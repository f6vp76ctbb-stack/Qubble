// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class L10nUr extends L10n {
  L10nUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'کھیلیں';

  @override
  String get commonLater => 'بعد میں';

  @override
  String get commonNotNow => 'ابھی نہیں';

  @override
  String get commonCancel => 'منسوخ کریں';

  @override
  String get commonBuy => 'خریدیں';

  @override
  String get commonSave => 'محفوظ کریں';

  @override
  String get commonCollect => 'حاصل کریں';

  @override
  String get nameNewName => 'نیا نام';

  @override
  String get nameFieldLabel => 'نام';

  @override
  String get piggyFullTitle => 'گلک بھر گئی ہے!';

  @override
  String get piggyKeepSaving => 'بچت جاری رکھیں';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity میں سے $coins جمع ہو گئے۔';
  }

  @override
  String get homeContinueRun => 'جاری رکھیں';

  @override
  String get homeVideo => 'ویڈیو';

  @override
  String get commonGotIt => 'ٹھیک ہے';

  @override
  String get commonHome => 'ہوم';

  @override
  String get commonScore => 'اسکور';

  @override
  String get commonBest => 'ریکارڈ';

  @override
  String commonLevelShort(int level) {
    return 'لیول $level';
  }

  @override
  String get homeNewRun => 'نیا کھیل شروع کریں';

  @override
  String get homeBackToExit => 'باہر نکلنے کے لیے دوبارہ \'واپس\' دبائیں';

  @override
  String get homeEnableLeaderboard => 'لیڈر بورڈ میں شامل ہوں';

  @override
  String get homeBestScore => 'بہترین اسکور';

  @override
  String get homeDailyChallenge => 'روزانہ چیلنج';

  @override
  String get homeDailyOpenToday => 'آج کھلا ہے';

  @override
  String homeDailyNextIn(String time) {
    return 'اگلا چیلنج $time میں';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'سلسلہ: $streak دن';
  }

  @override
  String get homeLeaderboard => 'لیڈر بورڈ';

  @override
  String get homePuzzleMode => 'پہیلی موڈ';

  @override
  String get homeMissions => 'مشن';

  @override
  String get homeThemes => 'تھیمز';

  @override
  String get homeSkins => 'اسکنز';

  @override
  String get homeHowToPlay => 'Qubble کیسے کھیلیں';

  @override
  String get homeWeekendBonus => 'ویک اینڈ: دگنے سکے!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'لیول $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'نام تبدیل کریں';

  @override
  String get nameChangeExplainer =>
      'آپ کا نام لیڈر بورڈ پر آپ کی پہچان ہے، اس لیے یہ مستقل ہے۔ آپ ایک بار نام تبدیل کرنے کی سہولت خرید سکتے ہیں۔';

  @override
  String get nameChangeAfterPurchase =>
      'خریداری کے بعد اپنے نام پر دوبارہ ٹیپ کر کے اسے تبدیل کریں۔';

  @override
  String get nameJoinedLeaderboard => 'اب آپ لیڈر بورڈ پر ہیں۔';

  @override
  String get nameRenameUnavailable => 'ابھی نام تبدیل نہیں ہو سکتا۔';

  @override
  String nameProblemTooShort(int min) {
    return 'کم از کم $min حروف۔';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'زیادہ سے زیادہ $max حروف۔';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'صرف انگریزی حروف (A–Z)، ہندسے، خالی جگہ، _ اور -۔';

  @override
  String get nameProblemOffensive => 'براہِ کرم کوئی اور نام چنیں۔';

  @override
  String get piggyTitle => 'گلک';

  @override
  String get piggyFillingHint => 'قطاریں صاف کرنے سے آپ کی گلک بھرتی ہے۔';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins سکے',
      one: '$coins سکہ',
    );
    return '$_temp0 حاصل کریں — مفت۔';
  }

  @override
  String get piggyEarlyOpenHint =>
      'بھر جانے پر آپ اسے مفت خالی کر سکتے ہیں — یا بونس ویڈیو دیکھ کر پہلے کھول سکتے ہیں۔';

  @override
  String get piggyOpenNow => 'ابھی کھولیں';

  @override
  String get gameNewPiecesVideo => 'نئے ٹکڑے (ویڈیو)';

  @override
  String get gameTapBoardCell => 'بورڈ پر کسی خانے پر ٹیپ کریں';

  @override
  String get gameDailyChallengeLabel => 'روزانہ چیلنج';

  @override
  String get gameOver => 'کھیل ختم';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'بم کے لیے سکے کم ہیں: $missing۔';
  }

  @override
  String get gameBombNotHere => 'بم یہاں ابھی کام نہیں کرتا۔';

  @override
  String gameNeedsCoins(String missing) {
    return 'سکے کم ہیں: $missing۔';
  }

  @override
  String get gameNotRightNow => 'ابھی ممکن نہیں۔';

  @override
  String get gameRunSaved => 'کھیل محفوظ ہو گیا — مینو میں \'جاری رکھیں\'۔';

  @override
  String get gameOverNoFit => 'آپ کا کوئی ٹکڑا اب بورڈ پر نہیں سماتا۔';

  @override
  String get gameOverNoFitNoRotations =>
      'کوئی ٹکڑا نہیں سماتا — اور گھمانے کی باریاں ختم ہو گئیں۔';

  @override
  String get gameStarterOfferUnavailable => 'ابھی دستیاب نہیں';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — حاصل کریں';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'کومبو x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'کامیابی: $title';
  }

  @override
  String get gameBestSubmitted => 'نیا ریکارڈ — بھیج دیا گیا';

  @override
  String get gameReviveFor => 'کھیل جاری رکھیں · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'ان لاک: $name';
  }

  @override
  String get gameStarterOfferTitle => 'اسٹارٹر پیک';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score پوائنٹس',
      one: '$score پوائنٹ',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'نیا ریکارڈ!';

  @override
  String gameStreakDays(int streak) {
    return 'سلسلہ: $streak دن';
  }

  @override
  String get gameDoubleCoins => 'دگنے سکے';

  @override
  String get gameDoubleDaily => 'دگنا روزانہ انعام';

  @override
  String get gamePlayAgain => 'دوبارہ کھیلیں';

  @override
  String gameLevelReached(int level) {
    return 'لیول $level تک پہنچ گئے!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count لیول — لیول $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 سکے + لکڑی تھیم';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'صرف $hours گھنٹے باقی — صرف ایک بار!';
  }

  @override
  String get boosterUndo => 'واپس';

  @override
  String get boosterSwap => 'تبدیل';

  @override
  String get boosterBomb => 'بم';

  @override
  String get boosterNoRotationsLeft =>
      'گھمانے کی باریاں ختم — دوبارہ بھرنے کے لیے قطاریں صاف کریں!';

  @override
  String get onboardingDragPiece => 'ایک ٹکڑا گرڈ پر گھسیٹیں';

  @override
  String get onboardingFillLine => 'پوری قطار یا کالم بھریں';

  @override
  String get onboardingLinesClear =>
      'بھری ہوئی قطاریں غائب ہو جاتی ہیں — پوائنٹس!';

  @override
  String get coachHintCombo =>
      'کومبو! اسے قائم رکھنے کے لیے 3 چالوں میں دوبارہ صاف کریں';

  @override
  String get coachHintFever => 'فیور! چمکنے تک دگنے پوائنٹس';

  @override
  String get coachHintRotation =>
      'گھمانے پر ایک چارج لگتا ہے — صفائی سے یہ بھر جاتا ہے';

  @override
  String get coachHintBooster => 'مشورہ: نیچے مددگار ٹولز ہیں';

  @override
  String get coachHintStrategy =>
      'مشورہ: سب قطاریں ایک ساتھ نہیں — بڑے ٹکڑوں کے لیے جگہ چھوڑیں';

  @override
  String get dailyStreakLabel => 'سلسلہ';

  @override
  String get dailyBestLabel => 'آج کا ریکارڈ';

  @override
  String dailyHistoryNote(int days) {
    return 'آخری $days دن محفوظ رہتے ہیں۔';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: کھیلا';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: نہیں کھیلا';
  }

  @override
  String get homeDailyCalendar => 'کیلنڈر';

  @override
  String get dailyShareButton => 'نتیجہ شیئر کریں';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · روزانہ چیلنج $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'اسکور: $score · بہترین کومبو x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'کھیلیں: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'کومبو: $moves چالیں باقی',
      one: 'کومبو: $moves چال باقی',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'نتیجہ کاپی ہو گیا';

  @override
  String get adNotAvailable =>
      'ابھی کوئی ویڈیو دستیاب نہیں — تھوڑی دیر بعد دوبارہ کوشش کریں';

  @override
  String get howToPlaySpeedTitle => 'رفتار بونس';

  @override
  String get howToPlaySpeedBody =>
      'تیزی سے رکھنے پر صفائی میں 30% تک اضافہ ہوتا ہے۔ بونس 1.5 سے 4 سیکنڈ کے درمیان کم ہوتا ہے اور اس کی ایک حد ہے، اس لیے تیزی فائدہ دیتی ہے مگر کھیل کا فیصلہ نہیں کرتی — محتاط، آہستہ کھیل اب بھی جلد باز کھیل کو ہرا سکتا ہے۔';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'رفتار بونس $percent فیصد';
  }

  @override
  String get iapDiamondsSmall => '100 ہیرے';

  @override
  String get iapDiamondsMedium => '350 ہیرے';

  @override
  String get iapDiamondsLarge => '1,000 ہیرے';

  @override
  String get howToPlayTitle => 'Qubble کیسے کھیلیں';

  @override
  String get howToPlayIntroHeadline => 'شروع کرنا آسان۔\nمنصوبہ بندی کا انعام۔';

  @override
  String get howToPlayIntroBody => 'بورڈ کو خالی رکھیں اور اپنا ریکارڈ توڑیں۔';

  @override
  String get howToPlayIntroSemantics =>
      'کھیل کا مقصد۔ بورڈ کو خالی رکھیں اور اپنا ریکارڈ توڑیں۔';

  @override
  String get howToPlayDragTitle => 'گھسیٹیں اور رکھیں';

  @override
  String get howToPlayDragBody =>
      'تین میں سے ایک ٹکڑا خالی خانوں پر گھسیٹیں۔ تینوں استعمال ہونے پر خود بخود تین نئے مل جاتے ہیں۔';

  @override
  String get howToPlayClearTitle => 'قطاریں صاف کریں';

  @override
  String get howToPlayClearBody =>
      'پوری قطار یا کالم بھریں۔ بھری ہوئی قطاریں غائب ہو کر اگلی چال کے لیے جگہ بناتی ہیں۔';

  @override
  String get howToPlayComboTitle => 'کومبو کی زنجیر';

  @override
  String get howToPlayComboBody =>
      'تین چالوں کے اندر ایک اور قطار صاف کریں۔ ہر اگلا کومبو پوائنٹس کا ضرب بڑھاتا ہے۔ کومبو چالیں گنتا ہے، سیکنڈ نہیں، اس لیے سوچتے وقت ختم نہیں ہوتا۔';

  @override
  String get howToPlayFeverTitle => 'فیور جگائیں';

  @override
  String get howToPlayFeverBody =>
      'صفائی سے فیور میٹر بھرتا ہے۔ بھر جانے پر اگلی بڑی صفائی دگنی گنی جاتی ہے — بڑی صفائیوں کی پہلے سے منصوبہ بندی کریں۔';

  @override
  String get howToPlayBoosterTitle => 'مددگار ٹولز سمجھداری سے';

  @override
  String get howToPlayBoosterBody =>
      'مددگار ٹولز مشکل کھیل بچاتے ہیں۔ آپ نیچے کسی ٹکڑے پر ٹیپ کر کے اسے گھما بھی سکتے ہیں۔';

  @override
  String get howToPlayDailyTitle => 'روزانہ چیلنج اور سلسلہ';

  @override
  String get howToPlayDailyBody =>
      'روزانہ چیلنج میں سب کو ایک جیسے ٹکڑے ملتے ہیں۔ اپنا سلسلہ اور بونس بڑھانے کے لیے روز کھیلیں۔';

  @override
  String get howToPlayPiggyTitle => 'گلک بھریں';

  @override
  String get howToPlayPiggyBody =>
      'ہر صاف کی گئی قطار آپ کی گلک بھرتی ہے۔ بھر جانے پر آپ سکے مفت حاصل کر سکتے ہیں۔';

  @override
  String get leaderboardTitle => 'لیڈر بورڈ';

  @override
  String get leaderboardUnreachable =>
      'لیڈر بورڈ دستیاب نہیں۔\nانٹرنیٹ کنکشن کے ساتھ دوبارہ کوشش کریں۔';

  @override
  String get leaderboardEmpty => 'ابھی کوئی اندراج نہیں۔\nپہلے آپ بنیں!';

  @override
  String leaderboardSubmitting(int score) {
    return 'آپ کا بہترین اسکور ($score) بھیجا جا رہا ہے …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'آپ کا بہترین اسکور خود بخود بھیجا جاتا ہے۔';

  @override
  String get puzzleModeTitle => 'پہیلی موڈ';

  @override
  String puzzleLevelTitle(int level) {
    return 'پہیلی $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'چالیں: $moves   •   ہدف: 3 ستاروں کے لیے $target';
  }

  @override
  String get puzzleSolved => 'حل ہو گئی!';

  @override
  String get puzzleLeaveTitle => 'پہیلی چھوڑیں؟';

  @override
  String get puzzleLeaveBody => 'اس پہیلی میں آپ کی پیش رفت ضائع ہو جائے گی۔';

  @override
  String get puzzleKeepPlaying => 'کھیلتے رہیں';

  @override
  String get puzzleLeave => 'چھوڑیں';

  @override
  String get puzzleStuckTitle => 'بند گلی';

  @override
  String get puzzleRestart => 'دوبارہ شروع';

  @override
  String get commonActive => 'فعال';

  @override
  String get commonTapToActivate => 'فعال کرنے کے لیے ٹیپ کریں';

  @override
  String get commonRestore => 'بحال کریں';

  @override
  String unlockForCost(int cost) {
    return '$cost میں ان لاک کریں';
  }

  @override
  String get skinsExchangeGold => 'سونا تبدیل کریں';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'ٹکڑا گھمائیں';

  @override
  String get puzzleNextLevel => 'اگلا لیول';

  @override
  String get puzzleBackToOverview => 'جائزے پر واپس';

  @override
  String get puzzleUnsolvable => 'یہاں سے بورڈ اب خالی نہیں ہو سکتا۔';

  @override
  String get puzzleExtraMoveVideo => 'اضافی چال (ویڈیو)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'حل شدہ: $solved';
  }

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get storageFailureTitle => 'Qubble آپ کا محفوظ کھیل لوڈ نہیں کر سکتا';

  @override
  String get storageFailureBody =>
      'براہِ کرم ایپ دوبارہ شروع کریں۔ اگر خرابی برقرار رہے تو صرف دوبارہ انسٹال کرنے سے مدد ملے گی۔ آپ ترتیبات › رائے میں اس کی اطلاع دے سکتے ہیں۔';

  @override
  String get iapUnavailable => 'یہ پیشکش ابھی دستیاب نہیں۔';

  @override
  String get iapFailed => 'خریداری مکمل نہیں ہوئی۔ کوئی رقم نہیں کٹی۔';

  @override
  String get settingsResetProgress => 'پیش رفت ری سیٹ کریں';

  @override
  String get settingsResetProgressSubtitle =>
      'اسکور، سکے، لیول اور پیش رفت شروع سے۔ خریداریاں، نام اور ظاہری اشیاء محفوظ رہیں گی۔';

  @override
  String get settingsResetConfirmTitle => 'پیش رفت ری سیٹ کریں؟';

  @override
  String get settingsResetConfirmBody =>
      'بہترین اسکور، سکے، لیول، سلسلہ اور تمام پیش رفت حذف ہو جائے گی۔ یہ واپس نہیں ہو سکتا۔\n\nآپ کی خریداریاں، نام اور ان لاک شدہ تھیمز و اسکنز محفوظ رہیں گے۔';

  @override
  String get settingsResetConfirmAction => 'ری سیٹ';

  @override
  String get settingsResetDone => 'پیش رفت ری سیٹ ہو گئی۔';

  @override
  String get settingsSectionGame => 'کھیل';

  @override
  String get settingsSectionSoundHaptics => 'آواز اور وائبریشن';

  @override
  String get settingsSectionReminders => 'یاد دہانیاں';

  @override
  String get settingsSectionPurchases => 'خریداریاں';

  @override
  String get settingsSectionHelpOut => 'مدد کریں';

  @override
  String get settingsSectionLegal => 'قانونی معلومات';

  @override
  String get settingsSectionLanguage => 'زبان';

  @override
  String get settingsGuide => 'کیسے کھیلیں';

  @override
  String get settingsGuideSubtitle => 'اصول، کومبو، فیور اور مددگار ٹولز';

  @override
  String get settingsSound => 'آواز';

  @override
  String get settingsMusic => 'موسیقی';

  @override
  String get settingsHaptics => 'وائبریشن';

  @override
  String get settingsHapticsOff => 'بند';

  @override
  String get settingsHapticsLight => 'ہلکی';

  @override
  String get settingsHapticsStrong => 'تیز';

  @override
  String get settingsSectionAccessibility => 'آرام';

  @override
  String get settingsReducedEffects => 'کم اثرات';

  @override
  String get settingsReducedEffectsHint =>
      'کم ذرات، اسکرین کا ہلنا نہیں، چمک نہیں';

  @override
  String get settingsNotifications => 'اطلاعات';

  @override
  String get settingsNotificationsSubtitle =>
      'روزانہ یاد دہانی اور سلسلے کا تحفظ';

  @override
  String get settingsNotificationsSystemHint =>
      'سسٹم کی ترتیبات میں اجازت دیں۔';

  @override
  String get settingsLanguageSystem => 'سسٹم کی زبان';

  @override
  String get settingsSupporterThanks => 'سپورٹر — شکریہ!';

  @override
  String get settingsSupporterPack => 'سپورٹر پیک';

  @override
  String get settingsSupporterPackSubtitle => 'خصوصی تھیم اور اسکن + 1,500 سکے';

  @override
  String get settingsRestorePurchases => 'خریداریاں بحال کریں';

  @override
  String get settingsRestoring => 'خریداریاں بحال ہو رہی ہیں…';

  @override
  String get settingsRateApp => 'ایپ کی درجہ بندی کریں';

  @override
  String get settingsRateAppSubtitle => 'اسٹور میں ریٹنگ دیں';

  @override
  String get settingsStoreUnavailable => 'اس ڈیوائس پر اسٹور دستیاب نہیں۔';

  @override
  String get settingsFeedback => 'رائے بھیجیں';

  @override
  String get settingsFeedbackSubtitle =>
      'آئیڈیاز اور خرابیاں (GitHub کے ذریعے)';

  @override
  String get settingsAdPrivacy => 'اشتہارات کی رازداری';

  @override
  String get settingsAdPrivacySubtitle =>
      'اشتہارات کی رضامندی دیکھیں یا تبدیل کریں';

  @override
  String get settingsAdPrivacyUnavailable =>
      'اس ڈیوائس پر اشتہارات کی کوئی ترتیب درکار نہیں۔';

  @override
  String get settingsPrivacy => 'رازداری کی پالیسی';

  @override
  String get settingsImprint => 'ناشر کی معلومات';

  @override
  String get settingsPageOpenFailed => 'صفحہ نہیں کھل سکا۔';

  @override
  String get settingsFooter => 'Qubble • آف لائن بلاک پزل';

  @override
  String get settingsAdminSection => 'ایڈمن (ٹیسٹ)';

  @override
  String get settingsAdminEnabled => 'ایڈمن موڈ آن ہے';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'ایڈمن موڈ کے لیے مزید $count بار ٹیپ کریں';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins سکے',
      one: '$coins سکہ',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'صرف ٹیسٹنگ کے لیے — ریلیز کے اسکرین شاٹس میں کبھی نہیں';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount سکے';
  }

  @override
  String get settingsAdminResetCoins => 'سکے 0 کریں';

  @override
  String get feedbackTitle => 'رائے';

  @override
  String get feedbackIntroShort =>
      'آپ کو کیا پسند ہے، کیا برا لگتا ہے، کیا کمی ہے؟ چھوٹی باتیں بھی مدد کرتی ہیں — جتنا واضح، اتنا بہتر۔';

  @override
  String feedbackAttachmentNote(String build) {
    return 'صرف $build اور آپ کی ڈیوائس کی قسم منسلک کی جاتی ہے — تاکہ مجھے معلوم ہو کون سا ورژن ہے۔';
  }

  @override
  String get feedbackSendByMail => 'ای میل سے بھیجیں';

  @override
  String get feedbackPreferGithub => 'GitHub issue بہتر ہے';

  @override
  String get feedbackThanksMail => 'شکریہ! بس پیغام بھیج دیں۔';

  @override
  String get feedbackNoMailApp =>
      'کوئی ای میل ایپ نہیں ملی۔ نیچے GitHub والا راستہ آزمائیں۔';

  @override
  String get feedbackEmptyHint => 'پہلے کچھ لکھیں۔';

  @override
  String get leaderboardRefresh => 'ریفریش';

  @override
  String get leaderboardRetry => 'دوبارہ کوشش کریں';

  @override
  String get feedbackHint => 'آپ کی رائے…';

  @override
  String get feedbackSubmit => 'رائے بھیجیں';

  @override
  String get feedbackOpenFailed =>
      'GitHub نہیں کھل سکا۔ بعد میں دوبارہ کوشش کریں۔';

  @override
  String get feedbackGithubNote =>
      'GitHub کھلے گا — وہاں \'Submit new issue\' پر ٹیپ کریں۔ (ایک بار GitHub میں لاگ ان ضروری ہے۔)';

  @override
  String get shopTitle => 'دکان';

  @override
  String get shopWebDemoNote =>
      'خریداری صرف Google Play سے لی گئی ایپ میں ممکن ہے۔ یہ ویب ورژن مفت ڈیمو ہے — آپ یہاں پورا کھیل کھیل سکتے ہیں۔';

  @override
  String get shopSupporterExplainer =>
      'Qubble زبردستی اشتہارات نہیں دکھاتا — آپ کو کبھی کچھ خریدنا نہیں پڑتا۔ سپورٹر پیک (قطبی روشنی تھیم، کرسٹل اسکن، 1,500 سکے، سپورٹر بیج) کھیل کی مدد کرنے پر شکریہ ہے۔ خریداریاں آپ کے اسٹور اکاؤنٹ سے منسلک ہیں اور کسی بھی وقت بحال کی جا سکتی ہیں۔';

  @override
  String get shopSupporterContents =>
      'قطبی روشنی تھیم + کرسٹل اسکن + 1,500 سکے';

  @override
  String get themesTitle => 'تھیمز';

  @override
  String get themesSupporterOnly => 'صرف سپورٹر پیک میں (دکان دیکھیں)';

  @override
  String get themesInSupporterPack => 'سپورٹر پیک میں';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'سکے کافی نہیں ($cost درکار، آپ کے پاس $coins)';
  }

  @override
  String get skinsTitle => 'بلاک اسکنز';

  @override
  String get skinsNotEnoughDiamonds => 'ہیرے کافی نہیں (نیچے سونا تبدیل کریں)';

  @override
  String get skinsNotEnoughCoins => 'سکے کافی نہیں';

  @override
  String get skinsNotEnoughGold => 'سونا کافی نہیں۔';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold سونا = 1 ہیرا۔ ہیرے سب سے خوبصورت اسکنز کھولتے ہیں — آرام سے جمع کریں۔';
  }

  @override
  String get statsTitle => 'اعداد و شمار';

  @override
  String get statsAverageScore => 'اوسط اسکور';

  @override
  String get statsBestCombo => 'بہترین کومبو';

  @override
  String get statsGames => 'کھیل';

  @override
  String get statsLinesCleared => 'صاف شدہ قطاریں';

  @override
  String get statsPiecesPlaced => 'رکھے گئے ٹکڑے';

  @override
  String get statsCoins => 'سکے';

  @override
  String get missionsTitle => 'مشن';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ٹکڑے رکھیں',
      one: '$countString ٹکڑا رکھیں',
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
      other: '$countString قطاریں صاف کریں',
      one: '$countString قطار صاف کریں',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '${countString}x کومبو تک پہنچیں';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ایک کھیل میں $countString پوائنٹس حاصل کریں',
      one: 'ایک کھیل میں $countString پوائنٹ حاصل کریں',
    );
    return '$_temp0';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString کھیل کھیلیں';
  }

  @override
  String get achievementsTitle => 'کامیابیاں';

  @override
  String get achievementFirstGameTitle => 'پہلا کھیل';

  @override
  String get achievementFirstGameBody => 'اپنا پہلا کھیل کھیلیں';

  @override
  String get achievementGames25Title => 'باقاعدہ';

  @override
  String get achievementGames25Body => '25 کھیل کھیلیں';

  @override
  String get achievementGames100Title => 'دیوانہ';

  @override
  String get achievementGames100Body => '100 کھیل کھیلیں';

  @override
  String get achievementScore1kTitle => 'آگے بڑھتا ہوا';

  @override
  String get achievementScore1kBody => '1,000 پوائنٹس تک پہنچیں';

  @override
  String get achievementScore5kTitle => 'ماہر';

  @override
  String get achievementScore5kBody => '5,000 پوائنٹس تک پہنچیں';

  @override
  String get achievementScore10kTitle => 'استاد';

  @override
  String get achievementScore10kBody => '10,000 پوائنٹس تک پہنچیں';

  @override
  String get achievementScore25kTitle => 'لیجنڈ';

  @override
  String get achievementScore25kBody => '25,000 پوائنٹس تک پہنچیں';

  @override
  String get achievementLines100Title => 'سلیقہ مند';

  @override
  String get achievementLines100Body => 'کل 100 قطاریں صاف کریں';

  @override
  String get achievementLines1000Title => 'بڑی صفائی';

  @override
  String get achievementLines1000Body => 'کل 1,000 قطاریں صاف کریں';

  @override
  String get achievementCombo5Title => 'کومبو نوآموز';

  @override
  String get achievementCombo5Body => '5x کومبو تک پہنچیں';

  @override
  String get achievementCombo10Title => 'کومبو بادشاہ';

  @override
  String get achievementCombo10Body => '10x کومبو تک پہنچیں';

  @override
  String get achievementLevel10Title => 'تجربہ کار';

  @override
  String get achievementLevel10Body => 'لیول 10 تک پہنچیں';

  @override
  String get achievementLevel20Title => 'پرانا کھلاڑی';

  @override
  String get achievementLevel20Body => 'لیول 20 تک پہنچیں';

  @override
  String get achievementStreak7Title => 'ہفتہ وار سلسلہ';

  @override
  String get achievementStreak7Body => '7 دن کا روزانہ سلسلہ';

  @override
  String get achievementStreak30Title => 'ماہانہ سلسلہ';

  @override
  String get achievementStreak30Body => '30 دن کا روزانہ سلسلہ';

  @override
  String get achievementPuzzles10Title => 'پہیلیوں کا ماہر';

  @override
  String get achievementPuzzles10Body => '10 پہیلیاں حل کریں';

  @override
  String get achievementPieces5000Title => 'معمار';

  @override
  String get achievementPieces5000Body => '5,000 ٹکڑے رکھیں';

  @override
  String streakRepairTitle(int streak) {
    return 'آپ کا $streak دن کا سلسلہ خطرے میں ہے!';
  }

  @override
  String get streakRepairBody => 'کل کھیل رہ گیا — اپنا سلسلہ بچائیں:';

  @override
  String get streakRepairFailed => 'مرمت ممکن نہیں۔';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins سکے',
      one: '$coins سکہ',
    );
    return 'خوش آمدید! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'یاد دہانیاں؟';

  @override
  String get notificationsOptInBody =>
      'کیا ہم آپ کو روزانہ پہیلی یاد دلائیں اور آپ کا سلسلہ محفوظ رکھیں؟ آپ یہ کسی بھی وقت ترتیبات میں بدل سکتے ہیں۔';

  @override
  String get notificationsOptInAccept => 'جی ہاں';

  @override
  String get notificationChannelDescription =>
      'روزانہ یاد دہانی، سلسلے کی تنبیہ، واپسی کی دعوت';

  @override
  String get notificationDailyTitle => 'آپ کی روزانہ پہیلی انتظار میں ہے 🧩';

  @override
  String get notificationDailyBody => 'آج کا چیلنج کھیلیں!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 آپ کا $streak دن کا سلسلہ خطرے میں ہے!';
  }

  @override
  String get notificationStreakBody => 'اسے قائم رکھنے کے لیے آج کھیلیں۔';

  @override
  String get notificationComebackTitle => 'آپ کی پہیلی آپ کو یاد کر رہی ہے 🧩';

  @override
  String get notificationComebackBody => 'واپس آئیں اور تحفہ لیں!';

  @override
  String get iapSupporterPack => 'سپورٹر پیک';

  @override
  String get iapCoinsSmall => '500 سکے';

  @override
  String get iapCoinsMedium => '2,000 سکے';

  @override
  String get iapCoinsLarge => '6,000 سکے';

  @override
  String get iapStarterPack => 'اسٹارٹر پیک';

  @override
  String get iapRename => 'نام کی تبدیلی';

  @override
  String get iapNeonTheme => 'نیون تھیم';

  @override
  String get settingsLeaderboardDelete => 'لیڈر بورڈ کا اندراج حذف کریں';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'آپ کا نام اور اسکور عوامی فہرست سے ہٹا دیتا ہے';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'اپنا اندراج حذف کریں؟';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'آپ کا نام اور اسکور لیڈر بورڈ سے ہٹا دیا جائے گا۔ کھیل میں آپ کی پیش رفت برقرار رہے گی۔ آپ کسی بھی وقت دوبارہ لیڈر بورڈ میں شامل ہو سکتے ہیں۔';

  @override
  String get settingsLeaderboardDeleteDone =>
      'آپ کا لیڈر بورڈ اندراج حذف ہو گیا۔';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'اندراج حذف نہیں ہو سکا۔ کنکشن چیک کر کے دوبارہ کوشش کریں۔';

  @override
  String get leaderboardReport => 'اس نام کی اطلاع دیں';

  @override
  String get leaderboardBlock => 'چھپائیں';

  @override
  String leaderboardBlocked(String name) {
    return '$name آپ کے لیے چھپا دیا گیا';
  }

  @override
  String get leaderboardUndo => 'واپس';

  @override
  String leaderboardBlockedCount(int count) {
    return 'آپ کے چھپائے گئے اندراج: $count';
  }

  @override
  String get leaderboardUnblockAll => 'دوبارہ دکھائیں';

  @override
  String get leaderboardReportUnavailable => 'ابھی اطلاع دینا ممکن نہیں۔';

  @override
  String get leaderboardReportSent => 'شکریہ — آپ کی اطلاع بھیج دی گئی۔';

  @override
  String get leaderboardRules =>
      'نام سب کو نظر آتے ہیں۔ کوئی توہین، کوئی گالی اور کوئی ایسی چیز نہیں جو کسی حقیقی شخص کی شناخت کرے۔ اصول توڑنے والے نام ہٹا دیے جاتے ہیں۔';

  @override
  String get leaderboardRulesAccept => 'ٹھیک ہے';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total میں سے $unlocked ان لاک';
  }

  @override
  String get settingsSectionData => 'محفوظ ڈیٹا';

  @override
  String get gameRotatePiece => 'ٹکڑا گھمائیں';

  @override
  String get themeClassic => 'کلاسک';

  @override
  String get themeFade => 'پیسٹل';

  @override
  String get themeNeon => 'نیون';

  @override
  String get themeOcean => 'سمندر';

  @override
  String get themeWood => 'لکڑی';

  @override
  String get themeSunset => 'غروبِ آفتاب';

  @override
  String get themeForest => 'جنگل';

  @override
  String get themeAurora => 'قطبی روشنی';

  @override
  String get skinClassic => 'کلاسک';

  @override
  String get skinGradient => 'گریڈینٹ';

  @override
  String get skinOutline => 'خاکہ';

  @override
  String get skinGlossy => 'چمکدار';

  @override
  String get skinStripe => 'دھاریاں';

  @override
  String get skinBevel => 'ڈھلوان';

  @override
  String get skinGlow => 'چمک';

  @override
  String get skinCrystal => 'کرسٹل';

  @override
  String rewardThemeName(String name) {
    return '$name تھیم';
  }

  @override
  String rewardSkinName(String name) {
    return '$name اسکن';
  }
}
