import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/scoring.dart';

void main() {
  group('placement points', () {
    test('placing without a clear scores one point per cell', () {
      final s = ScoreKeeper();
      final e = s.applyPlacement(
        placedCells: 4,
        clearedLines: 0,
        clearedCells: 0,
        isAllClear: false,
      );
      expect(e.gained, 4);
      expect(e.total, 4);
      expect(e.combo, 0);
    });
  });

  group('clear points', () {
    test('single line: 10 per cleared cell x1 x combo1', () {
      final s = ScoreKeeper();
      final e = s.applyPlacement(
        placedCells: 1,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      // placement 1 + clear 8*10*1*1.0 = 81
      expect(e.gained, 81);
      expect(e.combo, 1);
    });

    test('double line applies x2 line multiplier', () {
      final s = ScoreKeeper();
      final e = s.applyPlacement(
        placedCells: 2,
        clearedLines: 2,
        clearedCells: 15,
        isAllClear: false,
      );
      // placement 2 + clear 15*10*2*1.0 = 302
      expect(e.gained, 302);
    });

    test('line multiplier is capped at max', () {
      final s = ScoreKeeper(feverPerLine: 0); // isolate from fever burst
      final e = s.applyPlacement(
        placedCells: 0,
        clearedLines: 6,
        clearedCells: 10,
        isAllClear: false,
      );
      // capped at x4: 10*10*4*1.0 = 400
      expect(e.gained, 400);
    });
  });

  group('combo', () {
    test('consecutive clears raise the combo multiplier', () {
      final s = ScoreKeeper(feverPerLine: 0);
      s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      final e2 = s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      expect(e2.combo, 2);
      // combo2 multiplier 1.5: 8*10*1*1.5 = 120
      expect(e2.gained, 120);
    });

    test('a combo survives filler moves inside the window', () {
      final s = ScoreKeeper(feverPerLine: 0);
      s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      expect(s.comboMovesLeft, ScoreKeeper.defaultComboWindowMoves);

      for (var i = 1; i <= ScoreKeeper.defaultComboWindowMoves; i++) {
        final held = s.applyPlacement(
          placedCells: 3,
          clearedLines: 0,
          clearedCells: 0,
          isAllClear: false,
        );
        expect(held.combo, 1, reason: 'still alive after $i filler moves');
        expect(s.comboMovesLeft, ScoreKeeper.defaultComboWindowMoves - i);
      }

      final chained = s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      expect(chained.combo, 2);
      expect(s.comboMovesLeft, ScoreKeeper.defaultComboWindowMoves);
    });

    test('the combo expires one move past the window', () {
      final s = ScoreKeeper(feverPerLine: 0);
      s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );

      ScoreEvent? last;
      for (var i = 0; i <= ScoreKeeper.defaultComboWindowMoves; i++) {
        last = s.applyPlacement(
          placedCells: 3,
          clearedLines: 0,
          clearedCells: 0,
          isAllClear: false,
        );
      }
      expect(last!.combo, 0);
      expect(s.comboMovesLeft, isNull);
    });

    test('a clear past the window restarts the streak at 1', () {
      final s = ScoreKeeper(feverPerLine: 0);
      s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      for (var i = 0; i <= ScoreKeeper.defaultComboWindowMoves; i++) {
        s.applyPlacement(
          placedCells: 3,
          clearedLines: 0,
          clearedCells: 0,
          isAllClear: false,
        );
      }
      final late = s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      expect(late.combo, 1);
      // Base points, no combo bonus: 8*10 = 80.
      expect(late.gained, 80);
    });

    test('nothing about the combo depends on wall-clock time', () {
      // The point of the whole change: two players on the same seed making the
      // same moves get the same score, however long they took to think.
      // Measured across 1.500 seeds the clock was worth a factor of 2,6
      // (scripts/audit/combo_window.dart) — this is the unit-level guard that
      // no timing input can creep back in.
      final s = ScoreKeeper(feverPerLine: 0);
      var total = 0;
      for (var i = 0; i < 6; i++) {
        total = s.applyPlacement(
          placedCells: 0,
          clearedLines: 1,
          clearedCells: 8,
          isAllClear: false,
        ).total;
      }
      expect(s.combo, 6);
      expect(total, greaterThan(0));
      // applyPlacement takes no clock at all, so there is nothing to vary.
      expect(s.comboMovesLeft, ScoreKeeper.defaultComboWindowMoves);
    });
  });

  group('fever', () {
    test('meter fills with cleared lines', () {
      final s = ScoreKeeper();
      final e = s.applyPlacement(
        placedCells: 0,
        clearedLines: 2,
        clearedCells: 15,
        isAllClear: false,
      );
      expect(e.feverLevel, closeTo(0.4, 1e-9));
      expect(e.feverBurst, isFalse);
    });

    test('full meter triggers a burst that doubles clear points and resets', () {
      final s = ScoreKeeper();
      // Fill meter to 0.8 first (4 lines across two moves would burst; use one
      // move of 4 lines = 0.8, then a 1-line move to reach 1.0).
      s.applyPlacement(
        placedCells: 0,
        clearedLines: 4,
        clearedCells: 10,
        isAllClear: false,
      ); // fever 0.8
      final burst = s.applyPlacement(
        placedCells: 0,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: false,
      );
      expect(burst.feverBurst, isTrue);
      expect(burst.feverLevel, 0.0); // reset after burst
      // combo is now 2 (both moves cleared). clear = 8*10*1*1.5 = 120, doubled.
      expect(burst.gained, 240);
    });

    test('meter decays on a move without a clear', () {
      final s = ScoreKeeper();
      s.applyPlacement(
        placedCells: 0,
        clearedLines: 2,
        clearedCells: 15,
        isAllClear: false,
      ); // fever 0.4
      final e = s.applyPlacement(
        placedCells: 1,
        clearedLines: 0,
        clearedCells: 0,
        isAllClear: false,
      );
      final k = ScoreKeeper();
      expect(e.feverLevel, closeTo(0.4 - k.feverDecayNoClear, 1e-9));
    });
  });

  group('all clear', () {
    test('adds the all-clear bonus on top', () {
      final s = ScoreKeeper(feverPerLine: 0);
      final e = s.applyPlacement(
        placedCells: 1,
        clearedLines: 1,
        clearedCells: 8,
        isAllClear: true,
      );
      // placement + cleared cells at x1, plus the flat bonus.
      final k = ScoreKeeper();
      expect(e.gained, 1 + 8 * k.pointsPerClearedCell + k.allClearBonus);
    });
  });


  group('combo cap', () {
    /// Clears one line, [times] moves in a row. Consecutive clears always
    /// chain: the window only counts the non-clearing moves between them.
    ScoreEvent runCombo(ScoreKeeper s, int times) {
      late ScoreEvent e;
      for (var i = 0; i < times; i++) {
        e = s.applyPlacement(
          placedCells: 0,
          clearedLines: 1,
          clearedCells: 8,
          isAllClear: false,
        );
      }
      return e;
    }

    test('the multiplier stops climbing at the cap', () {
      final k = ScoreKeeper(feverPerLine: 0);
      final atCap = ((k.maxComboMultiplier - 1) / k.comboStep).round() + 1;

      final justBelow = ScoreKeeper(feverPerLine: 0);
      final a = runCombo(justBelow, atCap);
      final b = runCombo(ScoreKeeper(feverPerLine: 0), atCap + 6);

      expect(b.combo, greaterThan(a.combo),
          reason: 'the streak itself keeps counting');
      expect(b.gained, a.gained,
          reason: 'but the multiplier it pays out at does not');
    });

    test('a long streak is not worth an unbounded multiple of a short one',
        () {
      final short = runCombo(ScoreKeeper(feverPerLine: 0), 1);
      final long = runCombo(ScoreKeeper(feverPerLine: 0), 30);
      final k = ScoreKeeper();
      expect(long.gained / short.gained,
          lessThanOrEqualTo(k.maxComboMultiplier + 0.01));
    });

    test('the cap does not touch the early combo steps', () {
      final k = ScoreKeeper(feverPerLine: 0);
      final one = runCombo(ScoreKeeper(feverPerLine: 0), 1);
      final two = runCombo(ScoreKeeper(feverPerLine: 0), 2);
      expect(two.gained / one.gained, closeTo(1 + k.comboStep, 0.01));
    });
  });

  test('reset clears total, combo and fever', () {
    final s = ScoreKeeper();
    s.applyPlacement(
      placedCells: 4,
      clearedLines: 1,
      clearedCells: 8,
      isAllClear: false,
    );
    s.reset();
    expect(s.total, 0);
    expect(s.combo, 0);
    expect(s.feverLevel, 0.0);
  });
}
