import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/leaderboard_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The top ten, and the player's own place under them (owner, 12.10.2026):
/// "Man sieht die 10 besten und darunter sein Platz + Punkte."
class _Board extends LeaderboardService {
  _Board({required this.rows, this.rank});

  final List<LeaderboardEntry> rows;
  final int? rank;
  int? askedLimit;
  int? askedScore;

  @override
  Future<List<LeaderboardEntry>> fetchTop({int limit = 50}) async {
    askedLimit = limit;
    return rows.take(limit).toList();
  }

  @override
  Future<int?> scoreRank(int score) async {
    askedScore = score;
    return rank;
  }
}

List<LeaderboardEntry> _players(int n) => [
      for (var i = 0; i < n; i++)
        LeaderboardEntry(name: 'P$i', score: 100000 - i * 1000),
    ];

Future<void> _pump(
  WidgetTester tester,
  LeaderboardService service,
  Map<String, Object> prefs,
) async {
  tester.view.physicalSize = const Size(600, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  SharedPreferences.setMockInitialValues({'onboardingDone': true, ...prefs});
  final storage = await Storage.create();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        leaderboardServiceProvider.overrideWithValue(service),
      ],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const LeaderboardScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('lists the best ten, not more', (tester) async {
    final service = _Board(rows: _players(30));
    await _pump(tester, service, const {});

    expect(service.askedLimit, kLeaderboardTop);
    for (var i = 0; i < 10; i++) {
      expect(find.text('P$i'), findsOneWidget);
    }
    expect(find.text('P10'), findsNothing);
  });

  testWidgets('blocked names do not cost a place in the ten', (tester) async {
    final service = _Board(rows: _players(30));
    await _pump(tester, service, const {
      'leaderboard.blockedNames': ['P0', 'P3'],
    });

    expect(service.askedLimit, kLeaderboardTop + 2);
    expect(find.text('P0'), findsNothing);
    expect(find.text('P11'), findsOneWidget);
    expect(find.text('P12'), findsNothing);
  });

  testWidgets('the player\'s own place and best sit under the ten',
      (tester) async {
    final service = _Board(rows: _players(30), rank: 57);
    await _pump(tester, service, const {
      'playerName': 'Mia',
      'highscore': 4321,
    });

    expect(service.askedScore, 4321);
    expect(find.text('Mia'), findsOneWidget);
    expect(find.text('57'), findsOneWidget);
    expect(find.text('4,321'), findsOneWidget);
    // Below the last of the ten.
    expect(
      tester.getTopLeft(find.text('Mia')).dy,
      greaterThan(tester.getTopLeft(find.text('P9')).dy),
    );
  });

  testWidgets('without a name the own row says "You"', (tester) async {
    final service = _Board(rows: _players(3), rank: 4);
    await _pump(tester, service, const {'highscore': 800});

    expect(find.text('You'), findsOneWidget);
    expect(find.text('800'), findsOneWidget);
  });

  testWidgets('no own row before the first score, or offline',
      (tester) async {
    final none = _Board(rows: _players(3), rank: 9);
    await _pump(tester, none, const {'playerName': 'Mia'});
    expect(none.askedScore, isNull);
    expect(find.text('Mia'), findsNothing);

    final offline = _Board(rows: _players(3));
    await _pump(tester, offline, const {'playerName': 'Mia', 'highscore': 50});
    expect(find.text('Mia'), findsNothing);
  });

  test('scoreRank counts the better entries and adds one', () async {
    var sent = '';
    final service = LeaderboardService(
      client: MockClient((req) async {
        sent = req.body;
        return http.Response(
          '[{"result": {"aggregateFields": {"n": {"integerValue": "12"}}}}]',
          200,
        );
      }),
    );
    expect(await service.scoreRank(5000), 13);
    expect(sent, contains('"collectionId":"leaderboard"'));
    expect(sent, contains('"GREATER_THAN"'));
    expect(sent, contains('"5000"'));
  });

  test('scoreRank is null when the server cannot be asked', () async {
    final service = LeaderboardService(
      client: MockClient((_) async => http.Response('nope', 500)),
    );
    expect(await service.scoreRank(5000), isNull);
  });
}
