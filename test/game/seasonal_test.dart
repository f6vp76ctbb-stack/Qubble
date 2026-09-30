import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/seasonal.dart';
import 'package:gridpop/ui/theme.dart';

void main() {
  final october = DateTime(2026, 10, 15, 12);
  final november = DateTime(2026, 11, 1, 0, 1);
  final lastOctoberMinute = DateTime(2026, 10, 31, 23, 59);

  group('the sale window', () {
    test('an ordinary design is for sale all year', () {
      for (var m = 1; m <= 12; m++) {
        expect(forSaleIn(null, DateTime(2026, m, 3)), isTrue, reason: '$m');
      }
    });

    test('a seasonal one only in its month, every year', () {
      expect(forSaleIn(kHalloweenMonth, october), isTrue);
      expect(forSaleIn(kHalloweenMonth, lastOctoberMinute), isTrue);
      expect(forSaleIn(kHalloweenMonth, november), isFalse);
      expect(
        forSaleIn(kHalloweenMonth, DateTime(2026, 9, 30, 23, 59)),
        isFalse,
      );
      expect(forSaleIn(kHalloweenMonth, DateTime(2027, 10, 1)), isTrue);
    });

    test('Halloween runs through October', () {
      expect(halloweenActive(DateTime(2026, 10, 1)), isTrue);
      expect(halloweenActive(lastOctoberMinute), isTrue);
      expect(halloweenActive(november), isFalse);
    });
  });

  group('the Halloween designs', () {
    final pumpkin = kThemeCatalog.singleWhere((t) => t.id == kHalloweenThemeId);
    final ghost = kSkinCatalog.singleWhere((s) => s.id == kHalloweenSkinId);

    test('cost diamonds, like the other designs of their kind', () {
      expect(pumpkin.currency, SkinCurrency.diamond);
      expect(pumpkin.cost, 80);
      expect(ghost.currency, SkinCurrency.diamond);
      expect(ghost.cost, kAnimatedSkinPrice);
      expect(ghost.style.isAnimated, isTrue);
    });

    test('are for sale in October and not after', () {
      expect(pumpkin.isForSaleAt(october), isTrue);
      expect(ghost.isForSaleAt(october), isTrue);
      expect(pumpkin.isForSaleAt(november), isFalse);
      expect(ghost.isForSaleAt(november), isFalse);
    });

    test('the ghost has a style of its own', () {
      final others = kSkinCatalog.where((s) => s.id != kHalloweenSkinId);
      expect(others.map((s) => s.style), isNot(contains(ghost.style)));
    });

    test('supporter and achievement designs stay unsellable in October', () {
      for (final s in kSkinCatalog.where((s) => !s.isPurchasable)) {
        expect(s.isForSaleAt(october), isFalse, reason: s.id);
      }
      for (final t in kThemeCatalog.where((t) => t.supporterOnly)) {
        expect(t.isForSaleAt(october), isFalse, reason: t.id);
      }
    });
  });
}
