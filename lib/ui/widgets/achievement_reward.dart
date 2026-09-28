/// What an achievement pays: a coin amount, or the animated skin it unlocks,
/// shown moving on a tiny board so the reward sells itself.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/achievements.dart';
import '../../game/block_skin.dart';
import '../../l10n/app_localizations.dart';
import '../l10n_maps.dart';
import '../state/settings_controller.dart';
import '../state/theme_controller.dart';
import 'app_icons.dart';
import 'mini_board_preview.dart';

class AchievementRewardLabel extends ConsumerWidget {
  const AchievementRewardLabel({
    super.key,
    required this.achievement,
    required this.color,
    this.size = 13,
  });

  final Achievement achievement;
  final Color color;

  /// Font size of the label; the coin and the preview scale with it.
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skinId = achievement.skinId;
    if (skinId == null) {
      return CoinAmount(
        amount: achievement.coins,
        size: size + 2,
        color: color,
        prefix: '+',
      );
    }
    final l10n = L10n.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MiniBoardPreview(
          theme: ref.watch(activeThemeProvider),
          style: skinStyleById(skinId),
          size: size * 3,
          animate: !ref.watch(reducedEffectsProvider),
        ),
        SizedBox(width: size * 0.5),
        Flexible(
          child: Text(
            l10n.achievementRewardSkin(skinName(l10n, skinId)),
            style: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
