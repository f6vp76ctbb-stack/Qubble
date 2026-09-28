import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/ui/state/game_controller.dart';

/// Five seconds per move, so the score does not depend on machine speed.
class SteppingClock {
  DateTime _t = DateTime.utc(2026, 1, 1);

  DateTime call() {
    _t = _t.add(const Duration(seconds: 5));
    return _t;
  }
}

/// Places the first tray piece that fits anywhere; false if none does.
bool placeSomething(GameController c) {
  for (var slot = 0; slot < c.state.tray.length; slot++) {
    final p = c.state.tray[slot];
    if (p == null) continue;
    for (var r = 0; r <= Board.size - p.height; r++) {
      for (var col = 0; col <= Board.size - p.width; col++) {
        if (c.canPlace(slot, Cell(r, col))) {
          c.place(slot, Cell(r, col));
          return true;
        }
      }
    }
  }
  return false;
}

/// Plays greedily, rotating when nothing fits, until the run is over.
void playToGameOver(GameController c) {
  var guard = 0;
  while (!c.state.gameOver && guard++ < 3000) {
    if (placeSomething(c)) continue;
    var rotated = false;
    for (var slot = 0; slot < c.state.tray.length && !rotated; slot++) {
      if (c.state.tray[slot] == null) continue;
      for (var i = 0; i < 3; i++) {
        if (!c.rotateTray(slot)) break;
        if (placeSomething(c)) {
          rotated = true;
          break;
        }
      }
    }
    if (!rotated) break;
  }
}
