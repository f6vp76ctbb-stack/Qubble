// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class L10nCs extends L10n {
  L10nCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Hrát';

  @override
  String get commonLater => 'Později';

  @override
  String get commonNotNow => 'Teď ne';

  @override
  String get commonCancel => 'Zrušit';

  @override
  String get commonBuy => 'Koupit';

  @override
  String get commonSave => 'Uložit';

  @override
  String get commonCollect => 'Vybrat';

  @override
  String get nameNewName => 'Nové jméno';

  @override
  String get nameFieldLabel => 'Jméno';

  @override
  String get piggyFullTitle => 'Prasátko je plné!';

  @override
  String get piggyKeepSaving => 'Šetřit dál';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Nasbíráno $coins z $capacity.';
  }

  @override
  String get homeContinueRun => 'Pokračovat';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Rozumím';

  @override
  String get commonHome => 'Domů';

  @override
  String get commonScore => 'SKÓRE';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Úroveň $level';
  }

  @override
  String get homeNewRun => 'Začít novou hru';

  @override
  String get homeBackToExit => 'Pro ukončení stiskni Zpět ještě jednou';

  @override
  String get homeEnableLeaderboard => 'Zapsat se do žebříčku';

  @override
  String get homeBestScore => 'NEJLEPŠÍ SKÓRE';

  @override
  String get homeDailyChallenge => 'Denní výzva';

  @override
  String get homeDailyOpenToday => 'Dnes ještě nehráno';

  @override
  String homeDailyNextIn(String time) {
    return 'Další výzva za $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak dní',
      few: '$streak dny',
      one: '$streak den',
    );
    return 'Série: $_temp0';
  }

  @override
  String get homeLeaderboard => 'Žebříček';

  @override
  String get homePuzzleMode => 'Hádanky';

  @override
  String get homeMissions => 'Mise';

  @override
  String get homeThemes => 'Motivy';

  @override
  String get homeSkins => 'Vzhledy';

  @override
  String get homeHowToPlay => 'Jak hrát Qubble';

  @override
  String get homeWeekendBonus => 'Víkend: dvojnásobné mince!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Úroveň $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Změnit jméno';

  @override
  String get nameChangeExplainer =>
      'Tvé jméno je tvou identitou v žebříčku, proto se nemění. Můžeš si koupit jednorázovou změnu jména.';

  @override
  String get nameChangeAfterPurchase =>
      'Po nákupu klepni znovu na své jméno a změň ho.';

  @override
  String get nameJoinedLeaderboard => 'Teď jsi v žebříčku.';

  @override
  String get nameRenameUnavailable => 'Jméno teď změnit nelze.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min znaků',
      few: '$min znaky',
      one: '$min znak',
    );
    return 'Nejméně $_temp0.';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: '$max znaků',
      few: '$max znaky',
      one: '$max znak',
    );
    return 'Nejvýše $_temp0.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Jen písmena bez diakritiky (A–Z), číslice, mezery, _ a -.';

  @override
  String get nameProblemOffensive => 'Zvol prosím jiné jméno.';

  @override
  String get piggyTitle => 'Prasátko';

  @override
  String get piggyFillingHint => 'Prasátko se plní, když mažeš řady.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mincí',
      few: '$coins mince',
      one: '$coins mince',
    );
    return 'Vyber $_temp0 — zdarma.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Až bude plné, můžeš ho vybrat zdarma — nebo ho otevřít dřív za bonusové video.';

  @override
  String get piggyOpenNow => 'Otevřít hned';

  @override
  String get gameNewPiecesVideo => 'Nové dílky (video)';

  @override
  String get gameTapBoardCell => 'Klepni na políčko na desce';

  @override
  String get gameDailyChallengeLabel => 'DENNÍ VÝZVA';

  @override
  String get gameOver => 'Konec hry';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Na bombu ti chybí mince: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomba tady teď nefunguje.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Chybí ti mince: $missing.';
  }

  @override
  String get gameNotRightNow => 'Teď to nejde.';

  @override
  String get gameRunSaved => 'Hra uložena — „Pokračovat“ v menu.';

  @override
  String get gameOverNoFit => 'Žádný z tvých dílků se už na desku nevejde.';

  @override
  String get gameOverNoFitNoRotations =>
      'Žádný dílek se nevejde — a otočení došla.';

  @override
  String get gameStarterOfferUnavailable => 'Teď nedostupné';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — získat';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Úspěch: $title';
  }

  @override
  String get gameBestSubmitted => 'Nový rekord — odesláno';

  @override
  String get gameReviveFor => 'Hrát dál · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Odemčeno: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Startovní balíček';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score bodů',
      few: '$score body',
      one: '$score bod',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Nový rekord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak dní',
      few: '$streak dny',
      one: '$streak den',
    );
    return 'Série: $_temp0';
  }

  @override
  String get gameDoubleCoins => 'Zdvojnásobit mince';

  @override
  String get gameDoubleDaily => 'Zdvojnásobit denní odměnu';

  @override
  String get gamePlayAgain => 'Hrát znovu';

  @override
  String gameLevelReached(int level) {
    return 'Dosažena úroveň $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count úrovní',
      few: '$count úrovně',
      one: '$count úroveň',
    );
    return '+$_temp0 — úroveň $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 mincí + motiv Dřevo';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hodin',
      few: '$hours hodiny',
      one: '$hours hodina',
    );
    return 'Zbývá jen $_temp0 — jen jednou!';
  }

  @override
  String get boosterUndo => 'Zpět';

  @override
  String get boosterSwap => 'Výměna';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft => 'Otočení došla — maž řady a dobiješ je!';

  @override
  String get onboardingDragPiece => 'Přetáhni dílek na desku';

  @override
  String get onboardingFillLine => 'Zaplň celou řadu nebo sloupec';

  @override
  String get onboardingLinesClear => 'Plné řady zmizí — body!';

  @override
  String get coachHintCombo => 'Kombo! Smaž znovu do 3 tahů a udržíš ho';

  @override
  String get coachHintFever => 'HOREČKA! Dvojnásobné body, dokud svítí';

  @override
  String get coachHintRotation =>
      'Otočení stojí jeden náboj — mazání ho doplní';

  @override
  String get coachHintBooster => 'Tip: dole máš pomůcky';

  @override
  String get coachHintStrategy =>
      'Tip: nemaž všechny řady naráz — nech místo pro velké dílky';

  @override
  String get dailyStreakLabel => 'Série';

  @override
  String get dailyBestLabel => 'Denní rekord';

  @override
  String dailyHistoryNote(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dní',
      few: '$days dny',
      one: '$days den',
    );
    return 'Uchovává se posledních $_temp0.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: odehráno';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: neodehráno';
  }

  @override
  String get homeDailyCalendar => 'Kalendář';

  @override
  String get dailyShareButton => 'Sdílet výsledek';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Denní výzva $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Skóre: $score · nejlepší kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Hraj: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Kombo: zbývá $moves tahů',
      few: 'Kombo: zbývají $moves tahy',
      one: 'Kombo: zbývá $moves tah',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Výsledek zkopírován do schránky';

  @override
  String get adNotAvailable =>
      'Teď není k dispozici žádné video — zkus to za chvíli';

  @override
  String get howToPlaySpeedTitle => 'Bonus za rychlost';

  @override
  String get howToPlaySpeedBody =>
      'Rychlé pokládání přidá k mazání až 30 %. Bonus slábne mezi 1,5 a 4 sekundami a má strop, takže rychlost se vyplatí, ale nerozhoduje — pečlivá pomalá hra může porazit uspěchanou rychlou.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus za rychlost $percent procent';
  }

  @override
  String get iapDiamondsSmall => '100 diamantů';

  @override
  String get iapDiamondsMedium => '350 diamantů';

  @override
  String get iapDiamondsLarge => '1 000 diamantů';

  @override
  String get howToPlayTitle => 'Jak hrát Qubble';

  @override
  String get howToPlayIntroHeadline => 'Snadný začátek.\nPlánování se vyplácí.';

  @override
  String get howToPlayIntroBody =>
      'Udržuj desku volnou a překonej svůj rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Cíl hry. Udržuj desku volnou a překonej svůj rekord.';

  @override
  String get howToPlayDragTitle => 'Přetáhni a polož';

  @override
  String get howToPlayDragBody =>
      'Přetáhni jeden ze tří dílků na volná políčka. Když použiješ všechny tři, automaticky dostaneš tři nové.';

  @override
  String get howToPlayClearTitle => 'Maž řady';

  @override
  String get howToPlayClearBody =>
      'Zaplň celou řadu nebo sloupec. Plné řady zmizí a udělají místo pro další tah.';

  @override
  String get howToPlayComboTitle => 'Řeť komba';

  @override
  String get howToPlayComboBody =>
      'Smaž další řadu do tří tahů. Každé další kombo zvýší násobitel bodů. Kombo počítá tahy, ne sekundy, takže nevyprší, zatímco přemýšlíš.';

  @override
  String get howToPlayFeverTitle => 'Rozpal horečku';

  @override
  String get howToPlayFeverBody =>
      'Mazání plní ukazatel horečky. Když je plný, další mazání se počítá dvojnásobně — plánuj velká mazání dopředu.';

  @override
  String get howToPlayBoosterTitle => 'Používej pomůcky s rozumem';

  @override
  String get howToPlayBoosterBody =>
      'Pomůcky zachrání těsné hry. Dílek v zásobníku můžeš také otočit klepnutím.';

  @override
  String get howToPlayDailyTitle => 'Denní výzva a série';

  @override
  String get howToPlayDailyBody =>
      'Denní výzva používá pro všechny stejné dílky. Hraj každý den a prodlužuj sérii i bonus.';

  @override
  String get howToPlayPiggyTitle => 'Plň prasátko';

  @override
  String get howToPlayPiggyBody =>
      'Každá smazaná řada plní tvé prasátko. Až bude plné, můžeš mince vybrat zdarma.';

  @override
  String get leaderboardTitle => 'Žebříček';

  @override
  String get leaderboardUnreachable =>
      'Žebříček není dostupný.\nZkus to znovu s připojením k internetu.';

  @override
  String get leaderboardEmpty => 'Zatím žádné záznamy.\nBuď první!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Tvé nejlepší skóre ($score) se odesílá …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Tvé nejlepší skóre se odesílá automaticky.';

  @override
  String get puzzleModeTitle => 'Režim hádanek';

  @override
  String puzzleLevelTitle(int level) {
    return 'Hádanka $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Tahy: $moves   •   Cíl: $target na 3 hvězdy';
  }

  @override
  String get puzzleSolved => 'Vyřešeno!';

  @override
  String get puzzleLeaveTitle => 'Opustit hádanku?';

  @override
  String get puzzleLeaveBody => 'Postup v této hádance se ztratí.';

  @override
  String get puzzleKeepPlaying => 'Hrát dál';

  @override
  String get puzzleLeave => 'Opustit';

  @override
  String get puzzleStuckTitle => 'Slepá ulička';

  @override
  String get puzzleRestart => 'Začít znovu';

  @override
  String get commonActive => 'Aktivní';

  @override
  String get commonTapToActivate => 'Klepnutím aktivuj';

  @override
  String get commonRestore => 'Obnovit';

  @override
  String unlockForCost(int cost) {
    return 'Odemknout za $cost';
  }

  @override
  String get skinsExchangeGold => 'Směnit zlato';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Otočit dílek';

  @override
  String get puzzleNextLevel => 'Další úroveň';

  @override
  String get puzzleBackToOverview => 'Zpět na přehled';

  @override
  String get puzzleUnsolvable => 'Odsud už desku úplně vyprázdnit nejde.';

  @override
  String get puzzleExtraMoveVideo => 'Tah navíc (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Vyřešeno: $solved';
  }

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get storageFailureTitle => 'Qubble nemůže načíst uloženou hru';

  @override
  String get storageFailureBody =>
      'Restartuj prosím aplikaci. Pokud chyba přetrvá, pomůže jen přeinstalace. Nahlásit ji můžeš v Nastavení › Poslat zpětnou vazbu.';

  @override
  String get iapUnavailable => 'Tato nabídka teď není dostupná.';

  @override
  String get iapFailed => 'Nákup neproběhl. Nic nebylo účtováno.';

  @override
  String get settingsResetProgress => 'Resetovat postup';

  @override
  String get settingsResetProgressSubtitle =>
      'Skóre, mince, úroveň a postup se vrátí na začátek. Nákupy, jméno a kosmetika zůstanou.';

  @override
  String get settingsResetConfirmTitle => 'Resetovat postup?';

  @override
  String get settingsResetConfirmBody =>
      'Nejlepší skóre, mince, úroveň, série a veškerý postup budou smazány. Nelze to vrátit.\n\nTvé nákupy, jméno a odemčené motivy a vzhledy zůstanou.';

  @override
  String get settingsResetConfirmAction => 'Resetovat';

  @override
  String get settingsResetDone => 'Postup byl resetován.';

  @override
  String get settingsSectionGame => 'Hra';

  @override
  String get settingsSectionSoundHaptics => 'Zvuk a vibrace';

  @override
  String get settingsSectionReminders => 'Připomínky';

  @override
  String get settingsSectionPurchases => 'Nákupy';

  @override
  String get settingsSectionHelpOut => 'Podpoř nás';

  @override
  String get settingsSectionLegal => 'Právní informace';

  @override
  String get settingsSectionLanguage => 'Jazyk';

  @override
  String get settingsGuide => 'Jak hrát';

  @override
  String get settingsGuideSubtitle => 'Pravidla, komba, horečka a pomůcky';

  @override
  String get settingsSound => 'Zvuk';

  @override
  String get settingsMusic => 'Hudba';

  @override
  String get settingsHaptics => 'Vibrace';

  @override
  String get settingsHapticsOff => 'Vyp.';

  @override
  String get settingsHapticsLight => 'Slabé';

  @override
  String get settingsHapticsStrong => 'Silné';

  @override
  String get settingsSectionAccessibility => 'Pohodlí';

  @override
  String get settingsReducedEffects => 'Méně efektů';

  @override
  String get settingsReducedEffectsHint =>
      'Méně částic, bez třesení obrazovky, bez záře';

  @override
  String get settingsNotifications => 'Oznámení';

  @override
  String get settingsNotificationsSubtitle =>
      'Denní připomínka a ochrana série';

  @override
  String get settingsNotificationsSystemHint => 'Povol je v nastavení systému.';

  @override
  String get settingsLanguageSystem => 'Jazyk systému';

  @override
  String get settingsSupporterThanks => 'Podporovatel — díky!';

  @override
  String get settingsSupporterPack => 'Balíček podporovatele';

  @override
  String get settingsSupporterPackSubtitle =>
      'Exkluzivní motiv a vzhled + 1 500 mincí';

  @override
  String get settingsRestorePurchases => 'Obnovit nákupy';

  @override
  String get settingsRestoring => 'Obnovují se nákupy…';

  @override
  String get settingsRateApp => 'Ohodnotit aplikaci';

  @override
  String get settingsRateAppSubtitle => 'Zanech hodnocení v obchodě';

  @override
  String get settingsStoreUnavailable =>
      'Obchod na tomto zařízení není dostupný.';

  @override
  String get settingsFeedback => 'Poslat zpětnou vazbu';

  @override
  String get settingsFeedbackSubtitle => 'Nápady a chyby (přes GitHub)';

  @override
  String get settingsAdPrivacy => 'Soukromí reklam';

  @override
  String get settingsAdPrivacySubtitle =>
      'Zobrazit nebo změnit souhlas s reklamami';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Na tomto zařízení nejsou potřeba žádné volby reklam.';

  @override
  String get settingsPrivacy => 'Zásady ochrany soukromí';

  @override
  String get settingsImprint => 'Tiráž';

  @override
  String get settingsPageOpenFailed => 'Stránku se nepodařilo otevřít.';

  @override
  String get settingsFooter => 'Qubble • Offline hlavolam s kostkami';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Režim admina zapnut';

  @override
  String settingsAdminTapsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Klepni ještě $count× pro režim admina',
      few: 'Klepni ještě $count× pro režim admina',
      one: 'Klepni ještě $count× pro režim admina',
    );
    return '$_temp0';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mincí',
      few: '$coins mince',
      one: '$coins mince',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Jen pro testování — nikdy neukazovat na snímcích vydané verze';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount mincí';
  }

  @override
  String get settingsAdminResetCoins => 'Nastavit mince na 0';

  @override
  String get feedbackTitle => 'Zpětná vazba';

  @override
  String get feedbackIntroShort =>
      'Co se ti líbí, co tě štve, co chybí? I drobnosti pomůžou — čím konkrétněji, tím líp.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Přikládá se jen $build a typ tvého zařízení — aby bylo jasné, o jakou verzi jde.';
  }

  @override
  String get feedbackSendByMail => 'Poslat e-mailem';

  @override
  String get feedbackPreferGithub => 'Raději issue na GitHubu';

  @override
  String get feedbackThanksMail => 'Díky! Zprávu už jen odešli.';

  @override
  String get feedbackNoMailApp =>
      'Nenašla se žádná e-mailová aplikace. Zkus cestu přes GitHub níže.';

  @override
  String get feedbackEmptyHint => 'Nejdřív prosím něco napiš.';

  @override
  String get leaderboardRefresh => 'Obnovit';

  @override
  String get leaderboardRetry => 'Zkusit znovu';

  @override
  String get feedbackHint => 'Tvá zpětná vazba…';

  @override
  String get feedbackSubmit => 'Poslat zpětnou vazbu';

  @override
  String get feedbackOpenFailed =>
      'GitHub se nepodařilo otevřít. Zkus to později.';

  @override
  String get feedbackGithubNote =>
      'Otevře se GitHub — klepni tam na „Submit new issue“. (Je potřeba jednorázové přihlášení do GitHubu.)';

  @override
  String get shopTitle => 'Obchod';

  @override
  String get shopWebDemoNote =>
      'Nákupy jsou dostupné jen v aplikaci z Obchodu Play. Tato webová verze je bezplatné demo — celou hru si tu ale zahraješ.';

  @override
  String get shopSupporterExplainer =>
      'Qubble nezobrazuje vynucené reklamy — nikdy nemusíš nic kupovat. Balíček podporovatele (motiv Polární záře, vzhled Krystal, 1 500 mincí, odznak podporovatele) je poděkování za podporu hry. Nákupy jsou vázané na tvůj účet v obchodě a dají se kdykoli obnovit.';

  @override
  String get shopSupporterContents =>
      'Motiv Polární záře + vzhled Krystal + 1 500 mincí';

  @override
  String get themesTitle => 'Motivy';

  @override
  String get themesSupporterOnly => 'Jen v balíčku podporovatele (viz obchod)';

  @override
  String get themesInSupporterPack => 'V balíčku podporovatele';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Málo mincí (potřeba $cost, máš $coins)';
  }

  @override
  String get skinsTitle => 'Vzhledy kostek';

  @override
  String get skinsNotEnoughDiamonds => 'Málo diamantů (směň zlato níže)';

  @override
  String get skinsNotEnoughCoins => 'Málo mincí';

  @override
  String get skinsNotEnoughGold => 'Málo zlata.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold zlata = 1 diamant. Diamanty odemykají nejkrásnější vzhledy — sbírej v klidu.';
  }

  @override
  String get statsTitle => 'Statistiky';

  @override
  String get statsAverageScore => 'Prům. skóre';

  @override
  String get statsBestCombo => 'Nejlepší kombo';

  @override
  String get statsGames => 'Hry';

  @override
  String get statsLinesCleared => 'Smazané řady';

  @override
  String get statsPiecesPlaced => 'Položené dílky';

  @override
  String get statsCoins => 'Mince';

  @override
  String get missionsTitle => 'Mise';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString dílků',
      few: '$countString dílky',
      one: '$countString dílek',
    );
    return 'Polož $_temp0';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString řad',
      few: '$countString řady',
      one: '$countString řadu',
    );
    return 'Smaž $_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Dosáhni komba x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString bodů',
      few: '$countString body',
      one: '$countString bod',
    );
    return 'Překonej $_temp0 v jedné hře';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString her',
      few: '$countString hry',
      one: '$countString hru',
    );
    return 'Zahraj $_temp0';
  }

  @override
  String get achievementsTitle => 'Úspěchy';

  @override
  String get achievementFirstGameTitle => 'První hra';

  @override
  String get achievementFirstGameBody => 'Zahraj svou první hru';

  @override
  String get achievementGames25Title => 'Štamgast';

  @override
  String get achievementGames25Body => 'Zahraj 25 her';

  @override
  String get achievementGames100Title => 'Závislák';

  @override
  String get achievementGames100Body => 'Zahraj 100 her';

  @override
  String get achievementScore1kTitle => 'Horolezec';

  @override
  String get achievementScore1kBody => 'Dosáhni 1 000 bodů';

  @override
  String get achievementScore5kTitle => 'Profík';

  @override
  String get achievementScore5kBody => 'Dosáhni 5 000 bodů';

  @override
  String get achievementScore10kTitle => 'Mistr';

  @override
  String get achievementScore10kBody => 'Dosáhni 10 000 bodů';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Dosáhni 25 000 bodů';

  @override
  String get achievementLines100Title => 'Pořádkumilovný';

  @override
  String get achievementLines100Body => 'Smaž celkem 100 řad';

  @override
  String get achievementLines1000Title => 'Velký úklid';

  @override
  String get achievementLines1000Body => 'Smaž celkem 1 000 řad';

  @override
  String get achievementCombo5Title => 'Začátečník komb';

  @override
  String get achievementCombo5Body => 'Dosáhni komba x5';

  @override
  String get achievementCombo10Title => 'Král komb';

  @override
  String get achievementCombo10Body => 'Dosáhni komba x10';

  @override
  String get achievementLevel10Title => 'Zkušený';

  @override
  String get achievementLevel10Body => 'Dosáhni úrovně 10';

  @override
  String get achievementLevel20Title => 'Veterán';

  @override
  String get achievementLevel20Body => 'Dosáhni úrovně 20';

  @override
  String get achievementStreak7Title => 'Celý týden';

  @override
  String get achievementStreak7Body => 'Denní série 7 dní';

  @override
  String get achievementStreak30Title => 'Celý měsíc';

  @override
  String get achievementStreak30Body => 'Denní série 30 dní';

  @override
  String get achievementPuzzles10Title => 'Luštitel';

  @override
  String get achievementPuzzles10Body => 'Vyřeš 10 hádanek';

  @override
  String get achievementPieces5000Title => 'Stavitel';

  @override
  String get achievementPieces5000Body => 'Polož 5 000 dílků';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak dní',
      few: '$streak dny',
      one: '$streak den',
    );
    return 'Série v ohrožení: $_temp0!';
  }

  @override
  String get streakRepairBody => 'Včera se nehrálo — zachraň svou sérii:';

  @override
  String get streakRepairFailed => 'Oprava není možná.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mincí',
      few: '$coins mince',
      one: '$coins mince',
    );
    return 'Vítej zpět! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Připomínky?';

  @override
  String get notificationsOptInBody =>
      'Máme ti připomínat denní hádanku a chránit tvou sérii? V nastavení to můžeš kdykoli změnit.';

  @override
  String get notificationsOptInAccept => 'Ano, prosím';

  @override
  String get notificationChannelDescription =>
      'Denní připomínka, varování před koncem série, pozvánka zpět';

  @override
  String get notificationDailyTitle => 'Tvá denní hádanka čeká 🧩';

  @override
  String get notificationDailyBody => 'Zahraj si dnešní výzvu!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak dní',
      few: '$streak dny',
      one: '$streak den',
    );
    return '🔥 Série v ohrožení: $_temp0!';
  }

  @override
  String get notificationStreakBody => 'Zahraj si dnes a udržíš ji.';

  @override
  String get notificationComebackTitle => 'Tvé hádance se po tobě stýská 🧩';

  @override
  String get notificationComebackBody => 'Vrať se a vyzvedni si dárek!';

  @override
  String get iapSupporterPack => 'Balíček podporovatele';

  @override
  String get iapCoinsSmall => '500 mincí';

  @override
  String get iapCoinsMedium => '2 000 mincí';

  @override
  String get iapCoinsLarge => '6 000 mincí';

  @override
  String get iapStarterPack => 'Startovní balíček';

  @override
  String get iapRename => 'Změna jména';

  @override
  String get iapNeonTheme => 'Motiv Neon';

  @override
  String get settingsLeaderboardDelete => 'Smazat záznam v žebříčku';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Odstraní tvé jméno a skóre z veřejného seznamu';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Smazat tvůj záznam?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tvé jméno a skóre budou z žebříčku odstraněny. Postup ve hře zůstane beze změny. Do žebříčku se můžeš kdykoli znovu zapsat.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Tvůj záznam v žebříčku byl smazán.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Záznam se nepodařilo smazat. Zkontroluj připojení a zkus to znovu.';

  @override
  String get leaderboardReport => 'Nahlásit toto jméno';

  @override
  String get leaderboardBlock => 'Blokovat';

  @override
  String leaderboardBlocked(String name) {
    return '$name je pro tebe skryto';
  }

  @override
  String get leaderboardUndo => 'Zpět';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Skrytých $count záznamů',
      few: 'Skryté $count záznamy',
      one: 'Skrytý $count záznam',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Znovu zobrazit';

  @override
  String get leaderboardReportUnavailable => 'Nahlášení teď není dostupné.';

  @override
  String get leaderboardReportSent => 'Díky — hlášení je na cestě.';

  @override
  String get leaderboardRules =>
      'Jména jsou veřejná. Žádné urážky, žádné nadávky a nic, co by identifikovalo skutečnou osobu. Jména, která pravidla porušují, se odstraňují.';

  @override
  String get leaderboardRulesAccept => 'Rozumím';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Odemčeno $unlocked z $total';
  }

  @override
  String get settingsSectionData => 'Uložená data';

  @override
  String get gameRotatePiece => 'Otočit dílek';

  @override
  String get themeClassic => 'Klasika';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Oceán';

  @override
  String get themeWood => 'Dřevo';

  @override
  String get themeSunset => 'Západ slunce';

  @override
  String get themeForest => 'Les';

  @override
  String get themeAurora => 'Polární záře';

  @override
  String get skinClassic => 'Klasika';

  @override
  String get skinGradient => 'Přechod';

  @override
  String get skinOutline => 'Obrys';

  @override
  String get skinGlossy => 'Lesk';

  @override
  String get skinStripe => 'Proužky';

  @override
  String get skinBevel => 'Zkosení';

  @override
  String get skinGlow => 'Záře';

  @override
  String get skinCrystal => 'Krystal';

  @override
  String rewardThemeName(String name) {
    return 'Motiv $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Vzhled $name';
  }
}
