/// Riverpod controller for the player's answer about statistics and crash
/// reports (`lib/services/stats_consent.dart`).
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/stats_consent.dart';
import '../../services/storage.dart';
import 'game_controller.dart';

/// The gate Firebase's backends and crash handlers read. main overrides it
/// with the instance it handed to `initFirebase`.
final statsConsentGateProvider = Provider<StatsConsentGate>(
  (ref) => StatsConsentGate(),
);

/// Null where this build sends no statistics at all (web, tests, Firebase
/// failed to start): then the app neither asks nor shows the switch.
final statsCollectionProvider = Provider<StatsCollection?>((ref) => null);

final statsConsentControllerProvider =
    StateNotifierProvider<StatsConsentController, bool?>((ref) {
      return StatsConsentController(
        ref.read(storageProvider),
        ref.read(statsConsentGateProvider),
        ref.read(statsCollectionProvider),
      );
    });

/// Null until the player has answered.
class StatsConsentController extends StateNotifier<bool?> {
  StatsConsentController(this._storage, this._gate, this._collection)
    : super(_storage.statsConsent);

  final Storage _storage;
  final StatsConsentGate _gate;
  final StatsCollection? _collection;

  /// Whether this build has statistics to ask about.
  bool get available => _collection != null;

  /// Records [allowed] and applies it at once, see
  /// [StatsCollection.setEnabled] for what a new answer deletes.
  Future<void> set(bool allowed) async {
    await _storage.setStatsConsent(allowed);
    _gate.allowed = allowed;
    state = allowed;
    await _collection?.setEnabled(allowed, answerChanged: true);
  }
}
