// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class L10nSv extends L10n {
  L10nSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Spela';

  @override
  String get commonLater => 'Senare';

  @override
  String get commonNotNow => 'Inte nu';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonBuy => 'Köp';

  @override
  String get commonSave => 'Spara';

  @override
  String get commonCollect => 'Hämta';

  @override
  String get nameNewName => 'Nytt namn';

  @override
  String get nameFieldLabel => 'Namn';

  @override
  String get piggyFullTitle => 'Spargrisen är full!';

  @override
  String get piggyKeepSaving => 'Fortsätt spara';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins av $capacity insamlade.';
  }

  @override
  String get homeContinueRun => 'Fortsätt';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Uppfattat';

  @override
  String get commonHome => 'Hem';

  @override
  String get commonScore => 'POÄNG';

  @override
  String get commonBest => 'BÄSTA';

  @override
  String commonLevelShort(int level) {
    return 'Nivå $level';
  }

  @override
  String get homeNewRun => 'Starta en ny omgång';

  @override
  String get homeBackToExit => 'Tryck bakåt igen för att avsluta';

  @override
  String get homeEnableLeaderboard => 'Gå med i topplistan';

  @override
  String get homeBestScore => 'BÄSTA POÄNG';

  @override
  String get homeDailyChallenge => 'Daglig utmaning';

  @override
  String get homeDailyOpenToday => 'Öppen i dag';

  @override
  String homeDailyNextIn(String time) {
    return 'Nästa utmaning om $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Svit: $streak dagar',
      one: 'Svit: $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Topplista';

  @override
  String get homePuzzleMode => 'Pusselläge';

  @override
  String get homeMissions => 'Uppdrag';

  @override
  String get homeThemes => 'Teman';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Så spelar du Qubble';

  @override
  String get homeWeekendBonus => 'Helg: dubbla mynt!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Nivå $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Byt namn';

  @override
  String get nameChangeExplainer =>
      'Ditt namn är din identitet på topplistan, så det är låst. Du kan köpa ett namnbyte en gång.';

  @override
  String get nameChangeAfterPurchase =>
      'Efter köpet trycker du på ditt namn igen för att byta det.';

  @override
  String get nameJoinedLeaderboard => 'Nu är du med på topplistan.';

  @override
  String get nameRenameUnavailable => 'Det går inte att byta namn just nu.';

  @override
  String nameProblemTooShort(int min) {
    return 'Minst $min tecken.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Högst $max tecken.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Endast bokstäver utan å, ä och ö (A–Z), siffror, mellanslag, _ och -.';

  @override
  String get nameProblemOffensive => 'Välj ett annat namn.';

  @override
  String get piggyTitle => 'Spargris';

  @override
  String get piggyFillingHint => 'Spargrisen fylls på medan du rensar rader.';

  @override
  String piggyCollect(int coins) {
    return 'Hämta $coins mynt – gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'När den är full kan du tömma den gratis – eller öppna den tidigare med en bonusvideo.';

  @override
  String get piggyOpenNow => 'Öppna nu';

  @override
  String get gameNewPiecesVideo => 'Nya bitar (video)';

  @override
  String get gameTapBoardCell => 'Tryck på en ruta på brädet';

  @override
  String get gameDailyChallengeLabel => 'DAGLIG UTMANING';

  @override
  String get gameOver => 'Spelet är slut';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Du behöver $missing mynt till för bomben.';
  }

  @override
  String get gameBombNotHere => 'Bomben fungerar inte här just nu.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Du behöver $missing mynt till för det.';
  }

  @override
  String get gameNotRightNow => 'Det går inte just nu.';

  @override
  String get gameRunSaved => 'Omgången är sparad – ”Fortsätt” i menyn.';

  @override
  String get gameOverNoFit => 'Ingen av dina bitar får plats på brädet längre.';

  @override
  String get gameOverNoFitNoRotations =>
      'Ingen av dina bitar får plats – och vridningarna är slut.';

  @override
  String get gameStarterOfferUnavailable => 'Inte tillgängligt just nu';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price – hämta';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Prestation: $title';
  }

  @override
  String get gameBestSubmitted => 'Nytt rekord – inskickat';

  @override
  String get gameReviveFor => 'Fortsätt spela · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Upplåst: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Startpaket';

  @override
  String gameOverPoints(int score) {
    return '$score poäng';
  }

  @override
  String get gameNewRecord => 'Nytt rekord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Svit: $streak dagar',
      one: 'Svit: $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Dubbla mynt';

  @override
  String get gameDoubleDaily => 'Dubbel daglig belöning';

  @override
  String get gamePlayAgain => 'Spela igen';

  @override
  String gameLevelReached(int level) {
    return 'Nivå $level uppnådd!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nivåer upp – nivå $level!',
      one: '$count nivå upp – nivå $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 mynt + temat Trä';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Bara $hours h kvar – en enda gång!';
  }

  @override
  String get boosterUndo => 'Ångra';

  @override
  String get boosterSwap => 'Byt';

  @override
  String get boosterBomb => 'Bomb';

  @override
  String get boosterNoRotationsLeft =>
      'Inga vridningar kvar – rensa rader för att ladda om!';

  @override
  String get onboardingDragPiece => 'Dra en bit till rutnätet';

  @override
  String get onboardingFillLine => 'Fyll en hel rad eller kolumn';

  @override
  String get onboardingLinesClear => 'Fulla rader försvinner – poäng!';

  @override
  String get coachHintCombo =>
      'Kombo! Rensa igen inom 3 drag för att behålla den';

  @override
  String get coachHintFever => 'FEBER! Dubbla poäng medan det lyser';

  @override
  String get coachHintRotation =>
      'Att vrida kostar en laddning – rensningar fyller på';

  @override
  String get coachHintBooster => 'Tips: längst ner finns boosters';

  @override
  String get coachHintStrategy =>
      'Tips: inte alla rader på en gång – spara plats åt stora bitar';

  @override
  String get dailyStreakLabel => 'Svit';

  @override
  String get dailyBestLabel => 'Dagens bästa';

  @override
  String dailyHistoryNote(int days) {
    return 'De senaste $days dagarna sparas.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: spelad';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: inte spelad';
  }

  @override
  String get homeDailyCalendar => 'Kalender';

  @override
  String get dailyShareButton => 'Dela resultat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Daglig utmaning $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score poäng · bästa kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Spela: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: $moves drag kvar';
  }

  @override
  String get dailyShareCopied => 'Resultatet har kopierats till urklipp';

  @override
  String get adNotAvailable =>
      'Ingen video tillgänglig just nu – försök igen om en stund';

  @override
  String get howToPlaySpeedTitle => 'Hastighetsbonus';

  @override
  String get howToPlaySpeedBody =>
      'Snabba placeringar ger upp till 30 % extra för en rensning. Bonusen avtar mellan 1,5 och 4 sekunder och har ett tak, så snabbhet lönar sig utan att avgöra spelet – en noggrann, långsam omgång kan fortfarande slå en hastig.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Hastighetsbonus $percent procent';
  }

  @override
  String get iapDiamondsSmall => '100 diamanter';

  @override
  String get iapDiamondsMedium => '350 diamanter';

  @override
  String get iapDiamondsLarge => '1 000 diamanter';

  @override
  String get howToPlayTitle => 'Så spelar du Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Lätt att börja.\nBelönar framförhållning.';

  @override
  String get howToPlayIntroBody => 'Håll brädet fritt och slå ditt rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Spelets mål. Håll brädet fritt och slå ditt rekord.';

  @override
  String get howToPlayDragTitle => 'Dra och släpp';

  @override
  String get howToPlayDragBody =>
      'Dra en av de tre bitarna till lediga rutor. När alla tre är använda får du automatiskt tre nya.';

  @override
  String get howToPlayClearTitle => 'Rensa rader';

  @override
  String get howToPlayClearBody =>
      'Fyll en hel rad eller kolumn. Fulla rader försvinner och ger plats åt ditt nästa drag.';

  @override
  String get howToPlayComboTitle => 'Kedja kombos';

  @override
  String get howToPlayComboBody =>
      'Rensa en rad till inom tre drag. Varje ytterligare kombo höjer din poängmultiplikator. Kombon räknar drag, inte sekunder, så den tar aldrig slut medan du tänker.';

  @override
  String get howToPlayFeverTitle => 'Tänd febern';

  @override
  String get howToPlayFeverBody =>
      'Rensningar fyller febermätaren. När den är full räknas nästa smäll dubbelt – planera stora rensningar i förväg.';

  @override
  String get howToPlayBoosterTitle => 'Använd boosters klokt';

  @override
  String get howToPlayBoosterBody =>
      'Boosters räddar trånga omgångar. Du kan också trycka på en bit i facket för att vrida den.';

  @override
  String get howToPlayDailyTitle => 'Daglig utmaning och svit';

  @override
  String get howToPlayDailyBody =>
      'Den dagliga utmaningen har samma bitar för alla. Spela varje dag för att bygga din svit och din bonus.';

  @override
  String get howToPlayPiggyTitle => 'Fyll spargrisen';

  @override
  String get howToPlayPiggyBody =>
      'Varje rensad rad fyller din spargris. När den är full kan du hämta mynten gratis.';

  @override
  String get leaderboardTitle => 'Topplista';

  @override
  String get leaderboardUnreachable =>
      'Topplistan är inte tillgänglig.\nFörsök igen med internetanslutning.';

  @override
  String get leaderboardEmpty => 'Inga poster än.\nBli först!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Ditt bästa resultat ($score) skickas in …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Ditt bästa resultat skickas in automatiskt.';

  @override
  String get puzzleModeTitle => 'Pusselläge';

  @override
  String puzzleLevelTitle(int level) {
    return 'Pussel $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Drag: $moves   •   Mål: $target för 3 stjärnor';
  }

  @override
  String get puzzleSolved => 'Löst!';

  @override
  String get puzzleLeaveTitle => 'Lämna pusslet?';

  @override
  String get puzzleLeaveBody =>
      'Dina framsteg i det här pusslet går förlorade.';

  @override
  String get puzzleKeepPlaying => 'Fortsätt spela';

  @override
  String get puzzleLeave => 'Lämna';

  @override
  String get puzzleStuckTitle => 'Fast';

  @override
  String get puzzleRestart => 'Börja om';

  @override
  String get commonActive => 'Aktiv';

  @override
  String get commonTapToActivate => 'Tryck för att aktivera';

  @override
  String get commonRestore => 'Återställ';

  @override
  String unlockForCost(int cost) {
    return '$cost för att låsa upp';
  }

  @override
  String get skinsExchangeGold => 'Växla guld';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Vrid bit';

  @override
  String get puzzleNextLevel => 'Nästa nivå';

  @override
  String get puzzleBackToOverview => 'Tillbaka till översikten';

  @override
  String get puzzleUnsolvable => 'Brädet går inte att tömma härifrån längre.';

  @override
  String get puzzleExtraMoveVideo => 'Extra drag (video)';

  @override
  String puzzleSolvedCount(int solved) {
    String _temp0 = intl.Intl.pluralLogic(
      solved,
      locale: localeName,
      other: '$solved lösta',
      one: '$solved löst',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get storageFailureTitle => 'Qubble kan inte läsa in ditt sparade spel';

  @override
  String get storageFailureBody =>
      'Starta om appen. Om felet kvarstår hjälper bara en ominstallation. Du kan rapportera det under Inställningar › Feedback.';

  @override
  String get iapUnavailable => 'Erbjudandet är inte tillgängligt just nu.';

  @override
  String get iapFailed => 'Köpet gick inte igenom. Inget har debiterats.';

  @override
  String get settingsResetProgress => 'Återställ framsteg';

  @override
  String get settingsResetProgressSubtitle =>
      'Poäng, mynt, nivå och framsteg tillbaka till start. Köp, namn och kosmetika behålls.';

  @override
  String get settingsResetConfirmTitle => 'Återställa framstegen?';

  @override
  String get settingsResetConfirmBody =>
      'Bästa poäng, mynt, nivå, svit och alla framsteg raderas. Det går inte att ångra.\n\nDina köp, ditt namn och upplåsta teman och skins behålls.';

  @override
  String get settingsResetConfirmAction => 'Återställ';

  @override
  String get settingsResetDone => 'Framstegen har återställts.';

  @override
  String get settingsSectionGame => 'Spel';

  @override
  String get settingsSectionSoundHaptics => 'Ljud och vibration';

  @override
  String get settingsSectionReminders => 'Påminnelser';

  @override
  String get settingsSectionPurchases => 'Köp';

  @override
  String get settingsSectionHelpOut => 'Hjälp till';

  @override
  String get settingsSectionLegal => 'Juridiskt';

  @override
  String get settingsSectionLanguage => 'Språk';

  @override
  String get settingsGuide => 'Så spelar du';

  @override
  String get settingsGuideSubtitle => 'Regler, kombos, feber och boosters';

  @override
  String get settingsSound => 'Ljud';

  @override
  String get settingsMusic => 'Musik';

  @override
  String get settingsHaptics => 'Vibration';

  @override
  String get settingsHapticsOff => 'Av';

  @override
  String get settingsHapticsLight => 'Lätt';

  @override
  String get settingsHapticsStrong => 'Stark';

  @override
  String get settingsSectionAccessibility => 'Komfort';

  @override
  String get settingsReducedEffects => 'Färre effekter';

  @override
  String get settingsReducedEffectsHint =>
      'Färre partiklar, ingen skärmskakning, inget sken';

  @override
  String get settingsNotifications => 'Aviseringar';

  @override
  String get settingsNotificationsSubtitle => 'Daglig påminnelse och svitskydd';

  @override
  String get settingsNotificationsSystemHint =>
      'Tillåt det i systeminställningarna.';

  @override
  String get settingsLanguageSystem => 'Systemspråk';

  @override
  String get settingsSupporterThanks => 'Supporter – tack!';

  @override
  String get settingsSupporterPack => 'Supporterpaket';

  @override
  String get settingsSupporterPackSubtitle =>
      'Exklusivt tema och skin + 1 500 mynt';

  @override
  String get settingsRestorePurchases => 'Återställ köp';

  @override
  String get settingsRestoring => 'Återställer köp …';

  @override
  String get settingsRateApp => 'Betygsätt appen';

  @override
  String get settingsRateAppSubtitle => 'Lämna ett betyg i butiken';

  @override
  String get settingsStoreUnavailable =>
      'Butiken är inte tillgänglig på den här enheten.';

  @override
  String get settingsFeedback => 'Skicka feedback';

  @override
  String get settingsFeedbackSubtitle =>
      'Rapportera idéer och buggar (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Annonsinställningar för integritet';

  @override
  String get settingsAdPrivacySubtitle =>
      'Visa eller ändra ditt annonssamtycke';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Inga annonsval behövs på den här enheten.';

  @override
  String get settingsPrivacy => 'Integritetspolicy';

  @override
  String get settingsImprint => 'Utgivaruppgifter';

  @override
  String get settingsPageOpenFailed => 'Sidan kunde inte öppnas.';

  @override
  String get settingsFooter => 'Qubble • Offline blockpussel';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Adminläge aktiverat';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tryck $count gånger till för adminläge',
      one: 'Tryck $count gång till för adminläge',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins mynt';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Endast för test – visa aldrig i skärmbilder för release';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount mynt';
  }

  @override
  String get settingsAdminResetCoins => 'Sätt mynt till 0';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Vad gillar du, vad stör dig, vad saknas? Små saker hjälper också – ju konkretare, desto bättre.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Bara $build och din enhetstyp bifogas – så att jag vet vilken version du menar.';
  }

  @override
  String get feedbackSendByMail => 'Skicka via e-post';

  @override
  String get feedbackPreferGithub => 'Hellre ett GitHub-ärende';

  @override
  String get feedbackThanksMail => 'Tack! Skicka bara meddelandet.';

  @override
  String get feedbackNoMailApp =>
      'Ingen e-postapp hittades. Prova GitHub-vägen nedan.';

  @override
  String get feedbackEmptyHint => 'Skriv något först.';

  @override
  String get leaderboardRefresh => 'Uppdatera';

  @override
  String get leaderboardRetry => 'Försök igen';

  @override
  String get feedbackHint => 'Din feedback …';

  @override
  String get feedbackSubmit => 'Skicka feedback';

  @override
  String get feedbackOpenFailed =>
      'GitHub kunde inte öppnas. Försök igen senare.';

  @override
  String get feedbackGithubNote =>
      'GitHub öppnas – tryck där på ”Submit new issue”. (En engångsinloggning på GitHub krävs.)';

  @override
  String get shopTitle => 'Butik';

  @override
  String get shopWebDemoNote =>
      'Köp finns bara i appen från Play Butik. Den här webbversionen är en gratis demo – du kan ändå spela allt här.';

  @override
  String get shopSupporterExplainer =>
      'Qubble visar ingen påtvingad reklam – du behöver aldrig köpa något. Supporterpaketet (temat Aurora, skinnet Kristall, 1 500 mynt, supportermärke) är ett tack för att du stöder spelet. Köp är kopplade till ditt butikskonto och kan återställas när som helst.';

  @override
  String get shopSupporterContents =>
      'Temat Aurora + skinnet Kristall + 1 500 mynt';

  @override
  String get themesTitle => 'Teman';

  @override
  String get themesSupporterOnly =>
      'Exklusivt för supporterpaketet (se butiken)';

  @override
  String get themesInSupporterPack => 'I supporterpaketet';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Inte tillräckligt med mynt (behöver $cost, har $coins)';
  }

  @override
  String get skinsTitle => 'Blockskins';

  @override
  String get skinsNotEnoughDiamonds =>
      'Inte tillräckligt med diamanter (växla guld nedan)';

  @override
  String get skinsNotEnoughCoins => 'Inte tillräckligt med mynt';

  @override
  String get skinsNotEnoughGold => 'Inte tillräckligt med guld.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold guld = 1 diamant. Diamanter låser upp de finaste skinsen – ta god tid på dig att samla.';
  }

  @override
  String get statsTitle => 'Statistik';

  @override
  String get statsAverageScore => 'Snittpoäng';

  @override
  String get statsBestCombo => 'Bästa kombo';

  @override
  String get statsGames => 'Omgångar';

  @override
  String get statsLinesCleared => 'Rensade rader';

  @override
  String get statsPiecesPlaced => 'Placerade bitar';

  @override
  String get statsCoins => 'Mynt';

  @override
  String get missionsTitle => 'Uppdrag';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Placera $countString bitar';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Rensa $countString rader';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Nå en ${countString}x-kombo';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Få $countString poäng i en omgång';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Spela $countString omgångar';
  }

  @override
  String get achievementsTitle => 'Prestationer';

  @override
  String get achievementFirstGameTitle => 'Första omgången';

  @override
  String get achievementFirstGameBody => 'Spela din första omgång';

  @override
  String get achievementGames25Title => 'Stamgäst';

  @override
  String get achievementGames25Body => 'Spela 25 omgångar';

  @override
  String get achievementGames100Title => 'Fast i spelet';

  @override
  String get achievementGames100Body => 'Spela 100 omgångar';

  @override
  String get achievementScore1kTitle => 'Klättrare';

  @override
  String get achievementScore1kBody => 'Nå 1 000 poäng';

  @override
  String get achievementScore5kTitle => 'Proffs';

  @override
  String get achievementScore5kBody => 'Nå 5 000 poäng';

  @override
  String get achievementScore10kTitle => 'Mästare';

  @override
  String get achievementScore10kBody => 'Nå 10 000 poäng';

  @override
  String get achievementScore25kTitle => 'Legend';

  @override
  String get achievementScore25kBody => 'Nå 25 000 poäng';

  @override
  String get achievementLines100Title => 'Ordningsam';

  @override
  String get achievementLines100Body => 'Rensa totalt 100 rader';

  @override
  String get achievementLines1000Title => 'Storstädare';

  @override
  String get achievementLines1000Body => 'Rensa totalt 1 000 rader';

  @override
  String get achievementCombo5Title => 'Kombonybörjare';

  @override
  String get achievementCombo5Body => 'Nå en 5x-kombo';

  @override
  String get achievementCombo10Title => 'Kombokung';

  @override
  String get achievementCombo10Body => 'Nå en 10x-kombo';

  @override
  String get achievementLevel10Title => 'Erfaren';

  @override
  String get achievementLevel10Body => 'Nå nivå 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Nå nivå 20';

  @override
  String get achievementStreak7Title => 'Veckosvit';

  @override
  String get achievementStreak7Body => 'En daglig svit på 7 dagar';

  @override
  String get achievementStreak30Title => 'Månadssvit';

  @override
  String get achievementStreak30Body => 'En daglig svit på 30 dagar';

  @override
  String get achievementPuzzles10Title => 'Pusslare';

  @override
  String get achievementPuzzles10Body => 'Lös 10 pussel';

  @override
  String get achievementPieces5000Title => 'Byggare';

  @override
  String get achievementPieces5000Body => 'Placera 5 000 bitar';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Din svit på $streak dagar är i fara!',
      one: 'Din svit på $streak dag är i fara!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Du missade i går – rädda din svit:';

  @override
  String get streakRepairFailed => 'Det går inte att reparera.';

  @override
  String comebackGift(int coins) {
    return 'Välkommen tillbaka! +$coins mynt';
  }

  @override
  String get notificationsOptInTitle => 'Påminnelser?';

  @override
  String get notificationsOptInBody =>
      'Ska vi påminna dig om ditt dagliga pussel och skydda din svit? Du kan ändra det när som helst i inställningarna.';

  @override
  String get notificationsOptInAccept => 'Ja, tack';

  @override
  String get notificationChannelDescription =>
      'Daglig påminnelse, svitvarning, återkomst';

  @override
  String get notificationDailyTitle => 'Ditt dagliga pussel väntar 🧩';

  @override
  String get notificationDailyBody => 'Spela dagens utmaning!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Din svit på $streak dagar är i fara!',
      one: 'Din svit på $streak dag är i fara!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'Spela i dag för att hålla den vid liv.';

  @override
  String get notificationComebackTitle => 'Ditt pussel saknar dig 🧩';

  @override
  String get notificationComebackBody => 'Kom tillbaka och hämta en gåva!';

  @override
  String get iapSupporterPack => 'Supporterpaket';

  @override
  String get iapCoinsSmall => '500 mynt';

  @override
  String get iapCoinsMedium => '2 000 mynt';

  @override
  String get iapCoinsLarge => '6 000 mynt';

  @override
  String get iapStarterPack => 'Startpaket';

  @override
  String get iapRename => 'Namnbyte';

  @override
  String get iapNeonTheme => 'Temat Neon';

  @override
  String get settingsLeaderboardDelete => 'Radera topplistepost';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Tar bort ditt namn och din poäng från den offentliga listan';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Radera din post?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Ditt namn och din poäng tas bort från topplistan. Dina framsteg i spelet påverkas inte. Du kan gå med i topplistan igen när som helst.';

  @override
  String get settingsLeaderboardDeleteDone => 'Din topplistepost har raderats.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Posten kunde inte raderas. Kontrollera anslutningen och försök igen.';

  @override
  String get leaderboardReport => 'Anmäl det här namnet';

  @override
  String get leaderboardBlock => 'Blockera';

  @override
  String leaderboardBlocked(String name) {
    return '$name är dold för dig';
  }

  @override
  String get leaderboardUndo => 'Ångra';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poster dolda av dig',
      one: '$count post dold av dig',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Visa igen';

  @override
  String get leaderboardReportUnavailable => 'Det går inte att anmäla just nu.';

  @override
  String get leaderboardReportSent => 'Tack – din anmälan är på väg.';

  @override
  String get leaderboardRules =>
      'Namn är offentliga. Inga förolämpningar, inga skällsord och inget som identifierar en verklig person. Namn som bryter mot detta tas bort.';

  @override
  String get leaderboardRulesAccept => 'Jag förstår';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked av $total upplåsta';
  }

  @override
  String get settingsSectionData => 'Sparade data';

  @override
  String get gameRotatePiece => 'Vrid bit';

  @override
  String get themeClassic => 'Klassisk';

  @override
  String get themeFade => 'Pastell';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Hav';

  @override
  String get themeWood => 'Trä';

  @override
  String get themeSunset => 'Solnedgång';

  @override
  String get themeForest => 'Skog';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klassisk';

  @override
  String get skinGradient => 'Gradient';

  @override
  String get skinOutline => 'Kontur';

  @override
  String get skinGlossy => 'Blank';

  @override
  String get skinStripe => 'Ränder';

  @override
  String get skinBevel => 'Fasad';

  @override
  String get skinGlow => 'Glöd';

  @override
  String get skinCrystal => 'Kristall';

  @override
  String rewardThemeName(String name) {
    return 'Temat $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skinnet $name';
  }
}
