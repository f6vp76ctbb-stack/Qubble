// The two comfort settings have to be reachable and readable, not just
// stored. A player who needs reduced effects cannot find a setting that
// exists only in the controller.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> pumpSettings(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  Locale locale = const Locale('en'),
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(500, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [storageProvider.overrideWithValue(storage)],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: locale,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const SettingsScreen(),
      ),
    ),
  );
  await tester.pump();
  return storage;
}

void main() {
  testWidgets('the reduced-effects switch is present and explains itself', (
    tester,
  ) async {
    final storage = await pumpSettings(tester);

    expect(find.text('Reduced effects'), findsOneWidget);
    // The label alone does not say what is reduced; a player deciding whether
    // this is the setting they need should not have to try it to find out.
    expect(
      find.text('Fewer particles, no screen shake, no glow'),
      findsOneWidget,
    );

    await tester.tap(find.text('Reduced effects'));
    await tester.pump();
    expect(storage.reducedEffects, isTrue);
  });

  testWidgets('all three haptic strengths are offered', (tester) async {
    await pumpSettings(tester);

    await tester.tap(find.byType(DropdownButton<HapticStrength>));
    await tester.pumpAndSettle();

    for (final label in ['Off', 'Light', 'Strong']) {
      expect(find.text(label), findsWidgets, reason: 'missing $label');
    }
  });

  testWidgets('picking a strength stores it', (tester) async {
    final storage = await pumpSettings(tester);

    await tester.tap(find.byType(DropdownButton<HapticStrength>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Light').last);
    await tester.pumpAndSettle();

    expect(storage.hapticStrength, HapticStrength.light);
  });

  testWidgets('the comfort settings are translated, not left in English', (
    tester,
  ) async {
    await pumpSettings(tester, locale: const Locale('de'));

    expect(find.text('Reduzierte Effekte'), findsOneWidget);
    // _SectionLabel uppercases its text.
    expect(find.text('KOMFORT'), findsOneWidget);
    expect(find.text('Reduced effects'), findsNothing);
  });
}
