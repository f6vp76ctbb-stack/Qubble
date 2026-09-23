// Once today's daily is played, the card said "Open today" -- an invitation
// to a run whose result no longer counts. It now says when the next one
// unlocks (MASTERPLAN.md D.3).
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/daily.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpHome(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  double width = 420,
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  tester.view.physicalSize = Size(width, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        leaderboardServiceProvider.overrideWithValue(
          LeaderboardService(
            client: MockClient((_) async => http.Response('[]', 200)),
            storage: storage,
          ),
        ),
      ],
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const HomeScreen(),
      ),
    ),
  );
  // Menu particles animate forever, so settle never returns here.
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('an unplayed daily still invites you in', (tester) async {
    await _pumpHome(tester);

    expect(find.text('Open today'), findsOneWidget);
    expect(find.textContaining('Next daily in'), findsNothing);
  });

  testWidgets('a played daily says when the next one unlocks', (tester) async {
    await _pumpHome(
      tester,
      prefs: {'lastDailyDate': DailyChallenge.dateKey(DateTime.now())},
    );

    expect(find.text('Open today'), findsNothing);
    expect(find.textContaining('Next daily in'), findsOneWidget);
  });

  testWidgets('yesterday counts as unplayed', (tester) async {
    // The boundary that matters: a player returning the next morning has to
    // be invited back in, not told to wait.
    await _pumpHome(
      tester,
      prefs: {
        'lastDailyDate': DailyChallenge.dateKey(
          DateTime.now().subtract(const Duration(days: 1)),
        ),
      },
    );

    expect(find.text('Open today'), findsOneWidget);
  });

  // On a 360 dp phone with a running streak, the status shared one line with
  // the streak and was cut off: "6-day streak · Open t…", and the countdown
  // lost its time entirely. The status is the half that says whether to tap.
  for (final (label, playedAgo, status) in [
    ('the invitation', 1, 'Open today'),
    ('the countdown', 0, 'Next daily in'),
  ]) {
    testWidgets('$label is not cut off next to a streak on a 360 dp phone', (
      tester,
    ) async {
      await _pumpHome(
        tester,
        width: 360,
        prefs: {
          'streak': 6,
          'lastDailyDate': DailyChallenge.dateKey(
            DateTime.now().subtract(Duration(days: playedAgo)),
          ),
        },
      );

      expect(find.text('6-day streak'), findsOneWidget);
      final paragraph = tester.renderObject<RenderParagraph>(
        find.textContaining(status),
      );
      expect(paragraph.didExceedMaxLines, isFalse);
    });
  }

  group('formatRemaining', () {
    test('drops the hour once inside the last one', () {
      expect(DailyCardFormat.remaining(const Duration(minutes: 12)), '12m');
      expect(
        DailyCardFormat.remaining(const Duration(hours: 7, minutes: 12)),
        '7h 12m',
      );
    });

    test('a whole number of hours still shows minutes', () {
      // "3h" alone reads as an estimate; "3h 0m" reads as a countdown.
      expect(DailyCardFormat.remaining(const Duration(hours: 3)), '3h 0m');
    });
  });
}
