/// Maps the stable ids and enums from the pure-Dart game layer to localized
/// text.
///
/// `lib/game/` must stay free of Flutter imports, so it carries ids
/// (`'score_10k'`, `CoachHintType.fever`) rather than sentences. This file is
/// the single place where those ids become words the player reads.
library;

import '../game/achievements.dart';
import '../game/coach_hints.dart';
import '../game/missions.dart';
import '../game/name_filter.dart';
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

/// What the player has to do to complete [mission].
///
/// Built from the metric and the target rather than one string per mission id.
/// The ids are tiered now (MASTERPLAN.md, missions), so a fixed switch would
/// need a new translation for every tier of every metric — and would silently
/// fall through to showing the raw id for any it had not been taught.
String missionDescription(L10n l10n, Mission mission) =>
    switch (mission.metric) {
      MissionMetric.piecesPlaced => l10n.missionPlacePieces(mission.target),
      MissionMetric.linesCleared => l10n.missionClearRows(mission.target),
      MissionMetric.maxComboReached => l10n.missionReachCombo(mission.target),
      MissionMetric.scoreReached => l10n.missionBreakScore(mission.target),
      MissionMetric.gamesPlayed => l10n.missionPlayRuns(mission.target),
    };

extension MissionL10n on Mission {
  String description(L10n l10n) => missionDescription(l10n, this);
}

/// The one-time contextual coaching line for [hint].
String coachHintText(L10n l10n, CoachHintType hint) => switch (hint) {
  CoachHintType.combo => l10n.coachHintCombo,
  CoachHintType.fever => l10n.coachHintFever,
  CoachHintType.rotation => l10n.coachHintRotation,
  CoachHintType.booster => l10n.coachHintBooster,
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
