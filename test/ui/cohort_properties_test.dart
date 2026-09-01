import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

Future<(GameController, RecordingAnalytics)> _controller(
  Map<String, Object> prefs,
) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final analytics = RecordingAnalytics();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      analyticsProvider.overrideWithValue(analytics),
    ],
  );
  addTearDown(container.dispose);
  return (container.read(gameControllerProvider.notifier), analytics);
}

void main() {
  group('player tier', () {
    test('buckets lifetime runs', () {
      expect(AnalyticsProperty.tierForGames(0), 'new');
      expect(AnalyticsProperty.tierForGames(4), 'new');
      expect(AnalyticsProperty.tierForGames(5), 'casual');
      expect(AnalyticsProperty.tierForGames(24), 'casual');
      expect(AnalyticsProperty.tierForGames(25), 'regular');
      expect(AnalyticsProperty.tierForGames(99), 'regular');
      expect(AnalyticsProperty.tierForGames(100), 'veteran');
      expect(AnalyticsProperty.tierForGames(5000), 'veteran');
    });

    test('every tier fits the 36-character limit Firebase imposes', () {
      for (final games in [0, 5, 25, 100]) {
        expect(AnalyticsProperty.tierForGames(games).length,
            lessThanOrEqualTo(36));
      }
    });
  });

  group('cohort properties', () {
    test('a fresh install reports the starting state', () async {
      final (c, analytics) = await _controller({});
      c.refreshCohortProperties();

      expect(analytics.properties, {
        AnalyticsProperty.playerTier: 'new',
        AnalyticsProperty.hasPurchased: 'false',
        AnalyticsProperty.notificationsOn: 'false',
        AnalyticsProperty.leaderboardOptIn: 'false',
      });
    });

    test('an established, paying, opted-in player reports as one', () async {
      final (c, analytics) = await _controller({
        'lifetimeStats': '{"games": 140}',
        'supporter': true,
        'settings.notifications': true,
        'playerName': 'Anna',
      });
      c.refreshCohortProperties();

      expect(analytics.properties[AnalyticsProperty.playerTier], 'veteran');
      expect(analytics.properties[AnalyticsProperty.hasPurchased], 'true');
      expect(analytics.properties[AnalyticsProperty.notificationsOn], 'true');
      expect(analytics.properties[AnalyticsProperty.leaderboardOptIn], 'true');
    });

    test('the starter pack counts as a purchase too', () async {
      final (c, analytics) = await _controller({'starterPurchased': true});
      c.refreshCohortProperties();
      expect(analytics.properties[AnalyticsProperty.hasPurchased], 'true');
    });

    test('no property carries an identifier', () async {
      // The privacy policy promises the leaderboard name is never sent as an
      // analytics parameter. leaderboard_optin is a yes/no, not the name.
      final (c, analytics) = await _controller({
        'playerName': 'Anna',
        'fbUid': 'uid-abc',
      });
      c.refreshCohortProperties();

      for (final value in analytics.properties.values) {
        expect(value, isNot(contains('Anna')));
        expect(value, isNot(contains('uid-abc')));
      }
    });

    test('there are no more properties than the four intended', () async {
      // Firebase allows 25 per project; this guards against the set growing
      // by accident rather than by decision.
      final (c, analytics) = await _controller({});
      c.refreshCohortProperties();
      expect(analytics.properties, hasLength(4));
    });
  });
}
