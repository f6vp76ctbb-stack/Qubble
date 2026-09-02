// ignore_for_file: avoid_print
// Audit-only. NOT part of the app.
//
// Run:  dart run scripts/audit/leaderboard_metric.dart [players] [runsPerPlayer]
//
// Answers BACKLOG #31 with numbers instead of a preference: does a different
// leaderboard METRIC actually make the ranking reward skill over seed luck?
//
// The existing board ranks max(score) over everything a player ever played.
// Candidates measured here, each over the same simulated player-histories:
//   A  max score            (today)
//   B  max points-per-move
//   C  median score
//   D  median points-per-move
//
// For every candidate two spreads are computed on identical data:
//   luck  = p95/p05 of the metric across players who all play IDENTICALLY
//   skill = metric of the strongest heuristic / metric of the weakest, on the
//           SAME seeds, so the seed cancels out
// The ratio skill:luck is what the leaderboard actually rewards.
import 'dart:math';

import 'balance.dart' show Outcome, heuristics, play, mean, pct;

double _median(List<double> xs) {
  final s = xs.toList()..sort();
  if (s.isEmpty) return 0;
  final mid = s.length ~/ 2;
  return s.length.isOdd ? s[mid] : (s[mid - 1] + s[mid]) / 2;
}

/// The four candidate metrics, each reduced from one player's run history.
final Map<String, double Function(List<Outcome>)> metrics = {
  'A max Score': (runs) =>
      runs.map((o) => o.score.toDouble()).reduce(max),
  'B max Punkte/Zug': (runs) => runs
      .map((o) => o.moves == 0 ? 0.0 : o.score / o.moves)
      .reduce(max),
  'C Median Score': (runs) => _median(
        runs.map((o) => o.score.toDouble()).toList(),
      ),
  'D Median Punkte/Zug': (runs) => _median(
        runs.map((o) => o.moves == 0 ? 0.0 : o.score / o.moves).toList(),
      ),
};

void main(List<String> args) {
  final players = args.isEmpty ? 120 : int.parse(args[0]);
  final perPlayer = args.length < 2 ? 25 : int.parse(args[1]);
  const seedBase = 5_000_000;

  print('# Bestenlisten-Metrik — $players Spieler x $perPlayer Runden '
      'x ${heuristics.length} Spielweisen\n');
  print('Jeder Spieler bekommt einen eigenen, disjunkten Seed-Block. '
      'Gleiche Blöcke für jede Spielweise, damit der Seed sich herauskürzt.\n');

  // history[heuristicName][playerIndex] = that player's runs under that style.
  final history = <String, List<List<Outcome>>>{};
  for (final e in heuristics.entries) {
    history[e.key] = [
      for (var p = 0; p < players; p++)
        [
          for (var i = 0; i < perPlayer; i++)
            play(seedBase + p * perPlayer + i, e.value),
        ],
    ];
  }

  final rows = <List<String>>[];
  for (final m in metrics.entries) {
    // Luck: every player plays the same way, only the seeds differ.
    final same = history['no-holes']!.map(m.value).toList()..sort();
    final p05 = pct(same, 0.05).toDouble();
    final p95 = pct(same, 0.95).toDouble();
    final luck = p05 <= 0 ? double.infinity : p95 / p05;

    // Skill: same seed blocks, strongest vs weakest style, averaged over
    // players so a single lucky block cannot decide it.
    final byStyle = <String, double>{
      for (final e in heuristics.keys)
        e: mean(history[e]!.map(m.value).toList()),
    };
    final strongest = byStyle.values.reduce(max);
    final weakest = byStyle.values.reduce(min);
    final skill = weakest <= 0 ? double.infinity : strongest / weakest;

    rows.add([
      m.key,
      p05.toStringAsFixed(1),
      p95.toStringAsFixed(1),
      '${luck.toStringAsFixed(1)}x',
      '${skill.toStringAsFixed(2)}x',
      '1 : ${(luck / skill).toStringAsFixed(1)}',
    ]);
  }

  const head = [
    'Metrik',
    'p05',
    'p95',
    'Seed-Glück (p95/p05)',
    'Können (best/schlecht.)',
    'Können : Glück',
  ];
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

  print(line(head));
  print('|${w.map((x) => '-' * (x + 2)).join('|')}|');
  for (final r in rows) {
    print(line(r));
  }

  // Consistent single-run basis, so the numbers above can be compared with
  // BALANCE.md D.1/D.4. Those two figures were computed on DIFFERENT bases:
  // the skill span took max/min over five styles PER SEED (an order statistic
  // over five noisy values, so it carries seed noise inside it), while the
  // luck span was one fixed style. Both are computed the same way here.
  final flatSame = <double>[
    for (final runs in history['no-holes']!)
      for (final o in runs) o.score.toDouble(),
  ]..sort();
  final flatByStyle = <String, double>{
    for (final e in heuristics.keys)
      e: mean([
        for (final runs in history[e]!)
          for (final o in runs) o.score.toDouble(),
      ]),
  };
  final singleLuck =
      pct(flatSame, 0.95).toDouble() / max(pct(flatSame, 0.05).toDouble(), 1);
  final singleSkill =
      flatByStyle.values.reduce(max) / flatByStyle.values.reduce(min);
  print('\n### Basis Einzelrunde (zum Abgleich mit BALANCE.md)\n');
  print('- Seed-Glueck p95/p05 ueber alle Einzelrunden (no-holes): '
      '${singleLuck.toStringAsFixed(1)}x');
  print('- Koennen, staerkste gegen schwaechste Spielweise (feste Strategien): '
      '${singleSkill.toStringAsFixed(2)}x');
  print('- Verhaeltnis Koennen : Glueck = '
      '1 : ${(singleLuck / singleSkill).toStringAsFixed(1)}');

  // How much of the ranking is decided by simply playing MORE?
  print('\n### Wirkung der reinen Rundenzahl (gleiche Spielweise, no-holes)\n');
  for (final m in metrics.entries) {
    final few = <double>[];
    final many = <double>[];
    for (var p = 0; p < players; p++) {
      final runs = history['no-holes']![p];
      few.add(m.value(runs.take(5).toList()));
      many.add(m.value(runs));
    }
    final ratio = mean(many) / max(mean(few), 0.0001);
    print('- ${m.key}: $perPlayer Runden gegen 5 Runden = '
        '${ratio.toStringAsFixed(2)}x');
  }
}
