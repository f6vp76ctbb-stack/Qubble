/// Analytics abstraction. The Firebase backend is wired once the config files
/// (`google-services.json` / `GoogleService-Info.plist`) are added by the
/// human (see docs/SETUP-ACCOUNTS.md); until then [NoopAnalytics] is used and
/// [DebugAnalytics] prints the funnel so it can be verified locally.
library;

import 'package:flutter/foundation.dart';

/// Canonical event names for the acquisition/retention funnel.
class AnalyticsEvent {
  const AnalyticsEvent._();

  static const gameStart = 'game_start';
  static const roundComplete = 'round_complete';
  static const reachRound3 = 'reach_round_3';
  static const dailyPlayed = 'daily_played';
  /// A rewarded placement was put in front of the player.
  ///
  /// Without this and [rewardedAccepted] the funnel had no denominator: only
  /// redeemed rewards were logged, so the opt-in rate — the number the whole
  /// ad revenue hangs on — could not be derived at all.
  static const rewardedOffered = 'rewarded_offered';

  /// The player tapped a rewarded placement. Fires before the ad is requested,
  /// so a failure to load is visible as accepted-without-watched.
  static const rewardedAccepted = 'rewarded_accepted';

  static const rewardedWatched = 'rewarded_watched';
  static const purchase = 'purchase';
  static const themeUnlocked = 'theme_unlocked';
}

/// Converts an ad SDK's micros to whole currency units.
///
/// Named rather than inlined because it is the one arithmetic step here that
/// can be wrong without anything failing: a factor of a thousand either way
/// simply makes every revenue figure wrong on every dashboard, consistently,
/// with no error to notice.
double currencyFromMicros(double micros) => micros / 1000000;

abstract class Analytics {
  void logEvent(String name, [Map<String, Object?> params]);

  /// Reports the revenue of one ad impression, as the ad SDK measured it.
  ///
  /// [valueMicros] is millionths of one [currency] unit. Reporting this is
  /// what turns ad revenue from a number on a dashboard into something
  /// segmentable — per country, per placement, per cohort — which is the only
  /// way to find out what a rewarded impression is actually worth here rather
  /// than what a published benchmark says it is worth on average.
  void logAdImpression({
    required double valueMicros,
    required String currency,
    required String adFormat,
    String? adSource,
    String? adUnitName,
  });
}

class NoopAnalytics implements Analytics {
  @override
  void logEvent(String name, [Map<String, Object?> params = const {}]) {}

  @override
  void logAdImpression({
    required double valueMicros,
    required String currency,
    required String adFormat,
    String? adSource,
    String? adUnitName,
  }) {}
}

class DebugAnalytics implements Analytics {
  @override
  void logEvent(String name, [Map<String, Object?> params = const {}]) {
    debugPrint('[analytics] $name $params');
  }

  @override
  void logAdImpression({
    required double valueMicros,
    required String currency,
    required String adFormat,
    String? adSource,
    String? adUnitName,
  }) {
    debugPrint('[analytics] ad_impression $adFormat '
        '${currencyFromMicros(valueMicros)} $currency source=$adSource');
  }
}
