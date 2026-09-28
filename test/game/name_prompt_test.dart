import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/name_prompt.dart';

void main() {
  group('NamePrompt.shouldAsk', () {
    test('asks at the end of the first round', () {
      expect(
        NamePrompt.shouldAsk(
          hasName: false,
          stage: NamePromptStage.notAsked,
          newPersonalBest: false,
        ),
        isTrue,
      );
    });

    test('a player updating with rounds behind them is asked at the next '
        'game over, like a new one', () {
      // The stage starts at notAsked for everyone; the question is "has this
      // player been asked", not "is this their first round ever".
      expect(
        NamePrompt.shouldAsk(
          hasName: false,
          stage: NamePromptStage.notAsked,
          newPersonalBest: true,
        ),
        isTrue,
      );
    });

    test('never asks a player who already has a name', () {
      for (final stage in NamePromptStage.values) {
        for (final best in [false, true]) {
          expect(
            NamePrompt.shouldAsk(
              hasName: true,
              stage: stage,
              newPersonalBest: best,
            ),
            isFalse,
            reason: '$stage, best: $best',
          );
        }
      }
    });

    test('after one skip, asks again only on a new personal best', () {
      expect(
        NamePrompt.shouldAsk(
          hasName: false,
          stage: NamePromptStage.skippedOnce,
          newPersonalBest: false,
        ),
        isFalse,
      );
      expect(
        NamePrompt.shouldAsk(
          hasName: false,
          stage: NamePromptStage.skippedOnce,
          newPersonalBest: true,
        ),
        isTrue,
      );
    });

    test('after the second skip it never asks again', () {
      for (final best in [false, true]) {
        expect(
          NamePrompt.shouldAsk(
            hasName: false,
            stage: NamePromptStage.done,
            newPersonalBest: best,
          ),
          isFalse,
        );
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

    test('the whole path: first round, a plain round, a new best, then '
        'silence', () {
      var stage = NamePromptStage.notAsked;
      final asked = <bool>[];
      for (final best in [false, false, true, true, true]) {
        final ask = NamePrompt.shouldAsk(
          hasName: false,
          stage: stage,
          newPersonalBest: best,
        );
        asked.add(ask);
        if (ask) stage = NamePrompt.afterAsking(stage);
      }
      expect(asked, [true, false, true, false, false]);
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
