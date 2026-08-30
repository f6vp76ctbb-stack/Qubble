import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/leveling.dart';

void main() {
  group('curves', () {
    test('xpForNext follows 100 + 50*level', () {
      expect(LevelSystem.xpForNext(1), 150);
      expect(LevelSystem.xpForNext(2), 200);
      expect(LevelSystem.xpForNext(10), 600);
    });

    test('levelReward follows 20 + 5*level', () {
      expect(LevelSystem.levelReward(2), 30);
      expect(LevelSystem.levelReward(5), 45);
    });
  });

  group('xpForRun', () {
    const base = LevelSystem.baseXpPerRun;

    test('a flat floor per run plus one XP per 100 points', () {
      expect(LevelSystem.xpForRun(score: 250, dailyCompleted: false), base + 2);
      expect(LevelSystem.xpForRun(score: 99, dailyCompleted: false), base);
    });

    test('finishing a run is always worth something', () {
      // Purely score-based XP punished beginners twice: they score less AND
      // the reward scaled with the score, so the level bar never moved.
      expect(LevelSystem.xpForRun(score: 0, dailyCompleted: false), base);
      expect(LevelSystem.xpForRun(score: -5, dailyCompleted: false), base);
    });

    test('the floor does not distort a strong run', () {
      final strong = LevelSystem.xpForRun(score: 12000, dailyCompleted: false);
      expect(strong, base + 120);
      expect(base / strong, lessThan(0.15));
    });

    test('daily completion adds 50', () {
      expect(
        LevelSystem.xpForRun(score: 250, dailyCompleted: true),
        base + 2 + 50,
      );
    });

    test('a beginner reaches level 2 within a first session', () {
      // ~300 points a run is a realistic first-session score.
      final perRun = LevelSystem.xpForRun(score: 300, dailyCompleted: false);
      final runs = (LevelSystem.xpForNext(1) / perRun).ceil();
      expect(runs, lessThanOrEqualTo(12),
          reason: 'level 2 takes $runs runs — the progress bar looks dead');
    });
  });

  group('applyXp', () {
    test('no level-up below the threshold', () {
      final o = LevelSystem.applyXp(level: 1, xpIntoLevel: 0, gainedXp: 100);
      expect(o.leveledUp, isFalse);
      expect(o.level, 1);
      expect(o.xpIntoLevel, 100);
      expect(o.coinsAwarded, 0);
    });

    test('single level-up rolls over the remainder', () {
      // level 1 needs 150; 20 + 140 = 160 -> level 2 with 10 left.
      final o = LevelSystem.applyXp(level: 1, xpIntoLevel: 20, gainedXp: 140);
      expect(o.level, 2);
      expect(o.xpIntoLevel, 10);
      expect(o.levelsGained, [2]);
      expect(o.coinsAwarded, LevelSystem.levelReward(2));
    });

    test('multiple level-ups in one gain accumulate rewards', () {
      // From level 1 with 0: need 150 (->2), then 200 (->3) = 350 total.
      final o = LevelSystem.applyXp(level: 1, xpIntoLevel: 0, gainedXp: 350);
      expect(o.level, 3);
      expect(o.xpIntoLevel, 0);
      expect(o.levelsGained, [2, 3]);
      expect(
        o.coinsAwarded,
        LevelSystem.levelReward(2) + LevelSystem.levelReward(3),
      );
    });

    test('reaching a milestone level yields its cosmetic reward', () {
      // Push from level 3 to level 4 — the gradient skin unlocks at 4.
      final o = LevelSystem.applyXp(
        level: 3,
        xpIntoLevel: 0,
        gainedXp: LevelSystem.xpForNext(3),
      );
      expect(o.level, 4);
      expect(o.rewards, hasLength(1));
      expect(o.rewards.single.id, 'gradient');
      expect(o.rewards.single.kind, LevelRewardKind.skin);
    });

    test('the very first level-up already unlocks something', () {
      // A player who never unlocks anything concludes there is nothing to
      // unlock, so the first milestone sits at level 2.
      final o = LevelSystem.applyXp(level: 1, xpIntoLevel: 0, gainedXp: 150);
      expect(o.level, 2);
      expect(o.rewards.single.id, 'fade');
    });

    test('a non-milestone level-up yields no cosmetic', () {
      // Level 2 -> 3 is not on the reward track.
      final o = LevelSystem.applyXp(
        level: 2,
        xpIntoLevel: 0,
        gainedXp: LevelSystem.xpForNext(2),
      );
      expect(o.level, 3);
      expect(o.rewards, isEmpty);
    });

    test('jumping past several milestones collects each reward once', () {
      // From level 1, blow past levels 2 (fade) and 4 (gradient); level 3 has
      // no reward.
      var xp = 0;
      for (var l = 1; l < 5; l++) {
        xp += LevelSystem.xpForNext(l);
      }
      final o = LevelSystem.applyXp(level: 1, xpIntoLevel: 0, gainedXp: xp);
      expect(o.level, 5);
      expect(o.rewards.map((r) => r.id), ['fade', 'gradient']);
    });
  });

  group('reward track', () {
    test('nextReward returns the first milestone above the level', () {
      expect(LevelSystem.nextReward(1)!.level, 2);
      expect(LevelSystem.nextReward(3)!.level, 4);
      expect(LevelSystem.nextReward(19)!.level, 20);
      expect(LevelSystem.nextReward(20)!.level, 24);
      expect(LevelSystem.nextReward(28)!.level, 32);
      expect(LevelSystem.nextReward(40), isNull);
    });

    test('every reward id is unique and non-empty', () {
      final ids = LevelSystem.rewardTrack.map((r) => r.id).toList();
      expect(ids.toSet(), hasLength(ids.length));
      expect(ids.every((id) => id.isNotEmpty), isTrue);
    });
  });
}
