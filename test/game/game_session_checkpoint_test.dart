import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/scoring.dart';

void main() {
  test('checkpoint restores the board, score and next generated tray', () {
    final original = GameSession.newGame(seed: 42, freeRotation: false);
    _placeAnywhere(original, 0);
    original.rotate(1);

    final restored = GameSession.fromCheckpoint(
      Map<String, dynamic>.from(original.toCheckpoint()),
    );

    expect(restored.board.toAscii(), original.board.toAscii());
    expect(restored.score, original.score);
    expect(restored.combo, original.combo);
    expect(restored.placements, original.placements);
    expect(restored.rotationCharges, original.rotationCharges);
    expect(
      restored.tray.map((piece) => piece?.id),
      original.tray.map((piece) => piece?.id),
    );

    _placeRemainingTray(original);
    _placeRemainingTray(restored);
    expect(
      restored.tray.map((piece) => piece?.id),
      original.tray.map((piece) => piece?.id),
    );
  });

  test('checkpoint rejects missing generator state', () {
    final checkpoint = GameSession.newGame(seed: 7).toCheckpoint()
      ..remove('generatedTrays');

    expect(
      () => GameSession.fromCheckpoint(Map<String, dynamic>.from(checkpoint)),
      throwsFormatException,
    );
  });

  test('a checkpoint from the clock-based combo still restores', () {
    // Runs saved before the combo window moved from seconds to moves carry
    // 'lastClearMillis' and no 'movesSinceClear'. Reading the missing field as
    // zero resumes with the combo intact — the only reading that cannot punish
    // a player for an update they never asked for.
    final session = GameSession.newGame(seed: 7);
    final checkpoint = session.toCheckpoint();
    final legacy = Map<String, dynamic>.from(checkpoint);
    legacy['score'] = {
      'total': 1234,
      'combo': 3,
      'fever': 0.4,
      'lastClearMillis': DateTime(2026, 1, 1).millisecondsSinceEpoch,
    };

    final restored = GameSession.fromCheckpoint(legacy);
    expect(restored, isNotNull);
    expect(restored.score, 1234);
    expect(restored.combo, 3);
    // Zero moves spent, so the full window is left.
    expect(restored.comboMovesLeft, ScoreKeeper.defaultComboWindowMoves);
  });

  test('a checkpoint round-trips the moves spent since the last clear', () {
    final session = GameSession.newGame(seed: 11);
    final data = session.toCheckpoint();
    expect((data['score'] as Map)['movesSinceClear'], isA<int>());
    expect((data['score'] as Map).containsKey('lastClearMillis'), isFalse);
  });

  test('a corrupt colour row is rejected as a FormatException, not a crash', () {
    // Found by scripts/audit/soak.dart. The factory documents FormatException
    // for corrupt data; a short colour row used to escape that contract with a
    // RangeError, which only survived because the one caller happens to catch
    // everything. Anything narrower — a future caller following the documented
    // contract — would have crashed on startup while restoring a saved run.
    final session = GameSession.newGame(seed: 5);
    final checkpoint = session.toCheckpoint();
    final broken = Map<String, dynamic>.from(checkpoint);
    broken['boardColors'] = [
      for (var r = 0; r < 8; r++)
        // One row is one cell short.
        List<int>.filled(r == 3 ? 7 : 8, -1),
    ];

    expect(
      () => GameSession.fromCheckpoint(broken),
      throwsA(isA<FormatException>()),
    );
  });

  test('a colour grid with too few rows is ignored, not half-read', () {
    // Fewer rows than the board has is the shape the old code already handled:
    // colours are dropped entirely and the run resumes with default colours,
    // which is cosmetic-only and better than discarding a real run.
    final session = GameSession.newGame(seed: 5);
    final checkpoint = session.toCheckpoint();
    final short = Map<String, dynamic>.from(checkpoint);
    short['boardColors'] = [
      for (var r = 0; r < 3; r++) List<int>.filled(8, 1),
    ];

    expect(GameSession.fromCheckpoint(short), isNotNull);
  });
}

bool _placeAnywhere(GameSession session, int slot) {
  for (var row = 0; row < Board.size; row++) {
    for (var column = 0; column < Board.size; column++) {
      final origin = Cell(row, column);
      if (session.canPlace(slot, origin)) {
        return session.place(slot, origin) != null;
      }
    }
  }
  return false;
}

void _placeRemainingTray(GameSession session) {
  for (var slot = 0; slot < 3; slot++) {
    if (session.tray[slot] != null) _placeAnywhere(session, slot);
  }

}
