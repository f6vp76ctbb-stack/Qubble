/// The main play screen: score header, board, tray and game-over overlay.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/leveling.dart';
import '../../game/piece.dart';
import '../../game/review_prompt.dart';
import '../../l10n/app_localizations.dart';
import '../../monetization/iap.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import '../widgets/board_view.dart';
import '../widgets/clear_burst.dart';
import '../widgets/coin_popup.dart';
import '../widgets/juice_overlay.dart';
import '../widgets/shake.dart';
import '../widgets/tray_view.dart';

/// Height reserved for the coaching hint above the tray.
///
/// The board is sized by subtracting this from the available height, so the
/// hint must never exceed it — [_CoachHint] is clamped to exactly this tall.
/// Before that clamp a two-line hint (the combo tip on a 360 dp phone) pushed
/// the column 14 px past the bottom.
const double kCoachHintHeight = 64;

/// Gap between the hint and the tray, included in [kCoachHintHeight].
const double _hintGap = 8;

/// True while the player is choosing a target cell for the Board Bomb booster.
final bombModeProvider = StateProvider<bool>((ref) => false);

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  /// Attached to the board container; maps global drag positions to cells.
  final GlobalKey _boardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Entering the game is always a user gesture, so the music may start here
    // (satisfies web/PWA autoplay policies).
    ref.read(musicProvider).ensureStarted();
  }

  void _updateDragPreview(int slot, Offset feedbackTopLeft) {
    final piece = ref.read(gameControllerProvider).tray[slot];
    final notifier = ref.read(dragPreviewProvider.notifier);
    if (piece == null) {
      notifier.state = null;
      return;
    }
    final origin = boardOriginForDrag(
      boardKey: _boardKey,
      piece: piece,
      feedbackTopLeft: feedbackTopLeft,
    );
    if (origin == null) {
      notifier.state = null;
      return;
    }
    final valid = ref
        .read(gameControllerProvider.notifier)
        .canPlace(slot, origin);
    notifier.state = DragPreview(piece: piece, origin: origin, valid: valid);
  }

  void _handleDrop(int slot, Offset feedbackTopLeft) {
    final piece = ref.read(gameControllerProvider).tray[slot];
    if (piece != null) {
      final origin = boardOriginForDrag(
        boardKey: _boardKey,
        piece: piece,
        feedbackTopLeft: feedbackTopLeft,
      );
      if (origin != null) {
        ref.read(gameControllerProvider.notifier).place(slot, origin);
      }
    }
    ref.read(dragPreviewProvider.notifier).state = null;
  }

  Future<void> _handleBombTap(Cell cell) async {
    final ok = await ref.read(gameControllerProvider.notifier).tryBomb(cell);
    ref.read(bombModeProvider.notifier).state = false;
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(L10n.of(context).gameNotEnoughCoinsBomb),
        ),
      );
    }
  }

  /// Offers the store-rating card after a record run — but only once the
  /// player has settled on the game-over screen. Reviving keeps the run alive,
  /// so the offer is dropped if the overlay is gone again by then.
  void _offerReviewAfterRecord() {
    Future<void>.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      final snap = ref.read(gameControllerProvider);
      if (!snap.gameOver || !snap.isNewHighscore) return;
      ref
          .read(gameControllerProvider.notifier)
          .maybeAskForReview(ReviewTrigger.newHighscore);
    });
  }

  @override
  Widget build(BuildContext context) {
    // A new personal best is the game's clearest positive moment. The rating
    // card itself is Play's/StoreKit's, and dismissible; the frequency policy
    // lives in ReviewPrompt.
    ref.listen<GameSnapshot>(gameControllerProvider, (previous, next) {
      final becameRecord = next.gameOver && next.isNewHighscore;
      final wasRecord =
          previous != null && previous.gameOver && previous.isNewHighscore;
      if (becameRecord && !wasRecord) _offerReviewAfterRecord();
    });

    final l10n = L10n.of(context);
    final snap = ref.watch(gameControllerProvider);
    final theme = ref.watch(activeThemeProvider);
    final bombMode = ref.watch(bombModeProvider);
    final effectiveBombMode = bombMode && !snap.isDaily;
    final compactLayout = MediaQuery.sizeOf(context).height < 560;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _Header(
                  score: snap.score,
                  highscore: snap.highscore,
                  coins: snap.coins,
                  combo: snap.combo,
                  comboEndsAt: snap.comboEndsAt,
                  fever: snap.feverLevel,
                  isDaily: snap.isDaily,
                  feverColor: theme.fever,
                ),
                if (!compactLayout && !snap.gameOver && !snap.isDaily)
                  TextButton.icon(
                    onPressed: () =>
                        ref.read(gameControllerProvider.notifier).luckyBlock(),
                    icon: const Icon(Icons.card_giftcard, size: 18),
                    label: Text(l10n.gameNewPiecesVideo),
                    style: TextButton.styleFrom(foregroundColor: theme.fever),
                  ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final trayHeight = compactLayout ? 104.0 : 96.0;
                      const gap = 16.0;
                      final boosterHeight = compactLayout ? 0.0 : 64.0;
                      final hintReserve =
                          !compactLayout &&
                              (snap.onboardingHintStep != null ||
                                  snap.contextualHint != null ||
                                  effectiveBombMode)
                          ? kCoachHintHeight
                          : 0.0;
                      final maxBoard = (constraints.maxWidth - 24)
                          .clamp(0.0, double.infinity)
                          .toDouble();
                      final availableBoardHeight =
                          (constraints.maxHeight -
                                  trayHeight -
                                  boosterHeight -
                                  gap -
                                  hintReserve -
                                  2)
                              .clamp(0.0, double.infinity)
                              .toDouble();
                      final boardSize = maxBoard < availableBoardHeight
                          ? maxBoard
                          : availableBoardHeight;
                      // The DragTarget spans board AND tray: with the
                      // finger-lift the finger sits below the hovering piece,
                      // so drops targeting the bottom rows happen while the
                      // finger is over the booster/tray area.
                      return DragTarget<int>(
                        onMove: (d) => _updateDragPreview(d.data, d.offset),
                        onLeave: (_) =>
                            ref.read(dragPreviewProvider.notifier).state = null,
                        onAcceptWithDetails: (d) =>
                            _handleDrop(d.data, d.offset),
                        builder: (context, _, _) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Shake(
                              trigger: snap.clearEventId,
                              enabled: snap.lastClearedLineCount >= 3,
                              child: _FeverGlow(
                                fever: snap.feverLevel,
                                color: theme.fever,
                                child: SizedBox(
                                  width: boardSize,
                                  height: boardSize,
                                  // RepaintBoundaries isolate the animated
                                  // effect layers from the board — without
                                  // them every particle frame repaints the
                                  // whole surface, which flashes white on
                                  // iOS-Safari/PWA (canvas reallocation).
                                  child: Stack(
                                    children: [
                                      RepaintBoundary(
                                        child: BoardView(
                                          size: boardSize,
                                          board: snap.board,
                                          boardKey: _boardKey,
                                          onCellTap: effectiveBombMode
                                              ? _handleBombTap
                                              : null,
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: IgnorePointer(
                                          child: RepaintBoundary(
                                            child: ClearBurst(
                                              size: boardSize,
                                              cellSize: boardSize / 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: IgnorePointer(
                                          child: RepaintBoundary(
                                            child: JuiceOverlay(
                                              size: boardSize,
                                              cellSize: boardSize / 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CoinPopup(size: boardSize),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: gap),
                            if (!compactLayout && !snap.isDaily)
                              _BoosterBar(
                                snap: snap,
                                bombMode: effectiveBombMode,
                              ),
                            if (!compactLayout && effectiveBombMode)
                              _CoachHint(text: l10n.gameTapBoardCell)
                            else if (!compactLayout &&
                                snap.onboardingHintStep != null)
                              _CoachHint(
                                text: onboardingHints(
                                  l10n,
                                )[snap.onboardingHintStep!],
                              )
                            else if (!compactLayout &&
                                snap.contextualHint != null)
                              _CoachHint(
                                text: coachHintText(l10n, snap.contextualHint!),
                              ),
                            TrayView(
                              boardCell: boardSize / 8,
                              height: trayHeight,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            if (snap.gameOver) _GameOverOverlay(snap: snap),
          ],
        ),
      ),
    );
  }
}

/// Compact live coin balance shown in the game header; pulses when it grows.
class _CoinChip extends StatelessWidget {
  const _CoinChip({required this.coins});

  final int coins;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(coins),
      tween: Tween(begin: 1.18, end: 1.0),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: GridColors.gridLine),
        ),
        child: CoinAmount(
          amount: coins,
          size: 15,
          color: GridColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// A soft glow around the board that intensifies with the fever meter.
class _FeverGlow extends StatelessWidget {
  const _FeverGlow({
    required this.fever,
    required this.color,
    required this.child,
  });

  final double fever;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final f = fever.clamp(0.0, 1.0);
    // The shadow layer is ALWAYS present (invisible at fever 0). Adding a
    // large-blur shadow on the fly forces the compositor to allocate a new
    // blur surface mid-clear, which flashes white on iOS-Safari/PWA.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.004 + f * 0.6),
            blurRadius: 1 + f * 34,
            spreadRadius: f * 4,
          ),
        ],
      ),
      child: child,
    );
  }
}

/// The in-run booster bar: undo, swap pieces, board bomb.
class _BoosterBar extends ConsumerWidget {
  const _BoosterBar({required this.snap, required this.bombMode});

  final GameSnapshot snap;
  final bool bombMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(gameControllerProvider.notifier);

    Future<void> run(Future<bool> action) async {
      final ok = await action;
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(L10n.of(context).gameActionUnavailable),
          ),
        );
      }
    }

    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!snap.isDaily) ...[
            _BoosterButton(
              icon: AppIcons.undo,
              label: L10n.of(context).boosterUndo,
              cost: BoosterCosts.undo,
              enabled:
                  snap.canUndo &&
                  !snap.gameOver &&
                  snap.coins >= BoosterCosts.undo,
              active: false,
              onTap: () => run(controller.tryUndo()),
            ),
            _BoosterButton(
              icon: AppIcons.swap,
              label: L10n.of(context).boosterSwap,
              cost: BoosterCosts.swap,
              enabled: !snap.gameOver && snap.coins >= BoosterCosts.swap,
              active: false,
              onTap: () => run(controller.trySwapPieces()),
            ),
            _BoosterButton(
              icon: AppIcons.bomb,
              label: L10n.of(context).boosterBomb,
              cost: BoosterCosts.bomb,
              enabled: !snap.gameOver && snap.coins >= BoosterCosts.bomb,
              active: bombMode,
              onTap: () {
                final notifier = ref.read(bombModeProvider.notifier);
                notifier.state = !notifier.state;
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _BoosterButton extends StatelessWidget {
  const _BoosterButton({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.active,
    required this.onTap,
    required this.cost,
  });

  final IconData icon;
  final String label;

  /// Coin cost rendered with the coin icon.
  final int cost;

  final bool enabled;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? GridColors.fever
        : enabled
        ? GridColors.textPrimary
        : GridColors.textMuted;
    return Expanded(
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 2),
              Text(label, style: TextStyle(color: color, fontSize: 12)),
              CoinAmount(
                amount: cost,
                size: 12,
                color: GridColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A small pulsing coach banner used during the first-run guided moves.
class _CoachHint extends StatelessWidget {
  const _CoachHint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      liveRegion: true,
      label: text,
      child: ExcludeSemantics(
        child: TweenAnimationBuilder<double>(
          key: ValueKey(text),
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, t, child) => Opacity(opacity: t, child: child),
          // Exactly kCoachHintHeight tall including the gap below it: the
          // board is sized by subtracting that number, so a longer hint has to
          // ellipsize rather than grow and push the tray off screen.
          child: Container(
            height: kCoachHintHeight - _hintGap,
            margin: const EdgeInsets.only(bottom: _hintGap),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GridColors.boardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: GridColors.gridLine),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: GridColors.textPrimary,
                fontSize: 15,
                height: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.score,
    required this.highscore,
    required this.coins,
    required this.combo,
    required this.comboEndsAt,
    required this.fever,
    required this.isDaily,
    required this.feverColor,
  });

  final int score;
  final int highscore;
  final int coins;
  final int combo;
  final DateTime? comboEndsAt;
  final double fever;
  final bool isDaily;
  final Color feverColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 4),
      child: Column(
        children: [
          Row(
            children: [
              if (isDaily)
                Text(
                  L10n.of(context).gameDailyChallengeLabel,
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              const Spacer(),
              // Live coin balance — updates as you clear lines.
              _CoinChip(coins: coins),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.home_outlined,
                      color: GridColors.textMuted,
                    ),
                    tooltip: L10n.of(context).commonHome,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  _stat(L10n.of(context).commonScore, '$score'),
                ],
              ),
              if (combo > 1)
                _ComboBadge(
                  combo: combo,
                  color: feverColor,
                  endsAt: comboEndsAt,
                ),
              _stat(
                L10n.of(context).commonBest,
                '$highscore',
                alignEnd: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _FeverBar(level: fever, color: feverColor),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: GridColors.textMuted, fontSize: 11),
        ),
        Text(
          value,
          style: const TextStyle(
            color: GridColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Combo indicator that pulses on each combo step and shows the time window
/// draining away — when the bar empties, the combo is gone.
class _ComboBadge extends StatelessWidget {
  const _ComboBadge({
    required this.combo,
    required this.color,
    required this.endsAt,
  });

  final int combo;
  final Color color;
  final DateTime? endsAt;

  @override
  Widget build(BuildContext context) {
    final label = TweenAnimationBuilder<double>(
      key: ValueKey(combo),
      tween: Tween(begin: 1.35, end: 1.0),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Text(
        L10n.of(context).gameComboMultiplier(combo),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );

    final ends = endsAt;
    if (ends == null) return label;
    final remaining = ends.difference(DateTime.now());
    if (remaining.isNegative) return const SizedBox.shrink();

    return TweenAnimationBuilder<double>(
      // Restart the countdown whenever a new clear extends the window.
      key: ValueKey(ends),
      tween: Tween(begin: 1.0, end: 0.0),
      duration: remaining,
      builder: (context, t, child) {
        if (t <= 0) return const SizedBox.shrink();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child!,
            const SizedBox(height: 3),
            SizedBox(
              width: 84,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: t,
                  minHeight: 4,
                  backgroundColor: GridColors.emptyCell,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ),
          ],
        );
      },
      child: label,
    );
  }
}

class _FeverBar extends StatelessWidget {
  const _FeverBar({required this.level, required this.color});

  final double level;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: LinearProgressIndicator(
        value: level.clamp(0.0, 1.0),
        minHeight: 8,
        backgroundColor: GridColors.emptyCell,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}

class _GameOverOverlay extends ConsumerWidget {
  const _GameOverOverlay({required this.snap});

  final GameSnapshot snap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final controller = ref.read(gameControllerProvider.notifier);
    return Container(
      color: Colors.black.withValues(alpha: 0.72),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.gameOver,
              style: const TextStyle(
                color: GridColors.textPrimary,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.gameOverPoints(snap.score),
              style: const TextStyle(
                color: GridColors.textPrimary,
                fontSize: 22,
              ),
            ),
            if (snap.isNewHighscore)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  l10n.gameNewRecord,
                  style: const TextStyle(
                    color: GridColors.fever,
                    fontSize: 16,
                  ),
                ),
              ),
            if (snap.levelsGainedThisRun > 0)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: _LevelUpCard(
                  level: snap.playerLevel,
                  levelsGained: snap.levelsGainedThisRun,
                  rewards: snap.rewardsUnlockedThisRun,
                ),
              ),
            if (snap.isDaily && snap.streak > 0)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      AppIcons.streak,
                      size: 17,
                      color: GridColors.fever,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      l10n.gameStreakDays(snap.streak),
                      style: const TextStyle(
                        color: GridColors.fever,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            if (snap.coinsEarnedThisRun > 0)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CoinAmount(
                      amount: snap.coinsEarnedThisRun,
                      prefix: '+',
                      size: 17,
                      color: GridColors.textPrimary,
                    ),
                    if (snap.coinsDoubled)
                      const Text(
                        '  ×2',
                        style: TextStyle(
                          color: GridColors.fever,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            if (snap.coinsEarnedThisRun > 0 && !snap.coinsDoubled)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(
                    backgroundColor: GridColors.fever,
                    foregroundColor: GridColors.background,
                  ),
                  onPressed: () => controller.doubleCoinsWithAd(),
                  icon: const Icon(Icons.play_circle_fill_rounded, size: 20),
                  label: Text(l10n.gameDoubleCoins),
                ),
              ),
            for (final mission in snap.completedMissions)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 15,
                      color: GridColors.placed,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      missionDescription(l10n, mission),
                      style: const TextStyle(
                        color: GridColors.placed,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            for (final a in snap.achievementsUnlockedThisRun)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      AppIcons.trophy,
                      size: 15,
                      color: GridColors.fever,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      l10n.gameAchievementUnlocked(a.title(l10n)),
                      style: const TextStyle(
                        color: GridColors.fever,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            if (snap.starterOfferActive) ...[
              const SizedBox(height: 20),
              _StarterCard(hoursLeft: snap.starterHoursLeft),
            ],
            // The best score uploads to the leaderboard automatically in the
            // background (see GameController.autoUploadBestScore) — a new best
            // just gets a quiet confirmation, no button to tap.
            if (snap.isNewHighscore && snap.playerName.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    AppIcons.trophy,
                    size: 16,
                    color: GridColors.placed,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      l10n.gameBestSubmitted,
                      style: const TextStyle(
                        color: GridColors.placed,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 28),
            // "Nochmal" is the primary, always-free action. Qubble shows no
            // forced ads — restarting is instant. The revive below costs
            // coins; ads are never required to keep playing.
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                textStyle: const TextStyle(
                  fontFamily: kAppFontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => controller.newGame(),
              child: Text(l10n.gamePlayAgain),
            ),
            const SizedBox(height: 8),
            if (!snap.isDaily && !snap.reviveUsed)
              TextButton.icon(
                onPressed: snap.coins >= BoosterCosts.revive
                    ? () => controller.reviveWithCoins()
                    : null,
                icon: const Icon(Icons.favorite_rounded, size: 18),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.gameReviveFor),
                    CoinAmount(
                      amount: BoosterCosts.revive,
                      size: 15,
                      color: GridColors.fever,
                    ),
                  ],
                ),
                style: TextButton.styleFrom(foregroundColor: GridColors.fever),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text(l10n.commonHome),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated level-up celebration on the game-over screen: a badge that pops
/// and glows, plus any cosmetics the new level(s) unlocked.
class _LevelUpCard extends StatefulWidget {
  const _LevelUpCard({
    required this.level,
    required this.levelsGained,
    required this.rewards,
  });

  final int level;
  final int levelsGained;
  final List<LevelReward> rewards;

  @override
  State<_LevelUpCard> createState() => _LevelUpCardState();
}

class _LevelUpCardState extends State<_LevelUpCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final title = widget.levelsGained == 1
        ? l10n.gameLevelReached(widget.level)
        : l10n.gameLevelsGained(widget.levelsGained, widget.level);

    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        // Pop in with an overshoot, then settle; the glow pulses once.
        final pop = Curves.elasticOut.transform(_c.value.clamp(0.0, 1.0));
        final glow = (1.0 - (_c.value - 0.5).abs() * 2).clamp(0.0, 1.0);
        return Transform.scale(
          scale: 0.6 + 0.4 * pop,
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB03A), Color(0xFFFF7A59)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB03A).withValues(alpha: glow * 0.7),
                  blurRadius: 26 * glow,
                  spreadRadius: 2 * glow,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(AppIcons.level, size: 22, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (widget.rewards.isNotEmpty) ...[
            const SizedBox(height: 10),
            for (final r in widget.rewards)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      r.kind == LevelRewardKind.theme
                          ? AppIcons.themes
                          : AppIcons.skins,
                      size: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        l10n.gameRewardUnlocked(r.name),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

/// One-time starter pack card on the game-over screen (C.6).
class _StarterCard extends ConsumerWidget {
  const _StarterCard({required this.hoursLeft});

  final int hoursLeft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    // The price comes from the store, already localized and in the player's
    // currency. Until it is known, the button stays currency-free.
    final iap = ref.read(iapServiceProvider);
    final price = iap.products
        .where((p) => p.id == IapProducts.starter)
        .map((p) => p.price)
        .firstOrNull;
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C6BFF), Color(0xFF4ECDC4)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            l10n.gameStarterOfferTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.gameStarterOfferReward,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.gameStarterOfferTimeLeft(hoursLeft),
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 12),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: GridColors.background,
              minimumSize: const Size.fromHeight(44),
            ),
            onPressed: () =>
                ref.read(iapServiceProvider).buy(IapProducts.starter),
            child: Text(
              price == null
                  ? l10n.gameStarterOfferBuyGeneric
                  : l10n.gameStarterOfferBuy(price),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
