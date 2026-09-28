// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class L10nNe extends L10n {
  L10nNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'खेल्नुहोस्';

  @override
  String get commonLater => 'पछि';

  @override
  String get commonNotNow => 'अहिले होइन';

  @override
  String get commonCancel => 'रद्द गर्नुहोस्';

  @override
  String get commonBuy => 'किन्नुहोस्';

  @override
  String get commonSave => 'सुरक्षित गर्नुहोस्';

  @override
  String get commonCollect => 'लिनुहोस्';

  @override
  String get nameNewName => 'नयाँ नाम';

  @override
  String get nameFieldLabel => 'नाम';

  @override
  String get piggyFullTitle => 'खुत्रुके भरियो!';

  @override
  String get piggyKeepSaving => 'बचत जारी राख्नुहोस्';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity मध्ये $coins जम्मा भयो।';
  }

  @override
  String get homeContinueRun => 'जारी राख्नुहोस्';

  @override
  String get homeVideo => 'भिडियो';

  @override
  String get commonGotIt => 'बुझें';

  @override
  String get commonHome => 'होम';

  @override
  String get commonScore => 'स्कोर';

  @override
  String get commonBest => 'उत्कृष्ट';

  @override
  String commonLevelShort(int level) {
    return 'लेभल $level';
  }

  @override
  String get homeNewRun => 'नयाँ खेल सुरु गर्नुहोस्';

  @override
  String get homeBackToExit => 'बाहिर निस्कन फेरि ब्याक थिच्नुहोस्';

  @override
  String get homeEnableLeaderboard => 'लिडरबोर्डमा सामेल हुनुहोस्';

  @override
  String get homeBestScore => 'उत्कृष्ट स्कोर';

  @override
  String get homeDailyChallenge => 'दैनिक चुनौती';

  @override
  String get homeDailyOpenToday => 'आज खेल्न बाँकी';

  @override
  String homeDailyNextIn(String time) {
    return 'अर्को चुनौती: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'लगातार $streak दिन';
  }

  @override
  String get homeLeaderboard => 'लिडरबोर्ड';

  @override
  String get homePuzzleMode => 'पजल मोड';

  @override
  String get homeMissions => 'मिसन';

  @override
  String get homeThemes => 'थिम';

  @override
  String get homeSkins => 'स्किन';

  @override
  String get homeHowToPlay => 'Qubble कसरी खेल्ने';

  @override
  String get homeWeekendBonus => 'सप्ताहान्त: दोब्बर सिक्का!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'लेभल $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'नाम बदल्नुहोस्';

  @override
  String get nameChangeExplainer =>
      'लिडरबोर्डमा तपाईंको नाम नै तपाईंको पहिचान हो, त्यसैले यो स्थिर रहन्छ। एक पटक नाम बदल्ने सुविधा किन्न सकिन्छ।';

  @override
  String get nameChangeAfterPurchase =>
      'किनेपछि, नाम बदल्न आफ्नो नाममा फेरि ट्याप गर्नुहोस्।';

  @override
  String get nameJoinedLeaderboard => 'अब तपाईं लिडरबोर्डमा हुनुहुन्छ।';

  @override
  String nameProblemTooShort(int min) {
    return 'कम्तीमा अक्षर: $min।';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'बढीमा अक्षर: $max।';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'अङ्ग्रेजी अक्षर (A–Z), अङ्क, स्पेस, _ र - मात्र चल्छन्।';

  @override
  String get nameProblemOffensive => 'कृपया अर्को नाम छान्नुहोस्।';

  @override
  String get piggyTitle => 'खुत्रुके';

  @override
  String get piggyFillingHint =>
      'लाइन सफा गर्दा तपाईंको खुत्रुके भरिँदै जान्छ।';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins सिक्का निःशुल्क लिनुहोस्।',
      one: '$coins सिक्का निःशुल्क लिनुहोस्।',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'भरिएपछि यसलाई निःशुल्क खाली गर्न सकिन्छ — वा बोनस भिडियो हेरेर पहिल्यै खोल्न सकिन्छ।';

  @override
  String get piggyOpenNow => 'अहिले खोल्नुहोस्';

  @override
  String get gameNewPiecesVideo => 'नयाँ टुक्रा (भिडियो)';

  @override
  String get gameTapBoardCell => 'बोर्डको एउटा कोठामा ट्याप गर्नुहोस्';

  @override
  String get gameDailyChallengeLabel => 'दैनिक चुनौती';

  @override
  String get gameOver => 'खेल सकियो';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'बमका लागि थप सिक्का चाहिन्छ: $missing।';
  }

  @override
  String get gameBombNotHere => 'बम अहिले यहाँ काम गर्दैन।';

  @override
  String gameNeedsCoins(String missing) {
    return 'यसका लागि थप सिक्का चाहिन्छ: $missing।';
  }

  @override
  String get gameNotRightNow => 'अहिले सम्भव छैन।';

  @override
  String get gameRunSaved => 'खेल सुरक्षित भयो — मेनुमा \"जारी राख्नुहोस्\"।';

  @override
  String get gameOverNoFit => 'तपाईंको कुनै पनि टुक्रा अब बोर्डमा अटाउँदैन।';

  @override
  String get gameOverNoFitNoRotations =>
      'कुनै टुक्रा अटाउँदैन — र घुमाउने मौका पनि सकियो।';

  @override
  String get gameStarterOfferUnavailable => 'अहिले उपलब्ध छैन';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — लिनुहोस्';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'कम्बो x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'उपलब्धि: $title';
  }

  @override
  String get gameBestSubmitted => 'नयाँ उत्कृष्ट — पठाइयो';

  @override
  String get gameReviveFor => 'खेल जारी राख्नुहोस् · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'अनलक भयो: $name';
  }

  @override
  String get gameStarterOfferTitle => 'स्टार्टर प्याक';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score अङ्क',
      one: '$score अङ्क',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'नयाँ कीर्तिमान!';

  @override
  String gameStreakDays(int streak) {
    return 'लगातार $streak दिन';
  }

  @override
  String get gameDoubleCoins => 'सिक्का दोब्बर गर्नुहोस्';

  @override
  String get gameDoubleDaily => 'दैनिक पुरस्कार दोब्बर गर्नुहोस्';

  @override
  String get gamePlayAgain => 'फेरि खेल्नुहोस्';

  @override
  String gameLevelReached(int level) {
    return 'लेभल $level पुगियो!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count लेभल — लेभल $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 सिक्का + काठ थिम';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '$hours घण्टा मात्र बाँकी — एक पटक मात्र!';
  }

  @override
  String get boosterUndo => 'फिर्ता';

  @override
  String get boosterSwap => 'बदल्नुहोस्';

  @override
  String get boosterBomb => 'बम';

  @override
  String get boosterNoRotationsLeft =>
      'घुमाउने मौका सकियो — फेरि पाउन लाइन सफा गर्नुहोस्!';

  @override
  String get onboardingDragPiece => 'एउटा ब्लक ग्रिडमा तान्नुहोस्';

  @override
  String get onboardingFillLine => 'पूरा पङ्क्ति वा स्तम्भ भर्नुहोस्';

  @override
  String get onboardingLinesClear => 'भरिएका लाइन सफा हुन्छन् — अङ्क!';

  @override
  String get coachHintCombo =>
      'कम्बो! कायम राख्न 3 चालभित्र फेरि सफा गर्नुहोस्';

  @override
  String get coachHintFever => 'फिभर! चम्किउन्जेल दोब्बर अङ्क';

  @override
  String get coachHintRotation =>
      'घुमाउन एउटा चार्ज लाग्छ — सफा गर्दा फेरि भरिन्छ';

  @override
  String get coachHintBooster => 'सुझाव: तल बुस्टर प्रयोग गर्न सकिन्छ';

  @override
  String get coachHintStrategy =>
      'सुझाव: सबै लाइन एकैचोटि होइन — ठूला टुक्राका लागि ठाउँ छोड्नुहोस्';

  @override
  String get dailyStreakLabel => 'स्ट्रिक';

  @override
  String get dailyBestLabel => 'दैनिक उत्कृष्ट';

  @override
  String dailyHistoryNote(int days) {
    return 'पछिल्ला $days दिन सुरक्षित रहन्छन्।';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'दिन $day: खेलियो';
  }

  @override
  String dailyDayMissed(int day) {
    return 'दिन $day: खेलिएन';
  }

  @override
  String get homeDailyCalendar => 'पात्रो';

  @override
  String get dailyShareButton => 'नतिजा सेयर गर्नुहोस्';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · दैनिक चुनौती $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'अङ्क: $score · उत्कृष्ट कम्बो x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'खेल्नुहोस्: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'कम्बो: अझै $moves चाल',
      one: 'कम्बो: अझै $moves चाल',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'नतिजा क्लिपबोर्डमा कपी भयो';

  @override
  String get adNotAvailable =>
      'अहिले कुनै भिडियो छैन — केही बेरपछि फेरि प्रयास गर्नुहोस्';

  @override
  String get howToPlaySpeedTitle => 'गति बोनस';

  @override
  String get howToPlaySpeedBody =>
      'छिटो राख्दा हरेक सफाइमा 30 % सम्म थपिन्छ। बोनस 1.5 देखि 4 सेकेन्डबीच घट्दै जान्छ र यसको सीमा छ, त्यसैले गतिले फाइदा दिन्छ तर खेलको फैसला गर्दैन — सोचेर बिस्तारै खेलिएको खेलले अझै पनि हतारको छिटो खेललाई हराउन सक्छ।';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'गति बोनस $percent प्रतिशत';
  }

  @override
  String get iapDiamondsSmall => '100 हीरा';

  @override
  String get iapDiamondsMedium => '350 हीरा';

  @override
  String get iapDiamondsLarge => '1,000 हीरा';

  @override
  String get howToPlayTitle => 'Qubble कसरी खेल्ने';

  @override
  String get howToPlayIntroHeadline =>
      'सुरु गर्न सजिलो।\nअगाडि सोचे बढी पाइन्छ।';

  @override
  String get howToPlayIntroBody =>
      'बोर्ड खाली राख्नुहोस् र आफ्नो कीर्तिमान तोड्नुहोस्।';

  @override
  String get howToPlayIntroSemantics =>
      'खेलको लक्ष्य। बोर्ड खाली राख्नुहोस् र आफ्नो कीर्तिमान तोड्नुहोस्।';

  @override
  String get howToPlayDragTitle => 'तानेर राख्नुहोस्';

  @override
  String get howToPlayDragBody =>
      'तीनवटा टुक्रामध्ये एउटालाई खाली कोठामा तान्नुहोस्। तीनवटै प्रयोग भएपछि, आफैं तीनवटा नयाँ आउँछन्।';

  @override
  String get howToPlayClearTitle => 'लाइन सफा गर्नुहोस्';

  @override
  String get howToPlayClearBody =>
      'पूरा पङ्क्ति वा स्तम्भ भर्नुहोस्। भरिएका लाइन हराउँछन् र अर्को चालका लागि ठाउँ बनाउँछन्।';

  @override
  String get howToPlayComboTitle => 'कम्बो जोड्नुहोस्';

  @override
  String get howToPlayComboBody =>
      'तीन चालभित्र अर्को लाइन सफा गर्नुहोस्। हरेक थप कम्बोले तपाईंको अङ्क गुणक बढाउँछ। कम्बोले सेकेन्ड होइन, चाल गन्छ, त्यसैले सोच्दा यो सकिँदैन।';

  @override
  String get howToPlayFeverTitle => 'फिभर बाल्नुहोस्';

  @override
  String get howToPlayFeverBody =>
      'सफाइले फिभर मिटर भर्छ। भरिएपछि, अर्को विस्फोट दोब्बर गनिन्छ — ठूला सफाइको योजना पहिल्यै बनाउनुहोस्।';

  @override
  String get howToPlayBoosterTitle =>
      'बुस्टर बुद्धिमानीपूर्वक प्रयोग गर्नुहोस्';

  @override
  String get howToPlayBoosterBody =>
      'बुस्टरले कठिन खेल बचाउँछ। तलको टुक्रामा ट्याप गरेर त्यसलाई घुमाउन पनि सकिन्छ।';

  @override
  String get howToPlayDailyTitle => 'दैनिक चुनौती र स्ट्रिक';

  @override
  String get howToPlayDailyBody =>
      'दैनिक चुनौतीमा सबैले उस्तै टुक्रा पाउँछन्। आफ्नो स्ट्रिक र बोनस बढाउन हरेक दिन खेल्नुहोस्।';

  @override
  String get howToPlayPiggyTitle => 'खुत्रुके भर्नुहोस्';

  @override
  String get howToPlayPiggyBody =>
      'सफा गरिएको हरेक लाइनले तपाईंको खुत्रुके भर्छ। भरिएपछि, सिक्का निःशुल्क लिनुहोस्।';

  @override
  String get leaderboardTitle => 'लिडरबोर्ड';

  @override
  String get leaderboardUnreachable =>
      'लिडरबोर्ड उपलब्ध छैन।\nइन्टरनेट जडानसहित फेरि प्रयास गर्नुहोस्।';

  @override
  String get leaderboardEmpty =>
      'अहिलेसम्म कुनै प्रविष्टि छैन।\nपहिलो बन्नुहोस्!';

  @override
  String leaderboardSubmitting(int score) {
    return 'तपाईंको उत्कृष्ट स्कोर ($score) पठाइँदै छ …';
  }

  @override
  String get leaderboardAutoSubmit => 'तपाईंको उत्कृष्ट स्कोर आफैं पठाइनेछ।';

  @override
  String get puzzleModeTitle => 'पजल मोड';

  @override
  String puzzleLevelTitle(int level) {
    return 'पजल $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'चाल: $moves   •   लक्ष्य: 3 ताराका लागि $target';
  }

  @override
  String get puzzleSolved => 'समाधान भयो!';

  @override
  String get puzzleLeaveTitle => 'पजल छोड्ने?';

  @override
  String get puzzleLeaveBody => 'यो पजलमा तपाईंको प्रगति हराउनेछ।';

  @override
  String get puzzleKeepPlaying => 'खेलिरहनुहोस्';

  @override
  String get puzzleLeave => 'छोड्नुहोस्';

  @override
  String get puzzleStuckTitle => 'अड्कियो';

  @override
  String get puzzleRestart => 'फेरि सुरु गर्नुहोस्';

  @override
  String get commonActive => 'सक्रिय';

  @override
  String get commonTapToActivate => 'सक्रिय गर्न ट्याप गर्नुहोस्';

  @override
  String get commonRestore => 'पुनर्स्थापना गर्नुहोस्';

  @override
  String unlockForCost(int cost) {
    return '$cost मा अनलक गर्नुहोस्';
  }

  @override
  String get skinsExchangeGold => 'सुन साट्नुहोस्';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'टुक्रा घुमाउनुहोस्';

  @override
  String get puzzleNextLevel => 'अर्को लेभल';

  @override
  String get puzzleBackToOverview => 'सूचीमा फर्कनुहोस्';

  @override
  String get puzzleUnsolvable => 'यहाँबाट बोर्ड अब खाली गर्न सकिँदैन।';

  @override
  String get puzzleExtraMoveVideo => 'थप चाल (भिडियो)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'समाधान: $solved';
  }

  @override
  String get settingsTitle => 'सेटिङ';

  @override
  String get storageFailureTitle =>
      'Qubble ले तपाईंको सुरक्षित खेल लोड गर्न सकेन';

  @override
  String get storageFailureBody =>
      'कृपया एप फेरि सुरु गर्नुहोस्। समस्या रहिरहे, फेरि इन्स्टल गर्नु नै एक मात्र उपाय हो। सेटिङ › प्रतिक्रियाबाट यसबारे जानकारी दिन सक्नुहुन्छ।';

  @override
  String get iapUnavailable => 'यो प्रस्ताव अहिले उपलब्ध छैन।';

  @override
  String get iapFailed => 'खरिद पूरा भएन। कुनै पैसा काटिएको छैन।';

  @override
  String get settingsResetProgress => 'प्रगति रिसेट गर्नुहोस्';

  @override
  String get settingsResetProgressSubtitle =>
      'स्कोर, सिक्का, लेभल र प्रगति सुरुदेखि। खरिद, नाम र सजावट रहिरहन्छन्।';

  @override
  String get settingsResetConfirmTitle => 'प्रगति रिसेट गर्ने?';

  @override
  String get settingsResetConfirmBody =>
      'उत्कृष्ट स्कोर, सिक्का, लेभल, स्ट्रिक र सबै प्रगति मेटिनेछ। यसलाई फिर्ता ल्याउन सकिँदैन।\n\nतपाईंका खरिद, नाम र अनलक गरिएका थिम तथा स्किन रहिरहन्छन्।';

  @override
  String get settingsResetConfirmAction => 'रिसेट';

  @override
  String get settingsResetDone => 'प्रगति रिसेट भयो।';

  @override
  String get settingsSectionGame => 'खेल';

  @override
  String get settingsSectionSoundHaptics => 'आवाज र कम्पन';

  @override
  String get settingsSectionReminders => 'रिमाइन्डर';

  @override
  String get settingsSectionPurchases => 'खरिद';

  @override
  String get settingsSectionHelpOut => 'सहयोग गर्नुहोस्';

  @override
  String get settingsSectionLegal => 'कानुनी';

  @override
  String get settingsSectionLanguage => 'भाषा';

  @override
  String get settingsGuide => 'कसरी खेल्ने';

  @override
  String get settingsGuideSubtitle => 'नियम, कम्बो, फिभर र बुस्टर';

  @override
  String get settingsSound => 'आवाज';

  @override
  String get settingsMusic => 'सङ्गीत';

  @override
  String get settingsHaptics => 'कम्पन';

  @override
  String get settingsHapticsOff => 'बन्द';

  @override
  String get settingsHapticsLight => 'हल्का';

  @override
  String get settingsHapticsStrong => 'बलियो';

  @override
  String get settingsSectionAccessibility => 'पहुँचयोग्यता';

  @override
  String get settingsReducedEffects => 'कम इफेक्ट';

  @override
  String get settingsReducedEffectsHint => 'कम कण, स्क्रिन हल्लिँदैन, चमक छैन';

  @override
  String get settingsNotifications => 'सूचना';

  @override
  String get settingsNotificationsSubtitle =>
      'दैनिक रिमाइन्डर र स्ट्रिक सुरक्षा';

  @override
  String get settingsNotificationsSystemHint =>
      'प्रणाली सेटिङमा अनुमति दिनुहोस्।';

  @override
  String get settingsLanguageSystem => 'प्रणालीको भाषा';

  @override
  String get settingsSupporterThanks => 'सहयोगका लागि धन्यवाद!';

  @override
  String get settingsSupporterPack => 'समर्थक प्याक';

  @override
  String get settingsSupporterPackSubtitle =>
      'विशेष थिम र स्किन + 1,500 सिक्का';

  @override
  String get settingsRestorePurchases => 'खरिद पुनर्स्थापना गर्नुहोस्';

  @override
  String get settingsRestoring => 'खरिद पुनर्स्थापना हुँदै छ…';

  @override
  String get settingsRateApp => 'एपलाई रेटिङ दिनुहोस्';

  @override
  String get settingsRateAppSubtitle => 'स्टोरमा रेटिङ दिनुहोस्';

  @override
  String get settingsStoreUnavailable => 'यो उपकरणमा स्टोर उपलब्ध छैन।';

  @override
  String get settingsFeedback => 'प्रतिक्रिया पठाउनुहोस्';

  @override
  String get settingsFeedbackSubtitle =>
      'सुझाव र त्रुटि बताउनुहोस् (GitHub मार्फत)';

  @override
  String get settingsAdPrivacy => 'विज्ञापन गोपनीयता';

  @override
  String get settingsAdPrivacySubtitle =>
      'विज्ञापनका लागि आफ्नो सहमति हेर्नुहोस् वा बदल्नुहोस्';

  @override
  String get settingsAdPrivacyUnavailable =>
      'यो उपकरणमा विज्ञापन विकल्प आवश्यक छैन।';

  @override
  String get settingsPrivacy => 'गोपनीयता नीति';

  @override
  String get settingsImprint => 'कानुनी जानकारी';

  @override
  String get settingsPageOpenFailed => 'पेज खोल्न सकिएन।';

  @override
  String get settingsFooter => 'Qubble • अफलाइन ब्लक पजल';

  @override
  String get settingsAdminSection => 'एडमिन (परीक्षण)';

  @override
  String get settingsAdminEnabled => 'एडमिन मोड सक्रिय';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'एडमिन मोडका लागि अझै $count पटक ट्याप गर्नुहोस्';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins सिक्का',
      one: '$coins सिक्का',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'परीक्षणका लागि मात्र — रिलिज स्क्रिनसटमा कहिल्यै होइन';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount सिक्का',
      one: '$amount सिक्का',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'सिक्का 0 गर्नुहोस्';

  @override
  String get feedbackTitle => 'प्रतिक्रिया';

  @override
  String get feedbackIntroShort =>
      'तपाईंलाई के मन पर्छ, के झर्को लाग्छ, के कमी छ? साना कुराले पनि मद्दत गर्छन् — जति स्पष्ट, उति राम्रो।';

  @override
  String feedbackAttachmentNote(String build) {
    return '$build र तपाईंको उपकरणको प्रकार मात्र जोडिन्छ — ताकि कुन संस्करणको कुरा हो भनेर मलाई थाहा होस्।';
  }

  @override
  String get feedbackSendByMail => 'इमेलबाट पठाउनुहोस्';

  @override
  String get feedbackPreferGithub => 'GitHub issue मन पर्छ';

  @override
  String get feedbackThanksMail => 'धन्यवाद! सन्देश पठाए पुग्छ।';

  @override
  String get feedbackNoMailApp =>
      'कुनै मेल एप भेटिएन। तल GitHub बाट प्रयास गर्नुहोस्।';

  @override
  String get feedbackEmptyHint => 'कृपया पहिले केही लेख्नुहोस्।';

  @override
  String get leaderboardRefresh => 'रिफ्रेस गर्नुहोस्';

  @override
  String get leaderboardRetry => 'फेरि प्रयास गर्नुहोस्';

  @override
  String get feedbackHint => 'तपाईंको प्रतिक्रिया…';

  @override
  String get feedbackSubmit => 'प्रतिक्रिया पठाउनुहोस्';

  @override
  String get feedbackOpenFailed => 'GitHub खोल्न सकिएन। पछि प्रयास गर्नुहोस्।';

  @override
  String get feedbackGithubNote =>
      'GitHub खुल्नेछ — त्यहाँ \"Submit new issue\" मा ट्याप गर्नुहोस्। (एक पटक GitHub लगइन चाहिन्छ।)';

  @override
  String get shopTitle => 'पसल';

  @override
  String get shopWebDemoNote =>
      'खरिद Play Store एपमा मात्र उपलब्ध छ। यो वेब संस्करण निःशुल्क डेमो हो — तैपनि यहाँ सबै कुरा खेल्न सकिन्छ।';

  @override
  String get shopSupporterExplainer =>
      'Qubble ले जबरजस्ती विज्ञापन देखाउँदैन — केही किन्नु पर्दैन। समर्थक प्याक (अरोरा थिम, क्रिस्टल स्किन, 1,500 सिक्का, समर्थक ब्याज) खेललाई साथ दिएकोमा धन्यवाद हो। खरिद तपाईंको स्टोर खातासँग जोडिएका हुन्छन् र जुनसुकै बेला पुनर्स्थापना गर्न सकिन्छ।';

  @override
  String get shopSupporterContents =>
      'अरोरा थिम + क्रिस्टल स्किन + 1,500 सिक्का';

  @override
  String get themesTitle => 'थिम';

  @override
  String get themesSupporterOnly => 'समर्थक प्याकमा मात्र (पसल हेर्नुहोस्)';

  @override
  String get themesInSupporterPack => 'समर्थक प्याकमा';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'पर्याप्त सिक्का छैन ($cost चाहिन्छ, तपाईंसँग $coins)';
  }

  @override
  String get skinsTitle => 'ब्लक स्किन';

  @override
  String get skinsNotEnoughDiamonds => 'पर्याप्त हीरा छैन (तल सुन साट्नुहोस्)';

  @override
  String get skinsNotEnoughCoins => 'पर्याप्त सिक्का छैन';

  @override
  String get skinsNotEnoughGold => 'पर्याप्त सुन छैन।';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold सुन = 1 हीरा। हीराले सबैभन्दा सुन्दर स्किन अनलक हुन्छन् — बिस्तारै जम्मा गर्नुहोस्।';
  }

  @override
  String get statsTitle => 'तथ्याङ्क';

  @override
  String get statsAverageScore => 'औसत स्कोर';

  @override
  String get statsBestCombo => 'उत्कृष्ट कम्बो';

  @override
  String get statsGames => 'खेल';

  @override
  String get statsLinesCleared => 'सफा गरिएका लाइन';

  @override
  String get statsPiecesPlaced => 'राखिएका टुक्रा';

  @override
  String get statsCoins => 'सिक्का';

  @override
  String get missionsTitle => 'मिसन';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString टुक्रा राख्नुहोस्',
      one: '$countString टुक्रा राख्नुहोस्',
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
      other: '$countString लाइन सफा गर्नुहोस्',
      one: '$countString लाइन सफा गर्नुहोस्',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString कम्बो बनाउनुहोस्';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'एउटै खेलमा $countString अङ्क पार गर्नुहोस्',
      one: 'एउटै खेलमा $countString अङ्क पार गर्नुहोस्',
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
      other: '$countString खेल खेल्नुहोस्',
      one: '$countString खेल खेल्नुहोस्',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'उपलब्धि';

  @override
  String get achievementFirstGameTitle => 'पहिलो खेल';

  @override
  String get achievementFirstGameBody => 'आफ्नो पहिलो खेल खेल्नुहोस्';

  @override
  String get achievementGames25Title => 'नियमित';

  @override
  String get achievementGames25Body => '25 खेल खेल्नुहोस्';

  @override
  String get achievementGames100Title => 'सोखिन';

  @override
  String get achievementGames100Body => '100 खेल खेल्नुहोस्';

  @override
  String get achievementScore1kTitle => 'उकालो';

  @override
  String get achievementScore1kBody => '1,000 अङ्क बनाउनुहोस्';

  @override
  String get achievementScore5kTitle => 'प्रो';

  @override
  String get achievementScore5kBody => '5,000 अङ्क बनाउनुहोस्';

  @override
  String get achievementScore10kTitle => 'मास्टर';

  @override
  String get achievementScore10kBody => '10,000 अङ्क बनाउनुहोस्';

  @override
  String get achievementScore25kTitle => 'किंवदन्ती';

  @override
  String get achievementScore25kBody => '25,000 अङ्क बनाउनुहोस्';

  @override
  String get achievementLines100Title => 'व्यवस्थित';

  @override
  String get achievementLines100Body => 'जम्मा 100 लाइन सफा गर्नुहोस्';

  @override
  String get achievementLines1000Title => 'ठूलो सफाइ';

  @override
  String get achievementLines1000Body => 'जम्मा 1,000 लाइन सफा गर्नुहोस्';

  @override
  String get achievementCombo5Title => 'कम्बोको सुरुवात';

  @override
  String get achievementCombo5Body => 'x5 कम्बो बनाउनुहोस्';

  @override
  String get achievementCombo10Title => 'कम्बो सम्राट';

  @override
  String get achievementCombo10Body => 'x10 कम्बो बनाउनुहोस्';

  @override
  String get achievementLevel10Title => 'अनुभवी';

  @override
  String get achievementLevel10Body => 'लेभल 10 पुग्नुहोस्';

  @override
  String get achievementLevel20Title => 'पाका खेलाडी';

  @override
  String get achievementLevel20Body => 'लेभल 20 पुग्नुहोस्';

  @override
  String get achievementStreak7Title => 'साप्ताहिक स्ट्रिक';

  @override
  String get achievementStreak7Body => 'लगातार 7 दिनको दैनिक स्ट्रिक';

  @override
  String get achievementStreak30Title => 'मासिक स्ट्रिक';

  @override
  String get achievementStreak30Body => 'लगातार 30 दिनको दैनिक स्ट्रिक';

  @override
  String get achievementPuzzles10Title => 'पजलप्रेमी';

  @override
  String get achievementPuzzles10Body => '10 पजल समाधान गर्नुहोस्';

  @override
  String get achievementPieces5000Title => 'निर्माता';

  @override
  String get achievementPieces5000Body => '5,000 टुक्रा राख्नुहोस्';

  @override
  String streakRepairTitle(int streak) {
    return '$streak दिनको स्ट्रिक खतरामा!';
  }

  @override
  String get streakRepairBody => 'हिजो खेलिएन — आफ्नो स्ट्रिक बचाउनुहोस्:';

  @override
  String get streakRepairFailed => 'मर्मत गर्न सकिएन।';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins सिक्का',
      one: '$coins सिक्का',
    );
    return 'फेरि स्वागत छ! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'रिमाइन्डर?';

  @override
  String get notificationsOptInBody =>
      'तपाईंलाई दैनिक पजलको सम्झना गराऊँ र स्ट्रिक जोगाऊँ? यो सेटिङमा जुनसुकै बेला बदल्न सकिन्छ।';

  @override
  String get notificationsOptInAccept => 'हो, अवश्य';

  @override
  String get notificationChannelDescription =>
      'दैनिक रिमाइन्डर, स्ट्रिक चेतावनी, पुनरागमन';

  @override
  String get notificationDailyTitle => 'तपाईंको दैनिक पजल पर्खिरहेको छ 🧩';

  @override
  String get notificationDailyBody => 'आजको चुनौती खेल्नुहोस्!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 तपाईंको $streak दिनको स्ट्रिक खतरामा!';
  }

  @override
  String get notificationStreakBody => 'यसलाई कायम राख्न आज खेल्नुहोस्।';

  @override
  String get notificationComebackTitle => 'तपाईंका ब्लक पर्खिरहेका छन् 🧩';

  @override
  String get notificationComebackBody => 'फर्कनुहोस् र पुरस्कार लिनुहोस्!';

  @override
  String get iapSupporterPack => 'समर्थक प्याक';

  @override
  String get iapCoinsSmall => '500 सिक्का';

  @override
  String get iapCoinsMedium => '2,000 सिक्का';

  @override
  String get iapCoinsLarge => '6,000 सिक्का';

  @override
  String get iapStarterPack => 'स्टार्टर प्याक';

  @override
  String get iapRename => 'नाम परिवर्तन';

  @override
  String get iapNeonTheme => 'नियोन थिम';

  @override
  String get settingsLeaderboardDelete => 'लिडरबोर्ड प्रविष्टि मेटाउनुहोस्';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'तपाईंको नाम र स्कोर सार्वजनिक सूचीबाट हटाइन्छ';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'आफ्नो प्रविष्टि मेटाउने?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'तपाईंको नाम र स्कोर लिडरबोर्डबाट हटाइनेछ। खेलमा तपाईंको प्रगति बदलिँदैन। जुनसुकै बेला लिडरबोर्डमा फेरि सामेल हुन सकिन्छ।';

  @override
  String get settingsLeaderboardDeleteDone =>
      'तपाईंको लिडरबोर्ड प्रविष्टि मेटाइयो।';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'प्रविष्टि मेटाउन सकिएन। जडान जाँचेर फेरि प्रयास गर्नुहोस्।';

  @override
  String get leaderboardReport => 'यो नामबारे उजुरी गर्नुहोस्';

  @override
  String get leaderboardBlock => 'लुकाउनुहोस्';

  @override
  String leaderboardBlocked(String name) {
    return '$name तपाईंका लागि लुकाइयो';
  }

  @override
  String get leaderboardUndo => 'फिर्ता लिनुहोस्';

  @override
  String leaderboardBlockedCount(int count) {
    return 'तपाईंले लुकाएका प्रविष्टि: $count';
  }

  @override
  String get leaderboardUnblockAll => 'फेरि देखाउनुहोस्';

  @override
  String get leaderboardReportUnavailable => 'अहिले उजुरी गर्न सकिँदैन।';

  @override
  String get leaderboardReportSent => 'धन्यवाद — तपाईंको उजुरी पठाइयो।';

  @override
  String get leaderboardRules =>
      'नामहरू सार्वजनिक हुन्छन्। गाली, अपमान वा कुनै वास्तविक व्यक्ति चिनिने कुनै कुरा नराख्नुहोस्। यो नियम तोड्ने नाम हटाइन्छन्।';

  @override
  String get leaderboardRulesAccept => 'बुझें';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'अनलक: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'सुरक्षित डेटा';

  @override
  String get gameRotatePiece => 'टुक्रा घुमाउनुहोस्';

  @override
  String get themeClassic => 'क्लासिक';

  @override
  String get themeFade => 'प्यास्टल';

  @override
  String get themeNeon => 'नियोन';

  @override
  String get themeOcean => 'समुद्र';

  @override
  String get themeWood => 'काठ';

  @override
  String get themeSunset => 'सूर्यास्त';

  @override
  String get themeForest => 'जङ्गल';

  @override
  String get themeAurora => 'अरोरा';

  @override
  String get skinClassic => 'क्लासिक';

  @override
  String get skinGradient => 'ग्रेडियन्ट';

  @override
  String get skinOutline => 'रूपरेखा';

  @override
  String get skinGlossy => 'चम्किलो';

  @override
  String get skinStripe => 'धर्का';

  @override
  String get skinBevel => 'ढलान';

  @override
  String get skinGlow => 'आभा';

  @override
  String get skinCrystal => 'क्रिस्टल';

  @override
  String rewardThemeName(String name) {
    return '$name थिम';
  }

  @override
  String rewardSkinName(String name) {
    return '$name स्किन';
  }

  @override
  String get skinPulse => 'धड्कन';

  @override
  String get skinShimmer => 'झिलमिल';

  @override
  String get skinWave => 'छाल';

  @override
  String get skinEmber => 'अँगार';

  @override
  String get skinPrism => 'प्रिज्म';

  @override
  String get skinStardust => 'ताराको धूलो';

  @override
  String get skinCircuit => 'सर्किट';

  @override
  String get skinRipple => 'तरङ्ग';

  @override
  String achievementRewardSkin(String name) {
    return 'एनिमेटेड स्किन: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'उपलब्धिको पुरस्कार: $achievement';
  }

  @override
  String get achievementBackpay =>
      'अब उपलब्धिहरूले पुरस्कार दिन्छन् — तपाईंका पुरस्कार थपिएका छन्।';

  @override
  String get namePromptBody =>
      'एउटा नाम छान्नुहोस्, अनि तपाईंको सबैभन्दा राम्रो स्कोर लिडरबोर्डमा पुग्छ। नामबिना तपाईं गुमनाम रूपमा खेलिरहनुहुन्छ।';

  @override
  String get nameTaken => 'यो नाम पहिल्यै लिइसकिएको छ। अर्को प्रयास गर्नुहोस्।';

  @override
  String get nameCheckFailed =>
      'नाम जाँच्न सकिएन। तपाईं अनलाइन हुनुहुन्छ? केही बेरमा फेरि प्रयास गर्नुहोस्।';

  @override
  String nameLost(String name) {
    return '$name अब अर्को खेलाडीको हो। निःशुल्क नयाँ नाम छान्नुहोस्।';
  }

  @override
  String get themeCandy => 'क्यान्डी';

  @override
  String get themeVolcano => 'ज्वालामुखी';

  @override
  String get themeGlacier => 'हिमनदी';

  @override
  String get skinPixel => 'पिक्सेल';

  @override
  String get skinMarble => 'संगमरमर';

  @override
  String get skinJelly => 'जेली';

  @override
  String get skinLiquid => 'तरल';

  @override
  String get skinFizz => 'फोका';

  @override
  String get skinPlasma => 'प्लाज्मा';

  @override
  String get designsTitle => 'डिजाइन';

  @override
  String get designsNotEnoughDiamonds => 'पर्याप्त हीरा छैन।';

  @override
  String get designsOwned => 'तपाईंको';

  @override
  String get designsAchievementOnly => 'उपलब्धि';

  @override
  String get designsSupporterOnly => 'समर्थक';

  @override
  String get designsPreview => 'पूर्वावलोकन';

  @override
  String get designsGetDiamonds => 'हीरा पाउनुहोस्';

  @override
  String get shopDealTitle => 'आजको अफर';

  @override
  String get shopAnimatedSkins => 'एनिमेटेड स्किन';

  @override
  String get shopNewDesigns => 'नयाँ डिजाइन';

  @override
  String get shopDiamonds => 'हीरा';

  @override
  String get shopPacks => 'प्याक';

  @override
  String get shopPopular => 'लोकप्रिय';

  @override
  String get shopBestValue => 'सबैभन्दा सस्तो';

  @override
  String get shopDiamondsBlurb => 'एनिमेटेड स्किन र नयाँ डिजाइनका लागि।';

  @override
  String get shopCoinsBlurb => 'थिम, स्किन र बुस्टरका लागि।';

  @override
  String get shopNeonBlurb => 'नियोन थिम तुरुन्तै अनलक गर्छ।';

  @override
  String get shopRenameBlurb => 'लिडरबोर्डमा आफ्नो नाम बदल्नुहोस्।';

  @override
  String shopHoursLeft(int hours) {
    return '$hours घण्टा बाँकी';
  }

  @override
  String shopNewDealIn(String time) {
    return 'नयाँ अफर $time मा';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name अनलक भयो!';
  }
}
