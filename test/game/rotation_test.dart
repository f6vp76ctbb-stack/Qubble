import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';

void main() {
  group('Piece.rotatedCw', () {
    test('rotates a horizontal line into a vertical one', () {
      final h = Piece('line3_h', const [Cell(0, 0), Cell(0, 1), Cell(0, 2)], 1);
      final v = h.rotatedCw();
      expect(v.cells, const [Cell(0, 0), Cell(1, 0), Cell(2, 0)]);
      expect(v.width, 1);
      expect(v.height, 3);
      expect(v.id, 'line3_h', reason: 'rotation keeps the catalog id');
    });

    test('rotates an L shape correctly', () {
      // .X      XX      X.
      // .X  ->  ..  ->  X.  (two cw rotations = 180°)
      // XX      ..      XX ... verify one step:
      final l = Piece('l', const [Cell(0, 1), Cell(1, 1), Cell(2, 0), Cell(2, 1)], 1);
      final r = l.rotatedCw();
      // 90° cw: (r,c) -> (c, maxR - r); maxR = 2.
      expect(
        r.cells,
        const [Cell(0, 0), Cell(1, 0), Cell(1, 1), Cell(1, 2)],
      );
    });

    test('four rotations return to the original shape', () {
      final s = Piece('s_h', const [Cell(0, 1), Cell(0, 2), Cell(1, 0), Cell(1, 1)], 1);
      final back = s.rotatedCw().rotatedCw().rotatedCw().rotatedCw();
      expect(back.cells, s.cells);
    });

    test('a square is rotation-invariant', () {
      final sq = Piece('square2',
          const [Cell(0, 0), Cell(0, 1), Cell(1, 0), Cell(1, 1)], 1);
      expect(sq.rotatedCw().cells, sq.cells);
    });
  });

  group('GameSession rotation charges', () {
    // Owner, 15.11.2026: a charge pays for a PIECE, not for a quarter turn.
    // Once a piece has been turned, it turns as often as the player likes.
    test('the first turn of a piece costs one charge, further turns are '
        'free', () {
      final s = GameSession.newGame(seed: 7);
      expect(s.rotationCharges, GameSession.startRotationCharges);
      expect(s.rotationPaid(0), isFalse);
      expect(s.rotate(0), isTrue);
      expect(s.rotationCharges, GameSession.startRotationCharges - 1);
      expect(s.rotationPaid(0), isTrue);
      for (var i = 0; i < 7; i++) {
        expect(s.rotate(0), isTrue);
      }
      expect(s.rotationCharges, GameSession.startRotationCharges - 1,
          reason: 'turning the same piece again is free');
    });

    test('a paid piece keeps turning with no charges left; an unpaid one '
        'cannot turn', () {
      final s = GameSession.newGame(seed: 7);
      expect(GameSession.startRotationCharges, 2);
      expect(s.rotate(0), isTrue);
      expect(s.rotate(1), isTrue);
      expect(s.rotationCharges, 0);
      expect(s.canRotate(2), isFalse);
      expect(s.rotate(2), isFalse);
      expect(s.canRotate(0), isTrue);
      expect(s.canRotate(1), isTrue);
      for (var i = 0; i < 5; i++) {
        expect(s.rotate(0), isTrue);
        expect(s.rotate(1), isTrue);
      }
      expect(s.rotationCharges, 0);
    });

    test('free mode ignores charges', () {
      final free = GameSession.newGame(seed: 7, freeRotation: true);
      for (var slot = 0; slot < 3; slot++) {
        for (var i = 0; i < 10; i++) {
          expect(free.rotate(slot), isTrue);
        }
      }
      expect(free.rotationCharges, GameSession.startRotationCharges,
          reason: 'free rotation never consumes charges');
    });

    test('a new piece in a slot has to be paid for again', () {
      // Three single cells on an empty board: placing them clears nothing,
      // so no charge comes back and the refill is the only change.
      final dot = Piece('dot', const [Cell(0, 0)], 1);
      final s = GameSession.forTest(
        board: Board.empty(),
        tray: [dot, dot, dot],
        rotationCharges: 1,
      );
      expect(s.rotate(0), isTrue);
      expect(s.rotationCharges, 0);
      expect(s.place(0, const Cell(0, 0)), isNotNull);
      expect(s.rotationPaid(0), isFalse, reason: 'the slot is empty now');
      expect(s.place(1, const Cell(2, 2)), isNotNull);
      expect(s.place(2, const Cell(4, 4)), isNotNull);
      // The tray has refilled with three new pieces, none of them paid.
      expect(s.tray.whereType<Piece>(), hasLength(3));
      for (var slot = 0; slot < 3; slot++) {
        expect(s.rotationPaid(slot), isFalse);
        expect(s.canRotate(slot), isFalse, reason: 'no charge left');
      }
    });

    test('a rerolled tray is unpaid', () {
      final s = GameSession.newGame(seed: 7);
      s.rotate(0);
      expect(s.rotationPaid(0), isTrue);
      s.rerollTray();
      for (var slot = 0; slot < 3; slot++) {
        expect(s.rotationPaid(slot), isFalse);
      }
    });

    test('undo restores which pieces were paid for', () {
      final dot = Piece('dot', const [Cell(0, 0)], 1);
      final s = GameSession.forTest(
        board: Board.empty(),
        tray: [dot, dot, dot],
        rotationCharges: 2,
      );
      s.rotate(1); // paid before the move: stays paid after the undo
      s.place(0, const Cell(0, 0));
      s.rotate(2); // paid after the move: the undo takes it back
      expect(s.rotationCharges, 0);
      expect(s.undo(), isTrue);
      expect(s.rotationPaid(1), isTrue);
      expect(s.rotationPaid(2), isFalse);
      expect(s.rotationCharges, 1);
    });

    test('a clearing move refills one charge up to the cap', () {
      final s = GameSession.newGame(seed: 7);
      // Drain the charges first: one piece each.
      s.rotate(0);
      s.rotate(1);
      expect(s.rotationCharges, 0);

      // Play greedily (first legal spot each move) until a clear happens —
      // seeded, so this is deterministic and bounded.
      Cell? firstLegal(int slot) {
        final piece = s.tray[slot];
        if (piece == null) return null;
        for (var r = 0; r <= 8 - piece.height; r++) {
          for (var c = 0; c <= 8 - piece.width; c++) {
            if (s.canPlace(slot, Cell(r, c))) return Cell(r, c);
          }
        }
        return null;
      }

      var cleared = false;
      for (var move = 0; move < 200 && !cleared && !s.isGameOver; move++) {
        var placedAny = false;
        for (var slot = 0; slot < 3 && !cleared; slot++) {
          final cell = firstLegal(slot);
          if (cell == null) continue;
          final before = s.rotationCharges;
          s.place(slot, cell);
          placedAny = true;
          if (s.lastClearedLineCount > 0) {
            expect(s.rotationCharges, before + 1);
            cleared = true;
          }
        }
        if (!placedAny) break;
      }
      expect(cleared, isTrue, reason: 'the seeded run should clear a line');
    });

    test('undo restores the pre-move rotation charges', () {
      final s = GameSession.newGame(seed: 7);
      // Place one piece (creates the memento), then rotate — undo should
      // restore the tray AND the charge count captured before the move.
      final piece = s.tray[0]!;
      Cell? target;
      for (var r = 0; r <= 8 - piece.height && target == null; r++) {
        for (var c = 0; c <= 8 - piece.width && target == null; c++) {
          if (s.canPlace(0, Cell(r, c))) target = Cell(r, c);
        }
      }
      final chargesBeforeMove = s.rotationCharges;
      s.place(0, target!);
      s.undo();
      expect(s.rotationCharges, chargesBeforeMove);
    });
  });
}
