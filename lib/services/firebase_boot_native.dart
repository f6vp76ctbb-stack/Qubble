/// Native (Android/iOS) Firebase bootstrap: Crashlytics + Analytics.
///
/// Options are built from [FirebaseConfig] instead of `flutterfire configure`
/// output, so the git-ignored google-services.json is only needed by the
/// Android Gradle build itself.
library;

import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'analytics.dart';
import 'firebase_config.dart';

/// Initializes Firebase and returns the analytics backend, or null when this
/// platform has no Firebase app (or init failed) — the game runs fine without.
///
/// Crash reporting is wired for every platform where the init succeeds. It used
/// to bail out on `!Platform.isAndroid`, which left iOS with no Crashlytics and
/// no error handlers at all — an iOS crash produced nothing to look at.
Future<Analytics?> initFirebase() async {
  final appId = _appIdForPlatform();
  if (appId == null) return null;
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: FirebaseConfig.apiKey,
        appId: appId,
        messagingSenderId: FirebaseConfig.messagingSenderId,
        projectId: FirebaseConfig.projectId,
        storageBucket: FirebaseConfig.storageBucket,
      ),
    );
    _installCrashHandlers();
    return FirebaseAnalyticsBackend(FirebaseAnalytics.instance);
  } catch (e) {
    // Never block the game on analytics infrastructure.
    debugPrint('Firebase init failed, running without: $e');
    return null;
  }
}

/// The Firebase app id for the running platform, or null where no app is
/// registered yet (the iOS app is created with the App-Store phase; until then
/// its placeholder must not be handed to Firebase).
String? _appIdForPlatform() {
  if (Platform.isAndroid) return FirebaseConfig.androidAppId;
  if (Platform.isIOS) {
    final id = FirebaseConfig.iosAppId;
    if (id.startsWith('REPLACE_ME')) {
      debugPrint(
        'Firebase: no iOS app registered yet — crash reporting is OFF on iOS. '
        'Register the app in the Firebase console and set '
        'FirebaseConfig.iosAppId (see docs/SETUP-ACCOUNTS.md).',
      );
      return null;
    }
    return id;
  }
  return null;
}

/// Routes uncaught Flutter and platform errors to Crashlytics.
void _installCrashHandlers() {
  final previousOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    previousOnError?.call(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

/// Sends the funnel events to Firebase Analytics (fire-and-forget).
class FirebaseAnalyticsBackend implements Analytics {
  FirebaseAnalyticsBackend(this._analytics);

  final FirebaseAnalytics _analytics;

  @override
  void logEvent(String name, [Map<String, Object?> params = const {}]) {
    // Firebase only accepts String/num parameter values.
    final cleaned = <String, Object>{
      for (final e in params.entries)
        if (e.value != null)
          e.key: (e.value is String || e.value is num)
              ? e.value!
              : e.value.toString(),
    };
    unawaited(_analytics.logEvent(
      name: name,
      parameters: cleaned.isEmpty ? null : cleaned,
    ));
  }

  @override
  void logAdImpression({
    required double valueMicros,
    required String currency,
    required String adFormat,
    String? adSource,
    String? adUnitName,
  }) {
    unawaited(_analytics.logAdImpression(
      adPlatform: 'AdMob',
      adSource: adSource,
      adFormat: adFormat,
      adUnitName: adUnitName,
      // logAdImpression takes the value in the currency's own unit, while the
      // ad SDK reports micros.
      value: currencyFromMicros(valueMicros),
      currency: currency,
    ));
  }
}
