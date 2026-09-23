// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Jouer';

  @override
  String get commonLater => 'Plus tard';

  @override
  String get commonNotNow => 'Pas maintenant';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonBuy => 'Acheter';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonCollect => 'Récupérer';

  @override
  String get nameNewName => 'Nouveau nom';

  @override
  String get nameFieldLabel => 'Nom';

  @override
  String get piggyFullTitle => 'La tirelire est pleine !';

  @override
  String get piggyKeepSaving => 'Continuer d’économiser';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins sur $capacity récoltées.';
  }

  @override
  String get homeContinueRun => 'Continuer';

  @override
  String get homeVideo => 'Vidéo';

  @override
  String get commonGotIt => 'Compris';

  @override
  String get commonHome => 'Accueil';

  @override
  String get commonScore => 'SCORE';

  @override
  String get commonBest => 'RECORD';

  @override
  String commonLevelShort(int level) {
    return 'Niveau $level';
  }

  @override
  String get homeNewRun => 'Commencer une nouvelle partie';

  @override
  String get homeBackToExit => 'Appuie encore sur retour pour quitter';

  @override
  String get homeEnableLeaderboard => 'Rejoindre le classement';

  @override
  String get homeBestScore => 'MEILLEUR SCORE';

  @override
  String get homeDailyChallenge => 'Défi du jour';

  @override
  String get homeDailyOpenToday => 'À jouer aujourd’hui';

  @override
  String homeDailyNextIn(String time) {
    return 'Prochain défi dans $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Série de $streak jours',
      one: 'Série de $streak jour',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Classement';

  @override
  String get homePuzzleMode => 'Mode puzzle';

  @override
  String get homeMissions => 'Missions';

  @override
  String get homeThemes => 'Thèmes';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'Comment jouer à Qubble';

  @override
  String get homeWeekendBonus => 'Week-end : pièces doublées !';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Niveau $level : $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Changer de nom';

  @override
  String get nameChangeExplainer =>
      'Ton nom est ton identité dans le classement, il est donc fixe. Tu peux acheter un changement de nom unique.';

  @override
  String get nameChangeAfterPurchase =>
      'Après l’achat, touche à nouveau ton nom pour le modifier.';

  @override
  String get nameJoinedLeaderboard => 'Tu es maintenant dans le classement.';

  @override
  String get nameRenameUnavailable =>
      'Impossible de changer de nom pour le moment.';

  @override
  String nameProblemTooShort(int min) {
    return 'Au moins $min caractères.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Au plus $max caractères.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Uniquement des lettres sans accent (A–Z), des chiffres, des espaces, _ et -.';

  @override
  String get nameProblemOffensive => 'Choisis un autre nom, s’il te plaît.';

  @override
  String get piggyTitle => 'Tirelire';

  @override
  String get piggyFillingHint =>
      'Ta tirelire se remplit quand tu effaces des lignes.';

  @override
  String piggyCollect(int coins) {
    return 'Récupère $coins pièces, gratuitement.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Une fois pleine, tu peux la vider gratuitement, ou l’ouvrir plus tôt avec une vidéo bonus.';

  @override
  String get piggyOpenNow => 'Ouvrir maintenant';

  @override
  String get gameNewPiecesVideo => 'Nouvelles pièces (vidéo)';

  @override
  String get gameTapBoardCell => 'Touche une case du plateau';

  @override
  String get gameDailyChallengeLabel => 'DÉFI DU JOUR';

  @override
  String get gameOver => 'Partie terminée';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Il te manque $missing pièces pour la bombe.';
  }

  @override
  String get gameBombNotHere => 'La bombe ne marche pas ici pour le moment.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Il te manque $missing pièces pour ça.';
  }

  @override
  String get gameNotRightNow => 'Impossible pour le moment.';

  @override
  String get gameRunSaved => 'Partie enregistrée : « Continuer » dans le menu.';

  @override
  String get gameOverNoFit =>
      'Plus aucune de tes pièces ne rentre sur le plateau.';

  @override
  String get gameOverNoFitNoRotations =>
      'Plus aucune de tes pièces ne rentre, et tu n’as plus de rotations.';

  @override
  String get gameStarterOfferUnavailable => 'Indisponible pour le moment';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — je le prends';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Succès : $title';
  }

  @override
  String get gameBestSubmitted => 'Nouveau record envoyé';

  @override
  String get gameReviveFor => 'Continuer · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Débloqué : $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pack de départ';

  @override
  String gameOverPoints(int score) {
    return '$score points';
  }

  @override
  String get gameNewRecord => 'Nouveau record !';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Série de $streak jours',
      one: 'Série de $streak jour',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Doubler les pièces';

  @override
  String get gameDoubleDaily => 'Doubler la récompense';

  @override
  String get gamePlayAgain => 'Rejouer';

  @override
  String gameLevelReached(int level) {
    return 'Niveau $level atteint !';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count niveaux gagnés : niveau $level !';
  }

  @override
  String get gameStarterOfferReward => '1200 pièces + thème Bois';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Plus que $hours h, offre unique !';
  }

  @override
  String get boosterUndo => 'Annuler';

  @override
  String get boosterSwap => 'Échanger';

  @override
  String get boosterBomb => 'Bombe';

  @override
  String get boosterNoRotationsLeft =>
      'Plus de rotations : efface des lignes pour recharger !';

  @override
  String get onboardingDragPiece => 'Fais glisser un bloc sur la grille';

  @override
  String get onboardingFillLine => 'Remplis une ligne ou une colonne entière';

  @override
  String get onboardingLinesClear =>
      'Les lignes pleines disparaissent : des points !';

  @override
  String get coachHintCombo =>
      'Combo ! Efface encore en 3 coups pour le garder';

  @override
  String get coachHintFever => 'FIÈVRE ! Points doublés tant que ça brille';

  @override
  String get coachHintRotation =>
      'Tourner coûte une charge ; effacer des lignes la recharge';

  @override
  String get coachHintBooster => 'Astuce : tu peux utiliser des bonus en bas';

  @override
  String get coachHintStrategy =>
      'Astuce : pas toutes les lignes d’un coup, garde de la place pour les grandes pièces';

  @override
  String get dailyStreakLabel => 'Série';

  @override
  String get dailyBestLabel => 'Record du jour';

  @override
  String dailyHistoryNote(int days) {
    return 'Les $days derniers jours sont conservés.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Le $day : joué';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Le $day : pas joué';
  }

  @override
  String get homeDailyCalendar => 'Calendrier';

  @override
  String get dailyShareButton => 'Partager le résultat';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Défi du jour $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score points · meilleur combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Jouer : $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Combo : encore $moves coups',
      one: 'Combo : encore $moves coup',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Résultat copié dans le presse-papiers';

  @override
  String get adNotAvailable =>
      'Aucune vidéo disponible pour le moment. Réessaie dans un instant';

  @override
  String get howToPlaySpeedTitle => 'Bonus de vitesse';

  @override
  String get howToPlaySpeedBody =>
      'Placer vite ajoute jusqu’à 30 % à chaque ligne effacée. Le bonus diminue entre 1,5 et 4 secondes et il est plafonné : la vitesse paie sans décider de la partie, et une partie lente et réfléchie peut encore battre une partie rapide et précipitée.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent %';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus de vitesse de $percent pour cent';
  }

  @override
  String get iapDiamondsSmall => '100 diamants';

  @override
  String get iapDiamondsMedium => '350 diamants';

  @override
  String get iapDiamondsLarge => '1 000 diamants';

  @override
  String get howToPlayTitle => 'Comment jouer à Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Facile à prendre en main.\nRécompense l’anticipation.';

  @override
  String get howToPlayIntroBody =>
      'Garde le plateau dégagé et bats ton record.';

  @override
  String get howToPlayIntroSemantics =>
      'But du jeu. Garde le plateau dégagé et bats ton record.';

  @override
  String get howToPlayDragTitle => 'Glisse et pose';

  @override
  String get howToPlayDragBody =>
      'Fais glisser l’une des trois pièces sur des cases libres. Quand les trois sont posées, tu en reçois trois nouvelles automatiquement.';

  @override
  String get howToPlayClearTitle => 'Efface des lignes';

  @override
  String get howToPlayClearBody =>
      'Remplis une ligne ou une colonne entière. Les lignes pleines disparaissent et libèrent de la place pour ton prochain coup.';

  @override
  String get howToPlayComboTitle => 'Enchaîne les combos';

  @override
  String get howToPlayComboBody =>
      'Efface une autre ligne en trois coups maximum. Chaque combo supplémentaire augmente ton multiplicateur de points. Le combo compte les coups, pas les secondes : il ne s’arrête jamais pendant que tu réfléchis.';

  @override
  String get howToPlayFeverTitle => 'Déclenche la fièvre';

  @override
  String get howToPlayFeverBody =>
      'Effacer des lignes remplit la jauge de fièvre. Quand elle est pleine, la prochaine explosion compte double : prépare tes gros coups.';

  @override
  String get howToPlayBoosterTitle => 'Utilise bien les bonus';

  @override
  String get howToPlayBoosterBody =>
      'Les bonus sauvent les parties serrées. Tu peux aussi toucher une pièce de la réserve pour la faire tourner.';

  @override
  String get howToPlayDailyTitle => 'Défi du jour et série';

  @override
  String get howToPlayDailyBody =>
      'Le défi du jour utilise les mêmes pièces pour tout le monde. Joue chaque jour pour allonger ta série et ton bonus.';

  @override
  String get howToPlayPiggyTitle => 'Remplis la tirelire';

  @override
  String get howToPlayPiggyBody =>
      'Chaque ligne effacée remplit ta tirelire. Une fois pleine, tu peux récupérer les pièces gratuitement.';

  @override
  String get leaderboardTitle => 'Classement';

  @override
  String get leaderboardUnreachable =>
      'Classement indisponible.\nRéessaie avec une connexion Internet.';

  @override
  String get leaderboardEmpty =>
      'Aucune entrée pour l’instant.\nSois le premier !';

  @override
  String leaderboardSubmitting(int score) {
    return 'Ton record ($score) est en cours d’envoi…';
  }

  @override
  String get leaderboardAutoSubmit => 'Ton record est envoyé automatiquement.';

  @override
  String get puzzleModeTitle => 'Mode puzzle';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puzzle $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Coups : $moves   •   Objectif : $target pour 3 étoiles';
  }

  @override
  String get puzzleSolved => 'Résolu !';

  @override
  String get puzzleLeaveTitle => 'Quitter le puzzle ?';

  @override
  String get puzzleLeaveBody => 'Ta progression dans ce puzzle sera perdue.';

  @override
  String get puzzleKeepPlaying => 'Continuer';

  @override
  String get puzzleLeave => 'Quitter';

  @override
  String get puzzleStuckTitle => 'Bloqué';

  @override
  String get puzzleRestart => 'Recommencer';

  @override
  String get commonActive => 'Actif';

  @override
  String get commonTapToActivate => 'Touche pour activer';

  @override
  String get commonRestore => 'Restaurer';

  @override
  String unlockForCost(int cost) {
    return '$cost pour débloquer';
  }

  @override
  String get skinsExchangeGold => 'Échanger de l’or';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Tourner la pièce';

  @override
  String get puzzleNextLevel => 'Niveau suivant';

  @override
  String get puzzleBackToOverview => 'Retour à la liste';

  @override
  String get puzzleUnsolvable =>
      'Le plateau ne peut plus être vidé à partir d’ici.';

  @override
  String get puzzleExtraMoveVideo => 'Coup bonus (vidéo)';

  @override
  String puzzleSolvedCount(int solved) {
    String _temp0 = intl.Intl.pluralLogic(
      solved,
      locale: localeName,
      other: '$solved résolus',
      one: '$solved résolu',
    );
    return '$_temp0';
  }

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get storageFailureTitle => 'Qubble ne peut pas charger ta sauvegarde';

  @override
  String get storageFailureBody =>
      'Redémarre l’application. Si l’erreur persiste, seule une réinstallation peut aider. Tu peux la signaler via Paramètres › Avis.';

  @override
  String get iapUnavailable =>
      'Cette offre n’est pas disponible pour le moment.';

  @override
  String get iapFailed => 'L’achat n’a pas abouti. Rien n’a été débité.';

  @override
  String get settingsResetProgress => 'Réinitialiser la progression';

  @override
  String get settingsResetProgressSubtitle =>
      'Score, pièces, niveau et progression reviennent au début. Les achats, le nom et les cosmétiques sont conservés.';

  @override
  String get settingsResetConfirmTitle => 'Réinitialiser la progression ?';

  @override
  String get settingsResetConfirmBody =>
      'Le meilleur score, les pièces, le niveau, la série et toute la progression seront supprimés. Impossible de revenir en arrière.\n\nTes achats, ton nom et les thèmes et skins débloqués sont conservés.';

  @override
  String get settingsResetConfirmAction => 'Réinitialiser';

  @override
  String get settingsResetDone => 'Progression réinitialisée.';

  @override
  String get settingsSectionGame => 'Jeu';

  @override
  String get settingsSectionSoundHaptics => 'Son et vibrations';

  @override
  String get settingsSectionReminders => 'Rappels';

  @override
  String get settingsSectionPurchases => 'Achats';

  @override
  String get settingsSectionHelpOut => 'Donner un coup de main';

  @override
  String get settingsSectionLegal => 'Mentions légales';

  @override
  String get settingsSectionLanguage => 'Langue';

  @override
  String get settingsGuide => 'Comment jouer';

  @override
  String get settingsGuideSubtitle => 'Règles, combos, fièvre et bonus';

  @override
  String get settingsSound => 'Son';

  @override
  String get settingsMusic => 'Musique';

  @override
  String get settingsHaptics => 'Vibrations';

  @override
  String get settingsHapticsOff => 'Désactivées';

  @override
  String get settingsHapticsLight => 'Légères';

  @override
  String get settingsHapticsStrong => 'Fortes';

  @override
  String get settingsSectionAccessibility => 'Confort';

  @override
  String get settingsReducedEffects => 'Effets réduits';

  @override
  String get settingsReducedEffectsHint =>
      'Moins de particules, pas de secousses ni de lueur';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Rappel quotidien et protection de série';

  @override
  String get settingsNotificationsSystemHint =>
      'Autorise-les dans les paramètres du système.';

  @override
  String get settingsLanguageSystem => 'Langue du système';

  @override
  String get settingsSupporterThanks => 'Soutien : merci !';

  @override
  String get settingsSupporterPack => 'Pack soutien';

  @override
  String get settingsSupporterPackSubtitle =>
      'Thème et skin exclusifs + 1 500 pièces';

  @override
  String get settingsRestorePurchases => 'Restaurer les achats';

  @override
  String get settingsRestoring => 'Restauration des achats…';

  @override
  String get settingsRateApp => 'Noter l’application';

  @override
  String get settingsRateAppSubtitle => 'Laisse une note sur le store';

  @override
  String get settingsStoreUnavailable =>
      'Le store n’est pas disponible sur cet appareil.';

  @override
  String get settingsFeedback => 'Donner ton avis';

  @override
  String get settingsFeedbackSubtitle => 'Signale idées et bugs (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Confidentialité des pubs';

  @override
  String get settingsAdPrivacySubtitle =>
      'Voir ou modifier ton consentement publicitaire';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Aucune option publicitaire n’est requise sur cet appareil.';

  @override
  String get settingsPrivacy => 'Politique de confidentialité';

  @override
  String get settingsImprint => 'Mentions légales';

  @override
  String get settingsPageOpenFailed => 'La page n’a pas pu être ouverte.';

  @override
  String get settingsFooter => 'Qubble • Puzzle de blocs hors ligne';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Mode admin activé';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Encore $count touches pour le mode admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins pièces';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Pour les tests uniquement, jamais dans les captures de la version finale';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount pièces';
  }

  @override
  String get settingsAdminResetCoins => 'Remettre les pièces à 0';

  @override
  String get feedbackTitle => 'Avis';

  @override
  String get feedbackIntroShort =>
      'Qu’est-ce qui te plaît, t’agace ou te manque ? Les petits détails aident aussi : plus c’est concret, mieux c’est.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Seuls $build et ton type d’appareil sont joints, pour que je sache de quelle version tu parles.';
  }

  @override
  String get feedbackSendByMail => 'Envoyer par e-mail';

  @override
  String get feedbackPreferGithub => 'Plutôt une issue GitHub';

  @override
  String get feedbackThanksMail =>
      'Merci ! Il ne reste qu’à envoyer le message.';

  @override
  String get feedbackNoMailApp =>
      'Aucune application e-mail trouvée. Essaie l’option GitHub ci-dessous.';

  @override
  String get feedbackEmptyHint => 'Écris d’abord quelque chose.';

  @override
  String get leaderboardRefresh => 'Actualiser';

  @override
  String get leaderboardRetry => 'Réessayer';

  @override
  String get feedbackHint => 'Ton avis…';

  @override
  String get feedbackSubmit => 'Envoyer l’avis';

  @override
  String get feedbackOpenFailed =>
      'Impossible d’ouvrir GitHub. Réessaie plus tard.';

  @override
  String get feedbackGithubNote =>
      'GitHub s’ouvre : touche « Submit new issue » là-bas. (Une connexion GitHub unique est nécessaire.)';

  @override
  String get shopTitle => 'Boutique';

  @override
  String get shopWebDemoNote =>
      'Les achats ne sont disponibles que dans l’application du Play Store. Cette version web est une démo gratuite : tu peux quand même tout y jouer.';

  @override
  String get shopSupporterExplainer =>
      'Qubble n’impose aucune publicité : tu n’as jamais rien à acheter. Le pack soutien (thème Aurora, skin Cristal, 1 500 pièces, badge de soutien) est un merci pour ton soutien au jeu. Les achats sont liés à ton compte du store et peuvent être restaurés à tout moment.';

  @override
  String get shopSupporterContents =>
      'Thème Aurora + skin Cristal + 1 500 pièces';

  @override
  String get themesTitle => 'Thèmes';

  @override
  String get themesSupporterOnly =>
      'Exclusif au pack soutien (voir la boutique)';

  @override
  String get themesInSupporterPack => 'Dans le pack soutien';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Pas assez de pièces (il en faut $cost, tu en as $coins)';
  }

  @override
  String get skinsTitle => 'Skins de blocs';

  @override
  String get skinsNotEnoughDiamonds =>
      'Pas assez de diamants (échange de l’or ci-dessous)';

  @override
  String get skinsNotEnoughCoins => 'Pas assez de pièces';

  @override
  String get skinsNotEnoughGold => 'Pas assez d’or.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold or = 1 diamant. Les diamants débloquent les plus beaux skins : prends ton temps pour les réunir.';
  }

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get statsAverageScore => 'Score moyen';

  @override
  String get statsBestCombo => 'Meilleur combo';

  @override
  String get statsGames => 'Parties';

  @override
  String get statsLinesCleared => 'Lignes effacées';

  @override
  String get statsPiecesPlaced => 'Pièces posées';

  @override
  String get statsCoins => 'Pièces';

  @override
  String get missionsTitle => 'Missions';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Pose $countString pièces';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Efface $countString lignes';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Atteins un combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Dépasse $countString points en une partie';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Joue $countString parties';
  }

  @override
  String get achievementsTitle => 'Succès';

  @override
  String get achievementFirstGameTitle => 'Première partie';

  @override
  String get achievementFirstGameBody => 'Joue ta première partie';

  @override
  String get achievementGames25Title => 'Habitué';

  @override
  String get achievementGames25Body => 'Joue 25 parties';

  @override
  String get achievementGames100Title => 'Accro';

  @override
  String get achievementGames100Body => 'Joue 100 parties';

  @override
  String get achievementScore1kTitle => 'Grimpeur';

  @override
  String get achievementScore1kBody => 'Atteins 1 000 points';

  @override
  String get achievementScore5kTitle => 'Pro';

  @override
  String get achievementScore5kBody => 'Atteins 5 000 points';

  @override
  String get achievementScore10kTitle => 'Maître';

  @override
  String get achievementScore10kBody => 'Atteins 10 000 points';

  @override
  String get achievementScore25kTitle => 'Légende';

  @override
  String get achievementScore25kBody => 'Atteins 25 000 points';

  @override
  String get achievementLines100Title => 'Soigneux';

  @override
  String get achievementLines100Body => 'Efface 100 lignes au total';

  @override
  String get achievementLines1000Title => 'Grand ménage';

  @override
  String get achievementLines1000Body => 'Efface 1 000 lignes au total';

  @override
  String get achievementCombo5Title => 'Apprenti combo';

  @override
  String get achievementCombo5Body => 'Atteins un combo x5';

  @override
  String get achievementCombo10Title => 'Roi du combo';

  @override
  String get achievementCombo10Body => 'Atteins un combo x10';

  @override
  String get achievementLevel10Title => 'Expérimenté';

  @override
  String get achievementLevel10Body => 'Atteins le niveau 10';

  @override
  String get achievementLevel20Title => 'Vétéran';

  @override
  String get achievementLevel20Body => 'Atteins le niveau 20';

  @override
  String get achievementStreak7Title => 'Semaine parfaite';

  @override
  String get achievementStreak7Body => 'Une série quotidienne de 7 jours';

  @override
  String get achievementStreak30Title => 'Mois parfait';

  @override
  String get achievementStreak30Body => 'Une série quotidienne de 30 jours';

  @override
  String get achievementPuzzles10Title => 'Cerveau';

  @override
  String get achievementPuzzles10Body => 'Résous 10 puzzles';

  @override
  String get achievementPieces5000Title => 'Bâtisseur';

  @override
  String get achievementPieces5000Body => 'Pose 5 000 pièces';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Ta série de $streak jours est en danger !',
      one: 'Ta série de $streak jour est en danger !',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Tu n’as pas joué hier. Sauve ta série :';

  @override
  String get streakRepairFailed => 'Réparation impossible.';

  @override
  String comebackGift(int coins) {
    return 'Content de te revoir ! +$coins pièces';
  }

  @override
  String get notificationsOptInTitle => 'Des rappels ?';

  @override
  String get notificationsOptInBody =>
      'On te rappelle ton défi du jour et on protège ta série ? Tu peux changer ça à tout moment dans les paramètres.';

  @override
  String get notificationsOptInAccept => 'Oui, volontiers';

  @override
  String get notificationChannelDescription =>
      'Rappel quotidien, alerte de série, retour';

  @override
  String get notificationDailyTitle => 'Ton défi du jour t’attend 🧩';

  @override
  String get notificationDailyBody => 'Joue le défi d’aujourd’hui !';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '🔥 Ta série de $streak jours est en danger !',
      one: '🔥 Ta série de $streak jour est en danger !',
    );
    return '$_temp0';
  }

  @override
  String get notificationStreakBody => 'Joue aujourd’hui pour la garder.';

  @override
  String get notificationComebackTitle => 'Tes blocs t’attendent 🧩';

  @override
  String get notificationComebackBody => 'Reviens récupérer un cadeau !';

  @override
  String get iapSupporterPack => 'Pack soutien';

  @override
  String get iapCoinsSmall => '500 pièces';

  @override
  String get iapCoinsMedium => '2 000 pièces';

  @override
  String get iapCoinsLarge => '6 000 pièces';

  @override
  String get iapStarterPack => 'Pack de départ';

  @override
  String get iapRename => 'Changement de nom';

  @override
  String get iapNeonTheme => 'Thème Néon';

  @override
  String get settingsLeaderboardDelete => 'Supprimer mon entrée du classement';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Retire ton nom et ton score de la liste publique';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Supprimer ton entrée ?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Ton nom et ton score seront retirés du classement. Ta progression dans le jeu ne change pas. Tu peux rejoindre le classement à nouveau quand tu veux.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Ton entrée du classement a été supprimée.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'L’entrée n’a pas pu être supprimée. Vérifie ta connexion et réessaie.';

  @override
  String get leaderboardReport => 'Signaler ce nom';

  @override
  String get leaderboardBlock => 'Bloquer';

  @override
  String leaderboardBlocked(String name) {
    return '$name est masqué pour toi';
  }

  @override
  String get leaderboardUndo => 'Annuler';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entrées masquées par toi',
      one: '$count entrée masquée par toi',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Réafficher';

  @override
  String get leaderboardReportUnavailable =>
      'Le signalement est indisponible pour le moment.';

  @override
  String get leaderboardReportSent => 'Merci, ton signalement est en route.';

  @override
  String get leaderboardRules =>
      'Les noms sont publics. Pas d’insultes, pas de propos haineux, et rien qui identifie une personne réelle. Les noms qui enfreignent cette règle sont supprimés.';

  @override
  String get leaderboardRulesAccept => 'J’ai compris';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked sur $total débloqués';
  }

  @override
  String get settingsSectionData => 'Données enregistrées';

  @override
  String get gameRotatePiece => 'Tourner la pièce';

  @override
  String get themeClassic => 'Classique';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Néon';

  @override
  String get themeOcean => 'Océan';

  @override
  String get themeWood => 'Bois';

  @override
  String get themeSunset => 'Coucher de soleil';

  @override
  String get themeForest => 'Forêt';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Classique';

  @override
  String get skinGradient => 'Dégradé';

  @override
  String get skinOutline => 'Contour';

  @override
  String get skinGlossy => 'Brillant';

  @override
  String get skinStripe => 'Rayures';

  @override
  String get skinBevel => 'Relief';

  @override
  String get skinGlow => 'Lueur';

  @override
  String get skinCrystal => 'Cristal';

  @override
  String rewardThemeName(String name) {
    return 'Thème $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skin $name';
  }
}
