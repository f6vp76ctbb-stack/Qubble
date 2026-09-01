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

  // D.5.2 asks for three ratios. placed vs emptyCell is covered above, and
  // more strictly than the spec (3,0 rather than 2,0). These are the other two.

  test('chrome text stays readable on every theme background', () {
    // GameTheme carries no textPrimary: its doc comment asserts that "all
    // themes use dark backgrounds, so light text is always readable". That is
    // an assumption about every theme anyone adds later, so test it rather
    // than trust it. 4,5:1 is WCAG AA for body text (D.5.2).
    for (final entry in kThemeCatalog) {
      final ratio = contrast(GridColors.textPrimary, entry.theme.background);
      expect(
        ratio,
        greaterThanOrEqualTo(4.5),
        reason: 'theme "${entry.id}": chrome text vs background is '
            '${ratio.toStringAsFixed(2)}:1',
      );
    }
  });

  test('the fever glow reads against the board', () {
    for (final entry in kThemeCatalog) {
      final t = entry.theme;
      final ratio = contrast(t.fever, t.boardBackground);
      expect(
        ratio,
        greaterThanOrEqualTo(2.0),
        reason: 'theme "${entry.id}": fever vs board background is '
            '${ratio.toStringAsFixed(2)}:1 — the fever state is invisible',
      );
    }
  });

  test('the valid and invalid previews are not separable by colour alone', () {
    // Documents why board_view.dart outlines the invalid preview instead of
    // relying on the palette. These pairs are genuinely too close, and no
    // colour tweak fixes them without breaking the themes: the worst is
    // sunset, whose two previews are both in the red-orange family, and the
    // most common pairing is green against red, which a red-green deficiency
    // collapses regardless of contrast ratio.
    //
    // If this ever starts failing because every theme separated cleanly, the
    // outline is still right -- colour blindness is not a contrast ratio.
    final tooClose = <String>[];
    for (final entry in kThemeCatalog) {
      final t = entry.theme;
      if (contrast(t.validPreview, t.invalidPreview) < 2.0) {
        tooClose.add(entry.id);
      }
    }
    expect(tooClose, isNotEmpty);
  });

  test('the shared chrome palette matches the classic theme', () {
    // GridColors is used directly by chrome that is not theme-aware; if it
    // drifts from the classic theme the two look wrong side by side.
    expect(GridColors.emptyCell, kThemeCatalog.first.theme.emptyCell);
    expect(GridColors.boardBackground, kThemeCatalog.first.theme.boardBackground);
  });
}
