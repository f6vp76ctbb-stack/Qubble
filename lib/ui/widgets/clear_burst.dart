/// Particle burst that pops out of cleared cells. Purely decorative; it sits
/// over the board and never intercepts pointer events.
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/burst_style.dart';
import '../effects.dart';
import '../state/cosmetic_controller.dart';
import '../state/game_controller.dart';
import '../state/settings_controller.dart';
import '../state/theme_controller.dart';

class ClearBurst extends ConsumerStatefulWidget {
  const ClearBurst({super.key, required this.size, required this.cellSize});

  final double size;
  final double cellSize;

  @override
  ConsumerState<ClearBurst> createState() => _ClearBurstState();
}

class _ClearBurstState extends ConsumerState<ClearBurst>
    with TickerProviderStateMixin {
  final List<_Burst> _bursts = [];
  final Random _rng = Random();

  void _spawn(List<Offset> centers, Color color, {int lineCount = 1}) {
    // More lines → a much bigger celebration: more, faster, longer-lived
    // particles per cleared cell. Total is capped so multi-line clears stay
    // smooth on weaker devices (web canvas jank at 400+ circles).
    const maxParticles = 220;
    final intensity = 1.0 + (lineCount - 1) * 0.7;
    final reduced = ref.read(reducedEffectsProvider);
    var perCell = Effects.particles((7 * intensity).round(), reduced: reduced);
    if (centers.isNotEmpty && perCell * centers.length > maxParticles) {
      perCell = (maxParticles / centers.length).ceil();
    }
    final style = ref.read(activeBurstProvider);
    final particles = makeBurstParticles(
      _rng,
      centers,
      perCell: perCell,
      cellSize: widget.cellSize,
      intensity: intensity,
      style: style,
    );
    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (650 * intensity).clamp(650, 1100).round()),
    );
    final burst = _Burst(
      controller: controller,
      particles: particles,
      color: color,
      style: style,
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _bursts.remove(burst));
        controller.dispose();
      }
    });
    setState(() => _bursts.add(burst));
    controller.forward();
  }

  Offset _cellCenter(int row, int col) => Offset(
        (col + 0.5) * widget.cellSize,
        (row + 0.5) * widget.cellSize,
      );

  @override
  void dispose() {
    for (final b in _bursts) {
      b.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = ref.watch(activeThemeProvider).placed;
    ref.listen(gameControllerProvider, (prev, next) {
      if (next.clearEventId != (prev?.clearEventId ?? 0) &&
          next.clearedCells.isNotEmpty) {
        _spawn(
          [for (final c in next.clearedCells) _cellCenter(c.row, c.col)],
          color,
          lineCount: next.lastClearedLineCount.clamp(1, 5),
        );
      }
    });

    // ONE permanently mounted CustomPaint for all bursts: creating a fresh
    // paint layer per burst reallocates canvas surfaces mid-clear, which
    // flashes white on iOS-Safari/PWA. The painter repaints itself via the
    // merged controllers (repaint listenable), even while no burst runs.
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _ParticlePainter(
          bursts: List.of(_bursts),
          cellSize: widget.cellSize,
          repaint: Listenable.merge(
            [for (final b in _bursts) b.controller],
          ),
        ),
      ),
    );
  }
}

class _Burst {
  _Burst({
    required this.controller,
    required this.particles,
    required this.color,
    required this.style,
  });

  final AnimationController controller;
  final List<BurstParticle> particles;
  final Color color;
  final BurstStyle style;
}

class BurstParticle {
  BurstParticle({
    required this.origin,
    required this.velocity,
    this.sizeFactor = 0.18,
    this.sparkle = false,
    this.seed = 0,
  });

  final Offset origin;
  final Offset velocity;

  /// Particle radius as a fraction of the cell size (varied for depth).
  final double sizeFactor;

  /// Sparkles render white-hot instead of theme-colored.
  final bool sparkle;

  /// 0..1, fixed per particle: picks its colour and spin in the styles that
  /// vary them.
  final double seed;
}

/// The particles for one clear: [perCell] around each of [centers], shaped
/// by [style] — fire and bubbles rise, confetti and pixels fly wider.
List<BurstParticle> makeBurstParticles(
  Random rng,
  List<Offset> centers, {
  required int perCell,
  required double cellSize,
  required double intensity,
  required BurstStyle style,
}) {
  final particles = <BurstParticle>[];
  for (final c in centers) {
    for (var i = 0; i < perCell; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      var speed = cellSize * (1.0 + rng.nextDouble() * 2.6) * intensity;
      var direction = Offset(cos(angle), sin(angle));
      switch (style) {
        case BurstStyle.fire:
        case BurstStyle.bubbles:
          // Mostly upward, fanned a little.
          direction = Offset(direction.dx * 0.6, -0.6 - 0.4 * direction.dy.abs());
          speed *= style == BurstStyle.bubbles ? 0.55 : 0.8;
        case BurstStyle.confetti:
        case BurstStyle.pixels:
          speed *= 1.15;
        case BurstStyle.classic:
        case BurstStyle.stars:
          break;
      }
      particles.add(
        BurstParticle(
          origin: c,
          velocity: direction * speed,
          sizeFactor: 0.10 + rng.nextDouble() * 0.16,
          sparkle: rng.nextDouble() < 0.25,
          seed: rng.nextDouble(),
        ),
      );
    }
  }
  return particles;
}

const List<Color> _confettiColors = [
  Color(0xFFFF5D8F),
  Color(0xFFFFD166),
  Color(0xFF4FE0C6),
  Color(0xFF7C9BFF),
  Color(0xFFB57CFF),
];

/// Draws one burst at progress [t] (0..1) in [style]; [color] is the theme's.
void paintBurst(
  Canvas canvas, {
  required List<BurstParticle> particles,
  required BurstStyle style,
  required Color color,
  required double t,
  required double cellSize,
}) {
  final eased = Curves.easeOut.transform(t);
  final alpha = 1.0 - t;
  if (alpha <= 0) return;
  final paint = Paint();
  for (final p in particles) {
    switch (style) {
      case BurstStyle.classic:
        // Light gravity so the burst falls like confetti instead of fading.
        final radius = cellSize * p.sizeFactor * (1.0 - t);
        if (radius <= 0) continue;
        final pos =
            p.origin + p.velocity * eased + Offset(0, cellSize * 1.6 * t * t);
        paint.color = (p.sparkle ? const Color(0xFFFFFFFF) : color)
            .withValues(alpha: alpha);
        canvas.drawCircle(pos, radius, paint);
      case BurstStyle.confetti:
        // Paper strips in five colours, tumbling as they fall.
        final pos =
            p.origin + p.velocity * eased + Offset(0, cellSize * 2.4 * t * t);
        final w = cellSize * (0.12 + p.sizeFactor * 0.6);
        paint.color = _confettiColors[(p.seed * _confettiColors.length).floor()]
            .withValues(alpha: min(1, alpha * 1.4));
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(p.seed * 6 + t * (8 + p.seed * 10));
        // Tumbling: the strip narrows and widens as it turns.
        canvas.scale(1, cos(t * 14 + p.seed * 6).abs() * 0.8 + 0.2);
        canvas.drawRect(
          Rect.fromCenter(center: Offset.zero, width: w, height: w * 0.45),
          paint,
        );
        canvas.restore();
      case BurstStyle.fire:
        // Embers rising from white-hot through orange to a dark red.
        final pos = p.origin + p.velocity * eased;
        final radius = cellSize * p.sizeFactor * (1.2 - t) * 1.1;
        if (radius <= 0) continue;
        final heat = (t + p.seed * 0.3).clamp(0.0, 1.0);
        paint.color = Color.lerp(
          Color.lerp(
            const Color(0xFFFFF3B0),
            const Color(0xFFFF8A1F),
            (heat * 2).clamp(0.0, 1.0),
          ),
          const Color(0xFFB3261E),
          ((heat - 0.5) * 2).clamp(0.0, 1.0),
        )!;
        // A soft halo first, then a brighter core: embers glow, dots do not.
        paint.color = paint.color.withValues(alpha: alpha * 0.35);
        canvas.drawCircle(pos, radius * 1.8, paint);
        paint.color = paint.color.withValues(alpha: alpha);
        canvas.drawCircle(pos, radius, paint);
        paint.color = const Color(0xFFFFF6C8).withValues(alpha: alpha * 0.8);
        canvas.drawCircle(pos, radius * 0.4, paint);
      case BurstStyle.pixels:
        // Square shards in the block's colour, falling hard.
        final pos =
            p.origin + p.velocity * eased + Offset(0, cellSize * 2.8 * t * t);
        final side = cellSize * (0.14 + p.sizeFactor * 0.5) * (1 - t * 0.5);
        paint.color = (p.sparkle ? Color.lerp(color, Colors.white, 0.5)! : color)
            .withValues(alpha: alpha);
        canvas.drawRect(
          Rect.fromCenter(center: pos, width: side, height: side),
          paint,
        );
      case BurstStyle.stars:
        // Spinning gold and white stars.
        final pos =
            p.origin + p.velocity * eased + Offset(0, cellSize * 1.2 * t * t);
        final r = cellSize * (0.1 + p.sizeFactor * 0.7) * (1 - t * 0.6);
        paint.color = (p.sparkle ? Colors.white : const Color(0xFFFFD24A))
            .withValues(alpha: alpha);
        canvas.drawPath(_star(pos, r, t * 6 + p.seed * 6), paint);
      case BurstStyle.bubbles:
        // Soap bubbles drifting up, swelling, then popping.
        final wobble = sin(t * 12 + p.seed * 6) * cellSize * 0.15;
        final pos = p.origin + p.velocity * eased + Offset(wobble, 0);
        final r = cellSize * (0.12 + p.sizeFactor * 0.8) * (0.6 + t * 0.7);
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = max(0.8, cellSize * 0.035)
          ..color = Color.lerp(Colors.white, const Color(0xFF9FE4FF), p.seed)!
              .withValues(alpha: alpha);
        canvas.drawCircle(pos, r, paint);
        paint.style = PaintingStyle.fill;
        paint.color = Colors.white.withValues(alpha: alpha * 0.8);
        canvas.drawCircle(pos + Offset(-r * 0.35, -r * 0.35), r * 0.18, paint);
    }
  }
}

/// A five-pointed star around [c] with outer radius [r], turned by [turn].
Path _star(Offset c, double r, double turn) {
  final path = Path();
  for (var i = 0; i < 10; i++) {
    final radius = i.isEven ? r : r * 0.45;
    final a = turn + i * pi / 5 - pi / 2;
    final p = c + Offset(cos(a), sin(a)) * radius;
    if (i == 0) {
      path.moveTo(p.dx, p.dy);
    } else {
      path.lineTo(p.dx, p.dy);
    }
  }
  return path..close();
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.bursts,
    required this.cellSize,
    super.repaint,
  });

  final List<_Burst> bursts;
  final double cellSize;

  @override
  void paint(Canvas canvas, Size size) {
    for (final burst in bursts) {
      paintBurst(
        canvas,
        particles: burst.particles,
        style: burst.style,
        color: burst.color,
        t: burst.controller.value,
        cellSize: cellSize,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => true;
}

/// A looping explosion on a strip of four blocks, for the designs screen.
class BurstPreview extends StatefulWidget {
  const BurstPreview({
    super.key,
    required this.style,
    required this.color,
    required this.background,
    this.size = 72,
    this.animate = true,
  });

  final BurstStyle style;
  final Color color;
  final Color background;
  final double size;

  /// Off shows a still mid-burst frame (reduced effects, tests).
  final bool animate;

  @override
  State<BurstPreview> createState() => _BurstPreviewState();
}

class _BurstPreviewState extends State<BurstPreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );
  late List<BurstParticle> _particles = _make();

  List<BurstParticle> _make() {
    final cell = widget.size / 6;
    return makeBurstParticles(
      Random(7),
      [
        for (var i = 1; i < 5; i++)
          Offset((i + 0.5) * cell, widget.size * 0.55),
      ],
      perCell: 6,
      cellSize: cell,
      intensity: 1,
      style: widget.style,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _loop.repeat();
    } else {
      _loop.value = 0.3;
    }
  }

  @override
  void didUpdateWidget(BurstPreview old) {
    super.didUpdateWidget(old);
    if (old.style != widget.style || old.size != widget.size) {
      _particles = _make();
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
          particles: _particles,
          style: widget.style,
          color: widget.color,
          background: widget.background,
        ),
      ),
    );
  }
}

class _PreviewPainter extends CustomPainter {
  _PreviewPainter({
    required this.loop,
    required this.particles,
    required this.style,
    required this.color,
    required this.background,
  }) : super(repaint: loop);

  final Animation<double> loop;
  final List<BurstParticle> particles;
  final BurstStyle style;
  final Color color;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      Paint()..color = background,
    );
    final cell = size.width / 6;
    // The row blinks back in for the last fifth of the loop, so the burst
    // reads as blocks that clear.
    final t = loop.value;
    if (t > 0.8) {
      final a = (t - 0.8) / 0.2;
      for (var i = 1; i < 5; i++) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset((i + 0.5) * cell, size.height * 0.55),
              width: cell * 0.9,
              height: cell * 0.9,
            ),
            Radius.circular(cell * 0.2),
          ),
          Paint()..color = color.withValues(alpha: a),
        );
      }
    }
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
    );
    paintBurst(
      canvas,
      particles: particles,
      style: style,
      color: color,
      t: (t / 0.8).clamp(0.0, 1.0),
      cellSize: cell,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PreviewPainter old) =>
      old.style != style || old.color != color || old.particles != particles;
}
