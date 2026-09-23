// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class L10nIt extends L10n {
  L10nIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Gioca';

  @override
  String get commonLater => 'Più tardi';

  @override
  String get commonNotNow => 'Non ora';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonBuy => 'Acquista';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonCollect => 'Riscuoti';

  @override
  String get nameNewName => 'Nuovo nome';

  @override
  String get nameFieldLabel => 'Nome';

  @override
  String get piggyFullTitle => 'Il salvadanaio è pieno!';

  @override
  String get piggyKeepSaving => 'Continua a risparmiare';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins su $capacity raccolte.';
  }

  @override
  String get homeContinueRun => 'Continua';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Ho capito';

  @override
  String get commonHome => 'Home';

  @override
  String get commonScore => 'PUNTI';

  @override
  String get commonBest => 'RECORD';

  @override
  String commonLevelShort(int level) {
    return 'Livello $level';
  }

  @override
  String get homeNewRun => 'Inizia una nuova partita';

  @override
  String get homeBackToExit => 'Premi di nuovo indietro per uscire';

  @override
  String get homeEnableLeaderboard => 'Entra in classifica';

  @override
  String get homeBestScore => 'RECORD';

  @override
  String get homeDailyChallenge => 'Sfida del giorno';

  @override
  String get homeDailyOpenToday => 'Da giocare oggi';

  @override
  String homeDailyNextIn(String time) {
    return 'Prossima sfida tra $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Serie di $streak giorni',
      one: 'Serie di $streak giorno',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Classifica';

  @override
  String get homePuzzleMode => 'Modalità puzzle';

  @override
  String get homeMissions => 'Missioni';

  @override
  String get homeThemes => 'Temi';

  @override
  String get homeSkins => 'Skin';

  @override
  String get homeHowToPlay => 'Come si gioca a Qubble';

  @override
  String get homeWeekendBonus => 'Weekend: monete doppie!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Livello $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Cambia nome';

  @override
  String get nameChangeExplainer =>
      'Il tuo nome è la tua identità in classifica, per questo è fisso. Puoi acquistare un cambio di nome una tantum.';

  @override
  String get nameChangeAfterPurchase =>
      'Dopo l’acquisto, tocca di nuovo il tuo nome per cambiarlo.';

  @override
  String get nameJoinedLeaderboard => 'Ora sei in classifica.';

  @override
  String get nameRenameUnavailable =>
      'Al momento non è possibile cambiare nome.';

  @override
  String nameProblemTooShort(int min) {
    return 'Almeno $min caratteri.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Al massimo $max caratteri.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Solo lettere senza accenti (A–Z), numeri, spazi, _ e -.';

  @override
  String get nameProblemOffensive => 'Scegli un altro nome, per favore.';

  @override
  String get piggyTitle => 'Salvadanaio';

  @override
  String get piggyFillingHint =>
      'Il tuo salvadanaio si riempie mentre elimini righe.';

  @override
  String piggyCollect(int coins) {
    return 'Riscuoti $coins monete, gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Quando è pieno puoi svuotarlo gratis, oppure aprirlo prima con un video bonus.';

  @override
  String get piggyOpenNow => 'Apri ora';

  @override
  String get gameNewPiecesVideo => 'Nuovi pezzi (video)';

  @override
  String get gameTapBoardCell => 'Tocca una casella della griglia';

  @override
  String get gameDailyChallengeLabel => 'SFIDA DEL GIORNO';

  @override
  String get gameOver => 'Partita finita';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Ti mancano $missing monete per la bomba.';
  }

  @override
  String get gameBombNotHere => 'La bomba qui ora non funziona.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Ti mancano $missing monete.';
  }

  @override
  String get gameNotRightNow => 'Non è possibile ora.';

  @override
  String get gameRunSaved => 'Partita salvata: “Continua” nel menu.';

  @override
  String get gameOverNoFit => 'Nessuno dei tuoi pezzi entra più nella griglia.';

  @override
  String get gameOverNoFitNoRotations =>
      'Nessuno dei tuoi pezzi entra, e le rotazioni sono finite.';

  @override
  String get gameStarterOfferUnavailable => 'Non disponibile al momento';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — prendilo';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Obiettivo: $title';
  }

  @override
  String get gameBestSubmitted => 'Nuovo record inviato';

  @override
  String get gameReviveFor => 'Continua a giocare · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Sbloccato: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pacchetto iniziale';

  @override
  String gameOverPoints(int score) {
    return '$score punti';
  }

  @override
  String get gameNewRecord => 'Nuovo record!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Serie di $streak giorni',
      one: 'Serie di $streak giorno',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Raddoppia le monete';

  @override
  String get gameDoubleDaily => 'Raddoppia il premio';

  @override
  String get gamePlayAgain => 'Gioca ancora';

  @override
  String gameLevelReached(int level) {
    return 'Livello $level raggiunto!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Sei salito di $count livelli: livello $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 monete + tema Legno';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Solo $hours h rimaste, offerta unica!';
  }

  @override
  String get boosterUndo => 'Annulla';

  @override
  String get boosterSwap => 'Cambia';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Rotazioni finite: elimina righe per ricaricarle!';

  @override
  String get onboardingDragPiece => 'Trascina un blocco sulla griglia';

  @override
  String get onboardingFillLine => 'Riempi un’intera riga o colonna';

  @override
  String get onboardingLinesClear => 'Le linee piene spariscono: punti!';

  @override
  String get coachHintCombo =>
      'Combo! Elimina ancora entro 3 mosse per tenerla';

  @override
  String get coachHintFever => 'FEBBRE! Punti doppi finché brilla';

  @override
  String get coachHintRotation =>
      'Ruotare costa una carica; eliminare linee la ricarica';

  @override
  String get coachHintBooster =>
      'Suggerimento: qui sotto puoi usare i potenziamenti';

  @override
  String get coachHintStrategy =>
      'Suggerimento: non eliminare tutto subito, lascia spazio ai pezzi grandi';

  @override
  String get dailyStreakLabel => 'Serie';

  @override
  String get dailyBestLabel => 'Record del giorno';

  @override
  String dailyHistoryNote(int days) {
    return 'Vengono conservati gli ultimi $days giorni.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Giorno $day: giocato';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Giorno $day: non giocato';
  }

  @override
  String get homeDailyCalendar => 'Calendario';

  @override
  String get dailyShareButton => 'Condividi risultato';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Sfida del giorno $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score punti · combo migliore x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Gioca: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Combo: restano $moves mosse',
      one: 'Combo: resta $moves mossa',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Risultato copiato negli appunti';

  @override
  String get adNotAvailable =>
      'Nessun video disponibile al momento: riprova tra poco';

  @override
  String get howToPlaySpeedTitle => 'Bonus velocità';

  @override
  String get howToPlaySpeedBody =>
      'Piazzare in fretta aggiunge fino al 30 % a ogni linea eliminata. Il bonus cala tra 1,5 e 4 secondi ed è limitato: la velocità paga senza decidere la partita, e una partita lenta e ragionata può ancora battere una veloce e frettolosa.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus velocità del $percent per cento';
  }

  @override
  String get iapDiamondsSmall => '100 diamanti';

  @override
  String get iapDiamondsMedium => '350 diamanti';

  @override
  String get iapDiamondsLarge => '1.000 diamanti';

  @override
  String get howToPlayTitle => 'Come si gioca a Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Facile da iniziare.\nPremia chi pensa in anticipo.';

  @override
  String get howToPlayIntroBody =>
      'Tieni libera la griglia e batti il tuo record.';

  @override
  String get howToPlayIntroSemantics =>
      'Obiettivo del gioco. Tieni libera la griglia e batti il tuo record.';

  @override
  String get howToPlayDragTitle => 'Trascina e piazza';

  @override
  String get howToPlayDragBody =>
      'Trascina uno dei tre pezzi su caselle libere. Quando li hai usati tutti e tre, ne ricevi tre nuovi automaticamente.';

  @override
  String get howToPlayClearTitle => 'Elimina le linee';

  @override
  String get howToPlayClearBody =>
      'Completa un’intera riga o colonna. Le linee piene spariscono e fanno spazio alla mossa successiva.';

  @override
  String get howToPlayComboTitle => 'Concatena le combo';

  @override
  String get howToPlayComboBody =>
      'Elimina un’altra linea entro tre mosse. Ogni combo in più aumenta il tuo moltiplicatore di punti. La combo conta le mosse, non i secondi, quindi non scade mai mentre pensi.';

  @override
  String get howToPlayFeverTitle => 'Scatena la febbre';

  @override
  String get howToPlayFeverBody =>
      'Eliminare linee riempie l’indicatore della febbre. Quando è pieno, la prossima esplosione vale doppio: prepara le tue grandi mosse.';

  @override
  String get howToPlayBoosterTitle => 'Usa bene i potenziamenti';

  @override
  String get howToPlayBoosterBody =>
      'I potenziamenti salvano le partite difficili. Puoi anche toccare un pezzo nel vassoio per ruotarlo.';

  @override
  String get howToPlayDailyTitle => 'Sfida del giorno e serie';

  @override
  String get howToPlayDailyBody =>
      'La sfida del giorno usa gli stessi pezzi per tutti. Gioca ogni giorno per allungare la tua serie e il bonus.';

  @override
  String get howToPlayPiggyTitle => 'Riempi il salvadanaio';

  @override
  String get howToPlayPiggyBody =>
      'Ogni linea eliminata riempie il tuo salvadanaio. Quando è pieno, puoi riscuotere le monete gratis.';

  @override
  String get leaderboardTitle => 'Classifica';

  @override
  String get leaderboardUnreachable =>
      'Classifica non disponibile.\nRiprova con una connessione a Internet.';

  @override
  String get leaderboardEmpty => 'Ancora nessuno qui.\nSii il primo!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Invio del tuo record ($score) in corso…';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Il tuo record viene inviato automaticamente.';

  @override
  String get puzzleModeTitle => 'Modalità puzzle';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puzzle $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Mosse: $moves   •   Obiettivo: $target per 3 stelle';
  }

  @override
  String get puzzleSolved => 'Risolto!';

  @override
  String get puzzleLeaveTitle => 'Uscire dal puzzle?';

  @override
  String get puzzleLeaveBody => 'Perderai i progressi di questo puzzle.';

  @override
  String get puzzleKeepPlaying => 'Continua a giocare';

  @override
  String get puzzleLeave => 'Esci';

  @override
  String get puzzleStuckTitle => 'Bloccato';

  @override
  String get puzzleRestart => 'Ricomincia';

  @override
  String get commonActive => 'Attivo';

  @override
  String get commonTapToActivate => 'Tocca per attivare';

  @override
  String get commonRestore => 'Ripristina';

  @override
  String unlockForCost(int cost) {
    return '$cost per sbloccare';
  }

  @override
  String get skinsExchangeGold => 'Scambia oro';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Ruota pezzo';

  @override
  String get puzzleNextLevel => 'Livello successivo';

  @override
  String get puzzleBackToOverview => 'Torna all’elenco';

  @override
  String get puzzleUnsolvable => 'Da qui la griglia non si può più svuotare.';

  @override
  String get puzzleExtraMoveVideo => 'Mossa extra (video)';

  @override
  String puzzleSolvedCount(int solved) {
    String _temp0 = intl.Intl.pluralLogic(
      solved,
      locale: localeName,
      other: '$solved risolti',
      one: '$solved risolto',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get storageFailureTitle =>
      'Qubble non riesce a caricare il salvataggio';

  @override
  String get storageFailureBody =>
      'Riavvia l’app. Se l’errore continua, aiuta solo reinstallarla. Puoi segnalarlo da Impostazioni › Feedback.';

  @override
  String get iapUnavailable => 'Questa offerta non è disponibile al momento.';

  @override
  String get iapFailed =>
      'L’acquisto non è andato a buon fine. Non è stato addebitato nulla.';

  @override
  String get settingsResetProgress => 'Azzera progressi';

  @override
  String get settingsResetProgressSubtitle =>
      'Punteggio, monete, livello e progressi tornano all’inizio. Acquisti, nome e oggetti estetici restano.';

  @override
  String get settingsResetConfirmTitle => 'Azzerare i progressi?';

  @override
  String get settingsResetConfirmBody =>
      'Record, monete, livello, serie e tutti i progressi verranno eliminati. L’operazione non si può annullare.\n\nI tuoi acquisti, il tuo nome e i temi e le skin sbloccati restano.';

  @override
  String get settingsResetConfirmAction => 'Azzera';

  @override
  String get settingsResetDone => 'Progressi azzerati.';

  @override
  String get settingsSectionGame => 'Gioco';

  @override
  String get settingsSectionSoundHaptics => 'Suono e vibrazione';

  @override
  String get settingsSectionReminders => 'Promemoria';

  @override
  String get settingsSectionPurchases => 'Acquisti';

  @override
  String get settingsSectionHelpOut => 'Dai una mano';

  @override
  String get settingsSectionLegal => 'Note legali';

  @override
  String get settingsSectionLanguage => 'Lingua';

  @override
  String get settingsGuide => 'Come si gioca';

  @override
  String get settingsGuideSubtitle => 'Regole, combo, febbre e potenziamenti';

  @override
  String get settingsSound => 'Suono';

  @override
  String get settingsMusic => 'Musica';

  @override
  String get settingsHaptics => 'Vibrazione';

  @override
  String get settingsHapticsOff => 'Disattivata';

  @override
  String get settingsHapticsLight => 'Leggera';

  @override
  String get settingsHapticsStrong => 'Forte';

  @override
  String get settingsSectionAccessibility => 'Comfort';

  @override
  String get settingsReducedEffects => 'Effetti ridotti';

  @override
  String get settingsReducedEffectsHint =>
      'Meno particelle, niente scosse dello schermo né bagliori';

  @override
  String get settingsNotifications => 'Notifiche';

  @override
  String get settingsNotificationsSubtitle =>
      'Promemoria giornaliero e protezione della serie';

  @override
  String get settingsNotificationsSystemHint =>
      'Consentile nelle impostazioni di sistema.';

  @override
  String get settingsLanguageSystem => 'Lingua di sistema';

  @override
  String get settingsSupporterThanks => 'Sostenitore: grazie!';

  @override
  String get settingsSupporterPack => 'Pacchetto sostenitore';

  @override
  String get settingsSupporterPackSubtitle =>
      'Tema e skin esclusivi + 1.500 monete';

  @override
  String get settingsRestorePurchases => 'Ripristina acquisti';

  @override
  String get settingsRestoring => 'Ripristino degli acquisti…';

  @override
  String get settingsRateApp => 'Valuta l’app';

  @override
  String get settingsRateAppSubtitle => 'Lascia una valutazione nello store';

  @override
  String get settingsStoreUnavailable =>
      'Lo store non è disponibile su questo dispositivo.';

  @override
  String get settingsFeedback => 'Invia feedback';

  @override
  String get settingsFeedbackSubtitle => 'Segnala idee e bug (tramite GitHub)';

  @override
  String get settingsAdPrivacy => 'Privacy degli annunci';

  @override
  String get settingsAdPrivacySubtitle =>
      'Vedi o modifica il consenso agli annunci';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Su questo dispositivo non servono opzioni per gli annunci.';

  @override
  String get settingsPrivacy => 'Informativa sulla privacy';

  @override
  String get settingsImprint => 'Note legali';

  @override
  String get settingsPageOpenFailed => 'Impossibile aprire la pagina.';

  @override
  String get settingsFooter => 'Qubble • Puzzle a blocchi offline';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Modalità admin attivata';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Tocca ancora $count volte per la modalità admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins monete';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Solo per test, mai negli screenshot della versione finale';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount monete';
  }

  @override
  String get settingsAdminResetCoins => 'Azzera monete';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Cosa ti piace, cosa ti dà fastidio, cosa manca? Anche i dettagli piccoli aiutano: più sei concreto, meglio è.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Vengono allegati solo $build e il tipo di dispositivo, così so di quale versione parli.';
  }

  @override
  String get feedbackSendByMail => 'Invia per e-mail';

  @override
  String get feedbackPreferGithub => 'Preferisco una issue su GitHub';

  @override
  String get feedbackThanksMail => 'Grazie! Ora invia il messaggio.';

  @override
  String get feedbackNoMailApp =>
      'Nessuna app di posta trovata. Prova l’opzione GitHub qui sotto.';

  @override
  String get feedbackEmptyHint => 'Scrivi prima qualcosa.';

  @override
  String get leaderboardRefresh => 'Aggiorna';

  @override
  String get leaderboardRetry => 'Riprova';

  @override
  String get feedbackHint => 'Il tuo feedback…';

  @override
  String get feedbackSubmit => 'Invia feedback';

  @override
  String get feedbackOpenFailed =>
      'Impossibile aprire GitHub. Riprova più tardi.';

  @override
  String get feedbackGithubNote =>
      'Si apre GitHub: lì tocca \"Submit new issue\". (Serve un accesso a GitHub una volta sola.)';

  @override
  String get shopTitle => 'Negozio';

  @override
  String get shopWebDemoNote =>
      'Gli acquisti sono disponibili solo nell’app del Play Store. Questa versione web è una demo gratuita: puoi comunque giocarla tutta qui.';

  @override
  String get shopSupporterExplainer =>
      'Qubble non mostra pubblicità obbligatoria: non devi mai comprare nulla. Il pacchetto sostenitore (tema Aurora, skin Cristallo, 1.500 monete, badge sostenitore) è un grazie per aver sostenuto il gioco. Gli acquisti sono legati al tuo account dello store e possono essere ripristinati in qualsiasi momento.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + skin Cristallo + 1.500 monete';

  @override
  String get themesTitle => 'Temi';

  @override
  String get themesSupporterOnly =>
      'Esclusivo del pacchetto sostenitore (vedi negozio)';

  @override
  String get themesInSupporterPack => 'Nel pacchetto sostenitore';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Monete insufficienti (ne servono $cost, ne hai $coins)';
  }

  @override
  String get skinsTitle => 'Skin dei blocchi';

  @override
  String get skinsNotEnoughDiamonds =>
      'Diamanti insufficienti (scambia oro qui sotto)';

  @override
  String get skinsNotEnoughCoins => 'Monete insufficienti';

  @override
  String get skinsNotEnoughGold => 'Oro insufficiente.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold oro = 1 diamante. I diamanti sbloccano le skin più belle: prenditi il tuo tempo per raccoglierli.';
  }

  @override
  String get statsTitle => 'Statistiche';

  @override
  String get statsAverageScore => 'Media punti';

  @override
  String get statsBestCombo => 'Combo migliore';

  @override
  String get statsGames => 'Partite';

  @override
  String get statsLinesCleared => 'Righe eliminate';

  @override
  String get statsPiecesPlaced => 'Pezzi piazzati';

  @override
  String get statsCoins => 'Monete';

  @override
  String get missionsTitle => 'Missioni';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Piazza $countString pezzi';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Elimina $countString righe';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Raggiungi una combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Supera $countString punti in una partita';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Gioca $countString partite';
  }

  @override
  String get achievementsTitle => 'Obiettivi';

  @override
  String get achievementFirstGameTitle => 'Prima partita';

  @override
  String get achievementFirstGameBody => 'Gioca la tua prima partita';

  @override
  String get achievementGames25Title => 'Abituale';

  @override
  String get achievementGames25Body => 'Gioca 25 partite';

  @override
  String get achievementGames100Title => 'Appassionato';

  @override
  String get achievementGames100Body => 'Gioca 100 partite';

  @override
  String get achievementScore1kTitle => 'Scalatore';

  @override
  String get achievementScore1kBody => 'Raggiungi 1.000 punti';

  @override
  String get achievementScore5kTitle => 'Professionista';

  @override
  String get achievementScore5kBody => 'Raggiungi 5.000 punti';

  @override
  String get achievementScore10kTitle => 'Maestro';

  @override
  String get achievementScore10kBody => 'Raggiungi 10.000 punti';

  @override
  String get achievementScore25kTitle => 'Leggenda';

  @override
  String get achievementScore25kBody => 'Raggiungi 25.000 punti';

  @override
  String get achievementLines100Title => 'Ordinato';

  @override
  String get achievementLines100Body => 'Elimina 100 righe in totale';

  @override
  String get achievementLines1000Title => 'Pulizie di primavera';

  @override
  String get achievementLines1000Body => 'Elimina 1.000 righe in totale';

  @override
  String get achievementCombo5Title => 'Apprendista combo';

  @override
  String get achievementCombo5Body => 'Raggiungi una combo x5';

  @override
  String get achievementCombo10Title => 'Re delle combo';

  @override
  String get achievementCombo10Body => 'Raggiungi una combo x10';

  @override
  String get achievementLevel10Title => 'Esperto';

  @override
  String get achievementLevel10Body => 'Raggiungi il livello 10';

  @override
  String get achievementLevel20Title => 'Veterano';

  @override
  String get achievementLevel20Body => 'Raggiungi il livello 20';

  @override
  String get achievementStreak7Title => 'Settimana perfetta';

  @override
  String get achievementStreak7Body => 'Una serie giornaliera di 7 giorni';

  @override
  String get achievementStreak30Title => 'Mese perfetto';

  @override
  String get achievementStreak30Body => 'Una serie giornaliera di 30 giorni';

  @override
  String get achievementPuzzles10Title => 'Mente brillante';

  @override
  String get achievementPuzzles10Body => 'Risolvi 10 puzzle';

  @override
  String get achievementPieces5000Title => 'Costruttore';

  @override
  String get achievementPieces5000Body => 'Piazza 5.000 pezzi';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'La tua serie di $streak giorni è a rischio!',
      one: 'La tua serie di $streak giorno è a rischio!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Ieri non hai giocato. Salva la tua serie:';

  @override
  String get streakRepairFailed => 'Impossibile recuperarla.';

  @override
  String comebackGift(int coins) {
    return 'Bentornato! +$coins monete';
  }

  @override
  String get notificationsOptInTitle => 'Promemoria?';

  @override
  String get notificationsOptInBody =>
      'Vuoi che ti ricordiamo la sfida del giorno e proteggiamo la tua serie? Puoi cambiarlo quando vuoi nelle impostazioni.';

  @override
  String get notificationsOptInAccept => 'Sì, grazie';

  @override
  String get notificationChannelDescription =>
      'Promemoria giornaliero, avviso serie, ritorno';

  @override
  String get notificationDailyTitle => 'La tua sfida del giorno ti aspetta 🧩';

  @override
  String get notificationDailyBody => 'Gioca la sfida di oggi!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 La tua serie di $streak giorni è a rischio!',
      one: '🔥 La tua serie di $streak giorno è a rischio!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Gioca oggi per mantenerla.';

  @override
  String get notificationComebackTitle => 'I tuoi blocchi ti aspettano 🧩';

  @override
  String get notificationComebackBody => 'Torna e ritira un regalo!';

  @override
  String get iapSupporterPack => 'Pacchetto sostenitore';

  @override
  String get iapCoinsSmall => '500 monete';

  @override
  String get iapCoinsMedium => '2.000 monete';

  @override
  String get iapCoinsLarge => '6.000 monete';

  @override
  String get iapStarterPack => 'Pacchetto iniziale';

  @override
  String get iapRename => 'Cambio nome';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Elimina voce in classifica';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Rimuove nome e punteggio dalla lista pubblica';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Eliminare la tua voce?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Il tuo nome e il tuo punteggio verranno rimossi dalla classifica. I tuoi progressi nel gioco non cambiano. Puoi rientrare in classifica quando vuoi.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'La tua voce in classifica è stata eliminata.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Impossibile eliminare la voce. Controlla la connessione e riprova.';

  @override
  String get leaderboardReport => 'Segnala questo nome';

  @override
  String get leaderboardBlock => 'Blocca';

  @override
  String leaderboardBlocked(String name) {
    return '$name è nascosto per te';
  }

  @override
  String get leaderboardUndo => 'Annulla';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count voci nascoste da te',
      one: '$count voce nascosta da te',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Mostra di nuovo';

  @override
  String get leaderboardReportUnavailable =>
      'Al momento non è possibile segnalare.';

  @override
  String get leaderboardReportSent =>
      'Grazie, la tua segnalazione è stata inviata.';

  @override
  String get leaderboardRules =>
      'I nomi sono pubblici. Niente insulti, niente offese e niente che identifichi una persona reale. I nomi che violano questa regola vengono rimossi.';

  @override
  String get leaderboardRulesAccept => 'Ho capito';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked di $total sbloccati';
  }

  @override
  String get settingsSectionData => 'Dati salvati';

  @override
  String get gameRotatePiece => 'Ruota pezzo';

  @override
  String get themeClassic => 'Classico';

  @override
  String get themeFade => 'Pastello';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Oceano';

  @override
  String get themeWood => 'Legno';

  @override
  String get themeSunset => 'Tramonto';

  @override
  String get themeForest => 'Foresta';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Classico';

  @override
  String get skinGradient => 'Sfumato';

  @override
  String get skinOutline => 'Contorno';

  @override
  String get skinGlossy => 'Lucido';

  @override
  String get skinStripe => 'Strisce';

  @override
  String get skinBevel => 'Rilievo';

  @override
  String get skinGlow => 'Bagliore';

  @override
  String get skinCrystal => 'Cristallo';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skin $name';
  }
}
