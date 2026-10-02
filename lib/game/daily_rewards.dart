/// Pure-Dart rewards around the Daily Challenge (owner, 29.09.2026): a goal
/// of up to three stars for the day's score, and chests of diamonds at streak
/// milestones. No Flutter imports.
///
/// The Daily used to be a normal round on a fixed board: nothing to aim for
/// but the score, and the streak paid a few coins more each day. The stars
/// give every day a target anyone can read at a glance; the chests make the
/// long streak worth protecting.
library;

/// Stars for the score of the day's counted round.
class DailyGoal {
  const DailyGoal._();

  /// Scores for one, two and three stars. Set against the simulated rounds
  /// in BALANCE.md (median near 3,000): one star is a solid round, three a
  /// very good one.
  static const List<int> starScores = [1500, 3000, 5000];

  /// Extra coins per star, paid with the daily reward (and doubled with it).
  static const int coinsPerStar = 25;

  static int starsFor(int score) => starScores.where((s) => score >= s).length;

  static int coinsFor(int stars) => stars * coinsPerStar;
}

/// Diamonds for reaching a streak milestone.
class StreakChest {
  const StreakChest._();

  /// Streak length → diamonds in the chest.
  static const Map<int, int> milestones = {3: 5, 7: 15, 14: 30, 30: 60};

  /// After the last milestone the chest comes back every this many days.
  static const int repeatEvery = 30;

  /// Diamonds for a streak that has just reached [streak] days, or 0.
  static int diamondsFor(int streak) {
    final fixed = milestones[streak];
    if (fixed != null) return fixed;
    final last = milestones.keys.last;
    if (streak > last && streak % repeatEvery == 0) return milestones[last]!;
    return 0;
  }

  /// The next chest after [streak]: the day it comes on and what it holds.
  static ({int day, int diamonds}) next(int streak) {
    for (final e in milestones.entries) {
      if (e.key > streak) return (day: e.key, diamonds: e.value);
    }
    final day = (streak ~/ repeatEvery + 1) * repeatEvery;
    return (day: day, diamonds: milestones[milestones.keys.last]!);
  }
}
