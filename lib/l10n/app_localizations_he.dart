// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class L10nHe extends L10n {
  L10nHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'לשחק';

  @override
  String get commonLater => 'אחר כך';

  @override
  String get commonNotNow => 'לא עכשיו';

  @override
  String get commonCancel => 'ביטול';

  @override
  String get commonBuy => 'קנייה';

  @override
  String get commonSave => 'שמירה';

  @override
  String get commonCollect => 'לאסוף';

  @override
  String get nameNewName => 'שם חדש';

  @override
  String get nameFieldLabel => 'שם';

  @override
  String get piggyFullTitle => 'קופת החיסכון מלאה!';

  @override
  String get piggyKeepSaving => 'להמשיך לחסוך';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'נאספו $coins מתוך $capacity.';
  }

  @override
  String get homeContinueRun => 'המשך';

  @override
  String get homeVideo => 'וידאו';

  @override
  String get commonGotIt => 'הבנתי';

  @override
  String get commonHome => 'בית';

  @override
  String get commonScore => 'ניקוד';

  @override
  String get commonBest => 'שיא';

  @override
  String commonLevelShort(int level) {
    return 'שלב $level';
  }

  @override
  String get homeNewRun => 'משחק חדש';

  @override
  String get homeBackToExit => 'יש ללחוץ שוב על \'חזרה\' כדי לצאת';

  @override
  String get homeEnableLeaderboard => 'הצטרפות לטבלת המובילים';

  @override
  String get homeBestScore => 'השיא האישי';

  @override
  String get homeDailyChallenge => 'האתגר היומי';

  @override
  String get homeDailyOpenToday => 'פתוח היום';

  @override
  String homeDailyNextIn(String time) {
    return 'האתגר הבא בעוד $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'רצף: $streak ימים',
      one: 'רצף: $streak יום',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'טבלת המובילים';

  @override
  String get homePuzzleMode => 'מצב חידות';

  @override
  String get homeMissions => 'משימות';

  @override
  String get homeThemes => 'ערכות נושא';

  @override
  String get homeSkins => 'מראות';

  @override
  String get homeHowToPlay => 'איך משחקים ב-Qubble';

  @override
  String get homeWeekendBonus => 'סוף שבוע: מטבעות כפולים!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'שלב $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'שינוי שם';

  @override
  String get nameChangeExplainer =>
      'השם שלך הוא הזהות שלך בטבלת המובילים, ולכן הוא קבוע. אפשר לקנות שינוי שם חד-פעמי.';

  @override
  String get nameChangeAfterPurchase =>
      'אחרי הרכישה יש להקיש שוב על השם כדי לשנות אותו.';

  @override
  String get nameJoinedLeaderboard => 'נכנסת לטבלת המובילים.';

  @override
  String get nameRenameUnavailable => 'אי אפשר לשנות את השם כרגע.';

  @override
  String nameProblemTooShort(int min) {
    return 'לפחות $min תווים.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'לכל היותר $max תווים.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'רק אותיות באנגלית (A–Z), ספרות, רווחים, _ או -.';

  @override
  String get nameProblemOffensive => 'נא לבחור שם אחר.';

  @override
  String get piggyTitle => 'קופת חיסכון';

  @override
  String get piggyFillingHint => 'קופת החיסכון מתמלאת כשמנקים שורות.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins מטבעות',
      one: '$coins מטבע',
    );
    return 'לאסוף $_temp0 — בחינם.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'כשהיא מלאה אפשר לרוקן אותה בחינם — או לפתוח אותה מוקדם יותר עם סרטון בונוס.';

  @override
  String get piggyOpenNow => 'לפתוח עכשיו';

  @override
  String get gameNewPiecesVideo => 'חלקים חדשים (וידאו)';

  @override
  String get gameTapBoardCell => 'יש להקיש על משבצת בלוח';

  @override
  String get gameDailyChallengeLabel => 'האתגר היומי';

  @override
  String get gameOver => 'המשחק נגמר';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'חסרים מטבעות לפצצה: $missing.';
  }

  @override
  String get gameBombNotHere => 'הפצצה לא עובדת כאן כרגע.';

  @override
  String gameNeedsCoins(String missing) {
    return 'חסרים מטבעות: $missing.';
  }

  @override
  String get gameNotRightNow => 'אי אפשר כרגע.';

  @override
  String get gameRunSaved => 'המשחק נשמר — \'המשך\' בתפריט.';

  @override
  String get gameOverNoFit => 'אף אחד מהחלקים שלך כבר לא נכנס ללוח.';

  @override
  String get gameOverNoFitNoRotations => 'אף חלק לא נכנס — והסיבובים נגמרו.';

  @override
  String get gameStarterOfferUnavailable => 'לא זמין כרגע';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — לקבל';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'קומבו x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'הישג: $title';
  }

  @override
  String get gameBestSubmitted => 'שיא חדש — נשלח';

  @override
  String get gameReviveFor => 'להמשיך לשחק · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'נפתח: $name';
  }

  @override
  String get gameStarterOfferTitle => 'חבילת פתיחה';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score נקודות',
      one: '$score נקודה',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'שיא חדש!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'רצף: $streak ימים',
      one: 'רצף: $streak יום',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'מטבעות כפולים';

  @override
  String get gameDoubleDaily => 'פרס יומי כפול';

  @override
  String get gamePlayAgain => 'לשחק שוב';

  @override
  String gameLevelReached(int level) {
    return 'הגעת לשלב $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count שלבים — שלב $level!',
      one: '+$count שלב — שלב $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 מטבעות + ערכת עץ';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'נשארו רק $hours שעות — פעם אחת בלבד!',
      one: 'נשארה רק $hours שעה — פעם אחת בלבד!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'חזרה';

  @override
  String get boosterSwap => 'החלפה';

  @override
  String get boosterBomb => 'פצצה';

  @override
  String get boosterNoRotationsLeft =>
      'אין עוד סיבובים — אפשר לנקות שורות כדי להטעין!';

  @override
  String get onboardingDragPiece => 'יש לגרור חלק אל הלוח';

  @override
  String get onboardingFillLine => 'צריך למלא שורה או עמודה שלמה';

  @override
  String get onboardingLinesClear => 'שורות מלאות נעלמות — נקודות!';

  @override
  String get coachHintCombo => 'קומבו! עוד ניקוי תוך 3 מהלכים שומר עליו';

  @override
  String get coachHintFever => 'קדחת! נקודות כפולות כל עוד זה זוהר';

  @override
  String get coachHintRotation => 'סיבוב עולה טעינה אחת — ניקויים ממלאים אותה';

  @override
  String get coachHintBooster => 'טיפ: למטה יש עזרים';

  @override
  String get coachHintStrategy =>
      'טיפ: לא כל השורות בבת אחת — כדאי להשאיר מקום לחלקים הגדולים';

  @override
  String get dailyStreakLabel => 'רצף';

  @override
  String get dailyBestLabel => 'השיא היומי';

  @override
  String dailyHistoryNote(int days) {
    return 'נשמרים $days הימים האחרונים.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: שוחק';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: לא שוחק';
  }

  @override
  String get homeDailyCalendar => 'לוח שנה';

  @override
  String get dailyShareButton => 'שיתוף התוצאה';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · האתגר היומי $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'ניקוד: $score · הקומבו הכי טוב x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'לשחק: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'קומבו: נותרו $moves מהלכים',
      one: 'קומבו: נותר $moves מהלך',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'התוצאה הועתקה';

  @override
  String get adNotAvailable => 'אין סרטון זמין כרגע — כדאי לנסות שוב עוד רגע';

  @override
  String get howToPlaySpeedTitle => 'בונוס מהירות';

  @override
  String get howToPlaySpeedBody =>
      'הנחה מהירה מוסיפה עד 30% לניקוי. הבונוס דועך בין 1.5 ל-4 שניות ויש לו תקרה, כך שמהירות משתלמת בלי להכריע את המשחק — משחק זהיר ואיטי עדיין יכול לנצח משחק חפוז.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'בונוס מהירות $percent אחוז';
  }

  @override
  String get iapDiamondsSmall => '100 יהלומים';

  @override
  String get iapDiamondsMedium => '350 יהלומים';

  @override
  String get iapDiamondsLarge => '1,000 יהלומים';

  @override
  String get howToPlayTitle => 'איך משחקים ב-Qubble';

  @override
  String get howToPlayIntroHeadline => 'קל להתחיל.\nמתגמל תכנון מראש.';

  @override
  String get howToPlayIntroBody => 'לשמור על הלוח פנוי ולשבור את השיא.';

  @override
  String get howToPlayIntroSemantics =>
      'מטרת המשחק. לשמור על הלוח פנוי ולשבור את השיא.';

  @override
  String get howToPlayDragTitle => 'לגרור ולשחרר';

  @override
  String get howToPlayDragBody =>
      'גוררים אחד משלושת החלקים למשבצות פנויות. אחרי שכל השלושה בשימוש, מקבלים אוטומטית שלושה חדשים.';

  @override
  String get howToPlayClearTitle => 'לנקות שורות';

  @override
  String get howToPlayClearBody =>
      'ממלאים שורה או עמודה שלמה. שורות מלאות נעלמות ומפנות מקום למהלך הבא.';

  @override
  String get howToPlayComboTitle => 'שרשרת קומבו';

  @override
  String get howToPlayComboBody =>
      'מנקים עוד שורה תוך שלושה מהלכים. כל קומבו נוסף מגדיל את מכפיל הנקודות. הקומבו סופר מהלכים, לא שניות, כך שהוא לא נגמר בזמן שחושבים.';

  @override
  String get howToPlayFeverTitle => 'להדליק את הקדחת';

  @override
  String get howToPlayFeverBody =>
      'ניקויים ממלאים את מד הקדחת. כשהוא מלא, הניקוי הגדול הבא נספר כפול — כדאי לתכנן ניקויים גדולים מראש.';

  @override
  String get howToPlayBoosterTitle => 'עזרים בחוכמה';

  @override
  String get howToPlayBoosterBody =>
      'העזרים מצילים משחקים צפופים. אפשר גם להקיש על חלק למטה כדי לסובב אותו.';

  @override
  String get howToPlayDailyTitle => 'האתגר היומי והרצף';

  @override
  String get howToPlayDailyBody =>
      'באתגר היומי כולם מקבלים את אותם החלקים. משחקים כל יום כדי להגדיל את הרצף והבונוס.';

  @override
  String get howToPlayPiggyTitle => 'למלא את קופת החיסכון';

  @override
  String get howToPlayPiggyBody =>
      'כל שורה שמנקים ממלאת את קופת החיסכון. כשהיא מלאה, אפשר לאסוף את המטבעות בחינם.';

  @override
  String get leaderboardTitle => 'טבלת המובילים';

  @override
  String get leaderboardUnreachable =>
      'טבלת המובילים לא זמינה.\nכדאי לנסות שוב עם חיבור לאינטרנט.';

  @override
  String get leaderboardEmpty => 'עדיין אין תוצאות.\nאפשר להיות הראשונים!';

  @override
  String leaderboardSubmitting(int score) {
    return 'השיא שלך ($score) נשלח …';
  }

  @override
  String get leaderboardAutoSubmit => 'השיא שלך נשלח אוטומטית.';

  @override
  String get puzzleModeTitle => 'מצב חידות';

  @override
  String puzzleLevelTitle(int level) {
    return 'חידה $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'מהלכים: $moves   •   יעד: $target ל-3 כוכבים';
  }

  @override
  String get puzzleSolved => 'נפתר!';

  @override
  String get puzzleLeaveTitle => 'לצאת מהחידה?';

  @override
  String get puzzleLeaveBody => 'ההתקדמות בחידה הזו תאבד.';

  @override
  String get puzzleKeepPlaying => 'להמשיך לשחק';

  @override
  String get puzzleLeave => 'יציאה';

  @override
  String get puzzleStuckTitle => 'מבוי סתום';

  @override
  String get puzzleRestart => 'מההתחלה';

  @override
  String get commonActive => 'פעיל';

  @override
  String get commonTapToActivate => 'להקיש להפעלה';

  @override
  String get commonRestore => 'שחזור';

  @override
  String unlockForCost(int cost) {
    return 'פתיחה ב-$cost';
  }

  @override
  String get skinsExchangeGold => 'המרת זהב';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'סיבוב החלק';

  @override
  String get puzzleNextLevel => 'השלב הבא';

  @override
  String get puzzleBackToOverview => 'חזרה לסקירה';

  @override
  String get puzzleUnsolvable => 'מכאן כבר אי אפשר לרוקן את הלוח.';

  @override
  String get puzzleExtraMoveVideo => 'מהלך נוסף (וידאו)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'נפתרו: $solved';
  }

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get storageFailureTitle => 'Qubble לא מצליח לטעון את המשחק השמור';

  @override
  String get storageFailureBody =>
      'נא להפעיל מחדש את האפליקציה. אם השגיאה נמשכת, רק התקנה מחדש תעזור. אפשר לדווח עליה בהגדרות › משוב.';

  @override
  String get iapUnavailable => 'ההצעה הזו לא זמינה כרגע.';

  @override
  String get iapFailed => 'הרכישה לא הושלמה. לא בוצע חיוב.';

  @override
  String get settingsResetProgress => 'איפוס ההתקדמות';

  @override
  String get settingsResetProgressSubtitle =>
      'ניקוד, מטבעות, שלב והתקדמות חוזרים להתחלה. רכישות, שם ופריטי מראה נשמרים.';

  @override
  String get settingsResetConfirmTitle => 'לאפס את ההתקדמות?';

  @override
  String get settingsResetConfirmBody =>
      'השיא, המטבעות, השלב, הרצף וכל ההתקדמות יימחקו. אי אפשר לבטל את זה.\n\nהרכישות, השם, ערכות הנושא והמראות שנפתחו נשמרים.';

  @override
  String get settingsResetConfirmAction => 'איפוס';

  @override
  String get settingsResetDone => 'ההתקדמות אופסה.';

  @override
  String get settingsSectionGame => 'משחק';

  @override
  String get settingsSectionSoundHaptics => 'צליל ורטט';

  @override
  String get settingsSectionReminders => 'תזכורות';

  @override
  String get settingsSectionPurchases => 'רכישות';

  @override
  String get settingsSectionHelpOut => 'לעזור לנו';

  @override
  String get settingsSectionLegal => 'מידע משפטי';

  @override
  String get settingsSectionLanguage => 'שפה';

  @override
  String get settingsGuide => 'איך משחקים';

  @override
  String get settingsGuideSubtitle => 'כללים, קומבו, קדחת ועזרים';

  @override
  String get settingsSound => 'צלילים';

  @override
  String get settingsMusic => 'מוזיקה';

  @override
  String get settingsHaptics => 'רטט';

  @override
  String get settingsHapticsOff => 'כבוי';

  @override
  String get settingsHapticsLight => 'חלש';

  @override
  String get settingsHapticsStrong => 'חזק';

  @override
  String get settingsSectionAccessibility => 'נוחות';

  @override
  String get settingsReducedEffects => 'פחות אפקטים';

  @override
  String get settingsReducedEffectsHint =>
      'פחות חלקיקים, בלי רעידות מסך, בלי זוהר';

  @override
  String get settingsNotifications => 'התראות';

  @override
  String get settingsNotificationsSubtitle => 'תזכורת יומית והגנה על הרצף';

  @override
  String get settingsNotificationsSystemHint =>
      'אפשר לאשר אותן בהגדרות המערכת.';

  @override
  String get settingsLanguageSystem => 'שפת המערכת';

  @override
  String get settingsSupporterThanks => 'תומכים — תודה!';

  @override
  String get settingsSupporterPack => 'חבילת תומכים';

  @override
  String get settingsSupporterPackSubtitle =>
      'ערכת נושא ומראה בלעדיים + 1,500 מטבעות';

  @override
  String get settingsRestorePurchases => 'שחזור רכישות';

  @override
  String get settingsRestoring => 'משחזר רכישות…';

  @override
  String get settingsRateApp => 'לדרג את האפליקציה';

  @override
  String get settingsRateAppSubtitle => 'להשאיר דירוג בחנות';

  @override
  String get settingsStoreUnavailable => 'החנות לא זמינה במכשיר הזה.';

  @override
  String get settingsFeedback => 'שליחת משוב';

  @override
  String get settingsFeedbackSubtitle => 'רעיונות ובאגים (דרך GitHub)';

  @override
  String get settingsAdPrivacy => 'פרטיות מודעות';

  @override
  String get settingsAdPrivacySubtitle => 'צפייה בהסכמה למודעות או שינוי שלה';

  @override
  String get settingsAdPrivacyUnavailable =>
      'במכשיר הזה אין צורך בהגדרות מודעות.';

  @override
  String get settingsPrivacy => 'מדיניות פרטיות';

  @override
  String get settingsImprint => 'פרטי המפרסם';

  @override
  String get settingsPageOpenFailed => 'לא הצלחנו לפתוח את הדף.';

  @override
  String get settingsFooter => 'Qubble • פאזל בלוקים אופליין';

  @override
  String get settingsAdminSection => 'מנהל (בדיקה)';

  @override
  String get settingsAdminEnabled => 'מצב מנהל פעיל';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'עוד $count הקשות למצב מנהל';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins מטבעות',
      one: '$coins מטבע',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'לבדיקות בלבד — אף פעם לא בצילומי מסך לפרסום';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount מטבעות';
  }

  @override
  String get settingsAdminResetCoins => 'איפוס מטבעות ל-0';

  @override
  String get feedbackTitle => 'משוב';

  @override
  String get feedbackIntroShort =>
      'מה אהבת, מה מעצבן, מה חסר? גם דברים קטנים עוזרים — כמה שיותר ספציפי, יותר טוב.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'מצורפים רק $build וסוג המכשיר — כדי שאדע לאיזו גרסה הכוונה.';
  }

  @override
  String get feedbackSendByMail => 'שליחה במייל';

  @override
  String get feedbackPreferGithub => 'עדיף issue ב-GitHub';

  @override
  String get feedbackThanksMail => 'תודה! נשאר רק לשלוח את ההודעה.';

  @override
  String get feedbackNoMailApp =>
      'לא נמצאה אפליקציית מייל. כדאי לנסות את הדרך דרך GitHub למטה.';

  @override
  String get feedbackEmptyHint => 'קודם צריך לכתוב משהו.';

  @override
  String get leaderboardRefresh => 'רענון';

  @override
  String get leaderboardRetry => 'לנסות שוב';

  @override
  String get feedbackHint => 'המשוב שלך…';

  @override
  String get feedbackSubmit => 'שליחת משוב';

  @override
  String get feedbackOpenFailed =>
      'לא הצלחנו לפתוח את GitHub. כדאי לנסות שוב מאוחר יותר.';

  @override
  String get feedbackGithubNote =>
      'GitHub נפתח — שם יש להקיש על \'Submit new issue\'. (נדרשת התחברות חד-פעמית ל-GitHub.)';

  @override
  String get shopTitle => 'חנות';

  @override
  String get shopWebDemoNote =>
      'רכישות זמינות רק באפליקציה מ-Google Play. גרסת האינטרנט הזו היא הדגמה חינמית — אפשר לשחק כאן בכל המשחק.';

  @override
  String get shopSupporterExplainer =>
      'Qubble לא מציג מודעות כפויות — אף פעם לא צריך לקנות כלום. חבילת התומכים (ערכת זוהר צפוני, מראה קריסטל, 1,500 מטבעות, תג תומכים) היא תודה על התמיכה במשחק. רכישות מקושרות לחשבון החנות שלך ואפשר לשחזר אותן בכל עת.';

  @override
  String get shopSupporterContents =>
      'ערכת זוהר צפוני + מראה קריסטל + 1,500 מטבעות';

  @override
  String get themesTitle => 'ערכות נושא';

  @override
  String get themesSupporterOnly => 'רק בחבילת התומכים (ראו בחנות)';

  @override
  String get themesInSupporterPack => 'בחבילת התומכים';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'אין מספיק מטבעות (צריך $cost, יש $coins)';
  }

  @override
  String get skinsTitle => 'מראות לבלוקים';

  @override
  String get skinsNotEnoughDiamonds =>
      'אין מספיק יהלומים (אפשר להמיר זהב למטה)';

  @override
  String get skinsNotEnoughCoins => 'אין מספיק מטבעות';

  @override
  String get skinsNotEnoughGold => 'אין מספיק זהב.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold זהב = יהלום אחד. יהלומים פותחים את המראות היפים ביותר — אפשר לאסוף בנחת.';
  }

  @override
  String get statsTitle => 'סטטיסטיקה';

  @override
  String get statsAverageScore => 'ניקוד ממוצע';

  @override
  String get statsBestCombo => 'הקומבו הכי טוב';

  @override
  String get statsGames => 'משחקים';

  @override
  String get statsLinesCleared => 'שורות שנוקו';

  @override
  String get statsPiecesPlaced => 'חלקים שהונחו';

  @override
  String get statsCoins => 'מטבעות';

  @override
  String get missionsTitle => 'משימות';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'להניח $countString חלקים',
      one: 'להניח $countString חלק',
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
      other: 'לנקות $countString שורות',
      one: 'לנקות $countString שורה',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'להגיע לקומבו x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'לצבור $countString נקודות במשחק אחד',
      one: 'לצבור $countString נקודה במשחק אחד',
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
      other: 'לשחק $countString משחקים',
      one: 'לשחק $countString משחק',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'הישגים';

  @override
  String get achievementFirstGameTitle => 'משחק ראשון';

  @override
  String get achievementFirstGameBody => 'לשחק את המשחק הראשון';

  @override
  String get achievementGames25Title => 'קבוע';

  @override
  String get achievementGames25Body => 'לשחק 25 משחקים';

  @override
  String get achievementGames100Title => 'מכור';

  @override
  String get achievementGames100Body => 'לשחק 100 משחקים';

  @override
  String get achievementScore1kTitle => 'מטפס';

  @override
  String get achievementScore1kBody => 'להגיע ל-1,000 נקודות';

  @override
  String get achievementScore5kTitle => 'מקצוען';

  @override
  String get achievementScore5kBody => 'להגיע ל-5,000 נקודות';

  @override
  String get achievementScore10kTitle => 'אמן';

  @override
  String get achievementScore10kBody => 'להגיע ל-10,000 נקודות';

  @override
  String get achievementScore25kTitle => 'אגדה';

  @override
  String get achievementScore25kBody => 'להגיע ל-25,000 נקודות';

  @override
  String get achievementLines100Title => 'מסודר';

  @override
  String get achievementLines100Body => 'לנקות 100 שורות בסך הכול';

  @override
  String get achievementLines1000Title => 'ניקיון יסודי';

  @override
  String get achievementLines1000Body => 'לנקות 1,000 שורות בסך הכול';

  @override
  String get achievementCombo5Title => 'מתחיל קומבו';

  @override
  String get achievementCombo5Body => 'להגיע לקומבו x5';

  @override
  String get achievementCombo10Title => 'מלך הקומבו';

  @override
  String get achievementCombo10Body => 'להגיע לקומבו x10';

  @override
  String get achievementLevel10Title => 'מנוסה';

  @override
  String get achievementLevel10Body => 'להגיע לשלב 10';

  @override
  String get achievementLevel20Title => 'ותיק';

  @override
  String get achievementLevel20Body => 'להגיע לשלב 20';

  @override
  String get achievementStreak7Title => 'רצף שבועי';

  @override
  String get achievementStreak7Body => 'רצף יומי של 7 ימים';

  @override
  String get achievementStreak30Title => 'רצף חודשי';

  @override
  String get achievementStreak30Body => 'רצף יומי של 30 ימים';

  @override
  String get achievementPuzzles10Title => 'פותר חידות';

  @override
  String get achievementPuzzles10Body => 'לפתור 10 חידות';

  @override
  String get achievementPieces5000Title => 'בנאי';

  @override
  String get achievementPieces5000Body => 'להניח 5,000 חלקים';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'הרצף של $streak ימים בסכנה!',
      one: 'הרצף של $streak יום בסכנה!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'אתמול לא שיחקת — אפשר להציל את הרצף:';

  @override
  String get streakRepairFailed => 'אי אפשר לתקן.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins מטבעות',
      one: '$coins מטבע',
    );
    return 'ברוכים השבים! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'תזכורות?';

  @override
  String get notificationsOptInBody =>
      'להזכיר לך את החידה היומית ולשמור על הרצף? אפשר לשנות את זה בכל עת בהגדרות.';

  @override
  String get notificationsOptInAccept => 'כן, בבקשה';

  @override
  String get notificationChannelDescription =>
      'תזכורת יומית, אזהרת רצף, הזמנה לחזור';

  @override
  String get notificationDailyTitle => 'החידה היומית מחכה 🧩';

  @override
  String get notificationDailyBody => 'האתגר של היום כבר כאן!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'הרצף של $streak ימים בסכנה!',
      one: 'הרצף של $streak יום בסכנה!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'משחק אחד היום שומר עליו.';

  @override
  String get notificationComebackTitle => 'החידה מתגעגעת 🧩';

  @override
  String get notificationComebackBody => 'כדאי לחזור ולאסוף מתנה!';

  @override
  String get iapSupporterPack => 'חבילת תומכים';

  @override
  String get iapCoinsSmall => '500 מטבעות';

  @override
  String get iapCoinsMedium => '2,000 מטבעות';

  @override
  String get iapCoinsLarge => '6,000 מטבעות';

  @override
  String get iapStarterPack => 'חבילת פתיחה';

  @override
  String get iapRename => 'שינוי שם';

  @override
  String get iapNeonTheme => 'ערכת ניאון';

  @override
  String get settingsLeaderboardDelete => 'מחיקת הרשומה מטבלת המובילים';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'מסירה את השם והניקוד שלך מהרשימה הציבורית';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'למחוק את הרשומה?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'השם והניקוד שלך יוסרו מטבלת המובילים. ההתקדמות במשחק לא תשתנה. אפשר להצטרף שוב לטבלה בכל עת.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'הרשומה שלך נמחקה מטבלת המובילים.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'לא הצלחנו למחוק את הרשומה. כדאי לבדוק את החיבור ולנסות שוב.';

  @override
  String get leaderboardReport => 'דיווח על השם הזה';

  @override
  String get leaderboardBlock => 'הסתרה';

  @override
  String leaderboardBlocked(String name) {
    return '$name מוסתר עבורך';
  }

  @override
  String get leaderboardUndo => 'ביטול';

  @override
  String leaderboardBlockedCount(int count) {
    return 'רשומות שהסתרת: $count';
  }

  @override
  String get leaderboardUnblockAll => 'להציג שוב';

  @override
  String get leaderboardReportUnavailable => 'אי אפשר לדווח כרגע.';

  @override
  String get leaderboardReportSent => 'תודה — הדיווח נשלח.';

  @override
  String get leaderboardRules =>
      'השמות גלויים לכולם. בלי עלבונות, בלי קללות ובלי שום דבר שמזהה אדם אמיתי. שמות שמפרים את הכללים יוסרו.';

  @override
  String get leaderboardRulesAccept => 'הבנתי';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'נפתחו $unlocked מתוך $total';
  }

  @override
  String get settingsSectionData => 'נתונים שמורים';

  @override
  String get gameRotatePiece => 'סיבוב החלק';

  @override
  String get themeClassic => 'קלאסי';

  @override
  String get themeFade => 'פסטל';

  @override
  String get themeNeon => 'ניאון';

  @override
  String get themeOcean => 'אוקיינוס';

  @override
  String get themeWood => 'עץ';

  @override
  String get themeSunset => 'שקיעה';

  @override
  String get themeForest => 'יער';

  @override
  String get themeAurora => 'זוהר צפוני';

  @override
  String get skinClassic => 'קלאסי';

  @override
  String get skinGradient => 'מעבר צבע';

  @override
  String get skinOutline => 'קו מתאר';

  @override
  String get skinGlossy => 'מבריק';

  @override
  String get skinStripe => 'פסים';

  @override
  String get skinBevel => 'משופע';

  @override
  String get skinGlow => 'זוהר';

  @override
  String get skinCrystal => 'קריסטל';

  @override
  String rewardThemeName(String name) {
    return 'ערכת $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'מראה $name';
  }
}
