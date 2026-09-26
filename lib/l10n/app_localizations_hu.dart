// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class L10nHu extends L10n {
  L10nHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Játék';

  @override
  String get commonLater => 'Később';

  @override
  String get commonNotNow => 'Most nem';

  @override
  String get commonCancel => 'Mégse';

  @override
  String get commonBuy => 'Vásárlás';

  @override
  String get commonSave => 'Mentés';

  @override
  String get commonCollect => 'Begyűjtés';

  @override
  String get nameNewName => 'Új név';

  @override
  String get nameFieldLabel => 'Név';

  @override
  String get piggyFullTitle => 'Megtelt a malacpersely!';

  @override
  String get piggyKeepSaving => 'Gyűjts tovább';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity összegyűlt.';
  }

  @override
  String get homeContinueRun => 'Folytatás';

  @override
  String get homeVideo => 'Videó';

  @override
  String get commonGotIt => 'Értem';

  @override
  String get commonHome => 'Főmenü';

  @override
  String get commonScore => 'PONT';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return '$level. szint';
  }

  @override
  String get homeNewRun => 'Új játék indítása';

  @override
  String get homeBackToExit => 'A kilépéshez nyomd meg újra a Vissza gombot';

  @override
  String get homeEnableLeaderboard => 'Csatlakozz a ranglistához';

  @override
  String get homeBestScore => 'LEGJOBB PONTSZÁM';

  @override
  String get homeDailyChallenge => 'Napi kihívás';

  @override
  String get homeDailyOpenToday => 'Ma még nyitott';

  @override
  String homeDailyNextIn(String time) {
    return 'Következő napi kihívás: $time múlva';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak napos sorozat';
  }

  @override
  String get homeLeaderboard => 'Ranglista';

  @override
  String get homePuzzleMode => 'Rejtvénymód';

  @override
  String get homeMissions => 'Küldetések';

  @override
  String get homeThemes => 'Témák';

  @override
  String get homeSkins => 'Kinézetek';

  @override
  String get homeHowToPlay => 'A Qubble szabályai';

  @override
  String get homeWeekendBonus => 'Hétvége: dupla érme!';

  @override
  String homeNextUnlock(int level, String name) {
    return '$level. szint: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Névváltoztatás';

  @override
  String get nameChangeExplainer =>
      'A neved azonosít a ranglistán, ezért nem változtatható. Egyszeri névváltoztatást vásárolhatsz.';

  @override
  String get nameChangeAfterPurchase =>
      'A vásárlás után koppints újra a nevedre, és változtasd meg.';

  @override
  String get nameJoinedLeaderboard => 'Mostantól szerepelsz a ranglistán.';

  @override
  String get nameRenameUnavailable => 'Az átnevezés most nem lehetséges.';

  @override
  String nameProblemTooShort(int min) {
    return 'Legalább $min karakter.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Legfeljebb $max karakter.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Csak ékezet nélküli betűk (A–Z), számjegyek, szóközök, _ és -.';

  @override
  String get nameProblemOffensive => 'Kérlek, válassz másik nevet.';

  @override
  String get piggyTitle => 'Malacpersely';

  @override
  String get piggyFillingHint =>
      'A malacpersely telik, miközben sorokat tüntetsz el.';

  @override
  String piggyCollect(int coins) {
    return '$coins érme begyűjtése — ingyen.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Ha megtelt, ingyen kiürítheted — vagy korábban is kinyithatod egy bónuszvideóval.';

  @override
  String get piggyOpenNow => 'Kinyitás most';

  @override
  String get gameNewPiecesVideo => 'Új elemek (videó)';

  @override
  String get gameTapBoardCell => 'Koppints egy mezőre a táblán';

  @override
  String get gameDailyChallengeLabel => 'NAPI KIHÍVÁS';

  @override
  String get gameOver => 'Vége a játéknak';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'A bombához még $missing érme kell.';
  }

  @override
  String get gameBombNotHere => 'A bomba itt most nem működik.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Ehhez még $missing érme kell.';
  }

  @override
  String get gameNotRightNow => 'Ez most nem lehetséges.';

  @override
  String get gameRunSaved => 'Játék mentve — „Folytatás” a menüben.';

  @override
  String get gameOverNoFit => 'Egyik elemed sem fér már el a táblán.';

  @override
  String get gameOverNoFitNoRotations =>
      'Egyik elemed sem fér el — és a forgatások elfogytak.';

  @override
  String get gameStarterOfferUnavailable => 'Most nem elérhető';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — megveszem';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBÓ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Eredmény: $title';
  }

  @override
  String get gameBestSubmitted => 'Új rekord — beküldve';

  @override
  String get gameReviveFor => 'Tovább játszom · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Feloldva: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Kezdőcsomag';

  @override
  String gameOverPoints(int score) {
    return '$score pont';
  }

  @override
  String get gameNewRecord => 'Új rekord!';

  @override
  String gameStreakDays(int streak) {
    return '$streak napos sorozat';
  }

  @override
  String get gameDoubleCoins => 'Dupla érme';

  @override
  String get gameDoubleDaily => 'Dupla napi jutalom';

  @override
  String get gamePlayAgain => 'Még egy kör';

  @override
  String gameLevelReached(int level) {
    return 'Szintlépés: $level. szint!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count szintet léptél — $level. szint!';
  }

  @override
  String get gameStarterOfferReward => '1200 érme + Fa téma';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Már csak $hours óra — egyszeri ajánlat!';
  }

  @override
  String get boosterUndo => 'Vissza';

  @override
  String get boosterSwap => 'Csere';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Nincs több forgatás — tüntess el sorokat az újratöltéshez!';

  @override
  String get onboardingDragPiece => 'Húzz egy elemet a rácsra';

  @override
  String get onboardingFillLine => 'Tölts ki egy teljes sort vagy oszlopot';

  @override
  String get onboardingLinesClear => 'A teli sorok eltűnnek — pontok!';

  @override
  String get coachHintCombo =>
      'Kombó! Tüntess el újra 3 lépésen belül, hogy megmaradjon';

  @override
  String get coachHintFever => 'LÁZ! Dupla pont, amíg világít';

  @override
  String get coachHintRotation =>
      'A forgatás egy töltésbe kerül — az eltüntetés újratölti';

  @override
  String get coachHintBooster => 'Tipp: lent erősítőket is használhatsz';

  @override
  String get coachHintStrategy =>
      'Tipp: ne mindent egyszerre — hagyj helyet a nagy elemeknek';

  @override
  String get dailyStreakLabel => 'Sorozat';

  @override
  String get dailyBestLabel => 'Napi rekord';

  @override
  String dailyHistoryNote(int days) {
    return 'Az utolsó $days nap marad meg.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: lejátszva';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: kimaradt';
  }

  @override
  String get homeDailyCalendar => 'Naptár';

  @override
  String get dailyShareButton => 'Eredmény megosztása';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Napi kihívás $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score pont · legjobb kombó x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Játssz te is: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombó: még $moves lépés';
  }

  @override
  String get dailyShareCopied => 'Eredmény a vágólapra másolva';

  @override
  String get adNotAvailable =>
      'Most nincs elérhető videó — próbáld újra egy kicsit később';

  @override
  String get howToPlaySpeedTitle => 'Gyorsasági bónusz';

  @override
  String get howToPlaySpeedBody =>
      'A gyors lerakás akár 30%-kal növelheti egy eltüntetés pontértékét. A bónusz 1,5 és 4 másodperc között fokozatosan csökken, és felső határa van: a gyorsaság kifizetődik, de nem dönti el a játékot — egy megfontolt, lassú kör még mindig legyőzheti az elkapkodott gyorsat.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Gyorsasági bónusz: $percent százalék';
  }

  @override
  String get iapDiamondsSmall => '100 gyémánt';

  @override
  String get iapDiamondsMedium => '350 gyémánt';

  @override
  String get iapDiamondsLarge => '1000 gyémánt';

  @override
  String get howToPlayTitle => 'A Qubble szabályai';

  @override
  String get howToPlayIntroHeadline =>
      'Könnyű elkezdeni.\nA tervezés kifizetődik.';

  @override
  String get howToPlayIntroBody =>
      'Tartsd szabadon a táblát, és döntsd meg a rekordodat.';

  @override
  String get howToPlayIntroSemantics =>
      'A játék célja. Tartsd szabadon a táblát, és döntsd meg a rekordodat.';

  @override
  String get howToPlayDragTitle => 'Húzd és tedd le';

  @override
  String get howToPlayDragBody =>
      'Húzd a három elem egyikét szabad mezőkre. Ha mindhármat leraktad, automatikusan kapsz három újat.';

  @override
  String get howToPlayClearTitle => 'Sorok eltüntetése';

  @override
  String get howToPlayClearBody =>
      'Tölts ki egy teljes sort vagy oszlopot. A teli sorok eltűnnek, és helyet adnak a következő lépésednek.';

  @override
  String get howToPlayComboTitle => 'Kombók láncolása';

  @override
  String get howToPlayComboBody =>
      'Tüntess el újabb sort három lépésen belül. Minden további kombó növeli a pontszorzódat. A kombó lépéseket számol, nem másodperceket, így nem jár le, amíg gondolkodsz.';

  @override
  String get howToPlayFeverTitle => 'Láz beindítása';

  @override
  String get howToPlayFeverBody =>
      'Az eltüntetések töltik a lázmérőt. Ha megtelt, a következő sorozat duplán számít — tervezd meg előre a nagy eltüntetéseket.';

  @override
  String get howToPlayBoosterTitle => 'Erősítők okosan';

  @override
  String get howToPlayBoosterBody =>
      'Az erősítők kimentenek a szorult helyzetekből. Ha a tálcán egy elemre koppintasz, el is forgathatod.';

  @override
  String get howToPlayDailyTitle => 'Napi kihívás és sorozat';

  @override
  String get howToPlayDailyBody =>
      'A napi kihívásban mindenki ugyanazokat az elemeket kapja. Játssz minden nap, hogy nőjön a sorozatod és a bónuszod.';

  @override
  String get howToPlayPiggyTitle => 'Töltsd meg a malacperselyt';

  @override
  String get howToPlayPiggyBody =>
      'Minden eltüntetett sor tölti a malacperselyedet. Ha megtelt, ingyen begyűjtheted az érméket.';

  @override
  String get leaderboardTitle => 'Ranglista';

  @override
  String get leaderboardUnreachable =>
      'A ranglista nem érhető el.\nPróbáld újra internetkapcsolattal.';

  @override
  String get leaderboardEmpty => 'Még nincs bejegyzés.\nLegyél te az első!';

  @override
  String leaderboardSubmitting(int score) {
    return 'A legjobb pontszámod ($score) beküldése folyamatban …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'A legjobb pontszámodat automatikusan beküldjük.';

  @override
  String get puzzleModeTitle => 'Rejtvénymód';

  @override
  String puzzleLevelTitle(int level) {
    return '$level. rejtvény';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Lépések: $moves   •   3 csillaghoz: $target';
  }

  @override
  String get puzzleSolved => 'Megoldva!';

  @override
  String get puzzleLeaveTitle => 'Kilépsz a rejtvényből?';

  @override
  String get puzzleLeaveBody =>
      'Az ebben a rejtvényben elért haladásod elvész.';

  @override
  String get puzzleKeepPlaying => 'Folytatom';

  @override
  String get puzzleLeave => 'Kilépés';

  @override
  String get puzzleStuckTitle => 'Elakadtál';

  @override
  String get puzzleRestart => 'Újrakezdés';

  @override
  String get commonActive => 'Aktív';

  @override
  String get commonTapToActivate => 'Koppints az aktiváláshoz';

  @override
  String get commonRestore => 'Visszaállítás';

  @override
  String unlockForCost(int cost) {
    return 'Feloldás: $cost';
  }

  @override
  String get skinsExchangeGold => 'Arany beváltása';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Elem forgatása';

  @override
  String get puzzleNextLevel => 'Következő szint';

  @override
  String get puzzleBackToOverview => 'Vissza az áttekintéshez';

  @override
  String get puzzleUnsolvable => 'Innen már nem lehet kiüríteni a táblát.';

  @override
  String get puzzleExtraMoveVideo => 'Extra lépés (videó)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved megoldva';
  }

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get storageFailureTitle =>
      'A Qubble nem tudja betölteni a mentett játékot';

  @override
  String get storageFailureBody =>
      'Kérlek, indítsd újra az alkalmazást. Ha a hiba továbbra is fennáll, csak az újratelepítés segít. A Beállítások › Visszajelzés menüpontban jelentheted.';

  @override
  String get iapUnavailable => 'Ez az ajánlat most nem érhető el.';

  @override
  String get iapFailed => 'A vásárlás nem sikerült. Semmit nem terheltünk meg.';

  @override
  String get settingsResetProgress => 'Haladás visszaállítása';

  @override
  String get settingsResetProgressSubtitle =>
      'Pontszám, érmék, szint és haladás vissza az elejére. A vásárlások, a név és a kozmetikai elemek megmaradnak.';

  @override
  String get settingsResetConfirmTitle => 'Visszaállítod a haladást?';

  @override
  String get settingsResetConfirmBody =>
      'A legjobb pontszám, az érmék, a szint, a sorozat és minden haladás törlődik. Ez nem vonható vissza.\n\nA vásárlásaid, a neved, valamint a feloldott témák és kinézetek megmaradnak.';

  @override
  String get settingsResetConfirmAction => 'Visszaállítás';

  @override
  String get settingsResetDone => 'Haladás visszaállítva.';

  @override
  String get settingsSectionGame => 'Játék';

  @override
  String get settingsSectionSoundHaptics => 'Hang és rezgés';

  @override
  String get settingsSectionReminders => 'Emlékeztetők';

  @override
  String get settingsSectionPurchases => 'Vásárlások';

  @override
  String get settingsSectionHelpOut => 'Segíts nekünk';

  @override
  String get settingsSectionLegal => 'Jogi információk';

  @override
  String get settingsSectionLanguage => 'Nyelv';

  @override
  String get settingsGuide => 'Játékszabályok';

  @override
  String get settingsGuideSubtitle => 'Szabályok, kombók, láz és erősítők';

  @override
  String get settingsSound => 'Hang';

  @override
  String get settingsMusic => 'Zene';

  @override
  String get settingsHaptics => 'Rezgés';

  @override
  String get settingsHapticsOff => 'Ki';

  @override
  String get settingsHapticsLight => 'Gyenge';

  @override
  String get settingsHapticsStrong => 'Erős';

  @override
  String get settingsSectionAccessibility => 'Kényelem';

  @override
  String get settingsReducedEffects => 'Kevesebb effekt';

  @override
  String get settingsReducedEffectsHint =>
      'Kevesebb részecske, nincs képernyőrázás, nincs ragyogás';

  @override
  String get settingsNotifications => 'Értesítések';

  @override
  String get settingsNotificationsSubtitle =>
      'Napi emlékeztető és sorozatvédelem';

  @override
  String get settingsNotificationsSystemHint =>
      'Engedélyezd a rendszerbeállításokban.';

  @override
  String get settingsLanguageSystem => 'Rendszernyelv';

  @override
  String get settingsSupporterThanks => 'Támogató — köszönjük!';

  @override
  String get settingsSupporterPack => 'Támogatói csomag';

  @override
  String get settingsSupporterPackSubtitle =>
      'Exkluzív téma és kinézet + 1500 érme';

  @override
  String get settingsRestorePurchases => 'Vásárlások visszaállítása';

  @override
  String get settingsRestoring => 'Vásárlások visszaállítása…';

  @override
  String get settingsRateApp => 'Értékeld az alkalmazást';

  @override
  String get settingsRateAppSubtitle => 'Hagyj értékelést az áruházban';

  @override
  String get settingsStoreUnavailable =>
      'Az áruház nem érhető el ezen az eszközön.';

  @override
  String get settingsFeedback => 'Visszajelzés küldése';

  @override
  String get settingsFeedbackSubtitle =>
      'Ötletek és hibák jelentése (GitHubon)';

  @override
  String get settingsAdPrivacy => 'Hirdetési adatvédelem';

  @override
  String get settingsAdPrivacySubtitle =>
      'Hirdetési hozzájárulás megtekintése vagy módosítása';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Ezen az eszközön nincs szükség hirdetési beállításokra.';

  @override
  String get settingsPrivacy => 'Adatvédelmi tájékoztató';

  @override
  String get settingsImprint => 'Impresszum';

  @override
  String get settingsPageOpenFailed => 'Az oldalt nem sikerült megnyitni.';

  @override
  String get settingsFooter => 'Qubble • Offline blokkos kirakós';

  @override
  String get settingsAdminSection => 'Admin (teszt)';

  @override
  String get settingsAdminEnabled => 'Admin mód bekapcsolva';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Még $count koppintás az admin módhoz';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins érme';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Csak teszteléshez — soha ne legyen kiadási képernyőképen';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount érme';
  }

  @override
  String get settingsAdminResetCoins => 'Érmék nullázása';

  @override
  String get feedbackTitle => 'Visszajelzés';

  @override
  String get feedbackIntroShort =>
      'Mi tetszik, mi zavar, mi hiányzik? Az apróságok is segítenek — minél konkrétabb, annál jobb.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Csak ezt csatolom: $build, valamint a készüléked típusát — hogy tudjam, melyik buildről van szó.';
  }

  @override
  String get feedbackSendByMail => 'Küldés e-mailben';

  @override
  String get feedbackPreferGithub => 'Inkább GitHub-issue';

  @override
  String get feedbackThanksMail => 'Köszönöm! Már csak küldd el az üzenetet.';

  @override
  String get feedbackNoMailApp =>
      'Nem található levelezőalkalmazás. Próbáld a lenti GitHub-utat.';

  @override
  String get feedbackEmptyHint => 'Előbb írj valamit.';

  @override
  String get leaderboardRefresh => 'Frissítés';

  @override
  String get leaderboardRetry => 'Újra';

  @override
  String get feedbackHint => 'A visszajelzésed…';

  @override
  String get feedbackSubmit => 'Visszajelzés küldése';

  @override
  String get feedbackOpenFailed =>
      'A GitHubot nem sikerült megnyitni. Próbáld újra később.';

  @override
  String get feedbackGithubNote =>
      'Megnyílik a GitHub — ott koppints a „Submit new issue” gombra. (Egyszeri GitHub-bejelentkezés szükséges.)';

  @override
  String get shopTitle => 'Bolt';

  @override
  String get shopWebDemoNote =>
      'Vásárolni csak a Play Áruházból telepített alkalmazásban lehet. Ez a webes verzió ingyenes demó — itt is végig játszhatsz vele.';

  @override
  String get shopSupporterExplainer =>
      'A Qubble nem mutat kényszerített reklámot — soha semmit nem kell megvenned. A támogatói csomag (Aurora téma, Kristály kinézet, 1500 érme, támogatói jelvény) köszönet a játék támogatásáért. A vásárlások az áruházfiókodhoz kötődnek, és bármikor visszaállíthatók.';

  @override
  String get shopSupporterContents =>
      'Aurora téma + Kristály kinézet + 1500 érme';

  @override
  String get themesTitle => 'Témák';

  @override
  String get themesSupporterOnly => 'Csak a támogatói csomagban (lásd: Bolt)';

  @override
  String get themesInSupporterPack => 'A támogatói csomagban';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Nincs elég érméd ($cost kell, $coins van)';
  }

  @override
  String get skinsTitle => 'Blokk-kinézetek';

  @override
  String get skinsNotEnoughDiamonds =>
      'Nincs elég gyémántod (lent aranyat válthatsz be)';

  @override
  String get skinsNotEnoughCoins => 'Nincs elég érméd';

  @override
  String get skinsNotEnoughGold => 'Nincs elég aranyad.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold arany = 1 gyémánt. A gyémántokkal a legszebb kinézeteket oldhatod fel — gyűjtsd őket nyugodtan.';
  }

  @override
  String get statsTitle => 'Statisztika';

  @override
  String get statsAverageScore => 'Átlagpontszám';

  @override
  String get statsBestCombo => 'Legjobb kombó';

  @override
  String get statsGames => 'Játékok';

  @override
  String get statsLinesCleared => 'Eltüntetett sorok';

  @override
  String get statsPiecesPlaced => 'Lerakott elemek';

  @override
  String get statsCoins => 'Érmék';

  @override
  String get missionsTitle => 'Küldetések';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Rakj le $countString elemet';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Tüntess el $countString sort';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Érj el ${countString}x kombót';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Szerezz $countString pontot egy körben';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Játssz $countString kört';
  }

  @override
  String get achievementsTitle => 'Eredmények';

  @override
  String get achievementFirstGameTitle => 'Első kör';

  @override
  String get achievementFirstGameBody => 'Játszd le az első körödet';

  @override
  String get achievementGames25Title => 'Törzsjátékos';

  @override
  String get achievementGames25Body => 'Játssz 25 kört';

  @override
  String get achievementGames100Title => 'Rákattantál';

  @override
  String get achievementGames100Body => 'Játssz 100 kört';

  @override
  String get achievementScore1kTitle => 'Feltörekvő';

  @override
  String get achievementScore1kBody => 'Érj el 1000 pontot';

  @override
  String get achievementScore5kTitle => 'Profi';

  @override
  String get achievementScore5kBody => 'Érj el 5000 pontot';

  @override
  String get achievementScore10kTitle => 'Mester';

  @override
  String get achievementScore10kBody => 'Érj el 10 000 pontot';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Érj el 25 000 pontot';

  @override
  String get achievementLines100Title => 'Rendrakó';

  @override
  String get achievementLines100Body => 'Tüntess el összesen 100 sort';

  @override
  String get achievementLines1000Title => 'Nagytakarító';

  @override
  String get achievementLines1000Body => 'Tüntess el összesen 1000 sort';

  @override
  String get achievementCombo5Title => 'Kombókezdő';

  @override
  String get achievementCombo5Body => 'Érj el 5x kombót';

  @override
  String get achievementCombo10Title => 'Kombókirály';

  @override
  String get achievementCombo10Body => 'Érj el 10x kombót';

  @override
  String get achievementLevel10Title => 'Tapasztalt';

  @override
  String get achievementLevel10Body => 'Érd el a 10. szintet';

  @override
  String get achievementLevel20Title => 'Veterán';

  @override
  String get achievementLevel20Body => 'Érd el a 20. szintet';

  @override
  String get achievementStreak7Title => 'Heti sorozat';

  @override
  String get achievementStreak7Body => '7 napos napi sorozat';

  @override
  String get achievementStreak30Title => 'Havi sorozat';

  @override
  String get achievementStreak30Body => '30 napos napi sorozat';

  @override
  String get achievementPuzzles10Title => 'Rejtvényfejtő';

  @override
  String get achievementPuzzles10Body => 'Oldj meg 10 rejtvényt';

  @override
  String get achievementPieces5000Title => 'Építő';

  @override
  String get achievementPieces5000Body => 'Rakj le 5000 elemet';

  @override
  String streakRepairTitle(int streak) {
    return '$streak napos sorozatod veszélyben!';
  }

  @override
  String get streakRepairBody => 'Tegnap kihagytad — mentsd meg a sorozatodat:';

  @override
  String get streakRepairFailed => 'A javítás nem lehetséges.';

  @override
  String comebackGift(int coins) {
    return 'Üdv újra! +$coins érme';
  }

  @override
  String get notificationsOptInTitle => 'Emlékeztetők?';

  @override
  String get notificationsOptInBody =>
      'Emlékeztessünk a napi rejtvényedre, és védjük a sorozatodat? Ezt bármikor módosíthatod a beállításokban.';

  @override
  String get notificationsOptInAccept => 'Igen, kérem';

  @override
  String get notificationChannelDescription =>
      'Napi emlékeztető, sorozatfigyelmeztetés, visszahívás';

  @override
  String get notificationDailyTitle => 'Vár a napi rejtvényed 🧩';

  @override
  String get notificationDailyBody => 'Játszd le a mai kihívást!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak napos sorozatod veszélyben!';
  }

  @override
  String get notificationStreakBody => 'Játssz ma, hogy megmaradjon.';

  @override
  String get notificationComebackTitle => 'Hiányzol a rejtvényednek 🧩';

  @override
  String get notificationComebackBody =>
      'Gyere vissza, és vedd át az ajándékodat!';

  @override
  String get iapSupporterPack => 'Támogatói csomag';

  @override
  String get iapCoinsSmall => '500 érme';

  @override
  String get iapCoinsMedium => '2000 érme';

  @override
  String get iapCoinsLarge => '6000 érme';

  @override
  String get iapStarterPack => 'Kezdőcsomag';

  @override
  String get iapRename => 'Névváltoztatás';

  @override
  String get iapNeonTheme => 'Neon téma';

  @override
  String get settingsLeaderboardDelete => 'Ranglista-bejegyzés törlése';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Eltávolítja a neved és a pontszámod a nyilvános listáról';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Törlöd a bejegyzésedet?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'A neved és a pontszámod lekerül a ranglistáról. A játékbeli haladásod érintetlen marad. Bármikor újra felkerülhetsz a ranglistára.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'A ranglista-bejegyzésedet töröltük.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'A bejegyzést nem sikerült törölni. Ellenőrizd a kapcsolatot, és próbáld újra.';

  @override
  String get leaderboardReport => 'Név jelentése';

  @override
  String get leaderboardBlock => 'Elrejtés';

  @override
  String leaderboardBlocked(String name) {
    return '$name el van rejtve előled';
  }

  @override
  String get leaderboardUndo => 'Visszavonás';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Általad elrejtett bejegyzések: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Mutasd újra';

  @override
  String get leaderboardReportUnavailable => 'A jelentés most nem érhető el.';

  @override
  String get leaderboardReportSent => 'Köszönjük — a jelentésed úton van.';

  @override
  String get leaderboardRules =>
      'A nevek nyilvánosak. Semmi sértegetés, semmi gyalázkodás, és semmi, ami valódi személyt azonosít. Az ezt megsértő neveket eltávolítjuk.';

  @override
  String get leaderboardRulesAccept => 'Értem';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked / $total feloldva';
  }

  @override
  String get settingsSectionData => 'Mentett adatok';

  @override
  String get gameRotatePiece => 'Elem forgatása';

  @override
  String get themeClassic => 'Klasszikus';

  @override
  String get themeFade => 'Pasztell';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Óceán';

  @override
  String get themeWood => 'Fa';

  @override
  String get themeSunset => 'Naplemente';

  @override
  String get themeForest => 'Erdő';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasszikus';

  @override
  String get skinGradient => 'Színátmenet';

  @override
  String get skinOutline => 'Körvonal';

  @override
  String get skinGlossy => 'Fényes';

  @override
  String get skinStripe => 'Csíkos';

  @override
  String get skinBevel => 'Domború';

  @override
  String get skinGlow => 'Ragyogó';

  @override
  String get skinCrystal => 'Kristály';

  @override
  String rewardThemeName(String name) {
    return '$name téma';
  }

  @override
  String rewardSkinName(String name) {
    return '$name kinézet';
  }
}
