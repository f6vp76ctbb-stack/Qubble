import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/coach_hints.dart';
import 'package:gridpop/game/generator.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<(GameController, Storage)> _controller(
  Map<String, Object> preferences,
) async {
  SharedPreferences.setMockInitialValues(preferences);
  final storage = await Storage.create();
  return (
    GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
    ),
    storage,
  );
}

void main() {
  group('first-run fairness phase', () {
    test(
      'first endless run extends early weighting to 20 placements',
      () async {
        final (controller, _) = await _controller({});

        controller.newGame(seed: 7);

        expect(
          controller.earlyPhaseMovesForTest,
          GameController.firstRunEarlyPhaseMoves,
        );
        expect(GameController.firstRunEarlyPhaseMoves, 20);
      },
    );

    test('returning players use the regular 10-placement phase', () async {
      final (controller, _) = await _controller({
        'lifetimeStats': '{"games":1}',
      });

      controller.newGame(seed: 7);

      expect(
        controller.earlyPhaseMovesForTest,
        PieceGenerator.defaultEarlyPhaseMoves,
      );
      expect(PieceGenerator.defaultEarlyPhaseMoves, 10);
    });

    test('daily challenge always keeps the standard fairness phase', () async {
      final (controller, _) = await _controller({});

      controller.startDaily(now: DateTime(2026, 7, 23));

      expect(
        controller.earlyPhaseMovesForTest,
        PieceGenerator.defaultEarlyPhaseMoves,
      );
    });
  });

  group('contextual coach hints', () {
    test(
      'shows the affordable-booster hint only once and persists it',
      () async {
        final (controller, storage) = await _controller({
          'onboardingDone': true,
          'coins': 100,
          // The how-to-turn tip comes first; this test is about the booster.
          'hint.turnHow': true,
        });

        controller.newGame(seed: 3);

        expect(controller.state.contextualHint, CoachHintType.booster);
        expect(storage.seenCoachHints, contains(CoachHintType.booster));

        controller.newGame(seed: 4);
        expect(controller.state.contextualHint, isNull);
      },
    );

    test('a paid turn queues and persists the hint about charges', () async {
      final (controller, storage) = await _controller({
        'onboardingDone': true,
        'hint.turnHow': true,
        // Past the free beginner levels, so the turn costs a charge.
        'playerLevel': 3,
      });
      controller.newGame(seed: 3);
      expect(controller.state.rotationFree, isFalse);

      expect(controller.rotateTray(0), isTrue);

      expect(controller.state.contextualHint, CoachHintType.rotation);
      expect(storage.seenCoachHints, contains(CoachHintType.rotation));
    });

    test('a free turn says nothing about charges', () async {
      // Levels 1 and 2 turn for free: a hint about what a charge buys would
      // describe a cost the player never sees.
      final (controller, storage) = await _controller({
        'onboardingDone': true,
        'hint.turnHow': true,
      });
      controller.newGame(seed: 3);
      expect(controller.state.rotationFree, isTrue);

      expect(controller.rotateTray(0), isTrue);

      expect(controller.state.contextualHint, isNot(CoachHintType.rotation));
      expect(storage.seenCoachHints, isNot(contains(CoachHintType.rotation)));
    });

    test('the how-to-turn tip comes at the start of a run, once', () async {
      final (controller, storage) = await _controller({'onboardingDone': true});
      controller.newGame(seed: 3);
      expect(controller.state.contextualHint, CoachHintType.turnHow);
      expect(storage.seenCoachHints, contains(CoachHintType.turnHow));

      controller.newGame(seed: 4);
      expect(controller.state.contextualHint, isNot(CoachHintType.turnHow));
    });

    test('daily challenge suppresses the booster coach hint', () async {
      final (controller, storage) = await _controller({
        'onboardingDone': true,
        'coins': 100,
        'hint.turnHow': true,
      });

      controller.startDaily(now: DateTime(2026, 7, 23));

      expect(controller.state.contextualHint, isNull);
      expect(storage.seenCoachHints, isNot(contains(CoachHintType.booster)));
    });
  });
}
