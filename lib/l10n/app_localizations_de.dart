// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class L10nDe extends L10n {
  L10nDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Spielen';

  @override
  String get commonLater => 'Später';

  @override
  String get commonNotNow => 'Nicht jetzt';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonBuy => 'Kaufen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonCollect => 'Abholen';

  @override
  String get nameNewName => 'Neuer Name';

  @override
  String get nameFieldLabel => 'Name';

  @override
  String get piggyFullTitle => 'Sparschwein ist voll!';

  @override
  String get piggyKeepSaving => 'Weiter sparen';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins von $capacity gesammelt.';
  }

  @override
  String get homeContinueRun => 'Weiterspielen';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Verstanden';

  @override
  String get commonHome => 'Hauptmenü';

  @override
  String get commonScore => 'PUNKTE';

  @override
  String get commonBest => 'BEST';

  @override
  String commonLevelShort(int level) {
    return 'Level $level';
  }

  @override
  String get homeNewRun => 'Neue Runde starten';

  @override
  String get homeBackToExit => 'Nochmal zurück zum Beenden';

  @override
  String get homeEnableLeaderboard => 'Bestenliste aktivieren';

  @override
  String get homeBestScore => 'BESTWERT';

  @override
  String get homeDailyChallenge => 'Tägliche Challenge';

  @override
  String get homeDailyOpenToday => 'Heute noch offen';

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak Tage Streak';
  }

  @override
  String get homeLeaderboard => 'Bestenliste';

  @override
  String get homePuzzleMode => 'Rätsel-Modus';

  @override
  String get homeMissions => 'Missionen';

  @override
  String get homeThemes => 'Themes';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'So spielst du Qubble';

  @override
  String get homeWeekendBonus => 'Wochenende: doppelte Münzen!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Level $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Namen ändern';

  @override
  String get nameChangeExplainer =>
      'Dein Name ist deine Bestenlisten-Identität und daher fest. Du kannst eine einmalige Namensänderung kaufen.';

  @override
  String get nameChangeAfterPurchase =>
      'Nach dem Kauf tippe erneut auf deinen Namen zum Ändern.';

  @override
  String get nameJoinedLeaderboard => 'Du bist jetzt in der Bestenliste.';

  @override
  String get nameRenameUnavailable => 'Umbenennen gerade nicht möglich.';

  @override
  String nameProblemTooShort(int min) {
    return 'Mindestens $min Zeichen.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Höchstens $max Zeichen.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Nur Buchstaben, Zahlen, Leerzeichen, _ und -.';

  @override
  String get nameProblemOffensive => 'Bitte wähle einen anderen Namen.';

  @override
  String get piggyTitle => 'Sparschwein';

  @override
  String get piggyFillingHint =>
      'Das Sparschwein füllt sich, während du Reihen räumst.';

  @override
  String piggyCollect(int coins) {
    return 'Hol dir $coins Münzen — gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Ist es voll, kannst du es gratis ausschütten — oder du öffnest es jetzt schon mit einem Bonus-Video.';

  @override
  String get piggyOpenNow => 'Jetzt öffnen';

  @override
  String get gameNewPiecesVideo => 'Neue Teile (Video)';

  @override
  String get gameTapBoardCell => 'Tippe auf eine Zelle im Board';

  @override
  String get gameDailyChallengeLabel => 'TÄGLICHE CHALLENGE';

  @override
  String get gameOver => 'Game Over';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Für die Bombe fehlen dir $missing Münzen.';
  }

  @override
  String get gameBombNotHere => 'Die Bombe geht hier gerade nicht.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Dafür fehlen dir $missing Münzen.';
  }

  @override
  String get gameNotRightNow => 'Gerade nicht möglich.';

  @override
  String get gameRunSaved => 'Runde gespeichert — „Weiterspielen\" im Menü.';

  @override
  String get gameOverNoFit => 'Keins deiner Teile passt noch aufs Brett.';

  @override
  String get gameOverNoFitNoRotations =>
      'Keins deiner Teile passt noch — und die Drehungen sind aufgebraucht.';

  @override
  String get gameStarterOfferUnavailable => 'Gerade nicht verfügbar';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — holen';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Erfolg: $title';
  }

  @override
  String get gameBestSubmitted => 'Neuer Bestwert — eingetragen';

  @override
  String get gameReviveFor => 'Weiterspielen · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Freigeschaltet: $name';
  }

  @override
  String get gameStarterOfferTitle => '🎁 Starter-Paket';

  @override
  String gameOverPoints(int score) {
    return '$score Punkte';
  }

  @override
  String get gameNewRecord => 'Neuer Rekord!';

  @override
  String gameStreakDays(int streak) {
    return '$streak Tage Streak';
  }

  @override
  String get gameDoubleCoins => 'Münzen verdoppeln';

  @override
  String get gamePlayAgain => 'Nochmal spielen';

  @override
  String gameLevelReached(int level) {
    return 'Level $level erreicht!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count Level aufgestiegen — Level $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 Münzen + Wood-Theme';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Nur noch $hours h — einmalig!';
  }

  @override
  String get boosterUndo => 'Undo';

  @override
  String get boosterSwap => 'Tausch';

  @override
  String get boosterBomb => 'Bombe';

  @override
  String get boosterNoRotationsLeft =>
      'Keine Drehungen übrig — räume Reihen zum Aufladen!';

  @override
  String get onboardingDragPiece => 'Zieh einen Stein ins Gitter 👆';

  @override
  String get onboardingFillLine => 'Fülle eine ganze Reihe oder Spalte';

  @override
  String get onboardingLinesClear => 'Volle Linien lösen sich auf — Punkte! ✨';

  @override
  String get coachHintCombo =>
      'Combo! Räume innerhalb von 10 s weiter, sonst läuft sie ab ⏱';

  @override
  String get coachHintFever => 'FIEBER! Doppelte Punkte, solange es glüht 🔥';

  @override
  String get coachHintRotation =>
      'Drehen kostet eine Ladung – Clears füllen sie wieder auf';

  @override
  String get coachHintBooster => 'Tipp: Unten kannst du Booster einsetzen 🪙';

  @override
  String get howToPlayTitle => 'So spielst du Qubble';

  @override
  String get howToPlayIntroHeadline => 'Einfach starten.\nClever vorausplanen.';

  @override
  String get howToPlayIntroBody =>
      'Halte das Brett frei und überbiete deinen Bestwert.';

  @override
  String get howToPlayIntroSemantics =>
      'Ziel des Spiels. Halte das Brett frei und überbiete deinen Bestwert.';

  @override
  String get howToPlayDragTitle => 'Ziehen & platzieren';

  @override
  String get howToPlayDragBody =>
      'Zieh eines der drei Teile auf freie Felder. Sind alle Teile verbaut, bekommst du automatisch drei neue.';

  @override
  String get howToPlayClearTitle => 'Linien abräumen';

  @override
  String get howToPlayClearBody =>
      'Fülle eine komplette Reihe oder Spalte. Volle Linien lösen sich auf und schaffen Platz für den nächsten Zug.';

  @override
  String get howToPlayComboTitle => 'Combos verbinden';

  @override
  String get howToPlayComboBody =>
      'Räume innerhalb von 10 Sekunden erneut eine Linie ab. Jede weitere Combo erhöht deinen Punkte-Multiplikator.';

  @override
  String get howToPlayFeverTitle => 'Fieber auslösen';

  @override
  String get howToPlayFeverBody =>
      'Clears füllen die Fieber-Anzeige. Ist sie voll, zählt der nächste Ausbruch doppelt – plane große Clears voraus.';

  @override
  String get howToPlayBoosterTitle => 'Booster clever nutzen';

  @override
  String get howToPlayBoosterBody =>
      'Booster retten knappe Runden. Tippe außerdem ein Teil in der Ablage an, um es zu drehen.';

  @override
  String get howToPlayDailyTitle => 'Daily & Streak';

  @override
  String get howToPlayDailyBody =>
      'Die tägliche Challenge nutzt für alle dieselben Teile. Spiele jeden Tag, um deinen Streak und Bonus wachsen zu lassen.';

  @override
  String get howToPlayPiggyTitle => 'Sparschwein füllen';

  @override
  String get howToPlayPiggyBody =>
      'Jede geräumte Linie füllt dein Sparschwein. Ist es voll, kannst du die gesammelten Münzen kostenlos abholen.';

  @override
  String get leaderboardTitle => 'Bestenliste';

  @override
  String get leaderboardUnreachable =>
      'Bestenliste nicht erreichbar.\nMit Internet erneut versuchen.';

  @override
  String get leaderboardEmpty => 'Noch keine Einträge.\nSei die/der Erste!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Dein Bestwert ($score) wird eingetragen …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Dein Bestwert wird automatisch eingetragen.';

  @override
  String get puzzleModeTitle => 'Rätsel-Modus';

  @override
  String puzzleLevelTitle(int level) {
    return 'Rätsel $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Züge: $moves   •   Ziel: $target für 3 Sterne';
  }

  @override
  String get puzzleSolved => 'Gelöst!';

  @override
  String get puzzleLeaveTitle => 'Rätsel verlassen?';

  @override
  String get puzzleLeaveBody =>
      'Dein Fortschritt in diesem Rätsel geht verloren.';

  @override
  String get puzzleKeepPlaying => 'Weiterspielen';

  @override
  String get puzzleLeave => 'Verlassen';

  @override
  String get puzzleStuckTitle => 'Festgefahren';

  @override
  String get puzzleRestart => 'Neustart';

  @override
  String get commonActive => 'Aktiv';

  @override
  String get commonTapToActivate => 'Tippen zum Aktivieren';

  @override
  String get commonRestore => 'Wiederherstellen';

  @override
  String unlockForCost(int cost) {
    return '$cost zum Freischalten';
  }

  @override
  String get skinsExchangeGold => 'Gold eintauschen';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Teil drehen';

  @override
  String get puzzleNextLevel => 'Nächstes Level';

  @override
  String get puzzleBackToOverview => 'Zur Übersicht';

  @override
  String get puzzleUnsolvable => 'So lässt sich das Board nicht mehr leeren.';

  @override
  String get puzzleExtraMoveVideo => 'Extra-Zug (Video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved gelöst';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get storageFailureTitle => 'Qubble kann den Spielstand nicht laden';

  @override
  String get storageFailureBody =>
      'Bitte starte die App neu. Bleibt der Fehler, hilft nur eine Neuinstallation — bitte melde das im Playtest.';

  @override
  String get iapUnavailable => 'Dieses Angebot ist gerade nicht verfügbar.';

  @override
  String get iapFailed => 'Der Kauf hat nicht geklappt. Nichts wurde belastet.';

  @override
  String get settingsResetProgress => 'Spielstand zurücksetzen';

  @override
  String get settingsResetProgressSubtitle =>
      'Punkte, Münzen, Level und Fortschritt auf Anfang. Käufe, Name und Kosmetik bleiben erhalten.';

  @override
  String get settingsResetConfirmTitle => 'Spielstand zurücksetzen?';

  @override
  String get settingsResetConfirmBody =>
      'Bestwert, Münzen, Level, Streak und alle Fortschritte werden gelöscht. Das lässt sich nicht rückgängig machen.\n\nDeine Käufe, dein Name und freigeschaltete Themes und Skins bleiben erhalten.';

  @override
  String get settingsResetConfirmAction => 'Zurücksetzen';

  @override
  String get settingsResetDone => 'Spielstand zurückgesetzt.';

  @override
  String get settingsSectionGame => 'Spiel';

  @override
  String get settingsSectionSoundHaptics => 'Ton & Haptik';

  @override
  String get settingsSectionReminders => 'Erinnerungen';

  @override
  String get settingsSectionPurchases => 'Käufe';

  @override
  String get settingsSectionHelpOut => 'Mithelfen';

  @override
  String get settingsSectionLegal => 'Rechtliches';

  @override
  String get settingsSectionLanguage => 'Sprache';

  @override
  String get settingsGuide => 'Spielanleitung';

  @override
  String get settingsGuideSubtitle => 'Regeln, Combos, Fieber & Booster';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsMusic => 'Musik';

  @override
  String get settingsHaptics => 'Vibration';

  @override
  String get settingsHapticsOff => 'Aus';

  @override
  String get settingsHapticsLight => 'Leicht';

  @override
  String get settingsHapticsStrong => 'Stark';

  @override
  String get settingsSectionAccessibility => 'Komfort';

  @override
  String get settingsReducedEffects => 'Reduzierte Effekte';

  @override
  String get settingsReducedEffectsHint =>
      'Weniger Partikel, kein Wackeln, kein Leuchten';

  @override
  String get settingsNotifications => 'Benachrichtigungen';

  @override
  String get settingsNotificationsSubtitle =>
      'Daily-Erinnerung & Streak-Schutz';

  @override
  String get settingsNotificationsSystemHint =>
      'In den System-Einstellungen erlauben.';

  @override
  String get settingsLanguageSystem => 'Systemsprache';

  @override
  String get settingsSupporterThanks => 'Unterstützer — danke! ❤️';

  @override
  String get settingsSupporterPack => 'Unterstützer-Paket';

  @override
  String get settingsSupporterPackSubtitle =>
      'Exklusives Theme & Skin + 1.500 Münzen';

  @override
  String get settingsRestorePurchases => 'Käufe wiederherstellen';

  @override
  String get settingsRestoring => 'Käufe werden wiederhergestellt…';

  @override
  String get settingsRateApp => 'App bewerten';

  @override
  String get settingsRateAppSubtitle => 'Bewertung im Store abgeben';

  @override
  String get settingsStoreUnavailable =>
      'Der Store ist auf diesem Gerät nicht verfügbar.';

  @override
  String get settingsFeedback => 'Feedback geben';

  @override
  String get settingsFeedbackSubtitle => 'Ideen & Fehler melden (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Datenschutzeinstellungen';

  @override
  String get settingsAdPrivacySubtitle =>
      'Werbe-Einwilligung ansehen oder ändern';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Für dieses Gerät sind keine Werbe-Optionen erforderlich.';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsImprint => 'Impressum';

  @override
  String get settingsPageOpenFailed =>
      'Die Seite konnte nicht geöffnet werden.';

  @override
  String get settingsFooter => 'Qubble • Offline Block Puzzle';

  @override
  String get settingsAdminSection => 'Admin (Test)';

  @override
  String get settingsAdminEnabled => '🔧 Admin-Modus aktiviert';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Noch $count× tippen für Admin-Modus';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins Münzen';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Nur zum Testen — nicht in Release-Screenshots zeigen';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount Münzen';
  }

  @override
  String get settingsAdminResetCoins => 'Münzen auf 0 setzen';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Was gefällt dir, was nervt, was fehlt? Auch Kleinigkeiten helfen — je konkreter, desto besser.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Angehängt werden nur $build und dein Gerätetyp — damit ich weiß, welcher Build gemeint ist.';
  }

  @override
  String get feedbackSendByMail => 'Per Mail senden';

  @override
  String get feedbackPreferGithub => 'Lieber als GitHub-Issue';

  @override
  String get feedbackThanksMail => 'Danke! Schick die Nachricht ab.';

  @override
  String get feedbackNoMailApp =>
      'Keine Mail-App gefunden. Probier den GitHub-Weg darunter.';

  @override
  String get feedbackEmptyHint => 'Bitte zuerst etwas eintippen.';

  @override
  String get leaderboardRefresh => 'Aktualisieren';

  @override
  String get leaderboardRetry => 'Erneut versuchen';

  @override
  String get feedbackHint => 'Dein Feedback…';

  @override
  String get feedbackSubmit => 'Feedback senden';

  @override
  String get feedbackOpenFailed =>
      'GitHub ließ sich nicht öffnen. Später erneut versuchen.';

  @override
  String get feedbackGithubNote =>
      'Es öffnet sich GitHub — dort noch auf „Submit new issue\" tippen. (Einmaliger GitHub-Login nötig.)';

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopWebDemoNote =>
      'Käufe gibt es nur in der App aus dem Play Store. Diese Web-Version ist eine kostenlose Demo — spielen kannst du hier trotzdem alles.';

  @override
  String get shopSupporterExplainer =>
      'Qubble zeigt keine erzwungene Werbung — kaufen musst du hier nichts. Das Unterstützer-Paket (Aurora-Theme, Kristall-Skin, 1.500 Münzen, ❤️-Abzeichen) ist ein Dankeschön fürs Unterstützen. Käufe sind an dein Store-Konto gebunden und jederzeit wiederherstellbar.';

  @override
  String get shopSupporterContents =>
      'Aurora-Theme + Kristall-Skin + 1.500 Münzen';

  @override
  String get themesTitle => 'Themes';

  @override
  String get themesSupporterOnly =>
      'Exklusiv im Unterstützer-Paket (siehe Shop) ❤️';

  @override
  String get themesInSupporterPack => 'Im Unterstützer-Paket ❤️';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Nicht genug Münzen (brauchst $cost, hast $coins)';
  }

  @override
  String get skinsTitle => 'Block-Skins';

  @override
  String get skinsNotEnoughDiamonds =>
      'Nicht genug Diamanten (unten Gold eintauschen)';

  @override
  String get skinsNotEnoughCoins => 'Nicht genug Münzen';

  @override
  String get skinsNotEnoughGold => 'Nicht genug Gold.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold Gold = 1 Diamant. Diamanten schalten die edelsten Skins frei — lass dir Zeit beim Sammeln.';
  }

  @override
  String get statsTitle => 'Statistik';

  @override
  String get statsAverageScore => 'Ø Punkte';

  @override
  String get statsBestCombo => 'Größte Combo';

  @override
  String get statsGames => 'Runden';

  @override
  String get statsLinesCleared => 'Reihen geräumt';

  @override
  String get statsPiecesPlaced => 'Teile platziert';

  @override
  String get statsCoins => 'Münzen';

  @override
  String get missionsTitle => 'Missionen';

  @override
  String get missionPlace100 => 'Platziere 100 Teile';

  @override
  String get missionClear50 => 'Räume 50 Reihen ab';

  @override
  String get missionCombo5 => 'Erreiche eine 5er-Combo';

  @override
  String get missionScore1000 => 'Knacke 1000 Punkte in einer Runde';

  @override
  String get missionGames10 => 'Spiele 10 Runden';

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String get achievementFirstGameTitle => 'Erste Runde';

  @override
  String get achievementFirstGameBody => 'Spiele deine erste Runde';

  @override
  String get achievementGames25Title => 'Stammspieler';

  @override
  String get achievementGames25Body => 'Spiele 25 Runden';

  @override
  String get achievementGames100Title => 'Süchtig';

  @override
  String get achievementGames100Body => 'Spiele 100 Runden';

  @override
  String get achievementScore1kTitle => 'Aufsteiger';

  @override
  String get achievementScore1kBody => 'Erreiche 1.000 Punkte';

  @override
  String get achievementScore5kTitle => 'Profi';

  @override
  String get achievementScore5kBody => 'Erreiche 5.000 Punkte';

  @override
  String get achievementScore10kTitle => 'Meister';

  @override
  String get achievementScore10kBody => 'Erreiche 10.000 Punkte';

  @override
  String get achievementScore25kTitle => 'Legende';

  @override
  String get achievementScore25kBody => 'Erreiche 25.000 Punkte';

  @override
  String get achievementLines100Title => 'Aufräumer';

  @override
  String get achievementLines100Body => 'Räume insgesamt 100 Reihen';

  @override
  String get achievementLines1000Title => 'Putzteufel';

  @override
  String get achievementLines1000Body => 'Räume insgesamt 1.000 Reihen';

  @override
  String get achievementCombo5Title => 'Combo-Starter';

  @override
  String get achievementCombo5Body => 'Erreiche eine 5er-Combo';

  @override
  String get achievementCombo10Title => 'Combo-König';

  @override
  String get achievementCombo10Body => 'Erreiche eine 10er-Combo';

  @override
  String get achievementLevel10Title => 'Erfahren';

  @override
  String get achievementLevel10Body => 'Erreiche Level 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Erreiche Level 20';

  @override
  String get achievementStreak7Title => 'Wochenstreak';

  @override
  String get achievementStreak7Body => '7 Tage Daily-Streak';

  @override
  String get achievementStreak30Title => 'Monatsstreak';

  @override
  String get achievementStreak30Body => '30 Tage Daily-Streak';

  @override
  String get achievementPuzzles10Title => 'Knobler';

  @override
  String get achievementPuzzles10Body => 'Löse 10 Rätsel';

  @override
  String get achievementPieces5000Title => 'Baumeister';

  @override
  String get achievementPieces5000Body => 'Platziere 5.000 Teile';

  @override
  String streakRepairTitle(int streak) {
    return '$streak-Tage-Streak in Gefahr!';
  }

  @override
  String get streakRepairBody =>
      'Du hast gestern ausgesetzt — rette deinen Streak:';

  @override
  String get streakRepairFailed => 'Reparatur nicht möglich';

  @override
  String comebackGift(int coins) {
    return 'Willkommen zurück! 🪙 +$coins Münzen';
  }

  @override
  String get notificationsOptInTitle => 'Erinnerungen?';

  @override
  String get notificationsOptInBody =>
      'Sollen wir dich an dein tägliches Puzzle erinnern und deinen Streak schützen? Du kannst das jederzeit in den Einstellungen ändern.';

  @override
  String get notificationsOptInAccept => 'Ja, gerne';

  @override
  String get notificationChannelDescription =>
      'Tägliche Erinnerung, Streak-Warnung, Comeback';

  @override
  String get notificationDailyTitle => 'Dein Puzzle des Tages wartet 🧩';

  @override
  String get notificationDailyBody => 'Spiel die heutige Challenge!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak-Tage-Streak in Gefahr!';
  }

  @override
  String get notificationStreakBody => 'Spiel heute, um ihn zu halten.';

  @override
  String get notificationComebackTitle => 'Dein Puzzle vermisst dich 🧩';

  @override
  String get notificationComebackBody =>
      'Komm zurück und hol dir ein Geschenk!';

  @override
  String get iapSupporterPack => 'Unterstützer-Paket';

  @override
  String get iapCoinsSmall => '500 Münzen';

  @override
  String get iapCoinsMedium => '2000 Münzen';

  @override
  String get iapCoinsLarge => '6000 Münzen';

  @override
  String get iapStarterPack => 'Starter-Paket';

  @override
  String get iapRename => 'Namensänderung';

  @override
  String get iapNeonTheme => 'Neon-Theme';

  @override
  String get settingsLeaderboardDelete => 'Bestenlisten-Eintrag löschen';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Entfernt deinen Namen und Punktestand aus der öffentlichen Liste';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Eintrag löschen?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Dein Name und dein Punktestand werden aus der Bestenliste entfernt. Dein Spielfortschritt bleibt unangetastet. Du kannst dich jederzeit wieder eintragen.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Dein Bestenlisten-Eintrag wurde gelöscht.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Der Eintrag konnte nicht gelöscht werden. Prüfe deine Verbindung und versuch es noch einmal.';

  @override
  String get leaderboardReport => 'Diesen Namen melden';

  @override
  String get leaderboardBlock => 'Blockieren';

  @override
  String leaderboardBlocked(String name) {
    return '$name ist für dich ausgeblendet';
  }

  @override
  String get leaderboardUndo => 'Rückgängig';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge von dir ausgeblendet',
      one: '1 Eintrag von dir ausgeblendet',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Wieder anzeigen';

  @override
  String get leaderboardReportUnavailable => 'Melden ist gerade nicht möglich.';

  @override
  String get leaderboardReportSent => 'Danke — deine Meldung ist unterwegs.';

  @override
  String get leaderboardRules =>
      'Namen sind öffentlich sichtbar. Keine Beleidigungen, keine Schimpfwörter und nichts, was eine echte Person identifiziert. Namen, die dagegen verstoßen, werden entfernt.';

  @override
  String get leaderboardRulesAccept => 'Verstanden';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked von $total freigeschaltet';
  }

  @override
  String get settingsSectionData => 'Spielstand';

  @override
  String get gameRotatePiece => 'Teil drehen';
}
