// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class L10nSl extends L10n {
  L10nSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Igraj';

  @override
  String get commonLater => 'Pozneje';

  @override
  String get commonNotNow => 'Ne zdaj';

  @override
  String get commonCancel => 'Prekliči';

  @override
  String get commonBuy => 'Kupi';

  @override
  String get commonSave => 'Shrani';

  @override
  String get commonCollect => 'Prevzemi';

  @override
  String get nameNewName => 'Novo ime';

  @override
  String get nameFieldLabel => 'Ime';

  @override
  String get piggyFullTitle => 'Hranilnik je poln!';

  @override
  String get piggyKeepSaving => 'Varčuj naprej';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Zbrano: $coins od $capacity.';
  }

  @override
  String get homeContinueRun => 'Nadaljuj';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Razumem';

  @override
  String get commonHome => 'Domov';

  @override
  String get commonScore => 'TOČKE';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Stopnja $level';
  }

  @override
  String get homeNewRun => 'Začni novo igro';

  @override
  String get homeBackToExit => 'Za izhod znova pritisni nazaj';

  @override
  String get homeEnableLeaderboard => 'Pridruži se lestvici';

  @override
  String get homeBestScore => 'REKORD';

  @override
  String get homeDailyChallenge => 'Dnevni izziv';

  @override
  String get homeDailyOpenToday => 'Čaka danes';

  @override
  String homeDailyNextIn(String time) {
    return 'Naslednji izziv čez $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak-dnevni niz';
  }

  @override
  String get homeLeaderboard => 'Lestvica';

  @override
  String get homePuzzleMode => 'Način ugank';

  @override
  String get homeHowToPlay => 'Kako igrati Qubble';

  @override
  String get homeWeekendBonus => 'Vikend: dvojni kovanci!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Stopnja $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Spremeni ime';

  @override
  String get nameChangeExplainer =>
      'Tvoje ime je tvoja identiteta na lestvici, zato je stalno. Kupiš lahko enkratno spremembo imena.';

  @override
  String get nameChangeAfterPurchase =>
      'Po nakupu se znova dotakni svojega imena, da ga spremeniš.';

  @override
  String get nameJoinedLeaderboard => 'Zdaj si na lestvici.';

  @override
  String nameProblemTooShort(int min) {
    return 'Najmanjše število znakov: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Največje število znakov: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Samo latinične črke (A–Z, tudi s strešicami), številke, presledki, _ in -.';

  @override
  String get nameProblemOffensive => 'Izberi drugo ime.';

  @override
  String get piggyTitle => 'Hranilnik';

  @override
  String get piggyFillingHint => 'Hranilnik se polni, ko čistiš vrstice.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins kovancev',
      few: '$coins kovanci',
      two: '$coins kovanca',
      one: '$coins kovanec',
    );
    return 'Prevzemi $_temp0 – brezplačno.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Ko bo poln, ga lahko izprazniš brezplačno – ali ga odpreš prej z bonus videom.';

  @override
  String get piggyOpenNow => 'Odpri zdaj';

  @override
  String get gameNewPiecesVideo => 'Novi liki (video)';

  @override
  String get gameTapBoardCell => 'Dotakni se polja na plošči';

  @override
  String get gameDailyChallengeLabel => 'DNEVNI IZZIV';

  @override
  String get gameOver => 'Konec igre';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Za bombo manjka kovancev: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomba tukaj trenutno ne deluje.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Za to manjka kovancev: $missing.';
  }

  @override
  String get gameNotRightNow => 'Trenutno ni mogoče.';

  @override
  String get gameRunSaved => 'Igra shranjena – »Nadaljuj« v meniju.';

  @override
  String get gameOverNoFit => 'Noben tvoj lik ne gre več na ploščo.';

  @override
  String get gameOverNoFitNoRotations =>
      'Noben tvoj lik ne gre na ploščo – in obratov je zmanjkalo.';

  @override
  String get gameStarterOfferUnavailable => 'Trenutno ni na voljo';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price – pridobi';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Dosežek: $title';
  }

  @override
  String get gameBestSubmitted => 'Nov rekord – poslan';

  @override
  String get gameReviveFor => 'Igraj naprej · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Odklenjeno: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Začetni paket';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score točk',
      few: '$score točke',
      two: '$score točki',
      one: '$score točka',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Nov rekord!';

  @override
  String gameStreakDays(int streak) {
    return '$streak-dnevni niz';
  }

  @override
  String get gameDoubleCoins => 'Podvoji kovance';

  @override
  String get gameDoubleDaily => 'Podvoji dnevno nagrado';

  @override
  String get gamePlayAgain => 'Igraj znova';

  @override
  String gameLevelReached(int level) {
    return 'Dosežena stopnja $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count stopenj – stopnja $level!',
      few: '+$count stopnje – stopnja $level!',
      two: '+$count stopnji – stopnja $level!',
      one: '+$count stopnja – stopnja $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 kovancev + tema Les';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Še samo $hours h – samo enkrat!';
  }

  @override
  String get boosterUndo => 'Razveljavi';

  @override
  String get boosterSwap => 'Zamenjaj';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Obratov ni več – počisti vrstice, da jih napolniš!';

  @override
  String get onboardingDragPiece => 'Povleci blok na mrežo';

  @override
  String get onboardingFillLine => 'Zapolni celo vrstico ali stolpec';

  @override
  String get onboardingLinesClear => 'Polne vrstice izginejo – točke!';

  @override
  String get coachHintCombo =>
      'Kombo! Počisti znova v 3 potezah, da ga obdržiš';

  @override
  String get coachHintFever => 'VROČICA! Dvojne točke, dokler žari';

  @override
  String get coachHintRotation => 'Obrat stane en naboj – čiščenje ga napolni';

  @override
  String get coachHintBooster => 'Namig: spodaj lahko uporabiš ojačevalnike';

  @override
  String get coachHintStrategy =>
      'Namig: ne vseh vrstic hkrati – pusti prostor za velike like';

  @override
  String get dailyStreakLabel => 'Niz';

  @override
  String get dailyBestLabel => 'Dnevni rekord';

  @override
  String dailyHistoryNote(int days) {
    return 'Hranijo se zadnji dnevi: $days.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day. dan: odigrano';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day. dan: ni odigrano';
  }

  @override
  String get homeDailyCalendar => 'Koledar';

  @override
  String get dailyShareButton => 'Deli rezultat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Dnevni izziv $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Točke: $score · najboljši kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Igraj: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Kombo: še $moves potez',
      few: 'Kombo: še $moves poteze',
      two: 'Kombo: še $moves potezi',
      one: 'Kombo: še $moves poteza',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Rezultat kopiran v odložišče';

  @override
  String get adNotAvailable => 'Trenutno ni videa – poskusi znova čez trenutek';

  @override
  String get howToPlaySpeedTitle => 'Bonus hitrosti';

  @override
  String get howToPlaySpeedBody =>
      'Hitro postavljanje vsakemu čiščenju doda do 30 %. Bonus upada med 1,5 in 4 sekundami in ima zgornjo mejo, zato se hitrost splača, a igre ne odloči – skrbna počasna igra lahko še vedno premaga naglo hitro.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus hitrosti $percent odstotkov';
  }

  @override
  String get iapDiamondsSmall => '100 diamantov';

  @override
  String get iapDiamondsMedium => '350 diamantov';

  @override
  String get iapDiamondsLarge => '1.000 diamantov';

  @override
  String get howToPlayTitle => 'Kako igrati Qubble';

  @override
  String get howToPlayIntroHeadline => 'Lahek začetek.\nNagrajuje načrtovanje.';

  @override
  String get howToPlayIntroBody =>
      'Ohranjaj ploščo prosto in premagaj svoj rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Cilj igre. Ohranjaj ploščo prosto in premagaj svoj rekord.';

  @override
  String get howToPlayDragTitle => 'Povleci in postavi';

  @override
  String get howToPlayDragBody =>
      'Povleci enega od treh likov na prosta polja. Ko porabiš vse tri, samodejno dobiš tri nove.';

  @override
  String get howToPlayClearTitle => 'Čisti vrstice';

  @override
  String get howToPlayClearBody =>
      'Zapolni celo vrstico ali stolpec. Polne vrstice izginejo in naredijo prostor za naslednjo potezo.';

  @override
  String get howToPlayComboTitle => 'Poveži kombe';

  @override
  String get howToPlayComboBody =>
      'V treh potezah počisti še eno vrstico. Vsak nadaljnji kombo dvigne množitelj točk. Kombo šteje poteze, ne sekund, zato nikoli ne poteče, medtem ko razmišljaš.';

  @override
  String get howToPlayFeverTitle => 'Prižgi vročico';

  @override
  String get howToPlayFeverBody =>
      'Čiščenja polnijo merilnik vročice. Ko je poln, naslednja eksplozija šteje dvojno – velika čiščenja načrtuj vnaprej.';

  @override
  String get howToPlayBoosterTitle => 'Ojačevalnike uporabljaj pametno';

  @override
  String get howToPlayBoosterBody =>
      'Ojačevalniki rešijo tesne igre. Lik v pladnju lahko tudi tapneš, da ga obrneš.';

  @override
  String get howToPlayDailyTitle => 'Dnevni izziv in niz';

  @override
  String get howToPlayDailyBody =>
      'Dnevni izziv ima za vse enake like. Igraj vsak dan, da povečaš niz in bonus.';

  @override
  String get howToPlayPiggyTitle => 'Napolni hranilnik';

  @override
  String get howToPlayPiggyBody =>
      'Vsaka počiščena vrstica polni hranilnik. Ko je poln, lahko kovance prevzameš brezplačno.';

  @override
  String get leaderboardTitle => 'Lestvica';

  @override
  String get leaderboardUnreachable =>
      'Lestvica ni na voljo.\nPoskusi znova z internetno povezavo.';

  @override
  String get leaderboardEmpty => 'Še ni vpisov.\nBodi prvi!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Tvoj rekord ($score) se pošilja …';
  }

  @override
  String get leaderboardAutoSubmit => 'Tvoj rekord se pošlje samodejno.';

  @override
  String get puzzleModeTitle => 'Način ugank';

  @override
  String puzzleLevelTitle(int level) {
    return 'Uganka $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Poteze: $moves   •   Cilj za 3 zvezdice: $target';
  }

  @override
  String get puzzleSolved => 'Rešeno!';

  @override
  String get puzzleLeaveTitle => 'Zapustiš uganko?';

  @override
  String get puzzleLeaveBody => 'Napredek v tej uganki bo izgubljen.';

  @override
  String get puzzleKeepPlaying => 'Igraj naprej';

  @override
  String get puzzleLeave => 'Zapusti';

  @override
  String get puzzleStuckTitle => 'Slepa ulica';

  @override
  String get puzzleRestart => 'Znova';

  @override
  String get commonActive => 'Aktivno';

  @override
  String get commonRestore => 'Obnovi';

  @override
  String get skinsExchangeGold => 'Zamenjaj zlato';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Obrni lik';

  @override
  String get puzzleNextLevel => 'Naslednja stopnja';

  @override
  String get puzzleBackToOverview => 'Nazaj na pregled';

  @override
  String get puzzleUnsolvable => 'Od tu plošče ni več mogoče izprazniti.';

  @override
  String get puzzleExtraMoveVideo => 'Dodatna poteza (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Rešenih: $solved';
  }

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get storageFailureTitle => 'Qubble ne more naložiti shranjene igre';

  @override
  String get storageFailureBody =>
      'Znova zaženi aplikacijo. Če napaka ostane, pomaga le ponovna namestitev. Napako lahko sporočiš v Nastavitve › Povratne informacije.';

  @override
  String get iapUnavailable => 'Ta ponudba trenutno ni na voljo.';

  @override
  String get iapFailed => 'Nakup ni uspel. Nič ni bilo zaračunano.';

  @override
  String get settingsResetProgress => 'Ponastavi napredek';

  @override
  String get settingsResetProgressSubtitle =>
      'Točke, kovanci, stopnja in napredek se vrnejo na začetek. Nakupi, ime in kozmetika ostanejo.';

  @override
  String get settingsResetConfirmTitle => 'Ponastaviš napredek?';

  @override
  String get settingsResetConfirmBody =>
      'Rekord, kovanci, stopnja, niz in ves napredek bodo izbrisani. Tega ni mogoče razveljaviti.\n\nTvoji nakupi, ime ter odklenjene teme in videzi ostanejo.';

  @override
  String get settingsResetConfirmAction => 'Ponastavi';

  @override
  String get settingsResetDone => 'Napredek ponastavljen.';

  @override
  String get settingsSectionGame => 'Igra';

  @override
  String get settingsSectionSoundHaptics => 'Zvok in vibriranje';

  @override
  String get settingsSectionReminders => 'Opomniki';

  @override
  String get settingsSectionPurchases => 'Nakupi';

  @override
  String get settingsSectionHelpOut => 'Pomagaj';

  @override
  String get settingsSectionLegal => 'Pravno';

  @override
  String get settingsSectionLanguage => 'Jezik';

  @override
  String get settingsGuide => 'Kako igrati';

  @override
  String get settingsGuideSubtitle => 'Pravila, kombi, vročica in ojačevalniki';

  @override
  String get settingsSound => 'Zvok';

  @override
  String get settingsMusic => 'Glasba';

  @override
  String get settingsHaptics => 'Vibriranje';

  @override
  String get settingsHapticsOff => 'Izklopljeno';

  @override
  String get settingsHapticsLight => 'Blago';

  @override
  String get settingsHapticsStrong => 'Močno';

  @override
  String get settingsSectionAccessibility => 'Udobje';

  @override
  String get settingsReducedEffects => 'Manj učinkov';

  @override
  String get settingsReducedEffectsHint =>
      'Manj delcev, brez tresenja zaslona in žarenja';

  @override
  String get settingsNotifications => 'Obvestila';

  @override
  String get settingsNotificationsSubtitle => 'Dnevni opomnik in zaščita niza';

  @override
  String get settingsNotificationsSystemHint =>
      'Dovoli jih v sistemskih nastavitvah.';

  @override
  String get settingsLanguageSystem => 'Jezik sistema';

  @override
  String get settingsSupporterThanks => 'Podpornik – hvala!';

  @override
  String get settingsSupporterPack => 'Podporniški paket';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ekskluzivna tema in videz + 1.500 kovancev';

  @override
  String get settingsRestorePurchases => 'Obnovi nakupe';

  @override
  String get settingsRestoring => 'Obnavljanje nakupov …';

  @override
  String get settingsRateApp => 'Oceni aplikacijo';

  @override
  String get settingsRateAppSubtitle => 'Pusti oceno v trgovini';

  @override
  String get settingsStoreUnavailable => 'Trgovina v tej napravi ni na voljo.';

  @override
  String get settingsFeedback => 'Pošlji povratne informacije';

  @override
  String get settingsFeedbackSubtitle =>
      'Sporoči ideje in napake (prek GitHuba)';

  @override
  String get settingsAdPrivacy => 'Zasebnost oglasov';

  @override
  String get settingsAdPrivacySubtitle =>
      'Oglej si ali spremeni soglasje za oglase';

  @override
  String get settingsAdPrivacyUnavailable =>
      'V tej napravi možnosti oglasov niso potrebne.';

  @override
  String get settingsPrivacy => 'Pravilnik o zasebnosti';

  @override
  String get settingsImprint => 'Kolofon';

  @override
  String get settingsPageOpenFailed => 'Strani ni bilo mogoče odpreti.';

  @override
  String get settingsFooter => 'Qubble • Blokovna uganka brez povezave';

  @override
  String get settingsAdminSection => 'Skrbnik (test)';

  @override
  String get settingsAdminEnabled => 'Skrbniški način vklopljen';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Še $count-krat tapni za skrbniški način';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins kovancev',
      few: '$coins kovanci',
      two: '$coins kovanca',
      one: '$coins kovanec',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Samo za testiranje – nikoli na posnetkih zaslona izdaje';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount kovancev',
      few: '$amount kovanci',
      two: '$amount kovanca',
      one: '$amount kovanec',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Nastavi kovance na 0';

  @override
  String get feedbackTitle => 'Povratne informacije';

  @override
  String get feedbackIntroShort =>
      'Kaj ti je všeč, kaj te moti, kaj manjka? Pomagajo tudi malenkosti – bolj ko je konkretno, bolje je.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Priložena sta samo $build in vrsta naprave – da vem, o kateri različici govoriš.';
  }

  @override
  String get feedbackSendByMail => 'Pošlji po e-pošti';

  @override
  String get feedbackPreferGithub => 'Raje issue na GitHubu';

  @override
  String get feedbackThanksMail => 'Hvala! Samo še pošlji sporočilo.';

  @override
  String get feedbackNoMailApp =>
      'Ni aplikacije za e-pošto. Poskusi pot prek GitHuba spodaj.';

  @override
  String get feedbackEmptyHint => 'Najprej nekaj napiši.';

  @override
  String get leaderboardRefresh => 'Osveži';

  @override
  String get leaderboardRetry => 'Poskusi znova';

  @override
  String get feedbackHint => 'Tvoje povratne informacije …';

  @override
  String get feedbackSubmit => 'Pošlji povratne informacije';

  @override
  String get feedbackOpenFailed =>
      'GitHuba ni bilo mogoče odpreti. Poskusi pozneje.';

  @override
  String get feedbackGithubNote =>
      'Odpre se GitHub – tam tapni \"Submit new issue\". (Potrebna je enkratna prijava v GitHub.)';

  @override
  String get shopTitle => 'Trgovina';

  @override
  String get shopWebDemoNote =>
      'Nakupi so na voljo samo v aplikaciji iz Trgovine Play. Ta spletna različica je brezplačna demo različica – vseeno lahko tukaj igraš vse.';

  @override
  String get shopSupporterExplainer =>
      'Qubble ne prikazuje vsiljenih oglasov – nikoli ti ni treba ničesar kupiti. Podporniški paket (tema Aurora, videz Kristal, 1.500 kovancev, značka podpornika) je zahvala za podporo igri. Nakupi so vezani na tvoj račun v trgovini in jih lahko kadar koli obnoviš.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + videz Kristal + 1.500 kovancev';

  @override
  String get themesTitle => 'Teme';

  @override
  String get themesSupporterOnly =>
      'Samo v podporniškem paketu (glej trgovino)';

  @override
  String get skinsTitle => 'Videzi blokov';

  @override
  String get skinsNotEnoughCoins => 'Premalo kovancev';

  @override
  String get skinsNotEnoughGold => 'Premalo zlata.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold zlata = 1 diamant. Diamanti odklenejo najlepše videze – zbiraj brez naglice.';
  }

  @override
  String get statsTitle => 'Statistika';

  @override
  String get statsAverageScore => 'Povpr. točke';

  @override
  String get statsBestCombo => 'Najboljši kombo';

  @override
  String get statsGames => 'Igre';

  @override
  String get statsLinesCleared => 'Počiščene vrstice';

  @override
  String get statsPiecesPlaced => 'Postavljeni liki';

  @override
  String get statsCoins => 'Kovanci';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Doseži kombo x$countString';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'V eni igri preseži $countString točk',
      few: 'V eni igri preseži $countString točke',
      two: 'V eni igri preseži $countString točki',
      one: 'V eni igri preseži $countString točko',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Dosežki';

  @override
  String get achievementFirstGameTitle => 'Prva igra';

  @override
  String get achievementFirstGameBody => 'Odigraj svojo prvo igro';

  @override
  String get achievementGames25Title => 'Stalni igralec';

  @override
  String get achievementGames25Body => 'Odigraj 25 iger';

  @override
  String get achievementGames100Title => 'Zasvojen';

  @override
  String get achievementGames100Body => 'Odigraj 100 iger';

  @override
  String get achievementScore1kTitle => 'Plezalec';

  @override
  String get achievementScore1kBody => 'Doseži 1.000 točk';

  @override
  String get achievementScore5kTitle => 'Profesionalec';

  @override
  String get achievementScore5kBody => 'Doseži 5.000 točk';

  @override
  String get achievementScore10kTitle => 'Mojster';

  @override
  String get achievementScore10kBody => 'Doseži 10.000 točk';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Doseži 25.000 točk';

  @override
  String get achievementLines100Title => 'Urejen';

  @override
  String get achievementLines100Body => 'Skupaj počisti 100 vrstic';

  @override
  String get achievementLines1000Title => 'Veliko čiščenje';

  @override
  String get achievementLines1000Body => 'Skupaj počisti 1.000 vrstic';

  @override
  String get achievementCombo5Title => 'Kombo začetnik';

  @override
  String get achievementCombo5Body => 'Doseži kombo x5';

  @override
  String get achievementCombo10Title => 'Kralj kombov';

  @override
  String get achievementCombo10Body => 'Doseži kombo x10';

  @override
  String get achievementLevel10Title => 'Izkušen';

  @override
  String get achievementLevel10Body => 'Doseži stopnjo 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Doseži stopnjo 20';

  @override
  String get achievementStreak7Title => 'Tedenski niz';

  @override
  String get achievementStreak7Body => '7-dnevni niz dnevnih izzivov';

  @override
  String get achievementStreak30Title => 'Mesečni niz';

  @override
  String get achievementStreak30Body => '30-dnevni niz dnevnih izzivov';

  @override
  String get achievementPuzzles10Title => 'Ugankar';

  @override
  String get achievementPuzzles10Body => 'Reši 10 ugank';

  @override
  String get achievementPieces5000Title => 'Graditelj';

  @override
  String get achievementPieces5000Body => 'Postavi 5.000 likov';

  @override
  String streakRepairTitle(int streak) {
    return 'Tvoj $streak-dnevni niz je v nevarnosti!';
  }

  @override
  String get streakRepairBody => 'Včeraj je bil dan brez igre – reši svoj niz:';

  @override
  String get streakRepairFailed => 'Popravilo ni mogoče.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins kovancev',
      few: '$coins kovanci',
      two: '$coins kovanca',
      one: '$coins kovanec',
    );
    return 'Lepo, da si spet tu! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Opomniki?';

  @override
  String get notificationsOptInBody =>
      'Te opomnimo na dnevno uganko in zaščitimo tvoj niz? To lahko kadar koli spremeniš v nastavitvah.';

  @override
  String get notificationsOptInAccept => 'Da, prosim';

  @override
  String get notificationChannelDescription =>
      'Dnevni opomnik, opozorilo za niz, vrnitev';

  @override
  String get notificationDailyTitle => 'Tvoja dnevna uganka čaka 🧩';

  @override
  String get notificationDailyBody => 'Igraj današnji izziv!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Tvoj $streak-dnevni niz je v nevarnosti!';
  }

  @override
  String get notificationStreakBody => 'Igraj danes, da ga ohraniš.';

  @override
  String get notificationComebackTitle => 'Tvoji bloki te pogrešajo 🧩';

  @override
  String get notificationComebackBody => 'Vrni se in prevzemi darilo!';

  @override
  String get iapSupporterPack => 'Podporniški paket';

  @override
  String get iapCoinsSmall => '500 kovancev';

  @override
  String get iapCoinsMedium => '2.000 kovancev';

  @override
  String get iapCoinsLarge => '6.000 kovancev';

  @override
  String get iapStarterPack => 'Začetni paket';

  @override
  String get iapRename => 'Sprememba imena';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Izbriši vpis na lestvici';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Odstrani tvoje ime in točke z javnega seznama';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Izbrišeš svoj vpis?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tvoje ime in točke bodo odstranjeni z lestvice. Napredek v igri ostane nedotaknjen. Lestvici se lahko kadar koli znova pridružiš.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Tvoj vpis na lestvici je izbrisan.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Vpisa ni bilo mogoče izbrisati. Preveri povezavo in poskusi znova.';

  @override
  String get leaderboardReport => 'Prijavi to ime';

  @override
  String get leaderboardBlock => 'Blokiraj';

  @override
  String leaderboardBlocked(String name) {
    return '$name je zate skrit';
  }

  @override
  String get leaderboardUndo => 'Razveljavi';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Tvojih skritih vpisov: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Znova prikaži';

  @override
  String get leaderboardReportUnavailable => 'Prijava trenutno ni mogoča.';

  @override
  String get leaderboardReportSent => 'Hvala – tvoja prijava je na poti.';

  @override
  String get leaderboardRules =>
      'Imena so javna. Brez žalitev, brez slabšalnih izrazov in brez česar koli, kar razkrije resnično osebo. Imena, ki kršijo to pravilo, odstranimo.';

  @override
  String get leaderboardRulesAccept => 'Razumem';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Odklenjenih $unlocked od $total';
  }

  @override
  String get settingsSectionData => 'Shranjeni podatki';

  @override
  String get gameRotatePiece => 'Obrni lik';

  @override
  String get themeClassic => 'Klasična';

  @override
  String get themeFade => 'Pastelna';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeWood => 'Les';

  @override
  String get themeSunset => 'Sončni zahod';

  @override
  String get themeForest => 'Gozd';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasičen';

  @override
  String get skinGradient => 'Preliv';

  @override
  String get skinOutline => 'Obroba';

  @override
  String get skinGlossy => 'Bleščeč';

  @override
  String get skinStripe => 'Črte';

  @override
  String get skinBevel => 'Relief';

  @override
  String get skinGlow => 'Žar';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Videz $name';
  }

  @override
  String get skinPulse => 'Utrip';

  @override
  String get skinShimmer => 'Lesketanje';

  @override
  String get skinWave => 'Val';

  @override
  String get skinEmber => 'Žerjavica';

  @override
  String get skinPrism => 'Prizma';

  @override
  String get skinStardust => 'Zvezdni prah';

  @override
  String get skinCircuit => 'Vezje';

  @override
  String get skinRipple => 'Valovanje';

  @override
  String achievementRewardSkin(String name) {
    return 'Animiran videz: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Nagrada za dosežek: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Dosežki zdaj prinašajo nagrade — tvoje so dodane.';

  @override
  String get namePromptBody =>
      'Izberi ime in tvoj najboljši rezultat bo na lestvici. Brez imena igraš naprej anonimno.';

  @override
  String get nameTaken => 'To ime je že zasedeno. Poskusi drugo.';

  @override
  String get nameCheckFailed =>
      'Imena ni bilo mogoče preveriti. Si povezan z internetom? Poskusi znova čez trenutek.';

  @override
  String nameLost(String name) {
    return '$name zdaj pripada drugemu igralcu. Izberi novo ime – brezplačno.';
  }

  @override
  String get themeCandy => 'Bonbon';

  @override
  String get themeVolcano => 'Vulkan';

  @override
  String get themeGlacier => 'Ledenik';

  @override
  String get skinPixel => 'Piksel';

  @override
  String get skinMarble => 'Marmor';

  @override
  String get skinJelly => 'Žele';

  @override
  String get skinLiquid => 'Tekočina';

  @override
  String get skinFizz => 'Mehurčki';

  @override
  String get skinPlasma => 'Plazma';

  @override
  String get designsTitle => 'Videzi';

  @override
  String get designsNotEnoughDiamonds => 'Premalo diamantov.';

  @override
  String get designsOwned => 'Tvoje';

  @override
  String get designsAchievementOnly => 'Dosežek';

  @override
  String get designsSupporterOnly => 'Podpornik';

  @override
  String get designsPreview => 'Predogled';

  @override
  String get designsGetDiamonds => 'Pridobi diamante';

  @override
  String get shopDealTitle => 'Ponudba dneva';

  @override
  String get shopAnimatedSkins => 'Animirani videzi';

  @override
  String get shopNewDesigns => 'Novi videzi';

  @override
  String get shopDiamonds => 'Diamanti';

  @override
  String get shopPacks => 'Paketi';

  @override
  String get shopPopular => 'Priljubljeno';

  @override
  String get shopBestValue => 'Najugodneje';

  @override
  String get shopDiamondsBlurb => 'Za animirane videze in nove teme.';

  @override
  String get shopCoinsBlurb => 'Za teme, videze in ojačevalnike.';

  @override
  String get shopNeonBlurb => 'Takoj odklene temo Neon.';

  @override
  String get shopRenameBlurb => 'Spremeni svoje ime na lestvici.';

  @override
  String shopHoursLeft(int hours) {
    return 'Še $hours h';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Nova ponudba čez $time';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name odklenjeno!';
  }

  @override
  String get questsTitle => 'Naloge';

  @override
  String get questsDaily => 'Dnevne';

  @override
  String get questsWeekly => 'Tedenske';

  @override
  String get questsMonthly => 'Mesečne';

  @override
  String questsNewIn(String time) {
    return 'Nove naloge čez $time';
  }

  @override
  String get questsBonus => 'Bonus za vse';

  @override
  String get questsBonusEarned => 'Bonus prejet';

  @override
  String get questRounds => 'Igraj runde';

  @override
  String get questLines => 'Počisti vrstice';

  @override
  String get questPieces => 'Postavi like';

  @override
  String get questDailyChallenge => 'Igraj dnevni izziv';

  @override
  String get questPuzzles => 'Reši nove uganke';

  @override
  String get questDays => 'Igraj na različne dni';

  @override
  String get questDailySets => 'Opravi vse dnevne naloge';

  @override
  String get questsSetDaily => 'Vse dnevne naloge opravljene!';

  @override
  String get questsSetWeekly => 'Vse tedenske naloge opravljene!';

  @override
  String get questsSetMonthly => 'Vse mesečne naloge opravljene!';

  @override
  String get leaderboardTabScore => 'Najboljši rezultat';

  @override
  String get leaderboardTabPuzzle => 'Zvezdice ugank';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Tvoje zvezdice ugank se pošiljajo samodejno.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Tvoje zvezdice ugank ($stars) se pošiljajo …';
  }

  @override
  String get dailyGoalTitle => 'Današnji cilj';

  @override
  String dailyGoalPoints(String points) {
    return '$points točk';
  }

  @override
  String get dailyChestOpened => 'Skrinja niza odprta!';

  @override
  String dailyNextChest(int day) {
    return 'Naslednja skrinja: $day. dan niza';
  }

  @override
  String get dailyExplainer =>
      'Danes vsi igrajo isto ploščo, šteje pa tvoj prvi krog. Doseži oznake zvezdic za dodatne kovance, ohrani niz za skrinje z diamanti in poglej, kateri si danes.';

  @override
  String dailyRank(int rank, int total) {
    return '$rank. mesto od $total danes';
  }

  @override
  String get dailyRankNeedsName => 'Izberi ime, da se prikažeš na lestvici.';

  @override
  String get dailyRankingButton => 'Današnja lestvica';

  @override
  String get leaderboardTabDaily => 'Današnji izziv';

  @override
  String get leaderboardDailyFooter =>
      'Ista plošča za vse, šteje prvi krog. Vsak dan nova lestvica.';

  @override
  String notificationChestBody(int diamonds) {
    return 'Odigraj današnji izziv in odpri skrinjo niza: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'Buča';

  @override
  String get skinGhost => 'Duh';

  @override
  String get halloweenTitle => 'Noč čarovnic';

  @override
  String get halloweenBody => 'Tema Buča in skin Duh – samo oktobra.';

  @override
  String get designsBackInOctober => 'Spet oktobra';
}
