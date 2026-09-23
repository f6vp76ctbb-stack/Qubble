// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class L10nNl extends L10n {
  L10nNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Spelen';

  @override
  String get commonLater => 'Later';

  @override
  String get commonNotNow => 'Niet nu';

  @override
  String get commonCancel => 'Annuleren';

  @override
  String get commonBuy => 'Kopen';

  @override
  String get commonSave => 'Opslaan';

  @override
  String get commonCollect => 'Ophalen';

  @override
  String get nameNewName => 'Nieuwe naam';

  @override
  String get nameFieldLabel => 'Naam';

  @override
  String get piggyFullTitle => 'Het spaarvarken is vol!';

  @override
  String get piggyKeepSaving => 'Verder sparen';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins van $capacity verzameld.';
  }

  @override
  String get homeContinueRun => 'Verder spelen';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Begrepen';

  @override
  String get commonHome => 'Hoofdmenu';

  @override
  String get commonScore => 'SCORE';

  @override
  String get commonBest => 'RECORD';

  @override
  String commonLevelShort(int level) {
    return 'Level $level';
  }

  @override
  String get homeNewRun => 'Nieuw potje starten';

  @override
  String get homeBackToExit => 'Druk nog een keer op terug om af te sluiten';

  @override
  String get homeEnableLeaderboard => 'Doe mee aan het klassement';

  @override
  String get homeBestScore => 'RECORD';

  @override
  String get homeDailyChallenge => 'Dagelijkse uitdaging';

  @override
  String get homeDailyOpenToday => 'Vandaag nog te spelen';

  @override
  String homeDailyNextIn(String time) {
    return 'Volgende uitdaging over $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Reeks van $streak dagen',
      one: 'Reeks van $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Klassement';

  @override
  String get homePuzzleMode => 'Puzzelmodus';

  @override
  String get homeMissions => 'Missies';

  @override
  String get homeThemes => 'Thema\'s';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Zo speel je Qubble';

  @override
  String get homeWeekendBonus => 'Weekend: dubbele munten!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Level $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Naam wijzigen';

  @override
  String get nameChangeExplainer =>
      'Je naam is je identiteit in het klassement en ligt daarom vast. Je kunt een eenmalige naamswijziging kopen.';

  @override
  String get nameChangeAfterPurchase =>
      'Tik na de aankoop nog eens op je naam om hem te wijzigen.';

  @override
  String get nameJoinedLeaderboard => 'Je staat nu in het klassement.';

  @override
  String get nameRenameUnavailable => 'Naam wijzigen kan nu niet.';

  @override
  String nameProblemTooShort(int min) {
    return 'Minstens $min tekens.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Hoogstens $max tekens.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Alleen letters zonder accenten (A–Z), cijfers, spaties, _ en -.';

  @override
  String get nameProblemOffensive => 'Kies een andere naam.';

  @override
  String get piggyTitle => 'Spaarvarken';

  @override
  String get piggyFillingHint =>
      'Je spaarvarken vult zich terwijl je rijen wegspeelt.';

  @override
  String piggyCollect(int coins) {
    return 'Haal $coins munten op — gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Is het vol, dan kun je het gratis legen — of je opent het nu al met een bonusvideo.';

  @override
  String get piggyOpenNow => 'Nu openen';

  @override
  String get gameNewPiecesVideo => 'Nieuwe blokken (video)';

  @override
  String get gameTapBoardCell => 'Tik op een vakje op het bord';

  @override
  String get gameDailyChallengeLabel => 'DAGELIJKSE UITDAGING';

  @override
  String get gameOver => 'Game over';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Je hebt nog $missing munten nodig voor de bom.';
  }

  @override
  String get gameBombNotHere => 'De bom werkt hier nu niet.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Je hebt nog $missing munten nodig.';
  }

  @override
  String get gameNotRightNow => 'Kan nu niet.';

  @override
  String get gameRunSaved => 'Potje opgeslagen — „Verder spelen” in het menu.';

  @override
  String get gameOverNoFit => 'Geen van je blokken past nog op het bord.';

  @override
  String get gameOverNoFitNoRotations =>
      'Geen van je blokken past — en je draaibeurten zijn op.';

  @override
  String get gameStarterOfferUnavailable => 'Nu niet beschikbaar';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — nu halen';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Prestatie: $title';
  }

  @override
  String get gameBestSubmitted => 'Nieuw record — ingestuurd';

  @override
  String get gameReviveFor => 'Verder spelen · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Vrijgespeeld: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Startpakket';

  @override
  String gameOverPoints(int score) {
    return '$score punten';
  }

  @override
  String get gameNewRecord => 'Nieuw record!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Reeks van $streak dagen',
      one: 'Reeks van $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Munten verdubbelen';

  @override
  String get gameDoubleDaily => 'Dagbeloning verdubbelen';

  @override
  String get gamePlayAgain => 'Opnieuw spelen';

  @override
  String gameLevelReached(int level) {
    return 'Level $level bereikt!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count levels omhoog — level $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 munten + thema Hout';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Nog maar $hours u — eenmalig!';
  }

  @override
  String get boosterUndo => 'Terug';

  @override
  String get boosterSwap => 'Wissel';

  @override
  String get boosterBomb => 'Bom';

  @override
  String get boosterNoRotationsLeft =>
      'Geen draaibeurten meer — speel rijen weg om ze aan te vullen!';

  @override
  String get onboardingDragPiece => 'Sleep een blok naar het raster';

  @override
  String get onboardingFillLine => 'Vul een hele rij of kolom';

  @override
  String get onboardingLinesClear => 'Volle lijnen verdwijnen — punten!';

  @override
  String get coachHintCombo =>
      'Combo! Speel binnen 3 zetten weer een lijn weg om hem te houden';

  @override
  String get coachHintFever => 'KOORTS! Dubbele punten zolang het gloeit';

  @override
  String get coachHintRotation =>
      'Draaien kost een lading — lijnen wegspelen vult hem weer aan';

  @override
  String get coachHintBooster => 'Tip: onderaan kun je boosters gebruiken';

  @override
  String get coachHintStrategy =>
      'Tip: niet elke lijn meteen — houd ruimte voor grote blokken';

  @override
  String get dailyStreakLabel => 'Reeks';

  @override
  String get dailyBestLabel => 'Dagrecord';

  @override
  String dailyHistoryNote(int days) {
    return 'De laatste $days dagen worden bewaard.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '${day}e: gespeeld';
  }

  @override
  String dailyDayMissed(int day) {
    return '${day}e: niet gespeeld';
  }

  @override
  String get homeDailyCalendar => 'Kalender';

  @override
  String get dailyShareButton => 'Resultaat delen';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Dagelijkse uitdaging $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score punten · beste combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Speel: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Combo: nog $moves zetten',
      one: 'Combo: nog $moves zet',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Resultaat gekopieerd naar het klembord';

  @override
  String get adNotAvailable =>
      'Er is nu geen video beschikbaar — probeer het zo nog eens';

  @override
  String get howToPlaySpeedTitle => 'Snelheidsbonus';

  @override
  String get howToPlaySpeedBody =>
      'Snel plaatsen levert tot 30% extra op per weggespeelde lijn. De bonus neemt af tussen 1,5 en 4 seconden en heeft een plafond: snelheid loont, maar beslist het spel niet — een rustig, doordacht potje kan een gehaast potje nog steeds verslaan.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Snelheidsbonus $percent procent';
  }

  @override
  String get iapDiamondsSmall => '100 diamanten';

  @override
  String get iapDiamondsMedium => '350 diamanten';

  @override
  String get iapDiamondsLarge => '1.000 diamanten';

  @override
  String get howToPlayTitle => 'Zo speel je Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Makkelijk om te beginnen.\nVooruitdenken loont.';

  @override
  String get howToPlayIntroBody => 'Houd het bord vrij en verbeter je record.';

  @override
  String get howToPlayIntroSemantics =>
      'Doel van het spel. Houd het bord vrij en verbeter je record.';

  @override
  String get howToPlayDragTitle => 'Slepen & plaatsen';

  @override
  String get howToPlayDragBody =>
      'Sleep een van de drie blokken naar vrije vakjes. Zijn alle drie gebruikt, dan krijg je automatisch drie nieuwe.';

  @override
  String get howToPlayClearTitle => 'Lijnen wegspelen';

  @override
  String get howToPlayClearBody =>
      'Vul een hele rij of kolom. Volle lijnen verdwijnen en maken plaats voor je volgende zet.';

  @override
  String get howToPlayComboTitle => 'Combo\'s rijgen';

  @override
  String get howToPlayComboBody =>
      'Speel binnen drie zetten nog een lijn weg. Elke volgende combo verhoogt je puntenvermenigvuldiger. De combo telt zetten, geen seconden, dus hij loopt nooit af terwijl je nadenkt.';

  @override
  String get howToPlayFeverTitle => 'Koorts ontketenen';

  @override
  String get howToPlayFeverBody =>
      'Lijnen wegspelen vult de koortsmeter. Is die vol, dan telt de volgende grote klapper dubbel — plan je grote zetten vooruit.';

  @override
  String get howToPlayBoosterTitle => 'Boosters slim inzetten';

  @override
  String get howToPlayBoosterBody =>
      'Boosters redden krappe potjes. Je kunt ook op een blok in de lade tikken om het te draaien.';

  @override
  String get howToPlayDailyTitle => 'Dagelijkse uitdaging & reeks';

  @override
  String get howToPlayDailyBody =>
      'De dagelijkse uitdaging gebruikt voor iedereen dezelfde blokken. Speel elke dag om je reeks en je bonus te laten groeien.';

  @override
  String get howToPlayPiggyTitle => 'Vul het spaarvarken';

  @override
  String get howToPlayPiggyBody =>
      'Elke weggespeelde lijn vult je spaarvarken. Is het vol, dan haal je de munten gratis op.';

  @override
  String get leaderboardTitle => 'Klassement';

  @override
  String get leaderboardUnreachable =>
      'Klassement niet beschikbaar.\nProbeer het opnieuw met een internetverbinding.';

  @override
  String get leaderboardEmpty => 'Nog niemand.\nWees de eerste!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Je record ($score) wordt ingestuurd…';
  }

  @override
  String get leaderboardAutoSubmit => 'Je record wordt automatisch ingestuurd.';

  @override
  String get puzzleModeTitle => 'Puzzelmodus';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puzzel $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Zetten: $moves   •   Doel: $target voor 3 sterren';
  }

  @override
  String get puzzleSolved => 'Opgelost!';

  @override
  String get puzzleLeaveTitle => 'Puzzel verlaten?';

  @override
  String get puzzleLeaveBody => 'Je voortgang in deze puzzel gaat verloren.';

  @override
  String get puzzleKeepPlaying => 'Verder spelen';

  @override
  String get puzzleLeave => 'Verlaten';

  @override
  String get puzzleStuckTitle => 'Vast';

  @override
  String get puzzleRestart => 'Opnieuw';

  @override
  String get commonActive => 'Actief';

  @override
  String get commonTapToActivate => 'Tik om te activeren';

  @override
  String get commonRestore => 'Herstellen';

  @override
  String unlockForCost(int cost) {
    return '$cost om vrij te spelen';
  }

  @override
  String get skinsExchangeGold => 'Goud wisselen';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Blok draaien';

  @override
  String get puzzleNextLevel => 'Volgend level';

  @override
  String get puzzleBackToOverview => 'Terug naar het overzicht';

  @override
  String get puzzleUnsolvable => 'Vanaf hier kan het bord niet meer leeg.';

  @override
  String get puzzleExtraMoveVideo => 'Extra zet (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved opgelost';
  }

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get storageFailureTitle => 'Qubble kan je opgeslagen spel niet laden';

  @override
  String get storageFailureBody =>
      'Start de app opnieuw. Blijft de fout, dan helpt alleen opnieuw installeren. Je kunt hem melden via Instellingen › Feedback.';

  @override
  String get iapUnavailable => 'Deze aanbieding is nu niet beschikbaar.';

  @override
  String get iapFailed =>
      'De aankoop is niet gelukt. Er is niets afgeschreven.';

  @override
  String get settingsResetProgress => 'Voortgang resetten';

  @override
  String get settingsResetProgressSubtitle =>
      'Score, munten, level en voortgang terug naar het begin. Aankopen, naam en cosmetica blijven.';

  @override
  String get settingsResetConfirmTitle => 'Voortgang resetten?';

  @override
  String get settingsResetConfirmBody =>
      'Record, munten, level, reeks en alle voortgang worden gewist. Dit kan niet ongedaan worden gemaakt.\n\nJe aankopen, je naam en vrijgespeelde thema\'s en skins blijven behouden.';

  @override
  String get settingsResetConfirmAction => 'Resetten';

  @override
  String get settingsResetDone => 'Voortgang gereset.';

  @override
  String get settingsSectionGame => 'Spel';

  @override
  String get settingsSectionSoundHaptics => 'Geluid & trillen';

  @override
  String get settingsSectionReminders => 'Herinneringen';

  @override
  String get settingsSectionPurchases => 'Aankopen';

  @override
  String get settingsSectionHelpOut => 'Help mee';

  @override
  String get settingsSectionLegal => 'Juridisch';

  @override
  String get settingsSectionLanguage => 'Taal';

  @override
  String get settingsGuide => 'Zo speel je';

  @override
  String get settingsGuideSubtitle => 'Regels, combo\'s, koorts & boosters';

  @override
  String get settingsSound => 'Geluid';

  @override
  String get settingsMusic => 'Muziek';

  @override
  String get settingsHaptics => 'Trillen';

  @override
  String get settingsHapticsOff => 'Uit';

  @override
  String get settingsHapticsLight => 'Licht';

  @override
  String get settingsHapticsStrong => 'Sterk';

  @override
  String get settingsSectionAccessibility => 'Comfort';

  @override
  String get settingsReducedEffects => 'Minder effecten';

  @override
  String get settingsReducedEffectsHint =>
      'Minder deeltjes, geen schudden, geen gloed';

  @override
  String get settingsNotifications => 'Meldingen';

  @override
  String get settingsNotificationsSubtitle =>
      'Dagelijkse herinnering & reeksbescherming';

  @override
  String get settingsNotificationsSystemHint =>
      'Sta ze toe in je systeeminstellingen.';

  @override
  String get settingsLanguageSystem => 'Systeemtaal';

  @override
  String get settingsSupporterThanks => 'Supporter — bedankt!';

  @override
  String get settingsSupporterPack => 'Supporterpakket';

  @override
  String get settingsSupporterPackSubtitle =>
      'Exclusief thema & skin + 1.500 munten';

  @override
  String get settingsRestorePurchases => 'Aankopen herstellen';

  @override
  String get settingsRestoring => 'Aankopen worden hersteld…';

  @override
  String get settingsRateApp => 'App beoordelen';

  @override
  String get settingsRateAppSubtitle =>
      'Laat een beoordeling achter in de winkel';

  @override
  String get settingsStoreUnavailable =>
      'De winkel is niet beschikbaar op dit apparaat.';

  @override
  String get settingsFeedback => 'Feedback geven';

  @override
  String get settingsFeedbackSubtitle => 'Ideeën & bugs melden (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Advertentieprivacy';

  @override
  String get settingsAdPrivacySubtitle =>
      'Je toestemming voor advertenties bekijken of wijzigen';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Op dit apparaat zijn geen advertentie-opties nodig.';

  @override
  String get settingsPrivacy => 'Privacybeleid';

  @override
  String get settingsImprint => 'Colofon';

  @override
  String get settingsPageOpenFailed => 'De pagina kon niet worden geopend.';

  @override
  String get settingsFooter => 'Qubble • Offline blokpuzzel';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Adminmodus ingeschakeld';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Nog $count keer tikken voor de adminmodus';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins munten';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Alleen om te testen — nooit in screenshots van een release';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount munten';
  }

  @override
  String get settingsAdminResetCoins => 'Munten op 0 zetten';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Wat vind je leuk, wat irriteert je, wat mis je? Kleine dingen helpen ook — hoe concreter, hoe beter.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Alleen $build en je apparaattype worden meegestuurd — zodat ik weet over welke versie het gaat.';
  }

  @override
  String get feedbackSendByMail => 'Per e-mail versturen';

  @override
  String get feedbackPreferGithub => 'Liever een GitHub-issue';

  @override
  String get feedbackThanksMail =>
      'Bedankt! Je hoeft het bericht alleen nog te versturen.';

  @override
  String get feedbackNoMailApp =>
      'Geen mail-app gevonden. Probeer de GitHub-route hieronder.';

  @override
  String get feedbackEmptyHint => 'Typ eerst iets.';

  @override
  String get leaderboardRefresh => 'Vernieuwen';

  @override
  String get leaderboardRetry => 'Opnieuw proberen';

  @override
  String get feedbackHint => 'Je feedback…';

  @override
  String get feedbackSubmit => 'Feedback versturen';

  @override
  String get feedbackOpenFailed =>
      'GitHub kon niet worden geopend. Probeer het later opnieuw.';

  @override
  String get feedbackGithubNote =>
      'GitHub wordt geopend — tik daar op \"Submit new issue\". (Eenmalig inloggen bij GitHub is nodig.)';

  @override
  String get shopTitle => 'Winkel';

  @override
  String get shopWebDemoNote =>
      'Aankopen kunnen alleen in de app uit de Play Store. Deze webversie is een gratis demo — je kunt hier toch alles spelen.';

  @override
  String get shopSupporterExplainer =>
      'Qubble toont geen verplichte advertenties — je hoeft nooit iets te kopen. Het supporterpakket (thema Aurora, skin Kristal, 1.500 munten, supportersbadge) is een bedankje voor je steun aan het spel. Aankopen zijn gekoppeld aan je winkelaccount en kunnen altijd worden hersteld.';

  @override
  String get shopSupporterContents =>
      'Thema Aurora + skin Kristal + 1.500 munten';

  @override
  String get themesTitle => 'Thema\'s';

  @override
  String get themesSupporterOnly =>
      'Alleen in het supporterpakket (zie winkel)';

  @override
  String get themesInSupporterPack => 'In het supporterpakket';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Niet genoeg munten (nodig: $cost, je hebt $coins)';
  }

  @override
  String get skinsTitle => 'Blokskins';

  @override
  String get skinsNotEnoughDiamonds =>
      'Niet genoeg diamanten (wissel hieronder goud)';

  @override
  String get skinsNotEnoughCoins => 'Niet genoeg munten';

  @override
  String get skinsNotEnoughGold => 'Niet genoeg goud.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold goud = 1 diamant. Diamanten spelen de mooiste skins vrij — verzamel ze op je gemak.';
  }

  @override
  String get statsTitle => 'Statistieken';

  @override
  String get statsAverageScore => 'Gem. score';

  @override
  String get statsBestCombo => 'Beste combo';

  @override
  String get statsGames => 'Potjes';

  @override
  String get statsLinesCleared => 'Rijen weggespeeld';

  @override
  String get statsPiecesPlaced => 'Blokken geplaatst';

  @override
  String get statsCoins => 'Munten';

  @override
  String get missionsTitle => 'Missies';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Plaats $countString blokken';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Speel $countString rijen weg';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Haal een combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Haal meer dan $countString punten in één potje';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Speel $countString potjes';
  }

  @override
  String get achievementsTitle => 'Prestaties';

  @override
  String get achievementFirstGameTitle => 'Eerste potje';

  @override
  String get achievementFirstGameBody => 'Speel je eerste potje';

  @override
  String get achievementGames25Title => 'Vaste gast';

  @override
  String get achievementGames25Body => 'Speel 25 potjes';

  @override
  String get achievementGames100Title => 'Verslaafd';

  @override
  String get achievementGames100Body => 'Speel 100 potjes';

  @override
  String get achievementScore1kTitle => 'Klimmer';

  @override
  String get achievementScore1kBody => 'Haal 1.000 punten';

  @override
  String get achievementScore5kTitle => 'Prof';

  @override
  String get achievementScore5kBody => 'Haal 5.000 punten';

  @override
  String get achievementScore10kTitle => 'Meester';

  @override
  String get achievementScore10kBody => 'Haal 10.000 punten';

  @override
  String get achievementScore25kTitle => 'Legende';

  @override
  String get achievementScore25kBody => 'Haal 25.000 punten';

  @override
  String get achievementLines100Title => 'Netjes';

  @override
  String get achievementLines100Body => 'Speel in totaal 100 rijen weg';

  @override
  String get achievementLines1000Title => 'Grote schoonmaak';

  @override
  String get achievementLines1000Body => 'Speel in totaal 1.000 rijen weg';

  @override
  String get achievementCombo5Title => 'Combobeginner';

  @override
  String get achievementCombo5Body => 'Haal een combo x5';

  @override
  String get achievementCombo10Title => 'Comboking';

  @override
  String get achievementCombo10Body => 'Haal een combo x10';

  @override
  String get achievementLevel10Title => 'Ervaren';

  @override
  String get achievementLevel10Body => 'Bereik level 10';

  @override
  String get achievementLevel20Title => 'Veteraan';

  @override
  String get achievementLevel20Body => 'Bereik level 20';

  @override
  String get achievementStreak7Title => 'Weekreeks';

  @override
  String get achievementStreak7Body => 'Een dagreeks van 7 dagen';

  @override
  String get achievementStreak30Title => 'Maandreeks';

  @override
  String get achievementStreak30Body => 'Een dagreeks van 30 dagen';

  @override
  String get achievementPuzzles10Title => 'Puzzelaar';

  @override
  String get achievementPuzzles10Body => 'Los 10 puzzels op';

  @override
  String get achievementPieces5000Title => 'Bouwer';

  @override
  String get achievementPieces5000Body => 'Plaats 5.000 blokken';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Je reeks van $streak dagen is in gevaar!',
      one: 'Je reeks van $streak dag is in gevaar!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Gisteren niet gespeeld — red je reeks:';

  @override
  String get streakRepairFailed => 'Herstellen is niet mogelijk.';

  @override
  String comebackGift(int coins) {
    return 'Welkom terug! +$coins munten';
  }

  @override
  String get notificationsOptInTitle => 'Herinneringen?';

  @override
  String get notificationsOptInBody =>
      'Zullen we je herinneren aan je dagelijkse uitdaging en je reeks beschermen? Je kunt dit altijd aanpassen in de instellingen.';

  @override
  String get notificationsOptInAccept => 'Ja, graag';

  @override
  String get notificationChannelDescription =>
      'Dagelijkse herinnering, reekswaarschuwing, terugkeer';

  @override
  String get notificationDailyTitle => 'Je dagpuzzel wacht op je 🧩';

  @override
  String get notificationDailyBody => 'Speel de uitdaging van vandaag!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 Je reeks van $streak dagen is in gevaar!',
      one: '🔥 Je reeks van $streak dag is in gevaar!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Speel vandaag om hem te behouden.';

  @override
  String get notificationComebackTitle => 'Je blokken wachten op je 🧩';

  @override
  String get notificationComebackBody => 'Kom terug en haal een cadeau op!';

  @override
  String get iapSupporterPack => 'Supporterpakket';

  @override
  String get iapCoinsSmall => '500 munten';

  @override
  String get iapCoinsMedium => '2.000 munten';

  @override
  String get iapCoinsLarge => '6.000 munten';

  @override
  String get iapStarterPack => 'Startpakket';

  @override
  String get iapRename => 'Naamswijziging';

  @override
  String get iapNeonTheme => 'Thema Neon';

  @override
  String get settingsLeaderboardDelete => 'Klassementsvermelding verwijderen';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Haalt je naam en score van de openbare lijst';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Je vermelding verwijderen?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Je naam en score worden uit het klassement verwijderd. Je voortgang in het spel blijft gewoon staan. Je kunt altijd opnieuw meedoen aan het klassement.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Je klassementsvermelding is verwijderd.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'De vermelding kon niet worden verwijderd. Controleer je verbinding en probeer het opnieuw.';

  @override
  String get leaderboardReport => 'Deze naam melden';

  @override
  String get leaderboardBlock => 'Blokkeren';

  @override
  String leaderboardBlocked(String name) {
    return '$name is voor jou verborgen';
  }

  @override
  String get leaderboardUndo => 'Ongedaan maken';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vermeldingen door jou verborgen',
      one: '$count vermelding door jou verborgen',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Weer tonen';

  @override
  String get leaderboardReportUnavailable => 'Melden kan nu niet.';

  @override
  String get leaderboardReportSent => 'Bedankt — je melding is onderweg.';

  @override
  String get leaderboardRules =>
      'Namen zijn openbaar. Geen beledigingen, geen scheldwoorden en niets waarmee een echt persoon herkenbaar is. Namen die dit overtreden worden verwijderd.';

  @override
  String get leaderboardRulesAccept => 'Begrepen';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked van $total vrijgespeeld';
  }

  @override
  String get settingsSectionData => 'Opgeslagen gegevens';

  @override
  String get gameRotatePiece => 'Blok draaien';

  @override
  String get themeClassic => 'Klassiek';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Oceaan';

  @override
  String get themeWood => 'Hout';

  @override
  String get themeSunset => 'Zonsondergang';

  @override
  String get themeForest => 'Bos';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klassiek';

  @override
  String get skinGradient => 'Verloop';

  @override
  String get skinOutline => 'Omlijning';

  @override
  String get skinGlossy => 'Glans';

  @override
  String get skinStripe => 'Strepen';

  @override
  String get skinBevel => 'Reliëf';

  @override
  String get skinGlow => 'Gloed';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return 'Thema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skin $name';
  }
}
