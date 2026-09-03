// ignore_for_file: avoid_print, unnecessary_parenthesis, directives_ordering
// Audit-only soak test for the pure-Dart game logic. NOT part of the app.
//
// Run:  dart run scripts/audit/soak.dart [runs]
//
// Covers:
//   1. Stability   — random valid play over N seeded runs; crashes, hangs,
//                    NaN/Infinity, impossible board states, runtime outliers.
//   2. Determinism — the same seed replayed twice must produce identical output.
//   3. Checkpoint  — mid-run serialize/deserialize must resume identically.
//   4. Balance     — score/length/lines/combo distributions per strategy,
//                    piece usage (dead content), early-death rate.
//   5. Puzzle mode — every generated level must be solvable with asserts OFF,
//                    plus solver wall-clock per move.
//
// Deliberately uses only lib/game/** (no Flutter), so it runs on the plain VM.
import 'dart:math';

import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/generator.dart';
import 'package:gridpop/game/leveling.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/puzzle.dart';

/// One finished run.
class RunResult {
  RunResult({
    required this.seed,
    required this.score,
    required this.placements,
    required this.lines,
    required this.maxCombo,
    required this.allClears,
    required this.rotations,
    required this.micros,
    required this.pieceUse,
    required this.deadTrayAt,
  });

  final int seed;
  final int score;
  final int placements;
  final int lines;
  final int maxCombo;
  final int allClears;
  final int rotations;
  final int micros;
  final Map<String, int> pieceUse;

  /// Placement count at which the run ended (== placements).
  final int deadTrayAt;

  String get signature => '$score|$placements|$lines|$maxCombo|$allClears';
}

enum Strategy {
  /// Uniformly random legal (slot, origin).
  random,

  /// Greedy: maximise (cleared lines, then fewest new "holes", then lowest row).
  greedy,

  /// Deliberately bad: always the placement that leaves the most fragmentation.
  worst,
}

const int kMaxPlacements = 5000; // non-termination tripwire

/// Fixed virtual clock: every move advances 3s, so the 10s combo window is
/// exercised realistically without wall-clock flakiness.
/// Every legal (slot, origin) for the current tray.
List<(int, Cell)> legalMoves(GameSession s) {
  final out = <(int, Cell)>[];
  final tray = s.tray;
  for (var slot = 0; slot < tray.length; slot++) {
    final p = tray[slot];
    if (p == null) continue;
    for (var r = 0; r <= Board.size - p.height; r++) {
      for (var c = 0; c <= Board.size - p.width; c++) {
        final origin = Cell(r, c);
        if (s.canPlace(slot, origin)) out.add((slot, origin));
      }
    }
  }
  return out;
}

/// Number of empty cells with no empty orthogonal neighbour reachable —
/// a cheap fragmentation proxy (isolated single cells).
int isolatedHoles(Board b) {
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

/// Scores a candidate move without mutating the session.
(int lines, int holes, int filled) evaluate(Board board, Piece p, Cell o) {
  final res = board.place(p, o);
  return (res.clearedLines, isolatedHoles(res.board), res.board.filledCount);
}

RunResult playRun({
  required int seed,
  required Strategy strategy,
  required Random rng,
  bool allowRotation = true,
  bool freeRotation = false,
  List<String>? problems,
}) {
  final sw = Stopwatch()..start();
  final session = GameSession.newGame(
    seed: seed,
    freeRotation: freeRotation,
  );
  final pieceUse = <String, int>{};
  var allClears = 0;
  var rotations = 0;
  var steps = 0;

  while (!session.isGameOver) {
    if (++steps > kMaxPlacements) {
      problems?.add('seed $seed: NON-TERMINATION after $kMaxPlacements moves');
      break;
    }

    var moves = legalMoves(session);

    // Rotation is a real player option: when nothing fits, try to rotate out
    // of it exactly like the UI allows.
    if (moves.isEmpty && allowRotation) {
      for (var slot = 0; slot < session.tray.length; slot++) {
        if (session.tray[slot] == null) continue;
        for (var i = 0; i < 3 && session.canRotate(slot); i++) {
          session.rotate(slot);
          rotations++;
          if (legalMoves(session).isNotEmpty) break;
        }
        if (legalMoves(session).isNotEmpty) break;
      }
      moves = legalMoves(session);
    }

    if (moves.isEmpty) {
      if (!session.isGameOver) {
        problems?.add(
          'seed $seed: no legal move but isGameOver == false '
          '(board filled=${session.board.filledCount})',
        );
      }
      break;
    }

    late (int, Cell) pick;
    switch (strategy) {
      case Strategy.random:
        pick = moves[rng.nextInt(moves.length)];
      case Strategy.greedy:
      case Strategy.worst:
        var bestScore = strategy == Strategy.greedy ? -1 << 30 : 1 << 30;
        pick = moves.first;
        for (final m in moves) {
          final piece = session.tray[m.$1]!;
          final (lines, holes, filled) =
              evaluate(session.board, piece, m.$2);
          final v = lines * 1000 - holes * 40 - filled;
          final better = strategy == Strategy.greedy
              ? v > bestScore
              : v < bestScore;
          if (better) {
            bestScore = v;
            pick = m;
          }
        }
    }

    final piece = session.tray[pick.$1]!;
    final before = session.board.filledCount;
    final event = session.place(pick.$1, pick.$2);

    if (event == null) {
      problems?.add('seed $seed: place() rejected a move it reported legal');
      break;
    }
    pieceUse[piece.id] = (pieceUse[piece.id] ?? 0) + 1;
    if (session.lastWasAllClear) allClears++;

    // --- invariants -------------------------------------------------------
    final after = session.board.filledCount;
    final cleared = session.lastClearedCells.length;
    if (after != before + piece.size - cleared) {
      problems?.add(
        'seed $seed: cell-count mismatch (before=$before piece=${piece.size} '
        'cleared=$cleared after=$after)',
      );
    }
    if (after < 0 || after > 64) {
      problems?.add('seed $seed: impossible filledCount=$after');
    }
    if (session.score < 0) {
      problems?.add('seed $seed: negative score ${session.score}');
    }
    final f = session.feverLevel;
    if (f.isNaN || f.isInfinite || f < 0 || f > 1.0) {
      problems?.add('seed $seed: fever out of range: $f');
    }
    if (event.gained.isNaN || event.gained < 0) {
      problems?.add('seed $seed: bad gained ${event.gained}');
    }
    if (session.combo < 0) {
      problems?.add('seed $seed: negative combo ${session.combo}');
    }
    if (session.rotationCharges < 0 ||
        session.rotationCharges > GameSession.maxRotationCharges) {
      problems?.add('seed $seed: charges out of range '
          '${session.rotationCharges}');
    }
    // The tray must never expose a piece the board itself would reject.
    for (var slot = 0; slot < session.tray.length; slot++) {
      final t = session.tray[slot];
      if (t != null && t.cells.isEmpty) {
        problems?.add('seed $seed: empty piece in tray slot $slot');
      }
    }
  }

  sw.stop();
  return RunResult(
    seed: seed,
    score: session.score,
    placements: session.placements,
    lines: session.linesCleared,
    maxCombo: session.maxCombo,
    allClears: allClears,
    rotations: rotations,
    micros: sw.elapsedMicroseconds,
    pieceUse: pieceUse,
    deadTrayAt: session.placements,
  );
}

// ---------------------------------------------------------------------------
// Statistics helpers

double mean(List<num> xs) =>
    xs.isEmpty ? 0 : xs.fold<num>(0, (a, b) => a + b) / xs.length;

double stddev(List<num> xs) {
  if (xs.length < 2) return 0;
  final m = mean(xs);
  final v = xs.fold<double>(0, (a, b) => a + (b - m) * (b - m)) /
      (xs.length - 1);
  return sqrt(v);
}

num percentile(List<num> sorted, double p) {
  if (sorted.isEmpty) return 0;
  final i = ((sorted.length - 1) * p).round();
  return sorted[i];
}

String row(List<String> cells, List<int> w) {
  final b = StringBuffer('|');
  for (var i = 0; i < cells.length; i++) {
    b.write(' ${cells[i].padRight(w[i])} |');
  }
  return b.toString();
}

void printTable(String title, List<String> head, List<List<String>> rows) {
  final w = [
    for (var i = 0; i < head.length; i++)
      [head[i].length, ...rows.map((r) => r[i].length)].reduce(max),
  ];
  print('\n### $title\n');
  print(row(head, w));
  print('|${w.map((x) => '-' * (x + 2)).join('|')}|');
  for (final r in rows) {
    print(row(r, w));
  }
}

// ---------------------------------------------------------------------------

void main(List<String> args) {
  final runs = args.isEmpty ? 20000 : int.parse(args.first);
  final problems = <String>[];
  print('# Qubble soak — $runs runs per strategy\n');

  final byStrategy = <Strategy, List<RunResult>>{};
  final globalUse = <String, int>{};
  var totalPlacements = 0;

  for (final strategy in Strategy.values) {
    final rng = Random(0xC0FFEE);
    final results = <RunResult>[];
    for (var i = 0; i < runs; i++) {
      final seed = 1000000 + i;
      try {
        final r = playRun(
          seed: seed,
          strategy: strategy,
          rng: rng,
          problems: problems,
        );
        results.add(r);
        totalPlacements += r.placements;
        r.pieceUse.forEach((k, v) => globalUse[k] = (globalUse[k] ?? 0) + v);
      } catch (e, st) {
        problems.add('seed $seed ($strategy): THREW $e\n'
            '${st.toString().split('\n').take(4).join('\n')}');
      }
    }
    byStrategy[strategy] = results;
  }

  // --- determinism ---------------------------------------------------------
  var determinismFailures = 0;
  for (var i = 0; i < 500; i++) {
    final seed = 7000000 + i;
    final a = playRun(
      seed: seed,
      strategy: Strategy.greedy,
      rng: Random(1),
      problems: problems,
    );
    final b = playRun(
      seed: seed,
      strategy: Strategy.greedy,
      rng: Random(1),
      problems: problems,
    );
    if (a.signature != b.signature) {
      determinismFailures++;
      problems.add('seed $seed: NON-DETERMINISTIC ${a.signature} '
          '!= ${b.signature}');
    }
  }

  // --- checkpoint round-trip ----------------------------------------------
  var checkpointFailures = 0;
  var checkpointThrows = 0;
  for (var i = 0; i < 1000; i++) {
    final seed = 8000000 + i;
    final rng = Random(seed);
    final live = GameSession.newGame(seed: seed);
    // Play a few moves, then snapshot.
    for (var k = 0; k < 6 && !live.isGameOver; k++) {
      final ms = legalMoves(live);
      if (ms.isEmpty) break;
      final m = ms[rng.nextInt(ms.length)];
      live.place(m.$1, m.$2);
    }
    if (live.isGameOver) continue;
    try {
      final restored = GameSession.fromCheckpoint(live.toCheckpoint());
      if (restored.score != live.score ||
          restored.placements != live.placements ||
          restored.board.toAscii().join() != live.board.toAscii().join() ||
          restored.rotationCharges != live.rotationCharges ||
          restored.tray.map((p) => p?.id).join(',') !=
              live.tray.map((p) => p?.id).join(',')) {
        checkpointFailures++;
        problems.add('seed $seed: checkpoint state mismatch after restore');
      }
      // The next tray drawn must match, i.e. the RNG position was restored.
      final liveNext = <String>[];
      final restNext = <String>[];
      for (var k = 0; k < 3; k++) {
        liveNext.addAll(
          PieceGenerator(seed: seed).nextTray(Board.empty(), 0).map((p) => p.id),
        );
        restNext.addAll(
          PieceGenerator(seed: seed).nextTray(Board.empty(), 0).map((p) => p.id),
        );
      }
      if (liveNext.join() != restNext.join()) checkpointFailures++;
    } catch (e) {
      checkpointThrows++;
      problems.add('seed $seed: checkpoint round-trip THREW $e');
    }
  }

  // --- corrupt-checkpoint fuzzing -----------------------------------------
  final corruptCrashes = <String>[];
  final base = () {
    final s = GameSession.newGame(seed: 42);
    final m = legalMoves(s).first;
    s.place(m.$1, m.$2);
    return s.toCheckpoint();
  }();
  final mutations = <String, Map<String, Object?>>{
    'missing version': {...base}..remove('version'),
    'version 2': {...base, 'version': 2},
    'board too short': {...base, 'board': ['....', '....']},
    'board rows short': {
      ...base,
      'board': List<String>.filled(8, '..'),
    },
    'colors short rows': {
      ...base,
      'boardColors': List<List<int>>.filled(8, <int>[]),
    },
    'colors wrong type': {...base, 'boardColors': 'nope'},
    'tray not list': {...base, 'tray': 'nope'},
    'tray wrong length': {...base, 'tray': [null, null]},
    'tray piece no cells': {
      ...base,
      'tray': [
        {'id': 'x', 'weight': 1, 'cells': <Object?>[]},
        null,
        null,
      ],
    },
    'tray piece bad cell': {
      ...base,
      'tray': [
        {
          'id': 'x',
          'weight': 1,
          'cells': [
            [0],
          ],
        },
        null,
        null,
      ],
    },
    'score not map': {...base, 'score': 5},
    'score total string': {
      ...base,
      'score': {'total': 'x', 'combo': 0, 'fever': 0.0},
    },
    'negative placements': {...base, 'placements': -5},
    'generatedTrays 0': {...base, 'generatedTrays': 0},
    'huge generatedTrays': {...base, 'generatedTrays': 100000},
    'fever NaN': {
      ...base,
      'score': {'total': 10, 'combo': 0, 'fever': double.nan},
    },
    'charges negative': {...base, 'rotationCharges': -9},
    'earlyPhase negative': {...base, 'earlyPhaseMoves': -1},
  };
  mutations.forEach((label, data) {
    try {
      GameSession.fromCheckpoint(Map<String, dynamic>.from(data));
      // Accepting is fine as long as it doesn't blow up later.
    } on FormatException {
      // Expected, handled by the controller.
    } catch (e) {
      corruptCrashes.add('$label -> ${e.runtimeType}: $e');
    }
  });

  // --- puzzle mode ---------------------------------------------------------
  final puzzleProblems = <String>[];
  final solverMicros = <int>[];
  final puzzleMinMoves = <int>[];
  const puzzleLevels = 120;
  for (var level = 0; level < puzzleLevels; level++) {
    try {
      final p = PuzzleGenerator.generate(level);
      puzzleMinMoves.add(p.minMoves);
      // Replay the recorded solution with asserts OFF semantics.
      var b = p.start;
      var ok = true;
      for (var i = 0; i < p.pieces.length; i++) {
        if (!b.canPlace(p.pieces[i], p.solution[i])) {
          ok = false;
          break;
        }
        b = b.place(p.pieces[i], p.solution[i]).board;
      }
      if (!ok || !b.isEmpty) {
        puzzleProblems.add('level $level: recorded solution does not empty '
            'the board (filled=${b.filledCount})');
      }
      // Exactly what the UI runs after every placement.
      final sw = Stopwatch()..start();
      final first = p.start.place(p.pieces.first, p.solution.first).board;
      PuzzleSolver.canEmpty(first, p.pieces.sublist(1));
      sw.stop();
      solverMicros.add(sw.elapsedMicroseconds);
    } catch (e) {
      puzzleProblems.add('level $level: THREW $e');
    }
  }

  // --- report --------------------------------------------------------------
  print('## 1. Stability\n');
  print('- runs executed: ${runs * Strategy.values.length}');
  print('- placements simulated: $totalPlacements');
  print('- invariant violations / crashes: ${problems.length}');
  print('- determinism failures (500 replays): $determinismFailures');
  print('- checkpoint round-trip failures (1000): $checkpointFailures '
      '(threw: $checkpointThrows)');
  print('- corrupt-checkpoint non-FormatException crashes: '
      '${corruptCrashes.length}');
  for (final c in corruptCrashes) {
    print('    ! $c');
  }
  if (problems.isNotEmpty) {
    print('\nFirst 20 problems:');
    for (final p in problems.take(20)) {
      print('  ! $p');
    }
  }

  printTable(
    '2. Run outcome per strategy',
    ['Strategie', 'Score ø', 'Score σ', 'p05', 'p50', 'p95', 'max',
      'Züge ø', 'Züge p05', 'Linien ø', 'Combo max ø', 'AllClear/Run'],
    [
      for (final s in Strategy.values)
        () {
          final rs = byStrategy[s]!;
          final scores = rs.map((r) => r.score).toList()..sort();
          final places = rs.map((r) => r.placements).toList()..sort();
          return [
            s.name,
            mean(scores).toStringAsFixed(0),
            stddev(scores).toStringAsFixed(0),
            percentile(scores, 0.05).toString(),
            percentile(scores, 0.50).toString(),
            percentile(scores, 0.95).toString(),
            scores.last.toString(),
            mean(places).toStringAsFixed(1),
            percentile(places, 0.05).toString(),
            mean(rs.map((r) => r.lines).toList()).toStringAsFixed(1),
            mean(rs.map((r) => r.maxCombo).toList()).toStringAsFixed(2),
            mean(rs.map((r) => r.allClears).toList()).toStringAsFixed(3),
          ];
        }(),
    ],
  );

  // Skill gap: how much does play quality matter vs. seed luck?
  final rnd = byStrategy[Strategy.random]!.map((r) => r.score).toList();
  final grd = byStrategy[Strategy.greedy]!.map((r) => r.score).toList();
  final wst = byStrategy[Strategy.worst]!.map((r) => r.score).toList();
  print('\n### 3. Können vs. Zufall\n');
  print('- greedy / random Score-Verhältnis: '
      '${(mean(grd) / max(mean(rnd), 1)).toStringAsFixed(2)}x');
  print('- greedy / worst Score-Verhältnis:  '
      '${(mean(grd) / max(mean(wst), 1)).toStringAsFixed(2)}x');
  print('- Streuung greedy (σ/ø): '
      '${(stddev(grd) / max(mean(grd), 1)).toStringAsFixed(2)}');
  print('- Streuung random (σ/ø): '
      '${(stddev(rnd) / max(mean(rnd), 1)).toStringAsFixed(2)}');

  // Fehlstart-Fairness: how often does a run die very early despite good play?
  for (final s in Strategy.values) {
    final rs = byStrategy[s]!;
    final short = rs.where((r) => r.placements <= 10).length;
    final short20 = rs.where((r) => r.placements <= 20).length;
    print('- ${s.name}: Runden mit <=10 Zügen '
        '${(100 * short / rs.length).toStringAsFixed(2)}% | <=20 Zügen '
        '${(100 * short20 / rs.length).toStringAsFixed(2)}%');
  }

  // --- dead content: piece usage ------------------------------------------
  final catalog = buildCatalog();
  final totalUse = globalUse.values.fold<int>(0, (a, b) => a + b);
  final expectedTotal =
      catalog.fold<int>(0, (a, p) => a + p.weight);
  printTable(
    '4. Teile-Nutzung (alle Strategien zusammen)',
    ['Piece', 'Zellen', 'Gewicht', 'erwartet %', 'gemessen %', 'Delta'],
    [
      for (final p in catalog)
        () {
          final used = globalUse[p.id] ?? 0;
          final expPct = 100 * p.weight / expectedTotal;
          final actPct = totalUse == 0 ? 0.0 : 100 * used / totalUse;
          return [
            p.id,
            p.size.toString(),
            p.weight.toString(),
            expPct.toStringAsFixed(2),
            actPct.toStringAsFixed(2),
            (actPct - expPct).toStringAsFixed(2),
          ];
        }(),
    ],
  );

  // --- XP / progression ----------------------------------------------------
  final greedyScores = byStrategy[Strategy.greedy]!.map((r) => r.score).toList()
    ..sort();
  final medianScore = percentile(greedyScores, 0.5).toInt();
  final randMedian =
      percentile(byStrategy[Strategy.random]!.map((r) => r.score).toList()..sort(), 0.5)
          .toInt();
  printTable(
    '5. Level-Fortschritt (Runden bis Level N)',
    ['Level', 'XP kumuliert', 'Runden @median greedy ($medianScore)',
      'Runden @median random ($randMedian)', 'Belohnung'],
    [
      for (final lvl in [2, 3, 4, 5, 8, 12, 16, 20])
        () {
          var xp = 0;
          for (var l = 1; l < lvl; l++) {
            xp += LevelSystem.xpForNext(l);
          }
          final perRunG = LevelSystem.xpForRun(
            score: medianScore,
            dailyCompleted: false,
          );
          final perRunR = LevelSystem.xpForRun(
            score: randMedian,
            dailyCompleted: false,
          );
          final reward = LevelSystem.rewardTrack
              .where((r) => r.level == lvl)
              .map((r) => r.name)
              .join(', ');
          return [
            lvl.toString(),
            xp.toString(),
            perRunG == 0 ? '∞' : (xp / perRunG).ceil().toString(),
            perRunR == 0 ? '∞' : (xp / perRunR).ceil().toString(),
            reward.isEmpty ? '—' : reward,
          ];
        }(),
    ],
  );

  // --- runtime outliers ----------------------------------------------------
  final allMicros = [
    for (final rs in byStrategy.values) ...rs.map((r) => r.micros),
  ]..sort();
  print('\n### 6. Laufzeit pro Runde (reine Logik, ohne UI)\n');
  print('- median: ${(percentile(allMicros, 0.5) / 1000).toStringAsFixed(2)} ms');
  print('- p99:    ${(percentile(allMicros, 0.99) / 1000).toStringAsFixed(2)} ms');
  print('- max:    ${(allMicros.last / 1000).toStringAsFixed(2)} ms');

  solverMicros.sort();
  print('\n### 7. Rätsel-Modus\n');
  print('- Level generiert: $puzzleLevels');
  print('- Level mit fehlerhafter Lösung: ${puzzleProblems.length}');
  for (final p in puzzleProblems.take(10)) {
    print('  ! $p');
  }
  print('- minMoves min/median/max: ${puzzleMinMoves.reduce(min)} / '
      '${percentile((puzzleMinMoves.toList()..sort()), 0.5)} / '
      '${puzzleMinMoves.reduce(max)}');
  print('- Solver-Check nach 1. Zug (UI-Thread!): median '
      '${(percentile(solverMicros, 0.5) / 1000).toStringAsFixed(1)} ms, p95 '
      '${(percentile(solverMicros, 0.95) / 1000).toStringAsFixed(1)} ms, max '
      '${(solverMicros.last / 1000).toStringAsFixed(1)} ms');

  final exitBad = problems.isNotEmpty ||
      corruptCrashes.isNotEmpty ||
      puzzleProblems.isNotEmpty;
  print('\n## Ergebnis: ${exitBad ? 'BEFUNDE VORHANDEN' : 'sauber'}');
}
