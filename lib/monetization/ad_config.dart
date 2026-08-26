/// Centralized AdMob unit IDs.
///
/// CLAUDE.md rule: debug builds must use Google's official TEST ad unit IDs
/// only. Release builds use the real IDs — fill in the `REPLACE_ME_*`
/// placeholders once the AdMob units exist (see docs/SETUP-ACCOUNTS.md).
///
/// A closed playtest is built in RELEASE mode, so `kDebugMode` alone is not
/// enough to keep testers off the production units: repeated rewarded requests
/// from a handful of known devices is exactly the pattern Google treats as
/// invalid traffic. Build those with
/// `flutter build appbundle --release --dart-define=QUBBLE_TEST_ADS=true`.
library;

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

class AdConfig {
  const AdConfig._();

  // --- Google's official sample/test unit IDs (safe to ship in debug) -------
  static const _testRewardedAndroid = 'ca-app-pub-3940256099942544/5224354917';
  static const _testRewardedIos = 'ca-app-pub-3940256099942544/1712485313';

  // --- Real production unit IDs ---------------------------------------------
  // Rewarded is the ONLY ad format in Qubble (no interstitials, no banners).
  // Android id set 2026-07 (AdMob app "Qubble"); iOS follows with the
  // App-Store phase.
  static const _prodRewardedAndroid = 'ca-app-pub-8596176219181991/4303264559';
  static const _prodRewardedIos = 'REPLACE_ME_REWARDED_IOS';

  /// Marker for a production id that has not been created in AdMob yet.
  static const String _placeholderPrefix = 'REPLACE_ME';

  /// Forces Google's test units in a release build. Set at build time with
  /// `--dart-define=QUBBLE_TEST_ADS=true` for every internal/closed test.
  static const bool forceTestAds = bool.fromEnvironment('QUBBLE_TEST_ADS');

  static bool get _isAndroid => Platform.isAndroid;

  /// Whether this build must not touch production ad units.
  static bool get usesTestAds => kDebugMode || forceTestAds;

  static String get rewardedUnitId => resolveRewardedUnitId(
    android: _isAndroid,
    testAds: usesTestAds,
  );

  /// Pure selection logic, split out so it is unit-testable without a platform.
  ///
  /// A production id that is still a `REPLACE_ME` placeholder falls back to the
  /// test unit: an unregistered unit id never loads, which would silently break
  /// every rewarded feature on that platform. Serving a test ad instead keeps
  /// the flow verifiable and is never counted as real traffic.
  @visibleForTesting
  static String resolveRewardedUnitId({
    required bool android,
    required bool testAds,
  }) {
    final test = android ? _testRewardedAndroid : _testRewardedIos;
    if (testAds) return test;
    final prod = android ? _prodRewardedAndroid : _prodRewardedIos;
    if (prod.startsWith(_placeholderPrefix)) {
      debugPrint('AdConfig: production rewarded unit id is still a '
          'placeholder ($prod) — falling back to the test unit.');
      return test;
    }
    return prod;
  }
}
