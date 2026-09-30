/// Renders a single [Piece] as coloured rounded cells.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../game/accessory.dart';
import '../../game/block_skin.dart';
import '../../game/piece.dart';
import 'accessory_painter.dart';
import 'cell_style.dart';

class PieceView extends StatelessWidget {
  const PieceView({
    super.key,
    required this.piece,
    required this.cellSize,
    required this.color,
    this.opacity = 1.0,
    this.skin = BlockSkinStyle.solid,
    this.clock,
    this.accessory = AccessoryStyle.none,
  });

  final Piece piece;
  final double cellSize;
  final Color color;
  final double opacity;
  final BlockSkinStyle skin;

  /// Seconds for an animated [skin] (see `SkinClock`); null draws a still.
  final ValueListenable<double>? clock;

  /// Drawn on the piece's cells that wear it (`wearsAccessory`).
  final AccessoryStyle accessory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: piece.width * cellSize,
      height: piece.height * cellSize,
      child: CustomPaint(
        painter: _PiecePainter(
          piece,
          cellSize,
          color,
          opacity,
          skin,
          clock,
          accessory,
        ),
      ),
    );
  }
}

class _PiecePainter extends CustomPainter {
  _PiecePainter(
    this.piece,
    this.cellSize,
    this.color,
    this.opacity,
    this.skin,
    this.clock,
    this.accessory,
  ) : super(repaint: clock);

  final Piece piece;
  final double cellSize;
  final Color color;
  final double opacity;
  final BlockSkinStyle skin;
  final ValueListenable<double>? clock;
  final AccessoryStyle accessory;

  @override
  void paint(Canvas canvas, Size size) {
    final time = clock?.value ?? 0;
    const inset = 1.5;
    final radius = cellSize * 0.22;
    final drawColor = color.withValues(alpha: opacity);
    for (final cell in piece.cells) {
      final rect = Rect.fromLTWH(
        cell.col * cellSize + inset,
        cell.row * cellSize + inset,
        cellSize - inset * 2,
        cellSize - inset * 2,
      );
      paintCell(
        canvas,
        rect,
        radius,
        drawColor,
        skin,
        time: time,
        phase: (cell.row + cell.col).toDouble(),
      );
      if (wearsAccessory(cell.row, cell.col)) {
        paintAccessory(canvas, rect, accessory, alpha: opacity);
      }
    }
  }

  @override
  bool shouldRepaint(_PiecePainter old) =>
      old.piece != piece ||
      old.cellSize != cellSize ||
      old.color != color ||
      old.opacity != opacity ||
      old.skin != skin ||
      old.clock != clock ||
      old.accessory != accessory;
}
