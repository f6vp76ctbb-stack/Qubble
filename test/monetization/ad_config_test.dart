import 'dart:io';

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

    // The units the owner created in AdMob on 2026-09-28, one per offer,
    // copied from the AdMob unit list (name → id).
    const ownUnits = {
      AdPlacement.doubleCoins: 'ca-app-pub-8596176219181991/2059719876',
      AdPlacement.dailyDouble: 'ca-app-pub-8596176219181991/9586681095',
      AdPlacement.luckyBlock: 'ca-app-pub-8596176219181991/7120474864',
      AdPlacement.piggy: 'ca-app-pub-8596176219181991/7767342121',
      AdPlacement.streakRepair: 'ca-app-pub-8596176219181991/1201933775',
      AdPlacement.puzzleExtraMove: 'ca-app-pub-8596176219181991/5638114643',
      // The shop's free bonus, created on 2026-10-02.
      AdPlacement.freeCoins: 'ca-app-pub-8596176219181991/3859493490',
      AdPlacement.freeDiamonds: 'ca-app-pub-8596176219181991/4210847288',
    };

    // Offers whose unit the owner has yet to create in AdMob (ANLEITUNG.md).
    // Until then the shared unit serves them; each moves to ownUnits once
    // its id is in, and this set empties.
    const pending = <AdPlacement>{};

    test('an offer still waiting for its unit uses the shared one', () {
      for (final placement in pending) {
        expect(
          AdConfig.resolveRewardedUnitId(
            android: true,
            testAds: false,
            placement: placement,
          ),
          prodAndroid,
          reason: placement.name,
        );
      }
    });

    test('every offer uses its own unit in a production build', () {
      expect(
        {...ownUnits.keys, ...pending},
        containsAll(AdPlacement.values),
        reason: 'a new offer needs its own unit, or a place in pending',
      );
      for (final placement in ownUnits.keys) {
        expect(
          AdConfig.resolveRewardedUnitId(
            android: true,
            testAds: false,
            placement: placement,
          ),
          ownUnits[placement],
          reason: placement.name,
        );
      }
    });

    test('no two offers share a unit, and none reuses the shared one', () {
      // A copy-paste slip would merge two offers' revenue in AdMob; reusing
      // the shared unit would hide an offer inside the old aggregate.
      final ids = [
        for (final placement in ownUnits.keys)
          AdConfig.resolveRewardedUnitId(
            android: true,
            testAds: false,
            placement: placement,
          ),
      ];
      expect(ids.toSet(), hasLength(ids.length));
      expect(ids, isNot(contains(prodAndroid)));
    });

    test('every production unit belongs to the app id in the manifest', () {
      // A unit from another AdMob account or app never fills for this app.
      final manifest = File(
        'android/app/src/main/AndroidManifest.xml',
      ).readAsStringSync();
      final appId = RegExp(r'ca-app-pub-(\d+)~\d+').firstMatch(manifest)!;
      final publisher = 'ca-app-pub-${appId.group(1)}/';
      expect(prodAndroid, startsWith(publisher));
      for (final placement in AdPlacement.values) {
        expect(
          AdConfig.resolveRewardedUnitId(
            android: true,
            testAds: false,
            placement: placement,
          ),
          startsWith(publisher),
          reason: placement.name,
        );
      }
    });

    test('test builds use the sample unit for every offer', () {
      for (final placement in AdPlacement.values) {
        expect(
          AdConfig.resolveRewardedUnitId(
            android: true,
            testAds: true,
            placement: placement,
          ),
          testAndroid,
        );
      }
    });

    test('debug builds always force test ads', () {
      // The test runner is a debug build, so this guards the wiring itself.
      expect(AdConfig.usesTestAds, isTrue);
      expect(AdConfig.rewardedUnitId, anyOf(testAndroid, testIos));
    });
  });
}
