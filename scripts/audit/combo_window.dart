// ignore_for_file: avoid_print
// Audit-only. NOT part of the app.
//
// Run:  dart run scripts/audit/combo_window.dart [runs]
//
// BACKLOG #29: the combo expires on a CLOCK (10 s), in a game whose whole
// pitch is that there is no time pressure. A player who needs longer to think
// keeps less combo than a fast one on the identical board, and 96.6 % of all
// points run through that multiplier (BALANCE.md D.3).
//
// Swapping the clock for a count of non-clearing moves removes that. The
// question this answers is which count leaves the SCORE distribution where it
// is, so the change is about fairness and not a silent balance patch.
import 'dart:math';

import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/scoring.dart';

/// Simulated player pace, so the speed bonus has something to react to.
class _Clock {
  _Clock(this.stepMs);
  final int stepMs;
  DateTime _t = DateTime.utc(2026, 1, 1);
  DateTime call() {
    _t = _t.add(Duration(milliseconds: stepMs));
    return _t;
  }
}

/// The "competent player" heuristic from balance.dart D.1.
double _noHoles(Board after, int lines, int filled) =>
    lines * 600.0 - _isolated(after) * 50.0 - filled;

int _isolated(Board b) {
  var n = 0;
  for (var r = 0; r < Board.size; r++) {
    for (var c = 0; c < Board.size; c++) {
      if (b.filledAt(r, c)) continue;
      var free = 0;
      if (r > 0 && !b.filledAt(r - 1, c)) free++;
      if (r < Board.size - 1 && !b.filledAt(r + 1, c)) free++;
      if (c > 0 && !b.filledAt(r, c - 1)) free++;
      if (c < Board.size - 1 && !b.filledAt(r, c + 1)) free++;
      if (free == 0) n++;
    }
  }
  return n;
}

class Result {
  Result(this.score, this.moves, this.comboMoves, this.maxCombo);
  final int score;
  final int moves;
  final int comboMoves;
  final int maxCombo;
}

Result play(int seed, {int windowMoves = 3, int moveMs = 2200}) {
  final s = GameSession.newGame(
    seed: seed,
    clock: _Clock(moveMs).call,
    scorer: ScoreKeeper(comboWindowMoves: windowMoves),
  );
  var comboMoves = 0;
  while (!s.isGameOver) {
    var best = -1e18;
    (int, Cell)? pick;
    for (var slot = 0; slot < s.tray.length; slot++) {
      final p = s.tray[slot];
      if (p == null) continue;
      for (var r = 0; r <= Board.size - p.height; r++) {
        for (var c = 0; c <= Board.size - p.width; c++) {
          final o = Cell(r, c);
          if (!s.canPlace(slot, o)) continue;
          final res = s.board.place(p, o);
          final v = _noHoles(res.board, res.clearedLines, res.board.filledCount);
          if (v > best) {
            best = v;
            pick = (slot, o);
          }
        }
      }
    }
    if (pick == null) {
      var rotated = false;
      for (var slot = 0; slot < s.tray.length && !rotated; slot++) {
        if (s.tray[slot] == null) continue;
        for (var i = 0; i < 3 && s.canRotate(slot); i++) {
          s.rotate(slot);
          if (s.board.hasAnyPlacement(s.tray[slot]!)) {
            rotated = true;
            break;
          }
        }
      }
      if (rotated) continue;
      break;
    }
    final ev = s.place(pick.$1, pick.$2);
    if (ev == null) break;
    if (ev.combo > 1) comboMoves++;
  }
  return Result(s.score, s.placements, comboMoves, s.maxCombo);
}

double mean(List<num> xs) =>
    xs.isEmpty ? 0 : xs.fold<num>(0, (a, b) => a + b) / xs.length;
num pct(List<num> sorted, double p) =>
    sorted.isEmpty ? 0 : sorted[((sorted.length - 1) * p).round()];

void row(String label, List<Result> rs, double baseline) {
  final scores = rs.map((r) => r.score).toList()..sort();
  final m = mean(scores);
  final comboShare = 100 *
      mean(rs.map((r) => r.comboMoves).toList()) /
      max(mean(rs.map((r) => r.moves).toList()), 1);
  print('| $label | ${m.toStringAsFixed(0)} | ${pct(scores, 0.5)} | '
      '${(pct(scores, 0.95) / max(pct(scores, 0.05), 1)).toStringAsFixed(1)}x | '
      '${comboShare.toStringAsFixed(1)}% | '
      '${mean(rs.map((r) => r.maxCombo).toList()).toStringAsFixed(2)} | '
      '${baseline == 0 ? '—' : '${(100 * m / baseline).toStringAsFixed(0)}%'} |');
}

void main(List<String> args) {
  final runs = args.isEmpty ? 1500 : int.parse(args.first);
  print('# Combo-Fenster: Fenstergroesse in Zuegen — $runs Seeds, Heuristik no-holes\n');

  final shipped = [for (var i = 0; i < runs; i++) play(2_000_000 + i)];
  final base = mean(shipped.map((r) => r.score).toList());

  print('| Fenster | Score ø | Median | p95/p05 | Zuege mit Combo | Combo max ø | rel. |');
  print('|---|---|---|---|---|---|---|');
  for (final n in [2, 3, 4, 5, 6]) {
    row(n == 3 ? '$n Zuege (ausgeliefert)' : '$n Zuege', [
      for (var i = 0; i < runs; i++) play(2_000_000 + i, windowMoves: n),
    ], base);
  }

  print('\n### Tempo-Bonus: was schnelles Spielen heute wert ist\n');
  print('Dieselben Seeds, dieselbe Spielweise, nur anderes Tempo.\n');
  print('| Spieltempo | Score ø | rel. zum langsamsten |');
  print('|---|---|---|');
  final byPace = <int, double>{};
  for (final ms in [1000, 1500, 2200, 3000, 4000, 6000]) {
    byPace[ms] = mean([
      for (var i = 0; i < runs; i++)
        play(2_000_000 + i, moveMs: ms).score,
    ]);
  }
  final slowest = byPace[6000]!;
  for (final e in byPace.entries) {
    print('| ${(e.key / 1000).toStringAsFixed(1)} s/Zug | '
        '${e.value.toStringAsFixed(0)} | '
        '${(100 * e.value / slowest).toStringAsFixed(1)}% |');
  }
  print('\nDeckel laut ScoreKeeper.defaultSpeedBonusMax: '
      '${(100 * ScoreKeeper.defaultSpeedBonusMax).toStringAsFixed(0)}%. '
      'Gemessen: ${(100 * (byPace[1000]! / slowest - 1)).toStringAsFixed(1)}%.');
  print('Zum Vergleich vor der Umstellung: +158% (5.354 gegen 2.077).');
}
