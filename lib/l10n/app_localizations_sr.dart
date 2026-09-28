// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class L10nSr extends L10n {
  L10nSr([String locale = 'sr']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Играј';

  @override
  String get commonLater => 'Касније';

  @override
  String get commonNotNow => 'Не сада';

  @override
  String get commonCancel => 'Откажи';

  @override
  String get commonBuy => 'Купи';

  @override
  String get commonSave => 'Сачувај';

  @override
  String get commonCollect => 'Покупи';

  @override
  String get nameNewName => 'Ново име';

  @override
  String get nameFieldLabel => 'Име';

  @override
  String get piggyFullTitle => 'Касица је пуна!';

  @override
  String get piggyKeepSaving => 'Штеди даље';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Скупљено $coins од $capacity.';
  }

  @override
  String get homeContinueRun => 'Настави';

  @override
  String get homeVideo => 'Видео';

  @override
  String get commonGotIt => 'Разумем';

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
  String get homeNewRun => 'Започни нову игру';

  @override
  String get homeBackToExit => 'Притисни Назад још једном за излаз';

  @override
  String get homeEnableLeaderboard => 'Уђи на ранг-листу';

  @override
  String get homeBestScore => 'НАЈБОЉИ РЕЗУЛТАТ';

  @override
  String get homeDailyChallenge => 'Дневни изазов';

  @override
  String get homeDailyOpenToday => 'Отворено данас';

  @override
  String homeDailyNextIn(String time) {
    return 'Следећи изазов за $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Низ: $streak дана',
      few: 'Низ: $streak дана',
      one: 'Низ: $streak дан',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Ранг-листа';

  @override
  String get homePuzzleMode => 'Загонетке';

  @override
  String get homeMissions => 'Мисије';

  @override
  String get homeThemes => 'Теме';

  @override
  String get homeSkins => 'Изгледи';

  @override
  String get homeHowToPlay => 'Како се игра Qubble';

  @override
  String get homeWeekendBonus => 'Викенд: двоструки новчићи!';

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
      'Твоје име је твој идентитет на ранг-листи, зато се не мења. Можеш да купиш једнократну промену имена.';

  @override
  String get nameChangeAfterPurchase =>
      'После куповине поново додирни своје име и промени га.';

  @override
  String get nameJoinedLeaderboard => 'Сада си на ранг-листи.';

  @override
  String get nameRenameUnavailable => 'Промена имена тренутно није могућа.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'Најмање $min знакова.',
      few: 'Најмање $min знака.',
      one: 'Најмање $min знак.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'Највише $max знакова.',
      few: 'Највише $max знака.',
      one: 'Највише $max знак.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Само латинична слова без дијакритика (A–Z), цифре, размаци, _ и -.';

  @override
  String get nameProblemOffensive => 'Изабери друго име.';

  @override
  String get piggyTitle => 'Касица';

  @override
  String get piggyFillingHint => 'Касица се пуни док бришеш редове.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins новчића',
      few: '$coins новчића',
      one: '$coins новчић',
    );
    return 'Покупи $_temp0 — бесплатно.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Кад се напуни, можеш да је испразниш бесплатно — или да је отвориш раније уз бонус видео.';

  @override
  String get piggyOpenNow => 'Отвори сада';

  @override
  String get gameNewPiecesVideo => 'Нови делови (видео)';

  @override
  String get gameTapBoardCell => 'Додирни поље на табли';

  @override
  String get gameDailyChallengeLabel => 'ДНЕВНИ ИЗАЗОВ';

  @override
  String get gameOver => 'Крај игре';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'За бомбу ти недостаје новчића: $missing.';
  }

  @override
  String get gameBombNotHere => 'Бомба овде тренутно не ради.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Недостаје ти новчића: $missing.';
  }

  @override
  String get gameNotRightNow => 'Тренутно није могуће.';

  @override
  String get gameRunSaved => 'Игра је сачувана — „Настави” у менију.';

  @override
  String get gameOverNoFit => 'Ниједан твој део више не стаје на таблу.';

  @override
  String get gameOverNoFitNoRotations =>
      'Ниједан део не стаје — а окретања су потрошена.';

  @override
  String get gameStarterOfferUnavailable => 'Тренутно није доступно';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — узми';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'КОМБО x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Достигнуће: $title';
  }

  @override
  String get gameBestSubmitted => 'Нови рекорд — послато';

  @override
  String get gameReviveFor => 'Играј даље · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Откључано: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Почетни пакет';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score поена',
      few: '$score поена',
      one: '$score поен',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Нови рекорд!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Низ: $streak дана',
      few: 'Низ: $streak дана',
      one: 'Низ: $streak дан',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Удвостручи новчиће';

  @override
  String get gameDoubleDaily => 'Удвостручи дневну награду';

  @override
  String get gamePlayAgain => 'Играј поново';

  @override
  String gameLevelReached(int level) {
    return 'Достигнут ниво $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count нивоа — ниво $level!',
      few: '+$count нивоа — ниво $level!',
      one: '+$count ниво — ниво $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 новчића + тема Дрво';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Још само $hours сати — само једном!',
      few: 'Још само $hours сата — само једном!',
      one: 'Још само $hours сат — само једном!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Поништи';

  @override
  String get boosterSwap => 'Замени';

  @override
  String get boosterBomb => 'Бомба';

  @override
  String get boosterNoRotationsLeft =>
      'Нема више окретања — бриши редове да их напуниш!';

  @override
  String get onboardingDragPiece => 'Превуци део на мрежу';

  @override
  String get onboardingFillLine => 'Попуни цео ред или колону';

  @override
  String get onboardingLinesClear => 'Пуни редови нестају — поени!';

  @override
  String get coachHintCombo =>
      'Комбо! Обриши поново у року од 3 потеза да га задржиш';

  @override
  String get coachHintFever => 'ГРОЗНИЦА! Двоструки поени док светли';

  @override
  String get coachHintRotation =>
      'Окретање троши једно пуњење — брисања га допуњују';

  @override
  String get coachHintBooster => 'Савет: доле имаш појачања';

  @override
  String get coachHintStrategy =>
      'Савет: не све редове одједном — остави места за велике делове';

  @override
  String get dailyStreakLabel => 'Низ';

  @override
  String get dailyBestLabel => 'Дневни рекорд';

  @override
  String dailyHistoryNote(int days) {
    return 'Чува се последњих $days дана.';
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
  String get dailyShareButton => 'Подели резултат';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Дневни изазов $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Поени: $score · најбољи комбо x$combo';
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
      other: 'Комбо: још $moves потеза',
      few: 'Комбо: још $moves потеза',
      one: 'Комбо: још $moves потез',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Резултат је копиран у привремену меморију';

  @override
  String get adNotAvailable =>
      'Тренутно нема видеа — покушај поново мало касније';

  @override
  String get howToPlaySpeedTitle => 'Бонус за брзину';

  @override
  String get howToPlaySpeedBody =>
      'Брзо постављање додаје брисању до 30 %. Бонус слаби између 1,5 и 4 секунде и има горњу границу, па се брзина исплати, али не одлучује игру — пажљива спора игра и даље може да победи ужурбану.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Бонус за брзину $percent одсто';
  }

  @override
  String get iapDiamondsSmall => '100 дијаманата';

  @override
  String get iapDiamondsMedium => '350 дијаманата';

  @override
  String get iapDiamondsLarge => '1.000 дијаманата';

  @override
  String get howToPlayTitle => 'Како се игра Qubble';

  @override
  String get howToPlayIntroHeadline => 'Лако за почетак.\nНаграђује планирање.';

  @override
  String get howToPlayIntroBody => 'Држи таблу слободном и обори свој рекорд.';

  @override
  String get howToPlayIntroSemantics =>
      'Циљ игре. Држи таблу слободном и обори свој рекорд.';

  @override
  String get howToPlayDragTitle => 'Превуци и спусти';

  @override
  String get howToPlayDragBody =>
      'Превуци један од три дела на слободна поља. Кад искористиш сва три, аутоматски добијаш три нова.';

  @override
  String get howToPlayClearTitle => 'Бриши редове';

  @override
  String get howToPlayClearBody =>
      'Попуни цео ред или колону. Пуни редови нестају и ослобађају место за следећи потез.';

  @override
  String get howToPlayComboTitle => 'Надовезуј комбое';

  @override
  String get howToPlayComboBody =>
      'Обриши још један ред у року од три потеза. Сваки следећи комбо повећава множилац поена. Комбо броји потезе, а не секунде, па не истиче док размишљаш.';

  @override
  String get howToPlayFeverTitle => 'Запали грозницу';

  @override
  String get howToPlayFeverBody =>
      'Брисања пуне мерач грознице. Кад је пун, следеће велико брисање вреди дупло — планирај велика брисања унапред.';

  @override
  String get howToPlayBoosterTitle => 'Паметно користи појачања';

  @override
  String get howToPlayBoosterBody =>
      'Појачања спасавају тесне игре. Део доле можеш и да додирнеш да га окренеш.';

  @override
  String get howToPlayDailyTitle => 'Дневни изазов и низ';

  @override
  String get howToPlayDailyBody =>
      'Дневни изазов има исте делове за све. Играј сваки дан да ти расту низ и бонус.';

  @override
  String get howToPlayPiggyTitle => 'Напуни касицу';

  @override
  String get howToPlayPiggyBody =>
      'Сваки обрисани ред пуни твоју касицу. Кад се напуни, новчиће можеш да покупиш бесплатно.';

  @override
  String get leaderboardTitle => 'Ранг-листа';

  @override
  String get leaderboardUnreachable =>
      'Ранг-листа није доступна.\nПокушај поново са интернет везом.';

  @override
  String get leaderboardEmpty => 'Још нема резултата.\nБуди први!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Твој најбољи резултат ($score) се шаље …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Твој најбољи резултат се шаље аутоматски.';

  @override
  String get puzzleModeTitle => 'Загонетке';

  @override
  String puzzleLevelTitle(int level) {
    return 'Загонетка $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Потези: $moves   •   Циљ: $target за 3 звездице';
  }

  @override
  String get puzzleSolved => 'Решено!';

  @override
  String get puzzleLeaveTitle => 'Напустити загонетку?';

  @override
  String get puzzleLeaveBody => 'Напредак у овој загонетки биће изгубљен.';

  @override
  String get puzzleKeepPlaying => 'Играј даље';

  @override
  String get puzzleLeave => 'Напусти';

  @override
  String get puzzleStuckTitle => 'Ћорсокак';

  @override
  String get puzzleRestart => 'Испочетка';

  @override
  String get commonActive => 'Активно';

  @override
  String get commonTapToActivate => 'Додирни за активацију';

  @override
  String get commonRestore => 'Врати';

  @override
  String unlockForCost(int cost) {
    return 'Откључај за $cost';
  }

  @override
  String get skinsExchangeGold => 'Замени злато';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Окрени део';

  @override
  String get puzzleNextLevel => 'Следећи ниво';

  @override
  String get puzzleBackToOverview => 'Назад на преглед';

  @override
  String get puzzleUnsolvable => 'Одавде се табла више не може испразнити.';

  @override
  String get puzzleExtraMoveVideo => 'Додатни потез (видео)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Решено: $solved';
  }

  @override
  String get settingsTitle => 'Подешавања';

  @override
  String get storageFailureTitle => 'Qubble не може да учита сачувану игру';

  @override
  String get storageFailureBody =>
      'Поново покрени апликацију. Ако грешка остане, помаже само поновна инсталација. Можеш да је пријавиш у Подешавања › Повратне информације.';

  @override
  String get iapUnavailable => 'Ова понуда тренутно није доступна.';

  @override
  String get iapFailed => 'Куповина није успела. Ништа није наплаћено.';

  @override
  String get settingsResetProgress => 'Поништи напредак';

  @override
  String get settingsResetProgressSubtitle =>
      'Поени, новчићи, ниво и напредак испочетка. Куповине, име и козметика остају.';

  @override
  String get settingsResetConfirmTitle => 'Поништити напредак?';

  @override
  String get settingsResetConfirmBody =>
      'Најбољи резултат, новчићи, ниво, низ и сав напредак биће избрисани. То се не може вратити.\n\nТвоје куповине, име и откључане теме и изгледи остају.';

  @override
  String get settingsResetConfirmAction => 'Поништи';

  @override
  String get settingsResetDone => 'Напредак је поништен.';

  @override
  String get settingsSectionGame => 'Игра';

  @override
  String get settingsSectionSoundHaptics => 'Звук и вибрација';

  @override
  String get settingsSectionReminders => 'Подсетници';

  @override
  String get settingsSectionPurchases => 'Куповине';

  @override
  String get settingsSectionHelpOut => 'Помози';

  @override
  String get settingsSectionLegal => 'Правне информације';

  @override
  String get settingsSectionLanguage => 'Језик';

  @override
  String get settingsGuide => 'Како се игра';

  @override
  String get settingsGuideSubtitle => 'Правила, комбои, грозница и појачања';

  @override
  String get settingsSound => 'Звук';

  @override
  String get settingsMusic => 'Музика';

  @override
  String get settingsHaptics => 'Вибрација';

  @override
  String get settingsHapticsOff => 'Искљ.';

  @override
  String get settingsHapticsLight => 'Слаба';

  @override
  String get settingsHapticsStrong => 'Јака';

  @override
  String get settingsSectionAccessibility => 'Удобност';

  @override
  String get settingsReducedEffects => 'Мање ефеката';

  @override
  String get settingsReducedEffectsHint =>
      'Мање честица, без тресења екрана, без сјаја';

  @override
  String get settingsNotifications => 'Обавештења';

  @override
  String get settingsNotificationsSubtitle => 'Дневни подсетник и заштита низа';

  @override
  String get settingsNotificationsSystemHint =>
      'Дозволи их у подешавањима система.';

  @override
  String get settingsLanguageSystem => 'Језик система';

  @override
  String get settingsSupporterThanks => 'Подржавалац — хвала!';

  @override
  String get settingsSupporterPack => 'Пакет подржаваоца';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ексклузивна тема и изглед + 1.500 новчића';

  @override
  String get settingsRestorePurchases => 'Врати куповине';

  @override
  String get settingsRestoring => 'Враћање куповина…';

  @override
  String get settingsRateApp => 'Оцени апликацију';

  @override
  String get settingsRateAppSubtitle => 'Остави оцену у продавници';

  @override
  String get settingsStoreUnavailable =>
      'Продавница није доступна на овом уређају.';

  @override
  String get settingsFeedback => 'Пошаљи повратне информације';

  @override
  String get settingsFeedbackSubtitle => 'Идеје и грешке (преко GitHub-а)';

  @override
  String get settingsAdPrivacy => 'Приватност огласа';

  @override
  String get settingsAdPrivacySubtitle =>
      'Прегледај или промени сагласност за огласе';

  @override
  String get settingsAdPrivacyUnavailable =>
      'На овом уређају нису потребна подешавања огласа.';

  @override
  String get settingsPrivacy => 'Политика приватности';

  @override
  String get settingsImprint => 'Импресум';

  @override
  String get settingsPageOpenFailed => 'Страница није могла да се отвори.';

  @override
  String get settingsFooter => 'Qubble • Офлајн слагалица са блоковима';

  @override
  String get settingsAdminSection => 'Админ (тест)';

  @override
  String get settingsAdminEnabled => 'Админ режим је укључен';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Додирни још $count× за админ режим';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins новчића',
      few: '$coins новчића',
      one: '$coins новчић',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Само за тестирање — никад на снимцима за издање';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount новчића';
  }

  @override
  String get settingsAdminResetCoins => 'Новчићи на 0';

  @override
  String get feedbackTitle => 'Повратне информације';

  @override
  String get feedbackIntroShort =>
      'Шта ти се свиђа, шта те нервира, шта недостаје? И ситнице помажу — што конкретније, то боље.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Прилажу се само $build и врста твог уређаја — да знам о којој верзији је реч.';
  }

  @override
  String get feedbackSendByMail => 'Пошаљи имејлом';

  @override
  String get feedbackPreferGithub => 'Радије issue на GitHub-у';

  @override
  String get feedbackThanksMail => 'Хвала! Само пошаљи поруку.';

  @override
  String get feedbackNoMailApp =>
      'Није пронађена апликација за имејл. Покушај преко GitHub-а испод.';

  @override
  String get feedbackEmptyHint => 'Прво нешто напиши.';

  @override
  String get leaderboardRefresh => 'Освежи';

  @override
  String get leaderboardRetry => 'Покушај поново';

  @override
  String get feedbackHint => 'Твоје повратне информације…';

  @override
  String get feedbackSubmit => 'Пошаљи повратне информације';

  @override
  String get feedbackOpenFailed =>
      'GitHub није могао да се отвори. Покушај поново касније.';

  @override
  String get feedbackGithubNote =>
      'Отвара се GitHub — тамо додирни „Submit new issue”. (Потребна је једнократна пријава на GitHub.)';

  @override
  String get shopTitle => 'Продавница';

  @override
  String get shopWebDemoNote =>
      'Куповине постоје само у апликацији из Play продавнице. Ова веб верзија је бесплатан демо — овде ипак можеш да играш све.';

  @override
  String get shopSupporterExplainer =>
      'Qubble не приказује наметнуте огласе — никад ништа не мораш да купиш. Пакет подржаваоца (тема Аурора, изглед Кристал, 1.500 новчића, значка подржаваоца) захвалница је за подршку игри. Куповине су везане за твој налог у продавници и могу да се врате у било ком тренутку.';

  @override
  String get shopSupporterContents =>
      'Тема Аурора + изглед Кристал + 1.500 новчића';

  @override
  String get themesTitle => 'Теме';

  @override
  String get themesSupporterOnly =>
      'Само у пакету подржаваоца (види продавницу)';

  @override
  String get themesInSupporterPack => 'У пакету подржаваоца';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Нема довољно новчића (треба $cost, имаш $coins)';
  }

  @override
  String get skinsTitle => 'Изгледи блокова';

  @override
  String get skinsNotEnoughDiamonds =>
      'Нема довољно дијаманата (замени злато испод)';

  @override
  String get skinsNotEnoughCoins => 'Нема довољно новчића';

  @override
  String get skinsNotEnoughGold => 'Нема довољно злата.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold злата = 1 дијамант. Дијаманти откључавају најлепше изгледе — скупљај без журбе.';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsAverageScore => 'Просечан резултат';

  @override
  String get statsBestCombo => 'Најбољи комбо';

  @override
  String get statsGames => 'Игре';

  @override
  String get statsLinesCleared => 'Обрисани редови';

  @override
  String get statsPiecesPlaced => 'Постављени делови';

  @override
  String get statsCoins => 'Новчићи';

  @override
  String get missionsTitle => 'Мисије';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Постави $countString делова',
      few: 'Постави $countString дела',
      one: 'Постави $countString део',
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
      other: 'Обриши $countString редова',
      few: 'Обриши $countString реда',
      one: 'Обриши $countString ред',
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
      other: 'Освоји $countString поена у једној игри',
      few: 'Освоји $countString поена у једној игри',
      one: 'Освоји $countString поен у једној игри',
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
      other: 'Одиграј $countString игара',
      few: 'Одиграј $countString игре',
      one: 'Одиграј $countString игру',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Достигнућа';

  @override
  String get achievementFirstGameTitle => 'Прва игра';

  @override
  String get achievementFirstGameBody => 'Одиграј своју прву игру';

  @override
  String get achievementGames25Title => 'Стални гост';

  @override
  String get achievementGames25Body => 'Одиграј 25 игара';

  @override
  String get achievementGames100Title => 'Навучен';

  @override
  String get achievementGames100Body => 'Одиграј 100 игара';

  @override
  String get achievementScore1kTitle => 'Пењач';

  @override
  String get achievementScore1kBody => 'Достигни 1.000 поена';

  @override
  String get achievementScore5kTitle => 'Професионалац';

  @override
  String get achievementScore5kBody => 'Достигни 5.000 поена';

  @override
  String get achievementScore10kTitle => 'Мајстор';

  @override
  String get achievementScore10kBody => 'Достигни 10.000 поена';

  @override
  String get achievementScore25kTitle => 'Легенда';

  @override
  String get achievementScore25kBody => 'Достигни 25.000 поена';

  @override
  String get achievementLines100Title => 'Уредан';

  @override
  String get achievementLines100Body => 'Обриши укупно 100 редова';

  @override
  String get achievementLines1000Title => 'Велико чишћење';

  @override
  String get achievementLines1000Body => 'Обриши укупно 1.000 редова';

  @override
  String get achievementCombo5Title => 'Комбо почетник';

  @override
  String get achievementCombo5Body => 'Достигни комбо x5';

  @override
  String get achievementCombo10Title => 'Комбо краљ';

  @override
  String get achievementCombo10Body => 'Достигни комбо x10';

  @override
  String get achievementLevel10Title => 'Искусан';

  @override
  String get achievementLevel10Body => 'Достигни ниво 10';

  @override
  String get achievementLevel20Title => 'Ветеран';

  @override
  String get achievementLevel20Body => 'Достигни ниво 20';

  @override
  String get achievementStreak7Title => 'Недељни низ';

  @override
  String get achievementStreak7Body => 'Дневни низ од 7 дана';

  @override
  String get achievementStreak30Title => 'Месечни низ';

  @override
  String get achievementStreak30Body => 'Дневни низ од 30 дана';

  @override
  String get achievementPuzzles10Title => 'Решавач';

  @override
  String get achievementPuzzles10Body => 'Реши 10 загонетки';

  @override
  String get achievementPieces5000Title => 'Градитељ';

  @override
  String get achievementPieces5000Body => 'Постави 5.000 делова';

  @override
  String streakRepairTitle(int streak) {
    return 'Твој низ од $streak дана је у опасности!';
  }

  @override
  String get streakRepairBody => 'Јуче је пропуштено — спаси свој низ:';

  @override
  String get streakRepairFailed => 'Поправка није могућа.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins новчића',
      few: '$coins новчића',
      one: '$coins новчић',
    );
    return 'Добро дошли назад! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Подсетници?';

  @override
  String get notificationsOptInBody =>
      'Да те подсећамо на дневну загонетку и чувамо твој низ? То можеш да промениш било када у подешавањима.';

  @override
  String get notificationsOptInAccept => 'Да, молим';

  @override
  String get notificationChannelDescription =>
      'Дневни подсетник, упозорење за низ, позив назад';

  @override
  String get notificationDailyTitle => 'Твоја дневна загонетка чека 🧩';

  @override
  String get notificationDailyBody => 'Одиграј данашњи изазов!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Твој низ од $streak дана је у опасности!';
  }

  @override
  String get notificationStreakBody => 'Играј данас да га сачуваш.';

  @override
  String get notificationComebackTitle => 'Твоја загонетка те чека 🧩';

  @override
  String get notificationComebackBody => 'Врати се и покупи поклон!';

  @override
  String get iapSupporterPack => 'Пакет подржаваоца';

  @override
  String get iapCoinsSmall => '500 новчића';

  @override
  String get iapCoinsMedium => '2.000 новчића';

  @override
  String get iapCoinsLarge => '6.000 новчића';

  @override
  String get iapStarterPack => 'Почетни пакет';

  @override
  String get iapRename => 'Промена имена';

  @override
  String get iapNeonTheme => 'Тема Неон';

  @override
  String get settingsLeaderboardDelete => 'Избриши унос на ранг-листи';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Уклања твоје име и резултат са јавне листе';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Избрисати твој унос?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Твоје име и резултат биће уклоњени са ранг-листе. Напредак у игри остаје нетакнут. На ранг-листу можеш да се вратиш било када.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Твој унос на ранг-листи је избрисан.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Унос није могао да се избрише. Провери везу и покушај поново.';

  @override
  String get leaderboardReport => 'Пријави ово име';

  @override
  String get leaderboardBlock => 'Сакриј';

  @override
  String leaderboardBlocked(String name) {
    return '$name је скривен за тебе';
  }

  @override
  String get leaderboardUndo => 'Поништи';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Скривени уноси: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Прикажи поново';

  @override
  String get leaderboardReportUnavailable => 'Пријава тренутно није доступна.';

  @override
  String get leaderboardReportSent => 'Хвала — пријава је послата.';

  @override
  String get leaderboardRules =>
      'Имена су јавна. Без увреда, без псовки и без ичега што открива стварну особу. Имена која крше правила се уклањају.';

  @override
  String get leaderboardRulesAccept => 'Разумем';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Откључано $unlocked од $total';
  }

  @override
  String get settingsSectionData => 'Сачувани подаци';

  @override
  String get gameRotatePiece => 'Окрени део';

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
  String get themeSunset => 'Залазак сунца';

  @override
  String get themeForest => 'Шума';

  @override
  String get themeAurora => 'Аурора';

  @override
  String get skinClassic => 'Класични';

  @override
  String get skinGradient => 'Прелаз';

  @override
  String get skinOutline => 'Обрис';

  @override
  String get skinGlossy => 'Сјајни';

  @override
  String get skinStripe => 'Пруге';

  @override
  String get skinBevel => 'Закошени';

  @override
  String get skinGlow => 'Сјај';

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
}
