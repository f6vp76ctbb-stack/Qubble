// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class L10nDa extends L10n {
  L10nDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Spil';

  @override
  String get commonLater => 'Senere';

  @override
  String get commonNotNow => 'Ikke nu';

  @override
  String get commonCancel => 'Annuller';

  @override
  String get commonBuy => 'Køb';

  @override
  String get commonSave => 'Gem';

  @override
  String get commonCollect => 'Hent';

  @override
  String get nameNewName => 'Nyt navn';

  @override
  String get nameFieldLabel => 'Navn';

  @override
  String get piggyFullTitle => 'Sparegrisen er fuld!';

  @override
  String get piggyKeepSaving => 'Bliv ved med at spare';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins af $capacity samlet.';
  }

  @override
  String get homeContinueRun => 'Fortsæt';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Forstået';

  @override
  String get commonHome => 'Hjem';

  @override
  String get commonScore => 'POINT';

  @override
  String get commonBest => 'BEDSTE';

  @override
  String commonLevelShort(int level) {
    return 'Niveau $level';
  }

  @override
  String get homeNewRun => 'Start et nyt spil';

  @override
  String get homeBackToExit => 'Tryk tilbage igen for at afslutte';

  @override
  String get homeEnableLeaderboard => 'Kom på ranglisten';

  @override
  String get homeBestScore => 'BEDSTE SCORE';

  @override
  String get homeDailyChallenge => 'Daglig udfordring';

  @override
  String get homeDailyOpenToday => 'Åben i dag';

  @override
  String homeDailyNextIn(String time) {
    return 'Næste udfordring om $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Stime: $streak dage',
      one: 'Stime: $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Rangliste';

  @override
  String get homePuzzleMode => 'Puslespilstilstand';

  @override
  String get homeMissions => 'Missioner';

  @override
  String get homeThemes => 'Temaer';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Sådan spiller du Qubble';

  @override
  String get homeWeekendBonus => 'Weekend: dobbelte mønter!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Niveau $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Skift navn';

  @override
  String get nameChangeExplainer =>
      'Dit navn er din identitet på ranglisten, så det ligger fast. Du kan købe et navneskift én gang.';

  @override
  String get nameChangeAfterPurchase =>
      'Tryk på dit navn igen efter købet for at skifte det.';

  @override
  String get nameJoinedLeaderboard => 'Nu er du på ranglisten.';

  @override
  String get nameRenameUnavailable =>
      'Det er ikke muligt at skifte navn lige nu.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'Mindst $min tegn.',
      one: 'Mindst $min tegn.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'Højst $max tegn.',
      one: 'Højst $max tegn.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Kun bogstaver uden æ, ø og å (A–Z), tal, mellemrum, _ og -.';

  @override
  String get nameProblemOffensive => 'Vælg et andet navn.';

  @override
  String get piggyTitle => 'Sparegris';

  @override
  String get piggyFillingHint => 'Sparegrisen fyldes, mens du rydder rækker.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mønter',
      one: '$coins mønt',
    );
    return 'Hent $_temp0 – gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Når den er fuld, kan du tømme den gratis – eller åbne den tidligere med en bonusvideo.';

  @override
  String get piggyOpenNow => 'Åbn nu';

  @override
  String get gameNewPiecesVideo => 'Nye brikker (video)';

  @override
  String get gameTapBoardCell => 'Tryk på et felt på brættet';

  @override
  String get gameDailyChallengeLabel => 'DAGLIG UDFORDRING';

  @override
  String get gameOver => 'Spillet er slut';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Du mangler mønter til bomben: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomben virker ikke her lige nu.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Du mangler mønter: $missing.';
  }

  @override
  String get gameNotRightNow => 'Det går ikke lige nu.';

  @override
  String get gameRunSaved => 'Spillet er gemt – »Fortsæt« i menuen.';

  @override
  String get gameOverNoFit =>
      'Ingen af dine brikker kan være på brættet længere.';

  @override
  String get gameOverNoFitNoRotations =>
      'Ingen af dine brikker kan være der – og drejningerne er brugt op.';

  @override
  String get gameStarterOfferUnavailable => 'Ikke tilgængelig lige nu';

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
    return 'Præstation: $title';
  }

  @override
  String get gameBestSubmitted => 'Ny rekord – indsendt';

  @override
  String get gameReviveFor => 'Spil videre · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Låst op: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Startpakke';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score point',
      one: '$score point',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Ny rekord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Stime: $streak dage',
      one: 'Stime: $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Dobbelte mønter';

  @override
  String get gameDoubleDaily => 'Dobbelt daglig belønning';

  @override
  String get gamePlayAgain => 'Spil igen';

  @override
  String gameLevelReached(int level) {
    return 'Niveau $level nået!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count niveauer op – niveau $level!',
      one: '$count niveau op – niveau $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 mønter + temaet Træ';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Kun $hours timer tilbage – kun én gang!',
      one: 'Kun $hours time tilbage – kun én gang!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Fortryd';

  @override
  String get boosterSwap => 'Byt';

  @override
  String get boosterBomb => 'Bombe';

  @override
  String get boosterNoRotationsLeft =>
      'Ingen drejninger tilbage – ryd rækker for at genoplade!';

  @override
  String get onboardingDragPiece => 'Træk en brik ind på gitteret';

  @override
  String get onboardingFillLine => 'Fyld en hel række eller kolonne';

  @override
  String get onboardingLinesClear => 'Fulde rækker forsvinder – point!';

  @override
  String get coachHintCombo =>
      'Kombo! Ryd igen inden for 3 træk for at holde den';

  @override
  String get coachHintFever => 'FEBER! Dobbelte point, mens det lyser';

  @override
  String get coachHintRotation =>
      'Et drej koster en ladning – rydninger fylder op';

  @override
  String get coachHintBooster => 'Tip: nederst finder du boosters';

  @override
  String get coachHintStrategy =>
      'Tip: ikke alle rækker på én gang – gem plads til store brikker';

  @override
  String get dailyStreakLabel => 'Stime';

  @override
  String get dailyBestLabel => 'Dagens bedste';

  @override
  String dailyHistoryNote(int days) {
    return 'De seneste $days dage gemmes.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: spillet';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: ikke spillet';
  }

  @override
  String get homeDailyCalendar => 'Kalender';

  @override
  String get dailyShareButton => 'Del resultat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Daglig udfordring $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score point · bedste kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Spil: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Kombo: $moves træk tilbage',
      one: 'Kombo: $moves træk tilbage',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Resultatet er kopieret til udklipsholderen';

  @override
  String get adNotAvailable => 'Ingen video lige nu – prøv igen om lidt';

  @override
  String get howToPlaySpeedTitle => 'Fartbonus';

  @override
  String get howToPlaySpeedBody =>
      'Hurtige placeringer giver op til 30 % ekstra til en rydning. Bonussen aftager mellem 1,5 og 4 sekunder og har et loft, så fart betaler sig uden at afgøre spillet – et omhyggeligt, langsomt spil kan stadig slå et forhastet.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Fartbonus $percent procent';
  }

  @override
  String get iapDiamondsSmall => '100 diamanter';

  @override
  String get iapDiamondsMedium => '350 diamanter';

  @override
  String get iapDiamondsLarge => '1.000 diamanter';

  @override
  String get howToPlayTitle => 'Sådan spiller du Qubble';

  @override
  String get howToPlayIntroHeadline => 'Let at gå til.\nBelønner planlægning.';

  @override
  String get howToPlayIntroBody => 'Hold brættet frit, og slå din rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Spillets mål. Hold brættet frit, og slå din rekord.';

  @override
  String get howToPlayDragTitle => 'Træk og slip';

  @override
  String get howToPlayDragBody =>
      'Træk en af de tre brikker hen på frie felter. Når alle tre er brugt, får du automatisk tre nye.';

  @override
  String get howToPlayClearTitle => 'Ryd rækker';

  @override
  String get howToPlayClearBody =>
      'Fyld en hel række eller kolonne. Fulde rækker forsvinder og giver plads til dit næste træk.';

  @override
  String get howToPlayComboTitle => 'Kæd kombos sammen';

  @override
  String get howToPlayComboBody =>
      'Ryd endnu en række inden for tre træk. Hver ny kombo hæver din pointmultiplikator. Komboen tæller træk, ikke sekunder, så den løber aldrig ud, mens du tænker.';

  @override
  String get howToPlayFeverTitle => 'Tænd feberen';

  @override
  String get howToPlayFeverBody =>
      'Rydninger fylder febermåleren. Når den er fuld, tæller næste store rydning dobbelt – planlæg de store rydninger på forhånd.';

  @override
  String get howToPlayBoosterTitle => 'Brug boosters klogt';

  @override
  String get howToPlayBoosterBody =>
      'Boosters redder stramme spil. Du kan også trykke på en brik i bakken for at dreje den.';

  @override
  String get howToPlayDailyTitle => 'Daglig udfordring og stime';

  @override
  String get howToPlayDailyBody =>
      'Den daglige udfordring har de samme brikker for alle. Spil hver dag for at bygge din stime og din bonus op.';

  @override
  String get howToPlayPiggyTitle => 'Fyld sparegrisen';

  @override
  String get howToPlayPiggyBody =>
      'Hver række, du rydder, fylder din sparegris. Når den er fuld, kan du hente mønterne gratis.';

  @override
  String get leaderboardTitle => 'Rangliste';

  @override
  String get leaderboardUnreachable =>
      'Ranglisten er ikke tilgængelig.\nPrøv igen med internetforbindelse.';

  @override
  String get leaderboardEmpty => 'Ingen resultater endnu.\nBliv den første!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Din bedste score ($score) sendes …';
  }

  @override
  String get leaderboardAutoSubmit => 'Din bedste score sendes automatisk.';

  @override
  String get puzzleModeTitle => 'Puslespilstilstand';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puslespil $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Træk: $moves   •   Mål: $target for 3 stjerner';
  }

  @override
  String get puzzleSolved => 'Løst!';

  @override
  String get puzzleLeaveTitle => 'Forlad puslespillet?';

  @override
  String get puzzleLeaveBody => 'Dine fremskridt i dette puslespil går tabt.';

  @override
  String get puzzleKeepPlaying => 'Spil videre';

  @override
  String get puzzleLeave => 'Forlad';

  @override
  String get puzzleStuckTitle => 'Kørt fast';

  @override
  String get puzzleRestart => 'Start forfra';

  @override
  String get commonActive => 'Aktiv';

  @override
  String get commonTapToActivate => 'Tryk for at aktivere';

  @override
  String get commonRestore => 'Gendan';

  @override
  String unlockForCost(int cost) {
    return 'Lås op for $cost';
  }

  @override
  String get skinsExchangeGold => 'Veksl guld';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Drej brik';

  @override
  String get puzzleNextLevel => 'Næste niveau';

  @override
  String get puzzleBackToOverview => 'Tilbage til oversigten';

  @override
  String get puzzleUnsolvable => 'Brættet kan ikke længere tømmes herfra.';

  @override
  String get puzzleExtraMoveVideo => 'Ekstra træk (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved løst';
  }

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get storageFailureTitle => 'Qubble kan ikke indlæse dit gemte spil';

  @override
  String get storageFailureBody =>
      'Genstart appen. Hvis fejlen bliver ved, hjælper kun en geninstallation. Du kan rapportere den under Indstillinger › Feedback.';

  @override
  String get iapUnavailable => 'Tilbuddet er ikke tilgængeligt lige nu.';

  @override
  String get iapFailed => 'Købet gik ikke igennem. Der er ikke trukket noget.';

  @override
  String get settingsResetProgress => 'Nulstil fremskridt';

  @override
  String get settingsResetProgressSubtitle =>
      'Score, mønter, niveau og fremskridt tilbage til start. Køb, navn og kosmetik bevares.';

  @override
  String get settingsResetConfirmTitle => 'Nulstil fremskridt?';

  @override
  String get settingsResetConfirmBody =>
      'Bedste score, mønter, niveau, stime og alle fremskridt slettes. Det kan ikke fortrydes.\n\nDine køb, dit navn og oplåste temaer og skins bevares.';

  @override
  String get settingsResetConfirmAction => 'Nulstil';

  @override
  String get settingsResetDone => 'Fremskridt nulstillet.';

  @override
  String get settingsSectionGame => 'Spil';

  @override
  String get settingsSectionSoundHaptics => 'Lyd og vibration';

  @override
  String get settingsSectionReminders => 'Påmindelser';

  @override
  String get settingsSectionPurchases => 'Køb';

  @override
  String get settingsSectionHelpOut => 'Hjælp til';

  @override
  String get settingsSectionLegal => 'Juridisk';

  @override
  String get settingsSectionLanguage => 'Sprog';

  @override
  String get settingsGuide => 'Sådan spiller du';

  @override
  String get settingsGuideSubtitle => 'Regler, kombos, feber og boosters';

  @override
  String get settingsSound => 'Lyd';

  @override
  String get settingsMusic => 'Musik';

  @override
  String get settingsHaptics => 'Vibration';

  @override
  String get settingsHapticsOff => 'Fra';

  @override
  String get settingsHapticsLight => 'Let';

  @override
  String get settingsHapticsStrong => 'Kraftig';

  @override
  String get settingsSectionAccessibility => 'Komfort';

  @override
  String get settingsReducedEffects => 'Færre effekter';

  @override
  String get settingsReducedEffectsHint =>
      'Færre partikler, ingen skærmrystelser, ingen glød';

  @override
  String get settingsNotifications => 'Notifikationer';

  @override
  String get settingsNotificationsSubtitle =>
      'Daglig påmindelse og stimebeskyttelse';

  @override
  String get settingsNotificationsSystemHint =>
      'Tillad det i systemindstillingerne.';

  @override
  String get settingsLanguageSystem => 'Systemsprog';

  @override
  String get settingsSupporterThanks => 'Supporter – tak!';

  @override
  String get settingsSupporterPack => 'Supporterpakke';

  @override
  String get settingsSupporterPackSubtitle =>
      'Eksklusivt tema og skin + 1.500 mønter';

  @override
  String get settingsRestorePurchases => 'Gendan køb';

  @override
  String get settingsRestoring => 'Gendanner køb …';

  @override
  String get settingsRateApp => 'Bedøm appen';

  @override
  String get settingsRateAppSubtitle => 'Giv en bedømmelse i butikken';

  @override
  String get settingsStoreUnavailable =>
      'Butikken er ikke tilgængelig på denne enhed.';

  @override
  String get settingsFeedback => 'Send feedback';

  @override
  String get settingsFeedbackSubtitle => 'Idéer og fejl (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Annonceprivatliv';

  @override
  String get settingsAdPrivacySubtitle => 'Se eller skift dit annoncesamtykke';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Der kræves ingen annoncevalg på denne enhed.';

  @override
  String get settingsPrivacy => 'Privatlivspolitik';

  @override
  String get settingsImprint => 'Kolofon';

  @override
  String get settingsPageOpenFailed => 'Siden kunne ikke åbnes.';

  @override
  String get settingsFooter => 'Qubble • Offline blokpuslespil';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Admintilstand slået til';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tryk $count gange mere for admintilstand',
      one: 'Tryk $count gang mere for admintilstand',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mønter',
      one: '$coins mønt',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Kun til test – aldrig i skærmbilleder til udgivelse';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount mønter';
  }

  @override
  String get settingsAdminResetCoins => 'Sæt mønter til 0';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Hvad kan du lide, hvad irriterer dig, hvad mangler? Små ting hjælper også – jo mere konkret, jo bedre.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Kun $build og din enhedstype vedhæftes – så jeg ved, hvilken version du mener.';
  }

  @override
  String get feedbackSendByMail => 'Send via e-mail';

  @override
  String get feedbackPreferGithub => 'Hellere et GitHub-issue';

  @override
  String get feedbackThanksMail => 'Tak! Send bare beskeden.';

  @override
  String get feedbackNoMailApp =>
      'Ingen mailapp fundet. Prøv GitHub-vejen nedenfor.';

  @override
  String get feedbackEmptyHint => 'Skriv noget først.';

  @override
  String get leaderboardRefresh => 'Opdater';

  @override
  String get leaderboardRetry => 'Prøv igen';

  @override
  String get feedbackHint => 'Din feedback …';

  @override
  String get feedbackSubmit => 'Send feedback';

  @override
  String get feedbackOpenFailed => 'GitHub kunne ikke åbnes. Prøv igen senere.';

  @override
  String get feedbackGithubNote =>
      'GitHub åbner – tryk der på »Submit new issue«. (Det kræver et engangslogin på GitHub.)';

  @override
  String get shopTitle => 'Butik';

  @override
  String get shopWebDemoNote =>
      'Køb findes kun i appen fra Play Butik. Denne webversion er en gratis demo – du kan stadig spille det hele her.';

  @override
  String get shopSupporterExplainer =>
      'Qubble viser ingen tvungne reklamer – du behøver aldrig købe noget. Supporterpakken (temaet Aurora, skinnet Krystal, 1.500 mønter, supportermærke) er et tak for at støtte spillet. Køb er knyttet til din butikskonto og kan altid gendannes.';

  @override
  String get shopSupporterContents =>
      'Temaet Aurora + skinnet Krystal + 1.500 mønter';

  @override
  String get themesTitle => 'Temaer';

  @override
  String get themesSupporterOnly => 'Kun i supporterpakken (se butikken)';

  @override
  String get themesInSupporterPack => 'I supporterpakken';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Ikke nok mønter (kræver $cost, har $coins)';
  }

  @override
  String get skinsTitle => 'Blokskins';

  @override
  String get skinsNotEnoughDiamonds =>
      'Ikke nok diamanter (veksl guld nedenfor)';

  @override
  String get skinsNotEnoughCoins => 'Ikke nok mønter';

  @override
  String get skinsNotEnoughGold => 'Ikke nok guld.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold guld = 1 diamant. Diamanter låser de flotteste skins op – tag dig god tid til at samle.';
  }

  @override
  String get statsTitle => 'Statistik';

  @override
  String get statsAverageScore => 'Gns. score';

  @override
  String get statsBestCombo => 'Bedste kombo';

  @override
  String get statsGames => 'Spil';

  @override
  String get statsLinesCleared => 'Ryddede rækker';

  @override
  String get statsPiecesPlaced => 'Placerede brikker';

  @override
  String get statsCoins => 'Mønter';

  @override
  String get missionsTitle => 'Missioner';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Placer $countString brikker';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Ryd $countString rækker';
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

    return 'Få $countString point i ét spil';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Spil $countString spil';
  }

  @override
  String get achievementsTitle => 'Præstationer';

  @override
  String get achievementFirstGameTitle => 'Første spil';

  @override
  String get achievementFirstGameBody => 'Spil dit første spil';

  @override
  String get achievementGames25Title => 'Stamgæst';

  @override
  String get achievementGames25Body => 'Spil 25 spil';

  @override
  String get achievementGames100Title => 'Bidt af det';

  @override
  String get achievementGames100Body => 'Spil 100 spil';

  @override
  String get achievementScore1kTitle => 'Klatrer';

  @override
  String get achievementScore1kBody => 'Nå 1.000 point';

  @override
  String get achievementScore5kTitle => 'Proff';

  @override
  String get achievementScore5kBody => 'Nå 5.000 point';

  @override
  String get achievementScore10kTitle => 'Mester';

  @override
  String get achievementScore10kBody => 'Nå 10.000 point';

  @override
  String get achievementScore25kTitle => 'Legende';

  @override
  String get achievementScore25kBody => 'Nå 25.000 point';

  @override
  String get achievementLines100Title => 'Ryddelig';

  @override
  String get achievementLines100Body => 'Ryd 100 rækker i alt';

  @override
  String get achievementLines1000Title => 'Hovedrengøring';

  @override
  String get achievementLines1000Body => 'Ryd 1.000 rækker i alt';

  @override
  String get achievementCombo5Title => 'Kombonybegynder';

  @override
  String get achievementCombo5Body => 'Nå en 5x-kombo';

  @override
  String get achievementCombo10Title => 'Kombokonge';

  @override
  String get achievementCombo10Body => 'Nå en 10x-kombo';

  @override
  String get achievementLevel10Title => 'Erfaren';

  @override
  String get achievementLevel10Body => 'Nå niveau 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Nå niveau 20';

  @override
  String get achievementStreak7Title => 'Ugestime';

  @override
  String get achievementStreak7Body => 'En daglig stime på 7 dage';

  @override
  String get achievementStreak30Title => 'Månedsstime';

  @override
  String get achievementStreak30Body => 'En daglig stime på 30 dage';

  @override
  String get achievementPuzzles10Title => 'Puslespiller';

  @override
  String get achievementPuzzles10Body => 'Løs 10 puslespil';

  @override
  String get achievementPieces5000Title => 'Bygmester';

  @override
  String get achievementPieces5000Body => 'Placer 5.000 brikker';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Din stime på $streak dage er i fare!',
      one: 'Din stime på $streak dag er i fare!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Du sprang i går over – red din stime:';

  @override
  String get streakRepairFailed => 'Reparation er ikke mulig.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mønter',
      one: '$coins mønt',
    );
    return 'Velkommen tilbage! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Påmindelser?';

  @override
  String get notificationsOptInBody =>
      'Skal vi minde dig om dit daglige puslespil og beskytte din stime? Du kan altid ændre det i indstillingerne.';

  @override
  String get notificationsOptInAccept => 'Ja tak';

  @override
  String get notificationChannelDescription =>
      'Daglig påmindelse, stimeadvarsel, comeback';

  @override
  String get notificationDailyTitle => 'Dit daglige puslespil venter 🧩';

  @override
  String get notificationDailyBody => 'Spil dagens udfordring!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Din stime på $streak dage er i fare!',
      one: 'Din stime på $streak dag er i fare!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'Spil i dag for at holde den i live.';

  @override
  String get notificationComebackTitle => 'Dit puslespil savner dig 🧩';

  @override
  String get notificationComebackBody => 'Kom tilbage og hent en gave!';

  @override
  String get iapSupporterPack => 'Supporterpakke';

  @override
  String get iapCoinsSmall => '500 mønter';

  @override
  String get iapCoinsMedium => '2.000 mønter';

  @override
  String get iapCoinsLarge => '6.000 mønter';

  @override
  String get iapStarterPack => 'Startpakke';

  @override
  String get iapRename => 'Navneskift';

  @override
  String get iapNeonTheme => 'Temaet Neon';

  @override
  String get settingsLeaderboardDelete => 'Slet ranglisteindgang';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Fjerner dit navn og din score fra den offentlige liste';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Slet din indgang?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Dit navn og din score fjernes fra ranglisten. Dine fremskridt i spillet røres ikke. Du kan altid komme på ranglisten igen.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Din ranglisteindgang er slettet.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Indgangen kunne ikke slettes. Tjek forbindelsen, og prøv igen.';

  @override
  String get leaderboardReport => 'Anmeld dette navn';

  @override
  String get leaderboardBlock => 'Bloker';

  @override
  String leaderboardBlocked(String name) {
    return '$name er skjult for dig';
  }

  @override
  String get leaderboardUndo => 'Fortryd';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count indgange skjult af dig',
      one: '$count indgang skjult af dig',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Vis igen';

  @override
  String get leaderboardReportUnavailable =>
      'Det er ikke muligt at anmelde lige nu.';

  @override
  String get leaderboardReportSent => 'Tak – din anmeldelse er på vej.';

  @override
  String get leaderboardRules =>
      'Navne er offentlige. Ingen fornærmelser, ingen skældsord og intet, der identificerer en virkelig person. Navne, der bryder dette, fjernes.';

  @override
  String get leaderboardRulesAccept => 'Forstået';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked af $total låst op';
  }

  @override
  String get settingsSectionData => 'Gemte data';

  @override
  String get gameRotatePiece => 'Drej brik';

  @override
  String get themeClassic => 'Klassisk';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Hav';

  @override
  String get themeWood => 'Træ';

  @override
  String get themeSunset => 'Solnedgang';

  @override
  String get themeForest => 'Skov';

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
  String get skinStripe => 'Striber';

  @override
  String get skinBevel => 'Facet';

  @override
  String get skinGlow => 'Glød';

  @override
  String get skinCrystal => 'Krystal';

  @override
  String rewardThemeName(String name) {
    return 'Temaet $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skinnet $name';
  }
}
