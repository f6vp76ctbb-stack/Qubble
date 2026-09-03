// The daily calendar is the first place a player can see the run of days they
// actually kept. Before it, `lastDailyDate` could only answer "today or not",
// and the home card's countdown was hidden behind `streak == 0` — so the
// players it was built for, the ones on a streak, never saw it.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/daily.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/daily_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget _app(Storage storage, Widget home) => ProviderScope(
  overrides: [storageProvider.overrideWithValue(storage)],
  child: MaterialApp(
    theme: buildGridTheme(),
    localizationsDelegates: L10n.localizationsDelegates,
    supportedLocales: L10n.supportedLocales,
    home: home,
  ),
);

Future<Storage> _storage(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  return Storage.create();
}

void main() {
  testWidgets('marks the played days and today in the month grid', (
    tester,
  ) async {
    final storage = await _storage({
      'dailyDatesPlayed': ['2026-09-01', '2026-09-02'],
      'lastDailyDate': '2026-09-02',
      'streak': 2,
      'dailyBest': 4200,
    });

    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(storage, DailyScreen(today: DateTime(2026, 9, 2, 10))),
    );
    await tester.pumpAndSettle();

    // September 2026 has 30 days; every one of them is on screen exactly once.
    // Asserted through the semantics label rather than the bare number, since
    // a day number can collide with a metric value elsewhere on the screen.
    for (var d = 1; d <= 30; d++) {
      final played = find.bySemanticsLabel('$d. played');
      final missed = find.bySemanticsLabel('$d. not played');
      expect(
        played.evaluate().length + missed.evaluate().length,
        1,
        reason: 'day $d appears exactly once',
      );
    }
    // The two played days are announced as played, the rest are not.
    expect(find.bySemanticsLabel('1. played'), findsOneWidget);
    expect(find.bySemanticsLabel('2. played'), findsOneWidget);
    expect(find.bySemanticsLabel('3. played'), findsNothing);
    expect(find.bySemanticsLabel('3. not played'), findsOneWidget);

    // Streak and daily best are both shown.
    expect(find.text('4200'), findsOneWidget);
    expect(find.text('Streak'), findsOneWidget);
    expect(find.text('Daily best'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('an untouched month shows no played day at all', (tester) async {
    final storage = await _storage({});
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(storage, DailyScreen(today: DateTime(2026, 9, 15))),
    );
    await tester.pumpAndSettle();

    for (var d = 1; d <= 30; d++) {
      expect(find.bySemanticsLabel('$d. played'), findsNothing);
    }
    // With today still open the screen offers the run rather than a countdown.
    expect(find.text('Open today'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('the home card shows streak AND status together', (tester) async {
    // The regression: the status line used to sit in the `else` of the streak,
    // so a player with a streak saw no countdown and read the card as an
    // invitation to a run that no longer counted.
    final storage = await _storage({
      'streak': 5,
      'lastDailyDate': DailyChallenge.dateKey(DateTime.now()),
      'dailyDatesPlayed': [DailyChallenge.dateKey(DateTime.now())],
    });

    await tester.pumpWidget(_app(storage, const HomeScreen()));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('5-day streak'), findsOneWidget);
    // The countdown must be present even though the streak is running.
    expect(find.textContaining('Next daily in'), findsOneWidget);
  });

  testWidgets('a played day turns the card into the calendar entry', (
    tester,
  ) async {
    final storage = await _storage({
      'streak': 3,
      'lastDailyDate': DailyChallenge.dateKey(DateTime.now()),
      'dailyDatesPlayed': [DailyChallenge.dateKey(DateTime.now())],
    });

    await tester.pumpWidget(_app(storage, const HomeScreen()));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byIcon(Icons.calendar_month_rounded), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsNothing);

    await tester.tap(find.byIcon(Icons.calendar_month_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(DailyScreen), findsOneWidget);
  });

  testWidgets('an open day keeps the play action on the card', (tester) async {
    final storage = await _storage({'streak': 3, 'lastDailyDate': '2020-01-01'});
    await tester.pumpWidget(_app(storage, const HomeScreen()));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month_rounded), findsNothing);
  });

  testWidgets('steps back to a month the history still covers', (tester) async {
    // The point of keeping 70 days: on the first of a month the current one is
    // almost empty, and everything the player kept is in the month before.
    final storage = await _storage({
      'dailyDatesPlayed': ['2026-08-29', '2026-08-30', '2026-08-31'],
      'lastDailyDate': '2026-08-31',
      'streak': 3,
    });
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(storage, DailyScreen(today: DateTime(2026, 9, 1, 9))),
    );
    await tester.pumpAndSettle();

    // September shows no ticks at all.
    expect(find.text('September 2026'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp(r'\. played')), findsNothing);

    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();

    expect(find.text('August 2026'), findsOneWidget);
    expect(find.bySemanticsLabel('29. played'), findsOneWidget);
    expect(find.bySemanticsLabel('31. played'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('the back arrow stops at the oldest recorded day', (tester) async {
    final storage = await _storage({
      'dailyDatesPlayed': ['2026-09-01'],
      'lastDailyDate': '2026-09-01',
    });
    await tester.pumpWidget(
      _app(storage, DailyScreen(today: DateTime(2026, 9, 2))),
    );
    await tester.pumpAndSettle();

    // Nothing older than this month is stored, so there is nowhere to go back
    // to and the arrow is disabled rather than scrolling into empty months.
    final back = tester.widget<IconButton>(
      find.ancestor(
        of: find.byIcon(Icons.chevron_left_rounded),
        matching: find.byType(IconButton),
      ),
    );
    expect(back.onPressed, isNull);
    final forward = tester.widget<IconButton>(
      find.ancestor(
        of: find.byIcon(Icons.chevron_right_rounded),
        matching: find.byType(IconButton),
      ),
    );
    expect(forward.onPressed, isNull);
  });

}
