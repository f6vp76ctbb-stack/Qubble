/// Ad service abstraction over `google_mobile_ads`.
///
/// Qubble shows NO forced ads (no interstitials, no banners) — the only ad
/// format is the voluntary rewarded video, always opt-in and always paying out.
/// [FakeAdService] keeps tests and headless contexts ad-free (and always grants
/// rewards). [GoogleAdService] drives real AdMob rewarded ads and runs the UMP
/// consent flow before the first request.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/analytics.dart';
import 'ad_config.dart';

abstract class AdService {
  /// Runs consent + SDK init and preloads the first ads.
  Future<void> initialize();

  /// Shows a rewarded ad. Returns true if the reward was earned.
  Future<bool> showRewarded();

  /// Re-opens Google's privacy choices when the consent platform requires an
  /// in-app entry point. Returns false when no form is required or it fails.
  Future<bool> showPrivacyOptions() async => false;
}

/// No-op implementation for tests/dev. Rewards are always granted.
class FakeAdService implements AdService {
  @override
  Future<void> initialize() async {}

  @override
  Future<bool> showRewarded() async => true;

  @override
  Future<bool> showPrivacyOptions() async => false;
}

class GoogleAdService implements AdService {
  /// [_analytics] is optional so a caller that does not care about revenue
  /// reporting can still construct the service. Positional because a named
  /// parameter cannot bind a private field.
  GoogleAdService([this._analytics]);

  final Analytics? _analytics;

  /// Longest a rewarded ad is allowed to leave the caller waiting. Generous:
  /// a real rewarded video plus its end card runs well under this.
  static const Duration rewardTimeout = Duration(seconds: 120);

  RewardedAd? _rewarded;
  bool _initialized = false;
  bool _canRequestAds = false;
  bool _rewardedLoading = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    _canRequestAds = await _requestConsent();
    _publishConsent();
    await MobileAds.instance.initialize();
    if (_canRequestAds) _loadRewarded();
  }

  /// Hands the UMP outcome to the analytics backend.
  ///
  /// The two used to run past each other: consent was resolved here before the
  /// first ad request, analytics started earlier in main() with no consent
  /// state at all, and nothing joined them. The privacy policy already tells
  /// the player their choice governs the ad data.
  void _publishConsent() {
    _analytics?.setAdConsent(granted: _canRequestAds);
  }

  /// UMP (GDPR) consent must complete before the first ad request.
  Future<bool> _requestConsent() {
    final completer = Completer<bool>();

    Future<void> completeFromStatus() async {
      var allowed = false;
      try {
        allowed = await ConsentInformation.instance.canRequestAds();
      } catch (_) {
        // A failed/unknown consent state must never trigger an ad request.
      }
      if (!completer.isCompleted) completer.complete(allowed);
    }

    final params = ConsentRequestParameters();
    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        try {
          await ConsentForm.loadAndShowConsentFormIfRequired((_) {});
        } finally {
          await completeFromStatus();
        }
      },
      (error) {
        // UMP may still allow ads from a valid decision cached last session.
        unawaited(completeFromStatus());
      },
    );
    return completer.future;
  }

  @override
  Future<bool> showPrivacyOptions() async {
    try {
      final status = await ConsentInformation.instance
          .getPrivacyOptionsRequirementStatus();
      if (status != PrivacyOptionsRequirementStatus.required) return false;

      FormError? formError;
      await ConsentForm.showPrivacyOptionsForm((error) {
        formError = error;
      });
      _canRequestAds = await ConsentInformation.instance.canRequestAds();
      // A withdrawal here is the one case that matters most: the player has
      // gone looking for the setting in order to change it.
      _publishConsent();
      if (!_canRequestAds) {
        _rewarded?.dispose();
        _rewarded = null;
      } else {
        _loadRewarded();
      }
      return formError == null;
    } catch (error) {
      debugPrint('Privacy options failed to open: $error');
      return false;
    }
  }

  void _loadRewarded() {
    if (!_canRequestAds || _rewarded != null || _rewardedLoading) return;
    _rewardedLoading = true;
    RewardedAd.load(
      adUnitId: AdConfig.rewardedUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedLoading = false;
          _rewarded = ad;
          // The SDK reports what this impression actually paid. Without it
          // there is no ARPDAU, no eCPM per country, and no way to price the
          // rewarded-only model against anything but a published average.
          ad.onPaidEvent = (ad, valueMicros, precision, currencyCode) {
            _analytics?.logAdImpression(
              valueMicros: valueMicros,
              currency: currencyCode,
              adFormat: 'rewarded',
              adUnitName: AdConfig.rewardedUnitId,
              adSource: ad.responseInfo?.mediationAdapterClassName,
            );
          };
        },
        onAdFailedToLoad: (error) {
          _rewardedLoading = false;
          _rewarded = null;
          debugPrint('Rewarded failed to load: $error');
        },
      ),
    );
  }

  @override
  Future<bool> showRewarded() async {
    if (!_initialized) await initialize();
    if (!_canRequestAds) {
      _canRequestAds = await _requestConsent();
      _publishConsent();
      if (!_canRequestAds) return false;
      _loadRewarded();
      return false;
    }
    final ad = _rewarded;
    if (ad == null) {
      _loadRewarded();
      return false;
    }
    var earned = false;
    final completer = Completer<bool>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewarded = null;
        _loadRewarded();
        if (!completer.isCompleted) completer.complete(earned);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewarded = null;
        _loadRewarded();
        if (!completer.isCompleted) completer.complete(false);
      },
    );
    await ad.show(onUserEarnedReward: (ad, reward) => earned = true);
    // Without a bound this waits forever if neither callback ever fires — a
    // known outcome when the process is interrupted while the ad is on
    // screen. The caller has no timeout of its own, so the button it came
    // from would stay stuck for the rest of the session.
    return completer.future.timeout(
      rewardTimeout,
      onTimeout: () {
        debugPrint('Rewarded ad never reported a result; giving up.');
        _rewarded = null;
        _loadRewarded();
        return earned;
      },
    );
  }
}
