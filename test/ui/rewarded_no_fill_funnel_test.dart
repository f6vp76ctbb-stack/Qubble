// The rewarded funnel exists to answer one question: how often do players
// accept a voluntary offer? A tap that finds no ad is still an acceptance, and
// counting it as nothing makes "nobody wants these" look identical to "there
// was nothing to show them" — which call for opposite responses.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _NoFillAds implements AdService {
  int shown = 0;

  @override
  bool get rewardedReady => false;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> showRewarded() async {
    shown++;
    return true;
  }

  @override
  Future<bool> showPrivacyOptions() async => false;
}

class _RecordingAnalytics implements Analytics {
  final events = <(String, Map<String, Object?>)>[];

  @override
  void logEvent(String name, [Map<String, Object?>? params]) =>
      events.add((name, params ?? const {}));

  @override
  noSuchMethod(Invocation invocation) => null;
}

void main() {
  testWidgets('a tap with no fill is recorded as accepted, not lost', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'coins': 5000});
    final storage = await Storage.create();
    final ads = _NoFillAds();
    final analytics = _RecordingAnalytics();

    final container = ProviderContainer(
      overrides: [
        storageProvider.overrideWithValue(storage),
        adServiceProvider.overrideWithValue(ads),
        analyticsProvider.overrideWithValue(analytics),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(gameControllerProvider.notifier);
    final earned = await controller.luckyBlock();

    expect(earned, isFalse);
    expect(ads.shown, 0, reason: 'no ad exists, so none is requested');

    final accepted = analytics.events
        .where((e) => e.$1 == AnalyticsEvent.rewardedAccepted)
        .toList();
    expect(accepted, hasLength(1), reason: 'the acceptance must be recorded');
    expect(accepted.single.$2['ad_available'], isFalse);

    // No watched event: nothing was watched. That asymmetry is the signal —
    // accepted-without-watched is what makes a fill problem visible.
    expect(
      analytics.events.where((e) => e.$1 == AnalyticsEvent.rewardedWatched),
      isEmpty,
    );
  });

  testWidgets('a normal run reports the whole funnel', (tester) async {
    SharedPreferences.setMockInitialValues({'coins': 5000});
    final storage = await Storage.create();
    final analytics = _RecordingAnalytics();

    final container = ProviderContainer(
      overrides: [
        storageProvider.overrideWithValue(storage),
        adServiceProvider.overrideWithValue(FakeAdService()),
        analyticsProvider.overrideWithValue(analytics),
      ],
    );
    addTearDown(container.dispose);

    await container.read(gameControllerProvider.notifier).luckyBlock();

    final accepted = analytics.events
        .where((e) => e.$1 == AnalyticsEvent.rewardedAccepted)
        .toList();
    expect(accepted.single.$2['ad_available'], isTrue);
    expect(
      analytics.events.where((e) => e.$1 == AnalyticsEvent.rewardedWatched),
      hasLength(1),
    );
  });
}
