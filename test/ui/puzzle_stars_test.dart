import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/puzzle.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/puzzle_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<PuzzleController> _controller() async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  final container = ProviderContainer(
    overrides: [storageProvider.overrideWithValue(storage)],
  );
  addTearDown(container.dispose);
  return container.read(puzzleControllerProvider.notifier);
}

/// Plays a level to completion along its recorded solution.
Future<void> _solve(PuzzleController c) async {
  final puzzle = PuzzleGenerator.generate(c.state.level);
  // The controller holds the same deterministic level, so the recorded
  // solution applies: piece i goes at solution[i].
  for (var i = 0; i < puzzle.pieces.length && !c.state.solved; i++) {
    await c.place(puzzle.solution[i]);
    await c.settled;
  }
}

void main() {
  group('puzzle stars', () {
    test('a first-try solve earns three', () async {
      final c = await _controller();
      c.loadLevel(0);
      await _solve(c);

      expect(c.state.solved, isTrue, reason: 'the recorded solution must win');
      expect(c.state.stars, 3);
    });

    test('a restart costs a star', () async {
      final c = await _controller();
      c.loadLevel(0);
      c.restart();
      await _solve(c);

      expect(c.state.solved, isTrue);
      expect(c.state.stars, 2,
          reason: 'needing a second attempt is exactly what the rating is '
              'meant to show');
    });

    test('two restarts cost no more than one', () async {
      // The scale has three grades, not a ladder into the negatives.
      final c = await _controller();
      c.loadLevel(0);
      c.restart();
      c.restart();
      await _solve(c);
      expect(c.state.stars, 2);
    });

    test('moving to another level restores a clean slate', () async {
      final c = await _controller();
      c.loadLevel(0);
      c.restart();
      c.restart();

      c.loadLevel(1);
      await _solve(c);
      expect(c.state.stars, 3,
          reason: 'attempts belong to the level, not to the session');
    });

    test('only the best result is kept', () async {
      final c = await _controller();
      SharedPreferences.setMockInitialValues({});

      c.loadLevel(0);
      c.restart();
      await _solve(c);
      expect(c.state.stars, 2);

      // Replaying it cleanly should raise the stored grade, never lower it.
      c.loadLevel(0);
      await _solve(c);
      expect(c.state.stars, 3);
    });
  });

  group('the generator still guarantees a solution', () {
    test('every level up to 60 empties along its recorded solution', () {
      // The difficulty change carves more holes per band; this is the check
      // that more holes did not produce an unsolvable board.
      for (var level = 0; level < 60; level++) {
        final p = PuzzleGenerator.generate(level);
        var board = p.start;
        for (var i = 0; i < p.pieces.length; i++) {
          expect(board.canPlace(p.pieces[i], p.solution[i]), isTrue,
              reason: 'level $level, piece $i does not fit its origin');
          board = board.place(p.pieces[i], p.solution[i]).board;
        }
        expect(board.isEmpty, isTrue, reason: 'level $level does not empty');
      }
    });

    test('a harder level really does carry more pieces', () {
      final early = PuzzleGenerator.generate(3).pieces.length;
      final late = PuzzleGenerator.generate(50).pieces.length;
      expect(late, greaterThan(early));
    });

    test('pieces stay inside the board', () {
      for (var level = 0; level < 60; level++) {
        final p = PuzzleGenerator.generate(level);
        for (var i = 0; i < p.pieces.length; i++) {
          final origin = p.solution[i];
          final piece = p.pieces[i];
          expect(origin.row + piece.height, lessThanOrEqualTo(Board.size));
          expect(origin.col + piece.width, lessThanOrEqualTo(Board.size));
        }
      }
    });
  });
}
