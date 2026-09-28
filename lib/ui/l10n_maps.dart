/// Maps the stable ids and enums from the pure-Dart game layer to localized
/// text.
///
/// `lib/game/` must stay free of Flutter imports, so it carries ids
/// (`'score_10k'`, `CoachHintType.fever`) rather than sentences. This file is
/// the single place where those ids become words the player reads.
library;

import '../game/achievements.dart';
import '../game/block_skin.dart';
import '../game/coach_hints.dart';
import '../game/leveling.dart';
import '../game/name_filter.dart';
import '../game/quests.dart';
import '../l10n/app_localizations.dart';
import '../monetization/iap.dart';
import '../services/notification_planner.dart';

/// Title of the achievement with [id].
String achievementTitle(L10n l10n, String id) => switch (id) {
  'first_game' => l10n.achievementFirstGameTitle,
  'games_25' => l10n.achievementGames25Title,
  'games_100' => l10n.achievementGames100Title,
  'score_1k' => l10n.achievementScore1kTitle,
  'score_5k' => l10n.achievementScore5kTitle,
  'score_10k' => l10n.achievementScore10kTitle,
  'score_25k' => l10n.achievementScore25kTitle,
  'lines_100' => l10n.achievementLines100Title,
  'lines_1000' => l10n.achievementLines1000Title,
  'combo_5' => l10n.achievementCombo5Title,
  'combo_10' => l10n.achievementCombo10Title,
  'level_10' => l10n.achievementLevel10Title,
  'level_20' => l10n.achievementLevel20Title,
  'streak_7' => l10n.achievementStreak7Title,
  'streak_30' => l10n.achievementStreak30Title,
  'puzzles_10' => l10n.achievementPuzzles10Title,
  'pieces_5000' => l10n.achievementPieces5000Title,
  _ => id,
};

/// What the player has to do to unlock the achievement with [id].
String achievementDescription(L10n l10n, String id) => switch (id) {
  'first_game' => l10n.achievementFirstGameBody,
  'games_25' => l10n.achievementGames25Body,
  'games_100' => l10n.achievementGames100Body,
  'score_1k' => l10n.achievementScore1kBody,
  'score_5k' => l10n.achievementScore5kBody,
  'score_10k' => l10n.achievementScore10kBody,
  'score_25k' => l10n.achievementScore25kBody,
  'lines_100' => l10n.achievementLines100Body,
  'lines_1000' => l10n.achievementLines1000Body,
  'combo_5' => l10n.achievementCombo5Body,
  'combo_10' => l10n.achievementCombo10Body,
  'level_10' => l10n.achievementLevel10Body,
  'level_20' => l10n.achievementLevel20Body,
  'streak_7' => l10n.achievementStreak7Body,
  'streak_30' => l10n.achievementStreak30Body,
  'puzzles_10' => l10n.achievementPuzzles10Body,
  'pieces_5000' => l10n.achievementPieces5000Body,
  _ => '',
};

extension AchievementL10n on Achievement {
  String title(L10n l10n) => achievementTitle(l10n, id);
  String description(L10n l10n) => achievementDescription(l10n, id);
}

/// What [quest] asks for. The target is not in the text for the counted
/// goals — the progress bar shows it ("12 / 25"), which spares every language
/// its plural forms; the best-in-one-round goals name their mark.
String questDescription(L10n l10n, Quest quest) => switch (quest.metric) {
  QuestMetric.rounds => l10n.questRounds,
  QuestMetric.lines => l10n.questLines,
  QuestMetric.pieces => l10n.questPieces,
  QuestMetric.combo => l10n.questCombo(quest.target),
  QuestMetric.score => l10n.questScore(quest.target),
  QuestMetric.dailyChallenge => l10n.questDailyChallenge,
  QuestMetric.puzzles => l10n.questPuzzles,
  QuestMetric.days => l10n.questDays,
  QuestMetric.dailySets => l10n.questDailySets,
};

extension QuestL10n on Quest {
  String description(L10n l10n) => questDescription(l10n, this);
}

/// "Daily" / "Weekly" / "Monthly".
String questPeriodName(L10n l10n, QuestPeriod period) => switch (period) {
  QuestPeriod.daily => l10n.questsDaily,
  QuestPeriod.weekly => l10n.questsWeekly,
  QuestPeriod.monthly => l10n.questsMonthly,
};

/// "All daily quests done!" and its weekly and monthly siblings.
String questSetDoneText(L10n l10n, QuestPeriod period) => switch (period) {
  QuestPeriod.daily => l10n.questsSetDaily,
  QuestPeriod.weekly => l10n.questsSetWeekly,
  QuestPeriod.monthly => l10n.questsSetMonthly,
};

/// The one-time contextual coaching line for [hint].
String coachHintText(L10n l10n, CoachHintType hint) => switch (hint) {
  CoachHintType.combo => l10n.coachHintCombo,
  CoachHintType.fever => l10n.coachHintFever,
  CoachHintType.rotation => l10n.coachHintRotation,
  CoachHintType.booster => l10n.coachHintBooster,
  CoachHintType.strategy => l10n.coachHintStrategy,
};

/// The first-run onboarding hints, in order.
List<String> onboardingHints(L10n l10n) => [
  l10n.onboardingDragPiece,
  l10n.onboardingFillLine,
  l10n.onboardingLinesClear,
];

/// Why a chosen player name was rejected.
String nameProblemText(L10n l10n, NameProblem problem) => switch (problem) {
  NameProblem.tooShort => l10n.nameProblemTooShort(NameFilter.minLength),
  NameProblem.tooLong => l10n.nameProblemTooLong(NameFilter.maxLength),
  NameProblem.invalidCharacters => l10n.nameProblemInvalidCharacters,
  NameProblem.offensive => l10n.nameProblemOffensive,
};

/// Fallback title for a store product, used until the store returns its own
/// localized name (and in the web demo, which has no store at all).
String iapProductTitle(L10n l10n, String productId) => switch (productId) {
  IapProducts.supporter => l10n.iapSupporterPack,
  IapProducts.coinsS => l10n.iapCoinsSmall,
  IapProducts.coinsM => l10n.iapCoinsMedium,
  IapProducts.coinsL => l10n.iapCoinsLarge,
  IapProducts.starter => l10n.iapStarterPack,
  IapProducts.rename => l10n.iapRename,
  IapProducts.neonTheme => l10n.iapNeonTheme,
  IapProducts.diamondsS => l10n.iapDiamondsSmall,
  IapProducts.diamondsM => l10n.iapDiamondsMedium,
  IapProducts.diamondsL => l10n.iapDiamondsLarge,
  _ => productId,
};

/// The localized copy for the scheduled local notifications.
NotificationTexts notificationTexts(L10n l10n) => NotificationTexts(
  dailyReminderTitle: l10n.notificationDailyTitle,
  dailyReminderBody: l10n.notificationDailyBody,
  streakWarningTitle: l10n.notificationStreakTitle,
  streakWarningBody: l10n.notificationStreakBody,
  comebackTitle: l10n.notificationComebackTitle,
  comebackBody: l10n.notificationComebackBody,
);

/// Display name of the theme with catalog [id] (`kThemeCatalog`).
String themeName(L10n l10n, String id) => switch (id) {
  'classic' => l10n.themeClassic,
  'fade' => l10n.themeFade,
  'neon' => l10n.themeNeon,
  'ocean' => l10n.themeOcean,
  'wood' => l10n.themeWood,
  'sunset' => l10n.themeSunset,
  'forest' => l10n.themeForest,
  'candy' => l10n.themeCandy,
  'volcano' => l10n.themeVolcano,
  'glacier' => l10n.themeGlacier,
  'aurora' => l10n.themeAurora,
  _ => id,
};

/// Display name of the block skin with catalog [id] (`kSkinCatalog`).
String skinName(L10n l10n, String id) => switch (id) {
  kDefaultSkinId => l10n.skinClassic,
  'gradient' => l10n.skinGradient,
  'outline' => l10n.skinOutline,
  'glossy' => l10n.skinGlossy,
  'stripe' => l10n.skinStripe,
  'bevel' => l10n.skinBevel,
  'glow' => l10n.skinGlow,
  'crystal' => l10n.skinCrystal,
  'pixel' => l10n.skinPixel,
  'marble' => l10n.skinMarble,
  'jelly' => l10n.skinJelly,
  'pulse' => l10n.skinPulse,
  'shimmer' => l10n.skinShimmer,
  'wave' => l10n.skinWave,
  'ember' => l10n.skinEmber,
  'prism' => l10n.skinPrism,
  'stardust' => l10n.skinStardust,
  'circuit' => l10n.skinCircuit,
  'ripple' => l10n.skinRipple,
  'liquid' => l10n.skinLiquid,
  'fizz' => l10n.skinFizz,
  'plasma' => l10n.skinPlasma,
  _ => id,
};

/// "Ocean theme" / "Gradient skin" for a level-track milestone.
String levelRewardName(L10n l10n, LevelReward reward) => switch (reward.kind) {
  LevelRewardKind.theme => l10n.rewardThemeName(themeName(l10n, reward.id)),
  LevelRewardKind.skin => l10n.rewardSkinName(skinName(l10n, reward.id)),
};
