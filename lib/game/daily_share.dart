/// Emoji rendering of a finished board, for the shareable daily result.
///
/// Language-free by construction: the grid carries no words, so it belongs
/// here with the rest of the pure logic while the sentence built around it
/// stays in the l10n layer (CLAUDE.md — `lib/game/` holds no display text).
library;

import 'board.dart';

class DailyShare {
  const DailyShare._();

  /// A cell that was still occupied when the run ended.
  static const String filledCell = '🟦';

  /// A cell that was free. Chosen over ⬛ because the pair has to stay legible
  /// on both a light and a dark chat background, and ⬛ disappears on one of
  /// them.
  static const String emptyCell = '⬜';

  /// The board as [Board.size] lines of emoji.
  ///
  /// The final board is the honest artefact of a daily run: everyone played
  /// the same pieces, so the shape someone died in is the whole story, and it
  /// needs no invented score thresholds to be comparable.
  static String grid(Board board) {
    final rows = <String>[];
    for (var r = 0; r < Board.size; r++) {
      final buffer = StringBuffer();
      for (var c = 0; c < Board.size; c++) {
        buffer.write(board.filledAt(r, c) ? filledCell : emptyCell);
      }
      rows.add(buffer.toString());
    }
    return rows.join('\n');
  }
}
