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

  // Decided 28.09.2026: the highest tier of each category unlocks an animated
  // block skin; every tier below it pays coins.
  group('rewards', () {
    List<Achievement> tiersOf(AchievementMetric metric) => Achievements
        .catalog
        .where((a) => a.metric == metric)
        .toList()
      ..sort((a, b) => a.threshold.compareTo(b.threshold));

    test('every category has at least one achievement', () {
      for (final metric in AchievementMetric.values) {
        expect(tiersOf(metric), isNotEmpty, reason: metric.name);
      }
    });

    test('the top tier of every category unlocks a skin, the rest pay coins',
        () {
      for (final metric in AchievementMetric.values) {
        final tiers = tiersOf(metric);
        final top = tiers.last;
        expect(top.skinId, isNotNull, reason: top.id);
        expect(top.coins, 0, reason: '${top.id} pays with its skin');
        for (final lower in tiers.take(tiers.length - 1)) {
          expect(lower.skinId, isNull, reason: lower.id);
          expect(lower.coins, greaterThan(0), reason: lower.id);
        }
      }
    });

    test('a harder tier never pays fewer coins than an easier one', () {
      for (final metric in AchievementMetric.values) {
        final paying = tiersOf(metric).where((a) => a.coins > 0).toList();
        for (var i = 1; i < paying.length; i++) {
          expect(paying[i].coins, greaterThanOrEqualTo(paying[i - 1].coins),
              reason: paying[i].id);
        }
      }
    });

    test('every reward skin is animated and earned only by its achievement',
        () {
      for (final a in Achievements.catalog.where((a) => a.skinId != null)) {
        final skin = kSkinCatalog.singleWhere((s) => s.id == a.skinId);
        expect(skin.achievementId, a.id);
        expect(skin.style.isAnimated, isTrue, reason: skin.id);
      }
    });

    test('every achievement skin is the reward of exactly one achievement; '
        'the animated shop skins belong to none', () {
      for (final skin in kSkinCatalog.where((s) => s.style.isAnimated)) {
        final rewards = Achievements.catalog.where((a) => a.skinId == skin.id);
        if (skin.achievementId == null) {
          expect(rewards, isEmpty, reason: skin.id);
          expect(skin.isPurchasable, isTrue, reason: skin.id);
        } else {
          expect(rewards, hasLength(1), reason: skin.id);
        }
      }
    });

    test('rewardsFor adds up coins and collects skins', () {
      final r = Achievements.rewardsFor([
        Achievements.byId('first_game'),
        Achievements.byId('score_1k'),
        Achievements.byId('games_100'),
      ]);
      expect(
        r.coins,
        Achievements.byId('first_game').coins +
            Achievements.byId('score_1k').coins,
      );
      expect(r.skinIds, [Achievements.byId('games_100').skinId]);
    });

    test('nothing earned pays nothing', () {
      final r = Achievements.rewardsFor(const []);
      expect(r.coins, 0);
      expect(r.skinIds, isEmpty);
    });
  });
}
