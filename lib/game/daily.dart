/// Pure-Dart Daily Challenge seeding for GridPop. No Flutter imports.
///
/// Every calendar day maps to one fixed seed, so all players face the same
/// puzzle. The same seed feeds [PieceGenerator], making the day reproducible.
library;

class DailyChallenge {
  const DailyChallenge._();

  /// A stable seed derived only from the calendar date (time-of-day ignored).
  static int seedForDate(DateTime date) {
    return date.year * 10000 + date.month * 100 + date.day;
  }

  /// The seed for today. Pass [now] in tests for determinism.
  static int seedForToday({DateTime? now}) {
    return seedForDate(now ?? DateTime.now());
  }

  /// Canonical `YYYY-MM-DD` key for persistence (e.g. streak bookkeeping).
  static String dateKey(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  /// Whether today's daily has already been played.
  ///
  /// [lastKey] is the stored key of the last daily played, or null if none.
  static bool playedToday({required String? lastKey, DateTime? now}) {
    if (lastKey == null) return false;
    return lastKey == dateKey(now ?? DateTime.now());
  }

  /// How long until the next daily unlocks, i.e. until local midnight.
  ///
  /// Local, not UTC: the daily rolls over on the player's calendar day, which
  /// is what dateKey uses. Built from the calendar date rather than by adding
  /// 24 hours, so a day that is 23 or 25 hours long because the clocks changed
  /// still ends when the date does.
  static Duration untilNextDaily({DateTime? now}) {
    final n = now ?? DateTime.now();
    final nextMidnight = DateTime(n.year, n.month, n.day + 1);
    final left = nextMidnight.difference(n);
    return left.isNegative ? Duration.zero : left;
  }

  /// Whether [b] is exactly one calendar day after [a] (streak continuation).
  static bool isConsecutiveDay(DateTime a, DateTime b) {
    final da = DateTime(a.year, a.month, a.day);
    final db = DateTime(b.year, b.month, b.day);
    return db.difference(da).inDays == 1;
  }

  /// How many played days are kept. Two months is what the calendar can show
  /// (the current month and the one before it), so anything older is dead
  /// weight in `shared_preferences` and is dropped on write.
  static const int playedHistoryDays = 70;

  /// Adds [key] to [stored] and returns the pruned, sorted history.
  ///
  /// Sorting is lexicographic, which for `YYYY-MM-DD` is chronological. The
  /// cap keeps the NEWEST entries: a player returning after a long gap must
  /// not lose this month's ticks to entries from last spring.
  static List<String> recordPlayed(
    Iterable<String> stored,
    String key, {
    int cap = playedHistoryDays,
  }) {
    final all = <String>{...stored, key}.toList()..sort();
    if (all.length <= cap) return all;
    return all.sublist(all.length - cap);
  }

  /// One month as calendar cells: leading blanks, then the day numbers, padded
  /// with trailing blanks to full weeks.
  ///
  /// [firstWeekday] follows [DateTime]'s convention (1 = Monday .. 7 = Sunday)
  /// and comes from the locale in the UI, because the week does not start on
  /// the same day everywhere. Returned as day numbers rather than [DateTime]s
  /// so the grid carries no timezone of its own.
  static List<int?> monthCells(
    int year,
    int month, {
    int firstWeekday = DateTime.monday,
  }) {
    final first = DateTime(year, month, 1);
    // DateTime(y, m + 1, 0) normalises to the last day of month m.
    final dayCount = DateTime(year, month + 1, 0).day;
    final lead = (first.weekday - firstWeekday) % 7;
    final cells = <int?>[
      for (var i = 0; i < lead; i++) null,
      for (var d = 1; d <= dayCount; d++) d,
    ];
    while (cells.length % 7 != 0) {
      cells.add(null);
    }
    return cells;
  }
}
