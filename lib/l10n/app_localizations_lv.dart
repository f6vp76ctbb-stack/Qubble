// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class L10nLv extends L10n {
  L10nLv([String locale = 'lv']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Spēlēt';

  @override
  String get commonLater => 'Vēlāk';

  @override
  String get commonNotNow => 'Ne tagad';

  @override
  String get commonCancel => 'Atcelt';

  @override
  String get commonBuy => 'Pirkt';

  @override
  String get commonSave => 'Saglabāt';

  @override
  String get commonCollect => 'Saņemt';

  @override
  String get nameNewName => 'Jauns vārds';

  @override
  String get nameFieldLabel => 'Vārds';

  @override
  String get piggyFullTitle => 'Krājkasīte ir pilna!';

  @override
  String get piggyKeepSaving => 'Krāt tālāk';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Savākts: $coins no $capacity.';
  }

  @override
  String get homeContinueRun => 'Turpināt';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Skaidrs';

  @override
  String get commonHome => 'Sākums';

  @override
  String get commonScore => 'PUNKTI';

  @override
  String get commonBest => 'REKORDS';

  @override
  String commonLevelShort(int level) {
    return '$level. līmenis';
  }

  @override
  String get homeNewRun => 'Sākt jaunu spēli';

  @override
  String get homeBackToExit => 'Nospied „Atpakaļ” vēlreiz, lai izietu';

  @override
  String get homeEnableLeaderboard => 'Pievienoties līderu tabulai';

  @override
  String get homeBestScore => 'REKORDS';

  @override
  String get homeDailyChallenge => 'Dienas izaicinājums';

  @override
  String get homeDailyOpenToday => 'Gaida šodien';

  @override
  String homeDailyNextIn(String time) {
    return 'Nākamais izaicinājums pēc $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'Sērija: $streak d.';
  }

  @override
  String get homeLeaderboard => 'Līderu tabula';

  @override
  String get homePuzzleMode => 'Mīklu režīms';

  @override
  String get homeHowToPlay => 'Kā spēlēt Qubble';

  @override
  String get homeWeekendBonus => 'Nedēļas nogale: dubultas monētas!';

  @override
  String homeNextUnlock(int level, String name) {
    return '$level. līmenis: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Mainīt vārdu';

  @override
  String get nameChangeExplainer =>
      'Tavs vārds ir tava identitāte līderu tabulā, tāpēc tas ir nemainīgs. Vari nopirkt vienreizēju vārda maiņu.';

  @override
  String get nameChangeAfterPurchase =>
      'Pēc pirkuma vēlreiz pieskaries savam vārdam, lai to mainītu.';

  @override
  String get nameJoinedLeaderboard => 'Tagad tu esi līderu tabulā.';

  @override
  String nameProblemTooShort(int min) {
    return 'Minimālais rakstzīmju skaits: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Maksimālais rakstzīmju skaits: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Tikai latīņu burti (A–Z, arī ar garumzīmēm un mīkstinājuma zīmēm), cipari, atstarpes, _ un -.';

  @override
  String get nameProblemOffensive => 'Lūdzu, izvēlies citu vārdu.';

  @override
  String get piggyTitle => 'Krājkasīte';

  @override
  String get piggyFillingHint => 'Krājkasīte pildās, kamēr tu notīri rindas.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monētas',
      one: '$coins monētu',
      zero: '$coins monētu',
    );
    return 'Saņem $_temp0 — bez maksas.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kad tā būs pilna, varēsi to iztukšot bez maksas — vai atvērt agrāk ar bonusa video.';

  @override
  String get piggyOpenNow => 'Atvērt tagad';

  @override
  String get gameNewPiecesVideo => 'Jaunas figūras (video)';

  @override
  String get gameTapBoardCell => 'Pieskaries laukuma rūtiņai';

  @override
  String get gameDailyChallengeLabel => 'DIENAS IZAICINĀJUMS';

  @override
  String get gameOver => 'Spēle beigusies';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Bumbai trūkst monētu: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bumba šeit pašlaik nedarbojas.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Tam trūkst monētu: $missing.';
  }

  @override
  String get gameNotRightNow => 'Pašlaik nav iespējams.';

  @override
  String get gameRunSaved => 'Spēle saglabāta — izvēlnē „Turpināt”.';

  @override
  String get gameOverNoFit =>
      'Neviena no tavām figūrām vairs neietilpst laukumā.';

  @override
  String get gameOverNoFitNoRotations =>
      'Neviena no tavām figūrām neietilpst — un pagriezieni ir beigušies.';

  @override
  String get gameStarterOfferUnavailable => 'Pašlaik nav pieejams';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — saņemt';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Sasniegums: $title';
  }

  @override
  String get gameBestSubmitted => 'Jauns rekords nosūtīts';

  @override
  String get gameReviveFor => 'Spēlēt tālāk · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Atbloķēts: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Sākuma komplekts';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score punkti',
      one: '$score punkts',
      zero: '$score punktu',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Jauns rekords!';

  @override
  String gameStreakDays(int streak) {
    return 'Sērija: $streak d.';
  }

  @override
  String get gameDoubleCoins => 'Dubultot monētas';

  @override
  String get gameDoubleDaily => 'Dubultot dienas balvu';

  @override
  String get gamePlayAgain => 'Spēlēt vēlreiz';

  @override
  String gameLevelReached(int level) {
    return 'Sasniegts $level. līmenis!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Līmeņi: +$count — tagad $level. līmenis!';
  }

  @override
  String get gameStarterOfferReward => '1200 monētu + tēma „Koks”';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Atlikušas tikai $hours st. — vienreizējs piedāvājums!';
  }

  @override
  String get boosterUndo => 'Atsaukt';

  @override
  String get boosterSwap => 'Mainīt';

  @override
  String get boosterBomb => 'Bumba';

  @override
  String get boosterNoRotationsLeft =>
      'Pagriezienu nav — notīri rindas, lai tos atjaunotu!';

  @override
  String get onboardingDragPiece => 'Ievelc bloku režģī';

  @override
  String get onboardingFillLine => 'Aizpildi visu rindu vai kolonnu';

  @override
  String get onboardingLinesClear => 'Pilnas līnijas pazūd — punkti!';

  @override
  String get coachHintCombo =>
      'Kombo! Notīri vēlreiz 3 gājienu laikā, lai to noturētu';

  @override
  String get coachHintFever => 'DRUDZIS! Dubulti punkti, kamēr spīd';

  @override
  String get coachHintRotation =>
      'Pagrieziens maksā vienu lādiņu — tīrīšana to atjauno';

  @override
  String get coachHintBooster => 'Padoms: apakšā vari izmantot pastiprinātājus';

  @override
  String get coachHintStrategy =>
      'Padoms: ne visas līnijas uzreiz — atstāj vietu lielām figūrām';

  @override
  String get dailyStreakLabel => 'Sērija';

  @override
  String get dailyBestLabel => 'Dienas rekords';

  @override
  String dailyHistoryNote(int days) {
    return 'Tiek glabātas pēdējās dienas: $days.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day. diena: spēlēts';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day. diena: nav spēlēts';
  }

  @override
  String get homeDailyCalendar => 'Kalendārs';

  @override
  String get dailyShareButton => 'Dalīties ar rezultātu';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Dienas izaicinājums $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Punkti: $score · labākais kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Spēlē: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo — atlikušie gājieni: $moves';
  }

  @override
  String get dailyShareCopied => 'Rezultāts nokopēts starpliktuvē';

  @override
  String get adNotAvailable =>
      'Pašlaik video nav pieejams — mēģini vēlreiz pēc brīža';

  @override
  String get howToPlaySpeedTitle => 'Ātruma bonuss';

  @override
  String get howToPlaySpeedBody =>
      'Ātra novietošana katrai notīrīšanai pievieno līdz 30 %. Bonuss samazinās no 1,5 līdz 4 sekundēm, un tam ir griesti, tāpēc ātrums atmaksājas, bet neizšķir spēli — rūpīga lēna spēle joprojām var pārspēt steidzīgu ātru.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Ātruma bonuss $percent procenti';
  }

  @override
  String get iapDiamondsSmall => '100 dimantu';

  @override
  String get iapDiamondsMedium => '350 dimantu';

  @override
  String get iapDiamondsLarge => '1 000 dimantu';

  @override
  String get howToPlayTitle => 'Kā spēlēt Qubble';

  @override
  String get howToPlayIntroHeadline => 'Viegli sākt.\nAtalgo tos, kas plāno.';

  @override
  String get howToPlayIntroBody =>
      'Uzturi laukumu brīvu un pārspēj savu rekordu.';

  @override
  String get howToPlayIntroSemantics =>
      'Spēles mērķis. Uzturi laukumu brīvu un pārspēj savu rekordu.';

  @override
  String get howToPlayDragTitle => 'Velc un novieto';

  @override
  String get howToPlayDragBody =>
      'Ievelc vienu no trim figūrām brīvās rūtiņās. Kad visas trīs izmantotas, automātiski saņemsi trīs jaunas.';

  @override
  String get howToPlayClearTitle => 'Notīri līnijas';

  @override
  String get howToPlayClearBody =>
      'Aizpildi visu rindu vai kolonnu. Pilnas līnijas pazūd un atbrīvo vietu nākamajam gājienam.';

  @override
  String get howToPlayComboTitle => 'Savieno kombo';

  @override
  String get howToPlayComboBody =>
      'Notīri vēl vienu līniju triju gājienu laikā. Katrs nākamais kombo palielina punktu reizinātāju. Kombo skaita gājienus, nevis sekundes, tāpēc tas nekad nebeidzas, kamēr domā.';

  @override
  String get howToPlayFeverTitle => 'Iededz drudzi';

  @override
  String get howToPlayFeverBody =>
      'Tīrīšana piepilda drudža mērītāju. Kad tas ir pilns, nākamais sprādziens skaitās dubultā — plāno lielās tīrīšanas iepriekš.';

  @override
  String get howToPlayBoosterTitle => 'Izmanto pastiprinātājus gudri';

  @override
  String get howToPlayBoosterBody =>
      'Pastiprinātāji izglābj saspringtas spēles. Figūru apakšā vari arī pieskarties, lai to pagrieztu.';

  @override
  String get howToPlayDailyTitle => 'Dienas izaicinājums un sērija';

  @override
  String get howToPlayDailyBody =>
      'Dienas izaicinājumā visiem ir vienādas figūras. Spēlē katru dienu, lai audzētu sēriju un bonusu.';

  @override
  String get howToPlayPiggyTitle => 'Piepildi krājkasīti';

  @override
  String get howToPlayPiggyBody =>
      'Katra notīrītā līnija piepilda krājkasīti. Kad tā ir pilna, monētas vari saņemt bez maksas.';

  @override
  String get leaderboardTitle => 'Līderu tabula';

  @override
  String get leaderboardUnreachable =>
      'Līderu tabula nav pieejama.\nMēģini vēlreiz ar interneta savienojumu.';

  @override
  String get leaderboardEmpty => 'Vēl nav neviena ieraksta.\nEsi pirmais!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Tavs rekords ($score) tiek nosūtīts …';
  }

  @override
  String get leaderboardAutoSubmit => 'Tavs rekords tiek nosūtīts automātiski.';

  @override
  String get puzzleModeTitle => 'Mīklu režīms';

  @override
  String puzzleLevelTitle(int level) {
    return 'Mīkla $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Gājieni: $moves   •   Mērķis 3 zvaigznēm: $target';
  }

  @override
  String get puzzleSolved => 'Atrisināts!';

  @override
  String get puzzleLeaveTitle => 'Pamest mīklu?';

  @override
  String get puzzleLeaveBody => 'Progress šajā mīklā tiks zaudēts.';

  @override
  String get puzzleKeepPlaying => 'Spēlēt tālāk';

  @override
  String get puzzleLeave => 'Pamest';

  @override
  String get puzzleStuckTitle => 'Strupceļš';

  @override
  String get puzzleRestart => 'Sākt no jauna';

  @override
  String get commonActive => 'Aktīvs';

  @override
  String get commonRestore => 'Atjaunot';

  @override
  String get skinsExchangeGold => 'Mainīt zeltu';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Pagriezt figūru';

  @override
  String get puzzleNextLevel => 'Nākamais līmenis';

  @override
  String get puzzleBackToOverview => 'Atpakaļ uz sarakstu';

  @override
  String get puzzleUnsolvable => 'No šejienes laukumu vairs nevar iztukšot.';

  @override
  String get puzzleExtraMoveVideo => 'Papildu gājiens (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Atrisinātas: $solved';
  }

  @override
  String get settingsTitle => 'Iestatījumi';

  @override
  String get storageFailureTitle => 'Qubble nevar ielādēt saglabāto spēli';

  @override
  String get storageFailureBody =>
      'Lūdzu, restartē lietotni. Ja kļūda atkārtojas, palīdzēs tikai atkārtota instalēšana. Par to vari ziņot sadaļā Iestatījumi › Atsauksmes.';

  @override
  String get iapUnavailable => 'Šis piedāvājums pašlaik nav pieejams.';

  @override
  String get iapFailed => 'Pirkums neizdevās. Nauda netika iekasēta.';

  @override
  String get settingsResetProgress => 'Atiestatīt progresu';

  @override
  String get settingsResetProgressSubtitle =>
      'Punkti, monētas, līmenis un progress atgriežas sākumā. Pirkumi, vārds un kosmētika saglabājas.';

  @override
  String get settingsResetConfirmTitle => 'Atiestatīt progresu?';

  @override
  String get settingsResetConfirmBody =>
      'Rekords, monētas, līmenis, sērija un viss progress tiks dzēsts. To nevar atsaukt.\n\nTavi pirkumi, vārds un atbloķētās tēmas un izskati saglabājas.';

  @override
  String get settingsResetConfirmAction => 'Atiestatīt';

  @override
  String get settingsResetDone => 'Progress atiestatīts.';

  @override
  String get settingsSectionGame => 'Spēle';

  @override
  String get settingsSectionSoundHaptics => 'Skaņa un vibrācija';

  @override
  String get settingsSectionReminders => 'Atgādinājumi';

  @override
  String get settingsSectionPurchases => 'Pirkumi';

  @override
  String get settingsSectionHelpOut => 'Palīdzi';

  @override
  String get settingsSectionLegal => 'Juridiskā informācija';

  @override
  String get settingsSectionLanguage => 'Valoda';

  @override
  String get settingsGuide => 'Kā spēlēt';

  @override
  String get settingsGuideSubtitle =>
      'Noteikumi, kombo, drudzis un pastiprinātāji';

  @override
  String get settingsSound => 'Skaņa';

  @override
  String get settingsMusic => 'Mūzika';

  @override
  String get settingsHaptics => 'Vibrācija';

  @override
  String get settingsHapticsOff => 'Izslēgta';

  @override
  String get settingsHapticsLight => 'Viegla';

  @override
  String get settingsHapticsStrong => 'Spēcīga';

  @override
  String get settingsSectionAccessibility => 'Ērtības';

  @override
  String get settingsReducedEffects => 'Mazāk efektu';

  @override
  String get settingsReducedEffectsHint =>
      'Mazāk daļiņu, bez ekrāna trīcēšanas un mirdzuma';

  @override
  String get settingsNotifications => 'Paziņojumi';

  @override
  String get settingsNotificationsSubtitle =>
      'Dienas atgādinājums un sērijas aizsardzība';

  @override
  String get settingsNotificationsSystemHint =>
      'Atļauj to sistēmas iestatījumos.';

  @override
  String get settingsLanguageSystem => 'Sistēmas valoda';

  @override
  String get settingsSupporterThanks => 'Atbalstītājs — paldies!';

  @override
  String get settingsSupporterPack => 'Atbalstītāja komplekts';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ekskluzīva tēma un izskats + 1 500 monētu';

  @override
  String get settingsRestorePurchases => 'Atjaunot pirkumus';

  @override
  String get settingsRestoring => 'Pirkumi tiek atjaunoti…';

  @override
  String get settingsRateApp => 'Novērtēt lietotni';

  @override
  String get settingsRateAppSubtitle => 'Atstāj vērtējumu veikalā';

  @override
  String get settingsStoreUnavailable => 'Veikals šajā ierīcē nav pieejams.';

  @override
  String get settingsFeedback => 'Sūtīt atsauksmi';

  @override
  String get settingsFeedbackSubtitle =>
      'Ziņo par idejām un kļūdām (ar GitHub)';

  @override
  String get settingsAdPrivacy => 'Reklāmu privātums';

  @override
  String get settingsAdPrivacySubtitle =>
      'Skati vai maini savu piekrišanu reklāmām';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Šajā ierīcē reklāmu iestatījumi nav vajadzīgi.';

  @override
  String get settingsPrivacy => 'Privātuma politika';

  @override
  String get settingsImprint => 'Rekvizīti';

  @override
  String get settingsPageOpenFailed => 'Lapu neizdevās atvērt.';

  @override
  String get settingsFooter => 'Qubble • Bezsaistes bloku mīkla';

  @override
  String get settingsAdminSection => 'Administrators (tests)';

  @override
  String get settingsAdminEnabled => 'Administratora režīms ieslēgts';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Līdz administratora režīmam atlikušie pieskārieni: $count';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monētas',
      one: '$coins monēta',
      zero: '$coins monētu',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Tikai testēšanai — nekad laidiena ekrānuzņēmumos';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount monētas',
      one: '$amount monēta',
      zero: '$amount monētu',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Iestatīt 0 monētu';

  @override
  String get feedbackTitle => 'Atsauksmes';

  @override
  String get feedbackIntroShort =>
      'Kas tev patīk, kas kaitina, kā trūkst? Palīdz arī sīkumi — jo konkrētāk, jo labāk.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Tiek pievienots tikai $build un ierīces tips — lai es zinātu, par kuru versiju tu runā.';
  }

  @override
  String get feedbackSendByMail => 'Sūtīt pa e-pastu';

  @override
  String get feedbackPreferGithub => 'Labāk GitHub issue';

  @override
  String get feedbackThanksMail => 'Paldies! Atliek tikai nosūtīt ziņu.';

  @override
  String get feedbackNoMailApp =>
      'E-pasta lietotne netika atrasta. Izmēģini GitHub ceļu zemāk.';

  @override
  String get feedbackEmptyHint => 'Lūdzu, vispirms kaut ko uzraksti.';

  @override
  String get leaderboardRefresh => 'Atsvaidzināt';

  @override
  String get leaderboardRetry => 'Mēģināt vēlreiz';

  @override
  String get feedbackHint => 'Tava atsauksme…';

  @override
  String get feedbackSubmit => 'Sūtīt atsauksmi';

  @override
  String get feedbackOpenFailed => 'GitHub neizdevās atvērt. Mēģini vēlāk.';

  @override
  String get feedbackGithubNote =>
      'Atveras GitHub — tur pieskaries \"Submit new issue\". (Vienreiz jāpieslēdzas GitHub.)';

  @override
  String get shopTitle => 'Veikals';

  @override
  String get shopWebDemoNote =>
      'Pirkumi pieejami tikai lietotnē no Play Store. Šī tīmekļa versija ir bezmaksas demo — tomēr vari šeit spēlēt visu.';

  @override
  String get shopSupporterExplainer =>
      'Qubble nerāda piespiedu reklāmas — tev nekad nekas nav jāpērk. Atbalstītāja komplekts (tēma „Aurora”, izskats „Kristāls”, 1 500 monētu, atbalstītāja nozīmīte) ir pateicība par spēles atbalstīšanu. Pirkumi ir piesaistīti tavam veikala kontam, un tos var atjaunot jebkurā laikā.';

  @override
  String get shopSupporterContents =>
      'Tēma „Aurora” + izskats „Kristāls” + 1 500 monētu';

  @override
  String get themesTitle => 'Tēmas';

  @override
  String get themesSupporterOnly =>
      'Tikai atbalstītāja komplektā (skati veikalu)';

  @override
  String get skinsTitle => 'Bloku izskati';

  @override
  String get skinsNotEnoughCoins => 'Nepietiek monētu';

  @override
  String get skinsNotEnoughGold => 'Nepietiek zelta.';

  @override
  String skinsExchangeHint(int gold) {
    return 'Zelts $gold = 1 dimants. Dimanti atbloķē skaistākos izskatus — krāj nesteidzoties.';
  }

  @override
  String get statsTitle => 'Statistika';

  @override
  String get statsAverageScore => 'Vid. punkti';

  @override
  String get statsBestCombo => 'Labākais kombo';

  @override
  String get statsGames => 'Spēles';

  @override
  String get statsLinesCleared => 'Notīrītās rindas';

  @override
  String get statsPiecesPlaced => 'Novietotās figūras';

  @override
  String get statsCoins => 'Monētas';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Sasniedz kombo x$countString';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Vienā spēlē pārsniedz $countString punktus';
  }

  @override
  String get achievementsTitle => 'Sasniegumi';

  @override
  String get achievementFirstGameTitle => 'Pirmā spēle';

  @override
  String get achievementFirstGameBody => 'Nospēlē savu pirmo spēli';

  @override
  String get achievementGames25Title => 'Pastāvīgais';

  @override
  String get achievementGames25Body => 'Nospēlē 25 spēles';

  @override
  String get achievementGames100Title => 'Aizrāvies';

  @override
  String get achievementGames100Body => 'Nospēlē 100 spēles';

  @override
  String get achievementScore1kTitle => 'Kāpējs';

  @override
  String get achievementScore1kBody => 'Sasniedz 1 000 punktu';

  @override
  String get achievementScore5kTitle => 'Profesionālis';

  @override
  String get achievementScore5kBody => 'Sasniedz 5 000 punktu';

  @override
  String get achievementScore10kTitle => 'Meistars';

  @override
  String get achievementScore10kBody => 'Sasniedz 10 000 punktu';

  @override
  String get achievementScore25kTitle => 'Leģenda';

  @override
  String get achievementScore25kBody => 'Sasniedz 25 000 punktu';

  @override
  String get achievementLines100Title => 'Kārtīgs';

  @override
  String get achievementLines100Body => 'Kopā notīri 100 rindas';

  @override
  String get achievementLines1000Title => 'Lielā tīrīšana';

  @override
  String get achievementLines1000Body => 'Kopā notīri 1 000 rindas';

  @override
  String get achievementCombo5Title => 'Kombo iesācējs';

  @override
  String get achievementCombo5Body => 'Sasniedz kombo x5';

  @override
  String get achievementCombo10Title => 'Kombo karalis';

  @override
  String get achievementCombo10Body => 'Sasniedz kombo x10';

  @override
  String get achievementLevel10Title => 'Pieredzējis';

  @override
  String get achievementLevel10Body => 'Sasniedz 10. līmeni';

  @override
  String get achievementLevel20Title => 'Veterāns';

  @override
  String get achievementLevel20Body => 'Sasniedz 20. līmeni';

  @override
  String get achievementStreak7Title => 'Nedēļas sērija';

  @override
  String get achievementStreak7Body => '7 dienu dienas izaicinājumu sērija';

  @override
  String get achievementStreak30Title => 'Mēneša sērija';

  @override
  String get achievementStreak30Body => '30 dienu dienas izaicinājumu sērija';

  @override
  String get achievementPuzzles10Title => 'Mīklu minētājs';

  @override
  String get achievementPuzzles10Body => 'Atrisini 10 mīklas';

  @override
  String get achievementPieces5000Title => 'Būvētājs';

  @override
  String get achievementPieces5000Body => 'Novieto 5 000 figūras';

  @override
  String streakRepairTitle(int streak) {
    return 'Tava sērija ($streak d.) ir apdraudēta!';
  }

  @override
  String get streakRepairBody => 'Vakar tu nespēlēji — izglāb savu sēriju:';

  @override
  String get streakRepairFailed => 'Atjaunot nav iespējams.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monētas',
      one: '$coins monēta',
      zero: '$coins monētu',
    );
    return 'Laipni lūgts atpakaļ! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Atgādinājumi?';

  @override
  String get notificationsOptInBody =>
      'Vai atgādināt tev par dienas mīklu un sargāt tavu sēriju? To vari mainīt jebkurā laikā iestatījumos.';

  @override
  String get notificationsOptInAccept => 'Jā, lūdzu';

  @override
  String get notificationChannelDescription =>
      'Dienas atgādinājums, sērijas brīdinājums, atgriešanās';

  @override
  String get notificationDailyTitle => 'Tava dienas mīkla gaida 🧩';

  @override
  String get notificationDailyBody => 'Spēlē šodienas izaicinājumu!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Tava sērija ($streak d.) ir apdraudēta!';
  }

  @override
  String get notificationStreakBody => 'Spēlē šodien, lai to saglabātu.';

  @override
  String get notificationComebackTitle => 'Tavi bloki tevi gaida 🧩';

  @override
  String get notificationComebackBody => 'Atgriezies un saņem dāvanu!';

  @override
  String get iapSupporterPack => 'Atbalstītāja komplekts';

  @override
  String get iapCoinsSmall => '500 monētu';

  @override
  String get iapCoinsMedium => '2 000 monētu';

  @override
  String get iapCoinsLarge => '6 000 monētu';

  @override
  String get iapStarterPack => 'Sākuma komplekts';

  @override
  String get iapRename => 'Vārda maiņa';

  @override
  String get iapNeonTheme => 'Tēma „Neons”';

  @override
  String get settingsLeaderboardDelete => 'Dzēst ierakstu līderu tabulā';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Noņem tavu vārdu un punktus no publiskā saraksta';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Dzēst tavu ierakstu?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tavs vārds un punkti tiks noņemti no līderu tabulas. Spēles progress netiek skarts. Līderu tabulai vari pievienoties vēlreiz jebkurā laikā.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Tavs ieraksts līderu tabulā ir dzēsts.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Ierakstu neizdevās dzēst. Pārbaudi savienojumu un mēģini vēlreiz.';

  @override
  String get leaderboardReport => 'Ziņot par šo vārdu';

  @override
  String get leaderboardBlock => 'Bloķēt';

  @override
  String leaderboardBlocked(String name) {
    return '$name tev ir paslēpts';
  }

  @override
  String get leaderboardUndo => 'Atsaukt';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Tevis paslēptie ieraksti: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Rādīt atkal';

  @override
  String get leaderboardReportUnavailable => 'Pašlaik ziņot nav iespējams.';

  @override
  String get leaderboardReportSent => 'Paldies — tavs ziņojums ir ceļā.';

  @override
  String get leaderboardRules =>
      'Vārdi ir publiski. Nekādu apvainojumu, nekādu nievājošu vārdu un nekā, kas identificē reālu personu. Vārdi, kas to pārkāpj, tiek noņemti.';

  @override
  String get leaderboardRulesAccept => 'Sapratu';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Atbloķēti $unlocked no $total';
  }

  @override
  String get settingsSectionData => 'Saglabātie dati';

  @override
  String get gameRotatePiece => 'Pagriezt figūru';

  @override
  String get themeClassic => 'Klasika';

  @override
  String get themeFade => 'Pasteļi';

  @override
  String get themeNeon => 'Neons';

  @override
  String get themeOcean => 'Okeāns';

  @override
  String get themeWood => 'Koks';

  @override
  String get themeSunset => 'Saulriets';

  @override
  String get themeForest => 'Mežs';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasika';

  @override
  String get skinGradient => 'Gradients';

  @override
  String get skinOutline => 'Kontūra';

  @override
  String get skinGlossy => 'Spīdīgs';

  @override
  String get skinStripe => 'Svītras';

  @override
  String get skinBevel => 'Reljefs';

  @override
  String get skinGlow => 'Mirdzums';

  @override
  String get skinCrystal => 'Kristāls';

  @override
  String rewardThemeName(String name) {
    return 'Tēma „$name”';
  }

  @override
  String rewardSkinName(String name) {
    return 'Izskats „$name”';
  }

  @override
  String get skinPulse => 'Pulss';

  @override
  String get skinShimmer => 'Mirgoņa';

  @override
  String get skinWave => 'Vilnis';

  @override
  String get skinEmber => 'Ogles';

  @override
  String get skinPrism => 'Prizma';

  @override
  String get skinStardust => 'Zvaigžņu putekļi';

  @override
  String get skinCircuit => 'Ķēde';

  @override
  String get skinRipple => 'Viļņošanās';

  @override
  String achievementRewardSkin(String name) {
    return 'Animēts izskats „$name”';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Sasnieguma balva: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Par sasniegumiem tagad pienākas balvas — tavējās ir pievienotas.';

  @override
  String get namePromptBody =>
      'Izvēlies vārdu, un tavs labākais rezultāts nonāks līderu tabulā. Bez vārda turpini spēlēt anonīmi.';

  @override
  String get nameTaken => 'Šis vārds jau ir aizņemts. Pamēģini citu.';

  @override
  String get nameCheckFailed =>
      'Vārdu neizdevās pārbaudīt. Vai esi tiešsaistē? Mēģini vēlreiz pēc brīža.';

  @override
  String nameLost(String name) {
    return '$name tagad pieder citam spēlētājam. Izvēlies jaunu vārdu – bez maksas.';
  }

  @override
  String get themeCandy => 'Konfekte';

  @override
  String get themeVolcano => 'Vulkāns';

  @override
  String get themeGlacier => 'Ledājs';

  @override
  String get skinPixel => 'Pikselis';

  @override
  String get skinMarble => 'Marmors';

  @override
  String get skinJelly => 'Želeja';

  @override
  String get skinLiquid => 'Šķidrums';

  @override
  String get skinFizz => 'Burbuļi';

  @override
  String get skinPlasma => 'Plazma';

  @override
  String get designsTitle => 'Dizaini';

  @override
  String get designsNotEnoughDiamonds => 'Nepietiek dimantu.';

  @override
  String get designsOwned => 'Ir tev';

  @override
  String get designsAchievementOnly => 'Sasniegums';

  @override
  String get designsSupporterOnly => 'Atbalstītājs';

  @override
  String get designsPreview => 'Priekšskatījums';

  @override
  String get designsGetDiamonds => 'Iegūt dimantus';

  @override
  String get shopDealTitle => 'Dienas piedāvājums';

  @override
  String get shopAnimatedSkins => 'Animēti izskati';

  @override
  String get shopNewDesigns => 'Jauni dizaini';

  @override
  String get shopDiamonds => 'Dimanti';

  @override
  String get shopPacks => 'Komplekti';

  @override
  String get shopPopular => 'Populārs';

  @override
  String get shopBestValue => 'Izdevīgākais';

  @override
  String get shopDiamondsBlurb => 'Animētiem izskatiem un jaunajiem dizainiem.';

  @override
  String get shopCoinsBlurb => 'Tēmām, izskatiem un pastiprinātājiem.';

  @override
  String get shopNeonBlurb => 'Uzreiz atbloķē tēmu „Neons”.';

  @override
  String get shopRenameBlurb => 'Maini savu vārdu līderu tabulā.';

  @override
  String shopHoursLeft(int hours) {
    return 'Vēl $hours h';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Jauns piedāvājums pēc $time';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name atbloķēts!';
  }

  @override
  String get questsTitle => 'Uzdevumi';

  @override
  String get questsDaily => 'Dienas';

  @override
  String get questsWeekly => 'Nedēļas';

  @override
  String get questsMonthly => 'Mēneša';

  @override
  String questsNewIn(String time) {
    return 'Jauni uzdevumi pēc $time';
  }

  @override
  String get questsBonus => 'Bonuss par visiem';

  @override
  String get questsBonusEarned => 'Bonuss saņemts';

  @override
  String get questRounds => 'Spēlē raundus';

  @override
  String get questLines => 'Notīri rindas';

  @override
  String get questPieces => 'Novieto figūras';

  @override
  String get questDailyChallenge => 'Spēlē dienas izaicinājumu';

  @override
  String get questPuzzles => 'Atrisini jaunas mīklas';

  @override
  String get questDays => 'Spēlē dažādās dienās';

  @override
  String get questDailySets => 'Izpildi visus dienas uzdevumus';

  @override
  String get questsSetDaily => 'Visi dienas uzdevumi izpildīti!';

  @override
  String get questsSetWeekly => 'Visi nedēļas uzdevumi izpildīti!';

  @override
  String get questsSetMonthly => 'Visi mēneša uzdevumi izpildīti!';

  @override
  String get leaderboardTabScore => 'Labākais rezultāts';

  @override
  String get leaderboardTabPuzzle => 'Mīklu zvaigznes';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Tavas mīklu zvaigznes tiek iesniegtas automātiski.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Tiek iesniegtas tavas mīklu zvaigznes ($stars) …';
  }
}
