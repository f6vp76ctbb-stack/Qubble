/// The three-slot piece tray. Each piece is draggable onto the board and
/// turns 90° when tapped — or, while it is held, when a second finger taps
/// the screen (the game screen listens for that). The first turn of a piece
/// costs a charge outside beginner mode; after that it turns freely.
///
/// There is no rotate button any more (owner, 15.11.2026): the pieces get the
/// room it took, and the turn is where the player's hands already are.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/accessory.dart';
import '../../game/block_skin.dart';
import '../../game/piece.dart';
import '../../l10n/app_localizations.dart';
import '../state/cosmetic_controller.dart';
import '../state/game_controller.dart';
import '../state/settings_controller.dart';
import '../state/skin_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import 'board_view.dart';
import 'piece_view.dart';
import 'skin_clock.dart';

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
    final activeDrag = ref.watch(activeDragProvider);
    final slotColors = ref.watch(activeThemeProvider).traySlots;
    final skin = ref.watch(activeSkinProvider);
    final animate = skin.isAnimated && !ref.watch(reducedEffectsProvider);
    // Pieces are laid out at BOARD scale and only scaled down by the
    // FittedBox when they genuinely do not fit. Sizing every piece by the
    // tallest possible one (5 cells) is what made them tiny: a 5-cell column
    // at board scale is taller than any sane tray, so one rare shape was
    // shrinking the common ones by the same factor. A dot now renders at 1:1
    // with the board, and only tall shapes give ground.
    final pieceBoxHeight = (height - 8).clamp(24.0, double.infinity).toDouble();

    return SizedBox(
      height: height,
      child: SkinClock(
        running: animate,
        builder: (context, clock) => Row(
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
                    clock,
                    activeDrag,
                  ),
                ),
              ),
          ],
        ),
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
    ValueListenable<double>? clock,
    ActiveDrag? activeDrag,
  ) {
    // A used slot used to vanish entirely, so the tray silently went from
    // three pieces to two with nothing marking the gap. A faint outline keeps
    // "3 pieces, then a refill" readable.
    if (piece == null) return _EmptySlot(cell: boardCell);
    final color = colors[slot % colors.length];

    final feedbackW = piece.width * boardCell;
    final feedbackH = piece.height * boardCell;

    final l10n = L10n.of(context);
    final accessory = ref.watch(activeAccessoryProvider);

    void rotate() {
      // A second finger that lands on another piece while one is held must
      // not turn that one too: the held piece is the one that turns.
      if (ref.read(activeDragProvider) != null) return;
      rotateTrayPiece(context, ref, slot);
    }

    // While one piece is held, the others stay put: a second finger resting
    // on them must not pick up a second piece.
    final otherIsHeld = activeDrag != null && activeDrag.slot != slot;

    return Draggable<int>(
      data: slot,
      maxSimultaneousDrags: otherIsHeld ? 0 : 1,
      dragAnchorStrategy: (draggable, context, position) =>
          Offset(feedbackW / 2, feedbackH / 2 + kFingerLiftCells * boardCell),
      onDragStarted: () =>
          ref.read(activeDragProvider.notifier).state = ActiveDrag(
            slot: slot,
            startWidth: piece.width,
            startHeight: piece.height,
          ),
      // Safety net: whatever way the drag ends, never leave a stale preview.
      onDragEnd: (_) {
        ref.read(dragPreviewProvider.notifier).state = null;
        ref.read(activeDragProvider.notifier).state = null;
      },
      // The held piece follows its own turns: it reads the tray, not the
      // piece it was picked up as.
      feedback: _HeldPiece(
        slot: slot,
        fallback: piece,
        cellSize: boardCell,
        color: color,
        skin: skin,
        clock: clock,
        accessory: accessory,
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
              clock: clock,
              accessory: accessory,
            ),
          ),
        ),
      ),
      // A tap turns the piece. A drag only starts once the finger moves, so
      // the two do not compete; the whole slot is the target, not just the
      // painted cells, so a small piece is as easy to tap as a big one.
      child: Semantics(
        customSemanticsActions: {
          CustomSemanticsAction(label: l10n.trayRotatePiece): rotate,
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: rotate,
          child: SizedBox(
            height: pieceBoxHeight,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: PieceView(
                  piece: piece,
                  cellSize: boardCell,
                  color: color,
                  skin: skin,
                  clock: clock,
                  accessory: accessory,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Turns the tray piece in [slot], or says why it cannot turn. [held] when
/// the piece is being dragged (a second finger turned it).
void rotateTrayPiece(
  BuildContext context,
  WidgetRef ref,
  int slot, {
  bool held = false,
}) {
  final ok = ref
      .read(gameControllerProvider.notifier)
      .rotateTray(slot, held: held);
  if (!ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(L10n.of(context).boosterNoRotationsLeft),
      ),
    );
  }
}

/// The piece under the finger while it is dragged. It shows the tray's
/// current piece for [slot], so a turn while held is visible at once, and
/// keeps it centred where the drag began ([ActiveDrag.shift]).
class _HeldPiece extends ConsumerWidget {
  const _HeldPiece({
    required this.slot,
    required this.fallback,
    required this.cellSize,
    required this.color,
    required this.skin,
    required this.clock,
    required this.accessory,
  });

  final int slot;
  final Piece fallback;
  final double cellSize;
  final Color color;
  final BlockSkinStyle skin;
  final ValueListenable<double>? clock;
  final AccessoryStyle accessory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tray = ref.watch(gameControllerProvider.select((s) => s.tray));
    final piece = (slot < tray.length ? tray[slot] : null) ?? fallback;
    final drag = ref.watch(activeDragProvider);
    final shift = drag == null || drag.slot != slot
        ? Offset.zero
        : drag.shift(piece, cellSize);
    return Transform.translate(
      offset: shift,
      child: PieceView(
        piece: piece,
        cellSize: cellSize,
        color: color,
        skin: skin,
        clock: clock,
        accessory: accessory,
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
