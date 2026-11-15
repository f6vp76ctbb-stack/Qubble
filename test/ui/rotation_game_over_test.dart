// A run can end on a rotation. Since 15.11.2026 a charge pays for a whole
// piece, so the way it happens is: the last charge goes to a piece that fits
// in no orientation, while another piece — one that would only fit turned —
// is left without a charge to pay for its turn. The session is over without
// another placement.
//
// Only placing used to settle a run, so such a run paid nothing: no daily
// streak, no coins, no quests (found on the daily of 29.09.2026 in
// test/ui/daily_double_test.dart). Under the per-turn rule a greedy daily
// reached this path by itself; under the per-piece rule it is rare enough
// that a search over 120 dailies no longer finds it, so the position is
// built directly and handed to the controller as a saved run.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

void main() {
  test('a run that a rotation ends is settled like any other', () async {
    // Only three empty cells, stacked in column 0: a horizontal line of three
    // fits only turned, and a 2x2 square fits in no orientation.
    final board = Board.fromAscii(const [
      '.XXXXXXX',
      '.XXXXXXX',
      '.XXXXXXX',
      'XXXXXXXX',
      'XXXXXXXX',
      'XXXXXXXX',
      'XXXXXXXX',
      'XXXXXXXX',
    ]);
    final square = Piece(
      'square2',
      const [Cell(0, 0), Cell(0, 1), Cell(1, 0), Cell(1, 1)],
      1,
    );
    final line = Piece('line3_h', const [Cell(0, 0), Cell(0, 1), Cell(0, 2)], 1);
    final position = GameSession.forTest(
      board: board,
      tray: [square, line, null],
      rotationCharges: 1,
    );
    expect(position.isGameOver, isFalse, reason: 'the line can still turn');

    // A saved Endless run as the controller restores it at start-up.
    final checkpoint = Map<String, Object?>.from(position.toCheckpoint())
      ..['placements'] = 5
      ..['generatedTrays'] = 2;
    SharedPreferences.setMockInitialValues({'onboardingDone': true});
    final storage = await Storage.create();
    await storage.setActiveRunCheckpoint(checkpoint);
    final c = GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
      clock: SteppingClock().call,
    );
    expect(c.state.gameOver, isFalse);
    expect(c.state.rotationCharges, 1);

    // The last charge goes to the square. The line is left unpaid.
    expect(c.rotateTray(0), isTrue);
    expect(c.state.gameOver, isTrue);
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(storage.lifetimeStats.games, 1, reason: 'the run was counted');
    expect(storage.activeRunCheckpoint, isNull,
        reason: 'a finished run is not resumable');
  });
}
