// Boosters cost coins. A layout that drops them takes away something the
// player paid for — and the compact layout now also triggers on a large system
// font, so dropping them would take them from whoever most needs the larger
// text. They are laid out flatter there, never removed.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/app_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pump(
  WidgetTester tester, {
  required Size size,
  required double textScale,
}) async {
  SharedPreferences.setMockInitialValues({'coins': 5000});
  final storage = Storage(await SharedPreferences.getInstance());
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [storageProvider.overrideWithValue(storage)],
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        builder: (context, child) => MediaQuery.withClampedTextScaling(
          minScaleFactor: textScale,
          maxScaleFactor: textScale,
          child: child!,
        ),
        home: const GameScreen(),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  testWidgets('all three boosters are reachable at the default size', (
    tester,
  ) async {
    await _pump(tester, size: const Size(360, 640), textScale: 1.0);
    expect(find.byIcon(AppIcons.undo), findsOneWidget);
    expect(find.byIcon(AppIcons.swap), findsOneWidget);
    expect(find.byIcon(AppIcons.bomb), findsOneWidget);
  });

  testWidgets('all three survive a large system font', (tester) async {
    await _pump(tester, size: const Size(360, 640), textScale: 2.0);
    expect(find.byIcon(AppIcons.undo), findsOneWidget);
    expect(find.byIcon(AppIcons.swap), findsOneWidget);
    expect(find.byIcon(AppIcons.bomb), findsOneWidget);
  });

  testWidgets('all three survive a short screen', (tester) async {
    await _pump(tester, size: const Size(360, 520), textScale: 1.0);
    expect(find.byIcon(AppIcons.undo), findsOneWidget);
    expect(find.byIcon(AppIcons.swap), findsOneWidget);
    expect(find.byIcon(AppIcons.bomb), findsOneWidget);
  });

  testWidgets('the compact form still names each booster to a screen reader', (
    tester,
  ) async {
    // The visible label is dropped to save height, so the meaning has to
    // survive somewhere. It matters most in exactly this configuration.
    final semantics = tester.ensureSemantics();
    await _pump(tester, size: const Size(360, 640), textScale: 2.0);

    expect(find.bySemanticsLabel(RegExp('Undo')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Swap')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Bomb')), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('the daily challenge still has no boosters', (tester) async {
    // Not a layout question: the daily is competitive, so boosters are barred
    // there by design and must not come back through the compact path.
    SharedPreferences.setMockInitialValues({'coins': 5000});
    final storage = Storage(await SharedPreferences.getInstance());
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final container = ProviderContainer(
      overrides: [storageProvider.overrideWithValue(storage)],
    );
    addTearDown(container.dispose);
    container.read(gameControllerProvider.notifier).startDaily();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: buildGridTheme(),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const GameScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byIcon(AppIcons.undo), findsNothing);
    expect(find.byIcon(AppIcons.bomb), findsNothing);
  });
}
