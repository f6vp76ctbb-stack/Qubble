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

  /// Whether [b] is exactly one calendar day after [a] (streak continuation).
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

  static bool isConsecutiveDay(DateTime a, DateTime b) {
    final da = DateTime(a.year, a.month, a.day);
    final db = DateTime(b.year, b.month, b.day);
    return db.difference(da).inDays == 1;
  }
}
