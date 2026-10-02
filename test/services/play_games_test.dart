// Play Games Services (owner decision 02.10.2026): the sync sends what the
// local save has earned — unlocked achievements, every endless run, the best
// score and the daily streak — once per Play Games player, and never gets in
// the way of the game.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/achievements.dart';
import 'package:gridpop/game/stats.dart';
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
  final steps = <(String, int)>[];
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
  Future<bool> setSteps(String id, int value) async {
    if (failing) return false;
    steps.add((id, value));
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
  Future<bool> setSteps(String id, int steps) =>
      throw StateError('no Play services');

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

  test('incremental achievements send their progress, capped, once per '
      'change', () async {
    final storage = await _storage({
      'lifetimeStats': '{"games":12}',
    });
    final games = FakePlayGames();
    final sync = PlayGamesSync(
      games,
      storage,
      ids: const PlayGamesIds(achievements: {'games_25': 'ACH_25'}),
    );
    await sync.sync();
    expect(games.steps, [('ACH_25', 12)]);
    await sync.sync();
    expect(games.steps, hasLength(1));

    await storage.setLifetimeStats(const LifetimeStats(games: 40));
    await sync.sync();
    // 25 of 25: Play Games unlocks it; nothing beyond the total is sent.
    expect(games.steps, [('ACH_25', 12), ('ACH_25', 25)]);
    expect(games.unlocked, isEmpty);
    await sync.sync();
    expect(games.steps, hasLength(2));
  });

  test('the import and the app agree on which achievements are '
      'incremental', () {
    final rows = File(
      'store-assets/play-games/import/AchievementsMetadata.csv',
    ).readAsLinesSync().where((l) => l.isNotEmpty).toList();
    expect(rows, hasLength(Achievements.catalog.length));
    for (final (i, a) in Achievements.catalog.indexed) {
      final cols = rows[i].split(',');
      expect(cols, hasLength(7), reason: rows[i]);
      final incremental = kPlayGamesIncremental.contains(a.id);
      expect(cols[2], incremental ? 'True' : 'False', reason: a.id);
      expect(cols[3], incremental ? '${a.threshold}' : '', reason: a.id);
      expect(cols[6], '${i + 1}', reason: a.id);
    }
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

  // Android cannot be built in every environment this runs in, so the
  // wiring the SDK reads at start-up is checked here.
  test('the manifest points Play Games at the Console project id', () {
    final manifest =
        File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    final ids = File(
      'android/app/src/main/res/values/games-ids.xml',
    ).readAsStringSync();
    final ref = RegExp(
      r'android:name="com\.google\.android\.gms\.games\.APP_ID"\s*'
      r'android:value="@string/(\w+)"',
    ).firstMatch(manifest);
    expect(ref, isNotNull);
    expect(
      ids,
      contains('<string name="${ref!.group(1)}" translatable="false">'
          '108672510585</string>'),
    );
    expect(manifest, contains('android:name=".QubbleApplication"'));
    expect(
      File(
        'android/app/src/main/kotlin/com/thinkube/qubble/QubbleApplication.kt',
      ).readAsStringSync(),
      contains('PlayGamesSdk.initialize(this)'),
    );
  });

  // The SDK is switched on natively; the ids live in Dart. Ids without the
  // SDK would call an SDK that never started, the SDK without ids would sign
  // players in (and collect data) for nothing.
  test('Play Games starts exactly when its ids are filled in', () {
    final flag = RegExp(
      r'<bool name="play_games_enabled">(true|false)</bool>',
    ).firstMatch(
      File('android/app/src/main/res/values/play_games.xml')
          .readAsStringSync(),
    );
    expect(flag, isNotNull);
    final configured = kPlayGamesIds.bestScore != null ||
        kPlayGamesIds.dailyStreak != null ||
        kPlayGamesIds.achievements.isNotEmpty;
    expect(flag!.group(1), configured ? 'true' : 'false');
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
