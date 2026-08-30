import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/ad_config.dart';

void main() {
  group('AdConfig.resolveRewardedUnitId', () {
    const testAndroid = 'ca-app-pub-3940256099942544/5224354917';
    const testIos = 'ca-app-pub-3940256099942544/1712485313';
    const prodAndroid = 'ca-app-pub-8596176219181991/4303264559';

    test('test mode uses Google sample units on both platforms', () {
      expect(
        AdConfig.resolveRewardedUnitId(android: true, testAds: true),
        testAndroid,
      );
      expect(
        AdConfig.resolveRewardedUnitId(android: false, testAds: true),
        testIos,
      );
    });

    test('production Android build uses the real unit', () {
      expect(
        AdConfig.resolveRewardedUnitId(android: true, testAds: false),
        prodAndroid,
      );
    });

    test('an unfilled production id falls back to the test unit', () {
      // iOS has no real unit yet; requesting the placeholder would never load
      // and would silently kill every rewarded feature.
      expect(
        AdConfig.resolveRewardedUnitId(android: false, testAds: false),
        testIos,
      );
    });

    test('a production unit is never a placeholder in disguise', () {
      final id = AdConfig.resolveRewardedUnitId(android: true, testAds: false);
      expect(id.startsWith('ca-app-pub-'), isTrue);
      expect(id, isNot(startsWith('REPLACE_ME')));
    });

    test('debug builds always force test ads', () {
      // The test runner is a debug build, so this guards the wiring itself.
      expect(AdConfig.usesTestAds, isTrue);
      expect(AdConfig.rewardedUnitId, anyOf(testAndroid, testIos));
    });
  });
}
