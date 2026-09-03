// Playing fast should be worth something — that is most of the appeal of the
// genre. What it must not be worth is what it used to be: the old ten-second
// combo clock fed the MULTIPLIER, so a timing edge compounded with run length
// into a factor of 2.6 between 1.5 s and 6 s per move. This bonus is additive,
// applied once per clear, and capped, so the advantage cannot grow with the
// run.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/scoring.dart';

ScoreEvent _clear(ScoreKeeper s, DateTime now) => s.applyPlacement(
  placedCells: 0,
  clearedLines: 1,
  clearedCells: 8,
  isAllClear: false,
  now: now,
);

void main() {
  group('speed bonus', () {
    test('the first placement of a run carries no bonus', () {
      // Nothing to be fast relative to.
      final s = ScoreKeeper(feverPerLine: 0);
      final t = DateTime(2026, 1, 1, 12);
      expect(s.speedBonusAt(t), 0);
      // 8 cells x 10 points, no combo bonus, no speed bonus.
      expect(_clear(s, t).gained, 80);
    });

    test('a fast follow-up pays the full capped bonus and no more', () {
      final s = ScoreKeeper(feverPerLine: 0, comboStep: 0);
      final t = DateTime(2026, 1, 1, 12);
      _clear(s, t);
      final fast = _clear(s, t.add(const Duration(milliseconds: 500)));
      // comboStep 0 isolates the speed bonus from the combo multiplier.
      expect(fast.gained, (80 * (1 + ScoreKeeper.defaultSpeedBonusMax)).round());
    });

    test('being even faster does not pay more than the cap', () {
      final s = ScoreKeeper(feverPerLine: 0, comboStep: 0);
      final t = DateTime(2026, 1, 1, 12);
      _clear(s, t);
      final instant = _clear(s, t.add(const Duration(milliseconds: 1)));
      expect(instant.gained, (80 * (1 + ScoreKeeper.defaultSpeedBonusMax)).round());
    });

    test('past the window there is no bonus at all', () {
      final s = ScoreKeeper(feverPerLine: 0, comboStep: 0);
      final t = DateTime(2026, 1, 1, 12);
      _clear(s, t);
      final slow = _clear(s, t.add(const Duration(seconds: 10)));
      expect(slow.gained, 80);
    });

    test('the bonus fades smoothly rather than dropping off a cliff', () {
      final s = ScoreKeeper(feverPerLine: 0);
      final t = DateTime(2026, 1, 1, 12);
      _clear(s, t);
      final atFull = s.speedBonusAt(t.add(ScoreKeeper.defaultSpeedFullBelow));
      final middle = s.speedBonusAt(t.add(const Duration(milliseconds: 2750)));
      final atZero = s.speedBonusAt(t.add(ScoreKeeper.defaultSpeedZeroAbove));

      expect(atFull, ScoreKeeper.defaultSpeedBonusMax);
      expect(atZero, 0);
      // 2.75 s is the midpoint of the 1.5 s .. 4 s ramp.
      expect(middle, closeTo(ScoreKeeper.defaultSpeedBonusMax / 2, 0.001));
    });

    test('the bonus never touches the combo', () {
      // The separation is the whole design. A slow player keeps the streak;
      // they just earn a little less for each clear in it.
      final s = ScoreKeeper(feverPerLine: 0);
      final t = DateTime(2026, 1, 1, 12);
      _clear(s, t);
      final slow = _clear(s, t.add(const Duration(minutes: 5)));
      expect(slow.combo, 2, reason: 'the streak survives any amount of thinking');
      expect(s.comboMovesLeft, ScoreKeeper.defaultComboWindowMoves);
    });

    test('the advantage cannot grow with run length', () {
      // The failure mode of the old rule: a per-move edge that compounded.
      // Here the ratio between an always-fast and an always-slow run must stay
      // within the cap however many clears are chained.
      for (final clears in [2, 10, 40]) {
        final fastKeeper = ScoreKeeper(feverPerLine: 0);
        final slowKeeper = ScoreKeeper(feverPerLine: 0);
        var fastT = DateTime(2026, 1, 1, 12);
        var slowT = DateTime(2026, 1, 1, 12);
        for (var i = 0; i < clears; i++) {
          _clear(fastKeeper, fastT);
          _clear(slowKeeper, slowT);
          fastT = fastT.add(const Duration(milliseconds: 800));
          slowT = slowT.add(const Duration(seconds: 8));
        }
        final ratio = fastKeeper.total / slowKeeper.total;
        expect(
          ratio,
          lessThanOrEqualTo(1 + ScoreKeeper.defaultSpeedBonusMax + 0.001),
          reason: 'after $clears clears the fast run must stay within the cap',
        );
        expect(ratio, greaterThan(1.0), reason: 'being fast must still pay');
      }
    });

    test('a restored run does not inherit a stale timestamp', () {
      // Resuming hours later must not pay a bonus for the gap, nor punish the
      // first move back. A checkpoint carries no timestamp at all.
      final s = ScoreKeeper(feverPerLine: 0);
      s.restore(const ScoreMemento(500, 2, 0.4, 1));
      expect(s.lastPlacementAt, isNull);
      expect(s.speedBonusAt(DateTime(2026, 1, 1, 12)), 0);
    });
  });
}
