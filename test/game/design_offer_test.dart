import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/design_offer.dart';

void main() {
  group('the rotating designs (owner, 28.09.2026)', () {
    test('three themes and three skins, 80 diamonds each', () {
      expect(
        kRotatingDesigns.where((d) => d.kind == DesignKind.theme),
        hasLength(3),
      );
      expect(
        kRotatingDesigns.where((d) => d.kind == DesignKind.skin),
        hasLength(3),
      );
      expect(kRotatingDesignPrice, 80);
      expect(kRotatingDesigns.map((d) => d.id).toSet(), hasLength(6));
    });

    test('the skins among them are diamond skins in the catalog', () {
      for (final d in kRotatingDesigns.where((d) => d.kind == DesignKind.skin)) {
        final skin = kSkinCatalog.singleWhere((s) => s.id == d.id);
        expect(skin.currency, SkinCurrency.diamond, reason: d.id);
        expect(skin.cost, kRotatingDesignPrice, reason: d.id);
        expect(skin.style.isAnimated, isFalse, reason: 'static: ${d.id}');
        expect(skin.isPurchasable, isTrue, reason: d.id);
      }
    });
  });

  group('the daily deal', () {
    test('is one design per calendar day, the same all day', () {
      final morning = DateTime(2026, 9, 28, 0, 1);
      final night = DateTime(2026, 9, 28, 23, 59);
      expect(dailyDeal(morning), dailyDeal(night));
    });

    test('goes through all six before one comes back', () {
      final seen = [
        for (var i = 0; i < 6; i++) dailyDeal(DateTime(2026, 9, 28 + i, 12)),
      ];
      expect(seen.toSet(), hasLength(6));
      expect(dailyDeal(DateTime(2026, 10, 4, 12)), seen.first);
    });

    test('does not skip or repeat a day across a clock change', () {
      // Europe leaves summer time on 25.10.2026; a day of 25 hours must still
      // be one deal, and the next day the next one.
      final a = dailyDeal(DateTime(2026, 10, 24, 12));
      final b = dailyDeal(DateTime(2026, 10, 25, 12));
      final c = dailyDeal(DateTime(2026, 10, 26, 12));
      expect({a, b, c}, hasLength(3));
    });

    test('is 25 percent off, and only for the deal of the day', () {
      final now = DateTime(2026, 9, 28, 15);
      final deal = dailyDeal(now);
      expect(kDailyDealDiscountPercent, 25);
      expect(designPrice(deal, now), 60);
      for (final d in kRotatingDesigns.where((d) => d != deal)) {
        expect(designPrice(d, now), 80, reason: d.id);
      }
    });

    test('knows when the next deal starts: local midnight', () {
      expect(
        untilNextDeal(DateTime(2026, 9, 28, 22, 30)),
        const Duration(hours: 1, minutes: 30),
      );
    });
  });
}
