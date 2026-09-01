/// The three-slot piece tray. Each piece is draggable onto the board and can
/// be tapped to rotate it 90° (free in beginner mode, else one charge).
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/block_skin.dart';
import '../../game/piece.dart';
import '../../l10n/app_localizations.dart';
import '../state/game_controller.dart';
import '../state/skin_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import 'board_view.dart';
import 'piece_view.dart';

/// Hit area of the per-piece rotate button. Both platforms ask for 44 px in
/// the primary axis; the width carries that here because the button sits in a
/// row of three and vertical space is the scarce one.
const double _rotateButtonWidth = 48;
const double _rotateButtonHeight = 36;

class TrayView extends ConsumerWidget {
  const TrayView({
    super.key,
    required this.boardCell,
    required this.height,
    this.trayOverride,
  });

  /// Board cell size — the feedback piece uses it so it matches the board 1:1.
  final double boardCell;
  final double height;

  /// Optional fixed tray used by previews and widget tests.
  final List<Piece?>? trayOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tray = trayOverride ?? ref.watch(gameControllerProvider).tray;
    final slotColors = ref.watch(activeThemeProvider).traySlots;
    final skin = ref.watch(activeSkinProvider);
    // Pieces are laid out at BOARD scale and only scaled down by the
    // FittedBox when they genuinely do not fit. Sizing every piece by the
    // tallest possible one (5 cells) is what made them tiny: a 5-cell column
    // at board scale is taller than any sane tray, so one rare shape was
    // shrinking the common ones by the same factor. A dot now renders at 1:1
    // with the board, and only tall shapes give ground.
    final pieceBoxHeight = (height - _rotateButtonHeight - 8)
        .clamp(24.0, double.infinity)
        .toDouble();

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var slot = 0; slot < tray.length; slot++)
            Expanded(
              child: Center(
                child: _slot(
                  context,
                  ref,
                  tray[slot],
                  slot,
                  pieceBoxHeight,
                  slotColors,
                  skin,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _slot(
    BuildContext context,
    WidgetRef ref,
    Piece? piece,
    int slot,
    double pieceBoxHeight,
    List<Color> colors,
    BlockSkinStyle skin,
  ) {
    // A used slot used to vanish entirely, so the tray silently went from
    // three pieces to two with nothing marking the gap. A faint outline keeps
    // "3 pieces, then a refill" readable.
    if (piece == null) return _EmptySlot(cell: boardCell);
    final color = colors[slot % colors.length];

    final feedbackW = piece.width * boardCell;
    final feedbackH = piece.height * boardCell;

    void rotate() {
      final ok = ref.read(gameControllerProvider.notifier).rotateTray(slot);
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(L10n.of(context).boosterNoRotationsLeft),
          ),
        );
      }
    }

    return Draggable<int>(
      data: slot,
      dragAnchorStrategy: (draggable, context, position) =>
          Offset(feedbackW / 2, feedbackH / 2 + kFingerLiftCells * boardCell),
      // Safety net: whatever way the drag ends, never leave a stale preview.
      onDragEnd: (_) => ref.read(dragPreviewProvider.notifier).state = null,
      feedback: PieceView(
        piece: piece,
        cellSize: boardCell,
        color: color,
        skin: skin,
      ),
      childWhenDragging: Opacity(
        opacity: 0.25,
        child: SizedBox(
          height: pieceBoxHeight,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: PieceView(
              piece: piece,
              cellSize: boardCell,
              color: color,
              skin: skin,
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: PieceView(
                piece: piece,
                cellSize: boardCell,
                color: color,
                skin: skin,
              ),
            ),
          ),
          // 28x22 was well under the 44 px both platforms ask for, and it
          // sits inside the Draggable: a tap that drifted a few pixels
          // started a drag instead of rotating.
          Tooltip(
            message: L10n.of(context).trayRotatePiece,
            child: IconButton(
              tooltip: L10n.of(context).gameRotatePiece,
              onPressed: rotate,
              constraints: const BoxConstraints.tightFor(
                width: _rotateButtonWidth,
                height: _rotateButtonHeight,
              ),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.rotate_right_rounded, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder for a tray slot whose piece has been played.
class _EmptySlot extends StatelessWidget {
  const _EmptySlot({required this.cell});

  final double cell;

  @override
  Widget build(BuildContext context) {
    final size = (cell * 2).clamp(24.0, 56.0);
    return Opacity(
      opacity: 0.35,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cell * 0.22),
          border: Border.all(color: GridColors.gridLine, width: 1.5),
        ),
      ),
    );
  }
}
