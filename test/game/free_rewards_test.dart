import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/free_rewards.dart';

void main() {
  final now = DateTime(2026, 10, 3, 15);

  test('three a day, 100 gold or 3 diamonds each (owner, 30.09.2026)', () {
    expect(FreeRewards.perDay, 3);
    expect(FreeRewards.amount(FreeReward.coins), 100);
    expect(FreeRewards.amount(FreeReward.diamonds), 3);
  });

  test('left: counts down through the day and starts over the next', () {
    expect(FreeRewards.left(day: null, used: 0, now: now), 3);
    expect(FreeRewards.left(day: '2026-10-03', used: 1, now: now), 2);
    expect(FreeRewards.left(day: '2026-10-03', used: 3, now: now), 0);
    expect(FreeRewards.left(day: '2026-10-03', used: 7, now: now), 0);
    expect(FreeRewards.left(day: '2026-10-02', used: 3, now: now), 3);
  });
}
