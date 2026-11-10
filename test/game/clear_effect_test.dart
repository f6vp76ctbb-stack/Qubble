import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/clear_effect.dart';

void main() {
  test('a free default and four effects for diamonds (owner, 12.10.2026)', () {
    expect(
      kClearEffectCatalog.singleWhere((e) => e.id == kDefaultClearEffectId).cost,
      0,
    );
    final paid = kClearEffectCatalog.where((e) => e.cost > 0).toList();
    expect(paid.map((e) => e.id), ['laser', 'blaze', 'frost', 'lightning']);
    expect(paid.every((e) => e.cost == kClearEffectPrice), isTrue);
    expect(
      kClearEffectCatalog.map((e) => e.style).toSet(),
      hasLength(kClearEffectCatalog.length),
    );
  });

  test('ids resolve, unknown ones to the default', () {
    for (final e in kClearEffectCatalog) {
      expect(clearEffectStyleById(e.id), e.style);
    }
    expect(clearEffectStyleById('nope'), ClearEffectStyle.classic);
  });

  group('sweepOrder', () {
    Set<(int, int)> row(int r) => {for (var c = 0; c < 8; c++) (r, c)};
    Set<(int, int)> col(int c) => {for (var r = 0; r < 8; r++) (r, c)};

    test('a cleared row runs left to right', () {
      final cleared = row(3);
      expect(sweepOrder(3, 0, cleared), 0);
      expect(sweepOrder(3, 7, cleared), 1);
      expect(sweepOrder(3, 4, cleared), closeTo(4 / 7, 1e-9));
    });

    test('a cleared column runs top to bottom', () {
      final cleared = col(5);
      expect(sweepOrder(0, 5, cleared), 0);
      expect(sweepOrder(7, 5, cleared), 1);
    });

    test('where a row and a column cross, the row decides', () {
      final cleared = {...row(2), ...col(6)};
      expect(sweepOrder(2, 6, cleared), closeTo(6 / 7, 1e-9));
      expect(sweepOrder(5, 6, cleared), closeTo(5 / 7, 1e-9));
    });
  });
}
