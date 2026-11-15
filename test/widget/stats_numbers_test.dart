// The statistics screen printed its numbers raw: "18740" under a home screen
// that says "18.740" (seen in the German review pass, 15.11.2026). Every
// count goes through formatCount, as on the home screen, so the grouping
// follows the language.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/stats_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpStats(WidgetTester tester, String language) async {
  SharedPreferences.setMockInitialValues({});
  final storage = Storage(await SharedPreferences.getInstance());
  await storage.setHighscore(18740);
  await storage.setCoins(2480);

  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [storageProvider.overrideWithValue(storage)],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: localeFromCode(language),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const StatsScreen(),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('German groups the best score and the coins with a point', (
    tester,
  ) async {
    await _pumpStats(tester, 'de');
    expect(find.text('18.740'), findsOneWidget);
    expect(find.text('2.480'), findsOneWidget);
    expect(find.text('18740'), findsNothing);
    expect(find.text('2480'), findsNothing);
  });

  testWidgets('English groups them with a comma', (tester) async {
    await _pumpStats(tester, 'en');
    expect(find.text('18,740'), findsOneWidget);
    expect(find.text('2,480'), findsOneWidget);
  });
}
