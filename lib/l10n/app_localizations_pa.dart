// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class L10nPa extends L10n {
  L10nPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'ਖੇਡੋ';

  @override
  String get commonLater => 'ਬਾਅਦ ਵਿੱਚ';

  @override
  String get commonNotNow => 'ਹੁਣ ਨਹੀਂ';

  @override
  String get commonCancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get commonBuy => 'ਖਰੀਦੋ';

  @override
  String get commonSave => 'ਸੇਵ ਕਰੋ';

  @override
  String get commonCollect => 'ਲਓ';

  @override
  String get nameNewName => 'ਨਵਾਂ ਨਾਮ';

  @override
  String get nameFieldLabel => 'ਨਾਮ';

  @override
  String get piggyFullTitle => 'ਗੋਲਕ ਭਰ ਗਈ!';

  @override
  String get piggyKeepSaving => 'ਬੱਚਤ ਜਾਰੀ ਰੱਖੋ';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity ਵਿੱਚੋਂ $coins ਜਮ੍ਹਾਂ ਹੋਏ।';
  }

  @override
  String get homeContinueRun => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String get homeVideo => 'ਵੀਡੀਓ';

  @override
  String get commonGotIt => 'ਠੀਕ ਹੈ';

  @override
  String get commonHome => 'ਹੋਮ';

  @override
  String get commonScore => 'ਸਕੋਰ';

  @override
  String get commonBest => 'ਸਭ ਤੋਂ ਵਧੀਆ';

  @override
  String commonLevelShort(int level) {
    return 'ਲੈਵਲ $level';
  }

  @override
  String get homeNewRun => 'ਨਵੀਂ ਖੇਡ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get homeBackToExit => 'ਬਾਹਰ ਜਾਣ ਲਈ ਦੁਬਾਰਾ ਵਾਪਸ ਦਬਾਓ';

  @override
  String get homeEnableLeaderboard => 'ਲੀਡਰਬੋਰਡ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੋ';

  @override
  String get homeBestScore => 'ਸਭ ਤੋਂ ਵਧੀਆ ਸਕੋਰ';

  @override
  String get homeDailyChallenge => 'ਰੋਜ਼ਾਨਾ ਚੁਣੌਤੀ';

  @override
  String get homeDailyOpenToday => 'ਅੱਜ ਖੇਡਣਾ ਬਾਕੀ';

  @override
  String homeDailyNextIn(String time) {
    return 'ਅਗਲੀ ਚੁਣੌਤੀ: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'ਲਗਾਤਾਰ $streak ਦਿਨ';
  }

  @override
  String get homeLeaderboard => 'ਲੀਡਰਬੋਰਡ';

  @override
  String get homePuzzleMode => 'ਪਹੇਲੀ ਮੋਡ';

  @override
  String get homeHowToPlay => 'Qubble ਕਿਵੇਂ ਖੇਡੀਏ';

  @override
  String get homeWeekendBonus => 'ਵੀਕੈਂਡ: ਦੁੱਗਣੇ ਸਿੱਕੇ!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'ਲੈਵਲ $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'ਨਾਮ ਬਦਲੋ';

  @override
  String get nameChangeExplainer =>
      'ਤੁਹਾਡਾ ਨਾਮ ਲੀਡਰਬੋਰਡ ਉੱਤੇ ਤੁਹਾਡੀ ਪਛਾਣ ਹੈ, ਇਸ ਲਈ ਇਹ ਪੱਕਾ ਰਹਿੰਦਾ ਹੈ। ਇੱਕ ਵਾਰ ਨਾਮ ਬਦਲਣ ਦੀ ਸਹੂਲਤ ਖਰੀਦੀ ਜਾ ਸਕਦੀ ਹੈ।';

  @override
  String get nameChangeAfterPurchase =>
      'ਖਰੀਦਣ ਤੋਂ ਬਾਅਦ, ਨਾਮ ਬਦਲਣ ਲਈ ਆਪਣੇ ਨਾਮ ਉੱਤੇ ਦੁਬਾਰਾ ਟੈਪ ਕਰੋ।';

  @override
  String get nameJoinedLeaderboard => 'ਹੁਣ ਤੁਸੀਂ ਲੀਡਰਬੋਰਡ ਉੱਤੇ ਹੋ।';

  @override
  String nameProblemTooShort(int min) {
    return 'ਘੱਟੋ-ਘੱਟ ਅੱਖਰ: $min।';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'ਵੱਧ ਤੋਂ ਵੱਧ ਅੱਖਰ: $max।';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'ਸਿਰਫ਼ ਅੰਗਰੇਜ਼ੀ ਅੱਖਰ (A–Z), ਅੰਕ, ਸਪੇਸ, _ ਅਤੇ - ਦੀ ਇਜਾਜ਼ਤ ਹੈ।';

  @override
  String get nameProblemOffensive => 'ਕਿਰਪਾ ਕਰਕੇ ਕੋਈ ਹੋਰ ਨਾਮ ਚੁਣੋ।';

  @override
  String get piggyTitle => 'ਗੋਲਕ';

  @override
  String get piggyFillingHint =>
      'ਲਾਈਨਾਂ ਸਾਫ਼ ਕਰਨ ਨਾਲ ਤੁਹਾਡੀ ਗੋਲਕ ਭਰਦੀ ਜਾਂਦੀ ਹੈ।';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins ਸਿੱਕੇ ਮੁਫ਼ਤ ਵਿੱਚ ਲਓ।',
      one: '$coins ਸਿੱਕਾ ਮੁਫ਼ਤ ਵਿੱਚ ਲਓ।',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'ਭਰ ਜਾਣ ਉੱਤੇ ਇਸਨੂੰ ਮੁਫ਼ਤ ਵਿੱਚ ਖਾਲੀ ਕੀਤਾ ਜਾ ਸਕਦਾ ਹੈ — ਜਾਂ ਬੋਨਸ ਵੀਡੀਓ ਨਾਲ ਪਹਿਲਾਂ ਹੀ ਖੋਲ੍ਹਿਆ ਜਾ ਸਕਦਾ ਹੈ।';

  @override
  String get piggyOpenNow => 'ਹੁਣੇ ਖੋਲ੍ਹੋ';

  @override
  String get gameNewPiecesVideo => 'ਨਵੇਂ ਟੁਕੜੇ (ਵੀਡੀਓ)';

  @override
  String get gameTapBoardCell => 'ਬੋਰਡ ਦੇ ਕਿਸੇ ਖਾਨੇ ਉੱਤੇ ਟੈਪ ਕਰੋ';

  @override
  String get gameDailyChallengeLabel => 'ਰੋਜ਼ਾਨਾ ਚੁਣੌਤੀ';

  @override
  String get gameOver => 'ਖੇਡ ਖਤਮ';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'ਬੰਬ ਲਈ ਹੋਰ ਸਿੱਕੇ ਚਾਹੀਦੇ ਹਨ: $missing।';
  }

  @override
  String get gameBombNotHere => 'ਬੰਬ ਇਸ ਵੇਲੇ ਇੱਥੇ ਕੰਮ ਨਹੀਂ ਕਰੇਗਾ।';

  @override
  String gameNeedsCoins(String missing) {
    return 'ਇਸ ਲਈ ਹੋਰ ਸਿੱਕੇ ਚਾਹੀਦੇ ਹਨ: $missing।';
  }

  @override
  String get gameNotRightNow => 'ਇਸ ਵੇਲੇ ਸੰਭਵ ਨਹੀਂ।';

  @override
  String get gameRunSaved => 'ਖੇਡ ਸੇਵ ਹੋ ਗਈ — ਮੀਨੂ ਵਿੱਚ \"ਜਾਰੀ ਰੱਖੋ\"।';

  @override
  String get gameOverNoFit =>
      'ਤੁਹਾਡਾ ਕੋਈ ਵੀ ਟੁਕੜਾ ਹੁਣ ਬੋਰਡ ਉੱਤੇ ਫਿੱਟ ਨਹੀਂ ਹੁੰਦਾ।';

  @override
  String get gameOverNoFitNoRotations =>
      'ਕੋਈ ਟੁਕੜਾ ਫਿੱਟ ਨਹੀਂ ਹੁੰਦਾ — ਅਤੇ ਘੁਮਾਉਣ ਦੇ ਮੌਕੇ ਵੀ ਖਤਮ ਹੋ ਗਏ।';

  @override
  String get gameStarterOfferUnavailable => 'ਇਸ ਵੇਲੇ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — ਲਓ';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'ਕੰਬੋ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'ਪ੍ਰਾਪਤੀ: $title';
  }

  @override
  String get gameBestSubmitted => 'ਨਵਾਂ ਸਭ ਤੋਂ ਵਧੀਆ — ਭੇਜਿਆ ਗਿਆ';

  @override
  String get gameReviveFor => 'ਖੇਡ ਜਾਰੀ ਰੱਖੋ · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'ਅਨਲੌਕ ਹੋਇਆ: $name';
  }

  @override
  String get gameStarterOfferTitle => 'ਸਟਾਰਟਰ ਪੈਕ';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score ਅੰਕ',
      one: '$score ਅੰਕ',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'ਨਵਾਂ ਰਿਕਾਰਡ!';

  @override
  String gameStreakDays(int streak) {
    return 'ਲਗਾਤਾਰ $streak ਦਿਨ';
  }

  @override
  String get gameDoubleCoins => 'ਸਿੱਕੇ ਦੁੱਗਣੇ ਕਰੋ';

  @override
  String get gameDoubleDaily => 'ਰੋਜ਼ਾਨਾ ਇਨਾਮ ਦੁੱਗਣਾ ਕਰੋ';

  @override
  String get gamePlayAgain => 'ਦੁਬਾਰਾ ਖੇਡੋ';

  @override
  String gameLevelReached(int level) {
    return 'ਲੈਵਲ $level ਉੱਤੇ ਪਹੁੰਚੇ!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count ਲੈਵਲ — ਲੈਵਲ $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 ਸਿੱਕੇ + ਲੱਕੜ ਥੀਮ';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'ਸਿਰਫ਼ $hours ਘੰਟੇ ਬਾਕੀ — ਸਿਰਫ਼ ਇੱਕ ਵਾਰ!';
  }

  @override
  String get boosterUndo => 'ਵਾਪਸ';

  @override
  String get boosterSwap => 'ਬਦਲੋ';

  @override
  String get boosterBomb => 'ਬੰਬ';

  @override
  String get boosterNoRotationsLeft =>
      'ਘੁਮਾਉਣ ਦੇ ਮੌਕੇ ਖਤਮ — ਨਵੇਂ ਲੈਣ ਲਈ ਲਾਈਨਾਂ ਸਾਫ਼ ਕਰੋ!';

  @override
  String get onboardingDragPiece => 'ਇੱਕ ਬਲਾਕ ਨੂੰ ਗਰਿੱਡ ਉੱਤੇ ਖਿੱਚੋ';

  @override
  String get onboardingFillLine => 'ਪੂਰੀ ਕਤਾਰ ਜਾਂ ਕਾਲਮ ਭਰੋ';

  @override
  String get onboardingLinesClear => 'ਭਰੀਆਂ ਲਾਈਨਾਂ ਸਾਫ਼ ਹੋ ਜਾਂਦੀਆਂ ਹਨ — ਅੰਕ!';

  @override
  String get coachHintCombo =>
      'ਕੰਬੋ! ਇਸਨੂੰ ਬਣਾਈ ਰੱਖਣ ਲਈ 3 ਚਾਲਾਂ ਦੇ ਅੰਦਰ ਫਿਰ ਸਾਫ਼ ਕਰੋ';

  @override
  String get coachHintFever => 'ਫੀਵਰ! ਜਦੋਂ ਤੱਕ ਚਮਕ ਰਹੀ ਹੈ, ਦੁੱਗਣੇ ਅੰਕ';

  @override
  String get coachHintRotation =>
      'ਘੁਮਾਉਣ ਉੱਤੇ ਇੱਕ ਚਾਰਜ ਲੱਗਦਾ ਹੈ — ਸਾਫ਼ ਕਰਨ ਨਾਲ ਇਹ ਮੁੜ ਭਰਦਾ ਹੈ';

  @override
  String get coachHintBooster => 'ਸੁਝਾਅ: ਹੇਠਾਂ ਬੂਸਟਰ ਵਰਤੇ ਜਾ ਸਕਦੇ ਹਨ';

  @override
  String get coachHintStrategy =>
      'ਸੁਝਾਅ: ਸਾਰੀਆਂ ਲਾਈਨਾਂ ਇੱਕੋ ਵਾਰ ਨਹੀਂ — ਵੱਡੇ ਟੁਕੜਿਆਂ ਲਈ ਥਾਂ ਛੱਡੋ';

  @override
  String get dailyStreakLabel => 'ਲੜੀ';

  @override
  String get dailyBestLabel => 'ਰੋਜ਼ਾਨਾ ਸਭ ਤੋਂ ਵਧੀਆ';

  @override
  String dailyHistoryNote(int days) {
    return 'ਪਿਛਲੇ $days ਦਿਨ ਸੰਭਾਲੇ ਜਾਂਦੇ ਹਨ।';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'ਦਿਨ $day: ਖੇਡਿਆ';
  }

  @override
  String dailyDayMissed(int day) {
    return 'ਦਿਨ $day: ਨਹੀਂ ਖੇਡਿਆ';
  }

  @override
  String get homeDailyCalendar => 'ਕੈਲੰਡਰ';

  @override
  String get dailyShareButton => 'ਨਤੀਜਾ ਸਾਂਝਾ ਕਰੋ';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · ਰੋਜ਼ਾਨਾ ਚੁਣੌਤੀ $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'ਅੰਕ: $score · ਸਭ ਤੋਂ ਵਧੀਆ ਕੰਬੋ x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'ਖੇਡੋ: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'ਕੰਬੋ: $moves ਚਾਲਾਂ ਬਾਕੀ',
      one: 'ਕੰਬੋ: $moves ਚਾਲ ਬਾਕੀ',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'ਨਤੀਜਾ ਕਲਿੱਪਬੋਰਡ ਵਿੱਚ ਕਾਪੀ ਹੋ ਗਿਆ';

  @override
  String get adNotAvailable =>
      'ਇਸ ਵੇਲੇ ਕੋਈ ਵੀਡੀਓ ਨਹੀਂ — ਥੋੜ੍ਹੀ ਦੇਰ ਬਾਅਦ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get howToPlaySpeedTitle => 'ਤੇਜ਼ੀ ਬੋਨਸ';

  @override
  String get howToPlaySpeedBody =>
      'ਤੇਜ਼ੀ ਨਾਲ ਰੱਖਣ ਉੱਤੇ ਹਰ ਸਫ਼ਾਈ ਵਿੱਚ 30 % ਤੱਕ ਵਾਧਾ ਹੁੰਦਾ ਹੈ। ਬੋਨਸ 1.5 ਤੋਂ 4 ਸਕਿੰਟਾਂ ਦੇ ਵਿਚਕਾਰ ਘਟਦਾ ਜਾਂਦਾ ਹੈ ਅਤੇ ਇਸਦੀ ਹੱਦ ਵੀ ਹੈ, ਇਸ ਲਈ ਤੇਜ਼ੀ ਫ਼ਾਇਦਾ ਦਿੰਦੀ ਹੈ ਪਰ ਖੇਡ ਦਾ ਫ਼ੈਸਲਾ ਨਹੀਂ ਕਰਦੀ — ਸੋਚ-ਸਮਝ ਕੇ ਹੌਲੀ ਖੇਡੀ ਖੇਡ ਅਜੇ ਵੀ ਕਾਹਲੀ ਵਾਲੀ ਤੇਜ਼ ਖੇਡ ਨੂੰ ਹਰਾ ਸਕਦੀ ਹੈ।';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'ਤੇਜ਼ੀ ਬੋਨਸ $percent ਪ੍ਰਤੀਸ਼ਤ';
  }

  @override
  String get iapDiamondsSmall => '100 ਹੀਰੇ';

  @override
  String get iapDiamondsMedium => '350 ਹੀਰੇ';

  @override
  String get iapDiamondsLarge => '1,000 ਹੀਰੇ';

  @override
  String get howToPlayTitle => 'Qubble ਕਿਵੇਂ ਖੇਡੀਏ';

  @override
  String get howToPlayIntroHeadline =>
      'ਸ਼ੁਰੂ ਕਰਨਾ ਆਸਾਨ।\nਅੱਗੇ ਦੀ ਸੋਚੋ, ਜ਼ਿਆਦਾ ਪਾਓ।';

  @override
  String get howToPlayIntroBody => 'ਬੋਰਡ ਨੂੰ ਖਾਲੀ ਰੱਖੋ ਅਤੇ ਆਪਣਾ ਰਿਕਾਰਡ ਤੋੜੋ।';

  @override
  String get howToPlayIntroSemantics =>
      'ਖੇਡ ਦਾ ਟੀਚਾ। ਬੋਰਡ ਨੂੰ ਖਾਲੀ ਰੱਖੋ ਅਤੇ ਆਪਣਾ ਰਿਕਾਰਡ ਤੋੜੋ।';

  @override
  String get howToPlayDragTitle => 'ਖਿੱਚੋ ਅਤੇ ਰੱਖੋ';

  @override
  String get howToPlayDragBody =>
      'ਤਿੰਨ ਟੁਕੜਿਆਂ ਵਿੱਚੋਂ ਇੱਕ ਨੂੰ ਖਾਲੀ ਖਾਨਿਆਂ ਉੱਤੇ ਖਿੱਚੋ। ਤਿੰਨੇ ਵਰਤਣ ਤੋਂ ਬਾਅਦ, ਆਪਣੇ-ਆਪ ਤਿੰਨ ਨਵੇਂ ਮਿਲ ਜਾਂਦੇ ਹਨ।';

  @override
  String get howToPlayClearTitle => 'ਲਾਈਨਾਂ ਸਾਫ਼ ਕਰੋ';

  @override
  String get howToPlayClearBody =>
      'ਪੂਰੀ ਕਤਾਰ ਜਾਂ ਕਾਲਮ ਭਰੋ। ਭਰੀਆਂ ਲਾਈਨਾਂ ਗਾਇਬ ਹੋ ਜਾਂਦੀਆਂ ਹਨ ਅਤੇ ਅਗਲੀ ਚਾਲ ਲਈ ਥਾਂ ਬਣਾਉਂਦੀਆਂ ਹਨ।';

  @override
  String get howToPlayComboTitle => 'ਕੰਬੋ ਜੋੜੋ';

  @override
  String get howToPlayComboBody =>
      'ਤਿੰਨ ਚਾਲਾਂ ਦੇ ਅੰਦਰ ਇੱਕ ਹੋਰ ਲਾਈਨ ਸਾਫ਼ ਕਰੋ। ਹਰ ਵਾਧੂ ਕੰਬੋ ਤੁਹਾਡਾ ਅੰਕ ਗੁਣਕ ਵਧਾਉਂਦਾ ਹੈ। ਕੰਬੋ ਸਕਿੰਟ ਨਹੀਂ, ਚਾਲਾਂ ਗਿਣਦਾ ਹੈ, ਇਸ ਲਈ ਸੋਚਦੇ ਸਮੇਂ ਇਹ ਖਤਮ ਨਹੀਂ ਹੁੰਦਾ।';

  @override
  String get howToPlayFeverTitle => 'ਫੀਵਰ ਜਗਾਓ';

  @override
  String get howToPlayFeverBody =>
      'ਸਫ਼ਾਈਆਂ ਫੀਵਰ ਮੀਟਰ ਭਰਦੀਆਂ ਹਨ। ਇਹ ਭਰ ਜਾਣ ਉੱਤੇ, ਅਗਲਾ ਧਮਾਕਾ ਦੁੱਗਣਾ ਗਿਣਿਆ ਜਾਂਦਾ ਹੈ — ਵੱਡੀਆਂ ਸਫ਼ਾਈਆਂ ਪਹਿਲਾਂ ਤੋਂ ਸੋਚੋ।';

  @override
  String get howToPlayBoosterTitle => 'ਬੂਸਟਰ ਸਮਝਦਾਰੀ ਨਾਲ ਵਰਤੋ';

  @override
  String get howToPlayBoosterBody =>
      'ਬੂਸਟਰ ਮੁਸ਼ਕਲ ਖੇਡਾਂ ਨੂੰ ਬਚਾਉਂਦੇ ਹਨ। ਹੇਠਾਂ ਵਾਲੇ ਟੁਕੜੇ ਉੱਤੇ ਟੈਪ ਕਰਕੇ ਉਸਨੂੰ ਘੁਮਾਇਆ ਵੀ ਜਾ ਸਕਦਾ ਹੈ।';

  @override
  String get howToPlayDailyTitle => 'ਰੋਜ਼ਾਨਾ ਚੁਣੌਤੀ ਅਤੇ ਲੜੀ';

  @override
  String get howToPlayDailyBody =>
      'ਰੋਜ਼ਾਨਾ ਚੁਣੌਤੀ ਵਿੱਚ ਸਾਰਿਆਂ ਨੂੰ ਇੱਕੋ ਜਿਹੇ ਟੁਕੜੇ ਮਿਲਦੇ ਹਨ। ਆਪਣੀ ਲੜੀ ਅਤੇ ਬੋਨਸ ਵਧਾਉਣ ਲਈ ਹਰ ਰੋਜ਼ ਖੇਡੋ।';

  @override
  String get howToPlayPiggyTitle => 'ਗੋਲਕ ਭਰੋ';

  @override
  String get howToPlayPiggyBody =>
      'ਹਰ ਸਾਫ਼ ਕੀਤੀ ਲਾਈਨ ਤੁਹਾਡੀ ਗੋਲਕ ਭਰਦੀ ਹੈ। ਭਰ ਜਾਣ ਉੱਤੇ, ਸਿੱਕੇ ਮੁਫ਼ਤ ਵਿੱਚ ਲਓ।';

  @override
  String get leaderboardTitle => 'ਲੀਡਰਬੋਰਡ';

  @override
  String get leaderboardUnreachable =>
      'ਲੀਡਰਬੋਰਡ ਉਪਲਬਧ ਨਹੀਂ।\nਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਨਾਲ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get leaderboardEmpty => 'ਅਜੇ ਕੋਈ ਐਂਟਰੀ ਨਹੀਂ।\nਪਹਿਲੇ ਬਣੋ!';

  @override
  String leaderboardSubmitting(int score) {
    return 'ਤੁਹਾਡਾ ਸਭ ਤੋਂ ਵਧੀਆ ਸਕੋਰ ($score) ਭੇਜਿਆ ਜਾ ਰਿਹਾ ਹੈ …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'ਤੁਹਾਡਾ ਸਭ ਤੋਂ ਵਧੀਆ ਸਕੋਰ ਆਪਣੇ-ਆਪ ਭੇਜਿਆ ਜਾਵੇਗਾ।';

  @override
  String get puzzleModeTitle => 'ਪਹੇਲੀ ਮੋਡ';

  @override
  String puzzleLevelTitle(int level) {
    return 'ਪਹੇਲੀ $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'ਚਾਲਾਂ: $moves   •   ਟੀਚਾ: 3 ਤਾਰਿਆਂ ਲਈ $target';
  }

  @override
  String get puzzleSolved => 'ਹੱਲ ਹੋ ਗਈ!';

  @override
  String get puzzleLeaveTitle => 'ਪਹੇਲੀ ਛੱਡਣੀ ਹੈ?';

  @override
  String get puzzleLeaveBody => 'ਇਸ ਪਹੇਲੀ ਵਿੱਚ ਤੁਹਾਡੀ ਤਰੱਕੀ ਗੁੰਮ ਹੋ ਜਾਵੇਗੀ।';

  @override
  String get puzzleKeepPlaying => 'ਖੇਡਣਾ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get puzzleLeave => 'ਛੱਡੋ';

  @override
  String get puzzleStuckTitle => 'ਫਸ ਗਏ';

  @override
  String get puzzleRestart => 'ਦੁਬਾਰਾ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get commonActive => 'ਚਾਲੂ';

  @override
  String get commonRestore => 'ਮੁੜ-ਬਹਾਲ ਕਰੋ';

  @override
  String get skinsExchangeGold => 'ਸੋਨਾ ਬਦਲੋ';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'ਟੁਕੜਾ ਘੁਮਾਓ';

  @override
  String get puzzleNextLevel => 'ਅਗਲਾ ਲੈਵਲ';

  @override
  String get puzzleBackToOverview => 'ਸੂਚੀ ਉੱਤੇ ਵਾਪਸ';

  @override
  String get puzzleUnsolvable => 'ਇੱਥੋਂ ਬੋਰਡ ਹੁਣ ਖਾਲੀ ਨਹੀਂ ਹੋ ਸਕਦਾ।';

  @override
  String get puzzleExtraMoveVideo => 'ਵਾਧੂ ਚਾਲ (ਵੀਡੀਓ)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'ਹੱਲ ਹੋਈਆਂ: $solved';
  }

  @override
  String get settingsTitle => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get storageFailureTitle =>
      'Qubble ਤੁਹਾਡੀ ਸੇਵ ਕੀਤੀ ਖੇਡ ਲੋਡ ਨਹੀਂ ਕਰ ਸਕਦਾ';

  @override
  String get storageFailureBody =>
      'ਕਿਰਪਾ ਕਰਕੇ ਐਪ ਮੁੜ ਚਾਲੂ ਕਰੋ। ਜੇ ਗੜਬੜ ਬਣੀ ਰਹੇ, ਤਾਂ ਸਿਰਫ਼ ਦੁਬਾਰਾ ਇੰਸਟਾਲ ਕਰਨਾ ਹੀ ਹੱਲ ਹੈ। ਸੈਟਿੰਗਾਂ › ਫੀਡਬੈਕ ਰਾਹੀਂ ਇਸਦੀ ਜਾਣਕਾਰੀ ਦਿਓ।';

  @override
  String get iapUnavailable => 'ਇਹ ਪੇਸ਼ਕਸ਼ ਇਸ ਵੇਲੇ ਉਪਲਬਧ ਨਹੀਂ।';

  @override
  String get iapFailed => 'ਖਰੀਦ ਪੂਰੀ ਨਹੀਂ ਹੋਈ। ਕੋਈ ਪੈਸਾ ਨਹੀਂ ਕੱਟਿਆ ਗਿਆ।';

  @override
  String get settingsResetProgress => 'ਤਰੱਕੀ ਰੀਸੈੱਟ ਕਰੋ';

  @override
  String get settingsResetProgressSubtitle =>
      'ਸਕੋਰ, ਸਿੱਕੇ, ਲੈਵਲ ਅਤੇ ਤਰੱਕੀ ਸ਼ੁਰੂ ਤੋਂ। ਖਰੀਦਾਂ, ਨਾਮ ਅਤੇ ਸਜਾਵਟਾਂ ਬਣੀਆਂ ਰਹਿੰਦੀਆਂ ਹਨ।';

  @override
  String get settingsResetConfirmTitle => 'ਤਰੱਕੀ ਰੀਸੈੱਟ ਕਰਨੀ ਹੈ?';

  @override
  String get settingsResetConfirmBody =>
      'ਸਭ ਤੋਂ ਵਧੀਆ ਸਕੋਰ, ਸਿੱਕੇ, ਲੈਵਲ, ਲੜੀ ਅਤੇ ਸਾਰੀ ਤਰੱਕੀ ਮਿਟਾ ਦਿੱਤੀ ਜਾਵੇਗੀ। ਇਹ ਵਾਪਸ ਨਹੀਂ ਹੋ ਸਕਦਾ।\n\nਤੁਹਾਡੀਆਂ ਖਰੀਦਾਂ, ਨਾਮ ਅਤੇ ਅਨਲੌਕ ਕੀਤੇ ਥੀਮ ਤੇ ਸਕਿਨ ਬਣੇ ਰਹਿੰਦੇ ਹਨ।';

  @override
  String get settingsResetConfirmAction => 'ਰੀਸੈੱਟ';

  @override
  String get settingsResetDone => 'ਤਰੱਕੀ ਰੀਸੈੱਟ ਹੋ ਗਈ।';

  @override
  String get settingsSectionGame => 'ਖੇਡ';

  @override
  String get settingsSectionSoundHaptics => 'ਆਵਾਜ਼ ਅਤੇ ਥਰਥਰਾਹਟ';

  @override
  String get settingsSectionReminders => 'ਯਾਦ-ਦਹਾਨੀਆਂ';

  @override
  String get settingsSectionPurchases => 'ਖਰੀਦਾਂ';

  @override
  String get settingsSectionHelpOut => 'ਮਦਦ ਕਰੋ';

  @override
  String get settingsSectionLegal => 'ਕਾਨੂੰਨੀ';

  @override
  String get settingsSectionLanguage => 'ਭਾਸ਼ਾ';

  @override
  String get settingsGuide => 'ਕਿਵੇਂ ਖੇਡੀਏ';

  @override
  String get settingsGuideSubtitle => 'ਨਿਯਮ, ਕੰਬੋ, ਫੀਵਰ ਅਤੇ ਬੂਸਟਰ';

  @override
  String get settingsSound => 'ਆਵਾਜ਼';

  @override
  String get settingsMusic => 'ਸੰਗੀਤ';

  @override
  String get settingsHaptics => 'ਥਰਥਰਾਹਟ';

  @override
  String get settingsHapticsOff => 'ਬੰਦ';

  @override
  String get settingsHapticsLight => 'ਹਲਕੀ';

  @override
  String get settingsHapticsStrong => 'ਤੇਜ਼';

  @override
  String get settingsSectionAccessibility => 'ਪਹੁੰਚਯੋਗਤਾ';

  @override
  String get settingsReducedEffects => 'ਘੱਟ ਇਫੈਕਟ';

  @override
  String get settingsReducedEffectsHint =>
      'ਘੱਟ ਕਣ, ਸਕਰੀਨ ਹਿੱਲਦੀ ਨਹੀਂ, ਚਮਕ ਨਹੀਂ';

  @override
  String get settingsNotifications => 'ਸੂਚਨਾਵਾਂ';

  @override
  String get settingsNotificationsSubtitle =>
      'ਰੋਜ਼ਾਨਾ ਯਾਦ-ਦਹਾਨੀ ਅਤੇ ਲੜੀ ਦੀ ਰਾਖੀ';

  @override
  String get settingsNotificationsSystemHint =>
      'ਸਿਸਟਮ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਇਜਾਜ਼ਤ ਦਿਓ।';

  @override
  String get settingsLanguageSystem => 'ਸਿਸਟਮ ਭਾਸ਼ਾ';

  @override
  String get settingsSupporterThanks => 'ਸਹਿਯੋਗ ਲਈ ਧੰਨਵਾਦ!';

  @override
  String get settingsSupporterPack => 'ਸਮਰਥਕ ਪੈਕ';

  @override
  String get settingsSupporterPackSubtitle => 'ਖ਼ਾਸ ਥੀਮ ਅਤੇ ਸਕਿਨ + 1,500 ਸਿੱਕੇ';

  @override
  String get settingsRestorePurchases => 'ਖਰੀਦਾਂ ਮੁੜ-ਬਹਾਲ ਕਰੋ';

  @override
  String get settingsRestoring => 'ਖਰੀਦਾਂ ਮੁੜ-ਬਹਾਲ ਹੋ ਰਹੀਆਂ ਹਨ…';

  @override
  String get settingsRateApp => 'ਐਪ ਨੂੰ ਰੇਟ ਕਰੋ';

  @override
  String get settingsRateAppSubtitle => 'ਸਟੋਰ ਵਿੱਚ ਰੇਟਿੰਗ ਦਿਓ';

  @override
  String get settingsStoreUnavailable => 'ਇਸ ਡਿਵਾਈਸ ਉੱਤੇ ਸਟੋਰ ਉਪਲਬਧ ਨਹੀਂ।';

  @override
  String get settingsFeedback => 'ਫੀਡਬੈਕ ਭੇਜੋ';

  @override
  String get settingsFeedbackSubtitle => 'ਸੁਝਾਅ ਅਤੇ ਗੜਬੜਾਂ ਦੱਸੋ (GitHub ਰਾਹੀਂ)';

  @override
  String get settingsAdPrivacy => 'ਇਸ਼ਤਿਹਾਰ ਪਰਦੇਦਾਰੀ';

  @override
  String get settingsAdPrivacySubtitle =>
      'ਇਸ਼ਤਿਹਾਰਾਂ ਲਈ ਆਪਣੀ ਸਹਿਮਤੀ ਦੇਖੋ ਜਾਂ ਬਦਲੋ';

  @override
  String get settingsAdPrivacyUnavailable =>
      'ਇਸ ਡਿਵਾਈਸ ਉੱਤੇ ਇਸ਼ਤਿਹਾਰ ਵਿਕਲਪਾਂ ਦੀ ਲੋੜ ਨਹੀਂ।';

  @override
  String get settingsPrivacy => 'ਪਰਦੇਦਾਰੀ ਨੀਤੀ';

  @override
  String get settingsImprint => 'ਕਾਨੂੰਨੀ ਜਾਣਕਾਰੀ';

  @override
  String get settingsPageOpenFailed => 'ਪੰਨਾ ਨਹੀਂ ਖੁੱਲ੍ਹ ਸਕਿਆ।';

  @override
  String get settingsFooter => 'Qubble • ਆਫ਼ਲਾਈਨ ਬਲਾਕ ਪਹੇਲੀ';

  @override
  String get settingsAdminSection => 'ਐਡਮਿਨ (ਟੈਸਟ)';

  @override
  String get settingsAdminEnabled => 'ਐਡਮਿਨ ਮੋਡ ਚਾਲੂ';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'ਐਡਮਿਨ ਮੋਡ ਲਈ $count ਵਾਰ ਹੋਰ ਟੈਪ ਕਰੋ';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins ਸਿੱਕੇ',
      one: '$coins ਸਿੱਕਾ',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'ਸਿਰਫ਼ ਟੈਸਟਿੰਗ ਲਈ — ਰਿਲੀਜ਼ ਸਕਰੀਨਸ਼ਾਟਾਂ ਵਿੱਚ ਕਦੇ ਨਹੀਂ';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount ਸਿੱਕੇ',
      one: '$amount ਸਿੱਕਾ',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'ਸਿੱਕੇ 0 ਕਰੋ';

  @override
  String get feedbackTitle => 'ਫੀਡਬੈਕ';

  @override
  String get feedbackIntroShort =>
      'ਤੁਹਾਨੂੰ ਕੀ ਪਸੰਦ ਹੈ, ਕੀ ਖਿਝਾਉਂਦਾ ਹੈ, ਕੀ ਕਮੀ ਹੈ? ਛੋਟੀਆਂ ਗੱਲਾਂ ਵੀ ਮਦਦ ਕਰਦੀਆਂ ਹਨ — ਜਿੰਨਾ ਸਪਸ਼ਟ, ਓਨਾ ਵਧੀਆ।';

  @override
  String feedbackAttachmentNote(String build) {
    return 'ਸਿਰਫ਼ $build ਅਤੇ ਤੁਹਾਡੇ ਡਿਵਾਈਸ ਦੀ ਕਿਸਮ ਜੋੜੀ ਜਾਂਦੀ ਹੈ — ਤਾਂ ਜੋ ਮੈਨੂੰ ਪਤਾ ਲੱਗੇ ਕਿ ਗੱਲ ਕਿਹੜੇ ਵਰਜਨ ਦੀ ਹੈ।';
  }

  @override
  String get feedbackSendByMail => 'ਈਮੇਲ ਰਾਹੀਂ ਭੇਜੋ';

  @override
  String get feedbackPreferGithub => 'GitHub issue ਪਸੰਦ ਹੈ';

  @override
  String get feedbackThanksMail => 'ਧੰਨਵਾਦ! ਬੱਸ ਸੁਨੇਹਾ ਭੇਜ ਦਿਓ।';

  @override
  String get feedbackNoMailApp =>
      'ਕੋਈ ਮੇਲ ਐਪ ਨਹੀਂ ਮਿਲੀ। ਹੇਠਾਂ GitHub ਰਾਹੀਂ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get feedbackEmptyHint => 'ਕਿਰਪਾ ਕਰਕੇ ਪਹਿਲਾਂ ਕੁਝ ਲਿਖੋ।';

  @override
  String get leaderboardRefresh => 'ਤਾਜ਼ਾ ਕਰੋ';

  @override
  String get leaderboardRetry => 'ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get feedbackHint => 'ਤੁਹਾਡਾ ਫੀਡਬੈਕ…';

  @override
  String get feedbackSubmit => 'ਫੀਡਬੈਕ ਭੇਜੋ';

  @override
  String get feedbackOpenFailed =>
      'GitHub ਨਹੀਂ ਖੁੱਲ੍ਹ ਸਕਿਆ। ਬਾਅਦ ਵਿੱਚ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get feedbackGithubNote =>
      'GitHub ਖੁੱਲ੍ਹੇਗਾ — ਉੱਥੇ \"Submit new issue\" ਉੱਤੇ ਟੈਪ ਕਰੋ। (ਇੱਕ ਵਾਰ GitHub ਲੌਗਇਨ ਦੀ ਲੋੜ ਹੈ।)';

  @override
  String get shopTitle => 'ਦੁਕਾਨ';

  @override
  String get shopWebDemoNote =>
      'ਖਰੀਦਾਂ ਸਿਰਫ਼ Play Store ਐਪ ਵਿੱਚ ਉਪਲਬਧ ਹਨ। ਇਹ ਵੈੱਬ ਵਰਜਨ ਇੱਕ ਮੁਫ਼ਤ ਡੈਮੋ ਹੈ — ਫਿਰ ਵੀ ਇੱਥੇ ਸਭ ਕੁਝ ਖੇਡਿਆ ਜਾ ਸਕਦਾ ਹੈ।';

  @override
  String get shopSupporterExplainer =>
      'Qubble ਜ਼ਬਰਦਸਤੀ ਇਸ਼ਤਿਹਾਰ ਨਹੀਂ ਦਿਖਾਉਂਦਾ — ਕੁਝ ਵੀ ਖਰੀਦਣਾ ਜ਼ਰੂਰੀ ਨਹੀਂ। ਸਮਰਥਕ ਪੈਕ (ਔਰੋਰਾ ਥੀਮ, ਕ੍ਰਿਸਟਲ ਸਕਿਨ, 1,500 ਸਿੱਕੇ, ਸਮਰਥਕ ਬੈਜ) ਖੇਡ ਦਾ ਸਾਥ ਦੇਣ ਲਈ ਇੱਕ ਧੰਨਵਾਦ ਹੈ। ਖਰੀਦਾਂ ਤੁਹਾਡੇ ਸਟੋਰ ਖਾਤੇ ਨਾਲ ਜੁੜੀਆਂ ਹਨ ਅਤੇ ਕਦੇ ਵੀ ਮੁੜ-ਬਹਾਲ ਕੀਤੀਆਂ ਜਾ ਸਕਦੀਆਂ ਹਨ।';

  @override
  String get shopSupporterContents => 'ਔਰੋਰਾ ਥੀਮ + ਕ੍ਰਿਸਟਲ ਸਕਿਨ + 1,500 ਸਿੱਕੇ';

  @override
  String get themesTitle => 'ਥੀਮ';

  @override
  String get themesSupporterOnly => 'ਸਿਰਫ਼ ਸਮਰਥਕ ਪੈਕ ਵਿੱਚ (ਦੁਕਾਨ ਦੇਖੋ)';

  @override
  String get skinsTitle => 'ਬਲਾਕ ਸਕਿਨ';

  @override
  String get skinsNotEnoughCoins => 'ਕਾਫ਼ੀ ਸਿੱਕੇ ਨਹੀਂ';

  @override
  String get skinsNotEnoughGold => 'ਕਾਫ਼ੀ ਸੋਨਾ ਨਹੀਂ।';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold ਸੋਨਾ = 1 ਹੀਰਾ। ਹੀਰਿਆਂ ਨਾਲ ਸਭ ਤੋਂ ਸੁੰਦਰ ਸਕਿਨ ਅਨਲੌਕ ਹੁੰਦੀਆਂ ਹਨ — ਹੌਲੀ-ਹੌਲੀ ਇਕੱਠੇ ਕਰੋ।';
  }

  @override
  String get statsTitle => 'ਅੰਕੜੇ';

  @override
  String get statsAverageScore => 'ਔਸਤ ਸਕੋਰ';

  @override
  String get statsBestCombo => 'ਸਭ ਤੋਂ ਵਧੀਆ ਕੰਬੋ';

  @override
  String get statsGames => 'ਖੇਡਾਂ';

  @override
  String get statsLinesCleared => 'ਸਾਫ਼ ਕੀਤੀਆਂ ਲਾਈਨਾਂ';

  @override
  String get statsPiecesPlaced => 'ਰੱਖੇ ਟੁਕੜੇ';

  @override
  String get statsCoins => 'ਸਿੱਕੇ';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString ਕੰਬੋ ਬਣਾਓ';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ਇੱਕ ਖੇਡ ਵਿੱਚ $countString ਅੰਕ ਪਾਰ ਕਰੋ',
      one: 'ਇੱਕ ਖੇਡ ਵਿੱਚ $countString ਅੰਕ ਪਾਰ ਕਰੋ',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'ਪ੍ਰਾਪਤੀਆਂ';

  @override
  String get achievementFirstGameTitle => 'ਪਹਿਲੀ ਖੇਡ';

  @override
  String get achievementFirstGameBody => 'ਆਪਣੀ ਪਹਿਲੀ ਖੇਡ ਖੇਡੋ';

  @override
  String get achievementGames25Title => 'ਨਿਯਮਤ ਖਿਡਾਰੀ';

  @override
  String get achievementGames25Body => '25 ਖੇਡਾਂ ਖੇਡੋ';

  @override
  String get achievementGames100Title => 'ਸ਼ੌਕੀਨ';

  @override
  String get achievementGames100Body => '100 ਖੇਡਾਂ ਖੇਡੋ';

  @override
  String get achievementScore1kTitle => 'ਚੜ੍ਹਾਈ';

  @override
  String get achievementScore1kBody => '1,000 ਅੰਕ ਬਣਾਓ';

  @override
  String get achievementScore5kTitle => 'ਪ੍ਰੋ';

  @override
  String get achievementScore5kBody => '5,000 ਅੰਕ ਬਣਾਓ';

  @override
  String get achievementScore10kTitle => 'ਮਾਸਟਰ';

  @override
  String get achievementScore10kBody => '10,000 ਅੰਕ ਬਣਾਓ';

  @override
  String get achievementScore25kTitle => 'ਦੰਤਕਥਾ';

  @override
  String get achievementScore25kBody => '25,000 ਅੰਕ ਬਣਾਓ';

  @override
  String get achievementLines100Title => 'ਸਲੀਕੇਦਾਰ';

  @override
  String get achievementLines100Body => 'ਕੁੱਲ 100 ਲਾਈਨਾਂ ਸਾਫ਼ ਕਰੋ';

  @override
  String get achievementLines1000Title => 'ਵੱਡੀ ਸਫ਼ਾਈ';

  @override
  String get achievementLines1000Body => 'ਕੁੱਲ 1,000 ਲਾਈਨਾਂ ਸਾਫ਼ ਕਰੋ';

  @override
  String get achievementCombo5Title => 'ਕੰਬੋ ਦੀ ਸ਼ੁਰੂਆਤ';

  @override
  String get achievementCombo5Body => 'x5 ਕੰਬੋ ਬਣਾਓ';

  @override
  String get achievementCombo10Title => 'ਕੰਬੋ ਸਮਰਾਟ';

  @override
  String get achievementCombo10Body => 'x10 ਕੰਬੋ ਬਣਾਓ';

  @override
  String get achievementLevel10Title => 'ਤਜਰਬੇਕਾਰ';

  @override
  String get achievementLevel10Body => 'ਲੈਵਲ 10 ਉੱਤੇ ਪਹੁੰਚੋ';

  @override
  String get achievementLevel20Title => 'ਪੁਰਾਣੇ ਖਿਡਾਰੀ';

  @override
  String get achievementLevel20Body => 'ਲੈਵਲ 20 ਉੱਤੇ ਪਹੁੰਚੋ';

  @override
  String get achievementStreak7Title => 'ਹਫ਼ਤੇ ਦੀ ਲੜੀ';

  @override
  String get achievementStreak7Body => '7 ਦਿਨਾਂ ਦੀ ਰੋਜ਼ਾਨਾ ਲੜੀ';

  @override
  String get achievementStreak30Title => 'ਮਹੀਨੇ ਦੀ ਲੜੀ';

  @override
  String get achievementStreak30Body => '30 ਦਿਨਾਂ ਦੀ ਰੋਜ਼ਾਨਾ ਲੜੀ';

  @override
  String get achievementPuzzles10Title => 'ਪਹੇਲੀ ਮਾਹਰ';

  @override
  String get achievementPuzzles10Body => '10 ਪਹੇਲੀਆਂ ਹੱਲ ਕਰੋ';

  @override
  String get achievementPieces5000Title => 'ਨਿਰਮਾਤਾ';

  @override
  String get achievementPieces5000Body => '5,000 ਟੁਕੜੇ ਰੱਖੋ';

  @override
  String streakRepairTitle(int streak) {
    return '$streak ਦਿਨਾਂ ਦੀ ਲੜੀ ਖ਼ਤਰੇ ਵਿੱਚ!';
  }

  @override
  String get streakRepairBody => 'ਕੱਲ੍ਹ ਨਹੀਂ ਖੇਡਿਆ — ਆਪਣੀ ਲੜੀ ਬਚਾਓ:';

  @override
  String get streakRepairFailed => 'ਠੀਕ ਨਹੀਂ ਹੋ ਸਕੀ।';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins ਸਿੱਕੇ',
      one: '$coins ਸਿੱਕਾ',
    );
    return 'ਮੁੜ ਜੀ ਆਇਆਂ ਨੂੰ! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'ਯਾਦ-ਦਹਾਨੀਆਂ?';

  @override
  String get notificationsOptInBody =>
      'ਕੀ ਅਸੀਂ ਤੁਹਾਨੂੰ ਰੋਜ਼ਾਨਾ ਪਹੇਲੀ ਯਾਦ ਕਰਵਾਈਏ ਅਤੇ ਤੁਹਾਡੀ ਲੜੀ ਦੀ ਰਾਖੀ ਕਰੀਏ? ਇਹ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਕਦੇ ਵੀ ਬਦਲਿਆ ਜਾ ਸਕਦਾ ਹੈ।';

  @override
  String get notificationsOptInAccept => 'ਹਾਂ, ਜ਼ਰੂਰ';

  @override
  String get notificationChannelDescription =>
      'ਰੋਜ਼ਾਨਾ ਯਾਦ-ਦਹਾਨੀ, ਲੜੀ ਦੀ ਚੇਤਾਵਨੀ, ਵਾਪਸੀ';

  @override
  String get notificationDailyTitle => 'ਤੁਹਾਡੀ ਰੋਜ਼ਾਨਾ ਪਹੇਲੀ ਉਡੀਕ ਰਹੀ ਹੈ 🧩';

  @override
  String get notificationDailyBody => 'ਅੱਜ ਦੀ ਚੁਣੌਤੀ ਖੇਡੋ!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 ਤੁਹਾਡੀ $streak ਦਿਨਾਂ ਦੀ ਲੜੀ ਖ਼ਤਰੇ ਵਿੱਚ!';
  }

  @override
  String get notificationStreakBody => 'ਇਸਨੂੰ ਬਣਾਈ ਰੱਖਣ ਲਈ ਅੱਜ ਖੇਡੋ।';

  @override
  String get notificationComebackTitle => 'ਤੁਹਾਡੇ ਬਲਾਕ ਉਡੀਕ ਰਹੇ ਹਨ 🧩';

  @override
  String get notificationComebackBody => 'ਵਾਪਸ ਆਓ ਅਤੇ ਇਨਾਮ ਲਓ!';

  @override
  String get iapSupporterPack => 'ਸਮਰਥਕ ਪੈਕ';

  @override
  String get iapCoinsSmall => '500 ਸਿੱਕੇ';

  @override
  String get iapCoinsMedium => '2,000 ਸਿੱਕੇ';

  @override
  String get iapCoinsLarge => '6,000 ਸਿੱਕੇ';

  @override
  String get iapStarterPack => 'ਸਟਾਰਟਰ ਪੈਕ';

  @override
  String get iapRename => 'ਨਾਮ ਬਦਲਣਾ';

  @override
  String get iapNeonTheme => 'ਨਿਓਨ ਥੀਮ';

  @override
  String get settingsLeaderboardDelete => 'ਲੀਡਰਬੋਰਡ ਐਂਟਰੀ ਮਿਟਾਓ';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'ਤੁਹਾਡਾ ਨਾਮ ਅਤੇ ਸਕੋਰ ਜਨਤਕ ਸੂਚੀ ਤੋਂ ਹਟਾ ਦਿੱਤੇ ਜਾਣਗੇ';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'ਆਪਣੀ ਐਂਟਰੀ ਮਿਟਾਉਣੀ ਹੈ?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'ਤੁਹਾਡਾ ਨਾਮ ਅਤੇ ਸਕੋਰ ਲੀਡਰਬੋਰਡ ਤੋਂ ਹਟਾ ਦਿੱਤੇ ਜਾਣਗੇ। ਖੇਡ ਵਿੱਚ ਤੁਹਾਡੀ ਤਰੱਕੀ ਨਹੀਂ ਬਦਲਦੀ। ਲੀਡਰਬੋਰਡ ਵਿੱਚ ਕਦੇ ਵੀ ਦੁਬਾਰਾ ਸ਼ਾਮਲ ਹੋਇਆ ਜਾ ਸਕਦਾ ਹੈ।';

  @override
  String get settingsLeaderboardDeleteDone =>
      'ਤੁਹਾਡੀ ਲੀਡਰਬੋਰਡ ਐਂਟਰੀ ਮਿਟਾ ਦਿੱਤੀ ਗਈ।';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'ਐਂਟਰੀ ਨਹੀਂ ਮਿਟ ਸਕੀ। ਕਨੈਕਸ਼ਨ ਜਾਂਚੋ ਅਤੇ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get leaderboardReport => 'ਇਸ ਨਾਮ ਦੀ ਸ਼ਿਕਾਇਤ ਕਰੋ';

  @override
  String get leaderboardBlock => 'ਲੁਕਾਓ';

  @override
  String leaderboardBlocked(String name) {
    return '$name ਤੁਹਾਡੇ ਲਈ ਲੁਕਾਇਆ ਗਿਆ';
  }

  @override
  String get leaderboardUndo => 'ਵਾਪਸ ਲਓ';

  @override
  String leaderboardBlockedCount(int count) {
    return 'ਤੁਹਾਡੀਆਂ ਲੁਕਾਈਆਂ ਐਂਟਰੀਆਂ: $count';
  }

  @override
  String get leaderboardUnblockAll => 'ਫਿਰ ਦਿਖਾਓ';

  @override
  String get leaderboardReportUnavailable =>
      'ਇਸ ਵੇਲੇ ਸ਼ਿਕਾਇਤ ਨਹੀਂ ਕੀਤੀ ਜਾ ਸਕਦੀ।';

  @override
  String get leaderboardReportSent => 'ਧੰਨਵਾਦ — ਤੁਹਾਡੀ ਸ਼ਿਕਾਇਤ ਭੇਜ ਦਿੱਤੀ ਗਈ।';

  @override
  String get leaderboardRules =>
      'ਨਾਮ ਜਨਤਕ ਹਨ। ਗਾਲ੍ਹਾਂ, ਅਪਮਾਨ ਜਾਂ ਕਿਸੇ ਅਸਲ ਵਿਅਕਤੀ ਦੀ ਪਛਾਣ ਕਰਾਉਣ ਵਾਲੀ ਕੋਈ ਚੀਜ਼ ਨਹੀਂ। ਇਸ ਨਿਯਮ ਨੂੰ ਤੋੜਨ ਵਾਲੇ ਨਾਮ ਹਟਾ ਦਿੱਤੇ ਜਾਂਦੇ ਹਨ।';

  @override
  String get leaderboardRulesAccept => 'ਠੀਕ ਹੈ';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'ਅਨਲੌਕ: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'ਸੇਵ ਕੀਤਾ ਡਾਟਾ';

  @override
  String get gameRotatePiece => 'ਟੁਕੜਾ ਘੁਮਾਓ';

  @override
  String get themeClassic => 'ਕਲਾਸਿਕ';

  @override
  String get themeFade => 'ਪੇਸਟਲ';

  @override
  String get themeNeon => 'ਨਿਓਨ';

  @override
  String get themeOcean => 'ਸਮੁੰਦਰ';

  @override
  String get themeWood => 'ਲੱਕੜ';

  @override
  String get themeSunset => 'ਢਲਦਾ ਸੂਰਜ';

  @override
  String get themeForest => 'ਜੰਗਲ';

  @override
  String get themeAurora => 'ਔਰੋਰਾ';

  @override
  String get skinClassic => 'ਕਲਾਸਿਕ';

  @override
  String get skinGradient => 'ਗ੍ਰੇਡੀਐਂਟ';

  @override
  String get skinOutline => 'ਰੂਪਰੇਖਾ';

  @override
  String get skinGlossy => 'ਚਮਕੀਲਾ';

  @override
  String get skinStripe => 'ਧਾਰੀਆਂ';

  @override
  String get skinBevel => 'ਢਲਾਣ';

  @override
  String get skinGlow => 'ਦਮਕ';

  @override
  String get skinCrystal => 'ਕ੍ਰਿਸਟਲ';

  @override
  String rewardThemeName(String name) {
    return '$name ਥੀਮ';
  }

  @override
  String rewardSkinName(String name) {
    return '$name ਸਕਿਨ';
  }

  @override
  String get skinPulse => 'ਧੜਕਣ';

  @override
  String get skinShimmer => 'ਝਿਲਮਿਲ';

  @override
  String get skinWave => 'ਲਹਿਰ';

  @override
  String get skinEmber => 'ਅੰਗਿਆਰ';

  @override
  String get skinPrism => 'ਪ੍ਰਿਜ਼ਮ';

  @override
  String get skinStardust => 'ਤਾਰਿਆਂ ਦੀ ਧੂੜ';

  @override
  String get skinCircuit => 'ਸਰਕਟ';

  @override
  String get skinRipple => 'ਤਰੰਗ';

  @override
  String achievementRewardSkin(String name) {
    return 'ਐਨੀਮੇਟਡ ਸਕਿਨ: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'ਪ੍ਰਾਪਤੀ ਦਾ ਇਨਾਮ: $achievement';
  }

  @override
  String get achievementBackpay =>
      'ਹੁਣ ਪ੍ਰਾਪਤੀਆਂ ਉੱਤੇ ਇਨਾਮ ਮਿਲਦੇ ਹਨ — ਤੁਹਾਡੇ ਇਨਾਮ ਜੋੜ ਦਿੱਤੇ ਗਏ ਹਨ।';

  @override
  String get namePromptBody =>
      'ਕੋਈ ਨਾਮ ਚੁਣੋ, ਫਿਰ ਤੁਹਾਡਾ ਸਭ ਤੋਂ ਵਧੀਆ ਸਕੋਰ ਲੀਡਰਬੋਰਡ ਉੱਤੇ ਆਵੇਗਾ। ਨਾਮ ਤੋਂ ਬਿਨਾਂ ਤੁਸੀਂ ਗੁਮਨਾਮ ਤੌਰ ’ਤੇ ਖੇਡਦੇ ਰਹੋਗੇ।';

  @override
  String get nameTaken => 'ਇਹ ਨਾਮ ਪਹਿਲਾਂ ਹੀ ਲਿਆ ਜਾ ਚੁੱਕਾ ਹੈ। ਕੋਈ ਹੋਰ ਅਜ਼ਮਾਓ।';

  @override
  String get nameCheckFailed =>
      'ਨਾਮ ਦੀ ਜਾਂਚ ਨਹੀਂ ਹੋ ਸਕੀ। ਕੀ ਤੁਸੀਂ ਆਨਲਾਈਨ ਹੋ? ਥੋੜ੍ਹੀ ਦੇਰ ਬਾਅਦ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String nameLost(String name) {
    return '$name ਹੁਣ ਕਿਸੇ ਹੋਰ ਖਿਡਾਰੀ ਦਾ ਹੈ। ਮੁਫ਼ਤ ਵਿੱਚ ਨਵਾਂ ਨਾਮ ਚੁਣੋ।';
  }

  @override
  String get themeCandy => 'ਕੈਂਡੀ';

  @override
  String get themeVolcano => 'ਜਵਾਲਾਮੁਖੀ';

  @override
  String get themeGlacier => 'ਗਲੇਸ਼ੀਅਰ';

  @override
  String get skinPixel => 'ਪਿਕਸਲ';

  @override
  String get skinMarble => 'ਸੰਗਮਰਮਰ';

  @override
  String get skinJelly => 'ਜੈਲੀ';

  @override
  String get skinLiquid => 'ਤਰਲ';

  @override
  String get skinFizz => 'ਬੁਲਬੁਲੇ';

  @override
  String get skinPlasma => 'ਪਲਾਜ਼ਮਾ';

  @override
  String get designsTitle => 'ਡਿਜ਼ਾਈਨ';

  @override
  String get designsNotEnoughDiamonds => 'ਕਾਫ਼ੀ ਹੀਰੇ ਨਹੀਂ।';

  @override
  String get designsOwned => 'ਤੁਹਾਡਾ';

  @override
  String get designsAchievementOnly => 'ਪ੍ਰਾਪਤੀ';

  @override
  String get designsSupporterOnly => 'ਸਮਰਥਕ';

  @override
  String get designsPreview => 'ਝਲਕ';

  @override
  String get designsGetDiamonds => 'ਹੀਰੇ ਲਓ';

  @override
  String get shopDealTitle => 'ਅੱਜ ਦੀ ਪੇਸ਼ਕਸ਼';

  @override
  String get shopAnimatedSkins => 'ਐਨੀਮੇਟਡ ਸਕਿਨ';

  @override
  String get shopNewDesigns => 'ਨਵੇਂ ਡਿਜ਼ਾਈਨ';

  @override
  String get shopDiamonds => 'ਹੀਰੇ';

  @override
  String get shopPacks => 'ਪੈਕ';

  @override
  String get shopPopular => 'ਮਸ਼ਹੂਰ';

  @override
  String get shopBestValue => 'ਸਭ ਤੋਂ ਵਧੀਆ ਮੁੱਲ';

  @override
  String get shopDiamondsBlurb => 'ਐਨੀਮੇਟਡ ਸਕਿਨ ਅਤੇ ਨਵੇਂ ਡਿਜ਼ਾਈਨ ਲਈ।';

  @override
  String get shopCoinsBlurb => 'ਥੀਮ, ਸਕਿਨ ਅਤੇ ਬੂਸਟਰ ਲਈ।';

  @override
  String get shopNeonBlurb => 'ਨਿਓਨ ਥੀਮ ਤੁਰੰਤ ਅਨਲੌਕ ਕਰਦਾ ਹੈ।';

  @override
  String get shopRenameBlurb => 'ਲੀਡਰਬੋਰਡ ਤੇ ਆਪਣਾ ਨਾਮ ਬਦਲੋ।';

  @override
  String shopHoursLeft(int hours) {
    return '$hours ਘੰਟੇ ਬਾਕੀ';
  }

  @override
  String shopNewDealIn(String time) {
    return 'ਨਵੀਂ ਪੇਸ਼ਕਸ਼ $time ਵਿੱਚ';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name ਅਨਲੌਕ ਹੋਇਆ!';
  }

  @override
  String get questsTitle => 'ਕੁਐਸਟ';

  @override
  String get questsDaily => 'ਰੋਜ਼ਾਨਾ';

  @override
  String get questsWeekly => 'ਹਫ਼ਤਾਵਾਰ';

  @override
  String get questsMonthly => 'ਮਹੀਨਾਵਾਰ';

  @override
  String questsNewIn(String time) {
    return 'ਨਵੇਂ ਕੁਐਸਟ $time ਵਿੱਚ';
  }

  @override
  String get questsBonus => 'ਸਭ ਲਈ ਬੋਨਸ';

  @override
  String get questsBonusEarned => 'ਬੋਨਸ ਮਿਲ ਗਿਆ';

  @override
  String get questRounds => 'ਰਾਊਂਡ ਖੇਡੋ';

  @override
  String get questLines => 'ਲਾਈਨਾਂ ਸਾਫ਼ ਕਰੋ';

  @override
  String get questPieces => 'ਟੁਕੜੇ ਰੱਖੋ';

  @override
  String get questDailyChallenge => 'ਰੋਜ਼ਾਨਾ ਚੁਣੌਤੀ ਖੇਡੋ';

  @override
  String get questPuzzles => 'ਨਵੀਆਂ ਪਹੇਲੀਆਂ ਹੱਲ ਕਰੋ';

  @override
  String get questDays => 'ਵੱਖ-ਵੱਖ ਦਿਨਾਂ ਤੇ ਖੇਡੋ';

  @override
  String get questDailySets => 'ਸਾਰੇ ਰੋਜ਼ਾਨਾ ਕੁਐਸਟ ਪੂਰੇ ਕਰੋ';

  @override
  String get questsSetDaily => 'ਸਾਰੇ ਰੋਜ਼ਾਨਾ ਕੁਐਸਟ ਪੂਰੇ!';

  @override
  String get questsSetWeekly => 'ਸਾਰੇ ਹਫ਼ਤਾਵਾਰ ਕੁਐਸਟ ਪੂਰੇ!';

  @override
  String get questsSetMonthly => 'ਸਾਰੇ ਮਹੀਨਾਵਾਰ ਕੁਐਸਟ ਪੂਰੇ!';
}
