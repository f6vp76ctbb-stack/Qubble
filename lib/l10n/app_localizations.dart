import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// App name shown in the task switcher
  ///
  /// In en, this message translates to:
  /// **'Qubble'**
  String get appTitle;

  /// No description provided for @commonPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get commonPlay;

  /// No description provided for @commonLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get commonLater;

  /// No description provided for @commonNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get commonNotNow;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get commonBuy;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCollect.
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get commonCollect;

  /// No description provided for @nameNewName.
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get nameNewName;

  /// No description provided for @nameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameFieldLabel;

  /// No description provided for @piggyFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Piggy bank is full!'**
  String get piggyFullTitle;

  /// No description provided for @piggyKeepSaving.
  ///
  /// In en, this message translates to:
  /// **'Keep saving'**
  String get piggyKeepSaving;

  /// No description provided for @piggyProgress.
  ///
  /// In en, this message translates to:
  /// **'{coins} of {capacity} collected.'**
  String piggyProgress(int coins, int capacity);

  /// No description provided for @homeContinueRun.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get homeContinueRun;

  /// No description provided for @homeVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get homeVideo;

  /// No description provided for @commonGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get commonGotIt;

  /// No description provided for @commonHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get commonHome;

  /// No description provided for @commonScore.
  ///
  /// In en, this message translates to:
  /// **'SCORE'**
  String get commonScore;

  /// No description provided for @commonBest.
  ///
  /// In en, this message translates to:
  /// **'BEST'**
  String get commonBest;

  /// No description provided for @commonLevelShort.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String commonLevelShort(int level);

  /// No description provided for @homeNewRun.
  ///
  /// In en, this message translates to:
  /// **'Start a new run'**
  String get homeNewRun;

  /// No description provided for @homeBackToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get homeBackToExit;

  /// No description provided for @homeEnableLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Join the leaderboard'**
  String get homeEnableLeaderboard;

  /// No description provided for @homeBestScore.
  ///
  /// In en, this message translates to:
  /// **'BEST SCORE'**
  String get homeBestScore;

  /// No description provided for @homeDailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get homeDailyChallenge;

  /// No description provided for @homeDailyOpenToday.
  ///
  /// In en, this message translates to:
  /// **'Open today'**
  String get homeDailyOpenToday;

  /// Shown on the daily card once today's daily is played
  ///
  /// In en, this message translates to:
  /// **'Next daily in {time}'**
  String homeDailyNextIn(String time);

  /// No description provided for @homeDailyStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{streak}-day streak'**
  String homeDailyStreakDays(int streak);

  /// No description provided for @homeLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get homeLeaderboard;

  /// No description provided for @homePuzzleMode.
  ///
  /// In en, this message translates to:
  /// **'Puzzle Mode'**
  String get homePuzzleMode;

  /// No description provided for @homeMissions.
  ///
  /// In en, this message translates to:
  /// **'Missions'**
  String get homeMissions;

  /// No description provided for @homeThemes.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get homeThemes;

  /// No description provided for @homeSkins.
  ///
  /// In en, this message translates to:
  /// **'Skins'**
  String get homeSkins;

  /// No description provided for @homeHowToPlay.
  ///
  /// In en, this message translates to:
  /// **'How to play Qubble'**
  String get homeHowToPlay;

  /// No description provided for @homeWeekendBonus.
  ///
  /// In en, this message translates to:
  /// **'Weekend: double coins!'**
  String get homeWeekendBonus;

  /// No description provided for @homeNextUnlock.
  ///
  /// In en, this message translates to:
  /// **'Level {level}: {name}'**
  String homeNextUnlock(int level, String name);

  /// No description provided for @homeXpProgress.
  ///
  /// In en, this message translates to:
  /// **'{xp} / {goal} XP'**
  String homeXpProgress(int xp, int goal);

  /// No description provided for @nameChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change name'**
  String get nameChangeTitle;

  /// No description provided for @nameChangeExplainer.
  ///
  /// In en, this message translates to:
  /// **'Your name is your leaderboard identity, so it is fixed. You can buy a one-time name change.'**
  String get nameChangeExplainer;

  /// No description provided for @nameChangeAfterPurchase.
  ///
  /// In en, this message translates to:
  /// **'After the purchase, tap your name again to change it.'**
  String get nameChangeAfterPurchase;

  /// No description provided for @nameJoinedLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'You\'re on the leaderboard now.'**
  String get nameJoinedLeaderboard;

  /// No description provided for @nameRenameUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Renaming isn\'t possible right now.'**
  String get nameRenameUnavailable;

  /// No description provided for @nameProblemTooShort.
  ///
  /// In en, this message translates to:
  /// **'At least {min} characters.'**
  String nameProblemTooShort(int min);

  /// No description provided for @nameProblemTooLong.
  ///
  /// In en, this message translates to:
  /// **'At most {max} characters.'**
  String nameProblemTooLong(int max);

  /// No description provided for @nameProblemInvalidCharacters.
  ///
  /// In en, this message translates to:
  /// **'Letters, numbers, spaces, _ and - only.'**
  String get nameProblemInvalidCharacters;

  /// No description provided for @nameProblemOffensive.
  ///
  /// In en, this message translates to:
  /// **'Please pick a different name.'**
  String get nameProblemOffensive;

  /// No description provided for @piggyTitle.
  ///
  /// In en, this message translates to:
  /// **'Piggy bank'**
  String get piggyTitle;

  /// No description provided for @piggyFillingHint.
  ///
  /// In en, this message translates to:
  /// **'Your piggy bank fills up while you clear rows.'**
  String get piggyFillingHint;

  /// No description provided for @piggyCollect.
  ///
  /// In en, this message translates to:
  /// **'Collect {coins} coins — free.'**
  String piggyCollect(int coins);

  /// No description provided for @piggyEarlyOpenHint.
  ///
  /// In en, this message translates to:
  /// **'Once it\'s full you can empty it for free — or open it early with a bonus video.'**
  String get piggyEarlyOpenHint;

  /// No description provided for @piggyOpenNow.
  ///
  /// In en, this message translates to:
  /// **'Open now'**
  String get piggyOpenNow;

  /// No description provided for @gameNewPiecesVideo.
  ///
  /// In en, this message translates to:
  /// **'New pieces (video)'**
  String get gameNewPiecesVideo;

  /// No description provided for @gameTapBoardCell.
  ///
  /// In en, this message translates to:
  /// **'Tap a cell on the board'**
  String get gameTapBoardCell;

  /// No description provided for @gameDailyChallengeLabel.
  ///
  /// In en, this message translates to:
  /// **'DAILY CHALLENGE'**
  String get gameDailyChallengeLabel;

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// No description provided for @gameBombNeedsCoins.
  ///
  /// In en, this message translates to:
  /// **'You need {missing} more coins for the bomb.'**
  String gameBombNeedsCoins(String missing);

  /// No description provided for @gameBombNotHere.
  ///
  /// In en, this message translates to:
  /// **'The bomb doesn\'t work here right now.'**
  String get gameBombNotHere;

  /// No description provided for @gameNeedsCoins.
  ///
  /// In en, this message translates to:
  /// **'You need {missing} more coins for that.'**
  String gameNeedsCoins(String missing);

  /// No description provided for @gameNotRightNow.
  ///
  /// In en, this message translates to:
  /// **'Not possible right now.'**
  String get gameNotRightNow;

  /// No description provided for @gameRunSaved.
  ///
  /// In en, this message translates to:
  /// **'Run saved — \"Continue\" in the menu.'**
  String get gameRunSaved;

  /// No description provided for @gameOverNoFit.
  ///
  /// In en, this message translates to:
  /// **'None of your pieces fit on the board any more.'**
  String get gameOverNoFit;

  /// No description provided for @gameOverNoFitNoRotations.
  ///
  /// In en, this message translates to:
  /// **'None of your pieces fit — and the rotations are used up.'**
  String get gameOverNoFitNoRotations;

  /// No description provided for @gameStarterOfferUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Not available right now'**
  String get gameStarterOfferUnavailable;

  /// No description provided for @gameStarterOfferPrice.
  ///
  /// In en, this message translates to:
  /// **'{price} — get it'**
  String gameStarterOfferPrice(String price);

  /// No description provided for @gameComboMultiplier.
  ///
  /// In en, this message translates to:
  /// **'COMBO x{combo}'**
  String gameComboMultiplier(int combo);

  /// No description provided for @gameAchievementUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Achievement: {title}'**
  String gameAchievementUnlocked(String title);

  /// No description provided for @gameBestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'New best — submitted'**
  String get gameBestSubmitted;

  /// No description provided for @gameReviveFor.
  ///
  /// In en, this message translates to:
  /// **'Keep playing · '**
  String get gameReviveFor;

  /// No description provided for @gameRewardUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked: {name}'**
  String gameRewardUnlocked(String name);

  /// No description provided for @gameStarterOfferTitle.
  ///
  /// In en, this message translates to:
  /// **'Starter pack'**
  String get gameStarterOfferTitle;

  /// No description provided for @gameOverPoints.
  ///
  /// In en, this message translates to:
  /// **'{score} points'**
  String gameOverPoints(int score);

  /// No description provided for @gameNewRecord.
  ///
  /// In en, this message translates to:
  /// **'New record!'**
  String get gameNewRecord;

  /// No description provided for @gameStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{streak}-day streak'**
  String gameStreakDays(int streak);

  /// No description provided for @gameDoubleCoins.
  ///
  /// In en, this message translates to:
  /// **'Double coins'**
  String get gameDoubleCoins;

  /// Optional rewarded video that doubles the daily challenge reward
  ///
  /// In en, this message translates to:
  /// **'Double daily reward'**
  String get gameDoubleDaily;

  /// No description provided for @gamePlayAgain.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get gamePlayAgain;

  /// No description provided for @gameLevelReached.
  ///
  /// In en, this message translates to:
  /// **'Reached level {level}!'**
  String gameLevelReached(int level);

  /// No description provided for @gameLevelsGained.
  ///
  /// In en, this message translates to:
  /// **'Gained {count} levels — level {level}!'**
  String gameLevelsGained(int count, int level);

  /// No description provided for @gameStarterOfferReward.
  ///
  /// In en, this message translates to:
  /// **'1200 coins + Wood theme'**
  String get gameStarterOfferReward;

  /// No description provided for @gameStarterOfferTimeLeft.
  ///
  /// In en, this message translates to:
  /// **'Only {hours} h left — one time!'**
  String gameStarterOfferTimeLeft(int hours);

  /// No description provided for @boosterUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get boosterUndo;

  /// No description provided for @boosterSwap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get boosterSwap;

  /// No description provided for @boosterBomb.
  ///
  /// In en, this message translates to:
  /// **'Bomb'**
  String get boosterBomb;

  /// No description provided for @boosterNoRotationsLeft.
  ///
  /// In en, this message translates to:
  /// **'No rotations left — clear rows to recharge!'**
  String get boosterNoRotationsLeft;

  /// No description provided for @onboardingDragPiece.
  ///
  /// In en, this message translates to:
  /// **'Drag a block onto the grid'**
  String get onboardingDragPiece;

  /// No description provided for @onboardingFillLine.
  ///
  /// In en, this message translates to:
  /// **'Fill a whole row or column'**
  String get onboardingFillLine;

  /// No description provided for @onboardingLinesClear.
  ///
  /// In en, this message translates to:
  /// **'Full lines dissolve — points!'**
  String get onboardingLinesClear;

  /// No description provided for @coachHintCombo.
  ///
  /// In en, this message translates to:
  /// **'Combo! Clear again within 3 moves to keep it'**
  String get coachHintCombo;

  /// No description provided for @coachHintFever.
  ///
  /// In en, this message translates to:
  /// **'FEVER! Double points while it glows'**
  String get coachHintFever;

  /// No description provided for @coachHintRotation.
  ///
  /// In en, this message translates to:
  /// **'Rotating costs a charge — clears refill it'**
  String get coachHintRotation;

  /// No description provided for @coachHintBooster.
  ///
  /// In en, this message translates to:
  /// **'Tip: you can use boosters down below'**
  String get coachHintBooster;

  /// No description provided for @coachHintStrategy.
  ///
  /// In en, this message translates to:
  /// **'Tip: not every line at once — keep room for big pieces'**
  String get coachHintStrategy;

  /// No description provided for @dailyStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get dailyStreakLabel;

  /// No description provided for @dailyBestLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily best'**
  String get dailyBestLabel;

  /// No description provided for @dailyHistoryNote.
  ///
  /// In en, this message translates to:
  /// **'The last {days} days are kept.'**
  String dailyHistoryNote(int days);

  /// No description provided for @dailyDayPlayed.
  ///
  /// In en, this message translates to:
  /// **'{day}. played'**
  String dailyDayPlayed(int day);

  /// No description provided for @dailyDayMissed.
  ///
  /// In en, this message translates to:
  /// **'{day}. not played'**
  String dailyDayMissed(int day);

  /// No description provided for @homeDailyCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get homeDailyCalendar;

  /// No description provided for @dailyShareButton.
  ///
  /// In en, this message translates to:
  /// **'Share result'**
  String get dailyShareButton;

  /// No description provided for @dailyShareHeadline.
  ///
  /// In en, this message translates to:
  /// **'Qubble Daily {date}'**
  String dailyShareHeadline(String date);

  /// No description provided for @dailyShareStats.
  ///
  /// In en, this message translates to:
  /// **'{score} points · best combo x{combo}'**
  String dailyShareStats(String score, int combo);

  /// No description provided for @dailySharePlay.
  ///
  /// In en, this message translates to:
  /// **'Play: {url}'**
  String dailySharePlay(String url);

  /// No description provided for @gameComboMovesLeft.
  ///
  /// In en, this message translates to:
  /// **'Combo: {moves} moves left'**
  String gameComboMovesLeft(int moves);

  /// No description provided for @dailyShareCopied.
  ///
  /// In en, this message translates to:
  /// **'Result copied to the clipboard'**
  String get dailyShareCopied;

  /// No description provided for @adNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'No video available right now — try again in a moment'**
  String get adNotAvailable;

  /// No description provided for @howToPlaySpeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Speed bonus'**
  String get howToPlaySpeedTitle;

  /// No description provided for @howToPlaySpeedBody.
  ///
  /// In en, this message translates to:
  /// **'Placing quickly adds up to 30 % to a clear. The bonus fades between 1.5 and 4 seconds and is capped, so being fast pays off without deciding the game — a careful slow run can still beat a hasty quick one.'**
  String get howToPlaySpeedBody;

  /// No description provided for @gameSpeedBonus.
  ///
  /// In en, this message translates to:
  /// **'+{percent}%'**
  String gameSpeedBonus(int percent);

  /// No description provided for @gameSpeedBonusSemantics.
  ///
  /// In en, this message translates to:
  /// **'Speed bonus {percent} percent'**
  String gameSpeedBonusSemantics(int percent);

  /// No description provided for @howToPlayTitle.
  ///
  /// In en, this message translates to:
  /// **'How to play Qubble'**
  String get howToPlayTitle;

  /// No description provided for @howToPlayIntroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Easy to start.\nRewards planning ahead.'**
  String get howToPlayIntroHeadline;

  /// No description provided for @howToPlayIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Keep the board clear and beat your best score.'**
  String get howToPlayIntroBody;

  /// No description provided for @howToPlayIntroSemantics.
  ///
  /// In en, this message translates to:
  /// **'Goal of the game. Keep the board clear and beat your best score.'**
  String get howToPlayIntroSemantics;

  /// No description provided for @howToPlayDragTitle.
  ///
  /// In en, this message translates to:
  /// **'Drag & place'**
  String get howToPlayDragTitle;

  /// No description provided for @howToPlayDragBody.
  ///
  /// In en, this message translates to:
  /// **'Drag one of the three pieces onto free cells. Once all three are used, you get three new ones automatically.'**
  String get howToPlayDragBody;

  /// No description provided for @howToPlayClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear lines'**
  String get howToPlayClearTitle;

  /// No description provided for @howToPlayClearBody.
  ///
  /// In en, this message translates to:
  /// **'Fill a complete row or column. Full lines dissolve and make room for your next move.'**
  String get howToPlayClearBody;

  /// No description provided for @howToPlayComboTitle.
  ///
  /// In en, this message translates to:
  /// **'Chain combos'**
  String get howToPlayComboTitle;

  /// No description provided for @howToPlayComboBody.
  ///
  /// In en, this message translates to:
  /// **'Clear another line within three moves. Every further combo raises your score multiplier. The combo counts moves, not seconds, so it never runs out while you think.'**
  String get howToPlayComboBody;

  /// No description provided for @howToPlayFeverTitle.
  ///
  /// In en, this message translates to:
  /// **'Trigger fever'**
  String get howToPlayFeverTitle;

  /// No description provided for @howToPlayFeverBody.
  ///
  /// In en, this message translates to:
  /// **'Clears fill the fever meter. Once it\'s full, the next burst counts double — plan big clears ahead.'**
  String get howToPlayFeverBody;

  /// No description provided for @howToPlayBoosterTitle.
  ///
  /// In en, this message translates to:
  /// **'Use boosters wisely'**
  String get howToPlayBoosterTitle;

  /// No description provided for @howToPlayBoosterBody.
  ///
  /// In en, this message translates to:
  /// **'Boosters rescue tight runs. You can also tap a piece in the tray to rotate it.'**
  String get howToPlayBoosterBody;

  /// No description provided for @howToPlayDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily & streak'**
  String get howToPlayDailyTitle;

  /// No description provided for @howToPlayDailyBody.
  ///
  /// In en, this message translates to:
  /// **'The daily challenge uses the same pieces for everyone. Play every day to grow your streak and bonus.'**
  String get howToPlayDailyBody;

  /// No description provided for @howToPlayPiggyTitle.
  ///
  /// In en, this message translates to:
  /// **'Fill the piggy bank'**
  String get howToPlayPiggyTitle;

  /// No description provided for @howToPlayPiggyBody.
  ///
  /// In en, this message translates to:
  /// **'Every cleared line fills your piggy bank. When it\'s full, you can collect the coins for free.'**
  String get howToPlayPiggyBody;

  /// No description provided for @leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTitle;

  /// No description provided for @leaderboardUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard unavailable.\nTry again with an internet connection.'**
  String get leaderboardUnreachable;

  /// No description provided for @leaderboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'No entries yet.\nBe the first!'**
  String get leaderboardEmpty;

  /// No description provided for @leaderboardSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Your best score ({score}) is being submitted …'**
  String leaderboardSubmitting(int score);

  /// No description provided for @leaderboardAutoSubmit.
  ///
  /// In en, this message translates to:
  /// **'Your best score is submitted automatically.'**
  String get leaderboardAutoSubmit;

  /// No description provided for @puzzleModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Puzzle Mode'**
  String get puzzleModeTitle;

  /// No description provided for @puzzleLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Puzzle {level}'**
  String puzzleLevelTitle(int level);

  /// No description provided for @puzzleMoveCounter.
  ///
  /// In en, this message translates to:
  /// **'Moves: {moves}   •   Target: {target} for 3 stars'**
  String puzzleMoveCounter(int moves, int target);

  /// No description provided for @puzzleSolved.
  ///
  /// In en, this message translates to:
  /// **'Solved!'**
  String get puzzleSolved;

  /// No description provided for @puzzleLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave the puzzle?'**
  String get puzzleLeaveTitle;

  /// No description provided for @puzzleLeaveBody.
  ///
  /// In en, this message translates to:
  /// **'Your progress in this puzzle will be lost.'**
  String get puzzleLeaveBody;

  /// No description provided for @puzzleKeepPlaying.
  ///
  /// In en, this message translates to:
  /// **'Keep playing'**
  String get puzzleKeepPlaying;

  /// No description provided for @puzzleLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get puzzleLeave;

  /// No description provided for @puzzleStuckTitle.
  ///
  /// In en, this message translates to:
  /// **'Stuck'**
  String get puzzleStuckTitle;

  /// No description provided for @puzzleRestart.
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get puzzleRestart;

  /// No description provided for @commonActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get commonActive;

  /// No description provided for @commonTapToActivate.
  ///
  /// In en, this message translates to:
  /// **'Tap to activate'**
  String get commonTapToActivate;

  /// No description provided for @commonRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get commonRestore;

  /// No description provided for @unlockForCost.
  ///
  /// In en, this message translates to:
  /// **'{cost} to unlock'**
  String unlockForCost(int cost);

  /// No description provided for @skinsExchangeGold.
  ///
  /// In en, this message translates to:
  /// **'Exchange gold'**
  String get skinsExchangeGold;

  /// No description provided for @statsAchievementsRatio.
  ///
  /// In en, this message translates to:
  /// **'{unlocked} / {total}'**
  String statsAchievementsRatio(int unlocked, int total);

  /// No description provided for @trayRotatePiece.
  ///
  /// In en, this message translates to:
  /// **'Rotate piece'**
  String get trayRotatePiece;

  /// No description provided for @puzzleNextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next level'**
  String get puzzleNextLevel;

  /// No description provided for @puzzleBackToOverview.
  ///
  /// In en, this message translates to:
  /// **'Back to overview'**
  String get puzzleBackToOverview;

  /// No description provided for @puzzleUnsolvable.
  ///
  /// In en, this message translates to:
  /// **'The board can\'t be emptied from here any more.'**
  String get puzzleUnsolvable;

  /// No description provided for @puzzleExtraMoveVideo.
  ///
  /// In en, this message translates to:
  /// **'Extra move (video)'**
  String get puzzleExtraMoveVideo;

  /// No description provided for @puzzleSolvedCount.
  ///
  /// In en, this message translates to:
  /// **'{solved} solved'**
  String puzzleSolvedCount(int solved);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @storageFailureTitle.
  ///
  /// In en, this message translates to:
  /// **'Qubble cannot load your saved game'**
  String get storageFailureTitle;

  /// No description provided for @storageFailureBody.
  ///
  /// In en, this message translates to:
  /// **'Please restart the app. If the error persists, only a reinstall helps — please report it in the playtest.'**
  String get storageFailureBody;

  /// No description provided for @iapUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This offer isn\'t available right now.'**
  String get iapUnavailable;

  /// No description provided for @iapFailed.
  ///
  /// In en, this message translates to:
  /// **'The purchase didn\'t go through. Nothing was charged.'**
  String get iapFailed;

  /// No description provided for @settingsResetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset progress'**
  String get settingsResetProgress;

  /// No description provided for @settingsResetProgressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Score, coins, level and progress back to the start. Purchases, name and cosmetics are kept.'**
  String get settingsResetProgressSubtitle;

  /// No description provided for @settingsResetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset progress?'**
  String get settingsResetConfirmTitle;

  /// No description provided for @settingsResetConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Best score, coins, level, streak and all progress will be deleted. This cannot be undone.\n\nYour purchases, your name and unlocked themes and skins are kept.'**
  String get settingsResetConfirmBody;

  /// No description provided for @settingsResetConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get settingsResetConfirmAction;

  /// No description provided for @settingsResetDone.
  ///
  /// In en, this message translates to:
  /// **'Progress reset.'**
  String get settingsResetDone;

  /// No description provided for @settingsSectionGame.
  ///
  /// In en, this message translates to:
  /// **'Game'**
  String get settingsSectionGame;

  /// No description provided for @settingsSectionSoundHaptics.
  ///
  /// In en, this message translates to:
  /// **'Sound & haptics'**
  String get settingsSectionSoundHaptics;

  /// No description provided for @settingsSectionReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsSectionReminders;

  /// No description provided for @settingsSectionPurchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get settingsSectionPurchases;

  /// No description provided for @settingsSectionHelpOut.
  ///
  /// In en, this message translates to:
  /// **'Help out'**
  String get settingsSectionHelpOut;

  /// No description provided for @settingsSectionLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get settingsSectionLegal;

  /// No description provided for @settingsSectionLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsSectionLanguage;

  /// No description provided for @settingsGuide.
  ///
  /// In en, this message translates to:
  /// **'How to play'**
  String get settingsGuide;

  /// No description provided for @settingsGuideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rules, combos, fever & boosters'**
  String get settingsGuideSubtitle;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsSound;

  /// No description provided for @settingsMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get settingsMusic;

  /// No description provided for @settingsHaptics.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsHaptics;

  /// Haptic strength option: no vibration
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsHapticsOff;

  /// Haptic strength option: gentle vibration
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsHapticsLight;

  /// Haptic strength option: full vibration
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get settingsHapticsStrong;

  /// Settings section heading for comfort options
  ///
  /// In en, this message translates to:
  /// **'Comfort'**
  String get settingsSectionAccessibility;

  /// Toggle for fewer particles, no screen shake and no glow
  ///
  /// In en, this message translates to:
  /// **'Reduced effects'**
  String get settingsReducedEffects;

  /// Explains what the reduced effects toggle does
  ///
  /// In en, this message translates to:
  /// **'Fewer particles, no screen shake, no glow'**
  String get settingsReducedEffectsHint;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder & streak protection'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsNotificationsSystemHint.
  ///
  /// In en, this message translates to:
  /// **'Allow it in your system settings.'**
  String get settingsNotificationsSystemHint;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsSupporterThanks.
  ///
  /// In en, this message translates to:
  /// **'Supporter — thank you!'**
  String get settingsSupporterThanks;

  /// No description provided for @settingsSupporterPack.
  ///
  /// In en, this message translates to:
  /// **'Supporter pack'**
  String get settingsSupporterPack;

  /// No description provided for @settingsSupporterPackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exclusive theme & skin + 1,500 coins'**
  String get settingsSupporterPackSubtitle;

  /// No description provided for @settingsRestorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get settingsRestorePurchases;

  /// No description provided for @settingsRestoring.
  ///
  /// In en, this message translates to:
  /// **'Restoring purchases…'**
  String get settingsRestoring;

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the app'**
  String get settingsRateApp;

  /// No description provided for @settingsRateAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Leave a rating in the store'**
  String get settingsRateAppSubtitle;

  /// No description provided for @settingsStoreUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The store isn\'t available on this device.'**
  String get settingsStoreUnavailable;

  /// No description provided for @settingsFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get settingsFeedback;

  /// No description provided for @settingsFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Report ideas & bugs (via GitHub)'**
  String get settingsFeedbackSubtitle;

  /// No description provided for @settingsAdPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Ad privacy settings'**
  String get settingsAdPrivacy;

  /// No description provided for @settingsAdPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'View or change your ad consent'**
  String get settingsAdPrivacySubtitle;

  /// No description provided for @settingsAdPrivacyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No ad options are required on this device.'**
  String get settingsAdPrivacyUnavailable;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacy;

  /// No description provided for @settingsImprint.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get settingsImprint;

  /// No description provided for @settingsPageOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'The page could not be opened.'**
  String get settingsPageOpenFailed;

  /// No description provided for @settingsFooter.
  ///
  /// In en, this message translates to:
  /// **'Qubble • Offline Block Puzzle'**
  String get settingsFooter;

  /// No description provided for @settingsAdminSection.
  ///
  /// In en, this message translates to:
  /// **'Admin (test)'**
  String get settingsAdminSection;

  /// No description provided for @settingsAdminEnabled.
  ///
  /// In en, this message translates to:
  /// **'Admin mode enabled'**
  String get settingsAdminEnabled;

  /// No description provided for @settingsAdminTapsLeft.
  ///
  /// In en, this message translates to:
  /// **'Tap {count} more times for admin mode'**
  String settingsAdminTapsLeft(int count);

  /// No description provided for @settingsAdminCoins.
  ///
  /// In en, this message translates to:
  /// **'{coins} coins'**
  String settingsAdminCoins(int coins);

  /// No description provided for @settingsAdminCoinsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For testing only — never show in release screenshots'**
  String get settingsAdminCoinsSubtitle;

  /// No description provided for @settingsAdminAddCoins.
  ///
  /// In en, this message translates to:
  /// **'+{amount} coins'**
  String settingsAdminAddCoins(int amount);

  /// No description provided for @settingsAdminResetCoins.
  ///
  /// In en, this message translates to:
  /// **'Set coins to 0'**
  String get settingsAdminResetCoins;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedbackTitle;

  /// No description provided for @feedbackIntroShort.
  ///
  /// In en, this message translates to:
  /// **'What do you like, what annoys you, what\'s missing? Small things help too — the more concrete, the better.'**
  String get feedbackIntroShort;

  /// No description provided for @feedbackAttachmentNote.
  ///
  /// In en, this message translates to:
  /// **'Only {build} and your device type are attached — so I know which build you mean.'**
  String feedbackAttachmentNote(String build);

  /// No description provided for @feedbackSendByMail.
  ///
  /// In en, this message translates to:
  /// **'Send by email'**
  String get feedbackSendByMail;

  /// No description provided for @feedbackPreferGithub.
  ///
  /// In en, this message translates to:
  /// **'Prefer a GitHub issue'**
  String get feedbackPreferGithub;

  /// No description provided for @feedbackThanksMail.
  ///
  /// In en, this message translates to:
  /// **'Thanks! Just send the message.'**
  String get feedbackThanksMail;

  /// No description provided for @feedbackNoMailApp.
  ///
  /// In en, this message translates to:
  /// **'No mail app found. Try the GitHub route below.'**
  String get feedbackNoMailApp;

  /// No description provided for @feedbackEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Please type something first.'**
  String get feedbackEmptyHint;

  /// No description provided for @leaderboardRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get leaderboardRefresh;

  /// No description provided for @leaderboardRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get leaderboardRetry;

  /// No description provided for @feedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Your feedback…'**
  String get feedbackHint;

  /// No description provided for @feedbackSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get feedbackSubmit;

  /// No description provided for @feedbackOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'GitHub couldn\'t be opened. Try again later.'**
  String get feedbackOpenFailed;

  /// No description provided for @feedbackGithubNote.
  ///
  /// In en, this message translates to:
  /// **'GitHub opens — tap \"Submit new issue\" there. (A one-time GitHub login is required.)'**
  String get feedbackGithubNote;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopTitle;

  /// No description provided for @shopWebDemoNote.
  ///
  /// In en, this message translates to:
  /// **'Purchases are only available in the app from the Play Store. This web version is a free demo — you can still play all of it here.'**
  String get shopWebDemoNote;

  /// No description provided for @shopSupporterExplainer.
  ///
  /// In en, this message translates to:
  /// **'Qubble shows no forced ads — you never have to buy anything. The supporter pack (Aurora theme, crystal skin, 1,500 coins, supporter badge) is a thank-you for supporting the game. Purchases are tied to your store account and can be restored at any time.'**
  String get shopSupporterExplainer;

  /// No description provided for @shopSupporterContents.
  ///
  /// In en, this message translates to:
  /// **'Aurora theme + crystal skin + 1,500 coins'**
  String get shopSupporterContents;

  /// No description provided for @themesTitle.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themesTitle;

  /// No description provided for @themesSupporterOnly.
  ///
  /// In en, this message translates to:
  /// **'Exclusive to the supporter pack (see shop)'**
  String get themesSupporterOnly;

  /// No description provided for @themesInSupporterPack.
  ///
  /// In en, this message translates to:
  /// **'In the supporter pack'**
  String get themesInSupporterPack;

  /// No description provided for @themesNotEnoughCoins.
  ///
  /// In en, this message translates to:
  /// **'Not enough coins (need {cost}, have {coins})'**
  String themesNotEnoughCoins(int cost, int coins);

  /// No description provided for @skinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Block skins'**
  String get skinsTitle;

  /// No description provided for @skinsNotEnoughDiamonds.
  ///
  /// In en, this message translates to:
  /// **'Not enough diamonds (exchange gold below)'**
  String get skinsNotEnoughDiamonds;

  /// No description provided for @skinsNotEnoughCoins.
  ///
  /// In en, this message translates to:
  /// **'Not enough coins'**
  String get skinsNotEnoughCoins;

  /// No description provided for @skinsNotEnoughGold.
  ///
  /// In en, this message translates to:
  /// **'Not enough gold.'**
  String get skinsNotEnoughGold;

  /// No description provided for @skinsExchangeHint.
  ///
  /// In en, this message translates to:
  /// **'{gold} gold = 1 diamond. Diamonds unlock the finest skins — take your time collecting.'**
  String skinsExchangeHint(int gold);

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statsTitle;

  /// No description provided for @statsAverageScore.
  ///
  /// In en, this message translates to:
  /// **'Avg. score'**
  String get statsAverageScore;

  /// No description provided for @statsBestCombo.
  ///
  /// In en, this message translates to:
  /// **'Best combo'**
  String get statsBestCombo;

  /// No description provided for @statsGames.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get statsGames;

  /// No description provided for @statsLinesCleared.
  ///
  /// In en, this message translates to:
  /// **'Rows cleared'**
  String get statsLinesCleared;

  /// No description provided for @statsPiecesPlaced.
  ///
  /// In en, this message translates to:
  /// **'Pieces placed'**
  String get statsPiecesPlaced;

  /// No description provided for @statsCoins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get statsCoins;

  /// No description provided for @missionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Missions'**
  String get missionsTitle;

  /// Mission goal, tiered
  ///
  /// In en, this message translates to:
  /// **'Place {count} pieces'**
  String missionPlacePieces(int count);

  /// Mission goal, tiered
  ///
  /// In en, this message translates to:
  /// **'Clear {count} rows'**
  String missionClearRows(int count);

  /// Mission goal, tiered
  ///
  /// In en, this message translates to:
  /// **'Reach a {count}x combo'**
  String missionReachCombo(int count);

  /// Mission goal, tiered
  ///
  /// In en, this message translates to:
  /// **'Break {count} points in one run'**
  String missionBreakScore(int count);

  /// Mission goal, tiered
  ///
  /// In en, this message translates to:
  /// **'Play {count} runs'**
  String missionPlayRuns(int count);

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementFirstGameTitle.
  ///
  /// In en, this message translates to:
  /// **'First run'**
  String get achievementFirstGameTitle;

  /// No description provided for @achievementFirstGameBody.
  ///
  /// In en, this message translates to:
  /// **'Play your first run'**
  String get achievementFirstGameBody;

  /// No description provided for @achievementGames25Title.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get achievementGames25Title;

  /// No description provided for @achievementGames25Body.
  ///
  /// In en, this message translates to:
  /// **'Play 25 runs'**
  String get achievementGames25Body;

  /// No description provided for @achievementGames100Title.
  ///
  /// In en, this message translates to:
  /// **'Hooked'**
  String get achievementGames100Title;

  /// No description provided for @achievementGames100Body.
  ///
  /// In en, this message translates to:
  /// **'Play 100 runs'**
  String get achievementGames100Body;

  /// No description provided for @achievementScore1kTitle.
  ///
  /// In en, this message translates to:
  /// **'Climber'**
  String get achievementScore1kTitle;

  /// No description provided for @achievementScore1kBody.
  ///
  /// In en, this message translates to:
  /// **'Reach 1,000 points'**
  String get achievementScore1kBody;

  /// No description provided for @achievementScore5kTitle.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get achievementScore5kTitle;

  /// No description provided for @achievementScore5kBody.
  ///
  /// In en, this message translates to:
  /// **'Reach 5,000 points'**
  String get achievementScore5kBody;

  /// No description provided for @achievementScore10kTitle.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get achievementScore10kTitle;

  /// No description provided for @achievementScore10kBody.
  ///
  /// In en, this message translates to:
  /// **'Reach 10,000 points'**
  String get achievementScore10kBody;

  /// No description provided for @achievementScore25kTitle.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get achievementScore25kTitle;

  /// No description provided for @achievementScore25kBody.
  ///
  /// In en, this message translates to:
  /// **'Reach 25,000 points'**
  String get achievementScore25kBody;

  /// No description provided for @achievementLines100Title.
  ///
  /// In en, this message translates to:
  /// **'Tidy'**
  String get achievementLines100Title;

  /// No description provided for @achievementLines100Body.
  ///
  /// In en, this message translates to:
  /// **'Clear 100 rows in total'**
  String get achievementLines100Body;

  /// No description provided for @achievementLines1000Title.
  ///
  /// In en, this message translates to:
  /// **'Spring cleaner'**
  String get achievementLines1000Title;

  /// No description provided for @achievementLines1000Body.
  ///
  /// In en, this message translates to:
  /// **'Clear 1,000 rows in total'**
  String get achievementLines1000Body;

  /// No description provided for @achievementCombo5Title.
  ///
  /// In en, this message translates to:
  /// **'Combo starter'**
  String get achievementCombo5Title;

  /// No description provided for @achievementCombo5Body.
  ///
  /// In en, this message translates to:
  /// **'Reach a 5x combo'**
  String get achievementCombo5Body;

  /// No description provided for @achievementCombo10Title.
  ///
  /// In en, this message translates to:
  /// **'Combo king'**
  String get achievementCombo10Title;

  /// No description provided for @achievementCombo10Body.
  ///
  /// In en, this message translates to:
  /// **'Reach a 10x combo'**
  String get achievementCombo10Body;

  /// No description provided for @achievementLevel10Title.
  ///
  /// In en, this message translates to:
  /// **'Experienced'**
  String get achievementLevel10Title;

  /// No description provided for @achievementLevel10Body.
  ///
  /// In en, this message translates to:
  /// **'Reach level 10'**
  String get achievementLevel10Body;

  /// No description provided for @achievementLevel20Title.
  ///
  /// In en, this message translates to:
  /// **'Veteran'**
  String get achievementLevel20Title;

  /// No description provided for @achievementLevel20Body.
  ///
  /// In en, this message translates to:
  /// **'Reach level 20'**
  String get achievementLevel20Body;

  /// No description provided for @achievementStreak7Title.
  ///
  /// In en, this message translates to:
  /// **'Week streak'**
  String get achievementStreak7Title;

  /// No description provided for @achievementStreak7Body.
  ///
  /// In en, this message translates to:
  /// **'A 7-day daily streak'**
  String get achievementStreak7Body;

  /// No description provided for @achievementStreak30Title.
  ///
  /// In en, this message translates to:
  /// **'Month streak'**
  String get achievementStreak30Title;

  /// No description provided for @achievementStreak30Body.
  ///
  /// In en, this message translates to:
  /// **'A 30-day daily streak'**
  String get achievementStreak30Body;

  /// No description provided for @achievementPuzzles10Title.
  ///
  /// In en, this message translates to:
  /// **'Puzzler'**
  String get achievementPuzzles10Title;

  /// No description provided for @achievementPuzzles10Body.
  ///
  /// In en, this message translates to:
  /// **'Solve 10 puzzles'**
  String get achievementPuzzles10Body;

  /// No description provided for @achievementPieces5000Title.
  ///
  /// In en, this message translates to:
  /// **'Builder'**
  String get achievementPieces5000Title;

  /// No description provided for @achievementPieces5000Body.
  ///
  /// In en, this message translates to:
  /// **'Place 5,000 pieces'**
  String get achievementPieces5000Body;

  /// No description provided for @streakRepairTitle.
  ///
  /// In en, this message translates to:
  /// **'{streak}-day streak at risk!'**
  String streakRepairTitle(int streak);

  /// No description provided for @streakRepairBody.
  ///
  /// In en, this message translates to:
  /// **'You skipped yesterday — rescue your streak:'**
  String get streakRepairBody;

  /// No description provided for @streakRepairFailed.
  ///
  /// In en, this message translates to:
  /// **'Repair isn\'t possible.'**
  String get streakRepairFailed;

  /// No description provided for @comebackGift.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! +{coins} coins'**
  String comebackGift(int coins);

  /// No description provided for @notificationsOptInTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders?'**
  String get notificationsOptInTitle;

  /// No description provided for @notificationsOptInBody.
  ///
  /// In en, this message translates to:
  /// **'Should we remind you about your daily puzzle and protect your streak? You can change this any time in the settings.'**
  String get notificationsOptInBody;

  /// No description provided for @notificationsOptInAccept.
  ///
  /// In en, this message translates to:
  /// **'Yes, please'**
  String get notificationsOptInAccept;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder, streak warning, comeback'**
  String get notificationChannelDescription;

  /// No description provided for @notificationDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your daily puzzle is waiting 🧩'**
  String get notificationDailyTitle;

  /// No description provided for @notificationDailyBody.
  ///
  /// In en, this message translates to:
  /// **'Play today\'s challenge!'**
  String get notificationDailyBody;

  /// No description provided for @notificationStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'🔥 Your {streak}-day streak is at risk!'**
  String notificationStreakTitle(int streak);

  /// No description provided for @notificationStreakBody.
  ///
  /// In en, this message translates to:
  /// **'Play today to keep it alive.'**
  String get notificationStreakBody;

  /// No description provided for @notificationComebackTitle.
  ///
  /// In en, this message translates to:
  /// **'Your puzzle misses you 🧩'**
  String get notificationComebackTitle;

  /// No description provided for @notificationComebackBody.
  ///
  /// In en, this message translates to:
  /// **'Come back and pick up a gift!'**
  String get notificationComebackBody;

  /// No description provided for @iapSupporterPack.
  ///
  /// In en, this message translates to:
  /// **'Supporter pack'**
  String get iapSupporterPack;

  /// No description provided for @iapCoinsSmall.
  ///
  /// In en, this message translates to:
  /// **'500 coins'**
  String get iapCoinsSmall;

  /// No description provided for @iapCoinsMedium.
  ///
  /// In en, this message translates to:
  /// **'2,000 coins'**
  String get iapCoinsMedium;

  /// No description provided for @iapCoinsLarge.
  ///
  /// In en, this message translates to:
  /// **'6,000 coins'**
  String get iapCoinsLarge;

  /// No description provided for @iapStarterPack.
  ///
  /// In en, this message translates to:
  /// **'Starter pack'**
  String get iapStarterPack;

  /// No description provided for @iapRename.
  ///
  /// In en, this message translates to:
  /// **'Name change'**
  String get iapRename;

  /// No description provided for @iapNeonTheme.
  ///
  /// In en, this message translates to:
  /// **'Neon theme'**
  String get iapNeonTheme;

  /// Settings action that removes the player's public leaderboard entry
  ///
  /// In en, this message translates to:
  /// **'Delete leaderboard entry'**
  String get settingsLeaderboardDelete;

  /// Subtitle explaining what the delete action removes
  ///
  /// In en, this message translates to:
  /// **'Removes your name and score from the public list'**
  String get settingsLeaderboardDeleteSubtitle;

  /// Title of the confirmation dialog before deleting the leaderboard entry
  ///
  /// In en, this message translates to:
  /// **'Delete your entry?'**
  String get settingsLeaderboardDeleteConfirmTitle;

  /// Body of the confirmation dialog before deleting the leaderboard entry
  ///
  /// In en, this message translates to:
  /// **'Your name and score will be removed from the leaderboard. Your game progress stays untouched. You can enter the leaderboard again at any time.'**
  String get settingsLeaderboardDeleteConfirmBody;

  /// Confirmation that the leaderboard entry was deleted
  ///
  /// In en, this message translates to:
  /// **'Your leaderboard entry was deleted.'**
  String get settingsLeaderboardDeleteDone;

  /// Shown when deleting the leaderboard entry failed
  ///
  /// In en, this message translates to:
  /// **'The entry could not be deleted. Check your connection and try again.'**
  String get settingsLeaderboardDeleteFailed;

  /// Action to report an offensive leaderboard name
  ///
  /// In en, this message translates to:
  /// **'Report this name'**
  String get leaderboardReport;

  /// Button that hides a leaderboard entry for this player
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get leaderboardBlock;

  /// Confirmation after blocking a name
  ///
  /// In en, this message translates to:
  /// **'{name} is hidden for you'**
  String leaderboardBlocked(String name);

  /// Undoes the block
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get leaderboardUndo;

  /// Footer telling the player how many entries are hidden
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 entry hidden by you} other{{count} entries hidden by you}}'**
  String leaderboardBlockedCount(int count);

  /// Restores all blocked entries
  ///
  /// In en, this message translates to:
  /// **'Show again'**
  String get leaderboardUnblockAll;

  /// Shown when the report mail could not be opened
  ///
  /// In en, this message translates to:
  /// **'Reporting is unavailable right now.'**
  String get leaderboardReportUnavailable;

  /// Shown after the report mail was opened
  ///
  /// In en, this message translates to:
  /// **'Thanks — your report is on its way.'**
  String get leaderboardReportSent;

  /// The rule a player accepts before choosing a public leaderboard name
  ///
  /// In en, this message translates to:
  /// **'Names are public. No insults, no slurs, and nothing that identifies a real person. Names that break this are removed.'**
  String get leaderboardRules;

  /// Button confirming the player accepts the naming rule
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get leaderboardRulesAccept;

  /// Progress line on the achievements screen
  ///
  /// In en, this message translates to:
  /// **'{unlocked} of {total} unlocked'**
  String achievementsUnlockedCount(int unlocked, int total);

  /// Settings section holding the save-data actions
  ///
  /// In en, this message translates to:
  /// **'Saved data'**
  String get settingsSectionData;

  /// Label for the rotate button under the piece tray
  ///
  /// In en, this message translates to:
  /// **'Rotate piece'**
  String get gameRotatePiece;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return L10nDe();
    case 'en':
      return L10nEn();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
