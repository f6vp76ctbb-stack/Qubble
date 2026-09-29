import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/daily_rewards.dart';

void main() {
  group('the daily goal', () {
    test('one star at 1,500, two at 3,000, three at 5,000', () {
      expect(DailyGoal.starsFor(0), 0);
      expect(DailyGoal.starsFor(1499), 0);
      expect(DailyGoal.starsFor(1500), 1);
      expect(DailyGoal.starsFor(2999), 1);
      expect(DailyGoal.starsFor(3000), 2);
      expect(DailyGoal.starsFor(5000), 3);
      expect(DailyGoal.starsFor(99999), 3);
    });

    test('each star pays coins', () {
      expect(DailyGoal.coinsFor(0), 0);
      expect(DailyGoal.coinsFor(3), 3 * DailyGoal.coinsPerStar);
    });
  });

  group('streak chests', () {
    test('open on days 3, 7, 14 and 30, and every 30 days after', () {
      final paid = {
        for (var d = 1; d <= 120; d++)
          if (StreakChest.diamondsFor(d) > 0) d: StreakChest.diamondsFor(d),
      };
      expect(paid, {3: 5, 7: 15, 14: 30, 30: 60, 60: 60, 90: 60, 120: 60});
    });

    test('the next chest is always ahead', () {
      expect(StreakChest.next(0), (day: 3, diamonds: 5));
      expect(StreakChest.next(3), (day: 7, diamonds: 15));
      expect(StreakChest.next(13), (day: 14, diamonds: 30));
      expect(StreakChest.next(29), (day: 30, diamonds: 60));
      expect(StreakChest.next(30), (day: 60, diamonds: 60));
      expect(StreakChest.next(61), (day: 90, diamonds: 60));
      for (var s = 0; s < 200; s++) {
        final n = StreakChest.next(s);
        expect(n.day, greaterThan(s));
        expect(StreakChest.diamondsFor(n.day), n.diamonds, reason: 'day $s');
      }
    });
  });
}
