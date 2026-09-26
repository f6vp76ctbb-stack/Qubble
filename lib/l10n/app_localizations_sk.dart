// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class L10nSk extends L10n {
  L10nSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Hrať';

  @override
  String get commonLater => 'Neskôr';

  @override
  String get commonNotNow => 'Teraz nie';

  @override
  String get commonCancel => 'Zrušiť';

  @override
  String get commonBuy => 'Kúpiť';

  @override
  String get commonSave => 'Uložiť';

  @override
  String get commonCollect => 'Vybrať';

  @override
  String get nameNewName => 'Nové meno';

  @override
  String get nameFieldLabel => 'Meno';

  @override
  String get piggyFullTitle => 'Prasiatko je plné!';

  @override
  String get piggyKeepSaving => 'Šetriť ďalej';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Nazbierané $coins z $capacity.';
  }

  @override
  String get homeContinueRun => 'Pokračovať';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Rozumiem';

  @override
  String get commonHome => 'Domov';

  @override
  String get commonScore => 'SKÓRE';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Úroveň $level';
  }

  @override
  String get homeNewRun => 'Začať novú hru';

  @override
  String get homeBackToExit => 'Na ukončenie stlač Späť ešte raz';

  @override
  String get homeEnableLeaderboard => 'Zapísať sa do rebríčka';

  @override
  String get homeBestScore => 'NAJLEPŠIE SKÓRE';

  @override
  String get homeDailyChallenge => 'Denná výzva';

  @override
  String get homeDailyOpenToday => 'Dnes ešte nehrané';

  @override
  String homeDailyNextIn(String time) {
    return 'Ďalšia výzva o $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak dní',
      few: '$streak dni',
      one: '$streak deň',
    );
    return 'Séria: $_temp0';
  }

  @override
  String get homeLeaderboard => 'Rebríček';

  @override
  String get homePuzzleMode => 'Hádanky';

  @override
  String get homeMissions => 'Misie';

  @override
  String get homeThemes => 'Motívy';

  @override
  String get homeSkins => 'Vzhľady';

  @override
  String get homeHowToPlay => 'Ako hrať Qubble';

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
  String get nameChangeTitle => 'Zmeniť meno';

  @override
  String get nameChangeExplainer =>
      'Tvoje meno je tvojou identitou v rebríčku, preto sa nemení. Môžeš si kúpiť jednorazovú zmenu mena.';

  @override
  String get nameChangeAfterPurchase =>
      'Po nákupe ťukni znova na svoje meno a zmeň ho.';

  @override
  String get nameJoinedLeaderboard => 'Teraz si v rebríčku.';

  @override
  String get nameRenameUnavailable => 'Meno teraz nemožno zmeniť.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min znakov',
      few: '$min znaky',
      one: '$min znak',
    );
    return 'Najmenej $_temp0.';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: '$max znakov',
      few: '$max znaky',
      one: '$max znak',
    );
    return 'Najviac $_temp0.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Len písmená, číslice, medzery, _ a -.';

  @override
  String get nameProblemOffensive => 'Zvoľ si, prosím, iné meno.';

  @override
  String get piggyTitle => 'Prasiatko';

  @override
  String get piggyFillingHint => 'Prasiatko sa plní, keď mažeš rady.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mincí',
      few: '$coins mince',
      one: '$coins minca',
    );
    return 'Vyber $_temp0 — zadarmo.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Keď bude plné, môžeš ho vybrať zadarmo — alebo ho otvoriť skôr za bonusové video.';

  @override
  String get piggyOpenNow => 'Otvoriť hneď';

  @override
  String get gameNewPiecesVideo => 'Nové dieliky (video)';

  @override
  String get gameTapBoardCell => 'Ťukni na políčko na ploche';

  @override
  String get gameDailyChallengeLabel => 'DENNÁ VÝZVA';

  @override
  String get gameOver => 'Koniec hry';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Na bombu ti chýbajú mince: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomba tu teraz nefunguje.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Chýbajú ti mince: $missing.';
  }

  @override
  String get gameNotRightNow => 'Teraz to nejde.';

  @override
  String get gameRunSaved => 'Hra uložená — „Pokračovať“ v menu.';

  @override
  String get gameOverNoFit =>
      'Žiadny z tvojich dielikov sa už na plochu nezmestí.';

  @override
  String get gameOverNoFitNoRotations =>
      'Žiadny dielik sa nezmestí — a otočenia sa minuli.';

  @override
  String get gameStarterOfferUnavailable => 'Teraz nedostupné';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — získať';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Úspech: $title';
  }

  @override
  String get gameBestSubmitted => 'Nový rekord — odoslané';

  @override
  String get gameReviveFor => 'Hrať ďalej · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Odomknuté: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Štartovací balíček';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score bodov',
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
      few: '$streak dni',
      one: '$streak deň',
    );
    return 'Séria: $_temp0';
  }

  @override
  String get gameDoubleCoins => 'Zdvojnásobiť mince';

  @override
  String get gameDoubleDaily => 'Zdvojnásobiť dennú odmenu';

  @override
  String get gamePlayAgain => 'Hrať znova';

  @override
  String gameLevelReached(int level) {
    return 'Dosiahnutá úroveň $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count úrovní',
      few: '$count úrovne',
      one: '$count úroveň',
    );
    return '+$_temp0 — úroveň $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 mincí + motív Drevo';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hodín',
      few: '$hours hodiny',
      one: '$hours hodina',
    );
    return 'Už len $_temp0 — len raz!';
  }

  @override
  String get boosterUndo => 'Späť';

  @override
  String get boosterSwap => 'Výmena';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Otočenia sa minuli — maž rady a dobiješ ich!';

  @override
  String get onboardingDragPiece => 'Presuň dielik na plochu';

  @override
  String get onboardingFillLine => 'Zaplň celý rad alebo stĺpec';

  @override
  String get onboardingLinesClear => 'Plné rady zmiznú — body!';

  @override
  String get coachHintCombo => 'Kombo! Zmaž znova do 3 ťahov a udržíš ho';

  @override
  String get coachHintFever => 'HORÚČKA! Dvojnásobné body, kým svieti';

  @override
  String get coachHintRotation =>
      'Otočenie stojí jeden náboj — mazanie ho doplní';

  @override
  String get coachHintBooster => 'Tip: dole máš pomôcky';

  @override
  String get coachHintStrategy =>
      'Tip: nemaž všetky rady naraz — nechaj miesto pre veľké dieliky';

  @override
  String get dailyStreakLabel => 'Séria';

  @override
  String get dailyBestLabel => 'Denný rekord';

  @override
  String dailyHistoryNote(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dní',
      few: '$days dni',
      one: '$days deň',
    );
    return 'Uchováva sa posledných $_temp0.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: odohrané';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: neodohrané';
  }

  @override
  String get homeDailyCalendar => 'Kalendár';

  @override
  String get dailyShareButton => 'Zdieľať výsledok';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Denná výzva $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Skóre: $score · najlepšie kombo x$combo';
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
      other: 'Kombo: zostáva $moves ťahov',
      few: 'Kombo: zostávajú $moves ťahy',
      one: 'Kombo: zostáva $moves ťah',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Výsledok skopírovaný do schránky';

  @override
  String get adNotAvailable =>
      'Teraz nie je k dispozícii žiadne video — skús to o chvíľu';

  @override
  String get howToPlaySpeedTitle => 'Bonus za rýchlosť';

  @override
  String get howToPlaySpeedBody =>
      'Rýchle kladenie pridá k mazaniu až 30 %. Bonus slabne medzi 1,5 a 4 sekundami a má strop, takže rýchlosť sa oplatí, ale nerozhoduje — starostlivá pomalá hra môže poraziť uponáhľanú rýchlu.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus za rýchlosť $percent percent';
  }

  @override
  String get iapDiamondsSmall => '100 diamantov';

  @override
  String get iapDiamondsMedium => '350 diamantov';

  @override
  String get iapDiamondsLarge => '1 000 diamantov';

  @override
  String get howToPlayTitle => 'Ako hrať Qubble';

  @override
  String get howToPlayIntroHeadline => 'Ľahký začiatok.\nPlánovanie sa oplatí.';

  @override
  String get howToPlayIntroBody =>
      'Udržuj plochu voľnú a prekonaj svoj rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Cieľ hry. Udržuj plochu voľnú a prekonaj svoj rekord.';

  @override
  String get howToPlayDragTitle => 'Presuň a polož';

  @override
  String get howToPlayDragBody =>
      'Presuň jeden z troch dielikov na voľné políčka. Keď použiješ všetky tri, automaticky dostaneš tri nové.';

  @override
  String get howToPlayClearTitle => 'Maž rady';

  @override
  String get howToPlayClearBody =>
      'Zaplň celý rad alebo stĺpec. Plné rady zmiznú a urobia miesto pre ďalší ťah.';

  @override
  String get howToPlayComboTitle => 'Reťaz kombá';

  @override
  String get howToPlayComboBody =>
      'Zmaž ďalší rad do troch ťahov. Každé ďalšie kombo zvýši násobiteľ bodov. Kombo počíta ťahy, nie sekundy, takže nevyprší, kým premýšľaš.';

  @override
  String get howToPlayFeverTitle => 'Roznieť horúčku';

  @override
  String get howToPlayFeverBody =>
      'Mazanie plní ukazovateľ horúčky. Keď je plný, ďalšie mazanie sa počíta dvojnásobne — plánuj veľké mazania dopredu.';

  @override
  String get howToPlayBoosterTitle => 'Používaj pomôcky s rozumom';

  @override
  String get howToPlayBoosterBody =>
      'Pomôcky zachránia tesné hry. Dielik v zásobníku môžeš aj otočiť ťuknutím.';

  @override
  String get howToPlayDailyTitle => 'Denná výzva a séria';

  @override
  String get howToPlayDailyBody =>
      'Denná výzva používa pre všetkých rovnaké dieliky. Hraj každý deň a predlžuj sériu aj bonus.';

  @override
  String get howToPlayPiggyTitle => 'Plň prasiatko';

  @override
  String get howToPlayPiggyBody =>
      'Každý zmazaný rad plní tvoje prasiatko. Keď bude plné, môžeš mince vybrať zadarmo.';

  @override
  String get leaderboardTitle => 'Rebríček';

  @override
  String get leaderboardUnreachable =>
      'Rebríček nie je dostupný.\nSkús to znova s pripojením na internet.';

  @override
  String get leaderboardEmpty => 'Zatiaľ žiadne záznamy.\nBuď prvý!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Tvoje najlepšie skóre ($score) sa odosiela …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Tvoje najlepšie skóre sa odosiela automaticky.';

  @override
  String get puzzleModeTitle => 'Režim hádaniek';

  @override
  String puzzleLevelTitle(int level) {
    return 'Hádanka $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Ťahy: $moves   •   Cieľ: $target na 3 hviezdy';
  }

  @override
  String get puzzleSolved => 'Vyriešené!';

  @override
  String get puzzleLeaveTitle => 'Opustiť hádanku?';

  @override
  String get puzzleLeaveBody => 'Postup v tejto hádanke sa stratí.';

  @override
  String get puzzleKeepPlaying => 'Hrať ďalej';

  @override
  String get puzzleLeave => 'Opustiť';

  @override
  String get puzzleStuckTitle => 'Slepá ulička';

  @override
  String get puzzleRestart => 'Začať znova';

  @override
  String get commonActive => 'Aktívne';

  @override
  String get commonTapToActivate => 'Ťuknutím aktivuj';

  @override
  String get commonRestore => 'Obnoviť';

  @override
  String unlockForCost(int cost) {
    return 'Odomknúť za $cost';
  }

  @override
  String get skinsExchangeGold => 'Zameniť zlato';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Otočiť dielik';

  @override
  String get puzzleNextLevel => 'Ďalšia úroveň';

  @override
  String get puzzleBackToOverview => 'Späť na prehľad';

  @override
  String get puzzleUnsolvable => 'Odtiaľto sa už plocha úplne vyprázdniť nedá.';

  @override
  String get puzzleExtraMoveVideo => 'Ťah navyše (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Vyriešené: $solved';
  }

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get storageFailureTitle => 'Qubble nemôže načítať uloženú hru';

  @override
  String get storageFailureBody =>
      'Reštartuj, prosím, aplikáciu. Ak chyba pretrváva, pomôže len preinštalovanie. Nahlásiť ju môžeš v Nastavenia › Poslať spätnú väzbu.';

  @override
  String get iapUnavailable => 'Táto ponuka teraz nie je dostupná.';

  @override
  String get iapFailed => 'Nákup neprebehol. Nič nebolo účtované.';

  @override
  String get settingsResetProgress => 'Resetovať postup';

  @override
  String get settingsResetProgressSubtitle =>
      'Skóre, mince, úroveň a postup sa vrátia na začiatok. Nákupy, meno a kozmetika zostanú.';

  @override
  String get settingsResetConfirmTitle => 'Resetovať postup?';

  @override
  String get settingsResetConfirmBody =>
      'Najlepšie skóre, mince, úroveň, séria a všetok postup budú vymazané. Nedá sa to vrátiť.\n\nTvoje nákupy, meno a odomknuté motívy a vzhľady zostanú.';

  @override
  String get settingsResetConfirmAction => 'Resetovať';

  @override
  String get settingsResetDone => 'Postup bol resetovaný.';

  @override
  String get settingsSectionGame => 'Hra';

  @override
  String get settingsSectionSoundHaptics => 'Zvuk a vibrácie';

  @override
  String get settingsSectionReminders => 'Pripomienky';

  @override
  String get settingsSectionPurchases => 'Nákupy';

  @override
  String get settingsSectionHelpOut => 'Podpor nás';

  @override
  String get settingsSectionLegal => 'Právne informácie';

  @override
  String get settingsSectionLanguage => 'Jazyk';

  @override
  String get settingsGuide => 'Ako hrať';

  @override
  String get settingsGuideSubtitle => 'Pravidlá, kombá, horúčka a pomôcky';

  @override
  String get settingsSound => 'Zvuk';

  @override
  String get settingsMusic => 'Hudba';

  @override
  String get settingsHaptics => 'Vibrácie';

  @override
  String get settingsHapticsOff => 'Vyp.';

  @override
  String get settingsHapticsLight => 'Slabé';

  @override
  String get settingsHapticsStrong => 'Silné';

  @override
  String get settingsSectionAccessibility => 'Pohodlie';

  @override
  String get settingsReducedEffects => 'Menej efektov';

  @override
  String get settingsReducedEffectsHint =>
      'Menej častíc, bez trasenia obrazovky, bez žiary';

  @override
  String get settingsNotifications => 'Upozornenia';

  @override
  String get settingsNotificationsSubtitle =>
      'Denná pripomienka a ochrana série';

  @override
  String get settingsNotificationsSystemHint =>
      'Povoľ ich v nastaveniach systému.';

  @override
  String get settingsLanguageSystem => 'Jazyk systému';

  @override
  String get settingsSupporterThanks => 'Podporovateľ — ďakujeme!';

  @override
  String get settingsSupporterPack => 'Balíček podporovateľa';

  @override
  String get settingsSupporterPackSubtitle =>
      'Exkluzívny motív a vzhľad + 1 500 mincí';

  @override
  String get settingsRestorePurchases => 'Obnoviť nákupy';

  @override
  String get settingsRestoring => 'Obnovujú sa nákupy…';

  @override
  String get settingsRateApp => 'Ohodnotiť aplikáciu';

  @override
  String get settingsRateAppSubtitle => 'Zanechaj hodnotenie v obchode';

  @override
  String get settingsStoreUnavailable =>
      'Obchod nie je na tomto zariadení dostupný.';

  @override
  String get settingsFeedback => 'Poslať spätnú väzbu';

  @override
  String get settingsFeedbackSubtitle => 'Nápady a chyby (cez GitHub)';

  @override
  String get settingsAdPrivacy => 'Súkromie reklám';

  @override
  String get settingsAdPrivacySubtitle =>
      'Zobraziť alebo zmeniť súhlas s reklamami';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Na tomto zariadení nie sú potrebné žiadne voľby reklám.';

  @override
  String get settingsPrivacy => 'Zásady ochrany súkromia';

  @override
  String get settingsImprint => 'Tiráž';

  @override
  String get settingsPageOpenFailed => 'Stránku sa nepodarilo otvoriť.';

  @override
  String get settingsFooter => 'Qubble • Offline hlavolam s kockami';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Režim admina zapnutý';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Ťukni ešte $count× pre režim admina';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mincí',
      few: '$coins mince',
      one: '$coins minca',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Len na testovanie — nikdy neukazovať na snímkach vydanej verzie';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount mincí';
  }

  @override
  String get settingsAdminResetCoins => 'Nastaviť mince na 0';

  @override
  String get feedbackTitle => 'Spätná väzba';

  @override
  String get feedbackIntroShort =>
      'Čo sa ti páči, čo ťa hnevá, čo chýba? Aj drobnosti pomôžu — čím konkrétnejšie, tým lepšie.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Prikladá sa len $build a typ tvojho zariadenia — aby bolo jasné, o akú verziu ide.';
  }

  @override
  String get feedbackSendByMail => 'Poslať e-mailom';

  @override
  String get feedbackPreferGithub => 'Radšej issue na GitHube';

  @override
  String get feedbackThanksMail => 'Vďaka! Správu už len odošli.';

  @override
  String get feedbackNoMailApp =>
      'Nenašla sa žiadna e-mailová aplikácia. Skús cestu cez GitHub nižšie.';

  @override
  String get feedbackEmptyHint => 'Najprv, prosím, niečo napíš.';

  @override
  String get leaderboardRefresh => 'Obnoviť';

  @override
  String get leaderboardRetry => 'Skúsiť znova';

  @override
  String get feedbackHint => 'Tvoja spätná väzba…';

  @override
  String get feedbackSubmit => 'Poslať spätnú väzbu';

  @override
  String get feedbackOpenFailed =>
      'GitHub sa nepodarilo otvoriť. Skús to neskôr.';

  @override
  String get feedbackGithubNote =>
      'Otvorí sa GitHub — ťukni tam na „Submit new issue“. (Je potrebné jednorazové prihlásenie do GitHubu.)';

  @override
  String get shopTitle => 'Obchod';

  @override
  String get shopWebDemoNote =>
      'Nákupy sú dostupné len v aplikácii z Obchodu Play. Táto webová verzia je bezplatné demo — celú hru si tu však zahráš.';

  @override
  String get shopSupporterExplainer =>
      'Qubble nezobrazuje vynútené reklamy — nikdy nemusíš nič kupovať. Balíček podporovateľa (motív Polárna žiara, vzhľad Kryštál, 1 500 mincí, odznak podporovateľa) je poďakovanie za podporu hry. Nákupy sú viazané na tvoj účet v obchode a dajú sa kedykoľvek obnoviť.';

  @override
  String get shopSupporterContents =>
      'Motív Polárna žiara + vzhľad Kryštál + 1 500 mincí';

  @override
  String get themesTitle => 'Motívy';

  @override
  String get themesSupporterOnly =>
      'Len v balíčku podporovateľa (pozri obchod)';

  @override
  String get themesInSupporterPack => 'V balíčku podporovateľa';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Málo mincí (treba $cost, máš $coins)';
  }

  @override
  String get skinsTitle => 'Vzhľady kociek';

  @override
  String get skinsNotEnoughDiamonds => 'Málo diamantov (zameň zlato nižšie)';

  @override
  String get skinsNotEnoughCoins => 'Málo mincí';

  @override
  String get skinsNotEnoughGold => 'Málo zlata.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold zlata = 1 diamant. Diamanty odomykajú najkrajšie vzhľady — zbieraj v pokoji.';
  }

  @override
  String get statsTitle => 'Štatistiky';

  @override
  String get statsAverageScore => 'Priem. skóre';

  @override
  String get statsBestCombo => 'Najlepšie kombo';

  @override
  String get statsGames => 'Hry';

  @override
  String get statsLinesCleared => 'Zmazané rady';

  @override
  String get statsPiecesPlaced => 'Položené dieliky';

  @override
  String get statsCoins => 'Mince';

  @override
  String get missionsTitle => 'Misie';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString dielikov',
      few: '$countString dieliky',
      one: '$countString dielik',
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
      other: '$countString radov',
      few: '$countString rady',
      one: '$countString rad',
    );
    return 'Zmaž $_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Dosiahni kombo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString bodov',
      few: '$countString body',
      one: '$countString bod',
    );
    return 'Prekonaj $_temp0 v jednej hre';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString hier',
      few: '$countString hry',
      one: '$countString hru',
    );
    return 'Zahraj $_temp0';
  }

  @override
  String get achievementsTitle => 'Úspechy';

  @override
  String get achievementFirstGameTitle => 'Prvá hra';

  @override
  String get achievementFirstGameBody => 'Zahraj svoju prvú hru';

  @override
  String get achievementGames25Title => 'Štamgast';

  @override
  String get achievementGames25Body => 'Zahraj 25 hier';

  @override
  String get achievementGames100Title => 'Závislák';

  @override
  String get achievementGames100Body => 'Zahraj 100 hier';

  @override
  String get achievementScore1kTitle => 'Horolezec';

  @override
  String get achievementScore1kBody => 'Dosiahni 1 000 bodov';

  @override
  String get achievementScore5kTitle => 'Profík';

  @override
  String get achievementScore5kBody => 'Dosiahni 5 000 bodov';

  @override
  String get achievementScore10kTitle => 'Majster';

  @override
  String get achievementScore10kBody => 'Dosiahni 10 000 bodov';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Dosiahni 25 000 bodov';

  @override
  String get achievementLines100Title => 'Poriadkumilovný';

  @override
  String get achievementLines100Body => 'Zmaž celkovo 100 radov';

  @override
  String get achievementLines1000Title => 'Veľké upratovanie';

  @override
  String get achievementLines1000Body => 'Zmaž celkovo 1 000 radov';

  @override
  String get achievementCombo5Title => 'Kombo nováčik';

  @override
  String get achievementCombo5Body => 'Dosiahni kombo x5';

  @override
  String get achievementCombo10Title => 'Kombo kráľ';

  @override
  String get achievementCombo10Body => 'Dosiahni kombo x10';

  @override
  String get achievementLevel10Title => 'Skúsený';

  @override
  String get achievementLevel10Body => 'Dosiahni úroveň 10';

  @override
  String get achievementLevel20Title => 'Veterán';

  @override
  String get achievementLevel20Body => 'Dosiahni úroveň 20';

  @override
  String get achievementStreak7Title => 'Celý týždeň';

  @override
  String get achievementStreak7Body => 'Denná séria 7 dní';

  @override
  String get achievementStreak30Title => 'Celý mesiac';

  @override
  String get achievementStreak30Body => 'Denná séria 30 dní';

  @override
  String get achievementPuzzles10Title => 'Lúštiteľ';

  @override
  String get achievementPuzzles10Body => 'Vyrieš 10 hádaniek';

  @override
  String get achievementPieces5000Title => 'Staviteľ';

  @override
  String get achievementPieces5000Body => 'Polož 5 000 dielikov';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak dní',
      few: '$streak dni',
      one: '$streak deň',
    );
    return 'Séria v ohrození: $_temp0!';
  }

  @override
  String get streakRepairBody => 'Včera sa nehralo — zachráň svoju sériu:';

  @override
  String get streakRepairFailed => 'Oprava nie je možná.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins mincí',
      few: '$coins mince',
      one: '$coins minca',
    );
    return 'Vitaj späť! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Pripomienky?';

  @override
  String get notificationsOptInBody =>
      'Máme ti pripomínať dennú hádanku a chrániť tvoju sériu? V nastaveniach to môžeš kedykoľvek zmeniť.';

  @override
  String get notificationsOptInAccept => 'Áno, prosím';

  @override
  String get notificationChannelDescription =>
      'Denná pripomienka, upozornenie na koniec série, pozvánka späť';

  @override
  String get notificationDailyTitle => 'Tvoja denná hádanka čaká 🧩';

  @override
  String get notificationDailyBody => 'Zahraj si dnešnú výzvu!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak dní',
      few: '$streak dni',
      one: '$streak deň',
    );
    return '🔥 Séria v ohrození: $_temp0!';
  }

  @override
  String get notificationStreakBody => 'Zahraj si dnes a udržíš ju.';

  @override
  String get notificationComebackTitle => 'Tvojej hádanke sa za tebou cnie 🧩';

  @override
  String get notificationComebackBody => 'Vráť sa a vyzdvihni si darček!';

  @override
  String get iapSupporterPack => 'Balíček podporovateľa';

  @override
  String get iapCoinsSmall => '500 mincí';

  @override
  String get iapCoinsMedium => '2 000 mincí';

  @override
  String get iapCoinsLarge => '6 000 mincí';

  @override
  String get iapStarterPack => 'Štartovací balíček';

  @override
  String get iapRename => 'Zmena mena';

  @override
  String get iapNeonTheme => 'Motív Neón';

  @override
  String get settingsLeaderboardDelete => 'Vymazať záznam v rebríčku';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Odstráni tvoje meno a skóre z verejného zoznamu';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Vymazať tvoj záznam?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tvoje meno a skóre budú z rebríčka odstránené. Postup v hre zostane bez zmeny. Do rebríčka sa môžeš kedykoľvek znova zapísať.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Tvoj záznam v rebríčku bol vymazaný.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Záznam sa nepodarilo vymazať. Skontroluj pripojenie a skús to znova.';

  @override
  String get leaderboardReport => 'Nahlásiť toto meno';

  @override
  String get leaderboardBlock => 'Blokovať';

  @override
  String leaderboardBlocked(String name) {
    return '$name je pre teba skryté';
  }

  @override
  String get leaderboardUndo => 'Späť';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Skrytých $count záznamov',
      few: 'Skryté $count záznamy',
      one: 'Skrytý $count záznam',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Znova zobraziť';

  @override
  String get leaderboardReportUnavailable =>
      'Nahlásenie teraz nie je dostupné.';

  @override
  String get leaderboardReportSent => 'Vďaka — hlásenie je na ceste.';

  @override
  String get leaderboardRules =>
      'Mená sú verejné. Žiadne urážky, žiadne nadávky a nič, čo by identifikovalo skutočnú osobu. Mená, ktoré pravidlá porušujú, sa odstraňujú.';

  @override
  String get leaderboardRulesAccept => 'Rozumiem';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Odomknuté $unlocked z $total';
  }

  @override
  String get settingsSectionData => 'Uložené dáta';

  @override
  String get gameRotatePiece => 'Otočiť dielik';

  @override
  String get themeClassic => 'Klasika';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neón';

  @override
  String get themeOcean => 'Oceán';

  @override
  String get themeWood => 'Drevo';

  @override
  String get themeSunset => 'Západ slnka';

  @override
  String get themeForest => 'Les';

  @override
  String get themeAurora => 'Polárna žiara';

  @override
  String get skinClassic => 'Klasika';

  @override
  String get skinGradient => 'Prechod';

  @override
  String get skinOutline => 'Obrys';

  @override
  String get skinGlossy => 'Lesk';

  @override
  String get skinStripe => 'Prúžky';

  @override
  String get skinBevel => 'Skosenie';

  @override
  String get skinGlow => 'Žiara';

  @override
  String get skinCrystal => 'Kryštál';

  @override
  String rewardThemeName(String name) {
    return 'Motív $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Vzhľad $name';
  }
}
