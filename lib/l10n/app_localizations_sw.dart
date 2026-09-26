// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class L10nSw extends L10n {
  L10nSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Cheza';

  @override
  String get commonLater => 'Baadaye';

  @override
  String get commonNotNow => 'Si sasa';

  @override
  String get commonCancel => 'Ghairi';

  @override
  String get commonBuy => 'Nunua';

  @override
  String get commonSave => 'Hifadhi';

  @override
  String get commonCollect => 'Chukua';

  @override
  String get nameNewName => 'Jina jipya';

  @override
  String get nameFieldLabel => 'Jina';

  @override
  String get piggyFullTitle => 'Kibubu kimejaa!';

  @override
  String get piggyKeepSaving => 'Endelea kuweka akiba';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins kati ya $capacity zimekusanywa.';
  }

  @override
  String get homeContinueRun => 'Endelea';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Nimeelewa';

  @override
  String get commonHome => 'Nyumbani';

  @override
  String get commonScore => 'ALAMA';

  @override
  String get commonBest => 'REKODI';

  @override
  String commonLevelShort(int level) {
    return 'Kiwango $level';
  }

  @override
  String get homeNewRun => 'Anza mchezo mpya';

  @override
  String get homeBackToExit => 'Bonyeza nyuma tena ili kutoka';

  @override
  String get homeEnableLeaderboard => 'Jiunge na ubao wa washindi';

  @override
  String get homeBestScore => 'REKODI YAKO';

  @override
  String get homeDailyChallenge => 'Changamoto ya Siku';

  @override
  String get homeDailyOpenToday => 'Inasubiri leo';

  @override
  String homeDailyNextIn(String time) {
    return 'Changamoto ijayo baada ya $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'Mfululizo wa siku $streak';
  }

  @override
  String get homeLeaderboard => 'Ubao wa washindi';

  @override
  String get homePuzzleMode => 'Hali ya Mafumbo';

  @override
  String get homeMissions => 'Majukumu';

  @override
  String get homeThemes => 'Mandhari';

  @override
  String get homeSkins => 'Mitindo';

  @override
  String get homeHowToPlay => 'Jinsi ya kucheza Qubble';

  @override
  String get homeWeekendBonus => 'Wikendi: sarafu mara mbili!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Kiwango $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Badilisha jina';

  @override
  String get nameChangeExplainer =>
      'Jina lako ndilo utambulisho wako kwenye ubao wa washindi, kwa hiyo halibadiliki. Unaweza kununua badiliko la jina mara moja.';

  @override
  String get nameChangeAfterPurchase =>
      'Baada ya kununua, gusa jina lako tena ili kulibadilisha.';

  @override
  String get nameJoinedLeaderboard => 'Sasa uko kwenye ubao wa washindi.';

  @override
  String get nameRenameUnavailable => 'Kubadilisha jina hakuwezekani kwa sasa.';

  @override
  String nameProblemTooShort(int min) {
    return 'Angalau herufi $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Herufi $max au chache zaidi.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Herufi (A–Z), nambari, nafasi, _ na - pekee.';

  @override
  String get nameProblemOffensive => 'Tafadhali chagua jina lingine.';

  @override
  String get piggyTitle => 'Kibubu';

  @override
  String get piggyFillingHint => 'Kibubu chako hujaa unaposafisha mistari.';

  @override
  String piggyCollect(int coins) {
    return 'Chukua sarafu $coins — bure.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kikijaa unaweza kukimwaga bure — au kukifungua mapema kwa video ya ziada.';

  @override
  String get piggyOpenNow => 'Fungua sasa';

  @override
  String get gameNewPiecesVideo => 'Vipande vipya (video)';

  @override
  String get gameTapBoardCell => 'Gusa kisanduku kwenye ubao';

  @override
  String get gameDailyChallengeLabel => 'CHANGAMOTO YA SIKU';

  @override
  String get gameOver => 'Mchezo Umekwisha';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Unahitaji sarafu $missing zaidi kwa bomu.';
  }

  @override
  String get gameBombNotHere => 'Bomu haliwezi kutumika hapa kwa sasa.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Unahitaji sarafu $missing zaidi kwa hilo.';
  }

  @override
  String get gameNotRightNow => 'Haiwezekani kwa sasa.';

  @override
  String get gameRunSaved => 'Mchezo umehifadhiwa — \"Endelea\" kwenye menyu.';

  @override
  String get gameOverNoFit =>
      'Hakuna kipande chako kinachotoshea tena kwenye ubao.';

  @override
  String get gameOverNoFitNoRotations =>
      'Hakuna kipande chako kinachotoshea — na mizunguko imekwisha.';

  @override
  String get gameStarterOfferUnavailable => 'Haipatikani kwa sasa';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — ipate';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Mafanikio: $title';
  }

  @override
  String get gameBestSubmitted => 'Rekodi mpya — imetumwa';

  @override
  String get gameReviveFor => 'Endelea kucheza · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Imefunguliwa: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Kifurushi cha kuanzia';

  @override
  String gameOverPoints(int score) {
    return 'Alama $score';
  }

  @override
  String get gameNewRecord => 'Rekodi mpya!';

  @override
  String gameStreakDays(int streak) {
    return 'Mfululizo wa siku $streak';
  }

  @override
  String get gameDoubleCoins => 'Sarafu mara mbili';

  @override
  String get gameDoubleDaily => 'Zawadi ya siku mara mbili';

  @override
  String get gamePlayAgain => 'Cheza tena';

  @override
  String gameLevelReached(int level) {
    return 'Umefikia kiwango $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Umepanda viwango $count — kiwango $level!';
  }

  @override
  String get gameStarterOfferReward => 'Sarafu 1200 + mandhari ya Mbao';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Zimebaki saa $hours tu — mara moja pekee!';
  }

  @override
  String get boosterUndo => 'Tendua';

  @override
  String get boosterSwap => 'Badilisha';

  @override
  String get boosterBomb => 'Bomu';

  @override
  String get boosterNoRotationsLeft =>
      'Mizunguko imekwisha — safisha mistari ili kuijaza!';

  @override
  String get onboardingDragPiece => 'Buruta kitalu hadi kwenye gridi';

  @override
  String get onboardingFillLine => 'Jaza safu au safu wima nzima';

  @override
  String get onboardingLinesClear => 'Mistari iliyojaa hutoweka — alama!';

  @override
  String get coachHintCombo =>
      'Kombo! Safisha tena ndani ya hatua 3 ili kuidumisha';

  @override
  String get coachHintFever => 'HOMA! Alama mara mbili ikiwaka';

  @override
  String get coachHintRotation =>
      'Kuzungusha kunatumia chaji — kusafisha huijaza tena';

  @override
  String get coachHintBooster => 'Kidokezo: visaidizi viko hapa chini';

  @override
  String get coachHintStrategy =>
      'Kidokezo: si kila mstari mara moja — acha nafasi kwa vipande vikubwa';

  @override
  String get dailyStreakLabel => 'Mfululizo';

  @override
  String get dailyBestLabel => 'Rekodi ya siku';

  @override
  String dailyHistoryNote(int days) {
    return 'Siku $days zilizopita zinahifadhiwa.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Siku $day: umecheza';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Siku $day: hukucheza';
  }

  @override
  String get homeDailyCalendar => 'Kalenda';

  @override
  String get dailyShareButton => 'Shiriki matokeo';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Changamoto ya Siku $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Alama $score · kombo bora x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Cheza: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: zimebaki hatua $moves';
  }

  @override
  String get dailyShareCopied => 'Matokeo yamenakiliwa kwenye ubao wa kunakili';

  @override
  String get adNotAvailable =>
      'Hakuna video kwa sasa — jaribu tena baada ya muda mfupi';

  @override
  String get howToPlaySpeedTitle => 'Bonasi ya kasi';

  @override
  String get howToPlaySpeedBody =>
      'Kuweka haraka huongeza hadi 30 % kwenye kila usafishaji. Bonasi hupungua kati ya sekunde 1.5 na 4 na ina kikomo, kwa hiyo kasi inalipa bila kuamua mchezo — mchezo wa taratibu na makini bado unaweza kushinda wa haraka na wa pupa.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonasi ya kasi asilimia $percent';
  }

  @override
  String get iapDiamondsSmall => 'Almasi 100';

  @override
  String get iapDiamondsMedium => 'Almasi 350';

  @override
  String get iapDiamondsLarge => 'Almasi 1,000';

  @override
  String get howToPlayTitle => 'Jinsi ya kucheza Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Rahisi kuanza.\nHulipa anayepanga mbele.';

  @override
  String get howToPlayIntroBody => 'Weka ubao wazi na uvunje rekodi yako.';

  @override
  String get howToPlayIntroSemantics =>
      'Lengo la mchezo. Weka ubao wazi na uvunje rekodi yako.';

  @override
  String get howToPlayDragTitle => 'Buruta na uweke';

  @override
  String get howToPlayDragBody =>
      'Buruta kimoja kati ya vipande vitatu hadi kwenye visanduku vitupu. Ukishatumia vyote vitatu, unapata vitatu vipya moja kwa moja.';

  @override
  String get howToPlayClearTitle => 'Safisha mistari';

  @override
  String get howToPlayClearBody =>
      'Jaza safu au safu wima nzima. Mistari iliyojaa hutoweka na kuacha nafasi kwa hatua yako ijayo.';

  @override
  String get howToPlayComboTitle => 'Unganisha kombo';

  @override
  String get howToPlayComboBody =>
      'Safisha mstari mwingine ndani ya hatua tatu. Kila kombo inayofuata huongeza kizidishi chako cha alama. Kombo huhesabu hatua, si sekunde, kwa hiyo haiishi ukiwa unafikiri.';

  @override
  String get howToPlayFeverTitle => 'Washa homa';

  @override
  String get howToPlayFeverBody =>
      'Kusafisha hujaza kipimo cha homa. Kikijaa, mlipuko unaofuata huhesabiwa mara mbili — panga usafishaji mkubwa mapema.';

  @override
  String get howToPlayBoosterTitle => 'Tumia visaidizi kwa busara';

  @override
  String get howToPlayBoosterBody =>
      'Visaidizi huokoa michezo migumu. Unaweza pia kugusa kipande kwenye trei ili kukizungusha.';

  @override
  String get howToPlayDailyTitle => 'Changamoto ya siku na mfululizo';

  @override
  String get howToPlayDailyBody =>
      'Changamoto ya siku hutumia vipande vilevile kwa kila mtu. Cheza kila siku ili kukuza mfululizo na bonasi yako.';

  @override
  String get howToPlayPiggyTitle => 'Jaza kibubu';

  @override
  String get howToPlayPiggyBody =>
      'Kila mstari unaosafishwa hujaza kibubu chako. Kikijaa, unaweza kuchukua sarafu bure.';

  @override
  String get leaderboardTitle => 'Ubao wa washindi';

  @override
  String get leaderboardUnreachable =>
      'Ubao wa washindi haupatikani.\nJaribu tena ukiwa na intaneti.';

  @override
  String get leaderboardEmpty => 'Bado hakuna majina.\nKuwa wa kwanza!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Rekodi yako ($score) inatumwa …';
  }

  @override
  String get leaderboardAutoSubmit => 'Rekodi yako hutumwa moja kwa moja.';

  @override
  String get puzzleModeTitle => 'Hali ya Mafumbo';

  @override
  String puzzleLevelTitle(int level) {
    return 'Fumbo $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Hatua: $moves   •   Lengo: $target kwa nyota 3';
  }

  @override
  String get puzzleSolved => 'Limetatuliwa!';

  @override
  String get puzzleLeaveTitle => 'Kuacha fumbo?';

  @override
  String get puzzleLeaveBody => 'Maendeleo yako katika fumbo hili yatapotea.';

  @override
  String get puzzleKeepPlaying => 'Endelea kucheza';

  @override
  String get puzzleLeave => 'Acha';

  @override
  String get puzzleStuckTitle => 'Umekwama';

  @override
  String get puzzleRestart => 'Anza upya';

  @override
  String get commonActive => 'Inatumika';

  @override
  String get commonTapToActivate => 'Gusa ili kuwasha';

  @override
  String get commonRestore => 'Rejesha';

  @override
  String unlockForCost(int cost) {
    return '$cost ili kufungua';
  }

  @override
  String get skinsExchangeGold => 'Badilisha dhahabu';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Zungusha kipande';

  @override
  String get puzzleNextLevel => 'Kiwango kijacho';

  @override
  String get puzzleBackToOverview => 'Rudi kwenye orodha';

  @override
  String get puzzleUnsolvable => 'Ubao hauwezi tena kuachwa mtupu kutoka hapa.';

  @override
  String get puzzleExtraMoveVideo => 'Hatua ya ziada (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved yametatuliwa';
  }

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get storageFailureTitle =>
      'Qubble haiwezi kupakia mchezo wako uliohifadhiwa';

  @override
  String get storageFailureBody =>
      'Tafadhali anzisha programu upya. Hitilafu ikiendelea, kusakinisha upya pekee ndiko kutasaidia. Unaweza kuiripoti kupitia Mipangilio › Maoni.';

  @override
  String get iapUnavailable => 'Ofa hii haipatikani kwa sasa.';

  @override
  String get iapFailed => 'Ununuzi haukukamilika. Hakuna kilichotozwa.';

  @override
  String get settingsResetProgress => 'Weka upya maendeleo';

  @override
  String get settingsResetProgressSubtitle =>
      'Alama, sarafu, kiwango na maendeleo vinarudi mwanzo. Ununuzi, jina na mapambo vinabaki.';

  @override
  String get settingsResetConfirmTitle => 'Kuweka upya maendeleo?';

  @override
  String get settingsResetConfirmBody =>
      'Rekodi, sarafu, kiwango, mfululizo na maendeleo yote yatafutwa. Hili haliwezi kutenduliwa.\n\nUnunuzi wako, jina lako na mandhari na mitindo uliyofungua vinabaki.';

  @override
  String get settingsResetConfirmAction => 'Weka upya';

  @override
  String get settingsResetDone => 'Maendeleo yamewekwa upya.';

  @override
  String get settingsSectionGame => 'Mchezo';

  @override
  String get settingsSectionSoundHaptics => 'Sauti na mtetemo';

  @override
  String get settingsSectionReminders => 'Vikumbusho';

  @override
  String get settingsSectionPurchases => 'Ununuzi';

  @override
  String get settingsSectionHelpOut => 'Saidia';

  @override
  String get settingsSectionLegal => 'Kisheria';

  @override
  String get settingsSectionLanguage => 'Lugha';

  @override
  String get settingsGuide => 'Jinsi ya kucheza';

  @override
  String get settingsGuideSubtitle => 'Sheria, kombo, homa na visaidizi';

  @override
  String get settingsSound => 'Sauti';

  @override
  String get settingsMusic => 'Muziki';

  @override
  String get settingsHaptics => 'Mtetemo';

  @override
  String get settingsHapticsOff => 'Imezimwa';

  @override
  String get settingsHapticsLight => 'Hafifu';

  @override
  String get settingsHapticsStrong => 'Mkali';

  @override
  String get settingsSectionAccessibility => 'Starehe';

  @override
  String get settingsReducedEffects => 'Madoido machache';

  @override
  String get settingsReducedEffectsHint =>
      'Chembe chache, skrini haitikisiki, hakuna mng\'ao';

  @override
  String get settingsNotifications => 'Arifa';

  @override
  String get settingsNotificationsSubtitle =>
      'Kikumbusho cha kila siku na ulinzi wa mfululizo';

  @override
  String get settingsNotificationsSystemHint =>
      'Ruhusu arifa kwenye mipangilio ya mfumo.';

  @override
  String get settingsLanguageSystem => 'Lugha ya mfumo';

  @override
  String get settingsSupporterThanks => 'Mfadhili — asante!';

  @override
  String get settingsSupporterPack => 'Kifurushi cha mfadhili';

  @override
  String get settingsSupporterPackSubtitle =>
      'Mandhari na mtindo wa kipekee + sarafu 1,500';

  @override
  String get settingsRestorePurchases => 'Rejesha ununuzi';

  @override
  String get settingsRestoring => 'Inarejesha ununuzi…';

  @override
  String get settingsRateApp => 'Kadiria programu';

  @override
  String get settingsRateAppSubtitle => 'Acha ukadiriaji dukani';

  @override
  String get settingsStoreUnavailable => 'Duka halipatikani kwenye kifaa hiki.';

  @override
  String get settingsFeedback => 'Tuma maoni';

  @override
  String get settingsFeedbackSubtitle =>
      'Ripoti mawazo na hitilafu (kupitia GitHub)';

  @override
  String get settingsAdPrivacy => 'Faragha ya matangazo';

  @override
  String get settingsAdPrivacySubtitle =>
      'Tazama au badilisha idhini yako ya matangazo';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Hakuna chaguo za matangazo zinazohitajika kwenye kifaa hiki.';

  @override
  String get settingsPrivacy => 'Sera ya faragha';

  @override
  String get settingsImprint => 'Taarifa za kisheria';

  @override
  String get settingsPageOpenFailed => 'Ukurasa haukuweza kufunguliwa.';

  @override
  String get settingsFooter => 'Qubble • Fumbo la Vitalu Bila Intaneti';

  @override
  String get settingsAdminSection => 'Admin (jaribio)';

  @override
  String get settingsAdminEnabled => 'Hali ya admin imewashwa';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Gusa mara $count zaidi kwa hali ya admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return 'Sarafu $coins';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Kwa majaribio tu — kamwe kwenye picha za toleo rasmi';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount sarafu';
  }

  @override
  String get settingsAdminResetCoins => 'Weka sarafu kuwa 0';

  @override
  String get feedbackTitle => 'Maoni';

  @override
  String get feedbackIntroShort =>
      'Unapenda nini, kinachokuudhi ni nini, nini kinakosekana? Mambo madogo pia husaidia — kadiri yalivyo mahususi, ndivyo bora.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Ni $build na aina ya kifaa chako pekee vinavyoambatishwa — ili nijue unazungumzia toleo gani.';
  }

  @override
  String get feedbackSendByMail => 'Tuma kwa barua pepe';

  @override
  String get feedbackPreferGithub => 'Napendelea issue ya GitHub';

  @override
  String get feedbackThanksMail => 'Asante! Tuma tu ujumbe.';

  @override
  String get feedbackNoMailApp =>
      'Hakuna programu ya barua pepe iliyopatikana. Jaribu njia ya GitHub hapa chini.';

  @override
  String get feedbackEmptyHint => 'Tafadhali andika kitu kwanza.';

  @override
  String get leaderboardRefresh => 'Onyesha upya';

  @override
  String get leaderboardRetry => 'Jaribu tena';

  @override
  String get feedbackHint => 'Maoni yako…';

  @override
  String get feedbackSubmit => 'Tuma maoni';

  @override
  String get feedbackOpenFailed =>
      'GitHub haikuweza kufunguliwa. Jaribu tena baadaye.';

  @override
  String get feedbackGithubNote =>
      'GitHub itafunguka — gusa \"Submit new issue\" hapo. (Unahitaji kuingia GitHub mara moja.)';

  @override
  String get shopTitle => 'Duka';

  @override
  String get shopWebDemoNote =>
      'Ununuzi unapatikana tu kwenye programu kutoka Play Store. Toleo hili la wavuti ni onyesho la bure — bado unaweza kulicheza lote hapa.';

  @override
  String get shopSupporterExplainer =>
      'Qubble haionyeshi matangazo ya lazima — hulazimiki kununua chochote kamwe. Kifurushi cha mfadhili (mandhari ya Aurora, mtindo wa Fuwele, sarafu 1,500, beji ya mfadhili) ni shukrani kwa kuunga mkono mchezo. Ununuzi umeunganishwa na akaunti yako ya duka na unaweza kurejeshwa wakati wowote.';

  @override
  String get shopSupporterContents =>
      'Mandhari ya Aurora + mtindo wa Fuwele + sarafu 1,500';

  @override
  String get themesTitle => 'Mandhari';

  @override
  String get themesSupporterOnly =>
      'Ni ya kifurushi cha mfadhili pekee (tazama dukani)';

  @override
  String get themesInSupporterPack => 'Kwenye kifurushi cha mfadhili';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Sarafu hazitoshi (unahitaji $cost, una $coins)';
  }

  @override
  String get skinsTitle => 'Mitindo ya vitalu';

  @override
  String get skinsNotEnoughDiamonds =>
      'Almasi hazitoshi (badilisha dhahabu hapa chini)';

  @override
  String get skinsNotEnoughCoins => 'Sarafu hazitoshi';

  @override
  String get skinsNotEnoughGold => 'Dhahabu haitoshi.';

  @override
  String skinsExchangeHint(int gold) {
    return 'Dhahabu $gold = almasi 1. Almasi hufungua mitindo maridadi zaidi — kusanya taratibu.';
  }

  @override
  String get statsTitle => 'Takwimu';

  @override
  String get statsAverageScore => 'Wastani';

  @override
  String get statsBestCombo => 'Kombo bora';

  @override
  String get statsGames => 'Michezo';

  @override
  String get statsLinesCleared => 'Mistari iliyosafishwa';

  @override
  String get statsPiecesPlaced => 'Vipande vilivyowekwa';

  @override
  String get statsCoins => 'Sarafu';

  @override
  String get missionsTitle => 'Majukumu';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Weka vipande $countString';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Safisha mistari $countString';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Fikia kombo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Vuka alama $countString katika mchezo mmoja';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Cheza michezo $countString';
  }

  @override
  String get achievementsTitle => 'Mafanikio';

  @override
  String get achievementFirstGameTitle => 'Mchezo wa kwanza';

  @override
  String get achievementFirstGameBody => 'Cheza mchezo wako wa kwanza';

  @override
  String get achievementGames25Title => 'Mchezaji wa kawaida';

  @override
  String get achievementGames25Body => 'Cheza michezo 25';

  @override
  String get achievementGames100Title => 'Umenaswa';

  @override
  String get achievementGames100Body => 'Cheza michezo 100';

  @override
  String get achievementScore1kTitle => 'Mpandaji';

  @override
  String get achievementScore1kBody => 'Fikia alama 1,000';

  @override
  String get achievementScore5kTitle => 'Mtaalamu';

  @override
  String get achievementScore5kBody => 'Fikia alama 5,000';

  @override
  String get achievementScore10kTitle => 'Bingwa';

  @override
  String get achievementScore10kBody => 'Fikia alama 10,000';

  @override
  String get achievementScore25kTitle => 'Gwiji';

  @override
  String get achievementScore25kBody => 'Fikia alama 25,000';

  @override
  String get achievementLines100Title => 'Nadhifu';

  @override
  String get achievementLines100Body => 'Safisha mistari 100 kwa jumla';

  @override
  String get achievementLines1000Title => 'Msafishaji hodari';

  @override
  String get achievementLines1000Body => 'Safisha mistari 1,000 kwa jumla';

  @override
  String get achievementCombo5Title => 'Mwanzilishi wa kombo';

  @override
  String get achievementCombo5Body => 'Fikia kombo x5';

  @override
  String get achievementCombo10Title => 'Mfalme wa kombo';

  @override
  String get achievementCombo10Body => 'Fikia kombo x10';

  @override
  String get achievementLevel10Title => 'Mzoefu';

  @override
  String get achievementLevel10Body => 'Fikia kiwango 10';

  @override
  String get achievementLevel20Title => 'Mkongwe';

  @override
  String get achievementLevel20Body => 'Fikia kiwango 20';

  @override
  String get achievementStreak7Title => 'Mfululizo wa wiki';

  @override
  String get achievementStreak7Body => 'Mfululizo wa siku 7';

  @override
  String get achievementStreak30Title => 'Mfululizo wa mwezi';

  @override
  String get achievementStreak30Body => 'Mfululizo wa siku 30';

  @override
  String get achievementPuzzles10Title => 'Mtatuzi';

  @override
  String get achievementPuzzles10Body => 'Tatua mafumbo 10';

  @override
  String get achievementPieces5000Title => 'Mjenzi';

  @override
  String get achievementPieces5000Body => 'Weka vipande 5,000';

  @override
  String streakRepairTitle(int streak) {
    return 'Mfululizo wa siku $streak uko hatarini!';
  }

  @override
  String get streakRepairBody => 'Jana hukucheza — okoa mfululizo wako:';

  @override
  String get streakRepairFailed => 'Kurekebisha hakuwezekani.';

  @override
  String comebackGift(int coins) {
    return 'Karibu tena! +$coins sarafu';
  }

  @override
  String get notificationsOptInTitle => 'Vikumbusho?';

  @override
  String get notificationsOptInBody =>
      'Tukukumbushe fumbo lako la kila siku na tulinde mfululizo wako? Unaweza kubadilisha hili wakati wowote kwenye mipangilio.';

  @override
  String get notificationsOptInAccept => 'Ndiyo, tafadhali';

  @override
  String get notificationChannelDescription =>
      'Kikumbusho cha kila siku, onyo la mfululizo, karibu tena';

  @override
  String get notificationDailyTitle => 'Fumbo lako la leo linakusubiri 🧩';

  @override
  String get notificationDailyBody => 'Cheza changamoto ya leo!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Mfululizo wako wa siku $streak uko hatarini!';
  }

  @override
  String get notificationStreakBody => 'Cheza leo ili kuudumisha.';

  @override
  String get notificationComebackTitle => 'Fumbo lako linakukumbuka 🧩';

  @override
  String get notificationComebackBody => 'Rudi uchukue zawadi!';

  @override
  String get iapSupporterPack => 'Kifurushi cha mfadhili';

  @override
  String get iapCoinsSmall => 'Sarafu 500';

  @override
  String get iapCoinsMedium => 'Sarafu 2,000';

  @override
  String get iapCoinsLarge => 'Sarafu 6,000';

  @override
  String get iapStarterPack => 'Kifurushi cha kuanzia';

  @override
  String get iapRename => 'Kubadilisha jina';

  @override
  String get iapNeonTheme => 'Mandhari ya Neoni';

  @override
  String get settingsLeaderboardDelete => 'Futa jina kwenye ubao wa washindi';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Huondoa jina na alama zako kwenye orodha ya umma';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Kufuta jina lako?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Jina na alama zako zitaondolewa kwenye ubao wa washindi. Maendeleo yako ya mchezo hayaguswi. Unaweza kujiunga tena na ubao wa washindi wakati wowote.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Jina lako limefutwa kwenye ubao wa washindi.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Haikuwezekana kufuta. Angalia muunganisho wako na ujaribu tena.';

  @override
  String get leaderboardReport => 'Ripoti jina hili';

  @override
  String get leaderboardBlock => 'Zuia';

  @override
  String leaderboardBlocked(String name) {
    return '$name amefichwa kwako';
  }

  @override
  String get leaderboardUndo => 'Tendua';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Majina $count yamefichwa nawe',
      one: 'Jina $count limefichwa nawe',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Onyesha tena';

  @override
  String get leaderboardReportUnavailable => 'Kuripoti hakupatikani kwa sasa.';

  @override
  String get leaderboardReportSent => 'Asante — ripoti yako imetumwa.';

  @override
  String get leaderboardRules =>
      'Majina ni ya umma. Hakuna matusi, hakuna maneno ya chuki, na hakuna kinachomtambulisha mtu halisi. Majina yanayokiuka hili huondolewa.';

  @override
  String get leaderboardRulesAccept => 'Nimeelewa';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked kati ya $total yamefunguliwa';
  }

  @override
  String get settingsSectionData => 'Data iliyohifadhiwa';

  @override
  String get gameRotatePiece => 'Zungusha kipande';

  @override
  String get themeClassic => 'Klasiki';

  @override
  String get themeFade => 'Pasteli';

  @override
  String get themeNeon => 'Neoni';

  @override
  String get themeOcean => 'Bahari';

  @override
  String get themeWood => 'Mbao';

  @override
  String get themeSunset => 'Machweo';

  @override
  String get themeForest => 'Msitu';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasiki';

  @override
  String get skinGradient => 'Gradienti';

  @override
  String get skinOutline => 'Kingo';

  @override
  String get skinGlossy => 'Ng\'aavu';

  @override
  String get skinStripe => 'Mistari';

  @override
  String get skinBevel => 'Mteremko';

  @override
  String get skinGlow => 'Mng\'ao';

  @override
  String get skinCrystal => 'Fuwele';

  @override
  String rewardThemeName(String name) {
    return 'Mandhari ya $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Mtindo wa $name';
  }
}
