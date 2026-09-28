/// Shared cell rendering for block skins, used by the board and tray painters.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../game/block_skin.dart';

Color _darken(Color c, double amount) =>
    Color.lerp(c, Colors.black, amount) ?? c;

Color _lighten(Color c, double amount) =>
    Color.lerp(c, Colors.white, amount) ?? c;

/// Premium default (Aurora look): a subtle vertical gradient, a soft top
/// light and a thin inner rim give each block real depth — without any blur
/// (which janks / flashes white on iOS-Safari and is costly). The animated
/// skins draw their effect on top of this base.
void _paintSolid(Canvas canvas, RRect rrect, Rect rect, Color color) {
  final shader = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [_lighten(color, 0.15), color, _darken(color, 0.17)],
    stops: const [0.0, 0.55, 1.0],
  ).createShader(rect);
  canvas.drawRRect(rrect, Paint()..shader = shader);
  canvas.save();
  canvas.clipRRect(rrect);
  canvas.drawRect(
    Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height * 0.34),
    Paint()..color = Colors.white.withValues(alpha: 0.12),
  );
  canvas.restore();
  canvas.drawRRect(
    rrect.deflate(0.5),
    Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = _lighten(color, 0.30).withValues(alpha: 0.45),
  );
}

/// Fractional part, always in 0..1 (also for negative input).
double _frac(double x) => x - x.floorToDouble();

/// Paints a single filled cell in [rect] using [color] and the given [style].
///
/// Animated styles read [time] (seconds on a running clock) and [phase] (a
/// per-cell offset — the painters pass row + column, so an effect travels
/// across the board instead of every cell blinking in step). With [time] at
/// 0 each animated style is a still frame that still reads as itself; that is
/// what the reduced-effects setting shows.
void paintCell(
  Canvas canvas,
  Rect rect,
  double radius,
  Color color,
  BlockSkinStyle style, {
  double time = 0,
  double phase = 0,
}) {
  final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
  switch (style) {
    case BlockSkinStyle.solid:
      _paintSolid(canvas, rrect, rect, color);
    case BlockSkinStyle.gradient:
      final shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color, _darken(color, 0.30)],
      ).createShader(rect);
      canvas.drawRRect(rrect, Paint()..shader = shader);
    case BlockSkinStyle.glossy:
      canvas.drawRRect(rrect, Paint()..color = color);
      final highlight = Rect.fromLTWH(
        rect.left,
        rect.top,
        rect.width,
        rect.height * 0.42,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(highlight, Radius.circular(radius)),
        Paint()..color = Colors.white.withValues(alpha: 0.22),
      );
    case BlockSkinStyle.outline:
      canvas.drawRRect(rrect, Paint()..color = _darken(color, 0.55));
      canvas.drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = color,
      );
    case BlockSkinStyle.bevel:
      // Raised 3D tile: dark base, lighter inset face, top highlight strip.
      canvas.drawRRect(rrect, Paint()..color = _darken(color, 0.35));
      final inset = rect.deflate(rect.width * 0.14);
      canvas.drawRRect(
        RRect.fromRectAndRadius(inset, Radius.circular(radius * 0.7)),
        Paint()..color = color,
      );
      final topHi = Rect.fromLTWH(
        inset.left,
        inset.top,
        inset.width,
        inset.height * 0.28,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(topHi, Radius.circular(radius * 0.7)),
        Paint()..color = _lighten(color, 0.28),
      );
    case BlockSkinStyle.glow:
      // Dark core with a bright, blurred neon border.
      canvas.drawRRect(rrect, Paint()..color = _darken(color, 0.62));
      canvas.drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = color
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
      canvas.drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = _lighten(color, 0.3),
      );
    case BlockSkinStyle.stripe:
      canvas.drawRRect(rrect, Paint()..color = color);
      canvas.save();
      canvas.clipRRect(rrect);
      final stripe = Paint()
        ..color = _darken(color, 0.22)
        ..strokeWidth = rect.width * 0.16
        ..style = PaintingStyle.stroke;
      for (var d = -rect.height; d < rect.width; d += rect.width * 0.34) {
        canvas.drawLine(
          Offset(rect.left + d, rect.bottom),
          Offset(rect.left + d + rect.height, rect.top),
          stripe,
        );
      }
      canvas.restore();
    case BlockSkinStyle.crystal:
      // Faceted gem: diagonal gradient base, a bright triangular facet in the
      // upper-left, and a fine light border.
      final shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_lighten(color, 0.18), _darken(color, 0.35)],
      ).createShader(rect);
      canvas.drawRRect(rrect, Paint()..shader = shader);
      canvas.save();
      canvas.clipRRect(rrect);
      final facet = Path()
        ..moveTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top)
        ..lineTo(rect.left, rect.bottom)
        ..close();
      canvas.drawPath(
        facet,
        Paint()..color = Colors.white.withValues(alpha: 0.18),
      );
      canvas.restore();
      canvas.drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _lighten(color, 0.4),
      );
    case BlockSkinStyle.pulse:
      // Breathes: the block brightens and its rim glows on a slow beat that
      // rolls diagonally across the board.
      final beat =
          0.5 + 0.5 * math.sin(2 * math.pi * time / 1.6 - phase * 0.35);
      _paintSolid(
        canvas,
        rrect,
        rect,
        Color.lerp(_darken(color, 0.12), _lighten(color, 0.4), beat)!,
      );
      canvas.drawRRect(
        rrect.deflate(0.75),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = _lighten(color, 0.6).withValues(alpha: 0.25 + 0.5 * beat),
      );
    case BlockSkinStyle.shimmer:
      // Polished metal: a bright band sweeps diagonally over the board.
      final base = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_lighten(color, 0.3), color, _darken(color, 0.28)],
      ).createShader(rect);
      canvas.drawRRect(rrect, Paint()..shader = base);
      final u = _frac(time / 2.6 - phase / 16) * 2.4 - 0.7;
      if (u > -0.25 && u < 1.25) {
        final band = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.7),
            Colors.white.withValues(alpha: 0),
          ],
          stops: [
            (u - 0.24).clamp(0.0, 1.0),
            u.clamp(0.0, 1.0),
            (u + 0.24).clamp(0.0, 1.0),
          ],
        ).createShader(rect);
        canvas.drawRRect(rrect, Paint()..shader = band);
      }
      canvas.drawRRect(
        rrect.deflate(0.5),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = _lighten(color, 0.5).withValues(alpha: 0.6),
      );
    case BlockSkinStyle.wave:
      // A swell of light rolls across the board like a wave.
      final w = math.sin(2 * math.pi * (time / 2.2 - phase / 9));
      final c = w >= 0
          ? Color.lerp(color, _lighten(color, 0.4), w)!
          : Color.lerp(color, _darken(color, 0.3), -w)!;
      _paintSolid(canvas, rrect, rect, c);
    case BlockSkinStyle.ember:
      // Embers: a warm glow flickers up from the bottom of every block.
      _paintSolid(canvas, rrect, rect, _darken(color, 0.12));
      final flicker =
          (0.55 +
                  0.25 *
                      math.sin(time * 7.3 + phase * 1.9) *
                      math.sin(time * 3.1 + phase * 0.7) +
                  0.2 * math.sin(time * 11 + phase * 3))
              .clamp(0.0, 1.0);
      final glow = RadialGradient(
        center: const Alignment(0, 1.1),
        radius: 0.95,
        colors: [
          const Color(0xFFFFB347).withValues(alpha: 0.9 * flicker),
          const Color(0xFFFF5E3A).withValues(alpha: 0.4 * flicker),
          const Color(0x00FF5E3A),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);
      canvas.drawRRect(rrect, Paint()..shader = glow);
    case BlockSkinStyle.prism:
      // Rainbow: the hue turns, offset along the board's diagonal.
      final hsl = HSLColor.fromColor(color);
      final hue = (hsl.hue + time * 50 + phase * 22) % 360;
      _paintSolid(
        canvas,
        rrect,
        rect,
        hsl
            .withHue(hue)
            .withSaturation(math.max(hsl.saturation, 0.55))
            .toColor()
            .withValues(alpha: color.a),
      );
    case BlockSkinStyle.stardust:
      // Two tiny stars per block twinkle at their own moments.
      _paintSolid(canvas, rrect, rect, color);
      for (var k = 0; k < 2; k++) {
        final h = _frac(math.sin(phase * 12.9898 + k * 78.233) * 43758.5453);
        final twinkle = math
            .pow(math.max(0.0, math.sin(2 * math.pi * (time / 1.9 + h))), 4)
            .toDouble();
        if (twinkle < 0.02) continue;
        final centre = Offset(
          rect.left + rect.width * (0.25 + 0.5 * _frac(h * 3.1)),
          rect.top + rect.height * (0.25 + 0.5 * _frac(h * 7.7)),
        );
        final arm = rect.width * 0.2 * twinkle;
        final star = Paint()
          ..color = Colors.white.withValues(alpha: 0.9 * twinkle * color.a)
          ..strokeWidth = math.max(1.0, rect.width * 0.05)
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(
          centre.translate(-arm, 0),
          centre.translate(arm, 0),
          star,
        );
        canvas.drawLine(
          centre.translate(0, -arm),
          centre.translate(0, arm),
          star,
        );
      }
    case BlockSkinStyle.circuit:
      // A dark tile with a light running round its edge.
      canvas.drawRRect(rrect, Paint()..color = _darken(color, 0.55));
      canvas.drawRRect(
        rrect.deflate(1),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = color.withValues(alpha: 0.55 * color.a),
      );
      final edge = (Path()..addRRect(rrect.deflate(1))).computeMetrics().first;
      final length = edge.length;
      final start = _frac(time / 1.4 + phase * 0.11) * length;
      final run = length * 0.3;
      final light = Path()
        ..addPath(
          edge.extractPath(start, math.min(start + run, length)),
          Offset.zero,
        );
      if (start + run > length) {
        light.addPath(edge.extractPath(0, start + run - length), Offset.zero);
      }
      canvas.drawPath(
        light,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..color = _lighten(color, 0.3).withValues(alpha: 0.35 * color.a),
      );
      canvas.drawPath(
        light,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8
          ..strokeCap = StrokeCap.round
          ..color = _lighten(color, 0.6).withValues(alpha: color.a),
      );
    case BlockSkinStyle.ripple:
      // Rings spread from the middle of every block, like drops on water.
      _paintSolid(canvas, rrect, rect, color);
      canvas.save();
      canvas.clipRRect(rrect);
      for (var k = 0; k < 2; k++) {
        final f = _frac(time / 1.8 + phase * 0.07 + k * 0.5);
        canvas.drawCircle(
          rect.center,
          rect.width * (0.12 + 0.6 * f),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.6 + rect.width * 0.07 * (1 - f)
            ..color = Colors.white.withValues(alpha: 0.45 * (1 - f) * color.a),
        );
      }
      canvas.restore();
  }
}
