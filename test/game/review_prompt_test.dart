import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/review_prompt.dart';

/// A state that clears every gate, so each test can fail exactly one.
ReviewPromptState _ready({
  int gamesPlayed = ReviewPrompt.minGamesPlayed,
  int appOpens = ReviewPrompt.minAppOpens,
  int promptCount = 0,
  DateTime? lastPromptAt,
  bool rated = false,
}) {
  return ReviewPromptState(
    gamesPlayed: gamesPlayed,
    appOpens: appOpens,
    promptCount: promptCount,
    lastPromptAt: lastPromptAt,
    rated: rated,
  );
}

final _now = DateTime(2026, 8, 30, 12);

bool _ask(
  ReviewPromptState state, {
  ReviewTrigger trigger = ReviewTrigger.newHighscore,
  DateTime? now,
}) {
  return ReviewPrompt.shouldAsk(state, trigger: trigger, now: now ?? _now);
}

void main() {
  group('ReviewPrompt.shouldAsk', () {
    test('asks after a positive moment once every gate is cleared', () {
      expect(_ask(_ready()), isTrue);
    });

    test('every trigger is a valid moment', () {
      for (final trigger in ReviewTrigger.values) {
        expect(_ask(_ready(), trigger: trigger), isTrue, reason: trigger.name);
      }
    });

    test('stays quiet until the player has played enough runs', () {
      expect(_ask(_ready(gamesPlayed: ReviewPrompt.minGamesPlayed - 1)), isFalse);
      expect(_ask(_ready(gamesPlayed: ReviewPrompt.minGamesPlayed)), isTrue);
    });

    test('never asks during the first sessions', () {
      expect(_ask(_ready(appOpens: 1)), isFalse);
      expect(_ask(_ready(appOpens: ReviewPrompt.minAppOpens - 1)), isFalse);
      expect(_ask(_ready(appOpens: ReviewPrompt.minAppOpens)), isTrue);
    });

    test('respects the lifetime cap', () {
      expect(_ask(_ready(promptCount: ReviewPrompt.maxPrompts - 1)), isTrue);
      expect(_ask(_ready(promptCount: ReviewPrompt.maxPrompts)), isFalse);
      expect(_ask(_ready(promptCount: ReviewPrompt.maxPrompts + 5)), isFalse);
    });

    test('waits out the cooldown between two requests', () {
      final justBefore = _now.subtract(
        ReviewPrompt.cooldown - const Duration(hours: 1),
      );
      expect(
        _ask(_ready(promptCount: 1, lastPromptAt: justBefore)),
        isFalse,
      );

      final justAfter = _now.subtract(
        ReviewPrompt.cooldown + const Duration(hours: 1),
      );
      expect(_ask(_ready(promptCount: 1, lastPromptAt: justAfter)), isTrue);
    });

    test('stops asking once the player rated deliberately', () {
      expect(_ask(_ready(rated: true)), isFalse);
    });

    test('a fresh install is never prompted', () {
      const fresh = ReviewPromptState(
        gamesPlayed: 0,
        appOpens: 1,
        promptCount: 0,
      );
      expect(_ask(fresh), isFalse);
    });
  });
}
