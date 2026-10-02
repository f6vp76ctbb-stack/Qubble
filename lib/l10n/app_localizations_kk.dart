// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class L10nKk extends L10n {
  L10nKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Ойнау';

  @override
  String get commonLater => 'Кейін';

  @override
  String get commonNotNow => 'Қазір емес';

  @override
  String get commonCancel => 'Бас тарту';

  @override
  String get commonBuy => 'Сатып алу';

  @override
  String get commonSave => 'Сақтау';

  @override
  String get commonCollect => 'Алу';

  @override
  String get nameNewName => 'Жаңа есім';

  @override
  String get nameFieldLabel => 'Есім';

  @override
  String get piggyFullTitle => 'Жинақ қорабы толды!';

  @override
  String get piggyKeepSaving => 'Жинай беру';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity жиналды.';
  }

  @override
  String get homeContinueRun => 'Жалғастыру';

  @override
  String get homeVideo => 'Бейне';

  @override
  String get commonGotIt => 'Түсінікті';

  @override
  String get commonHome => 'Басты бет';

  @override
  String get commonScore => 'ҰПАЙ';

  @override
  String get commonBest => 'ҮЗДІК';

  @override
  String commonLevelShort(int level) {
    return 'Деңгей $level';
  }

  @override
  String get homeNewRun => 'Жаңа ойын бастау';

  @override
  String get homeBackToExit => 'Шығу үшін «Артқа» түймесін тағы басыңыз';

  @override
  String get homeEnableLeaderboard => 'Көшбасшыларға қосылу';

  @override
  String get homeBestScore => 'ҮЗДІК ҰПАЙ';

  @override
  String get homeDailyChallenge => 'Күнделікті сынақ';

  @override
  String get homeDailyOpenToday => 'Бүгін әлі ойналмады';

  @override
  String homeDailyNextIn(String time) {
    return 'Келесі сынақ: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'Қатарынан $streak күн';
  }

  @override
  String get homeLeaderboard => 'Көшбасшылар';

  @override
  String get homePuzzleMode => 'Пазл режимі';

  @override
  String get homeHowToPlay => 'Qubble қалай ойналады';

  @override
  String get homeWeekendBonus => 'Демалыс: тиын екі есе!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Деңгей $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Есімді өзгерту';

  @override
  String get nameChangeExplainer =>
      'Есіміңіз — көшбасшылар тізіміндегі сіздің бейнеңіз, сондықтан ол тұрақты. Есімді бір рет өзгерту мүмкіндігін сатып алуға болады.';

  @override
  String get nameChangeAfterPurchase =>
      'Сатып алғаннан кейін өзгерту үшін есіміңізді қайта түртіңіз.';

  @override
  String get nameJoinedLeaderboard => 'Енді сіз көшбасшылар тізіміндесіз.';

  @override
  String nameProblemTooShort(int min) {
    return 'Кемінде таңба саны: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Ең көп таңба саны: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Тек латын әріптері (A–Z, é сияқты белгілері барлары да), сандар, бос орын, _ және - рұқсат.';

  @override
  String get nameProblemOffensive => 'Басқа есім таңдаңыз.';

  @override
  String get piggyTitle => 'Жинақ қорабы';

  @override
  String get piggyFillingHint =>
      'Сызықтарды тазалаған сайын жинақ қорабыңыз толады.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins тиынды тегін алыңыз.',
      one: '$coins тиынды тегін алыңыз.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Толғанда оны тегін босатуға болады — немесе бонус бейне арқылы ертерек ашуға болады.';

  @override
  String get piggyOpenNow => 'Қазір ашу';

  @override
  String get gameNewPiecesVideo => 'Жаңа фигуралар (бейне)';

  @override
  String get gameTapBoardCell => 'Тақтадағы бір ұяшықты түртіңіз';

  @override
  String get gameDailyChallengeLabel => 'КҮНДЕЛІКТІ СЫНАҚ';

  @override
  String get gameOver => 'Ойын аяқталды';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Бомбаға тағы қажет тиын: $missing.';
  }

  @override
  String get gameBombNotHere => 'Бомба қазір мұнда әсер етпейді.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Бұған тағы қажет тиын: $missing.';
  }

  @override
  String get gameNotRightNow => 'Қазір мүмкін емес.';

  @override
  String get gameRunSaved => 'Ойын сақталды — мәзірде «Жалғастыру».';

  @override
  String get gameOverNoFit => 'Бірде-бір фигураңыз тақтаға енді сыймайды.';

  @override
  String get gameOverNoFitNoRotations =>
      'Бірде-бір фигура сыймайды — бұру мүмкіндігі де таусылды.';

  @override
  String get gameStarterOfferUnavailable => 'Қазір қолжетімсіз';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — алу';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'КОМБО x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Жетістік: $title';
  }

  @override
  String get gameBestSubmitted => 'Жаңа үздік нәтиже — жіберілді';

  @override
  String get gameReviveFor => 'Ойынды жалғастыру · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Ашылды: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Бастауыш жинақ';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score ұпай',
      one: '$score ұпай',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Жаңа рекорд!';

  @override
  String gameStreakDays(int streak) {
    return 'Қатарынан $streak күн';
  }

  @override
  String get gameDoubleCoins => 'Тиынды екі есе көбейту';

  @override
  String get gameDoubleDaily => 'Күнделікті сыйлықты екі есе көбейту';

  @override
  String get gamePlayAgain => 'Қайта ойнау';

  @override
  String gameLevelReached(int level) {
    return 'Деңгей $level алынды!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count деңгей — деңгей $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 тиын + «Ағаш» тақырыбы';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Тек $hours сағат қалды — бір реттік!';
  }

  @override
  String get boosterUndo => 'Кері';

  @override
  String get boosterSwap => 'Ауыстыру';

  @override
  String get boosterBomb => 'Бомба';

  @override
  String get boosterNoRotationsLeft =>
      'Бұру мүмкіндігі таусылды — қайта алу үшін сызықтарды тазалаңыз!';

  @override
  String get onboardingDragPiece => 'Бір блокты торға сүйреңіз';

  @override
  String get onboardingFillLine => 'Тұтас қатарды немесе бағанды толтырыңыз';

  @override
  String get onboardingLinesClear => 'Толған сызықтар жойылады — ұпай!';

  @override
  String get coachHintCombo =>
      'Комбо! Сақтау үшін 3 жүріс ішінде қайта тазалаңыз';

  @override
  String get coachHintFever => 'ҚЫЗУ! Жарқырап тұрғанда ұпай екі есе';

  @override
  String get coachHintRotation =>
      'Бұруға бір заряд кетеді — тазалағанда қайта толады';

  @override
  String get coachHintBooster => 'Кеңес: төменде бустерлерді қолдануға болады';

  @override
  String get coachHintStrategy =>
      'Кеңес: барлық сызықты бірден емес — үлкен фигураларға орын қалдырыңыз';

  @override
  String get dailyStreakLabel => 'Серия';

  @override
  String get dailyBestLabel => 'Күннің үздігі';

  @override
  String dailyHistoryNote(int days) {
    return 'Соңғы $days күн сақталады.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day-күн: ойналды';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day-күн: ойналмады';
  }

  @override
  String get homeDailyCalendar => 'Күнтізбе';

  @override
  String get dailyShareButton => 'Нәтижені бөлісу';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Күнделікті сынақ $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Ұпай: $score · Үздік комбо x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Ойнау: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Комбо: тағы $moves жүріс',
      one: 'Комбо: тағы $moves жүріс',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Нәтиже алмасу буферіне көшірілді';

  @override
  String get adNotAvailable => 'Қазір бейне жоқ — сәл кейін қайталап көріңіз';

  @override
  String get howToPlaySpeedTitle => 'Жылдамдық бонусы';

  @override
  String get howToPlaySpeedBody =>
      'Жылдам қою әр тазалауға 30 %-ға дейін қосады. Бонус 1,5 пен 4 секунд аралығында азаяды және оның шегі бар, сондықтан жылдамдық пайда береді, бірақ ойынды шешпейді — ойланып, асықпай ойналған ойын әлі де асығыс жылдам ойынды жеңе алады.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Жылдамдық бонусы $percent пайыз';
  }

  @override
  String get iapDiamondsSmall => '100 алмас';

  @override
  String get iapDiamondsMedium => '350 алмас';

  @override
  String get iapDiamondsLarge => '1 000 алмас';

  @override
  String get howToPlayTitle => 'Qubble қалай ойналады';

  @override
  String get howToPlayIntroHeadline =>
      'Бастау оңай.\nАлдын ала ойласаң — ұтасың.';

  @override
  String get howToPlayIntroBody =>
      'Тақтаны бос ұстап, өз рекордыңызды жаңартыңыз.';

  @override
  String get howToPlayIntroSemantics =>
      'Ойынның мақсаты. Тақтаны бос ұстап, өз рекордыңызды жаңартыңыз.';

  @override
  String get howToPlayDragTitle => 'Сүйреп қою';

  @override
  String get howToPlayDragBody =>
      'Үш фигураның бірін бос ұяшықтарға сүйреңіз. Үшеуі де қойылғанда, үш жаңасы өздігінен шығады.';

  @override
  String get howToPlayClearTitle => 'Сызықтарды тазалау';

  @override
  String get howToPlayClearBody =>
      'Тұтас қатарды немесе бағанды толтырыңыз. Толған сызықтар жойылып, келесі жүріске орын босатады.';

  @override
  String get howToPlayComboTitle => 'Комбо жинау';

  @override
  String get howToPlayComboBody =>
      'Үш жүріс ішінде тағы бір сызықты тазалаңыз. Әр қосымша комбо ұпай көбейткішін арттырады. Комбо секундты емес, жүрісті санайды, сондықтан ойланып тұрғанда ол бітпейді.';

  @override
  String get howToPlayFeverTitle => 'Қызуды тұтату';

  @override
  String get howToPlayFeverBody =>
      'Тазалаулар қызу шкаласын толтырады. Ол толғанда келесі жарылыс екі есе есептеледі — үлкен тазалауларды алдын ала жоспарлаңыз.';

  @override
  String get howToPlayBoosterTitle => 'Бустерлерді ақылмен қолдану';

  @override
  String get howToPlayBoosterBody =>
      'Бустерлер қиын ойындарды құтқарады. Төмендегі фигураны түртіп, оны бұруға да болады.';

  @override
  String get howToPlayDailyTitle => 'Күнделікті сынақ пен серия';

  @override
  String get howToPlayDailyBody =>
      'Күнделікті сынақта бәріне бірдей фигуралар беріледі. Сериясы мен бонусты өсіру үшін күн сайын ойнаңыз.';

  @override
  String get howToPlayPiggyTitle => 'Жинақ қорабын толтыру';

  @override
  String get howToPlayPiggyBody =>
      'Тазаланған әр сызық жинақ қорабыңызды толтырады. Толғанда тиындарды тегін алыңыз.';

  @override
  String get leaderboardTitle => 'Көшбасшылар';

  @override
  String get leaderboardUnreachable =>
      'Көшбасшылар тізімі қолжетімсіз.\nИнтернетке қосылып, қайталап көріңіз.';

  @override
  String get leaderboardEmpty => 'Әзірге жазба жоқ.\nБірінші болыңыз!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Үздік ұпайыңыз ($score) жіберілуде …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Үздік ұпайыңыз автоматты түрде жіберіледі.';

  @override
  String get puzzleModeTitle => 'Пазл режимі';

  @override
  String puzzleLevelTitle(int level) {
    return 'Пазл $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Жүріс: $moves   •   Мақсат: 3 жұлдызға $target';
  }

  @override
  String get puzzleSolved => 'Шешілді!';

  @override
  String get puzzleLeaveTitle => 'Пазлдан шығу керек пе?';

  @override
  String get puzzleLeaveBody => 'Бұл пазлдағы прогресіңіз жоғалады.';

  @override
  String get puzzleKeepPlaying => 'Ойнай беру';

  @override
  String get puzzleLeave => 'Шығу';

  @override
  String get puzzleStuckTitle => 'Тұйық';

  @override
  String get puzzleRestart => 'Қайта бастау';

  @override
  String get commonActive => 'Белсенді';

  @override
  String get commonRestore => 'Қалпына келтіру';

  @override
  String get skinsExchangeGold => 'Алтын айырбастау';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Фигураны бұру';

  @override
  String get puzzleNextLevel => 'Келесі деңгей';

  @override
  String get puzzleBackToOverview => 'Тізімге оралу';

  @override
  String get puzzleUnsolvable => 'Бұл жерден тақтаны енді босату мүмкін емес.';

  @override
  String get puzzleExtraMoveVideo => 'Қосымша жүріс (бейне)';

  @override
  String get puzzleHintVideo => 'Кеңес (бейне)';

  @override
  String get puzzleHintVideoCost => 'Кеңес (бейне, бір жұлдыз кетеді)';

  @override
  String get puzzleNoHint =>
      'Осы жерден кеңес беру мүмкін емес. Пазлды қайта бастаңыз.';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Шешілген: $solved';
  }

  @override
  String get settingsTitle => 'Баптаулар';

  @override
  String get storageFailureTitle => 'Qubble сақталған ойынды жүктей алмады';

  @override
  String get storageFailureBody =>
      'Қолданбаны қайта іске қосыңыз. Қате қайталанса, жалғыз шешім — қайта орнату. Бұл туралы Баптаулар › Кері байланыс арқылы хабарлауға болады.';

  @override
  String get iapUnavailable => 'Бұл ұсыныс қазір қолжетімсіз.';

  @override
  String get iapFailed => 'Сатып алу аяқталмады. Ақша алынған жоқ.';

  @override
  String get settingsResetProgress => 'Прогресті тастау';

  @override
  String get settingsResetProgressSubtitle =>
      'Ұпай, тиын, деңгей мен прогресс басынан басталады. Сатып алулар, есім және безендіру сақталады.';

  @override
  String get settingsResetConfirmTitle => 'Прогресті тастау керек пе?';

  @override
  String get settingsResetConfirmBody =>
      'Үздік ұпай, тиындар, деңгей, серия және бүкіл прогресс жойылады. Мұны қайтару мүмкін емес.\n\nСатып алуларыңыз, есіміңіз және ашылған тақырыптар мен скиндер сақталады.';

  @override
  String get settingsResetConfirmAction => 'Тастау';

  @override
  String get settingsResetDone => 'Прогресс тасталды.';

  @override
  String get settingsSectionGame => 'Ойын';

  @override
  String get settingsSectionSoundHaptics => 'Дыбыс және діріл';

  @override
  String get settingsSectionReminders => 'Еске салғыштар';

  @override
  String get settingsSectionPurchases => 'Сатып алулар';

  @override
  String get settingsSectionHelpOut => 'Қолдау көрсету';

  @override
  String get settingsSectionLegal => 'Құқықтық';

  @override
  String get settingsSectionLanguage => 'Тіл';

  @override
  String get settingsGuide => 'Қалай ойнау керек';

  @override
  String get settingsGuideSubtitle => 'Ережелер, комбо, қызу және бустерлер';

  @override
  String get settingsSound => 'Дыбыс';

  @override
  String get settingsMusic => 'Музыка';

  @override
  String get settingsHaptics => 'Діріл';

  @override
  String get settingsHapticsOff => 'Өшірулі';

  @override
  String get settingsHapticsLight => 'Әлсіз';

  @override
  String get settingsHapticsStrong => 'Күшті';

  @override
  String get settingsSectionAccessibility => 'Арнайы мүмкіндіктер';

  @override
  String get settingsReducedEffects => 'Азайтылған эффектілер';

  @override
  String get settingsReducedEffectsHint =>
      'Бөлшектер аз, экран сілкінбейді, жарқыл жоқ';

  @override
  String get settingsNotifications => 'Хабарландырулар';

  @override
  String get settingsNotificationsSubtitle =>
      'Күнделікті еске салу және серияны қорғау';

  @override
  String get settingsNotificationsSystemHint =>
      'Жүйе баптауларында рұқсат беріңіз.';

  @override
  String get settingsLanguageSystem => 'Жүйе тілі';

  @override
  String get settingsSupporterThanks => 'Қолдауыңызға рахмет!';

  @override
  String get settingsSupporterPack => 'Қолдаушы жинағы';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ерекше тақырып пен скин + 1 500 тиын';

  @override
  String get settingsRestorePurchases => 'Сатып алуларды қалпына келтіру';

  @override
  String get settingsRestoring => 'Сатып алулар қалпына келтірілуде…';

  @override
  String get settingsRateApp => 'Қолданбаны бағалау';

  @override
  String get settingsRateAppSubtitle => 'Дүкенде баға беріңіз';

  @override
  String get settingsStoreUnavailable => 'Бұл құрылғыда дүкен қолжетімсіз.';

  @override
  String get settingsFeedback => 'Кері байланыс жіберу';

  @override
  String get settingsFeedbackSubtitle =>
      'Идеялар мен қателер туралы жазыңыз (GitHub арқылы)';

  @override
  String get settingsAdPrivacy => 'Жарнама құпиялылығы';

  @override
  String get settingsAdPrivacySubtitle =>
      'Жарнамаға берген келісіміңізді көру немесе өзгерту';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Бұл құрылғыда жарнама параметрлері қажет емес.';

  @override
  String get settingsPrivacy => 'Құпиялылық саясаты';

  @override
  String get settingsImprint => 'Құқықтық ақпарат';

  @override
  String get settingsPageOpenFailed => 'Бетті ашу мүмкін болмады.';

  @override
  String get settingsFooter => 'Qubble • Офлайн блок-пазл';

  @override
  String get settingsAdminSection => 'Әкімші (сынақ)';

  @override
  String get settingsAdminEnabled => 'Әкімші режимі қосулы';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Әкімші режиміне дейін тағы $count рет түртіңіз';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins тиын',
      one: '$coins тиын',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Тек сынақ үшін — релиз скриншоттарында ешқашан';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount тиын',
      one: '$amount тиын',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Тиынды 0-ге түсіру';

  @override
  String get feedbackTitle => 'Кері байланыс';

  @override
  String get feedbackIntroShort =>
      'Не ұнайды, не ашуландырады, не жетіспейді? Ұсақ-түйек те көмектеседі — неғұрлым нақты болса, соғұрлым жақсы.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Тек $build және құрылғыңыздың түрі қосылады — қай нұсқа туралы сөз болып тұрғанын білу үшін.';
  }

  @override
  String get feedbackSendByMail => 'Эл. поштамен жіберу';

  @override
  String get feedbackPreferGithub => 'GitHub issue ыңғайлырақ';

  @override
  String get feedbackThanksMail => 'Рахмет! Хатты жіберсеңіз болғаны.';

  @override
  String get feedbackNoMailApp =>
      'Пошта қолданбасы табылмады. Төмендегі GitHub арқылы көріңіз.';

  @override
  String get feedbackEmptyHint => 'Алдымен бірдеңе жазыңыз.';

  @override
  String get leaderboardRefresh => 'Жаңарту';

  @override
  String get leaderboardRetry => 'Қайталау';

  @override
  String get feedbackHint => 'Пікіріңіз…';

  @override
  String get feedbackSubmit => 'Кері байланыс жіберу';

  @override
  String get feedbackOpenFailed => 'GitHub ашылмады. Кейінірек көріңіз.';

  @override
  String get feedbackGithubNote =>
      'GitHub ашылады — онда «Submit new issue» түймесін түртіңіз. (Бір рет GitHub-қа кіру қажет.)';

  @override
  String get shopTitle => 'Дүкен';

  @override
  String get shopWebDemoNote =>
      'Сатып алу тек Play Store қолданбасында қолжетімді. Бұл веб-нұсқа — тегін демо, бірақ мұнда бәрін ойнауға болады.';

  @override
  String get shopSupporterExplainer =>
      'Qubble мәжбүрлі жарнама көрсетпейді — ештеңе сатып алудың қажеті жоқ. Қолдаушы жинағы («Аврора» тақырыбы, «Кристал» скині, 1 500 тиын, қолдаушы белгісі) — ойынды қолдағаныңыз үшін алғыс. Сатып алулар дүкен аккаунтыңызға байланған және кез келген уақытта қалпына келтіріледі.';

  @override
  String get shopSupporterContents =>
      '«Аврора» тақырыбы + «Кристал» скині + 1 500 тиын';

  @override
  String get themesTitle => 'Тақырыптар';

  @override
  String get themesSupporterOnly => 'Тек қолдаушы жинағында (дүкенді қараңыз)';

  @override
  String get skinsTitle => 'Блок скиндері';

  @override
  String get skinsNotEnoughCoins => 'Тиын жеткіліксіз';

  @override
  String get skinsNotEnoughGold => 'Алтын жеткіліксіз.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold алтын = 1 алмас. Алмас ең әдемі скиндерді ашады — асықпай жинаңыз.';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsAverageScore => 'Орташа ұпай';

  @override
  String get statsBestCombo => 'Үздік комбо';

  @override
  String get statsGames => 'Ойындар';

  @override
  String get statsLinesCleared => 'Тазаланған сызықтар';

  @override
  String get statsPiecesPlaced => 'Қойылған фигуралар';

  @override
  String get statsCoins => 'Тиындар';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString комбо жасау';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Бір ойында $countString ұпайдан асу',
      one: 'Бір ойында $countString ұпайдан асу',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Жетістіктер';

  @override
  String get achievementFirstGameTitle => 'Алғашқы ойын';

  @override
  String get achievementFirstGameBody => 'Алғашқы ойыныңызды ойнаңыз';

  @override
  String get achievementGames25Title => 'Тұрақты ойыншы';

  @override
  String get achievementGames25Body => '25 ойын ойнаңыз';

  @override
  String get achievementGames100Title => 'Жанкүйер';

  @override
  String get achievementGames100Body => '100 ойын ойнаңыз';

  @override
  String get achievementScore1kTitle => 'Өрлеу';

  @override
  String get achievementScore1kBody => '1 000 ұпай жинаңыз';

  @override
  String get achievementScore5kTitle => 'Кәсіпқой';

  @override
  String get achievementScore5kBody => '5 000 ұпай жинаңыз';

  @override
  String get achievementScore10kTitle => 'Шебер';

  @override
  String get achievementScore10kBody => '10 000 ұпай жинаңыз';

  @override
  String get achievementScore25kTitle => 'Аңыз';

  @override
  String get achievementScore25kBody => '25 000 ұпай жинаңыз';

  @override
  String get achievementLines100Title => 'Ұқыптылық';

  @override
  String get achievementLines100Body => 'Барлығы 100 сызық тазалаңыз';

  @override
  String get achievementLines1000Title => 'Үлкен тазалық';

  @override
  String get achievementLines1000Body => 'Барлығы 1 000 сызық тазалаңыз';

  @override
  String get achievementCombo5Title => 'Комбо бастамасы';

  @override
  String get achievementCombo5Body => 'x5 комбо жасаңыз';

  @override
  String get achievementCombo10Title => 'Комбо патшасы';

  @override
  String get achievementCombo10Body => 'x10 комбо жасаңыз';

  @override
  String get achievementLevel10Title => 'Тәжірибелі';

  @override
  String get achievementLevel10Body => '10-деңгейге жетіңіз';

  @override
  String get achievementLevel20Title => 'Ардагер';

  @override
  String get achievementLevel20Body => '20-деңгейге жетіңіз';

  @override
  String get achievementStreak7Title => 'Апталық серия';

  @override
  String get achievementStreak7Body => 'Қатарынан 7 күн';

  @override
  String get achievementStreak30Title => 'Айлық серия';

  @override
  String get achievementStreak30Body => 'Қатарынан 30 күн';

  @override
  String get achievementPuzzles10Title => 'Пазл шебері';

  @override
  String get achievementPuzzles10Body => '10 пазл шешіңіз';

  @override
  String get achievementPieces5000Title => 'Құрылысшы';

  @override
  String get achievementPieces5000Body => '5 000 фигура қойыңыз';

  @override
  String streakRepairTitle(int streak) {
    return '$streak күндік серия қауіпте!';
  }

  @override
  String get streakRepairBody =>
      'Кеше ойналмады — сериясыңызды сақтап қалыңыз:';

  @override
  String get streakRepairFailed => 'Қалпына келтіру мүмкін болмады.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins тиын',
      one: '$coins тиын',
    );
    return 'Қайта қош келдіңіз! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Еске салғыштар?';

  @override
  String get notificationsOptInBody =>
      'Күнделікті пазлды еске салып, сериясыңызды қорғайық па? Мұны баптауларда кез келген уақытта өзгертуге болады.';

  @override
  String get notificationsOptInAccept => 'Иә, әрине';

  @override
  String get notificationChannelDescription =>
      'Күнделікті еске салу, серия туралы ескерту, қайта оралу';

  @override
  String get notificationDailyTitle => 'Күнделікті пазлыңыз күтіп тұр 🧩';

  @override
  String get notificationDailyBody => 'Бүгінгі сынақты ойнаңыз!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak күндік сериясыңыз қауіпте!';
  }

  @override
  String get notificationStreakBody => 'Оны сақтау үшін бүгін ойнаңыз.';

  @override
  String get notificationComebackTitle => 'Блоктарыңыз күтіп тұр 🧩';

  @override
  String get notificationComebackBody => 'Оралып, сыйлығыңызды алыңыз!';

  @override
  String get iapSupporterPack => 'Қолдаушы жинағы';

  @override
  String get iapCoinsSmall => '500 тиын';

  @override
  String get iapCoinsMedium => '2 000 тиын';

  @override
  String get iapCoinsLarge => '6 000 тиын';

  @override
  String get iapStarterPack => 'Бастауыш жинақ';

  @override
  String get iapRename => 'Есімді өзгерту';

  @override
  String get iapNeonTheme => '«Неон» тақырыбы';

  @override
  String get settingsLeaderboardDelete => 'Көшбасшылар жазбасын жою';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Есіміңіз бен ұпайыңыз ашық тізімнен алынып тасталады';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Жазбаңызды жою керек пе?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Есіміңіз бен ұпайыңыз көшбасшылар тізімінен алынып тасталады. Ойындағы прогресіңіз өзгермейді. Көшбасшыларға кез келген уақытта қайта қосылуға болады.';

  @override
  String get settingsLeaderboardDeleteDone => 'Көшбасшылар жазбаңыз жойылды.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Жазбаны жою мүмкін болмады. Байланысты тексеріп, қайталап көріңіз.';

  @override
  String get leaderboardReport => 'Бұл есім туралы шағымдану';

  @override
  String get leaderboardBlock => 'Жасыру';

  @override
  String leaderboardBlocked(String name) {
    return '$name сізден жасырылды';
  }

  @override
  String get leaderboardUndo => 'Болдырмау';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Жасырған жазбаларыңыз: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Қайта көрсету';

  @override
  String get leaderboardReportUnavailable => 'Қазір шағымдану мүмкін емес.';

  @override
  String get leaderboardReportSent => 'Рахмет — шағымыңыз жіберілді.';

  @override
  String get leaderboardRules =>
      'Есімдер жария. Балағат, қорлау немесе нақты адамды анықтайтын ештеңе болмауы керек. Бұл ережені бұзатын есімдер жойылады.';

  @override
  String get leaderboardRulesAccept => 'Түсінікті';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Ашылғаны: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'Сақталған деректер';

  @override
  String get gameRotatePiece => 'Фигураны бұру';

  @override
  String get themeClassic => 'Классика';

  @override
  String get themeFade => 'Пастель';

  @override
  String get themeNeon => 'Неон';

  @override
  String get themeOcean => 'Мұхит';

  @override
  String get themeWood => 'Ағаш';

  @override
  String get themeSunset => 'Күн батуы';

  @override
  String get themeForest => 'Орман';

  @override
  String get themeAurora => 'Аврора';

  @override
  String get skinClassic => 'Классика';

  @override
  String get skinGradient => 'Градиент';

  @override
  String get skinOutline => 'Контур';

  @override
  String get skinGlossy => 'Жылтыр';

  @override
  String get skinStripe => 'Жолақ';

  @override
  String get skinBevel => 'Қиғаш';

  @override
  String get skinGlow => 'Сәуле';

  @override
  String get skinCrystal => 'Кристал';

  @override
  String rewardThemeName(String name) {
    return '«$name» тақырыбы';
  }

  @override
  String rewardSkinName(String name) {
    return '«$name» скині';
  }

  @override
  String get skinPulse => 'Пульс';

  @override
  String get skinShimmer => 'Жарқыл';

  @override
  String get skinWave => 'Толқын';

  @override
  String get skinEmber => 'Шоқ';

  @override
  String get skinPrism => 'Призма';

  @override
  String get skinStardust => 'Жұлдыз тозаңы';

  @override
  String get skinCircuit => 'Тізбек';

  @override
  String get skinRipple => 'Иірім';

  @override
  String achievementRewardSkin(String name) {
    return 'Анимациялы скин: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Жетістік сыйлығы: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Жетістіктер енді сыйлық береді — сіздікі қосылды.';

  @override
  String get namePromptBody =>
      'Есім таңдаңыз, сонда ең жақсы нәтижеңіз көшбасшылар тізіміне шығады. Есімсіз жасырын ойнай бересіз.';

  @override
  String get nameTaken => 'Бұл есім бос емес. Басқасын көріңіз.';

  @override
  String get nameCheckFailed =>
      'Есімді тексеру мүмкін болмады. Интернетке қосылғансыз ба? Сәлден соң қайталап көріңіз.';

  @override
  String nameLost(String name) {
    return '$name енді басқа ойыншыға тиесілі. Жаңа есімді тегін таңдаңыз.';
  }

  @override
  String get themeCandy => 'Кәмпит';

  @override
  String get themeVolcano => 'Жанартау';

  @override
  String get themeGlacier => 'Мұздық';

  @override
  String get skinPixel => 'Пиксель';

  @override
  String get skinMarble => 'Мәрмәр';

  @override
  String get skinJelly => 'Желе';

  @override
  String get skinLiquid => 'Сұйықтық';

  @override
  String get skinFizz => 'Көпіршік';

  @override
  String get skinPlasma => 'Плазма';

  @override
  String get designsTitle => 'Дизайндар';

  @override
  String get designsNotEnoughDiamonds => 'Алмас жеткіліксіз.';

  @override
  String get designsOwned => 'Сенде бар';

  @override
  String get designsAchievementOnly => 'Жетістік';

  @override
  String get designsSupporterOnly => 'Қолдаушы';

  @override
  String get designsPreview => 'Алдын ала қарау';

  @override
  String get designsGetDiamonds => 'Алмас алу';

  @override
  String get shopDealTitle => 'Күн ұсынысы';

  @override
  String get shopAnimatedSkins => 'Анимациялы скиндер';

  @override
  String get shopNewDesigns => 'Жаңа дизайндар';

  @override
  String get shopDiamonds => 'Алмастар';

  @override
  String get shopPacks => 'Жинақтар';

  @override
  String get shopPopular => 'Танымал';

  @override
  String get shopBestValue => 'Ең тиімді';

  @override
  String get shopDiamondsBlurb => 'Анимациялы скиндер мен жаңа дизайндарға.';

  @override
  String get shopCoinsBlurb => 'Тақырыптарға, скиндерге және бустерлерге.';

  @override
  String get shopNeonBlurb => '«Неон» тақырыбын бірден ашады.';

  @override
  String get shopRenameBlurb => 'Көшбасшылар тізіміндегі атыңды өзгерт.';

  @override
  String shopHoursLeft(int hours) {
    return '$hours сағ қалды';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Жаңа ұсыныс: $time кейін';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name ашылды!';
  }

  @override
  String get questsTitle => 'Тапсырмалар';

  @override
  String get questsDaily => 'Күнделікті';

  @override
  String get questsWeekly => 'Апталық';

  @override
  String get questsMonthly => 'Айлық';

  @override
  String questsNewIn(String time) {
    return 'Жаңа тапсырмалар: $time кейін';
  }

  @override
  String get questsBonus => 'Барлығы үшін бонус';

  @override
  String get questsBonusEarned => 'Бонус алынды';

  @override
  String get questRounds => 'Раундтар ойна';

  @override
  String get questLines => 'Сызықтарды тазала';

  @override
  String get questPieces => 'Фигураларды қой';

  @override
  String get questDailyChallenge => 'Күнделікті сынақты ойна';

  @override
  String get questPuzzles => 'Жаңа жұмбақтарды шеш';

  @override
  String get questDays => 'Әр түрлі күндері ойна';

  @override
  String get questDailySets => 'Барлық күнделікті тапсырманы орында';

  @override
  String get questsSetDaily => 'Барлық күнделікті тапсырма орындалды!';

  @override
  String get questsSetWeekly => 'Барлық апталық тапсырма орындалды!';

  @override
  String get questsSetMonthly => 'Барлық айлық тапсырма орындалды!';

  @override
  String get leaderboardTabScore => 'Ең жоғары ұпай';

  @override
  String get leaderboardTabPuzzle => 'Жұмбақ жұлдыздары';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Жұмбақ жұлдыздарың автоматты түрде жіберіледі.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Жұмбақ жұлдыздарың ($stars) жіберілуде …';
  }

  @override
  String get dailyGoalTitle => 'Бүгінгі мақсат';

  @override
  String dailyGoalPoints(String points) {
    return '$points ұпай';
  }

  @override
  String get dailyChestOpened => 'Серия сандығы ашылды!';

  @override
  String dailyNextChest(int day) {
    return 'Келесі сандық: серияның $day-күні';
  }

  @override
  String get dailyExplainer =>
      'Бүгін бәрі бірдей тақтада ойнайды, ал сенің бірінші раундың есептеледі. Қосымша тиындар үшін жұлдыз белгілеріне жет, алмас сандықтары үшін серияңды сақта және бүгін нешінші орында екеніңді көр.';

  @override
  String dailyRank(int rank, int total) {
    return 'Бүгін $total ішінен $rank-орын';
  }

  @override
  String get dailyRankNeedsName => 'Рейтингте көріну үшін атау таңда.';

  @override
  String get dailyRankingButton => 'Бүгінгі рейтинг';

  @override
  String get leaderboardTabDaily => 'Бүгінгі сынақ';

  @override
  String get leaderboardDailyFooter =>
      'Барлығына бірдей тақта, бірінші раунд есептеледі. Күн сайын жаңа рейтинг.';

  @override
  String notificationChestBody(int diamonds) {
    return 'Бүгінгі сынақты ойнап, серия сандығын аш: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'Асқабақ';

  @override
  String get skinGhost => 'Елес';

  @override
  String get halloweenTitle => 'Хэллоуин';

  @override
  String get halloweenBody =>
      'Асқабақ тақырыбы мен елес скині — тек қазан айында.';

  @override
  String get designsBackInOctober => 'Қазанда қайта оралады';

  @override
  String get shopFreeTitle => 'Тегін бонус';

  @override
  String get shopFreeWatch => 'Бейнені көру';

  @override
  String shopFreeToday(int left, int total) {
    return 'Бүгін: $left/$total';
  }

  @override
  String get shopFreeTomorrow => 'Ертең қайта';

  @override
  String get designsAccessories => 'Аксессуарлар';

  @override
  String get designsBursts => 'Жарылыстар';

  @override
  String get accessoryNone => 'Жоқ';

  @override
  String get accessoryCobweb => 'Өрмекші торы';

  @override
  String get accessorySnowCap => 'Қар бөрік';

  @override
  String get accessoryCrown => 'Тәж';

  @override
  String get accessoryFlower => 'Гүл';

  @override
  String get accessorySparkle => 'Жарқыл';

  @override
  String get accessoryDewdrop => 'Шық тамшысы';

  @override
  String get burstClassic => 'Классикалық';

  @override
  String get burstConfetti => 'Конфетти';

  @override
  String get burstFire => 'От';

  @override
  String get burstPixels => 'Пиксельдер';

  @override
  String get burstStars => 'Жұлдыздар';

  @override
  String get burstBubbles => 'Көпіршіктер';

  @override
  String bestShareText(String score) {
    return 'Qubble-дегі жаңа рекордым: $score ұпай! Оны жаңарта аласың ба?';
  }
}
