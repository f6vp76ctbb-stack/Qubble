import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/crash_reporter.dart';

/// Captures what was reported, so a test can assert on the funnel rather than
/// on a debugPrint.
///
/// Shared because two suites had grown their own copy, and every addition to
/// the [Analytics] contract then had to be made twice.
class RecordingAnalytics implements Analytics {
  final events = <(String, Map<String, Object?>)>[];
  final impressions = <AdImpression>[];
  final properties = <String, String?>{};
  final adConsent = <bool>[];

  @override
  void logEvent(String name, [Map<String, Object?> params = const {}]) {
    events.add((name, params));
  }

  @override
  void logAdImpression({
    required double valueMicros,
    required String currency,
    required String adFormat,
    String? adSource,
    String? adUnitName,
  }) {
    impressions.add(AdImpression(
      valueMicros: valueMicros,
      currency: currency,
      adFormat: adFormat,
      adSource: adSource,
      adUnitName: adUnitName,
    ));
  }

  @override
  void setUserProperty(String name, String? value) {
    properties[name] = value;
  }

  @override
  void setAdConsent({required bool granted}) {
    adConsent.add(granted);
  }

  /// The parameter maps of every event logged under [name], in order.
  List<Map<String, Object?>> of(String name) =>
      events.where((e) => e.$1 == name).map((e) => e.$2).toList();

  /// Convenience for the common single-event assertion.
  List<Map<String, Object?>> paramsFor(String name) => of(name);
}

class AdImpression {
  const AdImpression({
    required this.valueMicros,
    required this.currency,
    required this.adFormat,
    this.adSource,
    this.adUnitName,
  });

  final double valueMicros;
  final String currency;
  final String adFormat;
  final String? adSource;
  final String? adUnitName;
}

/// Captures the state attached to crash reports.
class RecordingCrashReporter implements CrashReporter {
  final keys = <String, Object>{};
  final recorded = <Object>[];

  @override
  void setKey(String key, Object value) {
    keys[key] = value;
  }

  @override
  void record(Object error, StackTrace? stack, {String? reason}) {
    recorded.add(error);
  }
}
