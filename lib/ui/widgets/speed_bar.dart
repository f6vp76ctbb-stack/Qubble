/// The speed bonus as a bar (owner, 29.09.2026: the "+30%" readout alone got
/// lost). Full while the next clear would earn the whole bonus, then draining
/// to empty as the bonus falls off. While full it shakes and throws sparks,
/// unless the player asked for reduced effects.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../game/scoring.dart';
import '../theme.dart';

class SpeedBar extends StatefulWidget {
  const SpeedBar({
    super.key,
    required this.lastPlacementAt,
    required this.color,
    this.reducedEffects = false,
    this.now = DateTime.now,
  });

  /// When the last piece was placed; null before the first one.
  final DateTime? lastPlacementAt;
  final Color color;
  final bool reducedEffects;

  /// The clock the bar reads; the game's placements use the wall clock.
  final DateTime Function() now;

  /// How full the bar is [elapsed] after a placement: 1 while the bonus is
  /// whole, falling to 0 in step with [ScoreKeeper.speedBonusAt].
  static double fillAfter(Duration elapsed) {
    const full = ScoreKeeper.defaultSpeedFullBelow;
    const zero = ScoreKeeper.defaultSpeedZeroAbove;
    if (elapsed <= full) return 1;
    if (elapsed >= zero) return 0;
    return (zero - elapsed).inMicroseconds / (zero - full).inMicroseconds;
  }

  @override
  State<SpeedBar> createState() => _SpeedBarState();
}

class _SpeedBarState extends State<SpeedBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ticker = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(SpeedBar old) {
    super.didUpdateWidget(old);
    if (old.lastPlacementAt != widget.lastPlacementAt) _sync();
  }

  /// Runs the ticker exactly as long as the bar has something to show, so
  /// an idle board costs no frames (and tests can still settle).
  void _sync() {
    final last = widget.lastPlacementAt;
    final left = last == null
        ? Duration.zero
        : ScoreKeeper.defaultSpeedZeroAbove - widget.now().difference(last);
    if (left <= Duration.zero) {
      _ticker.stop();
      return;
    }
    _ticker
      ..duration = left
      ..forward(from: 0);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  double get _fill {
    final last = widget.lastPlacementAt;
    if (last == null) return 0;
    return SpeedBar.fillAfter(widget.now().difference(last));
  }

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return ExcludeSemantics(
      // The "+30%" next to the score already says it in words.
      child: AnimatedBuilder(
        animation: _ticker,
        builder: (context, _) {
          final fill = _fill;
          final hot = fill >= 1 && !widget.reducedEffects;
          final t = widget.now().microsecondsSinceEpoch / 1e6;
          final shake = hot ? math.sin(t * 2 * math.pi * 14) * 1.6 : 0.0;
          return Transform.translate(
            offset: Offset(shake, 0),
            child: Row(
              children: [
                Icon(
                  Icons.bolt_rounded,
                  size: 14,
                  color: fill > 0 ? widget.color : GridColors.textMuted,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: SizedBox(
                    height: 7,
                    child: CustomPaint(
                      painter: _SpeedBarPainter(
                        fill: fill,
                        color: widget.color,
                        sparks: hot,
                        time: t,
                        rtl: rtl,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SpeedBarPainter extends CustomPainter {
  _SpeedBarPainter({
    required this.fill,
    required this.color,
    required this.sparks,
    required this.time,
    required this.rtl,
  });

  final double fill;
  final Color color;
  final bool sparks;
  final double time;
  final bool rtl;

  static const int _sparkCount = 11;
  static const Color _gold = Color(0xFFFFD166);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.height / 2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, radius),
      Paint()..color = GridColors.emptyCell,
    );
    if (fill <= 0) return;

    final width = size.width * fill;
    final left = rtl ? size.width - width : 0.0;
    final bar = Rect.fromLTWH(left, 0, width, size.height);
    if (sparks) {
      // A soft glow under the full bar.
      canvas.drawRRect(
        RRect.fromRectAndRadius(bar.inflate(2), radius),
        Paint()
          ..color = color.withValues(alpha: 0.45)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(bar, radius),
      Paint()..color = color,
    );
    if (!sparks) return;

    // Sparks fly off the leading end: each on its own cycle, fanned out back
    // over the bar (ahead of it is the screen edge when the bar is full),
    // falling a little as they fade — white-hot at first, then gold.
    final tip = Offset(rtl ? left : left + width, size.height / 2);
    final back = rtl ? 1.0 : -1.0;
    final paint = Paint();
    for (var i = 0; i < _sparkCount; i++) {
      final phase = (time * 1.8 + i / _sparkCount) % 1.0;
      // Spread from 80° up to 80° down, in a scrambled order so neighbours
      // in time do not fly side by side.
      final slot = (i * 7) % _sparkCount / (_sparkCount - 1);
      final angle = (slot - 0.5) * math.pi * 0.9;
      final distance = 3 + phase * 24;
      final p = tip +
          Offset(
            back * math.cos(angle) * distance,
            math.sin(angle) * distance + phase * phase * 8,
          );
      paint.color = Color.lerp(Colors.white, _gold, phase)!
          .withValues(alpha: (1 - phase * phase).clamp(0.0, 1.0));
      canvas.drawCircle(p, 2.6 * (1 - phase) + 0.6, paint);
    }
  }

  @override
  bool shouldRepaint(_SpeedBarPainter old) =>
      old.fill != fill ||
      old.color != color ||
      old.sparks != sparks ||
      old.time != time ||
      old.rtl != rtl;
}
