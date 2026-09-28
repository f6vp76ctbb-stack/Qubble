/// Quests and achievements on one screen (owner, 28.09.2026): the daily,
/// weekly and monthly quests with their countdowns and diamond bonuses, and
/// every achievement with a bar showing how far along it is.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/achievements.dart';
import '../../game/quests.dart';
import '../../l10n/app_localizations.dart';
import '../format.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../theme.dart';
import '../widgets/achievement_reward.dart';
import '../widgets/app_icons.dart';
import '../widgets/screen_title.dart';

class QuestsScreen extends ConsumerStatefulWidget {
  const QuestsScreen({super.key, this.initialTab = 0});

  /// 0 = quests, 1 = achievements.
  final int initialTab;

  @override
  ConsumerState<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends ConsumerState<QuestsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(
    length: 2,
    vsync: this,
    initialIndex: widget.initialTab,
  );

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      backgroundColor: GridColors.background,
      appBar: AppBar(
        title: ScreenTitle(l10n.questsTitle),
        backgroundColor: GridColors.background,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: GridColors.placed,
          labelColor: GridColors.textPrimary,
          unselectedLabelColor: GridColors.textMuted,
          tabs: [
            Tab(text: l10n.questsTitle),
            Tab(text: l10n.achievementsTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [_QuestsTab(), _AchievementsTab()],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quests

class _QuestsTab extends ConsumerStatefulWidget {
  const _QuestsTab();

  @override
  ConsumerState<_QuestsTab> createState() => _QuestsTabState();
}

class _QuestsTabState extends ConsumerState<_QuestsTab> {
  // Minutes are the smallest unit shown; a new period also brings new
  // quests, which this refresh picks up while the screen stays open.
  late final Timer _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(
      const Duration(seconds: 30),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _tick.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watched so progress refreshes after a run or a solved puzzle.
    ref.watch(gameControllerProvider);
    final game = ref.read(gameControllerProvider.notifier);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        for (final period in QuestPeriod.values) ...[
          _PeriodCard(
            period: period,
            quests: game.questViews(period),
            renewIn: game.questsRenewIn(period),
            bonusPaid: game.questSetDone(period),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _PeriodCard extends StatelessWidget {
  const _PeriodCard({
    required this.period,
    required this.quests,
    required this.renewIn,
    required this.bonusPaid,
  });

  final QuestPeriod period;
  final List<QuestView> quests;
  final Duration renewIn;
  final bool bonusPaid;

  IconData get _icon => switch (period) {
        QuestPeriod.daily => Icons.today_rounded,
        QuestPeriod.weekly => Icons.date_range_rounded,
        QuestPeriod.monthly => Icons.calendar_month_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final done = quests.where((q) => q.done).length;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: bonusPaid ? GridColors.fever : GridColors.gridLine,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_icon, size: 22, color: GridColors.fever),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  upperCaseFor(
                    questPeriodName(l10n, period),
                    Localizations.maybeLocaleOf(context)?.languageCode,
                  ),
                  style: TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: labelTracking(context, 1.2),
                  ),
                ),
              ),
              Text(
                '$done/${quests.length}',
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: GridColors.textMuted,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  l10n.questsNewIn(formatRemaining(renewIn)),
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _BonusRow(
            diamonds: kQuestBonusDiamonds[period]!,
            paid: bonusPaid,
          ),
          const SizedBox(height: 4),
          for (final q in quests) _QuestRow(view: q),
        ],
      ),
    );
  }
}

class _BonusRow extends StatelessWidget {
  const _BonusRow({required this.diamonds, required this.paid});

  final int diamonds;
  final bool paid;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: GridColors.fever.withValues(alpha: paid ? 0.22 : 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            paid ? Icons.check_circle_rounded : Icons.card_giftcard_rounded,
            size: 16,
            color: GridColors.fever,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              paid ? l10n.questsBonusEarned : l10n.questsBonus,
              style: const TextStyle(
                color: GridColors.fever,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          DiamondAmount(
            amount: diamonds,
            size: 14,
            color: GridColors.textPrimary,
          ),
        ],
      ),
    );
  }
}

class _QuestRow extends StatelessWidget {
  const _QuestRow({required this.view});

  final QuestView view;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final done = view.done;
    final shown = view.progress.clamp(0, view.quest.target);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  view.quest.description(l10n),
                  style: TextStyle(
                    color: done ? GridColors.textMuted : GridColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (done)
                const Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: GridColors.placed,
                )
              else
                CoinAmount(
                  amount: view.quest.coins,
                  size: 14,
                  color: GridColors.fever,
                ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: done ? 1 : view.fraction,
                    minHeight: 8,
                    backgroundColor: GridColors.emptyCell,
                    valueColor: const AlwaysStoppedAnimation(
                      GridColors.placed,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${l10n.count(shown)} / ${l10n.count(view.quest.target)}',
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Achievements

class _AchievementsTab extends ConsumerWidget {
  const _AchievementsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(gameControllerProvider);
    final storage = ref.read(storageProvider);
    final life = storage.lifetimeStats;
    final progress = AchievementProgress(
      games: life.games,
      highscore: storage.highscore,
      totalLines: life.totalLines,
      bestCombo: life.bestCombo,
      level: storage.playerLevel,
      streak: storage.streak,
      puzzlesSolved: storage.puzzleStars.length,
      totalPieces: life.totalPieces,
    );
    final unlocked = storage.unlockedAchievements;
    final unlockedCount =
        Achievements.catalog.where((a) => unlocked.contains(a.id)).length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AchievementsHeader(
          unlocked: unlockedCount,
          total: Achievements.catalog.length,
        ),
        const SizedBox(height: 12),
        for (final a in Achievements.catalog)
          _AchievementTile(
            achievement: a,
            done: unlocked.contains(a.id),
            value: progress.value(a.metric),
            fraction: Achievements.fraction(a, progress),
          ),
      ],
    );
  }
}

class _AchievementsHeader extends StatelessWidget {
  const _AchievementsHeader({required this.unlocked, required this.total});

  final int unlocked;
  final int total;

  @override
  Widget build(BuildContext context) {
    final frac = total == 0 ? 0.0 : unlocked / total;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            GridColors.fever.withValues(alpha: 0.3),
            GridColors.boardBackground,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(AppIcons.trophy, size: 30, color: GridColors.fever),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  L10n.of(context).achievementsUnlockedCount(unlocked, total),
                  style: const TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: frac,
              minHeight: 8,
              backgroundColor: GridColors.emptyCell,
              valueColor: const AlwaysStoppedAnimation(GridColors.fever),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({
    required this.achievement,
    required this.done,
    required this.value,
    required this.fraction,
  });

  final Achievement achievement;
  final bool done;
  final int value;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final shown = value.clamp(0, achievement.threshold);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: done ? GridColors.placed : GridColors.gridLine,
        ),
      ),
      child: Row(
        children: [
          Opacity(
            opacity: done ? 1.0 : 0.4,
            child: Text(achievement.icon, style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        achievement.title(l10n),
                        style: TextStyle(
                          color: done
                              ? GridColors.textPrimary
                              : GridColors.textMuted,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (done)
                      const Icon(
                        Icons.check_circle,
                        color: GridColors.placed,
                        size: 18,
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  achievement.description(l10n),
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                AchievementRewardLabel(
                  achievement: achievement,
                  color: done ? GridColors.placed : GridColors.textMuted,
                  size: 12,
                ),
                // Every achievement shows its bar, a finished one full: how
                // far along the player is was the point of the request.
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: done ? 1 : fraction,
                          minHeight: 7,
                          backgroundColor: GridColors.emptyCell,
                          valueColor: AlwaysStoppedAnimation(
                            done ? GridColors.placed : GridColors.traySlots[0],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${l10n.count(done ? achievement.threshold : shown)}'
                      ' / ${l10n.count(achievement.threshold)}',
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
