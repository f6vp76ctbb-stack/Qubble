// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class L10nHi extends L10n {
  L10nHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'खेलें';

  @override
  String get commonLater => 'बाद में';

  @override
  String get commonNotNow => 'अभी नहीं';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonBuy => 'खरीदें';

  @override
  String get commonSave => 'सहेजें';

  @override
  String get commonCollect => 'लें';

  @override
  String get nameNewName => 'नया नाम';

  @override
  String get nameFieldLabel => 'नाम';

  @override
  String get piggyFullTitle => 'गुल्लक भर गई!';

  @override
  String get piggyKeepSaving => 'बचत जारी रखें';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity में से $coins जमा हुए।';
  }

  @override
  String get homeContinueRun => 'जारी रखें';

  @override
  String get homeVideo => 'वीडियो';

  @override
  String get commonGotIt => 'ठीक है';

  @override
  String get commonHome => 'होम';

  @override
  String get commonScore => 'स्कोर';

  @override
  String get commonBest => 'सर्वश्रेष्ठ';

  @override
  String commonLevelShort(int level) {
    return 'लेवल $level';
  }

  @override
  String get homeNewRun => 'नया गेम शुरू करें';

  @override
  String get homeBackToExit => 'बाहर निकलने के लिए फिर से वापस दबाएँ';

  @override
  String get homeEnableLeaderboard => 'लीडरबोर्ड में शामिल हों';

  @override
  String get homeBestScore => 'सर्वश्रेष्ठ स्कोर';

  @override
  String get homeDailyChallenge => 'दैनिक चुनौती';

  @override
  String get homeDailyOpenToday => 'आज खेलना बाकी';

  @override
  String homeDailyNextIn(String time) {
    return 'अगली चुनौती $time में';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'लगातार $streak दिन';
  }

  @override
  String get homeLeaderboard => 'लीडरबोर्ड';

  @override
  String get homePuzzleMode => 'पहेली मोड';

  @override
  String get homeMissions => 'मिशन';

  @override
  String get homeThemes => 'थीम';

  @override
  String get homeSkins => 'स्किन';

  @override
  String get homeHowToPlay => 'Qubble कैसे खेलें';

  @override
  String get homeWeekendBonus => 'वीकेंड: दोगुने सिक्के!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'लेवल $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'नाम बदलें';

  @override
  String get nameChangeExplainer =>
      'आपका नाम लीडरबोर्ड पर आपकी पहचान है, इसलिए यह तय रहता है। आप एक बार नाम बदलने का विकल्प खरीद सकते हैं।';

  @override
  String get nameChangeAfterPurchase =>
      'खरीदने के बाद, नाम बदलने के लिए अपने नाम पर फिर से टैप करें।';

  @override
  String get nameJoinedLeaderboard => 'अब आप लीडरबोर्ड पर हैं।';

  @override
  String get nameRenameUnavailable => 'अभी नाम नहीं बदला जा सकता।';

  @override
  String nameProblemTooShort(int min) {
    return 'कम से कम $min अक्षर।';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'ज़्यादा से ज़्यादा $max अक्षर।';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'केवल अंग्रेज़ी अक्षर (A–Z), अंक, स्पेस, _ और - की अनुमति है।';

  @override
  String get nameProblemOffensive => 'कृपया कोई दूसरा नाम चुनें।';

  @override
  String get piggyTitle => 'गुल्लक';

  @override
  String get piggyFillingHint =>
      'पंक्तियाँ साफ़ करने पर आपकी गुल्लक भरती जाती है।';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins सिक्के मुफ़्त में लें।',
      one: '$coins सिक्का मुफ़्त में लें।',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'भर जाने पर आप इसे मुफ़्त में खाली कर सकते हैं — या बोनस वीडियो देखकर पहले ही खोल सकते हैं।';

  @override
  String get piggyOpenNow => 'अभी खोलें';

  @override
  String get gameNewPiecesVideo => 'नए टुकड़े (वीडियो)';

  @override
  String get gameTapBoardCell => 'बोर्ड पर कोई खाना टैप करें';

  @override
  String get gameDailyChallengeLabel => 'दैनिक चुनौती';

  @override
  String get gameOver => 'गेम ओवर';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'बम के लिए और सिक्के चाहिए: $missing';
  }

  @override
  String get gameBombNotHere => 'बम अभी यहाँ काम नहीं करेगा।';

  @override
  String gameNeedsCoins(String missing) {
    return 'और सिक्के चाहिए: $missing';
  }

  @override
  String get gameNotRightNow => 'अभी संभव नहीं।';

  @override
  String get gameRunSaved =>
      'गेम सहेज लिया गया — मेन्यू में \"जारी रखें\" दबाएँ।';

  @override
  String get gameOverNoFit => 'आपका कोई भी टुकड़ा अब बोर्ड पर फ़िट नहीं होता।';

  @override
  String get gameOverNoFitNoRotations =>
      'कोई टुकड़ा फ़िट नहीं होता — और घुमाने के मौके भी खत्म हो गए।';

  @override
  String get gameStarterOfferUnavailable => 'अभी उपलब्ध नहीं';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — अभी लें';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'कॉम्बो x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'उपलब्धि: $title';
  }

  @override
  String get gameBestSubmitted => 'नया रिकॉर्ड — भेज दिया गया';

  @override
  String get gameReviveFor => 'खेलते रहें · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'अनलॉक हुआ: $name';
  }

  @override
  String get gameStarterOfferTitle => 'स्टार्टर पैक';

  @override
  String gameOverPoints(int score) {
    return '$score अंक';
  }

  @override
  String get gameNewRecord => 'नया रिकॉर्ड!';

  @override
  String gameStreakDays(int streak) {
    return 'लगातार $streak दिन';
  }

  @override
  String get gameDoubleCoins => 'सिक्के दोगुने करें';

  @override
  String get gameDoubleDaily => 'दैनिक इनाम दोगुना करें';

  @override
  String get gamePlayAgain => 'फिर से खेलें';

  @override
  String gameLevelReached(int level) {
    return 'लेवल $level मिल गया!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count लेवल ऊपर — अब लेवल $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 सिक्के + लकड़ी थीम';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'सिर्फ़ $hours घंटे बाकी — केवल एक बार!';
  }

  @override
  String get boosterUndo => 'वापस लें';

  @override
  String get boosterSwap => 'बदलें';

  @override
  String get boosterBomb => 'बम';

  @override
  String get boosterNoRotationsLeft =>
      'घुमाने के मौके खत्म — रिचार्ज के लिए पंक्तियाँ साफ़ करें!';

  @override
  String get onboardingDragPiece => 'एक ब्लॉक को बोर्ड पर खींचें';

  @override
  String get onboardingFillLine => 'पूरी पंक्ति या कॉलम भरें';

  @override
  String get onboardingLinesClear => 'भरी हुई लाइनें गायब हो जाती हैं — अंक!';

  @override
  String get coachHintCombo =>
      'कॉम्बो! इसे बनाए रखने के लिए 3 चालों में फिर से साफ़ करें';

  @override
  String get coachHintFever => 'फ़ीवर! चमक रहने तक अंक दोगुने';

  @override
  String get coachHintRotation =>
      'घुमाने में एक चार्ज लगता है — साफ़ करने से वह वापस भरता है';

  @override
  String get coachHintBooster => 'टिप: नीचे बूस्टर इस्तेमाल कर सकते हैं';

  @override
  String get coachHintStrategy =>
      'टिप: सारी लाइनें एक साथ नहीं — बड़े टुकड़ों के लिए जगह छोड़ें';

  @override
  String get dailyStreakLabel => 'लगातार दिन';

  @override
  String get dailyBestLabel => 'दैनिक सर्वश्रेष्ठ';

  @override
  String dailyHistoryNote(int days) {
    return 'पिछले $days दिनों का रिकॉर्ड रखा जाता है।';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day तारीख: खेला';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day तारीख: नहीं खेला';
  }

  @override
  String get homeDailyCalendar => 'कैलेंडर';

  @override
  String get dailyShareButton => 'नतीजा शेयर करें';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble दैनिक चुनौती $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score अंक · सर्वश्रेष्ठ कॉम्बो x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'खेलें: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'कॉम्बो: $moves चालें बाकी',
      one: 'कॉम्बो: $moves चाल बाकी',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'नतीजा क्लिपबोर्ड पर कॉपी हो गया';

  @override
  String get adNotAvailable =>
      'अभी कोई वीडियो उपलब्ध नहीं — थोड़ी देर में फिर कोशिश करें';

  @override
  String get howToPlaySpeedTitle => 'स्पीड बोनस';

  @override
  String get howToPlaySpeedBody =>
      'जल्दी रखने पर हर क्लियर में 30 % तक अतिरिक्त अंक मिलते हैं। बोनस 1.5 से 4 सेकंड के बीच घटता है और उसकी एक सीमा है, इसलिए तेज़ी फ़ायदेमंद है पर खेल तय नहीं करती — सोच-समझकर खेला गया धीमा गेम भी जल्दबाज़ी वाले गेम को हरा सकता है।';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'स्पीड बोनस $percent प्रतिशत';
  }

  @override
  String get iapDiamondsSmall => '100 हीरे';

  @override
  String get iapDiamondsMedium => '350 हीरे';

  @override
  String get iapDiamondsLarge => '1,000 हीरे';

  @override
  String get howToPlayTitle => 'Qubble कैसे खेलें';

  @override
  String get howToPlayIntroHeadline => 'शुरू करना आसान।\nआगे की सोच का इनाम।';

  @override
  String get howToPlayIntroBody =>
      'बोर्ड को खाली रखें और अपना सर्वश्रेष्ठ स्कोर तोड़ें।';

  @override
  String get howToPlayIntroSemantics =>
      'खेल का लक्ष्य। बोर्ड को खाली रखें और अपना सर्वश्रेष्ठ स्कोर तोड़ें।';

  @override
  String get howToPlayDragTitle => 'खींचें और रखें';

  @override
  String get howToPlayDragBody =>
      'तीन टुकड़ों में से एक को खाली खानों पर खींचें। तीनों इस्तेमाल होते ही आपको अपने-आप तीन नए टुकड़े मिलते हैं।';

  @override
  String get howToPlayClearTitle => 'लाइनें साफ़ करें';

  @override
  String get howToPlayClearBody =>
      'पूरी पंक्ति या कॉलम भरें। भरी हुई लाइनें गायब होकर अगली चाल के लिए जगह बनाती हैं।';

  @override
  String get howToPlayComboTitle => 'कॉम्बो जोड़ें';

  @override
  String get howToPlayComboBody =>
      'तीन चालों के अंदर एक और लाइन साफ़ करें। हर अगला कॉम्बो आपका स्कोर मल्टीप्लायर बढ़ाता है। कॉम्बो सेकंड नहीं, चालें गिनता है, इसलिए सोचते समय यह खत्म नहीं होता।';

  @override
  String get howToPlayFeverTitle => 'फ़ीवर जगाएँ';

  @override
  String get howToPlayFeverBody =>
      'क्लियर करने से फ़ीवर मीटर भरता है। भर जाने पर अगला क्लियर दोगुना गिना जाता है — बड़े क्लियर की पहले से योजना बनाएँ।';

  @override
  String get howToPlayBoosterTitle => 'बूस्टर समझदारी से इस्तेमाल करें';

  @override
  String get howToPlayBoosterBody =>
      'बूस्टर मुश्किल गेम बचाते हैं। ट्रे में किसी टुकड़े पर टैप करके आप उसे घुमा भी सकते हैं।';

  @override
  String get howToPlayDailyTitle => 'दैनिक चुनौती और लगातार दिन';

  @override
  String get howToPlayDailyBody =>
      'दैनिक चुनौती में सबको एक जैसे टुकड़े मिलते हैं। अपने लगातार दिन और बोनस बढ़ाने के लिए हर दिन खेलें।';

  @override
  String get howToPlayPiggyTitle => 'गुल्लक भरें';

  @override
  String get howToPlayPiggyBody =>
      'हर साफ़ की गई लाइन आपकी गुल्लक भरती है। भर जाने पर आप सिक्के मुफ़्त में ले सकते हैं।';

  @override
  String get leaderboardTitle => 'लीडरबोर्ड';

  @override
  String get leaderboardUnreachable =>
      'लीडरबोर्ड उपलब्ध नहीं।\nइंटरनेट कनेक्शन के साथ फिर कोशिश करें।';

  @override
  String get leaderboardEmpty => 'अभी कोई एंट्री नहीं।\nपहले बनें!';

  @override
  String leaderboardSubmitting(int score) {
    return 'आपका सर्वश्रेष्ठ स्कोर ($score) भेजा जा रहा है …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'आपका सर्वश्रेष्ठ स्कोर अपने-आप भेजा जाता है।';

  @override
  String get puzzleModeTitle => 'पहेली मोड';

  @override
  String puzzleLevelTitle(int level) {
    return 'पहेली $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'चालें: $moves   •   लक्ष्य: 3 सितारों के लिए $target';
  }

  @override
  String get puzzleSolved => 'हल हो गई!';

  @override
  String get puzzleLeaveTitle => 'पहेली छोड़ें?';

  @override
  String get puzzleLeaveBody => 'इस पहेली में आपकी प्रगति खो जाएगी।';

  @override
  String get puzzleKeepPlaying => 'खेलते रहें';

  @override
  String get puzzleLeave => 'छोड़ें';

  @override
  String get puzzleStuckTitle => 'रास्ता बंद';

  @override
  String get puzzleRestart => 'फिर से शुरू करें';

  @override
  String get commonActive => 'चालू';

  @override
  String get commonTapToActivate => 'चालू करने के लिए टैप करें';

  @override
  String get commonRestore => 'वापस लाएँ';

  @override
  String unlockForCost(int cost) {
    return '$cost में अनलॉक करें';
  }

  @override
  String get skinsExchangeGold => 'सोना बदलें';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'टुकड़ा घुमाएँ';

  @override
  String get puzzleNextLevel => 'अगला लेवल';

  @override
  String get puzzleBackToOverview => 'सूची पर वापस';

  @override
  String get puzzleUnsolvable =>
      'यहाँ से अब बोर्ड पूरा खाली नहीं किया जा सकता।';

  @override
  String get puzzleExtraMoveVideo => 'एक और चाल (वीडियो)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved हल';
  }

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get storageFailureTitle =>
      'Qubble आपका सहेजा गया गेम लोड नहीं कर पा रहा';

  @override
  String get storageFailureBody =>
      'कृपया ऐप दोबारा शुरू करें। अगर गड़बड़ी बनी रहे, तो केवल दोबारा इंस्टॉल करना ही मदद करेगा। आप इसकी रिपोर्ट सेटिंग्स › फ़ीडबैक भेजें से कर सकते हैं।';

  @override
  String get iapUnavailable => 'यह ऑफ़र अभी उपलब्ध नहीं है।';

  @override
  String get iapFailed => 'खरीदारी पूरी नहीं हुई। कोई शुल्क नहीं लिया गया।';

  @override
  String get settingsResetProgress => 'प्रगति रीसेट करें';

  @override
  String get settingsResetProgressSubtitle =>
      'स्कोर, सिक्के, लेवल और प्रगति शुरुआत पर लौट आते हैं। खरीदारी, नाम और कॉस्मेटिक्स बने रहते हैं।';

  @override
  String get settingsResetConfirmTitle => 'प्रगति रीसेट करें?';

  @override
  String get settingsResetConfirmBody =>
      'सर्वश्रेष्ठ स्कोर, सिक्के, लेवल, लगातार दिन और सारी प्रगति मिट जाएगी। इसे वापस नहीं लाया जा सकता।\n\nआपकी खरीदारी, आपका नाम और अनलॉक की गई थीम व स्किन बनी रहेंगी।';

  @override
  String get settingsResetConfirmAction => 'रीसेट करें';

  @override
  String get settingsResetDone => 'प्रगति रीसेट हो गई।';

  @override
  String get settingsSectionGame => 'गेम';

  @override
  String get settingsSectionSoundHaptics => 'आवाज़ और वाइब्रेशन';

  @override
  String get settingsSectionReminders => 'रिमाइंडर';

  @override
  String get settingsSectionPurchases => 'खरीदारी';

  @override
  String get settingsSectionHelpOut => 'सहयोग करें';

  @override
  String get settingsSectionLegal => 'कानूनी जानकारी';

  @override
  String get settingsSectionLanguage => 'भाषा';

  @override
  String get settingsGuide => 'कैसे खेलें';

  @override
  String get settingsGuideSubtitle => 'नियम, कॉम्बो, फ़ीवर और बूस्टर';

  @override
  String get settingsSound => 'आवाज़';

  @override
  String get settingsMusic => 'संगीत';

  @override
  String get settingsHaptics => 'वाइब्रेशन';

  @override
  String get settingsHapticsOff => 'बंद';

  @override
  String get settingsHapticsLight => 'हल्का';

  @override
  String get settingsHapticsStrong => 'तेज़';

  @override
  String get settingsSectionAccessibility => 'आराम';

  @override
  String get settingsReducedEffects => 'कम इफ़ेक्ट';

  @override
  String get settingsReducedEffectsHint =>
      'कम कण, स्क्रीन का हिलना नहीं, चमक नहीं';

  @override
  String get settingsNotifications => 'सूचनाएँ';

  @override
  String get settingsNotificationsSubtitle =>
      'दैनिक रिमाइंडर और लगातार दिनों की सुरक्षा';

  @override
  String get settingsNotificationsSystemHint =>
      'इसे अपनी सिस्टम सेटिंग्स में अनुमति दें।';

  @override
  String get settingsLanguageSystem => 'सिस्टम की भाषा';

  @override
  String get settingsSupporterThanks => 'सपोर्टर — धन्यवाद!';

  @override
  String get settingsSupporterPack => 'सपोर्टर पैक';

  @override
  String get settingsSupporterPackSubtitle => 'खास थीम और स्किन + 1,500 सिक्के';

  @override
  String get settingsRestorePurchases => 'खरीदारी वापस लाएँ';

  @override
  String get settingsRestoring => 'खरीदारी वापस लाई जा रही है…';

  @override
  String get settingsRateApp => 'ऐप को रेट करें';

  @override
  String get settingsRateAppSubtitle => 'स्टोर में रेटिंग दें';

  @override
  String get settingsStoreUnavailable => 'इस डिवाइस पर स्टोर उपलब्ध नहीं है।';

  @override
  String get settingsFeedback => 'फ़ीडबैक भेजें';

  @override
  String get settingsFeedbackSubtitle => 'सुझाव और बग बताएँ (GitHub से)';

  @override
  String get settingsAdPrivacy => 'विज्ञापन गोपनीयता सेटिंग्स';

  @override
  String get settingsAdPrivacySubtitle => 'अपनी विज्ञापन सहमति देखें या बदलें';

  @override
  String get settingsAdPrivacyUnavailable =>
      'इस डिवाइस पर विज्ञापन विकल्पों की ज़रूरत नहीं है।';

  @override
  String get settingsPrivacy => 'गोपनीयता नीति';

  @override
  String get settingsImprint => 'प्रकाशक जानकारी';

  @override
  String get settingsPageOpenFailed => 'पेज नहीं खुल सका।';

  @override
  String get settingsFooter => 'Qubble • ऑफ़लाइन ब्लॉक पहेली';

  @override
  String get settingsAdminSection => 'एडमिन (टेस्ट)';

  @override
  String get settingsAdminEnabled => 'एडमिन मोड चालू';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'एडमिन मोड के लिए $count बार और टैप करें';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins सिक्के',
      one: '$coins सिक्का',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'केवल टेस्ट के लिए — रिलीज़ स्क्रीनशॉट में कभी न दिखाएँ';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount सिक्के';
  }

  @override
  String get settingsAdminResetCoins => 'सिक्के 0 करें';

  @override
  String get feedbackTitle => 'फ़ीडबैक';

  @override
  String get feedbackIntroShort =>
      'आपको क्या पसंद है, क्या खटकता है, क्या कमी है? छोटी बातें भी मदद करती हैं — जितना सटीक, उतना बेहतर।';

  @override
  String feedbackAttachmentNote(String build) {
    return 'सिर्फ़ $build और आपके डिवाइस का प्रकार जोड़ा जाता है — ताकि पता चले कि बात किस बिल्ड की है।';
  }

  @override
  String get feedbackSendByMail => 'ईमेल से भेजें';

  @override
  String get feedbackPreferGithub => 'GitHub issue से भेजें';

  @override
  String get feedbackThanksMail => 'धन्यवाद! बस संदेश भेज दें।';

  @override
  String get feedbackNoMailApp =>
      'कोई मेल ऐप नहीं मिला। नीचे GitHub वाला तरीका आज़माएँ।';

  @override
  String get feedbackEmptyHint => 'कृपया पहले कुछ लिखें।';

  @override
  String get leaderboardRefresh => 'रीफ़्रेश करें';

  @override
  String get leaderboardRetry => 'फिर कोशिश करें';

  @override
  String get feedbackHint => 'आपका फ़ीडबैक…';

  @override
  String get feedbackSubmit => 'फ़ीडबैक भेजें';

  @override
  String get feedbackOpenFailed =>
      'GitHub नहीं खुल सका। बाद में फिर कोशिश करें।';

  @override
  String get feedbackGithubNote =>
      'GitHub खुलेगा — वहाँ \"Submit new issue\" पर टैप करें। (एक बार GitHub लॉगिन ज़रूरी है।)';

  @override
  String get shopTitle => 'दुकान';

  @override
  String get shopWebDemoNote =>
      'खरीदारी सिर्फ़ Play Store वाले ऐप में उपलब्ध है। यह वेब वर्ज़न मुफ़्त डेमो है — फिर भी आप यहाँ पूरा गेम खेल सकते हैं।';

  @override
  String get shopSupporterExplainer =>
      'Qubble में कोई ज़बरदस्ती वाला विज्ञापन नहीं है — आपको कभी कुछ खरीदना ज़रूरी नहीं। सपोर्टर पैक (ऑरोरा थीम, क्रिस्टल स्किन, 1,500 सिक्के, सपोर्टर बैज) गेम का साथ देने के लिए धन्यवाद है। खरीदारी आपके स्टोर अकाउंट से जुड़ी रहती है और कभी भी वापस लाई जा सकती है।';

  @override
  String get shopSupporterContents =>
      'ऑरोरा थीम + क्रिस्टल स्किन + 1,500 सिक्के';

  @override
  String get themesTitle => 'थीम';

  @override
  String get themesSupporterOnly => 'सिर्फ़ सपोर्टर पैक में (दुकान देखें)';

  @override
  String get themesInSupporterPack => 'सपोर्टर पैक में शामिल';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'सिक्के कम हैं (ज़रूरत $cost, आपके पास $coins)';
  }

  @override
  String get skinsTitle => 'ब्लॉक स्किन';

  @override
  String get skinsNotEnoughDiamonds => 'हीरे कम हैं (नीचे सोना बदलें)';

  @override
  String get skinsNotEnoughCoins => 'सिक्के कम हैं';

  @override
  String get skinsNotEnoughGold => 'सोना कम है।';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold सोना = 1 हीरा। हीरों से सबसे शानदार स्किन खुलती हैं — आराम से इकट्ठा करें।';
  }

  @override
  String get statsTitle => 'आँकड़े';

  @override
  String get statsAverageScore => 'औसत स्कोर';

  @override
  String get statsBestCombo => 'सर्वश्रेष्ठ कॉम्बो';

  @override
  String get statsGames => 'गेम';

  @override
  String get statsLinesCleared => 'साफ़ की गई पंक्तियाँ';

  @override
  String get statsPiecesPlaced => 'रखे गए टुकड़े';

  @override
  String get statsCoins => 'सिक्के';

  @override
  String get missionsTitle => 'मिशन';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString टुकड़े रखें',
      one: '$countString टुकड़ा रखें',
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
      other: '$countString पंक्तियाँ साफ़ करें',
      one: '$countString पंक्ति साफ़ करें',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString कॉम्बो बनाएँ';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'एक गेम में $countString अंक पार करें';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString गेम खेलें';
  }

  @override
  String get achievementsTitle => 'उपलब्धियाँ';

  @override
  String get achievementFirstGameTitle => 'पहला गेम';

  @override
  String get achievementFirstGameBody => 'अपना पहला गेम खेलें';

  @override
  String get achievementGames25Title => 'नियमित खिलाड़ी';

  @override
  String get achievementGames25Body => '25 गेम खेलें';

  @override
  String get achievementGames100Title => 'दीवाना';

  @override
  String get achievementGames100Body => '100 गेम खेलें';

  @override
  String get achievementScore1kTitle => 'पर्वतारोही';

  @override
  String get achievementScore1kBody => '1,000 अंक पाएँ';

  @override
  String get achievementScore5kTitle => 'प्रो';

  @override
  String get achievementScore5kBody => '5,000 अंक पाएँ';

  @override
  String get achievementScore10kTitle => 'उस्ताद';

  @override
  String get achievementScore10kBody => '10,000 अंक पाएँ';

  @override
  String get achievementScore25kTitle => 'दिग्गज';

  @override
  String get achievementScore25kBody => '25,000 अंक पाएँ';

  @override
  String get achievementLines100Title => 'साफ़-सुथरा';

  @override
  String get achievementLines100Body => 'कुल 100 पंक्तियाँ साफ़ करें';

  @override
  String get achievementLines1000Title => 'महासफ़ाई';

  @override
  String get achievementLines1000Body => 'कुल 1,000 पंक्तियाँ साफ़ करें';

  @override
  String get achievementCombo5Title => 'कॉम्बो की शुरुआत';

  @override
  String get achievementCombo5Body => 'x5 कॉम्बो बनाएँ';

  @override
  String get achievementCombo10Title => 'कॉम्बो किंग';

  @override
  String get achievementCombo10Body => 'x10 कॉम्बो बनाएँ';

  @override
  String get achievementLevel10Title => 'अनुभवी';

  @override
  String get achievementLevel10Body => 'लेवल 10 तक पहुँचें';

  @override
  String get achievementLevel20Title => 'पुराना खिलाड़ी';

  @override
  String get achievementLevel20Body => 'लेवल 20 तक पहुँचें';

  @override
  String get achievementStreak7Title => 'पूरा हफ़्ता';

  @override
  String get achievementStreak7Body => 'दैनिक चुनौती लगातार 7 दिन';

  @override
  String get achievementStreak30Title => 'पूरा महीना';

  @override
  String get achievementStreak30Body => 'दैनिक चुनौती लगातार 30 दिन';

  @override
  String get achievementPuzzles10Title => 'पहेली मास्टर';

  @override
  String get achievementPuzzles10Body => '10 पहेलियाँ हल करें';

  @override
  String get achievementPieces5000Title => 'निर्माता';

  @override
  String get achievementPieces5000Body => '5,000 टुकड़े रखें';

  @override
  String streakRepairTitle(int streak) {
    return 'लगातार $streak दिनों का सिलसिला खतरे में!';
  }

  @override
  String get streakRepairBody => 'आपने कल नहीं खेला — अपना सिलसिला बचाएँ:';

  @override
  String get streakRepairFailed => 'ठीक नहीं किया जा सकता।';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins सिक्के',
      one: '$coins सिक्का',
    );
    return 'वापसी पर स्वागत है! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'रिमाइंडर?';

  @override
  String get notificationsOptInBody =>
      'क्या हम आपको आपकी दैनिक पहेली याद दिलाएँ और आपका सिलसिला बचाएँ? आप इसे कभी भी सेटिंग्स में बदल सकते हैं।';

  @override
  String get notificationsOptInAccept => 'हाँ, ज़रूर';

  @override
  String get notificationChannelDescription =>
      'दैनिक रिमाइंडर, सिलसिले की चेतावनी, वापसी का न्योता';

  @override
  String get notificationDailyTitle => 'आपकी दैनिक पहेली इंतज़ार कर रही है 🧩';

  @override
  String get notificationDailyBody => 'आज की चुनौती खेलें!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 आपका $streak दिनों का सिलसिला खतरे में है!';
  }

  @override
  String get notificationStreakBody => 'इसे बचाने के लिए आज खेलें।';

  @override
  String get notificationComebackTitle => 'आपकी पहेली आपको याद कर रही है 🧩';

  @override
  String get notificationComebackBody => 'वापस आएँ और अपना तोहफ़ा लें!';

  @override
  String get iapSupporterPack => 'सपोर्टर पैक';

  @override
  String get iapCoinsSmall => '500 सिक्के';

  @override
  String get iapCoinsMedium => '2,000 सिक्के';

  @override
  String get iapCoinsLarge => '6,000 सिक्के';

  @override
  String get iapStarterPack => 'स्टार्टर पैक';

  @override
  String get iapRename => 'नाम बदलना';

  @override
  String get iapNeonTheme => 'नियॉन थीम';

  @override
  String get settingsLeaderboardDelete => 'लीडरबोर्ड एंट्री हटाएँ';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'सार्वजनिक सूची से आपका नाम और स्कोर हटाता है';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'अपनी एंट्री हटाएँ?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'आपका नाम और स्कोर लीडरबोर्ड से हटा दिया जाएगा। आपकी गेम प्रगति पर कोई असर नहीं पड़ेगा। आप कभी भी फिर से लीडरबोर्ड में शामिल हो सकते हैं।';

  @override
  String get settingsLeaderboardDeleteDone =>
      'आपकी लीडरबोर्ड एंट्री हटा दी गई।';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'एंट्री हटाई नहीं जा सकी। अपना कनेक्शन जाँचें और फिर कोशिश करें।';

  @override
  String get leaderboardReport => 'इस नाम की रिपोर्ट करें';

  @override
  String get leaderboardBlock => 'छिपाएँ';

  @override
  String leaderboardBlocked(String name) {
    return '$name आपके लिए छिपा दिया गया';
  }

  @override
  String get leaderboardUndo => 'पूर्ववत करें';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपने $count एंट्री छिपाई हैं',
      one: 'आपने $count एंट्री छिपाई है',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'फिर से दिखाएँ';

  @override
  String get leaderboardReportUnavailable => 'अभी रिपोर्ट नहीं की जा सकती।';

  @override
  String get leaderboardReportSent => 'धन्यवाद — आपकी रिपोर्ट भेज दी गई है।';

  @override
  String get leaderboardRules =>
      'नाम सार्वजनिक होते हैं। कोई अपमान नहीं, कोई गाली नहीं, और ऐसा कुछ नहीं जिससे किसी असली व्यक्ति की पहचान हो। नियम तोड़ने वाले नाम हटा दिए जाते हैं।';

  @override
  String get leaderboardRulesAccept => 'ठीक है, समझ में आया';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total में से $unlocked अनलॉक';
  }

  @override
  String get settingsSectionData => 'सहेजा गया डेटा';

  @override
  String get gameRotatePiece => 'टुकड़ा घुमाएँ';

  @override
  String get themeClassic => 'क्लासिक';

  @override
  String get themeFade => 'पेस्टल';

  @override
  String get themeNeon => 'नियॉन';

  @override
  String get themeOcean => 'समुद्र';

  @override
  String get themeWood => 'लकड़ी';

  @override
  String get themeSunset => 'सूर्यास्त';

  @override
  String get themeForest => 'जंगल';

  @override
  String get themeAurora => 'ऑरोरा';

  @override
  String get skinClassic => 'क्लासिक';

  @override
  String get skinGradient => 'ग्रेडिएंट';

  @override
  String get skinOutline => 'आउटलाइन';

  @override
  String get skinGlossy => 'चमकदार';

  @override
  String get skinStripe => 'धारियाँ';

  @override
  String get skinBevel => 'बेवल';

  @override
  String get skinGlow => 'ग्लो';

  @override
  String get skinCrystal => 'क्रिस्टल';

  @override
  String rewardThemeName(String name) {
    return '$name थीम';
  }

  @override
  String rewardSkinName(String name) {
    return '$name स्किन';
  }
}
