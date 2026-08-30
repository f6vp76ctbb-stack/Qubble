import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/coach_hints.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
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
  testWidgets('game screen fits a two-line coach hint on a 360x640 phone', (
    tester,
  ) async {
    // A very common budget-phone size, and the tightest the game has to fit.
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // A player past onboarding with coins in hand gets the booster hint, the
    // longest of the coaching lines — it wraps to two lines at this width.
    SharedPreferences.setMockInitialValues({
      'onboardingDone': true,
      'coins': 500,
    });
    final storage = await Storage.create();

    final container = ProviderContainer(
      overrides: [storageProvider.overrideWithValue(storage)],
    );
    addTearDown(container.dispose);

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
    await tester.pump();

    // Starting a run queues the booster hint (the player can afford one), and
    // that hint is the longest coaching line — two lines at this width.
    container.read(gameControllerProvider.notifier).newGame(seed: 3);
    await tester.pump();

    // Assert the hint is really on screen — otherwise this test could pass by
    // simply not rendering the thing that used to overflow.
    expect(
      container.read(gameControllerProvider).contextualHint,
      CoachHintType.booster,
    );
    expect(find.textContaining('boosters'), findsOneWidget);
    // takeException() is the actual check: a RenderFlex overflow surfaces here.
    expect(tester.takeException(), isNull);
  });

  testWidgets('home wraps its controls on a 360 px display', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(await _app(const HomeScreen()));
    await tester.pump();

    expect(find.text('Play'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('game screen stays safe in compact landscape', (tester) async {
    tester.view.physicalSize = const Size(800, 360);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(await _app(const GameScreen()));
    await tester.pump();

    expect(find.text('SCORE'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
