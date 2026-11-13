// The Qubbies follow the game from the outside (lib/ui/state/pet_controller
// .dart): cleared lines count an egg down and make the active one grow, a
// finished run opens ready eggs. Nothing here may reach back into the game.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/clear_effect.dart';
import 'package:gridpop/game/pet.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/cosmetic_controller.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/pet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';
import '../support/recording_analytics.dart';

Future<({ProviderContainer container, Storage storage, RecordingAnalytics log})>
_setup({PetState? pets, int diamonds = 0, int coins = 0}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  if (pets != null) await storage.setPets(pets);
  if (diamonds > 0) await storage.setDiamonds(diamonds);
  if (coins > 0) await storage.setCoins(coins);
  final log = RecordingAnalytics();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      analyticsProvider.overrideWithValue(log),
      hapticsProvider.overrideWithValue(Haptics(enabled: false)),
      gameClockProvider.overrideWithValue(SteppingClock().call),
    ],
  );
  addTearDown(container.dispose);
  // The pet controller only follows the game once someone looks at it.
  container.listen(petControllerProvider, (_, _) {});
  return (container: container, storage: storage, log: log);
}

/// Places pieces until a line is cleared.
void _playToClear(GameController c) {
  final before = c.state.clearEventId;
  var guard = 0;
  while (c.state.clearEventId == before && guard++ < 400) {
    expect(placeSomething(c), isTrue, reason: 'the run ended before a clear');
  }
}

/// Lets the end-of-run bookkeeping (a chain of storage writes) finish.
Future<void> _settled(ProviderContainer container) async {
  for (var i = 0; i < 50; i++) {
    await Future<void>.delayed(Duration.zero);
    final snap = container.read(gameControllerProvider);
    if (snap.gameOver && !snap.finalizing) return;
  }
  fail('the run never finished its bookkeeping');
}

PetState _hatched(String id) {
  var pets = PetState.empty.chooseStarter('kiki').addLines(10);
  pets = pets.hatchReady().state;
  if (id == 'kiki') return pets;
  pets = pets.addBoughtEgg(id)!.addLines(PetRules.boughtEggLines);
  return pets.hatchReady().state.withActive(id);
}

void main() {
  test('cleared lines count an egg down', () async {
    final s = await _setup(pets: PetState.empty.chooseStarter('kiki'));
    final c = s.container.read(gameControllerProvider.notifier)
      ..newGame(seed: 11);
    _playToClear(c);
    final lines = c.state.lastClearedLineCount;
    expect(lines, greaterThan(0));
    final view = s.container.read(petControllerProvider);
    expect(view.pets.eggs.single.linesLeft, PetRules.starterEggLines - lines);
    expect(s.storage.pets.eggs.single.linesLeft, view.pets.eggs.single.linesLeft,
        reason: 'saved as it goes: a closed app keeps the lines');
    expect(view.perchEgg, isNotNull, reason: 'the egg sits on the board');
    expect(view.active, isNull);
  });

  test('the active Qubbie gains one experience per cleared line', () async {
    final s = await _setup(pets: _hatched('kiki'));
    final c = s.container.read(gameControllerProvider.notifier)
      ..newGame(seed: 11);
    _playToClear(c);
    final first = c.state.lastClearedLineCount;
    expect(s.container.read(petControllerProvider).pets.xpOf('kiki'), first);
    _playToClear(c);
    expect(
      s.container.read(petControllerProvider).pets.xpOf('kiki'),
      first + c.state.lastClearedLineCount,
    );
  });

  test('a bomb clears cells, not lines: nothing is counted', () async {
    final s = await _setup(
      pets: PetState.empty.chooseStarter('kiki'),
      coins: BoosterCosts.bomb * 2,
    );
    final c = s.container.read(gameControllerProvider.notifier)
      ..newGame(seed: 11);
    // A real clear first: it leaves a line count behind that a bomb's own
    // event would otherwise be mistaken for.
    _playToClear(c);
    final left = s.container.read(petControllerProvider).pets.eggs.single
        .linesLeft;
    expect(placeSomething(c), isTrue);
    Cell? filled;
    for (var r = 0; r < Board.size && filled == null; r++) {
      for (var col = 0; col < Board.size && filled == null; col++) {
        if (c.state.board.filledAt(r, col)) filled = Cell(r, col);
      }
    }
    final eventBefore = c.state.clearEventId;
    expect(await c.tryBomb(filled!), isTrue);
    expect(c.state.clearEventId, isNot(eventBefore));
    expect(
      s.container.read(petControllerProvider).pets.eggs.single.linesLeft,
      left,
    );
  });

  test('a ready egg opens when the run is over, never in mid-run', () async {
    final s = await _setup(
      pets: PetState.empty.chooseStarter('kiki').addLines(10),
    );
    final c = s.container.read(gameControllerProvider.notifier)
      ..newGame(seed: 11);
    _playToClear(c);
    expect(s.container.read(petControllerProvider).pets.owned, isEmpty,
        reason: 'ready, but the moment belongs to the game over');

    playToGameOver(c);
    await _settled(s.container);
    final view = s.container.read(petControllerProvider);
    expect(view.justHatched, ['kiki']);
    expect(view.pets.owned, {'kiki'});
    expect(view.active?.id, 'kiki');
    expect(s.storage.pets.owned, {'kiki'});
    final hatched = s.log.of(AnalyticsEvent.petHatched).single;
    expect(hatched['pet'], 'kiki');
    expect(hatched['runs'], 1);

    // The next run starts: the arrival has been seen.
    c.newGame(seed: 12);
    expect(s.container.read(petControllerProvider).justHatched, isEmpty);
    expect(s.container.read(petControllerProvider).active?.id, 'kiki');
  });

  test('the free first egg is offered from the third finished run', () async {
    final s = await _setup();
    final c = s.container.read(gameControllerProvider.notifier);
    final pets = s.container.read(petControllerProvider.notifier);
    for (var run = 1; run <= 3; run++) {
      expect(pets.offersFirstEgg, isFalse, reason: 'before run $run ends');
      c.newGame(seed: 20 + run);
      playToGameOver(c);
      await _settled(s.container);
    }
    expect(pets.offersFirstEgg, isTrue);

    pets.chooseStarter('glim');
    expect(pets.offersFirstEgg, isFalse);
    final view = s.container.read(petControllerProvider);
    expect(view.pets.eggs.single.petId, 'glim');
    expect(view.pets.eggs.single.linesLeft, PetRules.starterEggLines);
    expect(s.log.of(AnalyticsEvent.petEgg).single, {
      'pet': 'glim',
      'source': 'starter',
    });

    // Once only.
    pets.chooseStarter('bit');
    expect(s.container.read(petControllerProvider).pets.eggs, hasLength(1));
  });

  test('buying takes the diamonds and brings an egg', () async {
    final s = await _setup(pets: _hatched('kiki'), diamonds: 700);
    final pets = s.container.read(petControllerProvider.notifier);
    expect(await pets.buy('frosti'), isTrue);
    expect(s.storage.diamonds, 700 - kPremiumPetPrice);
    final view = s.container.read(petControllerProvider);
    expect(view.pets.eggs.single.petId, 'frosti');
    expect(view.pets.eggs.single.linesLeft, PetRules.boughtEggLines);
    expect(view.pets.owned, {'kiki'}, reason: 'it arrives as an egg');
    expect(s.log.of(AnalyticsEvent.petEgg).single, {
      'pet': 'frosti',
      'source': 'diamonds',
    });
  });

  test('too few diamonds, an owned one, an unknown one: nothing happens',
      () async {
    final s = await _setup(pets: _hatched('kiki'), diamonds: 500);
    final pets = s.container.read(petControllerProvider.notifier);
    expect(await pets.buy('frosti'), isFalse, reason: '500 of 600');
    expect(await pets.buy('kiki'), isFalse, reason: 'already hers');
    expect(await pets.buy('nope'), isFalse);
    expect(s.storage.diamonds, 500);
    expect(s.container.read(petControllerProvider).pets.eggs, isEmpty);
    expect(s.log.of(AnalyticsEvent.petEgg), isEmpty);

    // And not twice while it is still an egg.
    await s.storage.setDiamonds(2000);
    expect(await pets.buy('frosti'), isTrue);
    expect(await pets.buy('frosti'), isFalse);
    expect(s.storage.diamonds, 2000 - kPremiumPetPrice);
  });

  test('only a hatched Qubbie can be the one that plays along', () async {
    final s = await _setup(pets: _hatched('funki'));
    final pets = s.container.read(petControllerProvider.notifier);
    expect(s.container.read(petControllerProvider).active?.id, 'funki');
    pets.setActive('kiki');
    expect(s.container.read(petControllerProvider).active?.id, 'kiki');
    expect(s.storage.pets.activeId, 'kiki');
    pets.setActive('pyra');
    expect(s.container.read(petControllerProvider).active?.id, 'kiki');
  });

  test('a starter flies with the player\'s row effect, the others bring '
      'their own', () async {
    final s = await _setup(pets: _hatched('funki'));
    final pets = s.container.read(petControllerProvider.notifier);
    ClearEffectStyle board() => s.container.read(boardClearEffectProvider);

    expect(board(), ClearEffectStyle.blaze, reason: 'the dragon burns');
    pets.setActive('kiki');
    expect(board(), s.container.read(activeClearEffectProvider));
    expect(board(), ClearEffectStyle.classic);

    for (final (id, style) in const [
      ('frosti', ClearEffectStyle.frost),
      ('optik', ClearEffectStyle.laser),
      ('zapp', ClearEffectStyle.lightning),
      ('prisma', ClearEffectStyle.prism),
      ('pyra', ClearEffectStyle.blaze),
    ]) {
      final t = await _setup(pets: _hatched(id));
      expect(t.container.read(boardClearEffectProvider), style, reason: id);
    }
  });

  test('without a Qubbie the board plays the equipped row effect', () async {
    final s = await _setup();
    expect(
      s.container.read(boardClearEffectProvider),
      s.container.read(activeClearEffectProvider),
    );
  });

  test('a Qubbie changes nothing about the run it plays in', () async {
    // Same seed, same moves, with and without the legendary Qubbie: score,
    // coins and pieces must come out identical. This is the promise that a
    // bought Qubbie is never stronger than none.
    Future<(int, int, int)> run(PetState? pets) async {
      final s = await _setup(pets: pets);
      final c = s.container.read(gameControllerProvider.notifier)
        ..newGame(seed: 77);
      playToGameOver(c);
      await _settled(s.container);
      return (c.state.score, s.storage.coins, c.state.runBestCombo);
    }

    expect(await run(_hatched('pyra')), await run(null));
  });
}
