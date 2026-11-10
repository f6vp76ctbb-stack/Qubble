import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/achievements.dart';
import 'package:gridpop/game/block_skin.dart';

void main() {
  group('catalog integrity', () {
    test('ids are unique and thresholds positive', () {
      final ids = Achievements.catalog.map((a) => a.id).toList();
      expect(ids.toSet(), hasLength(ids.length));
      expect(Achievements.catalog.every((a) => a.threshold > 0), isTrue);
      expect(Achievements.catalog.every((a) => a.icon.isNotEmpty), isTrue);
    });
  });

  group('unlockedFor', () {
    test('nothing unlocked at zero progress except no-op', () {
      expect(Achievements.unlockedFor(const AchievementProgress()), isEmpty);
    });

    test('first game unlocks after one game', () {
      final u = Achievements.unlockedFor(const AchievementProgress(games: 1));
      expect(u, contains('first_game'));
      expect(u, isNot(contains('games_25')));
    });

    test('high metrics unlock all tiers of that metric', () {
      final u =
          Achievements.unlockedFor(const AchievementProgress(highscore: 30000));
      expect(u, containsAll(['score_1k', 'score_5k', 'score_10k', 'score_25k']));
    });
  });

  group('fraction', () {
    test('is clamped between 0 and 1', () {
      final a = Achievements.byId('score_10k'); // threshold 10000
      expect(
        Achievements.fraction(a, const AchievementProgress(highscore: 5000)),
        0.5,
      );
      expect(
        Achievements.fraction(a, const AchievementProgress(highscore: 99999)),
        1.0,
      );
      expect(
        Achievements.fraction(a, const AchievementProgress()),
        0.0,
      );
    });
  });

  group('newlyUnlocked', () {
    test('returns only achievements not already unlocked', () {
      const p = AchievementProgress(games: 1, highscore: 1200);
      final fresh = Achievements.newlyUnlocked(p, {'first_game'});
      final ids = fresh.map((a) => a.id).toList();
      expect(ids, contains('score_1k'));
      expect(ids, isNot(contains('first_game')));
    });

    test('empty when nothing new crosses a threshold', () {
      const p = AchievementProgress(games: 1);
      expect(Achievements.newlyUnlocked(p, {'first_game'}), isEmpty);
    });
  });

  // Stages (owner, 12.10.2026): eight categories of five stages; every stage
  // below the last pays coins on a tap, the last unlocks the animated skin.
  group('stages', () {
    AchievementStatus status(
      String id,
      int value, {
      int claimed = 0,
      bool skinOwned = false,
    }) => AchievementStatus(
      track: AchievementTracks.byId(id),
      value: value,
      claimed: claimed,
      skinOwned: skinOwned,
    );

    test('every category has five ascending stages and covers its metric',
        () {
      expect(
        AchievementTracks.catalog.map((t) => t.metric).toSet(),
        AchievementMetric.values.toSet(),
      );
      for (final t in AchievementTracks.catalog) {
        expect(t.stages, 5, reason: t.id);
        for (var i = 1; i < t.tiers.length; i++) {
          expect(t.tiers[i], greaterThan(t.tiers[i - 1]), reason: t.id);
        }
      }
      expect(AchievementTracks.totalStages, 40);
    });

    test('"Hooked" ends at the old 100 runs (the owner\'s example)', () {
      expect(AchievementTracks.byId('games').tiers.last, 100);
    });

    test('the two that were too easy are harder now', () {
      // 25,000 points and 10 puzzles were reached quickly (12.10.2026).
      expect(AchievementTracks.byId('score').tiers.last, 100000);
      expect(AchievementTracks.byId('puzzles').tiers.last, 100);
    });

    test('stages below the last pay coins, the last the skin', () {
      final s = status('games', 0);
      for (var tier = 0; tier < 4; tier++) {
        expect(s.rewardFor(tier).coins, kAchievementTierCoins);
        expect(s.rewardFor(tier).skinId, isNull);
      }
      expect(s.rewardFor(4).skinId, 'pulse');
      expect(s.rewardFor(4).coins, 0);
    });

    test('a skin owned from before the stages pays coins instead', () {
      final s = status('score', 0, skinOwned: true);
      expect(s.rewardFor(4).skinId, isNull);
      expect(s.rewardFor(4).coins, kAchievementTierCoins);
    });

    test('reached, claimable and collectable', () {
      final s = status('games', 30, claimed: 1);
      expect(s.reached, 3); // 1, 10, 25
      expect(s.claimable, 2);
      expect(s.collectable.coins, 2 * kAchievementTierCoins);
      expect(s.collectable.skinId, isNull);
      expect(s.currentTier, 1);
      expect(s.target, 10);
    });

    test('collecting the last stage hands over the skin', () {
      final s = status('games', 120, claimed: 3);
      expect(s.claimable, 2);
      expect(s.collectable.coins, kAchievementTierCoins);
      expect(s.collectable.skinId, 'pulse');
    });

    test('the bar runs toward the first stage not collected', () {
      final s = status('lines', 75, claimed: 1); // 50 collected, next 100
      expect(s.target, 100);
      expect(s.fraction, 0.75);
      expect(status('lines', 2000, claimed: 5).fraction, 1.0);
      expect(status('lines', 2000, claimed: 5).complete, isTrue);
    });

    test('sorted: rewards to collect, then closest first, finished last', () {
      final sorted = AchievementTracks.sorted([
        status('games', 100, claimed: 5), // finished
        status('lines', 90, claimed: 1), // 90 % to 100
        status('pieces', 100, claimed: 0), // 40 % to 250
        status('combo', 3, claimed: 0), // stage 1 waiting
        status('level', 7, claimed: 1), // 87.5 % to 8
      ]).map((s) => s.track.id).toList();
      expect(sorted, ['combo', 'lines', 'level', 'pieces', 'games']);
    });

    test('collecting moves a category down from the top', () {
      final before = AchievementTracks.sorted([
        status('lines', 90, claimed: 1),
        status('games', 12, claimed: 1),
      ]);
      expect(before.first.track.id, 'games', reason: 'stage 2 waiting');
      final after = AchievementTracks.sorted([
        status('lines', 90, claimed: 1),
        status('games', 12, claimed: 2), // 12 of 25 now
      ]);
      expect(after.first.track.id, 'lines');
    });

    test('newlyReached reports only categories past what was shown', () {
      const p = AchievementProgress(games: 12, totalLines: 40);
      final fresh = AchievementTracks.newlyReached(p, {'games': 1});
      expect(fresh.keys.map((t) => t.id), ['games']);
      expect(fresh.values.single, 2);
      expect(AchievementTracks.newlyReached(p, {'games': 2}), isEmpty);
    });

    test('every reward skin is animated, belongs to exactly one category, '
        'and the animated shop skins to none', () {
      for (final skin in kSkinCatalog.where((s) => s.style.isAnimated)) {
        final owners =
            AchievementTracks.catalog.where((t) => t.skinId == skin.id);
        if (skin.achievementId == null) {
          expect(owners, isEmpty, reason: skin.id);
          expect(skin.isPurchasable, isTrue, reason: skin.id);
        } else {
          expect(owners.single.id, skin.achievementId, reason: skin.id);
        }
      }
      for (final t in AchievementTracks.catalog) {
        final skin = kSkinCatalog.singleWhere((s) => s.id == t.skinId);
        expect(skin.style.isAnimated, isTrue, reason: skin.id);
        expect(skin.isPurchasable, isFalse, reason: skin.id);
      }
    });
  });
}
