// The generator's help for the opening of a run (MASTERPLAN.md §4,
// "Fairness-Tuning"; measured in BALANCE.md, Nachtrag 5).
//
// The classic rule — placeable pieces weigh 1,5× for the first ten moves — did
// nothing where it was meant to work: on the nearly empty board of an opening
// every piece is placeable, so every weight was raised alike. The assist looks
// at what a piece can do on this board instead: complete a line, complete
// two, or not fit at all.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/generator.dart';
import 'package:gridpop/game/piece.dart';

/// Rows 6 and 7 each miss their last three cells: a horizontal line of three
/// completes one of them, the 2x3 rectangle completes both.
final Board _twoOpenRows = Board.fromAscii([
  '........',
  '........',
  '........',
  '........',
  '........',
  '........',
  '#####...',
  '#####...',
]);

/// A crowded board: single holes only, so nothing bigger than a dot fits.
final Board _onlyDotsFit = Board.fromAscii([
  '#.######',
  '########',
  '###.####',
  '########',
  '#####.##',
  '########',
  '##.#####',
  '########',
]);

/// Tight, but not hopeless: the dot and both dominoes still fit.
final Board _tightBoard = Board.fromAscii([
  '#..#####',
  '########',
  '###.####',
  '###.####',
  '########',
  '#####..#',
  '########',
  '##.#####',
]);

const _full = SpawnAssist(fullMoves: 1000, fadeMoves: 0);

int _countWhere(
  Board board,
  SpawnAssist assist,
  bool Function(Piece piece) test, {
  int seeds = 300,
}) {
  var n = 0;
  for (var seed = 0; seed < seeds; seed++) {
    final gen = PieceGenerator(seed: seed, assist: assist);
    n += gen.nextTray(board, 50).where(test).length;
  }
  return n;
}

/// Lines the best placement of [piece] on [board] would clear.
int _bestClear(Board board, Piece piece) {
  var best = 0;
  for (var r = 0; r <= Board.size - piece.height; r++) {
    for (var c = 0; c <= Board.size - piece.width; c++) {
      if (!board.canPlace(piece, Cell(r, c))) continue;
      final lines = board.place(piece, Cell(r, c)).clearedLines;
      if (lines > best) best = lines;
    }
  }
  return best;
}

void main() {
  group('strength over a run', () {
    test('is full, then fades in a straight line, then is gone', () {
      const assist = SpawnAssist(fullMoves: 10, fadeMoves: 20);
      expect(assist.strengthAt(0), 1.0);
      expect(assist.strengthAt(9), 1.0);
      expect(assist.strengthAt(10), 1.0);
      expect(assist.strengthAt(20), closeTo(0.5, 1e-9));
      expect(assist.strengthAt(30), 0.0);
      expect(assist.strengthAt(500), 0.0);
    });

    test('without a fade it simply ends', () {
      const assist = SpawnAssist(fullMoves: 5, fadeMoves: 0);
      expect(assist.strengthAt(4), 1.0);
      expect(assist.strengthAt(5), 0.0);
    });

    test('none never helps', () {
      for (final move in [0, 1, 10, 1000]) {
        expect(SpawnAssist.none.strengthAt(move), 0.0);
      }
    });
  });

  group('without an assist nothing changes', () {
    test('the same seed deals the same trays as before', () {
      // Daily Challenge and every seeded test rely on the classic sequence.
      for (final board in [Board.empty(), _twoOpenRows, _onlyDotsFit]) {
        for (var seed = 0; seed < 40; seed++) {
          final classic = PieceGenerator(seed: seed);
          final none = PieceGenerator(seed: seed, assist: SpawnAssist.none);
          for (var move = 0; move < 30; move += 3) {
            expect(
              none.nextTray(board, move).map((p) => p.id).toList(),
              classic.nextTray(board, move).map((p) => p.id).toList(),
              reason: 'seed $seed, move $move',
            );
          }
        }
      }
    });

    test('a spent assist deals the classic trays again', () {
      const spent = SpawnAssist(fullMoves: 5, fadeMoves: 5);
      for (var seed = 0; seed < 40; seed++) {
        final classic = PieceGenerator(seed: seed);
        final assisted = PieceGenerator(seed: seed, assist: spent);
        expect(
          assisted.nextTray(_twoOpenRows, 60).map((p) => p.id).toList(),
          classic.nextTray(_twoOpenRows, 60).map((p) => p.id).toList(),
        );
      }
    });
  });

  group('with an assist', () {
    test('pieces that complete a line come up far more often', () {
      bool clears(Piece p) => _bestClear(_twoOpenRows, p) >= 1;
      final classic = _countWhere(_twoOpenRows, SpawnAssist.none, clears);
      final assisted = _countWhere(_twoOpenRows, _full, clears);
      expect(classic, greaterThan(0));
      expect(assisted, greaterThan(classic * 2));
    });

    test('pieces that complete two lines at once are favoured again', () {
      bool doubles(Piece p) => _bestClear(_twoOpenRows, p) >= 2;
      final classic = _countWhere(_twoOpenRows, SpawnAssist.none, doubles);
      final assisted = _countWhere(_twoOpenRows, _full, doubles);
      expect(classic, greaterThan(0));
      expect(assisted, greaterThan(classic * 3));
    });

    test('pieces that fit nowhere become rare', () {
      bool dead(Piece p) => !_tightBoard.hasAnyPlacement(p);
      final classic = _countWhere(_tightBoard, SpawnAssist.none, dead);
      final assisted = _countWhere(_tightBoard, _full, dead);
      // Classic: only the dot and the two dominoes fit, 16 of 121 weight
      // points, so most of what is dealt cannot be placed at all.
      expect(classic, greaterThan(500));
      expect(assisted, lessThan(classic ~/ 3));
    });

    test('half strength lies between none and full', () {
      bool clears(Piece p) => _bestClear(_twoOpenRows, p) >= 1;
      const half = SpawnAssist(fullMoves: 0, fadeMoves: 100);
      final none = _countWhere(_twoOpenRows, SpawnAssist.none, clears);
      // strengthAt(50) == 0.5
      final mid = _countWhere(_twoOpenRows, half, clears);
      final full = _countWhere(_twoOpenRows, _full, clears);
      expect(mid, greaterThan(none));
      expect(mid, lessThan(full));
    });

    test('stays deterministic', () {
      for (var seed = 0; seed < 20; seed++) {
        final a = PieceGenerator(seed: seed, assist: _full);
        final b = PieceGenerator(seed: seed, assist: _full);
        for (var i = 0; i < 10; i++) {
          expect(
            a.nextTray(_twoOpenRows, i).map((p) => p.id).toList(),
            b.nextTray(_twoOpenRows, i).map((p) => p.id).toList(),
          );
        }
      }
    });

    test('still rescues a tray in which nothing fits', () {
      for (var seed = 0; seed < 50; seed++) {
        final gen = PieceGenerator(seed: seed, assist: _full);
        expect(
          gen.nextTray(_onlyDotsFit, 3).any(_onlyDotsFit.hasAnyPlacement),
          isTrue,
          reason: 'seed $seed',
        );
      }
    });

    test('on an empty board every piece keeps its plain share', () {
      // Nothing completes a line and nothing is dead, so no weight moves:
      // the opening tray of an assisted run is the classic one.
      for (var seed = 0; seed < 40; seed++) {
        final classic = PieceGenerator(seed: seed, earlyPhaseMoves: 0);
        final assisted = PieceGenerator(seed: seed, assist: _full);
        expect(
          assisted.nextTray(Board.empty(), 0).map((p) => p.id).toList(),
          classic.nextTray(Board.empty(), 0).map((p) => p.id).toList(),
        );
      }
    });
  });

  group('in a session', () {
    test('a run started with an assist resumes with the same next tray', () {
      // Restoring replays the generator by tray count, which only works while
      // a pick costs exactly one random number whatever the weights are.
      const assist = SpawnAssist(fullMoves: 30, fadeMoves: 30);
      for (var seed = 1; seed <= 12; seed++) {
        final original = GameSession.newGame(seed: seed, assist: assist);
        for (var i = 0; i < 7 && !original.isGameOver; i++) {
          _placeFirstFit(original);
        }
        if (original.isGameOver) continue;
        final restored = GameSession.fromCheckpoint(
          Map<String, dynamic>.from(original.toCheckpoint()),
        );
        expect(restored.assist.fullMoves, 30);
        expect(restored.assist.fadeMoves, 30);
        for (var i = 0; i < 9; i++) {
          if (original.isGameOver) break;
          _placeFirstFit(original);
          _placeFirstFit(restored);
          expect(
            restored.tray.map((p) => p?.id).toList(),
            original.tray.map((p) => p?.id).toList(),
            reason: 'seed $seed, step $i',
          );
        }
      }
    });

    test('a checkpoint written before the assist existed restores without', () {
      final checkpoint = Map<String, dynamic>.from(
        GameSession.newGame(seed: 5).toCheckpoint(),
      )..remove('assist');
      final restored = GameSession.fromCheckpoint(checkpoint);
      expect(restored.assist.isNone, isTrue);
    });

    test('a corrupt assist entry is rejected, not half-read', () {
      final checkpoint = Map<String, dynamic>.from(
        GameSession.newGame(
          seed: 5,
          assist: const SpawnAssist(fullMoves: 3, fadeMoves: 3),
        ).toCheckpoint(),
      );
      checkpoint['assist'] = {'full': -4, 'fade': 'x'};
      expect(
        () => GameSession.fromCheckpoint(checkpoint),
        throwsFormatException,
      );
    });

    test('the default session has no assist', () {
      expect(GameSession.newGame(seed: 1).assist.isNone, isTrue);
    });
  });
}

void _placeFirstFit(GameSession s) {
  for (var slot = 0; slot < s.tray.length; slot++) {
    final piece = s.tray[slot];
    if (piece == null) continue;
    for (var r = 0; r <= Board.size - piece.height; r++) {
      for (var c = 0; c <= Board.size - piece.width; c++) {
        if (s.canPlace(slot, Cell(r, c))) {
          s.place(slot, Cell(r, c));
          return;
        }
      }
    }
  }
}
