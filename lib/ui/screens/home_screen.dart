/// Home screen: title, best score, coins, and entry into endless / daily.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/daily.dart';
import '../../game/leveling.dart';
import '../../game/name_filter.dart';
import '../../game/piggy_bank.dart';
import '../../game/streak.dart';
import '../../l10n/app_localizations.dart';
import '../../monetization/iap.dart';
import '../format.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/settings_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import '../widgets/menu_particles.dart';
import 'daily_screen.dart';
import 'game_screen.dart';
import 'how_to_play_screen.dart';
import 'leaderboard_screen.dart';
import 'missions_screen.dart';
import 'puzzle_levels_screen.dart';
import 'settings_screen.dart';
import 'shop_screen.dart';
import 'skins_screen.dart';
import 'stats_screen.dart';
import 'themes_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  /// When the last back press happened, for the confirm-to-exit guard.
  DateTime? _lastBackPress;

  /// Android's back button used to close the app straight from the menu, with
  /// no confirmation — easy to hit by accident mid-session.
  bool _allowExit() {
    final now = DateTime.now();
    final last = _lastBackPress;
    if (last != null && now.difference(last) < const Duration(seconds: 2)) {
      return true;
    }
    _lastBackPress = now;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(L10n.of(context).homeBackToExit),
      ),
    );
    return false;
  }

  void _openGame(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const GameScreen()));
  }

  /// Choosing a first leaderboard name is optional and free. Later changes
  /// consume a purchased rename credit so a public identity stays stable.
  Future<void> _changeName(
    BuildContext context,
    WidgetRef ref,
    String currentName,
    int renameCredits,
  ) async {
    if (currentName.isEmpty) {
      await _renameDialog(context, ref, firstName: true);
      return;
    }
    if (renameCredits > 0) {
      await _renameDialog(context, ref);
      return;
    }
    final buy = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GridColors.boardBackground,
        title: Text(
          L10n.of(dialogContext).nameChangeTitle,
          style: TextStyle(color: GridColors.textPrimary),
        ),
        content: Text(
L10n.of(dialogContext).nameChangeExplainer,
          style: TextStyle(color: GridColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(L10n.of(dialogContext).commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(L10n.of(dialogContext).commonBuy),
          ),
        ],
      ),
    );
    if (buy ?? false) {
      await ref.read(iapServiceProvider).buy(IapProducts.rename);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              L10n.of(context).nameChangeAfterPurchase,
            ),
          ),
        );
      }
    }
  }

  Future<void> _renameDialog(
    BuildContext context,
    WidgetRef ref, {
    bool firstName = false,
  }) async {
    final controller = TextEditingController();
    // Disposed below: a dialog-local controller is not owned by any State, so
    // nothing else ever released it.
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GridColors.boardBackground,
        title: Text(
          firstName ? L10n.of(context).homeEnableLeaderboard : L10n.of(dialogContext).nameNewName,
          style: const TextStyle(color: GridColors.textPrimary),
        ),
        // The name is published to every other player, so the rule that governs
        // it is stated here, at the moment it is chosen, rather than buried in
        // a terms screen nobody opens. Google's UGC policy asks for exactly
        // this: the rule accepted before the content is created.
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              maxLength: 14,
              textCapitalization: TextCapitalization.words,
              style: const TextStyle(color: GridColors.textPrimary),
              decoration: InputDecoration(
                hintText: L10n.of(dialogContext).nameFieldLabel,
              ),
            ),
            Text(
              L10n.of(dialogContext).leaderboardRules,
              style: const TextStyle(
                color: GridColors.textMuted,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(L10n.of(dialogContext).commonCancel),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text.trim()),
            // Saving is the acknowledgement of the rule shown above it.
            child: Text(
              firstName
                  ? L10n.of(dialogContext).leaderboardRulesAccept
                  : L10n.of(dialogContext).commonSave,
            ),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null) return;
    final problem = NameFilter.problem(name);
    if (problem != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(nameProblemText(L10n.of(context), problem))));
      }
      return;
    }
    if (firstName) {
      await ref.read(gameControllerProvider.notifier).setPlayerName(name);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.of(context).nameJoinedLeaderboard)),
        );
      }
      return;
    }
    final ok = await ref
        .read(gameControllerProvider.notifier)
        .renameWithCredit(name);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context).nameRenameUnavailable)),
      );
    }
  }

  /// Opens the piggy bank (free when full, or early via a bonus video).
  void _handlePiggy(BuildContext context, WidgetRef ref, PiggyBank piggy) {
    if (piggy.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            L10n.of(context).piggyFillingHint,
          ),
        ),
      );
      return;
    }
    final controller = ref.read(gameControllerProvider.notifier);
    if (piggy.isFull) {
      // A full bank pays out for free — the piggy is a reward, not a purchase.
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: GridColors.boardBackground,
          title: Text(
            L10n.of(dialogContext).piggyFullTitle,
            style: TextStyle(color: GridColors.textPrimary),
          ),
          content: Text(
            L10n.of(dialogContext).piggyCollect(piggy.coins),
            style: const TextStyle(color: GridColors.textMuted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(L10n.of(dialogContext).commonLater),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                controller.openPiggy();
              },
              child: Text(L10n.of(dialogContext).commonCollect),
            ),
          ],
        ),
      );
      return;
    }
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GridColors.boardBackground,
        title: Text(
          L10n.of(dialogContext).piggyTitle,
          style: TextStyle(color: GridColors.textPrimary),
        ),
        content: Text(
'${L10n.of(dialogContext).piggyProgress(piggy.coins, piggy.capacity)}'
          '\n\n${L10n.of(dialogContext).piggyEarlyOpenHint}',
          style: const TextStyle(color: GridColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(L10n.of(dialogContext).piggyKeepSaving),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              controller.openPiggyWithAd();
            },
            child: Text(L10n.of(dialogContext).piggyOpenNow),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final snap = ref.watch(gameControllerProvider);
    final controller = ref.read(gameControllerProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_allowExit()) SystemNavigator.pop();
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Subtle drifting particles behind everything.
            Positioned.fill(
              child: MenuParticles(
                colors: ref.watch(activeThemeProvider).traySlots,
                reduced: ref.watch(reducedEffectsProvider),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                // Scrolls when the content is taller than the screen (small phones,
                // landscape), while the Spacers still center it when there's room.
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              runSpacing: 8,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      // Icon-only, so the tooltip is also the
                                      // label a screen reader announces.
                                      tooltip: l10n.shopTitle,
                                      icon: const Icon(
                                        Icons.shopping_bag_outlined,
                                        color: GridColors.textPrimary,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (_) =>
                                                  const ShopScreen(),
                                            ),
                                          ),
                                    ),
                                    IconButton(
                                      // Icon-only, so the tooltip is also the
                                      // label a screen reader announces.
                                      tooltip: l10n.statsTitle,
                                      icon: const Icon(
                                        Icons.bar_chart,
                                        color: GridColors.textPrimary,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (_) =>
                                                  const StatsScreen(),
                                            ),
                                          ),
                                    ),
                                    IconButton(
                                      // Icon-only, so the tooltip is also the
                                      // label a screen reader announces.
                                      tooltip: l10n.settingsTitle,
                                      icon: const Icon(
                                        Icons.settings_outlined,
                                        color: GridColors.textPrimary,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (_) =>
                                                  const SettingsScreen(),
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _PiggyChip(
                                      coins: snap.piggyCoins,
                                      capacity: snap.piggyCapacity,
                                      onTap: () => _handlePiggy(
                                        context,
                                        ref,
                                        PiggyBank(
                                          coins: snap.piggyCoins,
                                          capacity: snap.piggyCapacity,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Three chips of text side by side: at a
                                    // large system font they need to give,
                                    // and shrinking beats clipping one off.
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            _CoinPill(coins: snap.coins),
                                            const SizedBox(width: 8),
                                            _DiamondPill(
                                              diamonds: snap.diamonds,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(flex: 2),
                            // Compact brand + profile (deliberately understated).
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // The largest text on the screen, so it is the
                                // first thing to run out of room as the system
                                // font size goes up — and it sits next to a
                                // 48px minimum tap target that will not shrink.
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      l10n.appTitle,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: GridColors.textPrimary,
                                        fontSize: 34,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2),
                                IconButton(
                                  tooltip: l10n.homeHowToPlay,
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(
                                    Icons.help_outline_rounded,
                                    color: GridColors.textMuted,
                                    size: 21,
                                  ),
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => const HowToPlayScreen(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Playing never requires a name. Tapping this compact profile
                            // control opts into the public leaderboard; later renames are paid.
                            GestureDetector(
                              onTap: () => _changeName(
                                context,
                                ref,
                                snap.playerName,
                                snap.renameCredits,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    snap.playerName.isEmpty
                                        ? Icons.person_add_alt_1_outlined
                                        : Icons.person,
                                    size: 13,
                                    color: GridColors.textMuted,
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      snap.playerName.isEmpty
                                          ? L10n.of(context).homeEnableLeaderboard
                                          : snap.supporter
                                          ? '${snap.playerName} ❤️'
                                          : snap.playerName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: GridColors.textMuted,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Icon(
                                    snap.playerName.isEmpty
                                        ? Icons.arrow_forward_ios_rounded
                                        : snap.renameCredits > 0
                                        ? Icons.vpn_key_rounded
                                        : Icons.lock_outline_rounded,
                                    size: 12,
                                    color: GridColors.textMuted,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(flex: 3),
                            // Prominent best score, right above the play button.
                            Text(
                              l10n.homeBestScore,
                              style: TextStyle(
                                color: GridColors.textMuted,
                                fontSize: 13,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.count(snap.highscore),
                              style: const TextStyle(
                                color: GridColors.placed,
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _PrimaryButton(
                              // A run in progress resumes instead of silently
                              // restarting — including an Endless run parked
                              // while the Daily Challenge was played.
                              label: snap.runActive || snap.parkedEndlessRun
                                  ? l10n.homeContinueRun
                                  : l10n.commonPlay,
                              onPressed: () {
                                ref.read(musicProvider).ensureStarted();
                                if (snap.runActive) {
                                  _openGame(context);
                                  return;
                                }
                                if (snap.parkedEndlessRun &&
                                    controller.resumeEndlessRun()) {
                                  _openGame(context);
                                  return;
                                }
                                controller.newGame();
                                _openGame(context);
                              },
                            ),
                            if (snap.runActive || snap.parkedEndlessRun)
                              TextButton(
                                onPressed: () {
                                  ref.read(musicProvider).ensureStarted();
                                  controller.newGame();
                                  _openGame(context);
                                },
                                child: Text(
                                  l10n.homeNewRun,
                                  style: TextStyle(color: GridColors.textMuted),
                                ),
                              ),
                            const SizedBox(height: 12),
                            _LevelBadge(
                              level: snap.playerLevel,
                              xp: snap.xpIntoLevel,
                              xpForNext: snap.xpForNextLevel,
                            ),
                            if (snap.weekendActive) ...[
                              const SizedBox(height: 12),
                              const _WeekendBanner(),
                            ],
                            const SizedBox(height: 14),
                            if (snap.streakRepairAvailable) ...[
                              _StreakRepairBanner(streak: snap.streak),
                              const SizedBox(height: 14),
                            ],
                            _DailyCard(
                              streak: snap.streak,
                              playedToday: snap.dailyPlayedToday,
                              onPlay: () {
                                ref.read(musicProvider).ensureStarted();
                                controller.startDaily();
                                _openGame(context);
                              },
                              onOpenCalendar: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const DailyScreen(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: _SecondaryButton(
                                    icon: Icons.emoji_events_outlined,
                                    label: l10n.homeLeaderboard,
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) =>
                                            const LeaderboardScreen(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _SecondaryButton(
                                    icon: Icons.extension_outlined,
                                    label: l10n.homePuzzleMode,
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) =>
                                            const PuzzleLevelsScreen(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: _SecondaryButton(
                                    icon: Icons.flag_outlined,
                                    label: l10n.homeMissions,
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) => const MissionsScreen(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _SecondaryButton(
                                    icon: Icons.palette_outlined,
                                    label: l10n.homeThemes,
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) => const ThemesScreen(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _SecondaryButton(
                                    icon: Icons.grid_view,
                                    label: l10n.homeSkins,
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) => const SkinsScreen(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoinPill extends StatelessWidget {
  const _CoinPill({required this.coins});

  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CoinAmount(
        amount: coins,
        size: 17,
        color: GridColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DiamondPill extends StatelessWidget {
  const _DiamondPill({required this.diamonds});

  final int diamonds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DiamondAmount(
        amount: diamonds,
        size: 17,
        color: GridColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(58),
        // styleFrom's textStyle replaces the theme's, so the family has to
        // be repeated — without it the label falls back to the platform font.
        textStyle: const TextStyle(
          fontFamily: kAppFontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _PiggyChip extends StatelessWidget {
  const _PiggyChip({
    required this.coins,
    required this.capacity,
    required this.onTap,
  });

  final int coins;
  final int capacity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final piggy = PiggyBank(coins: coins, capacity: capacity);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(20),
          border: piggy.showHint ? Border.all(color: GridColors.fever) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.savings_rounded,
              size: 16,
              color: piggy.showHint ? GridColors.fever : GridColors.textMuted,
            ),
            const SizedBox(width: 5),
            Text(
              '$coins',
              style: TextStyle(
                color: piggy.showHint
                    ? GridColors.fever
                    : GridColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekendBanner extends StatelessWidget {
  const _WeekendBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: GridColors.fever.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: GridColors.fever),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(AppIcons.celebrate, size: 16, color: GridColors.fever),
          const SizedBox(width: 7),
          // Flexible + ellipsis: the label must survive narrow phones and a
          // large system font scale without overflowing the pill.
          Flexible(
            child: Text(
              L10n.of(context).homeWeekendBonus,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: GridColors.fever,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({
    required this.level,
    required this.xp,
    required this.xpForNext,
  });

  final int level;
  final int xp;
  final int xpForNext;

  @override
  Widget build(BuildContext context) {
    final progress = xpForNext == 0 ? 0.0 : (xp / xpForNext).clamp(0.0, 1.0);
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  L10n.of(context).commonLevelShort(level),
                  overflow: TextOverflow.ellipsis,
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
                  overflow: TextOverflow.ellipsis,
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
              minHeight: 7,
              backgroundColor: GridColors.emptyCell,
              valueColor: AlwaysStoppedAnimation(GridColors.traySlots[0]),
            ),
          ),
          if (LevelSystem.nextReward(level) case final next?) ...[
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  next.kind == LevelRewardKind.theme
                      ? AppIcons.themes
                      : AppIcons.skins,
                  size: 13,
                  color: GridColors.textMuted,
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    L10n.of(context).homeNextUnlock(next.level, next.name),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: GridColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StreakRepairBanner extends ConsumerWidget {
  const _StreakRepairBanner({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(gameControllerProvider.notifier);

    Future<void> repair(Future<bool> action) async {
      final ok = await action;
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.of(context).streakRepairFailed)),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GridColors.fever),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(AppIcons.streak, size: 18, color: GridColors.fever),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  L10n.of(context).streakRepairTitle(streak),
                  style: const TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            L10n.of(context).streakRepairBody,
            style: TextStyle(color: GridColors.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonal(
                  onPressed: () => repair(controller.repairStreakWithAd()),
                  child: Text(L10n.of(context).homeVideo),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () => repair(controller.repairStreakWithCoins()),
                  child: CoinAmount(
                    amount: StreakRepair.coinCost,
                    size: 16,
                    color: GridColors.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Vertical layout (icon over label) so narrow half-width buttons never
    // wrap the text; the label scales down to fit if needed.
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        foregroundColor: GridColors.textPrimary,
        side: const BorderSide(color: GridColors.gridLine),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Formatting for the daily card's countdown, out here so it can be tested
/// without exposing the private widget.
class DailyCardFormat {
  const DailyCardFormat._();

  /// "7h 12m", or "12m" inside the last hour. Deliberately not seconds: the
  /// label is built when the screen builds, so a ticking unit would already be
  /// wrong by the time it was drawn.
  static String remaining(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h > 0 ? '${h}h ${m}m' : '${m}m';
  }
}

class _DailyCard extends StatelessWidget {
  const _DailyCard({
    required this.streak,
    required this.playedToday,
    required this.onPlay,
    required this.onOpenCalendar,
  });

  final int streak;

  /// Today's daily is done. The card then says when the next one unlocks
  /// rather than "Open today", which read as an invitation to a run that no
  /// longer counts (MASTERPLAN.md D.3).
  final bool playedToday;

  final VoidCallback onPlay;

  /// Opens the calendar. It is also what tapping the card does once today is
  /// played, so the card always leads somewhere useful.
  final VoidCallback onOpenCalendar;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: playedToday ? onOpenCalendar : onPlay,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: GridColors.traySlots[0]),
        ),
        child: Row(
          children: [
            const Icon(Icons.today_rounded, color: GridColors.textPrimary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.of(context).homeDailyChallenge,
                    style: TextStyle(
                      color: GridColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Streak and status are two different facts, and the
                  // status is the one that says whether to tap. It used to
                  // live in the `else` of the streak, so a player on a running
                  // streak — the whole audience for the countdown — never saw
                  // it and read "Daily Challenge · 5 days" as an invitation to
                  // a run that no longer counted.
                  Row(
                    children: [
                      if (streak > 0) ...[
                        const Icon(
                          AppIcons.streak,
                          size: 14,
                          color: GridColors.fever,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          L10n.of(context).homeDailyStreakDays(streak),
                          style: const TextStyle(
                            color: GridColors.fever,
                            fontSize: 14,
                          ),
                        ),
                        const Text(
                          '  ·  ',
                          style: TextStyle(
                            color: GridColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                      Flexible(
                        child: Text(
                          playedToday
                              ? L10n.of(context).homeDailyNextIn(
                                  DailyCardFormat.remaining(
                                    DailyChallenge.untilNextDaily(),
                                  ),
                                )
                              : L10n.of(context).homeDailyOpenToday,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: GridColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                playedToday
                    ? Icons.calendar_month_rounded
                    : Icons.play_arrow_rounded,
                color: GridColors.placed,
              ),
              tooltip: playedToday
                  ? L10n.of(context).homeDailyCalendar
                  : L10n.of(context).homeDailyOpenToday,
              onPressed: playedToday ? onOpenCalendar : onPlay,
            ),
          ],
        ),
      ),
    );
  }
}
