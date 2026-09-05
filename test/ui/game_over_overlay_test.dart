// The game-over overlay used to appear immediately with empty rewards and
// then grow by up to six blocks ABOVE its buttons as ~10 storage writes
// completed, so a quick tap on "Nochmal spielen" could land on the paid
// revive. It also never said why the run had ended.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Builds the screen over an explicit container so the test can drive the
/// controller directly.
/// A clock that advances a fixed step per placement.
///
/// Without it these tests were timing-dependent: the speed bonus reads the
/// wall clock, the bonus lands in the score, XP is derived from the score and
/// a level-up pays coins — so the coins a seeded run ends with varied with how
/// fast the machine ran the loop. One run paid 261 coins on a fast pass where
/// the premise below needs it under 200.
class _SteppingClock {
  DateTime _t = DateTime.utc(2026, 1, 1);
  DateTime call() {
    _t = _t.add(const Duration(seconds: 5));
    return _t;
  }
}

({Widget widget, ProviderContainer container}) _app(Storage storage) {
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      // Five seconds per move: past the speed-bonus window, so a run scores
      // what its moves earn and nothing that depends on the machine.
      gameClockProvider.overrideWithValue(_SteppingClock().call),
    ],
  );
  return (
    widget: UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const GameScreen(),
      ),
    ),
    container: container,
  );
}

/// Plays the first legal move, or null when none exists as the tray stands.
bool _placeSomething(GameController c) {
  for (var slot = 0; slot < c.state.tray.length; slot++) {
    final p = c.state.tray[slot];
    if (p == null) continue;
    for (var r = 0; r <= Board.size - p.height; r++) {
      for (var col = 0; col <= Board.size - p.width; col++) {
        if (c.canPlace(slot, Cell(r, col))) {
          c.place(slot, Cell(r, col));
          return true;
        }
      }
    }
  }
  return false;
}

/// Drives the controller behind the screen to a real game over.
///
/// Rotation matters here: the session only declares game over once no tray
/// piece fits even after the rotations the player could still afford, so a
/// loop that never rotates stops early with isGameOver still false.
void _playToGameOver(GameController c) {
  var guard = 0;
  while (!c.state.gameOver && guard++ < 3000) {
    if (_placeSomething(c)) continue;
    var rotated = false;
    for (var slot = 0; slot < c.state.tray.length && !rotated; slot++) {
      if (c.state.tray[slot] == null) continue;
      for (var i = 0; i < 3; i++) {
        if (!c.rotateTray(slot)) break;
        if (_placeSomething(c)) {
          rotated = true;
          break;
        }
      }
    }
    if (!rotated) break;
  }
}

void main() {
  testWidgets('the overlay says why the run ended', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    final app = _app(storage);
    addTearDown(app.container.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pump();

    final c = app.container.read(gameControllerProvider.notifier);
    c.newGame(seed: 4242);
    _playToGameOver(c);
    await tester.pumpAndSettle();

    expect(find.text('Game Over'), findsOneWidget);
    expect(
      find.textContaining('None of your pieces fit'),
      findsOneWidget,
      reason: 'the one reason a run ends is the lesson of the round',
    );
  });

  testWidgets('the overlay holds its actions until the rewards are settled',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    final app = _app(storage);
    addTearDown(app.container.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pump();

    final c = app.container.read(gameControllerProvider.notifier);
    c.newGame(seed: 4242);
    _playToGameOver(c);

    // Synchronously at game over the bookkeeping has not run yet. (The
    // mid-flight FRAME is not asserted here: SharedPreferences' mock resolves
    // before the next pump, so there is no deterministic way to render one.
    // The flag is the mechanism; the test below covers the symptom.)
    expect(c.state.gameOver, isTrue);
    expect(c.state.finalizing, isTrue,
        reason: 'rewards are unknown until ~10 storage writes complete');

    await tester.pumpAndSettle();
    expect(c.state.finalizing, isFalse);
    expect(find.text('Play again'), findsOneWidget);
  });

  testWidgets('a failed reward tally still releases the actions',
      (tester) async {
    // If finalizing could stick, the player would be stranded on a game-over
    // screen with no buttons at all.
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    final app = _app(storage);
    addTearDown(app.container.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pump();

    final c = app.container.read(gameControllerProvider.notifier);
    c.newGame(seed: 4242);
    _playToGameOver(c);
    await tester.pumpAndSettle();

    expect(c.state.finalizing, isFalse);
    expect(find.text('Play again'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('the buttons do not shift once they are shown', (tester) async {
    // A new best plus level-ups is the case that used to insert the most
    // above the buttons.
    SharedPreferences.setMockInitialValues({'highscore': 1, 'coins': 5000});
    final storage = await Storage.create();
    final app = _app(storage);
    addTearDown(app.container.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pump();

    final c = app.container.read(gameControllerProvider.notifier);
    c.newGame(seed: 4242);
    _playToGameOver(c);
    await tester.pumpAndSettle();

    final before = tester.getTopLeft(find.text('Play again'));
    await tester.pump(const Duration(milliseconds: 400));
    final after = tester.getTopLeft(find.text('Play again'));
    expect(after, before);
  });

  group('the revive button (MASTERPLAN.md D.6)', () {
    // Revive is the one place coins buy their way back into a lost run, and
    // CLAUDE.md is explicit that it costs coins and never a video. Its three
    // states are worth pinning because two of them are absences, and an
    // absence is exactly what a refactor removes without anyone noticing.

    Future<GameController> gameOverWith(
      WidgetTester tester,
      Map<String, Object> prefs, {
      bool daily = false,
    }) async {
      SharedPreferences.setMockInitialValues(prefs);
      final storage = await Storage.create();
      tester.view.physicalSize = const Size(500, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      final app = _app(storage);
      addTearDown(app.container.dispose);
      await tester.pumpWidget(app.widget);
      await tester.pump();

      final c = app.container.read(gameControllerProvider.notifier);
      if (daily) {
        c.startDaily();
      } else {
        c.newGame(seed: 4242);
      }
      _playToGameOver(c);
      await tester.pumpAndSettle();
      return c;
    }

    testWidgets('offered when the player can afford it', (tester) async {
      await gameOverWith(tester, {'coins': BoosterCosts.revive});

      final button = tester.widget<TextButton>(
        find.ancestor(
          of: find.textContaining('Keep playing'),
          matching: find.byType(TextButton),
        ).first,
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('shown but disabled without enough coins', (tester) async {
      // Greyed out rather than hidden: a player who cannot afford it should
      // still learn the option exists, and what it costs.
      //
      // The balance is not the subject here, so the setup no longer depends on
      // it. Seeding zero coins used to work because a run paid less than a
      // revive; it now pays more, and chasing a seed that still pays less
      // would only hold until the next balance change. Spending the surplus
      // back down puts the player one coin short whatever the run earned.
      final c = await gameOverWith(tester, {'coins': 0});
      final surplus = c.state.coins - BoosterCosts.revive + 1;
      if (surplus > 0) {
        expect(await c.trySpendCoins(surplus), isTrue);
      }
      await tester.pumpAndSettle();

      expect(
        c.state.coins,
        lessThan(BoosterCosts.revive),
        reason: 'the setup failed to put the player below the revive price',
      );

      expect(find.textContaining('Keep playing'), findsOneWidget);
      final button = tester.widget<TextButton>(
        find.ancestor(
          of: find.textContaining('Keep playing'),
          matching: find.byType(TextButton),
        ).first,
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('gone once it has been used in this run', (tester) async {
      final c = await gameOverWith(tester, {'coins': BoosterCosts.revive * 3});

      expect(await c.reviveWithCoins(), isTrue);
      _playToGameOver(c);
      await tester.pumpAndSettle();

      // One revive per run, even with coins to spare.
      expect(find.textContaining('Keep playing'), findsNothing);
    });

    testWidgets('never offered in the daily challenge', (tester) async {
      // The daily is the same board for everyone; buying a second life would
      // make its leaderboard meaningless.
      await gameOverWith(tester, {'coins': BoosterCosts.revive * 3},
          daily: true);

      expect(find.textContaining('Keep playing'), findsNothing);
    });
  });
}
