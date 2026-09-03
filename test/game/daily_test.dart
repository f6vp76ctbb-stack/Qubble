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
  group('monthCells', () {
    test('lays a month out with leading blanks for the first weekday', () {
      // 1 September 2026 is a Tuesday. A Monday-first week therefore needs one
      // leading blank.
      expect(DateTime(2026, 9, 1).weekday, DateTime.tuesday);
      final cells = DailyChallenge.monthCells(2026, 9);
      expect(cells.first, isNull);
      expect(cells[1], 1);
      expect(cells.where((c) => c != null).length, 30);
      expect(cells.length % 7, 0);
    });

    test('shifts the same month when the week starts on Sunday', () {
      final monday = DailyChallenge.monthCells(2026, 9);
      final sunday = DailyChallenge.monthCells(
        2026,
        9,
        firstWeekday: DateTime.sunday,
      );
      // Tuesday is one day after Monday but two after Sunday.
      expect(monday.indexOf(1), 1);
      expect(sunday.indexOf(1), 2);
    });

    test('handles a leap February and a month starting on the first weekday',
        () {
      expect(
        DailyChallenge.monthCells(2024, 2).where((c) => c != null).length,
        29,
      );
      expect(
        DailyChallenge.monthCells(2026, 2).where((c) => c != null).length,
        28,
      );
      // 1 June 2026 is a Monday: no leading blank in a Monday-first week.
      expect(DateTime(2026, 6, 1).weekday, DateTime.monday);
      expect(DailyChallenge.monthCells(2026, 6).first, 1);
    });

    test('every day of a month appears exactly once', () {
      for (var m = 1; m <= 12; m++) {
        final days = DailyChallenge.monthCells(2026, m).whereType<int>().toList();
        expect(days, List.generate(days.length, (i) => i + 1),
            reason: 'month $m');
      }
    });
  });

  group('recordPlayed', () {
    test('adds a day once and keeps the history sorted', () {
      var history = DailyChallenge.recordPlayed(const [], '2026-09-02');
      history = DailyChallenge.recordPlayed(history, '2026-09-01');
      history = DailyChallenge.recordPlayed(history, '2026-09-02');
      expect(history, ['2026-09-01', '2026-09-02']);
    });

    test('drops the OLDEST entries when the cap is reached', () {
      // The cap must never cost a returning player this month's ticks.
      var history = <String>[];
      for (var d = 1; d <= 5; d++) {
        history = DailyChallenge.recordPlayed(
          history,
          '2026-09-0$d',
          cap: 3,
        );
      }
      expect(history, ['2026-09-03', '2026-09-04', '2026-09-05']);
    });

    test('keeps the newest even when days arrive out of order', () {
      var history = DailyChallenge.recordPlayed(const [], '2026-09-05', cap: 2);
      history = DailyChallenge.recordPlayed(history, '2026-08-01', cap: 2);
      history = DailyChallenge.recordPlayed(history, '2026-09-06', cap: 2);
      expect(history, ['2026-09-05', '2026-09-06']);
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
