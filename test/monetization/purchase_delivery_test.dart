import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/supporter_pack.dart';
import 'package:gridpop/monetization/iap.dart';
import 'package:gridpop/monetization/purchase_delivery.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _DeliveryHarness {
  _DeliveryHarness(this.storage) : coins = storage.coins;

  final Storage storage;
  int coins;
  int diamonds = 0;
  int supporterMarks = 0;
  final Set<String> themes = {};
  final Set<String> skins = {};

  PurchaseDelivery createDelivery() => PurchaseDelivery(
    storage: storage,
    grantCoins: (amount) async {
      coins += amount;
      await storage.setCoins(coins);
    },
    grantDiamonds: (amount) async {
      diamonds += amount;
      await storage.setDiamonds(diamonds);
    },
    grantTheme: (id) async => themes.add(id),
    grantSkin: (id) async => skins.add(id),
    markSupporter: () async {
      supporterMarks++;
      await storage.setSupporter(true);
    },
    markStarterPurchased: () async {},
    grantRenameCredit: () async {},
    analytics: NoopAnalytics(),
  );
}

Future<_DeliveryHarness> _harness([
  Map<String, Object> prefs = const {},
]) async {
  SharedPreferences.setMockInitialValues(prefs);
  return _DeliveryHarness(await Storage.create());
}

void main() {
  group('supporter delivery', () {
    test('grants welcome coins only once across repeated deliveries', () async {
      final harness = await _harness({'coins': 100});
      final delivery = harness.createDelivery();

      await delivery.deliver(IapProducts.supporter);
      await delivery.deliver(IapProducts.supporter);

      expect(harness.coins, 100 + SupporterPack.coins);
      expect(harness.supporterMarks, 1);
      expect(harness.storage.supporter, isTrue);
      expect(harness.themes, contains(SupporterPack.themeId));
      expect(harness.skins, contains(SupporterPack.skinId));
    });

    test('serializes simultaneous events and grants coins only once', () async {
      final harness = await _harness({'coins': 100});
      final delivery = harness.createDelivery();

      await Future.wait([
        delivery.deliver(IapProducts.supporter),
        delivery.deliver(IapProducts.supporter),
      ]);

      expect(harness.coins, 100 + SupporterPack.coins);
      expect(harness.supporterMarks, 1);
    });

    test('a restore repairs cosmetics without repeating coins', () async {
      final harness = await _harness({'coins': 1600, 'supporter': true});

      // A fresh delivery object models a later app process / store restore.
      await harness.createDelivery().deliver(IapProducts.supporter);

      expect(harness.coins, 1600);
      expect(harness.supporterMarks, 0);
      expect(harness.themes, {SupporterPack.themeId});
      expect(harness.skins, {SupporterPack.skinId});
    });
  });

  group('diamond packs', () {
    test('each pack grants its documented amount', () async {
      for (final entry in IapProducts.diamondAmounts.entries) {
        final h = await _harness();
        // A fresh install starts with a gold balance, so the check is that the
        // pack left it alone — not that it is zero.
        final coinsBefore = h.coins;
        await h.createDelivery().deliver(entry.key);
        expect(h.diamonds, entry.value, reason: entry.key);
        expect(
          h.coins,
          coinsBefore,
          reason: '${entry.key} pays diamonds and must not touch gold',
        );
      }
    });

    test('a diamond pack is consumable, so it can be bought again', () {
      // A permanent unlock sold as consumable can be charged twice; a currency
      // pack sold as non-consumable can only ever be bought once. Both are
      // console settings, and this is the source of truth for them.
      for (final id in IapProducts.diamondAmounts.keys) {
        expect(IapProducts.isConsumable(id), isTrue, reason: id);
        expect(IapProducts.all, contains(id), reason: id);
      }
    });

    test('buying twice accumulates rather than replacing', () async {
      final h = await _harness();
      final delivery = h.createDelivery();
      await delivery.deliver(IapProducts.diamondsS);
      await delivery.deliver(IapProducts.diamondsS);
      expect(h.diamonds, IapProducts.diamondAmounts[IapProducts.diamondsS]! * 2);
    });

    test('no product is both a coin pack and a diamond pack', () {
      // The delivery checks diamonds before falling through to coins, so an id
      // in both maps would silently pay only diamonds.
      expect(
        IapProducts.diamondAmounts.keys.toSet()
            .intersection(IapProducts.coinAmounts.keys.toSet()),
        isEmpty,
      );
    });
  });
}
