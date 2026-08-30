import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/piggy_bank.dart';

/// Lines a competent run clears, measured over 60.000 simulated runs
/// (scripts/audit/soak.dart). Used to express the pacing intent below.
const int kLinesPerRun = 15;

void main() {
  test('starts empty at base capacity', () {
    final p = PiggyBank.initial();
    expect(p.coins, 0);
    expect(p.capacity, PiggyBank.baseCapacity);
    expect(p.isEmpty, isTrue);
    expect(p.showHint, isFalse);
  });

  test('addLines banks coinsPerLine for each cleared line', () {
    final p = PiggyBank.initial().addLines(3).addLines(2);
    expect(p.coins, 5 * PiggyBank.coinsPerLine);
  });

  test('addLines ignores a non-positive count', () {
    final p = PiggyBank.initial().addLines(0).addLines(-4);
    expect(p.coins, 0);
  });

  test('fill is capped at capacity', () {
    final p = PiggyBank.initial().addLines(99999);
    expect(p.coins, PiggyBank.baseCapacity);
    expect(p.fillFraction, 1.0);
  });

  test('is full exactly at capacity (free-open condition)', () {
    int linesFor(int coins) => coins ~/ PiggyBank.coinsPerLine;
    final justUnder = PiggyBank.initial()
        .addLines(linesFor(PiggyBank.baseCapacity) - 1);
    expect(justUnder.isFull, isFalse);
    expect(
      PiggyBank.initial().addLines(linesFor(PiggyBank.baseCapacity)).isFull,
      isTrue,
    );
    expect(PiggyBank.initial().addLines(99999).isFull, isTrue);
  });

  test('hint shows only at/above 80% full', () {
    final target = (PiggyBank.baseCapacity * PiggyBank.hintThreshold).ceil();
    final linesForTarget = (target / PiggyBank.coinsPerLine).ceil();
    expect(PiggyBank.initial().addLines(linesForTarget - 1).showHint, isFalse);
    expect(PiggyBank.initial().addLines(linesForTarget).showHint, isTrue);
  });

  test('opening empties the bank and raises capacity by a step', () {
    final filled = PiggyBank.initial().addLines(99999);
    final opened = filled.opened();
    expect(opened.coins, 0);
    expect(opened.capacity, PiggyBank.baseCapacity + PiggyBank.capacityStep);
  });

  test('capacity never exceeds the maximum', () {
    var p = PiggyBank.initial();
    for (var i = 0; i < 20; i++) {
      p = p.opened();
    }
    expect(p.capacity, PiggyBank.maxCapacity);
  });

  group('pacing', () {
    /// Runs needed to reach the nth payout at [kLinesPerRun] lines per run.
    List<int> payoutRuns(int count) {
      var p = PiggyBank.initial();
      final out = <int>[];
      for (var run = 1; run <= 500 && out.length < count; run++) {
        p = p.addLines(kLinesPerRun);
        if (p.isFull) {
          out.add(run);
          p = p.opened();
        }
      }
      return out;
    }

    test('the first payout lands inside a playtest', () {
      // At 1 coin per line into a 500 capacity this took ~33 runs — about 50
      // minutes of play — so testers never saw the piggy bank pay out at all,
      // and its rewarded-video hook was dead content.
      final first = payoutRuns(1).single;
      expect(first, lessThanOrEqualTo(10),
          reason: 'first payout after $first runs is beyond a playtest');
    });

    test('later payouts still stretch out', () {
      // The growing capacity has to keep this from becoming a per-run trickle.
      final runs = payoutRuns(3);
      expect(runs[1] - runs[0], greaterThan(runs[0]));
      expect(runs[2] - runs[1], greaterThan(runs[1] - runs[0]));
    });
  });
}
