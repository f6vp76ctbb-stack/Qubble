/// Analytics abstraction. The Firebase backend is wired once the config files
/// (`google-services.json` / `GoogleService-Info.plist`) are added by the
/// human (see docs/SETUP-ACCOUNTS.md); until then [NoopAnalytics] is used and
/// [DebugAnalytics] prints the funnel so it can be verified locally.
library;

import 'package:flutter/foundation.dart';

/// Canonical event names for the acquisition/retention funnel.
class AnalyticsEvent {
  const AnalyticsEvent._();

  /// The rules screen was put in front of a player who did not ask for it.
  /// Paired with [rulesDismissed] this shows whether the screen is read or
  /// tapped away — the question that decides where it belongs in the flow.
  static const rulesShown = 'rules_shown';
  static const rulesDismissed = 'rules_dismissed';

  /// A step of the in-run coach was completed. Step 0 is the player's first
  /// placement ever, which is the FTUE measure: how many of the people who
  /// open the app ever put down a block.
  static const onboardingStep = 'onboarding_step';

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

  /// The player tapped a rewarded placement. Fires before the ad is requested
  /// AND before the availability check, so a failure to load is visible as
  /// accepted-without-watched.
  ///
  /// Carries `ad_available`, which separates the two reasons a reward never
  /// arrives: the player closed the video, or there was no video to close.
  /// Without that split a market with no fill reads exactly like an audience
  /// that does not want the offers, and the two call for opposite responses.
  static const rewardedAccepted = 'rewarded_accepted';

  static const rewardedWatched = 'rewarded_watched';
  static const purchase = 'purchase';
  static const themeUnlocked = 'theme_unlocked';
}

/// Durable properties used to segment cohorts. Firebase allows 25 per project
/// and 36 characters per value.
class AnalyticsProperty {
  const AnalyticsProperty._();

  /// `new` / `casual` / `regular` / `veteran`, by lifetime runs.
  static const playerTier = 'player_tier';

  /// Whether this player has ever bought anything.
  static const hasPurchased = 'has_purchased';

  /// Whether reminders are switched on — the question being whether the
  /// opt-in prompt on the second launch earns its interruption.
  static const notificationsOn = 'notifications_on';

  /// Whether the player entered the leaderboard, the app's only social hook.
  static const leaderboardOptIn = 'leaderboard_optin';

  /// Buckets lifetime runs into the tiers above.
  static String tierForGames(int games) {
    if (games < 5) return 'new';
    if (games < 25) return 'casual';
    if (games < 100) return 'regular';
    return 'veteran';
  }
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

  /// Sets a durable property used to segment cohorts.
  ///
  /// Retention is already cohorted by install date; what was missing is any
  /// way to ask *which* players stay — whether the notification opt-in earns
  /// its interruption, whether entering the leaderboard changes anything.
  ///
  /// Deliberately not an identifier: no display name, no leaderboard uid. The
  /// privacy policy promises the leaderboard name is never sent as an
  /// analytics parameter, and keeping the two apart is the point.
  void setUserProperty(String name, String? value);

  /// Passes the player's advertising-consent decision on to the analytics
  /// backend.
  ///
  /// The UMP flow and Firebase Analytics used to run past each other: consent
  /// was collected before the first ad request, and analytics started before
  /// any consent state existed, with nothing connecting the two. The privacy
  /// policy already tells the player their choice governs the ad data, so this
  /// is the code catching up with what is published.
  ///
  /// Only the two ad-related signals are passed. Analytics storage itself is
  /// not gated on the ad consent — it is a separate purpose with its own
  /// disclosure, and conflating them would silently change what the app
  /// measures based on an answer to a different question.
  void setAdConsent({required bool granted});
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

  @override
  void setUserProperty(String name, String? value) {}

  @override
  void setAdConsent({required bool granted}) {}
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

  @override
  void setUserProperty(String name, String? value) {
    debugPrint('[analytics] property $name=$value');
  }

  @override
  void setAdConsent({required bool granted}) {
    debugPrint('[analytics] ad consent granted=$granted');
  }
}
