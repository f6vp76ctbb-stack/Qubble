// The public web build (GitHub Pages) has no ad SDK. Until 16.11.2026 it ran
// FakeAdService, which answers every rewarded offer with "watched" — so on
// the web the piggy bank opened early, coins doubled and lucky blocks came
// for free, without a video (owner: "Sparschwein benutzt und sofort Münzen
// bekommen ohne Video"). CLAUDE.md: the public web build never hands out
// coins for free. Only a local debug web build keeps the fake.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

void main() {
  test('a release web build gets no rewarded videos at all', () async {
    final ads = webAdService(debug: false);
    for (final placement in AdPlacement.values) {
      expect(ads.rewardedReadyFor(placement), isFalse, reason: '$placement');
      expect(await ads.showRewarded(placement), isFalse, reason: '$placement');
    }
  });

  test('only a debug web build keeps the fake that always pays', () {
    expect(webAdService(debug: true), isA<FakeAdService>());
    expect(webAdService(debug: false), isNot(isA<FakeAdService>()));
  });

  test('without a video the piggy bank does not open early', () async {
    SharedPreferences.setMockInitialValues({
      'onboardingDone': true,
      'piggyCoins': 120,
      'piggyCapacity': 300,
      'coins': 50,
    });
    final storage = await Storage.create();
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      webAdService(debug: false),
      NoopAnalytics(),
      clock: SteppingClock().call,
    );
    expect(c.state.piggyCoins, 120);

    expect(await c.openPiggyWithAd(), isNull);
    expect(storage.coins, 50, reason: 'no coins without a video');
    expect(c.state.piggyCoins, 120, reason: 'the piggy keeps saving');
  });
}
