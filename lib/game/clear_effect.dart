/// Clear effects (owner, 12.10.2026): how a cleared row dissolves on the
/// blocks themselves before it is gone — "wie ein Laser, ein Feuer oder so
/// was", and a design of its own. Pure Dart, no Flutter imports; the drawing
/// is in lib/ui/widgets/clear_sweep.dart.
///
/// The explosions (lib/game/burst_style.dart) are the particles that fly off
/// afterwards; a clear effect is what happens to the blocks. The two combine
/// freely, like every other design.
library;

enum ClearEffectStyle { classic, laser, blaze, frost, lightning }

class ClearEffect {
  const ClearEffect({
    required this.id,
    required this.style,
    required this.cost,
  });

  /// Stable catalog id; the displayed name is `clearEffectName` in
  /// lib/ui/l10n_maps.dart.
  final String id;
  final ClearEffectStyle style;

  /// Price in diamonds; 0 for the default.
  final int cost;
}

/// The free default: the row shrinks away in a quick flash.
const String kDefaultClearEffectId = 'classic';

/// Price of each clear effect, in diamonds — the same as an explosion.
const int kClearEffectPrice = 100;

const List<ClearEffect> kClearEffectCatalog = [
  ClearEffect(
    id: kDefaultClearEffectId,
    style: ClearEffectStyle.classic,
    cost: 0,
  ),
  ClearEffect(
    id: 'laser',
    style: ClearEffectStyle.laser,
    cost: kClearEffectPrice,
  ),
  ClearEffect(
    id: 'blaze',
    style: ClearEffectStyle.blaze,
    cost: kClearEffectPrice,
  ),
  ClearEffect(
    id: 'frost',
    style: ClearEffectStyle.frost,
    cost: kClearEffectPrice,
  ),
  ClearEffect(
    id: 'lightning',
    style: ClearEffectStyle.lightning,
    cost: kClearEffectPrice,
  ),
];

ClearEffectStyle clearEffectStyleById(String id) => kClearEffectCatalog
    .firstWhere((e) => e.id == id, orElse: () => kClearEffectCatalog.first)
    .style;

/// Where in its line a cleared cell sits, 0..1 — the order a sweep reaches
/// it. A cell whose whole row was cleared runs left to right, one whose
/// column was cleared top to bottom; a cell in both goes with its row.
/// [cleared] holds (row, col) pairs; [size] is the board's side.
double sweepOrder(
  int row,
  int col,
  Set<(int, int)> cleared, {
  int size = 8,
}) {
  bool full(Iterable<(int, int)> line) => line.every(cleared.contains);
  final rowFull = full([for (var c = 0; c < size; c++) (row, c)]);
  if (rowFull || !full([for (var r = 0; r < size; r++) (r, col)])) {
    return size <= 1 ? 0 : col / (size - 1);
  }
  return size <= 1 ? 0 : row / (size - 1);
}
