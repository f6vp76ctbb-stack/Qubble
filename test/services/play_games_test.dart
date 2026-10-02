// Play Games Services (owner decision 02.10.2026): the sync sends what the
// local save has earned — unlocked achievements, every endless run, the best
// score and the daily streak — once per Play Games player, and never gets in
// the way of the game.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/achievements.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/play_games.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

class FakePlayGames implements PlayGamesService {
  String? player = 'p1';
  bool failing = false;
  final unlocked = <String>[];
  final scores = <(String, int)>[];

  @override
  Future<String?> playerId() async => player;

  @override
  Future<bool> unlock(String id) async {
    if (failing) return false;
    unlocked.add(id);
    return true;
  }

  @override
  Future<bool> submitScore(String id, int score) async {
    if (failing) return false;
    scores.add((id, score));
    return true;
  }
}

class ThrowingPlayGames implements PlayGamesService {
  @override
  Future<String?> playerId() => throw StateError('no Play services');

  @override
  Future<bool> unlock(String id) => throw StateError('no Play services');

  @override
  Future<bool> submitScore(String id, int score) =>
      throw StateError('no Play services');
}

const _ids = PlayGamesIds(
  bestScore: 'LB_BEST',
  dailyStreak: 'LB_STREAK',
  achievements: {'first_game': 'ACH_FIRST', 'score_1k': 'ACH_1K'},
);

Future<Storage> _storage([Map<String, Object> values = const {}]) async {
  SharedPreferences.setMockInitialValues(values);
  return Storage.create();
}

void main() {
  test('the shipped ids are empty, so nothing is sent before Play Console '
      'has the entries', () async {
    final storage = await _storage({
      'highscore': 5000,
      'achievements': ['first_game'],
    });
    final games = FakePlayGames();
    await PlayGamesSync(games, storage).sync(runScore: 300);
    expect(games.unlocked, isEmpty);
    expect(games.scores, isEmpty);
  });

  test('nothing is sent while nobody is signed in', () async {
    final storage = await _storage({
      'highscore': 5000,
      'achievements': ['first_game'],
    });
    final games = FakePlayGames()..player = null;
    await PlayGamesSync(games, storage, ids: _ids).sync(runScore: 300);
    expect(games.unlocked, isEmpty);
    expect(games.scores, isEmpty);
  });

  test('unlocked achievements, the best and the streak arrive once', () async {
    final storage = await _storage({
      'highscore': 5000,
      'streak': 4,
      // games_25 has no Play Games id here and is skipped.
      'achievements': ['first_game', 'score_1k', 'games_25'],
    });
    final games = FakePlayGames();
    final sync = PlayGamesSync(games, storage, ids: _ids);

    await sync.sync();
    expect(games.unlocked, unorderedEquals(['ACH_FIRST', 'ACH_1K']));
    expect(games.scores, [('LB_BEST', 5000), ('LB_STREAK', 4)]);

    await sync.sync();
    expect(games.unlocked, hasLength(2));
    expect(games.scores, hasLength(2));
  });

  test('every endless run goes to the leaderboard, a new best once',
      () async {
    final storage = await _storage({'highscore': 5000});
    final games = FakePlayGames();
    final sync = PlayGamesSync(games, storage, ids: _ids);
    await sync.sync();
    games.scores.clear();

    await sync.sync(runScore: 1200);
    expect(games.scores, [('LB_BEST', 1200)]);

    await storage.submitScore(6000);
    await sync.sync(runScore: 6000);
    expect(games.scores, [('LB_BEST', 1200), ('LB_BEST', 6000)]);
  });

  test('the streak is sent whenever it changes', () async {
    final storage = await _storage({'streak': 3});
    final games = FakePlayGames();
    final sync = PlayGamesSync(games, storage, ids: _ids);
    await sync.sync();
    await storage.setStreak(1);
    await sync.sync();
    await sync.sync();
    expect(games.scores, [('LB_STREAK', 3), ('LB_STREAK', 1)]);
  });

  test('what failed to arrive is sent again on the next sync', () async {
    final storage = await _storage({
      'highscore': 5000,
      'achievements': ['first_game'],
    });
    final games = FakePlayGames()..failing = true;
    final sync = PlayGamesSync(games, storage, ids: _ids);
    await sync.sync();
    expect(games.unlocked, isEmpty);

    games.failing = false;
    await sync.sync();
    expect(games.unlocked, ['ACH_FIRST']);
    expect(games.scores, [('LB_BEST', 5000)]);
  });

  test('another Play Games account gets everything again', () async {
    final storage = await _storage({
      'highscore': 5000,
      'achievements': ['first_game'],
    });
    final games = FakePlayGames();
    final sync = PlayGamesSync(games, storage, ids: _ids);
    await sync.sync();

    games.player = 'p2';
    await sync.sync();
    expect(games.unlocked, ['ACH_FIRST', 'ACH_FIRST']);
    expect(games.scores, [('LB_BEST', 5000), ('LB_BEST', 5000)]);
  });

  test('syncs started together run one after the other', () async {
    final storage = await _storage({'achievements': ['first_game']});
    final games = FakePlayGames();
    final sync = PlayGamesSync(games, storage, ids: _ids);
    await Future.wait([sync.sync(), sync.sync(), sync.sync()]);
    expect(games.unlocked, ['ACH_FIRST']);
  });

  test('a broken Play Games never throws into the game', () async {
    final storage = await _storage({'achievements': ['first_game']});
    final sync = PlayGamesSync(ThrowingPlayGames(), storage, ids: _ids);
    await expectLater(sync.sync(runScore: 10), completes);
    // And the queue still works afterwards.
    await expectLater(sync.sync(), completes);
  });

  test('a reset keeps what Play Games already has', () async {
    final storage = await _storage({'achievements': ['first_game']});
    final games = FakePlayGames();
    final sync = PlayGamesSync(games, storage, ids: _ids);
    await sync.sync();
    await storage.resetProgress();
    await storage.setUnlockedAchievements({'first_game'});
    await sync.sync();
    expect(games.unlocked, ['ACH_FIRST']);
  });

  test('every achievement has its Play Games icon (tool/play_games_icons.py)',
      () {
    for (final a in Achievements.catalog) {
      expect(
        File('store-assets/play-games/achievement_${a.id}.png').existsSync(),
        isTrue,
        reason: a.id,
      );
    }
  });

  test('a finished endless run hands its score and achievements to Play '
      'Games', () async {
    final storage = await _storage({'onboardingDone': true});
    final games = FakePlayGames();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
      seed: 4242,
      clock: SteppingClock().call,
      playGames: PlayGamesSync(games, storage, ids: _ids),
    );
    addTearDown(c.dispose);
    playToGameOver(c);
    expect(c.state.gameOver, isTrue);
    for (var i = 0; i < 50 && games.unlocked.isEmpty; i++) {
      await Future<void>.delayed(Duration.zero);
    }
    for (var i = 0; i < 50; i++) {
      await Future<void>.delayed(Duration.zero);
    }

    expect(games.unlocked, contains('ACH_FIRST'));
    expect(games.scores, contains(('LB_BEST', c.state.score)));
  });
}
