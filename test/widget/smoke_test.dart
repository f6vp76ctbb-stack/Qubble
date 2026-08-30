import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/puzzle_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/tray_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _app(Widget home) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  return ProviderScope(
    overrides: [storageProvider.overrideWithValue(storage)],
    child: MaterialApp(
      theme: buildGridTheme(),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: home,
    ),
  );
}

void main() {
  testWidgets('home screen shows title and play button', (tester) async {
    await tester.pumpWidget(await _app(const HomeScreen()));
    expect(find.text('Qubble'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);
    expect(find.text('BEST SCORE'), findsOneWidget);
  });

  testWidgets('tapping Play navigates into the game', (tester) async {
    await tester.pumpWidget(await _app(const HomeScreen()));
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();
    // The game header shows the score label.
    expect(find.text('SCORE'), findsOneWidget);
    expect(find.text('BEST'), findsOneWidget);
  });

  testWidgets('game screen renders board and tray without overflow',
      (tester) async {
    await tester.pumpWidget(await _app(const GameScreen()));
    await tester.pumpAndSettle();
    expect(find.text('SCORE'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tray fits a five-cell vertical piece without overflow',
      (tester) async {
    final line5 = buildCatalog().firstWhere((piece) => piece.id == 'line5_v');
    await tester.pumpWidget(
      await _app(
        Scaffold(
          body: Center(
            child: TrayView(
              boardCell: 20,
              height: 96,
              trayOverride: [line5, line5, line5],
            ),
          ),
        ),
      ),
    );
    expect(find.byType(TrayView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('puzzle screen loads a level and renders', (tester) async {
    await tester.pumpWidget(await _app(const PuzzleScreen(level: 0)));
    await tester.pumpAndSettle();
    expect(find.text('Puzzle 1'), findsOneWidget);
    expect(find.textContaining('Target:'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
