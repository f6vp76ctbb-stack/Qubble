import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/crash_reporter.dart';
import 'package:gridpop/services/stats_consent.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/stats_consent_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';
import '../support/recording_stats_collection.dart';

// Statistics and crash reports only with the player's consent (§ 25 TDDDG).
//
// The SDK round trip needs a device; what is checked here is everything on
// this side of it: the gate, the controller, and the switches in the native
// configuration that keep both SDKs off until the player says yes.

class _RecordingCrashes implements CrashReporter {
  final keys = <String>[];
  final errors = <Object>[];

  @override
  void setKey(String key, Object value) => keys.add(key);

  @override
  void record(Object error, StackTrace? stack, {String? reason}) =>
      errors.add(error);
}

void main() {
  group('gate', () {
    test('nothing reaches analytics until the player allows it', () {
      final gate = StatsConsentGate();
      final inner = RecordingAnalytics();
      final analytics = ConsentGatedAnalytics(inner, gate);

      analytics
        ..logEvent('game_start')
        ..setUserProperty('player_tier', 'new')
        ..logAdImpression(
          valueMicros: 1000,
          currency: 'EUR',
          adFormat: 'rewarded',
        );
      expect(inner.events, isEmpty);
      expect(inner.properties, isEmpty);
      expect(inner.impressions, isEmpty);

      gate.allowed = true;
      analytics.logEvent('game_start');
      expect(inner.of('game_start'), hasLength(1));

      // A withdrawal applies to the very next event.
      gate.allowed = false;
      analytics.logEvent('game_start');
      expect(inner.of('game_start'), hasLength(1));
    });

    test('nothing reaches crash reporting until the player allows it', () {
      final gate = StatsConsentGate();
      final inner = _RecordingCrashes();
      final crashes = ConsentGatedCrashReporter(inner, gate);

      crashes
        ..setKey('mode', 'daily')
        ..record(StateError('x'), null);
      expect(inner.keys, isEmpty);
      expect(inner.errors, isEmpty);

      gate.allowed = true;
      crashes.record(StateError('y'), null);
      expect(inner.errors, hasLength(1));
    });
  });

  group('controller', () {
    Future<Storage> storage([Map<String, Object> prefs = const {}]) async {
      SharedPreferences.setMockInitialValues(prefs);
      return Storage.create();
    }

    test('starts unanswered and records a yes everywhere at once', () async {
      final s = await storage();
      final gate = StatsConsentGate();
      final collection = RecordingCollection();
      final controller = StatsConsentController(s, gate, collection);

      expect(controller.state, isNull);
      expect(controller.available, isTrue);

      await controller.set(true);
      expect(controller.state, isTrue);
      expect(s.statsConsent, isTrue);
      expect(gate.allowed, isTrue);
      expect(collection.calls.single, (enabled: true, answerChanged: true));
    });

    test('a withdrawal switches off as a changed answer', () async {
      final s = await storage({'settings.statsConsent': true});
      final gate = StatsConsentGate(allowed: true);
      final collection = RecordingCollection();
      final controller = StatsConsentController(s, gate, collection);

      await controller.set(false);
      expect(s.statsConsent, isFalse);
      expect(gate.allowed, isFalse);
      expect(collection.calls.single, (enabled: false, answerChanged: true));
    });

    test('a first "no" also counts as a changed answer', () async {
      // It deletes what a version that never asked had already collected.
      final collection = RecordingCollection();
      final controller = StatsConsentController(
        await storage(),
        StatsConsentGate(),
        collection,
      );

      await controller.set(false);
      expect(collection.calls.single, (enabled: false, answerChanged: true));
    });

    test('a build without statistics has nothing to ask about', () async {
      final controller = StatsConsentController(
        await storage(),
        StatsConsentGate(),
        null,
      );
      expect(controller.available, isFalse);
    });

    test('the answer survives a progress reset', () async {
      final s = await storage({'settings.statsConsent': false});
      await s.resetProgress();
      expect(s.statsConsent, isFalse);
    });
  });

  group('native configuration', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    final plist = File('ios/Runner/Info.plist').readAsStringSync();

    bool metaFalse(String name) => RegExp(
      'android:name="${RegExp.escape(name)}"\\s+android:value="false"',
    ).hasMatch(manifest);

    bool plistFalse(String key) =>
        RegExp('<key>${RegExp.escape(key)}</key>\\s*<false/>').hasMatch(plist);

    test('both SDKs start switched off on Android', () {
      // Without these, Analytics logs first_open and sessions on its own
      // before a single line of Dart has run.
      expect(metaFalse('firebase_analytics_collection_enabled'), isTrue);
      expect(metaFalse('firebase_crashlytics_collection_enabled'), isTrue);
    });

    test('ad signals in Analytics stay denied on Android', () {
      expect(metaFalse('google_analytics_default_allow_ad_storage'), isTrue);
      expect(metaFalse('google_analytics_default_allow_ad_user_data'), isTrue);
      expect(
        metaFalse('google_analytics_default_allow_ad_personalization_signals'),
        isTrue,
      );
    });

    test('iOS matches', () {
      for (final key in [
        'FIREBASE_ANALYTICS_COLLECTION_ENABLED',
        'FirebaseCrashlyticsCollectionEnabled',
        'GOOGLE_ANALYTICS_DEFAULT_ALLOW_AD_STORAGE',
        'GOOGLE_ANALYTICS_DEFAULT_ALLOW_AD_USER_DATA',
        'GOOGLE_ANALYTICS_DEFAULT_ALLOW_AD_PERSONALIZATION_SIGNALS',
      ]) {
        expect(plistFalse(key), isTrue, reason: key);
      }
    });

    test('no code grants Analytics consent signals', () {
      // UMP's canRequestAds() is also true after "Do not consent"; passing it
      // on as consent told Google the opposite of the player's answer.
      for (final file
          in Directory('lib')
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('.dart'))) {
        expect(
          file.readAsStringSync(),
          isNot(contains('setConsent(')),
          reason: file.path,
        );
      }
    });

    test('the Mobile Ads SDK starts only behind canRequestAds', () {
      final ads = File('lib/monetization/ads.dart').readAsStringSync();
      expect(
        'MobileAds.instance.initialize()'.allMatches(ads),
        hasLength(1),
        reason: 'one call site, inside _startAds',
      );
      final start = ads.indexOf('Future<void> _startAds()');
      final call = ads.indexOf('MobileAds.instance.initialize()');
      expect(start, greaterThan(0));
      expect(call, greaterThan(start));
      expect(ads, contains('if (_canRequestAds) await _startAds();'));
    });
  });
}
