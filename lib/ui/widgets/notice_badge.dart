/// A small "!" that sits on a button and gently bobs (owner, 12.10.2026: "ein
/// kleines, minimal bewegendes Ausrufezeichen"). Still under reduced effects.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/settings_controller.dart';
import '../theme.dart';

class NoticeBadge extends ConsumerStatefulWidget {
  const NoticeBadge({super.key, this.size = 18});

  final double size;

  @override
  ConsumerState<NoticeBadge> createState() => _NoticeBadgeState();
}

class _NoticeBadgeState extends ConsumerState<NoticeBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bob = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void dispose() {
    _bob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final still = ref.watch(reducedEffectsProvider);
    if (still) {
      _bob.stop();
    } else if (!_bob.isAnimating) {
      _bob.repeat(reverse: true);
    }
    final badge = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: GridColors.fever,
        shape: BoxShape.circle,
        border: Border.all(color: GridColors.background, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: GridColors.fever.withValues(alpha: 0.5),
            blurRadius: 6,
          ),
        ],
      ),
      child: Icon(
        Icons.priority_high_rounded,
        size: widget.size * 0.72,
        color: Colors.black,
      ),
    );
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _bob,
        builder: (context, child) {
          final t = Curves.easeInOut.transform(_bob.value);
          // A small lift and swell — enough to catch the eye, not to nag.
          return Transform.translate(
            offset: Offset(0, -2.5 * t),
            child: Transform.scale(scale: 1 + 0.12 * t, child: child),
          );
        },
        child: badge,
      ),
    );
  }
}
