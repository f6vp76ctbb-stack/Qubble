// The shop's reward videos (owner, 30.09.2026): voluntary, three a day for
// gold and three for diamonds; a video that is not watched to the end pays
// nothing and uses nothing up.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/free_rewards.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

class _Ads extends FakeAdService {
  bool finish = true;
  final shown = <AdPlacement>[];

  @override
  Future<bool> showRewarded(AdPlacement placement) async {
    shown.add(placement);
    return finish;
  }
}

void main() {
  var now = DateTime(2026, 10, 3, 15);

  Future<(GameController, Storage, _Ads, RecordingAnalytics)> make() async {
    SharedPreferences.setMockInitialValues({'coins': 0, 'diamonds': 0});
    final storage = await Storage.create();
    final ads = _Ads();
    final analytics = RecordingAnalytics();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      ads,
      analytics,
      calendar: () => now,
    );
    return (c, storage, ads, analytics);
  }

  setUp(() => now = DateTime(2026, 10, 3, 15));

  test('three videos for gold, each paying 100, then none', () async {
    final (c, storage, ads, _) = await make();
    for (var i = 0; i < 3; i++) {
      expect(await c.watchFreeReward(FreeReward.coins), isTrue);
    }
    expect(storage.coins, 300);
    expect(c.freeRewardsLeft(FreeReward.coins), 0);
    expect(await c.watchFreeReward(FreeReward.coins), isFalse);
    expect(ads.shown, hasLength(3), reason: 'no fourth video is even shown');
    expect(storage.coins, 300);
  });

  test('diamonds are counted apart from gold', () async {
    final (c, storage, ads, _) = await make();
    for (var i = 0; i < 3; i++) {
      await c.watchFreeReward(FreeReward.coins);
    }
    expect(c.freeRewardsLeft(FreeReward.diamonds), 3);
    expect(await c.watchFreeReward(FreeReward.diamonds), isTrue);
    expect(storage.diamonds, 3);
    expect(ads.shown.last, AdPlacement.freeDiamonds);
  });

  test('a video closed early pays nothing and uses nothing up', () async {
    final (c, storage, ads, _) = await make();
    ads.finish = false;
    expect(await c.watchFreeReward(FreeReward.diamonds), isFalse);
    expect(storage.diamonds, 0);
    expect(c.freeRewardsLeft(FreeReward.diamonds), 3);
  });

  test('a new day opens three more', () async {
    final (c, _, _, _) = await make();
    for (var i = 0; i < 3; i++) {
      await c.watchFreeReward(FreeReward.coins);
    }
    now = DateTime(2026, 10, 4, 0, 1);
    expect(c.freeRewardsLeft(FreeReward.coins), 3);
    expect(await c.watchFreeReward(FreeReward.coins), isTrue);
    expect(c.freeRewardsLeft(FreeReward.coins), 2);
  });

  test('reported through the same funnel as the other offers', () async {
    final (c, _, _, analytics) = await make();
    c.noteRewardedOffered(AdPlacement.freeCoins);
    await c.watchFreeReward(FreeReward.coins);
    final events = analytics.events
        .where((e) => e.$2['placement'] == 'free_coins')
        .map((e) => e.$1)
        .toList();
    expect(
      events,
      containsAll([
        'rewarded_offered',
        'rewarded_accepted',
        'rewarded_watched',
      ]),
    );
  });
}
