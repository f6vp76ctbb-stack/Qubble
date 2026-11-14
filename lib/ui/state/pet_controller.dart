/// Riverpod controller for the player's Qubbies (lib/game/pet.dart).
///
/// It follows the game from the outside: every cleared line it sees counts
/// an egg down and gives the active Qubbie experience, and a finished run
/// opens the eggs that are ready. The game controller knows nothing of pets,
/// which is the point — nothing a Qubbie does can reach the score.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/clear_effect.dart';
import '../../game/pet.dart';
import '../../services/analytics.dart';
import '../../services/storage.dart';
import 'cosmetic_controller.dart';
import 'game_controller.dart';

/// What the screens need to know about the Qubbies right now.
@immutable
class PetView {
  const PetView({required this.pets, this.justHatched = const []});

  final PetState pets;

  /// Qubbies that came out of their eggs at the game over that is on screen;
  /// empty again once the next run starts.
  final List<String> justHatched;

  Pet? get active => switch (pets.activeId) {
    final String id => petById(id),
    null => null,
  };

  /// The egg shown where a Qubbie would sit, while there is no Qubbie yet.
  PetEgg? get perchEgg =>
      pets.activeId == null && pets.eggs.isNotEmpty ? pets.eggs.first : null;
}

final petControllerProvider = StateNotifierProvider<PetController, PetView>((
  ref,
) {
  final controller = PetController(
    ref.read(storageProvider),
    ref.read(analyticsProvider),
    spendDiamonds: (cost) =>
        ref.read(gameControllerProvider.notifier).trySpendDiamonds(cost),
  );
  ref.listen<GameSnapshot>(gameControllerProvider, controller.followGame);
  return controller;
});

/// The row effect the board plays: the active Qubbie's own where it brings
/// one, otherwise the one the player has equipped.
final boardClearEffectProvider = Provider<ClearEffectStyle>((ref) {
  final signature = ref.watch(
    petControllerProvider.select((view) => view.active?.signature),
  );
  return switch (signature) {
    PetSignature.frost => ClearEffectStyle.frost,
    PetSignature.laser => ClearEffectStyle.laser,
    PetSignature.lightning => ClearEffectStyle.lightning,
    PetSignature.fire => ClearEffectStyle.blaze,
    PetSignature.phoenix => ClearEffectStyle.blaze,
    PetSignature.rainbow => ClearEffectStyle.prism,
    null => ref.watch(activeClearEffectProvider),
  };
});

class PetController extends StateNotifier<PetView> {
  PetController(
    this._storage,
    this._analytics, {
    required Future<bool> Function(int cost) spendDiamonds,
    // A named parameter cannot bind a private field.
    // ignore: prefer_initializing_formals
  }) : _spendDiamonds = spendDiamonds,
       super(PetView(pets: _storage.pets));

  final Storage _storage;
  final Analytics _analytics;
  final Future<bool> Function(int cost) _spendDiamonds;

  /// Whether the free first egg is due: after the third finished run, to a
  /// player who has not chosen one.
  bool get offersFirstEgg => PetRules.offersFirstEgg(
    state.pets,
    finishedRuns: _storage.lifetimeStats.games,
  );

  void _set(PetState pets, {List<String>? justHatched}) {
    if (identical(pets, state.pets) && justHatched == null) return;
    state = PetView(
      pets: pets,
      justHatched: justHatched ?? state.justHatched,
    );
    unawaited(_storage.setPets(pets));
  }

  /// Takes the free first egg.
  void chooseStarter(String id) {
    final next = state.pets.chooseStarter(id);
    if (identical(next, state.pets)) return;
    _analytics.logEvent(AnalyticsEvent.petEgg, {
      'pet': id,
      'source': 'starter',
    });
    _set(next);
  }

  /// Buys [id] for diamonds; it arrives as an egg. False when it cannot be
  /// bought or the diamonds are short.
  Future<bool> buy(String id) async {
    final pet = petById(id);
    if (pet == null || !state.pets.canBuy(id)) return false;
    if (!await _spendDiamonds(pet.cost)) return false;
    // Re-read: the state may have moved on while the diamonds were taken.
    final next = state.pets.addBoughtEgg(id);
    if (next == null) return false;
    _analytics.logEvent(AnalyticsEvent.petEgg, {
      'pet': id,
      'source': 'diamonds',
    });
    _set(next);
    return true;
  }

  /// Makes a hatched Qubbie the one that plays along.
  void setActive(String id) => _set(state.pets.withActive(id));

  /// Called for every change of the game.
  void followGame(GameSnapshot? previous, GameSnapshot next) {
    if (previous == null) return;
    // A cleared line. `lastGained > 0` keeps the bomb out, which clears
    // cells without completing a line (and leaves the line count stale).
    if (next.clearEventId != previous.clearEventId &&
        next.lastGained > 0 &&
        next.lastClearedLineCount > 0) {
      _set(state.pets.addLines(next.lastClearedLineCount));
    }
    final wasSettled = previous.gameOver && !previous.finalizing;
    final isSettled = next.gameOver && !next.finalizing;
    if (isSettled && !wasSettled) {
      // A run is over: the moment an egg opens — never in mid-move.
      final result = state.pets.hatchReady();
      for (final id in result.hatched) {
        _analytics.logEvent(AnalyticsEvent.petHatched, {
          'pet': id,
          'runs': _storage.lifetimeStats.games,
        });
      }
      _set(result.state, justHatched: result.hatched);
    } else if (!next.gameOver && state.justHatched.isNotEmpty) {
      // The next run has begun; the arrival has been seen.
      _set(state.pets, justHatched: const []);
    }
  }
}
