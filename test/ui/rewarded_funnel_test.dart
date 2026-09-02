import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

class ScriptedAds implements AdService {
  @override
  bool get rewardedReady => true;

  ScriptedAds({required this.grants});
  final bool grants;

  @override
  Future<void> initialize() async {}
  @override
  Future<bool> showRewarded() async => grants;
  @override
  Future<bool> showPrivacyOptions() async => false;
}

Future<(GameController, RecordingAnalytics)> _controller({
  required bool adGrants,
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final analytics = RecordingAnalytics();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      analyticsProvider.overrideWithValue(analytics),
      adServiceProvider.overrideWithValue(ScriptedAds(grants: adGrants)),
    ],
  );
  addTearDown(container.dispose);
  return (container.read(gameControllerProvider.notifier), analytics);
}

void main() {
  group('rewarded funnel', () {
    test('a taken offer reports accepted and watched with earned true',
        () async {
      final (c, analytics) = await _controller(adGrants: true);

      // The piggy placement has no precondition beyond the ad itself, so this
      // exercises the funnel and nothing else.
      await c.openPiggyWithAd();

      expect(analytics.of(AnalyticsEvent.rewardedAccepted).single['placement'],
          'piggy');
      final watched = analytics.of(AnalyticsEvent.rewardedWatched).single;
      expect(watched['placement'], 'piggy');
      expect(watched['earned'], isTrue);
    });

    test('a refused offer still reports accepted, and watched with earned false',
        () async {
      // This is the whole point: without the accepted event, a player who taps
      // and gets no ad is indistinguishable from one who never tapped, so the
      // opt-in rate cannot be computed.
      final (c, analytics) = await _controller(adGrants: false);

      expect(await c.openPiggyWithAd(), isNull);

      expect(analytics.of(AnalyticsEvent.rewardedAccepted), hasLength(1));
      final watched = analytics.of(AnalyticsEvent.rewardedWatched).single;
      expect(watched['placement'], 'piggy');
      expect(watched['earned'], isFalse);
    });

    test('a placement blocked before the ad reports nothing at all', () async {
      // doubleCoinsWithAd returns early when the run earned no coins. No ad
      // was requested, so nothing may appear in the funnel.
      final (c, analytics) = await _controller(adGrants: true);

      expect(await c.doubleCoinsWithAd(), isFalse);

      expect(analytics.of(AnalyticsEvent.rewardedAccepted), isEmpty);
      expect(analytics.of(AnalyticsEvent.rewardedWatched), isEmpty);
    });

    test('an offer is reported once per run, however often it is drawn',
        () async {
      final (c, analytics) = await _controller(adGrants: true);

      c.noteRewardedOffered('double');
      c.noteRewardedOffered('double');
      c.noteRewardedOffered('double');

      expect(analytics.of(AnalyticsEvent.rewardedOffered), hasLength(1),
          reason: 'a rebuild must not inflate the denominator');
    });

    test('a different placement is reported separately', () async {
      final (c, analytics) = await _controller(adGrants: true);

      c.noteRewardedOffered('double');
      c.noteRewardedOffered('lucky');

      expect(
        analytics
            .of(AnalyticsEvent.rewardedOffered)
            .map((p) => p['placement']),
        ['double', 'lucky'],
      );
    });

    test('every placement name is one of the five known ones', () async {
      // Guards against a sixth placement appearing with a typo'd name, which
      // would silently split the funnel.
      const known = {
        'double',
        'lucky',
        'piggy',
        'streak_repair',
        'puzzle_extra_move',
      };
      final (c, analytics) = await _controller(adGrants: true);
      c
        ..noteRewardedOffered('double')
        ..noteRewardedOffered('lucky')
        ..noteRewardedOffered('piggy');

      for (final params in analytics.of(AnalyticsEvent.rewardedOffered)) {
        expect(known, contains(params['placement']));
      }
    });
  });
}
