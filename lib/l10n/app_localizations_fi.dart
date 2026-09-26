// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class L10nFi extends L10n {
  L10nFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Pelaa';

  @override
  String get commonLater => 'Myöhemmin';

  @override
  String get commonNotNow => 'Ei nyt';

  @override
  String get commonCancel => 'Peruuta';

  @override
  String get commonBuy => 'Osta';

  @override
  String get commonSave => 'Tallenna';

  @override
  String get commonCollect => 'Kerää';

  @override
  String get nameNewName => 'Uusi nimi';

  @override
  String get nameFieldLabel => 'Nimi';

  @override
  String get piggyFullTitle => 'Säästöpossu on täynnä!';

  @override
  String get piggyKeepSaving => 'Jatka säästämistä';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Kerätty $coins/$capacity.';
  }

  @override
  String get homeContinueRun => 'Jatka';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Selvä';

  @override
  String get commonHome => 'Koti';

  @override
  String get commonScore => 'PISTEET';

  @override
  String get commonBest => 'ENNÄTYS';

  @override
  String commonLevelShort(int level) {
    return 'Taso $level';
  }

  @override
  String get homeNewRun => 'Aloita uusi peli';

  @override
  String get homeBackToExit => 'Poistu painamalla takaisin uudelleen';

  @override
  String get homeEnableLeaderboard => 'Liity tulostaululle';

  @override
  String get homeBestScore => 'PARAS TULOS';

  @override
  String get homeDailyChallenge => 'Päivän haaste';

  @override
  String get homeDailyOpenToday => 'Avoinna tänään';

  @override
  String homeDailyNextIn(String time) {
    return 'Seuraava haaste $time päästä';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Putki: $streak päivää',
      one: 'Putki: $streak päivä',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Tulostaulu';

  @override
  String get homePuzzleMode => 'Pulmatila';

  @override
  String get homeMissions => 'Tehtävät';

  @override
  String get homeThemes => 'Teemat';

  @override
  String get homeSkins => 'Ulkoasut';

  @override
  String get homeHowToPlay => 'Qubblen säännöt';

  @override
  String get homeWeekendBonus => 'Viikonloppu: tuplakolikot!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Taso $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Vaihda nimi';

  @override
  String get nameChangeExplainer =>
      'Nimesi on tunnisteesi tulostaululla, joten se on pysyvä. Voit ostaa kertaluonteisen nimenvaihdon.';

  @override
  String get nameChangeAfterPurchase =>
      'Napauta ostoksen jälkeen nimeäsi uudelleen vaihtaaksesi sen.';

  @override
  String get nameJoinedLeaderboard => 'Olet nyt tulostaululla.';

  @override
  String get nameRenameUnavailable =>
      'Nimen vaihtaminen ei ole juuri nyt mahdollista.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'Vähintään $min merkkiä.',
      one: 'Vähintään $min merkki.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'Enintään $max merkkiä.',
      one: 'Enintään $max merkki.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Vain kirjaimet ilman ääkkösiä (A–Z), numerot, välilyönnit, _ ja -.';

  @override
  String get nameProblemOffensive => 'Valitse toinen nimi.';

  @override
  String get piggyTitle => 'Säästöpossu';

  @override
  String get piggyFillingHint => 'Säästöpossu täyttyy, kun tyhjennät rivejä.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins kolikkoa',
      one: '$coins kolikko',
    );
    return 'Kerää $_temp0 – ilmaiseksi.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kun se on täynnä, voit tyhjentää sen ilmaiseksi – tai avata sen aiemmin bonusvideolla.';

  @override
  String get piggyOpenNow => 'Avaa nyt';

  @override
  String get gameNewPiecesVideo => 'Uudet palat (video)';

  @override
  String get gameTapBoardCell => 'Napauta ruutua laudalla';

  @override
  String get gameDailyChallengeLabel => 'PÄIVÄN HAASTE';

  @override
  String get gameOver => 'Peli päättyi';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Pommiin puuttuu kolikoita: $missing.';
  }

  @override
  String get gameBombNotHere => 'Pommi ei toimi tässä juuri nyt.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Kolikoita puuttuu: $missing.';
  }

  @override
  String get gameNotRightNow => 'Ei onnistu juuri nyt.';

  @override
  String get gameRunSaved => 'Peli tallennettu – ”Jatka” valikossa.';

  @override
  String get gameOverNoFit => 'Mikään paloistasi ei enää mahdu laudalle.';

  @override
  String get gameOverNoFitNoRotations =>
      'Mikään pala ei mahdu – ja kierrot on käytetty.';

  @override
  String get gameStarterOfferUnavailable => 'Ei saatavilla nyt';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price – hae';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Saavutus: $title';
  }

  @override
  String get gameBestSubmitted => 'Uusi ennätys – lähetetty';

  @override
  String get gameReviveFor => 'Jatka pelaamista · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Avattu: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Aloituspaketti';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score pistettä',
      one: '$score piste',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Uusi ennätys!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Putki: $streak päivää',
      one: 'Putki: $streak päivä',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Tuplakolikot';

  @override
  String get gameDoubleDaily => 'Tuplaa päiväpalkinto';

  @override
  String get gamePlayAgain => 'Pelaa uudelleen';

  @override
  String gameLevelReached(int level) {
    return 'Taso $level saavutettu!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count tasoa – taso $level!',
      one: '+$count taso – taso $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 kolikkoa + Puu-teema';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Vain $hours tuntia jäljellä – vain kerran!',
      one: 'Vain $hours tunti jäljellä – vain kerran!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Kumoa';

  @override
  String get boosterSwap => 'Vaihda';

  @override
  String get boosterBomb => 'Pommi';

  @override
  String get boosterNoRotationsLeft =>
      'Kierrot loppuivat – tyhjennä rivejä ladataksesi!';

  @override
  String get onboardingDragPiece => 'Vedä pala ruudukkoon';

  @override
  String get onboardingFillLine => 'Täytä kokonainen rivi tai sarake';

  @override
  String get onboardingLinesClear => 'Täydet rivit katoavat – pisteitä!';

  @override
  String get coachHintCombo =>
      'Kombo! Tyhjennä uudelleen 3 siirron sisällä pitääksesi sen';

  @override
  String get coachHintFever => 'KUUME! Tuplapisteet niin kauan kuin hehkuu';

  @override
  String get coachHintRotation =>
      'Kääntö maksaa latauksen – tyhjennykset täyttävät sen';

  @override
  String get coachHintBooster => 'Vinkki: alhaalla on tehostimia';

  @override
  String get coachHintStrategy =>
      'Vinkki: älä kaikkia rivejä kerralla – jätä tilaa isoille paloille';

  @override
  String get dailyStreakLabel => 'Putki';

  @override
  String get dailyBestLabel => 'Päivän paras';

  @override
  String dailyHistoryNote(int days) {
    return 'Viimeiset $days päivää säilytetään.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day.: pelattu';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day.: ei pelattu';
  }

  @override
  String get homeDailyCalendar => 'Kalenteri';

  @override
  String get dailyShareButton => 'Jaa tulos';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Päivän haaste $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'Pisteet: $score · paras kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Pelaa: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Kombo: $moves siirtoa jäljellä',
      one: 'Kombo: $moves siirto jäljellä',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Tulos kopioitu leikepöydälle';

  @override
  String get adNotAvailable =>
      'Videota ei ole nyt saatavilla – yritä hetken päästä uudelleen';

  @override
  String get howToPlaySpeedTitle => 'Nopeusbonus';

  @override
  String get howToPlaySpeedBody =>
      'Nopea asettelu antaa tyhjennykseen jopa 30 % lisää. Bonus hiipuu 1,5 ja 4 sekunnin välillä, ja sillä on katto, joten nopeus kannattaa ratkaisematta peliä – huolellinen, hidas peli voi yhä voittaa hätäisen.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Nopeusbonus $percent prosenttia';
  }

  @override
  String get iapDiamondsSmall => '100 timanttia';

  @override
  String get iapDiamondsMedium => '350 timanttia';

  @override
  String get iapDiamondsLarge => '1 000 timanttia';

  @override
  String get howToPlayTitle => 'Qubblen säännöt';

  @override
  String get howToPlayIntroHeadline =>
      'Helppo aloittaa.\nPalkitsee suunnittelun.';

  @override
  String get howToPlayIntroBody => 'Pidä lauta vapaana ja lyö ennätyksesi.';

  @override
  String get howToPlayIntroSemantics =>
      'Pelin tavoite. Pidä lauta vapaana ja lyö ennätyksesi.';

  @override
  String get howToPlayDragTitle => 'Vedä ja pudota';

  @override
  String get howToPlayDragBody =>
      'Vedä yksi kolmesta palasta vapaisiin ruutuihin. Kun kaikki kolme on käytetty, saat automaattisesti kolme uutta.';

  @override
  String get howToPlayClearTitle => 'Tyhjennä rivejä';

  @override
  String get howToPlayClearBody =>
      'Täytä kokonainen rivi tai sarake. Täydet rivit katoavat ja tekevät tilaa seuraavalle siirrollesi.';

  @override
  String get howToPlayComboTitle => 'Ketjuta komboja';

  @override
  String get howToPlayComboBody =>
      'Tyhjennä uusi rivi kolmen siirron sisällä. Jokainen seuraava kombo nostaa pistekerrointasi. Kombo laskee siirtoja, ei sekunteja, joten se ei lopu kesken, kun mietit.';

  @override
  String get howToPlayFeverTitle => 'Sytytä kuume';

  @override
  String get howToPlayFeverBody =>
      'Tyhjennykset täyttävät kuumemittaria. Kun se on täynnä, seuraava iso tyhjennys lasketaan tuplana – suunnittele isot tyhjennykset etukäteen.';

  @override
  String get howToPlayBoosterTitle => 'Käytä tehostimia viisaasti';

  @override
  String get howToPlayBoosterBody =>
      'Tehostimet pelastavat tiukat pelit. Voit myös napauttaa alhaalla olevaa palaa kääntääksesi sen.';

  @override
  String get howToPlayDailyTitle => 'Päivän haaste ja putki';

  @override
  String get howToPlayDailyBody =>
      'Päivän haasteessa kaikilla on samat palat. Pelaa joka päivä kasvattaaksesi putkeasi ja bonustasi.';

  @override
  String get howToPlayPiggyTitle => 'Täytä säästöpossu';

  @override
  String get howToPlayPiggyBody =>
      'Jokainen tyhjentämäsi rivi täyttää säästöpossuasi. Kun se on täynnä, voit kerätä kolikot ilmaiseksi.';

  @override
  String get leaderboardTitle => 'Tulostaulu';

  @override
  String get leaderboardUnreachable =>
      'Tulostaulu ei ole saatavilla.\nYritä uudelleen internetyhteydellä.';

  @override
  String get leaderboardEmpty => 'Ei vielä tuloksia.\nOle ensimmäinen!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Paras tuloksesi ($score) lähetetään …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Paras tuloksesi lähetetään automaattisesti.';

  @override
  String get puzzleModeTitle => 'Pulmatila';

  @override
  String puzzleLevelTitle(int level) {
    return 'Pulma $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Siirrot: $moves   •   Tavoite: $target kolmeen tähteen';
  }

  @override
  String get puzzleSolved => 'Ratkaistu!';

  @override
  String get puzzleLeaveTitle => 'Poistutaanko pulmasta?';

  @override
  String get puzzleLeaveBody => 'Edistymisesi tässä pulmassa menetetään.';

  @override
  String get puzzleKeepPlaying => 'Jatka pelaamista';

  @override
  String get puzzleLeave => 'Poistu';

  @override
  String get puzzleStuckTitle => 'Umpikuja';

  @override
  String get puzzleRestart => 'Aloita alusta';

  @override
  String get commonActive => 'Aktiivinen';

  @override
  String get commonTapToActivate => 'Aktivoi napauttamalla';

  @override
  String get commonRestore => 'Palauta';

  @override
  String unlockForCost(int cost) {
    return 'Avaa hintaan $cost';
  }

  @override
  String get skinsExchangeGold => 'Vaihda kultaa';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Käännä palaa';

  @override
  String get puzzleNextLevel => 'Seuraava taso';

  @override
  String get puzzleBackToOverview => 'Takaisin yleiskatsaukseen';

  @override
  String get puzzleUnsolvable => 'Lautaa ei voi enää tyhjentää tästä.';

  @override
  String get puzzleExtraMoveVideo => 'Lisäsiirto (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Ratkaistu: $solved';
  }

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get storageFailureTitle => 'Qubble ei voi ladata tallennettua peliä';

  @override
  String get storageFailureBody =>
      'Käynnistä sovellus uudelleen. Jos virhe jatkuu, vain uudelleenasennus auttaa. Voit ilmoittaa siitä kohdassa Asetukset › Palaute.';

  @override
  String get iapUnavailable => 'Tämä tarjous ei ole nyt saatavilla.';

  @override
  String get iapFailed => 'Osto epäonnistui. Mitään ei veloitettu.';

  @override
  String get settingsResetProgress => 'Nollaa edistyminen';

  @override
  String get settingsResetProgressSubtitle =>
      'Pisteet, kolikot, taso ja edistyminen takaisin alkuun. Ostokset, nimi ja ulkoasut säilyvät.';

  @override
  String get settingsResetConfirmTitle => 'Nollataanko edistyminen?';

  @override
  String get settingsResetConfirmBody =>
      'Paras tulos, kolikot, taso, putki ja kaikki edistyminen poistetaan. Tätä ei voi perua.\n\nOstoksesi, nimesi sekä avatut teemat ja ulkoasut säilyvät.';

  @override
  String get settingsResetConfirmAction => 'Nollaa';

  @override
  String get settingsResetDone => 'Edistyminen nollattu.';

  @override
  String get settingsSectionGame => 'Peli';

  @override
  String get settingsSectionSoundHaptics => 'Ääni ja värinä';

  @override
  String get settingsSectionReminders => 'Muistutukset';

  @override
  String get settingsSectionPurchases => 'Ostokset';

  @override
  String get settingsSectionHelpOut => 'Auta meitä';

  @override
  String get settingsSectionLegal => 'Oikeudelliset tiedot';

  @override
  String get settingsSectionLanguage => 'Kieli';

  @override
  String get settingsGuide => 'Peliohjeet';

  @override
  String get settingsGuideSubtitle => 'Säännöt, kombot, kuume ja tehostimet';

  @override
  String get settingsSound => 'Äänet';

  @override
  String get settingsMusic => 'Musiikki';

  @override
  String get settingsHaptics => 'Värinä';

  @override
  String get settingsHapticsOff => 'Pois';

  @override
  String get settingsHapticsLight => 'Kevyt';

  @override
  String get settingsHapticsStrong => 'Voimakas';

  @override
  String get settingsSectionAccessibility => 'Mukavuus';

  @override
  String get settingsReducedEffects => 'Vähemmän tehosteita';

  @override
  String get settingsReducedEffectsHint =>
      'Vähemmän partikkeleita, ei näytön tärinää, ei hehkua';

  @override
  String get settingsNotifications => 'Ilmoitukset';

  @override
  String get settingsNotificationsSubtitle =>
      'Päivittäinen muistutus ja putken suojaus';

  @override
  String get settingsNotificationsSystemHint =>
      'Salli ne järjestelmäasetuksissa.';

  @override
  String get settingsLanguageSystem => 'Järjestelmän kieli';

  @override
  String get settingsSupporterThanks => 'Tukija – kiitos!';

  @override
  String get settingsSupporterPack => 'Tukijapaketti';

  @override
  String get settingsSupporterPackSubtitle =>
      'Eksklusiivinen teema ja ulkoasu + 1 500 kolikkoa';

  @override
  String get settingsRestorePurchases => 'Palauta ostokset';

  @override
  String get settingsRestoring => 'Palautetaan ostoksia…';

  @override
  String get settingsRateApp => 'Arvioi sovellus';

  @override
  String get settingsRateAppSubtitle => 'Jätä arvio kaupassa';

  @override
  String get settingsStoreUnavailable =>
      'Kauppa ei ole käytettävissä tällä laitteella.';

  @override
  String get settingsFeedback => 'Lähetä palautetta';

  @override
  String get settingsFeedbackSubtitle => 'Ideat ja virheet (GitHubin kautta)';

  @override
  String get settingsAdPrivacy => 'Mainosten tietosuoja';

  @override
  String get settingsAdPrivacySubtitle => 'Näytä tai muuta mainossuostumustasi';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Tällä laitteella ei tarvita mainosvalintoja.';

  @override
  String get settingsPrivacy => 'Tietosuojakäytäntö';

  @override
  String get settingsImprint => 'Julkaisijan tiedot';

  @override
  String get settingsPageOpenFailed => 'Sivua ei voitu avata.';

  @override
  String get settingsFooter => 'Qubble • Offline-palikkapeli';

  @override
  String get settingsAdminSection => 'Ylläpito (testi)';

  @override
  String get settingsAdminEnabled => 'Ylläpitotila käytössä';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Napauta vielä $count× ylläpitotilaan';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins kolikkoa',
      one: '$coins kolikko',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Vain testaukseen – ei koskaan julkaisun kuvakaappauksiin';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount kolikkoa';
  }

  @override
  String get settingsAdminResetCoins => 'Aseta kolikot nollaan';

  @override
  String get feedbackTitle => 'Palaute';

  @override
  String get feedbackIntroShort =>
      'Mistä pidät, mikä ärsyttää, mitä puuttuu? Pienetkin asiat auttavat – mitä konkreettisempi, sen parempi.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Liitteenä on vain $build ja laitteesi tyyppi – jotta tiedän, mitä versiota tarkoitat.';
  }

  @override
  String get feedbackSendByMail => 'Lähetä sähköpostilla';

  @override
  String get feedbackPreferGithub => 'Mieluummin GitHub-issue';

  @override
  String get feedbackThanksMail => 'Kiitos! Lähetä vain viesti.';

  @override
  String get feedbackNoMailApp =>
      'Sähköpostisovellusta ei löytynyt. Kokeile alla olevaa GitHub-reittiä.';

  @override
  String get feedbackEmptyHint => 'Kirjoita ensin jotain.';

  @override
  String get leaderboardRefresh => 'Päivitä';

  @override
  String get leaderboardRetry => 'Yritä uudelleen';

  @override
  String get feedbackHint => 'Palautteesi…';

  @override
  String get feedbackSubmit => 'Lähetä palaute';

  @override
  String get feedbackOpenFailed =>
      'GitHubia ei voitu avata. Yritä myöhemmin uudelleen.';

  @override
  String get feedbackGithubNote =>
      'GitHub avautuu – napauta siellä ”Submit new issue”. (Vaatii kertaluonteisen kirjautumisen GitHubiin.)';

  @override
  String get shopTitle => 'Kauppa';

  @override
  String get shopWebDemoNote =>
      'Ostokset ovat saatavilla vain Play Kaupasta asennetussa sovelluksessa. Tämä selainversio on ilmainen demo – voit silti pelata kaiken täällä.';

  @override
  String get shopSupporterExplainer =>
      'Qubble ei näytä pakotettuja mainoksia – sinun ei koskaan tarvitse ostaa mitään. Tukijapaketti (Revontulet-teema, Kristalli-ulkoasu, 1 500 kolikkoa, tukijamerkki) on kiitos pelin tukemisesta. Ostokset on sidottu kauppatiliisi, ja ne voi palauttaa milloin tahansa.';

  @override
  String get shopSupporterContents =>
      'Revontulet-teema + Kristalli-ulkoasu + 1 500 kolikkoa';

  @override
  String get themesTitle => 'Teemat';

  @override
  String get themesSupporterOnly => 'Vain tukijapaketissa (katso kauppa)';

  @override
  String get themesInSupporterPack => 'Tukijapaketissa';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Kolikot eivät riitä (tarvitaan $cost, sinulla $coins)';
  }

  @override
  String get skinsTitle => 'Palikoiden ulkoasut';

  @override
  String get skinsNotEnoughDiamonds =>
      'Timantit eivät riitä (vaihda kultaa alla)';

  @override
  String get skinsNotEnoughCoins => 'Kolikot eivät riitä';

  @override
  String get skinsNotEnoughGold => 'Kulta ei riitä.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold kultaa = 1 timantti. Timanteilla avaat hienoimmat ulkoasut – kerää rauhassa.';
  }

  @override
  String get statsTitle => 'Tilastot';

  @override
  String get statsAverageScore => 'Keskim. tulos';

  @override
  String get statsBestCombo => 'Paras kombo';

  @override
  String get statsGames => 'Pelit';

  @override
  String get statsLinesCleared => 'Tyhjennetyt rivit';

  @override
  String get statsPiecesPlaced => 'Asetetut palat';

  @override
  String get statsCoins => 'Kolikot';

  @override
  String get missionsTitle => 'Tehtävät';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Aseta $countString palaa',
      one: 'Aseta $countString pala',
    );
    return '$_temp0';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tyhjennä $countString riviä',
      one: 'Tyhjennä $countString rivi',
    );
    return '$_temp0';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Saavuta ${countString}x-kombo';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ylitä $countString pistettä yhdessä pelissä',
      one: 'Ylitä $countString piste yhdessä pelissä',
    );
    return '$_temp0';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pelaa $countString peliä',
      one: 'Pelaa $countString peli',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'Saavutukset';

  @override
  String get achievementFirstGameTitle => 'Ensimmäinen peli';

  @override
  String get achievementFirstGameBody => 'Pelaa ensimmäinen pelisi';

  @override
  String get achievementGames25Title => 'Vakiokävijä';

  @override
  String get achievementGames25Body => 'Pelaa 25 peliä';

  @override
  String get achievementGames100Title => 'Koukussa';

  @override
  String get achievementGames100Body => 'Pelaa 100 peliä';

  @override
  String get achievementScore1kTitle => 'Nousija';

  @override
  String get achievementScore1kBody => 'Saavuta 1 000 pistettä';

  @override
  String get achievementScore5kTitle => 'Ammattilainen';

  @override
  String get achievementScore5kBody => 'Saavuta 5 000 pistettä';

  @override
  String get achievementScore10kTitle => 'Mestari';

  @override
  String get achievementScore10kBody => 'Saavuta 10 000 pistettä';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Saavuta 25 000 pistettä';

  @override
  String get achievementLines100Title => 'Siisti';

  @override
  String get achievementLines100Body => 'Tyhjennä yhteensä 100 riviä';

  @override
  String get achievementLines1000Title => 'Suursiivooja';

  @override
  String get achievementLines1000Body => 'Tyhjennä yhteensä 1 000 riviä';

  @override
  String get achievementCombo5Title => 'Kombojen alku';

  @override
  String get achievementCombo5Body => 'Saavuta 5x-kombo';

  @override
  String get achievementCombo10Title => 'Kombokuningas';

  @override
  String get achievementCombo10Body => 'Saavuta 10x-kombo';

  @override
  String get achievementLevel10Title => 'Kokenut';

  @override
  String get achievementLevel10Body => 'Saavuta taso 10';

  @override
  String get achievementLevel20Title => 'Veteraani';

  @override
  String get achievementLevel20Body => 'Saavuta taso 20';

  @override
  String get achievementStreak7Title => 'Viikon putki';

  @override
  String get achievementStreak7Body => '7 päivän päivittäinen putki';

  @override
  String get achievementStreak30Title => 'Kuukauden putki';

  @override
  String get achievementStreak30Body => '30 päivän päivittäinen putki';

  @override
  String get achievementPuzzles10Title => 'Pulmailija';

  @override
  String get achievementPuzzles10Body => 'Ratkaise 10 pulmaa';

  @override
  String get achievementPieces5000Title => 'Rakentaja';

  @override
  String get achievementPieces5000Body => 'Aseta 5 000 palaa';

  @override
  String streakRepairTitle(int streak) {
    return '$streak päivän putkesi on vaarassa!';
  }

  @override
  String get streakRepairBody => 'Eilinen jäi väliin – pelasta putkesi:';

  @override
  String get streakRepairFailed => 'Korjaus ei ole mahdollinen.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins kolikkoa',
      one: '$coins kolikko',
    );
    return 'Tervetuloa takaisin! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Muistutuksia?';

  @override
  String get notificationsOptInBody =>
      'Muistutetaanko sinua päivän pulmasta ja suojataanko putkesi? Voit muuttaa tätä milloin tahansa asetuksissa.';

  @override
  String get notificationsOptInAccept => 'Kyllä kiitos';

  @override
  String get notificationChannelDescription =>
      'Päivittäinen muistutus, putkivaroitus, paluukutsu';

  @override
  String get notificationDailyTitle => 'Päivän pulmasi odottaa 🧩';

  @override
  String get notificationDailyBody => 'Pelaa tämän päivän haaste!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak päivän putkesi on vaarassa!';
  }

  @override
  String get notificationStreakBody => 'Pelaa tänään pitääksesi sen hengissä.';

  @override
  String get notificationComebackTitle => 'Pulmasi kaipaa sinua 🧩';

  @override
  String get notificationComebackBody => 'Palaa ja hae lahja!';

  @override
  String get iapSupporterPack => 'Tukijapaketti';

  @override
  String get iapCoinsSmall => '500 kolikkoa';

  @override
  String get iapCoinsMedium => '2 000 kolikkoa';

  @override
  String get iapCoinsLarge => '6 000 kolikkoa';

  @override
  String get iapStarterPack => 'Aloituspaketti';

  @override
  String get iapRename => 'Nimenvaihto';

  @override
  String get iapNeonTheme => 'Neon-teema';

  @override
  String get settingsLeaderboardDelete => 'Poista tulostaulumerkintä';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Poistaa nimesi ja tuloksesi julkiselta listalta';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Poistetaanko merkintäsi?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Nimesi ja tuloksesi poistetaan tulostaululta. Pelin edistymisesi pysyy ennallaan. Voit liittyä tulostaululle uudelleen milloin tahansa.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Tulostaulumerkintäsi poistettiin.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Merkintää ei voitu poistaa. Tarkista yhteys ja yritä uudelleen.';

  @override
  String get leaderboardReport => 'Ilmoita tästä nimestä';

  @override
  String get leaderboardBlock => 'Estä';

  @override
  String leaderboardBlocked(String name) {
    return '$name on piilotettu sinulta';
  }

  @override
  String get leaderboardUndo => 'Kumoa';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Piilotit $count merkintää',
      one: 'Piilotit $count merkinnän',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Näytä uudelleen';

  @override
  String get leaderboardReportUnavailable =>
      'Ilmoittaminen ei ole nyt mahdollista.';

  @override
  String get leaderboardReportSent => 'Kiitos – ilmoituksesi on matkalla.';

  @override
  String get leaderboardRules =>
      'Nimet ovat julkisia. Ei loukkauksia, ei herjauksia eikä mitään, mikä tunnistaa oikean henkilön. Sääntöjä rikkovat nimet poistetaan.';

  @override
  String get leaderboardRulesAccept => 'Ymmärrän';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked/$total avattu';
  }

  @override
  String get settingsSectionData => 'Tallennetut tiedot';

  @override
  String get gameRotatePiece => 'Käännä palaa';

  @override
  String get themeClassic => 'Klassinen';

  @override
  String get themeFade => 'Pastelli';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Meri';

  @override
  String get themeWood => 'Puu';

  @override
  String get themeSunset => 'Auringonlasku';

  @override
  String get themeForest => 'Metsä';

  @override
  String get themeAurora => 'Revontulet';

  @override
  String get skinClassic => 'Klassinen';

  @override
  String get skinGradient => 'Liukuväri';

  @override
  String get skinOutline => 'Ääriviiva';

  @override
  String get skinGlossy => 'Kiiltävä';

  @override
  String get skinStripe => 'Raidat';

  @override
  String get skinBevel => 'Viiste';

  @override
  String get skinGlow => 'Hehku';

  @override
  String get skinCrystal => 'Kristalli';

  @override
  String rewardThemeName(String name) {
    return '$name-teema';
  }

  @override
  String rewardSkinName(String name) {
    return '$name-ulkoasu';
  }
}
