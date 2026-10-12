/// Pure-Dart achievements. No Flutter imports.
///
/// Two layers over the same metrics:
///
/// * [AchievementTracks] — what the player sees and is paid for (owner,
///   12.10.2026): eight categories of five stages each. Every stage below the
///   last pays [kAchievementTierCoins], collected with a tap; the last stage
///   unlocks the category's animated skin, which is shown from the start as
///   the goal.
/// * [Achievements] — the seventeen single milestones that existed before the
///   stages. They pay nothing any more; they remain because the Play Games
///   import (tool/play_games_import.py, its icons and texts) was built on
///   them, and Play Games never takes an unlock back.
///
/// Evaluation is a pure function of the player's aggregate progress, so it's
/// fully deterministic and unit-testable.
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

/// One of the milestones Play Games knows (see the library doc).
class Achievement {
  const Achievement({
    required this.id,
    required this.icon,
    required this.metric,
    required this.threshold,
  });

  /// Stable key. Also the lookup key for the localized title/description —
  /// see `achievementTitle`/`achievementDescription` in the UI layer, which
  /// the Play Games import reads as well.
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

  /// The Play Games milestones, grouped by metric and ascending threshold.
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

// ---------------------------------------------------------------------------
// Stages (owner, 12.10.2026)

/// What every stage below a category's last pays, collected with a tap.
const int kAchievementTierCoins = 100;

/// One achievement category with its five stages.
class AchievementTrack {
  const AchievementTrack({
    required this.id,
    required this.icon,
    required this.metric,
    required this.tiers,
    required this.skinId,
  });

  /// Stable key: storage, the skin's `achievementId`, the localized title.
  final String id;

  /// Emoji shown in the UI.
  final String icon;
  final AchievementMetric metric;

  /// The stage thresholds, ascending.
  final List<int> tiers;

  /// The animated skin the last stage unlocks.
  final String skinId;

  int get stages => tiers.length;

  /// How many stages [value] has reached.
  int reachedBy(int value) => tiers.where((t) => value >= t).length;
}

/// A category that reached a new stage, for the game-over celebration:
/// [stage] stages of [AchievementTrack.stages] reached now.
class ReachedStage {
  const ReachedStage(this.track, this.stage);

  final AchievementTrack track;
  final int stage;
}

/// What one tap on "collect" pays.
class AchievementPayout {
  const AchievementPayout({this.coins = 0, this.skinId});

  final int coins;
  final String? skinId;

  bool get isEmpty => coins == 0 && skinId == null;
}

/// Where the player stands in one category.
class AchievementStatus {
  const AchievementStatus({
    required this.track,
    required this.value,
    required this.claimed,
    this.skinOwned = false,
  });

  final AchievementTrack track;

  /// The metric's current value.
  final int value;

  /// Stages collected so far — always the first ones, in order.
  final int claimed;

  /// Whether the player already owns the category's skin. Players who had it
  /// before the stages existed (the old top milestone) are paid coins for the
  /// last stage instead of a skin they have.
  final bool skinOwned;

  int get reached => track.reachedBy(value);

  /// Stages reached and not yet collected.
  int get claimable => (reached - claimed).clamp(0, track.stages);

  /// Every stage collected.
  bool get complete => claimed >= track.stages;

  /// The stage the bar works toward: the first one not collected.
  int get currentTier => claimed.clamp(0, track.stages - 1);

  int get target => track.tiers[currentTier];

  /// How far toward [target], 0..1; 1 once complete.
  double get fraction =>
      complete ? 1.0 : (value / target).clamp(0.0, 1.0).toDouble();

  /// What stage [tier] pays.
  AchievementPayout rewardFor(int tier) =>
      tier == track.stages - 1 && !skinOwned
      ? AchievementPayout(skinId: track.skinId)
      : const AchievementPayout(coins: kAchievementTierCoins);

  /// What collecting everything reached pays now.
  AchievementPayout get collectable {
    var coins = 0;
    String? skin;
    for (var tier = claimed; tier < claimed + claimable; tier++) {
      final r = rewardFor(tier);
      coins += r.coins;
      skin ??= r.skinId;
    }
    return AchievementPayout(coins: coins, skinId: skin);
  }
}

class AchievementTracks {
  const AchievementTracks._();

  /// Eight categories, five stages each; the last stage is the skin.
  ///
  /// The last thresholds are the old top milestones, except two the owner
  /// found too easy (12.10.2026): the best score went from 25,000 to 100,000
  /// (four of the ten players on the leaderboard that day were past 25,000,
  /// the best at 89,736) and the puzzles from 10 to 100 (the levels never
  /// run out).
  static const List<AchievementTrack> catalog = [
    AchievementTrack(
      id: 'games',
      icon: '👑',
      metric: AchievementMetric.games,
      tiers: [1, 10, 25, 50, 100],
      skinId: 'pulse',
    ),
    AchievementTrack(
      id: 'score',
      icon: '🏆',
      metric: AchievementMetric.highscore,
      tiers: [2500, 10000, 25000, 50000, 100000],
      skinId: 'shimmer',
    ),
    AchievementTrack(
      id: 'lines',
      icon: '🧹',
      metric: AchievementMetric.totalLines,
      tiers: [50, 100, 250, 500, 1000],
      skinId: 'wave',
    ),
    AchievementTrack(
      id: 'combo',
      icon: '💥',
      metric: AchievementMetric.bestCombo,
      tiers: [2, 4, 6, 8, 10],
      skinId: 'ember',
    ),
    AchievementTrack(
      id: 'level',
      icon: '🌟',
      metric: AchievementMetric.level,
      tiers: [4, 8, 12, 16, 20],
      skinId: 'prism',
    ),
    AchievementTrack(
      id: 'streak',
      icon: '🗓️',
      metric: AchievementMetric.streak,
      tiers: [3, 7, 14, 21, 30],
      skinId: 'stardust',
    ),
    AchievementTrack(
      id: 'puzzles',
      icon: '🧩',
      metric: AchievementMetric.puzzlesSolved,
      tiers: [5, 15, 30, 60, 100],
      skinId: 'circuit',
    ),
    AchievementTrack(
      id: 'pieces',
      icon: '🧱',
      metric: AchievementMetric.totalPieces,
      tiers: [250, 500, 1000, 2500, 5000],
      skinId: 'ripple',
    ),
  ];

  static AchievementTrack byId(String id) =>
      catalog.firstWhere((t) => t.id == id);

  static int get totalStages =>
      catalog.fold(0, (sum, t) => sum + t.stages);

  /// The order the screen lists them in (owner, 12.10.2026: "da wo man am
  /// weitesten ist bzw. am kürzesten von der Belohnung entfernt, ganz
  /// oben"): rewards waiting to be collected first, then the categories in
  /// progress, closest to their next stage first, and the finished ones
  /// last. Collecting moves a category out of the top group, down to where
  /// its next stage puts it. Ties keep the catalog order.
  static List<AchievementStatus> sorted(Iterable<AchievementStatus> all) {
    int group(AchievementStatus s) => s.claimable > 0
        ? 0
        : s.complete
        ? 2
        : 1;
    final list = all.toList();
    final order = {for (var i = 0; i < catalog.length; i++) catalog[i].id: i};
    list.sort((a, b) {
      final g = group(a).compareTo(group(b));
      if (g != 0) return g;
      if (group(a) == 1) {
        final f = b.fraction.compareTo(a.fraction);
        if (f != 0) return f;
      }
      return (order[a.track.id] ?? 0).compareTo(order[b.track.id] ?? 0);
    });
    return list;
  }

  /// Tracks whose reached stages rose above [announced] (track id → stages
  /// already shown at a game over), with how many they reach now.
  static Map<AchievementTrack, int> newlyReached(
    AchievementProgress p,
    Map<String, int> announced,
  ) => {
    for (final t in catalog)
      if (t.reachedBy(p.value(t.metric)) > (announced[t.id] ?? 0))
        t: t.reachedBy(p.value(t.metric)),
  };
}
