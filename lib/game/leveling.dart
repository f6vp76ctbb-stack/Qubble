/// Pure-Dart player XP / level system (MASTERPLAN.md C.3). No Flutter imports.
///
/// Level starts at 1. XP is tracked *within* the current level; reaching the
/// threshold levels up and rolls the remainder over.
library;

class LevelSystem {
  const LevelSystem._();

  static const int baseCost = 100;
  static const int costPerLevel = 50;

  /// XP required to advance from [level] to [level] + 1.
  static int xpForNext(int level) => baseCost + costPerLevel * level;

  /// Coins granted for reaching [level].
  static int levelReward(int level) => 20 + 5 * level;

  /// XP every finished run is worth regardless of score.
  ///
  /// Without this, XP was purely `score / 100`, which punished beginners
  /// twice: they score less AND the reward scales with the score. At a
  /// beginner's ~300 points a run that is 3 XP, so level 2 (150 XP) took
  /// around 50 runs and the home screen's progress bar never visibly moved.
  /// A flat floor per finished run puts level 2 within a first session while
  /// barely changing the pace for strong players, whose score term dominates.
  static const int baseXpPerRun = 12;

  /// XP earned for a finished run.
  static int xpForRun({required int score, required bool dailyCompleted}) {
    final fromScore = score <= 0 ? 0 : score ~/ 100;
    return baseXpPerRun + fromScore + (dailyCompleted ? 50 : 0);
  }

  /// Applies [gainedXp] to a (level, xpIntoLevel) state and returns the new
  /// state plus any level-ups and the cosmetics they unlock.
  static LevelOutcome applyXp({
    required int level,
    required int xpIntoLevel,
    required int gainedXp,
  }) {
    var lvl = level;
    var xp = xpIntoLevel + (gainedXp < 0 ? 0 : gainedXp);
    var coins = 0;
    final gained = <int>[];
    while (xp >= xpForNext(lvl)) {
      xp -= xpForNext(lvl);
      lvl += 1;
      gained.add(lvl);
      coins += levelReward(lvl);
    }
    return LevelOutcome(
      level: lvl,
      xpIntoLevel: xp,
      levelsGained: gained,
      coinsAwarded: coins,
      rewards: rewardsForLevels(gained),
    );
  }

  /// Cosmetic milestones unlocked purely by levelling up (no coins needed).
  /// Ids match [kThemeCatalog] / [kSkinCatalog]. This is the "earn by playing"
  /// track that runs alongside the coin shop.
  static const List<LevelReward> rewardTrack = [
    // The first two milestones sit early on purpose: a player who never
    // unlocks anything concludes there is nothing to unlock. Level 3 is also
    // where rotation stops being free, so landing a reward just before that
    // keeps the first rule change from being the only thing that happens.
    LevelReward(
      level: 2,
      kind: LevelRewardKind.theme,
      id: 'fade',
    ),
    LevelReward(
      level: 4,
      kind: LevelRewardKind.skin,
      id: 'gradient',
    ),
    LevelReward(
      level: 8,
      kind: LevelRewardKind.theme,
      id: 'ocean',
    ),
    LevelReward(
      level: 12,
      kind: LevelRewardKind.skin,
      id: 'glossy',
    ),
    LevelReward(
      level: 16,
      kind: LevelRewardKind.theme,
      id: 'wood',
    ),
    LevelReward(
      level: 20,
      kind: LevelRewardKind.skin,
      id: 'outline',
    ),
    LevelReward(
      level: 24,
      kind: LevelRewardKind.theme,
      id: 'sunset',
    ),
    LevelReward(
      level: 28,
      kind: LevelRewardKind.theme,
      id: 'forest',
    ),
    LevelReward(
      level: 32,
      kind: LevelRewardKind.skin,
      id: 'bevel',
    ),
    LevelReward(
      level: 36,
      kind: LevelRewardKind.skin,
      id: 'glow',
    ),
    LevelReward(
      level: 40,
      kind: LevelRewardKind.skin,
      id: 'stripe',
    ),
  ];

  /// The rewards whose milestone level appears in [levels].
  static List<LevelReward> rewardsForLevels(Iterable<int> levels) {
    final set = levels.toSet();
    return [
      for (final r in rewardTrack)
        if (set.contains(r.level)) r,
    ];
  }

  /// The next upcoming reward strictly above [level], or null past the track.
  static LevelReward? nextReward(int level) {
    for (final r in rewardTrack) {
      if (r.level > level) return r;
    }
    return null;
  }
}

/// What a level-up milestone unlocks.
enum LevelRewardKind { theme, skin }

class LevelReward {
  const LevelReward({
    required this.level,
    required this.kind,
    required this.id,
  });

  final int level;
  final LevelRewardKind kind;

  /// Catalog id of the theme/skin to unlock. The label shown for it is built
  /// in the l10n layer (`levelRewardName` in lib/ui/l10n_maps.dart).
  final String id;
}

class LevelOutcome {
  const LevelOutcome({
    required this.level,
    required this.xpIntoLevel,
    required this.levelsGained,
    required this.coinsAwarded,
    required this.rewards,
  });

  final int level;
  final int xpIntoLevel;
  final List<int> levelsGained;
  final int coinsAwarded;

  /// Cosmetics unlocked by the level-ups in this outcome.
  final List<LevelReward> rewards;

  bool get leveledUp => levelsGained.isNotEmpty;
}
