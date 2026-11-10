import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/achievements.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/leveling.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<GameController> _controller({AdService? ads}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  return GameController(
    storage,
    Haptics(enabled: false),
    SilentAudio(),
    ads ?? FakeAdService(),
    NoopAnalytics(),
  );
}

/// Drives the controller by always playing the first legal move it can find.
/// Plays like a real player: if nothing fits as-is, it rotates a piece that
/// can be rescued within the rotation budget, then places. Returns when the
/// game is over or the guard trips.
void _playToGameOver(GameController c) {
  var guard = 0;
  while (!c.state.gameOver && guard < 5000) {
    if (!_placeOneLegalMove(c)) break;
    guard++;
  }
}

/// Plays a single move: a direct placement if possible, else a rotation
/// rescue (only spending charges on a piece that will actually fit). Returns
/// whether one was made.
bool _placeOneLegalMove(GameController c) {
  bool tryPlace(int slot) {
    for (var r = 0; r < Board.size; r++) {
      for (var col = 0; col < Board.size; col++) {
        if (c.canPlace(slot, Cell(r, col))) {
          c.place(slot, Cell(r, col));
          return true;
        }
      }
    }
    return false;
  }

  for (var slot = 0; slot < c.state.tray.length; slot++) {
    if (c.state.tray[slot] == null) continue;
    if (tryPlace(slot)) return true;
  }
  final budget = c.state.rotationFree ? 3 : c.state.rotationCharges.clamp(0, 3);
  for (var slot = 0; slot < c.state.tray.length; slot++) {
    final piece = c.state.tray[slot];
    if (piece == null) continue;
    var rotated = piece;
    for (var rot = 1; rot <= budget; rot++) {
      rotated = rotated.rotatedCw();
      if (c.state.board.hasAnyPlacement(rotated)) {
        for (var i = 0; i < rot; i++) {
          c.rotateTray(slot);
        }
        return tryPlace(slot);
      }
    }
  }
  return false;
}

void main() {
  test('endless run does not touch the daily streak', () async {
    final c = await _controller();
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(c.state.gameOver, isTrue);
    expect(c.state.isDaily, isFalse);
    expect(c.state.streak, 0);
  });

  test('completing the daily awards coins and starts a streak', () async {
    final c = await _controller();
    final startCoins = c.state.coins;
    c.startDaily(now: DateTime(2026, 7, 5));
    expect(c.state.isDaily, isTrue);

    _playToGameOver(c);
    // Let the async finalize (storage writes) settle.
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(c.state.streak, 1);
    // First daily completion always grants at least the base + streak reward.
    expect(c.state.coinsEarnedThisRun, greaterThanOrEqualTo(60));
    expect(c.state.coins, greaterThan(startCoins));
  });

  test('the onboarding hint follows progress, not a move counter', () async {
    final c = await _controller(); // fresh prefs => onboarding active
    c.newGame(seed: 3);
    expect(c.state.onboardingHintStep, isNotNull);

    // Three placements used to end the lesson outright, whether or not the
    // player had cleared anything. See test/ui/onboarding_progress_test.dart
    // for the step-by-step behaviour.
    for (var i = 0; i < 3; i++) {
      _placeOneLegalMove(c);
    }
    if (c.state.lastClearedLineCount == 0) {
      expect(c.state.onboardingHintStep, isNotNull);
    }

    // Playing on until lines clear does finish it.
    var guard = 0;
    while (c.state.onboardingHintStep != null && guard++ < 300) {
      _placeOneLegalMove(c);
      if (c.state.gameOver) break;
    }
    expect(c.state.onboardingHintStep, isNull);
  });

  test('daily mode never shows the onboarding hint', () async {
    final c = await _controller();
    c.startDaily(now: DateTime(2026, 7, 5));
    expect(c.state.onboardingHintStep, isNull);
  });

  test('a finished run updates lifetime stats', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
    );
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final stats = storage.lifetimeStats;
    expect(stats.games, 1);
    expect(stats.totalPieces, greaterThan(0));
  });

  test('clearing lines increments the clear event id', () async {
    final c = await _controller();
    c.newGame(seed: 1);
    _playToGameOver(c);
    // A greedy full run reliably clears lines, so the particle trigger must
    // have fired at least once and exposed the cleared cells.
    expect(c.state.clearEventId, greaterThan(0));
  });

  group('boosters', () {
    test('undo is unavailable with nothing to undo', () async {
      final c = await _controller();
      c.newGame(seed: 1);
      expect(c.state.canUndo, isFalse);
      expect(await c.tryUndo(), isFalse);
    });

    test('undo reverts the last move and costs coins', () async {
      SharedPreferences.setMockInitialValues({'coins': 100});
      final storage = await Storage.create();
      final c = GameController(
        storage,
        Haptics(enabled: false),
        SilentAudio(),
        FakeAdService(),
        NoopAnalytics(),
      );
      c.newGame(seed: 3);
      final scoreBefore = c.state.score;
      _placeOneLegalMove(c);
      expect(c.state.canUndo, isTrue);
      final ok = await c.tryUndo();
      expect(ok, isTrue);
      expect(c.state.score, scoreBefore);
      expect(c.state.coins, 50); // 100 - 50
      expect(c.state.canUndo, isFalse); // only one undo
    });

    test('undo is refused without enough coins', () async {
      SharedPreferences.setMockInitialValues({'coins': 10});
      final storage = await Storage.create();
      final c = GameController(
        storage,
        Haptics(enabled: false),
        SilentAudio(),
        FakeAdService(),
        NoopAnalytics(),
      );
      c.newGame(seed: 3);
      _placeOneLegalMove(c);
      expect(await c.tryUndo(), isFalse);
      expect(c.state.canUndo, isTrue); // move preserved
    });

    test('swap costs coins and redraws the tray', () async {
      SharedPreferences.setMockInitialValues({'coins': 100});
      final storage = await Storage.create();
      final c = GameController(
        storage,
        Haptics(enabled: false),
        SilentAudio(),
        FakeAdService(),
        NoopAnalytics(),
      );
      c.newGame(seed: 5);
      final before = c.state.tray.map((p) => p?.id).toList();
      final ok = await c.trySwapPieces();
      expect(ok, isTrue);
      expect(c.state.coins, 25); // 100 - 75
      expect(c.state.tray.map((p) => p?.id).toList(), isNot(before));
    });

    test('bomb costs coins', () async {
      SharedPreferences.setMockInitialValues({'coins': 200});
      final storage = await Storage.create();
      final c = GameController(
        storage,
        Haptics(enabled: false),
        SilentAudio(),
        FakeAdService(),
        NoopAnalytics(),
      );
      c.newGame(seed: 5);
      final ok = await c.tryBomb(const Cell(4, 4));
      expect(ok, isTrue);
      expect(c.state.coins, 50); // 200 - 150
    });
  });

  test('an illegal placement is a no-op', () async {
    final c = await _controller();
    c.newGame(seed: 2);
    final before = c.state.score;
    c.place(0, const Cell(100, 100));
    expect(c.state.score, before);
  });

  test('reaching a milestone level unlocks its cosmetic reward', () async {
    // One XP shy of level 2 (fade theme milestone); any finished run earns
    // at least LevelSystem.baseXpPerRun.
    SharedPreferences.setMockInitialValues({
      'playerLevel': 1,
      'xp': LevelSystem.xpForNext(1) - 1,
    });
    final storage = await Storage.create();
    var cosmeticsCallbackFired = false;
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
      onCosmeticsGranted: () => cosmeticsCallbackFired = true,
    );
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(storage.playerLevel, greaterThanOrEqualTo(2));
    expect(storage.unlockedThemes, contains('fade'));
    expect(c.state.rewardsUnlockedThisRun.map((r) => r.id), contains('fade'));
    expect(cosmeticsCallbackFired, isTrue);
  });

  test('an already-owned reward is not re-announced', () async {
    SharedPreferences.setMockInitialValues({
      'playerLevel': 1,
      'xp': LevelSystem.xpForNext(1) - 1,
      'unlockedThemes': <String>['fade'],
    });
    final storage = await Storage.create();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
    );
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    // Crossed level 2 but already owned fade → nothing new to announce.
    expect(storage.playerLevel, greaterThanOrEqualTo(2));
    expect(c.state.rewardsUnlockedThisRun, isEmpty);
  });

  test('clearing lines awards live coins during play', () async {
    SharedPreferences.setMockInitialValues({'coins': 0});
    final storage = await Storage.create();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
    );
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    // A greedy full run clears many lines, each worth kCoinsPerLine coins,
    // so the balance must have grown from the live rewards.
    expect(storage.coins, greaterThan(0));
    // The run total shown on game-over includes those play coins.
    expect(c.state.coinsEarnedThisRun, greaterThan(0));
  });

  test('finishing a run announces the stages it reached', () async {
    final c = await _controller();
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    // At minimum the first stage of "games" (one run) is reached.
    final reached = {
      for (final r in c.state.achievementsUnlockedThisRun) r.track.id: r.stage,
    };
    expect(reached['games'], 1);
  });

  test('the Play Games milestones are still recorded, paying nothing',
      () async {
    SharedPreferences.setMockInitialValues({'coins': 0});
    final storage = await Storage.create();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
    );
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(storage.unlockedAchievements, contains('first_game'));
    // Only the run's own coins: stage rewards wait to be collected.
    expect(storage.coins, c.state.coinsEarnedThisRun);
  });

  test('stages already shown are not announced again next run', () async {
    SharedPreferences.setMockInitialValues({
      'achievements.tiersShown': '{"games": 1}',
    });
    final storage = await Storage.create();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
    );
    c.newGame(seed: 1);
    _playToGameOver(c);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    final ids = c.state.achievementsUnlockedThisRun.map((r) => r.track.id);
    expect(ids, isNot(contains('games')));
  });

  // Owner, 12.10.2026: every stage below the last pays a small reward, the
  // last the skin, each collected with a tap.
  group('achievement stages', () {
    Future<(GameController, Storage)> withPrefs(
      Map<String, Object> prefs,
    ) async {
      SharedPreferences.setMockInitialValues(prefs);
      final storage = await Storage.create();
      final c = GameController(
        storage,
        Haptics(enabled: false),
        SilentAudio(),
        FakeAdService(),
        NoopAnalytics(),
      );
      return (c, storage);
    }

    test('collecting pays every reached stage once', () async {
      final (c, storage) = await withPrefs({
        'coins': 0,
        'lifetimeStats': '{"games": 30}',
      });
      final games = c.achievementStatuses.firstWhere(
        (s) => s.track.id == 'games',
      );
      expect(games.value, 30);
      expect(games.claimable, 3);
      expect(c.claimableAchievementTiers, greaterThanOrEqualTo(3));

      final paid = await c.collectAchievement('games');
      expect(paid.coins, 3 * kAchievementTierCoins);
      expect(storage.coins, 3 * kAchievementTierCoins);
      expect(storage.achievementTiersClaimed['games'], 3);

      final again = await c.collectAchievement('games');
      expect(again.isEmpty, isTrue);
      expect(storage.coins, 3 * kAchievementTierCoins);
    });

    test('the last stage unlocks the skin', () async {
      final (c, storage) = await withPrefs({
        'coins': 0,
        'lifetimeStats': '{"games": 100}',
        'achievements.tiersClaimed': '{"games": 4}',
      });
      final paid = await c.collectAchievement('games');
      expect(paid.skinId, 'pulse');
      expect(paid.coins, 0);
      expect(storage.unlockedSkins, contains('pulse'));
    });

    test('a skin owned from before the stages pays coins instead', () async {
      final (c, storage) = await withPrefs({
        'coins': 0,
        'lifetimeStats': '{"games": 100}',
        'unlockedSkins': <String>['classic', 'pulse'],
        'achievements.tiersClaimed': '{"games": 4}',
      });
      final paid = await c.collectAchievement('games');
      expect(paid.skinId, isNull);
      expect(paid.coins, kAchievementTierCoins);
      expect(storage.coins, kAchievementTierCoins);
    });

    test('an update does not announce old stages; they wait to be collected',
        () async {
      final (c, storage) = await withPrefs({
        'lifetimeStats': '{"games": 30}',
      });
      await c.startAchievementStages();
      expect(storage.achievementTiersShown?['games'], 3);
      expect(c.claimableAchievementTiers, greaterThanOrEqualTo(3));

      // Started once per device: a later call changes nothing.
      await storage.setAchievementTiersShown({'games': 0});
      await c.startAchievementStages();
      expect(storage.achievementTiersShown?['games'], 0);
    });

    test('a reward waiting makes the Quests button call', () async {
      final (c, _) = await withPrefs({'lifetimeStats': '{"games": 1}'});
      await c.markQuestsSeen();
      expect(c.claimableAchievementTiers, 1);
      expect(c.questNotice, isTrue);
      await c.collectAchievement('games');
      expect(c.questNotice, isFalse);
    });
  });

  // The weekend banner and bonus read the injected calendar, not the wall
  // clock, so a caller can pin the date. The screenshot generator does: its
  // home screen showed the weekend banner whenever it ran on a Saturday.
  group('calendar', () {
    Future<GameController> on(DateTime day) async {
      SharedPreferences.setMockInitialValues({});
      final storage = await Storage.create();
      return GameController(
        storage,
        Haptics(enabled: false),
        SilentAudio(),
        FakeAdService(),
        NoopAnalytics(),
        calendar: () => day,
      );
    }

    test('a Saturday is a weekend', () async {
      expect((await on(DateTime(2026, 3, 14))).state.weekendActive, isTrue);
    });

    test('a Wednesday is not', () async {
      expect((await on(DateTime(2026, 3, 11))).state.weekendActive, isFalse);
    });
  });
}
