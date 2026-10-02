// The puzzle hint (owner decision 02.10.2026): a voluntary video shows where
// the current piece goes. A hint must never lead the player astray — every
// hint keeps the board emptiable — and it must also work after the player
// left the generator's own solution.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart' show Cell;
import 'package:gridpop/game/puzzle.dart';

/// Follows hints from [board] after the moves in [placed] to the end; true
/// when the board ends up empty.
bool hintsEmpty(Puzzle p, List<Cell> placed, Board board) {
  final moves = [...placed];
  while (!board.isEmpty && moves.length < p.pieces.length) {
    final hint = PuzzleHint.next(p, moves, board);
    final piece = p.pieces[moves.length];
    if (hint == null || !board.canPlace(piece, hint)) return false;
    board = board.place(piece, hint).board;
    moves.add(hint);
  }
  return board.isEmpty;
}

void main() {
  test("on the generator's own path the hint is its solution", () {
    for (var level = 0; level < 60; level++) {
      final p = PuzzleGenerator.generate(level);
      var board = p.start;
      for (var i = 0; i < p.pieces.length; i++) {
        expect(
          PuzzleHint.next(p, p.solution.sublist(0, i), board),
          p.solution[i],
          reason: 'level $level, piece $i',
        );
        board = board.place(p.pieces[i], p.solution[i]).board;
      }
    }
  });

  test('after the player took another hole of the same shape, hints still '
      'empty the board', () {
    // Same-shaped pieces fit each other's holes; taking the "wrong" one is
    // the usual way off the generator's path.
    var checked = 0;
    for (var level = 0; level < 200; level++) {
      final p = PuzzleGenerator.generate(level);
      var board = p.start;
      for (var i = 0; i < p.pieces.length; i++) {
        final other = [
          for (var j = i + 1; j < p.pieces.length; j++)
            if (p.pieces[j].id == p.pieces[i].id &&
                board.canPlace(p.pieces[i], p.solution[j]))
              p.solution[j],
        ];
        if (other.isNotEmpty) {
          final off = board.place(p.pieces[i], other.first).board;
          final placed = [...p.solution.sublist(0, i), other.first];
          expect(
            hintsEmpty(p, placed, off),
            isTrue,
            reason: 'level $level, piece $i',
          );
          checked += 1;
        }
        board = board.place(p.pieces[i], p.solution[i]).board;
      }
    }
    expect(checked, greaterThan(50), reason: 'the case must actually occur');
  });

  test('after a move outside the holes, a hint is still only given when it '
      'empties the board', () {
    // Such a move almost always loses the level, and the search then finds
    // nothing; the rare one that does not must still get a correct hint.
    var given = 0;
    var refused = 0;
    for (var level = 0; level < 16; level++) {
      final p = PuzzleGenerator.generate(level);
      final k = level % p.pieces.length;
      var board = p.start;
      for (var i = 0; i < k; i++) {
        board = board.place(p.pieces[i], p.solution[i]).board;
      }
      final piece = p.pieces[k];
      for (var r = 0; r <= Board.size - piece.height; r++) {
        for (var c = 0; c <= Board.size - piece.width; c++) {
          final spot = Cell(r, c);
          if (!board.canPlace(piece, spot) || p.solution.contains(spot)) {
            continue;
          }
          final next = board.place(piece, spot).board;
          if (next.isEmpty) continue;
          final placed = [...p.solution.sublist(0, k), spot];
          if (PuzzleHint.next(p, placed, next, budget: 2000) == null) {
            refused += 1;
            continue;
          }
          expect(
            hintsEmpty(p, placed, next),
            isTrue,
            reason: 'level $level, piece $k at $spot',
          );
          given += 1;
        }
      }
    }
    expect(given, greaterThan(0), reason: 'the case must actually occur');
    expect(refused, greaterThan(0));
  });

  test('no hint where the board can no longer be emptied', () {
    var checked = 0;
    for (var level = 0; level < 4; level++) {
      final p = PuzzleGenerator.generate(level);
      final piece = p.pieces.first;
      for (var r = 0; r <= Board.size - piece.height; r++) {
        for (var c = 0; c <= Board.size - piece.width; c++) {
          if (!p.start.canPlace(piece, Cell(r, c))) continue;
          final next = p.start.place(piece, Cell(r, c)).board;
          final proof = PuzzleSolver.canEmpty(
            next,
            p.pieces.sublist(1),
            budget: 300000,
          );
          if (proof.budgetExceeded || proof.moves != null) continue;
          expect(
            PuzzleHint.next(p, [Cell(r, c)], next),
            isNull,
            reason: 'level $level at ($r,$c)',
          );
          checked += 1;
        }
      }
    }
    expect(checked, greaterThan(5), reason: 'the case must actually occur');
  });

  test('no hint once every piece is placed', () {
    final p = PuzzleGenerator.generate(0);
    expect(PuzzleHint.next(p, p.solution, Board.empty()), isNull);
  });
}
