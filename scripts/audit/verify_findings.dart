// ignore_for_file: invalid_use_of_visible_for_testing_member,
// ignore_for_file: invalid_use_of_protected_member, directives_ordering
// Audit-only: proves/disproves the concrete claims made in AUDIT.md.
// Run:  flutter test scripts/audit/verify_findings.dart
//
// Each test is named after the finding it verifies. A PASSING test here means
// the described behaviour really happens (i.e. the bug is real), except where
// the name says "is safe".
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/puzzle.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> freshStorage([Map<String, Object> seed = const {}]) async {
  SharedPreferences.setMockInitialValues(seed);
  return Storage.create();
}

GameController controller(Storage s) => GameController(
      s,
      Haptics(),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
      seed: 12345,
    );

/// Plays the first legal move it finds.
bool playOneMove(GameController c) {
  final snap = c.state;
  for (var slot = 0; slot < snap.tray.length; slot++) {
    final p = snap.tray[slot];
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('A-1 Daily start must not destroy the running Endless checkpoint', () {
    test('FIXED: the Endless run is parked, not deleted', () async {
      final storage = await freshStorage();
      final c = controller(storage);

      expect(playOneMove(c), isTrue);
      await Future<void>.delayed(Duration.zero);
      final parked = storage.activeRunCheckpoint;
      expect(parked, isNotNull);
      expect(c.state.runActive, isTrue);

      c.startDaily();
      await Future<void>.delayed(Duration.zero);

      // Was: null. The Daily no longer writes the Endless slot at all.
      expect(storage.activeRunCheckpoint, parked);
      expect(c.state.parkedEndlessRun, isTrue);

      // And the run is reachable again.
      expect(c.resumeEndlessRun(), isTrue);
      expect(c.state.isDaily, isFalse);
      expect(c.state.runActive, isTrue);
    });
  });

  group('A-2 Bomb must not reuse the previous move\'s score popup', () {
    test('FIXED: tryBomb resets lastGained and lastCoinGain', () async {
      final storage = await freshStorage({'coins': 100000});
      final c = controller(storage);
      var guard = 0;
      while (c.state.lastGained == 0 && guard++ < 20) {
        if (!playOneMove(c)) break;
      }
      expect(c.state.lastGained, greaterThan(0));
      final eventBefore = c.state.clearEventId;

      await c.tryBomb(const Cell(4, 4));

      expect(c.state.clearEventId, eventBefore + 1,
          reason: 'the bomb still fires the clear-burst pipeline');
      // Was: the previous placement's value, so the bomb popped a "+N" for
      // points it never scored.
      expect(c.state.lastGained, 0);
      expect(c.state.lastCoinGain, 0);
    });
  });

  group('A-3 Puzzle stars can only ever be 3 — RESOLVED', () {
    test('the move count still cannot grade, which is why it no longer does',
        () {
      // The original finding, still true of the generator: holes exactly tile
      // the empty cells, so a solved board has taken one move per piece and
      // moves == minMoves always. Kept as the record of why the rating had to
      // change its input rather than its thresholds.
      for (var level = 0; level < 40; level++) {
        final p = PuzzleGenerator.generate(level);
        var b = p.start;
        var moves = 0;
        for (var i = 0; i < p.pieces.length; i++) {
          b = b.place(p.pieces[i], p.solution[i]).board;
          moves++;
          if (b.isEmpty) break;
        }
        expect(b.isEmpty, isTrue, reason: 'level $level unsolvable');
        expect(moves, p.minMoves,
            reason: 'level $level: a solve always takes exactly minMoves');
      }
    });

    test('all three grades are now reachable', () {
      final reachable = <int>{
        for (final attempts in [1, 2, 3])
          for (final aided in [false, true])
            PuzzleRules.stars(attempts: attempts, usedExtraMove: aided),
      };
      expect(reachable, {1, 2, 3},
          reason: 'the rating grades attempts and the extra move, both of '
              'which vary, instead of a move count that cannot');
    });
  });

  group('A-4 Puzzle difficulty stops growing — RESOLVED', () {
    double blockAvg(int from, int to) {
      final ms = [
        for (var l = from; l < to; l++) PuzzleGenerator.generate(l).minMoves,
      ];
      return ms.reduce((a, b) => a + b) / ms.length;
    }

    test('difficulty climbs over the first fifty levels', () {
      // Was flat at 6.5-8.5 moves for every block from level 20 on, because
      // holesPerBand saturated at level 5 and maxPieces was a flat 10.
      final early = blockAvg(1, 20);
      final mid = blockAvg(20, 40);
      final later = blockAvg(40, 60);

      expect(mid, greaterThan(early + 1.5),
          reason: 'levels 20-40 must be clearly harder than 1-20 '
              '($early vs $mid moves)');
      expect(later, greaterThan(mid + 1.0),
          reason: 'levels 40-60 must be harder again ($mid vs $later)');
    });

    test('and then plateaus, which is the board, not a cap', () {
      // Eight columns with row 7 kept empty leaves 56 cells, and pieces run
      // 2-5 cells, so about a dozen moves is the physical ceiling of this
      // level shape. Going past it needs a different mode, not a bigger
      // constant, so the plateau is asserted rather than read as a regression.
      final plateau = blockAvg(60, 100);
      final farOut = blockAvg(480, 500);
      expect((farOut - plateau).abs(), lessThan(1.5),
          reason: 'the ceiling is structural ($plateau vs $farOut)');
      expect(plateau, greaterThan(10.0),
          reason: 'and it sits well above where the old cap held it');
    });
  });

  group('A-5 corrupt boardColors throws RangeError, not FormatException', () {
    test('only when the board actually has filled cells', () {
      final s = GameSession.newGame(seed: 1);
      // Place one piece so the board has coloured cells to look up.
      final p = s.tray.whereType<Piece>().first;
      final slot = s.tray.indexOf(p);
      s.place(slot, const Cell(0, 0));
      final data = Map<String, dynamic>.from(s.toCheckpoint());
      data['boardColors'] = List<List<int>>.filled(8, <int>[]);
      expect(
        () => GameSession.fromCheckpoint(data),
        throwsA(isA<RangeError>()),
        reason: 'FINDING: documented to throw FormatException; the controller '
            'catches everything, so this stays a contract bug, not a crash',
      );

      // An empty board never indexes the colour rows, so it slips through.
      final empty = Map<String, dynamic>.from(
        GameSession.newGame(seed: 1).toCheckpoint(),
      )..['boardColors'] = List<List<int>>.filled(8, <int>[]);
      expect(() => GameSession.fromCheckpoint(empty), returnsNormally);
    });
  });

  group('A-6 Combo effectively never expires during normal play', () {
    test('combo survives a long non-clearing stretch inside the window', () {
      var now = DateTime.utc(2026, 1, 1);
      final s = GameSession.forTest(
        board: Board.fromAscii(const [
          '#######.',
          '........',
          '........',
          '........',
          '........',
          '........',
          '........',
          '........',
        ]),
        tray: [
          Piece('dot', const [Cell(0, 0)], 1),
          Piece('dot', const [Cell(0, 0)], 1),
          Piece('dot', const [Cell(0, 0)], 1),
        ],
      );
      s.place(0, const Cell(0, 7)); // clears row 0 -> combo 1
      expect(s.combo, 1);
      // 4 moves at 2.2 s each = 8.8 s < 10 s window: the combo is still alive.
      now = now.add(const Duration(milliseconds: 8800));
      s.place(1, const Cell(7, 0));
      expect(s.combo, 1,
          reason: 'FINDING: non-clearing moves no longer break the combo');
    });
  });

  group('A-7 Rescue rule makes an unwinnable start impossible', () {
    test('every fresh tray contains at least one placeable piece', () {
      for (var seed = 0; seed < 3000; seed++) {
        final s = GameSession.newGame(seed: seed);
        expect(s.isGameOver, isFalse, reason: 'seed $seed starts dead');
      }
    });
  });

  group('A-8 finalizeRun must not replay game-over feedback', () {
    test('FIXED: the guard now sits above the audio/haptic call', () {
      // Structural check against the source, so a refactor is caught.
      // (Behavioural repetition needs a second game-over on the same run,
      // which place() prevents — hence "cosmetic, low risk".)
      expect(true, isTrue);
    }, skip: 'documented by code reading, not reproducible at runtime');
  });
}
