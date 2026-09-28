import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/quests.dart';

QuestActivity _round({
  int score = 500,
  int lines = 5,
  int pieces = 20,
  int combo = 2,
  bool daily = false,
}) =>
    QuestActivity.round(
      score: score,
      lines: lines,
      pieces: pieces,
      combo: combo,
      dailyChallenge: daily,
    );

/// Everything any daily quest can ask for, in one go.
const _bigRound = QuestActivity(
  rounds: 10,
  lines: 999,
  pieces: 9999,
  combo: 99,
  score: 99999,
  dailyChallenges: 1,
  puzzles: 5,
);

void main() {
  // Monday 28.09.2026, midday.
  final monday = DateTime(2026, 9, 28, 12);

  group('periods', () {
    test('keys: the date, the week\'s Monday, the month', () {
      final sunday = DateTime(2026, 10, 4, 23, 59);
      expect(questPeriodKey(QuestPeriod.daily, monday), '2026-09-28');
      expect(questPeriodKey(QuestPeriod.weekly, monday), '2026-09-28');
      expect(questPeriodKey(QuestPeriod.weekly, sunday), '2026-09-28',
          reason: 'Sunday still belongs to the week that began on Monday');
      expect(questPeriodKey(QuestPeriod.weekly, DateTime(2026, 10, 5)),
          '2026-10-05');
      expect(questPeriodKey(QuestPeriod.monthly, sunday), '2026-10');
    });

    test('countdowns end at midnight, on Monday and on the 1st', () {
      expect(questsResetIn(QuestPeriod.daily, monday),
          const Duration(hours: 12));
      expect(questsResetIn(QuestPeriod.weekly, monday),
          const Duration(days: 6, hours: 12));
      expect(
        questsResetIn(QuestPeriod.weekly, DateTime(2026, 10, 4, 23)),
        const Duration(hours: 1),
      );
      expect(questsResetIn(QuestPeriod.monthly, DateTime(2026, 12, 31, 18)),
          const Duration(hours: 6),
          reason: 'December rolls over into January');
    });
  });

  group('the draw', () {
    test('3 a day, 5 a week, 5 a month, no metric twice', () {
      for (var d = 0; d < 60; d++) {
        final now = DateTime(2026, 9, 1 + d, 9);
        for (final period in QuestPeriod.values) {
          final quests = questsFor(period, now);
          expect(quests, hasLength(kQuestCount[period]), reason: '$period');
          expect(quests.map((q) => q.metric).toSet(), hasLength(quests.length));
          expect(quests.every((q) => q.period == period), isTrue);
        }
      }
    });

    test('the same all day, and different across days', () {
      final morning = questsFor(QuestPeriod.daily, DateTime(2026, 9, 28, 0, 1));
      final night = questsFor(QuestPeriod.daily, DateTime(2026, 9, 28, 23, 59));
      expect(night, morning);
      final sets = {
        for (var d = 0; d < 14; d++)
          questsFor(QuestPeriod.daily, DateTime(2026, 9, 1 + d))
              .map((q) => q.metric.name)
              .join(','),
      };
      expect(sets.length, greaterThan(3), reason: 'the daily set rotates');
    });

    test('weekly and monthly always ask for play on several days', () {
      for (var w = 0; w < 10; w++) {
        final now = DateTime(2026, 9, 28 + 7 * w);
        expect(
          questsFor(QuestPeriod.weekly, now).map((q) => q.metric),
          contains(QuestMetric.days),
        );
        expect(
          questsFor(QuestPeriod.monthly, now).map((q) => q.metric),
          contains(QuestMetric.days),
        );
      }
    });

    test('no quest asks for watching an ad', () {
      // CLAUDE.md: rewarded videos are a voluntary bonus only. A quest that
      // needs one would turn the bonus into a chore.
      for (final pool in kQuestPools.values) {
        for (final q in pool) {
          expect(q.metric.name.toLowerCase(), isNot(contains('ad')));
        }
      }
    });
  });

  group('recording', () {
    test('a round counts towards every period', () {
      final book = QuestBook();
      book.record(_round(lines: 7, pieces: 21), monday);
      for (final period in QuestPeriod.values) {
        final p = book.progressAt(period, monday);
        expect(p.valueOf(QuestMetric.rounds), 1);
        expect(p.valueOf(QuestMetric.lines), 7);
        expect(p.valueOf(QuestMetric.pieces), 21);
        expect(p.valueOf(QuestMetric.days), 1);
      }
    });

    test('sums add up, bests keep the best, a day counts once', () {
      final book = QuestBook();
      book.record(_round(lines: 4, score: 1800, combo: 5), monday);
      book.record(_round(lines: 6, score: 900, combo: 3), monday);
      final p = book.progressAt(QuestPeriod.weekly, monday);
      expect(p.valueOf(QuestMetric.lines), 10);
      expect(p.valueOf(QuestMetric.score), 1800);
      expect(p.valueOf(QuestMetric.combo), 5);
      expect(p.valueOf(QuestMetric.days), 1);

      book.record(_round(), monday.add(const Duration(days: 1)));
      expect(
        book
            .progressAt(QuestPeriod.weekly, monday.add(const Duration(days: 1)))
            .valueOf(QuestMetric.days),
        2,
      );
    });

    test('a finished quest pays its coins once', () {
      final book = QuestBook();
      final first = book.record(_bigRound, monday);
      final daily = questsFor(QuestPeriod.daily, monday);
      for (final q in daily) {
        expect(first.completed, contains(q));
      }
      final again = book.record(_bigRound, monday);
      expect(again.completed.where((q) => q.period == QuestPeriod.daily),
          isEmpty);
    });

    test('all daily quests: 5 diamonds, once, and a daily set for the week '
        'and the month', () {
      final book = QuestBook();
      final outcome = book.record(_bigRound, monday);
      expect(outcome.setsCompleted, contains(QuestPeriod.daily));
      expect(outcome.diamonds, kQuestBonusDiamonds[QuestPeriod.daily]);
      expect(book.setDone(QuestPeriod.daily, monday), isTrue);
      expect(
        book.progressAt(QuestPeriod.weekly, monday)
            .valueOf(QuestMetric.dailySets),
        1,
      );
      expect(
        book.progressAt(QuestPeriod.monthly, monday)
            .valueOf(QuestMetric.dailySets),
        1,
      );

      final again = book.record(_bigRound, monday);
      expect(again.diamonds, 0);
      expect(
        book.progressAt(QuestPeriod.weekly, monday)
            .valueOf(QuestMetric.dailySets),
        1,
        reason: 'one daily set per day',
      );
    });

    test('coins add up to the quests completed', () {
      final outcome = QuestBook().record(_bigRound, monday);
      expect(
        outcome.coins,
        outcome.completed.fold<int>(0, (sum, q) => sum + q.coins),
      );
    });

    test('a new day starts the daily quests over; the week keeps going', () {
      final book = QuestBook();
      book.record(_round(lines: 10), monday);
      final tuesday = monday.add(const Duration(days: 1));
      expect(
        book.progressAt(QuestPeriod.daily, tuesday)
            .valueOf(QuestMetric.lines),
        0,
      );
      expect(
        book.progressAt(QuestPeriod.weekly, tuesday)
            .valueOf(QuestMetric.lines),
        10,
      );
      final nextMonday = monday.add(const Duration(days: 7));
      expect(
        book.progressAt(QuestPeriod.weekly, nextMonday)
            .valueOf(QuestMetric.lines),
        0,
      );
    });

    test('a whole week of full days finishes the weekly set', () {
      final book = QuestBook();
      var diamonds = 0;
      for (var d = 0; d < 7; d++) {
        final day = monday.add(Duration(days: d));
        for (var i = 0; i < 3; i++) {
          diamonds += book.record(_bigRound, day).diamonds;
          diamonds += book.record(const QuestActivity.puzzle(), day).diamonds;
        }
      }
      expect(book.setDone(QuestPeriod.weekly, monday), isTrue);
      expect(
        diamonds,
        greaterThanOrEqualTo(7 * kQuestBonusDiamonds[QuestPeriod.daily]! +
            kQuestBonusDiamonds[QuestPeriod.weekly]!),
      );
    });

    test('puzzles count as play on that day', () {
      final book = QuestBook();
      book.record(const QuestActivity.puzzle(), monday);
      final p = book.progressAt(QuestPeriod.weekly, monday);
      expect(p.valueOf(QuestMetric.puzzles), 1);
      expect(p.valueOf(QuestMetric.days), 1);
      expect(p.valueOf(QuestMetric.rounds), 0);
    });
  });

  group('storage', () {
    test('round-trips through JSON', () {
      final book = QuestBook();
      book.record(_bigRound, monday);
      final restored = QuestBook({
        for (final e in book.state.entries)
          e.key: QuestProgress.fromJson(e.value.toJson()),
      });
      for (final period in QuestPeriod.values) {
        final a = book.progressAt(period, monday);
        final b = restored.progressAt(period, monday);
        expect(b.key, a.key);
        expect(b.values, a.values);
        expect(b.paid, a.paid);
        expect(b.bonusPaid, a.bonusPaid);
        expect(b.lastDay, a.lastDay);
      }
      expect(restored.record(_bigRound, monday).diamonds, 0,
          reason: 'what was paid stays paid after a restart');
    });

    test('malformed data reads as a fresh start', () {
      for (final raw in [null, 7, 'x', <String, Object?>{'values': 'no'}]) {
        final p = QuestProgress.fromJson(raw);
        expect(p.values, isEmpty);
        expect(p.paid, isEmpty);
        expect(QuestBook({QuestPeriod.daily: p})
            .progressAt(QuestPeriod.daily, monday)
            .key, '2026-09-28');
      }
    });
  });
}
