// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class L10nKn extends L10n {
  L10nKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'ಆಡಿ';

  @override
  String get commonLater => 'ನಂತರ';

  @override
  String get commonNotNow => 'ಈಗ ಬೇಡ';

  @override
  String get commonCancel => 'ರದ್ದುಮಾಡಿ';

  @override
  String get commonBuy => 'ಖರೀದಿಸಿ';

  @override
  String get commonSave => 'ಉಳಿಸಿ';

  @override
  String get commonCollect => 'ಪಡೆಯಿರಿ';

  @override
  String get nameNewName => 'ಹೊಸ ಹೆಸರು';

  @override
  String get nameFieldLabel => 'ಹೆಸರು';

  @override
  String get piggyFullTitle => 'ಹುಂಡಿ ತುಂಬಿದೆ!';

  @override
  String get piggyKeepSaving => 'ಉಳಿತಾಯ ಮುಂದುವರಿಸಿ';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity ಸಂಗ್ರಹವಾಗಿದೆ.';
  }

  @override
  String get homeContinueRun => 'ಮುಂದುವರಿಸಿ';

  @override
  String get homeVideo => 'ವೀಡಿಯೊ';

  @override
  String get commonGotIt => 'ಸರಿ';

  @override
  String get commonHome => 'ಮುಖಪುಟ';

  @override
  String get commonScore => 'ಸ್ಕೋರ್';

  @override
  String get commonBest => 'ಅತ್ಯುತ್ತಮ';

  @override
  String commonLevelShort(int level) {
    return 'ಹಂತ $level';
  }

  @override
  String get homeNewRun => 'ಹೊಸ ಆಟ ಆರಂಭಿಸಿ';

  @override
  String get homeBackToExit => 'ನಿರ್ಗಮಿಸಲು ಮತ್ತೆ ಹಿಂದಕ್ಕೆ ಒತ್ತಿ';

  @override
  String get homeEnableLeaderboard => 'ಲೀಡರ್‌ಬೋರ್ಡ್‌ಗೆ ಸೇರಿ';

  @override
  String get homeBestScore => 'ಅತ್ಯುತ್ತಮ ಸ್ಕೋರ್';

  @override
  String get homeDailyChallenge => 'ದೈನಂದಿನ ಸವಾಲು';

  @override
  String get homeDailyOpenToday => 'ಇಂದು ತೆರೆದಿದೆ';

  @override
  String homeDailyNextIn(String time) {
    return 'ಮುಂದಿನ ಸವಾಲು: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak ದಿನಗಳ ಸರಣಿ',
      one: '$streak ದಿನದ ಸರಣಿ',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'ಲೀಡರ್‌ಬೋರ್ಡ್';

  @override
  String get homePuzzleMode => 'ಪಜಲ್ ಮೋಡ್';

  @override
  String get homeHowToPlay => 'Qubble ಆಡುವುದು ಹೇಗೆ';

  @override
  String get homeWeekendBonus => 'ವಾರಾಂತ್ಯ: ದುಪ್ಪಟ್ಟು ನಾಣ್ಯಗಳು!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'ಹಂತ $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'ಹೆಸರು ಬದಲಿಸಿ';

  @override
  String get nameChangeExplainer =>
      'ನಿಮ್ಮ ಹೆಸರೇ ಲೀಡರ್‌ಬೋರ್ಡ್‌ನಲ್ಲಿ ನಿಮ್ಮ ಗುರುತು, ಆದ್ದರಿಂದ ಅದು ಸ್ಥಿರವಾಗಿರುತ್ತದೆ. ಒಮ್ಮೆ ಹೆಸರು ಬದಲಿಸುವ ಸೌಲಭ್ಯವನ್ನು ಖರೀದಿಸಬಹುದು.';

  @override
  String get nameChangeAfterPurchase =>
      'ಖರೀದಿಯ ನಂತರ, ಬದಲಿಸಲು ನಿಮ್ಮ ಹೆಸರನ್ನು ಮತ್ತೆ ಟ್ಯಾಪ್ ಮಾಡಿ.';

  @override
  String get nameJoinedLeaderboard => 'ಈಗ ನೀವು ಲೀಡರ್‌ಬೋರ್ಡ್‌ನಲ್ಲಿದ್ದೀರಿ.';

  @override
  String nameProblemTooShort(int min) {
    return 'ಕನಿಷ್ಠ ಅಕ್ಷರಗಳು: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'ಗರಿಷ್ಠ ಅಕ್ಷರಗಳು: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'ಲ್ಯಾಟಿನ್ ಅಕ್ಷರಗಳು (ಉದಾ. A–Z, é), ಅಂಕೆಗಳು, ಸ್ಪೇಸ್, _ ಮತ್ತು - ಮಾತ್ರ.';

  @override
  String get nameProblemOffensive => 'ದಯವಿಟ್ಟು ಬೇರೆ ಹೆಸರು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get piggyTitle => 'ಹುಂಡಿ';

  @override
  String get piggyFillingHint =>
      'ನೀವು ಸಾಲುಗಳನ್ನು ತೆರವುಗೊಳಿಸಿದಂತೆ ನಿಮ್ಮ ಹುಂಡಿ ತುಂಬುತ್ತದೆ.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins ನಾಣ್ಯಗಳನ್ನು ಉಚಿತವಾಗಿ ಪಡೆಯಿರಿ.',
      one: '$coins ನಾಣ್ಯವನ್ನು ಉಚಿತವಾಗಿ ಪಡೆಯಿರಿ.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'ತುಂಬಿದ ನಂತರ ಉಚಿತವಾಗಿ ಖಾಲಿ ಮಾಡಬಹುದು — ಅಥವಾ ಬೋನಸ್ ವೀಡಿಯೊದಿಂದ ಮೊದಲೇ ತೆರೆಯಬಹುದು.';

  @override
  String get piggyOpenNow => 'ಈಗ ತೆರೆಯಿರಿ';

  @override
  String get gameNewPiecesVideo => 'ಹೊಸ ತುಂಡುಗಳು (ವೀಡಿಯೊ)';

  @override
  String get gameTapBoardCell => 'ಬೋರ್ಡ್‌ನಲ್ಲಿ ಒಂದು ಚೌಕವನ್ನು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get gameDailyChallengeLabel => 'ದೈನಂದಿನ ಸವಾಲು';

  @override
  String get gameOver => 'ಆಟ ಮುಗಿಯಿತು';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'ಬಾಂಬ್‌ಗೆ ಬೇಕಾದ ಹೆಚ್ಚುವರಿ ನಾಣ್ಯಗಳು: $missing.';
  }

  @override
  String get gameBombNotHere => 'ಬಾಂಬ್ ಈಗ ಇಲ್ಲಿ ಕೆಲಸ ಮಾಡುವುದಿಲ್ಲ.';

  @override
  String gameNeedsCoins(String missing) {
    return 'ಇದಕ್ಕೆ ಬೇಕಾದ ಹೆಚ್ಚುವರಿ ನಾಣ್ಯಗಳು: $missing.';
  }

  @override
  String get gameNotRightNow => 'ಈಗ ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String get gameRunSaved => 'ಆಟ ಉಳಿಸಲಾಗಿದೆ — ಮೆನುವಿನಲ್ಲಿ \"ಮುಂದುವರಿಸಿ\".';

  @override
  String get gameOverNoFit =>
      'ನಿಮ್ಮ ಯಾವ ತುಂಡೂ ಇನ್ನು ಬೋರ್ಡ್‌ನಲ್ಲಿ ಹೊಂದುವುದಿಲ್ಲ.';

  @override
  String get gameOverNoFitNoRotations =>
      'ಯಾವ ತುಂಡೂ ಹೊಂದುವುದಿಲ್ಲ — ತಿರುಗಿಸುವ ಅವಕಾಶಗಳೂ ಮುಗಿದಿವೆ.';

  @override
  String get gameStarterOfferUnavailable => 'ಈಗ ಲಭ್ಯವಿಲ್ಲ';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — ಪಡೆಯಿರಿ';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'ಕಾಂಬೊ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'ಸಾಧನೆ: $title';
  }

  @override
  String get gameBestSubmitted => 'ಹೊಸ ಅತ್ಯುತ್ತಮ — ಕಳುಹಿಸಲಾಗಿದೆ';

  @override
  String get gameReviveFor => 'ಆಟ ಮುಂದುವರಿಸಿ · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'ಅನ್‌ಲಾಕ್ ಆಗಿದೆ: $name';
  }

  @override
  String get gameStarterOfferTitle => 'ಸ್ಟಾರ್ಟರ್ ಪ್ಯಾಕ್';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score ಅಂಕಗಳು',
      one: '$score ಅಂಕ',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'ಹೊಸ ದಾಖಲೆ!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak ದಿನಗಳ ಸರಣಿ',
      one: '$streak ದಿನದ ಸರಣಿ',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'ನಾಣ್ಯಗಳನ್ನು ದುಪ್ಪಟ್ಟು ಮಾಡಿ';

  @override
  String get gameDoubleDaily => 'ದೈನಂದಿನ ಬಹುಮಾನ ದುಪ್ಪಟ್ಟು ಮಾಡಿ';

  @override
  String get gamePlayAgain => 'ಮತ್ತೆ ಆಡಿ';

  @override
  String gameLevelReached(int level) {
    return 'ಹಂತ $level ತಲುಪಿದಿರಿ!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count ಹಂತಗಳು — ಹಂತ $level!',
      one: '+$count ಹಂತ — ಹಂತ $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 ನಾಣ್ಯಗಳು + ಮರ ಥೀಮ್';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'ಕೇವಲ $hours ಗಂಟೆಗಳು ಬಾಕಿ — ಒಮ್ಮೆ ಮಾತ್ರ!',
      one: 'ಕೇವಲ $hours ಗಂಟೆ ಬಾಕಿ — ಒಮ್ಮೆ ಮಾತ್ರ!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'ಹಿಂದಕ್ಕೆ';

  @override
  String get boosterSwap => 'ಬದಲಿಸಿ';

  @override
  String get boosterBomb => 'ಬಾಂಬ್';

  @override
  String get boosterNoRotationsLeft =>
      'ತಿರುಗಿಸುವ ಅವಕಾಶ ಉಳಿದಿಲ್ಲ — ಮತ್ತೆ ಪಡೆಯಲು ಸಾಲುಗಳನ್ನು ತೆರವುಗೊಳಿಸಿ!';

  @override
  String get onboardingDragPiece => 'ಒಂದು ಬ್ಲಾಕ್ ಅನ್ನು ಗ್ರಿಡ್‌ಗೆ ಎಳೆಯಿರಿ';

  @override
  String get onboardingFillLine => 'ಪೂರ್ಣ ಸಾಲು ಅಥವಾ ಕಾಲಮ್ ತುಂಬಿಸಿ';

  @override
  String get onboardingLinesClear => 'ತುಂಬಿದ ಸಾಲುಗಳು ಮಾಯವಾಗುತ್ತವೆ — ಅಂಕಗಳು!';

  @override
  String get coachHintCombo =>
      'ಕಾಂಬೊ! ಉಳಿಸಿಕೊಳ್ಳಲು 3 ನಡೆಗಳಲ್ಲಿ ಮತ್ತೆ ತೆರವುಗೊಳಿಸಿ';

  @override
  String get coachHintFever => 'ಫೀವರ್! ಹೊಳೆಯುವವರೆಗೆ ದುಪ್ಪಟ್ಟು ಅಂಕಗಳು';

  @override
  String get coachHintRotation =>
      'ತಿರುಗಿಸಲು ಒಂದು ಚಾರ್ಜ್ ಬೇಕು — ತೆರವುಗೊಳಿಸಿದರೆ ಅದು ತುಂಬುತ್ತದೆ';

  @override
  String get coachHintBooster => 'ಸಲಹೆ: ಕೆಳಗೆ ಬೂಸ್ಟರ್‌ಗಳನ್ನು ಬಳಸಬಹುದು';

  @override
  String get coachHintStrategy =>
      'ಸಲಹೆ: ಎಲ್ಲ ಸಾಲುಗಳನ್ನು ಒಮ್ಮೆಲೇ ಬೇಡ — ದೊಡ್ಡ ತುಂಡುಗಳಿಗೆ ಜಾಗ ಬಿಡಿ';

  @override
  String get dailyStreakLabel => 'ಸರಣಿ';

  @override
  String get dailyBestLabel => 'ದೈನಂದಿನ ಅತ್ಯುತ್ತಮ';

  @override
  String dailyHistoryNote(int days) {
    return 'ಕೊನೆಯ $days ದಿನಗಳನ್ನು ಉಳಿಸಲಾಗುತ್ತದೆ.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'ದಿನ $day: ಆಡಲಾಗಿದೆ';
  }

  @override
  String dailyDayMissed(int day) {
    return 'ದಿನ $day: ಆಡಿಲ್ಲ';
  }

  @override
  String get homeDailyCalendar => 'ಕ್ಯಾಲೆಂಡರ್';

  @override
  String get dailyShareButton => 'ಫಲಿತಾಂಶ ಹಂಚಿಕೊಳ್ಳಿ';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · ದೈನಂದಿನ ಸವಾಲು $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'ಅಂಕಗಳು: $score · ಅತ್ಯುತ್ತಮ ಕಾಂಬೊ x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'ಆಡಿ: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'ಕಾಂಬೊ: ಇನ್ನೂ $moves ನಡೆಗಳು',
      one: 'ಕಾಂಬೊ: ಇನ್ನೂ $moves ನಡೆ',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'ಫಲಿತಾಂಶ ಕ್ಲಿಪ್‌ಬೋರ್ಡ್‌ಗೆ ನಕಲಾಗಿದೆ';

  @override
  String get adNotAvailable =>
      'ಈಗ ಯಾವುದೇ ವೀಡಿಯೊ ಇಲ್ಲ — ಸ್ವಲ್ಪ ಸಮಯದ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get howToPlaySpeedTitle => 'ವೇಗದ ಬೋನಸ್';

  @override
  String get howToPlaySpeedBody =>
      'ವೇಗವಾಗಿ ಇಡುವುದರಿಂದ ಪ್ರತಿ ತೆರವಿಗೆ 30 % ವರೆಗೆ ಸೇರುತ್ತದೆ. ಬೋನಸ್ 1.5 ರಿಂದ 4 ಸೆಕೆಂಡುಗಳ ನಡುವೆ ಕಡಿಮೆಯಾಗುತ್ತದೆ ಮತ್ತು ಅದಕ್ಕೆ ಮಿತಿ ಇದೆ; ಆದ್ದರಿಂದ ವೇಗ ಫಲ ನೀಡುತ್ತದೆ ಆದರೆ ಆಟವನ್ನು ನಿರ್ಧರಿಸುವುದಿಲ್ಲ — ಎಚ್ಚರಿಕೆಯಿಂದ ನಿಧಾನವಾಗಿ ಆಡಿದ ಆಟ ಆತುರದ ವೇಗದ ಆಟವನ್ನು ಇನ್ನೂ ಸೋಲಿಸಬಹುದು.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'ವೇಗದ ಬೋನಸ್ $percent ಶೇಕಡಾ';
  }

  @override
  String get iapDiamondsSmall => '100 ವಜ್ರಗಳು';

  @override
  String get iapDiamondsMedium => '350 ವಜ್ರಗಳು';

  @override
  String get iapDiamondsLarge => '1,000 ವಜ್ರಗಳು';

  @override
  String get howToPlayTitle => 'Qubble ಆಡುವುದು ಹೇಗೆ';

  @override
  String get howToPlayIntroHeadline =>
      'ಆರಂಭಿಸುವುದು ಸುಲಭ.\nಮುಂದಾಲೋಚನೆಗೆ ಬಹುಮಾನ.';

  @override
  String get howToPlayIntroBody =>
      'ಬೋರ್ಡ್ ಖಾಲಿಯಾಗಿರಿಸಿ ಮತ್ತು ನಿಮ್ಮ ದಾಖಲೆ ಮುರಿಯಿರಿ.';

  @override
  String get howToPlayIntroSemantics =>
      'ಆಟದ ಗುರಿ. ಬೋರ್ಡ್ ಖಾಲಿಯಾಗಿರಿಸಿ ಮತ್ತು ನಿಮ್ಮ ದಾಖಲೆ ಮುರಿಯಿರಿ.';

  @override
  String get howToPlayDragTitle => 'ಎಳೆದು ಇಡಿ';

  @override
  String get howToPlayDragBody =>
      'ಮೂರು ತುಂಡುಗಳಲ್ಲಿ ಒಂದನ್ನು ಖಾಲಿ ಚೌಕಗಳಿಗೆ ಎಳೆಯಿರಿ. ಮೂರನ್ನೂ ಬಳಸಿದ ನಂತರ, ಸ್ವಯಂಚಾಲಿತವಾಗಿ ಮೂರು ಹೊಸವು ಬರುತ್ತವೆ.';

  @override
  String get howToPlayClearTitle => 'ಸಾಲುಗಳನ್ನು ತೆರವುಗೊಳಿಸಿ';

  @override
  String get howToPlayClearBody =>
      'ಪೂರ್ಣ ಸಾಲು ಅಥವಾ ಕಾಲಮ್ ತುಂಬಿಸಿ. ತುಂಬಿದ ಸಾಲುಗಳು ಮಾಯವಾಗಿ ಮುಂದಿನ ನಡೆಗೆ ಜಾಗ ಮಾಡುತ್ತವೆ.';

  @override
  String get howToPlayComboTitle => 'ಕಾಂಬೊಗಳನ್ನು ಜೋಡಿಸಿ';

  @override
  String get howToPlayComboBody =>
      'ಮೂರು ನಡೆಗಳೊಳಗೆ ಮತ್ತೊಂದು ಸಾಲನ್ನು ತೆರವುಗೊಳಿಸಿ. ಪ್ರತಿ ಹೆಚ್ಚುವರಿ ಕಾಂಬೊ ನಿಮ್ಮ ಅಂಕ ಗುಣಕವನ್ನು ಹೆಚ್ಚಿಸುತ್ತದೆ. ಕಾಂಬೊ ಸೆಕೆಂಡುಗಳನ್ನಲ್ಲ, ನಡೆಗಳನ್ನು ಎಣಿಸುತ್ತದೆ; ಆದ್ದರಿಂದ ನೀವು ಯೋಚಿಸುವಾಗ ಅದು ಮುಗಿಯುವುದಿಲ್ಲ.';

  @override
  String get howToPlayFeverTitle => 'ಫೀವರ್ ಹೊತ್ತಿಸಿ';

  @override
  String get howToPlayFeverBody =>
      'ತೆರವುಗಳು ಫೀವರ್ ಮೀಟರ್ ತುಂಬಿಸುತ್ತವೆ. ಅದು ತುಂಬಿದಾಗ, ಮುಂದಿನ ಸ್ಫೋಟ ದುಪ್ಪಟ್ಟು ಎಣಿಕೆಯಾಗುತ್ತದೆ — ದೊಡ್ಡ ತೆರವುಗಳನ್ನು ಮೊದಲೇ ಯೋಜಿಸಿ.';

  @override
  String get howToPlayBoosterTitle => 'ಬೂಸ್ಟರ್‌ಗಳನ್ನು ಜಾಣತನದಿಂದ ಬಳಸಿ';

  @override
  String get howToPlayBoosterBody =>
      'ಬೂಸ್ಟರ್‌ಗಳು ಕಠಿಣ ಆಟಗಳನ್ನು ಉಳಿಸುತ್ತವೆ. ಕೆಳಗಿನ ತುಂಡನ್ನು ಟ್ಯಾಪ್ ಮಾಡಿ ಅದನ್ನು ತಿರುಗಿಸಲೂಬಹುದು.';

  @override
  String get howToPlayDailyTitle => 'ದೈನಂದಿನ ಸವಾಲು ಮತ್ತು ಸರಣಿ';

  @override
  String get howToPlayDailyBody =>
      'ದೈನಂದಿನ ಸವಾಲಿನಲ್ಲಿ ಎಲ್ಲರಿಗೂ ಒಂದೇ ತುಂಡುಗಳು. ನಿಮ್ಮ ಸರಣಿ ಮತ್ತು ಬೋನಸ್ ಬೆಳೆಸಲು ಪ್ರತಿದಿನ ಆಡಿ.';

  @override
  String get howToPlayPiggyTitle => 'ಹುಂಡಿ ತುಂಬಿಸಿ';

  @override
  String get howToPlayPiggyBody =>
      'ತೆರವುಗೊಂಡ ಪ್ರತಿ ಸಾಲು ನಿಮ್ಮ ಹುಂಡಿಯನ್ನು ತುಂಬಿಸುತ್ತದೆ. ಅದು ತುಂಬಿದಾಗ, ನಾಣ್ಯಗಳನ್ನು ಉಚಿತವಾಗಿ ಪಡೆಯಬಹುದು.';

  @override
  String get leaderboardTitle => 'ಲೀಡರ್‌ಬೋರ್ಡ್';

  @override
  String get leaderboardUnreachable =>
      'ಲೀಡರ್‌ಬೋರ್ಡ್ ಲಭ್ಯವಿಲ್ಲ.\nಇಂಟರ್ನೆಟ್ ಸಂಪರ್ಕದೊಂದಿಗೆ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get leaderboardEmpty => 'ಇನ್ನೂ ಯಾವುದೇ ನಮೂದುಗಳಿಲ್ಲ.\nಮೊದಲಿಗರಾಗಿ!';

  @override
  String leaderboardSubmitting(int score) {
    return 'ನಿಮ್ಮ ಅತ್ಯುತ್ತಮ ಸ್ಕೋರ್ ($score) ಕಳುಹಿಸಲಾಗುತ್ತಿದೆ …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'ನಿಮ್ಮ ಅತ್ಯುತ್ತಮ ಸ್ಕೋರ್ ಸ್ವಯಂಚಾಲಿತವಾಗಿ ಕಳುಹಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get puzzleModeTitle => 'ಪಜಲ್ ಮೋಡ್';

  @override
  String puzzleLevelTitle(int level) {
    return 'ಪಜಲ್ $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'ನಡೆಗಳು: $moves   •   ಗುರಿ: 3 ನಕ್ಷತ್ರಗಳಿಗೆ $target';
  }

  @override
  String get puzzleSolved => 'ಪರಿಹಾರವಾಯಿತು!';

  @override
  String get puzzleLeaveTitle => 'ಪಜಲ್‌ನಿಂದ ಹೊರಹೋಗಬೇಕೇ?';

  @override
  String get puzzleLeaveBody => 'ಈ ಪಜಲ್‌ನಲ್ಲಿನ ನಿಮ್ಮ ಪ್ರಗತಿ ಕಳೆದುಹೋಗುತ್ತದೆ.';

  @override
  String get puzzleKeepPlaying => 'ಆಟ ಮುಂದುವರಿಸಿ';

  @override
  String get puzzleLeave => 'ಹೊರಹೋಗಿ';

  @override
  String get puzzleStuckTitle => 'ಸಿಕ್ಕಿಹಾಕಿಕೊಂಡಿರಿ';

  @override
  String get puzzleRestart => 'ಮತ್ತೆ ಆರಂಭಿಸಿ';

  @override
  String get commonActive => 'ಸಕ್ರಿಯ';

  @override
  String get commonRestore => 'ಮರುಸ್ಥಾಪಿಸಿ';

  @override
  String get skinsExchangeGold => 'ಚಿನ್ನ ಬದಲಿಸಿ';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'ತುಂಡನ್ನು ತಿರುಗಿಸಿ';

  @override
  String get puzzleNextLevel => 'ಮುಂದಿನ ಹಂತ';

  @override
  String get puzzleBackToOverview => 'ಪಟ್ಟಿಗೆ ಹಿಂತಿರುಗಿ';

  @override
  String get puzzleUnsolvable =>
      'ಇಲ್ಲಿಂದ ಬೋರ್ಡ್ ಅನ್ನು ಇನ್ನು ಖಾಲಿ ಮಾಡಲಾಗುವುದಿಲ್ಲ.';

  @override
  String get puzzleExtraMoveVideo => 'ಹೆಚ್ಚುವರಿ ನಡೆ (ವೀಡಿಯೊ)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'ಪರಿಹರಿಸಿದವು: $solved';
  }

  @override
  String get settingsTitle => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get storageFailureTitle =>
      'Qubble ನಿಮ್ಮ ಉಳಿಸಿದ ಆಟವನ್ನು ಲೋಡ್ ಮಾಡಲು ಸಾಧ್ಯವಾಗುತ್ತಿಲ್ಲ';

  @override
  String get storageFailureBody =>
      'ದಯವಿಟ್ಟು ಆ್ಯಪ್ ಅನ್ನು ಮರುಪ್ರಾರಂಭಿಸಿ. ದೋಷ ಮುಂದುವರಿದರೆ, ಮರುಸ್ಥಾಪನೆ ಮಾತ್ರ ಸಹಾಯ ಮಾಡುತ್ತದೆ. ಸೆಟ್ಟಿಂಗ್‌ಗಳು › ಪ್ರತಿಕ್ರಿಯೆ ಮೂಲಕ ಇದನ್ನು ವರದಿ ಮಾಡಬಹುದು.';

  @override
  String get iapUnavailable => 'ಈ ಆಫರ್ ಈಗ ಲಭ್ಯವಿಲ್ಲ.';

  @override
  String get iapFailed => 'ಖರೀದಿ ಪೂರ್ಣಗೊಂಡಿಲ್ಲ. ಯಾವುದೇ ಶುಲ್ಕ ವಿಧಿಸಲಾಗಿಲ್ಲ.';

  @override
  String get settingsResetProgress => 'ಪ್ರಗತಿ ಮರುಹೊಂದಿಸಿ';

  @override
  String get settingsResetProgressSubtitle =>
      'ಸ್ಕೋರ್, ನಾಣ್ಯಗಳು, ಹಂತ ಮತ್ತು ಪ್ರಗತಿ ಆರಂಭಕ್ಕೆ ಮರಳುತ್ತವೆ. ಖರೀದಿಗಳು, ಹೆಸರು ಮತ್ತು ಅಲಂಕಾರಗಳು ಉಳಿಯುತ್ತವೆ.';

  @override
  String get settingsResetConfirmTitle => 'ಪ್ರಗತಿ ಮರುಹೊಂದಿಸಬೇಕೇ?';

  @override
  String get settingsResetConfirmBody =>
      'ಅತ್ಯುತ್ತಮ ಸ್ಕೋರ್, ನಾಣ್ಯಗಳು, ಹಂತ, ಸರಣಿ ಮತ್ತು ಎಲ್ಲ ಪ್ರಗತಿ ಅಳಿಸಲ್ಪಡುತ್ತದೆ. ಇದನ್ನು ಹಿಂಪಡೆಯಲಾಗುವುದಿಲ್ಲ.\n\nನಿಮ್ಮ ಖರೀದಿಗಳು, ನಿಮ್ಮ ಹೆಸರು ಮತ್ತು ಅನ್‌ಲಾಕ್ ಮಾಡಿದ ಥೀಮ್‌ಗಳು, ಸ್ಕಿನ್‌ಗಳು ಉಳಿಯುತ್ತವೆ.';

  @override
  String get settingsResetConfirmAction => 'ಮರುಹೊಂದಿಸಿ';

  @override
  String get settingsResetDone => 'ಪ್ರಗತಿ ಮರುಹೊಂದಿಸಲಾಗಿದೆ.';

  @override
  String get settingsSectionGame => 'ಆಟ';

  @override
  String get settingsSectionSoundHaptics => 'ಧ್ವನಿ ಮತ್ತು ಕಂಪನ';

  @override
  String get settingsSectionReminders => 'ಜ್ಞಾಪನೆಗಳು';

  @override
  String get settingsSectionPurchases => 'ಖರೀದಿಗಳು';

  @override
  String get settingsSectionHelpOut => 'ಸಹಾಯ ಮಾಡಿ';

  @override
  String get settingsSectionLegal => 'ಕಾನೂನು';

  @override
  String get settingsSectionLanguage => 'ಭಾಷೆ';

  @override
  String get settingsGuide => 'ಆಡುವುದು ಹೇಗೆ';

  @override
  String get settingsGuideSubtitle =>
      'ನಿಯಮಗಳು, ಕಾಂಬೊಗಳು, ಫೀವರ್ ಮತ್ತು ಬೂಸ್ಟರ್‌ಗಳು';

  @override
  String get settingsSound => 'ಧ್ವನಿ';

  @override
  String get settingsMusic => 'ಸಂಗೀತ';

  @override
  String get settingsHaptics => 'ಕಂಪನ';

  @override
  String get settingsHapticsOff => 'ಆಫ್';

  @override
  String get settingsHapticsLight => 'ಹಗುರ';

  @override
  String get settingsHapticsStrong => 'ಬಲವಾದ';

  @override
  String get settingsSectionAccessibility => 'ಸೌಕರ್ಯ';

  @override
  String get settingsReducedEffects => 'ಕಡಿಮೆ ಪರಿಣಾಮಗಳು';

  @override
  String get settingsReducedEffectsHint =>
      'ಕಡಿಮೆ ಕಣಗಳು, ಪರದೆ ಅಲುಗಾಟವಿಲ್ಲ, ಹೊಳಪಿಲ್ಲ';

  @override
  String get settingsNotifications => 'ಅಧಿಸೂಚನೆಗಳು';

  @override
  String get settingsNotificationsSubtitle =>
      'ದೈನಂದಿನ ಜ್ಞಾಪನೆ ಮತ್ತು ಸರಣಿ ರಕ್ಷಣೆ';

  @override
  String get settingsNotificationsSystemHint =>
      'ಸಿಸ್ಟಮ್ ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ಅನುಮತಿಸಿ.';

  @override
  String get settingsLanguageSystem => 'ಸಿಸ್ಟಮ್ ಭಾಷೆ';

  @override
  String get settingsSupporterThanks => 'ಬೆಂಬಲಿಗರು — ಧನ್ಯವಾದಗಳು!';

  @override
  String get settingsSupporterPack => 'ಬೆಂಬಲಿಗರ ಪ್ಯಾಕ್';

  @override
  String get settingsSupporterPackSubtitle =>
      'ವಿಶೇಷ ಥೀಮ್ ಮತ್ತು ಸ್ಕಿನ್ + 1,500 ನಾಣ್ಯಗಳು';

  @override
  String get settingsRestorePurchases => 'ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಿ';

  @override
  String get settingsRestoring => 'ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get settingsRateApp => 'ಆ್ಯಪ್‌ಗೆ ರೇಟಿಂಗ್ ನೀಡಿ';

  @override
  String get settingsRateAppSubtitle => 'ಸ್ಟೋರ್‌ನಲ್ಲಿ ರೇಟಿಂಗ್ ನೀಡಿ';

  @override
  String get settingsStoreUnavailable => 'ಈ ಸಾಧನದಲ್ಲಿ ಸ್ಟೋರ್ ಲಭ್ಯವಿಲ್ಲ.';

  @override
  String get settingsFeedback => 'ಪ್ರತಿಕ್ರಿಯೆ ಕಳುಹಿಸಿ';

  @override
  String get settingsFeedbackSubtitle => 'ಆಲೋಚನೆಗಳು ಮತ್ತು ದೋಷಗಳು (GitHub ಮೂಲಕ)';

  @override
  String get settingsAdPrivacy => 'ಜಾಹೀರಾತು ಗೌಪ್ಯತೆ';

  @override
  String get settingsAdPrivacySubtitle =>
      'ನಿಮ್ಮ ಜಾಹೀರಾತು ಸಮ್ಮತಿ ನೋಡಿ ಅಥವಾ ಬದಲಿಸಿ';

  @override
  String get settingsAdPrivacyUnavailable =>
      'ಈ ಸಾಧನದಲ್ಲಿ ಜಾಹೀರಾತು ಆಯ್ಕೆಗಳ ಅಗತ್ಯವಿಲ್ಲ.';

  @override
  String get settingsPrivacy => 'ಗೌಪ್ಯತಾ ನೀತಿ';

  @override
  String get settingsImprint => 'ಕಾನೂನು ಮಾಹಿತಿ';

  @override
  String get settingsPageOpenFailed => 'ಪುಟ ತೆರೆಯಲಾಗಲಿಲ್ಲ.';

  @override
  String get settingsFooter => 'Qubble • ಆಫ್‌ಲೈನ್ ಬ್ಲಾಕ್ ಪಜಲ್';

  @override
  String get settingsAdminSection => 'ಅಡ್ಮಿನ್ (ಪರೀಕ್ಷೆ)';

  @override
  String get settingsAdminEnabled => 'ಅಡ್ಮಿನ್ ಮೋಡ್ ಆನ್ ಆಗಿದೆ';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'ಅಡ್ಮಿನ್ ಮೋಡ್‌ಗಾಗಿ ಇನ್ನೂ $count ಬಾರಿ ಟ್ಯಾಪ್ ಮಾಡಿ';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins ನಾಣ್ಯಗಳು',
      one: '$coins ನಾಣ್ಯ',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'ಪರೀಕ್ಷೆಗೆ ಮಾತ್ರ — ಬಿಡುಗಡೆ ಸ್ಕ್ರೀನ್‌ಶಾಟ್‌ಗಳಲ್ಲಿ ಎಂದಿಗೂ ಬೇಡ';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount ನಾಣ್ಯಗಳು',
      one: '$amount ನಾಣ್ಯ',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'ನಾಣ್ಯಗಳನ್ನು 0 ಮಾಡಿ';

  @override
  String get feedbackTitle => 'ಪ್ರತಿಕ್ರಿಯೆ';

  @override
  String get feedbackIntroShort =>
      'ನಿಮಗೆ ಏನು ಇಷ್ಟ, ಏನು ಕಿರಿಕಿರಿ, ಏನು ಕೊರತೆ? ಸಣ್ಣ ವಿಷಯಗಳೂ ಸಹಾಯ ಮಾಡುತ್ತವೆ — ಎಷ್ಟು ನಿಖರವೋ ಅಷ್ಟು ಒಳ್ಳೆಯದು.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'ಕೇವಲ $build ಮತ್ತು ನಿಮ್ಮ ಸಾಧನದ ಪ್ರಕಾರ ಲಗತ್ತಿಸಲಾಗುತ್ತದೆ — ನೀವು ಯಾವ ಆವೃತ್ತಿಯ ಬಗ್ಗೆ ಹೇಳುತ್ತಿದ್ದೀರಿ ಎಂದು ನನಗೆ ತಿಳಿಯಲು.';
  }

  @override
  String get feedbackSendByMail => 'ಇಮೇಲ್ ಮೂಲಕ ಕಳುಹಿಸಿ';

  @override
  String get feedbackPreferGithub => 'GitHub issue ಆದ್ಯತೆ';

  @override
  String get feedbackThanksMail => 'ಧನ್ಯವಾದಗಳು! ಸಂದೇಶ ಕಳುಹಿಸಿದರೆ ಸಾಕು.';

  @override
  String get feedbackNoMailApp =>
      'ಯಾವುದೇ ಮೇಲ್ ಆ್ಯಪ್ ಸಿಗಲಿಲ್ಲ. ಕೆಳಗಿನ GitHub ಮಾರ್ಗ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get feedbackEmptyHint => 'ದಯವಿಟ್ಟು ಮೊದಲು ಏನಾದರೂ ಬರೆಯಿರಿ.';

  @override
  String get leaderboardRefresh => 'ರಿಫ್ರೆಶ್';

  @override
  String get leaderboardRetry => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get feedbackHint => 'ನಿಮ್ಮ ಪ್ರತಿಕ್ರಿಯೆ…';

  @override
  String get feedbackSubmit => 'ಪ್ರತಿಕ್ರಿಯೆ ಕಳುಹಿಸಿ';

  @override
  String get feedbackOpenFailed => 'GitHub ತೆರೆಯಲಾಗಲಿಲ್ಲ. ನಂತರ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get feedbackGithubNote =>
      'GitHub ತೆರೆಯುತ್ತದೆ — ಅಲ್ಲಿ \"Submit new issue\" ಟ್ಯಾಪ್ ಮಾಡಿ. (ಒಮ್ಮೆ GitHub ಲಾಗಿನ್ ಅಗತ್ಯ.)';

  @override
  String get shopTitle => 'ಶಾಪ್';

  @override
  String get shopWebDemoNote =>
      'ಖರೀದಿಗಳು Play Store ಆ್ಯಪ್‌ನಲ್ಲಿ ಮಾತ್ರ ಲಭ್ಯ. ಈ ವೆಬ್ ಆವೃತ್ತಿ ಉಚಿತ ಡೆಮೊ — ಆದರೂ ಇಲ್ಲಿ ಎಲ್ಲವನ್ನೂ ಆಡಬಹುದು.';

  @override
  String get shopSupporterExplainer =>
      'Qubble ಬಲವಂತದ ಜಾಹೀರಾತುಗಳನ್ನು ತೋರಿಸುವುದಿಲ್ಲ — ನೀವು ಏನನ್ನೂ ಖರೀದಿಸಬೇಕಾಗಿಲ್ಲ. ಬೆಂಬಲಿಗರ ಪ್ಯಾಕ್ (ಅರೋರಾ ಥೀಮ್, ಕ್ರಿಸ್ಟಲ್ ಸ್ಕಿನ್, 1,500 ನಾಣ್ಯಗಳು, ಬೆಂಬಲಿಗರ ಬ್ಯಾಡ್ಜ್) ಆಟವನ್ನು ಬೆಂಬಲಿಸಿದ್ದಕ್ಕಾಗಿ ಕೃತಜ್ಞತೆ. ಖರೀದಿಗಳು ನಿಮ್ಮ ಸ್ಟೋರ್ ಖಾತೆಗೆ ಲಿಂಕ್ ಆಗಿವೆ ಮತ್ತು ಯಾವಾಗ ಬೇಕಾದರೂ ಮರುಸ್ಥಾಪಿಸಬಹುದು.';

  @override
  String get shopSupporterContents =>
      'ಅರೋರಾ ಥೀಮ್ + ಕ್ರಿಸ್ಟಲ್ ಸ್ಕಿನ್ + 1,500 ನಾಣ್ಯಗಳು';

  @override
  String get themesTitle => 'ಥೀಮ್‌ಗಳು';

  @override
  String get themesSupporterOnly => 'ಬೆಂಬಲಿಗರ ಪ್ಯಾಕ್‌ನಲ್ಲಿ ಮಾತ್ರ (ಶಾಪ್ ನೋಡಿ)';

  @override
  String get skinsTitle => 'ಬ್ಲಾಕ್ ಸ್ಕಿನ್‌ಗಳು';

  @override
  String get skinsNotEnoughCoins => 'ಸಾಕಷ್ಟು ನಾಣ್ಯಗಳಿಲ್ಲ';

  @override
  String get skinsNotEnoughGold => 'ಸಾಕಷ್ಟು ಚಿನ್ನವಿಲ್ಲ.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold ಚಿನ್ನ = 1 ವಜ್ರ. ವಜ್ರಗಳು ಅತ್ಯಂತ ಸುಂದರ ಸ್ಕಿನ್‌ಗಳನ್ನು ಅನ್‌ಲಾಕ್ ಮಾಡುತ್ತವೆ — ನಿಧಾನವಾಗಿ ಸಂಗ್ರಹಿಸಿ.';
  }

  @override
  String get statsTitle => 'ಅಂಕಿಅಂಶಗಳು';

  @override
  String get statsAverageScore => 'ಸರಾಸರಿ ಸ್ಕೋರ್';

  @override
  String get statsBestCombo => 'ಅತ್ಯುತ್ತಮ ಕಾಂಬೊ';

  @override
  String get statsGames => 'ಆಟಗಳು';

  @override
  String get statsLinesCleared => 'ತೆರವುಗೊಳಿಸಿದ ಸಾಲುಗಳು';

  @override
  String get statsPiecesPlaced => 'ಇಟ್ಟ ತುಂಡುಗಳು';

  @override
  String get statsCoins => 'ನಾಣ್ಯಗಳು';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString ಕಾಂಬೊ ಸಾಧಿಸಿ';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ಒಂದೇ ಆಟದಲ್ಲಿ $countString ಅಂಕಗಳನ್ನು ದಾಟಿ',
      one: 'ಒಂದೇ ಆಟದಲ್ಲಿ $countString ಅಂಕ ದಾಟಿ',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'ಸಾಧನೆಗಳು';

  @override
  String get achievementFirstGameTitle => 'ಮೊದಲ ಆಟ';

  @override
  String get achievementFirstGameBody => 'ನಿಮ್ಮ ಮೊದಲ ಆಟ ಆಡಿ';

  @override
  String get achievementGames25Title => 'ನಿಯಮಿತ';

  @override
  String get achievementGames25Body => '25 ಆಟಗಳನ್ನು ಆಡಿ';

  @override
  String get achievementGames100Title => 'ಅಭಿಮಾನಿ';

  @override
  String get achievementGames100Body => '100 ಆಟಗಳನ್ನು ಆಡಿ';

  @override
  String get achievementScore1kTitle => 'ಏರುವವರು';

  @override
  String get achievementScore1kBody => '1,000 ಅಂಕ ತಲುಪಿ';

  @override
  String get achievementScore5kTitle => 'ಪ್ರೊ';

  @override
  String get achievementScore5kBody => '5,000 ಅಂಕ ತಲುಪಿ';

  @override
  String get achievementScore10kTitle => 'ಮಾಸ್ಟರ್';

  @override
  String get achievementScore10kBody => '10,000 ಅಂಕ ತಲುಪಿ';

  @override
  String get achievementScore25kTitle => 'ದಂತಕಥೆ';

  @override
  String get achievementScore25kBody => '25,000 ಅಂಕ ತಲುಪಿ';

  @override
  String get achievementLines100Title => 'ಅಚ್ಚುಕಟ್ಟು';

  @override
  String get achievementLines100Body => 'ಒಟ್ಟು 100 ಸಾಲುಗಳನ್ನು ತೆರವುಗೊಳಿಸಿ';

  @override
  String get achievementLines1000Title => 'ಮಹಾ ಸ್ವಚ್ಛತೆ';

  @override
  String get achievementLines1000Body => 'ಒಟ್ಟು 1,000 ಸಾಲುಗಳನ್ನು ತೆರವುಗೊಳಿಸಿ';

  @override
  String get achievementCombo5Title => 'ಕಾಂಬೊ ಆರಂಭ';

  @override
  String get achievementCombo5Body => 'x5 ಕಾಂಬೊ ಸಾಧಿಸಿ';

  @override
  String get achievementCombo10Title => 'ಕಾಂಬೊ ರಾಜ';

  @override
  String get achievementCombo10Body => 'x10 ಕಾಂಬೊ ಸಾಧಿಸಿ';

  @override
  String get achievementLevel10Title => 'ಅನುಭವಿ';

  @override
  String get achievementLevel10Body => 'ಹಂತ 10 ತಲುಪಿ';

  @override
  String get achievementLevel20Title => 'ಹಿರಿಯ';

  @override
  String get achievementLevel20Body => 'ಹಂತ 20 ತಲುಪಿ';

  @override
  String get achievementStreak7Title => 'ವಾರದ ಸರಣಿ';

  @override
  String get achievementStreak7Body => '7 ದಿನಗಳ ದೈನಂದಿನ ಸರಣಿ';

  @override
  String get achievementStreak30Title => 'ತಿಂಗಳ ಸರಣಿ';

  @override
  String get achievementStreak30Body => '30 ದಿನಗಳ ದೈನಂದಿನ ಸರಣಿ';

  @override
  String get achievementPuzzles10Title => 'ಪಜಲರ್';

  @override
  String get achievementPuzzles10Body => '10 ಪಜಲ್‌ಗಳನ್ನು ಪರಿಹರಿಸಿ';

  @override
  String get achievementPieces5000Title => 'ನಿರ್ಮಾತೃ';

  @override
  String get achievementPieces5000Body => '5,000 ತುಂಡುಗಳನ್ನು ಇಡಿ';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak ದಿನಗಳ ಸರಣಿ ಅಪಾಯದಲ್ಲಿದೆ!',
      one: '$streak ದಿನದ ಸರಣಿ ಅಪಾಯದಲ್ಲಿದೆ!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'ನಿನ್ನೆ ಆಡಲಿಲ್ಲ — ನಿಮ್ಮ ಸರಣಿಯನ್ನು ಉಳಿಸಿ:';

  @override
  String get streakRepairFailed => 'ಸರಿಪಡಿಸಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins ನಾಣ್ಯಗಳು',
      one: '$coins ನಾಣ್ಯ',
    );
    return 'ಮರಳಿ ಸ್ವಾಗತ! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'ಜ್ಞಾಪನೆಗಳು?';

  @override
  String get notificationsOptInBody =>
      'ನಿಮ್ಮ ದೈನಂದಿನ ಪಜಲ್ ಅನ್ನು ನೆನಪಿಸಿ, ನಿಮ್ಮ ಸರಣಿಯನ್ನು ರಕ್ಷಿಸೋಣವೇ? ಇದನ್ನು ಯಾವಾಗ ಬೇಕಾದರೂ ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ಬದಲಿಸಬಹುದು.';

  @override
  String get notificationsOptInAccept => 'ಹೌದು, ದಯವಿಟ್ಟು';

  @override
  String get notificationChannelDescription =>
      'ದೈನಂದಿನ ಜ್ಞಾಪನೆ, ಸರಣಿ ಎಚ್ಚರಿಕೆ, ಮರಳಿ ಬನ್ನಿ';

  @override
  String get notificationDailyTitle => 'ನಿಮ್ಮ ದೈನಂದಿನ ಪಜಲ್ ಕಾಯುತ್ತಿದೆ 🧩';

  @override
  String get notificationDailyBody => 'ಇಂದಿನ ಸವಾಲು ಆಡಿ!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak ದಿನಗಳ ಸರಣಿ ಅಪಾಯದಲ್ಲಿದೆ!',
      one: '$streak ದಿನದ ಸರಣಿ ಅಪಾಯದಲ್ಲಿದೆ!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'ಅದನ್ನು ಉಳಿಸಿಕೊಳ್ಳಲು ಇಂದು ಆಡಿ.';

  @override
  String get notificationComebackTitle => 'ನಿಮ್ಮ ಬ್ಲಾಕ್‌ಗಳು ಕಾಯುತ್ತಿವೆ 🧩';

  @override
  String get notificationComebackBody => 'ಮರಳಿ ಬಂದು ಉಡುಗೊರೆ ಪಡೆಯಿರಿ!';

  @override
  String get iapSupporterPack => 'ಬೆಂಬಲಿಗರ ಪ್ಯಾಕ್';

  @override
  String get iapCoinsSmall => '500 ನಾಣ್ಯಗಳು';

  @override
  String get iapCoinsMedium => '2,000 ನಾಣ್ಯಗಳು';

  @override
  String get iapCoinsLarge => '6,000 ನಾಣ್ಯಗಳು';

  @override
  String get iapStarterPack => 'ಸ್ಟಾರ್ಟರ್ ಪ್ಯಾಕ್';

  @override
  String get iapRename => 'ಹೆಸರು ಬದಲಾವಣೆ';

  @override
  String get iapNeonTheme => 'ನಿಯಾನ್ ಥೀಮ್';

  @override
  String get settingsLeaderboardDelete => 'ಲೀಡರ್‌ಬೋರ್ಡ್ ನಮೂದು ಅಳಿಸಿ';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'ನಿಮ್ಮ ಹೆಸರು ಮತ್ತು ಸ್ಕೋರ್ ಅನ್ನು ಸಾರ್ವಜನಿಕ ಪಟ್ಟಿಯಿಂದ ತೆಗೆದುಹಾಕುತ್ತದೆ';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'ನಿಮ್ಮ ನಮೂದು ಅಳಿಸಬೇಕೇ?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'ನಿಮ್ಮ ಹೆಸರು ಮತ್ತು ಸ್ಕೋರ್ ಲೀಡರ್‌ಬೋರ್ಡ್‌ನಿಂದ ತೆಗೆದುಹಾಕಲ್ಪಡುತ್ತವೆ. ನಿಮ್ಮ ಆಟದ ಪ್ರಗತಿ ಬದಲಾಗುವುದಿಲ್ಲ. ಯಾವಾಗ ಬೇಕಾದರೂ ಲೀಡರ್‌ಬೋರ್ಡ್‌ಗೆ ಮತ್ತೆ ಸೇರಬಹುದು.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'ನಿಮ್ಮ ಲೀಡರ್‌ಬೋರ್ಡ್ ನಮೂದು ಅಳಿಸಲಾಗಿದೆ.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'ನಮೂದು ಅಳಿಸಲಾಗಲಿಲ್ಲ. ಸಂಪರ್ಕ ಪರಿಶೀಲಿಸಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get leaderboardReport => 'ಈ ಹೆಸರನ್ನು ವರದಿ ಮಾಡಿ';

  @override
  String get leaderboardBlock => 'ಮರೆಮಾಡಿ';

  @override
  String leaderboardBlocked(String name) {
    return '$name ನಿಮಗೆ ಮರೆಮಾಡಲಾಗಿದೆ';
  }

  @override
  String get leaderboardUndo => 'ರದ್ದುಮಾಡಿ';

  @override
  String leaderboardBlockedCount(int count) {
    return 'ನೀವು ಮರೆಮಾಡಿದ ನಮೂದುಗಳು: $count';
  }

  @override
  String get leaderboardUnblockAll => 'ಮತ್ತೆ ತೋರಿಸಿ';

  @override
  String get leaderboardReportUnavailable => 'ಈಗ ವರದಿ ಮಾಡಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String get leaderboardReportSent => 'ಧನ್ಯವಾದಗಳು — ನಿಮ್ಮ ವರದಿ ಕಳುಹಿಸಲಾಗಿದೆ.';

  @override
  String get leaderboardRules =>
      'ಹೆಸರುಗಳು ಸಾರ್ವಜನಿಕ. ಅವಮಾನಗಳು, ನಿಂದನೆಗಳು ಮತ್ತು ನಿಜವಾದ ವ್ಯಕ್ತಿಯನ್ನು ಗುರುತಿಸುವ ಯಾವುದೂ ಬೇಡ. ಈ ನಿಯಮ ಮೀರುವ ಹೆಸರುಗಳನ್ನು ತೆಗೆದುಹಾಕಲಾಗುತ್ತದೆ.';

  @override
  String get leaderboardRulesAccept => 'ಅರ್ಥವಾಯಿತು';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'ಅನ್‌ಲಾಕ್ ಆದವು: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'ಉಳಿಸಿದ ಡೇಟಾ';

  @override
  String get gameRotatePiece => 'ತುಂಡನ್ನು ತಿರುಗಿಸಿ';

  @override
  String get themeClassic => 'ಕ್ಲಾಸಿಕ್';

  @override
  String get themeFade => 'ಪೇಸ್ಟಲ್';

  @override
  String get themeNeon => 'ನಿಯಾನ್';

  @override
  String get themeOcean => 'ಸಾಗರ';

  @override
  String get themeWood => 'ಮರ';

  @override
  String get themeSunset => 'ಸೂರ್ಯಾಸ್ತ';

  @override
  String get themeForest => 'ಅರಣ್ಯ';

  @override
  String get themeAurora => 'ಅರೋರಾ';

  @override
  String get skinClassic => 'ಕ್ಲಾಸಿಕ್';

  @override
  String get skinGradient => 'ಗ್ರೇಡಿಯಂಟ್';

  @override
  String get skinOutline => 'ಔಟ್‌ಲೈನ್';

  @override
  String get skinGlossy => 'ಹೊಳಪು';

  @override
  String get skinStripe => 'ಪಟ್ಟೆಗಳು';

  @override
  String get skinBevel => 'ಇಳಿಜಾರು';

  @override
  String get skinGlow => 'ಕಾಂತಿ';

  @override
  String get skinCrystal => 'ಕ್ರಿಸ್ಟಲ್';

  @override
  String rewardThemeName(String name) {
    return '$name ಥೀಮ್';
  }

  @override
  String rewardSkinName(String name) {
    return '$name ಸ್ಕಿನ್';
  }

  @override
  String get skinPulse => 'ನಾಡಿ';

  @override
  String get skinShimmer => 'ಮಿನುಗು';

  @override
  String get skinWave => 'ಅಲೆ';

  @override
  String get skinEmber => 'ಕೆಂಡ';

  @override
  String get skinPrism => 'ಪ್ರಿಸಂ';

  @override
  String get skinStardust => 'ನಕ್ಷತ್ರ ಧೂಳು';

  @override
  String get skinCircuit => 'ಸರ್ಕ್ಯೂಟ್';

  @override
  String get skinRipple => 'ತರಂಗ';

  @override
  String achievementRewardSkin(String name) {
    return 'ಅನಿಮೇಟೆಡ್ ಸ್ಕಿನ್: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'ಸಾಧನೆಯ ಬಹುಮಾನ: $achievement';
  }

  @override
  String get achievementBackpay =>
      'ಸಾಧನೆಗಳು ಈಗ ಬಹುಮಾನ ನೀಡುತ್ತವೆ — ನಿಮ್ಮವನ್ನು ಸೇರಿಸಲಾಗಿದೆ.';

  @override
  String get namePromptBody =>
      'ಒಂದು ಹೆಸರನ್ನು ಆಯ್ಕೆಮಾಡಿ, ಆಗ ನಿಮ್ಮ ಅತ್ಯುತ್ತಮ ಸ್ಕೋರ್ ಲೀಡರ್‌ಬೋರ್ಡ್‌ಗೆ ಹೋಗುತ್ತದೆ. ಹೆಸರಿಲ್ಲದೆ ನೀವು ಅನಾಮಧೇಯವಾಗಿ ಆಡುತ್ತಲೇ ಇರುತ್ತೀರಿ.';

  @override
  String get nameTaken =>
      'ಈ ಹೆಸರು ಈಗಾಗಲೇ ಬಳಕೆಯಲ್ಲಿದೆ. ಬೇರೆ ಹೆಸರನ್ನು ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get nameCheckFailed =>
      'ಹೆಸರನ್ನು ಪರಿಶೀಲಿಸಲಾಗಲಿಲ್ಲ. ನೀವು ಆನ್‌ಲೈನ್‌ನಲ್ಲಿದ್ದೀರಾ? ಸ್ವಲ್ಪ ಹೊತ್ತಿನ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String nameLost(String name) {
    return '$name ಈಗ ಬೇರೊಬ್ಬ ಆಟಗಾರರದ್ದು. ಉಚಿತವಾಗಿ ಹೊಸ ಹೆಸರನ್ನು ಆಯ್ಕೆಮಾಡಿ.';
  }

  @override
  String get themeCandy => 'ಕ್ಯಾಂಡಿ';

  @override
  String get themeVolcano => 'ಜ್ವಾಲಾಮುಖಿ';

  @override
  String get themeGlacier => 'ಹಿಮನದಿ';

  @override
  String get skinPixel => 'ಪಿಕ್ಸೆಲ್';

  @override
  String get skinMarble => 'ಅಮೃತಶಿಲೆ';

  @override
  String get skinJelly => 'ಜೆಲ್ಲಿ';

  @override
  String get skinLiquid => 'ದ್ರವ';

  @override
  String get skinFizz => 'ಗುಳ್ಳೆಗಳು';

  @override
  String get skinPlasma => 'ಪ್ಲಾಸ್ಮಾ';

  @override
  String get designsTitle => 'ವಿನ್ಯಾಸಗಳು';

  @override
  String get designsNotEnoughDiamonds => 'ಸಾಕಷ್ಟು ವಜ್ರಗಳಿಲ್ಲ.';

  @override
  String get designsOwned => 'ನಿಮ್ಮದು';

  @override
  String get designsAchievementOnly => 'ಸಾಧನೆ';

  @override
  String get designsSupporterOnly => 'ಬೆಂಬಲಿಗ';

  @override
  String get designsPreview => 'ಮುನ್ನೋಟ';

  @override
  String get designsGetDiamonds => 'ವಜ್ರಗಳನ್ನು ಪಡೆಯಿರಿ';

  @override
  String get shopDealTitle => 'ಇಂದಿನ ಆಫರ್';

  @override
  String get shopAnimatedSkins => 'ಅನಿಮೇಟೆಡ್ ಸ್ಕಿನ್‌ಗಳು';

  @override
  String get shopNewDesigns => 'ಹೊಸ ವಿನ್ಯಾಸಗಳು';

  @override
  String get shopDiamonds => 'ವಜ್ರಗಳು';

  @override
  String get shopPacks => 'ಪ್ಯಾಕ್‌ಗಳು';

  @override
  String get shopPopular => 'ಜನಪ್ರಿಯ';

  @override
  String get shopBestValue => 'ಅತ್ಯುತ್ತಮ ಮೌಲ್ಯ';

  @override
  String get shopDiamondsBlurb =>
      'ಅನಿಮೇಟೆಡ್ ಸ್ಕಿನ್‌ಗಳು ಮತ್ತು ಹೊಸ ವಿನ್ಯಾಸಗಳಿಗಾಗಿ.';

  @override
  String get shopCoinsBlurb => 'ಥೀಮ್‌ಗಳು, ಸ್ಕಿನ್‌ಗಳು ಮತ್ತು ಬೂಸ್ಟರ್‌ಗಳಿಗಾಗಿ.';

  @override
  String get shopNeonBlurb => 'ನಿಯಾನ್ ಥೀಮ್ ಅನ್ನು ತಕ್ಷಣ ಅನ್‌ಲಾಕ್ ಮಾಡುತ್ತದೆ.';

  @override
  String get shopRenameBlurb => 'ಲೀಡರ್‌ಬೋರ್ಡ್‌ನಲ್ಲಿ ನಿಮ್ಮ ಹೆಸರು ಬದಲಿಸಿ.';

  @override
  String shopHoursLeft(int hours) {
    return 'ಇನ್ನೂ $hours ಗಂ';
  }

  @override
  String shopNewDealIn(String time) {
    return 'ಹೊಸ ಆಫರ್ $time ನಲ್ಲಿ';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name ಅನ್‌ಲಾಕ್ ಆಯಿತು!';
  }

  @override
  String get questsTitle => 'ಕ್ವೆಸ್ಟ್‌ಗಳು';

  @override
  String get questsDaily => 'ದೈನಂದಿನ';

  @override
  String get questsWeekly => 'ವಾರದ';

  @override
  String get questsMonthly => 'ಮಾಸಿಕ';

  @override
  String questsNewIn(String time) {
    return 'ಹೊಸ ಕ್ವೆಸ್ಟ್‌ಗಳು $time ನಲ್ಲಿ';
  }

  @override
  String get questsBonus => 'ಎಲ್ಲಕ್ಕೂ ಬೋನಸ್';

  @override
  String get questsBonusEarned => 'ಬೋನಸ್ ಗಳಿಸಲಾಗಿದೆ';

  @override
  String get questRounds => 'ಸುತ್ತುಗಳನ್ನು ಆಡಿ';

  @override
  String get questLines => 'ಸಾಲುಗಳನ್ನು ತೆರವುಗೊಳಿಸಿ';

  @override
  String get questPieces => 'ತುಂಡುಗಳನ್ನು ಇಡಿ';

  @override
  String get questDailyChallenge => 'ದೈನಂದಿನ ಸವಾಲು ಆಡಿ';

  @override
  String get questPuzzles => 'ಹೊಸ ಒಗಟುಗಳನ್ನು ಬಿಡಿಸಿ';

  @override
  String get questDays => 'ಬೇರೆ ಬೇರೆ ದಿನಗಳಲ್ಲಿ ಆಡಿ';

  @override
  String get questDailySets => 'ಎಲ್ಲಾ ದೈನಂದಿನ ಕ್ವೆಸ್ಟ್‌ಗಳನ್ನು ಮುಗಿಸಿ';

  @override
  String get questsSetDaily => 'ಎಲ್ಲಾ ದೈನಂದಿನ ಕ್ವೆಸ್ಟ್‌ಗಳು ಮುಗಿದಿವೆ!';

  @override
  String get questsSetWeekly => 'ಎಲ್ಲಾ ವಾರದ ಕ್ವೆಸ್ಟ್‌ಗಳು ಮುಗಿದಿವೆ!';

  @override
  String get questsSetMonthly => 'ಎಲ್ಲಾ ಮಾಸಿಕ ಕ್ವೆಸ್ಟ್‌ಗಳು ಮುಗಿದಿವೆ!';

  @override
  String get leaderboardTabScore => 'ಅತ್ಯುತ್ತಮ ಸ್ಕೋರ್';

  @override
  String get leaderboardTabPuzzle => 'ಒಗಟು ನಕ್ಷತ್ರಗಳು';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'ನಿಮ್ಮ ಒಗಟು ನಕ್ಷತ್ರಗಳು ಸ್ವಯಂಚಾಲಿತವಾಗಿ ಕಳುಹಿಸಲ್ಪಡುತ್ತವೆ.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'ನಿಮ್ಮ ಒಗಟು ನಕ್ಷತ್ರಗಳನ್ನು ($stars) ಕಳುಹಿಸಲಾಗುತ್ತಿದೆ …';
  }

  @override
  String get dailyGoalTitle => 'ಇಂದಿನ ಗುರಿ';

  @override
  String dailyGoalPoints(String points) {
    return '$points ಅಂಕಗಳು';
  }

  @override
  String get dailyChestOpened => 'ಸರಣಿ ಪೆಟ್ಟಿಗೆ ತೆರೆಯಿತು!';

  @override
  String dailyNextChest(int day) {
    return 'ಮುಂದಿನ ಪೆಟ್ಟಿಗೆ: ಸರಣಿಯ ದಿನ $day';
  }

  @override
  String get dailyExplainer =>
      'ಇಂದು ಎಲ್ಲರೂ ಒಂದೇ ಬೋರ್ಡ್‌ನಲ್ಲಿ ಆಡುತ್ತಾರೆ, ಮತ್ತು ನಿಮ್ಮ ಮೊದಲ ಸುತ್ತು ಎಣಿಕೆಯಾಗುತ್ತದೆ. ಹೆಚ್ಚುವರಿ ನಾಣ್ಯಗಳಿಗಾಗಿ ನಕ್ಷತ್ರದ ಗುರುತುಗಳನ್ನು ತಲುಪಿ, ವಜ್ರದ ಪೆಟ್ಟಿಗೆಗಳಿಗಾಗಿ ನಿಮ್ಮ ಸರಣಿಯನ್ನು ಉಳಿಸಿಕೊಳ್ಳಿ, ಮತ್ತು ಇಂದು ನೀವು ಯಾವ ಸ್ಥಾನದಲ್ಲಿದ್ದೀರಿ ಎಂದು ನೋಡಿ.';

  @override
  String dailyRank(int rank, int total) {
    return 'ಇಂದು $total ರಲ್ಲಿ ಸ್ಥಾನ $rank';
  }

  @override
  String get dailyRankNeedsName => 'ಶ್ರೇಯಾಂಕದಲ್ಲಿ ಕಾಣಿಸಲು ಹೆಸರನ್ನು ಆರಿಸಿ.';

  @override
  String get dailyRankingButton => 'ಇಂದಿನ ಶ್ರೇಯಾಂಕ';

  @override
  String get leaderboardTabDaily => 'ಇಂದಿನ ಸವಾಲು';

  @override
  String get leaderboardDailyFooter =>
      'ಎಲ್ಲರಿಗೂ ಒಂದೇ ಬೋರ್ಡ್, ಮೊದಲ ಸುತ್ತು ಎಣಿಕೆಯಾಗುತ್ತದೆ. ಪ್ರತಿದಿನ ಹೊಸ ಶ್ರೇಯಾಂಕ.';

  @override
  String notificationChestBody(int diamonds) {
    return 'ಇಂದಿನ ಸವಾಲನ್ನು ಆಡಿ ಮತ್ತು ಸರಣಿ ಪೆಟ್ಟಿಗೆಯನ್ನು ತೆರೆಯಿರಿ: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'ಕುಂಬಳಕಾಯಿ';

  @override
  String get skinGhost => 'ಭೂತ';

  @override
  String get halloweenTitle => 'ಹ್ಯಾಲೋವೀನ್';

  @override
  String get halloweenBody =>
      'ಕುಂಬಳಕಾಯಿ ಥೀಮ್ ಮತ್ತು ಭೂತ ಸ್ಕಿನ್ — ಅಕ್ಟೋಬರ್‌ನಲ್ಲಿ ಮಾತ್ರ.';

  @override
  String get designsBackInOctober => 'ಅಕ್ಟೋಬರ್‌ನಲ್ಲಿ ಮತ್ತೆ';
}
