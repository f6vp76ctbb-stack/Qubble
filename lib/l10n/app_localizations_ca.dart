// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class L10nCa extends L10n {
  L10nCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Jugar';

  @override
  String get commonLater => 'Més tard';

  @override
  String get commonNotNow => 'Ara no';

  @override
  String get commonCancel => 'Cancel·la';

  @override
  String get commonBuy => 'Compra';

  @override
  String get commonSave => 'Desa';

  @override
  String get commonCollect => 'Recull';

  @override
  String get nameNewName => 'Nom nou';

  @override
  String get nameFieldLabel => 'Nom';

  @override
  String get piggyFullTitle => 'La guardiola és plena!';

  @override
  String get piggyKeepSaving => 'Continua estalviant';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins de $capacity reunides.';
  }

  @override
  String get homeContinueRun => 'Continua';

  @override
  String get homeVideo => 'Vídeo';

  @override
  String get commonGotIt => 'Entesos';

  @override
  String get commonHome => 'Inici';

  @override
  String get commonScore => 'PUNTS';

  @override
  String get commonBest => 'RÈCORD';

  @override
  String commonLevelShort(int level) {
    return 'Nivell $level';
  }

  @override
  String get homeNewRun => 'Comença una partida nova';

  @override
  String get homeBackToExit => 'Torna a prémer enrere per sortir';

  @override
  String get homeEnableLeaderboard => 'Uneix-te a la classificació';

  @override
  String get homeBestScore => 'RÈCORD';

  @override
  String get homeDailyChallenge => 'Repte diari';

  @override
  String get homeDailyOpenToday => 'Pendent avui';

  @override
  String homeDailyNextIn(String time) {
    return 'Proper repte d\'aquí a $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Ratxa de $streak dies',
      one: 'Ratxa de $streak dia',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Classificació';

  @override
  String get homePuzzleMode => 'Mode trencaclosques';

  @override
  String get homeMissions => 'Missions';

  @override
  String get homeThemes => 'Temes';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Com es juga a Qubble';

  @override
  String get homeWeekendBonus => 'Cap de setmana: monedes dobles!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Nivell $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Canvia el nom';

  @override
  String get nameChangeExplainer =>
      'El teu nom és la teva identitat a la classificació, per això és fix. Pots comprar un canvi de nom únic.';

  @override
  String get nameChangeAfterPurchase =>
      'Després de la compra, torna a tocar el teu nom per canviar-lo.';

  @override
  String get nameJoinedLeaderboard => 'Ja ets a la classificació.';

  @override
  String get nameRenameUnavailable => 'Ara mateix no es pot canviar el nom.';

  @override
  String nameProblemTooShort(int min) {
    return 'Com a mínim $min caràcters.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Com a màxim $max caràcters.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Només lletres sense accents (A–Z), números, espais, _ i -.';

  @override
  String get nameProblemOffensive => 'Tria un altre nom, si us plau.';

  @override
  String get piggyTitle => 'Guardiola';

  @override
  String get piggyFillingHint => 'La guardiola s\'omple mentre neteges files.';

  @override
  String piggyCollect(int coins) {
    return 'Recull $coins monedes, gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Quan sigui plena, la podràs buidar gratis, o obrir-la abans amb un vídeo extra.';

  @override
  String get piggyOpenNow => 'Obre-la ara';

  @override
  String get gameNewPiecesVideo => 'Peces noves (vídeo)';

  @override
  String get gameTapBoardCell => 'Toca una casella del tauler';

  @override
  String get gameDailyChallengeLabel => 'REPTE DIARI';

  @override
  String get gameOver => 'Fi de la partida';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Et falten $missing monedes per a la bomba.';
  }

  @override
  String get gameBombNotHere => 'Ara la bomba no funciona aquí.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Et falten $missing monedes per a això.';
  }

  @override
  String get gameNotRightNow => 'Ara no és possible.';

  @override
  String get gameRunSaved => 'Partida desada: «Continua» al menú.';

  @override
  String get gameOverNoFit => 'Cap de les teves peces no cap al tauler.';

  @override
  String get gameOverNoFitNoRotations =>
      'Cap de les teves peces no hi cap, i ja no et queden girs.';

  @override
  String get gameStarterOfferUnavailable => 'No disponible ara';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — aconsegueix-lo';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Assoliment: $title';
  }

  @override
  String get gameBestSubmitted => 'Rècord nou, enviat';

  @override
  String get gameReviveFor => 'Continua jugant · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Desbloquejat: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pack d\'inici';

  @override
  String gameOverPoints(int score) {
    return '$score punts';
  }

  @override
  String get gameNewRecord => 'Rècord nou!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Ratxa de $streak dies',
      one: 'Ratxa de $streak dia',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Duplica les monedes';

  @override
  String get gameDoubleDaily => 'Duplica el premi diari';

  @override
  String get gamePlayAgain => 'Torna a jugar';

  @override
  String gameLevelReached(int level) {
    return 'Has arribat al nivell $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Has pujat $count nivells: nivell $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 monedes + tema Fusta';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Només queden $hours h, una sola vegada!';
  }

  @override
  String get boosterUndo => 'Desfés';

  @override
  String get boosterSwap => 'Canvia';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'No queden girs: neteja files per recarregar-los!';

  @override
  String get onboardingDragPiece => 'Arrossega un bloc a la quadrícula';

  @override
  String get onboardingFillLine => 'Omple una fila o una columna sencera';

  @override
  String get onboardingLinesClear => 'Les línies plenes desapareixen: punts!';

  @override
  String get coachHintCombo =>
      'Combo! Torna a netejar en 3 moviments per mantenir-lo';

  @override
  String get coachHintFever => 'FEBRE! Punts dobles mentre brilla';

  @override
  String get coachHintRotation =>
      'Girar costa una càrrega; netejar línies la recarrega';

  @override
  String get coachHintBooster => 'Consell: a baix pots fer servir potenciadors';

  @override
  String get coachHintStrategy =>
      'Consell: no ho netegis tot de cop; deixa lloc per a peces grans';

  @override
  String get dailyStreakLabel => 'Ratxa';

  @override
  String get dailyBestLabel => 'Rècord diari';

  @override
  String dailyHistoryNote(int days) {
    return 'Es guarden els últims $days dies.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Dia $day: jugat';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Dia $day: no jugat';
  }

  @override
  String get homeDailyCalendar => 'Calendari';

  @override
  String get dailyShareButton => 'Comparteix el resultat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Repte diari $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score punts · millor combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Juga: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Combo: queden $moves moviments',
      one: 'Combo: queda $moves moviment',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Resultat copiat al porta-retalls';

  @override
  String get adNotAvailable =>
      'Ara no hi ha cap vídeo disponible; torna-ho a provar d\'aquí a un moment';

  @override
  String get howToPlaySpeedTitle => 'Bonus de velocitat';

  @override
  String get howToPlaySpeedBody =>
      'Col·locar ràpid suma fins a un 30 % a cada línia netejada. El bonus baixa entre 1,5 i 4 segons i té un límit: la rapidesa compensa sense decidir la partida, i una partida lenta i acurada encara pot superar-ne una de ràpida i precipitada.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus de velocitat del $percent per cent';
  }

  @override
  String get iapDiamondsSmall => '100 diamants';

  @override
  String get iapDiamondsMedium => '350 diamants';

  @override
  String get iapDiamondsLarge => '1.000 diamants';

  @override
  String get howToPlayTitle => 'Com es juga a Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Fàcil de començar.\nPremia qui planifica.';

  @override
  String get howToPlayIntroBody =>
      'Mantén el tauler net i supera el teu rècord.';

  @override
  String get howToPlayIntroSemantics =>
      'Objectiu del joc. Mantén el tauler net i supera el teu rècord.';

  @override
  String get howToPlayDragTitle => 'Arrossega i col·loca';

  @override
  String get howToPlayDragBody =>
      'Arrossega una de les tres peces a caselles lliures. Quan hagis fet servir les tres, en rebràs tres de noves automàticament.';

  @override
  String get howToPlayClearTitle => 'Neteja línies';

  @override
  String get howToPlayClearBody =>
      'Completa una fila o una columna sencera. Les línies plenes desapareixen i deixen lloc per a la teva jugada següent.';

  @override
  String get howToPlayComboTitle => 'Encadena combos';

  @override
  String get howToPlayComboBody =>
      'Neteja una altra línia en un màxim de tres moviments. Cada combo addicional apuja el multiplicador de punts. El combo compta moviments, no segons, així que mai s\'esgota mentre penses.';

  @override
  String get howToPlayFeverTitle => 'Activa la febre';

  @override
  String get howToPlayFeverBody =>
      'Netejar línies omple el mesurador de febre. Quan és ple, la propera explosió compta doble: planifica les grans jugades.';

  @override
  String get howToPlayBoosterTitle => 'Fes servir bé els potenciadors';

  @override
  String get howToPlayBoosterBody =>
      'Els potenciadors salven partides ajustades. També pots tocar una peça de la safata per girar-la.';

  @override
  String get howToPlayDailyTitle => 'Repte diari i ratxa';

  @override
  String get howToPlayDailyBody =>
      'El repte diari fa servir les mateixes peces per a tothom. Juga cada dia per allargar la ratxa i augmentar el bonus.';

  @override
  String get howToPlayPiggyTitle => 'Omple la guardiola';

  @override
  String get howToPlayPiggyBody =>
      'Cada línia netejada omple la guardiola. Quan és plena, pots recollir les monedes gratis.';

  @override
  String get leaderboardTitle => 'Classificació';

  @override
  String get leaderboardUnreachable =>
      'Classificació no disponible.\nTorna-ho a provar amb connexió a internet.';

  @override
  String get leaderboardEmpty =>
      'Encara no hi ha cap entrada.\nSigues el primer!';

  @override
  String leaderboardSubmitting(int score) {
    return 'S\'està enviant el teu rècord ($score)…';
  }

  @override
  String get leaderboardAutoSubmit => 'El teu rècord s\'envia automàticament.';

  @override
  String get puzzleModeTitle => 'Mode trencaclosques';

  @override
  String puzzleLevelTitle(int level) {
    return 'Trencaclosques $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Moviments: $moves   •   Objectiu: $target per a 3 estrelles';
  }

  @override
  String get puzzleSolved => 'Resolt!';

  @override
  String get puzzleLeaveTitle => 'Vols sortir del trencaclosques?';

  @override
  String get puzzleLeaveBody => 'Perdràs el progrés d\'aquest trencaclosques.';

  @override
  String get puzzleKeepPlaying => 'Continua jugant';

  @override
  String get puzzleLeave => 'Surt';

  @override
  String get puzzleStuckTitle => 'Sense sortida';

  @override
  String get puzzleRestart => 'Reinicia';

  @override
  String get commonActive => 'Actiu';

  @override
  String get commonTapToActivate => 'Toca per activar';

  @override
  String get commonRestore => 'Restaura';

  @override
  String unlockForCost(int cost) {
    return '$cost per desbloquejar';
  }

  @override
  String get skinsExchangeGold => 'Canvia or';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Gira la peça';

  @override
  String get puzzleNextLevel => 'Nivell següent';

  @override
  String get puzzleBackToOverview => 'Torna a la llista';

  @override
  String get puzzleUnsolvable => 'Des d\'aquí ja no es pot buidar el tauler.';

  @override
  String get puzzleExtraMoveVideo => 'Moviment extra (vídeo)';

  @override
  String puzzleSolvedCount(int solved) {
    String _temp0 = intl.Intl.pluralLogic(
      solved,
      locale: localeName,
      other: '$solved resolts',
      one: '$solved resolt',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Configuració';

  @override
  String get storageFailureTitle => 'Qubble no pot carregar la partida desada';

  @override
  String get storageFailureBody =>
      'Reinicia l\'app. Si l\'error continua, només queda reinstal·lar-la. Pots informar de l\'error des de Configuració › Comentaris.';

  @override
  String get iapUnavailable => 'Aquesta oferta no està disponible ara.';

  @override
  String get iapFailed => 'La compra no s\'ha completat. No s\'ha cobrat res.';

  @override
  String get settingsResetProgress => 'Reinicia el progrés';

  @override
  String get settingsResetProgressSubtitle =>
      'La puntuació, les monedes, el nivell i el progrés tornen a l\'inici. Es conserven les compres, el nom i els cosmètics.';

  @override
  String get settingsResetConfirmTitle => 'Vols reiniciar el progrés?';

  @override
  String get settingsResetConfirmBody =>
      'S\'esborraran el rècord, les monedes, el nivell, la ratxa i tot el progrés. No es pot desfer.\n\nEs conserven les compres, el nom i els temes i skins desbloquejats.';

  @override
  String get settingsResetConfirmAction => 'Reinicia';

  @override
  String get settingsResetDone => 'Progrés reiniciat.';

  @override
  String get settingsSectionGame => 'Joc';

  @override
  String get settingsSectionSoundHaptics => 'So i vibració';

  @override
  String get settingsSectionReminders => 'Recordatoris';

  @override
  String get settingsSectionPurchases => 'Compres';

  @override
  String get settingsSectionHelpOut => 'Col·labora';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionLanguage => 'Idioma';

  @override
  String get settingsGuide => 'Com es juga';

  @override
  String get settingsGuideSubtitle => 'Regles, combos, febre i potenciadors';

  @override
  String get settingsSound => 'So';

  @override
  String get settingsMusic => 'Música';

  @override
  String get settingsHaptics => 'Vibració';

  @override
  String get settingsHapticsOff => 'Desactivada';

  @override
  String get settingsHapticsLight => 'Suau';

  @override
  String get settingsHapticsStrong => 'Forta';

  @override
  String get settingsSectionAccessibility => 'Comoditat';

  @override
  String get settingsReducedEffects => 'Efectes reduïts';

  @override
  String get settingsReducedEffectsHint =>
      'Menys partícules, sense tremolor de pantalla ni brillantor';

  @override
  String get settingsNotifications => 'Notificacions';

  @override
  String get settingsNotificationsSubtitle =>
      'Recordatori diari i protecció de la ratxa';

  @override
  String get settingsNotificationsSystemHint =>
      'Permet-les a la configuració del sistema.';

  @override
  String get settingsLanguageSystem => 'Idioma del sistema';

  @override
  String get settingsSupporterThanks => 'Col·laborador: gràcies!';

  @override
  String get settingsSupporterPack => 'Pack de suport';

  @override
  String get settingsSupporterPackSubtitle =>
      'Tema i skin exclusius + 1.500 monedes';

  @override
  String get settingsRestorePurchases => 'Restaura les compres';

  @override
  String get settingsRestoring => 'S\'estan restaurant les compres…';

  @override
  String get settingsRateApp => 'Valora l\'app';

  @override
  String get settingsRateAppSubtitle => 'Deixa una valoració a la botiga';

  @override
  String get settingsStoreUnavailable =>
      'La botiga no està disponible en aquest dispositiu.';

  @override
  String get settingsFeedback => 'Envia comentaris';

  @override
  String get settingsFeedbackSubtitle => 'Envia idees i errors (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Privadesa dels anuncis';

  @override
  String get settingsAdPrivacySubtitle =>
      'Mira o canvia el consentiment d\'anuncis';

  @override
  String get settingsAdPrivacyUnavailable =>
      'En aquest dispositiu no calen opcions d\'anuncis.';

  @override
  String get settingsPrivacy => 'Política de privadesa';

  @override
  String get settingsImprint => 'Avís legal';

  @override
  String get settingsPageOpenFailed => 'No s\'ha pogut obrir la pàgina.';

  @override
  String get settingsFooter => 'Qubble • Trencaclosques de blocs offline';

  @override
  String get settingsAdminSection => 'Admin (prova)';

  @override
  String get settingsAdminEnabled => 'Mode admin activat';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Toca $count vegades més per al mode admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins monedes';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Només per a proves; mai en captures de la versió final';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount monedes';
  }

  @override
  String get settingsAdminResetCoins => 'Posa les monedes a 0';

  @override
  String get feedbackTitle => 'Comentaris';

  @override
  String get feedbackIntroShort =>
      'Què t\'agrada, què et molesta, què hi falta? Els detalls petits també ajuden: com més concret, millor.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Només s\'adjunten $build i el tipus de dispositiu, per saber a quina versió et refereixes.';
  }

  @override
  String get feedbackSendByMail => 'Envia per correu';

  @override
  String get feedbackPreferGithub => 'Prefereixo una issue a GitHub';

  @override
  String get feedbackThanksMail => 'Gràcies! Només has d\'enviar el missatge.';

  @override
  String get feedbackNoMailApp =>
      'No s\'ha trobat cap app de correu. Prova l\'opció de GitHub de sota.';

  @override
  String get feedbackEmptyHint => 'Primer escriu alguna cosa.';

  @override
  String get leaderboardRefresh => 'Actualitza';

  @override
  String get leaderboardRetry => 'Torna-ho a provar';

  @override
  String get feedbackHint => 'Els teus comentaris…';

  @override
  String get feedbackSubmit => 'Envia comentaris';

  @override
  String get feedbackOpenFailed =>
      'No s\'ha pogut obrir GitHub. Torna-ho a provar més tard.';

  @override
  String get feedbackGithubNote =>
      'S\'obre GitHub: toca-hi \"Submit new issue\". (Cal iniciar sessió a GitHub una vegada.)';

  @override
  String get shopTitle => 'Botiga';

  @override
  String get shopWebDemoNote =>
      'Les compres només estan disponibles a l\'app de Play Store. Aquesta versió web és una demo gratuïta: igualment la pots jugar sencera aquí.';

  @override
  String get shopSupporterExplainer =>
      'Qubble no mostra anuncis obligatoris: mai no has de comprar res. El pack de suport (tema Aurora, skin Cristall, 1.500 monedes i insígnia de col·laborador) és un agraïment per donar suport al joc. Les compres estan vinculades al teu compte de la botiga i es poden restaurar en qualsevol moment.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + skin Cristall + 1.500 monedes';

  @override
  String get themesTitle => 'Temes';

  @override
  String get themesSupporterOnly =>
      'Exclusiu del pack de suport (mira la botiga)';

  @override
  String get themesInSupporterPack => 'Al pack de suport';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'No tens prou monedes (en necessites $cost, en tens $coins)';
  }

  @override
  String get skinsTitle => 'Skins de blocs';

  @override
  String get skinsNotEnoughDiamonds =>
      'No tens prou diamants (canvia or a sota)';

  @override
  String get skinsNotEnoughCoins => 'No tens prou monedes';

  @override
  String get skinsNotEnoughGold => 'No tens prou or.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold d\'or = 1 diamant. Els diamants desbloquegen les millors skins: pren-t\'ho amb calma per reunir-los.';
  }

  @override
  String get statsTitle => 'Estadístiques';

  @override
  String get statsAverageScore => 'Mitjana';

  @override
  String get statsBestCombo => 'Millor combo';

  @override
  String get statsGames => 'Partides';

  @override
  String get statsLinesCleared => 'Files netejades';

  @override
  String get statsPiecesPlaced => 'Peces col·locades';

  @override
  String get statsCoins => 'Monedes';

  @override
  String get missionsTitle => 'Missions';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Col·loca $countString peces';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Neteja $countString files';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Aconsegueix un combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Supera $countString punts en una partida';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Juga $countString partides';
  }

  @override
  String get achievementsTitle => 'Assoliments';

  @override
  String get achievementFirstGameTitle => 'Primera partida';

  @override
  String get achievementFirstGameBody => 'Juga la teva primera partida';

  @override
  String get achievementGames25Title => 'Habitual';

  @override
  String get achievementGames25Body => 'Juga 25 partides';

  @override
  String get achievementGames100Title => 'Enganxat';

  @override
  String get achievementGames100Body => 'Juga 100 partides';

  @override
  String get achievementScore1kTitle => 'Escalador';

  @override
  String get achievementScore1kBody => 'Arriba a 1.000 punts';

  @override
  String get achievementScore5kTitle => 'Professional';

  @override
  String get achievementScore5kBody => 'Arriba a 5.000 punts';

  @override
  String get achievementScore10kTitle => 'Mestre';

  @override
  String get achievementScore10kBody => 'Arriba a 10.000 punts';

  @override
  String get achievementScore25kTitle => 'Llegenda';

  @override
  String get achievementScore25kBody => 'Arriba a 25.000 punts';

  @override
  String get achievementLines100Title => 'Endreçat';

  @override
  String get achievementLines100Body => 'Neteja 100 files en total';

  @override
  String get achievementLines1000Title => 'Neteja a fons';

  @override
  String get achievementLines1000Body => 'Neteja 1.000 files en total';

  @override
  String get achievementCombo5Title => 'Aprenent de combos';

  @override
  String get achievementCombo5Body => 'Aconsegueix un combo x5';

  @override
  String get achievementCombo10Title => 'Rei del combo';

  @override
  String get achievementCombo10Body => 'Aconsegueix un combo x10';

  @override
  String get achievementLevel10Title => 'Experimentat';

  @override
  String get achievementLevel10Body => 'Arriba al nivell 10';

  @override
  String get achievementLevel20Title => 'Veterà';

  @override
  String get achievementLevel20Body => 'Arriba al nivell 20';

  @override
  String get achievementStreak7Title => 'Ratxa setmanal';

  @override
  String get achievementStreak7Body => 'Una ratxa diària de 7 dies';

  @override
  String get achievementStreak30Title => 'Ratxa mensual';

  @override
  String get achievementStreak30Body => 'Una ratxa diària de 30 dies';

  @override
  String get achievementPuzzles10Title => 'Ment lògica';

  @override
  String get achievementPuzzles10Body => 'Resol 10 trencaclosques';

  @override
  String get achievementPieces5000Title => 'Constructor';

  @override
  String get achievementPieces5000Body => 'Col·loca 5.000 peces';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'La teva ratxa de $streak dies està en perill!',
      one: 'La teva ratxa de $streak dia està en perill!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Ahir no vas jugar. Salva la ratxa:';

  @override
  String get streakRepairFailed => 'No es pot reparar.';

  @override
  String comebackGift(int coins) {
    return 'Quina alegria tornar-te a veure! +$coins monedes';
  }

  @override
  String get notificationsOptInTitle => 'Recordatoris?';

  @override
  String get notificationsOptInBody =>
      'Vols que et recordem el repte diari i protegim la teva ratxa? Ho pots canviar quan vulguis a la configuració.';

  @override
  String get notificationsOptInAccept => 'Sí, si us plau';

  @override
  String get notificationChannelDescription =>
      'Recordatori diari, avís de ratxa, retorn';

  @override
  String get notificationDailyTitle => 'El teu repte diari t\'espera 🧩';

  @override
  String get notificationDailyBody => 'Juga el repte d\'avui!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 La teva ratxa de $streak dies està en perill!',
      one: '🔥 La teva ratxa de $streak dia està en perill!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Juga avui per mantenir-la.';

  @override
  String get notificationComebackTitle => 'Els teus blocs t\'esperen 🧩';

  @override
  String get notificationComebackBody => 'Torna i recull un regal!';

  @override
  String get iapSupporterPack => 'Pack de suport';

  @override
  String get iapCoinsSmall => '500 monedes';

  @override
  String get iapCoinsMedium => '2.000 monedes';

  @override
  String get iapCoinsLarge => '6.000 monedes';

  @override
  String get iapStarterPack => 'Pack d\'inici';

  @override
  String get iapRename => 'Canvi de nom';

  @override
  String get iapNeonTheme => 'Tema Neó';

  @override
  String get settingsLeaderboardDelete =>
      'Esborra l\'entrada de la classificació';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Treu el teu nom i la puntuació de la llista pública';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Vols esborrar la teva entrada?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'El teu nom i la puntuació es trauran de la classificació. El progrés al joc no canvia. Pots tornar a la classificació quan vulguis.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'S\'ha esborrat la teva entrada de la classificació.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'No s\'ha pogut esborrar l\'entrada. Revisa la connexió i torna-ho a provar.';

  @override
  String get leaderboardReport => 'Denuncia aquest nom';

  @override
  String get leaderboardBlock => 'Bloqueja';

  @override
  String leaderboardBlocked(String name) {
    return '$name està amagat per a tu';
  }

  @override
  String get leaderboardUndo => 'Desfés';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entrades amagades per tu',
      one: '$count entrada amagada per tu',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Torna-les a mostrar';

  @override
  String get leaderboardReportUnavailable => 'Ara no es pot denunciar.';

  @override
  String get leaderboardReportSent => 'Gràcies, la denúncia és de camí.';

  @override
  String get leaderboardRules =>
      'Els noms són públics. Res d\'insults ni ofenses, i res que identifiqui una persona real. Els noms que no ho compleixin s\'eliminen.';

  @override
  String get leaderboardRulesAccept => 'Entesos';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked de $total desbloquejats';
  }

  @override
  String get settingsSectionData => 'Dades desades';

  @override
  String get gameRotatePiece => 'Gira la peça';

  @override
  String get themeClassic => 'Clàssic';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neó';

  @override
  String get themeOcean => 'Oceà';

  @override
  String get themeWood => 'Fusta';

  @override
  String get themeSunset => 'Posta de sol';

  @override
  String get themeForest => 'Bosc';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Clàssic';

  @override
  String get skinGradient => 'Degradat';

  @override
  String get skinOutline => 'Contorn';

  @override
  String get skinGlossy => 'Brillant';

  @override
  String get skinStripe => 'Ratlles';

  @override
  String get skinBevel => 'Relleu';

  @override
  String get skinGlow => 'Resplendor';

  @override
  String get skinCrystal => 'Cristall';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skin $name';
  }
}
