// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class L10nAr extends L10n {
  L10nAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'العب';

  @override
  String get commonLater => 'لاحقًا';

  @override
  String get commonNotNow => 'ليس الآن';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonBuy => 'شراء';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonCollect => 'استلام';

  @override
  String get nameNewName => 'الاسم الجديد';

  @override
  String get nameFieldLabel => 'الاسم';

  @override
  String get piggyFullTitle => 'الحصالة ممتلئة!';

  @override
  String get piggyKeepSaving => 'واصل الادخار';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'تم جمع $coins من $capacity.';
  }

  @override
  String get homeContinueRun => 'متابعة';

  @override
  String get homeVideo => 'فيديو';

  @override
  String get commonGotIt => 'فهمت';

  @override
  String get commonHome => 'الرئيسية';

  @override
  String get commonScore => 'النقاط';

  @override
  String get commonBest => 'الأفضل';

  @override
  String commonLevelShort(int level) {
    return 'المستوى $level';
  }

  @override
  String get homeNewRun => 'ابدأ جولة جديدة';

  @override
  String get homeBackToExit => 'اضغط رجوع مرة أخرى للخروج';

  @override
  String get homeEnableLeaderboard => 'انضم إلى لوحة المتصدرين';

  @override
  String get homeBestScore => 'أفضل نتيجة';

  @override
  String get homeDailyChallenge => 'التحدي اليومي';

  @override
  String get homeDailyOpenToday => 'متاح اليوم';

  @override
  String homeDailyNextIn(String time) {
    return 'التحدي التالي بعد $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak يوم متتالٍ',
      many: '$streak يومًا متتاليًا',
      few: '$streak أيام متتالية',
      two: 'يومان متتاليان',
      one: 'يوم واحد متتالٍ',
      zero: 'لا أيام متتالية',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'المتصدرون';

  @override
  String get homePuzzleMode => 'وضع الألغاز';

  @override
  String get homeMissions => 'المهام';

  @override
  String get homeThemes => 'السمات';

  @override
  String get homeSkins => 'المظاهر';

  @override
  String get homeHowToPlay => 'طريقة لعب Qubble';

  @override
  String get homeWeekendBonus => 'عطلة نهاية الأسبوع: عملات مضاعفة!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'المستوى $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'تغيير الاسم';

  @override
  String get nameChangeExplainer =>
      'اسمك هو هويتك في لوحة المتصدرين، لذلك لا يمكن تغييره بحرية. يمكنك شراء تغيير واحد للاسم.';

  @override
  String get nameChangeAfterPurchase =>
      'بعد الشراء، اضغط على اسمك مرة أخرى لتغييره.';

  @override
  String get nameJoinedLeaderboard => 'أنت الآن في لوحة المتصدرين.';

  @override
  String get nameRenameUnavailable => 'لا يمكن تغيير الاسم الآن.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min حرف على الأقل.',
      many: '$min حرفًا على الأقل.',
      few: '$min أحرف على الأقل.',
      two: 'حرفان على الأقل.',
      one: 'حرف واحد على الأقل.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: '$max حرف كحد أقصى.',
      many: '$max حرفًا كحد أقصى.',
      few: '$max أحرف كحد أقصى.',
      two: 'حرفان كحد أقصى.',
      one: 'حرف واحد كحد أقصى.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'يُسمح فقط بالحروف الإنجليزية (A–Z) والأرقام والمسافات و _ و -.';

  @override
  String get nameProblemOffensive => 'يُرجى اختيار اسم آخر.';

  @override
  String get piggyTitle => 'الحصالة';

  @override
  String get piggyFillingHint => 'تمتلئ حصالتك كلما مسحت صفوفًا.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: 'استلم $coins عملة مجانًا.',
      many: 'استلم $coins عملة مجانًا.',
      few: 'استلم $coins عملات مجانًا.',
      two: 'استلم عملتين مجانًا.',
      one: 'استلم عملة واحدة مجانًا.',
      zero: 'الحصالة فارغة.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'عندما تمتلئ يمكنك إفراغها مجانًا، أو فتحها مبكرًا بمشاهدة فيديو المكافأة.';

  @override
  String get piggyOpenNow => 'افتحها الآن';

  @override
  String get gameNewPiecesVideo => 'قطع جديدة (فيديو)';

  @override
  String get gameTapBoardCell => 'اضغط على خانة في اللوحة';

  @override
  String get gameDailyChallengeLabel => 'التحدي اليومي';

  @override
  String get gameOver => 'انتهت اللعبة';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'تحتاج إلى عملات إضافية لاستخدام القنبلة: $missing';
  }

  @override
  String get gameBombNotHere => 'لا يمكن استخدام القنبلة هنا الآن.';

  @override
  String gameNeedsCoins(String missing) {
    return 'تحتاج إلى عملات إضافية: $missing';
  }

  @override
  String get gameNotRightNow => 'غير ممكن الآن.';

  @override
  String get gameRunSaved => 'تم حفظ الجولة — اضغط «متابعة» في القائمة.';

  @override
  String get gameOverNoFit => 'لم تعد أي من قطعك تتسع في اللوحة.';

  @override
  String get gameOverNoFitNoRotations =>
      'لا تتسع أي من قطعك — وقد نفدت مرات التدوير.';

  @override
  String get gameStarterOfferUnavailable => 'غير متاح الآن';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — احصل عليه';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'كومبو x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'إنجاز: $title';
  }

  @override
  String get gameBestSubmitted => 'رقم قياسي جديد — تم الإرسال';

  @override
  String get gameReviveFor => 'واصل اللعب · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'تم فتح: $name';
  }

  @override
  String get gameStarterOfferTitle => 'حزمة البداية';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score نقطة',
      many: '$score نقطة',
      few: '$score نقاط',
      two: 'نقطتان',
      one: 'نقطة واحدة',
      zero: '0 نقطة',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'رقم قياسي جديد!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak يوم متتالٍ',
      many: '$streak يومًا متتاليًا',
      few: '$streak أيام متتالية',
      two: 'يومان متتاليان',
      one: 'يوم واحد متتالٍ',
      zero: 'لا أيام متتالية',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'ضاعف العملات';

  @override
  String get gameDoubleDaily => 'ضاعف المكافأة اليومية';

  @override
  String get gamePlayAgain => 'العب مجددًا';

  @override
  String gameLevelReached(int level) {
    return 'وصلت إلى المستوى $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ارتقيت $count مستوى — المستوى $level!',
      many: 'ارتقيت $count مستوى — المستوى $level!',
      few: 'ارتقيت $count مستويات — المستوى $level!',
      two: 'ارتقيت مستويين — المستوى $level!',
      one: 'ارتقيت مستوى واحدًا — المستوى $level!',
      zero: 'المستوى $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 عملة + سمة الخشب';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'متبقٍ $hours ساعة فقط — لمرة واحدة!',
      many: 'متبقٍ $hours ساعة فقط — لمرة واحدة!',
      few: 'متبقٍ $hours ساعات فقط — لمرة واحدة!',
      two: 'متبقٍ ساعتان فقط — لمرة واحدة!',
      one: 'متبقٍ ساعة واحدة فقط — لمرة واحدة!',
      zero: 'ينتهي العرض الآن — لمرة واحدة!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'تراجع';

  @override
  String get boosterSwap => 'تبديل';

  @override
  String get boosterBomb => 'قنبلة';

  @override
  String get boosterNoRotationsLeft =>
      'نفدت مرات التدوير — امسح صفوفًا لإعادة الشحن!';

  @override
  String get onboardingDragPiece => 'اسحب قطعة إلى اللوحة';

  @override
  String get onboardingFillLine => 'املأ صفًا أو عمودًا كاملًا';

  @override
  String get onboardingLinesClear => 'الخطوط الممتلئة تختفي — نقاط!';

  @override
  String get coachHintCombo => 'كومبو! امسح مجددًا خلال 3 حركات للحفاظ عليه';

  @override
  String get coachHintFever => 'حُمّى! النقاط مضاعفة طالما اللوحة متوهجة';

  @override
  String get coachHintRotation => 'التدوير يستهلك شحنة — والمسح يعيد شحنها';

  @override
  String get coachHintBooster => 'نصيحة: يمكنك استخدام المساعدات في الأسفل';

  @override
  String get coachHintStrategy =>
      'نصيحة: لا تمسح كل الخطوط دفعة واحدة — اترك مكانًا للقطع الكبيرة';

  @override
  String get dailyStreakLabel => 'أيام متتالية';

  @override
  String get dailyBestLabel => 'أفضل نتيجة يومية';

  @override
  String dailyHistoryNote(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'يُحتفظ بسجل آخر $days يوم.',
      many: 'يُحتفظ بسجل آخر $days يومًا.',
      few: 'يُحتفظ بسجل آخر $days أيام.',
      two: 'يُحتفظ بسجل آخر يومين.',
      one: 'يُحتفظ بسجل آخر يوم.',
      zero: 'لا يُحتفظ بأي سجل.',
    );
    return '$_temp0';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'يوم $day: تم اللعب';
  }

  @override
  String dailyDayMissed(int day) {
    return 'يوم $day: لم يُلعب';
  }

  @override
  String get homeDailyCalendar => 'التقويم';

  @override
  String get dailyShareButton => 'شارك النتيجة';

  @override
  String dailyShareHeadline(String date) {
    return 'تحدي Qubble اليومي $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'النقاط: $score · أفضل كومبو x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'العب: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'كومبو: $moves حركة متبقية',
      many: 'كومبو: $moves حركة متبقية',
      few: 'كومبو: $moves حركات متبقية',
      two: 'كومبو: حركتان متبقيتان',
      one: 'كومبو: حركة واحدة متبقية',
      zero: 'كومبو: لا حركات متبقية',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'تم نسخ النتيجة إلى الحافظة';

  @override
  String get adNotAvailable => 'لا يوجد فيديو متاح الآن — حاول مجددًا بعد قليل';

  @override
  String get howToPlaySpeedTitle => 'مكافأة السرعة';

  @override
  String get howToPlaySpeedBody =>
      'الوضع السريع للقطع يضيف حتى 30 % إلى نقاط المسح. تتلاشى المكافأة بين 1.5 و4 ثوانٍ ولها حد أقصى، فالسرعة مفيدة لكنها لا تحسم اللعبة — الجولة المتأنية قد تتفوق على الجولة المتسرعة.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'مكافأة السرعة $percent بالمئة';
  }

  @override
  String get iapDiamondsSmall => '100 ماسة';

  @override
  String get iapDiamondsMedium => '350 ماسة';

  @override
  String get iapDiamondsLarge => '1,000 ماسة';

  @override
  String get howToPlayTitle => 'طريقة لعب Qubble';

  @override
  String get howToPlayIntroHeadline => 'سهلة البداية.\nوالتخطيط المسبق يُكافأ.';

  @override
  String get howToPlayIntroBody => 'حافظ على اللوحة فارغة وحطّم أفضل نتيجة لك.';

  @override
  String get howToPlayIntroSemantics =>
      'هدف اللعبة. حافظ على اللوحة فارغة وحطّم أفضل نتيجة لك.';

  @override
  String get howToPlayDragTitle => 'اسحب وضع';

  @override
  String get howToPlayDragBody =>
      'اسحب إحدى القطع الثلاث إلى خانات فارغة. عندما تستخدم القطع الثلاث، تحصل تلقائيًا على ثلاث قطع جديدة.';

  @override
  String get howToPlayClearTitle => 'امسح الخطوط';

  @override
  String get howToPlayClearBody =>
      'املأ صفًا أو عمودًا كاملًا. الخطوط الممتلئة تختفي وتفسح المجال لحركتك التالية.';

  @override
  String get howToPlayComboTitle => 'اصنع سلسلة كومبو';

  @override
  String get howToPlayComboBody =>
      'امسح خطًا آخر خلال ثلاث حركات. كل كومبو إضافي يرفع مضاعف النقاط. الكومبو يحسب الحركات لا الثواني، لذلك لا ينتهي وأنت تفكر.';

  @override
  String get howToPlayFeverTitle => 'أشعل الحُمّى';

  @override
  String get howToPlayFeverBody =>
      'المسح يملأ عداد الحُمّى. عندما يمتلئ، يُحسب المسح التالي مضاعفًا — خطط لعمليات مسح كبيرة مسبقًا.';

  @override
  String get howToPlayBoosterTitle => 'استخدم المساعدات بحكمة';

  @override
  String get howToPlayBoosterBody =>
      'المساعدات تنقذ الجولات الصعبة. ويمكنك أيضًا الضغط على قطعة في الصينية لتدويرها.';

  @override
  String get howToPlayDailyTitle => 'اليومي والأيام المتتالية';

  @override
  String get howToPlayDailyBody =>
      'يستخدم التحدي اليومي القطع نفسها للجميع. العب كل يوم لتطيل سلسلة أيامك وتزيد مكافأتك.';

  @override
  String get howToPlayPiggyTitle => 'املأ الحصالة';

  @override
  String get howToPlayPiggyBody =>
      'كل خط تمسحه يملأ حصالتك. عندما تمتلئ، يمكنك استلام العملات مجانًا.';

  @override
  String get leaderboardTitle => 'لوحة المتصدرين';

  @override
  String get leaderboardUnreachable =>
      'لوحة المتصدرين غير متاحة.\nحاول مجددًا مع اتصال بالإنترنت.';

  @override
  String get leaderboardEmpty => 'لا توجد إدخالات بعد.\nكن الأول!';

  @override
  String leaderboardSubmitting(int score) {
    return 'جارٍ إرسال أفضل نتيجة لك ($score) …';
  }

  @override
  String get leaderboardAutoSubmit => 'تُرسل أفضل نتيجة لك تلقائيًا.';

  @override
  String get puzzleModeTitle => 'وضع الألغاز';

  @override
  String puzzleLevelTitle(int level) {
    return 'لغز $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'الحركات: $moves   •   الهدف: $target لثلاث نجوم';
  }

  @override
  String get puzzleSolved => 'تم الحل!';

  @override
  String get puzzleLeaveTitle => 'مغادرة اللغز؟';

  @override
  String get puzzleLeaveBody => 'سيضيع تقدمك في هذا اللغز.';

  @override
  String get puzzleKeepPlaying => 'واصل اللعب';

  @override
  String get puzzleLeave => 'مغادرة';

  @override
  String get puzzleStuckTitle => 'طريق مسدود';

  @override
  String get puzzleRestart => 'إعادة البدء';

  @override
  String get commonActive => 'مفعّل';

  @override
  String get commonTapToActivate => 'اضغط للتفعيل';

  @override
  String get commonRestore => 'استعادة';

  @override
  String unlockForCost(int cost) {
    return 'افتح مقابل $cost';
  }

  @override
  String get skinsExchangeGold => 'استبدل الذهب';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'تدوير القطعة';

  @override
  String get puzzleNextLevel => 'المستوى التالي';

  @override
  String get puzzleBackToOverview => 'العودة إلى النظرة العامة';

  @override
  String get puzzleUnsolvable => 'لم يعد ممكنًا إفراغ اللوحة من هنا.';

  @override
  String get puzzleExtraMoveVideo => 'حركة إضافية (فيديو)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'المحلولة: $solved';
  }

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get storageFailureTitle => 'تعذّر على Qubble تحميل لعبتك المحفوظة';

  @override
  String get storageFailureBody =>
      'يُرجى إعادة تشغيل التطبيق. إذا استمر الخطأ، فلا حل إلا إعادة التثبيت. يمكنك الإبلاغ عنه من الإعدادات › إرسال ملاحظات.';

  @override
  String get iapUnavailable => 'هذا العرض غير متاح الآن.';

  @override
  String get iapFailed => 'لم تكتمل عملية الشراء. لم يتم خصم أي مبلغ.';

  @override
  String get settingsResetProgress => 'إعادة ضبط التقدم';

  @override
  String get settingsResetProgressSubtitle =>
      'تعود النقاط والعملات والمستوى والتقدم إلى البداية. تبقى المشتريات والاسم والمظاهر.';

  @override
  String get settingsResetConfirmTitle => 'إعادة ضبط التقدم؟';

  @override
  String get settingsResetConfirmBody =>
      'سيتم حذف أفضل نتيجة والعملات والمستوى والأيام المتتالية وكل التقدم. لا يمكن التراجع عن ذلك.\n\nتبقى مشترياتك واسمك والسمات والمظاهر التي فتحتها.';

  @override
  String get settingsResetConfirmAction => 'إعادة الضبط';

  @override
  String get settingsResetDone => 'تمت إعادة ضبط التقدم.';

  @override
  String get settingsSectionGame => 'اللعبة';

  @override
  String get settingsSectionSoundHaptics => 'الصوت والاهتزاز';

  @override
  String get settingsSectionReminders => 'التذكيرات';

  @override
  String get settingsSectionPurchases => 'المشتريات';

  @override
  String get settingsSectionHelpOut => 'ادعمنا';

  @override
  String get settingsSectionLegal => 'المعلومات القانونية';

  @override
  String get settingsSectionLanguage => 'اللغة';

  @override
  String get settingsGuide => 'طريقة اللعب';

  @override
  String get settingsGuideSubtitle => 'القواعد والكومبو والحُمّى والمساعدات';

  @override
  String get settingsSound => 'الصوت';

  @override
  String get settingsMusic => 'الموسيقى';

  @override
  String get settingsHaptics => 'الاهتزاز';

  @override
  String get settingsHapticsOff => 'إيقاف';

  @override
  String get settingsHapticsLight => 'خفيف';

  @override
  String get settingsHapticsStrong => 'قوي';

  @override
  String get settingsSectionAccessibility => 'الراحة';

  @override
  String get settingsReducedEffects => 'تقليل المؤثرات';

  @override
  String get settingsReducedEffectsHint =>
      'جزيئات أقل، بلا اهتزاز للشاشة، بلا توهج';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsNotificationsSubtitle =>
      'تذكير يومي وحماية الأيام المتتالية';

  @override
  String get settingsNotificationsSystemHint => 'اسمح بها في إعدادات النظام.';

  @override
  String get settingsLanguageSystem => 'لغة النظام';

  @override
  String get settingsSupporterThanks => 'داعم — شكرًا لك!';

  @override
  String get settingsSupporterPack => 'حزمة الداعم';

  @override
  String get settingsSupporterPackSubtitle => 'سمة ومظهر حصريان + 1,500 عملة';

  @override
  String get settingsRestorePurchases => 'استعادة المشتريات';

  @override
  String get settingsRestoring => 'جارٍ استعادة المشتريات…';

  @override
  String get settingsRateApp => 'قيّم التطبيق';

  @override
  String get settingsRateAppSubtitle => 'اترك تقييمًا في المتجر';

  @override
  String get settingsStoreUnavailable => 'المتجر غير متاح على هذا الجهاز.';

  @override
  String get settingsFeedback => 'إرسال ملاحظات';

  @override
  String get settingsFeedbackSubtitle => 'أبلغ عن أفكار وأخطاء (عبر GitHub)';

  @override
  String get settingsAdPrivacy => 'إعدادات خصوصية الإعلانات';

  @override
  String get settingsAdPrivacySubtitle =>
      'اعرض موافقتك على الإعلانات أو غيّرها';

  @override
  String get settingsAdPrivacyUnavailable =>
      'لا يلزم ضبط خيارات الإعلانات على هذا الجهاز.';

  @override
  String get settingsPrivacy => 'سياسة الخصوصية';

  @override
  String get settingsImprint => 'بيانات الناشر';

  @override
  String get settingsPageOpenFailed => 'تعذّر فتح الصفحة.';

  @override
  String get settingsFooter => 'Qubble • لغز مكعبات بلا إنترنت';

  @override
  String get settingsAdminSection => 'المشرف (اختبار)';

  @override
  String get settingsAdminEnabled => 'تم تفعيل وضع المشرف';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'اضغط $count مرة أخرى لوضع المشرف',
      many: 'اضغط $count مرة أخرى لوضع المشرف',
      few: 'اضغط $count مرات أخرى لوضع المشرف',
      two: 'اضغط مرتين أخريين لوضع المشرف',
      one: 'اضغط مرة واحدة أخرى لوضع المشرف',
      zero: 'وضع المشرف مفعّل',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    return 'العملات: $coins';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'للاختبار فقط — لا تظهر أبدًا في لقطات الشاشة للإصدار';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount عملة';
  }

  @override
  String get settingsAdminResetCoins => 'تصفير العملات';

  @override
  String get feedbackTitle => 'ملاحظات';

  @override
  String get feedbackIntroShort =>
      'ما الذي يعجبك، وما الذي يزعجك، وما الذي ينقص؟ الأشياء الصغيرة تفيد أيضًا — وكلما كانت محددة كان أفضل.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'يُرفق فقط $build ونوع جهازك — لأعرف أي إصدار تقصد.';
  }

  @override
  String get feedbackSendByMail => 'أرسل عبر البريد الإلكتروني';

  @override
  String get feedbackPreferGithub => 'أفضّل بلاغًا على GitHub';

  @override
  String get feedbackThanksMail => 'شكرًا! أرسل الرسالة فقط.';

  @override
  String get feedbackNoMailApp =>
      'لم يُعثر على تطبيق بريد. جرّب طريق GitHub في الأسفل.';

  @override
  String get feedbackEmptyHint => 'يُرجى كتابة شيء أولًا.';

  @override
  String get leaderboardRefresh => 'تحديث';

  @override
  String get leaderboardRetry => 'حاول مجددًا';

  @override
  String get feedbackHint => 'ملاحظاتك…';

  @override
  String get feedbackSubmit => 'إرسال الملاحظات';

  @override
  String get feedbackOpenFailed => 'تعذّر فتح GitHub. حاول لاحقًا.';

  @override
  String get feedbackGithubNote =>
      'سيُفتح GitHub — اضغط هناك على \"Submit new issue\". (يلزم تسجيل الدخول إلى GitHub مرة واحدة.)';

  @override
  String get shopTitle => 'المتجر';

  @override
  String get shopWebDemoNote =>
      'المشتريات متاحة فقط في التطبيق من متجر Play. نسخة الويب هذه تجربة مجانية — ويمكنك لعبها كاملة هنا.';

  @override
  String get shopSupporterExplainer =>
      'لا يعرض Qubble إعلانات إجبارية — ولست مضطرًا لشراء أي شيء. حزمة الداعم (سمة الشفق ومظهر الكريستال و1,500 عملة وشارة الداعم) شكرٌ لك على دعم اللعبة. المشتريات مرتبطة بحسابك في المتجر ويمكن استعادتها في أي وقت.';

  @override
  String get shopSupporterContents => 'سمة الشفق + مظهر الكريستال + 1,500 عملة';

  @override
  String get themesTitle => 'السمات';

  @override
  String get themesSupporterOnly => 'حصرية لحزمة الداعم (انظر المتجر)';

  @override
  String get themesInSupporterPack => 'ضمن حزمة الداعم';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'العملات غير كافية (المطلوب $cost، لديك $coins)';
  }

  @override
  String get skinsTitle => 'مظاهر المكعبات';

  @override
  String get skinsNotEnoughDiamonds =>
      'الماس غير كافٍ (استبدل الذهب في الأسفل)';

  @override
  String get skinsNotEnoughCoins => 'العملات غير كافية';

  @override
  String get skinsNotEnoughGold => 'الذهب غير كافٍ.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold ذهب = 1 ماسة. الماس يفتح أجمل المظاهر — اجمعه على مهل.';
  }

  @override
  String get statsTitle => 'الإحصاءات';

  @override
  String get statsAverageScore => 'متوسط النقاط';

  @override
  String get statsBestCombo => 'أفضل كومبو';

  @override
  String get statsGames => 'الجولات';

  @override
  String get statsLinesCleared => 'الصفوف الممسوحة';

  @override
  String get statsPiecesPlaced => 'القطع الموضوعة';

  @override
  String get statsCoins => 'العملات';

  @override
  String get missionsTitle => 'المهام';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ضع $countString قطعة',
      many: 'ضع $countString قطعة',
      few: 'ضع $countString قطع',
      two: 'ضع قطعتين',
      one: 'ضع قطعة واحدة',
      zero: 'ضع قطعًا',
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
      other: 'امسح $countString صف',
      many: 'امسح $countString صفًا',
      few: 'امسح $countString صفوف',
      two: 'امسح صفين',
      one: 'امسح صفًا واحدًا',
      zero: 'امسح صفوفًا',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'حقق كومبو x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تجاوز $countString نقطة في جولة واحدة',
      many: 'تجاوز $countString نقطة في جولة واحدة',
      few: 'تجاوز $countString نقاط في جولة واحدة',
      two: 'تجاوز نقطتين في جولة واحدة',
      one: 'تجاوز نقطة واحدة في جولة واحدة',
      zero: 'اجمع نقاطًا في جولة واحدة',
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
      other: 'العب $countString جولة',
      many: 'العب $countString جولة',
      few: 'العب $countString جولات',
      two: 'العب جولتين',
      one: 'العب جولة واحدة',
      zero: 'العب جولات',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'الإنجازات';

  @override
  String get achievementFirstGameTitle => 'الجولة الأولى';

  @override
  String get achievementFirstGameBody => 'العب جولتك الأولى';

  @override
  String get achievementGames25Title => 'لاعب دائم';

  @override
  String get achievementGames25Body => 'العب 25 جولة';

  @override
  String get achievementGames100Title => 'مدمن';

  @override
  String get achievementGames100Body => 'العب 100 جولة';

  @override
  String get achievementScore1kTitle => 'متسلق';

  @override
  String get achievementScore1kBody => 'اجمع 1,000 نقطة';

  @override
  String get achievementScore5kTitle => 'محترف';

  @override
  String get achievementScore5kBody => 'اجمع 5,000 نقطة';

  @override
  String get achievementScore10kTitle => 'خبير';

  @override
  String get achievementScore10kBody => 'اجمع 10,000 نقطة';

  @override
  String get achievementScore25kTitle => 'أسطورة';

  @override
  String get achievementScore25kBody => 'اجمع 25,000 نقطة';

  @override
  String get achievementLines100Title => 'مرتّب';

  @override
  String get achievementLines100Body => 'امسح 100 صف إجمالًا';

  @override
  String get achievementLines1000Title => 'تنظيف شامل';

  @override
  String get achievementLines1000Body => 'امسح 1,000 صف إجمالًا';

  @override
  String get achievementCombo5Title => 'بداية الكومبو';

  @override
  String get achievementCombo5Body => 'حقق كومبو x5';

  @override
  String get achievementCombo10Title => 'ملك الكومبو';

  @override
  String get achievementCombo10Body => 'حقق كومبو x10';

  @override
  String get achievementLevel10Title => 'صاحب خبرة';

  @override
  String get achievementLevel10Body => 'بلغ المستوى 10';

  @override
  String get achievementLevel20Title => 'محارب قديم';

  @override
  String get achievementLevel20Body => 'بلغ المستوى 20';

  @override
  String get achievementStreak7Title => 'أسبوع متواصل';

  @override
  String get achievementStreak7Body => '7 أيام متتالية في التحدي اليومي';

  @override
  String get achievementStreak30Title => 'شهر متواصل';

  @override
  String get achievementStreak30Body => '30 يومًا متتاليًا في التحدي اليومي';

  @override
  String get achievementPuzzles10Title => 'محترف ألغاز';

  @override
  String get achievementPuzzles10Body => 'حل 10 ألغاز';

  @override
  String get achievementPieces5000Title => 'بنّاء';

  @override
  String get achievementPieces5000Body => 'ضع 5,000 قطعة';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'سلسلة $streak يوم في خطر!',
      many: 'سلسلة $streak يومًا في خطر!',
      few: 'سلسلة $streak أيام في خطر!',
      two: 'سلسلة يومين في خطر!',
      one: 'سلسلة يوم واحد في خطر!',
      zero: 'أيامك المتتالية في خطر!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'لم تلعب أمس — أنقذ سلسلة أيامك:';

  @override
  String get streakRepairFailed => 'الإصلاح غير ممكن.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: 'مرحبًا بعودتك! +$coins عملة',
      many: 'مرحبًا بعودتك! +$coins عملة',
      few: 'مرحبًا بعودتك! +$coins عملات',
      two: 'مرحبًا بعودتك! +عملتان',
      one: 'مرحبًا بعودتك! +عملة واحدة',
      zero: 'مرحبًا بعودتك!',
    );
    return '$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'تذكيرات؟';

  @override
  String get notificationsOptInBody =>
      'هل نذكّرك بلغزك اليومي ونحمي سلسلة أيامك؟ يمكنك تغيير ذلك في أي وقت من الإعدادات.';

  @override
  String get notificationsOptInAccept => 'نعم، من فضلك';

  @override
  String get notificationChannelDescription =>
      'تذكير يومي، تنبيه للأيام المتتالية، دعوة للعودة';

  @override
  String get notificationDailyTitle => 'لغزك اليومي بانتظارك 🧩';

  @override
  String get notificationDailyBody => 'العب تحدي اليوم!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 سلسلة $streak يوم في خطر!',
      many: '🔥 سلسلة $streak يومًا في خطر!',
      few: '🔥 سلسلة $streak أيام في خطر!',
      two: '🔥 سلسلة يومين في خطر!',
      one: '🔥 سلسلة يوم واحد في خطر!',
      zero: '🔥 أيامك المتتالية في خطر!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'العب اليوم لتحافظ عليها.';

  @override
  String get notificationComebackTitle => 'لغزك يفتقدك 🧩';

  @override
  String get notificationComebackBody => 'عُد واستلم هديتك!';

  @override
  String get iapSupporterPack => 'حزمة الداعم';

  @override
  String get iapCoinsSmall => '500 عملة';

  @override
  String get iapCoinsMedium => '2,000 عملة';

  @override
  String get iapCoinsLarge => '6,000 عملة';

  @override
  String get iapStarterPack => 'حزمة البداية';

  @override
  String get iapRename => 'تغيير الاسم';

  @override
  String get iapNeonTheme => 'سمة النيون';

  @override
  String get settingsLeaderboardDelete => 'حذف إدخالك من لوحة المتصدرين';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'يزيل اسمك ونتيجتك من القائمة العامة';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'حذف إدخالك؟';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'سيُزال اسمك ونتيجتك من لوحة المتصدرين. يبقى تقدمك في اللعبة كما هو. يمكنك الانضمام إلى لوحة المتصدرين مجددًا في أي وقت.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'تم حذف إدخالك من لوحة المتصدرين.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'تعذّر حذف الإدخال. تحقق من اتصالك وحاول مجددًا.';

  @override
  String get leaderboardReport => 'الإبلاغ عن هذا الاسم';

  @override
  String get leaderboardBlock => 'حظر';

  @override
  String leaderboardBlocked(String name) {
    return 'تم إخفاء $name عنك';
  }

  @override
  String get leaderboardUndo => 'تراجع';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أخفيت $count إدخال',
      many: 'أخفيت $count إدخالًا',
      few: 'أخفيت $count إدخالات',
      two: 'أخفيت إدخالين',
      one: 'أخفيت إدخالًا واحدًا',
      zero: 'لم تُخفِ أي إدخال',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'إظهار مجددًا';

  @override
  String get leaderboardReportUnavailable => 'الإبلاغ غير متاح الآن.';

  @override
  String get leaderboardReportSent => 'شكرًا — بلاغك في الطريق.';

  @override
  String get leaderboardRules =>
      'الأسماء عامة. لا إهانات، ولا ألفاظ عنصرية، ولا شيء يكشف هوية شخص حقيقي. الأسماء المخالفة تُزال.';

  @override
  String get leaderboardRulesAccept => 'فهمت';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'تم فتح $unlocked من $total';
  }

  @override
  String get settingsSectionData => 'البيانات المحفوظة';

  @override
  String get gameRotatePiece => 'تدوير القطعة';

  @override
  String get themeClassic => 'كلاسيكي';

  @override
  String get themeFade => 'باستيل';

  @override
  String get themeNeon => 'نيون';

  @override
  String get themeOcean => 'المحيط';

  @override
  String get themeWood => 'الخشب';

  @override
  String get themeSunset => 'الغروب';

  @override
  String get themeForest => 'الغابة';

  @override
  String get themeAurora => 'الشفق';

  @override
  String get skinClassic => 'كلاسيكي';

  @override
  String get skinGradient => 'متدرج';

  @override
  String get skinOutline => 'محدد';

  @override
  String get skinGlossy => 'لامع';

  @override
  String get skinStripe => 'مخطط';

  @override
  String get skinBevel => 'مشطوف';

  @override
  String get skinGlow => 'متوهج';

  @override
  String get skinCrystal => 'كريستال';

  @override
  String rewardThemeName(String name) {
    return 'سمة $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'مظهر $name';
  }
}
