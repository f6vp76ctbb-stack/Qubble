// The piggy bank on the home screen glows once it holds coins and blinks when
// full, until tapped once (owner, 28.09.2026).
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> _pumpHome(
  WidgetTester tester,
  Map<String, Object> prefs,
) async {
  SharedPreferences.setMockInitialValues({'onboardingDone': true, ...prefs});
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
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
        home: const HomeScreen(),
      ),
    ),
  );
  // Not pumpAndSettle: the menu particles (and the blink) never settle.
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  return storage;
}

/// The glow of the chip, read from its decoration.
BoxShadow? _glow(WidgetTester tester) {
  final box = tester
      .widgetList<Container>(
        find.ancestor(
          of: find.byIcon(Icons.savings_rounded),
          matching: find.byType(Container),
        ),
      )
      .map((c) => c.decoration)
      .whereType<BoxDecoration>()
      .first;
  final shadows = box.boxShadow;
  return shadows == null || shadows.isEmpty ? null : shadows.first;
}

void main() {
  testWidgets('an empty piggy bank does not glow', (tester) async {
    await _pumpHome(tester, const {});
    expect(_glow(tester), isNull);
  });

  testWidgets('a piggy bank with coins glows', (tester) async {
    await _pumpHome(tester, const {'piggyCoins': 60, 'piggyCapacity': 200});
    expect(_glow(tester), isNotNull);
  });

  testWidgets('a full piggy bank blinks until tapped once', (tester) async {
    final storage = await _pumpHome(
      tester,
      const {'piggyCoins': 200, 'piggyCapacity': 200},
    );

    final samples = <double>{};
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 90));
      samples.add(_glow(tester)!.color.a);
    }
    expect(samples.length, greaterThan(2), reason: 'the glow changes: blinks');

    await tester.tap(find.byIcon(Icons.savings_rounded));
    await tester.pump(const Duration(milliseconds: 100));
    expect(storage.piggyFullSeen, isTrue);

    // Close the "collect" dialog without collecting: the blinking stays off.
    await tester.tapAt(const Offset(5, 5));
    await tester.pump(const Duration(milliseconds: 300));
    final steady = <double>{};
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 90));
      steady.add(_glow(tester)!.color.a);
    }
    expect(steady, hasLength(1), reason: 'no more blinking once tapped');
  });
}
