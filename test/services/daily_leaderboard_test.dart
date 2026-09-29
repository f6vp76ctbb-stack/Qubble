// Today's Daily ranking (owner, 29.09.2026): one entry per player and day,
// written once, from the day's counted round — the same board for everyone.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/daily_rewards.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _identity = <String, Object>{
  'fbUid': 'uid-abc',
  'fbRefreshToken': 'refresh-abc',
};

/// Answers the token exchange, and everything else with [status] / [body].
MockClient _client(
  List<http.Request> seen, {
  int status = 200,
  String Function(http.Request)? body,
}) => MockClient((request) async {
  seen.add(request);
  if (request.url.host == 'securetoken.googleapis.com') {
    return http.Response(jsonEncode({'id_token': 'tok'}), 200);
  }
  return http.Response(body?.call(request) ?? '{}', status);
});

String _count(int n) => jsonEncode([
  {
    'result': {
      'aggregateFields': {
        'n': {'integerValue': '$n'},
      },
    },
  },
]);

/// Records what the controller sends to the Daily ranking.
class _Recorder extends LeaderboardService {
  _Recorder([this.answer = DailySubmit.stored]);

  DailySubmit answer;
  final daily = <(String, int)>[];
  final ranks = <(String, int, bool)>[];
  List<String>? deletedDays;

  @override
  Future<NameClaim> claimName(String name) async => NameClaim.claimed;

  @override
  Future<bool> releaseName(String name) async => true;

  @override
  Future<bool> submit({required String name, required int score}) async => true;

  @override
  Future<DailySubmit> submitDaily({
    required String name,
    required int score,
    required String day,
  }) async {
    daily.add((day, score));
    return answer;
  }

  @override
  Future<({int rank, int total})?> dailyRank({
    required String day,
    required int score,
    bool entered = true,
  }) async {
    ranks.add((day, score, entered));
    return (rank: 3, total: 10);
  }

  @override
  Future<bool> deleteEntry({List<String> dailyDays = const []}) async {
    deletedDays = dailyDays;
    return true;
  }
}

final _today = DateTime(2026, 9, 29, 12);
const _todayKey = '2026-09-29';

Future<(GameController, Storage)> _controller(
  Map<String, Object> prefs,
  LeaderboardService? leaderboard,
) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final c = GameController(
    storage,
    Haptics(enabled: false),
    SilentAudio(),
    FakeAdService(),
    NoopAnalytics(),
    leaderboard: leaderboard,
    calendar: () => _today,
  );
  return (c, storage);
}

bool _placeSomething(GameController c) {
  for (var slot = 0; slot < c.state.tray.length; slot++) {
    final p = c.state.tray[slot];
    if (p == null) continue;
    for (var r = 0; r <= Board.size - p.height; r++) {
      for (var col = 0; col <= Board.size - p.width; col++) {
        if (c.canPlace(slot, Cell(r, col))) {
          c.place(slot, Cell(r, col));
          return true;
        }
      }
    }
  }
  return false;
}

/// Drives the controller to a real game over (rotating when nothing fits,
/// see daily_double_test.dart).
Future<void> _playToGameOver(GameController c) async {
  var guard = 0;
  while (!c.state.gameOver && guard++ < 3000) {
    if (_placeSomething(c)) continue;
    var rotated = false;
    for (var slot = 0; slot < c.state.tray.length && !rotated; slot++) {
      if (c.state.tray[slot] == null) continue;
      for (var i = 0; i < 3; i++) {
        if (!c.rotateTray(slot)) break;
        if (_placeSomething(c)) {
          rotated = true;
          break;
        }
      }
    }
    if (!rotated) break;
  }
  await Future<void>.delayed(const Duration(milliseconds: 20));
}

void main() {
  group('service', () {
    test('submitDaily creates the player\'s entry for the day', () async {
      SharedPreferences.setMockInitialValues(_identity);
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(seen),
        storage: await Storage.create(),
      );

      final result = await service.submitDaily(
        name: 'Anna',
        score: 4200,
        day: _todayKey,
      );

      expect(result, DailySubmit.stored);
      final write = seen.singleWhere(
        (r) => r.url.host == 'firestore.googleapis.com',
      );
      expect(write.url.path, endsWith('/dailyLeaderboard/$_todayKey/entries'));
      expect(
        write.url.queryParameters['documentId'],
        'uid-abc',
        reason: 'create-only: a second write for the day is a conflict',
      );
      final fields = (jsonDecode(write.body) as Map)['fields'] as Map;
      expect(fields['name'], {'stringValue': 'Anna'});
      expect(fields['score'], {'integerValue': '4200'});
    });

    for (final (status, expected) in [
      (409, DailySubmit.alreadyStored),
      (403, DailySubmit.refused),
      (503, DailySubmit.failed),
    ]) {
      test('HTTP $status reads as ${expected.name}', () async {
        SharedPreferences.setMockInitialValues(_identity);
        final service = LeaderboardService(
          client: _client([], status: status),
          storage: await Storage.create(),
        );
        expect(
          await service.submitDaily(name: 'Anna', score: 10, day: _todayKey),
          expected,
        );
      });
    }

    test('a name the rules would refuse is not even sent', () async {
      SharedPreferences.setMockInitialValues(_identity);
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(seen),
        storage: await Storage.create(),
      );
      expect(
        await service.submitDaily(name: '名前', score: 10, day: _todayKey),
        DailySubmit.refused,
      );
      expect(seen, isEmpty);
    });

    test('fetchDailyTop reads the day\'s entries', () async {
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(
          seen,
          body: (_) => jsonEncode([
            {
              'document': {
                'fields': {
                  'name': {'stringValue': 'Anna'},
                  'score': {'integerValue': '4200'},
                },
              },
            },
          ]),
        ),
      );

      final top = await service.fetchDailyTop(_todayKey);

      expect(top.single.name, 'Anna');
      expect(top.single.score, 4200);
      final request = seen.single;
      expect(
        request.url.path,
        endsWith('/dailyLeaderboard/$_todayKey:runQuery'),
      );
      final query = jsonDecode(request.body) as Map;
      expect(query['structuredQuery']['from'], [
        {'collectionId': 'entries'},
      ]);
    });

    test('dailyRank: one more than the better entries, out of all', () async {
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(
          seen,
          body: (r) => _count(r.body.contains('GREATER_THAN') ? 4 : 20),
        ),
      );

      final rank = await service.dailyRank(day: _todayKey, score: 3000);
      expect(rank, (rank: 5, total: 20));
      expect(
        seen.first.url.path,
        endsWith('/dailyLeaderboard/$_todayKey:runAggregationQuery'),
      );

      final outside = await service.dailyRank(
        day: _todayKey,
        score: 3000,
        entered: false,
      );
      expect(outside, (
        rank: 5,
        total: 21,
      ), reason: 'a player without an entry is counted in on top');
    });

    test('dailyRank is null when the server cannot be asked', () async {
      final service = LeaderboardService(client: _client([], status: 500));
      expect(await service.dailyRank(day: _todayKey, score: 1), isNull);
    });

    test('deleteEntry removes the Daily entries it is given', () async {
      SharedPreferences.setMockInitialValues(_identity);
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(seen),
        storage: await Storage.create(),
      );

      expect(
        await service.deleteEntry(dailyDays: ['2026-09-28', _todayKey]),
        isTrue,
      );

      final deleted = seen
          .where((r) => r.method == 'DELETE')
          .map((r) => r.url.path)
          .toList();
      expect(
        deleted,
        contains(endsWith('/dailyLeaderboard/2026-09-28/entries/uid-abc')),
      );
      expect(
        deleted,
        contains(endsWith('/dailyLeaderboard/$_todayKey/entries/uid-abc')),
      );
    });
  });

  group('controller', () {
    test('the counted Daily pays its stars and enters the ranking', () async {
      final lb = _Recorder();
      final (c, storage) = await _controller({'playerName': 'Anna'}, lb);
      c.startDaily();
      await _playToGameOver(c);

      final score = c.state.score;
      final stars = DailyGoal.starsFor(score);
      expect(c.state.dailyStarsThisRun, stars);
      expect(storage.lastDailyScore, score);
      expect(
        c.state.dailyRewardThisRun,
        greaterThanOrEqualTo(DailyGoal.coinsFor(stars)),
      );
      expect(lb.daily, [(_todayKey, score)]);
      expect(storage.pendingDaily, isNull);
      expect(storage.dailySubmittedDays, [_todayKey]);
    });

    test('a replay of the day enters nothing', () async {
      final lb = _Recorder();
      final (c, _) = await _controller({'playerName': 'Anna'}, lb);
      c.startDaily();
      await _playToGameOver(c);
      c.startDaily();
      await _playToGameOver(c);

      expect(lb.daily, hasLength(1));
      expect(c.state.dailyStarsThisRun, isNull);
    });

    test('without a name the entry waits for one', () async {
      final lb = _Recorder();
      final (c, storage) = await _controller({}, lb);
      c.startDaily();
      await _playToGameOver(c);
      final score = c.state.score;

      expect(lb.daily, isEmpty);
      expect(storage.pendingDaily, (day: _todayKey, score: score));

      await c.setPlayerName('Anna');
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(lb.daily, [(_todayKey, score)]);
      expect(storage.pendingDaily, isNull);
    });

    test('a failed upload is retried; a refused one is dropped', () async {
      final lb = _Recorder(DailySubmit.failed);
      final (c, storage) = await _controller({'playerName': 'Anna'}, lb);
      c.startDaily();
      await _playToGameOver(c);
      expect(storage.pendingDaily, isNotNull);
      expect(storage.dailySubmittedDays, isEmpty);

      lb.answer = DailySubmit.refused;
      c.autoUploadBestScore();
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(lb.daily, hasLength(2));
      expect(storage.pendingDaily, isNull);
      expect(storage.dailySubmittedDays, isEmpty);
    });

    test('an entry already on the server counts as sent', () async {
      final lb = _Recorder(DailySubmit.alreadyStored);
      final (c, storage) = await _controller({'playerName': 'Anna'}, lb);
      c.startDaily();
      await _playToGameOver(c);
      expect(storage.pendingDaily, isNull);
      expect(storage.dailySubmittedDays, [
        _todayKey,
      ], reason: 'it is still the player\'s, and deleting must find it');
    });

    test('the third day in a row opens a chest of diamonds', () async {
      final (c, storage) = await _controller({
        'streak': 2,
        'lastDailyDate': '2026-09-28',
      }, null);
      final before = storage.diamonds;
      c.startDaily();
      await _playToGameOver(c);

      expect(storage.streak, 3);
      expect(c.state.dailyChestThisRun, StreakChest.diamondsFor(3));
      expect(
        storage.diamonds - before,
        greaterThanOrEqualTo(StreakChest.diamondsFor(3)),
      );
    });

    test('no chest between milestones', () async {
      final (c, _) = await _controller({
        'streak': 3,
        'lastDailyDate': '2026-09-28',
      }, null);
      c.startDaily();
      await _playToGameOver(c);
      expect(c.state.dailyChestThisRun, 0);
    });

    test('today\'s rank asks with the counted score', () async {
      final lb = _Recorder();
      final (c, storage) = await _controller({'playerName': 'Anna'}, lb);
      expect(
        await c.todaysDailyRank(),
        isNull,
        reason: 'no Daily played today',
      );

      c.startDaily();
      await _playToGameOver(c);
      expect(await c.todaysDailyRank(), (rank: 3, total: 10));
      expect(lb.ranks.single, (_todayKey, storage.lastDailyScore, true));
    });

    test('deleting the entry takes the Daily entries along', () async {
      final lb = _Recorder();
      final (c, storage) = await _controller({
        'playerName': 'Anna',
        ..._identity,
        'leaderboard.dailyDays': ['2026-09-27', '2026-09-28'],
      }, lb);

      expect(await c.deleteLeaderboardEntry(), isTrue);
      expect(lb.deletedDays, ['2026-09-27', '2026-09-28']);
      expect(storage.dailySubmittedDays, isEmpty);
    });

    test('the submitted days survive a progress reset', () async {
      final (_, storage) = await _controller({
        'leaderboard.dailyDays': ['2026-09-28'],
        'leaderboard.pendingDaily': '2026-09-28|900',
      }, null);
      await storage.resetProgress();
      expect(storage.dailySubmittedDays, ['2026-09-28']);
      expect(storage.pendingDaily, isNull);
    });
  });
}
