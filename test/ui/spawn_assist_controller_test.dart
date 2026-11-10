// Which generator an endless run gets (BALANCE.md, Nachtrag 6): the opening
// help in every run, a longer one for a player's first three, and none in the
// Daily Challenge, whose pieces have to be the same for everyone.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/generator.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

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
  test('the presets are the measured ones', () {
    expect(SpawnAssist.endless.fullMoves, 24);
    expect(SpawnAssist.endless.fadeMoves, 48);
    expect(SpawnAssist.welcome.fullMoves, 45);
    expect(SpawnAssist.welcome.fadeMoves, 75);
    expect(SpawnAssist.welcomeRuns, 3);
    expect(SpawnAssist.forEndlessRun(0), same(SpawnAssist.welcome));
    expect(SpawnAssist.forEndlessRun(2), same(SpawnAssist.welcome));
    expect(SpawnAssist.forEndlessRun(3), same(SpawnAssist.endless));
    expect(SpawnAssist.forEndlessRun(500), same(SpawnAssist.endless));
  });

  test('a new player starts with the welcome assist', () async {
    final (controller, _) = await _controller({});
    expect(controller.assistForTest.fullMoves, SpawnAssist.welcome.fullMoves);
    controller.newGame(seed: 7);
    expect(controller.assistForTest.fullMoves, SpawnAssist.welcome.fullMoves);
    expect(controller.assistForTest.fadeMoves, SpawnAssist.welcome.fadeMoves);
  });

  test('from the fourth run on it is the regular one', () async {
    final (controller, _) = await _controller({'lifetimeStats': '{"games":3}'});
    controller.newGame(seed: 7);
    expect(controller.assistForTest.fullMoves, SpawnAssist.endless.fullMoves);
    expect(controller.assistForTest.fadeMoves, SpawnAssist.endless.fadeMoves);
  });

  test('the Daily Challenge is dealt by the classic generator', () async {
    final (controller, _) = await _controller({});
    controller.startDaily(now: DateTime(2026, 7, 23));
    expect(controller.assistForTest.isNone, isTrue);
  });

  test('the welcome assist ends with the third finished run', () async {
    final (controller, storage) = await _controller({});
    for (var run = 0; run < SpawnAssist.welcomeRuns; run++) {
      controller.newGame(seed: 40 + run);
      expect(
        controller.assistForTest.fullMoves,
        SpawnAssist.welcome.fullMoves,
        reason: 'run ${run + 1}',
      );
      playToGameOver(controller);
      expect(controller.state.gameOver, isTrue);
      // The run is booked asynchronously.
      await Future<void>.delayed(Duration.zero);
      while (controller.state.finalizing) {
        await Future<void>.delayed(const Duration(milliseconds: 1));
      }
    }
    expect(storage.lifetimeStats.games, SpawnAssist.welcomeRuns);
    controller.newGame(seed: 50);
    expect(controller.assistForTest.fullMoves, SpawnAssist.endless.fullMoves);
  });

  test('a parked run comes back with the assist it was started with', () async {
    final (first, storage) = await _controller({});
    first.newGame(seed: 11);
    placeSomething(first);
    placeSomething(first);
    // The checkpoint is written asynchronously.
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(storage.activeRunCheckpoint, isNotNull);

    final second = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
    );
    expect(second.assistForTest.fullMoves, SpawnAssist.welcome.fullMoves);
    expect(second.state.board.filledCount, greaterThan(0));
  });
}
