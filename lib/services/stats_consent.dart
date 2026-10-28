/// Consent for usage statistics and crash reports.
///
/// Firebase Analytics and Crashlytics used to start on every launch and send
/// before the player had been asked anything. Reading or storing information on
/// a device for statistics needs the player's prior consent in the EU
/// (§ 25 Abs. 1 TDDDG, Art. 5(3) ePrivacy Directive): it is not strictly
/// necessary to play. Both SDKs are now off by default — the
/// `*_collection_enabled` flags in `AndroidManifest.xml` and `Info.plist` —
/// and nothing reaches them until the player says yes.
library;

import 'analytics.dart';
import 'crash_reporter.dart';

/// Whether the player allowed statistics, read on every call so that a change
/// in the settings applies to the very next event.
///
/// One mutable holder rather than a value passed around: Firebase installs its
/// crash handlers before the save file is open, and those handlers, the gated
/// backends and the settings switch all have to see the same answer.
class StatsConsentGate {
  StatsConsentGate({this.allowed = false});

  bool allowed;
}

/// Switches collection on and off inside the SDKs themselves.
///
/// The gate keeps the app's own events back; this is what stops what the SDKs
/// collect on their own (first open, sessions, native crashes).
abstract class StatsCollection {
  /// [answerChanged] is true when the player has just answered or changed
  /// their answer, false when the stored answer is re-applied at start-up.
  ///
  /// A new "yes" first deletes crash reports held back on the device: they
  /// come from before the consent and must not be sent because of it. A new
  /// "no" also deletes the analytics id and the data tied to it, including
  /// what a version that never asked had collected. Re-applying a "yes" at
  /// start-up deletes nothing: the reports waiting then are the previous
  /// session's crashes, which Crashlytics sends on the next launch.
  Future<void> setEnabled(bool enabled, {bool answerChanged = false});
}

/// Forwards to [inner] only while [gate] allows it.
class ConsentGatedAnalytics implements Analytics {
  ConsentGatedAnalytics(this.inner, this.gate);

  final Analytics inner;
  final StatsConsentGate gate;

  @override
  void logEvent(String name, [Map<String, Object?> params = const {}]) {
    if (gate.allowed) inner.logEvent(name, params);
  }

  @override
  void logAdImpression({
    required double valueMicros,
    required String currency,
    required String adFormat,
    String? adSource,
    String? adUnitName,
  }) {
    if (!gate.allowed) return;
    inner.logAdImpression(
      valueMicros: valueMicros,
      currency: currency,
      adFormat: adFormat,
      adSource: adSource,
      adUnitName: adUnitName,
    );
  }

  @override
  void setUserProperty(String name, String? value) {
    if (gate.allowed) inner.setUserProperty(name, value);
  }
}

/// Forwards to [inner] only while [gate] allows it.
class ConsentGatedCrashReporter implements CrashReporter {
  ConsentGatedCrashReporter(this.inner, this.gate);

  final CrashReporter inner;
  final StatsConsentGate gate;

  @override
  void setKey(String key, Object value) {
    if (gate.allowed) inner.setKey(key, value);
  }

  @override
  void record(Object error, StackTrace? stack, {String? reason}) {
    if (gate.allowed) inner.record(error, stack, reason: reason);
  }
}
