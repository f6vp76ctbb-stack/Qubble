/// Pure-Dart Puzzle Mode (MASTERPLAN.md C.4). No Flutter imports.
///
/// A [Puzzle] is a pre-filled board plus a fixed piece sequence; the goal is to
/// empty the board by placing the pieces (in order), completing and clearing
/// lines. Levels are built *constructively* so a solution is guaranteed, and
/// the [PuzzleSolver] additionally validates each level and reports the minimum
/// number of moves (for star rating).
library;

import 'dart:math';

import 'board.dart';
import 'piece.dart';

class Puzzle {
  const Puzzle({
    required this.level,
    required this.start,
    required this.pieces,
    required this.minMoves,
    required this.solution,
  });

  final int level;
  final Board start;
  final List<Piece> pieces;

  /// Fewest moves to empty the board (3-star target).
  final int minMoves;

  /// A known-good origin for each piece (parallel to [pieces]): placing
  /// `pieces[i]` at `solution[i]` in order empties the board. Powers cheap
  /// verification and a potential hint feature.
  final List<Cell> solution;
}

/// A bitboard split into two 32-bit halves (rows 0-3 in [lo], rows 4-7 in
/// [hi]). Board.size (8) divides evenly into 4-row halves, so no row or
/// column mask ever straddles the lo/hi boundary.
///
/// A single 64-bit mask would be simpler, but JavaScript numbers (used by the
/// web/dart2js backend) cannot represent 64-bit integers or bitwise-shift
/// past bit 31 exactly. Every value used here stays within 32 safe bits on
/// every platform (VM, AOT, and web).
class Mask {
  const Mask(this.lo, this.hi);

  static const Mask zero = Mask(0, 0);

  final int lo;
  final int hi;

  bool get isEmpty => lo == 0 && hi == 0;

  Mask operator |(Mask other) => Mask(lo | other.lo, hi | other.hi);

  bool overlaps(Mask other) => (lo & other.lo) != 0 || (hi & other.hi) != 0;

  @override
  bool operator ==(Object other) =>
      other is Mask && other.lo == lo && other.hi == hi;

  @override
  int get hashCode => Object.hash(lo, hi);
}

/// Bitboard helpers: cell (r,c) -> bit c within row r's byte, packed 4 rows
/// per 32-bit half. Row r lives in [lo] if r < 4, else in [hi] at row (r-4).
class BitBoard {
  const BitBoard._();

  static const int _rowsPerHalf = 4;
  static const int fullRow = 0xFF;
  static const int col0PerHalf = 0x01010101; // column 0, within one half

  static (int half, int bitRow) _location(int row) {
    return row < _rowsPerHalf ? (0, row) : (1, row - _rowsPerHalf);
  }

  static Mask fromBoard(Board b) {
    var lo = 0;
    var hi = 0;
    for (var r = 0; r < Board.size; r++) {
      final (half, bitRow) = _location(r);
      for (var c = 0; c < Board.size; c++) {
        if (b.filledAt(r, c)) {
          final bit = 1 << (bitRow * Board.size + c);
          if (half == 0) {
            lo |= bit;
          } else {
            hi |= bit;
          }
        }
      }
    }
    return Mask(lo, hi);
  }

  /// The bit mask of [piece] placed with its top-left at (row, col).
  static Mask pieceMaskAt(Piece piece, int row, int col) {
    var lo = 0;
    var hi = 0;
    for (final cell in piece.cells) {
      final r = row + cell.row;
      final c = col + cell.col;
      final (half, bitRow) = _location(r);
      final bit = 1 << (bitRow * Board.size + c);
      if (half == 0) {
        lo |= bit;
      } else {
        hi |= bit;
      }
    }
    return Mask(lo, hi);
  }

  /// Adds [pieceMask] and removes any completed rows/columns.
  static Mask applyPlacement(Mask board, Mask pieceMask) {
    final next = board | pieceMask;
    var clearedLo = 0;
    var clearedHi = 0;

    for (var bitRow = 0; bitRow < _rowsPerHalf; bitRow++) {
      final rowMask = fullRow << (bitRow * Board.size);
      if (next.lo & rowMask == rowMask) clearedLo |= rowMask;
      if (next.hi & rowMask == rowMask) clearedHi |= rowMask;
    }
    for (var c = 0; c < Board.size; c++) {
      final colMask = col0PerHalf << c;
      final loFull = next.lo & colMask == colMask;
      final hiFull = next.hi & colMask == colMask;
      if (loFull && hiFull) {
        clearedLo |= colMask;
        clearedHi |= colMask;
      }
    }
    return Mask(next.lo & ~clearedLo, next.hi & ~clearedHi);
  }
}

class PuzzleSolver {
  const PuzzleSolver._();

  /// All legal top-left placement masks for [piece] on an 8x8 board (ignoring
  /// occupancy — filtered at solve time).
  static List<Mask> _placements(Piece piece) {
    final out = <Mask>[];
    for (var r = 0; r <= Board.size - piece.height; r++) {
      for (var c = 0; c <= Board.size - piece.width; c++) {
        out.add(BitBoard.pieceMaskAt(piece, r, c));
      }
    }
    return out;
  }

  /// Minimum moves to empty [start] by placing [pieces] in order, or null if
  /// impossible. Pieces must be placed in sequence; reaching an empty board
  /// ends the puzzle (remaining pieces are unused).
  ///
  /// [budget] caps the number of search nodes so a pathological state can't
  /// hang the UI; when the budget is exhausted the search reports "unknown"
  /// as [budgetExceeded] (see [solve]) — callers that only need a yes/no
  /// answer should treat that conservatively.
  static int? minMovesToEmpty(Board start, List<Piece> pieces,
      {int budget = 200000}) {
    return solve(start, pieces, budget: budget).moves;
  }

  /// Full result of a bounded search: [moves] is the minimum (or null if
  /// proven impossible), and [budgetExceeded] is true if the node budget ran
  /// out before the search finished (so [moves] may be incomplete).
  ///
  /// This explores every placement of every piece to prove the minimum. When
  /// the caller only needs to know whether the board can still be emptied —
  /// which is what the in-game "stuck" check asks — use [canEmpty]: it stops
  /// at the first solution and is far cheaper.
  static PuzzleSolveResult solve(Board start, List<Piece> pieces,
      {int budget = 200000}) {
    final placements = [for (final p in pieces) _placements(p)];
    // Keyed by a record rather than an interpolated string: the string form
    // allocated once per visited node, up to the whole budget per move.
    final memo = <(int, int, int), int?>{};
    var nodes = 0;
    var exceeded = false;

    int? search(Mask board, int idx) {
      if (board.isEmpty) return 0;
      if (idx >= pieces.length) return null;
      if (exceeded) return null;
      if (++nodes > budget) {
        exceeded = true;
        return null;
      }
      final key = (board.lo, board.hi, idx);
      final cached = memo[key];
      if (cached != null || memo.containsKey(key)) return cached;

      int? best;
      for (final mask in placements[idx]) {
        if (board.overlaps(mask)) continue; // overlap
        final next = BitBoard.applyPlacement(board, mask);
        final sub = search(next, idx + 1);
        if (sub != null && (best == null || sub + 1 < best)) {
          best = sub + 1;
        }
      }
      // Don't memoize partial results produced after the budget blew.
      if (!exceeded) memo[key] = best;
      return best;
    }

    final moves = search(BitBoard.fromBoard(start), 0);
    return PuzzleSolveResult(moves: moves, budgetExceeded: exceeded);
  }

  /// Whether [start] can still be emptied by placing [pieces] in order.
  ///
  /// Stops at the first solution instead of proving the minimum, so it visits
  /// a fraction of the nodes [solve] does. Runs after every placement on the
  /// UI thread, where [solve]'s exhaustive search cost 60-180 ms per move on
  /// a desktop VM — several times that on a phone.
  ///
  /// [budgetExceeded] means the search was cut short, so "no" is unproven;
  /// callers must treat that as "keep playing" rather than a failure.
  ///
  /// The budget is deliberately small. From a full start board with all ten
  /// pieces the space is large enough that even 300.000 nodes leaves a third
  /// of the levels unproven, at hundreds of milliseconds a call — so paying
  /// for it buys almost no extra detection. As pieces are placed the search
  /// shrinks fast, and by the time a player is genuinely stuck it is both
  /// cheap and decisive. Early detection is therefore best-effort by design;
  /// the guaranteed backstop is that the current piece stops fitting at all.
  static PuzzleSolveResult canEmpty(Board start, List<Piece> pieces,
      {int budget = 25000}) {
    final placements = [for (final p in pieces) _placements(p)];
    final seen = <(int, int, int)>{};
    var nodes = 0;
    var exceeded = false;

    bool search(Mask board, int idx) {
      if (board.isEmpty) return true;
      if (idx >= pieces.length || exceeded) return false;
      if (++nodes > budget) {
        exceeded = true;
        return false;
      }
      final key = (board.lo, board.hi, idx);
      if (!seen.add(key)) return false; // already proven unsolvable from here

      for (final mask in placements[idx]) {
        if (board.overlaps(mask)) continue;
        if (search(BitBoard.applyPlacement(board, mask), idx + 1)) return true;
      }
      return false;
    }

    final ok = search(BitBoard.fromBoard(start), 0);
    return PuzzleSolveResult(
      moves: ok ? 0 : null,
      budgetExceeded: exceeded,
    );
  }
}

/// Outcome of a bounded [PuzzleSolver.solve].
class PuzzleSolveResult {
  const PuzzleSolveResult({required this.moves, required this.budgetExceeded});

  final int? moves;
  final bool budgetExceeded;
}

/// Star rating and coin rewards for puzzle levels (MASTERPLAN.md C.4).
class PuzzleRules {
  const PuzzleRules._();

  /// 3 stars = solved first try, unaided. 2 = one crutch. 1 = both.
  ///
  /// This used to compare moves against minMoves, which could not grade
  /// anything: the generator carves holes that exactly tile the empty cells,
  /// so a solved board has always taken exactly one move per piece and
  /// `moves == minMoves` always held. Every solve scored three stars, and the
  /// display on three screens showed a rating that had never rated.
  ///
  /// The move count cannot be made to vary without redesigning the mode —
  /// pieces arrive in a fixed order, so there is no shorter path to grade
  /// against. What does vary is how much help the player needed: how many
  /// attempts the level took, and whether they spent the rewarded extra move.
  static int stars({required int attempts, required bool usedExtraMove}) {
    var earned = 3;
    if (attempts > 1) earned -= 1;
    if (usedExtraMove) earned -= 1;
    return earned < 1 ? 1 : earned;
  }

  /// 10 coins per level, +25 bonus on every 10th level.
  static int coinReward(int level) => 10 + ((level + 1) % 10 == 0 ? 25 : 0);
}

class PuzzleGenerator {
  const PuzzleGenerator._();

  static const int seedBase = 0x2A75E1; // "RÄTSEL"

  /// Builds puzzle [level] deterministically. Guaranteed solvable by
  /// construction; the solver both verifies it and measures the minimum moves.
  ///
  /// Difficulty ramps with the level: more, taller bands and — from level 5 —
  /// several holes per band, so a band only clears once every one of its
  /// pieces is placed. That means more moves, a fuller board, and real
  /// decisions (pieces of the same shape can fit multiple holes).
  static Puzzle generate(int level) {
    final rng = Random(seedBase + level);
    final catalog = buildCatalog()
        .where((p) => p.height <= 3 && p.size >= 2 && p.size <= 5)
        .toList();

    // How many stacked bands, and how many piece-holes to carve out of each.
    //
    // The band count is not the difficulty lever it looks like: bands fill
    // rows 0..6 (row 7 stays empty so no column is pre-full), and with heights
    // of 1..3 the row budget runs out before five bands do. Raising it changes
    // nothing.
    //
    // What does scale is holes per band and the overall piece cap, because
    // both add moves. These used to saturate at level 5 and 9 respectively,
    // with the cap at a flat 10 — so level 500 averaged 8.00 moves against
    // 7.75 for level 20, and the ramp was over before most players noticed
    // there was one. Carving is best-effort: a band with no room for another
    // hole simply gets fewer, and the existing fallback still guarantees one.
    final bandCount = (2 + level ~/ 3).clamp(2, 5);
    final holesPerBand = level < 5
        ? 1
        : level < 15
            ? 2
            : level < 40
                ? 3
                : 4;
    final maxPieces = (10 + (level - 15) ~/ 12).clamp(10, 18);

    final cells = List<bool>.filled(Board.size * Board.size, false);
    final pieces = <Piece>[];
    final origins = <Cell>[]; // carved hole top-left, parallel to pieces

    var top = 0;
    for (var band = 0; band < bandCount && pieces.length < maxPieces; band++) {
      // Leave at least the last row empty, so no column is ever fully filled
      // in the start board (a pre-full column would clear on the first move
      // and tear holes in the other bands, making the level unsolvable).
      final maxH = min(3, (Board.size - 1) - top);
      if (maxH < 1) break;
      final h = 1 + rng.nextInt(maxH);

      // Fill this band's rows completely, then carve out the holes.
      for (var r = top; r < top + h; r++) {
        for (var c = 0; c < Board.size; c++) {
          cells[r * Board.size + c] = true;
        }
      }

      final bandCandidates = catalog.where((p) => p.height <= h).toList();
      var carved = 0;
      for (var attempt = 0;
          attempt < 40 &&
              carved < holesPerBand &&
              pieces.length < maxPieces;
          attempt++) {
        final piece = bandCandidates[rng.nextInt(bandCandidates.length)];
        final rowOff = top + rng.nextInt(h - piece.height + 1);
        final colOff = rng.nextInt(Board.size - piece.width + 1);
        // Only carve where every target cell is still filled (no overlap with
        // an earlier hole in this band).
        final fits = piece.cells.every((cell) =>
            cells[(rowOff + cell.row) * Board.size + (colOff + cell.col)]);
        if (!fits) continue;
        for (final cell in piece.cells) {
          cells[(rowOff + cell.row) * Board.size + (colOff + cell.col)] = false;
        }
        pieces.add(piece);
        origins.add(Cell(rowOff, colOff));
        carved += 1;
      }

      // Guarantee at least one hole so the band is always clearable.
      if (carved == 0) {
        final piece = bandCandidates.first;
        for (final cell in piece.cells) {
          cells[(top + cell.row) * Board.size + cell.col] = false;
        }
        pieces.add(piece);
        origins.add(Cell(top, 0));
      }

      top += h;
      if (top >= Board.size - 1) break;
    }

    // Shuffle piece + origin together so the solution order isn't simply
    // top-to-bottom (keeps the piece↔origin pairing intact).
    final order = [for (var i = 0; i < pieces.length; i++) i]..shuffle(rng);
    final shuffledPieces = [for (final i in order) pieces[i]];
    final shuffledOrigins = [for (final i in order) origins[i]];
    pieces
      ..clear()
      ..addAll(shuffledPieces);
    origins
      ..clear()
      ..addAll(shuffledOrigins);

    final start = Board.fromAscii([
      for (var r = 0; r < Board.size; r++)
        String.fromCharCodes([
          for (var c = 0; c < Board.size; c++)
            cells[r * Board.size + c] ? 0x23 : 0x2e,
        ]),
    ]);

    // By construction every band clears once its holes are filled, and the
    // holes exactly tile the empty cells — so the board empties in exactly one
    // move per piece. minMoves is therefore the piece count. The assert
    // cheaply replays the recorded [solution] to confirm it empties the board
    // (no exponential solver needed).
    assert(
      _replayEmpties(start, pieces, origins),
      'constructed puzzle $level does not empty via its solution',
    );

    return Puzzle(
      level: level,
      start: start,
      pieces: pieces,
      minMoves: pieces.length,
      solution: origins,
    );
  }

  /// Places each piece at its solution origin, in order, and returns whether
  /// the board ends up empty.
  static bool _replayEmpties(
    Board start,
    List<Piece> pieces,
    List<Cell> origins,
  ) {
    var board = start;
    for (var i = 0; i < pieces.length; i++) {
      if (!board.canPlace(pieces[i], origins[i])) return false;
      board = board.place(pieces[i], origins[i]).board;
    }
    return board.isEmpty;
  }
}
