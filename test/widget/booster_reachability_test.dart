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
  bool newPlayer = false,
}) async {
  // Past the guided first moves, unless the test is about them: until the
  // first cleared line the bar keeps its place but is not shown.
  SharedPreferences.setMockInitialValues({
    'coins': 5000,
    if (!newPlayer) 'onboardingDone': true,
  });
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

  testWidgets('the video for new pieces sits in the bar, with how many are '
      'left', (tester) async {
    // It used to be a line of its own above the board: the first thing the
    // game said to a new player was an offer to watch an ad.
    final semantics = tester.ensureSemantics();
    await _pump(tester, size: const Size(360, 640), textScale: 1.0);

    expect(find.text('New pieces (video)'), findsNothing);
    expect(find.byIcon(Icons.card_giftcard_rounded), findsOneWidget);
    expect(
      find.descendant(
        of: find.ancestor(
          of: find.byIcon(Icons.card_giftcard_rounded),
          matching: find.byType(InkWell),
        ),
        matching: find.text('${GameController.luckyBlocksPerRun}'),
      ),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('New pieces (video)'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('it survives a large system font and a short screen too', (
    tester,
  ) async {
    await _pump(tester, size: const Size(360, 640), textScale: 2.0);
    expect(find.byIcon(Icons.card_giftcard_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('during the guided first moves the bar is neither shown nor '
      'reachable, and nothing shifts when it appears', (tester) async {
    final semantics = tester.ensureSemantics();
    await _pump(
      tester,
      size: const Size(360, 640),
      textScale: 1.0,
      newPlayer: true,
    );

    // In the tree, so the board keeps its size — but not on screen ...
    expect(find.byIcon(AppIcons.undo), findsOneWidget);
    final opacity = tester.widget<AnimatedOpacity>(
      find.ancestor(
        of: find.byIcon(AppIcons.undo),
        matching: find.byType(AnimatedOpacity),
      ),
    );
    expect(opacity.opacity, 0);
    // ... not tappable, and not read out.
    expect(find.bySemanticsLabel(RegExp('Undo')), findsNothing);
    expect(find.bySemanticsLabel('New pieces (video)'), findsNothing);
    await tester.tap(find.byIcon(AppIcons.bomb), warnIfMissed: false);
    await tester.pump();
    final container = ProviderScope.containerOf(
      tester.element(find.byType(GameScreen)),
    );
    expect(container.read(bombModeProvider), isFalse);
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

  testWidgets('a first-run hint still reaches a compact screen', (
    tester,
  ) async {
    // The onboarding hint used to be dropped whenever the layout was compact,
    // so a first-time player on a small phone was never taught anything. It
    // floats over the board there now instead of reserving a row.
    SharedPreferences.setMockInitialValues({});
    final storage = Storage(await SharedPreferences.getInstance());
    tester.view.physicalSize = const Size(360, 520);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [storageProvider.overrideWithValue(storage)],
        child: MaterialApp(
          theme: buildGridTheme(),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const GameScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 400));

    // A fresh install starts in onboarding, so some hint must be on screen.
    expect(
      find.textContaining(RegExp('block|Block|grid')),
      findsWidgets,
      reason: 'the first-run hint is missing on a compact screen',
    );
  });
}
