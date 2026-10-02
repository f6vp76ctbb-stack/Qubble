// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class L10nHr extends L10n {
  L10nHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Igraj';

  @override
  String get commonLater => 'Kasnije';

  @override
  String get commonNotNow => 'Ne sada';

  @override
  String get commonCancel => 'Odustani';

  @override
  String get commonBuy => 'Kupi';

  @override
  String get commonSave => 'Spremi';

  @override
  String get commonCollect => 'Pokupi';

  @override
  String get nameNewName => 'Novo ime';

  @override
  String get nameFieldLabel => 'Ime';

  @override
  String get piggyFullTitle => 'Kasica je puna!';

  @override
  String get piggyKeepSaving => 'Štedi dalje';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Skupljeno $coins od $capacity.';
  }

  @override
  String get homeContinueRun => 'Nastavi';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Razumijem';

  @override
  String get commonHome => 'Početna';

  @override
  String get commonScore => 'BODOVI';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Razina $level';
  }

  @override
  String get homeNewRun => 'Započni novu igru';

  @override
  String get homeBackToExit => 'Pritisni Natrag još jednom za izlaz';

  @override
  String get homeEnableLeaderboard => 'Uđi na ljestvicu';

  @override
  String get homeBestScore => 'NAJBOLJI REZULTAT';

  @override
  String get homeDailyChallenge => 'Dnevni izazov';

  @override
  String get homeDailyOpenToday => 'Otvoreno danas';

  @override
  String homeDailyNextIn(String time) {
    return 'Sljedeći izazov za $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Niz: $streak dana',
      few: 'Niz: $streak dana',
      one: 'Niz: $streak dan',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Ljestvica';

  @override
  String get homePuzzleMode => 'Zagonetke';

  @override
  String get homeHowToPlay => 'Kako se igra Qubble';

  @override
  String get homeWeekendBonus => 'Vikend: dvostruki novčići!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Razina $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Promijeni ime';

  @override
  String get nameChangeExplainer =>
      'Tvoje ime je tvoj identitet na ljestvici, zato se ne mijenja. Možeš kupiti jednokratnu promjenu imena.';

  @override
  String get nameChangeAfterPurchase =>
      'Nakon kupnje ponovno dodirni svoje ime i promijeni ga.';

  @override
  String get nameJoinedLeaderboard => 'Sada si na ljestvici.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'Najmanje $min znakova.',
      few: 'Najmanje $min znaka.',
      one: 'Najmanje $min znak.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'Najviše $max znakova.',
      few: 'Najviše $max znaka.',
      one: 'Najviše $max znak.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Samo latinična slova (A–Z, i s dijakriticima), brojke, razmaci, _ i -.';

  @override
  String get nameProblemOffensive => 'Odaberi drugo ime.';

  @override
  String get piggyTitle => 'Kasica';

  @override
  String get piggyFillingHint => 'Kasica se puni dok brišeš redove.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins novčića',
      few: '$coins novčića',
      one: '$coins novčić',
    );
    return 'Pokupi $_temp0 — besplatno.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kad se napuni, možeš je isprazniti besplatno — ili je otvoriti ranije uz bonus video.';

  @override
  String get piggyOpenNow => 'Otvori sada';

  @override
  String get gameNewPiecesVideo => 'Novi dijelovi (video)';

  @override
  String get gameTapBoardCell => 'Dodirni polje na ploči';

  @override
  String get gameDailyChallengeLabel => 'DNEVNI IZAZOV';

  @override
  String get gameOver => 'Kraj igre';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Za bombu ti nedostaje novčića: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomba ovdje trenutno ne radi.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Nedostaje ti novčića: $missing.';
  }

  @override
  String get gameNotRightNow => 'Trenutno nije moguće.';

  @override
  String get gameRunSaved => 'Igra je spremljena — „Nastavi” u izborniku.';

  @override
  String get gameOverNoFit => 'Nijedan tvoj dio više ne stane na ploču.';

  @override
  String get gameOverNoFitNoRotations =>
      'Nijedan dio ne stane — a okretanja su potrošena.';

  @override
  String get gameStarterOfferUnavailable => 'Trenutno nije dostupno';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — uzmi';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Postignuće: $title';
  }

  @override
  String get gameBestSubmitted => 'Novi rekord — poslano';

  @override
  String get gameReviveFor => 'Igraj dalje · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Otključano: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Početni paket';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score bodova',
      few: '$score boda',
      one: '$score bod',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Novi rekord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Niz: $streak dana',
      few: 'Niz: $streak dana',
      one: 'Niz: $streak dan',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Udvostruči novčiće';

  @override
  String get gameDoubleDaily => 'Udvostruči dnevnu nagradu';

  @override
  String get gamePlayAgain => 'Igraj ponovno';

  @override
  String gameLevelReached(int level) {
    return 'Dosegnuta razina $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count razina — razina $level!',
      few: '+$count razine — razina $level!',
      one: '+$count razina — razina $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 novčića + tema Drvo';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Još samo $hours sati — samo jednom!',
      few: 'Još samo $hours sata — samo jednom!',
      one: 'Još samo $hours sat — samo jednom!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Poništi';

  @override
  String get boosterSwap => 'Zamjena';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Nema više okretanja — briši redove da ih napuniš!';

  @override
  String get onboardingDragPiece => 'Povuci dio na mrežu';

  @override
  String get onboardingFillLine => 'Popuni cijeli red ili stupac';

  @override
  String get onboardingLinesClear => 'Puni redovi nestaju — bodovi!';

  @override
  String get coachHintCombo =>
      'Kombo! Obriši ponovno unutar 3 poteza da ga zadržiš';

  @override
  String get coachHintFever => 'GROZNICA! Dvostruki bodovi dok svijetli';

  @override
  String get coachHintRotation =>
      'Okretanje troši jedno punjenje — brisanja ga nadopunjuju';

  @override
  String get coachHintBooster => 'Savjet: dolje imaš pomagala';

  @override
  String get coachHintStrategy =>
      'Savjet: ne sve redove odjednom — ostavi mjesta za velike dijelove';

  @override
  String get dailyStreakLabel => 'Niz';

  @override
  String get dailyBestLabel => 'Dnevni rekord';

  @override
  String dailyHistoryNote(int days) {
    return 'Čuva se posljednjih $days dana.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: odigrano';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: propušteno';
  }

  @override
  String get homeDailyCalendar => 'Kalendar';

  @override
  String get dailyShareButton => 'Podijeli rezultat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Dnevni izazov $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Bodovi: $score · najbolji kombo x$combo';
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
      other: 'Kombo: još $moves poteza',
      few: 'Kombo: još $moves poteza',
      one: 'Kombo: još $moves potez',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Rezultat je kopiran u međuspremnik';

  @override
  String get adNotAvailable =>
      'Trenutno nema videa — pokušaj ponovno malo kasnije';

  @override
  String get howToPlaySpeedTitle => 'Bonus za brzinu';

  @override
  String get howToPlaySpeedBody =>
      'Brzo postavljanje dodaje brisanju do 30 %. Bonus slabi između 1,5 i 4 sekunde i ima gornju granicu, pa se brzina isplati, ali ne odlučuje igru — pažljiva spora igra i dalje može pobijediti užurbanu.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus za brzinu $percent posto';
  }

  @override
  String get iapDiamondsSmall => '100 dijamanata';

  @override
  String get iapDiamondsMedium => '350 dijamanata';

  @override
  String get iapDiamondsLarge => '1000 dijamanata';

  @override
  String get howToPlayTitle => 'Kako se igra Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Lako za početak.\nNagrađuje planiranje.';

  @override
  String get howToPlayIntroBody => 'Drži ploču slobodnom i sruši svoj rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Cilj igre. Drži ploču slobodnom i sruši svoj rekord.';

  @override
  String get howToPlayDragTitle => 'Povuci i ispusti';

  @override
  String get howToPlayDragBody =>
      'Povuci jedan od tri dijela na slobodna polja. Kad iskoristiš sva tri, automatski dobiješ tri nova.';

  @override
  String get howToPlayClearTitle => 'Briši redove';

  @override
  String get howToPlayClearBody =>
      'Popuni cijeli red ili stupac. Puni redovi nestaju i oslobađaju mjesto za sljedeći potez.';

  @override
  String get howToPlayComboTitle => 'Niži komboe';

  @override
  String get howToPlayComboBody =>
      'Obriši još jedan red unutar tri poteza. Svaki sljedeći kombo povećava množitelj bodova. Kombo broji poteze, a ne sekunde, pa ne istječe dok razmišljaš.';

  @override
  String get howToPlayFeverTitle => 'Zapali groznicu';

  @override
  String get howToPlayFeverBody =>
      'Brisanja pune mjerač groznice. Kad je pun, sljedeće veliko brisanje vrijedi dvostruko — planiraj velika brisanja unaprijed.';

  @override
  String get howToPlayBoosterTitle => 'Pametno koristi pomagala';

  @override
  String get howToPlayBoosterBody =>
      'Pomagala spašavaju tijesne igre. Dio dolje možeš i dodirnuti da ga okreneš.';

  @override
  String get howToPlayDailyTitle => 'Dnevni izazov i niz';

  @override
  String get howToPlayDailyBody =>
      'Dnevni izazov ima iste dijelove za sve. Igraj svaki dan da ti rastu niz i bonus.';

  @override
  String get howToPlayPiggyTitle => 'Napuni kasicu';

  @override
  String get howToPlayPiggyBody =>
      'Svaki obrisani red puni tvoju kasicu. Kad se napuni, novčiće možeš pokupiti besplatno.';

  @override
  String get leaderboardTitle => 'Ljestvica';

  @override
  String get leaderboardUnreachable =>
      'Ljestvica nije dostupna.\nPokušaj ponovno s internetskom vezom.';

  @override
  String get leaderboardEmpty => 'Još nema rezultata.\nBudi prvi!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Tvoj najbolji rezultat ($score) se šalje …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Tvoj najbolji rezultat šalje se automatski.';

  @override
  String get puzzleModeTitle => 'Zagonetke';

  @override
  String puzzleLevelTitle(int level) {
    return 'Zagonetka $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Potezi: $moves   •   Cilj: $target za 3 zvjezdice';
  }

  @override
  String get puzzleSolved => 'Riješeno!';

  @override
  String get puzzleLeaveTitle => 'Napustiti zagonetku?';

  @override
  String get puzzleLeaveBody => 'Napredak u ovoj zagonetki bit će izgubljen.';

  @override
  String get puzzleKeepPlaying => 'Igraj dalje';

  @override
  String get puzzleLeave => 'Napusti';

  @override
  String get puzzleStuckTitle => 'Slijepa ulica';

  @override
  String get puzzleRestart => 'Ispočetka';

  @override
  String get commonActive => 'Aktivno';

  @override
  String get commonRestore => 'Vrati';

  @override
  String get skinsExchangeGold => 'Zamijeni zlato';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Okreni dio';

  @override
  String get puzzleNextLevel => 'Sljedeća razina';

  @override
  String get puzzleBackToOverview => 'Natrag na pregled';

  @override
  String get puzzleUnsolvable => 'Odavde se ploča više ne može isprazniti.';

  @override
  String get puzzleExtraMoveVideo => 'Dodatni potez (video)';

  @override
  String get puzzleHintVideo => 'Savjet (video)';

  @override
  String get puzzleHintVideoCost => 'Savjet (video, košta jednu zvjezdicu)';

  @override
  String get puzzleNoHint =>
      'Odavde savjet nije moguć. Pokreni zagonetku ispočetka.';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Riješeno: $solved';
  }

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get storageFailureTitle => 'Qubble ne može učitati spremljenu igru';

  @override
  String get storageFailureBody =>
      'Ponovno pokreni aplikaciju. Ako greška ostane, pomaže samo ponovna instalacija. Možeš je prijaviti u Postavke › Povratne informacije.';

  @override
  String get iapUnavailable => 'Ova ponuda trenutno nije dostupna.';

  @override
  String get iapFailed => 'Kupnja nije uspjela. Ništa nije naplaćeno.';

  @override
  String get settingsResetProgress => 'Poništi napredak';

  @override
  String get settingsResetProgressSubtitle =>
      'Bodovi, novčići, razina i napredak ispočetka. Kupnje, ime i kozmetika ostaju.';

  @override
  String get settingsResetConfirmTitle => 'Poništiti napredak?';

  @override
  String get settingsResetConfirmBody =>
      'Najbolji rezultat, novčići, razina, niz i sav napredak bit će izbrisani. To se ne može vratiti.\n\nTvoje kupnje, ime te otključane teme i izgledi ostaju.';

  @override
  String get settingsResetConfirmAction => 'Poništi';

  @override
  String get settingsResetDone => 'Napredak je poništen.';

  @override
  String get settingsSectionGame => 'Igra';

  @override
  String get settingsSectionSoundHaptics => 'Zvuk i vibracija';

  @override
  String get settingsSectionReminders => 'Podsjetnici';

  @override
  String get settingsSectionPurchases => 'Kupnje';

  @override
  String get settingsSectionHelpOut => 'Pomozi';

  @override
  String get settingsSectionLegal => 'Pravne informacije';

  @override
  String get settingsSectionLanguage => 'Jezik';

  @override
  String get settingsGuide => 'Kako se igra';

  @override
  String get settingsGuideSubtitle => 'Pravila, komboi, groznica i pomagala';

  @override
  String get settingsSound => 'Zvuk';

  @override
  String get settingsMusic => 'Glazba';

  @override
  String get settingsHaptics => 'Vibracija';

  @override
  String get settingsHapticsOff => 'Isklj.';

  @override
  String get settingsHapticsLight => 'Slaba';

  @override
  String get settingsHapticsStrong => 'Jaka';

  @override
  String get settingsSectionAccessibility => 'Udobnost';

  @override
  String get settingsReducedEffects => 'Manje efekata';

  @override
  String get settingsReducedEffectsHint =>
      'Manje čestica, bez tresenja zaslona, bez sjaja';

  @override
  String get settingsNotifications => 'Obavijesti';

  @override
  String get settingsNotificationsSubtitle =>
      'Dnevni podsjetnik i zaštita niza';

  @override
  String get settingsNotificationsSystemHint =>
      'Dopusti ih u postavkama sustava.';

  @override
  String get settingsLanguageSystem => 'Jezik sustava';

  @override
  String get settingsSupporterThanks => 'Podržavatelj — hvala!';

  @override
  String get settingsSupporterPack => 'Paket podržavatelja';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ekskluzivna tema i izgled + 1500 novčića';

  @override
  String get settingsRestorePurchases => 'Vrati kupnje';

  @override
  String get settingsRestoring => 'Vraćanje kupnji…';

  @override
  String get settingsRateApp => 'Ocijeni aplikaciju';

  @override
  String get settingsRateAppSubtitle => 'Ostavi ocjenu u trgovini';

  @override
  String get settingsStoreUnavailable =>
      'Trgovina nije dostupna na ovom uređaju.';

  @override
  String get settingsFeedback => 'Pošalji povratne informacije';

  @override
  String get settingsFeedbackSubtitle => 'Ideje i greške (putem GitHuba)';

  @override
  String get settingsAdPrivacy => 'Privatnost oglasa';

  @override
  String get settingsAdPrivacySubtitle =>
      'Pregledaj ili promijeni pristanak za oglase';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Na ovom uređaju nisu potrebne postavke oglasa.';

  @override
  String get settingsPrivacy => 'Pravila privatnosti';

  @override
  String get settingsImprint => 'Impresum';

  @override
  String get settingsPageOpenFailed => 'Stranica se nije mogla otvoriti.';

  @override
  String get settingsFooter => 'Qubble • Offline slagalica s blokovima';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Admin način je uključen';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Dodirni još $count× za admin način';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins novčića',
      few: '$coins novčića',
      one: '$coins novčić',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Samo za testiranje — nikad na snimkama za izdanje';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount novčića';
  }

  @override
  String get settingsAdminResetCoins => 'Novčići na 0';

  @override
  String get feedbackTitle => 'Povratne informacije';

  @override
  String get feedbackIntroShort =>
      'Što ti se sviđa, što te živcira, što nedostaje? I sitnice pomažu — što konkretnije, to bolje.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Prilažu se samo $build i vrsta tvog uređaja — da znam o kojoj je verziji riječ.';
  }

  @override
  String get feedbackSendByMail => 'Pošalji e-poštom';

  @override
  String get feedbackPreferGithub => 'Radije issue na GitHubu';

  @override
  String get feedbackThanksMail => 'Hvala! Samo pošalji poruku.';

  @override
  String get feedbackNoMailApp =>
      'Nije pronađena aplikacija za e-poštu. Pokušaj put preko GitHuba ispod.';

  @override
  String get feedbackEmptyHint => 'Prvo nešto napiši.';

  @override
  String get leaderboardRefresh => 'Osvježi';

  @override
  String get leaderboardRetry => 'Pokušaj ponovno';

  @override
  String get feedbackHint => 'Tvoje povratne informacije…';

  @override
  String get feedbackSubmit => 'Pošalji povratne informacije';

  @override
  String get feedbackOpenFailed =>
      'GitHub se nije mogao otvoriti. Pokušaj ponovno kasnije.';

  @override
  String get feedbackGithubNote =>
      'Otvara se GitHub — ondje dodirni „Submit new issue”. (Potrebna je jednokratna prijava na GitHub.)';

  @override
  String get shopTitle => 'Trgovina';

  @override
  String get shopWebDemoNote =>
      'Kupnje postoje samo u aplikaciji iz Trgovine Play. Ova web verzija je besplatni demo — ovdje ipak možeš igrati sve.';

  @override
  String get shopSupporterExplainer =>
      'Qubble ne prikazuje nametnute oglase — nikad ništa ne moraš kupiti. Paket podržavatelja (tema Polarna svjetlost, izgled Kristal, 1500 novčića, značka podržavatelja) zahvala je za podršku igri. Kupnje su vezane uz tvoj račun u trgovini i mogu se vratiti u bilo kojem trenutku.';

  @override
  String get shopSupporterContents =>
      'Tema Polarna svjetlost + izgled Kristal + 1500 novčića';

  @override
  String get themesTitle => 'Teme';

  @override
  String get themesSupporterOnly =>
      'Samo u paketu podržavatelja (vidi trgovinu)';

  @override
  String get skinsTitle => 'Izgledi blokova';

  @override
  String get skinsNotEnoughCoins => 'Nema dovoljno novčića';

  @override
  String get skinsNotEnoughGold => 'Nema dovoljno zlata.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold zlata = 1 dijamant. Dijamanti otključavaju najljepše izglede — skupljaj bez žurbe.';
  }

  @override
  String get statsTitle => 'Statistika';

  @override
  String get statsAverageScore => 'Prosječni rezultat';

  @override
  String get statsBestCombo => 'Najbolji kombo';

  @override
  String get statsGames => 'Igre';

  @override
  String get statsLinesCleared => 'Obrisani redovi';

  @override
  String get statsPiecesPlaced => 'Postavljeni dijelovi';

  @override
  String get statsCoins => 'Novčići';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Dosegni kombo x$countString';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Osvoji $countString bodova u jednoj igri',
      few: 'Osvoji $countString boda u jednoj igri',
      one: 'Osvoji $countString bod u jednoj igri',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Postignuća';

  @override
  String get achievementFirstGameTitle => 'Prva igra';

  @override
  String get achievementFirstGameBody => 'Odigraj svoju prvu igru';

  @override
  String get achievementGames25Title => 'Stalni gost';

  @override
  String get achievementGames25Body => 'Odigraj 25 igara';

  @override
  String get achievementGames100Title => 'Navučen';

  @override
  String get achievementGames100Body => 'Odigraj 100 igara';

  @override
  String get achievementScore1kTitle => 'Penjač';

  @override
  String get achievementScore1kBody => 'Dosegni 1000 bodova';

  @override
  String get achievementScore5kTitle => 'Profesionalac';

  @override
  String get achievementScore5kBody => 'Dosegni 5000 bodova';

  @override
  String get achievementScore10kTitle => 'Majstor';

  @override
  String get achievementScore10kBody => 'Dosegni 10 000 bodova';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Dosegni 25 000 bodova';

  @override
  String get achievementLines100Title => 'Uredan';

  @override
  String get achievementLines100Body => 'Obriši ukupno 100 redova';

  @override
  String get achievementLines1000Title => 'Veliko čišćenje';

  @override
  String get achievementLines1000Body => 'Obriši ukupno 1000 redova';

  @override
  String get achievementCombo5Title => 'Kombo početnik';

  @override
  String get achievementCombo5Body => 'Dosegni kombo x5';

  @override
  String get achievementCombo10Title => 'Kombo kralj';

  @override
  String get achievementCombo10Body => 'Dosegni kombo x10';

  @override
  String get achievementLevel10Title => 'Iskusan';

  @override
  String get achievementLevel10Body => 'Dosegni razinu 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Dosegni razinu 20';

  @override
  String get achievementStreak7Title => 'Tjedni niz';

  @override
  String get achievementStreak7Body => 'Dnevni niz od 7 dana';

  @override
  String get achievementStreak30Title => 'Mjesečni niz';

  @override
  String get achievementStreak30Body => 'Dnevni niz od 30 dana';

  @override
  String get achievementPuzzles10Title => 'Rješavač';

  @override
  String get achievementPuzzles10Body => 'Riješi 10 zagonetki';

  @override
  String get achievementPieces5000Title => 'Graditelj';

  @override
  String get achievementPieces5000Body => 'Postavi 5000 dijelova';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Tvoj niz od $streak dana je u opasnosti!',
      few: 'Tvoj niz od $streak dana je u opasnosti!',
      one: 'Tvoj niz od $streak dana je u opasnosti!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Jučer je propušteno — spasi svoj niz:';

  @override
  String get streakRepairFailed => 'Popravak nije moguć.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins novčića',
      few: '$coins novčića',
      one: '$coins novčić',
    );
    return 'Dobro došli natrag! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Podsjetnici?';

  @override
  String get notificationsOptInBody =>
      'Da te podsjećamo na dnevnu zagonetku i čuvamo tvoj niz? To možeš promijeniti bilo kada u postavkama.';

  @override
  String get notificationsOptInAccept => 'Da, molim';

  @override
  String get notificationChannelDescription =>
      'Dnevni podsjetnik, upozorenje za niz, poziv natrag';

  @override
  String get notificationDailyTitle => 'Tvoja dnevna zagonetka čeka 🧩';

  @override
  String get notificationDailyBody => 'Odigraj današnji izazov!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Tvoj niz od $streak dana je u opasnosti!',
      few: 'Tvoj niz od $streak dana je u opasnosti!',
      one: 'Tvoj niz od $streak dana je u opasnosti!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'Igraj danas da ga sačuvaš.';

  @override
  String get notificationComebackTitle => 'Tvoja zagonetka te čeka 🧩';

  @override
  String get notificationComebackBody => 'Vrati se i pokupi poklon!';

  @override
  String get iapSupporterPack => 'Paket podržavatelja';

  @override
  String get iapCoinsSmall => '500 novčića';

  @override
  String get iapCoinsMedium => '2000 novčića';

  @override
  String get iapCoinsLarge => '6000 novčića';

  @override
  String get iapStarterPack => 'Početni paket';

  @override
  String get iapRename => 'Promjena imena';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Izbriši unos na ljestvici';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Uklanja tvoje ime i rezultat s javnog popisa';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Izbrisati tvoj unos?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tvoje ime i rezultat bit će uklonjeni s ljestvice. Napredak u igri ostaje netaknut. Na ljestvicu se možeš vratiti bilo kada.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Tvoj unos na ljestvici je izbrisan.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Unos se nije mogao izbrisati. Provjeri vezu i pokušaj ponovno.';

  @override
  String get leaderboardReport => 'Prijavi ovo ime';

  @override
  String get leaderboardBlock => 'Sakrij';

  @override
  String leaderboardBlocked(String name) {
    return '$name je skriven za tebe';
  }

  @override
  String get leaderboardUndo => 'Poništi';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Skriveni unosi: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Prikaži ponovno';

  @override
  String get leaderboardReportUnavailable => 'Prijava trenutno nije dostupna.';

  @override
  String get leaderboardReportSent => 'Hvala — prijava je poslana.';

  @override
  String get leaderboardRules =>
      'Imena su javna. Bez uvreda, bez psovki i bez ičega što otkriva stvarnu osobu. Imena koja krše pravila uklanjaju se.';

  @override
  String get leaderboardRulesAccept => 'Razumijem';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Otključano $unlocked od $total';
  }

  @override
  String get settingsSectionData => 'Spremljeni podaci';

  @override
  String get gameRotatePiece => 'Okreni dio';

  @override
  String get themeClassic => 'Klasična';

  @override
  String get themeFade => 'Pastelna';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeWood => 'Drvo';

  @override
  String get themeSunset => 'Zalazak sunca';

  @override
  String get themeForest => 'Šuma';

  @override
  String get themeAurora => 'Polarna svjetlost';

  @override
  String get skinClassic => 'Klasični';

  @override
  String get skinGradient => 'Prijelaz';

  @override
  String get skinOutline => 'Obris';

  @override
  String get skinGlossy => 'Sjajni';

  @override
  String get skinStripe => 'Pruge';

  @override
  String get skinBevel => 'Ukošeni';

  @override
  String get skinGlow => 'Sjaj';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Izgled $name';
  }

  @override
  String get skinPulse => 'Puls';

  @override
  String get skinShimmer => 'Svjetlucanje';

  @override
  String get skinWave => 'Val';

  @override
  String get skinEmber => 'Žar';

  @override
  String get skinPrism => 'Prizma';

  @override
  String get skinStardust => 'Zvjezdana prašina';

  @override
  String get skinCircuit => 'Strujni krug';

  @override
  String get skinRipple => 'Valići';

  @override
  String achievementRewardSkin(String name) {
    return 'Animirani izgled: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Nagrada za postignuće: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Postignuća sada donose nagrade — tvoje su dodane.';

  @override
  String get namePromptBody =>
      'Odaberi ime i tvoj najbolji rezultat ide na ljestvicu. Bez imena igraš dalje anonimno.';

  @override
  String get nameTaken => 'Ovo je ime već zauzeto. Pokušaj s nekim drugim.';

  @override
  String get nameCheckFailed =>
      'Ime nije bilo moguće provjeriti. Jesi li na internetu? Pokušaj ponovno za trenutak.';

  @override
  String nameLost(String name) {
    return '$name sada pripada drugom igraču. Odaberi novo ime – besplatno.';
  }

  @override
  String get themeCandy => 'Bombon';

  @override
  String get themeVolcano => 'Vulkan';

  @override
  String get themeGlacier => 'Ledenjak';

  @override
  String get skinPixel => 'Piksel';

  @override
  String get skinMarble => 'Mramor';

  @override
  String get skinJelly => 'Žele';

  @override
  String get skinLiquid => 'Tekućina';

  @override
  String get skinFizz => 'Mjehurići';

  @override
  String get skinPlasma => 'Plazma';

  @override
  String get designsTitle => 'Dizajni';

  @override
  String get designsNotEnoughDiamonds => 'Nema dovoljno dijamanata.';

  @override
  String get designsOwned => 'Tvoje';

  @override
  String get designsAchievementOnly => 'Postignuće';

  @override
  String get designsSupporterOnly => 'Podrška';

  @override
  String get designsPreview => 'Pregled';

  @override
  String get designsGetDiamonds => 'Nabavi dijamante';

  @override
  String get shopDealTitle => 'Ponuda dana';

  @override
  String get shopAnimatedSkins => 'Animirani izgledi';

  @override
  String get shopNewDesigns => 'Novi dizajni';

  @override
  String get shopDiamonds => 'Dijamanti';

  @override
  String get shopPacks => 'Paketi';

  @override
  String get shopPopular => 'Popularno';

  @override
  String get shopBestValue => 'Najisplativije';

  @override
  String get shopDiamondsBlurb => 'Za animirane izglede i nove dizajne.';

  @override
  String get shopCoinsBlurb => 'Za teme, izglede i pomagala.';

  @override
  String get shopNeonBlurb => 'Odmah otključava temu Neon.';

  @override
  String get shopRenameBlurb => 'Promijeni ime na ljestvici.';

  @override
  String shopHoursLeft(int hours) {
    return 'Još $hours h';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Nova ponuda za $time';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name otključano!';
  }

  @override
  String get questsTitle => 'Zadaci';

  @override
  String get questsDaily => 'Dnevni';

  @override
  String get questsWeekly => 'Tjedni';

  @override
  String get questsMonthly => 'Mjesečni';

  @override
  String questsNewIn(String time) {
    return 'Novi zadaci za $time';
  }

  @override
  String get questsBonus => 'Bonus za sve';

  @override
  String get questsBonusEarned => 'Bonus osvojen';

  @override
  String get questRounds => 'Igraj runde';

  @override
  String get questLines => 'Obriši redove';

  @override
  String get questPieces => 'Postavi dijelove';

  @override
  String get questDailyChallenge => 'Igraj dnevni izazov';

  @override
  String get questPuzzles => 'Riješi nove zagonetke';

  @override
  String get questDays => 'Igraj različitih dana';

  @override
  String get questDailySets => 'Završi sve dnevne zadatke';

  @override
  String get questsSetDaily => 'Svi dnevni zadaci su gotovi!';

  @override
  String get questsSetWeekly => 'Svi tjedni zadaci su gotovi!';

  @override
  String get questsSetMonthly => 'Svi mjesečni zadaci su gotovi!';

  @override
  String get leaderboardTabScore => 'Najbolji rezultat';

  @override
  String get leaderboardTabPuzzle => 'Zvjezdice zagonetki';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Tvoje zvjezdice iz zagonetki šalju se automatski.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Tvoje zvjezdice iz zagonetki ($stars) se šalju …';
  }

  @override
  String get dailyGoalTitle => 'Današnji cilj';

  @override
  String dailyGoalPoints(String points) {
    return '$points bodova';
  }

  @override
  String get dailyChestOpened => 'Škrinja niza otvorena!';

  @override
  String dailyNextChest(int day) {
    return 'Sljedeća škrinja: $day. dan niza';
  }

  @override
  String get dailyExplainer =>
      'Danas svi igraju istu ploču, a računa se tvoja prva runda. Dosegni oznake zvjezdica za dodatne novčiće, održi niz za škrinje dijamanata i pogledaj koji si danas.';

  @override
  String dailyRank(int rank, int total) {
    return '$rank. mjesto od $total danas';
  }

  @override
  String get dailyRankNeedsName => 'Odaberi ime da se pojaviš na ljestvici.';

  @override
  String get dailyRankingButton => 'Današnja ljestvica';

  @override
  String get leaderboardTabDaily => 'Današnji izazov';

  @override
  String get leaderboardDailyFooter =>
      'Ista ploča za sve, računa se prva runda. Svaki dan nova ljestvica.';

  @override
  String notificationChestBody(int diamonds) {
    return 'Odigraj današnji izazov i otvori škrinju niza: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'Bundeva';

  @override
  String get skinGhost => 'Duh';

  @override
  String get halloweenTitle => 'Halloween';

  @override
  String get halloweenBody => 'Tema Bundeva i skin Duh – samo u listopadu.';

  @override
  String get designsBackInOctober => 'Opet u listopadu';

  @override
  String get shopFreeTitle => 'Besplatni bonus';

  @override
  String get shopFreeWatch => 'Pogledaj video';

  @override
  String shopFreeToday(int left, int total) {
    return 'Danas: $left/$total';
  }

  @override
  String get shopFreeTomorrow => 'Opet sutra';

  @override
  String get designsAccessories => 'Dodaci';

  @override
  String get designsBursts => 'Eksplozije';

  @override
  String get accessoryNone => 'Ništa';

  @override
  String get accessoryCobweb => 'Paučina';

  @override
  String get accessorySnowCap => 'Snježna kapa';

  @override
  String get accessoryCrown => 'Kruna';

  @override
  String get accessoryFlower => 'Cvijet';

  @override
  String get accessorySparkle => 'Iskrica';

  @override
  String get accessoryDewdrop => 'Kap rose';

  @override
  String get burstClassic => 'Klasična';

  @override
  String get burstConfetti => 'Konfeti';

  @override
  String get burstFire => 'Vatra';

  @override
  String get burstPixels => 'Pikseli';

  @override
  String get burstStars => 'Zvijezde';

  @override
  String get burstBubbles => 'Mjehurići';

  @override
  String bestShareText(String score) {
    return 'Moj novi Qubble rekord: $score bodova! Možeš li ga oboriti?';
  }
}
