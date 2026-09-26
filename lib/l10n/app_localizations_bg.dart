// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class L10nBg extends L10n {
  L10nBg([String locale = 'bg']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Играй';

  @override
  String get commonLater => 'По-късно';

  @override
  String get commonNotNow => 'Не сега';

  @override
  String get commonCancel => 'Отказ';

  @override
  String get commonBuy => 'Купи';

  @override
  String get commonSave => 'Запази';

  @override
  String get commonCollect => 'Вземи';

  @override
  String get nameNewName => 'Ново име';

  @override
  String get nameFieldLabel => 'Име';

  @override
  String get piggyFullTitle => 'Касичката е пълна!';

  @override
  String get piggyKeepSaving => 'Продължи да спестяваш';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Събрани $coins от $capacity.';
  }

  @override
  String get homeContinueRun => 'Продължи';

  @override
  String get homeVideo => 'Видео';

  @override
  String get commonGotIt => 'Разбрах';

  @override
  String get commonHome => 'Начало';

  @override
  String get commonScore => 'ТОЧКИ';

  @override
  String get commonBest => 'РЕКОРД';

  @override
  String commonLevelShort(int level) {
    return 'Ниво $level';
  }

  @override
  String get homeNewRun => 'Започни нова игра';

  @override
  String get homeBackToExit => 'Натисни „Назад“ отново за изход';

  @override
  String get homeEnableLeaderboard => 'Влез в класацията';

  @override
  String get homeBestScore => 'НАЙ-ДОБЪР РЕЗУЛТАТ';

  @override
  String get homeDailyChallenge => 'Дневно предизвикателство';

  @override
  String get homeDailyOpenToday => 'Отворено днес';

  @override
  String homeDailyNextIn(String time) {
    return 'Следващо предизвикателство след $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Серия: $streak дни',
      one: 'Серия: $streak ден',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Класация';

  @override
  String get homePuzzleMode => 'Пъзели';

  @override
  String get homeMissions => 'Мисии';

  @override
  String get homeThemes => 'Теми';

  @override
  String get homeSkins => 'Облици';

  @override
  String get homeHowToPlay => 'Как се играе Qubble';

  @override
  String get homeWeekendBonus => 'Уикенд: двойни монети!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Ниво $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Смени името';

  @override
  String get nameChangeExplainer =>
      'Името ти е самоличността ти в класацията, затова не се променя. Можеш да купиш еднократна смяна на името.';

  @override
  String get nameChangeAfterPurchase =>
      'След покупката докосни името си отново, за да го смениш.';

  @override
  String get nameJoinedLeaderboard => 'Вече си в класацията.';

  @override
  String get nameRenameUnavailable =>
      'Смяната на името не е възможна в момента.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'Поне $min знака.',
      one: 'Поне $min знак.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'Най-много $max знака.',
      one: 'Най-много $max знак.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Само латински букви (A–Z), цифри, интервали, _ и -.';

  @override
  String get nameProblemOffensive => 'Избери друго име.';

  @override
  String get piggyTitle => 'Касичка';

  @override
  String get piggyFillingHint => 'Касичката се пълни, докато изчистваш редове.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins монети',
      one: '$coins монета',
    );
    return 'Вземи $_temp0 — безплатно.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Когато се напълни, можеш да я изпразниш безплатно — или да я отвориш по-рано с бонус видео.';

  @override
  String get piggyOpenNow => 'Отвори сега';

  @override
  String get gameNewPiecesVideo => 'Нови блокчета (видео)';

  @override
  String get gameTapBoardCell => 'Докосни клетка на дъската';

  @override
  String get gameDailyChallengeLabel => 'ДНЕВНО ПРЕДИЗВИКАТЕЛСТВО';

  @override
  String get gameOver => 'Край на играта';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'За бомбата не стигат монети: $missing.';
  }

  @override
  String get gameBombNotHere => 'Бомбата не работи тук в момента.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Не стигат монети: $missing.';
  }

  @override
  String get gameNotRightNow => 'Не е възможно в момента.';

  @override
  String get gameRunSaved => 'Играта е запазена — „Продължи“ в менюто.';

  @override
  String get gameOverNoFit =>
      'Нито едно от блокчетата ти вече не се побира на дъската.';

  @override
  String get gameOverNoFitNoRotations =>
      'Нито едно блокче не се побира — а завъртанията свършиха.';

  @override
  String get gameStarterOfferUnavailable => 'Не е налично сега';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — вземи';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'КОМБО x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Постижение: $title';
  }

  @override
  String get gameBestSubmitted => 'Нов рекорд — изпратен';

  @override
  String get gameReviveFor => 'Продължи играта · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Отключено: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Стартов пакет';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score точки',
      one: '$score точка',
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
      other: 'Серия: $streak дни',
      one: 'Серия: $streak ден',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Двойни монети';

  @override
  String get gameDoubleDaily => 'Двойна дневна награда';

  @override
  String get gamePlayAgain => 'Играй отново';

  @override
  String gameLevelReached(int level) {
    return 'Достигна ниво $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count нива — ниво $level!',
      one: '+$count ниво — ниво $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 монети + тема Дърво';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Остават само $hours часа — само веднъж!',
      one: 'Остава само $hours час — само веднъж!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Отмени';

  @override
  String get boosterSwap => 'Смяна';

  @override
  String get boosterBomb => 'Бомба';

  @override
  String get boosterNoRotationsLeft =>
      'Няма повече завъртания — изчисти редове, за да ги презаредиш!';

  @override
  String get onboardingDragPiece => 'Плъзни блокче върху мрежата';

  @override
  String get onboardingFillLine => 'Запълни цял ред или колона';

  @override
  String get onboardingLinesClear => 'Пълните редове изчезват — точки!';

  @override
  String get coachHintCombo =>
      'Комбо! Изчисти отново до 3 хода, за да го запазиш';

  @override
  String get coachHintFever => 'ТРЕСКА! Двойни точки, докато свети';

  @override
  String get coachHintRotation =>
      'Завъртането струва един заряд — изчистванията го пълнят';

  @override
  String get coachHintBooster => 'Съвет: долу има помощници';

  @override
  String get coachHintStrategy =>
      'Съвет: не всички редове наведнъж — остави място за големите блокчета';

  @override
  String get dailyStreakLabel => 'Серия';

  @override
  String get dailyBestLabel => 'Дневен рекорд';

  @override
  String dailyHistoryNote(int days) {
    return 'Пазят се последните $days дни.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: изиграно';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: пропуснато';
  }

  @override
  String get homeDailyCalendar => 'Календар';

  @override
  String get dailyShareButton => 'Сподели резултата';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Дневно предизвикателство $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Точки: $score · най-добро комбо x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Играй: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Комбо: остават $moves хода',
      one: 'Комбо: остава $moves ход',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Резултатът е копиран';

  @override
  String get adNotAvailable => 'В момента няма видео — опитай пак след малко';

  @override
  String get howToPlaySpeedTitle => 'Бонус за скорост';

  @override
  String get howToPlaySpeedBody =>
      'Бързото поставяне добавя до 30 % към изчистването. Бонусът намалява между 1,5 и 4 секунди и има таван, така че скоростта се отплаща, без да решава играта — внимателна, бавна игра пак може да победи прибързаната.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Бонус за скорост $percent процента';
  }

  @override
  String get iapDiamondsSmall => '100 диаманта';

  @override
  String get iapDiamondsMedium => '350 диаманта';

  @override
  String get iapDiamondsLarge => '1000 диаманта';

  @override
  String get howToPlayTitle => 'Как се играе Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Лесно за начало.\nНаграждава планирането.';

  @override
  String get howToPlayIntroBody =>
      'Пази дъската свободна и подобри рекорда си.';

  @override
  String get howToPlayIntroSemantics =>
      'Целта на играта. Пази дъската свободна и подобри рекорда си.';

  @override
  String get howToPlayDragTitle => 'Плъзни и пусни';

  @override
  String get howToPlayDragBody =>
      'Плъзни едно от трите блокчета върху свободни клетки. Щом използваш и трите, автоматично получаваш три нови.';

  @override
  String get howToPlayClearTitle => 'Изчиствай редове';

  @override
  String get howToPlayClearBody =>
      'Запълни цял ред или колона. Пълните редове изчезват и правят място за следващия ти ход.';

  @override
  String get howToPlayComboTitle => 'Верижни комбота';

  @override
  String get howToPlayComboBody =>
      'Изчисти още един ред до три хода. Всяко следващо комбо вдига множителя на точките. Комбото брои ходове, не секунди, така че не изтича, докато мислиш.';

  @override
  String get howToPlayFeverTitle => 'Разпали треската';

  @override
  String get howToPlayFeverBody =>
      'Изчистванията пълнят индикатора на треската. Когато е пълен, следващото голямо изчистване се брои двойно — планирай големите изчиствания предварително.';

  @override
  String get howToPlayBoosterTitle => 'Помощници с мярка';

  @override
  String get howToPlayBoosterBody =>
      'Помощниците спасяват трудните игри. Можеш и да докоснеш блокче долу, за да го завъртиш.';

  @override
  String get howToPlayDailyTitle => 'Дневно предизвикателство и серия';

  @override
  String get howToPlayDailyBody =>
      'Дневното предизвикателство има едни и същи блокчета за всички. Играй всеки ден, за да растат серията и бонусът ти.';

  @override
  String get howToPlayPiggyTitle => 'Напълни касичката';

  @override
  String get howToPlayPiggyBody =>
      'Всеки изчистен ред пълни касичката ти. Когато се напълни, можеш да вземеш монетите безплатно.';

  @override
  String get leaderboardTitle => 'Класация';

  @override
  String get leaderboardUnreachable =>
      'Класацията не е достъпна.\nОпитай пак с интернет връзка.';

  @override
  String get leaderboardEmpty => 'Още няма резултати.\nБъди първи!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Най-добрият ти резултат ($score) се изпраща …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Най-добрият ти резултат се изпраща автоматично.';

  @override
  String get puzzleModeTitle => 'Пъзели';

  @override
  String puzzleLevelTitle(int level) {
    return 'Пъзел $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Ходове: $moves   •   Цел: $target за 3 звезди';
  }

  @override
  String get puzzleSolved => 'Решено!';

  @override
  String get puzzleLeaveTitle => 'Да напуснеш пъзела?';

  @override
  String get puzzleLeaveBody => 'Напредъкът ти в този пъзел ще се загуби.';

  @override
  String get puzzleKeepPlaying => 'Продължи';

  @override
  String get puzzleLeave => 'Напусни';

  @override
  String get puzzleStuckTitle => 'Задънена улица';

  @override
  String get puzzleRestart => 'Отначало';

  @override
  String get commonActive => 'Активно';

  @override
  String get commonTapToActivate => 'Докосни за активиране';

  @override
  String get commonRestore => 'Възстанови';

  @override
  String unlockForCost(int cost) {
    return 'Отключи за $cost';
  }

  @override
  String get skinsExchangeGold => 'Обмени злато';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Завърти блокчето';

  @override
  String get puzzleNextLevel => 'Следващо ниво';

  @override
  String get puzzleBackToOverview => 'Обратно към прегледа';

  @override
  String get puzzleUnsolvable => 'Оттук дъската вече не може да се изпразни.';

  @override
  String get puzzleExtraMoveVideo => 'Допълнителен ход (видео)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Решени: $solved';
  }

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get storageFailureTitle => 'Qubble не може да зареди запазената игра';

  @override
  String get storageFailureBody =>
      'Рестартирай приложението. Ако грешката остане, помага само преинсталиране. Можеш да я съобщиш от Настройки › Обратна връзка.';

  @override
  String get iapUnavailable => 'Тази оферта не е налична в момента.';

  @override
  String get iapFailed => 'Покупката не мина. Нищо не е таксувано.';

  @override
  String get settingsResetProgress => 'Нулирай напредъка';

  @override
  String get settingsResetProgressSubtitle =>
      'Точки, монети, ниво и напредък — отначало. Покупките, името и козметиката остават.';

  @override
  String get settingsResetConfirmTitle => 'Да се нулира ли напредъкът?';

  @override
  String get settingsResetConfirmBody =>
      'Най-добрият резултат, монетите, нивото, серията и целият напредък ще бъдат изтрити. Това не може да се отмени.\n\nПокупките, името и отключените теми и облици остават.';

  @override
  String get settingsResetConfirmAction => 'Нулирай';

  @override
  String get settingsResetDone => 'Напредъкът е нулиран.';

  @override
  String get settingsSectionGame => 'Игра';

  @override
  String get settingsSectionSoundHaptics => 'Звук и вибрация';

  @override
  String get settingsSectionReminders => 'Напомняния';

  @override
  String get settingsSectionPurchases => 'Покупки';

  @override
  String get settingsSectionHelpOut => 'Помогни';

  @override
  String get settingsSectionLegal => 'Правна информация';

  @override
  String get settingsSectionLanguage => 'Език';

  @override
  String get settingsGuide => 'Как се играе';

  @override
  String get settingsGuideSubtitle => 'Правила, комбота, треска и помощници';

  @override
  String get settingsSound => 'Звук';

  @override
  String get settingsMusic => 'Музика';

  @override
  String get settingsHaptics => 'Вибрация';

  @override
  String get settingsHapticsOff => 'Изкл.';

  @override
  String get settingsHapticsLight => 'Слаба';

  @override
  String get settingsHapticsStrong => 'Силна';

  @override
  String get settingsSectionAccessibility => 'Удобство';

  @override
  String get settingsReducedEffects => 'По-малко ефекти';

  @override
  String get settingsReducedEffectsHint =>
      'По-малко частици, без разклащане на екрана, без сияние';

  @override
  String get settingsNotifications => 'Известия';

  @override
  String get settingsNotificationsSubtitle =>
      'Дневно напомняне и защита на серията';

  @override
  String get settingsNotificationsSystemHint =>
      'Разреши ги в системните настройки.';

  @override
  String get settingsLanguageSystem => 'Системен език';

  @override
  String get settingsSupporterThanks => 'Поддръжник — благодарим!';

  @override
  String get settingsSupporterPack => 'Пакет за поддръжници';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ексклузивна тема и облик + 1500 монети';

  @override
  String get settingsRestorePurchases => 'Възстанови покупките';

  @override
  String get settingsRestoring => 'Покупките се възстановяват…';

  @override
  String get settingsRateApp => 'Оцени приложението';

  @override
  String get settingsRateAppSubtitle => 'Остави оценка в магазина';

  @override
  String get settingsStoreUnavailable =>
      'Магазинът не е достъпен на това устройство.';

  @override
  String get settingsFeedback => 'Изпрати обратна връзка';

  @override
  String get settingsFeedbackSubtitle => 'Идеи и грешки (чрез GitHub)';

  @override
  String get settingsAdPrivacy => 'Поверителност на рекламите';

  @override
  String get settingsAdPrivacySubtitle =>
      'Виж или промени съгласието си за реклами';

  @override
  String get settingsAdPrivacyUnavailable =>
      'На това устройство не са нужни настройки за реклами.';

  @override
  String get settingsPrivacy => 'Политика за поверителност';

  @override
  String get settingsImprint => 'Данни за издателя';

  @override
  String get settingsPageOpenFailed => 'Страницата не можа да се отвори.';

  @override
  String get settingsFooter => 'Qubble • Офлайн пъзел с блокчета';

  @override
  String get settingsAdminSection => 'Админ (тест)';

  @override
  String get settingsAdminEnabled => 'Админ режимът е включен';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Докосни още $count× за админ режим';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins монети',
      one: '$coins монета',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Само за тестове — никога в снимки за издание';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount монети';
  }

  @override
  String get settingsAdminResetCoins => 'Монети на 0';

  @override
  String get feedbackTitle => 'Обратна връзка';

  @override
  String get feedbackIntroShort =>
      'Какво ти харесва, какво те дразни, какво липсва? И дребните неща помагат — колкото по-конкретно, толкова по-добре.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Прилагат се само $build и видът на устройството ти — за да знам за коя версия става дума.';
  }

  @override
  String get feedbackSendByMail => 'Изпрати по имейл';

  @override
  String get feedbackPreferGithub => 'По-добре issue в GitHub';

  @override
  String get feedbackThanksMail => 'Благодаря! Само изпрати съобщението.';

  @override
  String get feedbackNoMailApp =>
      'Не е намерено приложение за имейл. Опитай пътя през GitHub по-долу.';

  @override
  String get feedbackEmptyHint => 'Първо напиши нещо.';

  @override
  String get leaderboardRefresh => 'Обнови';

  @override
  String get leaderboardRetry => 'Опитай пак';

  @override
  String get feedbackHint => 'Твоята обратна връзка…';

  @override
  String get feedbackSubmit => 'Изпрати обратна връзка';

  @override
  String get feedbackOpenFailed =>
      'GitHub не можа да се отвори. Опитай пак по-късно.';

  @override
  String get feedbackGithubNote =>
      'Отваря се GitHub — докосни там „Submit new issue“. (Нужно е еднократно влизане в GitHub.)';

  @override
  String get shopTitle => 'Магазин';

  @override
  String get shopWebDemoNote =>
      'Покупки има само в приложението от Google Play. Тази уеб версия е безплатна демо версия — пак можеш да играеш всичко тук.';

  @override
  String get shopSupporterExplainer =>
      'Qubble не показва принудителни реклами — никога не е нужно да купуваш нищо. Пакетът за поддръжници (тема Сияние, облик Кристал, 1500 монети, значка за поддръжник) е благодарност за подкрепата на играта. Покупките са свързани с профила ти в магазина и могат да се възстановят по всяко време.';

  @override
  String get shopSupporterContents =>
      'Тема Сияние + облик Кристал + 1500 монети';

  @override
  String get themesTitle => 'Теми';

  @override
  String get themesSupporterOnly =>
      'Само в пакета за поддръжници (виж магазина)';

  @override
  String get themesInSupporterPack => 'В пакета за поддръжници';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Няма достатъчно монети (нужни $cost, имаш $coins)';
  }

  @override
  String get skinsTitle => 'Облици на блокчетата';

  @override
  String get skinsNotEnoughDiamonds =>
      'Няма достатъчно диаманти (обмени злато по-долу)';

  @override
  String get skinsNotEnoughCoins => 'Няма достатъчно монети';

  @override
  String get skinsNotEnoughGold => 'Няма достатъчно злато.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold злато = 1 диамант. Диамантите отключват най-красивите облици — събирай спокойно.';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsAverageScore => 'Среден резултат';

  @override
  String get statsBestCombo => 'Най-добро комбо';

  @override
  String get statsGames => 'Игри';

  @override
  String get statsLinesCleared => 'Изчистени редове';

  @override
  String get statsPiecesPlaced => 'Поставени блокчета';

  @override
  String get statsCoins => 'Монети';

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
      other: 'Постави $countString блокчета',
      one: 'Постави $countString блокче',
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
      other: 'Изчисти $countString реда',
      one: 'Изчисти $countString ред',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Достигни комбо x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Събери $countString точки в една игра',
      one: 'Събери $countString точка в една игра',
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
      other: 'Изиграй $countString игри',
      one: 'Изиграй $countString игра',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Постижения';

  @override
  String get achievementFirstGameTitle => 'Първа игра';

  @override
  String get achievementFirstGameBody => 'Изиграй първата си игра';

  @override
  String get achievementGames25Title => 'Редовен';

  @override
  String get achievementGames25Body => 'Изиграй 25 игри';

  @override
  String get achievementGames100Title => 'Запален';

  @override
  String get achievementGames100Body => 'Изиграй 100 игри';

  @override
  String get achievementScore1kTitle => 'Изкачващ се';

  @override
  String get achievementScore1kBody => 'Достигни 1000 точки';

  @override
  String get achievementScore5kTitle => 'Професионалист';

  @override
  String get achievementScore5kBody => 'Достигни 5000 точки';

  @override
  String get achievementScore10kTitle => 'Майстор';

  @override
  String get achievementScore10kBody => 'Достигни 10 000 точки';

  @override
  String get achievementScore25kTitle => 'Легенда';

  @override
  String get achievementScore25kBody => 'Достигни 25 000 точки';

  @override
  String get achievementLines100Title => 'Подреден';

  @override
  String get achievementLines100Body => 'Изчисти общо 100 реда';

  @override
  String get achievementLines1000Title => 'Голямо чистене';

  @override
  String get achievementLines1000Body => 'Изчисти общо 1000 реда';

  @override
  String get achievementCombo5Title => 'Комбо новак';

  @override
  String get achievementCombo5Body => 'Достигни комбо x5';

  @override
  String get achievementCombo10Title => 'Комбо крал';

  @override
  String get achievementCombo10Body => 'Достигни комбо x10';

  @override
  String get achievementLevel10Title => 'Опитен';

  @override
  String get achievementLevel10Body => 'Достигни ниво 10';

  @override
  String get achievementLevel20Title => 'Ветеран';

  @override
  String get achievementLevel20Body => 'Достигни ниво 20';

  @override
  String get achievementStreak7Title => 'Седмична серия';

  @override
  String get achievementStreak7Body => 'Дневна серия от 7 дни';

  @override
  String get achievementStreak30Title => 'Месечна серия';

  @override
  String get achievementStreak30Body => 'Дневна серия от 30 дни';

  @override
  String get achievementPuzzles10Title => 'Пъзелист';

  @override
  String get achievementPuzzles10Body => 'Реши 10 пъзела';

  @override
  String get achievementPieces5000Title => 'Строител';

  @override
  String get achievementPieces5000Body => 'Постави 5000 блокчета';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Серията ти от $streak дни е в опасност!',
      one: 'Серията ти от $streak ден е в опасност!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Вчера пропусна — спаси серията си:';

  @override
  String get streakRepairFailed => 'Поправката не е възможна.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins монети',
      one: '$coins монета',
    );
    return 'Добре дошъл отново! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Напомняния?';

  @override
  String get notificationsOptInBody =>
      'Да ти напомняме ли за дневния пъзел и да пазим серията ти? Можеш да промениш това по всяко време в настройките.';

  @override
  String get notificationsOptInAccept => 'Да, моля';

  @override
  String get notificationChannelDescription =>
      'Дневно напомняне, предупреждение за серията, покана за връщане';

  @override
  String get notificationDailyTitle => 'Дневният ти пъзел те чака 🧩';

  @override
  String get notificationDailyBody => 'Изиграй днешното предизвикателство!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Серията ти от $streak дни е в опасност!',
      one: 'Серията ти от $streak ден е в опасност!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'Играй днес, за да я запазиш.';

  @override
  String get notificationComebackTitle => 'Пъзелът ти скучае за теб 🧩';

  @override
  String get notificationComebackBody => 'Върни се и вземи подарък!';

  @override
  String get iapSupporterPack => 'Пакет за поддръжници';

  @override
  String get iapCoinsSmall => '500 монети';

  @override
  String get iapCoinsMedium => '2000 монети';

  @override
  String get iapCoinsLarge => '6000 монети';

  @override
  String get iapStarterPack => 'Стартов пакет';

  @override
  String get iapRename => 'Смяна на името';

  @override
  String get iapNeonTheme => 'Тема Неон';

  @override
  String get settingsLeaderboardDelete => 'Изтрий записа в класацията';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Премахва името и резултата ти от публичния списък';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Да изтрия ли записа ти?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Името и резултатът ти ще бъдат премахнати от класацията. Напредъкът ти в играта остава непроменен. Можеш да се върнеш в класацията по всяко време.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Записът ти в класацията е изтрит.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Записът не можа да бъде изтрит. Провери връзката и опитай пак.';

  @override
  String get leaderboardReport => 'Докладвай това име';

  @override
  String get leaderboardBlock => 'Скрий';

  @override
  String leaderboardBlocked(String name) {
    return '$name е скрит за теб';
  }

  @override
  String get leaderboardUndo => 'Отмени';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count записа скрити от теб',
      one: '$count запис скрит от теб',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Покажи отново';

  @override
  String get leaderboardReportUnavailable =>
      'Докладването не е достъпно в момента.';

  @override
  String get leaderboardReportSent => 'Благодарим — сигналът ти е изпратен.';

  @override
  String get leaderboardRules =>
      'Имената са публични. Без обиди, без ругатни и без нищо, което идентифицира реален човек. Имената, които нарушават това, се премахват.';

  @override
  String get leaderboardRulesAccept => 'Разбирам';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Отключени $unlocked от $total';
  }

  @override
  String get settingsSectionData => 'Запазени данни';

  @override
  String get gameRotatePiece => 'Завърти блокчето';

  @override
  String get themeClassic => 'Класическа';

  @override
  String get themeFade => 'Пастел';

  @override
  String get themeNeon => 'Неон';

  @override
  String get themeOcean => 'Океан';

  @override
  String get themeWood => 'Дърво';

  @override
  String get themeSunset => 'Залез';

  @override
  String get themeForest => 'Гора';

  @override
  String get themeAurora => 'Сияние';

  @override
  String get skinClassic => 'Класически';

  @override
  String get skinGradient => 'Градиент';

  @override
  String get skinOutline => 'Контур';

  @override
  String get skinGlossy => 'Гланц';

  @override
  String get skinStripe => 'Райета';

  @override
  String get skinBevel => 'Скосяване';

  @override
  String get skinGlow => 'Блясък';

  @override
  String get skinCrystal => 'Кристал';

  @override
  String rewardThemeName(String name) {
    return 'Тема $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Облик $name';
  }
}
