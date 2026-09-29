// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class L10nAf extends L10n {
  L10nAf([String locale = 'af']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Speel';

  @override
  String get commonLater => 'Later';

  @override
  String get commonNotNow => 'Nie nou nie';

  @override
  String get commonCancel => 'Kanselleer';

  @override
  String get commonBuy => 'Koop';

  @override
  String get commonSave => 'Stoor';

  @override
  String get commonCollect => 'Haal';

  @override
  String get nameNewName => 'Nuwe naam';

  @override
  String get nameFieldLabel => 'Naam';

  @override
  String get piggyFullTitle => 'Die spaarvarkie is vol!';

  @override
  String get piggyKeepSaving => 'Spaar verder';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins van $capacity versamel.';
  }

  @override
  String get homeContinueRun => 'Speel verder';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Verstaan';

  @override
  String get commonHome => 'Tuis';

  @override
  String get commonScore => 'TELLING';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Vlak $level';
  }

  @override
  String get homeNewRun => 'Begin \'n nuwe spel';

  @override
  String get homeBackToExit => 'Druk weer terug om uit te gaan';

  @override
  String get homeEnableLeaderboard => 'Sluit by die ranglys aan';

  @override
  String get homeBestScore => 'REKORD';

  @override
  String get homeDailyChallenge => 'Daaglikse uitdaging';

  @override
  String get homeDailyOpenToday => 'Vandag nog oop';

  @override
  String homeDailyNextIn(String time) {
    return 'Volgende uitdaging oor $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Reeks van $streak dae',
      one: 'Reeks van $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Ranglys';

  @override
  String get homePuzzleMode => 'Puzzelmodus';

  @override
  String get homeHowToPlay => 'So speel jy Qubble';

  @override
  String get homeWeekendBonus => 'Naweek: dubbele munte!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Vlak $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Verander naam';

  @override
  String get nameChangeExplainer =>
      'Jou naam is jou identiteit op die ranglys, daarom bly dit vas. Jy kan \'n eenmalige naamsverandering koop.';

  @override
  String get nameChangeAfterPurchase =>
      'Tik ná die aankoop weer op jou naam om dit te verander.';

  @override
  String get nameJoinedLeaderboard => 'Jy is nou op die ranglys.';

  @override
  String nameProblemTooShort(int min) {
    return 'Minstens $min karakters.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Hoogstens $max karakters.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Net letters sonder aksente (A–Z), syfers, spasies, _ en -.';

  @override
  String get nameProblemOffensive => 'Kies asseblief \'n ander naam.';

  @override
  String get piggyTitle => 'Spaarvarkie';

  @override
  String get piggyFillingHint =>
      'Jou spaarvarkie word voller terwyl jy lyne skoonmaak.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: 'Haal $coins munte — gratis.',
      one: 'Haal $coins munt — gratis.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Wanneer dit vol is, maak jy dit gratis leeg — of jy maak dit vroeër oop met \'n bonusvideo.';

  @override
  String get piggyOpenNow => 'Maak nou oop';

  @override
  String get gameNewPiecesVideo => 'Nuwe blokke (video)';

  @override
  String get gameTapBoardCell => 'Tik op \'n blokkie op die bord';

  @override
  String get gameDailyChallengeLabel => 'DAAGLIKSE UITDAGING';

  @override
  String get gameOver => 'Spel verby';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Munte kort vir die bom: $missing.';
  }

  @override
  String get gameBombNotHere => 'Die bom werk nie nou hier nie.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Munte kort: $missing.';
  }

  @override
  String get gameNotRightNow => 'Nie nou moontlik nie.';

  @override
  String get gameRunSaved => 'Spel gestoor — “Speel verder” in die kieslys.';

  @override
  String get gameOverNoFit =>
      'Nie een van jou blokke pas meer op die bord nie.';

  @override
  String get gameOverNoFitNoRotations =>
      'Geen blok pas nie — en jou draaie is op.';

  @override
  String get gameStarterOfferUnavailable => 'Nie nou beskikbaar nie';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — kry dit';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Prestasie: $title';
  }

  @override
  String get gameBestSubmitted => 'Nuwe rekord — ingestuur';

  @override
  String get gameReviveFor => 'Speel verder · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Ontsluit: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Beginpak';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score punte',
      one: '$score punt',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Nuwe rekord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Reeks van $streak dae',
      one: 'Reeks van $streak dag',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Verdubbel munte';

  @override
  String get gameDoubleDaily => 'Verdubbel dagbeloning';

  @override
  String get gamePlayAgain => 'Speel weer';

  @override
  String gameLevelReached(int level) {
    return 'Vlak $level bereik!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vlakke op — vlak $level!',
      one: '$count vlak op — vlak $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 munte + tema Hout';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Net nog $hours uur — eenmalig!',
      one: 'Net nog $hours uur — eenmalig!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Ontdoen';

  @override
  String get boosterSwap => 'Ruil';

  @override
  String get boosterBomb => 'Bom';

  @override
  String get boosterNoRotationsLeft =>
      'Geen draaie meer nie — maak lyne skoon om dit aan te vul!';

  @override
  String get onboardingDragPiece => 'Sleep \'n blok na die rooster';

  @override
  String get onboardingFillLine => 'Vul \'n hele ry of kolom';

  @override
  String get onboardingLinesClear => 'Vol lyne verdwyn — punte!';

  @override
  String get coachHintCombo =>
      'Kombo! Maak binne 3 skuiwe weer \'n lyn skoon om dit te hou';

  @override
  String get coachHintFever => 'KOORS! Dubbele punte solank dit gloei';

  @override
  String get coachHintRotation =>
      'Draai kos \'n lading — skoongemaakte lyne vul dit weer aan';

  @override
  String get coachHintBooster => 'Wenk: onder kan jy hupstote gebruik';

  @override
  String get coachHintStrategy =>
      'Wenk: nie elke lyn dadelik nie — hou plek oop vir groot blokke';

  @override
  String get dailyStreakLabel => 'Reeks';

  @override
  String get dailyBestLabel => 'Dagrekord';

  @override
  String dailyHistoryNote(int days) {
    return 'Die laaste $days dae word bewaar.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Dag $day: gespeel';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Dag $day: nie gespeel nie';
  }

  @override
  String get homeDailyCalendar => 'Kalender';

  @override
  String get dailyShareButton => 'Deel resultaat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Daaglikse uitdaging $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Punte: $score · beste kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Speel: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Kombo: nog $moves skuiwe',
      one: 'Kombo: nog $moves skuif',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Resultaat gekopieer';

  @override
  String get adNotAvailable =>
      'Geen video nou beskikbaar nie — probeer later weer';

  @override
  String get howToPlaySpeedTitle => 'Spoedbonus';

  @override
  String get howToPlaySpeedBody =>
      'Vinnig plaas gee tot 30 % ekstra per skoongemaakte lyn. Die bonus neem af tussen 1,5 en 4 sekondes en het \'n plafon: spoed betaal, maar besluit nie die spel nie — \'n rustige, deurdagte spel kan steeds \'n haastige een klop.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Spoedbonus $percent persent';
  }

  @override
  String get iapDiamondsSmall => '100 diamante';

  @override
  String get iapDiamondsMedium => '350 diamante';

  @override
  String get iapDiamondsLarge => '1 000 diamante';

  @override
  String get howToPlayTitle => 'So speel jy Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Maklik om te begin.\nVooruitdink betaal.';

  @override
  String get howToPlayIntroBody => 'Hou die bord oop en klop jou rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Doel van die spel. Hou die bord oop en klop jou rekord.';

  @override
  String get howToPlayDragTitle => 'Sleep en plaas';

  @override
  String get howToPlayDragBody =>
      'Sleep een van die drie blokke na oop blokkies. Sodra al drie gebruik is, kry jy outomaties drie nuwes.';

  @override
  String get howToPlayClearTitle => 'Maak lyne skoon';

  @override
  String get howToPlayClearBody =>
      'Vul \'n hele ry of kolom. Vol lyne verdwyn en maak plek vir jou volgende skuif.';

  @override
  String get howToPlayComboTitle => 'Ryg kombo\'s';

  @override
  String get howToPlayComboBody =>
      'Maak binne drie skuiwe nog \'n lyn skoon. Elke volgende kombo verhoog jou puntevermenigvuldiger. Die kombo tel skuiwe, nie sekondes nie, so dit loop nooit uit terwyl jy dink nie.';

  @override
  String get howToPlayFeverTitle => 'Ontketen die koors';

  @override
  String get howToPlayFeverBody =>
      'Skoongemaakte lyne vul die koorsmeter. Wanneer dit vol is, tel die volgende groot slag dubbel — beplan jou groot skuiwe vooruit.';

  @override
  String get howToPlayBoosterTitle => 'Gebruik hupstote slim';

  @override
  String get howToPlayBoosterBody =>
      'Hupstote red moeilike spele. Jy kan ook op \'n blok onder tik om dit te draai.';

  @override
  String get howToPlayDailyTitle => 'Daaglikse uitdaging en reeks';

  @override
  String get howToPlayDailyBody =>
      'Die daaglikse uitdaging gee almal dieselfde blokke. Speel elke dag om jou reeks en bonus te laat groei.';

  @override
  String get howToPlayPiggyTitle => 'Vul die spaarvarkie';

  @override
  String get howToPlayPiggyBody =>
      'Elke skoongemaakte lyn vul jou spaarvarkie. Wanneer dit vol is, haal jy die munte gratis.';

  @override
  String get leaderboardTitle => 'Ranglys';

  @override
  String get leaderboardUnreachable =>
      'Ranglys nie beskikbaar nie.\nProbeer weer met \'n internetverbinding.';

  @override
  String get leaderboardEmpty => 'Nog niemand nie.\nWees die eerste!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Jou rekord ($score) word ingestuur …';
  }

  @override
  String get leaderboardAutoSubmit => 'Jou rekord word outomaties ingestuur.';

  @override
  String get puzzleModeTitle => 'Puzzelmodus';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puzzel $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Skuiwe: $moves   •   Doel: $target vir 3 sterre';
  }

  @override
  String get puzzleSolved => 'Opgelos!';

  @override
  String get puzzleLeaveTitle => 'Verlaat puzzel?';

  @override
  String get puzzleLeaveBody => 'Jou vordering in hierdie puzzel gaan verlore.';

  @override
  String get puzzleKeepPlaying => 'Speel verder';

  @override
  String get puzzleLeave => 'Verlaat';

  @override
  String get puzzleStuckTitle => 'Vas';

  @override
  String get puzzleRestart => 'Begin oor';

  @override
  String get commonActive => 'Aktief';

  @override
  String get commonRestore => 'Herstel';

  @override
  String get skinsExchangeGold => 'Ruil goud';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Draai blok';

  @override
  String get puzzleNextLevel => 'Volgende vlak';

  @override
  String get puzzleBackToOverview => 'Terug na die oorsig';

  @override
  String get puzzleUnsolvable =>
      'Van hier af kan die bord nie meer leeg word nie.';

  @override
  String get puzzleExtraMoveVideo => 'Ekstra skuif (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved opgelos';
  }

  @override
  String get settingsTitle => 'Instellings';

  @override
  String get storageFailureTitle =>
      'Qubble kan nie jou gestoorde spel laai nie';

  @override
  String get storageFailureBody =>
      'Herbegin asseblief die toep. As die fout bly, help net herinstallering. Jy kan dit aanmeld via Instellings › Terugvoer.';

  @override
  String get iapUnavailable => 'Hierdie aanbod is nie nou beskikbaar nie.';

  @override
  String get iapFailed => 'Die aankoop het nie geslaag nie. Niks is gehef nie.';

  @override
  String get settingsResetProgress => 'Stel vordering terug';

  @override
  String get settingsResetProgressSubtitle =>
      'Telling, munte, vlak en vordering terug na die begin. Aankope, naam en voorkoms bly.';

  @override
  String get settingsResetConfirmTitle => 'Stel vordering terug?';

  @override
  String get settingsResetConfirmBody =>
      'Rekord, munte, vlak, reeks en alle vordering word uitgevee. Dit kan nie ongedaan gemaak word nie.\n\nJou aankope, naam en ontsluite temas en voorkoms bly behoue.';

  @override
  String get settingsResetConfirmAction => 'Stel terug';

  @override
  String get settingsResetDone => 'Vordering teruggestel.';

  @override
  String get settingsSectionGame => 'Spel';

  @override
  String get settingsSectionSoundHaptics => 'Klank en vibrasie';

  @override
  String get settingsSectionReminders => 'Herinneringe';

  @override
  String get settingsSectionPurchases => 'Aankope';

  @override
  String get settingsSectionHelpOut => 'Help mee';

  @override
  String get settingsSectionLegal => 'Regsinligting';

  @override
  String get settingsSectionLanguage => 'Taal';

  @override
  String get settingsGuide => 'So speel jy';

  @override
  String get settingsGuideSubtitle => 'Reëls, kombo\'s, koors en hupstote';

  @override
  String get settingsSound => 'Klank';

  @override
  String get settingsMusic => 'Musiek';

  @override
  String get settingsHaptics => 'Vibrasie';

  @override
  String get settingsHapticsOff => 'Af';

  @override
  String get settingsHapticsLight => 'Lig';

  @override
  String get settingsHapticsStrong => 'Sterk';

  @override
  String get settingsSectionAccessibility => 'Toeganklikheid';

  @override
  String get settingsReducedEffects => 'Minder effekte';

  @override
  String get settingsReducedEffectsHint =>
      'Minder deeltjies, geen skud nie, geen gloed nie';

  @override
  String get settingsNotifications => 'Kennisgewings';

  @override
  String get settingsNotificationsSubtitle =>
      'Daaglikse herinnering en reeksbeskerming';

  @override
  String get settingsNotificationsSystemHint =>
      'Laat dit toe in jou stelselinstellings.';

  @override
  String get settingsLanguageSystem => 'Stelseltaal';

  @override
  String get settingsSupporterThanks => 'Dankie vir jou steun!';

  @override
  String get settingsSupporterPack => 'Ondersteunerspak';

  @override
  String get settingsSupporterPackSubtitle =>
      'Eksklusiewe tema en voorkoms + 1 500 munte';

  @override
  String get settingsRestorePurchases => 'Herstel aankope';

  @override
  String get settingsRestoring => 'Aankope word herstel…';

  @override
  String get settingsRateApp => 'Gradeer die toep';

  @override
  String get settingsRateAppSubtitle => 'Laat \'n gradering in die winkel';

  @override
  String get settingsStoreUnavailable =>
      'Die winkel is nie op hierdie toestel beskikbaar nie.';

  @override
  String get settingsFeedback => 'Gee terugvoer';

  @override
  String get settingsFeedbackSubtitle => 'Idees en foute (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Advertensieprivaatheid';

  @override
  String get settingsAdPrivacySubtitle =>
      'Sien of verander jou toestemming vir advertensies';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Hierdie toestel het nie advertensie-opsies nodig nie.';

  @override
  String get settingsPrivacy => 'Privaatheidsbeleid';

  @override
  String get settingsImprint => 'Regsinligting';

  @override
  String get settingsPageOpenFailed => 'Die bladsy kon nie oopmaak nie.';

  @override
  String get settingsFooter => 'Qubble • Aflyn-blokpuzzel';

  @override
  String get settingsAdminSection => 'Admin (toets)';

  @override
  String get settingsAdminEnabled => 'Adminmodus aan';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Tik nog $count keer vir adminmodus';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins munte',
      one: '$coins munt',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Net vir toetse — nooit in vrystelling-skermskote nie';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount munte',
      one: '$amount munt',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'Stel munte op 0';

  @override
  String get feedbackTitle => 'Terugvoer';

  @override
  String get feedbackIntroShort =>
      'Wat hou jy van, wat irriteer jou, wat kort? Klein dinge help ook — hoe meer spesifiek, hoe beter.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Net $build en jou toesteltipe word bygevoeg — sodat ek weet oor watter weergawe dit gaan.';
  }

  @override
  String get feedbackSendByMail => 'Stuur per e-pos';

  @override
  String get feedbackPreferGithub => 'Eerder \'n GitHub-issue';

  @override
  String get feedbackThanksMail => 'Dankie! Stuur net die boodskap.';

  @override
  String get feedbackNoMailApp =>
      'Geen e-pos-toep gevind nie. Probeer die GitHub-roete hieronder.';

  @override
  String get feedbackEmptyHint => 'Tik asseblief eers iets.';

  @override
  String get leaderboardRefresh => 'Herlaai';

  @override
  String get leaderboardRetry => 'Probeer weer';

  @override
  String get feedbackHint => 'Jou terugvoer…';

  @override
  String get feedbackSubmit => 'Stuur terugvoer';

  @override
  String get feedbackOpenFailed =>
      'GitHub kon nie oopmaak nie. Probeer later weer.';

  @override
  String get feedbackGithubNote =>
      'GitHub maak oop — tik daar op “Submit new issue”. (Eenmalige aanmelding by GitHub is nodig.)';

  @override
  String get shopTitle => 'Winkel';

  @override
  String get shopWebDemoNote =>
      'Aankope is net in die Play Store-toep moontlik. Hierdie webweergawe is \'n gratis demo — jy kan hier nogtans alles speel.';

  @override
  String get shopSupporterExplainer =>
      'Qubble wys geen verpligte advertensies nie — jy hoef niks te koop nie. Die ondersteunerspak (tema Aurora, voorkoms Kristal, 1 500 munte, ondersteunerskenteken) is \'n dankie vir jou steun aan die spel. Aankope is aan jou winkelrekening gekoppel en kan enige tyd herstel word.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + voorkoms Kristal + 1 500 munte';

  @override
  String get themesTitle => 'Temas';

  @override
  String get themesSupporterOnly => 'Net in die ondersteunerspak (sien winkel)';

  @override
  String get skinsTitle => 'Blokvoorkoms';

  @override
  String get skinsNotEnoughCoins => 'Nie genoeg munte nie';

  @override
  String get skinsNotEnoughGold => 'Nie genoeg goud nie.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold goud = 1 diamant. Diamante ontsluit die mooiste voorkoms — versamel op jou gemak.';
  }

  @override
  String get statsTitle => 'Statistiek';

  @override
  String get statsAverageScore => 'Gem. telling';

  @override
  String get statsBestCombo => 'Beste kombo';

  @override
  String get statsGames => 'Spele';

  @override
  String get statsLinesCleared => 'Lyne skoongemaak';

  @override
  String get statsPiecesPlaced => 'Blokke geplaas';

  @override
  String get statsCoins => 'Munte';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Kry \'n kombo x$countString';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kry meer as $countString punte in een spel',
      one: 'Kry meer as $countString punt in een spel',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Prestasies';

  @override
  String get achievementFirstGameTitle => 'Eerste spel';

  @override
  String get achievementFirstGameBody => 'Speel jou eerste spel';

  @override
  String get achievementGames25Title => 'Gereelde gas';

  @override
  String get achievementGames25Body => 'Speel 25 spele';

  @override
  String get achievementGames100Title => 'Verslaaf';

  @override
  String get achievementGames100Body => 'Speel 100 spele';

  @override
  String get achievementScore1kTitle => 'Klimmer';

  @override
  String get achievementScore1kBody => 'Kry 1 000 punte';

  @override
  String get achievementScore5kTitle => 'Pro';

  @override
  String get achievementScore5kBody => 'Kry 5 000 punte';

  @override
  String get achievementScore10kTitle => 'Meester';

  @override
  String get achievementScore10kBody => 'Kry 10 000 punte';

  @override
  String get achievementScore25kTitle => 'Legende';

  @override
  String get achievementScore25kBody => 'Kry 25 000 punte';

  @override
  String get achievementLines100Title => 'Netjies';

  @override
  String get achievementLines100Body => 'Maak altesaam 100 lyne skoon';

  @override
  String get achievementLines1000Title => 'Groot skoonmaak';

  @override
  String get achievementLines1000Body => 'Maak altesaam 1 000 lyne skoon';

  @override
  String get achievementCombo5Title => 'Kombo-beginner';

  @override
  String get achievementCombo5Body => 'Kry \'n kombo x5';

  @override
  String get achievementCombo10Title => 'Kombokoning';

  @override
  String get achievementCombo10Body => 'Kry \'n kombo x10';

  @override
  String get achievementLevel10Title => 'Ervare';

  @override
  String get achievementLevel10Body => 'Bereik vlak 10';

  @override
  String get achievementLevel20Title => 'Veteraan';

  @override
  String get achievementLevel20Body => 'Bereik vlak 20';

  @override
  String get achievementStreak7Title => 'Weekreeks';

  @override
  String get achievementStreak7Body => '\'n Dagreeks van 7 dae';

  @override
  String get achievementStreak30Title => 'Maandreeks';

  @override
  String get achievementStreak30Body => '\'n Dagreeks van 30 dae';

  @override
  String get achievementPuzzles10Title => 'Puzzelaar';

  @override
  String get achievementPuzzles10Body => 'Los 10 puzzels op';

  @override
  String get achievementPieces5000Title => 'Bouer';

  @override
  String get achievementPieces5000Body => 'Plaas 5 000 blokke';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Jou reeks van $streak dae is in gevaar!',
      one: 'Jou reeks van $streak dag is in gevaar!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Gister nie gespeel nie — red jou reeks:';

  @override
  String get streakRepairFailed => 'Herstel is nie moontlik nie.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins munte',
      one: '$coins munt',
    );
    return 'Welkom terug! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Herinneringe?';

  @override
  String get notificationsOptInBody =>
      'Moet ons jou aan die daaglikse puzzel herinner en jou reeks beskerm? Jy kan dit enige tyd in die instellings verander.';

  @override
  String get notificationsOptInAccept => 'Ja, asseblief';

  @override
  String get notificationChannelDescription =>
      'Daaglikse herinnering, reekswaarskuwing, terugkeer';

  @override
  String get notificationDailyTitle => 'Jou daaglikse puzzel wag 🧩';

  @override
  String get notificationDailyBody => 'Speel vandag se uitdaging!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 Jou reeks van $streak dae is in gevaar!',
      one: '🔥 Jou reeks van $streak dag is in gevaar!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Speel vandag om dit te behou.';

  @override
  String get notificationComebackTitle => 'Jou blokke wag vir jou 🧩';

  @override
  String get notificationComebackBody => 'Kom terug en haal \'n geskenk!';

  @override
  String get iapSupporterPack => 'Ondersteunerspak';

  @override
  String get iapCoinsSmall => '500 munte';

  @override
  String get iapCoinsMedium => '2 000 munte';

  @override
  String get iapCoinsLarge => '6 000 munte';

  @override
  String get iapStarterPack => 'Beginpak';

  @override
  String get iapRename => 'Naamsverandering';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Verwyder ranglysinskrywing';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Haal jou naam en telling van die openbare lys af';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Verwyder jou inskrywing?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Jou naam en telling word van die ranglys verwyder. Jou vordering in die spel bly net so. Jy kan enige tyd weer by die ranglys aansluit.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Jou ranglysinskrywing is verwyder.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Die inskrywing kon nie verwyder word nie. Kyk jou verbinding en probeer weer.';

  @override
  String get leaderboardReport => 'Rapporteer hierdie naam';

  @override
  String get leaderboardBlock => 'Versteek';

  @override
  String leaderboardBlocked(String name) {
    return '$name is vir jou versteek';
  }

  @override
  String get leaderboardUndo => 'Ontdoen';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count inskrywings deur jou versteek',
      one: '$count inskrywing deur jou versteek',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Wys weer';

  @override
  String get leaderboardReportUnavailable =>
      'Rapporteer is nie nou moontlik nie.';

  @override
  String get leaderboardReportSent => 'Dankie — jou verslag is gestuur.';

  @override
  String get leaderboardRules =>
      'Name is openbaar. Geen beledigings, geen vloekwoorde en niks wat \'n regte persoon uitken nie. Name wat dit oortree, word verwyder.';

  @override
  String get leaderboardRulesAccept => 'Verstaan';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked van $total ontsluit';
  }

  @override
  String get settingsSectionData => 'Gestoorde data';

  @override
  String get gameRotatePiece => 'Draai blok';

  @override
  String get themeClassic => 'Klassiek';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Oseaan';

  @override
  String get themeWood => 'Hout';

  @override
  String get themeSunset => 'Sonsondergang';

  @override
  String get themeForest => 'Woud';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klassiek';

  @override
  String get skinGradient => 'Kleurverloop';

  @override
  String get skinOutline => 'Omlyning';

  @override
  String get skinGlossy => 'Glans';

  @override
  String get skinStripe => 'Strepe';

  @override
  String get skinBevel => 'Reliëf';

  @override
  String get skinGlow => 'Gloed';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Voorkoms $name';
  }

  @override
  String get skinPulse => 'Pols';

  @override
  String get skinShimmer => 'Glinster';

  @override
  String get skinWave => 'Golf';

  @override
  String get skinEmber => 'Gloeikole';

  @override
  String get skinPrism => 'Prisma';

  @override
  String get skinStardust => 'Sterrestof';

  @override
  String get skinCircuit => 'Stroombaan';

  @override
  String get skinRipple => 'Rimpeling';

  @override
  String achievementRewardSkin(String name) {
    return 'Geanimeerde voorkoms: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Prestasiebeloning: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Prestasies gee nou belonings — joune is bygevoeg.';

  @override
  String get namePromptBody =>
      'Kies \'n naam, dan kom jou beste telling op die ranglys. Sonder \'n naam speel jy anoniem verder.';

  @override
  String get nameTaken => 'Hierdie naam is reeds gevat. Probeer \'n ander een.';

  @override
  String get nameCheckFailed =>
      'Die naam kon nie nagegaan word nie. Is jy aanlyn? Probeer oor \'n oomblik weer.';

  @override
  String nameLost(String name) {
    return '$name behoort nou aan \'n ander speler. Kies \'n nuwe naam, gratis.';
  }

  @override
  String get themeCandy => 'Lekkergoed';

  @override
  String get themeVolcano => 'Vulkaan';

  @override
  String get themeGlacier => 'Gletser';

  @override
  String get skinPixel => 'Pixel';

  @override
  String get skinMarble => 'Marmer';

  @override
  String get skinJelly => 'Jellie';

  @override
  String get skinLiquid => 'Vloeistof';

  @override
  String get skinFizz => 'Borrels';

  @override
  String get skinPlasma => 'Plasma';

  @override
  String get designsTitle => 'Ontwerpe';

  @override
  String get designsNotEnoughDiamonds => 'Nie genoeg diamante nie.';

  @override
  String get designsOwned => 'In besit';

  @override
  String get designsAchievementOnly => 'Prestasie';

  @override
  String get designsSupporterOnly => 'Ondersteuner';

  @override
  String get designsPreview => 'Voorskou';

  @override
  String get designsGetDiamonds => 'Kry diamante';

  @override
  String get shopDealTitle => 'Aanbod van die dag';

  @override
  String get shopAnimatedSkins => 'Geanimeerde blokvoorkoms';

  @override
  String get shopNewDesigns => 'Nuwe ontwerpe';

  @override
  String get shopDiamonds => 'Diamante';

  @override
  String get shopPacks => 'Pakke';

  @override
  String get shopPopular => 'Gewild';

  @override
  String get shopBestValue => 'Beste waarde';

  @override
  String get shopDiamondsBlurb =>
      'Vir geanimeerde blokvoorkoms en die nuwe ontwerpe.';

  @override
  String get shopCoinsBlurb => 'Vir temas, blokvoorkoms en hupstote.';

  @override
  String get shopNeonBlurb => 'Ontsluit Tema Neon dadelik.';

  @override
  String get shopRenameBlurb => 'Verander jou naam op die ranglys.';

  @override
  String shopHoursLeft(int hours) {
    return 'Nog $hours h';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Nuwe aanbod oor $time';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name ontsluit!';
  }

  @override
  String get questsTitle => 'Take';

  @override
  String get questsDaily => 'Daagliks';

  @override
  String get questsWeekly => 'Weekliks';

  @override
  String get questsMonthly => 'Maandeliks';

  @override
  String questsNewIn(String time) {
    return 'Nuwe take oor $time';
  }

  @override
  String get questsBonus => 'Bonus vir almal';

  @override
  String get questsBonusEarned => 'Bonus verdien';

  @override
  String get questRounds => 'Speel rondes';

  @override
  String get questLines => 'Maak lyne skoon';

  @override
  String get questPieces => 'Plaas blokke';

  @override
  String get questDailyChallenge => 'Speel die daaglikse uitdaging';

  @override
  String get questPuzzles => 'Los nuwe raaisels op';

  @override
  String get questDays => 'Speel op verskillende dae';

  @override
  String get questDailySets => 'Voltooi al die daaglikse take';

  @override
  String get questsSetDaily => 'Al die daaglikse take klaar!';

  @override
  String get questsSetWeekly => 'Al die weeklikse take klaar!';

  @override
  String get questsSetMonthly => 'Al die maandelikse take klaar!';

  @override
  String get leaderboardTabScore => 'Hoogste telling';

  @override
  String get leaderboardTabPuzzle => 'Raaiselsterre';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Jou raaiselsterre word outomaties ingedien.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Jou raaiselsterre ($stars) word ingedien …';
  }
}
