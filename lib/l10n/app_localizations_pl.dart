// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class L10nPl extends L10n {
  L10nPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Graj';

  @override
  String get commonLater => 'Później';

  @override
  String get commonNotNow => 'Nie teraz';

  @override
  String get commonCancel => 'Anuluj';

  @override
  String get commonBuy => 'Kup';

  @override
  String get commonSave => 'Zapisz';

  @override
  String get commonCollect => 'Odbierz';

  @override
  String get nameNewName => 'Nowa nazwa';

  @override
  String get nameFieldLabel => 'Nazwa';

  @override
  String get piggyFullTitle => 'Skarbonka jest pełna!';

  @override
  String get piggyKeepSaving => 'Oszczędzaj dalej';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Zebrano $coins z $capacity.';
  }

  @override
  String get homeContinueRun => 'Kontynuuj';

  @override
  String get homeVideo => 'Wideo';

  @override
  String get commonGotIt => 'Rozumiem';

  @override
  String get commonHome => 'Menu główne';

  @override
  String get commonScore => 'WYNIK';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Poziom $level';
  }

  @override
  String get homeNewRun => 'Zacznij nową grę';

  @override
  String get homeBackToExit => 'Naciśnij wstecz jeszcze raz, aby wyjść';

  @override
  String get homeEnableLeaderboard => 'Dołącz do rankingu';

  @override
  String get homeBestScore => 'REKORD';

  @override
  String get homeDailyChallenge => 'Wyzwanie dnia';

  @override
  String get homeDailyOpenToday => 'Czeka na dziś';

  @override
  String homeDailyNextIn(String time) {
    return 'Następne wyzwanie za $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'dni',
      one: 'dzień',
    );
    return 'Seria: $streak $_temp0';
  }

  @override
  String get homeLeaderboard => 'Ranking';

  @override
  String get homePuzzleMode => 'Tryb łamigłówek';

  @override
  String get homeMissions => 'Misje';

  @override
  String get homeThemes => 'Motywy';

  @override
  String get homeSkins => 'Skórki';

  @override
  String get homeHowToPlay => 'Jak grać w Qubble';

  @override
  String get homeWeekendBonus => 'Weekend: podwójne monety!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Poziom $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Zmień nazwę';

  @override
  String get nameChangeExplainer =>
      'Twoja nazwa to twoja tożsamość w rankingu, dlatego jest stała. Możesz kupić jednorazową zmianę nazwy.';

  @override
  String get nameChangeAfterPurchase =>
      'Po zakupie dotknij swojej nazwy jeszcze raz, aby ją zmienić.';

  @override
  String get nameJoinedLeaderboard => 'Jesteś teraz w rankingu.';

  @override
  String get nameRenameUnavailable => 'Zmiana nazwy jest teraz niemożliwa.';

  @override
  String nameProblemTooShort(int min) {
    return 'Co najmniej $min znaki.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Najwyżej $max znaków.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Tylko litery bez polskich znaków (A–Z), cyfry, spacje, _ i -.';

  @override
  String get nameProblemOffensive => 'Wybierz inną nazwę.';

  @override
  String get piggyTitle => 'Skarbonka';

  @override
  String get piggyFillingHint => 'Skarbonka napełnia się, gdy czyścisz rzędy.';

  @override
  String piggyCollect(int coins) {
    return 'Odbierz monety: $coins — za darmo.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Gdy będzie pełna, opróżnisz ją za darmo — albo otworzysz ją wcześniej dzięki filmikowi z bonusem.';

  @override
  String get piggyOpenNow => 'Otwórz teraz';

  @override
  String get gameNewPiecesVideo => 'Nowe klocki (wideo)';

  @override
  String get gameTapBoardCell => 'Dotknij pola na planszy';

  @override
  String get gameDailyChallengeLabel => 'WYZWANIE DNIA';

  @override
  String get gameOver => 'Koniec gry';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Do bomby brakuje ci monet: $missing.';
  }

  @override
  String get gameBombNotHere => 'Bomby nie da się teraz tu użyć.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Brakuje ci monet: $missing.';
  }

  @override
  String get gameNotRightNow => 'Teraz to niemożliwe.';

  @override
  String get gameRunSaved => 'Gra zapisana — „Kontynuuj” w menu.';

  @override
  String get gameOverNoFit =>
      'Żaden z twoich klocków nie mieści się już na planszy.';

  @override
  String get gameOverNoFitNoRotations =>
      'Żaden z twoich klocków się nie mieści — a obroty się skończyły.';

  @override
  String get gameStarterOfferUnavailable => 'Teraz niedostępne';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — biorę';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Osiągnięcie: $title';
  }

  @override
  String get gameBestSubmitted => 'Nowy rekord — wysłany';

  @override
  String get gameReviveFor => 'Graj dalej · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Odblokowano: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pakiet startowy';

  @override
  String gameOverPoints(int score) {
    return '$score pkt';
  }

  @override
  String get gameNewRecord => 'Nowy rekord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'dni',
      one: 'dzień',
    );
    return 'Seria: $streak $_temp0';
  }

  @override
  String get gameDoubleCoins => 'Podwój monety';

  @override
  String get gameDoubleDaily => 'Podwój nagrodę dnia';

  @override
  String get gamePlayAgain => 'Zagraj ponownie';

  @override
  String gameLevelReached(int level) {
    return 'Osiągnięto poziom $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Awans o $count poz. — poziom $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 monet + motyw Drewno';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Zostało tylko $hours h — jednorazowo!';
  }

  @override
  String get boosterUndo => 'Cofnij';

  @override
  String get boosterSwap => 'Wymień';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Brak obrotów — czyść rzędy, aby je odnowić!';

  @override
  String get onboardingDragPiece => 'Przeciągnij klocek na planszę';

  @override
  String get onboardingFillLine => 'Wypełnij cały rząd albo kolumnę';

  @override
  String get onboardingLinesClear => 'Pełne linie znikają — punkty!';

  @override
  String get coachHintCombo =>
      'Combo! Wyczyść znowu w ciągu 3 ruchów, aby je utrzymać';

  @override
  String get coachHintFever => 'GORĄCZKA! Podwójne punkty, póki świeci';

  @override
  String get coachHintRotation =>
      'Obrót kosztuje ładunek — czyszczenie linii go odnawia';

  @override
  String get coachHintBooster => 'Wskazówka: na dole możesz użyć wzmocnień';

  @override
  String get coachHintStrategy =>
      'Wskazówka: nie czyść wszystkiego naraz — zostaw miejsce na duże klocki';

  @override
  String get dailyStreakLabel => 'Seria';

  @override
  String get dailyBestLabel => 'Rekord dnia';

  @override
  String dailyHistoryNote(int days) {
    return 'Przechowujemy ostatnie $days dni.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day. dzień: zagrany';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day. dzień: niezagrany';
  }

  @override
  String get homeDailyCalendar => 'Kalendarz';

  @override
  String get dailyShareButton => 'Udostępnij wynik';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Wyzwanie dnia $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score pkt · najlepsze combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Zagraj: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Combo: zostało $moves ruchu',
      many: 'Combo: zostało $moves ruchów',
      few: 'Combo: zostały $moves ruchy',
      one: 'Combo: został $moves ruch',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Wynik skopiowany do schowka';

  @override
  String get adNotAvailable => 'Brak dostępnego wideo — spróbuj za chwilę';

  @override
  String get howToPlaySpeedTitle => 'Bonus za szybkość';

  @override
  String get howToPlaySpeedBody =>
      'Szybkie układanie dodaje do 30% do każdej wyczyszczonej linii. Bonus maleje między 1,5 a 4 sekundami i ma limit: szybkość się opłaca, ale nie rozstrzyga gry — spokojna, przemyślana gra wciąż może pokonać pośpieszną.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus za szybkość: $percent procent';
  }

  @override
  String get iapDiamondsSmall => '100 diamentów';

  @override
  String get iapDiamondsMedium => '350 diamentów';

  @override
  String get iapDiamondsLarge => '1000 diamentów';

  @override
  String get howToPlayTitle => 'Jak grać w Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Łatwo zacząć.\nWygrywa ten, kto myśli naprzód.';

  @override
  String get howToPlayIntroBody =>
      'Utrzymuj planszę w porządku i pobij swój rekord.';

  @override
  String get howToPlayIntroSemantics =>
      'Cel gry. Utrzymuj planszę w porządku i pobij swój rekord.';

  @override
  String get howToPlayDragTitle => 'Przeciągnij i połóż';

  @override
  String get howToPlayDragBody =>
      'Przeciągnij jeden z trzech klocków na wolne pola. Gdy użyjesz wszystkich trzech, automatycznie dostaniesz trzy nowe.';

  @override
  String get howToPlayClearTitle => 'Czyść linie';

  @override
  String get howToPlayClearBody =>
      'Wypełnij cały rząd albo kolumnę. Pełne linie znikają i robią miejsce na kolejny ruch.';

  @override
  String get howToPlayComboTitle => 'Łącz combo';

  @override
  String get howToPlayComboBody =>
      'Wyczyść kolejną linię w ciągu trzech ruchów. Każde kolejne combo podnosi mnożnik punktów. Combo liczy ruchy, nie sekundy, więc nie przepada, gdy się zastanawiasz.';

  @override
  String get howToPlayFeverTitle => 'Rozpal gorączkę';

  @override
  String get howToPlayFeverBody =>
      'Czyszczenie linii napełnia pasek gorączki. Gdy jest pełny, następny wielki wybuch liczy się podwójnie — planuj duże czyszczenia z wyprzedzeniem.';

  @override
  String get howToPlayBoosterTitle => 'Używaj wzmocnień z głową';

  @override
  String get howToPlayBoosterBody =>
      'Wzmocnienia ratują trudne gry. Możesz też dotknąć klocka na tacy, aby go obrócić.';

  @override
  String get howToPlayDailyTitle => 'Wyzwanie dnia i seria';

  @override
  String get howToPlayDailyBody =>
      'Wyzwanie dnia ma te same klocki dla wszystkich. Graj codziennie, aby wydłużać serię i bonus.';

  @override
  String get howToPlayPiggyTitle => 'Napełnij skarbonkę';

  @override
  String get howToPlayPiggyBody =>
      'Każda wyczyszczona linia napełnia skarbonkę. Gdy jest pełna, możesz za darmo odebrać monety.';

  @override
  String get leaderboardTitle => 'Ranking';

  @override
  String get leaderboardUnreachable =>
      'Ranking niedostępny.\nSpróbuj ponownie z połączeniem internetowym.';

  @override
  String get leaderboardEmpty =>
      'Nikogo tu jeszcze nie ma.\nZajmij pierwsze miejsce!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Wysyłamy twój rekord ($score)…';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Twój rekord jest wysyłany automatycznie.';

  @override
  String get puzzleModeTitle => 'Tryb łamigłówek';

  @override
  String puzzleLevelTitle(int level) {
    return 'Łamigłówka $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Ruchy: $moves   •   Cel: $target na 3 gwiazdki';
  }

  @override
  String get puzzleSolved => 'Rozwiązane!';

  @override
  String get puzzleLeaveTitle => 'Opuścić łamigłówkę?';

  @override
  String get puzzleLeaveBody => 'Postęp w tej łamigłówce zostanie utracony.';

  @override
  String get puzzleKeepPlaying => 'Graj dalej';

  @override
  String get puzzleLeave => 'Wyjdź';

  @override
  String get puzzleStuckTitle => 'Utknięto';

  @override
  String get puzzleRestart => 'Od nowa';

  @override
  String get commonActive => 'Aktywny';

  @override
  String get commonTapToActivate => 'Dotknij, aby włączyć';

  @override
  String get commonRestore => 'Przywróć';

  @override
  String unlockForCost(int cost) {
    return '$cost, aby odblokować';
  }

  @override
  String get skinsExchangeGold => 'Wymień złoto';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Obróć klocek';

  @override
  String get puzzleNextLevel => 'Następny poziom';

  @override
  String get puzzleBackToOverview => 'Wróć do listy';

  @override
  String get puzzleUnsolvable => 'Stąd nie da się już wyczyścić planszy.';

  @override
  String get puzzleExtraMoveVideo => 'Dodatkowy ruch (wideo)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Rozwiązane: $solved';
  }

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get storageFailureTitle => 'Qubble nie może wczytać zapisanej gry';

  @override
  String get storageFailureBody =>
      'Uruchom aplikację ponownie. Jeśli błąd nie zniknie, pomoże tylko ponowna instalacja. Możesz go zgłosić w Ustawienia › Opinie.';

  @override
  String get iapUnavailable => 'Ta oferta jest teraz niedostępna.';

  @override
  String get iapFailed => 'Zakup się nie udał. Nic nie zostało pobrane.';

  @override
  String get settingsResetProgress => 'Zresetuj postęp';

  @override
  String get settingsResetProgressSubtitle =>
      'Wynik, monety, poziom i postęp wracają do początku. Zakupy, nazwa i elementy wyglądu zostają.';

  @override
  String get settingsResetConfirmTitle => 'Zresetować postęp?';

  @override
  String get settingsResetConfirmBody =>
      'Rekord, monety, poziom, seria i cały postęp zostaną usunięte. Tego nie da się cofnąć.\n\nTwoje zakupy, nazwa oraz odblokowane motywy i skórki zostają.';

  @override
  String get settingsResetConfirmAction => 'Zresetuj';

  @override
  String get settingsResetDone => 'Postęp zresetowany.';

  @override
  String get settingsSectionGame => 'Gra';

  @override
  String get settingsSectionSoundHaptics => 'Dźwięk i wibracje';

  @override
  String get settingsSectionReminders => 'Przypomnienia';

  @override
  String get settingsSectionPurchases => 'Zakupy';

  @override
  String get settingsSectionHelpOut => 'Wesprzyj grę';

  @override
  String get settingsSectionLegal => 'Informacje prawne';

  @override
  String get settingsSectionLanguage => 'Język';

  @override
  String get settingsGuide => 'Jak grać';

  @override
  String get settingsGuideSubtitle => 'Zasady, combo, gorączka i wzmocnienia';

  @override
  String get settingsSound => 'Dźwięk';

  @override
  String get settingsMusic => 'Muzyka';

  @override
  String get settingsHaptics => 'Wibracje';

  @override
  String get settingsHapticsOff => 'Wyłączone';

  @override
  String get settingsHapticsLight => 'Delikatne';

  @override
  String get settingsHapticsStrong => 'Mocne';

  @override
  String get settingsSectionAccessibility => 'Komfort';

  @override
  String get settingsReducedEffects => 'Mniej efektów';

  @override
  String get settingsReducedEffectsHint =>
      'Mniej cząsteczek, bez trzęsienia ekranu i poświaty';

  @override
  String get settingsNotifications => 'Powiadomienia';

  @override
  String get settingsNotificationsSubtitle =>
      'Codzienne przypomnienie i ochrona serii';

  @override
  String get settingsNotificationsSystemHint =>
      'Zezwól na nie w ustawieniach systemu.';

  @override
  String get settingsLanguageSystem => 'Język systemu';

  @override
  String get settingsSupporterThanks => 'Wspierasz grę — dziękujemy!';

  @override
  String get settingsSupporterPack => 'Pakiet wsparcia';

  @override
  String get settingsSupporterPackSubtitle =>
      'Ekskluzywny motyw i skórka + 1500 monet';

  @override
  String get settingsRestorePurchases => 'Przywróć zakupy';

  @override
  String get settingsRestoring => 'Przywracanie zakupów…';

  @override
  String get settingsRateApp => 'Oceń aplikację';

  @override
  String get settingsRateAppSubtitle => 'Zostaw ocenę w sklepie';

  @override
  String get settingsStoreUnavailable =>
      'Sklep jest niedostępny na tym urządzeniu.';

  @override
  String get settingsFeedback => 'Wyślij opinię';

  @override
  String get settingsFeedbackSubtitle => 'Zgłoś pomysły i błędy (przez GitHub)';

  @override
  String get settingsAdPrivacy => 'Prywatność reklam';

  @override
  String get settingsAdPrivacySubtitle => 'Zobacz lub zmień zgodę na reklamy';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Na tym urządzeniu nie są wymagane opcje reklam.';

  @override
  String get settingsPrivacy => 'Polityka prywatności';

  @override
  String get settingsImprint => 'Nota prawna';

  @override
  String get settingsPageOpenFailed => 'Nie udało się otworzyć strony.';

  @override
  String get settingsFooter => 'Qubble • Klocki offline';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Tryb admina włączony';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Pozostało dotknięć do trybu admina: $count';
  }

  @override
  String settingsAdminCoins(int coins) {
    return 'Monety: $coins';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Tylko do testów — nigdy na zrzutach ekranu wydania';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount monet';
  }

  @override
  String get settingsAdminResetCoins => 'Ustaw monety na 0';

  @override
  String get feedbackTitle => 'Opinie';

  @override
  String get feedbackIntroShort =>
      'Co ci się podoba, co przeszkadza, czego brakuje? Drobiazgi też pomagają — im konkretniej, tym lepiej.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Dołączamy tylko $build i typ urządzenia — żeby było wiadomo, o którą wersję chodzi.';
  }

  @override
  String get feedbackSendByMail => 'Wyślij e-mailem';

  @override
  String get feedbackPreferGithub => 'Wolę zgłoszenie na GitHubie';

  @override
  String get feedbackThanksMail => 'Dziękujemy! Wystarczy wysłać wiadomość.';

  @override
  String get feedbackNoMailApp =>
      'Nie znaleziono aplikacji pocztowej. Spróbuj przez GitHub poniżej.';

  @override
  String get feedbackEmptyHint => 'Najpierw coś napisz.';

  @override
  String get leaderboardRefresh => 'Odśwież';

  @override
  String get leaderboardRetry => 'Spróbuj ponownie';

  @override
  String get feedbackHint => 'Twoja opinia…';

  @override
  String get feedbackSubmit => 'Wyślij opinię';

  @override
  String get feedbackOpenFailed =>
      'Nie udało się otworzyć GitHuba. Spróbuj później.';

  @override
  String get feedbackGithubNote =>
      'Otworzy się GitHub — dotknij tam \"Submit new issue\". (Potrzebne jest jednorazowe logowanie do GitHuba).';

  @override
  String get shopTitle => 'Sklep';

  @override
  String get shopWebDemoNote =>
      'Zakupy są dostępne tylko w aplikacji ze Sklepu Play. Ta wersja przeglądarkowa to darmowe demo — i tak możesz tu zagrać we wszystko.';

  @override
  String get shopSupporterExplainer =>
      'Qubble nie ma wymuszonych reklam — nigdy nie musisz nic kupować. Pakiet wsparcia (motyw Aurora, skórka Kryształ, 1500 monet, odznaka wspierającego) to podziękowanie za wsparcie gry. Zakupy są przypisane do twojego konta w sklepie i można je w każdej chwili przywrócić.';

  @override
  String get shopSupporterContents =>
      'Motyw Aurora + skórka Kryształ + 1500 monet';

  @override
  String get themesTitle => 'Motywy';

  @override
  String get themesSupporterOnly => 'Tylko w pakiecie wsparcia (zobacz sklep)';

  @override
  String get themesInSupporterPack => 'W pakiecie wsparcia';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Za mało monet (potrzeba $cost, masz $coins)';
  }

  @override
  String get skinsTitle => 'Skórki klocków';

  @override
  String get skinsNotEnoughDiamonds =>
      'Za mało diamentów (wymień złoto poniżej)';

  @override
  String get skinsNotEnoughCoins => 'Za mało monet';

  @override
  String get skinsNotEnoughGold => 'Za mało złota.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold złota = 1 diament. Diamenty odblokowują najpiękniejsze skórki — zbieraj je bez pośpiechu.';
  }

  @override
  String get statsTitle => 'Statystyki';

  @override
  String get statsAverageScore => 'Śr. wynik';

  @override
  String get statsBestCombo => 'Najlepsze combo';

  @override
  String get statsGames => 'Gry';

  @override
  String get statsLinesCleared => 'Wyczyszczone rzędy';

  @override
  String get statsPiecesPlaced => 'Położone klocki';

  @override
  String get statsCoins => 'Monety';

  @override
  String get missionsTitle => 'Misje';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Połóż $countString klocków';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Wyczyść $countString rzędów';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Zdobądź combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Przekrocz $countString pkt w jednej grze';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Rozegraj $countString gier';
  }

  @override
  String get achievementsTitle => 'Osiągnięcia';

  @override
  String get achievementFirstGameTitle => 'Pierwsza gra';

  @override
  String get achievementFirstGameBody => 'Rozegraj pierwszą grę';

  @override
  String get achievementGames25Title => 'Stały bywalec';

  @override
  String get achievementGames25Body => 'Rozegraj 25 gier';

  @override
  String get achievementGames100Title => 'Wciągnięty';

  @override
  String get achievementGames100Body => 'Rozegraj 100 gier';

  @override
  String get achievementScore1kTitle => 'Wspinacz';

  @override
  String get achievementScore1kBody => 'Zdobądź 1000 pkt';

  @override
  String get achievementScore5kTitle => 'Zawodowiec';

  @override
  String get achievementScore5kBody => 'Zdobądź 5000 pkt';

  @override
  String get achievementScore10kTitle => 'Mistrz';

  @override
  String get achievementScore10kBody => 'Zdobądź 10 000 pkt';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Zdobądź 25 000 pkt';

  @override
  String get achievementLines100Title => 'Porządek';

  @override
  String get achievementLines100Body => 'Wyczyść łącznie 100 rzędów';

  @override
  String get achievementLines1000Title => 'Wielkie sprzątanie';

  @override
  String get achievementLines1000Body => 'Wyczyść łącznie 1000 rzędów';

  @override
  String get achievementCombo5Title => 'Początki combo';

  @override
  String get achievementCombo5Body => 'Zdobądź combo x5';

  @override
  String get achievementCombo10Title => 'Król combo';

  @override
  String get achievementCombo10Body => 'Zdobądź combo x10';

  @override
  String get achievementLevel10Title => 'Doświadczenie';

  @override
  String get achievementLevel10Body => 'Osiągnij poziom 10';

  @override
  String get achievementLevel20Title => 'Weteran';

  @override
  String get achievementLevel20Body => 'Osiągnij poziom 20';

  @override
  String get achievementStreak7Title => 'Cały tydzień';

  @override
  String get achievementStreak7Body => 'Seria wyzwań dnia: 7 dni';

  @override
  String get achievementStreak30Title => 'Cały miesiąc';

  @override
  String get achievementStreak30Body => 'Seria wyzwań dnia: 30 dni';

  @override
  String get achievementPuzzles10Title => 'Łamigłówkowa głowa';

  @override
  String get achievementPuzzles10Body => 'Rozwiąż 10 łamigłówek';

  @override
  String get achievementPieces5000Title => 'Budowniczy';

  @override
  String get achievementPieces5000Body => 'Połóż 5000 klocków';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'dni',
      one: 'dnia',
    );
    return 'Seria $streak $_temp0 w niebezpieczeństwie!';
  }

  @override
  String get streakRepairBody => 'Wczoraj nie było gry — uratuj swoją serię:';

  @override
  String get streakRepairFailed => 'Naprawa niemożliwa.';

  @override
  String comebackGift(int coins) {
    return 'Dobrze, że wracasz! +$coins monet';
  }

  @override
  String get notificationsOptInTitle => 'Przypomnienia?';

  @override
  String get notificationsOptInBody =>
      'Przypominać ci o wyzwaniu dnia i chronić twoją serię? Możesz to zmienić w każdej chwili w ustawieniach.';

  @override
  String get notificationsOptInAccept => 'Tak, poproszę';

  @override
  String get notificationChannelDescription =>
      'Codzienne przypomnienie, ostrzeżenie o serii, powrót';

  @override
  String get notificationDailyTitle => 'Twoja łamigłówka dnia czeka 🧩';

  @override
  String get notificationDailyBody => 'Zagraj w dzisiejsze wyzwanie!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'dni',
      one: 'dnia',
    );
    return '🔥 Seria $streak $_temp0 w niebezpieczeństwie!';
  }

  @override
  String get notificationStreakBody => 'Zagraj dziś, aby ją utrzymać.';

  @override
  String get notificationComebackTitle => 'Twoje klocki czekają 🧩';

  @override
  String get notificationComebackBody => 'Wróć i odbierz prezent!';

  @override
  String get iapSupporterPack => 'Pakiet wsparcia';

  @override
  String get iapCoinsSmall => '500 monet';

  @override
  String get iapCoinsMedium => '2000 monet';

  @override
  String get iapCoinsLarge => '6000 monet';

  @override
  String get iapStarterPack => 'Pakiet startowy';

  @override
  String get iapRename => 'Zmiana nazwy';

  @override
  String get iapNeonTheme => 'Motyw Neon';

  @override
  String get settingsLeaderboardDelete => 'Usuń wpis z rankingu';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Usuwa twoją nazwę i wynik z publicznej listy';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Usunąć twój wpis?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Twoja nazwa i wynik zostaną usunięte z rankingu. Postęp w grze się nie zmieni. Do rankingu możesz wrócić w każdej chwili.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Twój wpis w rankingu został usunięty.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Nie udało się usunąć wpisu. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get leaderboardReport => 'Zgłoś tę nazwę';

  @override
  String get leaderboardBlock => 'Zablokuj';

  @override
  String leaderboardBlocked(String name) {
    return '$name jest dla ciebie ukryty';
  }

  @override
  String get leaderboardUndo => 'Cofnij';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Ukryte przez ciebie wpisy: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Pokaż znowu';

  @override
  String get leaderboardReportUnavailable =>
      'Zgłaszanie jest teraz niedostępne.';

  @override
  String get leaderboardReportSent => 'Dziękujemy — zgłoszenie jest w drodze.';

  @override
  String get leaderboardRules =>
      'Nazwy są publiczne. Żadnych obelg, mowy nienawiści ani niczego, co identyfikuje prawdziwą osobę. Nazwy łamiące tę zasadę są usuwane.';

  @override
  String get leaderboardRulesAccept => 'Rozumiem';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Odblokowano $unlocked z $total';
  }

  @override
  String get settingsSectionData => 'Zapisane dane';

  @override
  String get gameRotatePiece => 'Obróć klocek';

  @override
  String get themeClassic => 'Klasyczny';

  @override
  String get themeFade => 'Pastelowy';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Ocean';

  @override
  String get themeWood => 'Drewno';

  @override
  String get themeSunset => 'Zachód słońca';

  @override
  String get themeForest => 'Las';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasyczna';

  @override
  String get skinGradient => 'Gradient';

  @override
  String get skinOutline => 'Kontur';

  @override
  String get skinGlossy => 'Połysk';

  @override
  String get skinStripe => 'Paski';

  @override
  String get skinBevel => 'Relief';

  @override
  String get skinGlow => 'Poświata';

  @override
  String get skinCrystal => 'Kryształ';

  @override
  String rewardThemeName(String name) {
    return 'Motyw $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skórka $name';
  }
}
