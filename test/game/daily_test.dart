import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/daily.dart';
import 'package:gridpop/game/generator.dart';

void main() {
  _countdownTests();
  group('seed', () {
    test('is stable for a given date regardless of time of day', () {
      final morning = DateTime(2026, 7, 5, 8, 30);
      final night = DateTime(2026, 7, 5, 23, 59);
      expect(
        DailyChallenge.seedForDate(morning),
        DailyChallenge.seedForDate(night),
      );
    });

    test('differs across days', () {
      expect(
        DailyChallenge.seedForDate(DateTime(2026, 7, 5)),
        isNot(DailyChallenge.seedForDate(DateTime(2026, 7, 6))),
      );
    });

    test('drives a reproducible generator sequence', () {
      final seed = DailyChallenge.seedForDate(DateTime(2026, 7, 5));
      final board = Board.empty();
      final a = PieceGenerator(seed: seed).nextTray(board, 0).map((p) => p.id);
      final b = PieceGenerator(seed: seed).nextTray(board, 0).map((p) => p.id);
      expect(a.toList(), b.toList());
    });
  });

  group('dateKey', () {
    test('zero-pads month and day', () {
      expect(DailyChallenge.dateKey(DateTime(2026, 1, 3)), '2026-01-03');
      expect(DailyChallenge.dateKey(DateTime(2026, 12, 25)), '2026-12-25');
    });
  });

  group('isConsecutiveDay', () {
    test('true for adjacent days', () {
      expect(
        DailyChallenge.isConsecutiveDay(
          DateTime(2026, 7, 5),
          DateTime(2026, 7, 6),
        ),
        isTrue,
      );
    });

    test('true across a month boundary', () {
      expect(
        DailyChallenge.isConsecutiveDay(
          DateTime(2026, 7, 31),
          DateTime(2026, 8, 1),
        ),
        isTrue,
      );
    });

    test('false for the same day or a gap', () {
      expect(
        DailyChallenge.isConsecutiveDay(
          DateTime(2026, 7, 5),
          DateTime(2026, 7, 5),
        ),
        isFalse,
      );
      expect(
        DailyChallenge.isConsecutiveDay(
          DateTime(2026, 7, 5),
          DateTime(2026, 7, 7),
        ),
        isFalse,
      );
    });
  });
}

void _countdownTests() {
  group('playedToday', () {
    test('no daily played yet', () {
      expect(
        DailyChallenge.playedToday(lastKey: null, now: DateTime(2026, 9, 2)),
        isFalse,
      );
    });

    test('played today', () {
      final now = DateTime(2026, 9, 2, 14, 30);
      expect(
        DailyChallenge.playedToday(
          lastKey: DailyChallenge.dateKey(now),
          now: now,
        ),
        isTrue,
      );
    });

    test('yesterday does not count as today', () {
      final now = DateTime(2026, 9, 2, 0, 1);
      expect(
        DailyChallenge.playedToday(
          lastKey: DailyChallenge.dateKey(DateTime(2026, 9, 1)),
          now: now,
        ),
        isFalse,
      );
    });
  });

  group('untilNextDaily', () {
    test('counts down to local midnight', () {
      expect(
        DailyChallenge.untilNextDaily(now: DateTime(2026, 9, 2, 23, 0)),
        const Duration(hours: 1),
      );
      expect(
        DailyChallenge.untilNextDaily(now: DateTime(2026, 9, 2, 0, 0)),
        const Duration(hours: 24),
      );
    });

    test('rolls over a month end', () {
      // DateTime(2026, 9, 31) is 1 October -- the arithmetic has to survive
      // that rather than producing an invalid date.
      expect(
        DailyChallenge.untilNextDaily(now: DateTime(2026, 9, 30, 22, 0)),
        const Duration(hours: 2),
      );
    });

    test('rolls over a year end', () {
      expect(
        DailyChallenge.untilNextDaily(now: DateTime(2026, 12, 31, 23, 30)),
        const Duration(minutes: 30),
      );
    });

    test('never returns a negative duration', () {
      // Defensive: a clock change or a bad now must not render as "-1h".
      expect(
        DailyChallenge.untilNextDaily(now: DateTime(2026, 9, 2, 12)).isNegative,
        isFalse,
      );
    });
  });
}
