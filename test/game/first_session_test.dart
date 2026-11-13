// What the game puts in front of a player, and when.
//
// Measured on 09.11.2026 by walking a fresh install: before the first block
// there were two dialogs (statistics, then Google's advertising form) and a
// menu; the first game over, a minute and a half in, opened a third (the
// leaderboard name). None of them is needed that early.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/first_session.dart';

void main() {
  group('the board comes first', () {
    test('a player who has never finished a run starts on the board', () {
      expect(FirstSession.opensBoard(finishedRuns: 0), isTrue);
    });

    test('everyone else starts on the menu', () {
      for (final runs in [1, 2, 50]) {
        expect(FirstSession.opensBoard(finishedRuns: runs), isFalse);
      }
    });
  });

  group('the statistics question', () {
    test('does not open the very first launch', () {
      expect(
        FirstSession.asksStatsAtLaunch(finishedRuns: 0, earlierLaunches: 0),
        isFalse,
      );
    });

    test('nor the second, while no run is finished', () {
      expect(
        FirstSession.asksStatsAtLaunch(finishedRuns: 0, earlierLaunches: 1),
        isFalse,
      );
    });

    test('opens a launch for anyone who has finished a run', () {
      // Players updating from a version that never asked, and new players
      // who closed the app on their first game over.
      expect(
        FirstSession.asksStatsAtLaunch(finishedRuns: 1, earlierLaunches: 0),
        isTrue,
      );
      expect(
        FirstSession.asksStatsAtLaunch(finishedRuns: 40, earlierLaunches: 12),
        isTrue,
      );
    });

    test('opens the third launch even without a finished run', () {
      // Someone who only plays puzzles never sees a game over.
      expect(
        FirstSession.asksStatsAtLaunch(finishedRuns: 0, earlierLaunches: 2),
        isTrue,
      );
    });

    test('follows the first finished run, and any later one while open', () {
      expect(FirstSession.asksStatsAfterRun(finishedRuns: 1), isTrue);
      expect(FirstSession.asksStatsAfterRun(finishedRuns: 7), isTrue);
      expect(FirstSession.asksStatsAfterRun(finishedRuns: 0), isFalse);
    });
  });

  group('a Qubbie moment has the game over to itself', () {
    test('the run that brings the free first egg', () {
      expect(
        FirstSession.petMomentComesFirst(
          finishedRuns: 3,
          starterChosen: false,
          eggOpens: false,
        ),
        isTrue,
      );
    });

    test('not the runs before it, and not every run after it', () {
      // An egg left unchosen is offered on every result, quietly. If it
      // kept the questions away as well, a player who never picks one would
      // never be asked for a name or about reminders.
      for (final runs in [1, 2, 4, 5, 40]) {
        expect(
          FirstSession.petMomentComesFirst(
            finishedRuns: runs,
            starterChosen: false,
            eggOpens: false,
          ),
          isFalse,
          reason: 'run $runs',
        );
      }
    });

    test('not once the egg is chosen', () {
      expect(
        FirstSession.petMomentComesFirst(
          finishedRuns: 3,
          starterChosen: true,
          eggOpens: false,
        ),
        isFalse,
      );
    });

    test('any run on which an egg opens', () {
      for (final runs in [4, 9, 200]) {
        expect(
          FirstSession.petMomentComesFirst(
            finishedRuns: runs,
            starterChosen: true,
            eggOpens: true,
          ),
          isTrue,
        );
      }
    });
  });

  group('the reminder question', () {
    test('follows a finished Daily, once', () {
      expect(
        FirstSession.asksForRemindersAfterRun(
          wasDaily: true,
          supported: true,
          enabled: false,
          askedBefore: false,
        ),
        isTrue,
      );
    });

    test('not after an endless run', () {
      expect(
        FirstSession.asksForRemindersAfterRun(
          wasDaily: false,
          supported: true,
          enabled: false,
          askedBefore: false,
        ),
        isFalse,
      );
    });

    test('not twice, not when on, not where none can arrive', () {
      expect(
        FirstSession.asksForRemindersAfterRun(
          wasDaily: true,
          supported: true,
          enabled: false,
          askedBefore: true,
        ),
        isFalse,
      );
      expect(
        FirstSession.asksForRemindersAfterRun(
          wasDaily: true,
          supported: true,
          enabled: true,
          askedBefore: false,
        ),
        isFalse,
      );
      expect(
        FirstSession.asksForRemindersAfterRun(
          wasDaily: true,
          supported: false,
          enabled: false,
          askedBefore: false,
        ),
        isFalse,
      );
    });

    test('opens a launch from the second on, for a player who has played', () {
      bool at({required int launches, required int runs, bool asked = false}) =>
          FirstSession.asksForRemindersAtLaunch(
            launchNumber: launches,
            finishedRuns: runs,
            supported: true,
            enabled: false,
            askedBefore: asked,
          );
      expect(at(launches: 1, runs: 0), isFalse);
      expect(at(launches: 1, runs: 3), isFalse, reason: 'never the first');
      expect(at(launches: 2, runs: 0), isFalse, reason: 'the board is open');
      expect(at(launches: 2, runs: 1), isTrue);
      expect(at(launches: 5, runs: 9), isTrue, reason: 'missed launch two');
      expect(at(launches: 5, runs: 9, asked: true), isFalse);
    });
  });
}
