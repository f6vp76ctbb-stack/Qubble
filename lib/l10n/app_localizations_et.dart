// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class L10nEt extends L10n {
  L10nEt([String locale = 'et']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Mängi';

  @override
  String get commonLater => 'Hiljem';

  @override
  String get commonNotNow => 'Mitte praegu';

  @override
  String get commonCancel => 'Tühista';

  @override
  String get commonBuy => 'Osta';

  @override
  String get commonSave => 'Salvesta';

  @override
  String get commonCollect => 'Võta vastu';

  @override
  String get nameNewName => 'Uus nimi';

  @override
  String get nameFieldLabel => 'Nimi';

  @override
  String get piggyFullTitle => 'Hoiupõrsas on täis!';

  @override
  String get piggyKeepSaving => 'Kogu edasi';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Kogutud $coins / $capacity.';
  }

  @override
  String get homeContinueRun => 'Jätka';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Selge';

  @override
  String get commonHome => 'Avaleht';

  @override
  String get commonScore => 'PUNKTID';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Tase $level';
  }

  @override
  String get homeNewRun => 'Alusta uut mängu';

  @override
  String get homeBackToExit => 'Väljumiseks vajuta uuesti tagasi';

  @override
  String get homeEnableLeaderboard => 'Liitu edetabeliga';

  @override
  String get homeBestScore => 'REKORD';

  @override
  String get homeDailyChallenge => 'Päeva väljakutse';

  @override
  String get homeDailyOpenToday => 'Ootab täna';

  @override
  String homeDailyNextIn(String time) {
    return 'Järgmine väljakutse $time pärast';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak-päevane seeria';
  }

  @override
  String get homeLeaderboard => 'Edetabel';

  @override
  String get homePuzzleMode => 'Mõistatuste režiim';

  @override
  String get homeHowToPlay => 'Kuidas Qubble\'it mängida';

  @override
  String get homeWeekendBonus => 'Nädalavahetus: topeltmündid!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Tase $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Muuda nime';

  @override
  String get nameChangeExplainer =>
      'Sinu nimi on sinu identiteet edetabelis, seega on see püsiv. Saad osta ühekordse nimemuutuse.';

  @override
  String get nameChangeAfterPurchase =>
      'Pärast ostu puuduta nime uuesti, et seda muuta.';

  @override
  String get nameJoinedLeaderboard => 'Oled nüüd edetabelis.';

  @override
  String nameProblemTooShort(int min) {
    return 'Vähemalt $min märki.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Kõige rohkem $max märki.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Ainult ladina tähed (A–Z, ka täppidega), numbrid, tühikud, _ ja -.';

  @override
  String get nameProblemOffensive => 'Palun vali teine nimi.';

  @override
  String get piggyTitle => 'Hoiupõrsas';

  @override
  String get piggyFillingHint => 'Hoiupõrsas täitub, kui ridu tühjendad.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins münti',
      one: '$coins münt',
    );
    return 'Võta $_temp0 – tasuta.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kui see on täis, saad selle tasuta tühjendada – või boonusvideoga varem avada.';

  @override
  String get piggyOpenNow => 'Ava kohe';

  @override
  String get gameNewPiecesVideo => 'Uued klotsid (video)';

  @override
  String get gameTapBoardCell => 'Puuduta laual ruutu';

  @override
  String get gameDailyChallengeLabel => 'PÄEVA VÄLJAKUTSE';

  @override
  String get gameOver => 'Mäng läbi';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Pommi jaoks puudu münte: $missing.';
  }

  @override
  String get gameBombNotHere => 'Pomm siin praegu ei tööta.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Selleks puudu münte: $missing.';
  }

  @override
  String get gameNotRightNow => 'Praegu pole võimalik.';

  @override
  String get gameRunSaved => 'Mäng salvestatud – menüüs „Jätka“.';

  @override
  String get gameOverNoFit => 'Ükski sinu klots ei mahu enam lauale.';

  @override
  String get gameOverNoFitNoRotations =>
      'Ükski sinu klots ei mahu – ja pöörded on otsas.';

  @override
  String get gameStarterOfferUnavailable => 'Praegu pole saadaval';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price – hangi';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Saavutus: $title';
  }

  @override
  String get gameBestSubmitted => 'Uus rekord – saadetud';

  @override
  String get gameReviveFor => 'Jätka mängu · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Avatud: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Algpakett';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score punkti',
      one: '$score punkt',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Uus rekord!';

  @override
  String gameStreakDays(int streak) {
    return '$streak-päevane seeria';
  }

  @override
  String get gameDoubleCoins => 'Topeltmündid';

  @override
  String get gameDoubleDaily => 'Topelt päevaauhind';

  @override
  String get gamePlayAgain => 'Mängi uuesti';

  @override
  String gameLevelReached(int level) {
    return 'Tase $level saavutatud!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count taset – tase $level!',
      one: '+$count tase – tase $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 münti + teema „Puit“';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Ainult $hours h jäänud – ühekordne!';
  }

  @override
  String get boosterUndo => 'Tagasi';

  @override
  String get boosterSwap => 'Vaheta';

  @override
  String get boosterBomb => 'Pomm';

  @override
  String get boosterNoRotationsLeft =>
      'Pöördeid pole enam – tühjenda ridu, et neid juurde saada!';

  @override
  String get onboardingDragPiece => 'Lohista klots ruudustikule';

  @override
  String get onboardingFillLine => 'Täida terve rida või veerg';

  @override
  String get onboardingLinesClear => 'Täis read kaovad – punktid!';

  @override
  String get coachHintCombo =>
      'Kombo! Tühjenda uuesti 3 käigu jooksul, et seda hoida';

  @override
  String get coachHintFever => 'PALAVIK! Topeltpunktid, kuni see helendab';

  @override
  String get coachHintRotation =>
      'Pööramine maksab ühe laengu – tühjendamine laeb selle';

  @override
  String get coachHintBooster => 'Vihje: all saad kasutada võimendeid';

  @override
  String get coachHintStrategy =>
      'Vihje: mitte kõik read korraga – jäta ruumi suurtele klotsidele';

  @override
  String get dailyStreakLabel => 'Seeria';

  @override
  String get dailyBestLabel => 'Päeva rekord';

  @override
  String dailyHistoryNote(int days) {
    return 'Säilitatakse viimased $days päeva.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day. päev: mängitud';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day. päev: mängimata';
  }

  @override
  String get homeDailyCalendar => 'Kalender';

  @override
  String get dailyShareButton => 'Jaga tulemust';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Päeva väljakutse $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Punktid: $score · parim kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Mängi: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Kombo: jäänud $moves käiku',
      one: 'Kombo: jäänud $moves käik',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Tulemus kopeeriti lõikelauale';

  @override
  String get adNotAvailable =>
      'Praegu pole videot saadaval – proovi hetke pärast uuesti';

  @override
  String get howToPlaySpeedTitle => 'Kiirusboonus';

  @override
  String get howToPlaySpeedBody =>
      'Kiire paigutamine lisab igale tühjendusele kuni 30 %. Boonus kahaneb 1,5 ja 4 sekundi vahel ning sellel on ülempiir, nii et kiirus tasub end ära, kuid ei otsusta mängu – hoolikas aeglane mäng võib ikkagi ületada kiirustava kiire mängu.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Kiirusboonus $percent protsenti';
  }

  @override
  String get iapDiamondsSmall => '100 teemanti';

  @override
  String get iapDiamondsMedium => '350 teemanti';

  @override
  String get iapDiamondsLarge => '1 000 teemanti';

  @override
  String get howToPlayTitle => 'Kuidas Qubble\'it mängida';

  @override
  String get howToPlayIntroHeadline => 'Lihtne alustada.\nTasub ette mõelda.';

  @override
  String get howToPlayIntroBody => 'Hoia laud vaba ja ületa oma rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Mängu eesmärk. Hoia laud vaba ja ületa oma rekord.';

  @override
  String get howToPlayDragTitle => 'Lohista ja aseta';

  @override
  String get howToPlayDragBody =>
      'Lohista üks kolmest klotsist vabadele ruutudele. Kui kõik kolm on kasutatud, saad automaatselt kolm uut.';

  @override
  String get howToPlayClearTitle => 'Tühjenda ridu';

  @override
  String get howToPlayClearBody =>
      'Täida terve rida või veerg. Täis read kaovad ja teevad ruumi järgmisele käigule.';

  @override
  String get howToPlayComboTitle => 'Ühenda kombosid';

  @override
  String get howToPlayComboBody =>
      'Tühjenda kolme käigu jooksul veel üks rida. Iga järgmine kombo tõstab punktikordajat. Kombo loeb käike, mitte sekundeid, nii et see ei lõpe kunagi, kui mõtled.';

  @override
  String get howToPlayFeverTitle => 'Süüta palavik';

  @override
  String get howToPlayFeverBody =>
      'Tühjendused täidavad palavikumõõdikut. Kui see on täis, loeb järgmine plahvatus topelt – planeeri suuri tühjendusi ette.';

  @override
  String get howToPlayBoosterTitle => 'Kasuta võimendeid targalt';

  @override
  String get howToPlayBoosterBody =>
      'Võimendid päästavad pingelisi mänge. Klotsi pööramiseks võid seda ka salves puudutada.';

  @override
  String get howToPlayDailyTitle => 'Päeva väljakutse ja seeria';

  @override
  String get howToPlayDailyBody =>
      'Päeva väljakutses saavad kõik samad klotsid. Mängi iga päev, et seeriat ja boonust kasvatada.';

  @override
  String get howToPlayPiggyTitle => 'Täida hoiupõrsas';

  @override
  String get howToPlayPiggyBody =>
      'Iga tühjendatud rida täidab hoiupõrsast. Kui see on täis, saad mündid tasuta kätte.';

  @override
  String get leaderboardTitle => 'Edetabel';

  @override
  String get leaderboardUnreachable =>
      'Edetabel pole saadaval.\nProovi uuesti internetiühendusega.';

  @override
  String get leaderboardEmpty => 'Kirjeid veel pole.\nOle esimene!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Sinu rekordit ($score) saadetakse …';
  }

  @override
  String get leaderboardAutoSubmit => 'Sinu rekord saadetakse automaatselt.';

  @override
  String get puzzleModeTitle => 'Mõistatuste režiim';

  @override
  String puzzleLevelTitle(int level) {
    return 'Mõistatus $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Käigud: $moves   •   Eesmärk 3 tähe jaoks: $target';
  }

  @override
  String get puzzleSolved => 'Lahendatud!';

  @override
  String get puzzleLeaveTitle => 'Lahkuda mõistatusest?';

  @override
  String get puzzleLeaveBody => 'Selle mõistatuse edenemine läheb kaotsi.';

  @override
  String get puzzleKeepPlaying => 'Mängi edasi';

  @override
  String get puzzleLeave => 'Lahku';

  @override
  String get puzzleStuckTitle => 'Ummikus';

  @override
  String get puzzleRestart => 'Alusta uuesti';

  @override
  String get commonActive => 'Aktiivne';

  @override
  String get commonRestore => 'Taasta';

  @override
  String get skinsExchangeGold => 'Vaheta kulda';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Pööra klotsi';

  @override
  String get puzzleNextLevel => 'Järgmine tase';

  @override
  String get puzzleBackToOverview => 'Tagasi ülevaatesse';

  @override
  String get puzzleUnsolvable => 'Siit ei saa lauda enam tühjaks.';

  @override
  String get puzzleExtraMoveVideo => 'Lisakäik (video)';

  @override
  String get puzzleHintVideo => 'Vihje (video)';

  @override
  String get puzzleNoHint =>
      'Siit ei saa vihjet anda. Alusta mõistatust uuesti.';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Lahendatud: $solved';
  }

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get storageFailureTitle => 'Qubble ei saa salvestatud mängu laadida';

  @override
  String get storageFailureBody =>
      'Palun taaskäivita rakendus. Kui viga püsib, aitab ainult uuesti installimine. Sellest saad teada anda menüüs Seaded › Tagasiside.';

  @override
  String get iapUnavailable => 'See pakkumine pole praegu saadaval.';

  @override
  String get iapFailed => 'Ost ei õnnestunud. Raha ei võetud.';

  @override
  String get settingsResetProgress => 'Lähtesta edenemine';

  @override
  String get settingsResetProgressSubtitle =>
      'Punktid, mündid, tase ja edenemine algusesse tagasi. Ostud, nimi ja kosmeetika jäävad alles.';

  @override
  String get settingsResetConfirmTitle => 'Lähtestada edenemine?';

  @override
  String get settingsResetConfirmBody =>
      'Rekord, mündid, tase, seeria ja kogu edenemine kustutatakse. Seda ei saa tagasi võtta.\n\nSinu ostud, nimi ning avatud teemad ja välimused jäävad alles.';

  @override
  String get settingsResetConfirmAction => 'Lähtesta';

  @override
  String get settingsResetDone => 'Edenemine lähtestatud.';

  @override
  String get settingsSectionGame => 'Mäng';

  @override
  String get settingsSectionSoundHaptics => 'Heli ja vibratsioon';

  @override
  String get settingsSectionReminders => 'Meeldetuletused';

  @override
  String get settingsSectionPurchases => 'Ostud';

  @override
  String get settingsSectionHelpOut => 'Aita kaasa';

  @override
  String get settingsSectionLegal => 'Õiguslik';

  @override
  String get settingsSectionLanguage => 'Keel';

  @override
  String get settingsGuide => 'Kuidas mängida';

  @override
  String get settingsGuideSubtitle => 'Reeglid, kombod, palavik ja võimendid';

  @override
  String get settingsSound => 'Heli';

  @override
  String get settingsMusic => 'Muusika';

  @override
  String get settingsHaptics => 'Vibratsioon';

  @override
  String get settingsHapticsOff => 'Väljas';

  @override
  String get settingsHapticsLight => 'Kerge';

  @override
  String get settingsHapticsStrong => 'Tugev';

  @override
  String get settingsSectionAccessibility => 'Mugavus';

  @override
  String get settingsReducedEffects => 'Vähendatud efektid';

  @override
  String get settingsReducedEffectsHint =>
      'Vähem osakesi, ilma ekraani värinata ja kumata';

  @override
  String get settingsNotifications => 'Teavitused';

  @override
  String get settingsNotificationsSubtitle =>
      'Päeva meeldetuletus ja seeria kaitse';

  @override
  String get settingsNotificationsSystemHint => 'Luba see süsteemi seadetes.';

  @override
  String get settingsLanguageSystem => 'Süsteemi keel';

  @override
  String get settingsSupporterThanks => 'Toetaja – aitäh!';

  @override
  String get settingsSupporterPack => 'Toetajapakett';

  @override
  String get settingsSupporterPackSubtitle =>
      'Eksklusiivne teema ja välimus + 1 500 münti';

  @override
  String get settingsRestorePurchases => 'Taasta ostud';

  @override
  String get settingsRestoring => 'Ostude taastamine…';

  @override
  String get settingsRateApp => 'Hinda rakendust';

  @override
  String get settingsRateAppSubtitle => 'Jäta poodi hinnang';

  @override
  String get settingsStoreUnavailable => 'Pood pole selles seadmes saadaval.';

  @override
  String get settingsFeedback => 'Saada tagasisidet';

  @override
  String get settingsFeedbackSubtitle =>
      'Anna teada ideedest ja vigadest (GitHubi kaudu)';

  @override
  String get settingsAdPrivacy => 'Reklaami privaatsus';

  @override
  String get settingsAdPrivacySubtitle => 'Vaata või muuda reklaaminõusolekut';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Selles seadmes pole reklaamivalikuid vaja.';

  @override
  String get settingsPrivacy => 'Privaatsuspoliitika';

  @override
  String get settingsImprint => 'Õiguslik teave';

  @override
  String get settingsPageOpenFailed => 'Lehte ei õnnestunud avada.';

  @override
  String get settingsFooter => 'Qubble • Võrguühenduseta klotsimõistatus';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Adminirežiim sisse lülitatud';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Adminirežiimi jaoks puuduta veel $count korda';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins münti',
      one: '$coins münt',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Ainult testimiseks – mitte kunagi väljalaske ekraanipiltidel';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount münti',
      one: '$amount münt',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Sea mündid nulli';

  @override
  String get feedbackTitle => 'Tagasiside';

  @override
  String get feedbackIntroShort =>
      'Mis sulle meeldib, mis häirib, mis puudu on? Ka väikesed asjad aitavad – mida konkreetsem, seda parem.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Lisatakse ainult $build ja seadme tüüp – et teaksin, millisest versioonist räägid.';
  }

  @override
  String get feedbackSendByMail => 'Saada e-postiga';

  @override
  String get feedbackPreferGithub => 'Eelistan GitHubi issue\'t';

  @override
  String get feedbackThanksMail => 'Aitäh! Saada lihtsalt sõnum ära.';

  @override
  String get feedbackNoMailApp =>
      'E-posti rakendust ei leitud. Proovi allpool GitHubi teed.';

  @override
  String get feedbackEmptyHint => 'Palun kirjuta enne midagi.';

  @override
  String get leaderboardRefresh => 'Värskenda';

  @override
  String get leaderboardRetry => 'Proovi uuesti';

  @override
  String get feedbackHint => 'Sinu tagasiside…';

  @override
  String get feedbackSubmit => 'Saada tagasisidet';

  @override
  String get feedbackOpenFailed =>
      'GitHubi ei õnnestunud avada. Proovi hiljem uuesti.';

  @override
  String get feedbackGithubNote =>
      'Avaneb GitHub – puuduta seal \"Submit new issue\". (Vajalik on ühekordne GitHubi sisselogimine.)';

  @override
  String get shopTitle => 'Pood';

  @override
  String get shopWebDemoNote =>
      'Ostud on saadaval ainult Play Store\'i rakenduses. See veebiversioon on tasuta demo – saad siin siiski kõike mängida.';

  @override
  String get shopSupporterExplainer =>
      'Qubble ei näita sundreklaame – sa ei pea kunagi midagi ostma. Toetajapakett (Aurora teema, Kristalli välimus, 1 500 münti, toetaja märk) on tänu mängu toetamise eest. Ostud on seotud sinu poekontoga ja neid saab igal ajal taastada.';

  @override
  String get shopSupporterContents =>
      'Aurora teema + Kristalli välimus + 1 500 münti';

  @override
  String get themesTitle => 'Teemad';

  @override
  String get themesSupporterOnly => 'Ainult toetajapaketis (vaata poodi)';

  @override
  String get skinsTitle => 'Klotside välimused';

  @override
  String get skinsNotEnoughCoins => 'Pole piisavalt münte';

  @override
  String get skinsNotEnoughGold => 'Pole piisavalt kulda.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold kulda = 1 teemant. Teemandid avavad kaunimad välimused – kogu rahulikult.';
  }

  @override
  String get statsTitle => 'Statistika';

  @override
  String get statsAverageScore => 'Keskm. punktid';

  @override
  String get statsBestCombo => 'Parim kombo';

  @override
  String get statsGames => 'Mängud';

  @override
  String get statsLinesCleared => 'Tühjendatud read';

  @override
  String get statsPiecesPlaced => 'Paigutatud klotsid';

  @override
  String get statsCoins => 'Mündid';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Saavuta kombo x$countString';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kogu ühes mängus $countString punkti',
      one: 'Kogu ühes mängus $countString punkt',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Saavutused';

  @override
  String get achievementFirstGameTitle => 'Esimene mäng';

  @override
  String get achievementFirstGameBody => 'Mängi oma esimene mäng';

  @override
  String get achievementGames25Title => 'Püsimängija';

  @override
  String get achievementGames25Body => 'Mängi 25 mängu';

  @override
  String get achievementGames100Title => 'Sõltlane';

  @override
  String get achievementGames100Body => 'Mängi 100 mängu';

  @override
  String get achievementScore1kTitle => 'Tõusja';

  @override
  String get achievementScore1kBody => 'Kogu 1 000 punkti';

  @override
  String get achievementScore5kTitle => 'Proff';

  @override
  String get achievementScore5kBody => 'Kogu 5 000 punkti';

  @override
  String get achievementScore10kTitle => 'Meister';

  @override
  String get achievementScore10kBody => 'Kogu 10 000 punkti';

  @override
  String get achievementScore25kTitle => 'Legend';

  @override
  String get achievementScore25kBody => 'Kogu 25 000 punkti';

  @override
  String get achievementLines100Title => 'Korralik';

  @override
  String get achievementLines100Body => 'Tühjenda kokku 100 rida';

  @override
  String get achievementLines1000Title => 'Suurpuhastaja';

  @override
  String get achievementLines1000Body => 'Tühjenda kokku 1 000 rida';

  @override
  String get achievementCombo5Title => 'Kombo algaja';

  @override
  String get achievementCombo5Body => 'Saavuta kombo x5';

  @override
  String get achievementCombo10Title => 'Kombokuningas';

  @override
  String get achievementCombo10Body => 'Saavuta kombo x10';

  @override
  String get achievementLevel10Title => 'Kogenud';

  @override
  String get achievementLevel10Body => 'Jõua 10. tasemele';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Jõua 20. tasemele';

  @override
  String get achievementStreak7Title => 'Nädala seeria';

  @override
  String get achievementStreak7Body => '7-päevane päeva väljakutse seeria';

  @override
  String get achievementStreak30Title => 'Kuu seeria';

  @override
  String get achievementStreak30Body => '30-päevane päeva väljakutse seeria';

  @override
  String get achievementPuzzles10Title => 'Nuputaja';

  @override
  String get achievementPuzzles10Body => 'Lahenda 10 mõistatust';

  @override
  String get achievementPieces5000Title => 'Ehitaja';

  @override
  String get achievementPieces5000Body => 'Paiguta 5 000 klotsi';

  @override
  String streakRepairTitle(int streak) {
    return '$streak-päevane seeria on ohus!';
  }

  @override
  String get streakRepairBody => 'Eile jäi mängimata – päästa oma seeria:';

  @override
  String get streakRepairFailed => 'Parandamine pole võimalik.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins münti',
      one: '$coins münt',
    );
    return 'Tere tulemast tagasi! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Meeldetuletused?';

  @override
  String get notificationsOptInBody =>
      'Kas tuletame sulle päeva mõistatust meelde ja kaitseme su seeriat? Saad seda igal ajal seadetes muuta.';

  @override
  String get notificationsOptInAccept => 'Jah, palun';

  @override
  String get notificationChannelDescription =>
      'Päeva meeldetuletus, seeria hoiatus, tagasitulek';

  @override
  String get notificationDailyTitle => 'Sinu päeva mõistatus ootab 🧩';

  @override
  String get notificationDailyBody => 'Mängi tänast väljakutset!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Sinu $streak-päevane seeria on ohus!';
  }

  @override
  String get notificationStreakBody => 'Mängi täna, et seda hoida.';

  @override
  String get notificationComebackTitle => 'Sinu klotsid igatsevad sind 🧩';

  @override
  String get notificationComebackBody => 'Tule tagasi ja võta kingitus!';

  @override
  String get iapSupporterPack => 'Toetajapakett';

  @override
  String get iapCoinsSmall => '500 münti';

  @override
  String get iapCoinsMedium => '2 000 münti';

  @override
  String get iapCoinsLarge => '6 000 münti';

  @override
  String get iapStarterPack => 'Algpakett';

  @override
  String get iapRename => 'Nimemuutus';

  @override
  String get iapNeonTheme => 'Teema „Neoon“';

  @override
  String get settingsLeaderboardDelete => 'Kustuta edetabeli kirje';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Eemaldab sinu nime ja punktid avalikust nimekirjast';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Kustutada sinu kirje?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Sinu nimi ja punktid eemaldatakse edetabelist. Mängu edenemine jääb puutumata. Saad edetabeliga igal ajal uuesti liituda.';

  @override
  String get settingsLeaderboardDeleteDone => 'Sinu edetabeli kirje kustutati.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Kirjet ei õnnestunud kustutada. Kontrolli ühendust ja proovi uuesti.';

  @override
  String get leaderboardReport => 'Teata sellest nimest';

  @override
  String get leaderboardBlock => 'Blokeeri';

  @override
  String leaderboardBlocked(String name) {
    return '$name on sinu eest peidetud';
  }

  @override
  String get leaderboardUndo => 'Võta tagasi';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Sinu peidetud kirjeid: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Näita uuesti';

  @override
  String get leaderboardReportUnavailable => 'Teatamine pole praegu võimalik.';

  @override
  String get leaderboardReportSent => 'Aitäh – sinu teade on teel.';

  @override
  String get leaderboardRules =>
      'Nimed on avalikud. Ei mingeid solvanguid ega halvustavaid sõnu ega midagi, mis tuvastab päris inimese. Reegleid rikkuvad nimed eemaldatakse.';

  @override
  String get leaderboardRulesAccept => 'Saan aru';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Avatud $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'Salvestatud andmed';

  @override
  String get gameRotatePiece => 'Pööra klotsi';

  @override
  String get themeClassic => 'Klassika';

  @override
  String get themeFade => 'Pastell';

  @override
  String get themeNeon => 'Neoon';

  @override
  String get themeOcean => 'Ookean';

  @override
  String get themeWood => 'Puit';

  @override
  String get themeSunset => 'Päikeseloojang';

  @override
  String get themeForest => 'Mets';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klassika';

  @override
  String get skinGradient => 'Üleminek';

  @override
  String get skinOutline => 'Kontuur';

  @override
  String get skinGlossy => 'Läikiv';

  @override
  String get skinStripe => 'Triibud';

  @override
  String get skinBevel => 'Reljeef';

  @override
  String get skinGlow => 'Kuma';

  @override
  String get skinCrystal => 'Kristall';

  @override
  String rewardThemeName(String name) {
    return 'Teema „$name“';
  }

  @override
  String rewardSkinName(String name) {
    return 'Välimus „$name“';
  }

  @override
  String get skinPulse => 'Pulss';

  @override
  String get skinShimmer => 'Sätendus';

  @override
  String get skinWave => 'Laine';

  @override
  String get skinEmber => 'Söed';

  @override
  String get skinPrism => 'Prisma';

  @override
  String get skinStardust => 'Tähetolm';

  @override
  String get skinCircuit => 'Vooluring';

  @override
  String get skinRipple => 'Virvendus';

  @override
  String achievementRewardSkin(String name) {
    return 'Animeeritud välimus „$name“';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Saavutuse auhind: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Saavutused annavad nüüd auhindu — sinu omad on lisatud.';

  @override
  String get namePromptBody =>
      'Vali nimi ja sinu parim tulemus jõuab edetabelisse. Ilma nimeta mängid edasi anonüümselt.';

  @override
  String get nameTaken => 'See nimi on juba võetud. Proovi mõnda muud.';

  @override
  String get nameCheckFailed =>
      'Nime ei õnnestunud kontrollida. Kas oled võrgus? Proovi hetke pärast uuesti.';

  @override
  String nameLost(String name) {
    return '$name kuulub nüüd teisele mängijale. Vali uus nimi – tasuta.';
  }

  @override
  String get themeCandy => 'Komm';

  @override
  String get themeVolcano => 'Vulkaan';

  @override
  String get themeGlacier => 'Liustik';

  @override
  String get skinPixel => 'Piksel';

  @override
  String get skinMarble => 'Marmor';

  @override
  String get skinJelly => 'Tarretis';

  @override
  String get skinLiquid => 'Vedelik';

  @override
  String get skinFizz => 'Mullid';

  @override
  String get skinPlasma => 'Plasma';

  @override
  String get designsTitle => 'Kujundused';

  @override
  String get designsNotEnoughDiamonds => 'Pole piisavalt teemante.';

  @override
  String get designsOwned => 'Olemas';

  @override
  String get designsAchievementOnly => 'Saavutus';

  @override
  String get designsSupporterOnly => 'Toetaja';

  @override
  String get designsPreview => 'Eelvaade';

  @override
  String get designsGetDiamonds => 'Hangi teemante';

  @override
  String get shopDealTitle => 'Päeva pakkumine';

  @override
  String get shopAnimatedSkins => 'Animeeritud välimused';

  @override
  String get shopNewDesigns => 'Uued kujundused';

  @override
  String get shopDiamonds => 'Teemandid';

  @override
  String get shopPacks => 'Paketid';

  @override
  String get shopPopular => 'Populaarne';

  @override
  String get shopBestValue => 'Parim hind';

  @override
  String get shopDiamondsBlurb =>
      'Animeeritud välimuste ja uute kujunduste jaoks.';

  @override
  String get shopCoinsBlurb => 'Teemade, välimuste ja võimendite jaoks.';

  @override
  String get shopNeonBlurb => 'Avab kohe teema „Neoon“.';

  @override
  String get shopRenameBlurb => 'Muuda oma nime edetabelis.';

  @override
  String shopHoursLeft(int hours) {
    return 'Veel $hours h';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Uus pakkumine $time pärast';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name avatud!';
  }

  @override
  String get questsTitle => 'Ülesanded';

  @override
  String get questsDaily => 'Päeva';

  @override
  String get questsWeekly => 'Nädala';

  @override
  String get questsMonthly => 'Kuu';

  @override
  String questsNewIn(String time) {
    return 'Uued ülesanded $time pärast';
  }

  @override
  String get questsBonus => 'Boonus kõigi eest';

  @override
  String get questsBonusEarned => 'Boonus teenitud';

  @override
  String get questRounds => 'Mängi ringe';

  @override
  String get questLines => 'Tühjenda ridu';

  @override
  String get questPieces => 'Paiguta klotse';

  @override
  String get questDailyChallenge => 'Mängi päeva väljakutset';

  @override
  String get questPuzzles => 'Lahenda uusi mõistatusi';

  @override
  String get questDays => 'Mängi eri päevadel';

  @override
  String get questDailySets => 'Täida kõik päeva ülesanded';

  @override
  String get questsSetDaily => 'Kõik päeva ülesanded tehtud!';

  @override
  String get questsSetWeekly => 'Kõik nädala ülesanded tehtud!';

  @override
  String get questsSetMonthly => 'Kõik kuu ülesanded tehtud!';

  @override
  String get leaderboardTabScore => 'Parim tulemus';

  @override
  String get leaderboardTabPuzzle => 'Mõistatuste tähed';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Sinu mõistatuste tähed saadetakse automaatselt.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Sinu mõistatuste tähti ($stars) saadetakse …';
  }

  @override
  String get dailyGoalTitle => 'Tänane eesmärk';

  @override
  String dailyGoalPoints(String points) {
    return '$points punkti';
  }

  @override
  String get dailyChestOpened => 'Seeria kirst avatud!';

  @override
  String dailyNextChest(int day) {
    return 'Järgmine kirst: seeria $day. päev';
  }

  @override
  String get dailyExplainer =>
      'Täna mängivad kõik sama lauda ja arvesse läheb sinu esimene voor. Jõua tähemärkideni lisamüntide saamiseks, hoia seeriat teemandikirstude jaoks ja vaata, mitmes sa täna oled.';

  @override
  String dailyRank(int rank, int total) {
    return '$rank. koht $total-st täna';
  }

  @override
  String get dailyRankNeedsName => 'Vali nimi, et edetabelisse jõuda.';

  @override
  String get dailyRankingButton => 'Tänane edetabel';

  @override
  String get leaderboardTabDaily => 'Tänane väljakutse';

  @override
  String get leaderboardDailyFooter =>
      'Sama laud kõigile, arvesse läheb esimene voor. Iga päev uus edetabel.';

  @override
  String notificationChestBody(int diamonds) {
    return 'Mängi tänast väljakutset ja ava seeria kirst: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'Kõrvits';

  @override
  String get skinGhost => 'Kummitus';

  @override
  String get halloweenTitle => 'Halloween';

  @override
  String get halloweenBody =>
      'Kõrvitsa teema ja kummituse skin – ainult oktoobris.';

  @override
  String get designsBackInOctober => 'Tagasi oktoobris';

  @override
  String get shopFreeTitle => 'Tasuta boonus';

  @override
  String get shopFreeWatch => 'Vaata videot';

  @override
  String shopFreeToday(int left, int total) {
    return 'Täna: $left/$total';
  }

  @override
  String get shopFreeTomorrow => 'Homme jälle';

  @override
  String get designsAccessories => 'Aksessuaarid';

  @override
  String get designsBursts => 'Plahvatused';

  @override
  String get accessoryNone => 'Puudub';

  @override
  String get accessoryCobweb => 'Ämblikuvõrk';

  @override
  String get accessorySnowCap => 'Lumemüts';

  @override
  String get accessoryCrown => 'Kroon';

  @override
  String get accessoryFlower => 'Lilleke';

  @override
  String get accessorySparkle => 'Sädelus';

  @override
  String get accessoryDewdrop => 'Kastepiisk';

  @override
  String get burstClassic => 'Klassikaline';

  @override
  String get burstConfetti => 'Konfetti';

  @override
  String get burstFire => 'Tuli';

  @override
  String get burstPixels => 'Pikslid';

  @override
  String get burstStars => 'Tähed';

  @override
  String get burstBubbles => 'Mullid';

  @override
  String bestShareText(String score) {
    return 'Minu uus Qubble\'i rekord: $score punkti! Kas suudad selle ületada?';
  }
}
