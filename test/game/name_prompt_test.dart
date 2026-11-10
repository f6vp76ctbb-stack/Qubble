import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/name_prompt.dart';

void main() {
  group('NamePrompt.shouldAsk', () {
    bool ask({
      bool hasName = false,
      NamePromptStage stage = NamePromptStage.notAsked,
      bool best = false,
      required int runs,
    }) => NamePrompt.shouldAsk(
      hasName: hasName,
      stage: stage,
      newPersonalBest: best,
      finishedRuns: runs,
    );

    test('the first round ends without the question', () {
      // The first score is always a personal best; that must not count.
      expect(ask(runs: 1, best: true), isFalse);
      expect(ask(runs: 1), isFalse);
    });

    test('from the second round a new personal best brings it', () {
      expect(ask(runs: 2, best: true), isTrue);
      expect(ask(runs: 3, best: true), isTrue);
      expect(ask(runs: 2), isFalse);
      expect(ask(runs: 3), isFalse);
    });

    test('after the fourth round it comes without one', () {
      expect(NamePrompt.firstAskRun, 2);
      expect(NamePrompt.latestAskRun, 4);
      expect(ask(runs: 4), isTrue);
      expect(ask(runs: 5), isTrue);
    });

    test('a player updating with rounds behind them is asked at the next '
        'game over', () {
      // The stage starts at notAsked for everyone who was never asked.
      expect(ask(runs: 120), isTrue);
    });

    test('never asks a player who already has a name', () {
      for (final stage in NamePromptStage.values) {
        for (final best in [false, true]) {
          expect(
            ask(hasName: true, stage: stage, best: best, runs: 9),
            isFalse,
            reason: '$stage, best: $best',
          );
        }
      }
    });

    test('after one skip, asks again only on a new personal best', () {
      expect(ask(stage: NamePromptStage.skippedOnce, runs: 9), isFalse);
      expect(
        ask(stage: NamePromptStage.skippedOnce, best: true, runs: 9),
        isTrue,
      );
    });

    test('after the second skip it never asks again', () {
      for (final best in [false, true]) {
        expect(ask(stage: NamePromptStage.done, best: best, runs: 9), isFalse);
      }
    });
  });

  group('NamePrompt.afterAsking', () {
    test('each question moves one stage on and stops at done', () {
      expect(
        NamePrompt.afterAsking(NamePromptStage.notAsked),
        NamePromptStage.skippedOnce,
      );
      expect(
        NamePrompt.afterAsking(NamePromptStage.skippedOnce),
        NamePromptStage.done,
      );
      expect(
        NamePrompt.afterAsking(NamePromptStage.done),
        NamePromptStage.done,
      );
    });

    test('the whole path: a first round, a plain one, a new best, a skip, '
        'another best, then silence', () {
      var stage = NamePromptStage.notAsked;
      final asked = <bool>[];
      // Whether each finished run set a new personal best.
      final bests = [true, false, true, false, true, true];
      for (var run = 1; run <= bests.length; run++) {
        final ask = NamePrompt.shouldAsk(
          hasName: false,
          stage: stage,
          newPersonalBest: bests[run - 1],
          finishedRuns: run,
        );
        asked.add(ask);
        if (ask) stage = NamePrompt.afterAsking(stage);
      }
      // Run 1 never; run 3 (a best) asks; run 5 (the next best) asks once
      // more; after that nothing.
      expect(asked, [false, false, true, false, true, false]);
    });
  });

  group('NamePromptStage storage', () {
    test('round-trips through its index and tolerates junk', () {
      for (final stage in NamePromptStage.values) {
        expect(NamePromptStage.fromIndex(stage.index), stage);
      }
      expect(NamePromptStage.fromIndex(null), NamePromptStage.notAsked);
      expect(NamePromptStage.fromIndex(-1), NamePromptStage.notAsked);
      expect(NamePromptStage.fromIndex(99), NamePromptStage.done);
    });
  });
}
