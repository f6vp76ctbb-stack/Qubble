// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class L10nMr extends L10n {
  L10nMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'खेळा';

  @override
  String get commonLater => 'नंतर';

  @override
  String get commonNotNow => 'आता नको';

  @override
  String get commonCancel => 'रद्द करा';

  @override
  String get commonBuy => 'खरेदी करा';

  @override
  String get commonSave => 'जतन करा';

  @override
  String get commonCollect => 'घ्या';

  @override
  String get nameNewName => 'नवीन नाव';

  @override
  String get nameFieldLabel => 'नाव';

  @override
  String get piggyFullTitle => 'गल्ला भरला!';

  @override
  String get piggyKeepSaving => 'बचत सुरू ठेवा';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity पैकी $coins जमा झाले.';
  }

  @override
  String get homeContinueRun => 'पुढे खेळा';

  @override
  String get homeVideo => 'व्हिडिओ';

  @override
  String get commonGotIt => 'समजले';

  @override
  String get commonHome => 'होम';

  @override
  String get commonScore => 'स्कोअर';

  @override
  String get commonBest => 'सर्वोत्तम';

  @override
  String commonLevelShort(int level) {
    return 'लेव्हल $level';
  }

  @override
  String get homeNewRun => 'नवीन खेळ सुरू करा';

  @override
  String get homeBackToExit => 'बाहेर पडण्यासाठी पुन्हा मागे दाबा';

  @override
  String get homeEnableLeaderboard => 'लीडरबोर्डमध्ये सामील व्हा';

  @override
  String get homeBestScore => 'सर्वोत्तम स्कोअर';

  @override
  String get homeDailyChallenge => 'दैनिक आव्हान';

  @override
  String get homeDailyOpenToday => 'आज खेळायचे बाकी';

  @override
  String homeDailyNextIn(String time) {
    return 'पुढील आव्हान: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'सलग $streak दिवस';
  }

  @override
  String get homeLeaderboard => 'लीडरबोर्ड';

  @override
  String get homePuzzleMode => 'पझल मोड';

  @override
  String get homeMissions => 'मिशन';

  @override
  String get homeThemes => 'थीम';

  @override
  String get homeSkins => 'स्किन';

  @override
  String get homeHowToPlay => 'Qubble कसे खेळायचे';

  @override
  String get homeWeekendBonus => 'वीकेंड: दुप्पट नाणी!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'लेव्हल $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'नाव बदला';

  @override
  String get nameChangeExplainer =>
      'लीडरबोर्डवर तुमचे नाव हीच तुमची ओळख आहे, म्हणून ते कायम राहते. एकदा नाव बदलण्याची सोय खरेदी करता येते.';

  @override
  String get nameChangeAfterPurchase =>
      'खरेदीनंतर, नाव बदलण्यासाठी तुमच्या नावावर पुन्हा टॅप करा.';

  @override
  String get nameJoinedLeaderboard => 'आता तुम्ही लीडरबोर्डवर आहात.';

  @override
  String nameProblemTooShort(int min) {
    return 'किमान अक्षरे: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'जास्तीत जास्त अक्षरे: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'फक्त इंग्रजी अक्षरे (A–Z), अंक, स्पेस, _ आणि - चालतील.';

  @override
  String get nameProblemOffensive => 'कृपया दुसरे नाव निवडा.';

  @override
  String get piggyTitle => 'गल्ला';

  @override
  String get piggyFillingHint => 'ओळी साफ केल्यावर तुमचा गल्ला भरत जातो.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins नाणी मोफत घ्या.',
      one: '$coins नाणे मोफत घ्या.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'भरल्यावर तो मोफत रिकामा करता येतो — किंवा बोनस व्हिडिओ पाहून आधीच उघडता येतो.';

  @override
  String get piggyOpenNow => 'आता उघडा';

  @override
  String get gameNewPiecesVideo => 'नवीन तुकडे (व्हिडिओ)';

  @override
  String get gameTapBoardCell => 'बोर्डवरील एका चौकोनावर टॅप करा';

  @override
  String get gameDailyChallengeLabel => 'दैनिक आव्हान';

  @override
  String get gameOver => 'खेळ संपला';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'बॉम्बसाठी आणखी नाणी हवीत: $missing.';
  }

  @override
  String get gameBombNotHere => 'बॉम्ब सध्या इथे काम करणार नाही.';

  @override
  String gameNeedsCoins(String missing) {
    return 'यासाठी आणखी नाणी हवीत: $missing.';
  }

  @override
  String get gameNotRightNow => 'सध्या शक्य नाही.';

  @override
  String get gameRunSaved => 'खेळ जतन झाला — मेनूमध्ये \"पुढे खेळा\".';

  @override
  String get gameOverNoFit => 'तुमचा कोणताही तुकडा आता बोर्डवर बसत नाही.';

  @override
  String get gameOverNoFitNoRotations =>
      'कोणताही तुकडा बसत नाही — आणि फिरवण्याच्या संधीही संपल्या.';

  @override
  String get gameStarterOfferUnavailable => 'सध्या उपलब्ध नाही';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — घ्या';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'कॉम्बो x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'यश: $title';
  }

  @override
  String get gameBestSubmitted => 'नवीन सर्वोत्तम — पाठवले';

  @override
  String get gameReviveFor => 'खेळ सुरू ठेवा · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'अनलॉक झाले: $name';
  }

  @override
  String get gameStarterOfferTitle => 'स्टार्टर पॅक';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score गुण',
      one: '$score गुण',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'नवीन विक्रम!';

  @override
  String gameStreakDays(int streak) {
    return 'सलग $streak दिवस';
  }

  @override
  String get gameDoubleCoins => 'नाणी दुप्पट करा';

  @override
  String get gameDoubleDaily => 'दैनिक बक्षीस दुप्पट करा';

  @override
  String get gamePlayAgain => 'पुन्हा खेळा';

  @override
  String gameLevelReached(int level) {
    return 'लेव्हल $level गाठली!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count लेव्हल — लेव्हल $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 नाणी + लाकूड थीम';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'फक्त $hours तास बाकी — एकदाच!';
  }

  @override
  String get boosterUndo => 'मागे';

  @override
  String get boosterSwap => 'बदला';

  @override
  String get boosterBomb => 'बॉम्ब';

  @override
  String get boosterNoRotationsLeft =>
      'फिरवण्याच्या संधी संपल्या — पुन्हा मिळवण्यासाठी ओळी साफ करा!';

  @override
  String get onboardingDragPiece => 'एक ब्लॉक ग्रिडवर ओढा';

  @override
  String get onboardingFillLine => 'एक पूर्ण ओळ किंवा स्तंभ भरा';

  @override
  String get onboardingLinesClear => 'भरलेल्या ओळी साफ होतात — गुण!';

  @override
  String get coachHintCombo =>
      'कॉम्बो! टिकवण्यासाठी 3 चालींमध्ये पुन्हा साफ करा';

  @override
  String get coachHintFever => 'फीवर! चमक असेपर्यंत दुप्पट गुण';

  @override
  String get coachHintRotation =>
      'फिरवण्यासाठी एक चार्ज लागतो — साफ केल्यावर तो पुन्हा भरतो';

  @override
  String get coachHintBooster => 'टीप: खाली बूस्टर वापरता येतात';

  @override
  String get coachHintStrategy =>
      'टीप: सर्व ओळी एकाच वेळी नको — मोठ्या तुकड्यांसाठी जागा ठेवा';

  @override
  String get dailyStreakLabel => 'स्ट्रीक';

  @override
  String get dailyBestLabel => 'दैनिक सर्वोत्तम';

  @override
  String dailyHistoryNote(int days) {
    return 'मागील $days दिवस जतन राहतात.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'दिवस $day: खेळले';
  }

  @override
  String dailyDayMissed(int day) {
    return 'दिवस $day: खेळले नाही';
  }

  @override
  String get homeDailyCalendar => 'कॅलेंडर';

  @override
  String get dailyShareButton => 'निकाल शेअर करा';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · दैनिक आव्हान $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'गुण: $score · सर्वोत्तम कॉम्बो x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'खेळा: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'कॉम्बो: आणखी $moves चाली',
      one: 'कॉम्बो: आणखी $moves चाल',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'निकाल क्लिपबोर्डवर कॉपी झाला';

  @override
  String get adNotAvailable =>
      'सध्या व्हिडिओ नाही — थोड्या वेळाने पुन्हा प्रयत्न करा';

  @override
  String get howToPlaySpeedTitle => 'वेग बोनस';

  @override
  String get howToPlaySpeedBody =>
      'पटकन ठेवल्यास प्रत्येक सफाईत 30 % पर्यंत भर पडते. बोनस 1.5 ते 4 सेकंदांदरम्यान कमी होत जातो आणि त्याला मर्यादा आहे, म्हणून वेग उपयोगी पडतो पण खेळाचा निकाल ठरवत नाही — विचारपूर्वक सावकाश खेळलेला खेळ अजूनही घाईच्या वेगवान खेळाला हरवू शकतो.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'वेग बोनस $percent टक्के';
  }

  @override
  String get iapDiamondsSmall => '100 हिरे';

  @override
  String get iapDiamondsMedium => '350 हिरे';

  @override
  String get iapDiamondsLarge => '1,000 हिरे';

  @override
  String get howToPlayTitle => 'Qubble कसे खेळायचे';

  @override
  String get howToPlayIntroHeadline =>
      'सुरुवात सोपी.\nपुढचा विचार करा, जास्त मिळवा.';

  @override
  String get howToPlayIntroBody => 'बोर्ड मोकळा ठेवा आणि तुमचा विक्रम मोडा.';

  @override
  String get howToPlayIntroSemantics =>
      'खेळाचे ध्येय. बोर्ड मोकळा ठेवा आणि तुमचा विक्रम मोडा.';

  @override
  String get howToPlayDragTitle => 'ओढा आणि ठेवा';

  @override
  String get howToPlayDragBody =>
      'तीन तुकड्यांपैकी एक रिकाम्या चौकोनांवर ओढा. तिन्ही वापरल्यावर, आपोआप तीन नवीन मिळतात.';

  @override
  String get howToPlayClearTitle => 'ओळी साफ करा';

  @override
  String get howToPlayClearBody =>
      'एक पूर्ण ओळ किंवा स्तंभ भरा. भरलेल्या ओळी नाहीशा होतात आणि पुढच्या चालीसाठी जागा करतात.';

  @override
  String get howToPlayComboTitle => 'कॉम्बो जोडा';

  @override
  String get howToPlayComboBody =>
      'तीन चालींमध्ये आणखी एक ओळ साफ करा. प्रत्येक जादा कॉम्बो तुमचा गुण गुणक वाढवतो. कॉम्बो सेकंद नाही तर चाली मोजतो, त्यामुळे विचार करताना तो संपत नाही.';

  @override
  String get howToPlayFeverTitle => 'फीवर पेटवा';

  @override
  String get howToPlayFeverBody =>
      'सफाईने फीवर मीटर भरतो. तो भरल्यावर, पुढचा स्फोट दुप्पट मोजला जातो — मोठ्या सफाईची आधीच योजना करा.';

  @override
  String get howToPlayBoosterTitle => 'बूस्टर हुशारीने वापरा';

  @override
  String get howToPlayBoosterBody =>
      'बूस्टर कठीण खेळ वाचवतात. खालच्या तुकड्यावर टॅप करून तो फिरवताही येतो.';

  @override
  String get howToPlayDailyTitle => 'दैनिक आव्हान आणि स्ट्रीक';

  @override
  String get howToPlayDailyBody =>
      'दैनिक आव्हानात सर्वांना सारखेच तुकडे मिळतात. तुमची स्ट्रीक आणि बोनस वाढवण्यासाठी रोज खेळा.';

  @override
  String get howToPlayPiggyTitle => 'गल्ला भरा';

  @override
  String get howToPlayPiggyBody =>
      'साफ केलेली प्रत्येक ओळ तुमचा गल्ला भरते. तो भरल्यावर, नाणी मोफत घ्या.';

  @override
  String get leaderboardTitle => 'लीडरबोर्ड';

  @override
  String get leaderboardUnreachable =>
      'लीडरबोर्ड उपलब्ध नाही.\nइंटरनेट कनेक्शनसह पुन्हा प्रयत्न करा.';

  @override
  String get leaderboardEmpty => 'अजून एकही नोंद नाही.\nपहिले व्हा!';

  @override
  String leaderboardSubmitting(int score) {
    return 'तुमचा सर्वोत्तम स्कोअर ($score) पाठवला जात आहे …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'तुमचा सर्वोत्तम स्कोअर आपोआप पाठवला जाईल.';

  @override
  String get puzzleModeTitle => 'पझल मोड';

  @override
  String puzzleLevelTitle(int level) {
    return 'पझल $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'चाली: $moves   •   लक्ष्य: 3 ताऱ्यांसाठी $target';
  }

  @override
  String get puzzleSolved => 'सुटले!';

  @override
  String get puzzleLeaveTitle => 'पझल सोडायचे?';

  @override
  String get puzzleLeaveBody => 'या पझलमधील तुमची प्रगती नष्ट होईल.';

  @override
  String get puzzleKeepPlaying => 'खेळत राहा';

  @override
  String get puzzleLeave => 'सोडा';

  @override
  String get puzzleStuckTitle => 'अडकलात';

  @override
  String get puzzleRestart => 'पुन्हा सुरू करा';

  @override
  String get commonActive => 'सक्रिय';

  @override
  String get commonTapToActivate => 'सक्रिय करण्यासाठी टॅप करा';

  @override
  String get commonRestore => 'पुनर्संचयित करा';

  @override
  String unlockForCost(int cost) {
    return '$cost मध्ये अनलॉक करा';
  }

  @override
  String get skinsExchangeGold => 'सोने बदला';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'तुकडा फिरवा';

  @override
  String get puzzleNextLevel => 'पुढील लेव्हल';

  @override
  String get puzzleBackToOverview => 'यादीकडे परत';

  @override
  String get puzzleUnsolvable => 'इथून बोर्ड आता रिकामा करता येणार नाही.';

  @override
  String get puzzleExtraMoveVideo => 'जादा चाल (व्हिडिओ)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'सुटलेली: $solved';
  }

  @override
  String get settingsTitle => 'सेटिंग्ज';

  @override
  String get storageFailureTitle =>
      'Qubble तुमचा जतन केलेला खेळ लोड करू शकत नाही';

  @override
  String get storageFailureBody =>
      'कृपया ॲप पुन्हा सुरू करा. त्रुटी कायम राहिल्यास, पुन्हा इंस्टॉल करणे हाच उपाय आहे. सेटिंग्ज › अभिप्राय मधून हे कळवता येईल.';

  @override
  String get iapUnavailable => 'ही ऑफर सध्या उपलब्ध नाही.';

  @override
  String get iapFailed =>
      'खरेदी पूर्ण झाली नाही. कोणतेही पैसे कापले गेले नाहीत.';

  @override
  String get settingsResetProgress => 'प्रगती रीसेट करा';

  @override
  String get settingsResetProgressSubtitle =>
      'स्कोअर, नाणी, लेव्हल आणि प्रगती सुरुवातीपासून. खरेदी, नाव आणि सजावट तशीच राहते.';

  @override
  String get settingsResetConfirmTitle => 'प्रगती रीसेट करायची?';

  @override
  String get settingsResetConfirmBody =>
      'सर्वोत्तम स्कोअर, नाणी, लेव्हल, स्ट्रीक आणि सर्व प्रगती पुसली जाईल. हे परत आणता येणार नाही.\n\nतुमची खरेदी, नाव आणि अनलॉक केलेल्या थीम व स्किन तशाच राहतात.';

  @override
  String get settingsResetConfirmAction => 'रीसेट';

  @override
  String get settingsResetDone => 'प्रगती रीसेट झाली.';

  @override
  String get settingsSectionGame => 'खेळ';

  @override
  String get settingsSectionSoundHaptics => 'आवाज आणि कंपन';

  @override
  String get settingsSectionReminders => 'स्मरणपत्रे';

  @override
  String get settingsSectionPurchases => 'खरेदी';

  @override
  String get settingsSectionHelpOut => 'मदत करा';

  @override
  String get settingsSectionLegal => 'कायदेशीर';

  @override
  String get settingsSectionLanguage => 'भाषा';

  @override
  String get settingsGuide => 'कसे खेळायचे';

  @override
  String get settingsGuideSubtitle => 'नियम, कॉम्बो, फीवर आणि बूस्टर';

  @override
  String get settingsSound => 'आवाज';

  @override
  String get settingsMusic => 'संगीत';

  @override
  String get settingsHaptics => 'कंपन';

  @override
  String get settingsHapticsOff => 'बंद';

  @override
  String get settingsHapticsLight => 'हलके';

  @override
  String get settingsHapticsStrong => 'जोरदार';

  @override
  String get settingsSectionAccessibility => 'सुलभता';

  @override
  String get settingsReducedEffects => 'कमी इफेक्ट';

  @override
  String get settingsReducedEffectsHint => 'कमी कण, स्क्रीन हलत नाही, चमक नाही';

  @override
  String get settingsNotifications => 'सूचना';

  @override
  String get settingsNotificationsSubtitle =>
      'दैनिक स्मरणपत्र आणि स्ट्रीक संरक्षण';

  @override
  String get settingsNotificationsSystemHint =>
      'सिस्टम सेटिंग्जमध्ये परवानगी द्या.';

  @override
  String get settingsLanguageSystem => 'सिस्टमची भाषा';

  @override
  String get settingsSupporterThanks => 'पाठिंब्याबद्दल धन्यवाद!';

  @override
  String get settingsSupporterPack => 'सपोर्टर पॅक';

  @override
  String get settingsSupporterPackSubtitle => 'खास थीम आणि स्किन + 1,500 नाणी';

  @override
  String get settingsRestorePurchases => 'खरेदी पुनर्संचयित करा';

  @override
  String get settingsRestoring => 'खरेदी पुनर्संचयित होत आहे…';

  @override
  String get settingsRateApp => 'ॲपला रेटिंग द्या';

  @override
  String get settingsRateAppSubtitle => 'स्टोअरमध्ये रेटिंग द्या';

  @override
  String get settingsStoreUnavailable => 'या डिव्हाइसवर स्टोअर उपलब्ध नाही.';

  @override
  String get settingsFeedback => 'अभिप्राय पाठवा';

  @override
  String get settingsFeedbackSubtitle =>
      'कल्पना आणि त्रुटी कळवा (GitHub द्वारे)';

  @override
  String get settingsAdPrivacy => 'जाहिरात गोपनीयता';

  @override
  String get settingsAdPrivacySubtitle =>
      'जाहिरातींसाठी तुमची संमती पाहा किंवा बदला';

  @override
  String get settingsAdPrivacyUnavailable =>
      'या डिव्हाइसवर जाहिरात पर्यायांची गरज नाही.';

  @override
  String get settingsPrivacy => 'गोपनीयता धोरण';

  @override
  String get settingsImprint => 'कायदेशीर माहिती';

  @override
  String get settingsPageOpenFailed => 'पेज उघडता आले नाही.';

  @override
  String get settingsFooter => 'Qubble • ऑफलाइन ब्लॉक पझल';

  @override
  String get settingsAdminSection => 'ॲडमिन (चाचणी)';

  @override
  String get settingsAdminEnabled => 'ॲडमिन मोड सुरू';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'ॲडमिन मोडसाठी आणखी $count वेळा टॅप करा';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins नाणी',
      one: '$coins नाणे',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'फक्त चाचणीसाठी — रिलीज स्क्रीनशॉटमध्ये कधीच नाही';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount नाणी',
      one: '$amount नाणे',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'नाणी 0 करा';

  @override
  String get feedbackTitle => 'अभिप्राय';

  @override
  String get feedbackIntroShort =>
      'तुम्हाला काय आवडते, काय त्रास देते, काय कमी आहे? छोट्या गोष्टीही मदत करतात — जितके नेमके, तितके चांगले.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'फक्त $build आणि तुमच्या डिव्हाइसचा प्रकार जोडला जातो — म्हणजे मला कळेल की कोणत्या आवृत्तीबद्दल बोलणे आहे.';
  }

  @override
  String get feedbackSendByMail => 'ईमेलने पाठवा';

  @override
  String get feedbackPreferGithub => 'GitHub issue आवडेल';

  @override
  String get feedbackThanksMail => 'धन्यवाद! फक्त संदेश पाठवा.';

  @override
  String get feedbackNoMailApp =>
      'मेल ॲप सापडले नाही. खाली GitHub द्वारे प्रयत्न करा.';

  @override
  String get feedbackEmptyHint => 'कृपया आधी काहीतरी लिहा.';

  @override
  String get leaderboardRefresh => 'रीफ्रेश करा';

  @override
  String get leaderboardRetry => 'पुन्हा प्रयत्न करा';

  @override
  String get feedbackHint => 'तुमचा अभिप्राय…';

  @override
  String get feedbackSubmit => 'अभिप्राय पाठवा';

  @override
  String get feedbackOpenFailed => 'GitHub उघडता आले नाही. नंतर प्रयत्न करा.';

  @override
  String get feedbackGithubNote =>
      'GitHub उघडेल — तिथे \"Submit new issue\" वर टॅप करा. (एकदा GitHub लॉगिन आवश्यक आहे.)';

  @override
  String get shopTitle => 'दुकान';

  @override
  String get shopWebDemoNote =>
      'खरेदी फक्त Play Store ॲपमध्ये उपलब्ध आहे. ही वेब आवृत्ती मोफत डेमो आहे — तरीही इथे सर्व काही खेळता येते.';

  @override
  String get shopSupporterExplainer =>
      'Qubble सक्तीच्या जाहिराती दाखवत नाही — काहीही खरेदी करण्याची गरज नाही. सपोर्टर पॅक (ऑरोरा थीम, क्रिस्टल स्किन, 1,500 नाणी, सपोर्टर बॅज) खेळाला पाठिंबा दिल्याबद्दल धन्यवाद आहे. खरेदी तुमच्या स्टोअर खात्याशी जोडलेली असते आणि कधीही पुनर्संचयित करता येते.';

  @override
  String get shopSupporterContents => 'ऑरोरा थीम + क्रिस्टल स्किन + 1,500 नाणी';

  @override
  String get themesTitle => 'थीम';

  @override
  String get themesSupporterOnly => 'फक्त सपोर्टर पॅकमध्ये (दुकान पाहा)';

  @override
  String get themesInSupporterPack => 'सपोर्टर पॅकमध्ये';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'पुरेशी नाणी नाहीत ($cost हवीत, तुमच्याकडे $coins)';
  }

  @override
  String get skinsTitle => 'ब्लॉक स्किन';

  @override
  String get skinsNotEnoughDiamonds => 'पुरेसे हिरे नाहीत (खाली सोने बदला)';

  @override
  String get skinsNotEnoughCoins => 'पुरेशी नाणी नाहीत';

  @override
  String get skinsNotEnoughGold => 'पुरेसे सोने नाही.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold सोने = 1 हिरा. हिऱ्यांनी सर्वात सुंदर स्किन अनलॉक होतात — हळूहळू जमा करा.';
  }

  @override
  String get statsTitle => 'आकडेवारी';

  @override
  String get statsAverageScore => 'सरासरी स्कोअर';

  @override
  String get statsBestCombo => 'सर्वोत्तम कॉम्बो';

  @override
  String get statsGames => 'खेळ';

  @override
  String get statsLinesCleared => 'साफ केलेल्या ओळी';

  @override
  String get statsPiecesPlaced => 'ठेवलेले तुकडे';

  @override
  String get statsCoins => 'नाणी';

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
      other: '$countString तुकडे ठेवा',
      one: '$countString तुकडा ठेवा',
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
      other: '$countString ओळी साफ करा',
      one: '$countString ओळ साफ करा',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString कॉम्बो करा';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'एका खेळात $countString गुण पार करा',
      one: 'एका खेळात $countString गुण पार करा',
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
      other: '$countString खेळ खेळा',
      one: '$countString खेळ खेळा',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'यश';

  @override
  String get achievementFirstGameTitle => 'पहिला खेळ';

  @override
  String get achievementFirstGameBody => 'तुमचा पहिला खेळ खेळा';

  @override
  String get achievementGames25Title => 'नियमित';

  @override
  String get achievementGames25Body => '25 खेळ खेळा';

  @override
  String get achievementGames100Title => 'चाहते';

  @override
  String get achievementGames100Body => '100 खेळ खेळा';

  @override
  String get achievementScore1kTitle => 'चढाई';

  @override
  String get achievementScore1kBody => '1,000 गुण मिळवा';

  @override
  String get achievementScore5kTitle => 'प्रो';

  @override
  String get achievementScore5kBody => '5,000 गुण मिळवा';

  @override
  String get achievementScore10kTitle => 'मास्टर';

  @override
  String get achievementScore10kBody => '10,000 गुण मिळवा';

  @override
  String get achievementScore25kTitle => 'दिग्गज';

  @override
  String get achievementScore25kBody => '25,000 गुण मिळवा';

  @override
  String get achievementLines100Title => 'नीटनेटके';

  @override
  String get achievementLines100Body => 'एकूण 100 ओळी साफ करा';

  @override
  String get achievementLines1000Title => 'मोठी सफाई';

  @override
  String get achievementLines1000Body => 'एकूण 1,000 ओळी साफ करा';

  @override
  String get achievementCombo5Title => 'कॉम्बोची सुरुवात';

  @override
  String get achievementCombo5Body => 'x5 कॉम्बो करा';

  @override
  String get achievementCombo10Title => 'कॉम्बो सम्राट';

  @override
  String get achievementCombo10Body => 'x10 कॉम्बो करा';

  @override
  String get achievementLevel10Title => 'अनुभवी';

  @override
  String get achievementLevel10Body => 'लेव्हल 10 गाठा';

  @override
  String get achievementLevel20Title => 'मुरलेले';

  @override
  String get achievementLevel20Body => 'लेव्हल 20 गाठा';

  @override
  String get achievementStreak7Title => 'साप्ताहिक स्ट्रीक';

  @override
  String get achievementStreak7Body => 'सलग 7 दिवसांची दैनिक स्ट्रीक';

  @override
  String get achievementStreak30Title => 'मासिक स्ट्रीक';

  @override
  String get achievementStreak30Body => 'सलग 30 दिवसांची दैनिक स्ट्रीक';

  @override
  String get achievementPuzzles10Title => 'पझलप्रेमी';

  @override
  String get achievementPuzzles10Body => '10 पझल सोडवा';

  @override
  String get achievementPieces5000Title => 'निर्माते';

  @override
  String get achievementPieces5000Body => '5,000 तुकडे ठेवा';

  @override
  String streakRepairTitle(int streak) {
    return '$streak दिवसांची स्ट्रीक धोक्यात!';
  }

  @override
  String get streakRepairBody => 'काल खेळ झाला नाही — तुमची स्ट्रीक वाचवा:';

  @override
  String get streakRepairFailed => 'दुरुस्त करता आले नाही.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins नाणी',
      one: '$coins नाणे',
    );
    return 'पुन्हा स्वागत! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'स्मरणपत्रे?';

  @override
  String get notificationsOptInBody =>
      'तुम्हाला दैनिक पझलची आठवण करून द्यावी आणि तुमची स्ट्रीक जपावी? हे सेटिंग्जमध्ये कधीही बदलता येते.';

  @override
  String get notificationsOptInAccept => 'हो, नक्की';

  @override
  String get notificationChannelDescription =>
      'दैनिक स्मरणपत्र, स्ट्रीक इशारा, पुनरागमन';

  @override
  String get notificationDailyTitle => 'तुमचे दैनिक पझल वाट पाहत आहे 🧩';

  @override
  String get notificationDailyBody => 'आजचे आव्हान खेळा!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 तुमची $streak दिवसांची स्ट्रीक धोक्यात!';
  }

  @override
  String get notificationStreakBody => 'ती टिकवण्यासाठी आज खेळा.';

  @override
  String get notificationComebackTitle => 'तुमचे ब्लॉक वाट पाहत आहेत 🧩';

  @override
  String get notificationComebackBody => 'परत या आणि बक्षीस घ्या!';

  @override
  String get iapSupporterPack => 'सपोर्टर पॅक';

  @override
  String get iapCoinsSmall => '500 नाणी';

  @override
  String get iapCoinsMedium => '2,000 नाणी';

  @override
  String get iapCoinsLarge => '6,000 नाणी';

  @override
  String get iapStarterPack => 'स्टार्टर पॅक';

  @override
  String get iapRename => 'नाव बदल';

  @override
  String get iapNeonTheme => 'निऑन थीम';

  @override
  String get settingsLeaderboardDelete => 'लीडरबोर्ड नोंद हटवा';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'तुमचे नाव आणि स्कोअर सार्वजनिक यादीतून काढले जातात';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'तुमची नोंद हटवायची?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'तुमचे नाव आणि स्कोअर लीडरबोर्डवरून काढले जातील. खेळातील तुमची प्रगती बदलत नाही. लीडरबोर्डमध्ये कधीही पुन्हा सामील होता येते.';

  @override
  String get settingsLeaderboardDeleteDone => 'तुमची लीडरबोर्ड नोंद हटवली.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'नोंद हटवता आली नाही. कनेक्शन तपासा आणि पुन्हा प्रयत्न करा.';

  @override
  String get leaderboardReport => 'या नावाची तक्रार करा';

  @override
  String get leaderboardBlock => 'लपवा';

  @override
  String leaderboardBlocked(String name) {
    return '$name तुमच्यासाठी लपवले';
  }

  @override
  String get leaderboardUndo => 'पूर्ववत करा';

  @override
  String leaderboardBlockedCount(int count) {
    return 'तुम्ही लपवलेल्या नोंदी: $count';
  }

  @override
  String get leaderboardUnblockAll => 'पुन्हा दाखवा';

  @override
  String get leaderboardReportUnavailable => 'सध्या तक्रार करता येत नाही.';

  @override
  String get leaderboardReportSent => 'धन्यवाद — तुमची तक्रार पाठवली.';

  @override
  String get leaderboardRules =>
      'नावे सार्वजनिक असतात. शिवीगाळ, अपमान किंवा खऱ्या व्यक्तीची ओळख पटेल असे काहीही नको. हा नियम मोडणारी नावे काढली जातात.';

  @override
  String get leaderboardRulesAccept => 'समजले';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'अनलॉक: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'जतन केलेला डेटा';

  @override
  String get gameRotatePiece => 'तुकडा फिरवा';

  @override
  String get themeClassic => 'क्लासिक';

  @override
  String get themeFade => 'पेस्टल';

  @override
  String get themeNeon => 'निऑन';

  @override
  String get themeOcean => 'सागर';

  @override
  String get themeWood => 'लाकूड';

  @override
  String get themeSunset => 'सूर्यास्त';

  @override
  String get themeForest => 'जंगल';

  @override
  String get themeAurora => 'ऑरोरा';

  @override
  String get skinClassic => 'क्लासिक';

  @override
  String get skinGradient => 'ग्रेडियंट';

  @override
  String get skinOutline => 'बाह्यरेखा';

  @override
  String get skinGlossy => 'चकचकीत';

  @override
  String get skinStripe => 'पट्टे';

  @override
  String get skinBevel => 'उतार';

  @override
  String get skinGlow => 'तेज';

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

  @override
  String get skinPulse => 'स्पंदन';

  @override
  String get skinShimmer => 'झगमग';

  @override
  String get skinWave => 'लाट';

  @override
  String get skinEmber => 'निखारा';

  @override
  String get skinPrism => 'प्रिझम';

  @override
  String get skinStardust => 'तारकधूळ';

  @override
  String get skinCircuit => 'सर्किट';

  @override
  String get skinRipple => 'तरंग';

  @override
  String achievementRewardSkin(String name) {
    return 'ॲनिमेटेड स्किन: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'यशाचे बक्षीस: $achievement';
  }

  @override
  String get achievementBackpay =>
      'आता यशासाठी बक्षिसे मिळतात — तुमची बक्षिसे जमा झाली आहेत.';

  @override
  String get namePromptBody =>
      'एखादे नाव निवडा, मग तुमचा सर्वोत्तम स्कोअर लीडरबोर्डवर जाईल. नावाशिवाय तुम्ही निनावी खेळत राहता.';

  @override
  String get nameTaken => 'हे नाव आधीच घेतलेले आहे. दुसरे वापरून पाहा.';

  @override
  String get nameCheckFailed =>
      'नाव तपासता आले नाही. तुम्ही ऑनलाइन आहात का? थोड्या वेळाने पुन्हा प्रयत्न करा.';

  @override
  String nameLost(String name) {
    return '$name आता दुसऱ्या खेळाडूचे आहे. नवीन नाव मोफत निवडा.';
  }
}
