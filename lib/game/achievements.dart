/// Pure-Dart achievements. No Flutter imports.
///
/// Each achievement unlocks when a single tracked metric reaches its
/// threshold. Evaluation is a pure function of the player's aggregate progress,
/// so it's fully deterministic and unit-testable. Unlock state is persisted
/// separately (see Storage); newly-unlocked achievements are the set-difference
/// between a fresh evaluation and what was already stored.
library;

enum AchievementMetric {
  games,
  highscore,
  totalLines,
  bestCombo,
  level,
  streak,
  puzzlesSolved,
  totalPieces,
}

class Achievement {
  const Achievement({
    required this.id,
    required this.icon,
    required this.metric,
    required this.threshold,
  });

  /// Stable key. Also the lookup key for the localized title/description —
  /// see `achievementTitle`/`achievementDescription` in the UI layer.
  final String id;

  /// Emoji shown in the UI (kept as a string so this stays Flutter-free).
  final String icon;
  final AchievementMetric metric;
  final int threshold;
}

/// A snapshot of the metrics achievements are evaluated against.
class AchievementProgress {
  const AchievementProgress({
    this.games = 0,
    this.highscore = 0,
    this.totalLines = 0,
    this.bestCombo = 0,
    this.level = 1,
    this.streak = 0,
    this.puzzlesSolved = 0,
    this.totalPieces = 0,
  });

  final int games;
  final int highscore;
  final int totalLines;
  final int bestCombo;
  final int level;
  final int streak;
  final int puzzlesSolved;
  final int totalPieces;

  int value(AchievementMetric m) => switch (m) {
        AchievementMetric.games => games,
        AchievementMetric.highscore => highscore,
        AchievementMetric.totalLines => totalLines,
        AchievementMetric.bestCombo => bestCombo,
        AchievementMetric.level => level,
        AchievementMetric.streak => streak,
        AchievementMetric.puzzlesSolved => puzzlesSolved,
        AchievementMetric.totalPieces => totalPieces,
      };
}

class Achievements {
  const Achievements._();

  /// The full catalog, grouped loosely by metric and ascending threshold.
  static const List<Achievement> catalog = [
    // Playing
    Achievement(
        id: 'first_game',
        icon: '🎮',
        metric: AchievementMetric.games,
        threshold: 1),
    Achievement(
        id: 'games_25',
        icon: '🕹️',
        metric: AchievementMetric.games,
        threshold: 25),
    Achievement(
        id: 'games_100',
        icon: '👑',
        metric: AchievementMetric.games,
        threshold: 100),
    // Score
    Achievement(
        id: 'score_1k',
        icon: '🥉',
        metric: AchievementMetric.highscore,
        threshold: 1000),
    Achievement(
        id: 'score_5k',
        icon: '🥈',
        metric: AchievementMetric.highscore,
        threshold: 5000),
    Achievement(
        id: 'score_10k',
        icon: '🥇',
        metric: AchievementMetric.highscore,
        threshold: 10000),
    Achievement(
        id: 'score_25k',
        icon: '🏆',
        metric: AchievementMetric.highscore,
        threshold: 25000),
    // Lines
    Achievement(
        id: 'lines_100',
        icon: '✨',
        metric: AchievementMetric.totalLines,
        threshold: 100),
    Achievement(
        id: 'lines_1000',
        icon: '🧹',
        metric: AchievementMetric.totalLines,
        threshold: 1000),
    // Combo
    Achievement(
        id: 'combo_5',
        icon: '🔥',
        metric: AchievementMetric.bestCombo,
        threshold: 5),
    Achievement(
        id: 'combo_10',
        icon: '💥',
        metric: AchievementMetric.bestCombo,
        threshold: 10),
    // Level
    Achievement(
        id: 'level_10',
        icon: '⭐',
        metric: AchievementMetric.level,
        threshold: 10),
    Achievement(
        id: 'level_20',
        icon: '🌟',
        metric: AchievementMetric.level,
        threshold: 20),
    // Streak
    Achievement(
        id: 'streak_7',
        icon: '📅',
        metric: AchievementMetric.streak,
        threshold: 7),
    Achievement(
        id: 'streak_30',
        icon: '🗓️',
        metric: AchievementMetric.streak,
        threshold: 30),
    // Puzzles
    Achievement(
        id: 'puzzles_10',
        icon: '🧩',
        metric: AchievementMetric.puzzlesSolved,
        threshold: 10),
    // Pieces
    Achievement(
        id: 'pieces_5000',
        icon: '🧱',
        metric: AchievementMetric.totalPieces,
        threshold: 5000),
  ];

  static Achievement byId(String id) =>
      catalog.firstWhere((a) => a.id == id);

  /// Ids currently satisfied by [p].
  static Set<String> unlockedFor(AchievementProgress p) => {
        for (final a in catalog)
          if (p.value(a.metric) >= a.threshold) a.id,
      };

  /// Progress toward [a] in the range 0..1.
  static double fraction(Achievement a, AchievementProgress p) =>
      (p.value(a.metric) / a.threshold).clamp(0.0, 1.0);

  /// Achievements newly satisfied by [p] that aren't in [already].
  static List<Achievement> newlyUnlocked(
    AchievementProgress p,
    Set<String> already,
  ) =>
      [
        for (final a in catalog)
          if (!already.contains(a.id) && p.value(a.metric) >= a.threshold) a,
      ];
}
