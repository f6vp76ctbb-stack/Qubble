// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Jugar';

  @override
  String get commonLater => 'Más tarde';

  @override
  String get commonNotNow => 'Ahora no';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonBuy => 'Comprar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCollect => 'Recoger';

  @override
  String get nameNewName => 'Nuevo nombre';

  @override
  String get nameFieldLabel => 'Nombre';

  @override
  String get piggyFullTitle => '¡La alcancía está llena!';

  @override
  String get piggyKeepSaving => 'Seguir ahorrando';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins de $capacity reunidas.';
  }

  @override
  String get homeContinueRun => 'Continuar';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Entendido';

  @override
  String get commonHome => 'Inicio';

  @override
  String get commonScore => 'PUNTOS';

  @override
  String get commonBest => 'RÉCORD';

  @override
  String commonLevelShort(int level) {
    return 'Nivel $level';
  }

  @override
  String get homeNewRun => 'Empezar una partida nueva';

  @override
  String get homeBackToExit => 'Pulsa atrás otra vez para salir';

  @override
  String get homeEnableLeaderboard => 'Unirse a la clasificación';

  @override
  String get homeBestScore => 'RÉCORD';

  @override
  String get homeDailyChallenge => 'Desafío diario';

  @override
  String get homeDailyOpenToday => 'Pendiente hoy';

  @override
  String homeDailyNextIn(String time) {
    return 'Siguiente desafío en $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Racha de $streak días',
      one: 'Racha de $streak día',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Clasificación';

  @override
  String get homePuzzleMode => 'Modo rompecabezas';

  @override
  String get homeMissions => 'Misiones';

  @override
  String get homeThemes => 'Temas';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Cómo jugar a Qubble';

  @override
  String get homeWeekendBonus => 'Fin de semana: ¡monedas dobles!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Nivel $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Cambiar nombre';

  @override
  String get nameChangeExplainer =>
      'Tu nombre es tu identidad en la clasificación, por eso es fijo. Puedes comprar un cambio de nombre único.';

  @override
  String get nameChangeAfterPurchase =>
      'Después de la compra, toca tu nombre otra vez para cambiarlo.';

  @override
  String get nameJoinedLeaderboard => 'Ya estás en la clasificación.';

  @override
  String get nameRenameUnavailable =>
      'Ahora mismo no se puede cambiar el nombre.';

  @override
  String nameProblemTooShort(int min) {
    return 'Al menos $min caracteres.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Como máximo $max caracteres.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Solo letras sin tildes (A–Z), números, espacios, _ y -.';

  @override
  String get nameProblemOffensive => 'Elige otro nombre, por favor.';

  @override
  String get piggyTitle => 'Alcancía';

  @override
  String get piggyFillingHint => 'Tu alcancía se llena mientras limpias filas.';

  @override
  String piggyCollect(int coins) {
    return 'Recoge $coins monedas, gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Cuando esté llena podrás vaciarla gratis, o abrirla antes con un video extra.';

  @override
  String get piggyOpenNow => 'Abrir ahora';

  @override
  String get gameNewPiecesVideo => 'Piezas nuevas (video)';

  @override
  String get gameTapBoardCell => 'Toca una casilla del tablero';

  @override
  String get gameDailyChallengeLabel => 'DESAFÍO DIARIO';

  @override
  String get gameOver => 'Fin de la partida';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Te faltan $missing monedas para la bomba.';
  }

  @override
  String get gameBombNotHere => 'La bomba no funciona aquí ahora.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Te faltan $missing monedas para eso.';
  }

  @override
  String get gameNotRightNow => 'Ahora no es posible.';

  @override
  String get gameRunSaved => 'Partida guardada: “Continuar” en el menú.';

  @override
  String get gameOverNoFit => 'Ninguna de tus piezas cabe ya en el tablero.';

  @override
  String get gameOverNoFitNoRotations =>
      'Ninguna de tus piezas cabe, y ya no te quedan giros.';

  @override
  String get gameStarterOfferUnavailable => 'No disponible ahora';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — conseguir';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Logro: $title';
  }

  @override
  String get gameBestSubmitted => 'Nuevo récord, enviado';

  @override
  String get gameReviveFor => 'Seguir jugando · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Desbloqueado: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pack de inicio';

  @override
  String gameOverPoints(int score) {
    return '$score puntos';
  }

  @override
  String get gameNewRecord => '¡Nuevo récord!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Racha de $streak días',
      one: 'Racha de $streak día',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Duplicar monedas';

  @override
  String get gameDoubleDaily => 'Duplicar premio diario';

  @override
  String get gamePlayAgain => 'Jugar otra vez';

  @override
  String gameLevelReached(int level) {
    return '¡Nivel $level alcanzado!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Subiste $count niveles: ¡nivel $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 monedas + tema Madera';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '¡Solo quedan $hours h, una única vez!';
  }

  @override
  String get boosterUndo => 'Deshacer';

  @override
  String get boosterSwap => 'Cambiar';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'No quedan giros: ¡limpia filas para recargarlos!';

  @override
  String get onboardingDragPiece => 'Arrastra un bloque a la cuadrícula';

  @override
  String get onboardingFillLine => 'Llena una fila o columna entera';

  @override
  String get onboardingLinesClear => 'Las líneas llenas desaparecen: ¡puntos!';

  @override
  String get coachHintCombo =>
      '¡Combo! Vuelve a limpiar en 3 movimientos para mantenerlo';

  @override
  String get coachHintFever => '¡FIEBRE! Puntos dobles mientras brilla';

  @override
  String get coachHintRotation =>
      'Girar cuesta una carga; limpiar líneas la recarga';

  @override
  String get coachHintBooster => 'Consejo: abajo puedes usar potenciadores';

  @override
  String get coachHintStrategy =>
      'Consejo: no limpies todo a la vez; deja sitio para piezas grandes';

  @override
  String get dailyStreakLabel => 'Racha';

  @override
  String get dailyBestLabel => 'Récord diario';

  @override
  String dailyHistoryNote(int days) {
    return 'Se guardan los últimos $days días.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Día $day: jugado';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Día $day: no jugado';
  }

  @override
  String get homeDailyCalendar => 'Calendario';

  @override
  String get dailyShareButton => 'Compartir resultado';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Desafío diario $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score puntos · mejor combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Juega: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Combo: quedan $moves movimientos',
      one: 'Combo: queda $moves movimiento',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Resultado copiado al portapapeles';

  @override
  String get adNotAvailable =>
      'No hay ningún video disponible ahora; inténtalo de nuevo en un momento';

  @override
  String get howToPlaySpeedTitle => 'Bonus de velocidad';

  @override
  String get howToPlaySpeedBody =>
      'Colocar rápido suma hasta un 30 % a cada línea limpiada. El bonus baja entre 1,5 y 4 segundos y tiene un tope: la rapidez compensa sin decidir la partida, y una partida lenta y cuidadosa aún puede superar a una rápida y apresurada.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus de velocidad del $percent por ciento';
  }

  @override
  String get iapDiamondsSmall => '100 diamantes';

  @override
  String get iapDiamondsMedium => '350 diamantes';

  @override
  String get iapDiamondsLarge => '1.000 diamantes';

  @override
  String get howToPlayTitle => 'Cómo jugar a Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Fácil de empezar.\nPremia a quien planifica.';

  @override
  String get howToPlayIntroBody =>
      'Mantén el tablero despejado y supera tu récord.';

  @override
  String get howToPlayIntroSemantics =>
      'Objetivo del juego. Mantén el tablero despejado y supera tu récord.';

  @override
  String get howToPlayDragTitle => 'Arrastra y coloca';

  @override
  String get howToPlayDragBody =>
      'Arrastra una de las tres piezas a casillas libres. Cuando hayas usado las tres, recibirás tres nuevas automáticamente.';

  @override
  String get howToPlayClearTitle => 'Limpia líneas';

  @override
  String get howToPlayClearBody =>
      'Completa una fila o columna entera. Las líneas llenas desaparecen y dejan sitio para tu siguiente jugada.';

  @override
  String get howToPlayComboTitle => 'Encadena combos';

  @override
  String get howToPlayComboBody =>
      'Limpia otra línea en un máximo de tres movimientos. Cada combo adicional sube tu multiplicador de puntos. El combo cuenta movimientos, no segundos, así que nunca se agota mientras piensas.';

  @override
  String get howToPlayFeverTitle => 'Activa la fiebre';

  @override
  String get howToPlayFeverBody =>
      'Limpiar líneas llena el medidor de fiebre. Cuando está lleno, la siguiente explosión cuenta doble: planea tus grandes jugadas.';

  @override
  String get howToPlayBoosterTitle => 'Usa bien los potenciadores';

  @override
  String get howToPlayBoosterBody =>
      'Los potenciadores salvan partidas ajustadas. También puedes tocar una pieza de la bandeja para girarla.';

  @override
  String get howToPlayDailyTitle => 'Desafío diario y racha';

  @override
  String get howToPlayDailyBody =>
      'El desafío diario usa las mismas piezas para todos. Juega cada día para aumentar tu racha y tu bonus.';

  @override
  String get howToPlayPiggyTitle => 'Llena la alcancía';

  @override
  String get howToPlayPiggyBody =>
      'Cada línea limpiada llena tu alcancía. Cuando está llena, puedes recoger las monedas gratis.';

  @override
  String get leaderboardTitle => 'Clasificación';

  @override
  String get leaderboardUnreachable =>
      'Clasificación no disponible.\nInténtalo de nuevo con conexión a internet.';

  @override
  String get leaderboardEmpty => 'Aún no hay entradas.\n¡Sé el primero!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Se está enviando tu récord ($score)…';
  }

  @override
  String get leaderboardAutoSubmit => 'Tu récord se envía automáticamente.';

  @override
  String get puzzleModeTitle => 'Modo rompecabezas';

  @override
  String puzzleLevelTitle(int level) {
    return 'Rompecabezas $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Movimientos: $moves   •   Objetivo: $target para 3 estrellas';
  }

  @override
  String get puzzleSolved => '¡Resuelto!';

  @override
  String get puzzleLeaveTitle => '¿Salir del rompecabezas?';

  @override
  String get puzzleLeaveBody => 'Perderás tu progreso en este rompecabezas.';

  @override
  String get puzzleKeepPlaying => 'Seguir jugando';

  @override
  String get puzzleLeave => 'Salir';

  @override
  String get puzzleStuckTitle => 'Sin salida';

  @override
  String get puzzleRestart => 'Reiniciar';

  @override
  String get commonActive => 'Activo';

  @override
  String get commonTapToActivate => 'Toca para activar';

  @override
  String get commonRestore => 'Restaurar';

  @override
  String unlockForCost(int cost) {
    return '$cost para desbloquear';
  }

  @override
  String get skinsExchangeGold => 'Cambiar oro';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Girar pieza';

  @override
  String get puzzleNextLevel => 'Siguiente nivel';

  @override
  String get puzzleBackToOverview => 'Volver a la lista';

  @override
  String get puzzleUnsolvable => 'Desde aquí ya no se puede vaciar el tablero.';

  @override
  String get puzzleExtraMoveVideo => 'Movimiento extra (video)';

  @override
  String puzzleSolvedCount(int solved) {
    String _temp0 = intl.Intl.pluralLogic(
      solved,
      locale: localeName,
      other: '$solved resueltos',
      one: '$solved resuelto',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get storageFailureTitle =>
      'Qubble no puede cargar tu partida guardada';

  @override
  String get storageFailureBody =>
      'Reinicia la app. Si el error continúa, solo queda reinstalarla. Puedes informar del error desde Ajustes › Comentarios.';

  @override
  String get iapUnavailable => 'Esta oferta no está disponible ahora.';

  @override
  String get iapFailed => 'La compra no se completó. No se ha cobrado nada.';

  @override
  String get settingsResetProgress => 'Reiniciar progreso';

  @override
  String get settingsResetProgressSubtitle =>
      'Puntuación, monedas, nivel y progreso vuelven al inicio. Se conservan las compras, el nombre y los cosméticos.';

  @override
  String get settingsResetConfirmTitle => '¿Reiniciar progreso?';

  @override
  String get settingsResetConfirmBody =>
      'Se borrarán el récord, las monedas, el nivel, la racha y todo el progreso. No se puede deshacer.\n\nSe conservan tus compras, tu nombre y los temas y skins desbloqueados.';

  @override
  String get settingsResetConfirmAction => 'Reiniciar';

  @override
  String get settingsResetDone => 'Progreso reiniciado.';

  @override
  String get settingsSectionGame => 'Juego';

  @override
  String get settingsSectionSoundHaptics => 'Sonido y vibración';

  @override
  String get settingsSectionReminders => 'Recordatorios';

  @override
  String get settingsSectionPurchases => 'Compras';

  @override
  String get settingsSectionHelpOut => 'Colabora';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionLanguage => 'Idioma';

  @override
  String get settingsGuide => 'Cómo jugar';

  @override
  String get settingsGuideSubtitle => 'Reglas, combos, fiebre y potenciadores';

  @override
  String get settingsSound => 'Sonido';

  @override
  String get settingsMusic => 'Música';

  @override
  String get settingsHaptics => 'Vibración';

  @override
  String get settingsHapticsOff => 'Desactivada';

  @override
  String get settingsHapticsLight => 'Suave';

  @override
  String get settingsHapticsStrong => 'Fuerte';

  @override
  String get settingsSectionAccessibility => 'Comodidad';

  @override
  String get settingsReducedEffects => 'Efectos reducidos';

  @override
  String get settingsReducedEffectsHint =>
      'Menos partículas, sin temblor de pantalla ni brillo';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsNotificationsSubtitle =>
      'Recordatorio diario y protección de racha';

  @override
  String get settingsNotificationsSystemHint =>
      'Permítelas en los ajustes del sistema.';

  @override
  String get settingsLanguageSystem => 'Idioma del sistema';

  @override
  String get settingsSupporterThanks => 'Colaborador: ¡gracias!';

  @override
  String get settingsSupporterPack => 'Pack de apoyo';

  @override
  String get settingsSupporterPackSubtitle =>
      'Tema y skin exclusivos + 1.500 monedas';

  @override
  String get settingsRestorePurchases => 'Restaurar compras';

  @override
  String get settingsRestoring => 'Restaurando compras…';

  @override
  String get settingsRateApp => 'Valorar la app';

  @override
  String get settingsRateAppSubtitle => 'Deja una valoración en la tienda';

  @override
  String get settingsStoreUnavailable =>
      'La tienda no está disponible en este dispositivo.';

  @override
  String get settingsFeedback => 'Enviar comentarios';

  @override
  String get settingsFeedbackSubtitle => 'Envía ideas y errores (vía GitHub)';

  @override
  String get settingsAdPrivacy => 'Privacidad de anuncios';

  @override
  String get settingsAdPrivacySubtitle =>
      'Ver o cambiar tu consentimiento de anuncios';

  @override
  String get settingsAdPrivacyUnavailable =>
      'En este dispositivo no hacen falta opciones de anuncios.';

  @override
  String get settingsPrivacy => 'Política de privacidad';

  @override
  String get settingsImprint => 'Aviso legal';

  @override
  String get settingsPageOpenFailed => 'No se pudo abrir la página.';

  @override
  String get settingsFooter => 'Qubble • Puzzle de bloques offline';

  @override
  String get settingsAdminSection => 'Admin (prueba)';

  @override
  String get settingsAdminEnabled => 'Modo admin activado';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Toca $count veces más para el modo admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins monedas';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Solo para pruebas; nunca en capturas de la versión final';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount monedas';
  }

  @override
  String get settingsAdminResetCoins => 'Poner monedas a 0';

  @override
  String get feedbackTitle => 'Comentarios';

  @override
  String get feedbackIntroShort =>
      '¿Qué te gusta, qué te molesta, qué falta? Los detalles pequeños también ayudan: cuanto más concreto, mejor.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Solo se adjuntan $build y el tipo de dispositivo, para saber a qué versión te refieres.';
  }

  @override
  String get feedbackSendByMail => 'Enviar por correo';

  @override
  String get feedbackPreferGithub => 'Prefiero una issue en GitHub';

  @override
  String get feedbackThanksMail =>
      '¡Gracias! Solo tienes que enviar el mensaje.';

  @override
  String get feedbackNoMailApp =>
      'No se encontró ninguna app de correo. Prueba la opción de GitHub de abajo.';

  @override
  String get feedbackEmptyHint => 'Escribe algo primero.';

  @override
  String get leaderboardRefresh => 'Actualizar';

  @override
  String get leaderboardRetry => 'Reintentar';

  @override
  String get feedbackHint => 'Tus comentarios…';

  @override
  String get feedbackSubmit => 'Enviar comentarios';

  @override
  String get feedbackOpenFailed =>
      'No se pudo abrir GitHub. Inténtalo más tarde.';

  @override
  String get feedbackGithubNote =>
      'Se abre GitHub: toca allí \"Submit new issue\". (Hace falta iniciar sesión en GitHub una vez).';

  @override
  String get shopTitle => 'Tienda';

  @override
  String get shopWebDemoNote =>
      'Las compras solo están disponibles en la app de Play Store. Esta versión web es una demo gratuita: aun así puedes jugarla completa aquí.';

  @override
  String get shopSupporterExplainer =>
      'Qubble no muestra anuncios obligatorios: nunca tienes que comprar nada. El pack de apoyo (tema Aurora, skin Cristal, 1.500 monedas e insignia de colaborador) es un agradecimiento por apoyar el juego. Las compras están vinculadas a tu cuenta de la tienda y se pueden restaurar en cualquier momento.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + skin Cristal + 1.500 monedas';

  @override
  String get themesTitle => 'Temas';

  @override
  String get themesSupporterOnly => 'Exclusivo del pack de apoyo (ver tienda)';

  @override
  String get themesInSupporterPack => 'En el pack de apoyo';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'No tienes suficientes monedas (necesitas $cost, tienes $coins)';
  }

  @override
  String get skinsTitle => 'Skins de bloques';

  @override
  String get skinsNotEnoughDiamonds =>
      'No tienes suficientes diamantes (cambia oro abajo)';

  @override
  String get skinsNotEnoughCoins => 'No tienes suficientes monedas';

  @override
  String get skinsNotEnoughGold => 'No tienes suficiente oro.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold de oro = 1 diamante. Los diamantes desbloquean las mejores skins: tómate tu tiempo para reunirlos.';
  }

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get statsAverageScore => 'Media';

  @override
  String get statsBestCombo => 'Mejor combo';

  @override
  String get statsGames => 'Partidas';

  @override
  String get statsLinesCleared => 'Filas limpiadas';

  @override
  String get statsPiecesPlaced => 'Piezas colocadas';

  @override
  String get statsCoins => 'Monedas';

  @override
  String get missionsTitle => 'Misiones';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Coloca $countString piezas';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Limpia $countString filas';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Consigue un combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Supera $countString puntos en una partida';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Juega $countString partidas';
  }

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get achievementFirstGameTitle => 'Primera partida';

  @override
  String get achievementFirstGameBody => 'Juega tu primera partida';

  @override
  String get achievementGames25Title => 'Habitual';

  @override
  String get achievementGames25Body => 'Juega 25 partidas';

  @override
  String get achievementGames100Title => 'Enganchado';

  @override
  String get achievementGames100Body => 'Juega 100 partidas';

  @override
  String get achievementScore1kTitle => 'Escalador';

  @override
  String get achievementScore1kBody => 'Alcanza 1.000 puntos';

  @override
  String get achievementScore5kTitle => 'Profesional';

  @override
  String get achievementScore5kBody => 'Alcanza 5.000 puntos';

  @override
  String get achievementScore10kTitle => 'Maestro';

  @override
  String get achievementScore10kBody => 'Alcanza 10.000 puntos';

  @override
  String get achievementScore25kTitle => 'Leyenda';

  @override
  String get achievementScore25kBody => 'Alcanza 25.000 puntos';

  @override
  String get achievementLines100Title => 'Ordenado';

  @override
  String get achievementLines100Body => 'Limpia 100 filas en total';

  @override
  String get achievementLines1000Title => 'Limpieza a fondo';

  @override
  String get achievementLines1000Body => 'Limpia 1.000 filas en total';

  @override
  String get achievementCombo5Title => 'Aprendiz de combos';

  @override
  String get achievementCombo5Body => 'Consigue un combo x5';

  @override
  String get achievementCombo10Title => 'Rey del combo';

  @override
  String get achievementCombo10Body => 'Consigue un combo x10';

  @override
  String get achievementLevel10Title => 'Experimentado';

  @override
  String get achievementLevel10Body => 'Alcanza el nivel 10';

  @override
  String get achievementLevel20Title => 'Veterano';

  @override
  String get achievementLevel20Body => 'Alcanza el nivel 20';

  @override
  String get achievementStreak7Title => 'Racha semanal';

  @override
  String get achievementStreak7Body => 'Una racha diaria de 7 días';

  @override
  String get achievementStreak30Title => 'Racha mensual';

  @override
  String get achievementStreak30Body => 'Una racha diaria de 30 días';

  @override
  String get achievementPuzzles10Title => 'Mente lógica';

  @override
  String get achievementPuzzles10Body => 'Resuelve 10 rompecabezas';

  @override
  String get achievementPieces5000Title => 'Constructor';

  @override
  String get achievementPieces5000Body => 'Coloca 5.000 piezas';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '¡Tu racha de $streak días está en peligro!',
      one: '¡Tu racha de $streak día está en peligro!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Ayer no jugaste. Rescata tu racha:';

  @override
  String get streakRepairFailed => 'No se puede reparar.';

  @override
  String comebackGift(int coins) {
    return '¡Qué bueno verte de nuevo! +$coins monedas';
  }

  @override
  String get notificationsOptInTitle => '¿Recordatorios?';

  @override
  String get notificationsOptInBody =>
      '¿Quieres que te recordemos el desafío diario y protejamos tu racha? Puedes cambiarlo cuando quieras en los ajustes.';

  @override
  String get notificationsOptInAccept => 'Sí, por favor';

  @override
  String get notificationChannelDescription =>
      'Recordatorio diario, aviso de racha, regreso';

  @override
  String get notificationDailyTitle => 'Tu desafío diario te espera 🧩';

  @override
  String get notificationDailyBody => '¡Juega el desafío de hoy!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 ¡Tu racha de $streak días está en peligro!',
      one: '🔥 ¡Tu racha de $streak día está en peligro!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Juega hoy para mantenerla.';

  @override
  String get notificationComebackTitle => 'Tus bloques te esperan 🧩';

  @override
  String get notificationComebackBody => '¡Vuelve y recoge un regalo!';

  @override
  String get iapSupporterPack => 'Pack de apoyo';

  @override
  String get iapCoinsSmall => '500 monedas';

  @override
  String get iapCoinsMedium => '2.000 monedas';

  @override
  String get iapCoinsLarge => '6.000 monedas';

  @override
  String get iapStarterPack => 'Pack de inicio';

  @override
  String get iapRename => 'Cambio de nombre';

  @override
  String get iapNeonTheme => 'Tema Neón';

  @override
  String get settingsLeaderboardDelete => 'Borrar entrada de la clasificación';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Quita tu nombre y puntuación de la lista pública';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => '¿Borrar tu entrada?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tu nombre y tu puntuación se quitarán de la clasificación. Tu progreso en el juego no cambia. Puedes volver a la clasificación cuando quieras.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Se borró tu entrada de la clasificación.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'No se pudo borrar la entrada. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get leaderboardReport => 'Denunciar este nombre';

  @override
  String get leaderboardBlock => 'Bloquear';

  @override
  String leaderboardBlocked(String name) {
    return '$name está oculto para ti';
  }

  @override
  String get leaderboardUndo => 'Deshacer';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas ocultadas por ti',
      one: '$count entrada ocultada por ti',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Mostrar de nuevo';

  @override
  String get leaderboardReportUnavailable => 'Ahora no se puede denunciar.';

  @override
  String get leaderboardReportSent => 'Gracias, tu denuncia está en camino.';

  @override
  String get leaderboardRules =>
      'Los nombres son públicos. Nada de insultos ni ofensas, y nada que identifique a una persona real. Los nombres que incumplan esto se eliminan.';

  @override
  String get leaderboardRulesAccept => 'Entendido';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked de $total desbloqueados';
  }

  @override
  String get settingsSectionData => 'Datos guardados';

  @override
  String get gameRotatePiece => 'Girar pieza';

  @override
  String get themeClassic => 'Clásico';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neón';

  @override
  String get themeOcean => 'Océano';

  @override
  String get themeWood => 'Madera';

  @override
  String get themeSunset => 'Atardecer';

  @override
  String get themeForest => 'Bosque';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Clásico';

  @override
  String get skinGradient => 'Degradado';

  @override
  String get skinOutline => 'Contorno';

  @override
  String get skinGlossy => 'Brillo';

  @override
  String get skinStripe => 'Rayas';

  @override
  String get skinBevel => 'Relieve';

  @override
  String get skinGlow => 'Resplandor';

  @override
  String get skinCrystal => 'Cristal';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skin $name';
  }
}
