// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class L10nLt extends L10n {
  L10nLt([String locale = 'lt']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Žaisti';

  @override
  String get commonLater => 'Vėliau';

  @override
  String get commonNotNow => 'Ne dabar';

  @override
  String get commonCancel => 'Atšaukti';

  @override
  String get commonBuy => 'Pirkti';

  @override
  String get commonSave => 'Išsaugoti';

  @override
  String get commonCollect => 'Pasiimti';

  @override
  String get nameNewName => 'Naujas vardas';

  @override
  String get nameFieldLabel => 'Vardas';

  @override
  String get piggyFullTitle => 'Taupyklė pilna!';

  @override
  String get piggyKeepSaving => 'Taupyti toliau';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Surinkta $coins iš $capacity.';
  }

  @override
  String get homeContinueRun => 'Tęsti';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Supratau';

  @override
  String get commonHome => 'Pradžia';

  @override
  String get commonScore => 'TAŠKAI';

  @override
  String get commonBest => 'REKORDAS';

  @override
  String commonLevelShort(int level) {
    return '$level lygis';
  }

  @override
  String get homeNewRun => 'Pradėti naują žaidimą';

  @override
  String get homeBackToExit => 'Norėdamas išeiti, dar kartą paspausk „Atgal“';

  @override
  String get homeEnableLeaderboard => 'Prisijungti prie lyderių lentelės';

  @override
  String get homeBestScore => 'REKORDAS';

  @override
  String get homeDailyChallenge => 'Dienos iššūkis';

  @override
  String get homeDailyOpenToday => 'Laukia šiandien';

  @override
  String homeDailyNextIn(String time) {
    return 'Kitas iššūkis po $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'Serija: $streak d.';
  }

  @override
  String get homeLeaderboard => 'Lyderių lentelė';

  @override
  String get homePuzzleMode => 'Galvosūkių režimas';

  @override
  String get homeMissions => 'Užduotys';

  @override
  String get homeThemes => 'Temos';

  @override
  String get homeSkins => 'Išvaizdos';

  @override
  String get homeHowToPlay => 'Kaip žaisti Qubble';

  @override
  String get homeWeekendBonus => 'Savaitgalis: dvigubos monetos!';

  @override
  String homeNextUnlock(int level, String name) {
    return '$level lygis: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Pakeisti vardą';

  @override
  String get nameChangeExplainer =>
      'Tavo vardas – tavo tapatybė lyderių lentelėje, todėl jis nekeičiamas. Gali nusipirkti vienkartinį vardo pakeitimą.';

  @override
  String get nameChangeAfterPurchase =>
      'Po pirkimo dar kartą paliesk savo vardą, kad jį pakeistum.';

  @override
  String get nameJoinedLeaderboard => 'Dabar esi lyderių lentelėje.';

  @override
  String get nameRenameUnavailable => 'Šiuo metu vardo pakeisti negalima.';

  @override
  String nameProblemTooShort(int min) {
    return 'Mažiausiai simbolių: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Daugiausiai simbolių: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Tik raidės be lietuviškų ženklų (A–Z), skaičiai, tarpai, _ ir -.';

  @override
  String get nameProblemOffensive => 'Pasirink kitą vardą.';

  @override
  String get piggyTitle => 'Taupyklė';

  @override
  String get piggyFillingHint => 'Taupyklė pildosi, kai valai eilutes.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monetų',
      few: '$coins monetas',
      one: '$coins monetą',
    );
    return 'Pasiimk $_temp0 – nemokamai.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kai ji prisipildys, galėsi ją ištuštinti nemokamai – arba atidaryti anksčiau su premijiniu vaizdo įrašu.';

  @override
  String get piggyOpenNow => 'Atidaryti dabar';

  @override
  String get gameNewPiecesVideo => 'Naujos figūros (video)';

  @override
  String get gameTapBoardCell => 'Paliesk lentos langelį';

  @override
  String get gameDailyChallengeLabel => 'DIENOS IŠŠŪKIS';

  @override
  String get gameOver => 'Žaidimas baigtas';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Bombai trūksta monetų: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomba čia šiuo metu neveikia.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Tam trūksta monetų: $missing.';
  }

  @override
  String get gameNotRightNow => 'Šiuo metu neįmanoma.';

  @override
  String get gameRunSaved => 'Žaidimas išsaugotas – meniu rasi „Tęsti“.';

  @override
  String get gameOverNoFit => 'Nė viena tavo figūra nebetelpa į lentą.';

  @override
  String get gameOverNoFitNoRotations =>
      'Nė viena tavo figūra netelpa – o pasukimai baigėsi.';

  @override
  String get gameStarterOfferUnavailable => 'Šiuo metu nepasiekiama';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price – gauti';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Pasiekimas: $title';
  }

  @override
  String get gameBestSubmitted => 'Naujas rekordas išsiųstas';

  @override
  String get gameReviveFor => 'Žaisti toliau · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Atrakinta: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pradžios paketas';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score taškų',
      few: '$score taškai',
      one: '$score taškas',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Naujas rekordas!';

  @override
  String gameStreakDays(int streak) {
    return 'Serija: $streak d.';
  }

  @override
  String get gameDoubleCoins => 'Dvigubinti monetas';

  @override
  String get gameDoubleDaily => 'Dvigubinti dienos prizą';

  @override
  String get gamePlayAgain => 'Žaisti dar kartą';

  @override
  String gameLevelReached(int level) {
    return 'Pasiektas $level lygis!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count lygių – dabar $level lygis!',
      few: '+$count lygiai – dabar $level lygis!',
      one: '+$count lygis – dabar $level lygis!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 monetų + tema „Mediena“';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Liko tik $hours val. – vienintelį kartą!';
  }

  @override
  String get boosterUndo => 'Atšaukti';

  @override
  String get boosterSwap => 'Keisti';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Pasukimų neliko – valyk eilutes, kad jų gautum!';

  @override
  String get onboardingDragPiece => 'Nutempk bloką į lentą';

  @override
  String get onboardingFillLine => 'Užpildyk visą eilutę ar stulpelį';

  @override
  String get onboardingLinesClear => 'Pilnos linijos išnyksta – taškai!';

  @override
  String get coachHintCombo =>
      'Kombo! Išvalyk dar per 3 ėjimus, kad jis tęstųsi';

  @override
  String get coachHintFever => 'KARŠTINĖ! Dvigubi taškai, kol švyti';

  @override
  String get coachHintRotation =>
      'Pasukimas kainuoja krūvį – valymai jį papildo';

  @override
  String get coachHintBooster => 'Patarimas: apačioje gali naudoti stipriklius';

  @override
  String get coachHintStrategy =>
      'Patarimas: ne visas linijas iškart – palik vietos didelėms figūroms';

  @override
  String get dailyStreakLabel => 'Serija';

  @override
  String get dailyBestLabel => 'Dienos rekordas';

  @override
  String dailyHistoryNote(int days) {
    return 'Saugoma paskutinių dienų: $days.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day d.: žaista';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day d.: nežaista';
  }

  @override
  String get homeDailyCalendar => 'Kalendorius';

  @override
  String get dailyShareButton => 'Dalintis rezultatu';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Dienos iššūkis $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Taškai: $score · geriausias kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Žaisk: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo – liko ėjimų: $moves';
  }

  @override
  String get dailyShareCopied => 'Rezultatas nukopijuotas į iškarpinę';

  @override
  String get adNotAvailable =>
      'Šiuo metu vaizdo įrašo nėra – pabandyk po akimirkos';

  @override
  String get howToPlaySpeedTitle => 'Greičio premija';

  @override
  String get howToPlaySpeedBody =>
      'Greitai dedant prie kiekvieno išvalymo pridedama iki 30 %. Premija mažėja nuo 1,5 iki 4 sekundžių ir turi ribą, todėl greitis apsimoka, bet žaidimo nenulemia – kruopštus lėtas žaidimas vis tiek gali aplenkti skubotą greitą.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Greičio premija $percent procentų';
  }

  @override
  String get iapDiamondsSmall => '100 deimantų';

  @override
  String get iapDiamondsMedium => '350 deimantų';

  @override
  String get iapDiamondsLarge => '1 000 deimantų';

  @override
  String get howToPlayTitle => 'Kaip žaisti Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Lengva pradėti.\nApdovanoja planuojančius.';

  @override
  String get howToPlayIntroBody =>
      'Laikyk lentą laisvą ir pagerink savo rekordą.';

  @override
  String get howToPlayIntroSemantics =>
      'Žaidimo tikslas. Laikyk lentą laisvą ir pagerink savo rekordą.';

  @override
  String get howToPlayDragTitle => 'Tempk ir padėk';

  @override
  String get howToPlayDragBody =>
      'Nutempk vieną iš trijų figūrų į laisvus langelius. Panaudojus visas tris, automatiškai gausi tris naujas.';

  @override
  String get howToPlayClearTitle => 'Valyk linijas';

  @override
  String get howToPlayClearBody =>
      'Užpildyk visą eilutę ar stulpelį. Pilnos linijos išnyksta ir atlaisvina vietos kitam ėjimui.';

  @override
  String get howToPlayComboTitle => 'Junk kombo';

  @override
  String get howToPlayComboBody =>
      'Išvalyk kitą liniją per tris ėjimus. Kiekvienas tolesnis kombo didina taškų daugiklį. Kombo skaičiuoja ėjimus, ne sekundes, todėl niekada nesibaigia, kol galvoji.';

  @override
  String get howToPlayFeverTitle => 'Įjunk karštinę';

  @override
  String get howToPlayFeverBody =>
      'Valymai pildo karštinės matuoklį. Kai jis pilnas, kitas sprogimas skaičiuojamas dvigubai – didelius valymus planuok iš anksto.';

  @override
  String get howToPlayBoosterTitle => 'Stipriklius naudok protingai';

  @override
  String get howToPlayBoosterBody =>
      'Stiprikliai išgelbsti sunkius žaidimus. Figūrą apačioje taip pat gali paliesti, kad ją pasuktum.';

  @override
  String get howToPlayDailyTitle => 'Dienos iššūkis ir serija';

  @override
  String get howToPlayDailyBody =>
      'Dienos iššūkyje visi gauna tas pačias figūras. Žaisk kasdien, kad augintum seriją ir premiją.';

  @override
  String get howToPlayPiggyTitle => 'Pripildyk taupyklę';

  @override
  String get howToPlayPiggyBody =>
      'Kiekviena išvalyta linija pildo taupyklę. Kai ji pilna, monetas gali pasiimti nemokamai.';

  @override
  String get leaderboardTitle => 'Lyderių lentelė';

  @override
  String get leaderboardUnreachable =>
      'Lyderių lentelė nepasiekiama.\nPabandyk dar kartą prisijungęs prie interneto.';

  @override
  String get leaderboardEmpty => 'Kol kas įrašų nėra.\nBūk pirmas!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Tavo rekordas ($score) siunčiamas …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Tavo rekordas išsiunčiamas automatiškai.';

  @override
  String get puzzleModeTitle => 'Galvosūkių režimas';

  @override
  String puzzleLevelTitle(int level) {
    return 'Galvosūkis $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Ėjimai: $moves   •   Tikslas 3 žvaigždutėms: $target';
  }

  @override
  String get puzzleSolved => 'Išspręsta!';

  @override
  String get puzzleLeaveTitle => 'Palikti galvosūkį?';

  @override
  String get puzzleLeaveBody => 'Šio galvosūkio pažanga bus prarasta.';

  @override
  String get puzzleKeepPlaying => 'Žaisti toliau';

  @override
  String get puzzleLeave => 'Palikti';

  @override
  String get puzzleStuckTitle => 'Aklavietė';

  @override
  String get puzzleRestart => 'Iš naujo';

  @override
  String get commonActive => 'Aktyvi';

  @override
  String get commonTapToActivate => 'Paliesk, kad įjungtum';

  @override
  String get commonRestore => 'Atkurti';

  @override
  String unlockForCost(int cost) {
    return 'Atrakinti už $cost';
  }

  @override
  String get skinsExchangeGold => 'Keisti auksą';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Pasukti figūrą';

  @override
  String get puzzleNextLevel => 'Kitas lygis';

  @override
  String get puzzleBackToOverview => 'Atgal į sąrašą';

  @override
  String get puzzleUnsolvable => 'Iš čia lentos nebeįmanoma ištuštinti.';

  @override
  String get puzzleExtraMoveVideo => 'Papildomas ėjimas (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Išspręsta: $solved';
  }

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get storageFailureTitle => 'Qubble negali įkelti išsaugoto žaidimo';

  @override
  String get storageFailureBody =>
      'Paleisk programėlę iš naujo. Jei klaida kartojasi, padės tik įdiegimas iš naujo. Apie ją gali pranešti per Nustatymai › Atsiliepimai.';

  @override
  String get iapUnavailable => 'Šis pasiūlymas šiuo metu nepasiekiamas.';

  @override
  String get iapFailed => 'Pirkimas nepavyko. Pinigai nenuskaičiuoti.';

  @override
  String get settingsResetProgress => 'Atstatyti pažangą';

  @override
  String get settingsResetProgressSubtitle =>
      'Taškai, monetos, lygis ir pažanga grįžta į pradžią. Pirkiniai, vardas ir kosmetika lieka.';

  @override
  String get settingsResetConfirmTitle => 'Atstatyti pažangą?';

  @override
  String get settingsResetConfirmBody =>
      'Bus ištrinti rekordas, monetos, lygis, serija ir visa pažanga. To atšaukti negalima.\n\nTavo pirkiniai, vardas ir atrakintos temos bei išvaizdos lieka.';

  @override
  String get settingsResetConfirmAction => 'Atstatyti';

  @override
  String get settingsResetDone => 'Pažanga atstatyta.';

  @override
  String get settingsSectionGame => 'Žaidimas';

  @override
  String get settingsSectionSoundHaptics => 'Garsas ir vibracija';

  @override
  String get settingsSectionReminders => 'Priminimai';

  @override
  String get settingsSectionPurchases => 'Pirkiniai';

  @override
  String get settingsSectionHelpOut => 'Padėk';

  @override
  String get settingsSectionLegal => 'Teisinė informacija';

  @override
  String get settingsSectionLanguage => 'Kalba';

  @override
  String get settingsGuide => 'Kaip žaisti';

  @override
  String get settingsGuideSubtitle =>
      'Taisyklės, kombo, karštinė ir stiprikliai';

  @override
  String get settingsSound => 'Garsas';

  @override
  String get settingsMusic => 'Muzika';

  @override
  String get settingsHaptics => 'Vibracija';

  @override
  String get settingsHapticsOff => 'Išjungta';

  @override
  String get settingsHapticsLight => 'Silpna';

  @override
  String get settingsHapticsStrong => 'Stipri';

  @override
  String get settingsSectionAccessibility => 'Patogumas';

  @override
  String get settingsReducedEffects => 'Mažiau efektų';

  @override
  String get settingsReducedEffectsHint =>
      'Mažiau dalelių, be ekrano drebėjimo ir švytėjimo';

  @override
  String get settingsNotifications => 'Pranešimai';

  @override
  String get settingsNotificationsSubtitle =>
      'Dienos priminimas ir serijos apsauga';

  @override
  String get settingsNotificationsSystemHint =>
      'Leisk tai sistemos nustatymuose.';

  @override
  String get settingsLanguageSystem => 'Sistemos kalba';

  @override
  String get settingsSupporterThanks => 'Rėmėjas – ačiū!';

  @override
  String get settingsSupporterPack => 'Rėmėjo paketas';

  @override
  String get settingsSupporterPackSubtitle =>
      'Išskirtinė tema ir išvaizda + 1 500 monetų';

  @override
  String get settingsRestorePurchases => 'Atkurti pirkinius';

  @override
  String get settingsRestoring => 'Atkuriami pirkiniai…';

  @override
  String get settingsRateApp => 'Įvertinti programėlę';

  @override
  String get settingsRateAppSubtitle => 'Palik įvertinimą parduotuvėje';

  @override
  String get settingsStoreUnavailable =>
      'Parduotuvė šiame įrenginyje nepasiekiama.';

  @override
  String get settingsFeedback => 'Siųsti atsiliepimą';

  @override
  String get settingsFeedbackSubtitle =>
      'Pranešk apie idėjas ir klaidas (per GitHub)';

  @override
  String get settingsAdPrivacy => 'Reklamos privatumas';

  @override
  String get settingsAdPrivacySubtitle =>
      'Peržiūrėk ar pakeisk sutikimą dėl reklamos';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Šiame įrenginyje reklamos parinkčių nereikia.';

  @override
  String get settingsPrivacy => 'Privatumo politika';

  @override
  String get settingsImprint => 'Rekvizitai';

  @override
  String get settingsPageOpenFailed => 'Puslapio atidaryti nepavyko.';

  @override
  String get settingsFooter => 'Qubble • Blokų galvosūkis be interneto';

  @override
  String get settingsAdminSection => 'Administratorius (testas)';

  @override
  String get settingsAdminEnabled => 'Administratoriaus režimas įjungtas';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Iki administratoriaus režimo liko paliesti: $count';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monetų',
      few: '$coins monetos',
      one: '$coins moneta',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Tik testavimui – niekada nerodyti leidimo ekrano kopijose';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount monetų',
      few: '$amount monetos',
      one: '$amount moneta',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Nustatyti 0 monetų';

  @override
  String get feedbackTitle => 'Atsiliepimai';

  @override
  String get feedbackIntroShort =>
      'Kas patinka, kas erzina, ko trūksta? Padeda ir smulkmenos – kuo konkrečiau, tuo geriau.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Pridedama tik $build ir įrenginio tipas – kad žinočiau, apie kurią versiją kalbi.';
  }

  @override
  String get feedbackSendByMail => 'Siųsti el. paštu';

  @override
  String get feedbackPreferGithub => 'Geriau GitHub issue';

  @override
  String get feedbackThanksMail => 'Ačiū! Tereikia išsiųsti laišką.';

  @override
  String get feedbackNoMailApp =>
      'El. pašto programėlė nerasta. Išbandyk GitHub būdą žemiau.';

  @override
  String get feedbackEmptyHint => 'Pirmiausia ką nors parašyk.';

  @override
  String get leaderboardRefresh => 'Atnaujinti';

  @override
  String get leaderboardRetry => 'Bandyti dar kartą';

  @override
  String get feedbackHint => 'Tavo atsiliepimas…';

  @override
  String get feedbackSubmit => 'Siųsti atsiliepimą';

  @override
  String get feedbackOpenFailed =>
      'Nepavyko atidaryti GitHub. Pabandyk vėliau.';

  @override
  String get feedbackGithubNote =>
      'Atsidaro GitHub – ten paliesk \"Submit new issue\". (Reikia vieną kartą prisijungti prie GitHub.)';

  @override
  String get shopTitle => 'Parduotuvė';

  @override
  String get shopWebDemoNote =>
      'Pirkiniai galimi tik programėlėje iš Play Store. Ši žiniatinklio versija – nemokama demonstracinė: vis tiek gali čia žaisti viską.';

  @override
  String get shopSupporterExplainer =>
      'Qubble nerodo privalomos reklamos – niekada nieko pirkti neprivalai. Rėmėjo paketas (tema „Aurora“, išvaizda „Kristalas“, 1 500 monetų, rėmėjo ženklelis) – padėka už žaidimo rėmimą. Pirkiniai susieti su tavo parduotuvės paskyra ir gali būti atkurti bet kada.';

  @override
  String get shopSupporterContents =>
      'Tema „Aurora“ + išvaizda „Kristalas“ + 1 500 monetų';

  @override
  String get themesTitle => 'Temos';

  @override
  String get themesSupporterOnly => 'Tik rėmėjo pakete (žr. parduotuvę)';

  @override
  String get themesInSupporterPack => 'Rėmėjo pakete';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Trūksta monetų (reikia: $cost, turi: $coins)';
  }

  @override
  String get skinsTitle => 'Blokų išvaizdos';

  @override
  String get skinsNotEnoughDiamonds =>
      'Trūksta deimantų (iškeisk auksą žemiau)';

  @override
  String get skinsNotEnoughCoins => 'Trūksta monetų';

  @override
  String get skinsNotEnoughGold => 'Trūksta aukso.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold aukso = 1 deimantas. Deimantai atrakina gražiausias išvaizdas – rink neskubėdamas.';
  }

  @override
  String get statsTitle => 'Statistika';

  @override
  String get statsAverageScore => 'Vid. taškai';

  @override
  String get statsBestCombo => 'Geriausias kombo';

  @override
  String get statsGames => 'Žaidimai';

  @override
  String get statsLinesCleared => 'Išvalytos eilutės';

  @override
  String get statsPiecesPlaced => 'Padėtos figūros';

  @override
  String get statsCoins => 'Monetos';

  @override
  String get missionsTitle => 'Užduotys';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Padėk $countString figūrų',
      few: 'Padėk $countString figūras',
      one: 'Padėk $countString figūrą',
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
      other: 'Išvalyk $countString eilučių',
      few: 'Išvalyk $countString eilutes',
      one: 'Išvalyk $countString eilutę',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Pasiek kombo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Surink $countString taškų per vieną žaidimą',
      few: 'Surink $countString taškus per vieną žaidimą',
      one: 'Surink $countString tašką per vieną žaidimą',
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
      other: 'Sužaisk $countString žaidimų',
      few: 'Sužaisk $countString žaidimus',
      one: 'Sužaisk $countString žaidimą',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Pasiekimai';

  @override
  String get achievementFirstGameTitle => 'Pirmasis žaidimas';

  @override
  String get achievementFirstGameBody => 'Sužaisk pirmąjį žaidimą';

  @override
  String get achievementGames25Title => 'Nuolatinis';

  @override
  String get achievementGames25Body => 'Sužaisk 25 žaidimus';

  @override
  String get achievementGames100Title => 'Užkibęs';

  @override
  String get achievementGames100Body => 'Sužaisk 100 žaidimų';

  @override
  String get achievementScore1kTitle => 'Kopėjas';

  @override
  String get achievementScore1kBody => 'Surink 1 000 taškų';

  @override
  String get achievementScore5kTitle => 'Profesionalas';

  @override
  String get achievementScore5kBody => 'Surink 5 000 taškų';

  @override
  String get achievementScore10kTitle => 'Meistras';

  @override
  String get achievementScore10kBody => 'Surink 10 000 taškų';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Surink 25 000 taškų';

  @override
  String get achievementLines100Title => 'Tvarkingas';

  @override
  String get achievementLines100Body => 'Iš viso išvalyk 100 eilučių';

  @override
  String get achievementLines1000Title => 'Didysis valytojas';

  @override
  String get achievementLines1000Body => 'Iš viso išvalyk 1 000 eilučių';

  @override
  String get achievementCombo5Title => 'Kombo pradžiamokslis';

  @override
  String get achievementCombo5Body => 'Pasiek kombo x5';

  @override
  String get achievementCombo10Title => 'Kombo karalius';

  @override
  String get achievementCombo10Body => 'Pasiek kombo x10';

  @override
  String get achievementLevel10Title => 'Patyręs';

  @override
  String get achievementLevel10Body => 'Pasiek 10 lygį';

  @override
  String get achievementLevel20Title => 'Veteranas';

  @override
  String get achievementLevel20Body => 'Pasiek 20 lygį';

  @override
  String get achievementStreak7Title => 'Savaitės serija';

  @override
  String get achievementStreak7Body => '7 dienų dienos iššūkių serija';

  @override
  String get achievementStreak30Title => 'Mėnesio serija';

  @override
  String get achievementStreak30Body => '30 dienų dienos iššūkių serija';

  @override
  String get achievementPuzzles10Title => 'Galvosūkių mėgėjas';

  @override
  String get achievementPuzzles10Body => 'Išspręsk 10 galvosūkių';

  @override
  String get achievementPieces5000Title => 'Statytojas';

  @override
  String get achievementPieces5000Body => 'Padėk 5 000 figūrų';

  @override
  String streakRepairTitle(int streak) {
    return 'Tavo serijai ($streak d.) gresia pavojus!';
  }

  @override
  String get streakRepairBody => 'Vakar nežaidei – išgelbėk savo seriją:';

  @override
  String get streakRepairFailed => 'Atkurti neįmanoma.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monetų',
      few: '$coins monetos',
      one: '$coins moneta',
    );
    return 'Sveikas sugrįžęs! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Priminimai?';

  @override
  String get notificationsOptInBody =>
      'Ar priminti tau apie dienos galvosūkį ir saugoti tavo seriją? Tai bet kada gali pakeisti nustatymuose.';

  @override
  String get notificationsOptInAccept => 'Taip, prašau';

  @override
  String get notificationChannelDescription =>
      'Dienos priminimas, įspėjimas dėl serijos, sugrįžimas';

  @override
  String get notificationDailyTitle => 'Tavo dienos galvosūkis laukia 🧩';

  @override
  String get notificationDailyBody => 'Sužaisk šiandienos iššūkį!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Tavo serijai ($streak d.) gresia pavojus!';
  }

  @override
  String get notificationStreakBody => 'Sužaisk šiandien, kad ją išsaugotum.';

  @override
  String get notificationComebackTitle => 'Tavo blokai tavęs pasiilgo 🧩';

  @override
  String get notificationComebackBody => 'Sugrįžk ir pasiimk dovaną!';

  @override
  String get iapSupporterPack => 'Rėmėjo paketas';

  @override
  String get iapCoinsSmall => '500 monetų';

  @override
  String get iapCoinsMedium => '2 000 monetų';

  @override
  String get iapCoinsLarge => '6 000 monetų';

  @override
  String get iapStarterPack => 'Pradžios paketas';

  @override
  String get iapRename => 'Vardo pakeitimas';

  @override
  String get iapNeonTheme => 'Tema „Neonas“';

  @override
  String get settingsLeaderboardDelete => 'Ištrinti įrašą lyderių lentelėje';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Pašalina tavo vardą ir taškus iš viešo sąrašo';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Ištrinti tavo įrašą?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tavo vardas ir taškai bus pašalinti iš lyderių lentelės. Žaidimo pažanga nepasikeis. Į lyderių lentelę gali grįžti bet kada.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Tavo įrašas lyderių lentelėje ištrintas.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Įrašo ištrinti nepavyko. Patikrink ryšį ir pabandyk dar kartą.';

  @override
  String get leaderboardReport => 'Pranešti apie šį vardą';

  @override
  String get leaderboardBlock => 'Blokuoti';

  @override
  String leaderboardBlocked(String name) {
    return '$name tau paslėptas';
  }

  @override
  String get leaderboardUndo => 'Atšaukti';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Tavo paslėptų įrašų: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Rodyti vėl';

  @override
  String get leaderboardReportUnavailable => 'Šiuo metu pranešti negalima.';

  @override
  String get leaderboardReportSent => 'Ačiū – tavo pranešimas išsiųstas.';

  @override
  String get leaderboardRules =>
      'Vardai yra vieši. Jokių įžeidimų, jokių menkinančių žodžių ir nieko, kas atskleistų tikrą asmenį. Taisyklę pažeidžiantys vardai šalinami.';

  @override
  String get leaderboardRulesAccept => 'Supratau';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Atrakinta $unlocked iš $total';
  }

  @override
  String get settingsSectionData => 'Išsaugoti duomenys';

  @override
  String get gameRotatePiece => 'Pasukti figūrą';

  @override
  String get themeClassic => 'Klasikinė';

  @override
  String get themeFade => 'Pastelinė';

  @override
  String get themeNeon => 'Neonas';

  @override
  String get themeOcean => 'Vandenynas';

  @override
  String get themeWood => 'Mediena';

  @override
  String get themeSunset => 'Saulėlydis';

  @override
  String get themeForest => 'Miškas';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasikinė';

  @override
  String get skinGradient => 'Gradientas';

  @override
  String get skinOutline => 'Kontūras';

  @override
  String get skinGlossy => 'Blizgi';

  @override
  String get skinStripe => 'Dryžiai';

  @override
  String get skinBevel => 'Reljefas';

  @override
  String get skinGlow => 'Švytėjimas';

  @override
  String get skinCrystal => 'Kristalas';

  @override
  String rewardThemeName(String name) {
    return 'Tema „$name“';
  }

  @override
  String rewardSkinName(String name) {
    return 'Išvaizda „$name“';
  }
}
