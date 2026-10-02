import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/accessory.dart';
import 'package:gridpop/game/burst_style.dart';

void main() {
  group('accessories (owner, 30.09.2026: six at 60 diamonds)', () {
    test('six to buy, plus "none" for free', () {
      final paid = kAccessoryCatalog.where((a) => a.id != kNoAccessoryId);
      expect(paid, hasLength(6));
      for (final a in paid) {
        expect(a.cost, 60, reason: a.id);
      }
      expect(
        kAccessoryCatalog.singleWhere((a) => a.id == kNoAccessoryId).cost,
        0,
      );
      expect(
        kAccessoryCatalog.map((a) => a.id).toSet(),
        hasLength(kAccessoryCatalog.length),
      );
      expect(
        kAccessoryCatalog.map((a) => a.style).toSet(),
        hasLength(kAccessoryCatalog.length),
      );
    });

    test('ids resolve to their style; unknown ids to none', () {
      for (final a in kAccessoryCatalog) {
        expect(accessoryStyleById(a.id), a.style);
        expect(a.id, a.style.name, reason: 'ids double as style names');
      }
      expect(accessoryStyleById('nope'), AccessoryStyle.none);
    });

    test('worn by two blocks in five, rarely by both neighbours', () {
      var worn = 0;
      var pairs = 0;
      for (var r = 0; r < 8; r++) {
        for (var c = 0; c < 8; c++) {
          if (wearsAccessory(r, c)) {
            worn++;
            if (c < 7 && wearsAccessory(r, c + 1)) pairs++;
          }
        }
      }
      expect(worn / 64, closeTo(0.4, 0.05));
      expect(pairs, lessThan(worn ~/ 2));
    });
  });

  group('explosions (owner, 30.09.2026: five at 100 diamonds)', () {
    test('five to buy, the old burst stays free', () {
      final paid = kBurstCatalog.where((b) => b.id != kDefaultBurstId);
      expect(paid, hasLength(5));
      for (final b in paid) {
        expect(b.cost, 100, reason: b.id);
      }
      expect(kBurstCatalog.first.id, kDefaultBurstId);
      expect(kBurstCatalog.first.cost, 0);
      expect(
        kBurstCatalog.map((b) => b.style).toSet(),
        hasLength(kBurstCatalog.length),
      );
    });

    test('ids resolve to their style; unknown ids to classic', () {
      for (final b in kBurstCatalog) {
        expect(burstStyleById(b.id), b.style);
      }
      expect(burstStyleById('nope'), BurstStyle.classic);
    });
  });
}
