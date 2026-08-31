// Android's back button had no handling anywhere: it closed the app straight
// from the menu, left the game with bomb-targeting still armed, and threw away
// a puzzle in progress without a word.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/puzzle_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/puzzle_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

({Widget widget, ProviderContainer container}) _app(
  Storage storage,
  Widget home,
) {
  final container = ProviderContainer(
    overrides: [storageProvider.overrideWithValue(storage)],
  );
  return (
    widget: UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
      theme: buildGridTheme(),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: home,
    ),
    ),
    container: container,
  );
}

Future<Storage> _storage() async {
  SharedPreferences.setMockInitialValues({});
  return Storage.create();
}

/// Pumps a fixed number of frames.
///
/// Used throughout instead of pumpAndSettle: the home screen runs
/// MenuParticles on a repeating controller so its tree never settles, and the
/// puzzle screen's stuck-check runs off-frame, which makes settle timing
/// depend on how loaded the machine is.
Future<void> _settle(WidgetTester tester, {int frames = 6}) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Sends a system back gesture, the way Android does.
Future<void> _pressBack(WidgetTester tester) async {
  await tester.binding.handlePopRoute();
  await _settle(tester, frames: 4);
}

void main() {
  group('home', () {
    testWidgets('one back press warns instead of closing the app',
        (tester) async {
      final app = _app(await _storage(), const HomeScreen());
      addTearDown(app.container.dispose);
      await tester.pumpWidget(app.widget);
      await tester.pump();

      await _pressBack(tester);

      expect(find.text('Press back again to exit'), findsOneWidget);
      expect(find.text('Qubble'), findsOneWidget,
          reason: 'the menu is still on screen');
    });
  });

  group('game', () {
    testWidgets('back disarms bomb targeting instead of leaving',
        (tester) async {
      final app = _app(await _storage(), const GameScreen());
      addTearDown(app.container.dispose);
      await tester.pumpWidget(app.widget);
      await tester.pump();

      app.container.read(bombModeProvider.notifier).state = true;
      await tester.pump();

      await _pressBack(tester);

      expect(app.container.read(bombModeProvider), isFalse,
          reason: 'bomb mode is global — leaving with it armed re-armed it '
              'on the next visit');
      expect(find.text('SCORE'), findsOneWidget,
          reason: 'the first back only cancels targeting');
    });

    testWidgets('leaving mid-run says the run is kept', (tester) async {
      final storage = await _storage();
      final app = _app(storage, const HomeScreen());
      addTearDown(app.container.dispose);
      await tester.pumpWidget(app.widget);
      await tester.pump();

      await tester.tap(find.text('Play'));
      await _settle(tester);

      // One placement, so the run counts as active.
      final c = app.container.read(gameControllerProvider.notifier);
      outer:
      for (var slot = 0; slot < c.state.tray.length; slot++) {
        final p = c.state.tray[slot];
        if (p == null) continue;
        for (var r = 0; r <= Board.size - p.height; r++) {
          for (var col = 0; col <= Board.size - p.width; col++) {
            if (c.canPlace(slot, Cell(r, col))) {
              c.place(slot, Cell(r, col));
              break outer;
            }
          }
        }
      }
      expect(c.state.runActive, isTrue);
      await tester.pump();

      await _pressBack(tester);

      expect(find.textContaining('Run saved'), findsOneWidget,
          reason: 'without this the player assumes the run is gone and '
              'starts a new one');
    });
  });

  group('puzzle', () {
    testWidgets('back mid-level asks before discarding', (tester) async {
      final app = _app(await _storage(), const PuzzleScreen(level: 0));
      addTearDown(app.container.dispose);
      await tester.pumpWidget(app.widget);
      await _settle(tester);

      final pc = app.container.read(puzzleControllerProvider.notifier);
      final puzzle = app.container.read(puzzleControllerProvider);
      // Play one move so there is progress worth warning about.
      expect(puzzle.currentPiece, isNotNull);
      await pc.place(_firstLegalOrigin(app.container));
      // The stuck-check is deferred behind a timer; pump so it can run.
      await _settle(tester);
      await pc.settled;

      await _pressBack(tester);

      expect(find.text('Leave the puzzle?'), findsOneWidget);
    });

    testWidgets('back on an untouched level leaves straight away',
        (tester) async {
      final app = _app(await _storage(), const PuzzleScreen(level: 0));
      addTearDown(app.container.dispose);
      await tester.pumpWidget(app.widget);
      await _settle(tester);

      await _pressBack(tester);

      expect(find.text('Leave the puzzle?'), findsNothing,
          reason: 'nothing to lose, so no dialog');
    });
  });
}

/// First origin the current puzzle piece legally fits at.
Cell _firstLegalOrigin(ProviderContainer container) {
  final state = container.read(puzzleControllerProvider);
  final piece = state.currentPiece!;
  for (var r = 0; r <= Board.size - piece.height; r++) {
    for (var c = 0; c <= Board.size - piece.width; c++) {
      if (state.board.canPlace(piece, Cell(r, c))) return Cell(r, c);
    }
  }
  throw StateError('no legal placement for the opening piece');
}
