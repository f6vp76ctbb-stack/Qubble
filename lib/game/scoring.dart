/// Pure-Dart scoring for GridPop. No Flutter imports.
///
/// Rules (MASTERPLAN.md §4 "Scoring" + Anhang A):
///  - Placement: +1 point per occupied cell.
///  - Clear: 10 points per cleared cell, multiplied by the number of lines
///    cleared in that move (capped at x4).
///  - Combo: clears within [comboWindowMoves] non-clearing placements of the
///    previous clear build a combo multiplier (1.0, 1.5, 2.0, ...). The window
///    is counted in MOVES, not seconds — see [comboWindowMoves].
///  - Fever meter: each cleared line fills the meter; when it fills up, that
///    move's clear points are doubled ("fever burst") and the meter resets.
///  - All Clear: a large flat bonus — rare enough (2 % of runs) that it has to
///    be worth the celebration it already gets.
library;

/// Outcome of scoring a single placement.
class ScoreEvent {
  const ScoreEvent({
    required this.gained,
    required this.total,
    required this.combo,
    required this.feverLevel,
    required this.feverBurst,
  });

  /// Points added by this move.
  final int gained;

  /// Running total after this move.
  final int total;

  /// Combo count after this move (0 when no active streak).
  final int combo;

  /// Fever meter in the range 0.0 .. 1.0 after this move.
  final double feverLevel;

  /// True if this move triggered a fever burst (doubled clear points).
  final bool feverBurst;
}

/// Mutable scorer that carries combo and fever state across a run.
class ScoreKeeper {
  ScoreKeeper({
    this.pointsPerPlacedCell = 1,
    this.pointsPerClearedCell = 10,
    this.maxLineMultiplier = 4,
    this.comboStep = 0.5,
    this.maxComboMultiplier = 4.0,
    this.comboWindowMoves = defaultComboWindowMoves,
    this.feverPerLine = 0.2,
    this.feverDecayNoClear = 0.05,
    this.allClearBonus = 1500,
    this.speedBonusMax = defaultSpeedBonusMax,
    this.speedFullBelow = defaultSpeedFullBelow,
    this.speedZeroAbove = defaultSpeedZeroAbove,
  });

  final int pointsPerPlacedCell;
  final int pointsPerClearedCell;
  final int maxLineMultiplier;
  final double comboStep;

  /// Ceiling on the combo multiplier.
  ///
  /// It used to be unbounded, and it multiplies the line multiplier on top:
  /// the same four-line clear was worth ~1.200 points at combo 1 and ~12.600
  /// at combo 20. Since the combo survives non-clearing moves and only the
  /// clock ends it, it was effectively a permanent ramp — active on 71 % of
  /// all moves across 15.000 simulated runs. Score therefore grew with the
  /// square of run length, and seed luck (p95/p05 = 31.6x) outweighed play
  /// quality (6.3x between the best and worst strategy on the same seed).
  /// Capping it puts the two back in the same order of magnitude.
  final double maxComboMultiplier;

  /// Non-clearing placements a combo survives. A clear inside the window
  /// extends the combo; beyond it, the streak restarts at 1.
  ///
  /// This used to be a ten-second clock, in a game whose own description
  /// promises no time pressure. It was not a neutral rule: 96.6 % of all
  /// points run through the combo multiplier (BALANCE.md D.3), so the clock
  /// quietly priced thinking time. Measured over 1.500 seeds with identical
  /// play (`scripts/audit/combo_window.dart`), the same player scored 5.354 at
  /// 1,5 s per move and 2.077 at 6 s — a factor of 2,6 decided by tapping
  /// speed alone, on a public leaderboard.
  ///
  /// Three is the value that leaves the score distribution exactly where the
  /// clock left it for a player at the reference pace of 2,2 s per move: mean
  /// 4.140, median 3.124, p95/p05 23,3x, identical on both rules. The change
  /// therefore removes the pace dependency without being a balance patch in
  /// disguise.
  final int comboWindowMoves;

  /// See [comboWindowMoves] for why it is three.
  static const int defaultComboWindowMoves = 3;

  /// Largest share a fast player can add to a clear, as a fraction.
  ///
  /// Playing quickly should be worth something — that is most of the appeal of
  /// the genre. What it must not be worth is what it used to be: the old
  /// ten-second combo clock fed the MULTIPLIER, so a timing edge compounded
  /// with run length into a factor of 2,6 between 1,5 s and 6 s per move
  /// (BALANCE.md, Nachtrag 3). This bonus is deliberately built the other way
  /// round — additive, applied once to the points of a single clear, and
  /// capped — so the advantage of always-fast over always-slow play cannot
  /// exceed this figure no matter how long the run gets.
  static const double defaultSpeedBonusMax = 0.30;

  /// At or below this gap between placements the bonus is full.
  static const Duration defaultSpeedFullBelow = Duration(milliseconds: 1500);

  /// At or above this gap there is no bonus at all. Between the two the bonus
  /// falls off linearly, so there is no cliff to feel cheated by.
  static const Duration defaultSpeedZeroAbove = Duration(milliseconds: 4000);

  final double feverPerLine;
  final double feverDecayNoClear;
  final int allClearBonus;

  /// See [defaultSpeedBonusMax].
  final double speedBonusMax;
  final Duration speedFullBelow;
  final Duration speedZeroAbove;

  int _total = 0;
  int _combo = 0;
  double _fever = 0;
  int _movesSinceClear = 0;
  DateTime? _lastPlacementAt;

  int get total => _total;
  int get combo => _combo;
  double get feverLevel => _fever;

  /// Non-clearing moves the current combo still has left, or null while no
  /// combo is running. The UI shows this instead of a countdown, because
  /// there is nothing left to count down.
  /// When the last placement was scored, or null at the start of a run.
  DateTime? get lastPlacementAt => _lastPlacementAt;

  /// The speed bonus a clear would get right now, as a fraction of the clear's
  /// points. Pure, so the HUD can show the player what they are playing for
  /// instead of leaving another invisible rule in the scoring.
  double speedBonusAt(DateTime now) {
    final last = _lastPlacementAt;
    if (last == null) return 0;
    final elapsed = now.difference(last);
    if (elapsed <= speedFullBelow) return speedBonusMax;
    if (elapsed >= speedZeroAbove) return 0;
    final span =
        speedZeroAbove.inMicroseconds - speedFullBelow.inMicroseconds;
    final left = speedZeroAbove.inMicroseconds - elapsed.inMicroseconds;
    return speedBonusMax * left / span;
  }

  int? get comboMovesLeft {
    if (_combo <= 0) return null;
    final left = comboWindowMoves - _movesSinceClear;
    return left < 0 ? 0 : left;
  }

  void reset() {
    _total = 0;
    _combo = 0;
    _fever = 0;
    _movesSinceClear = 0;
    _lastPlacementAt = null;
  }

  /// Captures the current scoring state (for one-step undo).
  ScoreMemento save() => ScoreMemento(
    _total,
    _combo,
    _fever,
    _movesSinceClear,
    _lastPlacementAt,
  );

  /// Restores a previously [save]d state.
  void restore(ScoreMemento m) {
    _total = m.total;
    _combo = m.combo;
    _fever = m.fever;
    _movesSinceClear = m.movesSinceClear;
    _lastPlacementAt = m.lastPlacementAt;
  }

  /// Applies a placement outcome and returns the resulting [ScoreEvent].
  ///
  /// [now] drives the speed bonus only. The combo window is counted in moves
  /// and never looks at the clock — that separation is the whole point: the
  /// bonus is additive and capped, the combo is not, and mixing them is what
  /// produced the old 2,6x spread. Omitting [now] disables the bonus, which is
  /// what a test that does not care about timing wants.
  ScoreEvent applyPlacement({
    required int placedCells,
    required int clearedLines,
    required int clearedCells,
    required bool isAllClear,
    DateTime? now,
  }) {
    final speedBonus = now == null ? 0.0 : speedBonusAt(now);
    if (now != null) _lastPlacementAt = now;
    var gained = placedCells * pointsPerPlacedCell;
    var burst = false;

    if (clearedLines > 0) {
      final expired = _movesSinceClear > comboWindowMoves;
      _movesSinceClear = 0;
      _combo = (_combo == 0 || expired) ? 1 : _combo + 1;

      final lineMultiplier =
          clearedLines > maxLineMultiplier ? maxLineMultiplier : clearedLines;
      final rawCombo = 1.0 + (_combo - 1) * comboStep;
      final comboMultiplier =
          rawCombo > maxComboMultiplier ? maxComboMultiplier : rawCombo;

      _fever += clearedLines * feverPerLine;
      if (_fever >= 1.0) {
        burst = true;
        _fever = 0;
      }

      var clearPoints =
          clearedCells * pointsPerClearedCell * lineMultiplier * comboMultiplier;
      if (burst) clearPoints *= 2;
      // Applied last and only here, so the cap is exact: whatever the combo,
      // the fever and the line count did, a fast clear is worth at most
      // (1 + speedBonusMax) of what the same clear pays a slow player.
      clearPoints *= 1 + speedBonus;
      gained += clearPoints.round();

      if (isAllClear) gained += allClearBonus;
    } else {
      // A single non-clearing move no longer kills the combo; it spends one of
      // the window's moves. It still cools the fever meter, and a spent window
      // drops the combo so the next clear starts a fresh streak.
      _movesSinceClear++;
      if (_movesSinceClear > comboWindowMoves) {
        _combo = 0;
      }
      _fever -= feverDecayNoClear;
      if (_fever < 0) _fever = 0;
    }

    _total += gained;
    return ScoreEvent(
      gained: gained,
      total: _total,
      combo: _combo,
      feverLevel: _fever,
      feverBurst: burst,
    );
  }
}

/// Immutable snapshot of [ScoreKeeper] state for one-step undo.
class ScoreMemento {
  const ScoreMemento(
    this.total,
    this.combo,
    this.fever, [
    this.movesSinceClear = 0,
    this.lastPlacementAt,
  ]);

  final int total;
  final int combo;
  final double fever;
  final int movesSinceClear;

  /// Only for one-step undo. Deliberately NOT persisted in a checkpoint: a run
  /// resumed hours later must not carry a stale "you were fast" timestamp.
  final DateTime? lastPlacementAt;
}
