// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class L10nTa extends L10n {
  L10nTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'விளையாடு';

  @override
  String get commonLater => 'பிறகு';

  @override
  String get commonNotNow => 'இப்போது வேண்டாம்';

  @override
  String get commonCancel => 'ரத்துசெய்';

  @override
  String get commonBuy => 'வாங்கு';

  @override
  String get commonSave => 'சேமி';

  @override
  String get commonCollect => 'பெறு';

  @override
  String get nameNewName => 'புதிய பெயர்';

  @override
  String get nameFieldLabel => 'பெயர்';

  @override
  String get piggyFullTitle => 'உண்டியல் நிரம்பிவிட்டது!';

  @override
  String get piggyKeepSaving => 'தொடர்ந்து சேமியுங்கள்';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity சேகரிக்கப்பட்டது.';
  }

  @override
  String get homeContinueRun => 'தொடர்';

  @override
  String get homeVideo => 'வீடியோ';

  @override
  String get commonGotIt => 'சரி';

  @override
  String get commonHome => 'முகப்பு';

  @override
  String get commonScore => 'புள்ளிகள்';

  @override
  String get commonBest => 'அதிகபட்சம்';

  @override
  String commonLevelShort(int level) {
    return 'நிலை $level';
  }

  @override
  String get homeNewRun => 'புதிய ஆட்டம் தொடங்கு';

  @override
  String get homeBackToExit => 'வெளியேற மீண்டும் பின் பொத்தானை அழுத்தவும்';

  @override
  String get homeEnableLeaderboard => 'தரவரிசையில் சேரவும்';

  @override
  String get homeBestScore => 'சிறந்த புள்ளிகள்';

  @override
  String get homeDailyChallenge => 'தினசரி சவால்';

  @override
  String get homeDailyOpenToday => 'இன்று திறந்துள்ளது';

  @override
  String homeDailyNextIn(String time) {
    return 'அடுத்த சவால்: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak நாள் தொடர்';
  }

  @override
  String get homeLeaderboard => 'தரவரிசை';

  @override
  String get homePuzzleMode => 'புதிர் பயன்முறை';

  @override
  String get homeMissions => 'பணிகள்';

  @override
  String get homeThemes => 'தீம்கள்';

  @override
  String get homeSkins => 'தோற்றங்கள்';

  @override
  String get homeHowToPlay => 'Qubble விளையாடுவது எப்படி';

  @override
  String get homeWeekendBonus => 'வார இறுதி: இரட்டை நாணயங்கள்!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'நிலை $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'பெயரை மாற்று';

  @override
  String get nameChangeExplainer =>
      'உங்கள் பெயரே தரவரிசையில் உங்கள் அடையாளம், எனவே அது நிலையானது. ஒருமுறை பெயர் மாற்றத்தை வாங்கலாம்.';

  @override
  String get nameChangeAfterPurchase =>
      'வாங்கிய பிறகு, மாற்ற உங்கள் பெயரை மீண்டும் தட்டவும்.';

  @override
  String get nameJoinedLeaderboard => 'இப்போது நீங்கள் தரவரிசையில் உள்ளீர்கள்.';

  @override
  String get nameRenameUnavailable => 'இப்போது பெயரை மாற்ற முடியாது.';

  @override
  String nameProblemTooShort(int min) {
    return 'குறைந்தபட்ச எழுத்துகள்: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'அதிகபட்ச எழுத்துகள்: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'ஆங்கில எழுத்துகள் (A–Z), எண்கள், இடைவெளி, _ மற்றும் - மட்டும்.';

  @override
  String get nameProblemOffensive => 'வேறு பெயரைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get piggyTitle => 'உண்டியல்';

  @override
  String get piggyFillingHint =>
      'வரிசைகளை அழிக்கும்போது உங்கள் உண்டியல் நிரம்புகிறது.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins நாணயங்களை இலவசமாகப் பெறுங்கள்.',
      one: '$coins நாணயத்தை இலவசமாகப் பெறுங்கள்.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'நிரம்பியதும் இலவசமாகக் காலி செய்யலாம் — அல்லது போனஸ் வீடியோ மூலம் முன்கூட்டியே திறக்கலாம்.';

  @override
  String get piggyOpenNow => 'இப்போது திற';

  @override
  String get gameNewPiecesVideo => 'புதிய துண்டுகள் (வீடியோ)';

  @override
  String get gameTapBoardCell => 'பலகையில் ஒரு கட்டத்தைத் தட்டவும்';

  @override
  String get gameDailyChallengeLabel => 'தினசரி சவால்';

  @override
  String get gameOver => 'ஆட்டம் முடிந்தது';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'வெடிகுண்டுக்குத் தேவையான கூடுதல் நாணயங்கள்: $missing.';
  }

  @override
  String get gameBombNotHere => 'வெடிகுண்டு இப்போது இங்கே வேலை செய்யாது.';

  @override
  String gameNeedsCoins(String missing) {
    return 'இதற்குத் தேவையான கூடுதல் நாணயங்கள்: $missing.';
  }

  @override
  String get gameNotRightNow => 'இப்போது இயலாது.';

  @override
  String get gameRunSaved => 'ஆட்டம் சேமிக்கப்பட்டது — மெனுவில் \"தொடர்\".';

  @override
  String get gameOverNoFit =>
      'உங்கள் துண்டுகள் எதுவும் இனி பலகையில் பொருந்தாது.';

  @override
  String get gameOverNoFitNoRotations =>
      'எந்தத் துண்டும் பொருந்தாது — சுழற்றும் வாய்ப்புகளும் தீர்ந்துவிட்டன.';

  @override
  String get gameStarterOfferUnavailable => 'இப்போது கிடைக்கவில்லை';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — பெறு';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'காம்போ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'சாதனை: $title';
  }

  @override
  String get gameBestSubmitted => 'புதிய அதிகபட்சம் — அனுப்பப்பட்டது';

  @override
  String get gameReviveFor => 'தொடர்ந்து விளையாடு · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'திறக்கப்பட்டது: $name';
  }

  @override
  String get gameStarterOfferTitle => 'தொடக்கத் தொகுப்பு';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score புள்ளிகள்',
      one: '$score புள்ளி',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'புதிய சாதனை!';

  @override
  String gameStreakDays(int streak) {
    return '$streak நாள் தொடர்';
  }

  @override
  String get gameDoubleCoins => 'நாணயங்களை இரட்டிப்பாக்கு';

  @override
  String get gameDoubleDaily => 'தினசரி பரிசை இரட்டிப்பாக்கு';

  @override
  String get gamePlayAgain => 'மீண்டும் விளையாடு';

  @override
  String gameLevelReached(int level) {
    return 'நிலை $level எட்டப்பட்டது!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count நிலைகள் — நிலை $level!',
      one: '+$count நிலை — நிலை $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 நாணயங்கள் + மரம் தீம்';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'இன்னும் $hours மணிநேரம் மட்டுமே — ஒருமுறை மட்டும்!';
  }

  @override
  String get boosterUndo => 'செயல்தவிர்';

  @override
  String get boosterSwap => 'மாற்று';

  @override
  String get boosterBomb => 'வெடிகுண்டு';

  @override
  String get boosterNoRotationsLeft =>
      'சுழற்றும் வாய்ப்பு இல்லை — மீண்டும் பெற வரிசைகளை அழிக்கவும்!';

  @override
  String get onboardingDragPiece => 'ஒரு பிளாக்கைக் கட்டத்திற்கு இழுக்கவும்';

  @override
  String get onboardingFillLine =>
      'ஒரு முழு வரிசை அல்லது நெடுவரிசையை நிரப்பவும்';

  @override
  String get onboardingLinesClear => 'நிரம்பிய கோடுகள் மறையும் — புள்ளிகள்!';

  @override
  String get coachHintCombo =>
      'காம்போ! தக்கவைக்க 3 நகர்வுகளுக்குள் மீண்டும் அழிக்கவும்';

  @override
  String get coachHintFever => 'ஃபீவர்! ஒளிரும் வரை இரட்டைப் புள்ளிகள்';

  @override
  String get coachHintRotation =>
      'சுழற்ற ஒரு சார்ஜ் செலவாகும் — அழிப்பது அதை நிரப்பும்';

  @override
  String get coachHintBooster => 'குறிப்பு: கீழே பூஸ்டர்களைப் பயன்படுத்தலாம்';

  @override
  String get coachHintStrategy =>
      'குறிப்பு: எல்லாக் கோடுகளையும் ஒரே நேரத்தில் வேண்டாம் — பெரிய துண்டுகளுக்கு இடம் வையுங்கள்';

  @override
  String get dailyStreakLabel => 'தொடர்';

  @override
  String get dailyBestLabel => 'தினசரி அதிகபட்சம்';

  @override
  String dailyHistoryNote(int days) {
    return 'கடைசி $days நாட்கள் சேமிக்கப்படும்.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'நாள் $day: விளையாடப்பட்டது';
  }

  @override
  String dailyDayMissed(int day) {
    return 'நாள் $day: விளையாடவில்லை';
  }

  @override
  String get homeDailyCalendar => 'நாட்காட்டி';

  @override
  String get dailyShareButton => 'முடிவைப் பகிர்';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · தினசரி சவால் $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'புள்ளிகள்: $score · சிறந்த காம்போ x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'விளையாடுங்கள்: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'காம்போ: இன்னும் $moves நகர்வுகள்',
      one: 'காம்போ: இன்னும் $moves நகர்வு',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'முடிவு கிளிப்போர்டுக்கு நகலெடுக்கப்பட்டது';

  @override
  String get adNotAvailable =>
      'இப்போது வீடியோ இல்லை — சிறிது நேரத்தில் மீண்டும் முயலவும்';

  @override
  String get howToPlaySpeedTitle => 'வேக போனஸ்';

  @override
  String get howToPlaySpeedBody =>
      'விரைவாக வைப்பது ஒவ்வொரு அழிப்புக்கும் 30 % வரை சேர்க்கும். போனஸ் 1.5 முதல் 4 வினாடிகளுக்குள் குறைந்து, ஒரு உச்சவரம்பைக் கொண்டது; எனவே வேகம் பலன் தரும், ஆனால் ஆட்டத்தைத் தீர்மானிக்காது — கவனமான மெதுவான ஆட்டம் அவசரமான வேகமான ஆட்டத்தை இன்னும் வெல்லலாம்.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'வேக போனஸ் $percent சதவீதம்';
  }

  @override
  String get iapDiamondsSmall => '100 வைரங்கள்';

  @override
  String get iapDiamondsMedium => '350 வைரங்கள்';

  @override
  String get iapDiamondsLarge => '1,000 வைரங்கள்';

  @override
  String get howToPlayTitle => 'Qubble விளையாடுவது எப்படி';

  @override
  String get howToPlayIntroHeadline =>
      'தொடங்குவது எளிது.\nமுன்கூட்டியே திட்டமிட்டால் பலன்.';

  @override
  String get howToPlayIntroBody =>
      'பலகையைக் காலியாக வைத்து உங்கள் சாதனையை முறியுங்கள்.';

  @override
  String get howToPlayIntroSemantics =>
      'ஆட்டத்தின் இலக்கு. பலகையைக் காலியாக வைத்து உங்கள் சாதனையை முறியுங்கள்.';

  @override
  String get howToPlayDragTitle => 'இழுத்து வையுங்கள்';

  @override
  String get howToPlayDragBody =>
      'மூன்று துண்டுகளில் ஒன்றைக் காலியான கட்டங்களுக்கு இழுக்கவும். மூன்றையும் பயன்படுத்தியதும், தானாகவே மூன்று புதியவை கிடைக்கும்.';

  @override
  String get howToPlayClearTitle => 'கோடுகளை அழியுங்கள்';

  @override
  String get howToPlayClearBody =>
      'ஒரு முழு வரிசை அல்லது நெடுவரிசையை நிரப்பவும். நிரம்பிய கோடுகள் மறைந்து அடுத்த நகர்வுக்கு இடம் தரும்.';

  @override
  String get howToPlayComboTitle => 'காம்போக்களை இணையுங்கள்';

  @override
  String get howToPlayComboBody =>
      'மூன்று நகர்வுகளுக்குள் இன்னொரு கோட்டை அழிக்கவும். ஒவ்வொரு கூடுதல் காம்போவும் உங்கள் புள்ளிப் பெருக்கியை உயர்த்தும். காம்போ வினாடிகளை அல்ல, நகர்வுகளை எண்ணுகிறது; எனவே நீங்கள் யோசிக்கும்போது அது முடிந்துவிடாது.';

  @override
  String get howToPlayFeverTitle => 'ஃபீவரைத் தூண்டுங்கள்';

  @override
  String get howToPlayFeverBody =>
      'அழிப்புகள் ஃபீவர் மீட்டரை நிரப்பும். அது நிரம்பியதும், அடுத்த வெடிப்பு இரட்டிப்பாகக் கணக்கிடப்படும் — பெரிய அழிப்புகளை முன்கூட்டியே திட்டமிடுங்கள்.';

  @override
  String get howToPlayBoosterTitle =>
      'பூஸ்டர்களை புத்திசாலித்தனமாகப் பயன்படுத்துங்கள்';

  @override
  String get howToPlayBoosterBody =>
      'பூஸ்டர்கள் நெருக்கடியான ஆட்டங்களைக் காப்பாற்றும். கீழே உள்ள ஒரு துண்டைத் தட்டி அதைச் சுழற்றவும் செய்யலாம்.';

  @override
  String get howToPlayDailyTitle => 'தினசரி சவால் & தொடர்';

  @override
  String get howToPlayDailyBody =>
      'தினசரி சவாலில் அனைவருக்கும் ஒரே துண்டுகள். உங்கள் தொடரையும் போனஸையும் வளர்க்க தினமும் விளையாடுங்கள்.';

  @override
  String get howToPlayPiggyTitle => 'உண்டியலை நிரப்புங்கள்';

  @override
  String get howToPlayPiggyBody =>
      'அழிக்கப்படும் ஒவ்வொரு கோடும் உங்கள் உண்டியலை நிரப்பும். அது நிரம்பியதும், நாணயங்களை இலவசமாகப் பெறலாம்.';

  @override
  String get leaderboardTitle => 'தரவரிசை';

  @override
  String get leaderboardUnreachable =>
      'தரவரிசை கிடைக்கவில்லை.\nஇணைய இணைப்புடன் மீண்டும் முயலவும்.';

  @override
  String get leaderboardEmpty => 'இன்னும் பதிவுகள் இல்லை.\nமுதலாவதாக இருங்கள்!';

  @override
  String leaderboardSubmitting(int score) {
    return 'உங்கள் அதிகபட்சம் ($score) அனுப்பப்படுகிறது …';
  }

  @override
  String get leaderboardAutoSubmit => 'உங்கள் அதிகபட்சம் தானாக அனுப்பப்படும்.';

  @override
  String get puzzleModeTitle => 'புதிர் பயன்முறை';

  @override
  String puzzleLevelTitle(int level) {
    return 'புதிர் $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'நகர்வுகள்: $moves   •   இலக்கு: 3 நட்சத்திரங்களுக்கு $target';
  }

  @override
  String get puzzleSolved => 'தீர்ந்தது!';

  @override
  String get puzzleLeaveTitle => 'புதிரை விட்டு வெளியேறவா?';

  @override
  String get puzzleLeaveBody =>
      'இந்தப் புதிரில் உங்கள் முன்னேற்றம் இழக்கப்படும்.';

  @override
  String get puzzleKeepPlaying => 'தொடர்ந்து விளையாடு';

  @override
  String get puzzleLeave => 'வெளியேறு';

  @override
  String get puzzleStuckTitle => 'சிக்கிக்கொண்டீர்கள்';

  @override
  String get puzzleRestart => 'மீண்டும் தொடங்கு';

  @override
  String get commonActive => 'செயலில்';

  @override
  String get commonTapToActivate => 'செயல்படுத்தத் தட்டவும்';

  @override
  String get commonRestore => 'மீட்டமை';

  @override
  String unlockForCost(int cost) {
    return 'திறக்க $cost';
  }

  @override
  String get skinsExchangeGold => 'தங்கத்தை மாற்று';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'துண்டைச் சுழற்று';

  @override
  String get puzzleNextLevel => 'அடுத்த நிலை';

  @override
  String get puzzleBackToOverview => 'பட்டியலுக்குத் திரும்பு';

  @override
  String get puzzleUnsolvable => 'இங்கிருந்து பலகையை இனி காலி செய்ய முடியாது.';

  @override
  String get puzzleExtraMoveVideo => 'கூடுதல் நகர்வு (வீடியோ)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'தீர்க்கப்பட்டவை: $solved';
  }

  @override
  String get settingsTitle => 'அமைப்புகள்';

  @override
  String get storageFailureTitle =>
      'உங்கள் சேமித்த ஆட்டத்தை Qubble ஏற்ற முடியவில்லை';

  @override
  String get storageFailureBody =>
      'ஆப்ஸை மீண்டும் தொடங்கவும். பிழை தொடர்ந்தால், மீண்டும் நிறுவுவது மட்டுமே உதவும். அமைப்புகள் › கருத்து மூலம் இதைத் தெரிவிக்கலாம்.';

  @override
  String get iapUnavailable => 'இந்தச் சலுகை இப்போது கிடைக்கவில்லை.';

  @override
  String get iapFailed =>
      'வாங்குதல் நிறைவடையவில்லை. கட்டணம் எதுவும் வசூலிக்கப்படவில்லை.';

  @override
  String get settingsResetProgress => 'முன்னேற்றத்தை மீட்டமை';

  @override
  String get settingsResetProgressSubtitle =>
      'புள்ளிகள், நாணயங்கள், நிலை மற்றும் முன்னேற்றம் தொடக்கத்திற்குத் திரும்பும். வாங்கியவை, பெயர் மற்றும் அலங்காரங்கள் இருக்கும்.';

  @override
  String get settingsResetConfirmTitle => 'முன்னேற்றத்தை மீட்டமைக்கவா?';

  @override
  String get settingsResetConfirmBody =>
      'அதிகபட்சம், நாணயங்கள், நிலை, தொடர் மற்றும் அனைத்து முன்னேற்றமும் நீக்கப்படும். இதைத் திரும்பப் பெற முடியாது.\n\nநீங்கள் வாங்கியவை, உங்கள் பெயர் மற்றும் திறந்த தீம்கள், தோற்றங்கள் இருக்கும்.';

  @override
  String get settingsResetConfirmAction => 'மீட்டமை';

  @override
  String get settingsResetDone => 'முன்னேற்றம் மீட்டமைக்கப்பட்டது.';

  @override
  String get settingsSectionGame => 'ஆட்டம்';

  @override
  String get settingsSectionSoundHaptics => 'ஒலி & அதிர்வு';

  @override
  String get settingsSectionReminders => 'நினைவூட்டல்கள்';

  @override
  String get settingsSectionPurchases => 'வாங்குதல்கள்';

  @override
  String get settingsSectionHelpOut => 'உதவுங்கள்';

  @override
  String get settingsSectionLegal => 'சட்டம்';

  @override
  String get settingsSectionLanguage => 'மொழி';

  @override
  String get settingsGuide => 'விளையாடுவது எப்படி';

  @override
  String get settingsGuideSubtitle =>
      'விதிகள், காம்போக்கள், ஃபீவர் & பூஸ்டர்கள்';

  @override
  String get settingsSound => 'ஒலி';

  @override
  String get settingsMusic => 'இசை';

  @override
  String get settingsHaptics => 'அதிர்வு';

  @override
  String get settingsHapticsOff => 'அணை';

  @override
  String get settingsHapticsLight => 'மென்மை';

  @override
  String get settingsHapticsStrong => 'வலுவானது';

  @override
  String get settingsSectionAccessibility => 'வசதி';

  @override
  String get settingsReducedEffects => 'குறைந்த விளைவுகள்';

  @override
  String get settingsReducedEffectsHint =>
      'குறைவான துகள்கள், திரை அதிர்வு இல்லை, ஒளிர்வு இல்லை';

  @override
  String get settingsNotifications => 'அறிவிப்புகள்';

  @override
  String get settingsNotificationsSubtitle =>
      'தினசரி நினைவூட்டல் & தொடர் பாதுகாப்பு';

  @override
  String get settingsNotificationsSystemHint =>
      'சிஸ்டம் அமைப்புகளில் அனுமதிக்கவும்.';

  @override
  String get settingsLanguageSystem => 'சிஸ்டம் மொழி';

  @override
  String get settingsSupporterThanks => 'ஆதரவாளர் — நன்றி!';

  @override
  String get settingsSupporterPack => 'ஆதரவாளர் தொகுப்பு';

  @override
  String get settingsSupporterPackSubtitle =>
      'பிரத்யேக தீம் & தோற்றம் + 1,500 நாணயங்கள்';

  @override
  String get settingsRestorePurchases => 'வாங்கியவற்றை மீட்டமை';

  @override
  String get settingsRestoring => 'வாங்கியவை மீட்டமைக்கப்படுகின்றன…';

  @override
  String get settingsRateApp => 'ஆப்ஸை மதிப்பிடு';

  @override
  String get settingsRateAppSubtitle => 'ஸ்டோரில் மதிப்பீடு வழங்குங்கள்';

  @override
  String get settingsStoreUnavailable =>
      'இந்தச் சாதனத்தில் ஸ்டோர் கிடைக்கவில்லை.';

  @override
  String get settingsFeedback => 'கருத்து அனுப்பு';

  @override
  String get settingsFeedbackSubtitle => 'யோசனைகள் & பிழைகள் (GitHub வழியாக)';

  @override
  String get settingsAdPrivacy => 'விளம்பரத் தனியுரிமை';

  @override
  String get settingsAdPrivacySubtitle =>
      'உங்கள் விளம்பர ஒப்புதலைப் பார்க்க அல்லது மாற்ற';

  @override
  String get settingsAdPrivacyUnavailable =>
      'இந்தச் சாதனத்தில் விளம்பர விருப்பங்கள் தேவையில்லை.';

  @override
  String get settingsPrivacy => 'தனியுரிமைக் கொள்கை';

  @override
  String get settingsImprint => 'சட்டத் தகவல்';

  @override
  String get settingsPageOpenFailed => 'பக்கத்தைத் திறக்க முடியவில்லை.';

  @override
  String get settingsFooter => 'Qubble • ஆஃப்லைன் பிளாக் புதிர்';

  @override
  String get settingsAdminSection => 'நிர்வாகி (சோதனை)';

  @override
  String get settingsAdminEnabled => 'நிர்வாகி பயன்முறை இயக்கப்பட்டது';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'நிர்வாகி பயன்முறைக்கு இன்னும் $count முறை தட்டவும்';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins நாணயங்கள்',
      one: '$coins நாணயம்',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'சோதனைக்கு மட்டும் — வெளியீட்டு ஸ்கிரீன்ஷாட்களில் ஒருபோதும் இல்லை';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount நாணயங்கள்',
      one: '$amount நாணயம்',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'நாணயங்களை 0 ஆக்கு';

  @override
  String get feedbackTitle => 'கருத்து';

  @override
  String get feedbackIntroShort =>
      'உங்களுக்கு எது பிடிக்கிறது, எது எரிச்சலூட்டுகிறது, எது இல்லை? சிறிய விஷயங்களும் உதவும் — எவ்வளவு குறிப்பாக இருக்கிறதோ அவ்வளவு நல்லது.';

  @override
  String feedbackAttachmentNote(String build) {
    return '$build மற்றும் உங்கள் சாதன வகை மட்டுமே இணைக்கப்படும் — நீங்கள் எந்தப் பதிப்பைப் பற்றிச் சொல்கிறீர்கள் என்று எனக்குத் தெரிய.';
  }

  @override
  String get feedbackSendByMail => 'மின்னஞ்சலில் அனுப்பு';

  @override
  String get feedbackPreferGithub => 'GitHub issue விரும்புகிறேன்';

  @override
  String get feedbackThanksMail => 'நன்றி! செய்தியை அனுப்பினால் போதும்.';

  @override
  String get feedbackNoMailApp =>
      'மின்னஞ்சல் ஆப்ஸ் இல்லை. கீழே உள்ள GitHub வழியை முயலவும்.';

  @override
  String get feedbackEmptyHint => 'முதலில் ஏதாவது எழுதவும்.';

  @override
  String get leaderboardRefresh => 'புதுப்பி';

  @override
  String get leaderboardRetry => 'மீண்டும் முயல்';

  @override
  String get feedbackHint => 'உங்கள் கருத்து…';

  @override
  String get feedbackSubmit => 'கருத்து அனுப்பு';

  @override
  String get feedbackOpenFailed =>
      'GitHub-ஐத் திறக்க முடியவில்லை. பிறகு முயலவும்.';

  @override
  String get feedbackGithubNote =>
      'GitHub திறக்கும் — அங்கே \"Submit new issue\"-ஐத் தட்டவும். (ஒருமுறை GitHub உள்நுழைவு தேவை.)';

  @override
  String get shopTitle => 'கடை';

  @override
  String get shopWebDemoNote =>
      'வாங்குதல்கள் Play Store ஆப்ஸில் மட்டுமே கிடைக்கும். இந்த இணையப் பதிப்பு இலவச டெமோ — ஆனாலும் இங்கே முழுவதும் விளையாடலாம்.';

  @override
  String get shopSupporterExplainer =>
      'Qubble கட்டாய விளம்பரங்களைக் காட்டாது — நீங்கள் எதையும் வாங்க வேண்டியதில்லை. ஆதரவாளர் தொகுப்பு (அரோரா தீம், கிரிஸ்டல் தோற்றம், 1,500 நாணயங்கள், ஆதரவாளர் பேட்ஜ்) ஆட்டத்தை ஆதரித்ததற்கான நன்றி. வாங்கியவை உங்கள் ஸ்டோர் கணக்குடன் இணைக்கப்பட்டுள்ளன, எப்போது வேண்டுமானாலும் மீட்டமைக்கலாம்.';

  @override
  String get shopSupporterContents =>
      'அரோரா தீம் + கிரிஸ்டல் தோற்றம் + 1,500 நாணயங்கள்';

  @override
  String get themesTitle => 'தீம்கள்';

  @override
  String get themesSupporterOnly =>
      'ஆதரவாளர் தொகுப்பில் மட்டும் (கடையைப் பார்க்கவும்)';

  @override
  String get themesInSupporterPack => 'ஆதரவாளர் தொகுப்பில்';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'போதுமான நாணயங்கள் இல்லை ($cost தேவை, உங்களிடம் $coins)';
  }

  @override
  String get skinsTitle => 'பிளாக் தோற்றங்கள்';

  @override
  String get skinsNotEnoughDiamonds =>
      'போதுமான வைரங்கள் இல்லை (கீழே தங்கத்தை மாற்றவும்)';

  @override
  String get skinsNotEnoughCoins => 'போதுமான நாணயங்கள் இல்லை';

  @override
  String get skinsNotEnoughGold => 'போதுமான தங்கம் இல்லை.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold தங்கம் = 1 வைரம். வைரங்கள் மிக அழகான தோற்றங்களைத் திறக்கும் — நிதானமாகச் சேகரியுங்கள்.';
  }

  @override
  String get statsTitle => 'புள்ளிவிவரம்';

  @override
  String get statsAverageScore => 'சராசரிப் புள்ளிகள்';

  @override
  String get statsBestCombo => 'சிறந்த காம்போ';

  @override
  String get statsGames => 'ஆட்டங்கள்';

  @override
  String get statsLinesCleared => 'அழித்த வரிசைகள்';

  @override
  String get statsPiecesPlaced => 'வைத்த துண்டுகள்';

  @override
  String get statsCoins => 'நாணயங்கள்';

  @override
  String get missionsTitle => 'பணிகள்';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString துண்டுகளை வையுங்கள்',
      one: '$countString துண்டை வையுங்கள்',
    );
    return '$_temp0';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString வரிசைகளை அழியுங்கள்',
      one: '$countString வரிசையை அழியுங்கள்',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString காம்போவை அடையுங்கள்';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ஒரே ஆட்டத்தில் $countString புள்ளிகளைத் தாண்டுங்கள்',
      one: 'ஒரே ஆட்டத்தில் $countString புள்ளியைத் தாண்டுங்கள்',
    );
    return '$_temp0';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ஆட்டங்கள் விளையாடுங்கள்',
      one: '$countString ஆட்டம் விளையாடுங்கள்',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'சாதனைகள்';

  @override
  String get achievementFirstGameTitle => 'முதல் ஆட்டம்';

  @override
  String get achievementFirstGameBody => 'உங்கள் முதல் ஆட்டத்தை விளையாடுங்கள்';

  @override
  String get achievementGames25Title => 'வழக்கமானவர்';

  @override
  String get achievementGames25Body => '25 ஆட்டங்கள் விளையாடுங்கள்';

  @override
  String get achievementGames100Title => 'அடிமையானவர்';

  @override
  String get achievementGames100Body => '100 ஆட்டங்கள் விளையாடுங்கள்';

  @override
  String get achievementScore1kTitle => 'ஏறுபவர்';

  @override
  String get achievementScore1kBody => '1,000 புள்ளிகளை அடையுங்கள்';

  @override
  String get achievementScore5kTitle => 'நிபுணர்';

  @override
  String get achievementScore5kBody => '5,000 புள்ளிகளை அடையுங்கள்';

  @override
  String get achievementScore10kTitle => 'மாஸ்டர்';

  @override
  String get achievementScore10kBody => '10,000 புள்ளிகளை அடையுங்கள்';

  @override
  String get achievementScore25kTitle => 'ஜாம்பவான்';

  @override
  String get achievementScore25kBody => '25,000 புள்ளிகளை அடையுங்கள்';

  @override
  String get achievementLines100Title => 'நேர்த்தியானவர்';

  @override
  String get achievementLines100Body => 'மொத்தம் 100 வரிசைகளை அழியுங்கள்';

  @override
  String get achievementLines1000Title => 'பெரும் சுத்தம்';

  @override
  String get achievementLines1000Body => 'மொத்தம் 1,000 வரிசைகளை அழியுங்கள்';

  @override
  String get achievementCombo5Title => 'காம்போ தொடக்கம்';

  @override
  String get achievementCombo5Body => 'x5 காம்போவை அடையுங்கள்';

  @override
  String get achievementCombo10Title => 'காம்போ ராஜா';

  @override
  String get achievementCombo10Body => 'x10 காம்போவை அடையுங்கள்';

  @override
  String get achievementLevel10Title => 'அனுபவசாலி';

  @override
  String get achievementLevel10Body => 'நிலை 10-ஐ அடையுங்கள்';

  @override
  String get achievementLevel20Title => 'மூத்தவர்';

  @override
  String get achievementLevel20Body => 'நிலை 20-ஐ அடையுங்கள்';

  @override
  String get achievementStreak7Title => 'வாரத் தொடர்';

  @override
  String get achievementStreak7Body => '7 நாள் தினசரி தொடர்';

  @override
  String get achievementStreak30Title => 'மாதத் தொடர்';

  @override
  String get achievementStreak30Body => '30 நாள் தினசரி தொடர்';

  @override
  String get achievementPuzzles10Title => 'புதிர் வீரர்';

  @override
  String get achievementPuzzles10Body => '10 புதிர்களைத் தீருங்கள்';

  @override
  String get achievementPieces5000Title => 'கட்டுநர்';

  @override
  String get achievementPieces5000Body => '5,000 துண்டுகளை வையுங்கள்';

  @override
  String streakRepairTitle(int streak) {
    return '$streak நாள் தொடர் ஆபத்தில்!';
  }

  @override
  String get streakRepairBody =>
      'நேற்று விளையாடவில்லை — உங்கள் தொடரைக் காப்பாற்றுங்கள்:';

  @override
  String get streakRepairFailed => 'சரிசெய்ய முடியாது.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins நாணயங்கள்',
      one: '$coins நாணயம்',
    );
    return 'மீண்டும் வருக! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'நினைவூட்டல்கள்?';

  @override
  String get notificationsOptInBody =>
      'உங்கள் தினசரி புதிரை நினைவூட்டி, உங்கள் தொடரைப் பாதுகாக்கலாமா? இதை எப்போது வேண்டுமானாலும் அமைப்புகளில் மாற்றலாம்.';

  @override
  String get notificationsOptInAccept => 'ஆம், தயவுசெய்து';

  @override
  String get notificationChannelDescription =>
      'தினசரி நினைவூட்டல், தொடர் எச்சரிக்கை, மீண்டும் வருகை';

  @override
  String get notificationDailyTitle =>
      'உங்கள் தினசரி புதிர் காத்திருக்கிறது 🧩';

  @override
  String get notificationDailyBody => 'இன்றைய சவாலை விளையாடுங்கள்!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 உங்கள் $streak நாள் தொடர் ஆபத்தில்!';
  }

  @override
  String get notificationStreakBody => 'அதைத் தக்கவைக்க இன்று விளையாடுங்கள்.';

  @override
  String get notificationComebackTitle =>
      'உங்கள் பிளாக்குகள் காத்திருக்கின்றன 🧩';

  @override
  String get notificationComebackBody => 'திரும்பி வந்து பரிசைப் பெறுங்கள்!';

  @override
  String get iapSupporterPack => 'ஆதரவாளர் தொகுப்பு';

  @override
  String get iapCoinsSmall => '500 நாணயங்கள்';

  @override
  String get iapCoinsMedium => '2,000 நாணயங்கள்';

  @override
  String get iapCoinsLarge => '6,000 நாணயங்கள்';

  @override
  String get iapStarterPack => 'தொடக்கத் தொகுப்பு';

  @override
  String get iapRename => 'பெயர் மாற்றம்';

  @override
  String get iapNeonTheme => 'நியான் தீம்';

  @override
  String get settingsLeaderboardDelete => 'தரவரிசைப் பதிவை நீக்கு';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'உங்கள் பெயரையும் புள்ளிகளையும் பொதுப் பட்டியலிலிருந்து நீக்கும்';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'உங்கள் பதிவை நீக்கவா?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'உங்கள் பெயரும் புள்ளிகளும் தரவரிசையிலிருந்து நீக்கப்படும். உங்கள் ஆட்ட முன்னேற்றம் மாறாது. எப்போது வேண்டுமானாலும் தரவரிசையில் மீண்டும் சேரலாம்.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'உங்கள் தரவரிசைப் பதிவு நீக்கப்பட்டது.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'பதிவை நீக்க முடியவில்லை. இணைப்பைச் சரிபார்த்து மீண்டும் முயலவும்.';

  @override
  String get leaderboardReport => 'இந்தப் பெயரைப் புகாரளி';

  @override
  String get leaderboardBlock => 'தடு';

  @override
  String leaderboardBlocked(String name) {
    return '$name உங்களுக்கு மறைக்கப்பட்டது';
  }

  @override
  String get leaderboardUndo => 'செயல்தவிர்';

  @override
  String leaderboardBlockedCount(int count) {
    return 'நீங்கள் மறைத்த பதிவுகள்: $count';
  }

  @override
  String get leaderboardUnblockAll => 'மீண்டும் காட்டு';

  @override
  String get leaderboardReportUnavailable => 'இப்போது புகாரளிக்க முடியாது.';

  @override
  String get leaderboardReportSent => 'நன்றி — உங்கள் புகார் அனுப்பப்பட்டது.';

  @override
  String get leaderboardRules =>
      'பெயர்கள் பொதுவானவை. அவமதிப்புகள், இழிவான சொற்கள், உண்மையான நபரை அடையாளம் காட்டும் எதுவும் கூடாது. இதை மீறும் பெயர்கள் நீக்கப்படும்.';

  @override
  String get leaderboardRulesAccept => 'புரிந்தது';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'திறக்கப்பட்டவை: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'சேமித்த தரவு';

  @override
  String get gameRotatePiece => 'துண்டைச் சுழற்று';

  @override
  String get themeClassic => 'கிளாசிக்';

  @override
  String get themeFade => 'பேஸ்டல்';

  @override
  String get themeNeon => 'நியான்';

  @override
  String get themeOcean => 'கடல்';

  @override
  String get themeWood => 'மரம்';

  @override
  String get themeSunset => 'சூரிய அஸ்தமனம்';

  @override
  String get themeForest => 'காடு';

  @override
  String get themeAurora => 'அரோரா';

  @override
  String get skinClassic => 'கிளாசிக்';

  @override
  String get skinGradient => 'கிரேடியன்ட்';

  @override
  String get skinOutline => 'அவுட்லைன்';

  @override
  String get skinGlossy => 'பளபளப்பு';

  @override
  String get skinStripe => 'கோடுகள்';

  @override
  String get skinBevel => 'சரிவு';

  @override
  String get skinGlow => 'ஒளிர்வு';

  @override
  String get skinCrystal => 'கிரிஸ்டல்';

  @override
  String rewardThemeName(String name) {
    return '$name தீம்';
  }

  @override
  String rewardSkinName(String name) {
    return '$name தோற்றம்';
  }
}
