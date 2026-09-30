/// Draws the accessories (lib/game/accessory.dart) on top of a painted block,
/// whatever its skin. Everything stays inside the block's own rect, so a
/// neighbour is never covered, and reads at tray size as well as on the
/// board.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../game/accessory.dart';

/// Paints [style] over the block in [rect]. [alpha] follows the block (a
/// faded tray piece fades its accessory too).
void paintAccessory(
  Canvas canvas,
  Rect rect,
  AccessoryStyle style, {
  double alpha = 1,
}) {
  final s = rect.width;
  switch (style) {
    case AccessoryStyle.none:
      return;
    case AccessoryStyle.cobweb:
      // A web in the top-left corner: threads fanning out from the corner,
      // crossed by three sagging rings.
      final corner = rect.topLeft;
      final reach = s * 0.62;
      final thread = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = math.max(0.6, s * 0.025)
        ..color = Colors.white.withValues(alpha: 0.78 * alpha);
      const spokes = 4;
      final ends = <Offset>[
        for (var i = 0; i < spokes; i++)
          corner +
              Offset.fromDirection(
                math.pi / 2 * i / (spokes - 1),
                reach,
              ),
      ];
      for (final end in ends) {
        canvas.drawLine(corner, end, thread);
      }
      for (final f in [0.35, 0.62, 0.9]) {
        final ring = Path();
        for (var i = 0; i < spokes; i++) {
          final p = Offset.lerp(corner, ends[i], f)!;
          if (i == 0) {
            ring.moveTo(p.dx, p.dy);
          } else {
            final prev = Offset.lerp(corner, ends[i - 1], f)!;
            // Sags toward the corner, like a real web.
            final mid = Offset.lerp(prev, p, 0.5)!;
            final sag = Offset.lerp(mid, corner, 0.12)!;
            ring.quadraticBezierTo(sag.dx, sag.dy, p.dx, p.dy);
          }
        }
        canvas.drawPath(ring, thread);
      }
    case AccessoryStyle.snowCap:
      // Snow resting on the top edge, with two short drips.
      final top = rect.top;
      final depth = s * 0.26;
      final cap = Path()
        ..moveTo(rect.left, top + s * 0.08)
        ..quadraticBezierTo(rect.left, top, rect.left + s * 0.1, top)
        ..lineTo(rect.right - s * 0.1, top)
        ..quadraticBezierTo(rect.right, top, rect.right, top + s * 0.08)
        ..lineTo(rect.right, top + depth * 0.7)
        ..quadraticBezierTo(
          rect.right - s * 0.12,
          top + depth * 1.05,
          rect.right - s * 0.25,
          top + depth * 0.75,
        )
        ..quadraticBezierTo(
          rect.left + s * 0.62,
          top + depth * 0.55,
          rect.left + s * 0.55,
          top + depth * 1.15,
        )
        ..quadraticBezierTo(
          rect.left + s * 0.45,
          top + depth * 0.6,
          rect.left + s * 0.28,
          top + depth * 0.8,
        )
        ..quadraticBezierTo(
          rect.left + s * 0.1,
          top + depth * 1.0,
          rect.left,
          top + depth * 0.65,
        )
        ..close();
      canvas.drawPath(
        cap,
        Paint()..color = const Color(0xFFF4FAFF).withValues(alpha: alpha),
      );
      canvas.drawPath(
        cap,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(0.5, s * 0.02)
          ..color = const Color(0xFFB9D8F0).withValues(alpha: 0.9 * alpha),
      );
    case AccessoryStyle.crown:
      // A small gold crown sitting on the top edge.
      final w = s * 0.5;
      final h = s * 0.3;
      final left = rect.center.dx - w / 2;
      final base = rect.top + h + s * 0.04;
      final crown = Path()
        ..moveTo(left, base)
        ..lineTo(left, rect.top + s * 0.1)
        ..lineTo(left + w * 0.25, rect.top + h * 0.62)
        ..lineTo(left + w * 0.5, rect.top + s * 0.04)
        ..lineTo(left + w * 0.75, rect.top + h * 0.62)
        ..lineTo(left + w, rect.top + s * 0.1)
        ..lineTo(left + w, base)
        ..close();
      canvas.drawPath(
        crown,
        Paint()..color = const Color(0xFFFFD24A).withValues(alpha: alpha),
      );
      canvas.drawPath(
        crown,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(0.6, s * 0.025)
          ..color = const Color(0xFFB9820F).withValues(alpha: alpha),
      );
      canvas.drawCircle(
        Offset(left + w * 0.5, base - h * 0.28),
        s * 0.045,
        Paint()..color = const Color(0xFFFF4F79).withValues(alpha: alpha),
      );
    case AccessoryStyle.flower:
      // A little flower in the bottom-right corner.
      final c = Offset(rect.right - s * 0.24, rect.bottom - s * 0.24);
      final r = s * 0.1;
      final petal = Paint()
        ..color = const Color(0xFFFFF3FA).withValues(alpha: alpha);
      for (var i = 0; i < 5; i++) {
        canvas.drawCircle(
          c + Offset.fromDirection(2 * math.pi * i / 5 - math.pi / 2, r),
          r * 0.78,
          petal,
        );
      }
      canvas.drawCircle(
        c,
        r * 0.62,
        Paint()..color = const Color(0xFFFFC93C).withValues(alpha: alpha),
      );
    case AccessoryStyle.sparkle:
      // Two four-pointed glints, a big one top right and a small one below.
      void glint(Offset c, double r) {
        final p = Path()
          ..moveTo(c.dx, c.dy - r)
          ..quadraticBezierTo(c.dx, c.dy, c.dx + r, c.dy)
          ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy + r)
          ..quadraticBezierTo(c.dx, c.dy, c.dx - r, c.dy)
          ..quadraticBezierTo(c.dx, c.dy, c.dx, c.dy - r)
          ..close();
        canvas.drawPath(
          p,
          Paint()..color = Colors.white.withValues(alpha: 0.95 * alpha),
        );
      }

      glint(Offset(rect.right - s * 0.26, rect.top + s * 0.26), s * 0.2);
      glint(Offset(rect.right - s * 0.52, rect.top + s * 0.5), s * 0.1);
    case AccessoryStyle.dewdrop:
      // A drop of water running down the left side, with its highlight.
      final c = Offset(rect.left + s * 0.3, rect.top + s * 0.58);
      final r = s * 0.13;
      final drop = Path()
        ..moveTo(c.dx, c.dy - r * 2.1)
        ..quadraticBezierTo(c.dx + r * 1.1, c.dy - r * 0.4, c.dx + r, c.dy)
        ..arcToPoint(
          Offset(c.dx - r, c.dy),
          radius: Radius.circular(r),
        )
        ..quadraticBezierTo(c.dx - r * 1.1, c.dy - r * 0.4, c.dx, c.dy - r * 2.1)
        ..close();
      canvas.drawPath(
        drop,
        Paint()..color = const Color(0xFFBFEFFF).withValues(alpha: 0.7 * alpha),
      );
      canvas.drawPath(
        drop,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(0.5, s * 0.02)
          ..color = Colors.white.withValues(alpha: 0.85 * alpha),
      );
      canvas.drawCircle(
        c + Offset(-r * 0.35, -r * 0.35),
        r * 0.28,
        Paint()..color = Colors.white.withValues(alpha: 0.95 * alpha),
      );
  }
}
