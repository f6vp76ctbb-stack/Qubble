// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class L10nSq extends L10n {
  L10nSq([String locale = 'sq']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Luaj';

  @override
  String get commonLater => 'Më vonë';

  @override
  String get commonNotNow => 'Jo tani';

  @override
  String get commonCancel => 'Anulo';

  @override
  String get commonBuy => 'Bli';

  @override
  String get commonSave => 'Ruaj';

  @override
  String get commonCollect => 'Merr';

  @override
  String get nameNewName => 'Emër i ri';

  @override
  String get nameFieldLabel => 'Emri';

  @override
  String get piggyFullTitle => 'Kumbaraja është plot!';

  @override
  String get piggyKeepSaving => 'Vazhdo të kursesh';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity të mbledhura.';
  }

  @override
  String get homeContinueRun => 'Vazhdo';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Në rregull';

  @override
  String get commonHome => 'Kreu';

  @override
  String get commonScore => 'PIKËT';

  @override
  String get commonBest => 'REKORDI';

  @override
  String commonLevelShort(int level) {
    return 'Niveli $level';
  }

  @override
  String get homeNewRun => 'Nis një lojë të re';

  @override
  String get homeBackToExit => 'Shtyp përsëri «Prapa» për të dalë';

  @override
  String get homeEnableLeaderboard => 'Bashkohu në renditje';

  @override
  String get homeBestScore => 'REKORDI';

  @override
  String get homeDailyChallenge => 'Sfida ditore';

  @override
  String get homeDailyOpenToday => 'E hapur sot';

  @override
  String homeDailyNextIn(String time) {
    return 'Sfida tjetër: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak ditë radhazi';
  }

  @override
  String get homeLeaderboard => 'Renditja';

  @override
  String get homePuzzleMode => 'Enigmat';

  @override
  String get homeHowToPlay => 'Si luhet Qubble';

  @override
  String get homeWeekendBonus => 'Fundjavë: monedha dyfish!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Niveli $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Ndrysho emrin';

  @override
  String get nameChangeExplainer =>
      'Emri yt është identiteti yt në renditje, prandaj mbetet i njëjtë. Mund të blesh një ndryshim emri të vetëm.';

  @override
  String get nameChangeAfterPurchase =>
      'Pas blerjes, prek sërish emrin tënd për ta ndryshuar.';

  @override
  String get nameJoinedLeaderboard => 'Tani je në renditje.';

  @override
  String nameProblemTooShort(int min) {
    return 'Të paktën $min shenja.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Jo më shumë se $max shenja.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Lejohen vetëm shkronjat latine (A–Z, edhe ë dhe ç), shifrat, hapësira, _ dhe -.';

  @override
  String get nameProblemOffensive => 'Të lutem zgjidh një emër tjetër.';

  @override
  String get piggyTitle => 'Kumbaraja';

  @override
  String get piggyFillingHint => 'Kumbaraja mbushet ndërsa pastron vija.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: 'Merr $coins monedha falas.',
      one: 'Merr $coins monedhë falas.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kur mbushet, e zbraz falas — ose e hap më herët me një video bonus.';

  @override
  String get piggyOpenNow => 'Hape tani';

  @override
  String get gameNewPiecesVideo => 'Pjesë të reja (video)';

  @override
  String get gameTapBoardCell => 'Prek një kuti në fushë';

  @override
  String get gameDailyChallengeLabel => 'SFIDA DITORE';

  @override
  String get gameOver => 'Loja mbaroi';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Për bombën duhen më shumë monedha: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomba nuk vepron këtu tani.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Për këtë duhen më shumë monedha: $missing.';
  }

  @override
  String get gameNotRightNow => 'Jo tani.';

  @override
  String get gameRunSaved => 'Loja u ruajt — «Vazhdo» te menyja.';

  @override
  String get gameOverNoFit => 'Asnjë nga pjesët e tua nuk futet më në fushë.';

  @override
  String get gameOverNoFitNoRotations =>
      'Asnjë pjesë nuk futet — dhe rrotullimet mbaruan.';

  @override
  String get gameStarterOfferUnavailable => 'E padisponueshme tani';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — merre';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Arritje: $title';
  }

  @override
  String get gameBestSubmitted => 'Rekord i ri — u dërgua';

  @override
  String get gameReviveFor => 'Vazhdo lojën · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'U zhbllokua: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Paketa fillestare';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pikë',
      one: '$score pikë',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Rekord i ri!';

  @override
  String gameStreakDays(int streak) {
    return '$streak ditë radhazi';
  }

  @override
  String get gameDoubleCoins => 'Dyfisho monedhat';

  @override
  String get gameDoubleDaily => 'Dyfisho shpërblimin ditor';

  @override
  String get gamePlayAgain => 'Luaj përsëri';

  @override
  String gameLevelReached(int level) {
    return 'Arrite nivelin $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count nivele — niveli $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 monedha + tema Dru';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Edhe vetëm $hours orë — vetëm një herë!';
  }

  @override
  String get boosterUndo => 'Zhbëj';

  @override
  String get boosterSwap => 'Ndërro';

  @override
  String get boosterBomb => 'Bombë';

  @override
  String get boosterNoRotationsLeft =>
      'S’ka më rrotullime — pastro vija për t’i rimbushur!';

  @override
  String get onboardingDragPiece => 'Tërhiq një bllok në rrjetë';

  @override
  String get onboardingFillLine => 'Mbush një rresht ose kolonë të plotë';

  @override
  String get onboardingLinesClear => 'Vijat e plota zhduken — pikë!';

  @override
  String get coachHintCombo =>
      'Kombo! Pastro sërish brenda 3 lëvizjeve që ta mbash';

  @override
  String get coachHintFever => 'VRULL! Pikë dyfish sa kohë shkëlqen';

  @override
  String get coachHintRotation =>
      'Rrotullimi kushton një ngarkesë — pastrimet e rimbushin';

  @override
  String get coachHintBooster => 'Këshillë: poshtë ke përforcues';

  @override
  String get coachHintStrategy =>
      'Këshillë: jo të gjitha vijat njëherësh — lër vend për pjesët e mëdha';

  @override
  String get dailyStreakLabel => 'Seria';

  @override
  String get dailyBestLabel => 'Rekordi ditor';

  @override
  String dailyHistoryNote(int days) {
    return 'Ruhen $days ditët e fundit.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Dita $day: luajtur';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Dita $day: pa luajtur';
  }

  @override
  String get homeDailyCalendar => 'Kalendari';

  @override
  String get dailyShareButton => 'Ndaj rezultatin';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Sfida ditore $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Pikë: $score · Kombo më e mirë x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Luaj: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Kombo: edhe $moves lëvizje',
      one: 'Kombo: edhe $moves lëvizje',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Rezultati u kopjua';

  @override
  String get adNotAvailable => 'S’ka video tani — provo sërish pas pak';

  @override
  String get howToPlaySpeedTitle => 'Bonusi i shpejtësisë';

  @override
  String get howToPlaySpeedBody =>
      'Vendosja e shpejtë i shton deri në 30 % çdo pastrimi. Bonusi zbret nga 1,5 deri në 4 sekonda dhe ka një kufi, kështu që shpejtësia ndihmon, por nuk e vendos lojën — një lojë e qetë dhe e menduar mund ta mundë ende një lojë të nxituar.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus shpejtësie $percent për qind';
  }

  @override
  String get iapDiamondsSmall => '100 diamante';

  @override
  String get iapDiamondsMedium => '350 diamante';

  @override
  String get iapDiamondsLarge => '1 000 diamante';

  @override
  String get howToPlayTitle => 'Si luhet Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'E lehtë për të nisur.\nShpërblen kush mendon përpara.';

  @override
  String get howToPlayIntroBody =>
      'Mbaje fushën të lirë dhe thyej rekordin tënd.';

  @override
  String get howToPlayIntroSemantics =>
      'Qëllimi i lojës. Mbaje fushën të lirë dhe thyej rekordin tënd.';

  @override
  String get howToPlayDragTitle => 'Tërhiq dhe lësho';

  @override
  String get howToPlayDragBody =>
      'Tërhiq një nga tri pjesët në kutitë e lira. Kur i ke vendosur të trija, vijnë vetvetiu tri të reja.';

  @override
  String get howToPlayClearTitle => 'Pastro vijat';

  @override
  String get howToPlayClearBody =>
      'Mbush një rresht ose kolonë të plotë. Vijat e plota zhduken dhe lënë vend për lëvizjen tjetër.';

  @override
  String get howToPlayComboTitle => 'Lidh kombo';

  @override
  String get howToPlayComboBody =>
      'Pastro një vijë tjetër brenda tri lëvizjeve. Çdo kombo shtesë rrit shumëzuesin e pikëve. Kombo numëron lëvizje, jo sekonda — ndaj nuk mbaron ndërsa mendohesh.';

  @override
  String get howToPlayFeverTitle => 'Ndiz vrullin';

  @override
  String get howToPlayFeverBody =>
      'Pastrimet mbushin matësin e vrullit. Kur mbushet, shpërthimi tjetër numërohet dyfish — planifiko pastrimet e mëdha.';

  @override
  String get howToPlayBoosterTitle => 'Përdor përforcuesit me mend';

  @override
  String get howToPlayBoosterBody =>
      'Përforcuesit shpëtojnë lojërat e vështira. Mund ta rrotullosh edhe një pjesë poshtë duke e prekur.';

  @override
  String get howToPlayDailyTitle => 'Sfida ditore dhe seria';

  @override
  String get howToPlayDailyBody =>
      'Në sfidën ditore të gjithë marrin të njëjtat pjesë. Luaj çdo ditë për të rritur serinë dhe bonusin.';

  @override
  String get howToPlayPiggyTitle => 'Mbush kumbaranë';

  @override
  String get howToPlayPiggyBody =>
      'Çdo vijë e pastruar e mbush kumbaranë. Kur është plot, merr monedhat falas.';

  @override
  String get leaderboardTitle => 'Renditja';

  @override
  String get leaderboardUnreachable =>
      'Renditja nuk arrihet.\nProvo sërish me internet.';

  @override
  String get leaderboardEmpty => 'Ende pa hyrje.\nZëre vendin e parë!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Po dërgohet rekordi yt ($score) …';
  }

  @override
  String get leaderboardAutoSubmit => 'Rekordi yt dërgohet automatikisht.';

  @override
  String get puzzleModeTitle => 'Enigmat';

  @override
  String puzzleLevelTitle(int level) {
    return 'Enigma $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Lëvizje: $moves   •   Objektivi: $target për 3 yje';
  }

  @override
  String get puzzleSolved => 'U zgjidh!';

  @override
  String get puzzleLeaveTitle => 'Të dalësh nga enigma?';

  @override
  String get puzzleLeaveBody => 'Përparimi yt në këtë enigmë do të humbasë.';

  @override
  String get puzzleKeepPlaying => 'Vazhdo të luash';

  @override
  String get puzzleLeave => 'Dil';

  @override
  String get puzzleStuckTitle => 'Pa rrugëdalje';

  @override
  String get puzzleRestart => 'Rinis';

  @override
  String get commonActive => 'Aktive';

  @override
  String get commonRestore => 'Rikthe';

  @override
  String get skinsExchangeGold => 'Këmbe arin';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Rrotullo pjesën';

  @override
  String get puzzleNextLevel => 'Niveli tjetër';

  @override
  String get puzzleBackToOverview => 'Kthehu te lista';

  @override
  String get puzzleUnsolvable => 'Nga këtu fusha nuk mund të pastrohet më.';

  @override
  String get puzzleExtraMoveVideo => 'Lëvizje shtesë (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Të zgjidhura: $solved';
  }

  @override
  String get settingsTitle => 'Cilësimet';

  @override
  String get storageFailureTitle => 'Qubble nuk po e ngarkon lojën e ruajtur';

  @override
  String get storageFailureBody =>
      'Të lutem rinis aplikacionin. Nëse gabimi vazhdon, zgjidhja e vetme është ta instalosh sërish. Mund ta raportosh te Cilësimet › Përshtypjet.';

  @override
  String get iapUnavailable => 'Kjo ofertë nuk është e disponueshme tani.';

  @override
  String get iapFailed => 'Blerja nuk u krye. Nuk u tarifua asgjë.';

  @override
  String get settingsResetProgress => 'Rivendos përparimin';

  @override
  String get settingsResetProgressSubtitle =>
      'Pikët, monedhat, niveli dhe përparimi nga e para. Blerjet, emri dhe stilet mbeten.';

  @override
  String get settingsResetConfirmTitle => 'Të rivendoset përparimi?';

  @override
  String get settingsResetConfirmBody =>
      'Rekordi, monedhat, niveli, seria dhe i gjithë përparimi do të fshihen. Kjo nuk kthehet pas.\n\nBlerjet, emri dhe temat e stilet e zhbllokuara mbeten.';

  @override
  String get settingsResetConfirmAction => 'Rivendos';

  @override
  String get settingsResetDone => 'Përparimi u rivendos.';

  @override
  String get settingsSectionGame => 'Loja';

  @override
  String get settingsSectionSoundHaptics => 'Zëri dhe dridhja';

  @override
  String get settingsSectionReminders => 'Kujtesat';

  @override
  String get settingsSectionPurchases => 'Blerjet';

  @override
  String get settingsSectionHelpOut => 'Ndihmo';

  @override
  String get settingsSectionLegal => 'Ligjore';

  @override
  String get settingsSectionLanguage => 'Gjuha';

  @override
  String get settingsGuide => 'Si luhet';

  @override
  String get settingsGuideSubtitle =>
      'Rregullat, kombo, vrulli dhe përforcuesit';

  @override
  String get settingsSound => 'Zëri';

  @override
  String get settingsMusic => 'Muzika';

  @override
  String get settingsHaptics => 'Dridhja';

  @override
  String get settingsHapticsOff => 'Fikur';

  @override
  String get settingsHapticsLight => 'E lehtë';

  @override
  String get settingsHapticsStrong => 'E fortë';

  @override
  String get settingsSectionAccessibility => 'Aksesueshmëria';

  @override
  String get settingsReducedEffects => 'Më pak efekte';

  @override
  String get settingsReducedEffectsHint =>
      'Më pak grimca, pa dridhje ekrani, pa ndezje';

  @override
  String get settingsNotifications => 'Njoftimet';

  @override
  String get settingsNotificationsSubtitle =>
      'Kujtesë ditore dhe mbrojtje e serisë';

  @override
  String get settingsNotificationsSystemHint =>
      'Lejoji te cilësimet e sistemit.';

  @override
  String get settingsLanguageSystem => 'Gjuha e sistemit';

  @override
  String get settingsSupporterThanks => 'Faleminderit për mbështetjen!';

  @override
  String get settingsSupporterPack => 'Paketa e mbështetësit';

  @override
  String get settingsSupporterPackSubtitle =>
      'Temë dhe stil ekskluziv + 1 500 monedha';

  @override
  String get settingsRestorePurchases => 'Rikthe blerjet';

  @override
  String get settingsRestoring => 'Po rikthehen blerjet…';

  @override
  String get settingsRateApp => 'Vlerëso aplikacionin';

  @override
  String get settingsRateAppSubtitle => 'Jep një vlerësim në dyqan';

  @override
  String get settingsStoreUnavailable =>
      'Dyqani nuk është i disponueshëm në këtë pajisje.';

  @override
  String get settingsFeedback => 'Dërgo përshtypje';

  @override
  String get settingsFeedbackSubtitle => 'Ide dhe gabime (përmes GitHub)';

  @override
  String get settingsAdPrivacy => 'Privatësia e reklamave';

  @override
  String get settingsAdPrivacySubtitle =>
      'Shiko ose ndrysho pëlqimin për reklamat';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Në këtë pajisje nuk nevojiten opsione reklamash.';

  @override
  String get settingsPrivacy => 'Politika e privatësisë';

  @override
  String get settingsImprint => 'Informacion ligjor';

  @override
  String get settingsPageOpenFailed => 'Faqja nuk u hap.';

  @override
  String get settingsFooter => 'Qubble • Enigmë me blloqe pa internet';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Modaliteti admin aktiv';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Edhe $count prekje për modalitetin admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monedha',
      one: '$coins monedhë',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Vetëm për testim — kurrë në pamjet e publikimit';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount monedha',
      one: '$amount monedhë',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Monedhat në 0';

  @override
  String get feedbackTitle => 'Përshtypjet';

  @override
  String get feedbackIntroShort =>
      'Çfarë të pëlqen, çfarë të bezdis, çfarë mungon? Edhe gjërat e vogla ndihmojnë — sa më konkrete, aq më mirë.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Shtohen vetëm $build dhe lloji i pajisjes — që të di për cilin version bëhet fjalë.';
  }

  @override
  String get feedbackSendByMail => 'Dërgo me email';

  @override
  String get feedbackPreferGithub => 'Më mirë një issue në GitHub';

  @override
  String get feedbackThanksMail => 'Faleminderit! Mjafton ta dërgosh mesazhin.';

  @override
  String get feedbackNoMailApp =>
      'Nuk u gjet aplikacion emaili. Provo me GitHub më poshtë.';

  @override
  String get feedbackEmptyHint => 'Të lutem shkruaj diçka fillimisht.';

  @override
  String get leaderboardRefresh => 'Rifresko';

  @override
  String get leaderboardRetry => 'Provo sërish';

  @override
  String get feedbackHint => 'Përshtypjet e tua…';

  @override
  String get feedbackSubmit => 'Dërgo përshtypjet';

  @override
  String get feedbackOpenFailed => 'GitHub nuk u hap. Provo më vonë.';

  @override
  String get feedbackGithubNote =>
      'Hapet GitHub — atje prek «Submit new issue». (Duhet hyrje në GitHub një herë.)';

  @override
  String get shopTitle => 'Dyqani';

  @override
  String get shopWebDemoNote =>
      'Blerjet janë vetëm në aplikacionin e Play Store. Ky version web është demo falas — gjithsesi këtu mund të luash gjithçka.';

  @override
  String get shopSupporterExplainer =>
      'Qubble nuk shfaq reklama të detyruara — nuk ke nevojë të blesh asgjë. Paketa e mbështetësit (tema Aurora, stili Kristal, 1 500 monedha, distinktivi i mbështetësit) është një falënderim që e mbështet lojën. Blerjet lidhen me llogarinë tënde të dyqanit dhe mund të rikthehen kurdo.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + stili Kristal + 1 500 monedha';

  @override
  String get themesTitle => 'Temat';

  @override
  String get themesSupporterOnly =>
      'Vetëm në paketën e mbështetësit (shih dyqanin)';

  @override
  String get skinsTitle => 'Stilet e blloqeve';

  @override
  String get skinsNotEnoughCoins => 'S’ke monedha të mjaftueshme';

  @override
  String get skinsNotEnoughGold => 'S’ke ar të mjaftueshëm.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold ar = 1 diamant. Diamantet zhbllokojnë stilet më të bukura — mblidhi me qetësi.';
  }

  @override
  String get statsTitle => 'Statistikat';

  @override
  String get statsAverageScore => 'Pikët mesatare';

  @override
  String get statsBestCombo => 'Kombo më e mirë';

  @override
  String get statsGames => 'Lojëra';

  @override
  String get statsLinesCleared => 'Vija të pastruara';

  @override
  String get statsPiecesPlaced => 'Pjesë të vendosura';

  @override
  String get statsCoins => 'Monedha';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Arrij kombo x$countString';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kalo $countString pikë në një lojë',
      one: 'Kalo $countString pikë në një lojë',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Arritjet';

  @override
  String get achievementFirstGameTitle => 'Loja e parë';

  @override
  String get achievementFirstGameBody => 'Luaj lojën tënde të parë';

  @override
  String get achievementGames25Title => 'I rregullt';

  @override
  String get achievementGames25Body => 'Luaj 25 lojëra';

  @override
  String get achievementGames100Title => 'Adhurues';

  @override
  String get achievementGames100Body => 'Luaj 100 lojëra';

  @override
  String get achievementScore1kTitle => 'Në ngjitje';

  @override
  String get achievementScore1kBody => 'Arrij 1 000 pikë';

  @override
  String get achievementScore5kTitle => 'Profesionist';

  @override
  String get achievementScore5kBody => 'Arrij 5 000 pikë';

  @override
  String get achievementScore10kTitle => 'Mjeshtër';

  @override
  String get achievementScore10kBody => 'Arrij 10 000 pikë';

  @override
  String get achievementScore25kTitle => 'Legjendë';

  @override
  String get achievementScore25kBody => 'Arrij 25 000 pikë';

  @override
  String get achievementLines100Title => 'Rregull';

  @override
  String get achievementLines100Body => 'Pastro 100 vija gjithsej';

  @override
  String get achievementLines1000Title => 'Pastrim i madh';

  @override
  String get achievementLines1000Body => 'Pastro 1 000 vija gjithsej';

  @override
  String get achievementCombo5Title => 'Fillim kombo';

  @override
  String get achievementCombo5Body => 'Arrij kombo x5';

  @override
  String get achievementCombo10Title => 'Mbret i kombove';

  @override
  String get achievementCombo10Body => 'Arrij kombo x10';

  @override
  String get achievementLevel10Title => 'Me përvojë';

  @override
  String get achievementLevel10Body => 'Arrij nivelin 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Arrij nivelin 20';

  @override
  String get achievementStreak7Title => 'Seri javore';

  @override
  String get achievementStreak7Body => '7 ditë radhazi në sfidën ditore';

  @override
  String get achievementStreak30Title => 'Seri mujore';

  @override
  String get achievementStreak30Body => '30 ditë radhazi në sfidën ditore';

  @override
  String get achievementPuzzles10Title => 'Zgjidhës enigmash';

  @override
  String get achievementPuzzles10Body => 'Zgjidh 10 enigma';

  @override
  String get achievementPieces5000Title => 'Ndërtues';

  @override
  String get achievementPieces5000Body => 'Vendos 5 000 pjesë';

  @override
  String streakRepairTitle(int streak) {
    return 'Seria prej $streak ditësh në rrezik!';
  }

  @override
  String get streakRepairBody => 'Dje nuk u luajt — shpëto serinë tënde:';

  @override
  String get streakRepairFailed => 'Nuk u riparua.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monedha',
      one: '$coins monedhë',
    );
    return 'Mirë se u ktheve! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Kujtesa?';

  @override
  String get notificationsOptInBody =>
      'Të të kujtojmë enigmën ditore dhe të mbrojmë serinë tënde? Mund ta ndryshosh kurdo te cilësimet.';

  @override
  String get notificationsOptInAccept => 'Po, patjetër';

  @override
  String get notificationChannelDescription =>
      'Kujtesë ditore, paralajmërim serie, rikthim';

  @override
  String get notificationDailyTitle => 'Enigma jote ditore të pret 🧩';

  @override
  String get notificationDailyBody => 'Luaj sfidën e sotme!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Seria jote prej $streak ditësh në rrezik!';
  }

  @override
  String get notificationStreakBody => 'Luaj sot që ta mbash.';

  @override
  String get notificationComebackTitle => 'Blloqet të presin 🧩';

  @override
  String get notificationComebackBody => 'Kthehu dhe merr shpërblimin!';

  @override
  String get iapSupporterPack => 'Paketa e mbështetësit';

  @override
  String get iapCoinsSmall => '500 monedha';

  @override
  String get iapCoinsMedium => '2 000 monedha';

  @override
  String get iapCoinsLarge => '6 000 monedha';

  @override
  String get iapStarterPack => 'Paketa fillestare';

  @override
  String get iapRename => 'Ndryshim emri';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Fshi hyrjen në renditje';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Heq emrin dhe pikët nga lista publike';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Të fshihet hyrja jote?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Emri dhe pikët e tua hiqen nga renditja. Përparimi në lojë nuk ndryshon. Mund t’i bashkohesh sërish renditjes kurdo.';

  @override
  String get settingsLeaderboardDeleteDone => 'Hyrja jote në renditje u fshi.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Hyrja nuk u fshi. Kontrollo lidhjen dhe provo sërish.';

  @override
  String get leaderboardReport => 'Raporto këtë emër';

  @override
  String get leaderboardBlock => 'Fshih';

  @override
  String leaderboardBlocked(String name) {
    return '$name u fsheh për ty';
  }

  @override
  String get leaderboardUndo => 'Zhbëj';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Hyrje të fshehura nga ti: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Shfaqi sërish';

  @override
  String get leaderboardReportUnavailable =>
      'Raportimi nuk është i mundur tani.';

  @override
  String get leaderboardReportSent => 'Faleminderit — raporti u dërgua.';

  @override
  String get leaderboardRules =>
      'Emrat janë publikë. Pa fyerje, sharje apo gjëra që identifikojnë një person real. Emrat që e shkelin këtë rregull hiqen.';

  @override
  String get leaderboardRulesAccept => 'Në rregull';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Të zhbllokuara: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'Të dhënat e ruajtura';

  @override
  String get gameRotatePiece => 'Rrotullo pjesën';

  @override
  String get themeClassic => 'Klasike';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Oqean';

  @override
  String get themeWood => 'Dru';

  @override
  String get themeSunset => 'Perëndim';

  @override
  String get themeForest => 'Pyll';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasik';

  @override
  String get skinGradient => 'Gradient';

  @override
  String get skinOutline => 'Kontur';

  @override
  String get skinGlossy => 'Me shkëlqim';

  @override
  String get skinStripe => 'Me vija';

  @override
  String get skinBevel => 'I pjerrët';

  @override
  String get skinGlow => 'Ndriçim';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Stili $name';
  }

  @override
  String get skinPulse => 'Puls';

  @override
  String get skinShimmer => 'Vezullim';

  @override
  String get skinWave => 'Valë';

  @override
  String get skinEmber => 'Prush';

  @override
  String get skinPrism => 'Prizëm';

  @override
  String get skinStardust => 'Pluhur yjesh';

  @override
  String get skinCircuit => 'Qark';

  @override
  String get skinRipple => 'Rrathë uji';

  @override
  String achievementRewardSkin(String name) {
    return 'Stil i animuar: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Shpërblim arritjeje: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Arritjet tani japin shpërblime — të tuat u shtuan.';

  @override
  String get namePromptBody =>
      'Zgjidh një emër dhe rezultati yt më i mirë del në renditje. Pa emër vazhdon të luash në mënyrë anonime.';

  @override
  String get nameTaken => 'Ky emër është zënë tashmë. Provo një tjetër.';

  @override
  String get nameCheckFailed =>
      'Emri nuk mund të kontrollohej. A je në internet? Provo sërish pas pak.';

  @override
  String nameLost(String name) {
    return '$name tani i përket një lojtari tjetër. Zgjidh një emër të ri, falas.';
  }

  @override
  String get themeCandy => 'Karamele';

  @override
  String get themeVolcano => 'Vullkan';

  @override
  String get themeGlacier => 'Akullnajë';

  @override
  String get skinPixel => 'Piksel';

  @override
  String get skinMarble => 'Mermer';

  @override
  String get skinJelly => 'Xhelatinë';

  @override
  String get skinLiquid => 'Lëng';

  @override
  String get skinFizz => 'Flluska';

  @override
  String get skinPlasma => 'Plazma';

  @override
  String get designsTitle => 'Dizajnet';

  @override
  String get designsNotEnoughDiamonds => 'S’ke diamante të mjaftueshme.';

  @override
  String get designsOwned => 'E jotja';

  @override
  String get designsAchievementOnly => 'Arritje';

  @override
  String get designsSupporterOnly => 'Mbështetës';

  @override
  String get designsPreview => 'Parapamje';

  @override
  String get designsGetDiamonds => 'Merr diamante';

  @override
  String get shopDealTitle => 'Oferta e ditës';

  @override
  String get shopAnimatedSkins => 'Stile të animuara';

  @override
  String get shopNewDesigns => 'Dizajne të reja';

  @override
  String get shopDiamonds => 'Diamante';

  @override
  String get shopPacks => 'Paketa';

  @override
  String get shopPopular => 'Popullore';

  @override
  String get shopBestValue => 'Më e leverdishme';

  @override
  String get shopDiamondsBlurb => 'Për stilet e animuara dhe dizajnet e reja.';

  @override
  String get shopCoinsBlurb => 'Për tema, stile dhe përforcues.';

  @override
  String get shopNeonBlurb => 'Hap menjëherë temën Neon.';

  @override
  String get shopRenameBlurb => 'Ndrysho emrin në renditje.';

  @override
  String shopHoursLeft(int hours) {
    return 'Edhe $hours orë';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Ofertë e re pas $time';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name u hap!';
  }

  @override
  String get questsTitle => 'Misione';

  @override
  String get questsDaily => 'Ditore';

  @override
  String get questsWeekly => 'Javore';

  @override
  String get questsMonthly => 'Mujore';

  @override
  String questsNewIn(String time) {
    return 'Misione të reja pas $time';
  }

  @override
  String get questsBonus => 'Bonus për të gjitha';

  @override
  String get questsBonusEarned => 'Bonusi u fitua';

  @override
  String get questRounds => 'Luaj raunde';

  @override
  String get questLines => 'Pastro vija';

  @override
  String get questPieces => 'Vendos pjesë';

  @override
  String get questDailyChallenge => 'Luaj sfidën ditore';

  @override
  String get questPuzzles => 'Zgjidh enigma të reja';

  @override
  String get questDays => 'Luaj në ditë të ndryshme';

  @override
  String get questDailySets => 'Kryej të gjitha misionet ditore';

  @override
  String get questsSetDaily => 'Të gjitha misionet ditore u kryen!';

  @override
  String get questsSetWeekly => 'Të gjitha misionet javore u kryen!';

  @override
  String get questsSetMonthly => 'Të gjitha misionet mujore u kryen!';

  @override
  String get leaderboardTabScore => 'Rezultati më i mirë';

  @override
  String get leaderboardTabPuzzle => 'Yjet e enigmave';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Yjet e tua të enigmave dërgohen automatikisht.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Po dërgohen yjet e tua të enigmave ($stars) …';
  }

  @override
  String get dailyGoalTitle => 'Objektivi i sotëm';

  @override
  String dailyGoalPoints(String points) {
    return '$points pikë';
  }

  @override
  String get dailyChestOpened => 'Sënduku i serisë u hap!';

  @override
  String dailyNextChest(int day) {
    return 'Sënduku tjetër: dita $day e serisë';
  }

  @override
  String get dailyExplainer =>
      'Sot të gjithë luajnë të njëjtën fushë dhe llogaritet raundi yt i parë. Arri pragjet e yjeve për monedha shtesë, mbaje serinë për sëndukë me diamante dhe shiko në cilin vend je sot.';

  @override
  String dailyRank(int rank, int total) {
    return 'Vendi $rank nga $total sot';
  }

  @override
  String get dailyRankNeedsName =>
      'Zgjidh një emër për t\'u shfaqur në renditje.';

  @override
  String get dailyRankingButton => 'Renditja e sotme';

  @override
  String get leaderboardTabDaily => 'Sfida e sotme';

  @override
  String get leaderboardDailyFooter =>
      'E njëjta fushë për të gjithë, llogaritet raundi i parë. Çdo ditë renditje e re.';
}
