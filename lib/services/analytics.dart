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

abstract class Analytics {
  void logEvent(String name, [Map<String, Object?> params]);
}

class NoopAnalytics implements Analytics {
  @override
  void logEvent(String name, [Map<String, Object?> params = const {}]) {}
}

class DebugAnalytics implements Analytics {
  @override
  void logEvent(String name, [Map<String, Object?> params = const {}]) {
    debugPrint('[analytics] $name $params');
  }
}
