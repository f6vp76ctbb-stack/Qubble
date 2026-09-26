// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class L10nFil extends L10n {
  L10nFil([String locale = 'fil']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Maglaro';

  @override
  String get commonLater => 'Mamaya';

  @override
  String get commonNotNow => 'Hindi muna';

  @override
  String get commonCancel => 'Kanselahin';

  @override
  String get commonBuy => 'Bilhin';

  @override
  String get commonSave => 'I-save';

  @override
  String get commonCollect => 'Kunin';

  @override
  String get nameNewName => 'Bagong pangalan';

  @override
  String get nameFieldLabel => 'Pangalan';

  @override
  String get piggyFullTitle => 'Puno na ang alkansya!';

  @override
  String get piggyKeepSaving => 'Mag-ipon pa';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins sa $capacity ang naipon.';
  }

  @override
  String get homeContinueRun => 'Ituloy';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Sige';

  @override
  String get commonHome => 'Home';

  @override
  String get commonScore => 'ISKOR';

  @override
  String get commonBest => 'RECORD';

  @override
  String commonLevelShort(int level) {
    return 'Level $level';
  }

  @override
  String get homeNewRun => 'Magsimula ng bagong laro';

  @override
  String get homeBackToExit => 'Pindutin ulit ang Back para lumabas';

  @override
  String get homeEnableLeaderboard => 'Sumali sa leaderboard';

  @override
  String get homeBestScore => 'PINAKAMATAAS NA ISKOR';

  @override
  String get homeDailyChallenge => 'Hamon ng Araw';

  @override
  String get homeDailyOpenToday => 'Bukas ngayon';

  @override
  String homeDailyNextIn(String time) {
    return 'Susunod na hamon sa loob ng $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'Streak: $streak araw';
  }

  @override
  String get homeLeaderboard => 'Leaderboard';

  @override
  String get homePuzzleMode => 'Puzzle Mode';

  @override
  String get homeMissions => 'Mga Misyon';

  @override
  String get homeThemes => 'Mga Tema';

  @override
  String get homeSkins => 'Mga Skin';

  @override
  String get homeHowToPlay => 'Paano laruin ang Qubble';

  @override
  String get homeWeekendBonus => 'Weekend: dobleng barya!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Level $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Palitan ang pangalan';

  @override
  String get nameChangeExplainer =>
      'Ang pangalan mo ang pagkakakilanlan mo sa leaderboard, kaya hindi ito nagbabago. Puwede kang bumili ng isang beses na pagpapalit ng pangalan.';

  @override
  String get nameChangeAfterPurchase =>
      'Pagkatapos bumili, i-tap ulit ang pangalan mo para palitan ito.';

  @override
  String get nameJoinedLeaderboard => 'Nasa leaderboard ka na.';

  @override
  String get nameRenameUnavailable =>
      'Hindi puwedeng palitan ang pangalan ngayon.';

  @override
  String nameProblemTooShort(int min) {
    return 'Hindi bababa sa $min character.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Hanggang $max character lang.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Mga letrang A–Z lang (walang ñ), numero, espasyo, _ at -.';

  @override
  String get nameProblemOffensive => 'Pumili ng ibang pangalan.';

  @override
  String get piggyTitle => 'Alkansya';

  @override
  String get piggyFillingHint =>
      'Napupuno ang alkansya habang nagki-clear ka ng mga hanay.';

  @override
  String piggyCollect(int coins) {
    return 'Kunin ang $coins barya — libre.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kapag puno na, puwede mo itong kunin nang libre — o buksan nang mas maaga gamit ang bonus video.';

  @override
  String get piggyOpenNow => 'Buksan na';

  @override
  String get gameNewPiecesVideo => 'Bagong piraso (video)';

  @override
  String get gameTapBoardCell => 'I-tap ang isang kahon sa board';

  @override
  String get gameDailyChallengeLabel => 'HAMON NG ARAW';

  @override
  String get gameOver => 'Tapos na ang laro';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Kulang ang barya para sa bomba: $missing.';
  }

  @override
  String get gameBombNotHere => 'Hindi gumagana ang bomba rito ngayon.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Kulang ang barya: $missing.';
  }

  @override
  String get gameNotRightNow => 'Hindi puwede ngayon.';

  @override
  String get gameRunSaved => 'Na-save ang laro — \"Ituloy\" sa menu.';

  @override
  String get gameOverNoFit => 'Wala nang piraso mong kasya sa board.';

  @override
  String get gameOverNoFitNoRotations =>
      'Walang kasyang piraso — at ubos na ang mga pag-ikot.';

  @override
  String get gameStarterOfferUnavailable => 'Hindi available ngayon';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — kunin';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Achievement: $title';
  }

  @override
  String get gameBestSubmitted => 'Bagong record — naipadala';

  @override
  String get gameReviveFor => 'Ituloy ang laro · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Na-unlock: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Starter pack';

  @override
  String gameOverPoints(int score) {
    return '$score puntos';
  }

  @override
  String get gameNewRecord => 'Bagong record!';

  @override
  String gameStreakDays(int streak) {
    return 'Streak: $streak araw';
  }

  @override
  String get gameDoubleCoins => 'Dobleng barya';

  @override
  String get gameDoubleDaily => 'Dobleng daily reward';

  @override
  String get gamePlayAgain => 'Maglaro ulit';

  @override
  String gameLevelReached(int level) {
    return 'Umabot sa Level $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count level — Level $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 barya + temang Kahoy';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '$hours oras na lang — minsan lang!';
  }

  @override
  String get boosterUndo => 'I-undo';

  @override
  String get boosterSwap => 'Palitan';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Wala nang pag-ikot — mag-clear ng mga hanay para mag-recharge!';

  @override
  String get onboardingDragPiece => 'I-drag ang isang piraso sa grid';

  @override
  String get onboardingFillLine => 'Punuin ang isang buong hanay o kolum';

  @override
  String get onboardingLinesClear => 'Nawawala ang mga punong linya — puntos!';

  @override
  String get coachHintCombo =>
      'Combo! Mag-clear ulit sa loob ng 3 galaw para mapanatili ito';

  @override
  String get coachHintFever => 'FEVER! Dobleng puntos habang nagliliwanag';

  @override
  String get coachHintRotation =>
      'Isang charge ang bawat pag-ikot — nare-recharge sa pag-clear';

  @override
  String get coachHintBooster => 'Tip: may mga booster sa ibaba';

  @override
  String get coachHintStrategy =>
      'Tip: huwag sabay-sabay ang lahat ng linya — mag-iwan ng puwang para sa malalaking piraso';

  @override
  String get dailyStreakLabel => 'Streak';

  @override
  String get dailyBestLabel => 'Pinakamataas ngayong araw';

  @override
  String dailyHistoryNote(int days) {
    return 'Itinatago ang huling $days araw.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: nalaro';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: hindi nalaro';
  }

  @override
  String get homeDailyCalendar => 'Kalendaryo';

  @override
  String get dailyShareButton => 'I-share ang resulta';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Hamon ng Araw $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Iskor: $score · pinakamahusay na combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Maglaro: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Combo: $moves galaw pa';
  }

  @override
  String get dailyShareCopied => 'Nakopya ang resulta';

  @override
  String get adNotAvailable => 'Walang video ngayon — subukan ulit mamaya';

  @override
  String get howToPlaySpeedTitle => 'Speed bonus';

  @override
  String get howToPlaySpeedBody =>
      'Ang mabilis na paglalagay ay nagdadagdag ng hanggang 30% sa isang clear. Humihina ang bonus mula 1.5 hanggang 4 na segundo at may limitasyon, kaya sulit ang bilis pero hindi ito ang nagpapasya ng laro — puwede pa ring manalo ang maingat at mabagal na laro laban sa padalos-dalos.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Speed bonus $percent porsiyento';
  }

  @override
  String get iapDiamondsSmall => '100 diyamante';

  @override
  String get iapDiamondsMedium => '350 diyamante';

  @override
  String get iapDiamondsLarge => '1,000 diyamante';

  @override
  String get howToPlayTitle => 'Paano laruin ang Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Madaling simulan.\nMay gantimpala ang pagpaplano.';

  @override
  String get howToPlayIntroBody =>
      'Panatilihing maluwag ang board at talunin ang record mo.';

  @override
  String get howToPlayIntroSemantics =>
      'Layunin ng laro. Panatilihing maluwag ang board at talunin ang record mo.';

  @override
  String get howToPlayDragTitle => 'I-drag at ilagay';

  @override
  String get howToPlayDragBody =>
      'I-drag ang isa sa tatlong piraso sa mga bakanteng kahon. Kapag nagamit na ang tatlo, awtomatiko kang bibigyan ng tatlong bago.';

  @override
  String get howToPlayClearTitle => 'Mag-clear ng mga linya';

  @override
  String get howToPlayClearBody =>
      'Punuin ang isang buong hanay o kolum. Nawawala ang mga punong linya at nagbibigay ng puwang sa susunod mong galaw.';

  @override
  String get howToPlayComboTitle => 'Pagdugtungin ang combo';

  @override
  String get howToPlayComboBody =>
      'Mag-clear ng isa pang linya sa loob ng tatlong galaw. Bawat kasunod na combo ay nagpapataas ng multiplier ng puntos. Galaw ang binibilang ng combo, hindi segundo, kaya hindi ito nauubos habang nag-iisip ka.';

  @override
  String get howToPlayFeverTitle => 'Pasiklabin ang fever';

  @override
  String get howToPlayFeverBody =>
      'Pinupuno ng mga clear ang fever meter. Kapag puno na, doble ang susunod na malaking clear — planuhin nang maaga ang malalaking clear.';

  @override
  String get howToPlayBoosterTitle => 'Gamitin nang matalino ang booster';

  @override
  String get howToPlayBoosterBody =>
      'Nililigtas ng mga booster ang masisikip na laro. Puwede mo ring i-tap ang isang piraso sa ibaba para iikot ito.';

  @override
  String get howToPlayDailyTitle => 'Hamon ng Araw at streak';

  @override
  String get howToPlayDailyBody =>
      'Pare-pareho ang mga piraso ng lahat sa Hamon ng Araw. Maglaro araw-araw para lumaki ang streak at bonus mo.';

  @override
  String get howToPlayPiggyTitle => 'Punuin ang alkansya';

  @override
  String get howToPlayPiggyBody =>
      'Bawat linyang na-clear ay pumupuno sa alkansya mo. Kapag puno na, makukuha mo ang mga barya nang libre.';

  @override
  String get leaderboardTitle => 'Leaderboard';

  @override
  String get leaderboardUnreachable =>
      'Hindi available ang leaderboard.\nSubukan ulit nang may internet.';

  @override
  String get leaderboardEmpty => 'Wala pang entry.\nMauna ka!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Ipinapadala ang pinakamataas mong iskor ($score) …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Awtomatikong ipinapadala ang pinakamataas mong iskor.';

  @override
  String get puzzleModeTitle => 'Puzzle Mode';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puzzle $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Galaw: $moves   •   Target: $target para sa 3 bituin';
  }

  @override
  String get puzzleSolved => 'Nalutas!';

  @override
  String get puzzleLeaveTitle => 'Iwan ang puzzle?';

  @override
  String get puzzleLeaveBody => 'Mawawala ang progreso mo sa puzzle na ito.';

  @override
  String get puzzleKeepPlaying => 'Ituloy ang laro';

  @override
  String get puzzleLeave => 'Iwan';

  @override
  String get puzzleStuckTitle => 'Barado';

  @override
  String get puzzleRestart => 'Ulitin';

  @override
  String get commonActive => 'Aktibo';

  @override
  String get commonTapToActivate => 'I-tap para i-activate';

  @override
  String get commonRestore => 'I-restore';

  @override
  String unlockForCost(int cost) {
    return 'I-unlock sa halagang $cost';
  }

  @override
  String get skinsExchangeGold => 'Ipalit ang ginto';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Iikot ang piraso';

  @override
  String get puzzleNextLevel => 'Susunod na level';

  @override
  String get puzzleBackToOverview => 'Bumalik sa listahan';

  @override
  String get puzzleUnsolvable => 'Hindi na mauubos ang board mula rito.';

  @override
  String get puzzleExtraMoveVideo => 'Dagdag na galaw (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Nalutas: $solved';
  }

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get storageFailureTitle =>
      'Hindi ma-load ng Qubble ang naka-save mong laro';

  @override
  String get storageFailureBody =>
      'Paki-restart ang app. Kung hindi pa rin maayos, pag-reinstall lang ang makakatulong. Puwede mo itong i-report sa Mga Setting › Feedback.';

  @override
  String get iapUnavailable => 'Hindi available ang alok na ito ngayon.';

  @override
  String get iapFailed => 'Hindi natuloy ang pagbili. Walang sinisingil.';

  @override
  String get settingsResetProgress => 'I-reset ang progreso';

  @override
  String get settingsResetProgressSubtitle =>
      'Iskor, barya, level at progreso — balik sa simula. Mananatili ang mga binili, pangalan at mga cosmetic.';

  @override
  String get settingsResetConfirmTitle => 'I-reset ang progreso?';

  @override
  String get settingsResetConfirmBody =>
      'Mabubura ang pinakamataas na iskor, barya, level, streak at lahat ng progreso. Hindi na ito maibabalik.\n\nMananatili ang mga binili mo, ang pangalan mo at ang mga na-unlock na tema at skin.';

  @override
  String get settingsResetConfirmAction => 'I-reset';

  @override
  String get settingsResetDone => 'Na-reset ang progreso.';

  @override
  String get settingsSectionGame => 'Laro';

  @override
  String get settingsSectionSoundHaptics => 'Tunog at vibration';

  @override
  String get settingsSectionReminders => 'Mga paalala';

  @override
  String get settingsSectionPurchases => 'Mga binili';

  @override
  String get settingsSectionHelpOut => 'Tumulong';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionLanguage => 'Wika';

  @override
  String get settingsGuide => 'Paano maglaro';

  @override
  String get settingsGuideSubtitle => 'Mga patakaran, combo, fever at booster';

  @override
  String get settingsSound => 'Tunog';

  @override
  String get settingsMusic => 'Musika';

  @override
  String get settingsHaptics => 'Vibration';

  @override
  String get settingsHapticsOff => 'Off';

  @override
  String get settingsHapticsLight => 'Mahina';

  @override
  String get settingsHapticsStrong => 'Malakas';

  @override
  String get settingsSectionAccessibility => 'Ginhawa';

  @override
  String get settingsReducedEffects => 'Mas kaunting effect';

  @override
  String get settingsReducedEffectsHint =>
      'Mas kaunting particle, walang pag-alog ng screen, walang glow';

  @override
  String get settingsNotifications => 'Mga notification';

  @override
  String get settingsNotificationsSubtitle =>
      'Araw-araw na paalala at proteksyon ng streak';

  @override
  String get settingsNotificationsSystemHint =>
      'Payagan ito sa settings ng system.';

  @override
  String get settingsLanguageSystem => 'Wika ng system';

  @override
  String get settingsSupporterThanks => 'Supporter — salamat!';

  @override
  String get settingsSupporterPack => 'Supporter pack';

  @override
  String get settingsSupporterPackSubtitle =>
      'Eksklusibong tema at skin + 1,500 barya';

  @override
  String get settingsRestorePurchases => 'I-restore ang mga binili';

  @override
  String get settingsRestoring => 'Nire-restore ang mga binili…';

  @override
  String get settingsRateApp => 'I-rate ang app';

  @override
  String get settingsRateAppSubtitle => 'Mag-iwan ng rating sa store';

  @override
  String get settingsStoreUnavailable =>
      'Hindi available ang store sa device na ito.';

  @override
  String get settingsFeedback => 'Magpadala ng feedback';

  @override
  String get settingsFeedbackSubtitle => 'Mga ideya at bug (sa GitHub)';

  @override
  String get settingsAdPrivacy => 'Privacy ng ad';

  @override
  String get settingsAdPrivacySubtitle =>
      'Tingnan o baguhin ang pahintulot mo sa ad';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Walang kailangang setting ng ad sa device na ito.';

  @override
  String get settingsPrivacy => 'Patakaran sa privacy';

  @override
  String get settingsImprint => 'Impormasyon ng publisher';

  @override
  String get settingsPageOpenFailed => 'Hindi mabuksan ang page.';

  @override
  String get settingsFooter => 'Qubble • Offline na block puzzle';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Naka-on ang admin mode';

  @override
  String settingsAdminTapsLeft(int count) {
    return '$count tap pa para sa admin mode';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins barya';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Para sa pag-test lang — huwag ipakita sa release screenshot';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount barya';
  }

  @override
  String get settingsAdminResetCoins => 'Gawing 0 ang barya';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Ano ang gusto mo, ano ang nakakainis, ano ang kulang? Nakakatulong kahit maliliit na bagay — mas tiyak, mas mabuti.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Ang $build at uri ng device mo lang ang ikakabit — para alam ko kung aling bersyon ang tinutukoy mo.';
  }

  @override
  String get feedbackSendByMail => 'Ipadala sa email';

  @override
  String get feedbackPreferGithub => 'Mas gusto ko ang GitHub issue';

  @override
  String get feedbackThanksMail => 'Salamat! Ipadala mo na lang ang mensahe.';

  @override
  String get feedbackNoMailApp =>
      'Walang email app. Subukan ang GitHub sa ibaba.';

  @override
  String get feedbackEmptyHint => 'Magsulat ka muna.';

  @override
  String get leaderboardRefresh => 'I-refresh';

  @override
  String get leaderboardRetry => 'Subukan ulit';

  @override
  String get feedbackHint => 'Ang feedback mo…';

  @override
  String get feedbackSubmit => 'Magpadala ng feedback';

  @override
  String get feedbackOpenFailed =>
      'Hindi mabuksan ang GitHub. Subukan ulit mamaya.';

  @override
  String get feedbackGithubNote =>
      'Magbubukas ang GitHub — i-tap doon ang \"Submit new issue\". (Kailangan ng isang beses na pag-login sa GitHub.)';

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopWebDemoNote =>
      'Sa app mula sa Play Store lang puwedeng bumili. Libreng demo ang web version na ito — pero puwede mong laruin ang lahat dito.';

  @override
  String get shopSupporterExplainer =>
      'Walang sapilitang ad ang Qubble — hindi mo kailangang bumili ng kahit ano. Ang supporter pack (temang Aurora, skin na Kristal, 1,500 barya, supporter badge) ay pasasalamat sa pagsuporta sa laro. Naka-link ang mga binili sa store account mo at puwedeng i-restore anumang oras.';

  @override
  String get shopSupporterContents =>
      'Temang Aurora + skin na Kristal + 1,500 barya';

  @override
  String get themesTitle => 'Mga Tema';

  @override
  String get themesSupporterOnly => 'Sa supporter pack lang (tingnan ang shop)';

  @override
  String get themesInSupporterPack => 'Kasama sa supporter pack';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Kulang ang barya (kailangan $cost, mayroon $coins)';
  }

  @override
  String get skinsTitle => 'Mga skin ng block';

  @override
  String get skinsNotEnoughDiamonds =>
      'Kulang ang diyamante (ipalit ang ginto sa ibaba)';

  @override
  String get skinsNotEnoughCoins => 'Kulang ang barya';

  @override
  String get skinsNotEnoughGold => 'Kulang ang ginto.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold ginto = 1 diyamante. Binubuksan ng diyamante ang pinakamagagandang skin — mag-ipon nang dahan-dahan.';
  }

  @override
  String get statsTitle => 'Stats';

  @override
  String get statsAverageScore => 'Average na iskor';

  @override
  String get statsBestCombo => 'Pinakamahusay na combo';

  @override
  String get statsGames => 'Mga laro';

  @override
  String get statsLinesCleared => 'Na-clear na hanay';

  @override
  String get statsPiecesPlaced => 'Nailagay na piraso';

  @override
  String get statsCoins => 'Barya';

  @override
  String get missionsTitle => 'Mga Misyon';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Maglagay ng $countString piraso';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Mag-clear ng $countString hanay';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Umabot sa ${countString}x combo';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Makakuha ng $countString puntos sa isang laro';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Maglaro ng $countString laro';
  }

  @override
  String get achievementsTitle => 'Mga Achievement';

  @override
  String get achievementFirstGameTitle => 'Unang laro';

  @override
  String get achievementFirstGameBody => 'Laruin ang una mong laro';

  @override
  String get achievementGames25Title => 'Suki';

  @override
  String get achievementGames25Body => 'Maglaro ng 25 laro';

  @override
  String get achievementGames100Title => 'Adik';

  @override
  String get achievementGames100Body => 'Maglaro ng 100 laro';

  @override
  String get achievementScore1kTitle => 'Umaakyat';

  @override
  String get achievementScore1kBody => 'Umabot sa 1,000 puntos';

  @override
  String get achievementScore5kTitle => 'Pro';

  @override
  String get achievementScore5kBody => 'Umabot sa 5,000 puntos';

  @override
  String get achievementScore10kTitle => 'Master';

  @override
  String get achievementScore10kBody => 'Umabot sa 10,000 puntos';

  @override
  String get achievementScore25kTitle => 'Alamat';

  @override
  String get achievementScore25kBody => 'Umabot sa 25,000 puntos';

  @override
  String get achievementLines100Title => 'Maayos';

  @override
  String get achievementLines100Body => 'Mag-clear ng 100 hanay sa kabuuan';

  @override
  String get achievementLines1000Title => 'General cleaning';

  @override
  String get achievementLines1000Body => 'Mag-clear ng 1,000 hanay sa kabuuan';

  @override
  String get achievementCombo5Title => 'Baguhan sa combo';

  @override
  String get achievementCombo5Body => 'Umabot sa 5x combo';

  @override
  String get achievementCombo10Title => 'Hari ng combo';

  @override
  String get achievementCombo10Body => 'Umabot sa 10x combo';

  @override
  String get achievementLevel10Title => 'Bihasa';

  @override
  String get achievementLevel10Body => 'Umabot sa Level 10';

  @override
  String get achievementLevel20Title => 'Beterano';

  @override
  String get achievementLevel20Body => 'Umabot sa Level 20';

  @override
  String get achievementStreak7Title => 'Streak ng linggo';

  @override
  String get achievementStreak7Body => '7 araw na daily streak';

  @override
  String get achievementStreak30Title => 'Streak ng buwan';

  @override
  String get achievementStreak30Body => '30 araw na daily streak';

  @override
  String get achievementPuzzles10Title => 'Manlulutas';

  @override
  String get achievementPuzzles10Body => 'Lutasin ang 10 puzzle';

  @override
  String get achievementPieces5000Title => 'Tagabuo';

  @override
  String get achievementPieces5000Body => 'Maglagay ng 5,000 piraso';

  @override
  String streakRepairTitle(int streak) {
    return 'Nanganganib ang $streak araw mong streak!';
  }

  @override
  String get streakRepairBody =>
      'Nalaktawan mo kahapon — iligtas ang streak mo:';

  @override
  String get streakRepairFailed => 'Hindi puwedeng ayusin.';

  @override
  String comebackGift(int coins) {
    return 'Maligayang pagbabalik! +$coins barya';
  }

  @override
  String get notificationsOptInTitle => 'Mga paalala?';

  @override
  String get notificationsOptInBody =>
      'Ipaalala ba namin sa iyo ang daily puzzle mo at protektahan ang streak mo? Puwede mo itong baguhin anumang oras sa settings.';

  @override
  String get notificationsOptInAccept => 'Oo, sige';

  @override
  String get notificationChannelDescription =>
      'Araw-araw na paalala, babala sa streak, imbitasyong bumalik';

  @override
  String get notificationDailyTitle => 'Naghihintay ang daily puzzle mo 🧩';

  @override
  String get notificationDailyBody => 'Laruin ang hamon ngayong araw!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Nanganganib ang $streak araw mong streak!';
  }

  @override
  String get notificationStreakBody => 'Maglaro ngayon para mapanatili ito.';

  @override
  String get notificationComebackTitle => 'Nami-miss ka ng puzzle mo 🧩';

  @override
  String get notificationComebackBody => 'Bumalik at kunin ang regalo mo!';

  @override
  String get iapSupporterPack => 'Supporter pack';

  @override
  String get iapCoinsSmall => '500 barya';

  @override
  String get iapCoinsMedium => '2,000 barya';

  @override
  String get iapCoinsLarge => '6,000 barya';

  @override
  String get iapStarterPack => 'Starter pack';

  @override
  String get iapRename => 'Pagpapalit ng pangalan';

  @override
  String get iapNeonTheme => 'Temang Neon';

  @override
  String get settingsLeaderboardDelete => 'Burahin ang entry sa leaderboard';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Inaalis ang pangalan at iskor mo sa pampublikong listahan';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Burahin ang entry mo?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Aalisin sa leaderboard ang pangalan at iskor mo. Hindi magbabago ang progreso mo sa laro. Puwede kang sumali ulit sa leaderboard anumang oras.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Nabura na ang entry mo sa leaderboard.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Hindi mabura ang entry. Tingnan ang koneksyon at subukan ulit.';

  @override
  String get leaderboardReport => 'I-report ang pangalang ito';

  @override
  String get leaderboardBlock => 'Itago';

  @override
  String leaderboardBlocked(String name) {
    return 'Nakatago sa iyo ang $name';
  }

  @override
  String get leaderboardUndo => 'I-undo';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Mga entry na itinago mo: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Ipakita ulit';

  @override
  String get leaderboardReportUnavailable =>
      'Hindi puwedeng mag-report ngayon.';

  @override
  String get leaderboardReportSent => 'Salamat — naipadala na ang report mo.';

  @override
  String get leaderboardRules =>
      'Pampubliko ang mga pangalan. Bawal ang insulto, mura at anumang nagpapakilala sa totoong tao. Aalisin ang mga pangalang lalabag dito.';

  @override
  String get leaderboardRulesAccept => 'Naiintindihan ko';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked sa $total ang na-unlock';
  }

  @override
  String get settingsSectionData => 'Naka-save na data';

  @override
  String get gameRotatePiece => 'Iikot ang piraso';

  @override
  String get themeClassic => 'Klasiko';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Karagatan';

  @override
  String get themeWood => 'Kahoy';

  @override
  String get themeSunset => 'Paglubog ng araw';

  @override
  String get themeForest => 'Gubat';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasiko';

  @override
  String get skinGradient => 'Gradient';

  @override
  String get skinOutline => 'Balangkas';

  @override
  String get skinGlossy => 'Makintab';

  @override
  String get skinStripe => 'Guhit';

  @override
  String get skinBevel => 'Bevel';

  @override
  String get skinGlow => 'Liwanag';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return 'Temang $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skin na $name';
  }
}
