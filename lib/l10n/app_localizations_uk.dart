// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class L10nUk extends L10n {
  L10nUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Грати';

  @override
  String get commonLater => 'Пізніше';

  @override
  String get commonNotNow => 'Не зараз';

  @override
  String get commonCancel => 'Скасувати';

  @override
  String get commonBuy => 'Купити';

  @override
  String get commonSave => 'Зберегти';

  @override
  String get commonCollect => 'Забрати';

  @override
  String get nameNewName => 'Нове ім’я';

  @override
  String get nameFieldLabel => 'Ім’я';

  @override
  String get piggyFullTitle => 'Скарбничка повна!';

  @override
  String get piggyKeepSaving => 'Збирати далі';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Зібрано $coins з $capacity.';
  }

  @override
  String get homeContinueRun => 'Продовжити';

  @override
  String get homeVideo => 'Відео';

  @override
  String get commonGotIt => 'Зрозуміло';

  @override
  String get commonHome => 'Головна';

  @override
  String get commonScore => 'РАХУНОК';

  @override
  String get commonBest => 'РЕКОРД';

  @override
  String commonLevelShort(int level) {
    return 'Рівень $level';
  }

  @override
  String get homeNewRun => 'Почати нову гру';

  @override
  String get homeBackToExit => 'Натисни «Назад» ще раз, щоб вийти';

  @override
  String get homeEnableLeaderboard => 'Увійти в таблицю лідерів';

  @override
  String get homeBestScore => 'РЕКОРД';

  @override
  String get homeDailyChallenge => 'Щоденний виклик';

  @override
  String get homeDailyOpenToday => 'Сьогодні ще доступний';

  @override
  String homeDailyNextIn(String time) {
    return 'Наступний виклик через $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'дня',
      many: 'днів',
      few: 'дні',
      one: 'день',
    );
    return 'Серія: $streak $_temp0';
  }

  @override
  String get homeLeaderboard => 'Лідери';

  @override
  String get homePuzzleMode => 'Головоломки';

  @override
  String get homeMissions => 'Місії';

  @override
  String get homeThemes => 'Теми';

  @override
  String get homeSkins => 'Скіни';

  @override
  String get homeHowToPlay => 'Як грати в Qubble';

  @override
  String get homeWeekendBonus => 'Вихідні: подвійні монети!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Рівень $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Змінити ім’я';

  @override
  String get nameChangeExplainer =>
      'Твоє ім’я — це твоє обличчя в таблиці лідерів, тому воно незмінне. Можна купити одноразову зміну імені.';

  @override
  String get nameChangeAfterPurchase =>
      'Після покупки торкнися свого імені ще раз, щоб його змінити.';

  @override
  String get nameJoinedLeaderboard => 'Тепер ти в таблиці лідерів.';

  @override
  String get nameRenameUnavailable => 'Зараз змінити ім’я неможливо.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'символу',
      many: 'символів',
      few: 'символи',
      one: 'символ',
    );
    return 'Щонайменше $min $_temp0.';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'символу',
      many: 'символів',
      few: 'символи',
      one: 'символ',
    );
    return 'Щонайбільше $max $_temp0.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Лише латинські літери (A–Z), цифри, пробіли, _ і -.';

  @override
  String get nameProblemOffensive => 'Обери інше ім’я.';

  @override
  String get piggyTitle => 'Скарбничка';

  @override
  String get piggyFillingHint =>
      'Скарбничка наповнюється, коли ти очищаєш ряди.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: 'монети',
      many: 'монет',
      few: 'монети',
      one: 'монету',
    );
    return 'Забрати $coins $_temp0 — безкоштовно.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Коли вона повна, її можна спорожнити безкоштовно — або відкрити раніше за бонусне відео.';

  @override
  String get piggyOpenNow => 'Відкрити зараз';

  @override
  String get gameNewPiecesVideo => 'Нові фігури (відео)';

  @override
  String get gameTapBoardCell => 'Торкнися клітинки на полі';

  @override
  String get gameDailyChallengeLabel => 'ЩОДЕННИЙ ВИКЛИК';

  @override
  String get gameOver => 'Гру завершено';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Для бомби бракує монет: $missing.';
  }

  @override
  String get gameBombNotHere => 'Зараз бомба тут не спрацює.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Бракує монет: $missing.';
  }

  @override
  String get gameNotRightNow => 'Зараз неможливо.';

  @override
  String get gameRunSaved => 'Гру збережено — «Продовжити» в меню.';

  @override
  String get gameOverNoFit =>
      'Жодна з твоїх фігур більше не вміщується на полі.';

  @override
  String get gameOverNoFitNoRotations =>
      'Жодна фігура не вміщується — а повороти вичерпано.';

  @override
  String get gameStarterOfferUnavailable => 'Зараз недоступно';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — отримати';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'КОМБО x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Досягнення: $title';
  }

  @override
  String get gameBestSubmitted => 'Новий рекорд — надіслано';

  @override
  String get gameReviveFor => 'Грати далі · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Відкрито: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Стартовий набір';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: 'очка',
      many: 'очок',
      few: 'очки',
      one: 'очко',
    );
    return '$score $_temp0';
  }

  @override
  String get gameNewRecord => 'Новий рекорд!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'дня',
      many: 'днів',
      few: 'дні',
      one: 'день',
    );
    return 'Серія: $streak $_temp0';
  }

  @override
  String get gameDoubleCoins => 'Подвоїти монети';

  @override
  String get gameDoubleDaily => 'Подвоїти щоденну нагороду';

  @override
  String get gamePlayAgain => 'Грати знову';

  @override
  String gameLevelReached(int level) {
    return 'Досягнуто рівня $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'рівня',
      many: 'рівнів',
      few: 'рівні',
      one: 'рівень',
    );
    return '+$count $_temp0 — рівень $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 монет + тема «Дерево»';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Лише $hours год — одноразово!';
  }

  @override
  String get boosterUndo => 'Відмінити';

  @override
  String get boosterSwap => 'Заміна';

  @override
  String get boosterBomb => 'Бомба';

  @override
  String get boosterNoRotationsLeft =>
      'Поворотів не лишилося — очищай ряди, щоб поповнити!';

  @override
  String get onboardingDragPiece => 'Перетягни фігуру на поле';

  @override
  String get onboardingFillLine => 'Заповни цілий ряд або стовпець';

  @override
  String get onboardingLinesClear => 'Заповнені лінії зникають — очки!';

  @override
  String get coachHintCombo =>
      'Комбо! Очисти ще раз протягом 3 ходів, щоб його зберегти';

  @override
  String get coachHintFever => 'ЗАПАЛ! Подвійні очки, поки поле світиться';

  @override
  String get coachHintRotation =>
      'Поворот коштує заряд — очищення його поповнює';

  @override
  String get coachHintBooster => 'Порада: підсилення чекають унизу';

  @override
  String get coachHintStrategy =>
      'Порада: не всі лінії одразу — лишай місце для великих фігур';

  @override
  String get dailyStreakLabel => 'Серія';

  @override
  String get dailyBestLabel => 'Рекорд дня';

  @override
  String dailyHistoryNote(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'дня',
      many: 'днів',
      few: 'дні',
      one: 'день',
    );
    return 'Зберігаються останні $days $_temp0.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: зіграно';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: не зіграно';
  }

  @override
  String get homeDailyCalendar => 'Календар';

  @override
  String get dailyShareButton => 'Поділитися результатом';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Щоденний виклик $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Очки: $score · найкраще комбо x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Грай: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Комбо: лишилося $moves ходу',
      many: 'Комбо: лишилося $moves ходів',
      few: 'Комбо: лишилося $moves ходи',
      one: 'Комбо: лишився $moves хід',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Результат скопійовано в буфер обміну';

  @override
  String get adNotAvailable => 'Зараз немає відео — спробуй трохи згодом';

  @override
  String get howToPlaySpeedTitle => 'Бонус за швидкість';

  @override
  String get howToPlaySpeedBody =>
      'Швидке розміщення додає до 30 % до очищення. Бонус згасає між 1,5 і 4 секундами й має межу, тож швидкість окупається, але не вирішує гру — обережна повільна гра все одно може перемогти поспішну швидку.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Бонус за швидкість $percent відсотків';
  }

  @override
  String get iapDiamondsSmall => '100 діамантів';

  @override
  String get iapDiamondsMedium => '350 діамантів';

  @override
  String get iapDiamondsLarge => '1 000 діамантів';

  @override
  String get howToPlayTitle => 'Як грати в Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Легко почати.\nПланування винагороджується.';

  @override
  String get howToPlayIntroBody => 'Тримай поле вільним і побий свій рекорд.';

  @override
  String get howToPlayIntroSemantics =>
      'Мета гри. Тримай поле вільним і побий свій рекорд.';

  @override
  String get howToPlayDragTitle => 'Перетягни й постав';

  @override
  String get howToPlayDragBody =>
      'Перетягни одну з трьох фігур на вільні клітинки. Коли всі три використано, автоматично з’являються три нові.';

  @override
  String get howToPlayClearTitle => 'Очищай лінії';

  @override
  String get howToPlayClearBody =>
      'Заповни цілий ряд або стовпець. Повні лінії зникають і звільняють місце для наступного ходу.';

  @override
  String get howToPlayComboTitle => 'Збирай комбо';

  @override
  String get howToPlayComboBody =>
      'Очисти ще одну лінію протягом трьох ходів. Кожне наступне комбо підвищує множник очок. Комбо рахує ходи, а не секунди, тож воно не згасне, поки ти думаєш.';

  @override
  String get howToPlayFeverTitle => 'Розпали запал';

  @override
  String get howToPlayFeverBody =>
      'Очищення наповнюють шкалу запалу. Коли вона повна, наступне очищення рахується вдвічі — плануй великі очищення заздалегідь.';

  @override
  String get howToPlayBoosterTitle => 'Використовуй підсилення з розумом';

  @override
  String get howToPlayBoosterBody =>
      'Підсилення рятують складні ігри. А ще можна торкнутися фігури в лотку, щоб її повернути.';

  @override
  String get howToPlayDailyTitle => 'Щоденний виклик і серія';

  @override
  String get howToPlayDailyBody =>
      'Щоденний виклик для всіх використовує ті самі фігури. Грай щодня, щоб подовжувати серію та збільшувати бонус.';

  @override
  String get howToPlayPiggyTitle => 'Наповнюй скарбничку';

  @override
  String get howToPlayPiggyBody =>
      'Кожна очищена лінія наповнює скарбничку. Коли вона повна, монети можна забрати безкоштовно.';

  @override
  String get leaderboardTitle => 'Таблиця лідерів';

  @override
  String get leaderboardUnreachable =>
      'Таблиця лідерів недоступна.\nСпробуй ще раз з інтернетом.';

  @override
  String get leaderboardEmpty => 'Ще немає записів.\nБудь першим!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Твій рекорд ($score) надсилається …';
  }

  @override
  String get leaderboardAutoSubmit => 'Твій рекорд надсилається автоматично.';

  @override
  String get puzzleModeTitle => 'Режим головоломок';

  @override
  String puzzleLevelTitle(int level) {
    return 'Головоломка $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Ходи: $moves   •   Мета: $target для 3 зірок';
  }

  @override
  String get puzzleSolved => 'Розв’язано!';

  @override
  String get puzzleLeaveTitle => 'Вийти з головоломки?';

  @override
  String get puzzleLeaveBody => 'Прогрес у цій головоломці буде втрачено.';

  @override
  String get puzzleKeepPlaying => 'Грати далі';

  @override
  String get puzzleLeave => 'Вийти';

  @override
  String get puzzleStuckTitle => 'Глухий кут';

  @override
  String get puzzleRestart => 'Почати заново';

  @override
  String get commonActive => 'Активна';

  @override
  String get commonTapToActivate => 'Торкнися, щоб увімкнути';

  @override
  String get commonRestore => 'Відновити';

  @override
  String unlockForCost(int cost) {
    return 'Відкрити за $cost';
  }

  @override
  String get skinsExchangeGold => 'Обміняти золото';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Повернути фігуру';

  @override
  String get puzzleNextLevel => 'Наступний рівень';

  @override
  String get puzzleBackToOverview => 'До огляду';

  @override
  String get puzzleUnsolvable => 'Звідси поле вже не очистити повністю.';

  @override
  String get puzzleExtraMoveVideo => 'Додатковий хід (відео)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Розв’язано: $solved';
  }

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get storageFailureTitle => 'Qubble не може завантажити збережену гру';

  @override
  String get storageFailureBody =>
      'Перезапусти застосунок. Якщо помилка не зникне, допоможе лише перевстановлення. Повідомити про неї можна в Налаштування › Надіслати відгук.';

  @override
  String get iapUnavailable => 'Ця пропозиція зараз недоступна.';

  @override
  String get iapFailed => 'Покупку не завершено. Кошти не списано.';

  @override
  String get settingsResetProgress => 'Скинути прогрес';

  @override
  String get settingsResetProgressSubtitle =>
      'Очки, монети, рівень і прогрес — до початку. Покупки, ім’я та косметика залишаються.';

  @override
  String get settingsResetConfirmTitle => 'Скинути прогрес?';

  @override
  String get settingsResetConfirmBody =>
      'Рекорд, монети, рівень, серію та весь прогрес буде видалено. Це не можна скасувати.\n\nТвої покупки, ім’я та відкриті теми й скіни залишаться.';

  @override
  String get settingsResetConfirmAction => 'Скинути';

  @override
  String get settingsResetDone => 'Прогрес скинуто.';

  @override
  String get settingsSectionGame => 'Гра';

  @override
  String get settingsSectionSoundHaptics => 'Звук і вібрація';

  @override
  String get settingsSectionReminders => 'Нагадування';

  @override
  String get settingsSectionPurchases => 'Покупки';

  @override
  String get settingsSectionHelpOut => 'Підтримати';

  @override
  String get settingsSectionLegal => 'Правова інформація';

  @override
  String get settingsSectionLanguage => 'Мова';

  @override
  String get settingsGuide => 'Як грати';

  @override
  String get settingsGuideSubtitle => 'Правила, комбо, запал і підсилення';

  @override
  String get settingsSound => 'Звук';

  @override
  String get settingsMusic => 'Музика';

  @override
  String get settingsHaptics => 'Вібрація';

  @override
  String get settingsHapticsOff => 'Вимк.';

  @override
  String get settingsHapticsLight => 'Слабка';

  @override
  String get settingsHapticsStrong => 'Сильна';

  @override
  String get settingsSectionAccessibility => 'Комфорт';

  @override
  String get settingsReducedEffects => 'Менше ефектів';

  @override
  String get settingsReducedEffectsHint =>
      'Менше частинок, без трясіння екрана, без світіння';

  @override
  String get settingsNotifications => 'Сповіщення';

  @override
  String get settingsNotificationsSubtitle =>
      'Щоденне нагадування й захист серії';

  @override
  String get settingsNotificationsSystemHint =>
      'Дозволь їх у системних налаштуваннях.';

  @override
  String get settingsLanguageSystem => 'Мова системи';

  @override
  String get settingsSupporterThanks => 'Прихильник — дякуємо!';

  @override
  String get settingsSupporterPack => 'Набір прихильника';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ексклюзивні тема й скін + 1 500 монет';

  @override
  String get settingsRestorePurchases => 'Відновити покупки';

  @override
  String get settingsRestoring => 'Відновлення покупок…';

  @override
  String get settingsRateApp => 'Оцінити застосунок';

  @override
  String get settingsRateAppSubtitle => 'Залиш оцінку в магазині';

  @override
  String get settingsStoreUnavailable =>
      'Магазин недоступний на цьому пристрої.';

  @override
  String get settingsFeedback => 'Надіслати відгук';

  @override
  String get settingsFeedbackSubtitle => 'Ідеї та помилки (через GitHub)';

  @override
  String get settingsAdPrivacy => 'Конфіденційність реклами';

  @override
  String get settingsAdPrivacySubtitle =>
      'Переглянути або змінити згоду на рекламу';

  @override
  String get settingsAdPrivacyUnavailable =>
      'На цьому пристрої налаштування реклами не потрібні.';

  @override
  String get settingsPrivacy => 'Політика конфіденційності';

  @override
  String get settingsImprint => 'Вихідні дані';

  @override
  String get settingsPageOpenFailed => 'Не вдалося відкрити сторінку.';

  @override
  String get settingsFooter => 'Qubble • Офлайн-головоломка з блоками';

  @override
  String get settingsAdminSection => 'Адмін (тест)';

  @override
  String get settingsAdminEnabled => 'Режим адміністратора ввімкнено';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ще $count дотику до режиму адміна',
      many: 'Ще $count дотиків до режиму адміна',
      few: 'Ще $count дотики до режиму адміна',
      one: 'Ще $count дотик до режиму адміна',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    return 'Монети: $coins';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Лише для тестування — ніколи не показувати на скриншотах релізу';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount монет';
  }

  @override
  String get settingsAdminResetCoins => 'Обнулити монети';

  @override
  String get feedbackTitle => 'Відгук';

  @override
  String get feedbackIntroShort =>
      'Що подобається, що дратує, чого бракує? Дрібниці теж допомагають — чим конкретніше, тим краще.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Додаються лише $build і тип твого пристрою — щоб було зрозуміло, про яку збірку йдеться.';
  }

  @override
  String get feedbackSendByMail => 'Надіслати поштою';

  @override
  String get feedbackPreferGithub => 'Краще issue на GitHub';

  @override
  String get feedbackThanksMail => 'Дякую! Просто надішли лист.';

  @override
  String get feedbackNoMailApp =>
      'Поштовий застосунок не знайдено. Спробуй варіант із GitHub нижче.';

  @override
  String get feedbackEmptyHint => 'Спочатку напиши щось.';

  @override
  String get leaderboardRefresh => 'Оновити';

  @override
  String get leaderboardRetry => 'Спробувати ще раз';

  @override
  String get feedbackHint => 'Твій відгук…';

  @override
  String get feedbackSubmit => 'Надіслати відгук';

  @override
  String get feedbackOpenFailed =>
      'Не вдалося відкрити GitHub. Спробуй пізніше.';

  @override
  String get feedbackGithubNote =>
      'Відкриється GitHub — натисни там «Submit new issue». (Потрібен одноразовий вхід у GitHub.)';

  @override
  String get shopTitle => 'Магазин';

  @override
  String get shopWebDemoNote =>
      'Покупки доступні лише в застосунку з Play Store. Ця веб-версія — безкоштовне демо, але пограти тут можна повністю.';

  @override
  String get shopSupporterExplainer =>
      'У Qubble немає примусової реклами — тобі ніколи не потрібно нічого купувати. Набір прихильника (тема «Аврора», скін «Кришталь», 1 500 монет, значок прихильника) — це подяка за підтримку гри. Покупки прив’язані до твого облікового запису в магазині й можуть бути відновлені будь-коли.';

  @override
  String get shopSupporterContents =>
      'Тема «Аврора» + скін «Кришталь» + 1 500 монет';

  @override
  String get themesTitle => 'Теми';

  @override
  String get themesSupporterOnly => 'Лише в наборі прихильника (див. магазин)';

  @override
  String get themesInSupporterPack => 'У наборі прихильника';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Замало монет (потрібно $cost, є $coins)';
  }

  @override
  String get skinsTitle => 'Скіни блоків';

  @override
  String get skinsNotEnoughDiamonds =>
      'Замало діамантів (обміняй золото нижче)';

  @override
  String get skinsNotEnoughCoins => 'Замало монет';

  @override
  String get skinsNotEnoughGold => 'Замало золота.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold золота = 1 діамант. Діаманти відкривають найкращі скіни — збирай без поспіху.';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get statsAverageScore => 'Сер. рахунок';

  @override
  String get statsBestCombo => 'Найкраще комбо';

  @override
  String get statsGames => 'Ігри';

  @override
  String get statsLinesCleared => 'Очищено рядів';

  @override
  String get statsPiecesPlaced => 'Поставлено фігур';

  @override
  String get statsCoins => 'Монети';

  @override
  String get missionsTitle => 'Місії';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Постав $countString фігури',
      many: 'Постав $countString фігур',
      few: 'Постав $countString фігури',
      one: 'Постав $countString фігуру',
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
      other: 'Очисти $countString ряду',
      many: 'Очисти $countString рядів',
      few: 'Очисти $countString ряди',
      one: 'Очисти $countString ряд',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Досягни комбо x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Набери $countString очка за гру',
      many: 'Набери $countString очок за гру',
      few: 'Набери $countString очки за гру',
      one: 'Набери $countString очко за гру',
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
      other: 'Зіграй $countString гри',
      many: 'Зіграй $countString ігор',
      few: 'Зіграй $countString гри',
      one: 'Зіграй $countString гру',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Досягнення';

  @override
  String get achievementFirstGameTitle => 'Перша гра';

  @override
  String get achievementFirstGameBody => 'Зіграй свою першу гру';

  @override
  String get achievementGames25Title => 'Завсідник';

  @override
  String get achievementGames25Body => 'Зіграй 25 ігор';

  @override
  String get achievementGames100Title => 'На гачку';

  @override
  String get achievementGames100Body => 'Зіграй 100 ігор';

  @override
  String get achievementScore1kTitle => 'Альпініст';

  @override
  String get achievementScore1kBody => 'Набери 1 000 очок';

  @override
  String get achievementScore5kTitle => 'Профі';

  @override
  String get achievementScore5kBody => 'Набери 5 000 очок';

  @override
  String get achievementScore10kTitle => 'Майстер';

  @override
  String get achievementScore10kBody => 'Набери 10 000 очок';

  @override
  String get achievementScore25kTitle => 'Легенда';

  @override
  String get achievementScore25kBody => 'Набери 25 000 очок';

  @override
  String get achievementLines100Title => 'Охайність';

  @override
  String get achievementLines100Body => 'Очисти 100 рядів загалом';

  @override
  String get achievementLines1000Title => 'Генеральне прибирання';

  @override
  String get achievementLines1000Body => 'Очисти 1 000 рядів загалом';

  @override
  String get achievementCombo5Title => 'Комбо-новачок';

  @override
  String get achievementCombo5Body => 'Досягни комбо x5';

  @override
  String get achievementCombo10Title => 'Король комбо';

  @override
  String get achievementCombo10Body => 'Досягни комбо x10';

  @override
  String get achievementLevel10Title => 'Досвідчений';

  @override
  String get achievementLevel10Body => 'Досягни 10 рівня';

  @override
  String get achievementLevel20Title => 'Ветеран';

  @override
  String get achievementLevel20Body => 'Досягни 20 рівня';

  @override
  String get achievementStreak7Title => 'Тижнева серія';

  @override
  String get achievementStreak7Body => 'Щоденний виклик 7 днів поспіль';

  @override
  String get achievementStreak30Title => 'Місячна серія';

  @override
  String get achievementStreak30Body => 'Щоденний виклик 30 днів поспіль';

  @override
  String get achievementPuzzles10Title => 'Знавець головоломок';

  @override
  String get achievementPuzzles10Body => 'Розв’яжи 10 головоломок';

  @override
  String get achievementPieces5000Title => 'Будівельник';

  @override
  String get achievementPieces5000Body => 'Постав 5 000 фігур';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'дня',
      many: 'днів',
      few: 'дні',
      one: 'день',
    );
    return 'Серія під загрозою: $streak $_temp0!';
  }

  @override
  String get streakRepairBody => 'Учора гри не було — врятуй свою серію:';

  @override
  String get streakRepairFailed => 'Відновлення неможливе.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: 'монети',
      many: 'монет',
      few: 'монети',
      one: 'монета',
    );
    return 'З поверненням! +$coins $_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Нагадування?';

  @override
  String get notificationsOptInBody =>
      'Нагадувати про щоденну головоломку й берегти твою серію? Це можна будь-коли змінити в налаштуваннях.';

  @override
  String get notificationsOptInAccept => 'Так, будь ласка';

  @override
  String get notificationChannelDescription =>
      'Щоденне нагадування, попередження про серію, запрошення повернутися';

  @override
  String get notificationDailyTitle => 'Твоя щоденна головоломка чекає 🧩';

  @override
  String get notificationDailyBody => 'Зіграй сьогоднішній виклик!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'дня',
      many: 'днів',
      few: 'дні',
      one: 'день',
    );
    return '🔥 Серія під загрозою: $streak $_temp0!';
  }

  @override
  String get notificationStreakBody => 'Зіграй сьогодні, щоб її зберегти.';

  @override
  String get notificationComebackTitle => 'Твоя головоломка сумує 🧩';

  @override
  String get notificationComebackBody => 'Повертайся й забери подарунок!';

  @override
  String get iapSupporterPack => 'Набір прихильника';

  @override
  String get iapCoinsSmall => '500 монет';

  @override
  String get iapCoinsMedium => '2 000 монет';

  @override
  String get iapCoinsLarge => '6 000 монет';

  @override
  String get iapStarterPack => 'Стартовий набір';

  @override
  String get iapRename => 'Зміна імені';

  @override
  String get iapNeonTheme => 'Тема «Неон»';

  @override
  String get settingsLeaderboardDelete => 'Видалити запис у таблиці лідерів';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Прибирає твоє ім’я та рахунок із публічного списку';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Видалити свій запис?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Твоє ім’я та рахунок буде видалено з таблиці лідерів. Прогрес у грі не зміниться. Повернутися до таблиці лідерів можна будь-коли.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Твій запис у таблиці лідерів видалено.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Не вдалося видалити запис. Перевір з’єднання та спробуй ще раз.';

  @override
  String get leaderboardReport => 'Поскаржитися на це ім’я';

  @override
  String get leaderboardBlock => 'Заблокувати';

  @override
  String leaderboardBlocked(String name) {
    return '$name приховано для тебе';
  }

  @override
  String get leaderboardUndo => 'Скасувати';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count запису приховано',
      many: '$count записів приховано',
      few: '$count записи приховано',
      one: '$count запис приховано',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Показати знову';

  @override
  String get leaderboardReportUnavailable => 'Поскаржитися зараз неможливо.';

  @override
  String get leaderboardReportSent => 'Дякуємо — скаргу надіслано.';

  @override
  String get leaderboardRules =>
      'Імена публічні. Без образ, без лайки й нічого, що вказує на реальну людину. Імена, що порушують правила, видаляються.';

  @override
  String get leaderboardRulesAccept => 'Зрозуміло';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Відкрито $unlocked з $total';
  }

  @override
  String get settingsSectionData => 'Збережені дані';

  @override
  String get gameRotatePiece => 'Повернути фігуру';

  @override
  String get themeClassic => 'Класика';

  @override
  String get themeFade => 'Пастель';

  @override
  String get themeNeon => 'Неон';

  @override
  String get themeOcean => 'Океан';

  @override
  String get themeWood => 'Дерево';

  @override
  String get themeSunset => 'Захід сонця';

  @override
  String get themeForest => 'Ліс';

  @override
  String get themeAurora => 'Аврора';

  @override
  String get skinClassic => 'Класика';

  @override
  String get skinGradient => 'Градієнт';

  @override
  String get skinOutline => 'Контур';

  @override
  String get skinGlossy => 'Глянець';

  @override
  String get skinStripe => 'Смуги';

  @override
  String get skinBevel => 'Фаска';

  @override
  String get skinGlow => 'Сяйво';

  @override
  String get skinCrystal => 'Кришталь';

  @override
  String rewardThemeName(String name) {
    return 'Тема «$name»';
  }

  @override
  String rewardSkinName(String name) {
    return 'Скін «$name»';
  }
}
