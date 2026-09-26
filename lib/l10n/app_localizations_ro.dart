// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class L10nRo extends L10n {
  L10nRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Joacă';

  @override
  String get commonLater => 'Mai târziu';

  @override
  String get commonNotNow => 'Nu acum';

  @override
  String get commonCancel => 'Anulează';

  @override
  String get commonBuy => 'Cumpără';

  @override
  String get commonSave => 'Salvează';

  @override
  String get commonCollect => 'Colectează';

  @override
  String get nameNewName => 'Nume nou';

  @override
  String get nameFieldLabel => 'Nume';

  @override
  String get piggyFullTitle => 'Pușculița e plină!';

  @override
  String get piggyKeepSaving => 'Continuă să economisești';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins din $capacity strânse.';
  }

  @override
  String get homeContinueRun => 'Continuă';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Am înțeles';

  @override
  String get commonHome => 'Acasă';

  @override
  String get commonScore => 'SCOR';

  @override
  String get commonBest => 'RECORD';

  @override
  String commonLevelShort(int level) {
    return 'Nivelul $level';
  }

  @override
  String get homeNewRun => 'Începe un joc nou';

  @override
  String get homeBackToExit => 'Apasă din nou Înapoi pentru a ieși';

  @override
  String get homeEnableLeaderboard => 'Intră în clasament';

  @override
  String get homeBestScore => 'CEL MAI BUN SCOR';

  @override
  String get homeDailyChallenge => 'Provocarea zilnică';

  @override
  String get homeDailyOpenToday => 'Încă nejucată azi';

  @override
  String homeDailyNextIn(String time) {
    return 'Următoarea provocare în $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak de zile',
      few: '$streak zile',
      one: '$streak zi',
    );
    return 'Serie: $_temp0';
  }

  @override
  String get homeLeaderboard => 'Clasament';

  @override
  String get homePuzzleMode => 'Mod puzzle';

  @override
  String get homeMissions => 'Misiuni';

  @override
  String get homeThemes => 'Teme';

  @override
  String get homeSkins => 'Skinuri';

  @override
  String get homeHowToPlay => 'Cum se joacă Qubble';

  @override
  String get homeWeekendBonus => 'Weekend: monede duble!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Nivelul $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Schimbă numele';

  @override
  String get nameChangeExplainer =>
      'Numele tău este identitatea ta în clasament, de aceea rămâne fix. Poți cumpăra o singură schimbare de nume.';

  @override
  String get nameChangeAfterPurchase =>
      'După cumpărare, atinge din nou numele ca să-l schimbi.';

  @override
  String get nameJoinedLeaderboard => 'Acum ești în clasament.';

  @override
  String get nameRenameUnavailable => 'Numele nu poate fi schimbat acum.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min de caractere',
      few: '$min caractere',
      one: '$min caracter',
    );
    return 'Cel puțin $_temp0.';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: '$max de caractere',
      few: '$max caractere',
      one: '$max caracter',
    );
    return 'Cel mult $_temp0.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Doar litere fără diacritice (A–Z), cifre, spații, _ și -.';

  @override
  String get nameProblemOffensive => 'Te rugăm să alegi alt nume.';

  @override
  String get piggyTitle => 'Pușculiță';

  @override
  String get piggyFillingHint =>
      'Pușculița se umple pe măsură ce elimini rânduri.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins de monede',
      few: '$coins monede',
      one: '$coins monedă',
    );
    return 'Colectează $_temp0 — gratuit.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Când e plină o poți goli gratuit — sau o poți deschide mai devreme cu un video bonus.';

  @override
  String get piggyOpenNow => 'Deschide acum';

  @override
  String get gameNewPiecesVideo => 'Piese noi (video)';

  @override
  String get gameTapBoardCell => 'Atinge o căsuță de pe tablă';

  @override
  String get gameDailyChallengeLabel => 'PROVOCAREA ZILNICĂ';

  @override
  String get gameOver => 'Joc terminat';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Pentru bombă îți mai trebuie monede: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomba nu funcționează aici acum.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Îți mai trebuie monede: $missing.';
  }

  @override
  String get gameNotRightNow => 'Nu se poate acum.';

  @override
  String get gameRunSaved => 'Joc salvat — „Continuă” din meniu.';

  @override
  String get gameOverNoFit => 'Nicio piesă nu mai încape pe tablă.';

  @override
  String get gameOverNoFitNoRotations =>
      'Nicio piesă nu încape — iar rotirile s-au terminat.';

  @override
  String get gameStarterOfferUnavailable => 'Indisponibil acum';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — ia-l';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Realizare: $title';
  }

  @override
  String get gameBestSubmitted => 'Record nou — trimis';

  @override
  String get gameReviveFor => 'Continuă jocul · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Deblocat: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pachet de început';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score de puncte',
      few: '$score puncte',
      one: '$score punct',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Record nou!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak de zile',
      few: '$streak zile',
      one: '$streak zi',
    );
    return 'Serie: $_temp0';
  }

  @override
  String get gameDoubleCoins => 'Dublează monedele';

  @override
  String get gameDoubleDaily => 'Dublează recompensa zilnică';

  @override
  String get gamePlayAgain => 'Joacă din nou';

  @override
  String gameLevelReached(int level) {
    return 'Ai ajuns la nivelul $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de niveluri',
      few: '$count niveluri',
      one: '$count nivel',
    );
    return '+$_temp0 — nivelul $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 de monede + tema Lemn';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours de ore',
      few: '$hours ore',
      one: '$hours oră',
    );
    return 'Doar $_temp0 rămase — o singură dată!';
  }

  @override
  String get boosterUndo => 'Înapoi';

  @override
  String get boosterSwap => 'Schimbă';

  @override
  String get boosterBomb => 'Bombă';

  @override
  String get boosterNoRotationsLeft =>
      'Nu mai ai rotiri — elimină rânduri ca să le reîncarci!';

  @override
  String get onboardingDragPiece => 'Trage o piesă pe tablă';

  @override
  String get onboardingFillLine => 'Umple un rând sau o coloană întreagă';

  @override
  String get onboardingLinesClear => 'Liniile pline dispar — puncte!';

  @override
  String get coachHintCombo =>
      'Combo! Elimină din nou în 3 mutări ca să-l păstrezi';

  @override
  String get coachHintFever => 'FEBRĂ! Puncte duble cât timp strălucește';

  @override
  String get coachHintRotation =>
      'Rotirea costă o încărcare — eliminările o reîncarcă';

  @override
  String get coachHintBooster => 'Sfat: jos ai ajutoare';

  @override
  String get coachHintStrategy =>
      'Sfat: nu toate liniile deodată — lasă loc pentru piesele mari';

  @override
  String get dailyStreakLabel => 'Serie';

  @override
  String get dailyBestLabel => 'Record zilnic';

  @override
  String dailyHistoryNote(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days de zile',
      few: '$days zile',
      one: '$days zi',
    );
    return 'Se păstrează ultimele $_temp0.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: jucată';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: nejucată';
  }

  @override
  String get homeDailyCalendar => 'Calendar';

  @override
  String get dailyShareButton => 'Distribuie rezultatul';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Provocarea zilnică $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Scor: $score · cel mai bun combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Joacă: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: '$moves de mutări',
      few: '$moves mutări',
      one: '$moves mutare',
    );
    return 'Combo: încă $_temp0';
  }

  @override
  String get dailyShareCopied => 'Rezultatul a fost copiat în clipboard';

  @override
  String get adNotAvailable =>
      'Niciun video disponibil acum — încearcă din nou puțin mai târziu';

  @override
  String get howToPlaySpeedTitle => 'Bonus de viteză';

  @override
  String get howToPlaySpeedBody =>
      'Dacă plasezi repede, primești până la 30 % în plus la fiecare eliminare. Bonusul scade între 1,5 și 4 secunde și are o limită, așa că viteza contează, dar nu decide jocul — un joc atent și lent poate bate unul grăbit.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus de viteză $percent la sută';
  }

  @override
  String get iapDiamondsSmall => '100 de diamante';

  @override
  String get iapDiamondsMedium => '350 de diamante';

  @override
  String get iapDiamondsLarge => '1.000 de diamante';

  @override
  String get howToPlayTitle => 'Cum se joacă Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Ușor de început.\nGândirea în avans e răsplătită.';

  @override
  String get howToPlayIntroBody => 'Ține tabla liberă și bate-ți recordul.';

  @override
  String get howToPlayIntroSemantics =>
      'Scopul jocului. Ține tabla liberă și bate-ți recordul.';

  @override
  String get howToPlayDragTitle => 'Trage și plasează';

  @override
  String get howToPlayDragBody =>
      'Trage una dintre cele trei piese pe căsuțe libere. După ce le folosești pe toate trei, primești automat trei piese noi.';

  @override
  String get howToPlayClearTitle => 'Elimină linii';

  @override
  String get howToPlayClearBody =>
      'Umple un rând sau o coloană întreagă. Liniile pline dispar și fac loc pentru următoarea mutare.';

  @override
  String get howToPlayComboTitle => 'Înlănțuie combo-uri';

  @override
  String get howToPlayComboBody =>
      'Elimină încă o linie în trei mutări. Fiecare combo în plus îți crește multiplicatorul de puncte. Combo-ul numără mutări, nu secunde, așa că nu expiră cât timp te gândești.';

  @override
  String get howToPlayFeverTitle => 'Aprinde febra';

  @override
  String get howToPlayFeverBody =>
      'Eliminările umplu indicatorul de febră. Când e plin, următoarea eliminare contează dublu — plănuiește din timp eliminările mari.';

  @override
  String get howToPlayBoosterTitle => 'Folosește ajutoarele cu cap';

  @override
  String get howToPlayBoosterBody =>
      'Ajutoarele salvează jocurile dificile. Poți și să atingi o piesă din tavă ca s-o rotești.';

  @override
  String get howToPlayDailyTitle => 'Zilnic și serie';

  @override
  String get howToPlayDailyBody =>
      'Provocarea zilnică folosește aceleași piese pentru toți. Joacă în fiecare zi ca să-ți lungești seria și bonusul.';

  @override
  String get howToPlayPiggyTitle => 'Umple pușculița';

  @override
  String get howToPlayPiggyBody =>
      'Fiecare linie eliminată îți umple pușculița. Când e plină, poți colecta monedele gratuit.';

  @override
  String get leaderboardTitle => 'Clasament';

  @override
  String get leaderboardUnreachable =>
      'Clasamentul nu e disponibil.\nÎncearcă din nou cu conexiune la internet.';

  @override
  String get leaderboardEmpty => 'Încă nu există înscrieri.\nFii primul!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Cel mai bun scor al tău ($score) se trimite …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Cel mai bun scor al tău se trimite automat.';

  @override
  String get puzzleModeTitle => 'Mod puzzle';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puzzle $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Mutări: $moves   •   Țintă: $target pentru 3 stele';
  }

  @override
  String get puzzleSolved => 'Rezolvat!';

  @override
  String get puzzleLeaveTitle => 'Părăsești puzzle-ul?';

  @override
  String get puzzleLeaveBody => 'Progresul din acest puzzle se va pierde.';

  @override
  String get puzzleKeepPlaying => 'Joacă în continuare';

  @override
  String get puzzleLeave => 'Ieși';

  @override
  String get puzzleStuckTitle => 'Blocat';

  @override
  String get puzzleRestart => 'Reia';

  @override
  String get commonActive => 'Activ';

  @override
  String get commonTapToActivate => 'Atinge pentru a activa';

  @override
  String get commonRestore => 'Restabilește';

  @override
  String unlockForCost(int cost) {
    return 'Deblochează pentru $cost';
  }

  @override
  String get skinsExchangeGold => 'Schimbă aur';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Rotește piesa';

  @override
  String get puzzleNextLevel => 'Nivelul următor';

  @override
  String get puzzleBackToOverview => 'Înapoi la listă';

  @override
  String get puzzleUnsolvable =>
      'De aici tabla nu mai poate fi golită complet.';

  @override
  String get puzzleExtraMoveVideo => 'Mutare în plus (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Rezolvate: $solved';
  }

  @override
  String get settingsTitle => 'Setări';

  @override
  String get storageFailureTitle => 'Qubble nu poate încărca jocul salvat';

  @override
  String get storageFailureBody =>
      'Repornește aplicația. Dacă eroarea persistă, ajută doar reinstalarea. O poți raporta din Setări › Trimite feedback.';

  @override
  String get iapUnavailable => 'Această ofertă nu e disponibilă acum.';

  @override
  String get iapFailed => 'Achiziția nu s-a finalizat. Nu s-a perceput nimic.';

  @override
  String get settingsResetProgress => 'Resetează progresul';

  @override
  String get settingsResetProgressSubtitle =>
      'Scorul, monedele, nivelul și progresul revin la început. Achizițiile, numele și elementele cosmetice rămân.';

  @override
  String get settingsResetConfirmTitle => 'Resetezi progresul?';

  @override
  String get settingsResetConfirmBody =>
      'Cel mai bun scor, monedele, nivelul, seria și tot progresul vor fi șterse. Acțiunea nu poate fi anulată.\n\nAchizițiile, numele tău și temele și skinurile deblocate rămân.';

  @override
  String get settingsResetConfirmAction => 'Resetează';

  @override
  String get settingsResetDone => 'Progresul a fost resetat.';

  @override
  String get settingsSectionGame => 'Joc';

  @override
  String get settingsSectionSoundHaptics => 'Sunet și vibrații';

  @override
  String get settingsSectionReminders => 'Mementouri';

  @override
  String get settingsSectionPurchases => 'Achiziții';

  @override
  String get settingsSectionHelpOut => 'Susține-ne';

  @override
  String get settingsSectionLegal => 'Informații legale';

  @override
  String get settingsSectionLanguage => 'Limbă';

  @override
  String get settingsGuide => 'Cum se joacă';

  @override
  String get settingsGuideSubtitle => 'Reguli, combo-uri, febră și ajutoare';

  @override
  String get settingsSound => 'Sunet';

  @override
  String get settingsMusic => 'Muzică';

  @override
  String get settingsHaptics => 'Vibrații';

  @override
  String get settingsHapticsOff => 'Oprit';

  @override
  String get settingsHapticsLight => 'Ușor';

  @override
  String get settingsHapticsStrong => 'Puternic';

  @override
  String get settingsSectionAccessibility => 'Confort';

  @override
  String get settingsReducedEffects => 'Efecte reduse';

  @override
  String get settingsReducedEffectsHint =>
      'Mai puține particule, fără tremurat de ecran, fără strălucire';

  @override
  String get settingsNotifications => 'Notificări';

  @override
  String get settingsNotificationsSubtitle =>
      'Memento zilnic și protecția seriei';

  @override
  String get settingsNotificationsSystemHint =>
      'Permite-le din setările sistemului.';

  @override
  String get settingsLanguageSystem => 'Limba sistemului';

  @override
  String get settingsSupporterThanks => 'Susținător — mulțumim!';

  @override
  String get settingsSupporterPack => 'Pachetul de susținător';

  @override
  String get settingsSupporterPackSubtitle =>
      'Temă și skin exclusive + 1.500 de monede';

  @override
  String get settingsRestorePurchases => 'Restabilește achizițiile';

  @override
  String get settingsRestoring => 'Se restabilesc achizițiile…';

  @override
  String get settingsRateApp => 'Evaluează aplicația';

  @override
  String get settingsRateAppSubtitle => 'Lasă o evaluare în magazin';

  @override
  String get settingsStoreUnavailable =>
      'Magazinul nu e disponibil pe acest dispozitiv.';

  @override
  String get settingsFeedback => 'Trimite feedback';

  @override
  String get settingsFeedbackSubtitle => 'Idei și erori (prin GitHub)';

  @override
  String get settingsAdPrivacy => 'Confidențialitatea reclamelor';

  @override
  String get settingsAdPrivacySubtitle =>
      'Vezi sau schimbă consimțământul pentru reclame';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Pe acest dispozitiv nu sunt necesare opțiuni pentru reclame.';

  @override
  String get settingsPrivacy => 'Politica de confidențialitate';

  @override
  String get settingsImprint => 'Informații despre editor';

  @override
  String get settingsPageOpenFailed => 'Pagina nu a putut fi deschisă.';

  @override
  String get settingsFooter => 'Qubble • Puzzle cu blocuri offline';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Modul admin e activat';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mai atinge de $count de ori pentru modul admin',
      few: 'Mai atinge de $count ori pentru modul admin',
      one: 'Mai atinge o dată pentru modul admin',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins de monede',
      few: '$coins monede',
      one: '$coins monedă',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Doar pentru teste — nu apare niciodată în capturile de ecran ale versiunii publice';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount monede';
  }

  @override
  String get settingsAdminResetCoins => 'Setează monedele la 0';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Ce îți place, ce te deranjează, ce lipsește? Și lucrurile mici ajută — cu cât mai concret, cu atât mai bine.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Se atașează doar $build și tipul dispozitivului tău — ca să fie clar despre ce versiune e vorba.';
  }

  @override
  String get feedbackSendByMail => 'Trimite prin e-mail';

  @override
  String get feedbackPreferGithub => 'Prefer un issue pe GitHub';

  @override
  String get feedbackThanksMail => 'Mulțumesc! Trimite doar mesajul.';

  @override
  String get feedbackNoMailApp =>
      'Nu s-a găsit nicio aplicație de e-mail. Încearcă varianta GitHub de mai jos.';

  @override
  String get feedbackEmptyHint => 'Scrie mai întâi ceva.';

  @override
  String get leaderboardRefresh => 'Reîmprospătează';

  @override
  String get leaderboardRetry => 'Încearcă din nou';

  @override
  String get feedbackHint => 'Feedbackul tău…';

  @override
  String get feedbackSubmit => 'Trimite feedback';

  @override
  String get feedbackOpenFailed =>
      'GitHub nu a putut fi deschis. Încearcă mai târziu.';

  @override
  String get feedbackGithubNote =>
      'Se deschide GitHub — atinge acolo „Submit new issue”. (E nevoie o dată de autentificare în GitHub.)';

  @override
  String get shopTitle => 'Magazin';

  @override
  String get shopWebDemoNote =>
      'Achizițiile sunt disponibile doar în aplicația din Play Store. Această versiune web este o demonstrație gratuită — o poți juca totuși în întregime aici.';

  @override
  String get shopSupporterExplainer =>
      'Qubble nu afișează reclame forțate — nu trebuie să cumperi nimic, niciodată. Pachetul de susținător (tema Aurora, skinul Cristal, 1.500 de monede, insigna de susținător) este un mulțumesc pentru că susții jocul. Achizițiile sunt legate de contul tău din magazin și pot fi restabilite oricând.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + skinul Cristal + 1.500 de monede';

  @override
  String get themesTitle => 'Teme';

  @override
  String get themesSupporterOnly =>
      'Exclusiv în pachetul de susținător (vezi magazinul)';

  @override
  String get themesInSupporterPack => 'În pachetul de susținător';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Monede insuficiente (necesar $cost, ai $coins)';
  }

  @override
  String get skinsTitle => 'Skinuri pentru blocuri';

  @override
  String get skinsNotEnoughDiamonds =>
      'Diamante insuficiente (schimbă aur mai jos)';

  @override
  String get skinsNotEnoughCoins => 'Monede insuficiente';

  @override
  String get skinsNotEnoughGold => 'Aur insuficient.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold aur = 1 diamant. Diamantele deblochează cele mai frumoase skinuri — adună-le fără grabă.';
  }

  @override
  String get statsTitle => 'Statistici';

  @override
  String get statsAverageScore => 'Scor mediu';

  @override
  String get statsBestCombo => 'Cel mai bun combo';

  @override
  String get statsGames => 'Jocuri';

  @override
  String get statsLinesCleared => 'Rânduri eliminate';

  @override
  String get statsPiecesPlaced => 'Piese plasate';

  @override
  String get statsCoins => 'Monede';

  @override
  String get missionsTitle => 'Misiuni';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString de piese',
      few: '$countString piese',
      one: '$countString piesă',
    );
    return 'Plasează $_temp0';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString de rânduri',
      few: '$countString rânduri',
      one: '$countString rând',
    );
    return 'Elimină $_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Atinge un combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString de puncte',
      few: '$countString puncte',
      one: '$countString punct',
    );
    return 'Depășește $_temp0 într-un joc';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString de jocuri',
      few: '$countString jocuri',
      one: '$countString joc',
    );
    return 'Joacă $_temp0';
  }

  @override
  String get achievementsTitle => 'Realizări';

  @override
  String get achievementFirstGameTitle => 'Primul joc';

  @override
  String get achievementFirstGameBody => 'Joacă primul tău joc';

  @override
  String get achievementGames25Title => 'Obișnuit';

  @override
  String get achievementGames25Body => 'Joacă 25 de jocuri';

  @override
  String get achievementGames100Title => 'Prins de joc';

  @override
  String get achievementGames100Body => 'Joacă 100 de jocuri';

  @override
  String get achievementScore1kTitle => 'Cățărător';

  @override
  String get achievementScore1kBody => 'Atinge 1.000 de puncte';

  @override
  String get achievementScore5kTitle => 'Profesionist';

  @override
  String get achievementScore5kBody => 'Atinge 5.000 de puncte';

  @override
  String get achievementScore10kTitle => 'Maestru';

  @override
  String get achievementScore10kBody => 'Atinge 10.000 de puncte';

  @override
  String get achievementScore25kTitle => 'Legendă';

  @override
  String get achievementScore25kBody => 'Atinge 25.000 de puncte';

  @override
  String get achievementLines100Title => 'Ordonat';

  @override
  String get achievementLines100Body => 'Elimină 100 de rânduri în total';

  @override
  String get achievementLines1000Title => 'Curățenie generală';

  @override
  String get achievementLines1000Body => 'Elimină 1.000 de rânduri în total';

  @override
  String get achievementCombo5Title => 'Începător în combo';

  @override
  String get achievementCombo5Body => 'Atinge un combo x5';

  @override
  String get achievementCombo10Title => 'Regele combo-urilor';

  @override
  String get achievementCombo10Body => 'Atinge un combo x10';

  @override
  String get achievementLevel10Title => 'Experimentat';

  @override
  String get achievementLevel10Body => 'Atinge nivelul 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Atinge nivelul 20';

  @override
  String get achievementStreak7Title => 'O săptămână întreagă';

  @override
  String get achievementStreak7Body => 'O serie zilnică de 7 zile';

  @override
  String get achievementStreak30Title => 'O lună întreagă';

  @override
  String get achievementStreak30Body => 'O serie zilnică de 30 de zile';

  @override
  String get achievementPuzzles10Title => 'Pasionat de puzzle';

  @override
  String get achievementPuzzles10Body => 'Rezolvă 10 puzzle-uri';

  @override
  String get achievementPieces5000Title => 'Constructor';

  @override
  String get achievementPieces5000Body => 'Plasează 5.000 de piese';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak de zile',
      few: '$streak zile',
      one: '$streak zi',
    );
    return 'Seria ta în pericol: $_temp0!';
  }

  @override
  String get streakRepairBody => 'Ieri nu ai jucat — salvează-ți seria:';

  @override
  String get streakRepairFailed => 'Reparația nu e posibilă.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins de monede',
      few: '$coins monede',
      one: '$coins monedă',
    );
    return 'Bine ai revenit! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Mementouri?';

  @override
  String get notificationsOptInBody =>
      'Să-ți amintim de puzzle-ul zilnic și să-ți protejăm seria? Poți schimba oricând asta din setări.';

  @override
  String get notificationsOptInAccept => 'Da, te rog';

  @override
  String get notificationChannelDescription =>
      'Memento zilnic, avertizare pentru serie, invitație de revenire';

  @override
  String get notificationDailyTitle => 'Puzzle-ul tău zilnic te așteaptă 🧩';

  @override
  String get notificationDailyBody => 'Joacă provocarea de azi!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak de zile',
      few: '$streak zile',
      one: '$streak zi',
    );
    return '🔥 Seria ta în pericol: $_temp0!';
  }

  @override
  String get notificationStreakBody => 'Joacă azi ca s-o păstrezi.';

  @override
  String get notificationComebackTitle => 'Puzzle-ul tău îți duce dorul 🧩';

  @override
  String get notificationComebackBody => 'Revino și ia-ți cadoul!';

  @override
  String get iapSupporterPack => 'Pachetul de susținător';

  @override
  String get iapCoinsSmall => '500 de monede';

  @override
  String get iapCoinsMedium => '2.000 de monede';

  @override
  String get iapCoinsLarge => '6.000 de monede';

  @override
  String get iapStarterPack => 'Pachet de început';

  @override
  String get iapRename => 'Schimbare de nume';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Șterge înscrierea din clasament';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Îți elimină numele și scorul din lista publică';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Ștergi înscrierea?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Numele și scorul tău vor fi eliminate din clasament. Progresul din joc rămâne neatins. Poți intra din nou în clasament oricând.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Înscrierea ta din clasament a fost ștearsă.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Înscrierea nu a putut fi ștearsă. Verifică-ți conexiunea și încearcă din nou.';

  @override
  String get leaderboardReport => 'Raportează acest nume';

  @override
  String get leaderboardBlock => 'Blochează';

  @override
  String leaderboardBlocked(String name) {
    return '$name e ascuns pentru tine';
  }

  @override
  String get leaderboardUndo => 'Anulează';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Ascunse de tine: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Arată din nou';

  @override
  String get leaderboardReportUnavailable =>
      'Raportarea nu e disponibilă acum.';

  @override
  String get leaderboardReportSent => 'Mulțumim — raportul tău e pe drum.';

  @override
  String get leaderboardRules =>
      'Numele sunt publice. Fără insulte, fără injurii și nimic care să identifice o persoană reală. Numele care încalcă regula sunt eliminate.';

  @override
  String get leaderboardRulesAccept => 'Am înțeles';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked din $total deblocate';
  }

  @override
  String get settingsSectionData => 'Date salvate';

  @override
  String get gameRotatePiece => 'Rotește piesa';

  @override
  String get themeClassic => 'Clasic';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeWood => 'Lemn';

  @override
  String get themeSunset => 'Apus';

  @override
  String get themeForest => 'Pădure';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Clasic';

  @override
  String get skinGradient => 'Degradeu';

  @override
  String get skinOutline => 'Contur';

  @override
  String get skinGlossy => 'Lucios';

  @override
  String get skinStripe => 'Dungi';

  @override
  String get skinBevel => 'Teșit';

  @override
  String get skinGlow => 'Strălucire';

  @override
  String get skinCrystal => 'Cristal';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skinul $name';
  }
}
