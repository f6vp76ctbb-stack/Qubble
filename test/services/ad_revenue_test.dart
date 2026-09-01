import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/analytics.dart';

import '../support/recording_analytics.dart';

void main() {
  group('ad impression reporting', () {
    test('records the value in micros, unconverted, for the backend to scale',
        () {
      final analytics = RecordingAnalytics();

      // A rewarded impression paying roughly a US cent.
      analytics.logAdImpression(
        valueMicros: 12500,
        currency: 'USD',
        adFormat: 'rewarded',
        adUnitName: 'ca-app-pub-x/y',
        adSource: 'com.google.ads.mediation.admob.AdMobAdapter',
      );

      final impression = analytics.impressions.single;
      expect(impression.valueMicros, 12500);
      expect(impression.currency, 'USD');
      expect(impression.adFormat, 'rewarded');
      expect(impression.adSource,
          'com.google.ads.mediation.admob.AdMobAdapter');
    });

    test('micros convert to currency units by a million, not a thousand', () {
      // The one arithmetic mistake this code can make, and it would be
      // invisible: every revenue figure simply reads 1000x off, consistently,
      // with nothing failing to say so.
      expect(currencyFromMicros(1000000), 1.0);
      expect(currencyFromMicros(16490000), 16.49); // a plausible rewarded eCPM
      expect(currencyFromMicros(12500), 0.0125);
      expect(currencyFromMicros(0), 0.0);
    });

    test('a mediation-free impression reports no source rather than empty', () {
      final analytics = RecordingAnalytics();
      analytics.logAdImpression(
        valueMicros: 1,
        currency: 'EUR',
        adFormat: 'rewarded',
      );
      expect(analytics.impressions.single.adSource, isNull);
    });

    test('several impressions accumulate in order', () {
      final analytics = RecordingAnalytics();
      for (final v in [100.0, 200.0, 300.0]) {
        analytics.logAdImpression(
          valueMicros: v,
          currency: 'EUR',
          adFormat: 'rewarded',
        );
      }
      expect(analytics.impressions.map((i) => i.valueMicros),
          [100.0, 200.0, 300.0]);
    });
  });
}
