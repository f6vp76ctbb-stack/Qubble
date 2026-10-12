// The bobbing "!" on the Quests button (owner, 12.10.2026): new quests every
// day, finished quests, and rewards waiting to be collected.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/daily.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/notice_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _now = DateTime(2026, 10, 12, 15);

Future<Storage> _pump(WidgetTester tester, Map<String, Object> prefs) async {
  SharedPreferences.setMockInitialValues({
    'onboardingDone': true,
    'playerName': 'Mia',
    ...prefs,
  });
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(412, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        gameCalendarProvider.overrideWithValue(() => _now),
      ],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const HomeScreen(),
      ),
    ),
  );
  await _frames(tester);
  return storage;
}

/// The home screen animates forever: fixed frames, never settle.
Future<void> _frames(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('new quests today: the notice shows until the quests are seen',
      (tester) async {
    final storage = await _pump(tester, {'quests.seenDay': '2026-10-11'});
    expect(find.byType(NoticeBadge), findsOneWidget);

    await tester.tap(find.text('Quests'));
    await _frames(tester);
    expect(storage.questsSeenDay, DailyChallenge.dateKey(_now));

    await tester.pageBack();
    await _frames(tester);
    expect(find.byType(NoticeBadge), findsNothing);
  });

  testWidgets('seen today and nothing new: no notice', (tester) async {
    await _pump(tester, {
      'quests.seenDay': DailyChallenge.dateKey(_now),
      'quests.seenDone': 0,
    });
    expect(find.byType(NoticeBadge), findsNothing);
  });
}
