// A run can end on a rotation: the last rotation charge turns a piece that
// still fits nowhere, and the session is over without another placement.
// Only placing used to settle a run, so such a run paid nothing — no daily
// streak, no coins, no quests. The daily of 29.09.2026 ended that way in
// test/ui/daily_double_test.dart, which is how this came to light.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/daily.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

/// Plays greedily like [playToGameOver]; returns whether the move that ended
/// the run was a rotation.
bool _playReportingLastMove(GameController c) {
  var lastWasRotation = false;
  var guard = 0;
  while (!c.state.gameOver && guard++ < 3000) {
    if (placeSomething(c)) {
      lastWasRotation = false;
      continue;
    }
    var moved = false;
    for (var slot = 0; slot < c.state.tray.length && !moved; slot++) {
      if (c.state.tray[slot] == null) continue;
      for (var i = 0; i < 3; i++) {
        if (!c.rotateTray(slot)) break;
        lastWasRotation = true;
        moved = true;
        if (c.state.gameOver) break;
        if (placeSomething(c)) {
          lastWasRotation = false;
          break;
        }
      }
    }
    if (!moved) break;
  }
  return lastWasRotation;
}

void main() {
  test('a daily that a rotation ends still pays out', () async {
    // Find a daily whose greedy run ends on a rotation, so the test keeps
    // covering the path even if the generator changes.
    for (var d = 0; d < 120; d++) {
      final day = DateTime(2026, 9, 1 + d, 12);
      SharedPreferences.setMockInitialValues({'onboardingDone': true});
      final storage = await Storage.create();
      final c = GameController(
        storage,
        Haptics(enabled: false),
        SilentAudio(),
        FakeAdService(),
        NoopAnalytics(),
        clock: SteppingClock().call,
        calendar: () => day,
      );
      c.startDaily(now: day);
      final endedOnRotation = _playReportingLastMove(c);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      if (!c.state.gameOver || !endedOnRotation) continue;

      expect(storage.lifetimeStats.games, 1, reason: 'the run was counted');
      expect(storage.lastDailyDate, DailyChallenge.dateKey(day));
      expect(storage.streak, 1);
      expect(c.state.dailyRewardThisRun, greaterThan(0));
      return;
    }
    fail('no daily in 120 days ended on a rotation; the test needs a new '
        'way to reach that path');
  });
}
