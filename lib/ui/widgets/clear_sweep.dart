/// The clear effects (lib/game/clear_effect.dart): a cleared row dissolves
/// on the blocks themselves — cut by a laser, burnt, frozen and shattered,
/// struck by lightning — before the explosion's particles fly. Purely
/// decorative; it sits over the board and never intercepts pointer events.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/board.dart';
import '../../game/clear_effect.dart';
import '../../game/piece.dart';
import '../state/cosmetic_controller.dart';
import '../state/game_controller.dart';
import '../state/settings_controller.dart';
import '../state/theme_controller.dart';

/// How long a row takes to dissolve, end to end.
Duration clearEffectDuration(ClearEffectStyle style) => switch (style) {
  ClearEffectStyle.classic => const Duration(milliseconds: 320),
  _ => const Duration(milliseconds: 560),
};

/// How much of the run the sweep along the line takes: 0 dissolves every
/// cell at once, 0.5 lets the last cell start halfway through.
double _spread(ClearEffectStyle style) => switch (style) {
  ClearEffectStyle.classic => 0.25,
  ClearEffectStyle.frost => 0.3,
  _ => 0.45,
};

/// One dissolving cell: where, in what colour, and when the sweep reaches it.
class SweepCell {
  const SweepCell({
    required this.rect,
    required this.color,
    required this.order,
    required this.horizontal,
    this.seed = 0,
  });

  final Rect rect;
  final Color color;

  /// 0..1 along its line ([sweepOrder]).
  final double order;

  /// Whether its line runs left to right (a row) or top to bottom.
  final bool horizontal;

  /// Varies the shards, sparks and bolt between cells.
  final int seed;
}

/// Paints [cells] at time [t] (0..1 of the whole effect) in [style].
void paintClearSweep(
  Canvas canvas,
  List<SweepCell> cells,
  ClearEffectStyle style,
  double t,
) {
  final spread = _spread(style);
  for (final cell in cells) {
    final local = ((t - cell.order * spread) / (1 - spread)).clamp(0.0, 1.0);
    _paintCell(canvas, cell, style, local, t);
  }
}

RRect _rrect(Rect r) =>
    RRect.fromRectAndRadius(r, Radius.circular(r.shortestSide * 0.22));

/// A pseudo-random 0..1 from [seed] and [i], stable from frame to frame.
double _noise(int seed, int i) {
  final x = math.sin(seed * 12.9898 + i * 78.233) * 43758.5453;
  return x - x.floorToDouble();
}

void _paintCell(
  Canvas canvas,
  SweepCell cell,
  ClearEffectStyle style,
  double p,
  double t,
) {
  final r = cell.rect;
  final s = r.width;
  if (p <= 0) {
    // Not reached yet: the block still stands.
    canvas.drawRRect(_rrect(r), Paint()..color = cell.color);
    return;
  }
  if (p >= 1) return;

  switch (style) {
    case ClearEffectStyle.classic:
      // A quick white flash, then the block shrinks away.
      final k = Curves.easeIn.transform(p);
      final color = Color.lerp(cell.color, Colors.white, 0.6 * (1 - p))!;
      canvas.drawRRect(
        _rrect(
          Rect.fromCenter(
            center: r.center,
            width: s * (1 - k),
            height: s * (1 - k),
          ),
        ),
        Paint()..color = color.withValues(alpha: 1 - p * 0.6),
      );

    case ClearEffectStyle.laser:
      // The beam passes and the block falls apart in two halves, edges
      // glowing red-hot.
      final gap = s * 0.45 * Curves.easeOut.transform(p);
      final fade = 1 - p;
      final hot = Color.lerp(cell.color, const Color(0xFFFFD0D8), 0.5 * fade)!;
      final halfPaint = Paint()..color = hot.withValues(alpha: fade);
      final edge = Paint()
        ..color = const Color(0xFFFF3B5C).withValues(alpha: fade)
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(1, s * 0.06);
      if (cell.horizontal) {
        final top = Rect.fromLTRB(r.left, r.top - gap, r.right, r.center.dy - gap);
        final bottom =
            Rect.fromLTRB(r.left, r.center.dy + gap, r.right, r.bottom + gap);
        canvas
          ..drawRect(top, halfPaint)
          ..drawRect(bottom, halfPaint)
          ..drawLine(top.bottomLeft, top.bottomRight, edge)
          ..drawLine(bottom.topLeft, bottom.topRight, edge);
      } else {
        final left = Rect.fromLTRB(r.left - gap, r.top, r.center.dx - gap, r.bottom);
        final right =
            Rect.fromLTRB(r.center.dx + gap, r.top, r.right + gap, r.bottom);
        canvas
          ..drawRect(left, halfPaint)
          ..drawRect(right, halfPaint)
          ..drawLine(left.topRight, left.bottomRight, edge)
          ..drawLine(right.topLeft, right.bottomLeft, edge);
      }
      // The beam itself, while it is over this cell.
      if (p < 0.45) {
        final a = 1 - p / 0.45;
        final (from, to) = cell.horizontal
            ? (
                Offset(r.left - s * 0.1, r.center.dy),
                Offset(r.right + s * 0.1, r.center.dy),
              )
            : (
                Offset(r.center.dx, r.top - s * 0.1),
                Offset(r.center.dx, r.bottom + s * 0.1),
              );
        canvas
          ..drawLine(
            from,
            to,
            Paint()
              ..color = const Color(0xFFFF3B5C).withValues(alpha: 0.8 * a)
              ..strokeWidth = s * 0.4
              ..maskFilter = MaskFilter.blur(BlurStyle.normal, s * 0.12),
          )
          ..drawLine(
            from,
            to,
            Paint()
              ..color = Colors.white.withValues(alpha: a)
              ..strokeWidth = math.max(1.5, s * 0.07),
          );
      }

    case ClearEffectStyle.blaze:
      // The block catches fire from below and burns down to embers, flames
      // licking up over it.
      final heat = (p / 0.35).clamp(0.0, 1.0);
      final burn = ((p - 0.25) / 0.75).clamp(0.0, 1.0);
      final fire = Color.lerp(
        const Color(0xFFFFB02E),
        const Color(0xFF7A1E0E),
        burn,
      )!;
      final body = Color.lerp(cell.color, fire, heat)!;
      final height = s * (1 - Curves.easeIn.transform(burn));
      if (height > 0.5) {
        canvas.drawRRect(
          _rrect(Rect.fromLTWH(r.left, r.bottom - height, s, height)),
          Paint()..color = body.withValues(alpha: 1 - burn * 0.5),
        );
      }
      // Three flame tongues, flickering.
      final flameA = (1 - burn) * math.min(1.0, p * 4);
      for (var i = 0; i < 3; i++) {
        final x = r.left + s * (0.22 + 0.28 * i);
        final flicker = 0.75 + 0.25 * math.sin(t * 40 + i * 2.1 + cell.seed);
        final h = s * (0.35 + 0.3 * _noise(cell.seed, i)) * flicker;
        final base = r.bottom - height;
        final w = s * 0.16;
        Path tongue(double w, double h) => Path()
          ..moveTo(x - w, base)
          ..quadraticBezierTo(x - w * 0.6, base - h * 0.55, x, base - h)
          ..quadraticBezierTo(x + w * 0.6, base - h * 0.55, x + w, base)
          ..close();
        canvas
          ..drawPath(
            tongue(w, h),
            Paint()
              ..color = const Color(0xFFFF6A1A).withValues(alpha: 0.85 * flameA),
          )
          ..drawPath(
            tongue(w * 0.5, h * 0.55),
            Paint()
              ..color = const Color(0xFFFFE38A).withValues(alpha: flameA),
          );
      }

    case ClearEffectStyle.frost:
      // The block freezes white-blue, cracks, and shatters into four shards
      // that fall away.
      final freeze = (p / 0.35).clamp(0.0, 1.0);
      final shatter = ((p - 0.35) / 0.65).clamp(0.0, 1.0);
      final ice = Color.lerp(cell.color, const Color(0xFFCFF1FF), freeze)!;
      if (shatter == 0) {
        canvas.drawRRect(_rrect(r), Paint()..color = ice);
        final crack = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(0.8, s * 0.035)
          ..color = Colors.white.withValues(alpha: freeze);
        canvas
          ..drawLine(r.topLeft, r.bottomRight, crack)
          ..drawLine(r.topRight, r.bottomLeft, crack);
        return;
      }
      final c = r.center;
      final corners = [r.topLeft, r.topRight, r.bottomRight, r.bottomLeft];
      for (var i = 0; i < 4; i++) {
        final a = corners[i];
        final b = corners[(i + 1) % 4];
        final mid = Offset.lerp(a, b, 0.5)!;
        final out = (mid - c) / (mid - c).distance;
        final drift = out * s * 0.6 * shatter +
            Offset(0, s * 1.1 * shatter * shatter);
        final spin = (i.isEven ? 1 : -1) * 1.2 * shatter;
        canvas
          ..save()
          ..translate(mid.dx + drift.dx, mid.dy + drift.dy)
          ..rotate(spin)
          ..translate(-mid.dx, -mid.dy);
        final shard = Path()
          ..moveTo(c.dx, c.dy)
          ..lineTo(a.dx, a.dy)
          ..lineTo(b.dx, b.dy)
          ..close();
        canvas
          ..drawPath(shard, Paint()..color = ice.withValues(alpha: 1 - shatter))
          ..drawPath(
            shard,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = math.max(0.6, s * 0.03)
              ..color = Colors.white.withValues(alpha: 1 - shatter),
          )
          ..restore();
      }

    case ClearEffectStyle.lightning:
      // The block flashes white and crumbles into small pieces while a
      // jagged bolt runs through the line over it.
      final flash = (1 - (p - 0.1).abs() / 0.15).clamp(0.0, 1.0);
      final crumble = ((p - 0.2) / 0.8).clamp(0.0, 1.0);
      final color = Color.lerp(cell.color, Colors.white, flash)!;
      const grid = 3;
      final piece = s / grid;
      for (var gy = 0; gy < grid; gy++) {
        for (var gx = 0; gx < grid; gx++) {
          final i = gy * grid + gx;
          final dx = (_noise(cell.seed, i) - 0.5) * s * 0.8 * crumble;
          final dy = (_noise(cell.seed, i + 9) - 0.2) * s * 0.9 * crumble;
          final shrink = 1 - crumble * (0.4 + 0.6 * _noise(cell.seed, i + 20));
          canvas.drawRect(
            Rect.fromCenter(
              center: Offset(
                r.left + (gx + 0.5) * piece + dx,
                r.top + (gy + 0.5) * piece + dy,
              ),
              width: piece * shrink,
              height: piece * shrink,
            ),
            Paint()..color = color.withValues(alpha: 1 - crumble),
          );
        }
      }
      if (p < 0.55) {
        final a = 1 - p / 0.55;
        final step = (t * 24).floor(); // a fresh zigzag every few frames
        final bolt = Path();
        const n = 4;
        for (var i = 0; i <= n; i++) {
          final f = i / n;
          // The ends sit on the centre line, so neighbours join up.
          final jitter = i == 0 || i == n
              ? 0.0
              : (_noise(cell.seed + step, i) - 0.5) * s * 0.6;
          final pt = cell.horizontal
              ? Offset(r.left + s * f, r.center.dy + jitter)
              : Offset(r.center.dx + jitter, r.top + s * f);
          i == 0 ? bolt.moveTo(pt.dx, pt.dy) : bolt.lineTo(pt.dx, pt.dy);
        }
        canvas
          ..drawPath(
            bolt,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = s * 0.3
              ..color = const Color(0xFF6FD3FF).withValues(alpha: 0.6 * a)
              ..maskFilter = MaskFilter.blur(BlurStyle.normal, s * 0.12),
          )
          ..drawPath(
            bolt,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = math.max(1.5, s * 0.08)
              ..strokeJoin = StrokeJoin.miter
              ..color = Colors.white.withValues(alpha: a),
          );
      }
  }
}

/// The dissolving cells of the latest clears, over the board.
class ClearSweep extends ConsumerStatefulWidget {
  const ClearSweep({super.key, required this.size, required this.cellSize});

  final double size;
  final double cellSize;

  @override
  ConsumerState<ClearSweep> createState() => _ClearSweepState();
}

class _Sweep {
  _Sweep(this.controller, this.cells, this.style);

  final AnimationController controller;
  final List<SweepCell> cells;
  final ClearEffectStyle style;
}

class _ClearSweepState extends ConsumerState<ClearSweep>
    with TickerProviderStateMixin {
  final List<_Sweep> _sweeps = [];

  void _start(List<Cell> cleared, Board before) {
    final reduced = ref.read(reducedEffectsProvider);
    // Reduced effects keep only the short, still fade.
    final style = reduced
        ? ClearEffectStyle.classic
        : ref.read(activeClearEffectProvider);
    final theme = ref.read(activeThemeProvider);
    final set = {for (final c in cleared) (c.row, c.col)};
    const inset = 1.5;
    final cell = widget.cellSize;
    bool rowFull(int r) =>
        [for (var c = 0; c < Board.size; c++) (r, c)].every(set.contains);
    final cells = [
      for (final c in cleared)
        SweepCell(
          rect: Rect.fromLTWH(
            c.col * cell + inset,
            c.row * cell + inset,
            cell - inset * 2,
            cell - inset * 2,
          ),
          // The block's own colour where the board had it; a cell of the
          // piece just placed was never on the board, and takes the theme's.
          color: switch (before.colorAt(c.row, c.col)) {
            final int i when i >= 0 =>
              theme.traySlots[i % theme.traySlots.length],
            _ => theme.placed,
          },
          order: sweepOrder(c.row, c.col, set),
          horizontal:
              rowFull(c.row) ||
              ![
                for (var r = 0; r < Board.size; r++) (r, c.col),
              ].every(set.contains),
          seed: c.row * Board.size + c.col,
        ),
    ];
    final controller = AnimationController(
      vsync: this,
      duration: clearEffectDuration(style),
    );
    final sweep = _Sweep(controller, cells, style);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _sweeps.remove(sweep));
        controller.dispose();
      }
    });
    setState(() => _sweeps.add(sweep));
    controller.forward();
  }

  @override
  void dispose() {
    for (final s in _sweeps) {
      s.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameControllerProvider, (prev, next) {
      if (prev != null &&
          next.clearEventId != prev.clearEventId &&
          next.clearedCells.isNotEmpty) {
        _start(next.clearedCells, prev.board);
      }
    });
    // One mounted painter for all sweeps, like the explosions: a fresh
    // paint layer per clear flashes on iOS Safari.
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _SweepPainter(
          sweeps: List.of(_sweeps),
          repaint: Listenable.merge([for (final s in _sweeps) s.controller]),
        ),
      ),
    );
  }
}

class _SweepPainter extends CustomPainter {
  _SweepPainter({required this.sweeps, required Listenable repaint})
    : super(repaint: repaint);

  final List<_Sweep> sweeps;

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in sweeps) {
      paintClearSweep(canvas, s.cells, s.style, s.controller.value);
    }
  }

  @override
  bool shouldRepaint(_SweepPainter old) => true;
}

/// A row of blocks dissolving in [style] over and over — the design's card
/// and stage in the designs screen.
class ClearEffectPreview extends StatefulWidget {
  const ClearEffectPreview({
    super.key,
    required this.style,
    required this.colors,
    required this.background,
    required this.size,
    this.animate = true,
  });

  final ClearEffectStyle style;

  /// The blocks' colours, in turn.
  final List<Color> colors;
  final Color background;
  final double size;
  final bool animate;

  @override
  State<ClearEffectPreview> createState() => _ClearEffectPreviewState();
}

class _ClearEffectPreviewState extends State<ClearEffectPreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _loop.repeat();
    } else {
      _loop.value = 0.35;
    }
  }

  @override
  void dispose() {
    _loop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _PreviewPainter(
          loop: _loop,
          style: widget.style,
          colors: widget.colors,
          background: widget.background,
        ),
      ),
    );
  }
}

class _PreviewPainter extends CustomPainter {
  _PreviewPainter({
    required this.loop,
    required this.style,
    required this.colors,
    required this.background,
  }) : super(repaint: loop);

  final Animation<double> loop;
  final ClearEffectStyle style;
  final List<Color> colors;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    final frame = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(10),
    );
    canvas
      ..drawRRect(frame, Paint()..color = background)
      ..save()
      ..clipRRect(frame);
    const n = 6;
    final pad = size.width * 0.06;
    final cell = (size.width - 2 * pad) / n;
    final top = size.height / 2 - cell / 2;
    final cells = [
      for (var i = 0; i < n; i++)
        SweepCell(
          rect: Rect.fromLTWH(pad + i * cell + 1, top + 1, cell - 2, cell - 2),
          color: colors.isEmpty ? Colors.white : colors[i % colors.length],
          order: i / (n - 1),
          horizontal: true,
          seed: i * 7 + 3,
        ),
    ];
    // Stand for a beat, dissolve, then stay empty a moment before the loop.
    final t = ((loop.value - 0.15) / 0.55).clamp(0.0, 1.0);
    paintClearSweep(canvas, cells, style, t);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PreviewPainter old) =>
      old.style != style || old.colors != colors || old.background != background;
}
