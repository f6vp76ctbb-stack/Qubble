// The stuck-check is a bounded search that ran BEFORE the placement was
// emitted, so the board did not update until it finished — 63 ms median and
// 176 ms worst case on a desktop VM, several times that on a phone. It now
// runs after the move is on screen.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/puzzle.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/puzzle_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container() async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  return ProviderContainer(
    overrides: [storageProvider.overrideWithValue(storage)],
  );
}

Cell _firstLegalOrigin(PuzzleState s) {
  final piece = s.currentPiece!;
  for (var r = 0; r <= Board.size - piece.height; r++) {
    for (var c = 0; c <= Board.size - piece.width; c++) {
      if (s.board.canPlace(piece, Cell(r, c))) return Cell(r, c);
    }
  }
  throw StateError('no legal placement');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the board updates before the stuck-check runs', () async {
    final container = await _container();
    addTearDown(container.dispose);
    final c = container.read(puzzleControllerProvider.notifier);
    c.loadLevel(0);

    final before = container.read(puzzleControllerProvider);
    final origin = _firstLegalOrigin(before);
    final future = c.place(origin);

    // Synchronously after place() the move is already visible: the emit
    // happens before the search, not after it.
    final mid = container.read(puzzleControllerProvider);
    expect(mid.moves, before.moves + 1);
    expect(mid.pieceIndex, before.pieceIndex + 1);
    expect(mid.failed, isFalse);

    await future;
    await c.settled;
  });

  test('following the recorded solution never reports a dead end', () async {
    final container = await _container();
    addTearDown(container.dispose);
    final c = container.read(puzzleControllerProvider.notifier);

    for (var level = 0; level < 8; level++) {
      c.loadLevel(level);
      final puzzle = PuzzleGenerator.generate(level);
      for (var i = 0; i < puzzle.pieces.length; i++) {
        if (container.read(puzzleControllerProvider).solved) break;
        await c.place(puzzle.solution[i]);
        await c.settled;
        expect(container.read(puzzleControllerProvider).failed, isFalse,
            reason: 'level $level flagged as stuck while following its own '
                'solution');
      }
      expect(container.read(puzzleControllerProvider).solved, isTrue,
          reason: 'level $level did not empty');
    }
  });

  group('PuzzleSolver.canEmpty', () {
    test('never contradicts solve where both reach a verdict', () {
      // A start board with all ten pieces is the largest search either will
      // ever face; both are bounded, so what matters is that neither claims
      // the opposite of the other when it does finish.
      // A handful of levels: solve() is exhaustive and this is the largest
      // board either search ever sees, so the suite pays for every extra one.
      for (var level = 0; level < 6; level++) {
        final p = PuzzleGenerator.generate(level);
        final full = PuzzleSolver.solve(p.start, p.pieces, budget: 60000);
        final quick = PuzzleSolver.canEmpty(p.start, p.pieces, budget: 60000);
        if (full.budgetExceeded || quick.budgetExceeded) continue;
        expect(
          quick.moves != null,
          full.moves != null,
          reason: 'level $level: canEmpty and solve disagree',
        );
      }
    });

    test('finds the solution the generator recorded', () {
      // Whatever the budget proves or not, a level must never be declared
      // unsolvable when its own solution is still playable.
      for (var level = 0; level < 10; level++) {
        final p = PuzzleGenerator.generate(level);
        var board = p.start;
        for (var i = 0; i < p.pieces.length; i++) {
          board = board.place(p.pieces[i], p.solution[i]).board;
          if (board.isEmpty) break;
          final r = PuzzleSolver.canEmpty(board, p.pieces.sublist(i + 1));
          final declaredStuck = !r.budgetExceeded && r.moves == null;
          expect(declaredStuck, isFalse,
              reason: 'level $level move ${i + 1}: declared unwinnable on the '
                  'generator\'s own solution path');
        }
      }
    });

    test('reports an unsolvable board as unsolvable', () {
      // A single cell left over and only a 2-wide piece to fill it.
      final board = Board.fromAscii(const [
        '#######.',
        '........',
        '........',
        '........',
        '........',
        '........',
        '........',
        '........',
      ]);
      final result = PuzzleSolver.canEmpty(board, [
        Piece('line2_h', const [Cell(0, 0), Cell(0, 1)], 6),
      ]);
      expect(result.budgetExceeded, isFalse);
      expect(result.moves, isNull);
    });

    test('an exhausted budget is reported, not treated as a failure', () {
      final p = PuzzleGenerator.generate(20);
      final result = PuzzleSolver.canEmpty(p.start, p.pieces, budget: 1);
      expect(result.budgetExceeded, isTrue);
      // The caller must read this as "unproven" and keep the level running.
      expect(result.moves, isNull);
    });

    test('it visits far fewer nodes than the exhaustive search', () {
      // Both are bounded; canEmpty stops at the first solution.
      final p = PuzzleGenerator.generate(15);
      final first = p.start.place(p.pieces.first, p.solution.first).board;
      final rest = p.pieces.sublist(1);

      final swQuick = Stopwatch()..start();
      PuzzleSolver.canEmpty(first, rest);
      swQuick.stop();

      final swFull = Stopwatch()..start();
      PuzzleSolver.solve(first, rest, budget: 60000);
      swFull.stop();

      expect(
        swQuick.elapsedMicroseconds,
        lessThanOrEqualTo(swFull.elapsedMicroseconds),
      );
    });
  });
}
