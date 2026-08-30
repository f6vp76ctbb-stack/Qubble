/// Store-rating service: the native in-app review card and the explicit
/// "rate this app" entry in the settings.
///
/// `in_app_review` has no web implementation, so the PWA build gets
/// [NoopReview] (see `main.dart`) — the same pattern as ads, IAP and
/// notifications.
library;

import 'package:in_app_review/in_app_review.dart';

abstract class ReviewService {
  /// Asks the platform to show its own (dismissible) rating card. The OS may
  /// silently do nothing — quota, no Play Store, sideloaded build. Returns
  /// true only if the request was actually handed to the platform, so callers
  /// can decide whether the attempt counts against the app's own budget.
  Future<bool> requestReview();

  /// Opens the store listing so the player can leave a rating deliberately.
  /// Returns false if no store listing could be opened.
  Future<bool> openStoreListing();
}

/// Default for tests, dev and the web build: records nothing, opens nothing.
class NoopReview implements ReviewService {
  const NoopReview();

  @override
  Future<bool> requestReview() async => false;

  @override
  Future<bool> openStoreListing() async => false;
}

/// Play In-App Review API on Android, `SKStoreReviewController` on iOS.
class StoreReview implements ReviewService {
  StoreReview({InAppReview? review, this.appStoreId})
    : _review = review ?? InAppReview.instance;

  final InAppReview _review;

  /// Numeric App Store ID, required by iOS to open the listing. Null until the
  /// app exists in App Store Connect; Android ignores it.
  final String? appStoreId;

  @override
  Future<bool> requestReview() async {
    try {
      if (!await _review.isAvailable()) return false;
      await _review.requestReview();
      return true;
    } catch (_) {
      // A missing Play Store, an emulator without Play services or a
      // sideloaded build must never take the game down.
      return false;
    }
  }

  @override
  Future<bool> openStoreListing() async {
    try {
      await _review.openStoreListing(appStoreId: appStoreId);
      return true;
    } catch (_) {
      return false;
    }
  }
}
