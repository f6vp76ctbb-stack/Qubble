/// The main play screen: score header, board, tray and game-over overlay.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/leveling.dart';
import '../../game/piece.dart';
import '../../l10n/app_localizations.dart';
import '../../monetization/iap.dart';
import '../effects.dart';
import '../format.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/settings_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import '../widgets/board_view.dart';
import '../widgets/clear_burst.dart';
import '../widgets/coin_popup.dart';
import '../widgets/juice_overlay.dart';
import '../widgets/shake.dart';
import '../widgets/tray_view.dart';

/// True while the player is choosing a target cell for the Board Bomb booster.
final bombModeProvider = StateProvider<bool>((ref) => false);

/// Exact height reserved for the coach hint. [_CoachHint] pins itself to this,
/// so the board/tray budget below can subtract a number that is actually true.
/// It used to reserve 52 px for a bubble that wrapped to two lines on a 360 px
/// display and took 68 — which overflowed the play column by 14 px.
const double _kCoachHintHeight = 68;

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
      final coins = ref.read(gameControllerProvider).coins;
      final missing = BoosterCosts.bomb - coins;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            missing > 0
                ? L10n.of(context).gameBombNeedsCoins(L10n.of(context).count(missing))
                : L10n.of(context).gameBombNotHere,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final snap = ref.watch(gameControllerProvider);
    final theme = ref.watch(activeThemeProvider);
    final bombMode = ref.watch(bombModeProvider);
    final effectiveBombMode = bombMode && !snap.isDaily;
    final compactLayout = MediaQuery.sizeOf(context).height < 560;

    // Android's back button had no handling anywhere in the app. In the game
    // that meant: leaving mid-run with no word that the run is saved (so
    // players started a new one), and leaving with bomb-targeting still armed
    // globally, so it was still active on the next visit.
    return PopScope(
      canPop: !effectiveBombMode,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          if (snap.runActive) _confirmRunIsSaved();
          return;
        }
        ref.read(bombModeProvider.notifier).state = false;
      },
      child: Scaffold(
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
                  if (!compactLayout &&
                      !snap.gameOver &&
                      !snap.isDaily &&
                      snap.luckyBlocksLeft > 0)
                    TextButton.icon(
                      onPressed: () => ref
                          .read(gameControllerProvider.notifier)
                          .luckyBlock(),
                      icon: const Icon(Icons.card_giftcard, size: 18),
                      label: Text(l10n.gameNewPiecesVideo),
                      style: TextButton.styleFrom(foregroundColor: theme.fever),
                    ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const gap = 16.0;
                        final boosterHeight = compactLayout ? 0.0 : 64.0;
                        final hintReserve =
                            !compactLayout &&
                                (snap.onboardingHintStep != null ||
                                    snap.contextualHint != null ||
                                    effectiveBombMode)
                            ? _kCoachHintHeight
                            : 0.0;
                        // The board is capped rather than filling the width
                        // (MASTERPLAN.md D.6). Measured before capping: a
                        // 1200 dp tablet drew it 1176 px wide, 98 % of the
                        // screen, which turns every placement into a drag
                        // across the whole display and puts the far corners
                        // out of thumb reach.
                        //
                        // 560 leaves phones untouched: the widest common
                        // phone is around 480 dp, so maxWidth - 24 stays
                        // below the cap and nothing changes there. Only
                        // tablets and unfolded foldables see it, and there
                        // the surrounding Column centres what is left over.
                        final maxBoard = (constraints.maxWidth - 24)
                            .clamp(0.0, kMaxBoardWidth)
                            .toDouble();
                        // The tray takes whatever the board leaves over, within
                        // bounds, instead of a fixed height. A fixed tall tray
                        // overflowed on a 360x640 phone; a fixed short one drew
                        // the pieces far below board scale, which is what made
                        // them hard to judge.
                        final forBoardAndTray =
                            (constraints.maxHeight -
                                    boosterHeight -
                                    gap -
                                    hintReserve -
                                    2)
                                .clamp(0.0, double.infinity)
                                .toDouble();
                        final minTray = (compactLayout ? 96.0 : 104.0)
                            .clamp(0.0, forBoardAndTray)
                            .toDouble();
                        final maxTray = compactLayout ? 112.0 : 148.0;
                        final boardSize = [maxBoard, forBoardAndTray - minTray]
                            .reduce((a, b) => a < b ? a : b)
                            .clamp(0.0, maxBoard)
                            .toDouble();
                        final trayHeight = (forBoardAndTray - boardSize)
                            .clamp(minTray, maxTray)
                            .toDouble();
                        // The DragTarget spans board AND tray: with the
                        // finger-lift the finger sits below the hovering piece,
                        // so drops targeting the bottom rows happen while the
                        // finger is over the booster/tray area.
                        return DragTarget<int>(
                          onMove: (d) => _updateDragPreview(d.data, d.offset),
                          onLeave: (_) =>
                              ref.read(dragPreviewProvider.notifier).state =
                                  null,
                          onAcceptWithDetails: (d) =>
                              _handleDrop(d.data, d.offset),
                          builder: (context, _, _) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Shake(
                                trigger: snap.clearEventId,
                                enabled: snap.lastClearedLineCount >= 3 &&
                                    !ref.watch(reducedEffectsProvider),
                                child: _FeverGlow(
                                  fever: snap.feverLevel,
                                  color: theme.fever,
                                  reduced: ref.watch(reducedEffectsProvider),
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
                                  text: coachHintText(
                                    l10n,
                                    snap.contextualHint!,
                                  ),
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
      ),
    );
  }

  /// Leaving mid-run keeps the run: say so, or the player assumes it is gone
  /// and starts a new one from the home screen.
  void _confirmRunIsSaved() {
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(L10n.of(context).gameRunSaved),
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
/// Widest the 8x8 board is ever drawn, in logical pixels.
///
/// Not a style choice: without it the board grew with the screen, and a drag
/// from the tray to a far corner became the length of the display. See the
/// comment at its use site for the measurements.
const double kMaxBoardWidth = 560;

class _FeverGlow extends StatelessWidget {
  const _FeverGlow({
    required this.fever,
    required this.color,
    required this.reduced,
    required this.child,
  });

  final double fever;
  final Color color;

  /// Reduced effects keep the layer but drop the blur, so the fever still
  /// marks the board without the bloom (MASTERPLAN.md D.5.1).
  final bool reduced;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final f = fever.clamp(0.0, 1.0);
    // The shadow layer is ALWAYS present (invisible at fever 0). Adding a
    // large-blur shadow on the fly forces the compositor to allocate a new
    // blur surface mid-clear, which flashes white on iOS-Safari/PWA.
    // Reduced effects therefore zero the radius rather than dropping the
    // BoxShadow -- removing it would reintroduce exactly that bug.
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.004 + f * 0.6),
            blurRadius: Effects.blur(1 + f * 34, reduced: reduced),
            spreadRadius: Effects.spread(f * 4, reduced: reduced),
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

    // One message used to cover three different causes — too few coins,
    // nothing to undo, and the Daily disallowing boosters — with a question
    // mark, which reads as if the app itself did not know.
    Future<void> run(Future<bool> action, {required int cost}) async {
      final ok = await action;
      if (ok || !context.mounted) return;
      final message = snap.coins < cost
          ? L10n.of(
            context,
          ).gameNeedsCoins(L10n.of(context).count(cost - snap.coins))
          : L10n.of(context).gameNotRightNow;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(message),
        ),
      );
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
              onTap: () => run(controller.tryUndo(), cost: BoosterCosts.undo),
            ),
            _BoosterButton(
              icon: AppIcons.swap,
              label: L10n.of(context).boosterSwap,
              cost: BoosterCosts.swap,
              enabled: !snap.gameOver && snap.coins >= BoosterCosts.swap,
              active: false,
              onTap: () => run(controller.trySwapPieces(), cost: BoosterCosts.swap),
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
          child: SizedBox(
            height: _kCoachHintHeight,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                  style: TextStyle(
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
                  _stat(L10n.of(context).commonScore, L10n.of(context).count(score)),
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
                L10n.of(context).count(highscore),
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
              style: TextStyle(
                color: GridColors.textPrimary,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            // A run ends for exactly one reason, and the overlay never said
            // it. In a genre where the end always feels sudden, this is the
            // whole lesson of the round.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                snap.rotationCharges > 0 || snap.rotationFree
                    ? l10n.gameOverNoFit
                    : l10n.gameOverNoFitNoRotations,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 15,
                  height: 1.35,
                ),
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
            // Everything below is only known once the end-of-run bookkeeping
            // has finished (~10 storage writes). Rendering it as it trickles
            // in inserted up to six blocks ABOVE the buttons, so a quick tap
            // on "Nochmal spielen" could land on the paid revive instead.
            if (snap.finalizing) ...[
              const SizedBox(height: 40),
              const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
              const SizedBox(height: 40),
            ] else ...[
              if (snap.isNewHighscore)
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    l10n.gameNewRecord,
                    style: TextStyle(color: GridColors.fever, fontSize: 16),
                  ),
                ),
              if (snap.levelsGainedThisRun > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: _LevelUpCard(
                    level: snap.playerLevel,
                    levelsGained: snap.levelsGainedThisRun,
                    rewards: snap.rewardsUnlockedThisRun,
                    reduced: ref.watch(reducedEffectsProvider),
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
              // The daily reward is a separate pot from the coins earned by
              // playing, so it gets its own optional double rather than being
              // folded into the one above. Both stay voluntary: the reward is
              // already credited before either is offered.
              if (snap.dailyRewardThisRun > 0 && !snap.dailyRewardDoubled)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(
                      backgroundColor: GridColors.fever,
                      foregroundColor: GridColors.background,
                    ),
                    onPressed: () => controller.doubleDailyRewardWithAd(),
                    icon: const Icon(Icons.play_circle_fill_rounded, size: 20),
                    label: Text(l10n.gameDoubleDaily),
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
                        mission,
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
                    Icon(AppIcons.trophy, size: 16, color: GridColors.placed),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        l10n.gameBestSubmitted,
                        style: TextStyle(
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
                  // styleFrom's textStyle replaces the theme's, so the family
                  // has to be repeated — otherwise the label falls back to the
                  // platform font.
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
                  style: TextButton.styleFrom(
                    foregroundColor: GridColors.fever,
                  ),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text(L10n.of(context).commonHome),
              ),
            ],
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
    required this.reduced,
  });

  final int level;
  final int levelsGained;
  final List<LevelReward> rewards;

  /// Drop the pulsing halo, keep the card (MASTERPLAN.md D.5.1).
  final bool reduced;

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
                  blurRadius: Effects.blur(26 * glow, reduced: widget.reduced),
                  spreadRadius:
                      Effects.spread(2 * glow, reduced: widget.reduced),
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.gameStarterOfferReward,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.gameStarterOfferTimeLeft(hoursLeft),
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Builder(
            builder: (context) {
              // The price used to be hardcoded as "1,99 €". Store prices vary
              // by country and can be changed in the console, so claiming one
              // in the app is both wrong for most players and a store-policy
              // problem. Read what the store actually reports.
              final iap = ref.read(iapServiceProvider);
              final product = iap.products
                  .where((p) => p.id == IapProducts.starter)
                  .firstOrNull;
              return FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: GridColors.background,
                  minimumSize: const Size.fromHeight(44),
                ),
                onPressed: product == null
                    ? null
                    : () => iap.buy(IapProducts.starter),
                child: Text(
                  product == null
                      ? l10n.gameStarterOfferUnavailable
                      : l10n.gameStarterOfferPrice(product.price),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
