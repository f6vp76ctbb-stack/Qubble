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
    this.coins = 0,
    this.skinId,
  });

  /// Stable key. Also the lookup key for the localized title/description —
  /// see `achievementTitle`/`achievementDescription` in the UI layer.
  final String id;

  /// Emoji shown in the UI (kept as a string so this stays Flutter-free).
  final String icon;
  final AchievementMetric metric;
  final int threshold;

  /// Coins paid once when the achievement unlocks (0 for a skin reward).
  ///
  /// Sized against the rest of the economy: a run earns ~100–200 coins, a
  /// mission 30–130, a gold skin costs 1200–2200. All coin rewards together
  /// come to 1025 — about the cheapest gold skin.
  final int coins;

  /// Block skin unlocked by this achievement, or null. Decided 28.09.2026:
  /// the highest tier of every category unlocks an animated skin, the tiers
  /// below it pay [coins].
  final String? skinId;
}

/// What a set of achievements pays out together.
class AchievementRewards {
  const AchievementRewards({required this.coins, required this.skinIds});

  final int coins;
  final List<String> skinIds;
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
        threshold: 1,
        coins: 50),
    Achievement(
        id: 'games_25',
        icon: '🕹️',
        metric: AchievementMetric.games,
        threshold: 25,
        coins: 150),
    Achievement(
        id: 'games_100',
        icon: '👑',
        metric: AchievementMetric.games,
        threshold: 100,
        skinId: 'pulse'),
    // Score
    Achievement(
        id: 'score_1k',
        icon: '🥉',
        metric: AchievementMetric.highscore,
        threshold: 1000,
        coins: 50),
    Achievement(
        id: 'score_5k',
        icon: '🥈',
        metric: AchievementMetric.highscore,
        threshold: 5000,
        coins: 100),
    Achievement(
        id: 'score_10k',
        icon: '🥇',
        metric: AchievementMetric.highscore,
        threshold: 10000,
        coins: 200),
    Achievement(
        id: 'score_25k',
        icon: '🏆',
        metric: AchievementMetric.highscore,
        threshold: 25000,
        skinId: 'shimmer'),
    // Lines
    Achievement(
        id: 'lines_100',
        icon: '✨',
        metric: AchievementMetric.totalLines,
        threshold: 100,
        coins: 75),
    Achievement(
        id: 'lines_1000',
        icon: '🧹',
        metric: AchievementMetric.totalLines,
        threshold: 1000,
        skinId: 'wave'),
    // Combo
    Achievement(
        id: 'combo_5',
        icon: '🔥',
        metric: AchievementMetric.bestCombo,
        threshold: 5,
        coins: 100),
    Achievement(
        id: 'combo_10',
        icon: '💥',
        metric: AchievementMetric.bestCombo,
        threshold: 10,
        skinId: 'ember'),
    // Level
    Achievement(
        id: 'level_10',
        icon: '⭐',
        metric: AchievementMetric.level,
        threshold: 10,
        coins: 150),
    Achievement(
        id: 'level_20',
        icon: '🌟',
        metric: AchievementMetric.level,
        threshold: 20,
        skinId: 'prism'),
    // Streak
    Achievement(
        id: 'streak_7',
        icon: '📅',
        metric: AchievementMetric.streak,
        threshold: 7,
        coins: 150),
    Achievement(
        id: 'streak_30',
        icon: '🗓️',
        metric: AchievementMetric.streak,
        threshold: 30,
        skinId: 'stardust'),
    // Puzzles
    Achievement(
        id: 'puzzles_10',
        icon: '🧩',
        metric: AchievementMetric.puzzlesSolved,
        threshold: 10,
        skinId: 'circuit'),
    // Pieces
    Achievement(
        id: 'pieces_5000',
        icon: '🧱',
        metric: AchievementMetric.totalPieces,
        threshold: 5000,
        skinId: 'ripple'),
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

  /// Everything [earned] pays out: the coins summed, the skins listed.
  static AchievementRewards rewardsFor(Iterable<Achievement> earned) =>
      AchievementRewards(
        coins: earned.fold(0, (sum, a) => sum + a.coins),
        skinIds: [
          for (final a in earned)
            if (a.skinId != null) a.skinId!,
        ],
      );

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
