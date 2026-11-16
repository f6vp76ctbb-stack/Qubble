// The All-Clear banner speaks the player's language and shows the bonus the
// scorer pays. It used to read "BLITZBLANK!\n+300" for everyone: German in
// every language, and a bonus that BALANCE.md had raised to 1,500 long ago.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/scoring.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/juice_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A saved run one dot away from an empty board.
Map<String, Object?> _oneDotFromEmpty() {
  final dot = buildCatalog().firstWhere((p) => p.id == 'dot');
  final json = {
    'id': dot.id,
    'weight': dot.weight,
    'cells': [
      for (final cell in dot.cells) [cell.row, cell.col],
    ],
  };
  return {
    'version': 1,
    'seed': 1,
    'earlyPhaseMoves': 0,
    'freeRotation': false,
    'board': [for (var r = 0; r < Board.size - 1; r++) '........', '#######.'],
    'tray': [json, json, json],
    'placements': 3,
    'generatedTrays': 1,
    'rotationCharges': 3,
    'linesCleared': 0,
    'maxCombo': 0,
    'score': {'total': 7, 'combo': 0, 'fever': 0.0, 'movesSinceClear': 1},
  };
}

Future<void> _clearTheBoard(WidgetTester tester, String locale) async {
  SharedPreferences.setMockInitialValues({'onboardingDone': true});
  final storage = await Storage.create();
  await storage.setActiveRunCheckpoint(_oneDotFromEmpty());
  await tester.pumpWidget(
    ProviderScope(
      overrides: [storageProvider.overrideWithValue(storage)],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: Locale(locale),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const Scaffold(
          body: Center(child: JuiceOverlay(size: 320, cellSize: 40)),
        ),
      ),
    ),
  );
  final container = ProviderScope.containerOf(
    tester.element(find.byType(JuiceOverlay)),
  );
  final controller = container.read(gameControllerProvider.notifier);
  controller.place(0, const Cell(7, 7));
  expect(container.read(gameControllerProvider).lastWasAllClear, isTrue);
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  test('the banner bonus is the bonus the scorer pays', () {
    expect(ScoreKeeper().allClearBonus, ScoreKeeper.defaultAllClearBonus);
  });

  testWidgets('English players read English, with the real bonus', (
    tester,
  ) async {
    await _clearTheBoard(tester, 'en');
    expect(find.text('ALL CLEAR!'), findsOneWidget);
    expect(find.text('+1,500'), findsOneWidget);
    expect(find.textContaining('BLITZBLANK'), findsNothing);
    expect(find.text('+300'), findsNothing);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('German keeps its word, grouped the German way', (tester) async {
    await _clearTheBoard(tester, 'de');
    expect(find.text('BLITZBLANK!'), findsOneWidget);
    expect(find.text('+1.500'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('Spanish has its own line', (tester) async {
    await _clearTheBoard(tester, 'es');
    expect(find.text('¡TABLERO LIMPIO!'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('Portuguese has its own line', (tester) async {
    await _clearTheBoard(tester, 'pt');
    expect(find.text('TABULEIRO LIMPO!'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
  });
}
