/// Pure-Dart, seedable piece generator for GridPop. No Flutter imports.
///
/// Fairness rules (MASTERPLAN.md Anhang A.2):
///  1. A tray always holds 3 pieces; a new tray is drawn only once all 3 are
///     placed (the caller owns that lifecycle).
///  2. Rescue: if none of the 3 drawn pieces fit the board, the last slot is
///     replaced by the largest currently-placeable piece. If nothing fits at
///     all, game over is legitimate.
///  3. Early phase (first 10 placements of a run): placeable pieces get a
///     x1.5 weight bonus. Afterwards, base weights only.
///  4. Fully determined by the seed — basis for the Daily Challenge and tests.
///  5. Optional [SpawnAssist] (endless runs since 1.6.0): for the opening of a
///     run the weights follow what a piece can do on the board in front of
///     the player. It replaces rule 3 while it is active and fades out, after
///     which the generator is exactly the classic one.
library;

import 'dart:math';

import 'board.dart';
import 'piece.dart';

/// How strongly the generator leans towards pieces that suit the board, and
/// for how long into a run.
///
/// Rule 3 above was meant to do this and could not: on the nearly empty board
/// of an opening every piece is placeable, so the bonus raised every weight
/// alike and changed nothing. Measured before the assist (BALANCE.md D.2 and
/// Nachtrag 5): a competent player's run ended after a median of 38 moves and
/// one run in eight before move 21 — a game over every minute and a half,
/// decided mostly by the draw.
///
/// The assist asks a different question of each piece: can it complete a line
/// here, can it complete two, or does it fit nowhere at all? Line-completing
/// pieces come up more often, dead ones rarely. It is strongest at the start
/// and gone after [fullMoves] + [fadeMoves] placements, so the late game is
/// as honest as it always was (MASTERPLAN.md §4: "Spät in der Runde wird es
/// ehrlich-schwer").
///
/// The Daily Challenge never uses it: every player has to get the same pieces
/// whatever version of the app they run.
class SpawnAssist {
  const SpawnAssist({
    required this.fullMoves,
    required this.fadeMoves,
    this.clearBonus = defaultClearBonus,
    this.multiClearBonus = defaultMultiClearBonus,
    this.deadWeight = defaultDeadWeight,
  }) : assert(fullMoves >= 0),
       assert(fadeMoves >= 0),
       assert(clearBonus >= 0),
       assert(multiClearBonus >= 0),
       assert(deadWeight >= 0 && deadWeight <= 1);

  /// No help: the classic generator.
  static const SpawnAssist none = SpawnAssist(fullMoves: 0, fadeMoves: 0);

  static const double defaultClearBonus = 2.0;
  static const double defaultMultiClearBonus = 1.0;
  static const double defaultDeadWeight = 0.1;

  /// Placements during which the help is at full strength.
  final int fullMoves;

  /// Placements over which it then fades to nothing, in a straight line.
  final int fadeMoves;

  /// Extra weight, at full strength, for a piece that can complete a line:
  /// 2.0 makes it three times as likely as its catalog weight.
  final double clearBonus;

  /// Further extra weight for a piece that can complete two or more at once,
  /// multiplied on top of [clearBonus].
  final double multiClearBonus;

  /// What is left, at full strength, of the weight of a piece that fits
  /// nowhere on the board.
  final double deadWeight;

  bool get isNone => fullMoves == 0 && fadeMoves == 0;

  /// 1.0 while the help is full, down to 0.0 once it is spent.
  double strengthAt(int placementsSoFar) {
    if (placementsSoFar < fullMoves) return 1.0;
    if (fadeMoves == 0) return 0.0;
    final t = (placementsSoFar - fullMoves) / fadeMoves;
    return t >= 1 ? 0.0 : 1.0 - t;
  }
}

class PieceGenerator {
  PieceGenerator({
    required int seed,
    List<Piece>? catalog,
    this.earlyPhaseMoves = defaultEarlyPhaseMoves,
    this.assist = SpawnAssist.none,
  }) : assert(earlyPhaseMoves >= 0),
       _rng = Random(seed),
       catalog = catalog ?? buildCatalog();

  static const int defaultEarlyPhaseMoves = 10;
  static const double earlyPlaceableBonus = 1.5;

  final Random _rng;
  final List<Piece> catalog;
  final int earlyPhaseMoves;

  /// The opening help of this run; [SpawnAssist.none] for the classic rules.
  final SpawnAssist assist;

  /// Draws a tray of 3 pieces for the given [board] state and the number of
  /// [placementsSoFar] in the current run.
  ///
  /// Every pick consumes exactly one random number, with or without an
  /// assist: a resumed run replays the generator by counting trays
  /// (GameSession.fromCheckpoint), which only works while that holds.
  List<Piece> nextTray(Board board, int placementsSoFar) {
    final strength = assist.strengthAt(placementsSoFar);
    final List<Piece> tray;
    if (strength > 0) {
      final weights = _assistedWeights(board, strength);
      tray = [for (var i = 0; i < 3; i++) _pickFrom(weights)];
    } else {
      final early = placementsSoFar < earlyPhaseMoves;
      tray = [for (var i = 0; i < 3; i++) _weightedPick(board, early)];
    }

    // Rescue rule: guarantee at least one placeable piece when possible.
    final anyPlaceable = tray.any(board.hasAnyPlacement);
    if (!anyPlaceable) {
      final rescue = _largestPlaceable(board);
      if (rescue != null) tray[2] = rescue;
    }
    return tray;
  }

  /// Catalog weights bent towards what each piece can do on [board].
  List<double> _assistedWeights(Board board, double strength) {
    final rowFill = List<int>.filled(Board.size, 0);
    final colFill = List<int>.filled(Board.size, 0);
    for (var r = 0; r < Board.size; r++) {
      for (var c = 0; c < Board.size; c++) {
        if (board.filledAt(r, c)) {
          rowFill[r]++;
          colFill[c]++;
        }
      }
    }
    return [
      for (final p in catalog)
        p.weight.toDouble() *
            _assistFactor(p, board, rowFill, colFill, strength),
    ];
  }

  double _assistFactor(
    Piece p,
    Board board,
    List<int> rowFill,
    List<int> colFill,
    double strength,
  ) {
    final lines = _bestClear(p, board, rowFill, colFill);
    if (lines < 0) return 1.0 - strength * (1.0 - assist.deadWeight);
    var factor = 1.0;
    if (lines >= 1) factor *= 1.0 + strength * assist.clearBonus;
    if (lines >= 2) factor *= 1.0 + strength * assist.multiClearBonus;
    return factor;
  }

  /// The most lines one placement of [p] would complete, or -1 if it fits
  /// nowhere. Counted from the row and column fills, so no board is built.
  int _bestClear(Piece p, Board board, List<int> rowFill, List<int> colFill) {
    var best = -1;
    final rowAdd = List<int>.filled(p.height, 0);
    final colAdd = List<int>.filled(p.width, 0);
    for (final cell in p.cells) {
      rowAdd[cell.row]++;
      colAdd[cell.col]++;
    }
    for (var r = 0; r <= Board.size - p.height; r++) {
      for (var c = 0; c <= Board.size - p.width; c++) {
        if (!board.canPlace(p, Cell(r, c))) continue;
        var lines = 0;
        for (var i = 0; i < p.height; i++) {
          if (rowAdd[i] > 0 && rowFill[r + i] + rowAdd[i] == Board.size) {
            lines++;
          }
        }
        for (var j = 0; j < p.width; j++) {
          if (colAdd[j] > 0 && colFill[c + j] + colAdd[j] == Board.size) {
            lines++;
          }
        }
        if (lines > best) best = lines;
      }
    }
    return best;
  }

  Piece _pickFrom(List<double> weights) {
    var totalWeight = 0.0;
    for (final w in weights) {
      totalWeight += w;
    }
    var roll = _rng.nextDouble() * totalWeight;
    for (var i = 0; i < catalog.length; i++) {
      roll -= weights[i];
      if (roll <= 0) return catalog[i];
    }
    return catalog.last; // floating-point guard
  }

  double _effectiveWeight(Piece p, Board board, bool early) {
    final base = p.weight.toDouble();
    if (early && board.hasAnyPlacement(p)) return base * earlyPlaceableBonus;
    return base;
  }

  Piece _weightedPick(Board board, bool early) {
    var totalWeight = 0.0;
    for (final p in catalog) {
      totalWeight += _effectiveWeight(p, board, early);
    }
    var roll = _rng.nextDouble() * totalWeight;
    for (final p in catalog) {
      roll -= _effectiveWeight(p, board, early);
      if (roll <= 0) return p;
    }
    return catalog.last; // floating-point guard
  }

  /// The placeable piece with the most cells (ties broken by weight, then id),
  /// or null if nothing fits.
  Piece? _largestPlaceable(Board board) {
    Piece? best;
    for (final p in catalog) {
      if (!board.hasAnyPlacement(p)) continue;
      if (best == null ||
          p.size > best.size ||
          (p.size == best.size && p.weight > best.weight) ||
          (p.size == best.size &&
              p.weight == best.weight &&
              p.id.compareTo(best.id) < 0)) {
        best = p;
      }
    }
    return best;
  }
}
