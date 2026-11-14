/// Pure-Dart policy for what the game puts in front of a player, and when.
/// No Flutter imports — fully unit-testable.
///
/// A fresh install used to meet two dialogs and a menu before the first
/// block (statistics, Google's advertising form), and a third dialog on the
/// first game over (the leaderboard name). None of them is needed that
/// early, and each one is a place to leave. The order now:
///
///  * first launch: the board, nothing else;
///  * first game over: the statistics question (nothing is collected before
///    there is an answer, so asking later only costs measurements);
///  * a later game over: the leaderboard name (NamePrompt);
///  * the first finished Daily: reminders, where "tomorrow" means something;
///  * Google's advertising form: when the player first taps an offer that
///    needs a video (GoogleAdService).
///
/// A Qubbie moment — the free first egg appearing, an egg opening — is shown
/// on the result itself and takes that game over for itself: the name and
/// the reminders keep for the next one ([petMomentComesFirst]).
library;

import 'pet.dart';

class FirstSession {
  const FirstSession._();

  /// Whether a finished run's result belongs to the Qubbies, so that no
  /// question opens over it. [finishedRuns] includes that run.
  ///
  /// Only the one game over on which the free first egg appears, and those
  /// on which an egg opens ([eggOpens]). Not every game over while the egg
  /// is still unchosen: a player who never picks one would then never be
  /// asked for a name or about reminders at all.
  static bool petMomentComesFirst({
    required int finishedRuns,
    required bool starterChosen,
    required bool eggOpens,
  }) =>
      eggOpens ||
      (!starterChosen && finishedRuns == PetRules.firstEggAfterRuns);

  /// Whether a launch opens the board at once instead of the menu.
  ///
  /// Until a run has been finished the menu has nothing to say: a best score
  /// of zero, three empty balances, six doors to rooms that mean nothing yet.
  static bool opensBoard({required int finishedRuns}) => finishedRuns == 0;

  /// Launches after which the statistics question is put even to a player
  /// who has never finished a run (someone who only plays puzzles).
  static const int statsLaunchFallback = 2;

  /// Whether the statistics question opens this launch.
  ///
  /// [earlierLaunches] counts the launches before this one.
  static bool asksStatsAtLaunch({
    required int finishedRuns,
    required int earlierLaunches,
  }) => finishedRuns >= 1 || earlierLaunches >= statsLaunchFallback;

  /// Whether the statistics question follows a run that just ended.
  /// [finishedRuns] includes that run. The caller checks that the question
  /// is still open and that this build sends statistics at all.
  static bool asksStatsAfterRun({required int finishedRuns}) =>
      finishedRuns >= 1;

  /// Whether the reminder question follows a run that just ended: after a
  /// Daily, when "come back tomorrow" has something to point at.
  static bool asksForRemindersAfterRun({
    required bool wasDaily,
    required bool supported,
    required bool enabled,
    required bool askedBefore,
  }) => wasDaily && supported && !enabled && !askedBefore;

  /// Whether the reminder question opens this launch: from the second
  /// launch on (never the first), once, and not over the board a new player
  /// is sent to.
  static bool asksForRemindersAtLaunch({
    required int launchNumber,
    required int finishedRuns,
    required bool supported,
    required bool enabled,
    required bool askedBefore,
  }) =>
      launchNumber >= 2 &&
      finishedRuns >= 1 &&
      supported &&
      !enabled &&
      !askedBefore;
}
