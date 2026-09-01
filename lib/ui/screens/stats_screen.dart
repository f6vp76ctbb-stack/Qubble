/// Lifetime statistics overview — a visual dashboard rather than a number grid.
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/achievements.dart';
import '../../game/leveling.dart';
import '../../l10n/app_localizations.dart';
import '../state/game_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import 'achievements_screen.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.read(storageProvider);
    final stats = storage.lifetimeStats;
    final puzzleStars = storage.puzzleStars;
    final puzzlesSolved = puzzleStars.length;
    final totalStars = puzzleStars.values.fold(0, (a, b) => a + b);

    final level = storage.playerLevel;
    final xp = storage.xp;
    final xpForNext = LevelSystem.xpForNext(level);

    final l10n = L10n.of(context);
    final cards = <_StatData>[
      _StatData(
        Icons.casino_outlined,
        GridColors.traySlots[0],
        l10n.statsGames,
        '${stats.games}',
      ),
      _StatData(
        Icons.trending_up,
        GridColors.placed,
        l10n.statsAverageScore,
        '${stats.averageScore}',
      ),
      _StatData(
        Icons.bolt,
        GridColors.fever,
        l10n.statsBestCombo,
        '${max(stats.bestCombo, 0)}',
      ),
      _StatData(
        Icons.grid_on,
        GridColors.traySlots[1 % GridColors.traySlots.length],
        l10n.statsLinesCleared,
        '${stats.totalLines}',
      ),
      _StatData(
        Icons.extension,
        GridColors.traySlots[2 % GridColors.traySlots.length],
        l10n.statsPiecesPlaced,
        '${stats.totalPieces}',
      ),
      _StatData(
        Icons.paid_outlined,
        GridColors.fever,
        l10n.statsCoins,
        '${storage.coins}',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statsTitle),
        backgroundColor: GridColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _HeroCard(
            highscore: storage.highscore,
            level: level,
            xp: xp,
            xpForNext: xpForNext,
          ),
          const SizedBox(height: 16),
          // A fixed aspect ratio gave every cell 105 logical pixels of height
          // at 360 px wide, which the card's icon, value and label overran by
          // 14 — before any font scaling. Sizing the cell from the text scale
          // instead means the grid grows with the setting rather than clipping.
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: _statCardHeight(context),
            children: [for (final c in cards) _StatCard(data: c)],
          ),
          const SizedBox(height: 16),
          _PuzzleCard(solved: puzzlesSolved, stars: totalStars),
          const SizedBox(height: 16),
          _AchievementsLink(
            unlocked: storage.unlockedAchievements.length,
            total: Achievements.catalog.length,
          ),
        ],
      ),
    );
  }
}

class _AchievementsLink extends StatelessWidget {
  const _AchievementsLink({required this.unlocked, required this.total});

  final int unlocked;
  final int total;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const AchievementsScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: GridColors.gridLine),
        ),
        child: Row(
          children: [
            const Icon(AppIcons.trophy, size: 24, color: GridColors.fever),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                L10n.of(context).achievementsTitle,
                style: const TextStyle(
                  color: GridColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Text(
                L10n.of(context).statsAchievementsRatio(unlocked, total),
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: GridColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.highscore,
    required this.level,
    required this.xp,
    required this.xpForNext,
  });

  final int highscore;
  final int level;
  final int xp;
  final int xpForNext;

  @override
  Widget build(BuildContext context) {
    final progress = xpForNext == 0 ? 0.0 : (xp / xpForNext).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            GridColors.placed.withValues(alpha: 0.35),
            GridColors.boardBackground,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(AppIcons.trophy, size: 34, color: GridColors.fever),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.of(context).homeBestScore,
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 12,
                        letterSpacing: 1.5,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$highscore',
                        style: const TextStyle(
                          color: GridColors.textPrimary,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  L10n.of(context).commonLevelShort(level),
                  style: const TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  L10n.of(context).homeXpProgress(xp, xpForNext),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: GridColors.emptyCell,
              valueColor: AlwaysStoppedAnimation(GridColors.traySlots[0]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Height one stat card needs: the icon block and the two text lines, plus
/// padding, with the text parts following the system font scale.
///
/// Capped at 1.6x so an extreme accessibility setting stretches the grid into
/// something scrollable rather than unusable — the card's own FittedBox and
/// ellipsis take it from there.
double _statCardHeight(BuildContext context) {
  final scaler = MediaQuery.textScalerOf(context);
  const iconBlock = 36.0; // 8 padding + 20 icon + 8 padding
  const verticalPadding = 28.0; // 14 top + 14 bottom
  final value = scaler.scale(24) * 1.2;
  final label = scaler.scale(12) * 1.3;
  final raw = iconBlock + value + label + verticalPadding + 8;
  return raw.clamp(105.0, 105.0 * 1.6);
}

class _StatData {
  const _StatData(this.icon, this.color, this.label, this.value);
  final IconData icon;
  final Color color;
  final String label;
  final String value;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.data});

  final _StatData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(data.icon, color: data.color, size: 20),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                data.value,
                style: const TextStyle(
                  color: GridColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Text(
            data.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: GridColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _PuzzleCard extends StatelessWidget {
  const _PuzzleCard({required this.solved, required this.stars});

  final int solved;
  final int stars;

  @override
  Widget build(BuildContext context) {
    // Up to 3 stars per solved level.
    final maxStars = solved * 3;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.extension_outlined,
                color: GridColors.placed,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  L10n.of(context).puzzleModeTitle,
                  style: const TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  L10n.of(context).puzzleSolvedCount(solved),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.star_rounded, size: 22, color: GridColors.fever),
              const SizedBox(width: 8),
              Text(
                '$stars',
                style: const TextStyle(
                  color: GridColors.fever,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (maxStars > 0) ...[
                const SizedBox(width: 4),
                Text(
                  '/ $maxStars',
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
          if (maxStars > 0) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: (stars / maxStars).clamp(0.0, 1.0),
                minHeight: 7,
                backgroundColor: GridColors.emptyCell,
                valueColor: const AlwaysStoppedAnimation(GridColors.fever),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
