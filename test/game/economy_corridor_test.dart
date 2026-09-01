// Economy and fairness corridors from MASTERPLAN.md D.4.
//
// These are regression guards, not balance experiments. BALANCE.md measured
// the numbers once; without a test, a generator or scoring change can move
// them silently and nobody notices until players do.
//
// The bot always takes the FIRST legal move it finds. That is deliberately
// the weakest player in the simulation set -- BALANCE.md D.1 puts the spread
// between heuristics at 4,7x -- so every bound here is a floor a real player
// clears comfortably. A regression has to be substantial to trip one, which
// is what keeps these tests from becoming noise.
//
// Measured on the current constants over the 200-seed sample below:
//
//   coins/run     mean 29,4   p10 6    median 24   p90 62
//   placements    mean 23,0   p10 14   median 23   min 8
//   zero-coin runs  3,0 %
//
// Where the live coins come from, measured over the same sample:
//
//   per-line   60,4 %      combo bonus  39,2 %      all-clear  0,4 %
//
// Two things follow. The combo bonus is a third of all live income even for a
// bot that never plays for combos, so CoinRules.perLine is a weaker lever than
// it looks -- cutting it from 3 to 1 leaves the mean at ~18, still inside the
// corridor. And the All Clear bonus is close to decorative: one all clear in
// 200 runs. That is a balance observation, not a defect, and changing it is a
// product decision -- recorded here so it is visible rather than lost.
//
// If a bound is ever violated, adjust the constants (CoinRules, the generator
// weights) and record the change in MASTERPLAN.md A.3/C.1 -- do not relax the
// bound. That is the entire point of pinning it.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/coin_rules.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';

/// Deterministic clock, 2.2 s per move -- the cadence
/// scripts/audit/balance.dart uses, so results stay comparable to BALANCE.md.
/// It matters: the combo window is 10 s, so this lets a streak survive a few
/// consecutive clears and expire across a dry spell, the way real play does.
class _Clock {
  DateTime _t = DateTime.utc(2026, 1, 1);
  DateTime call() {
    _t = _t.add(const Duration(milliseconds: 2200));
    return _t;
  }
}

typedef RunOutcome = ({int coins, int placements});

/// Plays one endless run to game over, taking the first legal move each time.
RunOutcome playRun(int seed) {
  final s = GameSession.newGame(seed: seed, clock: _Clock().call);
  var coins = 0;

  while (!s.isGameOver) {
    var moved = false;
    for (var slot = 0; slot < s.tray.length && !moved; slot++) {
      final piece = s.tray[slot];
      if (piece == null) continue;
      for (var r = 0; r <= Board.size - piece.height && !moved; r++) {
        for (var c = 0; c <= Board.size - piece.width && !moved; c++) {
          if (!s.canPlace(slot, Cell(r, c))) continue;
          final event = s.place(slot, Cell(r, c));
          moved = true;
          if (event == null || s.lastClearedCells.isEmpty) continue;
          // Mirrors the controller: only clearing moves pay out.
          coins += CoinRules.forClear(
            lines: s.lastClearedLineCount,
            combo: event.combo,
            allClear: s.lastWasAllClear,
          );
        }
      }
    }
    if (!moved) break;
  }
  return (coins: coins, placements: s.placements);
}

double _mean(List<int> xs) => xs.fold<int>(0, (a, b) => a + b) / xs.length;

/// Nearest-rank percentile, so the value returned is always a real sample.
int _percentile(List<int> xs, double p) {
  final sorted = [...xs]..sort();
  final rank = (p * sorted.length).ceil().clamp(1, sorted.length);
  return sorted[rank - 1];
}

void main() {
  // D.4.1 asks for >= 50 seeds and D.4.2 for >= 100. 200 costs about a second
  // and makes the percentiles stable enough that a passing run today is not a
  // failing run tomorrow for no reason. Played once, shared by every test.
  const seeds = 200;
  late List<RunOutcome> runs;
  late List<int> coins;
  late List<int> placements;

  setUpAll(() {
    runs = [for (var seed = 1; seed <= seeds; seed++) playRun(seed)];
    coins = [for (final r in runs) r.coins];
    placements = [for (final r in runs) r.placements];
  });

  group('D.4.1 economy corridor', () {
    test('a run pays 15-60 live coins on average', () {
      final average = _mean(coins);
      printOnFailure(
        'coins/run: mean ${average.toStringAsFixed(1)}, '
        'p10 ${_percentile(coins, 0.10)}, '
        'median ${_percentile(coins, 0.50)}, '
        'p90 ${_percentile(coins, 0.90)}',
      );

      // Boosters cost 50-200 (BoosterCosts), so a player should reach one in
      // roughly 2-5 runs: earned, not gifted, and not a grind.
      expect(
        average,
        inInclusiveRange(15, 60),
        reason: 'Outside the D.4.1 corridor. Adjust CoinRules.perLine / '
            'allClearBonus or the booster prices and record it in '
            'MASTERPLAN.md A.3/C.1 -- do not widen this range.',
      );
    });

    test('runs that pay nothing at all stay a small minority', () {
      // Not zero, and deliberately not asserted as zero: this bot clears no
      // line at all in about 3 % of runs, always short ones (8-14 placements).
      // That is a property of placing top-left-first, not something a player
      // who aims for lines runs into -- so the guard is on the size of the
      // tail, not on its existence. It catches an economy that stops paying
      // out, which the mean alone can hide.
      final share = coins.where((c) => c == 0).length / seeds;
      printOnFailure('zero-coin runs: ${(share * 100).toStringAsFixed(1)} %');
      expect(share, lessThan(0.08));
    });
  });

  group('D.4.2 fairness floor', () {
    // Guards the rescue rule and the generator's early-phase weighting. A
    // regression there shows up as runs ending before the player has done
    // anything, which is the worst first impression the game can make.
    test('a run lasts 15 placements on average', () {
      final average = _mean(placements);
      printOnFailure('placements: mean ${average.toStringAsFixed(1)}');
      expect(
        average,
        greaterThanOrEqualTo(15),
        reason: 'The generator got harsher. Check the early-phase weighting '
            'and the rescue rule before touching this bound.',
      );
    });

    test('even the unluckiest tenth of runs reaches 8 placements', () {
      final p10 = _percentile(placements, 0.10);
      printOnFailure('placements: p10 $p10, min ${_percentile(placements, 0)}');
      expect(
        p10,
        greaterThanOrEqualTo(8),
        reason: 'The tail got worse: one run in ten now ends almost '
            'immediately. The mean can hide that, which is why the tail is '
            'pinned separately.',
      );
    });
  });

  group('CoinRules', () {
    test('a plain single-line clear pays per line only', () {
      expect(
        CoinRules.forClear(lines: 1, combo: 1, allClear: false),
        CoinRules.perLine,
      );
    });

    test('a running combo adds its own count on top', () {
      expect(
        CoinRules.forClear(lines: 1, combo: 4, allClear: false),
        CoinRules.perLine + 4,
      );
    });

    test('combo 1 is not a combo and adds nothing', () {
      expect(
        CoinRules.forClear(lines: 2, combo: 1, allClear: false),
        2 * CoinRules.perLine,
      );
    });

    test('an all clear adds its bonus', () {
      expect(
        CoinRules.forClear(lines: 2, combo: 1, allClear: true),
        2 * CoinRules.perLine + CoinRules.allClearBonus,
      );
    });
  });
}
