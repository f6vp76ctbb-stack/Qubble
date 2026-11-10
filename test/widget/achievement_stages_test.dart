// The achievements screen with stages (owner, 12.10.2026): rewards to
// collect on top, then closest to the next stage, finished last; a tap on
// "Collect" pays and moves the category down.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/quests_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> _pump(WidgetTester tester, Map<String, Object> prefs) async {
  SharedPreferences.setMockInitialValues({
    'onboardingDone': true,
    'coins': 0,
    ...prefs,
  });
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(412, 3000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [storageProvider.overrideWithValue(storage)],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const QuestsScreen(initialTab: 1),
      ),
    ),
  );
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  return storage;
}

double _y(WidgetTester tester, String title) =>
    tester.getTopLeft(find.text(title)).dy;

void main() {
  testWidgets('a reward to collect sits on top; collecting pays and moves it',
      (tester) async {
    final storage = await _pump(tester, {
      // games: 12 runs, stage 1 collected, stage 2 (10) waiting.
      // lines: 90 of the next 100 — close, nothing to collect.
      'lifetimeStats': '{"games": 12, "totalLines": 90}',
      'achievements.tiersClaimed': '{"games": 1, "lines": 1}',
    });

    expect(find.text('Collect'), findsOneWidget);
    expect(_y(tester, 'Hooked'), lessThan(_y(tester, 'Spring cleaner')));

    await tester.tap(find.text('Collect'));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(storage.coins, 100);
    expect(storage.achievementTiersClaimed['games'], 2);
    expect(find.text('Collect'), findsNothing);
    // 12 of 25 now: the 90 % category moves above it.
    expect(_y(tester, 'Spring cleaner'), lessThan(_y(tester, 'Hooked')));
  });

  testWidgets('every category shows its goal: stage target and the skin',
      (tester) async {
    await _pump(tester, {});
    expect(find.text('0 / 1'), findsOneWidget, reason: 'games, stage 1');
    expect(find.text('0 / 2,500'), findsOneWidget, reason: 'score, stage 1');
    expect(find.text('0 of 40 unlocked'), findsOneWidget);
  });
}
