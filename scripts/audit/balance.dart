// ignore_for_file: avoid_print, unnecessary_parenthesis, directives_ordering
// Audit-only balance analysis. NOT part of the app.
//
// Run:  dart run scripts/audit/balance.dart [runs]
//
// Answers section D of the playtest audit with numbers:
//   - where runs die (difficulty wall / boredom stretch)
//   - score composition (placement vs clear vs combo vs fever vs all-clear)
//   - combo / fever reachability
//   - dominant strategy: how much does the heuristic choice actually matter?
//   - unfair starts: how often is a run doomed within the first 10 moves
//     even under best-effort play, for the SAME seed
//   - realistic session length
import 'dart:math';

import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/scoring.dart';

/// Seconds a real player takes per placement (used for session-length math).
const double kSecondsPerMove = 2.2;

typedef Heuristic = double Function(Board before, Board after, int lines,
    int placed, int filledAfter);

/// Candidate heuristics a real player might converge on.
final Map<String, Heuristic> heuristics = {
  // "Clear whatever you can, right now."
  'lines-first': (b, a, lines, placed, filled) => lines * 1000.0 - filled,
  // "Keep the board empty."
  'keep-empty': (b, a, lines, placed, filled) => -filled.toDouble(),
  // "Avoid isolated single cells."
  'no-holes': (b, a, lines, placed, filled) =>
      lines * 600.0 - _isolated(a) * 50.0 - filled,
  // "Push everything into a corner."
  'corner-pack': (b, a, lines, placed, filled) =>
      lines * 800.0 - _centreOfMass(a) * 20.0,
  // "Play the biggest piece you can, wherever."
  'greedy-size': (b, a, lines, placed, filled) => placed * 100.0 + lines * 50.0,
};

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

/// Distance of the filled mass from the top-left corner (lower = packed).
double _centreOfMass(Board b) {
  var sum = 0.0;
  var n = 0;
  for (var r = 0; r < Board.size; r++) {
    for (var c = 0; c < Board.size; c++) {
      if (b.filledAt(r, c)) {
        sum += r + c;
        n++;
      }
    }
  }
  return n == 0 ? 0 : sum / n;
}

class Outcome {
  Outcome(this.score, this.moves, this.lines, this.maxCombo, this.comboMoves,
      this.feverBursts, this.allClears, this.placementPoints, this.clearPoints);
  final int score;
  final int moves;
  final int lines;
  final int maxCombo;
  final int comboMoves;
  final int feverBursts;
  final int allClears;
  final int placementPoints;
  final int clearPoints;
}

Outcome play(int seed, Heuristic h, {bool useRotation = true}) {
  final s = GameSession.newGame(seed: seed);
  var placementPoints = 0;
  var clearPoints = 0;
  var comboMoves = 0;
  var feverBursts = 0;
  var allClears = 0;

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
          final v = h(s.board, res.board, res.clearedLines, p.size,
              res.board.filledCount);
          if (v > best) {
            best = v;
            pick = (slot, o);
          }
        }
      }
    }
    if (pick == null) {
      if (useRotation) {
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
      }
      break;
    }
    final piece = s.tray[pick.$1]!;
    final ev = s.place(pick.$1, pick.$2);
    if (ev == null) break;
    placementPoints += piece.size;
    clearPoints += ev.gained - piece.size;
    if (ev.combo > 1) comboMoves++;
    if (ev.feverBurst) feverBursts++;
    if (s.lastWasAllClear) allClears++;
  }
  return Outcome(s.score, s.placements, s.linesCleared, s.maxCombo, comboMoves,
      feverBursts, allClears, placementPoints, clearPoints);
}

double mean(List<num> xs) =>
    xs.isEmpty ? 0 : xs.fold<num>(0, (a, b) => a + b) / xs.length;
double sd(List<num> xs) {
  if (xs.length < 2) return 0;
  final m = mean(xs);
  return sqrt(xs.fold<double>(0, (a, b) => a + (b - m) * (b - m)) /
      (xs.length - 1));
}

num pct(List<num> sorted, double p) =>
    sorted.isEmpty ? 0 : sorted[((sorted.length - 1) * p).round()];

void table(String title, List<String> head, List<List<String>> rows) {
  final w = [
    for (var i = 0; i < head.length; i++)
      [head[i].length, ...rows.map((r) => r[i].length)].reduce(max),
  ];
  String line(List<String> c) {
    final b = StringBuffer('|');
    for (var i = 0; i < c.length; i++) {
      b.write(' ${c[i].padRight(w[i])} |');
    }
    return b.toString();
  }

  print('\n### $title\n');
  print(line(head));
  print('|${w.map((x) => '-' * (x + 2)).join('|')}|');
  for (final r in rows) {
    print(line(r));
  }
}

void main(List<String> args) {
  final runs = args.isEmpty ? 4000 : int.parse(args.first);
  print('# Qubble Balance — $runs Seeds pro Heuristik\n');

  final byH = <String, List<Outcome>>{};
  heuristics.forEach((name, h) {
    byH[name] = [for (var i = 0; i < runs; i++) play(2_000_000 + i, h)];
  });

  table(
    'D.1 Dominante Strategie — was bringt welche Spielweise?',
    ['Heuristik', 'Score ø', 'Score Median', 'Züge ø', 'Linien ø',
      'Combo max ø', 'Fieber/Run', 'AllClear/Run', 'rel. zu bester'],
    () {
      final best = byH.values.map((v) => mean(v.map((o) => o.score).toList()))
          .reduce(max);
      return [
        for (final e in byH.entries)
          () {
            final v = e.value;
            final scores = v.map((o) => o.score).toList()..sort();
            return [
              e.key,
              mean(scores).toStringAsFixed(0),
              pct(scores, 0.5).toString(),
              mean(v.map((o) => o.moves).toList()).toStringAsFixed(1),
              mean(v.map((o) => o.lines).toList()).toStringAsFixed(1),
              mean(v.map((o) => o.maxCombo).toList()).toStringAsFixed(2),
              mean(v.map((o) => o.feverBursts).toList()).toStringAsFixed(2),
              mean(v.map((o) => o.allClears).toList()).toStringAsFixed(3),
              '${(100 * mean(scores) / best).toStringAsFixed(0)}%',
            ];
          }(),
      ];
    }(),
  );

  // --- where do runs die? --------------------------------------------------
  final ref = byH['no-holes']!;
  final buckets = <String, int>{
    '1-10': 0,
    '11-20': 0,
    '21-30': 0,
    '31-40': 0,
    '41-60': 0,
    '61-80': 0,
    '81-120': 0,
    '121+': 0,
  };
  for (final o in ref) {
    final m = o.moves;
    if (m <= 10) {
      buckets['1-10'] = buckets['1-10']! + 1;
    } else if (m <= 20) {
      buckets['11-20'] = buckets['11-20']! + 1;
    } else if (m <= 30) {
      buckets['21-30'] = buckets['21-30']! + 1;
    } else if (m <= 40) {
      buckets['31-40'] = buckets['31-40']! + 1;
    } else if (m <= 60) {
      buckets['41-60'] = buckets['41-60']! + 1;
    } else if (m <= 80) {
      buckets['61-80'] = buckets['61-80']! + 1;
    } else if (m <= 120) {
      buckets['81-120'] = buckets['81-120']! + 1;
    } else {
      buckets['121+'] = buckets['121+']! + 1;
    }
  }
  table(
    'D.2 Wo Runden enden (Heuristik "no-holes", $runs Seeds)',
    ['Züge', 'Anteil', 'Sitzungsdauer @${kSecondsPerMove}s/Zug'],
    [
      for (final e in buckets.entries)
        [
          e.key,
          '${(100 * e.value / ref.length).toStringAsFixed(1)}%',
          '${(int.parse(e.key.split(RegExp(r'[-+]')).first) * kSecondsPerMove).round()}s+',
        ],
    ],
  );

  // --- score composition ---------------------------------------------------
  final pp = mean(ref.map((o) => o.placementPoints).toList());
  final cp = mean(ref.map((o) => o.clearPoints).toList());
  print('\n### D.3 Punkte-Zusammensetzung (no-holes)\n');
  print('- Punkte aus Platzieren (1/Zelle): ${pp.toStringAsFixed(0)} '
      '(${(100 * pp / (pp + cp)).toStringAsFixed(1)}%)');
  print('- Punkte aus Clears/Combo/Fieber:  ${cp.toStringAsFixed(0)} '
      '(${(100 * cp / (pp + cp)).toStringAsFixed(1)}%)');
  print('- Züge mit aktiver Combo (>1): '
      '${(100 * mean(ref.map((o) => o.comboMoves).toList()) / mean(ref.map((o) => o.moves).toList())).toStringAsFixed(1)}% aller Züge');
  print('- Runden ganz ohne Combo: '
      '${(100 * ref.where((o) => o.maxCombo <= 1).length / ref.length).toStringAsFixed(1)}%');
  print('- Runden ganz ohne Fieber-Ausbruch: '
      '${(100 * ref.where((o) => o.feverBursts == 0).length / ref.length).toStringAsFixed(1)}%');
  print('- Runden mit mindestens einem All-Clear: '
      '${(100 * ref.where((o) => o.allClears > 0).length / ref.length).toStringAsFixed(2)}%');

  // --- seed fairness: same seed, best of all heuristics --------------------
  var doomed10 = 0;
  var doomed15 = 0;
  final bestPerSeed = <int>[];
  final worstPerSeed = <int>[];
  for (var i = 0; i < runs; i++) {
    var bestMoves = 0;
    var bestScore = 0;
    var worstScore = 1 << 30;
    for (final h in heuristics.values) {
      final o = play(2_000_000 + i, h);
      bestMoves = max(bestMoves, o.moves);
      bestScore = max(bestScore, o.score);
      worstScore = min(worstScore, o.score);
    }
    if (bestMoves <= 10) doomed10++;
    if (bestMoves <= 15) doomed15++;
    bestPerSeed.add(bestScore);
    worstPerSeed.add(worstScore);
  }
  print('\n### D.4 Fehlstart-Fairness (bester Ausgang über alle 5 Heuristiken)\n');
  print('- Seeds, bei denen KEINE Strategie über 10 Züge kommt: '
      '${(100 * doomed10 / runs).toStringAsFixed(2)}%');
  print('- Seeds, bei denen KEINE Strategie über 15 Züge kommt: '
      '${(100 * doomed15 / runs).toStringAsFixed(2)}%');
  final bp = bestPerSeed.toList()..sort();
  print('- Score-Spanne pro Seed (best/worst Heuristik) im Median: '
      '${(mean(bestPerSeed) / max(mean(worstPerSeed), 1)).toStringAsFixed(1)}x');
  print('- Seed-Streuung bei GLEICHER Spielweise (no-holes): σ/ø = '
      '${(sd(ref.map((o) => o.score).toList()) / max(mean(ref.map((o) => o.score).toList()), 1)).toStringAsFixed(2)}');
  print('- bester Seed vs. schlechtester Seed (no-holes): '
      '${(ref.map((o) => o.score).reduce(max))} vs '
      '${(ref.map((o) => o.score).reduce(min))}');
  print('- p95/p05 Score-Verhältnis (no-holes): '
      '${(pct(ref.map((o) => o.score).toList()..sort(), 0.95) / max(pct(ref.map((o) => o.score).toList()..sort(), 0.05), 1)).toStringAsFixed(1)}x');
  print('- Median-Bestscore über alle Seeds: ${pct(bp, 0.5)}');

  // --- session length ------------------------------------------------------
  final moves = ref.map((o) => o.moves).toList()..sort();
  print('\n### D.5 Sitzungslänge (eine Runde, @${kSecondsPerMove}s/Zug)\n');
  print('- p25: ${(pct(moves, 0.25) * kSecondsPerMove).round()}s  '
      '| Median: ${(pct(moves, 0.5) * kSecondsPerMove).round()}s  '
      '| p75: ${(pct(moves, 0.75) * kSecondsPerMove).round()}s  '
      '| p95: ${(pct(moves, 0.95) * kSecondsPerMove).round()}s');

  // --- scoring constants sanity -------------------------------------------
  print('\n### D.6 Punkte-Kurve (ScoreKeeper-Konstanten)\n');
  final k = ScoreKeeper();
  for (final lines in [1, 2, 3, 4, 5]) {
    final cells = lines * 8 - (lines > 1 ? (lines ~/ 2) : 0);
    final mult = min(lines, k.maxLineMultiplier);
    print('- $lines Linie(n): ~$cells Zellen x ${k.pointsPerClearedCell} x '
        '$mult (Linien-Mult) = ~${cells * k.pointsPerClearedCell * mult} '
        'Punkte bei Combo 1');
  }
  print('- Combo-Multiplikator: 1.0 / 1.5 / 2.0 / 2.5 … (+${k.comboStep} pro Stufe, '
      'ungedeckelt)');
  print('- Fieber: ${k.feverPerLine} pro Linie -> Ausbruch nach '
      '${(1 / k.feverPerLine).ceil()} Linien; Abbau ${k.feverDecayNoClear} pro '
      'clear-losem Zug');
  print('- All-Clear-Bonus: ${k.allClearBonus}');
}
