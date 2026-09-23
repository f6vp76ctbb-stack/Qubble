// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class L10nPt extends L10n {
  L10nPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Jogar';

  @override
  String get commonLater => 'Depois';

  @override
  String get commonNotNow => 'Agora não';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonBuy => 'Comprar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonCollect => 'Coletar';

  @override
  String get nameNewName => 'Novo nome';

  @override
  String get nameFieldLabel => 'Nome';

  @override
  String get piggyFullTitle => 'O cofrinho está cheio!';

  @override
  String get piggyKeepSaving => 'Continuar guardando';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins de $capacity guardadas.';
  }

  @override
  String get homeContinueRun => 'Continuar';

  @override
  String get homeVideo => 'Vídeo';

  @override
  String get commonGotIt => 'Entendi';

  @override
  String get commonHome => 'Início';

  @override
  String get commonScore => 'PONTOS';

  @override
  String get commonBest => 'RECORDE';

  @override
  String commonLevelShort(int level) {
    return 'Nível $level';
  }

  @override
  String get homeNewRun => 'Começar uma nova partida';

  @override
  String get homeBackToExit => 'Toque em voltar de novo para sair';

  @override
  String get homeEnableLeaderboard => 'Entrar no ranking';

  @override
  String get homeBestScore => 'RECORDE';

  @override
  String get homeDailyChallenge => 'Desafio diário';

  @override
  String get homeDailyOpenToday => 'Disponível hoje';

  @override
  String homeDailyNextIn(String time) {
    return 'Próximo desafio em $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Sequência de $streak dias',
      one: 'Sequência de $streak dia',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Ranking';

  @override
  String get homePuzzleMode => 'Modo quebra-cabeça';

  @override
  String get homeMissions => 'Missões';

  @override
  String get homeThemes => 'Temas';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Como jogar Qubble';

  @override
  String get homeWeekendBonus => 'Fim de semana: moedas em dobro!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Nível $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Mudar nome';

  @override
  String get nameChangeExplainer =>
      'Seu nome é sua identidade no ranking, por isso ele é fixo. Você pode comprar uma troca de nome única.';

  @override
  String get nameChangeAfterPurchase =>
      'Depois da compra, toque no seu nome de novo para mudá-lo.';

  @override
  String get nameJoinedLeaderboard => 'Agora você está no ranking.';

  @override
  String get nameRenameUnavailable => 'Não é possível mudar o nome agora.';

  @override
  String nameProblemTooShort(int min) {
    return 'No mínimo $min caracteres.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'No máximo $max caracteres.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Só letras sem acento (A–Z), números, espaços, _ e -.';

  @override
  String get nameProblemOffensive => 'Escolha outro nome, por favor.';

  @override
  String get piggyTitle => 'Cofrinho';

  @override
  String get piggyFillingHint =>
      'Seu cofrinho enche enquanto você limpa fileiras.';

  @override
  String piggyCollect(int coins) {
    return 'Colete $coins moedas, de graça.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Quando estiver cheio, você pode esvaziá-lo de graça, ou abrir antes com um vídeo bônus.';

  @override
  String get piggyOpenNow => 'Abrir agora';

  @override
  String get gameNewPiecesVideo => 'Peças novas (vídeo)';

  @override
  String get gameTapBoardCell => 'Toque em uma casa do tabuleiro';

  @override
  String get gameDailyChallengeLabel => 'DESAFIO DIÁRIO';

  @override
  String get gameOver => 'Fim de jogo';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Faltam $missing moedas para a bomba.';
  }

  @override
  String get gameBombNotHere => 'A bomba não funciona aqui agora.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Faltam $missing moedas para isso.';
  }

  @override
  String get gameNotRightNow => 'Não é possível agora.';

  @override
  String get gameRunSaved => 'Partida salva: “Continuar” no menu.';

  @override
  String get gameOverNoFit => 'Nenhuma das suas peças cabe mais no tabuleiro.';

  @override
  String get gameOverNoFitNoRotations =>
      'Nenhuma das suas peças cabe, e os giros acabaram.';

  @override
  String get gameStarterOfferUnavailable => 'Indisponível no momento';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — quero';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Conquista: $title';
  }

  @override
  String get gameBestSubmitted => 'Novo recorde, enviado';

  @override
  String get gameReviveFor => 'Continuar jogando · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Desbloqueado: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pacote inicial';

  @override
  String gameOverPoints(int score) {
    return '$score pontos';
  }

  @override
  String get gameNewRecord => 'Novo recorde!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Sequência de $streak dias',
      one: 'Sequência de $streak dia',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Dobrar moedas';

  @override
  String get gameDoubleDaily => 'Dobrar prêmio diário';

  @override
  String get gamePlayAgain => 'Jogar de novo';

  @override
  String gameLevelReached(int level) {
    return 'Nível $level alcançado!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Você subiu $count níveis: nível $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 moedas + tema Madeira';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Só faltam $hours h, oferta única!';
  }

  @override
  String get boosterUndo => 'Desfazer';

  @override
  String get boosterSwap => 'Trocar';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Sem giros: limpe fileiras para recarregar!';

  @override
  String get onboardingDragPiece => 'Arraste um bloco para a grade';

  @override
  String get onboardingFillLine => 'Complete uma fileira ou coluna inteira';

  @override
  String get onboardingLinesClear => 'Linhas cheias somem: pontos!';

  @override
  String get coachHintCombo =>
      'Combo! Limpe de novo em até 3 jogadas para mantê-lo';

  @override
  String get coachHintFever => 'FEBRE! Pontos em dobro enquanto brilha';

  @override
  String get coachHintRotation =>
      'Girar gasta uma carga; limpar linhas recarrega';

  @override
  String get coachHintBooster => 'Dica: você pode usar reforços logo abaixo';

  @override
  String get coachHintStrategy =>
      'Dica: não limpe tudo de uma vez; deixe espaço para peças grandes';

  @override
  String get dailyStreakLabel => 'Sequência';

  @override
  String get dailyBestLabel => 'Recorde diário';

  @override
  String dailyHistoryNote(int days) {
    return 'Os últimos $days dias ficam salvos.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Dia $day: jogado';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Dia $day: não jogado';
  }

  @override
  String get homeDailyCalendar => 'Calendário';

  @override
  String get dailyShareButton => 'Compartilhar resultado';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Desafio diário $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score pontos · melhor combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Jogue: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Combo: restam $moves jogadas',
      one: 'Combo: resta $moves jogada',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied =>
      'Resultado copiado para a área de transferência';

  @override
  String get adNotAvailable =>
      'Nenhum vídeo disponível agora; tente de novo em instantes';

  @override
  String get howToPlaySpeedTitle => 'Bônus de velocidade';

  @override
  String get howToPlaySpeedBody =>
      'Colocar peças rápido soma até 30 % a cada linha limpa. O bônus cai entre 1,5 e 4 segundos e tem um teto: ser rápido compensa sem decidir o jogo, e uma partida calma e cuidadosa ainda pode vencer uma rápida e apressada.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bônus de velocidade de $percent por cento';
  }

  @override
  String get iapDiamondsSmall => '100 diamantes';

  @override
  String get iapDiamondsMedium => '350 diamantes';

  @override
  String get iapDiamondsLarge => '1.000 diamantes';

  @override
  String get howToPlayTitle => 'Como jogar Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Fácil de começar.\nRecompensa quem planeja.';

  @override
  String get howToPlayIntroBody =>
      'Mantenha o tabuleiro livre e supere seu recorde.';

  @override
  String get howToPlayIntroSemantics =>
      'Objetivo do jogo. Mantenha o tabuleiro livre e supere seu recorde.';

  @override
  String get howToPlayDragTitle => 'Arraste e coloque';

  @override
  String get howToPlayDragBody =>
      'Arraste uma das três peças para casas livres. Quando usar as três, você recebe três novas automaticamente.';

  @override
  String get howToPlayClearTitle => 'Limpe linhas';

  @override
  String get howToPlayClearBody =>
      'Complete uma fileira ou coluna inteira. Linhas cheias somem e abrem espaço para a próxima jogada.';

  @override
  String get howToPlayComboTitle => 'Encadeie combos';

  @override
  String get howToPlayComboBody =>
      'Limpe outra linha em até três jogadas. Cada combo seguido aumenta seu multiplicador de pontos. O combo conta jogadas, não segundos, então nunca acaba enquanto você pensa.';

  @override
  String get howToPlayFeverTitle => 'Ative a febre';

  @override
  String get howToPlayFeverBody =>
      'Limpar linhas enche o medidor de febre. Quando ele está cheio, a próxima explosão vale o dobro: planeje suas grandes jogadas.';

  @override
  String get howToPlayBoosterTitle => 'Use os reforços com sabedoria';

  @override
  String get howToPlayBoosterBody =>
      'Reforços salvam partidas apertadas. Você também pode tocar em uma peça da bandeja para girá-la.';

  @override
  String get howToPlayDailyTitle => 'Desafio diário e sequência';

  @override
  String get howToPlayDailyBody =>
      'O desafio diário usa as mesmas peças para todos. Jogue todos os dias para aumentar sua sequência e seu bônus.';

  @override
  String get howToPlayPiggyTitle => 'Encha o cofrinho';

  @override
  String get howToPlayPiggyBody =>
      'Cada linha limpa enche seu cofrinho. Quando estiver cheio, você pode coletar as moedas de graça.';

  @override
  String get leaderboardTitle => 'Ranking';

  @override
  String get leaderboardUnreachable =>
      'Ranking indisponível.\nTente de novo com conexão à internet.';

  @override
  String get leaderboardEmpty => 'Ainda não há ninguém.\nSeja o primeiro!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Seu recorde ($score) está sendo enviado…';
  }

  @override
  String get leaderboardAutoSubmit => 'Seu recorde é enviado automaticamente.';

  @override
  String get puzzleModeTitle => 'Modo quebra-cabeça';

  @override
  String puzzleLevelTitle(int level) {
    return 'Quebra-cabeça $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Jogadas: $moves   •   Meta: $target para 3 estrelas';
  }

  @override
  String get puzzleSolved => 'Resolvido!';

  @override
  String get puzzleLeaveTitle => 'Sair do quebra-cabeça?';

  @override
  String get puzzleLeaveBody =>
      'Seu progresso neste quebra-cabeça será perdido.';

  @override
  String get puzzleKeepPlaying => 'Continuar jogando';

  @override
  String get puzzleLeave => 'Sair';

  @override
  String get puzzleStuckTitle => 'Sem saída';

  @override
  String get puzzleRestart => 'Recomeçar';

  @override
  String get commonActive => 'Ativo';

  @override
  String get commonTapToActivate => 'Toque para ativar';

  @override
  String get commonRestore => 'Restaurar';

  @override
  String unlockForCost(int cost) {
    return '$cost para desbloquear';
  }

  @override
  String get skinsExchangeGold => 'Trocar ouro';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Girar peça';

  @override
  String get puzzleNextLevel => 'Próximo nível';

  @override
  String get puzzleBackToOverview => 'Voltar à lista';

  @override
  String get puzzleUnsolvable => 'Daqui não dá mais para esvaziar o tabuleiro.';

  @override
  String get puzzleExtraMoveVideo => 'Jogada extra (vídeo)';

  @override
  String puzzleSolvedCount(int solved) {
    String _temp0 = intl.Intl.pluralLogic(
      solved,
      locale: localeName,
      other: '$solved resolvidos',
      one: '$solved resolvido',
      zero: '$solved resolvidos',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get storageFailureTitle =>
      'O Qubble não consegue carregar seu jogo salvo';

  @override
  String get storageFailureBody =>
      'Reinicie o app. Se o erro continuar, só reinstalar resolve. Você pode relatar o erro em Configurações › Feedback.';

  @override
  String get iapUnavailable => 'Esta oferta não está disponível agora.';

  @override
  String get iapFailed => 'A compra não foi concluída. Nada foi cobrado.';

  @override
  String get settingsResetProgress => 'Redefinir progresso';

  @override
  String get settingsResetProgressSubtitle =>
      'Pontuação, moedas, nível e progresso voltam ao início. Compras, nome e cosméticos são mantidos.';

  @override
  String get settingsResetConfirmTitle => 'Redefinir progresso?';

  @override
  String get settingsResetConfirmBody =>
      'Recorde, moedas, nível, sequência e todo o progresso serão apagados. Isso não pode ser desfeito.\n\nSuas compras, seu nome e os temas e skins desbloqueados são mantidos.';

  @override
  String get settingsResetConfirmAction => 'Redefinir';

  @override
  String get settingsResetDone => 'Progresso redefinido.';

  @override
  String get settingsSectionGame => 'Jogo';

  @override
  String get settingsSectionSoundHaptics => 'Som e vibração';

  @override
  String get settingsSectionReminders => 'Lembretes';

  @override
  String get settingsSectionPurchases => 'Compras';

  @override
  String get settingsSectionHelpOut => 'Ajude o jogo';

  @override
  String get settingsSectionLegal => 'Informações legais';

  @override
  String get settingsSectionLanguage => 'Idioma';

  @override
  String get settingsGuide => 'Como jogar';

  @override
  String get settingsGuideSubtitle => 'Regras, combos, febre e reforços';

  @override
  String get settingsSound => 'Som';

  @override
  String get settingsMusic => 'Música';

  @override
  String get settingsHaptics => 'Vibração';

  @override
  String get settingsHapticsOff => 'Desligada';

  @override
  String get settingsHapticsLight => 'Leve';

  @override
  String get settingsHapticsStrong => 'Forte';

  @override
  String get settingsSectionAccessibility => 'Conforto';

  @override
  String get settingsReducedEffects => 'Efeitos reduzidos';

  @override
  String get settingsReducedEffectsHint =>
      'Menos partículas, sem tremor de tela e sem brilho';

  @override
  String get settingsNotifications => 'Notificações';

  @override
  String get settingsNotificationsSubtitle =>
      'Lembrete diário e proteção da sequência';

  @override
  String get settingsNotificationsSystemHint =>
      'Permita nas configurações do sistema.';

  @override
  String get settingsLanguageSystem => 'Idioma do sistema';

  @override
  String get settingsSupporterThanks => 'Apoiador: obrigado!';

  @override
  String get settingsSupporterPack => 'Pacote Apoiador';

  @override
  String get settingsSupporterPackSubtitle =>
      'Tema e skin exclusivos + 1.500 moedas';

  @override
  String get settingsRestorePurchases => 'Restaurar compras';

  @override
  String get settingsRestoring => 'Restaurando compras…';

  @override
  String get settingsRateApp => 'Avaliar o app';

  @override
  String get settingsRateAppSubtitle => 'Deixe uma avaliação na loja';

  @override
  String get settingsStoreUnavailable =>
      'A loja não está disponível neste aparelho.';

  @override
  String get settingsFeedback => 'Enviar feedback';

  @override
  String get settingsFeedbackSubtitle => 'Envie ideias e bugs (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Privacidade de anúncios';

  @override
  String get settingsAdPrivacySubtitle =>
      'Ver ou mudar seu consentimento de anúncios';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Neste aparelho não são necessárias opções de anúncios.';

  @override
  String get settingsPrivacy => 'Política de privacidade';

  @override
  String get settingsImprint => 'Informações legais';

  @override
  String get settingsPageOpenFailed => 'Não foi possível abrir a página.';

  @override
  String get settingsFooter => 'Qubble • Quebra-cabeça de blocos offline';

  @override
  String get settingsAdminSection => 'Admin (teste)';

  @override
  String get settingsAdminEnabled => 'Modo admin ativado';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Toque mais $count vezes para o modo admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins moedas';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Só para testes; nunca em capturas da versão final';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount moedas';
  }

  @override
  String get settingsAdminResetCoins => 'Zerar moedas';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'Do que você gosta, o que incomoda, o que falta? Detalhes pequenos também ajudam: quanto mais concreto, melhor.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Só $build e o tipo do seu aparelho são anexados, para eu saber de qual versão você está falando.';
  }

  @override
  String get feedbackSendByMail => 'Enviar por e-mail';

  @override
  String get feedbackPreferGithub => 'Prefiro uma issue no GitHub';

  @override
  String get feedbackThanksMail => 'Obrigado! É só enviar a mensagem.';

  @override
  String get feedbackNoMailApp =>
      'Nenhum app de e-mail encontrado. Tente a opção do GitHub abaixo.';

  @override
  String get feedbackEmptyHint => 'Escreva algo primeiro.';

  @override
  String get leaderboardRefresh => 'Atualizar';

  @override
  String get leaderboardRetry => 'Tentar de novo';

  @override
  String get feedbackHint => 'Seu feedback…';

  @override
  String get feedbackSubmit => 'Enviar feedback';

  @override
  String get feedbackOpenFailed =>
      'Não foi possível abrir o GitHub. Tente mais tarde.';

  @override
  String get feedbackGithubNote =>
      'O GitHub vai abrir: toque em \"Submit new issue\" lá. (É preciso entrar no GitHub uma vez.)';

  @override
  String get shopTitle => 'Loja';

  @override
  String get shopWebDemoNote =>
      'Compras só estão disponíveis no app da Play Store. Esta versão web é uma demo gratuita: mesmo assim, você pode jogar tudo aqui.';

  @override
  String get shopSupporterExplainer =>
      'O Qubble não mostra anúncios obrigatórios: você nunca precisa comprar nada. O Pacote Apoiador (tema Aurora, skin Cristal, 1.500 moedas e selo de apoiador) é um agradecimento por apoiar o jogo. As compras ficam ligadas à sua conta da loja e podem ser restauradas a qualquer momento.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + skin Cristal + 1.500 moedas';

  @override
  String get themesTitle => 'Temas';

  @override
  String get themesSupporterOnly =>
      'Exclusivo do Pacote Apoiador (veja a loja)';

  @override
  String get themesInSupporterPack => 'No Pacote Apoiador';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Moedas insuficientes (precisa de $cost, você tem $coins)';
  }

  @override
  String get skinsTitle => 'Skins de blocos';

  @override
  String get skinsNotEnoughDiamonds =>
      'Diamantes insuficientes (troque ouro abaixo)';

  @override
  String get skinsNotEnoughCoins => 'Moedas insuficientes';

  @override
  String get skinsNotEnoughGold => 'Ouro insuficiente.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold de ouro = 1 diamante. Diamantes desbloqueiam as skins mais especiais: junte com calma.';
  }

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get statsAverageScore => 'Média';

  @override
  String get statsBestCombo => 'Melhor combo';

  @override
  String get statsGames => 'Partidas';

  @override
  String get statsLinesCleared => 'Fileiras limpas';

  @override
  String get statsPiecesPlaced => 'Peças colocadas';

  @override
  String get statsCoins => 'Moedas';

  @override
  String get missionsTitle => 'Missões';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Coloque $countString peças';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Limpe $countString fileiras';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Faça um combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Passe de $countString pontos em uma partida';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Jogue $countString partidas';
  }

  @override
  String get achievementsTitle => 'Conquistas';

  @override
  String get achievementFirstGameTitle => 'Primeira partida';

  @override
  String get achievementFirstGameBody => 'Jogue sua primeira partida';

  @override
  String get achievementGames25Title => 'Frequentador';

  @override
  String get achievementGames25Body => 'Jogue 25 partidas';

  @override
  String get achievementGames100Title => 'Viciado';

  @override
  String get achievementGames100Body => 'Jogue 100 partidas';

  @override
  String get achievementScore1kTitle => 'Escalador';

  @override
  String get achievementScore1kBody => 'Alcance 1.000 pontos';

  @override
  String get achievementScore5kTitle => 'Profissional';

  @override
  String get achievementScore5kBody => 'Alcance 5.000 pontos';

  @override
  String get achievementScore10kTitle => 'Mestre';

  @override
  String get achievementScore10kBody => 'Alcance 10.000 pontos';

  @override
  String get achievementScore25kTitle => 'Lenda';

  @override
  String get achievementScore25kBody => 'Alcance 25.000 pontos';

  @override
  String get achievementLines100Title => 'Organizado';

  @override
  String get achievementLines100Body => 'Limpe 100 fileiras no total';

  @override
  String get achievementLines1000Title => 'Faxina geral';

  @override
  String get achievementLines1000Body => 'Limpe 1.000 fileiras no total';

  @override
  String get achievementCombo5Title => 'Aprendiz de combos';

  @override
  String get achievementCombo5Body => 'Faça um combo x5';

  @override
  String get achievementCombo10Title => 'Rei do combo';

  @override
  String get achievementCombo10Body => 'Faça um combo x10';

  @override
  String get achievementLevel10Title => 'Experiente';

  @override
  String get achievementLevel10Body => 'Alcance o nível 10';

  @override
  String get achievementLevel20Title => 'Veterano';

  @override
  String get achievementLevel20Body => 'Alcance o nível 20';

  @override
  String get achievementStreak7Title => 'Semana completa';

  @override
  String get achievementStreak7Body => 'Uma sequência diária de 7 dias';

  @override
  String get achievementStreak30Title => 'Mês completo';

  @override
  String get achievementStreak30Body => 'Uma sequência diária de 30 dias';

  @override
  String get achievementPuzzles10Title => 'Mente afiada';

  @override
  String get achievementPuzzles10Body => 'Resolva 10 quebra-cabeças';

  @override
  String get achievementPieces5000Title => 'Construtor';

  @override
  String get achievementPieces5000Body => 'Coloque 5.000 peças';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Sua sequência de $streak dias está em risco!',
      one: 'Sua sequência de $streak dia está em risco!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Você não jogou ontem. Salve sua sequência:';

  @override
  String get streakRepairFailed => 'Não é possível recuperar.';

  @override
  String comebackGift(int coins) {
    return 'Que bom ter você de volta! +$coins moedas';
  }

  @override
  String get notificationsOptInTitle => 'Lembretes?';

  @override
  String get notificationsOptInBody =>
      'Quer que a gente lembre você do desafio diário e proteja sua sequência? Dá para mudar isso quando quiser nas configurações.';

  @override
  String get notificationsOptInAccept => 'Sim, por favor';

  @override
  String get notificationChannelDescription =>
      'Lembrete diário, aviso de sequência, retorno';

  @override
  String get notificationDailyTitle => 'Seu desafio diário está esperando 🧩';

  @override
  String get notificationDailyBody => 'Jogue o desafio de hoje!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 Sua sequência de $streak dias está em risco!',
      one: '🔥 Sua sequência de $streak dia está em risco!',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Jogue hoje para mantê-la.';

  @override
  String get notificationComebackTitle => 'Seus blocos estão esperando 🧩';

  @override
  String get notificationComebackBody => 'Volte e pegue um presente!';

  @override
  String get iapSupporterPack => 'Pacote Apoiador';

  @override
  String get iapCoinsSmall => '500 moedas';

  @override
  String get iapCoinsMedium => '2.000 moedas';

  @override
  String get iapCoinsLarge => '6.000 moedas';

  @override
  String get iapStarterPack => 'Pacote inicial';

  @override
  String get iapRename => 'Troca de nome';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Apagar entrada do ranking';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Remove seu nome e pontuação da lista pública';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Apagar sua entrada?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Seu nome e sua pontuação serão removidos do ranking. Seu progresso no jogo não muda. Você pode voltar ao ranking quando quiser.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Sua entrada no ranking foi apagada.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Não foi possível apagar a entrada. Verifique sua conexão e tente de novo.';

  @override
  String get leaderboardReport => 'Denunciar este nome';

  @override
  String get leaderboardBlock => 'Bloquear';

  @override
  String leaderboardBlocked(String name) {
    return '$name está oculto para você';
  }

  @override
  String get leaderboardUndo => 'Desfazer';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas ocultadas por você',
      one: '$count entrada ocultada por você',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Mostrar de novo';

  @override
  String get leaderboardReportUnavailable => 'Não é possível denunciar agora.';

  @override
  String get leaderboardReportSent => 'Obrigado, sua denúncia está a caminho.';

  @override
  String get leaderboardRules =>
      'Os nomes são públicos. Nada de insultos, ofensas ou algo que identifique uma pessoa real. Nomes que quebram esta regra são removidos.';

  @override
  String get leaderboardRulesAccept => 'Entendi';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked de $total desbloqueadas';
  }

  @override
  String get settingsSectionData => 'Dados salvos';

  @override
  String get gameRotatePiece => 'Girar peça';

  @override
  String get themeClassic => 'Clássico';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Oceano';

  @override
  String get themeWood => 'Madeira';

  @override
  String get themeSunset => 'Pôr do sol';

  @override
  String get themeForest => 'Floresta';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Clássico';

  @override
  String get skinGradient => 'Degradê';

  @override
  String get skinOutline => 'Contorno';

  @override
  String get skinGlossy => 'Brilho';

  @override
  String get skinStripe => 'Listras';

  @override
  String get skinBevel => 'Relevo';

  @override
  String get skinGlow => 'Radiante';

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
