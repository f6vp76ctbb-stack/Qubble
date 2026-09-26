// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class L10nNb extends L10n {
  L10nNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Spill';

  @override
  String get commonLater => 'Senere';

  @override
  String get commonNotNow => 'Ikke nå';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonBuy => 'Kjøp';

  @override
  String get commonSave => 'Lagre';

  @override
  String get commonCollect => 'Hent';

  @override
  String get nameNewName => 'Nytt navn';

  @override
  String get nameFieldLabel => 'Navn';

  @override
  String get piggyFullTitle => 'Sparegrisen er full!';

  @override
  String get piggyKeepSaving => 'Fortsett å spare';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins av $capacity samlet.';
  }

  @override
  String get homeContinueRun => 'Fortsett';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Skjønner';

  @override
  String get commonHome => 'Hjem';

  @override
  String get commonScore => 'POENG';

  @override
  String get commonBest => 'BESTE';

  @override
  String commonLevelShort(int level) {
    return 'Nivå $level';
  }

  @override
  String get homeNewRun => 'Start et nytt spill';

  @override
  String get homeBackToExit => 'Trykk tilbake igjen for å avslutte';

  @override
  String get homeEnableLeaderboard => 'Bli med på topplisten';

  @override
  String get homeBestScore => 'BESTE POENGSUM';

  @override
  String get homeDailyChallenge => 'Daglig utfordring';

  @override
  String get homeDailyOpenToday => 'Åpen i dag';

  @override
  String homeDailyNextIn(String time) {
    return 'Neste utfordring om $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Serie: $streak dager',
      one: 'Serie: $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Toppliste';

  @override
  String get homePuzzleMode => 'Puslemodus';

  @override
  String get homeMissions => 'Oppdrag';

  @override
  String get homeThemes => 'Temaer';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Slik spiller du Qubble';

  @override
  String get homeWeekendBonus => 'Helg: doble mynter!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Nivå $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Bytt navn';

  @override
  String get nameChangeExplainer =>
      'Navnet ditt er identiteten din på topplisten, så det ligger fast. Du kan kjøpe ett navnebytte.';

  @override
  String get nameChangeAfterPurchase =>
      'Trykk på navnet ditt igjen etter kjøpet for å bytte det.';

  @override
  String get nameJoinedLeaderboard => 'Nå er du på topplisten.';

  @override
  String get nameRenameUnavailable => 'Det går ikke å bytte navn akkurat nå.';

  @override
  String nameProblemTooShort(int min) {
    return 'Minst $min tegn.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Maks $max tegn.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Bare bokstaver uten æ, ø og å (A–Z), tall, mellomrom, _ og -.';

  @override
  String get nameProblemOffensive => 'Velg et annet navn.';

  @override
  String get piggyTitle => 'Sparegris';

  @override
  String get piggyFillingHint => 'Sparegrisen fylles mens du rydder rader.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mynter',
      one: '$coins mynt',
    );
    return 'Hent $_temp0 – gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Når den er full, kan du tømme den gratis – eller åpne den tidligere med en bonusvideo.';

  @override
  String get piggyOpenNow => 'Åpne nå';

  @override
  String get gameNewPiecesVideo => 'Nye brikker (video)';

  @override
  String get gameTapBoardCell => 'Trykk på en rute på brettet';

  @override
  String get gameDailyChallengeLabel => 'DAGLIG UTFORDRING';

  @override
  String get gameOver => 'Spillet er over';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Du mangler mynter til bomben: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomben virker ikke her akkurat nå.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Du mangler mynter: $missing.';
  }

  @override
  String get gameNotRightNow => 'Det går ikke akkurat nå.';

  @override
  String get gameRunSaved => 'Spillet er lagret – «Fortsett» i menyen.';

  @override
  String get gameOverNoFit =>
      'Ingen av brikkene dine får plass på brettet lenger.';

  @override
  String get gameOverNoFitNoRotations =>
      'Ingen av brikkene dine får plass – og rotasjonene er brukt opp.';

  @override
  String get gameStarterOfferUnavailable => 'Ikke tilgjengelig nå';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price – hent den';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Prestasjon: $title';
  }

  @override
  String get gameBestSubmitted => 'Ny rekord – sendt inn';

  @override
  String get gameReviveFor => 'Spill videre · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Låst opp: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Startpakke';

  @override
  String gameOverPoints(int score) {
    return '$score poeng';
  }

  @override
  String get gameNewRecord => 'Ny rekord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Serie: $streak dager',
      one: 'Serie: $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Doble mynter';

  @override
  String get gameDoubleDaily => 'Dobbel daglig belønning';

  @override
  String get gamePlayAgain => 'Spill igjen';

  @override
  String gameLevelReached(int level) {
    return 'Nivå $level nådd!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nivåer opp – nivå $level!',
      one: '$count nivå opp – nivå $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 mynter + temaet Tre';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Bare $hours timer igjen – kun én gang!',
      one: 'Bare $hours time igjen – kun én gang!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Angre';

  @override
  String get boosterSwap => 'Bytt';

  @override
  String get boosterBomb => 'Bombe';

  @override
  String get boosterNoRotationsLeft =>
      'Ingen rotasjoner igjen – rydd rader for å lade opp!';

  @override
  String get onboardingDragPiece => 'Dra en brikke inn på rutenettet';

  @override
  String get onboardingFillLine => 'Fyll en hel rad eller kolonne';

  @override
  String get onboardingLinesClear => 'Fulle rader forsvinner – poeng!';

  @override
  String get coachHintCombo =>
      'Kombo! Rydd igjen innen 3 trekk for å beholde den';

  @override
  String get coachHintFever => 'FEBER! Doble poeng mens det lyser';

  @override
  String get coachHintRotation =>
      'Å rotere koster en ladning – rydding fyller på';

  @override
  String get coachHintBooster => 'Tips: nederst finner du boostere';

  @override
  String get coachHintStrategy =>
      'Tips: ikke alle rader på en gang – spar plass til store brikker';

  @override
  String get dailyStreakLabel => 'Serie';

  @override
  String get dailyBestLabel => 'Dagens beste';

  @override
  String dailyHistoryNote(int days) {
    return 'De siste $days dagene lagres.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: spilt';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: ikke spilt';
  }

  @override
  String get homeDailyCalendar => 'Kalender';

  @override
  String get dailyShareButton => 'Del resultat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Daglig utfordring $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score poeng · beste kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Spill: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: $moves trekk igjen';
  }

  @override
  String get dailyShareCopied => 'Resultatet er kopiert til utklippstavlen';

  @override
  String get adNotAvailable =>
      'Ingen video tilgjengelig nå – prøv igjen om litt';

  @override
  String get howToPlaySpeedTitle => 'Fartsbonus';

  @override
  String get howToPlaySpeedBody =>
      'Raske plasseringer gir opptil 30 % ekstra for en rydding. Bonusen avtar mellom 1,5 og 4 sekunder og har et tak, så fart lønner seg uten å avgjøre spillet – et nøye, rolig spill kan fortsatt slå et forhastet.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Fartsbonus $percent prosent';
  }

  @override
  String get iapDiamondsSmall => '100 diamanter';

  @override
  String get iapDiamondsMedium => '350 diamanter';

  @override
  String get iapDiamondsLarge => '1 000 diamanter';

  @override
  String get howToPlayTitle => 'Slik spiller du Qubble';

  @override
  String get howToPlayIntroHeadline => 'Lett å begynne.\nBelønner planlegging.';

  @override
  String get howToPlayIntroBody => 'Hold brettet ledig og slå rekorden din.';

  @override
  String get howToPlayIntroSemantics =>
      'Målet med spillet. Hold brettet ledig og slå rekorden din.';

  @override
  String get howToPlayDragTitle => 'Dra og slipp';

  @override
  String get howToPlayDragBody =>
      'Dra en av de tre brikkene til ledige ruter. Når alle tre er brukt, får du automatisk tre nye.';

  @override
  String get howToPlayClearTitle => 'Rydd rader';

  @override
  String get howToPlayClearBody =>
      'Fyll en hel rad eller kolonne. Fulle rader forsvinner og gir plass til neste trekk.';

  @override
  String get howToPlayComboTitle => 'Lag kombokjeder';

  @override
  String get howToPlayComboBody =>
      'Rydd en rad til innen tre trekk. Hver nye kombo øker poengmultiplikatoren. Komboen teller trekk, ikke sekunder, så den renner aldri ut mens du tenker.';

  @override
  String get howToPlayFeverTitle => 'Tenn feberen';

  @override
  String get howToPlayFeverBody =>
      'Rydding fyller febermåleren. Når den er full, teller neste store rydding dobbelt – planlegg store ryddinger på forhånd.';

  @override
  String get howToPlayBoosterTitle => 'Bruk boostere klokt';

  @override
  String get howToPlayBoosterBody =>
      'Boostere redder trange spill. Du kan også trykke på en brikke nederst for å rotere den.';

  @override
  String get howToPlayDailyTitle => 'Daglig utfordring og serie';

  @override
  String get howToPlayDailyBody =>
      'Den daglige utfordringen har de samme brikkene for alle. Spill hver dag for å bygge serien og bonusen din.';

  @override
  String get howToPlayPiggyTitle => 'Fyll sparegrisen';

  @override
  String get howToPlayPiggyBody =>
      'Hver rad du rydder, fyller sparegrisen. Når den er full, kan du hente myntene gratis.';

  @override
  String get leaderboardTitle => 'Toppliste';

  @override
  String get leaderboardUnreachable =>
      'Topplisten er ikke tilgjengelig.\nPrøv igjen med internettilkobling.';

  @override
  String get leaderboardEmpty => 'Ingen oppføringer ennå.\nBli den første!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Den beste poengsummen din ($score) sendes inn …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Den beste poengsummen din sendes inn automatisk.';

  @override
  String get puzzleModeTitle => 'Puslemodus';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puslespill $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Trekk: $moves   •   Mål: $target for 3 stjerner';
  }

  @override
  String get puzzleSolved => 'Løst!';

  @override
  String get puzzleLeaveTitle => 'Forlate puslespillet?';

  @override
  String get puzzleLeaveBody => 'Framgangen i dette puslespillet går tapt.';

  @override
  String get puzzleKeepPlaying => 'Spill videre';

  @override
  String get puzzleLeave => 'Forlat';

  @override
  String get puzzleStuckTitle => 'Kjørt fast';

  @override
  String get puzzleRestart => 'Start på nytt';

  @override
  String get commonActive => 'Aktiv';

  @override
  String get commonTapToActivate => 'Trykk for å aktivere';

  @override
  String get commonRestore => 'Gjenopprett';

  @override
  String unlockForCost(int cost) {
    return 'Lås opp for $cost';
  }

  @override
  String get skinsExchangeGold => 'Veksle gull';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Roter brikke';

  @override
  String get puzzleNextLevel => 'Neste nivå';

  @override
  String get puzzleBackToOverview => 'Tilbake til oversikten';

  @override
  String get puzzleUnsolvable => 'Brettet kan ikke tømmes herfra lenger.';

  @override
  String get puzzleExtraMoveVideo => 'Ekstra trekk (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved løst';
  }

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get storageFailureTitle =>
      'Qubble kan ikke laste inn det lagrede spillet';

  @override
  String get storageFailureBody =>
      'Start appen på nytt. Hvis feilen fortsetter, hjelper bare en ny installasjon. Du kan rapportere den under Innstillinger › Tilbakemelding.';

  @override
  String get iapUnavailable => 'Tilbudet er ikke tilgjengelig nå.';

  @override
  String get iapFailed => 'Kjøpet gikk ikke gjennom. Ingenting er trukket.';

  @override
  String get settingsResetProgress => 'Tilbakestill framgang';

  @override
  String get settingsResetProgressSubtitle =>
      'Poeng, mynter, nivå og framgang tilbake til start. Kjøp, navn og kosmetikk beholdes.';

  @override
  String get settingsResetConfirmTitle => 'Tilbakestille framgangen?';

  @override
  String get settingsResetConfirmBody =>
      'Beste poengsum, mynter, nivå, serie og all framgang slettes. Det kan ikke angres.\n\nKjøpene dine, navnet ditt og opplåste temaer og skins beholdes.';

  @override
  String get settingsResetConfirmAction => 'Tilbakestill';

  @override
  String get settingsResetDone => 'Framgangen er tilbakestilt.';

  @override
  String get settingsSectionGame => 'Spill';

  @override
  String get settingsSectionSoundHaptics => 'Lyd og vibrasjon';

  @override
  String get settingsSectionReminders => 'Påminnelser';

  @override
  String get settingsSectionPurchases => 'Kjøp';

  @override
  String get settingsSectionHelpOut => 'Hjelp til';

  @override
  String get settingsSectionLegal => 'Juridisk';

  @override
  String get settingsSectionLanguage => 'Språk';

  @override
  String get settingsGuide => 'Slik spiller du';

  @override
  String get settingsGuideSubtitle => 'Regler, kombo, feber og boostere';

  @override
  String get settingsSound => 'Lyd';

  @override
  String get settingsMusic => 'Musikk';

  @override
  String get settingsHaptics => 'Vibrasjon';

  @override
  String get settingsHapticsOff => 'Av';

  @override
  String get settingsHapticsLight => 'Lett';

  @override
  String get settingsHapticsStrong => 'Kraftig';

  @override
  String get settingsSectionAccessibility => 'Komfort';

  @override
  String get settingsReducedEffects => 'Færre effekter';

  @override
  String get settingsReducedEffectsHint =>
      'Færre partikler, ingen skjermristing, ingen glød';

  @override
  String get settingsNotifications => 'Varsler';

  @override
  String get settingsNotificationsSubtitle =>
      'Daglig påminnelse og seriebeskyttelse';

  @override
  String get settingsNotificationsSystemHint =>
      'Tillat det i systeminnstillingene.';

  @override
  String get settingsLanguageSystem => 'Systemspråk';

  @override
  String get settingsSupporterThanks => 'Supporter – takk!';

  @override
  String get settingsSupporterPack => 'Supporterpakke';

  @override
  String get settingsSupporterPackSubtitle =>
      'Eksklusivt tema og skin + 1 500 mynter';

  @override
  String get settingsRestorePurchases => 'Gjenopprett kjøp';

  @override
  String get settingsRestoring => 'Gjenoppretter kjøp …';

  @override
  String get settingsRateApp => 'Vurder appen';

  @override
  String get settingsRateAppSubtitle => 'Gi en vurdering i butikken';

  @override
  String get settingsStoreUnavailable =>
      'Butikken er ikke tilgjengelig på denne enheten.';

  @override
  String get settingsFeedback => 'Send tilbakemelding';

  @override
  String get settingsFeedbackSubtitle => 'Ideer og feil (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Annonsepersonvern';

  @override
  String get settingsAdPrivacySubtitle =>
      'Se eller endre annonsesamtykket ditt';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Ingen annonsevalg trengs på denne enheten.';

  @override
  String get settingsPrivacy => 'Personvernerklæring';

  @override
  String get settingsImprint => 'Utgiverinformasjon';

  @override
  String get settingsPageOpenFailed => 'Siden kunne ikke åpnes.';

  @override
  String get settingsFooter => 'Qubble • Offline blokkpuslespill';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Admin-modus er på';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Trykk $count ganger til for admin-modus',
      one: 'Trykk $count gang til for admin-modus',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mynter',
      one: '$coins mynt',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Bare for testing – aldri i skjermbilder for utgivelse';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount mynter';
  }

  @override
  String get settingsAdminResetCoins => 'Sett mynter til 0';

  @override
  String get feedbackTitle => 'Tilbakemelding';

  @override
  String get feedbackIntroShort =>
      'Hva liker du, hva irriterer deg, hva mangler? Små ting hjelper også – jo mer konkret, jo bedre.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Bare $build og enhetstypen din legges ved – så jeg vet hvilken versjon du mener.';
  }

  @override
  String get feedbackSendByMail => 'Send på e-post';

  @override
  String get feedbackPreferGithub => 'Heller en GitHub-sak';

  @override
  String get feedbackThanksMail => 'Takk! Bare send meldingen.';

  @override
  String get feedbackNoMailApp =>
      'Fant ingen e-postapp. Prøv GitHub-veien nedenfor.';

  @override
  String get feedbackEmptyHint => 'Skriv noe først.';

  @override
  String get leaderboardRefresh => 'Oppdater';

  @override
  String get leaderboardRetry => 'Prøv igjen';

  @override
  String get feedbackHint => 'Tilbakemeldingen din …';

  @override
  String get feedbackSubmit => 'Send tilbakemelding';

  @override
  String get feedbackOpenFailed =>
      'GitHub kunne ikke åpnes. Prøv igjen senere.';

  @override
  String get feedbackGithubNote =>
      'GitHub åpnes – trykk der på «Submit new issue». (Krever én innlogging på GitHub.)';

  @override
  String get shopTitle => 'Butikk';

  @override
  String get shopWebDemoNote =>
      'Kjøp finnes bare i appen fra Play Butikk. Denne nettversjonen er en gratis demo – du kan likevel spille alt her.';

  @override
  String get shopSupporterExplainer =>
      'Qubble viser ingen påtvungne annonser – du trenger aldri å kjøpe noe. Supporterpakken (temaet Aurora, skinnet Krystall, 1 500 mynter, supportermerke) er en takk for at du støtter spillet. Kjøp er knyttet til butikkontoen din og kan gjenopprettes når som helst.';

  @override
  String get shopSupporterContents =>
      'Temaet Aurora + skinnet Krystall + 1 500 mynter';

  @override
  String get themesTitle => 'Temaer';

  @override
  String get themesSupporterOnly => 'Bare i supporterpakken (se butikken)';

  @override
  String get themesInSupporterPack => 'I supporterpakken';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Ikke nok mynter (trenger $cost, har $coins)';
  }

  @override
  String get skinsTitle => 'Blokkskins';

  @override
  String get skinsNotEnoughDiamonds =>
      'Ikke nok diamanter (veksle gull nedenfor)';

  @override
  String get skinsNotEnoughCoins => 'Ikke nok mynter';

  @override
  String get skinsNotEnoughGold => 'Ikke nok gull.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold gull = 1 diamant. Diamanter låser opp de fineste skinsene – ta deg god tid til å samle.';
  }

  @override
  String get statsTitle => 'Statistikk';

  @override
  String get statsAverageScore => 'Snittpoeng';

  @override
  String get statsBestCombo => 'Beste kombo';

  @override
  String get statsGames => 'Spill';

  @override
  String get statsLinesCleared => 'Ryddede rader';

  @override
  String get statsPiecesPlaced => 'Plasserte brikker';

  @override
  String get statsCoins => 'Mynter';

  @override
  String get missionsTitle => 'Oppdrag';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Plasser $countString brikker';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Rydd $countString rader';
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

    return 'Få $countString poeng i ett spill';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Spill $countString spill';
  }

  @override
  String get achievementsTitle => 'Prestasjoner';

  @override
  String get achievementFirstGameTitle => 'Første spill';

  @override
  String get achievementFirstGameBody => 'Spill ditt første spill';

  @override
  String get achievementGames25Title => 'Stamgjest';

  @override
  String get achievementGames25Body => 'Spill 25 spill';

  @override
  String get achievementGames100Title => 'Hektet';

  @override
  String get achievementGames100Body => 'Spill 100 spill';

  @override
  String get achievementScore1kTitle => 'Klatrer';

  @override
  String get achievementScore1kBody => 'Nå 1 000 poeng';

  @override
  String get achievementScore5kTitle => 'Proff';

  @override
  String get achievementScore5kBody => 'Nå 5 000 poeng';

  @override
  String get achievementScore10kTitle => 'Mester';

  @override
  String get achievementScore10kBody => 'Nå 10 000 poeng';

  @override
  String get achievementScore25kTitle => 'Legende';

  @override
  String get achievementScore25kBody => 'Nå 25 000 poeng';

  @override
  String get achievementLines100Title => 'Ryddig';

  @override
  String get achievementLines100Body => 'Rydd 100 rader totalt';

  @override
  String get achievementLines1000Title => 'Storrengjøring';

  @override
  String get achievementLines1000Body => 'Rydd 1 000 rader totalt';

  @override
  String get achievementCombo5Title => 'Kombonybegynner';

  @override
  String get achievementCombo5Body => 'Nå en 5x-kombo';

  @override
  String get achievementCombo10Title => 'Kombokonge';

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
  String get achievementStreak7Title => 'Ukesserie';

  @override
  String get achievementStreak7Body => 'En daglig serie på 7 dager';

  @override
  String get achievementStreak30Title => 'Månedsserie';

  @override
  String get achievementStreak30Body => 'En daglig serie på 30 dager';

  @override
  String get achievementPuzzles10Title => 'Puslespiller';

  @override
  String get achievementPuzzles10Body => 'Løs 10 puslespill';

  @override
  String get achievementPieces5000Title => 'Byggmester';

  @override
  String get achievementPieces5000Body => 'Plasser 5 000 brikker';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Serien din på $streak dager er i fare!',
      one: 'Serien din på $streak dag er i fare!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Du hoppet over i går – redd serien din:';

  @override
  String get streakRepairFailed => 'Reparasjon er ikke mulig.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mynter',
      one: '$coins mynt',
    );
    return 'Velkommen tilbake! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Påminnelser?';

  @override
  String get notificationsOptInBody =>
      'Skal vi minne deg på det daglige puslespillet ditt og beskytte serien din? Du kan endre dette når som helst i innstillingene.';

  @override
  String get notificationsOptInAccept => 'Ja takk';

  @override
  String get notificationChannelDescription =>
      'Daglig påminnelse, serievarsel, comeback';

  @override
  String get notificationDailyTitle =>
      'Det daglige puslespillet ditt venter 🧩';

  @override
  String get notificationDailyBody => 'Spill dagens utfordring!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Serien din på $streak dager er i fare!',
      one: 'Serien din på $streak dag er i fare!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'Spill i dag for å holde den i live.';

  @override
  String get notificationComebackTitle => 'Puslespillet ditt savner deg 🧩';

  @override
  String get notificationComebackBody => 'Kom tilbake og hent en gave!';

  @override
  String get iapSupporterPack => 'Supporterpakke';

  @override
  String get iapCoinsSmall => '500 mynter';

  @override
  String get iapCoinsMedium => '2 000 mynter';

  @override
  String get iapCoinsLarge => '6 000 mynter';

  @override
  String get iapStarterPack => 'Startpakke';

  @override
  String get iapRename => 'Navnebytte';

  @override
  String get iapNeonTheme => 'Temaet Neon';

  @override
  String get settingsLeaderboardDelete => 'Slett topplisteoppføring';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Fjerner navnet og poengsummen din fra den offentlige listen';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Slette oppføringen din?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Navnet og poengsummen din fjernes fra topplisten. Framgangen din i spillet røres ikke. Du kan bli med på topplisten igjen når som helst.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Topplisteoppføringen din er slettet.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Oppføringen kunne ikke slettes. Sjekk tilkoblingen og prøv igjen.';

  @override
  String get leaderboardReport => 'Rapporter dette navnet';

  @override
  String get leaderboardBlock => 'Blokker';

  @override
  String leaderboardBlocked(String name) {
    return '$name er skjult for deg';
  }

  @override
  String get leaderboardUndo => 'Angre';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oppføringer skjult av deg',
      one: '$count oppføring skjult av deg',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Vis igjen';

  @override
  String get leaderboardReportUnavailable =>
      'Rapportering er ikke tilgjengelig nå.';

  @override
  String get leaderboardReportSent => 'Takk – rapporten din er på vei.';

  @override
  String get leaderboardRules =>
      'Navn er offentlige. Ingen fornærmelser, ingen skjellsord og ingenting som identifiserer en ekte person. Navn som bryter dette, fjernes.';

  @override
  String get leaderboardRulesAccept => 'Jeg forstår';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked av $total låst opp';
  }

  @override
  String get settingsSectionData => 'Lagrede data';

  @override
  String get gameRotatePiece => 'Roter brikke';

  @override
  String get themeClassic => 'Klassisk';

  @override
  String get themeFade => 'Pastell';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Hav';

  @override
  String get themeWood => 'Tre';

  @override
  String get themeSunset => 'Solnedgang';

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
  String get skinStripe => 'Striper';

  @override
  String get skinBevel => 'Fasett';

  @override
  String get skinGlow => 'Glød';

  @override
  String get skinCrystal => 'Krystall';

  @override
  String rewardThemeName(String name) {
    return 'Temaet $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skinnet $name';
  }
}
