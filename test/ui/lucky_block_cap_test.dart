import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

/// Grants every reward and counts how many were requested.
class CountingAds implements AdService {
  @override
  bool get rewardedReady => true;

  int shown = 0;

  @override
  Future<void> initialize() async {}
  @override
  Future<bool> showRewarded() async {
    shown += 1;
    return true;
  }

  @override
  Future<bool> showPrivacyOptions() async => false;
}

Future<(GameController, CountingAds, RecordingAnalytics)> _controller() async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  final ads = CountingAds();
  final analytics = RecordingAnalytics();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      adServiceProvider.overrideWithValue(ads),
      analyticsProvider.overrideWithValue(analytics),
    ],
  );
  addTearDown(container.dispose);
  return (container.read(gameControllerProvider.notifier), ads, analytics);
}

void main() {
  group('lucky block', () {
    test('grants exactly three per run and then stops', () async {
      final (c, ads, _) = await _controller();
      c.newGame();

      for (var i = 0; i < GameController.luckyBlocksPerRun; i++) {
        expect(await c.luckyBlock(), isTrue, reason: 'reroll ${i + 1}');
      }
      expect(ads.shown, GameController.luckyBlocksPerRun);

      // The fourth is refused, and no fourth video is requested — an
      // unbounded supply turns a leaderboard score into a test of patience.
      expect(await c.luckyBlock(), isFalse);
      expect(ads.shown, GameController.luckyBlocksPerRun);
    });

    test('the remaining count is visible to the UI', () async {
      final (c, _, _) = await _controller();
      c.newGame();
      expect(c.state.luckyBlocksLeft, GameController.luckyBlocksPerRun);

      await c.luckyBlock();
      expect(c.state.luckyBlocksLeft, GameController.luckyBlocksPerRun - 1);

      await c.luckyBlock();
      await c.luckyBlock();
      expect(c.state.luckyBlocksLeft, 0,
          reason: 'at zero the offer is hidden rather than shown and refused');
    });

    test('a new run restores the allowance', () async {
      final (c, _, _) = await _controller();
      c.newGame();
      for (var i = 0; i < GameController.luckyBlocksPerRun; i++) {
        await c.luckyBlock();
      }
      expect(await c.luckyBlock(), isFalse);

      c.newGame();
      expect(c.state.luckyBlocksLeft, GameController.luckyBlocksPerRun);
      expect(await c.luckyBlock(), isTrue);
    });

    test('a refusal past the cap reports nothing to the funnel', () async {
      // The guard sits before _runRewarded, so a refused offer must not
      // appear as an accepted one.
      final (c, _, analytics) = await _controller();
      c.newGame();
      for (var i = 0; i < GameController.luckyBlocksPerRun; i++) {
        await c.luckyBlock();
      }
      final acceptedBefore =
          analytics.of(AnalyticsEvent.rewardedAccepted).length;

      await c.luckyBlock();

      expect(analytics.of(AnalyticsEvent.rewardedAccepted), 
          hasLength(acceptedBefore));
    });

    test('the daily challenge offers none at all', () async {
      final (c, ads, _) = await _controller();
      c.startDaily();
      expect(await c.luckyBlock(), isFalse);
      expect(ads.shown, 0);
    });
  });
}
