// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Play';

  @override
  String get commonLater => 'Later';

  @override
  String get commonNotNow => 'Not now';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonBuy => 'Buy';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCollect => 'Collect';

  @override
  String get nameNewName => 'New name';

  @override
  String get nameFieldLabel => 'Name';

  @override
  String get piggyFullTitle => 'Piggy bank is full!';

  @override
  String get piggyKeepSaving => 'Keep saving';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins of $capacity collected.';
  }

  @override
  String get homeContinueRun => 'Continue';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Got it';

  @override
  String get commonHome => 'Home';

  @override
  String get commonScore => 'SCORE';

  @override
  String get commonBest => 'BEST';

  @override
  String commonLevelShort(int level) {
    return 'Level $level';
  }

  @override
  String get homeNewRun => 'Start a new run';

  @override
  String get homeBackToExit => 'Press back again to exit';

  @override
  String get homeEnableLeaderboard => 'Join the leaderboard';

  @override
  String get homeBestScore => 'BEST SCORE';

  @override
  String get homeDailyChallenge => 'Daily Challenge';

  @override
  String get homeDailyOpenToday => 'Open today';

  @override
  String homeDailyNextIn(String time) {
    return 'Next daily in $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak-day streak';
  }

  @override
  String get homeLeaderboard => 'Leaderboard';

  @override
  String get homePuzzleMode => 'Puzzle Mode';

  @override
  String get homeMissions => 'Missions';

  @override
  String get homeThemes => 'Themes';

  @override
  String get homeSkins => 'Skins';

  @override
  String get homeHowToPlay => 'How to play Qubble';

  @override
  String get homeWeekendBonus => 'Weekend: double coins!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Level $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Change name';

  @override
  String get nameChangeExplainer =>
      'Your name is your leaderboard identity, so it is fixed. You can buy a one-time name change.';

  @override
  String get nameChangeAfterPurchase =>
      'After the purchase, tap your name again to change it.';

  @override
  String get nameJoinedLeaderboard => 'You\'re on the leaderboard now.';

  @override
  String get nameRenameUnavailable => 'Renaming isn\'t possible right now.';

  @override
  String nameProblemTooShort(int min) {
    return 'At least $min characters.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'At most $max characters.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Letters, numbers, spaces, _ and - only.';

  @override
  String get nameProblemOffensive => 'Please pick a different name.';

  @override
  String get piggyTitle => 'Piggy bank';

  @override
  String get piggyFillingHint =>
      'Your piggy bank fills up while you clear rows.';

  @override
  String piggyCollect(int coins) {
    return 'Collect $coins coins — free.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Once it\'s full you can empty it for free — or open it early with a bonus video.';

  @override
  String get piggyOpenNow => 'Open now';

  @override
  String get gameNewPiecesVideo => 'New pieces (video)';

  @override
  String get gameTapBoardCell => 'Tap a cell on the board';

  @override
  String get gameDailyChallengeLabel => 'DAILY CHALLENGE';

  @override
  String get gameOver => 'Game Over';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'You need $missing more coins for the bomb.';
  }

  @override
  String get gameBombNotHere => 'The bomb doesn\'t work here right now.';

  @override
  String gameNeedsCoins(String missing) {
    return 'You need $missing more coins for that.';
  }

  @override
  String get gameNotRightNow => 'Not possible right now.';

  @override
  String get gameRunSaved => 'Run saved — \"Continue\" in the menu.';

  @override
  String get gameOverNoFit => 'None of your pieces fit on the board any more.';

  @override
  String get gameOverNoFitNoRotations =>
      'None of your pieces fit — and the rotations are used up.';

  @override
  String get gameStarterOfferUnavailable => 'Not available right now';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — get it';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Achievement: $title';
  }

  @override
  String get gameBestSubmitted => 'New best — submitted';

  @override
  String get gameReviveFor => 'Keep playing · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Unlocked: $name';
  }

  @override
  String get gameStarterOfferTitle => '🎁 Starter pack';

  @override
  String gameOverPoints(int score) {
    return '$score points';
  }

  @override
  String get gameNewRecord => 'New record!';

  @override
  String gameStreakDays(int streak) {
    return '$streak-day streak';
  }

  @override
  String get gameDoubleCoins => 'Double coins';

  @override
  String get gameDoubleDaily => 'Double daily reward';

  @override
  String get gamePlayAgain => 'Play again';

  @override
  String gameLevelReached(int level) {
    return 'Reached level $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Gained $count levels — level $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 coins + Wood theme';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Only $hours h left — one time!';
  }

  @override
  String get boosterUndo => 'Undo';

  @override
  String get boosterSwap => 'Swap';

  @override
  String get boosterBomb => 'Bomb';

  @override
  String get boosterNoRotationsLeft =>
      'No rotations left — clear rows to recharge!';

  @override
  String get onboardingDragPiece => 'Drag a block onto the grid 👆';

  @override
  String get onboardingFillLine => 'Fill a whole row or column';

  @override
  String get onboardingLinesClear => 'Full lines dissolve — points! ✨';

  @override
  String get coachHintCombo => 'Combo! Clear again within 3 moves to keep it';

  @override
  String get coachHintFever => 'FEVER! Double points while it glows 🔥';

  @override
  String get coachHintRotation => 'Rotating costs a charge — clears refill it';

  @override
  String get coachHintBooster => 'Tip: you can use boosters down below 🪙';

  @override
  String get coachHintStrategy =>
      'Tip: not every line at once — keep room for big pieces';

  @override
  String get dailyStreakLabel => 'Streak';

  @override
  String get dailyBestLabel => 'Daily best';

  @override
  String dailyHistoryNote(int days) {
    return 'The last $days days are kept.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day. played';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day. not played';
  }

  @override
  String get homeDailyCalendar => 'Calendar';

  @override
  String get dailyShareButton => 'Share result';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble Daily $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score points · best combo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Play: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Combo: $moves moves left';
  }

  @override
  String get dailyShareCopied => 'Result copied to the clipboard';

  @override
  String get adNotAvailable =>
      'No video available right now — try again in a moment';

  @override
  String get howToPlaySpeedTitle => 'Speed bonus';

  @override
  String get howToPlaySpeedBody =>
      'Placing quickly adds up to 30 % to a clear. The bonus fades between 1.5 and 4 seconds and is capped, so being fast pays off without deciding the game — a careful slow run can still beat a hasty quick one.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Speed bonus $percent percent';
  }

  @override
  String get howToPlayTitle => 'How to play Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Easy to start.\nRewards planning ahead.';

  @override
  String get howToPlayIntroBody =>
      'Keep the board clear and beat your best score.';

  @override
  String get howToPlayIntroSemantics =>
      'Goal of the game. Keep the board clear and beat your best score.';

  @override
  String get howToPlayDragTitle => 'Drag & place';

  @override
  String get howToPlayDragBody =>
      'Drag one of the three pieces onto free cells. Once all three are used, you get three new ones automatically.';

  @override
  String get howToPlayClearTitle => 'Clear lines';

  @override
  String get howToPlayClearBody =>
      'Fill a complete row or column. Full lines dissolve and make room for your next move.';

  @override
  String get howToPlayComboTitle => 'Chain combos';

  @override
  String get howToPlayComboBody =>
      'Clear another line within three moves. Every further combo raises your score multiplier. The combo counts moves, not seconds, so it never runs out while you think.';

  @override
  String get howToPlayFeverTitle => 'Trigger fever';

  @override
  String get howToPlayFeverBody =>
      'Clears fill the fever meter. Once it\'s full, the next burst counts double — plan big clears ahead.';

  @override
  String get howToPlayBoosterTitle => 'Use boosters wisely';

  @override
  String get howToPlayBoosterBody =>
      'Boosters rescue tight runs. You can also tap a piece in the tray to rotate it.';

  @override
  String get howToPlayDailyTitle => 'Daily & streak';

  @override
  String get howToPlayDailyBody =>
      'The daily challenge uses the same pieces for everyone. Play every day to grow your streak and bonus.';

  @override
  String get howToPlayPiggyTitle => 'Fill the piggy bank';

  @override
  String get howToPlayPiggyBody =>
      'Every cleared line fills your piggy bank. When it\'s full, you can collect the coins for free.';

  @override
  String get leaderboardTitle => 'Leaderboard';

  @override
  String get leaderboardUnreachable =>
      'Leaderboard unavailable.\nTry again with an internet connection.';

  @override
  String get leaderboardEmpty => 'No entries yet.\nBe the first!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Your best score ($score) is being submitted …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Your best score is submitted automatically.';

  @override
  String get puzzleModeTitle => 'Puzzle Mode';

  @override
  String puzzleLevelTitle(int level) {
    return 'Puzzle $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Moves: $moves   •   Target: $target for 3 stars';
  }

  @override
  String get puzzleSolved => 'Solved!';

  @override
  String get puzzleLeaveTitle => 'Leave the puzzle?';

  @override
  String get puzzleLeaveBody => 'Your progress in this puzzle will be lost.';

  @override
  String get puzzleKeepPlaying => 'Keep playing';

  @override
  String get puzzleLeave => 'Leave';

  @override
  String get puzzleStuckTitle => 'Stuck';

  @override
  String get puzzleRestart => 'Restart';

  @override
  String get commonActive => 'Active';

  @override
  String get commonTapToActivate => 'Tap to activate';

  @override
  String get commonRestore => 'Restore';

  @override
  String unlockForCost(int cost) {
    return '$cost to unlock';
  }

  @override
  String get skinsExchangeGold => 'Exchange gold';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Rotate piece';

  @override
  String get puzzleNextLevel => 'Next level';

  @override
  String get puzzleBackToOverview => 'Back to overview';

  @override
  String get puzzleUnsolvable =>
      'The board can\'t be emptied from here any more.';

  @override
  String get puzzleExtraMoveVideo => 'Extra move (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved solved';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get storageFailureTitle => 'Qubble cannot load your saved game';

  @override
  String get storageFailureBody =>
      'Please restart the app. If the error persists, only a reinstall helps — please report it in the playtest.';

  @override
  String get iapUnavailable => 'This offer isn\'t available right now.';

  @override
  String get iapFailed =>
      'The purchase didn\'t go through. Nothing was charged.';

  @override
  String get settingsResetProgress => 'Reset progress';

  @override
  String get settingsResetProgressSubtitle =>
      'Score, coins, level and progress back to the start. Purchases, name and cosmetics are kept.';

  @override
  String get settingsResetConfirmTitle => 'Reset progress?';

  @override
  String get settingsResetConfirmBody =>
      'Best score, coins, level, streak and all progress will be deleted. This cannot be undone.\n\nYour purchases, your name and unlocked themes and skins are kept.';

  @override
  String get settingsResetConfirmAction => 'Reset';

  @override
  String get settingsResetDone => 'Progress reset.';

  @override
  String get settingsSectionGame => 'Game';

  @override
  String get settingsSectionSoundHaptics => 'Sound & haptics';

  @override
  String get settingsSectionReminders => 'Reminders';

  @override
  String get settingsSectionPurchases => 'Purchases';

  @override
  String get settingsSectionHelpOut => 'Help out';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionLanguage => 'Language';

  @override
  String get settingsGuide => 'How to play';

  @override
  String get settingsGuideSubtitle => 'Rules, combos, fever & boosters';

  @override
  String get settingsSound => 'Sound';

  @override
  String get settingsMusic => 'Music';

  @override
  String get settingsHaptics => 'Vibration';

  @override
  String get settingsHapticsOff => 'Off';

  @override
  String get settingsHapticsLight => 'Light';

  @override
  String get settingsHapticsStrong => 'Strong';

  @override
  String get settingsSectionAccessibility => 'Comfort';

  @override
  String get settingsReducedEffects => 'Reduced effects';

  @override
  String get settingsReducedEffectsHint =>
      'Fewer particles, no screen shake, no glow';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Daily reminder & streak protection';

  @override
  String get settingsNotificationsSystemHint =>
      'Allow it in your system settings.';

  @override
  String get settingsLanguageSystem => 'System language';

  @override
  String get settingsSupporterThanks => 'Supporter — thank you! ❤️';

  @override
  String get settingsSupporterPack => 'Supporter pack';

  @override
  String get settingsSupporterPackSubtitle =>
      'Exclusive theme & skin + 1,500 coins';

  @override
  String get settingsRestorePurchases => 'Restore purchases';

  @override
  String get settingsRestoring => 'Restoring purchases…';

  @override
  String get settingsRateApp => 'Rate the app';

  @override
  String get settingsRateAppSubtitle => 'Leave a rating in the store';

  @override
  String get settingsStoreUnavailable =>
      'The store isn\'t available on this device.';

  @override
  String get settingsFeedback => 'Send feedback';

  @override
  String get settingsFeedbackSubtitle => 'Report ideas & bugs (via GitHub)';

  @override
  String get settingsAdPrivacy => 'Ad privacy settings';

  @override
  String get settingsAdPrivacySubtitle => 'View or change your ad consent';

  @override
  String get settingsAdPrivacyUnavailable =>
      'No ad options are required on this device.';

  @override
  String get settingsPrivacy => 'Privacy policy';

  @override
  String get settingsImprint => 'Imprint';

  @override
  String get settingsPageOpenFailed => 'The page could not be opened.';

  @override
  String get settingsFooter => 'Qubble • Offline Block Puzzle';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => '🔧 Admin mode enabled';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Tap $count more times for admin mode';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins coins';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'For testing only — never show in release screenshots';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount coins';
  }

  @override
  String get settingsAdminResetCoins => 'Set coins to 0';

  @override
  String get feedbackTitle => 'Feedback';

  @override
  String get feedbackIntroShort =>
      'What do you like, what annoys you, what\'s missing? Small things help too — the more concrete, the better.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Only $build and your device type are attached — so I know which build you mean.';
  }

  @override
  String get feedbackSendByMail => 'Send by email';

  @override
  String get feedbackPreferGithub => 'Prefer a GitHub issue';

  @override
  String get feedbackThanksMail => 'Thanks! Just send the message.';

  @override
  String get feedbackNoMailApp =>
      'No mail app found. Try the GitHub route below.';

  @override
  String get feedbackEmptyHint => 'Please type something first.';

  @override
  String get leaderboardRefresh => 'Refresh';

  @override
  String get leaderboardRetry => 'Try again';

  @override
  String get feedbackHint => 'Your feedback…';

  @override
  String get feedbackSubmit => 'Send feedback';

  @override
  String get feedbackOpenFailed =>
      'GitHub couldn\'t be opened. Try again later.';

  @override
  String get feedbackGithubNote =>
      'GitHub opens — tap \"Submit new issue\" there. (A one-time GitHub login is required.)';

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopWebDemoNote =>
      'Purchases are only available in the app from the Play Store. This web version is a free demo — you can still play all of it here.';

  @override
  String get shopSupporterExplainer =>
      'Qubble shows no forced ads — you never have to buy anything. The supporter pack (Aurora theme, crystal skin, 1,500 coins, ❤️ badge) is a thank-you for supporting the game. Purchases are tied to your store account and can be restored at any time.';

  @override
  String get shopSupporterContents =>
      'Aurora theme + crystal skin + 1,500 coins';

  @override
  String get themesTitle => 'Themes';

  @override
  String get themesSupporterOnly =>
      'Exclusive to the supporter pack (see shop) ❤️';

  @override
  String get themesInSupporterPack => 'In the supporter pack ❤️';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Not enough coins (need $cost, have $coins)';
  }

  @override
  String get skinsTitle => 'Block skins';

  @override
  String get skinsNotEnoughDiamonds =>
      'Not enough diamonds (exchange gold below)';

  @override
  String get skinsNotEnoughCoins => 'Not enough coins';

  @override
  String get skinsNotEnoughGold => 'Not enough gold.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold gold = 1 diamond. Diamonds unlock the finest skins — take your time collecting.';
  }

  @override
  String get statsTitle => 'Stats';

  @override
  String get statsAverageScore => 'Avg. score';

  @override
  String get statsBestCombo => 'Best combo';

  @override
  String get statsGames => 'Games';

  @override
  String get statsLinesCleared => 'Rows cleared';

  @override
  String get statsPiecesPlaced => 'Pieces placed';

  @override
  String get statsCoins => 'Coins';

  @override
  String get missionsTitle => 'Missions';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Place $countString pieces';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Clear $countString rows';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Reach a ${countString}x combo';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Break $countString points in one run';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Play $countString runs';
  }

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get achievementFirstGameTitle => 'First run';

  @override
  String get achievementFirstGameBody => 'Play your first run';

  @override
  String get achievementGames25Title => 'Regular';

  @override
  String get achievementGames25Body => 'Play 25 runs';

  @override
  String get achievementGames100Title => 'Hooked';

  @override
  String get achievementGames100Body => 'Play 100 runs';

  @override
  String get achievementScore1kTitle => 'Climber';

  @override
  String get achievementScore1kBody => 'Reach 1,000 points';

  @override
  String get achievementScore5kTitle => 'Pro';

  @override
  String get achievementScore5kBody => 'Reach 5,000 points';

  @override
  String get achievementScore10kTitle => 'Master';

  @override
  String get achievementScore10kBody => 'Reach 10,000 points';

  @override
  String get achievementScore25kTitle => 'Legend';

  @override
  String get achievementScore25kBody => 'Reach 25,000 points';

  @override
  String get achievementLines100Title => 'Tidy';

  @override
  String get achievementLines100Body => 'Clear 100 rows in total';

  @override
  String get achievementLines1000Title => 'Spring cleaner';

  @override
  String get achievementLines1000Body => 'Clear 1,000 rows in total';

  @override
  String get achievementCombo5Title => 'Combo starter';

  @override
  String get achievementCombo5Body => 'Reach a 5x combo';

  @override
  String get achievementCombo10Title => 'Combo king';

  @override
  String get achievementCombo10Body => 'Reach a 10x combo';

  @override
  String get achievementLevel10Title => 'Experienced';

  @override
  String get achievementLevel10Body => 'Reach level 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Reach level 20';

  @override
  String get achievementStreak7Title => 'Week streak';

  @override
  String get achievementStreak7Body => 'A 7-day daily streak';

  @override
  String get achievementStreak30Title => 'Month streak';

  @override
  String get achievementStreak30Body => 'A 30-day daily streak';

  @override
  String get achievementPuzzles10Title => 'Puzzler';

  @override
  String get achievementPuzzles10Body => 'Solve 10 puzzles';

  @override
  String get achievementPieces5000Title => 'Builder';

  @override
  String get achievementPieces5000Body => 'Place 5,000 pieces';

  @override
  String streakRepairTitle(int streak) {
    return '$streak-day streak at risk!';
  }

  @override
  String get streakRepairBody => 'You skipped yesterday — rescue your streak:';

  @override
  String get streakRepairFailed => 'Repair isn\'t possible.';

  @override
  String comebackGift(int coins) {
    return 'Welcome back! 🪙 +$coins coins';
  }

  @override
  String get notificationsOptInTitle => 'Reminders?';

  @override
  String get notificationsOptInBody =>
      'Should we remind you about your daily puzzle and protect your streak? You can change this any time in the settings.';

  @override
  String get notificationsOptInAccept => 'Yes, please';

  @override
  String get notificationChannelDescription =>
      'Daily reminder, streak warning, comeback';

  @override
  String get notificationDailyTitle => 'Your daily puzzle is waiting 🧩';

  @override
  String get notificationDailyBody => 'Play today\'s challenge!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Your $streak-day streak is at risk!';
  }

  @override
  String get notificationStreakBody => 'Play today to keep it alive.';

  @override
  String get notificationComebackTitle => 'Your puzzle misses you 🧩';

  @override
  String get notificationComebackBody => 'Come back and pick up a gift!';

  @override
  String get iapSupporterPack => 'Supporter pack';

  @override
  String get iapCoinsSmall => '500 coins';

  @override
  String get iapCoinsMedium => '2,000 coins';

  @override
  String get iapCoinsLarge => '6,000 coins';

  @override
  String get iapStarterPack => 'Starter pack';

  @override
  String get iapRename => 'Name change';

  @override
  String get iapNeonTheme => 'Neon theme';

  @override
  String get settingsLeaderboardDelete => 'Delete leaderboard entry';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Removes your name and score from the public list';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Delete your entry?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Your name and score will be removed from the leaderboard. Your game progress stays untouched. You can enter the leaderboard again at any time.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Your leaderboard entry was deleted.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'The entry could not be deleted. Check your connection and try again.';

  @override
  String get leaderboardReport => 'Report this name';

  @override
  String get leaderboardBlock => 'Block';

  @override
  String leaderboardBlocked(String name) {
    return '$name is hidden for you';
  }

  @override
  String get leaderboardUndo => 'Undo';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries hidden by you',
      one: '1 entry hidden by you',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Show again';

  @override
  String get leaderboardReportUnavailable =>
      'Reporting is unavailable right now.';

  @override
  String get leaderboardReportSent => 'Thanks — your report is on its way.';

  @override
  String get leaderboardRules =>
      'Names are public. No insults, no slurs, and nothing that identifies a real person. Names that break this are removed.';

  @override
  String get leaderboardRulesAccept => 'I understand';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked of $total unlocked';
  }

  @override
  String get settingsSectionData => 'Saved data';

  @override
  String get gameRotatePiece => 'Rotate piece';
}
