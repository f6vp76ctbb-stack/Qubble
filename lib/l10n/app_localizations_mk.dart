// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class L10nMk extends L10n {
  L10nMk([String locale = 'mk']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Играј';

  @override
  String get commonLater => 'Подоцна';

  @override
  String get commonNotNow => 'Не сега';

  @override
  String get commonCancel => 'Откажи';

  @override
  String get commonBuy => 'Купи';

  @override
  String get commonSave => 'Зачувај';

  @override
  String get commonCollect => 'Земи';

  @override
  String get nameNewName => 'Ново име';

  @override
  String get nameFieldLabel => 'Име';

  @override
  String get piggyFullTitle => 'Касичката е полна!';

  @override
  String get piggyKeepSaving => 'Продолжи да штедиш';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Собрани $coins од $capacity.';
  }

  @override
  String get homeContinueRun => 'Продолжи';

  @override
  String get homeVideo => 'Видео';

  @override
  String get commonGotIt => 'Разбрав';

  @override
  String get commonHome => 'Почетна';

  @override
  String get commonScore => 'ПОЕНИ';

  @override
  String get commonBest => 'РЕКОРД';

  @override
  String commonLevelShort(int level) {
    return 'Ниво $level';
  }

  @override
  String get homeNewRun => 'Започни нова игра';

  @override
  String get homeBackToExit => 'Притисни „Назад“ уште еднаш за излез';

  @override
  String get homeEnableLeaderboard => 'Влези на ранг-листата';

  @override
  String get homeBestScore => 'НАЈДОБАР РЕЗУЛТАТ';

  @override
  String get homeDailyChallenge => 'Дневен предизвик';

  @override
  String get homeDailyOpenToday => 'Отворено денес';

  @override
  String homeDailyNextIn(String time) {
    return 'Следен предизвик за $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Низа: $streak дена',
      one: 'Низа: $streak ден',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Ранг-листа';

  @override
  String get homePuzzleMode => 'Загатки';

  @override
  String get homeMissions => 'Мисии';

  @override
  String get homeThemes => 'Теми';

  @override
  String get homeSkins => 'Изгледи';

  @override
  String get homeHowToPlay => 'Како се игра Qubble';

  @override
  String get homeWeekendBonus => 'Викенд: двојни парички!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Ниво $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Промени име';

  @override
  String get nameChangeExplainer =>
      'Твоето име е твојот идентитет на ранг-листата, затоа не се менува. Можеш да купиш еднократна промена на името.';

  @override
  String get nameChangeAfterPurchase =>
      'По купувањето допри го пак своето име за да го смениш.';

  @override
  String get nameJoinedLeaderboard => 'Сега си на ранг-листата.';

  @override
  String get nameRenameUnavailable => 'Промена на името моментално не е можна.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'Најмалку $min знаци.',
      one: 'Најмалку $min знак.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'Најмногу $max знаци.',
      one: 'Најмногу $max знак.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Само латински букви (A–Z), цифри, празни места, _ и -.';

  @override
  String get nameProblemOffensive => 'Избери друго име.';

  @override
  String get piggyTitle => 'Касичка';

  @override
  String get piggyFillingHint => 'Касичката се полни додека бришеш редови.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins парички',
      one: '$coins паричка',
    );
    return 'Земи $_temp0 — бесплатно.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Кога ќе се наполни, ја празниш бесплатно — или ја отвораш порано со бонус видео.';

  @override
  String get piggyOpenNow => 'Отвори сега';

  @override
  String get gameNewPiecesVideo => 'Нови парчиња (видео)';

  @override
  String get gameTapBoardCell => 'Допри поле на таблата';

  @override
  String get gameDailyChallengeLabel => 'ДНЕВЕН ПРЕДИЗВИК';

  @override
  String get gameOver => 'Крај на играта';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'За бомбата ти недостигаат парички: $missing.';
  }

  @override
  String get gameBombNotHere => 'Бомбата моментално не работи тука.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Ти недостигаат парички: $missing.';
  }

  @override
  String get gameNotRightNow => 'Моментално не е можно.';

  @override
  String get gameRunSaved => 'Играта е зачувана — „Продолжи“ во менито.';

  @override
  String get gameOverNoFit => 'Ниту едно твое парче веќе не собира на таблата.';

  @override
  String get gameOverNoFitNoRotations =>
      'Ниту едно парче не собира — а вртењата се потрошени.';

  @override
  String get gameStarterOfferUnavailable => 'Моментално не е достапно';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — земи';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'КОМБО x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Достигнување: $title';
  }

  @override
  String get gameBestSubmitted => 'Нов рекорд — испратен';

  @override
  String get gameReviveFor => 'Продолжи ја играта · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Отклучено: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Почетен пакет';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score поени',
      one: '$score поен',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Нов рекорд!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Низа: $streak дена',
      one: 'Низа: $streak ден',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Удвои ги паричките';

  @override
  String get gameDoubleDaily => 'Удвои ја дневната награда';

  @override
  String get gamePlayAgain => 'Играј повторно';

  @override
  String gameLevelReached(int level) {
    return 'Достигнато ниво $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count нивоа — ниво $level!',
      one: '+$count ниво — ниво $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 парички + тема Дрво';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Уште само $hours часа — само еднаш!',
      one: 'Уште само $hours час — само еднаш!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Врати';

  @override
  String get boosterSwap => 'Замени';

  @override
  String get boosterBomb => 'Бомба';

  @override
  String get boosterNoRotationsLeft =>
      'Нема повеќе вртења — бриши редови за да ги наполниш!';

  @override
  String get onboardingDragPiece => 'Повлечи блок на мрежата';

  @override
  String get onboardingFillLine => 'Пополни цел ред или колона';

  @override
  String get onboardingLinesClear => 'Полните редови исчезнуваат — поени!';

  @override
  String get coachHintCombo =>
      'Комбо! Избриши пак во рок од 3 потези за да го задржиш';

  @override
  String get coachHintFever => 'ЖАР! Двојни поени додека свети';

  @override
  String get coachHintRotation =>
      'Вртењето троши едно полнење — бришењата го дополнуваат';

  @override
  String get coachHintBooster => 'Совет: долу имаш засилувачи';

  @override
  String get coachHintStrategy =>
      'Совет: не сите редови одеднаш — остави место за големите парчиња';

  @override
  String get dailyStreakLabel => 'Низа';

  @override
  String get dailyBestLabel => 'Дневен рекорд';

  @override
  String dailyHistoryNote(int days) {
    return 'Се чуваат последните $days дена.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: одиграно';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: пропуштено';
  }

  @override
  String get homeDailyCalendar => 'Календар';

  @override
  String get dailyShareButton => 'Сподели резултат';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Дневен предизвик $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Поени: $score · најдобро комбо x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Играј: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Комбо: уште $moves потези',
      one: 'Комбо: уште $moves потег',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Резултатот е копиран';

  @override
  String get adNotAvailable =>
      'Моментално нема видео — обиди се повторно малку подоцна';

  @override
  String get howToPlaySpeedTitle => 'Бонус за брзина';

  @override
  String get howToPlaySpeedBody =>
      'Брзото поставување додава до 30 % на бришењето. Бонусот слабее помеѓу 1,5 и 4 секунди и има горна граница, па брзината помага, но не ја одлучува играта — промислена, мирна игра сè уште може да победи брзоплета брза игра.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Бонус за брзина $percent проценти';
  }

  @override
  String get iapDiamondsSmall => '100 дијаманти';

  @override
  String get iapDiamondsMedium => '350 дијаманти';

  @override
  String get iapDiamondsLarge => '1.000 дијаманти';

  @override
  String get howToPlayTitle => 'Како се игра Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Лесно за почеток.\nГо наградува планирањето.';

  @override
  String get howToPlayIntroBody =>
      'Чувај ја таблата слободна и собори го својот рекорд.';

  @override
  String get howToPlayIntroSemantics =>
      'Целта на играта. Чувај ја таблата слободна и собори го својот рекорд.';

  @override
  String get howToPlayDragTitle => 'Повлечи и пушти';

  @override
  String get howToPlayDragBody =>
      'Повлечи едно од трите парчиња на слободни полиња. Кога ќе ги искористиш сите три, автоматски добиваш три нови.';

  @override
  String get howToPlayClearTitle => 'Бриши редови';

  @override
  String get howToPlayClearBody =>
      'Пополни цел ред или колона. Полните редови исчезнуваат и ослободуваат место за следниот потег.';

  @override
  String get howToPlayComboTitle => 'Нижи комбо';

  @override
  String get howToPlayComboBody =>
      'Избриши уште еден ред во рок од три потези. Секое дополнително комбо го зголемува множителот на поени. Комбото брои потези, не секунди — па не истекува додека размислуваш.';

  @override
  String get howToPlayFeverTitle => 'Разгори го жарот';

  @override
  String get howToPlayFeverBody =>
      'Бришењата го полнат мерачот на жар. Кога ќе се наполни, следната експлозија се брои двојно — планирај ги големите бришења однапред.';

  @override
  String get howToPlayBoosterTitle => 'Користи ги засилувачите паметно';

  @override
  String get howToPlayBoosterBody =>
      'Засилувачите спасуваат тешки игри. Парче долу можеш и да го свртиш со допир.';

  @override
  String get howToPlayDailyTitle => 'Дневен предизвик и низа';

  @override
  String get howToPlayDailyBody =>
      'Во дневниот предизвик сите ги добиваат истите парчиња. Играј секој ден за да ги зголемиш низата и бонусот.';

  @override
  String get howToPlayPiggyTitle => 'Наполни ја касичката';

  @override
  String get howToPlayPiggyBody =>
      'Секој избришан ред ја полни твојата касичка. Кога ќе се наполни, земи ги паричките бесплатно.';

  @override
  String get leaderboardTitle => 'Ранг-листа';

  @override
  String get leaderboardUnreachable =>
      'Ранг-листата не е достапна.\nОбиди се повторно со интернет.';

  @override
  String get leaderboardEmpty =>
      'Сè уште нема записи.\nЗаземи го првото место!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Твојот рекорд ($score) се испраќа …';
  }

  @override
  String get leaderboardAutoSubmit => 'Твојот рекорд се испраќа автоматски.';

  @override
  String get puzzleModeTitle => 'Загатки';

  @override
  String puzzleLevelTitle(int level) {
    return 'Загатка $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Потези: $moves   •   Цел: $target за 3 ѕвезди';
  }

  @override
  String get puzzleSolved => 'Решено!';

  @override
  String get puzzleLeaveTitle => 'Да ја напуштиш загатката?';

  @override
  String get puzzleLeaveBody => 'Напредокот во оваа загатка ќе се изгуби.';

  @override
  String get puzzleKeepPlaying => 'Продолжи да играш';

  @override
  String get puzzleLeave => 'Напушти';

  @override
  String get puzzleStuckTitle => 'Без излез';

  @override
  String get puzzleRestart => 'Почни одново';

  @override
  String get commonActive => 'Активно';

  @override
  String get commonTapToActivate => 'Допри за вклучување';

  @override
  String get commonRestore => 'Врати';

  @override
  String unlockForCost(int cost) {
    return 'Отклучи за $cost';
  }

  @override
  String get skinsExchangeGold => 'Размени злато';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Сврти го парчето';

  @override
  String get puzzleNextLevel => 'Следно ниво';

  @override
  String get puzzleBackToOverview => 'Назад кон листата';

  @override
  String get puzzleUnsolvable =>
      'Од тука таблата повеќе не може да се исчисти.';

  @override
  String get puzzleExtraMoveVideo => 'Дополнителен потег (видео)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Решени: $solved';
  }

  @override
  String get settingsTitle => 'Поставки';

  @override
  String get storageFailureTitle =>
      'Qubble не може да ја вчита зачуваната игра';

  @override
  String get storageFailureBody =>
      'Рестартирај ја апликацијата. Ако грешката остане, единствено решение е повторна инсталација. Можеш да ја пријавиш преку Поставки › Мислење.';

  @override
  String get iapUnavailable => 'Оваа понуда моментално не е достапна.';

  @override
  String get iapFailed => 'Купувањето не беше завршено. Ништо не е наплатено.';

  @override
  String get settingsResetProgress => 'Ресетирај напредок';

  @override
  String get settingsResetProgressSubtitle =>
      'Поени, парички, ниво и напредок од почеток. Купувањата, името и изгледите остануваат.';

  @override
  String get settingsResetConfirmTitle => 'Да се ресетира напредокот?';

  @override
  String get settingsResetConfirmBody =>
      'Рекордот, паричките, нивото, низата и целиот напредок ќе се избришат. Ова не може да се врати.\n\nКупувањата, името и отклучените теми и изгледи остануваат.';

  @override
  String get settingsResetConfirmAction => 'Ресетирај';

  @override
  String get settingsResetDone => 'Напредокот е ресетиран.';

  @override
  String get settingsSectionGame => 'Игра';

  @override
  String get settingsSectionSoundHaptics => 'Звук и вибрации';

  @override
  String get settingsSectionReminders => 'Потсетници';

  @override
  String get settingsSectionPurchases => 'Купувања';

  @override
  String get settingsSectionHelpOut => 'Помогни';

  @override
  String get settingsSectionLegal => 'Правни информации';

  @override
  String get settingsSectionLanguage => 'Јазик';

  @override
  String get settingsGuide => 'Како се игра';

  @override
  String get settingsGuideSubtitle => 'Правила, комбо, жар и засилувачи';

  @override
  String get settingsSound => 'Звук';

  @override
  String get settingsMusic => 'Музика';

  @override
  String get settingsHaptics => 'Вибрации';

  @override
  String get settingsHapticsOff => 'Исклучено';

  @override
  String get settingsHapticsLight => 'Слабо';

  @override
  String get settingsHapticsStrong => 'Силно';

  @override
  String get settingsSectionAccessibility => 'Пристапност';

  @override
  String get settingsReducedEffects => 'Помалку ефекти';

  @override
  String get settingsReducedEffectsHint =>
      'Помалку честички, без тресење на екранот, без блесоци';

  @override
  String get settingsNotifications => 'Известувања';

  @override
  String get settingsNotificationsSubtitle =>
      'Дневен потсетник и заштита на низата';

  @override
  String get settingsNotificationsSystemHint =>
      'Дозволи ги во системските поставки.';

  @override
  String get settingsLanguageSystem => 'Јазик на системот';

  @override
  String get settingsSupporterThanks => 'Ти благодариме за поддршката!';

  @override
  String get settingsSupporterPack => 'Пакет за поддржувачи';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ексклузивна тема и изглед + 1.500 парички';

  @override
  String get settingsRestorePurchases => 'Врати ги купувањата';

  @override
  String get settingsRestoring => 'Купувањата се враќаат…';

  @override
  String get settingsRateApp => 'Оцени ја апликацијата';

  @override
  String get settingsRateAppSubtitle => 'Остави оценка во продавницата';

  @override
  String get settingsStoreUnavailable =>
      'Продавницата не е достапна на овој уред.';

  @override
  String get settingsFeedback => 'Испрати мислење';

  @override
  String get settingsFeedbackSubtitle => 'Идеи и грешки (преку GitHub)';

  @override
  String get settingsAdPrivacy => 'Приватност на рекламите';

  @override
  String get settingsAdPrivacySubtitle =>
      'Види или промени ја согласноста за реклами';

  @override
  String get settingsAdPrivacyUnavailable =>
      'На овој уред не се потребни опции за реклами.';

  @override
  String get settingsPrivacy => 'Политика за приватност';

  @override
  String get settingsImprint => 'Правни податоци';

  @override
  String get settingsPageOpenFailed => 'Страницата не можеше да се отвори.';

  @override
  String get settingsFooter => 'Qubble • Блок-загатка без интернет';

  @override
  String get settingsAdminSection => 'Админ (тест)';

  @override
  String get settingsAdminEnabled => 'Админ-режимот е вклучен';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Уште $count допири до админ-режимот',
      one: 'Уште $count допир до админ-режимот',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins парички',
      one: '$coins паричка',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Само за тестирање — никогаш во слики за објава';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount парички',
      one: '$amount паричка',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Парички на 0';

  @override
  String get feedbackTitle => 'Мислење';

  @override
  String get feedbackIntroShort =>
      'Што ти се допаѓа, што те нервира, што недостига? И ситниците помагаат — колку поконкретно, толку подобро.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Се додаваат само $build и типот на уредот — за да знам за која верзија станува збор.';
  }

  @override
  String get feedbackSendByMail => 'Испрати по е-пошта';

  @override
  String get feedbackPreferGithub => 'Подобро issue на GitHub';

  @override
  String get feedbackThanksMail => 'Благодарам! Само испрати ја пораката.';

  @override
  String get feedbackNoMailApp =>
      'Не е пронајдена апликација за пошта. Обиди се преку GitHub подолу.';

  @override
  String get feedbackEmptyHint => 'Прво напиши нешто.';

  @override
  String get leaderboardRefresh => 'Освежи';

  @override
  String get leaderboardRetry => 'Обиди се повторно';

  @override
  String get feedbackHint => 'Твоето мислење…';

  @override
  String get feedbackSubmit => 'Испрати мислење';

  @override
  String get feedbackOpenFailed =>
      'GitHub не можеше да се отвори. Обиди се подоцна.';

  @override
  String get feedbackGithubNote =>
      'Се отвора GitHub — таму допри „Submit new issue“. (Потребна е еднократна најава на GitHub.)';

  @override
  String get shopTitle => 'Продавница';

  @override
  String get shopWebDemoNote =>
      'Купувањата се можни само во апликацијата од Play Store. Оваа веб-верзија е бесплатно демо — сепак тука можеш да играш сè.';

  @override
  String get shopSupporterExplainer =>
      'Qubble не прикажува задолжителни реклами — не мораш ништо да купуваш. Пакетот за поддржувачи (тема Аурора, изглед Кристал, 1.500 парички, значка за поддржувач) е благодарност што ја поддржуваш играта. Купувањата се поврзани со твојата сметка во продавницата и можат да се вратат во секое време.';

  @override
  String get shopSupporterContents =>
      'Тема Аурора + изглед Кристал + 1.500 парички';

  @override
  String get themesTitle => 'Теми';

  @override
  String get themesSupporterOnly =>
      'Само во пакетот за поддржувачи (види ја продавницата)';

  @override
  String get themesInSupporterPack => 'Во пакетот за поддржувачи';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Немаш доволно парички (потребни се $cost, имаш $coins)';
  }

  @override
  String get skinsTitle => 'Изгледи на блоковите';

  @override
  String get skinsNotEnoughDiamonds =>
      'Немаш доволно дијаманти (размени злато подолу)';

  @override
  String get skinsNotEnoughCoins => 'Немаш доволно парички';

  @override
  String get skinsNotEnoughGold => 'Немаш доволно злато.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold злато = 1 дијамант. Дијамантите ги отклучуваат најубавите изгледи — собирај полека.';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsAverageScore => 'Просечни поени';

  @override
  String get statsBestCombo => 'Најдобро комбо';

  @override
  String get statsGames => 'Игри';

  @override
  String get statsLinesCleared => 'Избришани редови';

  @override
  String get statsPiecesPlaced => 'Поставени парчиња';

  @override
  String get statsCoins => 'Парички';

  @override
  String get missionsTitle => 'Мисии';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Постави $countString парчиња',
      one: 'Постави $countString парче',
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
      other: 'Избриши $countString редови',
      one: 'Избриши $countString ред',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Постигни комбо x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Надмини $countString поени во една игра',
      one: 'Надмини $countString поен во една игра',
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
      other: 'Одиграј $countString игри',
      one: 'Одиграј $countString игра',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Достигнувања';

  @override
  String get achievementFirstGameTitle => 'Прва игра';

  @override
  String get achievementFirstGameBody => 'Одиграј ја својата прва игра';

  @override
  String get achievementGames25Title => 'Редовен гостин';

  @override
  String get achievementGames25Body => 'Одиграј 25 игри';

  @override
  String get achievementGames100Title => 'Обожавател';

  @override
  String get achievementGames100Body => 'Одиграј 100 игри';

  @override
  String get achievementScore1kTitle => 'Во подем';

  @override
  String get achievementScore1kBody => 'Освои 1.000 поени';

  @override
  String get achievementScore5kTitle => 'Професионалец';

  @override
  String get achievementScore5kBody => 'Освои 5.000 поени';

  @override
  String get achievementScore10kTitle => 'Мајстор';

  @override
  String get achievementScore10kBody => 'Освои 10.000 поени';

  @override
  String get achievementScore25kTitle => 'Легенда';

  @override
  String get achievementScore25kBody => 'Освои 25.000 поени';

  @override
  String get achievementLines100Title => 'Уредност';

  @override
  String get achievementLines100Body => 'Избриши вкупно 100 редови';

  @override
  String get achievementLines1000Title => 'Големо чистење';

  @override
  String get achievementLines1000Body => 'Избриши вкупно 1.000 редови';

  @override
  String get achievementCombo5Title => 'Почеток на комбо';

  @override
  String get achievementCombo5Body => 'Постигни комбо x5';

  @override
  String get achievementCombo10Title => 'Крал на комбото';

  @override
  String get achievementCombo10Body => 'Постигни комбо x10';

  @override
  String get achievementLevel10Title => 'Искусен';

  @override
  String get achievementLevel10Body => 'Стигни до ниво 10';

  @override
  String get achievementLevel20Title => 'Ветеран';

  @override
  String get achievementLevel20Body => 'Стигни до ниво 20';

  @override
  String get achievementStreak7Title => 'Неделна низа';

  @override
  String get achievementStreak7Body => 'Дневна низа од 7 дена';

  @override
  String get achievementStreak30Title => 'Месечна низа';

  @override
  String get achievementStreak30Body => 'Дневна низа од 30 дена';

  @override
  String get achievementPuzzles10Title => 'Решавач на загатки';

  @override
  String get achievementPuzzles10Body => 'Реши 10 загатки';

  @override
  String get achievementPieces5000Title => 'Градител';

  @override
  String get achievementPieces5000Body => 'Постави 5.000 парчиња';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Низата од $streak дена е во опасност!',
      one: 'Низата од $streak ден е во опасност!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Вчера не е играно — спаси ја својата низа:';

  @override
  String get streakRepairFailed => 'Поправката не успеа.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins парички',
      one: '$coins паричка',
    );
    return 'Добредојде назад! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Потсетници?';

  @override
  String get notificationsOptInBody =>
      'Да те потсетуваме на дневната загатка и да ја чуваме твојата низа? Може да се смени во поставките во секое време.';

  @override
  String get notificationsOptInAccept => 'Да, секако';

  @override
  String get notificationChannelDescription =>
      'Дневен потсетник, предупредување за низата, враќање';

  @override
  String get notificationDailyTitle => 'Твојата дневна загатка те чека 🧩';

  @override
  String get notificationDailyBody => 'Одиграј го денешниот предизвик!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 Твојата низа од $streak дена е во опасност!',
      one: '🔥 Твојата низа од $streak ден е во опасност!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Играј денес за да ја задржиш.';

  @override
  String get notificationComebackTitle => 'Твоите блокови те чекаат 🧩';

  @override
  String get notificationComebackBody => 'Врати се и земи ја наградата!';

  @override
  String get iapSupporterPack => 'Пакет за поддржувачи';

  @override
  String get iapCoinsSmall => '500 парички';

  @override
  String get iapCoinsMedium => '2.000 парички';

  @override
  String get iapCoinsLarge => '6.000 парички';

  @override
  String get iapStarterPack => 'Почетен пакет';

  @override
  String get iapRename => 'Промена на име';

  @override
  String get iapNeonTheme => 'Тема Неон';

  @override
  String get settingsLeaderboardDelete => 'Избриши запис од ранг-листата';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Ги отстранува името и поените од јавната листа';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Да се избрише твојот запис?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Твоето име и поени ќе се отстранат од ранг-листата. Напредокот во играта не се менува. Можеш повторно да се приклучиш во секое време.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Твојот запис на ранг-листата е избришан.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Записот не можеше да се избрише. Провери ја врската и обиди се повторно.';

  @override
  String get leaderboardReport => 'Пријави го ова име';

  @override
  String get leaderboardBlock => 'Скриј';

  @override
  String leaderboardBlocked(String name) {
    return 'Скриено за тебе: $name';
  }

  @override
  String get leaderboardUndo => 'Врати';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Скриени записи: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Прикажи ги пак';

  @override
  String get leaderboardReportUnavailable =>
      'Пријавувањето моментално не е можно.';

  @override
  String get leaderboardReportSent => 'Благодарам — пријавата е испратена.';

  @override
  String get leaderboardRules =>
      'Имињата се јавни. Без навреди, пцости или нешто што открива вистинска личност. Имињата што го кршат ова правило се отстрануваат.';

  @override
  String get leaderboardRulesAccept => 'Разбрав';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Отклучени: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'Зачувани податоци';

  @override
  String get gameRotatePiece => 'Сврти го парчето';

  @override
  String get themeClassic => 'Класична';

  @override
  String get themeFade => 'Пастелна';

  @override
  String get themeNeon => 'Неон';

  @override
  String get themeOcean => 'Океан';

  @override
  String get themeWood => 'Дрво';

  @override
  String get themeSunset => 'Зајдисонце';

  @override
  String get themeForest => 'Шума';

  @override
  String get themeAurora => 'Аурора';

  @override
  String get skinClassic => 'Класичен';

  @override
  String get skinGradient => 'Преливен';

  @override
  String get skinOutline => 'Контура';

  @override
  String get skinGlossy => 'Сјаен';

  @override
  String get skinStripe => 'Пругаст';

  @override
  String get skinBevel => 'Закосен';

  @override
  String get skinGlow => 'Светлечки';

  @override
  String get skinCrystal => 'Кристал';

  @override
  String rewardThemeName(String name) {
    return 'Тема $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Изглед $name';
  }

  @override
  String get skinPulse => 'Пулс';

  @override
  String get skinShimmer => 'Блескање';

  @override
  String get skinWave => 'Бран';

  @override
  String get skinEmber => 'Жар';

  @override
  String get skinPrism => 'Призма';

  @override
  String get skinStardust => 'Ѕвездена прашина';

  @override
  String get skinCircuit => 'Струјно коло';

  @override
  String get skinRipple => 'Брановчиња';

  @override
  String achievementRewardSkin(String name) {
    return 'Анимиран изглед: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Награда за достигнување: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Достигнувањата сега носат награди — твоите се додадени.';
}
