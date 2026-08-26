// The empty board cells ARE the visible grid: boardBackground shows through
// the 1.5 px inset between them. That pair used to sit at 1.14:1, which made
// the cell boundaries — the thing a player reads to plan a move — invisible.
import 'dart:math' as math;
import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/ui/theme.dart';

/// WCAG relative luminance.
double _luminance(Color c) {
  double channel(double v) {
    final s = v; // already 0..1
    return s <= 0.04045 ? s / 12.92 : math.pow((s + 0.055) / 1.055, 2.4) as double;
  }

  return 0.2126 * channel(c.r) +
      0.7152 * channel(c.g) +
      0.0722 * channel(c.b);
}

double contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  final hi = math.max(la, lb);
  final lo = math.min(la, lb);
  return (hi + 0.05) / (lo + 0.05);
}

/// Floor for the grid structure. Not WCAG's 3:1 for graphical objects — a
/// board that stark would fight the calm look — but far enough above the old
/// 1.14 that the cells read as cells.
const double kMinGridContrast = 1.6;

/// A tray piece must stay clearly distinguishable from an empty cell, which
/// raising the empty-cell brightness could have eroded.
const double kMinPieceContrast = 3.0;

void main() {
  test('every theme keeps the grid structure visible', () {
    for (final entry in kThemeCatalog) {
      final t = entry.theme;
      final ratio = contrast(t.emptyCell, t.boardBackground);
      expect(
        ratio,
        greaterThanOrEqualTo(kMinGridContrast),
        reason: 'theme "${entry.id}": empty cell vs board background is '
            '${ratio.toStringAsFixed(2)}:1 — the cell boundaries disappear',
      );
    }
  });

  test('placed blocks stay obvious against an empty cell', () {
    for (final entry in kThemeCatalog) {
      final t = entry.theme;
      final ratio = contrast(t.placed, t.emptyCell);
      expect(
        ratio,
        greaterThanOrEqualTo(kMinPieceContrast),
        reason: 'theme "${entry.id}": placed vs empty is '
            '${ratio.toStringAsFixed(2)}:1 — filled and free look alike',
      );
    }
  });

  test('every tray slot colour stays distinguishable from an empty cell', () {
    for (final entry in kThemeCatalog) {
      final t = entry.theme;
      for (var i = 0; i < t.traySlots.length; i++) {
        final ratio = contrast(t.traySlots[i], t.emptyCell);
        expect(
          ratio,
          greaterThanOrEqualTo(2.0),
          reason: 'theme "${entry.id}" slot $i is '
              '${ratio.toStringAsFixed(2)}:1 against an empty cell',
        );
      }
    }
  });

  test('the shared chrome palette matches the classic theme', () {
    // GridColors is used directly by chrome that is not theme-aware; if it
    // drifts from the classic theme the two look wrong side by side.
    expect(GridColors.emptyCell, kThemeCatalog.first.theme.emptyCell);
    expect(GridColors.boardBackground, kThemeCatalog.first.theme.boardBackground);
  });
}
