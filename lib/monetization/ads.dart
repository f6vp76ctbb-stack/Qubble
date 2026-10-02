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

export 'ad_config.dart' show AdPlacement;

abstract class AdService {
  /// Runs consent + SDK init and preloads the first ads.
  Future<void> initialize();

  /// Starts loading the video for [placement] while its offer is on screen,
  /// so the tap can use that offer's own unit. Idempotent.
  void prepare(AdPlacement placement);

  /// Shows a rewarded ad for [placement]. Returns true if the reward was
  /// earned.
  Future<bool> showRewarded(AdPlacement placement);

  /// Whether a rewarded ad could actually be shown for [placement] right now —
  /// consent given and an ad loaded.
  ///
  /// Without this the UI cannot tell "no video was available" apart from "the
  /// player closed the video early", and every voluntary offer degraded into a
  /// button that silently did nothing whenever there was no fill.
  bool rewardedReadyFor(AdPlacement placement);

  /// Re-opens Google's privacy choices when the consent platform requires an
  /// in-app entry point. Returns false when no form is required or it fails.
  Future<bool> showPrivacyOptions() async => false;
}

/// No-op implementation for tests/dev. Rewards are always granted.
class FakeAdService implements AdService {
  @override
  Future<void> initialize() async {}

  @override
  void prepare(AdPlacement placement) {}

  @override
  bool rewardedReadyFor(AdPlacement placement) => true;

  @override
  Future<bool> showRewarded(AdPlacement placement) async => true;

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

  /// How long a loaded video is kept. Google's preloading guide has loaded
  /// ads expire after about an hour; an expired one fails to show, and the
  /// player who tapped gets "no video". The app often sits in the background
  /// for hours with a video loaded at start-up, so it is replaced in time.
  static const Duration maxAdAge = Duration(minutes: 55);

  /// Whether a video loaded at [loadedAt] can still be shown at [now].
  @visibleForTesting
  static bool isFresh(DateTime loadedAt, DateTime now) =>
      now.difference(loadedAt) < maxAdAge;

  /// The shared unit, kept loaded at all times: it serves any offer whose own
  /// video is not ready, exactly as it served every offer before the split.
  final _RewardedSlot _shared = _RewardedSlot(AdConfig.rewardedUnitId);

  /// Offers with a unit of their own, loaded while the offer is on screen.
  final Map<AdPlacement, _RewardedSlot> _own = {};

  bool _initialized = false;
  bool _canRequestAds = false;

  Iterable<_RewardedSlot> get _slots => [_shared, ..._own.values];

  @override
  bool rewardedReadyFor(AdPlacement placement) {
    if (!_canRequestAds) return false;
    final own = _own[placement];
    return (own != null && _ready(own)) | _ready(_shared);
  }

  /// Whether [slot] holds a video that can still be shown. An expired one is
  /// dropped and a fresh one requested, so the offer comes back on its own.
  bool _ready(_RewardedSlot slot) {
    if (slot.ad == null) return false;
    if (isFresh(slot.loadedAt!, DateTime.now())) return true;
    slot.clear();
    _load(slot);
    return false;
  }

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    _canRequestAds = await _requestConsent();
    _publishConsent();
    await MobileAds.instance.initialize();
    if (_canRequestAds) _load(_shared);
  }

  @override
  void prepare(AdPlacement placement) {
    if (!_initialized || !_canRequestAds) return;
    final unitId = AdConfig.rewardedUnitIdFor(placement);
    // No unit of its own yet (or a test build, where every offer shares the
    // sample unit): the shared slot already covers it.
    if (unitId == _shared.unitId) return;
    _load(_own.putIfAbsent(placement, () => _RewardedSlot(unitId)));
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
        for (final slot in _slots) {
          slot.clear();
        }
      } else {
        _load(_shared);
      }
      return formError == null;
    } catch (error) {
      debugPrint('Privacy options failed to open: $error');
      return false;
    }
  }

  void _load(_RewardedSlot slot) {
    if (!_canRequestAds || slot.loading) return;
    if (slot.ad != null) {
      if (isFresh(slot.loadedAt!, DateTime.now())) return;
      slot.clear();
    }
    slot.loading = true;
    RewardedAd.load(
      adUnitId: slot.unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          slot.loading = false;
          slot.ad = ad;
          slot.loadedAt = DateTime.now();
          // The SDK reports what this impression actually paid. Without it
          // there is no ARPDAU, no eCPM per country, and no way to price the
          // rewarded-only model against anything but a published average.
          ad.onPaidEvent = (ad, valueMicros, precision, currencyCode) {
            _analytics?.logAdImpression(
              valueMicros: valueMicros,
              currency: currencyCode,
              adFormat: 'rewarded',
              adUnitName: slot.unitId,
              adSource: ad.responseInfo?.mediationAdapterClassName,
            );
          };
        },
        onAdFailedToLoad: (error) {
          slot.loading = false;
          slot.ad = null;
          debugPrint('Rewarded (${slot.unitId}) failed to load: $error');
        },
      ),
    );
  }

  @override
  Future<bool> showRewarded(AdPlacement placement) async {
    if (!_initialized) await initialize();
    if (!_canRequestAds) {
      _canRequestAds = await _requestConsent();
      _publishConsent();
      if (!_canRequestAds) return false;
      _load(_shared);
      return false;
    }
    // The offer's own video if it is ready, else the shared one — so a unit
    // of its own can only ever add fill, never take it away. Expired videos
    // count as not ready (see [maxAdAge]).
    final own = _own[placement];
    final slot = own != null && _ready(own) ? own : _shared;
    final ad = _ready(slot) ? slot.ad : null;
    if (ad == null) {
      _load(_shared);
      prepare(placement);
      return false;
    }
    var earned = false;
    final completer = Completer<bool>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        slot.ad = null;
        _load(slot);
        if (!completer.isCompleted) completer.complete(earned);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        slot.ad = null;
        _load(slot);
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
        slot.ad = null;
        _load(slot);
        return earned;
      },
    );
  }
}

/// One AdMob unit and the video currently loaded from it.
class _RewardedSlot {
  _RewardedSlot(this.unitId);

  final String unitId;
  RewardedAd? ad;

  /// When [ad] arrived; set together with it.
  DateTime? loadedAt;
  bool loading = false;

  void clear() {
    ad?.dispose();
    ad = null;
    loadedAt = null;
  }
}
