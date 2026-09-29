// The puzzle ranking (owner, 29.09.2026): total puzzle stars in their own
// collection, under the same name and identity as the score board.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/leaderboard_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _identity = <String, Object>{
  'fbUid': 'uid-abc',
  'fbRefreshToken': 'refresh-abc',
};

MockClient _client(List<http.Request> seen, {String queryAnswer = '[]'}) =>
    MockClient((request) async {
      seen.add(request);
      if (request.url.host == 'securetoken.googleapis.com') {
        return http.Response(jsonEncode({'id_token': 'tok'}), 200);
      }
      if (request.url.path.endsWith(':runQuery')) {
        return http.Response(queryAnswer, 200);
      }
      return http.Response('{}', 200);
    });

/// Records what the controller uploads; every name is the player's.
class _Recorder extends LeaderboardService {
  final scores = <int>[];
  final stars = <int>[];

  @override
  Future<NameClaim> claimName(String name) async => NameClaim.claimed;

  @override
  Future<bool> submit({required String name, required int score}) async {
    scores.add(score);
    return true;
  }

  @override
  Future<bool> submitPuzzle({required String name, required int stars}) async {
    this.stars.add(stars);
    return true;
  }
}

Future<(GameController, Storage, _Recorder)> _controller(
  Map<String, Object> prefs,
) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final lb = _Recorder();
  final c = GameController(
    storage,
    Haptics(enabled: false),
    SilentAudio(),
    FakeAdService(),
    NoopAnalytics(),
    leaderboard: lb,
  );
  return (c, storage, lb);
}

Future<void> _drain() => Future<void>.delayed(const Duration(milliseconds: 20));

void main() {
  group('service', () {
    test('submitPuzzle writes the stars to the puzzle ranking', () async {
      SharedPreferences.setMockInitialValues(_identity);
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(seen),
        storage: await Storage.create(),
      );

      expect(await service.submitPuzzle(name: 'Anna', stars: 42), isTrue);

      final write = seen.singleWhere((r) => r.method == 'PATCH');
      expect(write.url.path, endsWith('/puzzleLeaderboard/uid-abc'));
      final fields = (jsonDecode(write.body) as Map)['fields'] as Map;
      expect(fields['name'], {'stringValue': 'Anna'});
      expect(fields['score'], {'integerValue': '42'});
    });

    test('fetchTopPuzzle reads the puzzle ranking, best first', () async {
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(
          seen,
          queryAnswer: jsonEncode([
            {
              'document': {
                'fields': {
                  'name': {'stringValue': 'Anna'},
                  'score': {'integerValue': '42'},
                },
              },
            },
          ]),
        ),
      );

      final top = await service.fetchTopPuzzle();

      expect(top.single.name, 'Anna');
      expect(top.single.score, 42);
      final query = jsonDecode(seen.single.body) as Map;
      expect(
        query['structuredQuery']['from'],
        [
          {'collectionId': 'puzzleLeaderboard'},
        ],
      );
    });
  });

  group('controller', () {
    test('uploads the total stars once they beat the last upload', () async {
      final (c, storage, lb) = await _controller({
        'playerName': 'Anna',
        'puzzleStars': '{"0": 3, "1": 2, "2": 3}',
      });

      c.autoUploadBestScore();
      await _drain();
      expect(lb.stars, [8]);
      expect(storage.lastSubmittedPuzzleStars, 8);
      expect(lb.scores, isEmpty, reason: 'no score to upload');

      c.autoUploadBestScore();
      await _drain();
      expect(lb.stars, [8], reason: 'nothing new, nothing sent');
    });

    test('without a name nothing is uploaded', () async {
      final (c, _, lb) = await _controller({
        'puzzleStars': '{"0": 3}',
      });
      c.autoUploadBestScore();
      await _drain();
      expect(lb.stars, isEmpty);
    });

    test('a new name re-sends the stars under it', () async {
      final (c, _, lb) = await _controller({
        'playerName': 'Anna',
        'puzzleStars': '{"0": 3}',
        'lastSubmittedPuzzleStars': 3,
      });
      await c.setPlayerName('Anna 2');
      await _drain();
      expect(lb.stars, [3]);
    });
  });

  testWidgets('the leaderboard screen has a puzzle tab with stars',
      (tester) async {
    SharedPreferences.setMockInitialValues({'onboardingDone': true});
    final storage = await Storage.create();
    final service = _Boards();
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
    expect(find.text('High score'), findsOneWidget);
    expect(find.text('Scorer'), findsOneWidget);

    await tester.tap(find.text('Puzzle stars'));
    await tester.pumpAndSettle();
    expect(find.text('Solver'), findsOneWidget);
    expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    expect(
      find.text('Your puzzle stars are submitted automatically.'),
      findsOneWidget,
    );
  });
}

class _Boards extends LeaderboardService {
  @override
  Future<List<LeaderboardEntry>> fetchTop({int limit = 50}) async =>
      const [LeaderboardEntry(name: 'Scorer', score: 9000)];

  @override
  Future<List<LeaderboardEntry>> fetchTopPuzzle({int limit = 50}) async =>
      const [LeaderboardEntry(name: 'Solver', score: 120)];
}
