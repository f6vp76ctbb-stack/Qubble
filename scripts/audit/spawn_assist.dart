// ignore_for_file: avoid_print
// Audit-only measurement of the generator's opening help (SpawnAssist).
// NOT part of the app.
//
// Run:  dart run scripts/audit/spawn_assist.dart [runs]
//
// Question: how long does a run last, and how many of them end before the
// player has had a game at all — with the classic generator, and with each
// candidate assist? Three players, weakest to strongest:
//
//   first-fit   takes the first legal move it finds (the floor; the economy
//               corridor test uses the same bot)
//   lines-first clears whatever it can, right now (what the tutorial teaches)
//   no-holes    avoids isolated cells (BALANCE.md's "competent player")
//
// Results are recorded in BALANCE.md, Nachtrag 5.
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/coin_rules.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/generator.dart';
import 'package:gridpop/game/piece.dart';

/// Seconds a real player takes per placement (BALANCE.md uses the same).
const double kSecondsPerMove = 2.2;

typedef Heuristic =
    double Function(Board after, int lines, int placed, int filledAfter);

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

final Map<String, Heuristic?> players = {
  'first-fit': null,
  'lines-first': (a, lines, placed, filled) => lines * 1000.0 - filled,
  'no-holes': (a, lines, placed, filled) =>
      lines * 600.0 - _isolated(a) * 50.0 - filled,
};

class Outcome {
  Outcome(this.moves, this.lines, this.score, this.coins, this.multiClears);
  final int moves;
  final int lines;
  final int score;
  final int coins;
  final int multiClears;
}

Outcome play(int seed, Heuristic? h, SpawnAssist assist) {
  final s = GameSession.newGame(seed: seed, assist: assist);
  var coins = 0;
  var multi = 0;
  while (!s.isGameOver) {
    (int, Cell)? pick;
    var best = -1e18;
    for (var slot = 0; slot < s.tray.length; slot++) {
      final p = s.tray[slot];
      if (p == null) continue;
      for (var r = 0; r <= Board.size - p.height; r++) {
        for (var c = 0; c <= Board.size - p.width; c++) {
          final o = Cell(r, c);
          if (!s.canPlace(slot, o)) continue;
          if (h == null) {
            pick ??= (slot, o);
            continue;
          }
          final res = s.board.place(p, o);
          final v = h(
            res.board,
            res.clearedLines,
            p.size,
            res.board.filledCount,
          );
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
    if (s.lastClearedLineCount > 0) {
      coins += CoinRules.forClear(
        lines: s.lastClearedLineCount,
        combo: ev.combo,
        allClear: s.lastWasAllClear,
      );
      if (s.lastClearedLineCount >= 2) multi++;
    }
  }
  return Outcome(s.placements, s.linesCleared, s.score, coins, multi);
}

num pct(List<num> sorted, double p) =>
    sorted.isEmpty ? 0 : sorted[((sorted.length - 1) * p).round()];

double mean(Iterable<num> xs) {
  var sum = 0.0;
  var n = 0;
  for (final x in xs) {
    sum += x;
    n++;
  }
  return n == 0 ? 0 : sum / n;
}

String f(num v, [int digits = 1]) => v.toStringAsFixed(digits);

void main(List<String> args) {
  final runs = args.isEmpty ? 1500 : int.parse(args.first);
  final candidates = <String, SpawnAssist>{
    'classic (none)': SpawnAssist.none,
    'endless 24/48': SpawnAssist.endless,
    'welcome 45/75': SpawnAssist.welcome,
    // Context: what was weighed against them.
    '12/36': const SpawnAssist(fullMoves: 12, fadeMoves: 36),
    '30/60': const SpawnAssist(fullMoves: 30, fadeMoves: 60),
    '60/90': const SpawnAssist(fullMoves: 60, fadeMoves: 90),
    '24/48, clear x3, dead 0.10': const SpawnAssist(
      fullMoves: 24,
      fadeMoves: 48,
      clearBonus: 2,
      deadWeight: 0.1,
    ),
  };
  print('# SpawnAssist — $runs seeds per cell, $kSecondsPerMove s per move\n');
  for (final player in players.entries) {
    print('## ${player.key}\n');
    print(
      '| assist | moves median | p10 | p90 | time median | dead <21 | '
      'dead <31 | lines ø | multi ø | score median | coins ø |',
    );
    print('|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|');
    for (final cand in candidates.entries) {
      final out = [
        for (var i = 0; i < runs; i++)
          play(3_000_000 + i, player.value, cand.value),
      ];
      final moves = out.map<num>((o) => o.moves).toList()..sort();
      final scores = out.map<num>((o) => o.score).toList()..sort();
      final early20 = out.where((o) => o.moves < 21).length / runs * 100;
      final early30 = out.where((o) => o.moves < 31).length / runs * 100;
      final med = pct(moves, 0.5);
      print(
        '| ${cand.key} | $med | ${pct(moves, 0.1)} | ${pct(moves, 0.9)} | '
        '${f(med * kSecondsPerMove, 0)} s | ${f(early20)} % | ${f(early30)} % | '
        '${f(mean(out.map((o) => o.lines)))} | '
        '${f(mean(out.map((o) => o.multiClears)))} | ${pct(scores, 0.5)} | '
        '${f(mean(out.map((o) => o.coins)))} |',
      );
    }
    print('');
  }
}
