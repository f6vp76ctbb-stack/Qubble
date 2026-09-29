// The Daily screen says what the Daily is and what it brings (owner,
// 29.09.2026): the explainer, today's star goal, the next streak chest, and
// the way to today's ranking.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/daily_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/daily_stars.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _today = DateTime(2026, 9, 29, 10);

class _Boards extends LeaderboardService {
  final days = <String>[];

  @override
  Future<List<LeaderboardEntry>> fetchTop({int limit = 50}) async => const [];

  @override
  Future<List<LeaderboardEntry>> fetchTopPuzzle({int limit = 50}) async =>
      const [];

  @override
  Future<List<LeaderboardEntry>> fetchDailyTop(
    String day, {
    int limit = 50,
  }) async {
    days.add(day);
    return const [LeaderboardEntry(name: 'Early Bird', score: 5100)];
  }
}

Future<Widget> _app(Map<String, Object> prefs, _Boards boards) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  return ProviderScope(
    overrides: [
      storageProvider.overrideWithValue(storage),
      leaderboardServiceProvider.overrideWithValue(boards),
      gameCalendarProvider.overrideWithValue(() => _today),
    ],
    child: MaterialApp(
      theme: buildGridTheme(),
      locale: const Locale('en'),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: DailyScreen(today: _today),
    ),
  );
}

void main() {
  testWidgets('explains the Daily and shows the goal still open', (
    tester,
  ) async {
    await tester.pumpWidget(await _app({'streak': 1}, _Boards()));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Everyone plays the same board'),
      findsOneWidget,
    );
    expect(find.text("Today's goal"), findsOneWidget);
    expect(find.text('1,500 points'), findsOneWidget);
    expect(find.text('3,000 points'), findsOneWidget);
    expect(find.text('5,000 points'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Next chest: streak day 3'), 200);
    expect(find.text('Next chest: streak day 3'), findsOneWidget);
    // Nothing reached yet: the heading's stars are all empty.
    expect(
      find.byWidgetPredicate((w) => w is DailyStars && w.stars == 0),
      findsOneWidget,
    );
  });

  testWidgets("lights the stars today's round reached", (tester) async {
    await tester.pumpWidget(
      await _app({
        'lastDailyDate': '2026-09-29',
        'lastDailyScore': 3200,
        'streak': 3,
      }, _Boards()),
    );
    await tester.pumpAndSettle();

    // Two stars for 3,200, next to the three example rows (1, 2, 3 stars).
    expect(
      find.byWidgetPredicate((w) => w is DailyStars && w.stars == 2),
      findsNWidgets(2),
    );
    await tester.scrollUntilVisible(find.text('Next chest: streak day 7'), 200);
    expect(find.text('Next chest: streak day 7'), findsOneWidget);
  });

  testWidgets("the ranking button opens today's Daily ranking", (tester) async {
    final boards = _Boards();
    await tester.pumpWidget(await _app({}, boards));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text("Today's ranking"), 200);
    await tester.tap(find.text("Today's ranking"));
    await tester.pumpAndSettle();

    expect(boards.days, ['2026-09-29']);
    expect(find.text('Early Bird'), findsOneWidget);
    expect(
      find.text(
        'Same board for everyone, first round counts. '
        'A new ranking every day.',
      ),
      findsOneWidget,
    );
  });
}
