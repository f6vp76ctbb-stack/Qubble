/// The day's goal as three stars (owner, 29.09.2026): filled up to [stars].
library;

import 'package:flutter/material.dart';

import '../../game/daily_rewards.dart';
import '../theme.dart';

class DailyStars extends StatelessWidget {
  const DailyStars({super.key, required this.stars, this.size = 26});

  final int stars;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < DailyGoal.starScores.length; i++)
          Icon(
            i < stars ? Icons.star_rounded : Icons.star_outline_rounded,
            size: size,
            color: i < stars ? GridColors.fever : GridColors.textMuted,
          ),
      ],
    );
  }
}
