/// Plays a single puzzle level: drag the current piece onto the board, empty it.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/board.dart';
import '../../game/piece.dart';
import '../../game/review_prompt.dart';
import '../../l10n/app_localizations.dart';
import '../state/game_controller.dart';
import '../state/puzzle_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import '../widgets/board_view.dart' show boardOriginForDrag, kFingerLiftCells;
import '../widgets/piece_view.dart';

class PuzzleScreen extends ConsumerStatefulWidget {
  const PuzzleScreen({super.key, required this.level});

  final int level;

  @override
  ConsumerState<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends ConsumerState<PuzzleScreen> {
  final GlobalKey _boardKey = GlobalKey();
  Cell? _preview;
  bool _valid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(puzzleControllerProvider.notifier).loadLevel(widget.level);
    });
  }

  Cell? _originFor(Offset feedbackTopLeft) {
    final piece = ref.read(puzzleControllerProvider).currentPiece;
    if (piece == null) return null;
    return boardOriginForDrag(
      boardKey: _boardKey,
      piece: piece,
      feedbackTopLeft: feedbackTopLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    // A flawless solve is the puzzle mode's positive moment. ReviewPrompt
    // decides whether asking for a rating is appropriate at all.
    ref.listen<PuzzleState>(puzzleControllerProvider, (previous, next) {
      final perfect = next.solved && next.stars >= 3;
      final wasPerfect =
          previous != null && previous.solved && previous.stars >= 3;
      if (perfect && !wasPerfect) {
        ref
            .read(gameControllerProvider.notifier)
            .maybeAskForReview(ReviewTrigger.puzzlePerfect);
      }
    });

    final l10n = L10n.of(context);
    final state = ref.watch(puzzleControllerProvider);
    final theme = ref.watch(activeThemeProvider);
    final controller = ref.read(puzzleControllerProvider.notifier);

    // Back mid-puzzle throws the level away with no warning; a solved or
    // failed one has nothing left to lose, so it leaves straight away.
    final inProgress = state.moves > 0 && !state.solved && !state.failed;
    return PopScope(
      canPop: !inProgress,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _confirmLeave();
      },
      child: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.background,
          title: Text(l10n.puzzleLevelTitle(state.level + 1)),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: controller.restart,
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      l10n.puzzleMoveCounter(state.moves, state.minMoves),
                      style: const TextStyle(color: GridColors.textMuted),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const trayHeight = 92.0;
                        const gap = 16.0;
                        final boardSize = (constraints.maxWidth - 24).clamp(
                          0.0,
                          constraints.maxHeight - trayHeight - gap,
                        );
                        // Like the main game, the DragTarget spans board AND
                        // tray so the bottom rows stay reachable despite the
                        // finger-lift.
                        return DragTarget<int>(
                          onMove: (d) {
                            final origin = _originFor(d.offset);
                            setState(() {
                              _preview = origin;
                              _valid =
                                  origin != null && controller.canPlace(origin);
                            });
                          },
                          onLeave: (_) => setState(() => _preview = null),
                          onAcceptWithDetails: (d) {
                            final origin = _originFor(d.offset);
                            if (origin != null) controller.place(origin);
                            setState(() => _preview = null);
                          },
                          builder: (context, _, _) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _PuzzleBoard(
                                size: boardSize,
                                boardKey: _boardKey,
                                preview: _preview,
                                valid: _valid,
                              ),
                              const SizedBox(height: gap),
                              _PuzzleTray(
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
              if (state.solved) _WinOverlay(state: state),
              if (state.failed) _FailOverlay(state: state),
            ],
          ),
        ),
      ),
    );
  }

  /// A puzzle has no checkpoint, so leaving mid-level discards the progress.
  Future<void> _confirmLeave() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GridColors.boardBackground,
        title: Text(L10n.of(context).puzzleLeaveTitle,
          style: const TextStyle(color: GridColors.textPrimary),
        ),
        content: Text(L10n.of(context).puzzleLeaveBody,
          style: const TextStyle(color: GridColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(L10n.of(context).puzzleKeepPlaying),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(L10n.of(context).puzzleLeave),
          ),
        ],
      ),
    );
    if ((leave ?? false) && mounted) Navigator.of(context).pop();
  }
}

class _PuzzleBoard extends ConsumerWidget {
  const _PuzzleBoard({
    required this.size,
    required this.boardKey,
    required this.preview,
    required this.valid,
  });

  final double size;
  final GlobalKey boardKey;
  final Cell? preview;
  final bool valid;

  double get _cell => size / Board.size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(puzzleControllerProvider);
    final theme = ref.watch(activeThemeProvider);

    return Container(
      key: boardKey,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.boardBackground,
        borderRadius: BorderRadius.circular(_cell * 0.25),
      ),
      child: CustomPaint(
        painter: _PuzzlePainter(
          board: state.board,
          cell: _cell,
          piece: state.currentPiece,
          origin: preview,
          valid: valid,
          filled: theme.placed,
          empty: theme.emptyCell,
          validColor: theme.validPreview,
          invalidColor: theme.invalidPreview,
        ),
      ),
    );
  }
}

class _PuzzlePainter extends CustomPainter {
  _PuzzlePainter({
    required this.board,
    required this.cell,
    required this.piece,
    required this.origin,
    required this.valid,
    required this.filled,
    required this.empty,
    required this.validColor,
    required this.invalidColor,
  });

  final Board board;
  final double cell;
  final Piece? piece;
  final Cell? origin;
  final bool valid;
  final Color filled;
  final Color empty;
  final Color validColor;
  final Color invalidColor;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(cell * 0.22);
    const inset = 1.5;
    void draw(int r, int c, Color color) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            c * cell + inset,
            r * cell + inset,
            cell - inset * 2,
            cell - inset * 2,
          ),
          radius,
        ),
        Paint()..color = color,
      );
    }

    for (var r = 0; r < Board.size; r++) {
      for (var c = 0; c < Board.size; c++) {
        draw(r, c, board.filledAt(r, c) ? filled : empty);
      }
    }
    final p = piece;
    final o = origin;
    if (p != null && o != null) {
      final color = valid ? validColor : invalidColor;
      for (final cellOffset in p.cells) {
        final r = o.row + cellOffset.row;
        final c = o.col + cellOffset.col;
        if (r >= 0 && r < Board.size && c >= 0 && c < Board.size) {
          draw(r, c, color);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_PuzzlePainter old) =>
      old.board != board || old.origin != origin || old.valid != valid;
}

class _PuzzleTray extends ConsumerWidget {
  const _PuzzleTray({required this.boardCell, required this.height});

  final double boardCell;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(puzzleControllerProvider);
    final theme = ref.watch(activeThemeProvider);
    final current = state.currentPiece;
    final next = state.pieceIndex + 1 < state.pieces.length
        ? state.pieces[state.pieceIndex + 1]
        : null;

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (current != null)
            Draggable<int>(
              data: 0,
              dragAnchorStrategy: (draggable, context, position) => Offset(
                current.width * boardCell / 2,
                current.height * boardCell / 2 + kFingerLiftCells * boardCell,
              ),
              feedback: PieceView(
                piece: current,
                cellSize: boardCell,
                color: theme.placed,
              ),
              childWhenDragging: Opacity(
                opacity: 0.25,
                child: PieceView(
                  piece: current,
                  cellSize: height / 5,
                  color: theme.placed,
                ),
              ),
              child: PieceView(
                piece: current,
                cellSize: height / 5,
                color: theme.traySlots[0],
              ),
            ),
          if (next != null) ...[
            const SizedBox(width: 28),
            Opacity(
              opacity: 0.5,
              child: PieceView(
                piece: next,
                cellSize: height / 7,
                color: GridColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _WinOverlay extends ConsumerWidget {
  const _WinOverlay({required this.state});

  final PuzzleState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final controller = ref.read(puzzleControllerProvider.notifier);
    return _Overlay(
      children: [
        Text(l10n.puzzleSolved,
          style: const TextStyle(
            color: GridColors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              Icon(
                i < state.stars
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: 38,
                color: GridColors.fever,
              ),
          ],
        ),
        if (state.coinsAwarded > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CoinAmount(
              amount: state.coinsAwarded,
              prefix: '+',
              size: 16,
              color: GridColors.textPrimary,
            ),
          ),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: () => controller.loadLevel(state.level + 1),
          child: Text(l10n.puzzleNextLevel),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(l10n.puzzleBackToOverview),
        ),
      ],
    );
  }
}

class _FailOverlay extends ConsumerWidget {
  const _FailOverlay({required this.state});

  final PuzzleState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final controller = ref.read(puzzleControllerProvider.notifier);
    return _Overlay(
      children: [
        Text(l10n.puzzleStuckTitle,
          style: const TextStyle(
            color: GridColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(l10n.puzzleUnsolvable,
          textAlign: TextAlign.center,
          style: const TextStyle(color: GridColors.textMuted),
        ),
        const SizedBox(height: 24),
        if (state.canExtraMove)
          FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              backgroundColor: GridColors.fever,
              foregroundColor: GridColors.background,
            ),
            onPressed: () async {
              final ok = await ref.read(adServiceProvider).showRewarded();
              if (ok) controller.applyExtraMove();
            },
            icon: const Icon(Icons.play_circle_fill_rounded, size: 20),
            label: Text(l10n.puzzleExtraMoveVideo),
          ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: controller.restart,
          child: Text(l10n.puzzleRestart),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(l10n.puzzleBackToOverview),
        ),
      ],
    );
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.75),
      alignment: Alignment.center,
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
