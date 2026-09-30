// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class L10nBn extends L10n {
  L10nBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'খেলুন';

  @override
  String get commonLater => 'পরে';

  @override
  String get commonNotNow => 'এখন নয়';

  @override
  String get commonCancel => 'বাতিল করুন';

  @override
  String get commonBuy => 'কিনুন';

  @override
  String get commonSave => 'সংরক্ষণ করুন';

  @override
  String get commonCollect => 'নিন';

  @override
  String get nameNewName => 'নতুন নাম';

  @override
  String get nameFieldLabel => 'নাম';

  @override
  String get piggyFullTitle => 'মাটির ব্যাংক ভরে গেছে!';

  @override
  String get piggyKeepSaving => 'জমানো চালিয়ে যান';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity-এর মধ্যে $coins জমা হয়েছে।';
  }

  @override
  String get homeContinueRun => 'চালিয়ে যান';

  @override
  String get homeVideo => 'ভিডিও';

  @override
  String get commonGotIt => 'বুঝেছি';

  @override
  String get commonHome => 'হোম';

  @override
  String get commonScore => 'স্কোর';

  @override
  String get commonBest => 'সেরা';

  @override
  String commonLevelShort(int level) {
    return 'লেভেল $level';
  }

  @override
  String get homeNewRun => 'নতুন খেলা শুরু করুন';

  @override
  String get homeBackToExit => 'বের হতে আবার ব্যাক চাপুন';

  @override
  String get homeEnableLeaderboard => 'লিডারবোর্ডে যোগ দিন';

  @override
  String get homeBestScore => 'সেরা স্কোর';

  @override
  String get homeDailyChallenge => 'দৈনিক চ্যালেঞ্জ';

  @override
  String get homeDailyOpenToday => 'আজ খেলা বাকি';

  @override
  String homeDailyNextIn(String time) {
    return 'পরের চ্যালেঞ্জ: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'টানা $streak দিন';
  }

  @override
  String get homeLeaderboard => 'লিডারবোর্ড';

  @override
  String get homePuzzleMode => 'পাজল মোড';

  @override
  String get homeHowToPlay => 'Qubble কীভাবে খেলবেন';

  @override
  String get homeWeekendBonus => 'সপ্তাহান্ত: দ্বিগুণ কয়েন!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'লেভেল $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'নাম বদলান';

  @override
  String get nameChangeExplainer =>
      'লিডারবোর্ডে আপনার নামই আপনার পরিচয়, তাই এটি স্থির থাকে। একবার নাম বদলানোর সুযোগ কেনা যায়।';

  @override
  String get nameChangeAfterPurchase =>
      'কেনার পরে, নাম বদলাতে আপনার নামে আবার ট্যাপ করুন।';

  @override
  String get nameJoinedLeaderboard => 'এখন আপনি লিডারবোর্ডে আছেন।';

  @override
  String nameProblemTooShort(int min) {
    return 'কমপক্ষে অক্ষর: $min।';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'সর্বোচ্চ অক্ষর: $max।';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'শুধু লাতিন অক্ষর (যেমন A–Z, é), সংখ্যা, স্পেস, _ এবং - চলবে।';

  @override
  String get nameProblemOffensive => 'অনুগ্রহ করে অন্য একটি নাম বেছে নিন।';

  @override
  String get piggyTitle => 'মাটির ব্যাংক';

  @override
  String get piggyFillingHint => 'লাইন সাফ করলে আপনার মাটির ব্যাংক ভরতে থাকে।';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coinsটি কয়েন বিনামূল্যে নিন।',
      one: '$coinsটি কয়েন বিনামূল্যে নিন।',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'ভরে গেলে বিনামূল্যে খালি করা যায় — অথবা বোনাস ভিডিও দেখে আগেই খোলা যায়।';

  @override
  String get piggyOpenNow => 'এখনই খুলুন';

  @override
  String get gameNewPiecesVideo => 'নতুন টুকরো (ভিডিও)';

  @override
  String get gameTapBoardCell => 'বোর্ডের একটি ঘরে ট্যাপ করুন';

  @override
  String get gameDailyChallengeLabel => 'দৈনিক চ্যালেঞ্জ';

  @override
  String get gameOver => 'খেলা শেষ';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'বোমার জন্য আরও কয়েন লাগবে: $missing।';
  }

  @override
  String get gameBombNotHere => 'বোমা এই মুহূর্তে এখানে কাজ করবে না।';

  @override
  String gameNeedsCoins(String missing) {
    return 'এর জন্য আরও কয়েন লাগবে: $missing।';
  }

  @override
  String get gameNotRightNow => 'এই মুহূর্তে সম্ভব নয়।';

  @override
  String get gameRunSaved => 'খেলা সংরক্ষিত — মেনুতে \"চালিয়ে যান\"।';

  @override
  String get gameOverNoFit => 'আপনার কোনো টুকরোই আর বোর্ডে জায়গা পাচ্ছে না।';

  @override
  String get gameOverNoFitNoRotations =>
      'কোনো টুকরোই জায়গা পাচ্ছে না — আর ঘোরানোর সুযোগও শেষ।';

  @override
  String get gameStarterOfferUnavailable => 'এই মুহূর্তে পাওয়া যাচ্ছে না';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — নিন';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'কম্বো x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'অর্জন: $title';
  }

  @override
  String get gameBestSubmitted => 'নতুন সেরা — পাঠানো হয়েছে';

  @override
  String get gameReviveFor => 'খেলা চালিয়ে যান · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'আনলক হয়েছে: $name';
  }

  @override
  String get gameStarterOfferTitle => 'স্টার্টার প্যাক';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score পয়েন্ট',
      one: '$score পয়েন্ট',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'নতুন রেকর্ড!';

  @override
  String gameStreakDays(int streak) {
    return 'টানা $streak দিন';
  }

  @override
  String get gameDoubleCoins => 'কয়েন দ্বিগুণ করুন';

  @override
  String get gameDoubleDaily => 'দৈনিক পুরস্কার দ্বিগুণ করুন';

  @override
  String get gamePlayAgain => 'আবার খেলুন';

  @override
  String gameLevelReached(int level) {
    return 'লেভেল $level-এ পৌঁছেছেন!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count লেভেল — লেভেল $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 কয়েন + কাঠ থিম';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'মাত্র $hours ঘণ্টা বাকি — শুধু একবার!';
  }

  @override
  String get boosterUndo => 'ফেরত';

  @override
  String get boosterSwap => 'বদলান';

  @override
  String get boosterBomb => 'বোমা';

  @override
  String get boosterNoRotationsLeft =>
      'ঘোরানোর সুযোগ শেষ — আবার পেতে লাইন সাফ করুন!';

  @override
  String get onboardingDragPiece => 'একটি ব্লক গ্রিডে টেনে আনুন';

  @override
  String get onboardingFillLine => 'একটি পুরো সারি বা কলাম ভরুন';

  @override
  String get onboardingLinesClear => 'ভরা লাইন সাফ হয়ে যায় — পয়েন্ট!';

  @override
  String get coachHintCombo => 'কম্বো! ধরে রাখতে 3 চালের মধ্যে আবার সাফ করুন';

  @override
  String get coachHintFever => 'ফিভার! যতক্ষণ জ্বলছে, দ্বিগুণ পয়েন্ট';

  @override
  String get coachHintRotation => 'ঘোরাতে একটি চার্জ লাগে — সাফ করলে আবার ভরে';

  @override
  String get coachHintBooster => 'টিপ: নিচে বুস্টার ব্যবহার করা যায়';

  @override
  String get coachHintStrategy =>
      'টিপ: সব লাইন একসাথে নয় — বড় টুকরোর জন্য জায়গা রাখুন';

  @override
  String get dailyStreakLabel => 'স্ট্রিক';

  @override
  String get dailyBestLabel => 'দৈনিক সেরা';

  @override
  String dailyHistoryNote(int days) {
    return 'গত $days দিন সংরক্ষিত থাকে।';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'দিন $day: খেলেছেন';
  }

  @override
  String dailyDayMissed(int day) {
    return 'দিন $day: খেলেননি';
  }

  @override
  String get homeDailyCalendar => 'ক্যালেন্ডার';

  @override
  String get dailyShareButton => 'ফলাফল শেয়ার করুন';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · দৈনিক চ্যালেঞ্জ $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'পয়েন্ট: $score · সেরা কম্বো x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'খেলুন: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'কম্বো: আর $moves চাল',
      one: 'কম্বো: আর $moves চাল',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'ফলাফল ক্লিপবোর্ডে কপি হয়েছে';

  @override
  String get adNotAvailable =>
      'এই মুহূর্তে কোনো ভিডিও নেই — একটু পরে আবার চেষ্টা করুন';

  @override
  String get howToPlaySpeedTitle => 'গতি বোনাস';

  @override
  String get howToPlaySpeedBody =>
      'দ্রুত বসালে প্রতিটি সাফে 30 % পর্যন্ত যোগ হয়। বোনাসটি 1.5 থেকে 4 সেকেন্ডের মধ্যে কমতে থাকে এবং এর একটি সীমা আছে, তাই গতি কাজে দেয় কিন্তু খেলার ফয়সালা করে না — ভেবেচিন্তে ধীরে খেলা একটি খেলা এখনও তাড়াহুড়োর দ্রুত খেলাকে হারাতে পারে।';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'গতি বোনাস $percent শতাংশ';
  }

  @override
  String get iapDiamondsSmall => '100টি হীরা';

  @override
  String get iapDiamondsMedium => '350টি হীরা';

  @override
  String get iapDiamondsLarge => '1,000টি হীরা';

  @override
  String get howToPlayTitle => 'Qubble কীভাবে খেলবেন';

  @override
  String get howToPlayIntroHeadline => 'শুরু করা সহজ।\nআগে ভাবলে বেশি লাভ।';

  @override
  String get howToPlayIntroBody => 'বোর্ড খালি রাখুন আর নিজের রেকর্ড ভাঙুন।';

  @override
  String get howToPlayIntroSemantics =>
      'খেলার লক্ষ্য। বোর্ড খালি রাখুন আর নিজের রেকর্ড ভাঙুন।';

  @override
  String get howToPlayDragTitle => 'টেনে বসান';

  @override
  String get howToPlayDragBody =>
      'তিনটি টুকরোর একটি খালি ঘরে টেনে আনুন। তিনটিই ব্যবহার হয়ে গেলে, নিজে থেকেই তিনটি নতুন আসে।';

  @override
  String get howToPlayClearTitle => 'লাইন সাফ করুন';

  @override
  String get howToPlayClearBody =>
      'একটি পুরো সারি বা কলাম ভরুন। ভরা লাইন মিলিয়ে যায় আর পরের চালের জন্য জায়গা করে দেয়।';

  @override
  String get howToPlayComboTitle => 'কম্বো গাঁথুন';

  @override
  String get howToPlayComboBody =>
      'তিন চালের মধ্যে আরেকটি লাইন সাফ করুন। প্রতিটি বাড়তি কম্বো আপনার পয়েন্ট গুণক বাড়ায়। কম্বো সেকেন্ড নয়, চাল গোনে, তাই ভাবার সময় এটি শেষ হয় না।';

  @override
  String get howToPlayFeverTitle => 'ফিভার জ্বালান';

  @override
  String get howToPlayFeverBody =>
      'সাফ করলে ফিভার মিটার ভরে। ভরে গেলে, পরের বিস্ফোরণ দ্বিগুণ গোনা হয় — বড় সাফের পরিকল্পনা আগে থেকে করুন।';

  @override
  String get howToPlayBoosterTitle => 'বুস্টার বুঝেশুনে ব্যবহার করুন';

  @override
  String get howToPlayBoosterBody =>
      'বুস্টার কঠিন খেলা বাঁচায়। নিচের টুকরোতে ট্যাপ করে সেটি ঘোরানোও যায়।';

  @override
  String get howToPlayDailyTitle => 'দৈনিক চ্যালেঞ্জ ও স্ট্রিক';

  @override
  String get howToPlayDailyBody =>
      'দৈনিক চ্যালেঞ্জে সবাই একই টুকরো পায়। আপনার স্ট্রিক আর বোনাস বাড়াতে প্রতিদিন খেলুন।';

  @override
  String get howToPlayPiggyTitle => 'মাটির ব্যাংক ভরুন';

  @override
  String get howToPlayPiggyBody =>
      'প্রতিটি সাফ করা লাইন আপনার মাটির ব্যাংক ভরায়। ভরে গেলে, কয়েন বিনামূল্যে নিন।';

  @override
  String get leaderboardTitle => 'লিডারবোর্ড';

  @override
  String get leaderboardUnreachable =>
      'লিডারবোর্ড পাওয়া যাচ্ছে না।\nইন্টারনেট সংযোগসহ আবার চেষ্টা করুন।';

  @override
  String get leaderboardEmpty => 'এখনও কোনো এন্ট্রি নেই।\nপ্রথম হন!';

  @override
  String leaderboardSubmitting(int score) {
    return 'আপনার সেরা স্কোর ($score) পাঠানো হচ্ছে …';
  }

  @override
  String get leaderboardAutoSubmit => 'আপনার সেরা স্কোর নিজে থেকেই পাঠানো হবে।';

  @override
  String get puzzleModeTitle => 'পাজল মোড';

  @override
  String puzzleLevelTitle(int level) {
    return 'পাজল $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'চাল: $moves   •   লক্ষ্য: 3 তারার জন্য $target';
  }

  @override
  String get puzzleSolved => 'সমাধান হয়েছে!';

  @override
  String get puzzleLeaveTitle => 'পাজল ছেড়ে যাবেন?';

  @override
  String get puzzleLeaveBody => 'এই পাজলে আপনার অগ্রগতি হারিয়ে যাবে।';

  @override
  String get puzzleKeepPlaying => 'খেলা চালিয়ে যান';

  @override
  String get puzzleLeave => 'ছেড়ে যান';

  @override
  String get puzzleStuckTitle => 'আটকে গেছেন';

  @override
  String get puzzleRestart => 'আবার শুরু করুন';

  @override
  String get commonActive => 'চালু';

  @override
  String get commonRestore => 'পুনরুদ্ধার করুন';

  @override
  String get skinsExchangeGold => 'সোনা বদলান';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'টুকরো ঘোরান';

  @override
  String get puzzleNextLevel => 'পরের লেভেল';

  @override
  String get puzzleBackToOverview => 'তালিকায় ফিরুন';

  @override
  String get puzzleUnsolvable => 'এখান থেকে বোর্ড আর খালি করা যাবে না।';

  @override
  String get puzzleExtraMoveVideo => 'বাড়তি চাল (ভিডিও)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'সমাধান: $solved';
  }

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get storageFailureTitle =>
      'Qubble আপনার সংরক্ষিত খেলা লোড করতে পারছে না';

  @override
  String get storageFailureBody =>
      'অনুগ্রহ করে অ্যাপটি আবার চালু করুন। সমস্যা থেকে গেলে, আবার ইনস্টল করাই একমাত্র সমাধান। সেটিংস › মতামত দিয়ে এটি জানাতে পারেন।';

  @override
  String get iapUnavailable => 'এই অফারটি এই মুহূর্তে পাওয়া যাচ্ছে না।';

  @override
  String get iapFailed => 'কেনা সম্পূর্ণ হয়নি। কোনো টাকা কাটা হয়নি।';

  @override
  String get settingsResetProgress => 'অগ্রগতি রিসেট করুন';

  @override
  String get settingsResetProgressSubtitle =>
      'স্কোর, কয়েন, লেভেল ও অগ্রগতি শুরু থেকে। কেনাকাটা, নাম ও সাজসজ্জা থেকে যায়।';

  @override
  String get settingsResetConfirmTitle => 'অগ্রগতি রিসেট করবেন?';

  @override
  String get settingsResetConfirmBody =>
      'সেরা স্কোর, কয়েন, লেভেল, স্ট্রিক ও সব অগ্রগতি মুছে যাবে। এটি ফেরানো যাবে না।\n\nআপনার কেনাকাটা, নাম এবং আনলক করা থিম ও স্কিন থেকে যায়।';

  @override
  String get settingsResetConfirmAction => 'রিসেট';

  @override
  String get settingsResetDone => 'অগ্রগতি রিসেট হয়েছে।';

  @override
  String get settingsSectionGame => 'খেলা';

  @override
  String get settingsSectionSoundHaptics => 'শব্দ ও কম্পন';

  @override
  String get settingsSectionReminders => 'রিমাইন্ডার';

  @override
  String get settingsSectionPurchases => 'কেনাকাটা';

  @override
  String get settingsSectionHelpOut => 'সাহায্য করুন';

  @override
  String get settingsSectionLegal => 'আইনি';

  @override
  String get settingsSectionLanguage => 'ভাষা';

  @override
  String get settingsGuide => 'কীভাবে খেলবেন';

  @override
  String get settingsGuideSubtitle => 'নিয়ম, কম্বো, ফিভার ও বুস্টার';

  @override
  String get settingsSound => 'শব্দ';

  @override
  String get settingsMusic => 'সংগীত';

  @override
  String get settingsHaptics => 'কম্পন';

  @override
  String get settingsHapticsOff => 'বন্ধ';

  @override
  String get settingsHapticsLight => 'হালকা';

  @override
  String get settingsHapticsStrong => 'জোরালো';

  @override
  String get settingsSectionAccessibility => 'অ্যাক্সেসিবিলিটি';

  @override
  String get settingsReducedEffects => 'কম ইফেক্ট';

  @override
  String get settingsReducedEffectsHint => 'কম কণা, স্ক্রিন কাঁপে না, ঝলক নেই';

  @override
  String get settingsNotifications => 'বিজ্ঞপ্তি';

  @override
  String get settingsNotificationsSubtitle =>
      'দৈনিক রিমাইন্ডার ও স্ট্রিক সুরক্ষা';

  @override
  String get settingsNotificationsSystemHint => 'সিস্টেম সেটিংসে অনুমতি দিন।';

  @override
  String get settingsLanguageSystem => 'সিস্টেমের ভাষা';

  @override
  String get settingsSupporterThanks => 'সমর্থনের জন্য ধন্যবাদ!';

  @override
  String get settingsSupporterPack => 'সাপোর্টার প্যাক';

  @override
  String get settingsSupporterPackSubtitle => 'বিশেষ থিম ও স্কিন + 1,500 কয়েন';

  @override
  String get settingsRestorePurchases => 'কেনাকাটা পুনরুদ্ধার করুন';

  @override
  String get settingsRestoring => 'কেনাকাটা পুনরুদ্ধার হচ্ছে…';

  @override
  String get settingsRateApp => 'অ্যাপটিকে রেটিং দিন';

  @override
  String get settingsRateAppSubtitle => 'স্টোরে রেটিং দিন';

  @override
  String get settingsStoreUnavailable => 'এই ডিভাইসে স্টোর পাওয়া যাচ্ছে না।';

  @override
  String get settingsFeedback => 'মতামত পাঠান';

  @override
  String get settingsFeedbackSubtitle =>
      'আইডিয়া ও ত্রুটি জানান (GitHub-এর মাধ্যমে)';

  @override
  String get settingsAdPrivacy => 'বিজ্ঞাপন গোপনীয়তা';

  @override
  String get settingsAdPrivacySubtitle =>
      'বিজ্ঞাপনের জন্য আপনার সম্মতি দেখুন বা বদলান';

  @override
  String get settingsAdPrivacyUnavailable =>
      'এই ডিভাইসে বিজ্ঞাপন বিকল্পের দরকার নেই।';

  @override
  String get settingsPrivacy => 'গোপনীয়তা নীতি';

  @override
  String get settingsImprint => 'আইনি তথ্য';

  @override
  String get settingsPageOpenFailed => 'পৃষ্ঠাটি খোলা যায়নি।';

  @override
  String get settingsFooter => 'Qubble • অফলাইন ব্লক পাজল';

  @override
  String get settingsAdminSection => 'অ্যাডমিন (টেস্ট)';

  @override
  String get settingsAdminEnabled => 'অ্যাডমিন মোড চালু';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'অ্যাডমিন মোডের জন্য আর $count বার ট্যাপ করুন';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coinsটি কয়েন',
      one: '$coinsটি কয়েন',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'শুধু টেস্টের জন্য — রিলিজ স্ক্রিনশটে কখনও নয়';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amountটি কয়েন',
      one: '$amountটি কয়েন',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'কয়েন 0 করুন';

  @override
  String get feedbackTitle => 'মতামত';

  @override
  String get feedbackIntroShort =>
      'আপনার কী ভালো লাগে, কী বিরক্ত করে, কী কম আছে? ছোট বিষয়ও কাজে লাগে — যত নির্দিষ্ট, তত ভালো।';

  @override
  String feedbackAttachmentNote(String build) {
    return 'শুধু $build আর আপনার ডিভাইসের ধরন যোগ করা হয় — যাতে আমি জানি কোন সংস্করণের কথা হচ্ছে।';
  }

  @override
  String get feedbackSendByMail => 'ইমেইলে পাঠান';

  @override
  String get feedbackPreferGithub => 'GitHub issue পছন্দ';

  @override
  String get feedbackThanksMail => 'ধন্যবাদ! শুধু বার্তাটি পাঠিয়ে দিন।';

  @override
  String get feedbackNoMailApp =>
      'কোনো মেইল অ্যাপ পাওয়া যায়নি। নিচে GitHub দিয়ে চেষ্টা করুন।';

  @override
  String get feedbackEmptyHint => 'অনুগ্রহ করে আগে কিছু লিখুন।';

  @override
  String get leaderboardRefresh => 'রিফ্রেশ করুন';

  @override
  String get leaderboardRetry => 'আবার চেষ্টা করুন';

  @override
  String get feedbackHint => 'আপনার মতামত…';

  @override
  String get feedbackSubmit => 'মতামত পাঠান';

  @override
  String get feedbackOpenFailed => 'GitHub খোলা যায়নি। পরে চেষ্টা করুন।';

  @override
  String get feedbackGithubNote =>
      'GitHub খুলবে — সেখানে \"Submit new issue\"-এ ট্যাপ করুন। (একবার GitHub-এ লগইন করতে হবে।)';

  @override
  String get shopTitle => 'দোকান';

  @override
  String get shopWebDemoNote =>
      'কেনাকাটা শুধু Play Store অ্যাপে করা যায়। এই ওয়েব সংস্করণটি একটি বিনামূল্যের ডেমো — তবুও এখানে সবকিছু খেলা যায়।';

  @override
  String get shopSupporterExplainer =>
      'Qubble জোর করে বিজ্ঞাপন দেখায় না — কিছু কেনার দরকার নেই। সাপোর্টার প্যাক (অরোরা থিম, ক্রিস্টাল স্কিন, 1,500 কয়েন, সাপোর্টার ব্যাজ) খেলাটির পাশে থাকার জন্য একটি ধন্যবাদ। কেনাকাটা আপনার স্টোর অ্যাকাউন্টের সাথে যুক্ত এবং যেকোনো সময় পুনরুদ্ধার করা যায়।';

  @override
  String get shopSupporterContents =>
      'অরোরা থিম + ক্রিস্টাল স্কিন + 1,500 কয়েন';

  @override
  String get themesTitle => 'থিম';

  @override
  String get themesSupporterOnly => 'শুধু সাপোর্টার প্যাকে (দোকান দেখুন)';

  @override
  String get skinsTitle => 'ব্লক স্কিন';

  @override
  String get skinsNotEnoughCoins => 'যথেষ্ট কয়েন নেই';

  @override
  String get skinsNotEnoughGold => 'যথেষ্ট সোনা নেই।';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold সোনা = 1টি হীরা। হীরা দিয়ে সবচেয়ে সুন্দর স্কিন আনলক হয় — ধীরে ধীরে জমান।';
  }

  @override
  String get statsTitle => 'পরিসংখ্যান';

  @override
  String get statsAverageScore => 'গড় স্কোর';

  @override
  String get statsBestCombo => 'সেরা কম্বো';

  @override
  String get statsGames => 'খেলা';

  @override
  String get statsLinesCleared => 'সাফ করা লাইন';

  @override
  String get statsPiecesPlaced => 'বসানো টুকরো';

  @override
  String get statsCoins => 'কয়েন';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString কম্বো করুন';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'এক খেলায় $countString পয়েন্ট পার করুন',
      one: 'এক খেলায় $countString পয়েন্ট পার করুন',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'অর্জন';

  @override
  String get achievementFirstGameTitle => 'প্রথম খেলা';

  @override
  String get achievementFirstGameBody => 'আপনার প্রথম খেলাটি খেলুন';

  @override
  String get achievementGames25Title => 'নিয়মিত';

  @override
  String get achievementGames25Body => '25টি খেলা খেলুন';

  @override
  String get achievementGames100Title => 'অনুরাগী';

  @override
  String get achievementGames100Body => '100টি খেলা খেলুন';

  @override
  String get achievementScore1kTitle => 'উত্থান';

  @override
  String get achievementScore1kBody => '1,000 পয়েন্ট করুন';

  @override
  String get achievementScore5kTitle => 'প্রো';

  @override
  String get achievementScore5kBody => '5,000 পয়েন্ট করুন';

  @override
  String get achievementScore10kTitle => 'মাস্টার';

  @override
  String get achievementScore10kBody => '10,000 পয়েন্ট করুন';

  @override
  String get achievementScore25kTitle => 'কিংবদন্তি';

  @override
  String get achievementScore25kBody => '25,000 পয়েন্ট করুন';

  @override
  String get achievementLines100Title => 'গোছানো';

  @override
  String get achievementLines100Body => 'মোট 100টি লাইন সাফ করুন';

  @override
  String get achievementLines1000Title => 'বড় সাফাই';

  @override
  String get achievementLines1000Body => 'মোট 1,000টি লাইন সাফ করুন';

  @override
  String get achievementCombo5Title => 'কম্বোর শুরু';

  @override
  String get achievementCombo5Body => 'x5 কম্বো করুন';

  @override
  String get achievementCombo10Title => 'কম্বো সম্রাট';

  @override
  String get achievementCombo10Body => 'x10 কম্বো করুন';

  @override
  String get achievementLevel10Title => 'অভিজ্ঞ';

  @override
  String get achievementLevel10Body => 'লেভেল 10-এ পৌঁছান';

  @override
  String get achievementLevel20Title => 'প্রবীণ';

  @override
  String get achievementLevel20Body => 'লেভেল 20-এ পৌঁছান';

  @override
  String get achievementStreak7Title => 'সাপ্তাহিক স্ট্রিক';

  @override
  String get achievementStreak7Body => 'টানা 7 দিনের দৈনিক স্ট্রিক';

  @override
  String get achievementStreak30Title => 'মাসিক স্ট্রিক';

  @override
  String get achievementStreak30Body => 'টানা 30 দিনের দৈনিক স্ট্রিক';

  @override
  String get achievementPuzzles10Title => 'পাজলপ্রেমী';

  @override
  String get achievementPuzzles10Body => '10টি পাজল সমাধান করুন';

  @override
  String get achievementPieces5000Title => 'নির্মাতা';

  @override
  String get achievementPieces5000Body => '5,000টি টুকরো বসান';

  @override
  String streakRepairTitle(int streak) {
    return '$streak দিনের স্ট্রিক বিপদে!';
  }

  @override
  String get streakRepairBody => 'গতকাল খেলা হয়নি — আপনার স্ট্রিক বাঁচান:';

  @override
  String get streakRepairFailed => 'মেরামত করা যায়নি।';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coinsটি কয়েন',
      one: '$coinsটি কয়েন',
    );
    return 'আবার স্বাগতম! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'রিমাইন্ডার?';

  @override
  String get notificationsOptInBody =>
      'আপনাকে দৈনিক পাজলের কথা মনে করিয়ে দেব আর স্ট্রিক রক্ষা করব? সেটিংসে যেকোনো সময় বদলানো যায়।';

  @override
  String get notificationsOptInAccept => 'হ্যাঁ, অবশ্যই';

  @override
  String get notificationChannelDescription =>
      'দৈনিক রিমাইন্ডার, স্ট্রিক সতর্কতা, ফিরে আসা';

  @override
  String get notificationDailyTitle => 'আপনার দৈনিক পাজল অপেক্ষা করছে 🧩';

  @override
  String get notificationDailyBody => 'আজকের চ্যালেঞ্জ খেলুন!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 আপনার $streak দিনের স্ট্রিক বিপদে!';
  }

  @override
  String get notificationStreakBody => 'ধরে রাখতে আজ খেলুন।';

  @override
  String get notificationComebackTitle => 'আপনার ব্লকগুলো অপেক্ষা করছে 🧩';

  @override
  String get notificationComebackBody => 'ফিরে আসুন আর পুরস্কার নিন!';

  @override
  String get iapSupporterPack => 'সাপোর্টার প্যাক';

  @override
  String get iapCoinsSmall => '500 কয়েন';

  @override
  String get iapCoinsMedium => '2,000 কয়েন';

  @override
  String get iapCoinsLarge => '6,000 কয়েন';

  @override
  String get iapStarterPack => 'স্টার্টার প্যাক';

  @override
  String get iapRename => 'নাম বদল';

  @override
  String get iapNeonTheme => 'নিয়ন থিম';

  @override
  String get settingsLeaderboardDelete => 'লিডারবোর্ড এন্ট্রি মুছুন';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'আপনার নাম ও স্কোর সর্বজনীন তালিকা থেকে সরিয়ে দেয়';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'আপনার এন্ট্রি মুছবেন?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'আপনার নাম ও স্কোর লিডারবোর্ড থেকে সরানো হবে। খেলায় আপনার অগ্রগতি বদলাবে না। যেকোনো সময় আবার লিডারবোর্ডে যোগ দিতে পারেন।';

  @override
  String get settingsLeaderboardDeleteDone =>
      'আপনার লিডারবোর্ড এন্ট্রি মুছে ফেলা হয়েছে।';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'এন্ট্রি মোছা যায়নি। সংযোগ দেখে আবার চেষ্টা করুন।';

  @override
  String get leaderboardReport => 'এই নামটি রিপোর্ট করুন';

  @override
  String get leaderboardBlock => 'লুকান';

  @override
  String leaderboardBlocked(String name) {
    return '$name আপনার জন্য লুকানো হয়েছে';
  }

  @override
  String get leaderboardUndo => 'ফিরিয়ে আনুন';

  @override
  String leaderboardBlockedCount(int count) {
    return 'আপনার লুকানো এন্ট্রি: $count';
  }

  @override
  String get leaderboardUnblockAll => 'আবার দেখান';

  @override
  String get leaderboardReportUnavailable =>
      'এই মুহূর্তে রিপোর্ট করা যাচ্ছে না।';

  @override
  String get leaderboardReportSent => 'ধন্যবাদ — আপনার রিপোর্ট পাঠানো হয়েছে।';

  @override
  String get leaderboardRules =>
      'নাম সর্বজনীন। গালি, অপমান বা কোনো বাস্তব ব্যক্তিকে চেনা যায় এমন কিছু চলবে না। এই নিয়ম ভাঙা নাম সরিয়ে দেওয়া হয়।';

  @override
  String get leaderboardRulesAccept => 'বুঝেছি';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'আনলক: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'সংরক্ষিত ডেটা';

  @override
  String get gameRotatePiece => 'টুকরো ঘোরান';

  @override
  String get themeClassic => 'ক্লাসিক';

  @override
  String get themeFade => 'প্যাস্টেল';

  @override
  String get themeNeon => 'নিয়ন';

  @override
  String get themeOcean => 'সমুদ্র';

  @override
  String get themeWood => 'কাঠ';

  @override
  String get themeSunset => 'সূর্যাস্ত';

  @override
  String get themeForest => 'অরণ্য';

  @override
  String get themeAurora => 'অরোরা';

  @override
  String get skinClassic => 'ক্লাসিক';

  @override
  String get skinGradient => 'গ্রেডিয়েন্ট';

  @override
  String get skinOutline => 'রেখাচিত্র';

  @override
  String get skinGlossy => 'চকচকে';

  @override
  String get skinStripe => 'ডোরা';

  @override
  String get skinBevel => 'ঢাল';

  @override
  String get skinGlow => 'দীপ্তি';

  @override
  String get skinCrystal => 'ক্রিস্টাল';

  @override
  String rewardThemeName(String name) {
    return '$name থিম';
  }

  @override
  String rewardSkinName(String name) {
    return '$name স্কিন';
  }

  @override
  String get skinPulse => 'স্পন্দন';

  @override
  String get skinShimmer => 'ঝিলিক';

  @override
  String get skinWave => 'ঢেউ';

  @override
  String get skinEmber => 'অঙ্গার';

  @override
  String get skinPrism => 'প্রিজম';

  @override
  String get skinStardust => 'তারার ধুলো';

  @override
  String get skinCircuit => 'সার্কিট';

  @override
  String get skinRipple => 'লহরী';

  @override
  String achievementRewardSkin(String name) {
    return 'অ্যানিমেটেড স্কিন: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'অর্জনের পুরস্কার: $achievement';
  }

  @override
  String get achievementBackpay =>
      'অর্জন এখন পুরস্কার দেয় — আপনারগুলো যোগ করা হয়েছে।';

  @override
  String get namePromptBody =>
      'একটি নাম বেছে নিন, তাহলে আপনার সেরা স্কোর লিডারবোর্ডে উঠবে। নাম ছাড়া আপনি বেনামে খেলতে থাকবেন।';

  @override
  String get nameTaken => 'এই নামটি আগেই নেওয়া হয়েছে। অন্য একটি চেষ্টা করুন।';

  @override
  String get nameCheckFailed =>
      'নামটি যাচাই করা যায়নি। আপনি কি অনলাইনে আছেন? একটু পরে আবার চেষ্টা করুন।';

  @override
  String nameLost(String name) {
    return '$name এখন অন্য একজন খেলোয়াড়ের। বিনামূল্যে একটি নতুন নাম বেছে নিন।';
  }

  @override
  String get themeCandy => 'ক্যান্ডি';

  @override
  String get themeVolcano => 'আগ্নেয়গিরি';

  @override
  String get themeGlacier => 'হিমবাহ';

  @override
  String get skinPixel => 'পিক্সেল';

  @override
  String get skinMarble => 'মার্বেল';

  @override
  String get skinJelly => 'জেলি';

  @override
  String get skinLiquid => 'তরল';

  @override
  String get skinFizz => 'বুদবুদ';

  @override
  String get skinPlasma => 'প্লাজমা';

  @override
  String get designsTitle => 'ডিজাইন';

  @override
  String get designsNotEnoughDiamonds => 'যথেষ্ট হীরা নেই।';

  @override
  String get designsOwned => 'আপনার';

  @override
  String get designsAchievementOnly => 'অর্জন';

  @override
  String get designsSupporterOnly => 'সাপোর্টার';

  @override
  String get designsPreview => 'প্রিভিউ';

  @override
  String get designsGetDiamonds => 'হীরা নিন';

  @override
  String get shopDealTitle => 'আজকের অফার';

  @override
  String get shopAnimatedSkins => 'অ্যানিমেটেড স্কিন';

  @override
  String get shopNewDesigns => 'নতুন ডিজাইন';

  @override
  String get shopDiamonds => 'হীরা';

  @override
  String get shopPacks => 'প্যাক';

  @override
  String get shopPopular => 'জনপ্রিয়';

  @override
  String get shopBestValue => 'সেরা মূল্য';

  @override
  String get shopDiamondsBlurb => 'অ্যানিমেটেড স্কিন ও নতুন ডিজাইনের জন্য।';

  @override
  String get shopCoinsBlurb => 'থিম, স্কিন ও বুস্টারের জন্য।';

  @override
  String get shopNeonBlurb => 'নিয়ন থিম সঙ্গে সঙ্গে আনলক করে।';

  @override
  String get shopRenameBlurb => 'লিডারবোর্ডে আপনার নাম বদলান।';

  @override
  String shopHoursLeft(int hours) {
    return 'আর $hours ঘণ্টা';
  }

  @override
  String shopNewDealIn(String time) {
    return 'নতুন অফার $time পরে';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name আনলক হয়েছে!';
  }

  @override
  String get questsTitle => 'কোয়েস্ট';

  @override
  String get questsDaily => 'দৈনিক';

  @override
  String get questsWeekly => 'সাপ্তাহিক';

  @override
  String get questsMonthly => 'মাসিক';

  @override
  String questsNewIn(String time) {
    return 'নতুন কোয়েস্ট $time পরে';
  }

  @override
  String get questsBonus => 'সবগুলোর বোনাস';

  @override
  String get questsBonusEarned => 'বোনাস পাওয়া গেছে';

  @override
  String get questRounds => 'রাউন্ড খেলুন';

  @override
  String get questLines => 'লাইন সাফ করুন';

  @override
  String get questPieces => 'টুকরো বসান';

  @override
  String get questDailyChallenge => 'দৈনিক চ্যালেঞ্জ খেলুন';

  @override
  String get questPuzzles => 'নতুন পাজল সমাধান করুন';

  @override
  String get questDays => 'ভিন্ন ভিন্ন দিনে খেলুন';

  @override
  String get questDailySets => 'সব দৈনিক কোয়েস্ট শেষ করুন';

  @override
  String get questsSetDaily => 'সব দৈনিক কোয়েস্ট শেষ!';

  @override
  String get questsSetWeekly => 'সব সাপ্তাহিক কোয়েস্ট শেষ!';

  @override
  String get questsSetMonthly => 'সব মাসিক কোয়েস্ট শেষ!';

  @override
  String get leaderboardTabScore => 'সেরা স্কোর';

  @override
  String get leaderboardTabPuzzle => 'পাজল তারা';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'আপনার পাজল তারা নিজে থেকেই জমা হয়।';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'আপনার পাজল তারা ($stars) জমা হচ্ছে …';
  }

  @override
  String get dailyGoalTitle => 'আজকের লক্ষ্য';

  @override
  String dailyGoalPoints(String points) {
    return '$points পয়েন্ট';
  }

  @override
  String get dailyChestOpened => 'স্ট্রিকের সিন্দুক খোলা হয়েছে!';

  @override
  String dailyNextChest(int day) {
    return 'পরের সিন্দুক: স্ট্রিকের দিন $day';
  }

  @override
  String get dailyExplainer =>
      'আজ সবাই একই বোর্ডে খেলে, আর তোমার প্রথম রাউন্ডটাই গোনা হয়। বাড়তি কয়েনের জন্য তারার সীমায় পৌঁছাও, হীরার সিন্দুকের জন্য স্ট্রিক ধরে রাখো, আর দেখো আজ তুমি কত নম্বরে।';

  @override
  String dailyRank(int rank, int total) {
    return 'আজ $total জনের মধ্যে $rank নম্বর';
  }

  @override
  String get dailyRankNeedsName => 'র‍্যাঙ্কিংয়ে দেখা যেতে একটি নাম বেছে নাও।';

  @override
  String get dailyRankingButton => 'আজকের র‍্যাঙ্কিং';

  @override
  String get leaderboardTabDaily => 'আজকের চ্যালেঞ্জ';

  @override
  String get leaderboardDailyFooter =>
      'সবার জন্য একই বোর্ড, প্রথম রাউন্ড গোনা হয়। প্রতিদিন নতুন র‍্যাঙ্কিং।';

  @override
  String notificationChestBody(int diamonds) {
    return 'আজকের চ্যালেঞ্জ খেলো আর স্ট্রিকের সিন্দুক খোলো: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'কুমড়া';

  @override
  String get skinGhost => 'ভূত';

  @override
  String get halloweenTitle => 'হ্যালোউইন';

  @override
  String get halloweenBody => 'কুমড়া থিম আর ভূত স্কিন — শুধু অক্টোবরে।';

  @override
  String get designsBackInOctober => 'অক্টোবরে আবার';
}
