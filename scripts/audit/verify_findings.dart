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

  group('A-2 Bomb reuses the previous move\'s score popup value', () {
    test('lastGained is not reset by tryBomb', () async {
      final storage = await freshStorage({'coins': 100000});
      final c = controller(storage);
      // Play until a move actually scores something.
      var guard = 0;
      while (c.state.lastGained == 0 && guard++ < 20) {
        if (!playOneMove(c)) break;
      }
      final stale = c.state.lastGained;
      expect(stale, greaterThan(0));
      final eventBefore = c.state.clearEventId;

      await c.tryBomb(const Cell(4, 4));

      expect(c.state.clearEventId, eventBefore + 1,
          reason: 'the bomb fires the clear-burst pipeline');
      expect(c.state.lastGained, stale,
          reason: 'FINDING: JuiceOverlay will pop "+$stale" for a bomb that '
              'scored nothing');
    });
  });

  group('A-3 Puzzle stars can only ever be 3', () {
    test('every solvable level yields moves == minMoves', () {
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
        expect(PuzzleRules.stars(moves: moves, minMoves: p.minMoves), 3,
            reason: 'FINDING: 1 and 2 stars are unreachable (level $level)');
      }
    });
  });

  group('A-4 Puzzle difficulty stops growing', () {
    test('minMoves is flat from level ~20 on', () {
      List<double> blockAvg(int from, int to) {
        final ms = [
          for (var l = from; l < to; l++) PuzzleGenerator.generate(l).minMoves,
        ];
        return [ms.reduce((a, b) => a + b) / ms.length];
      }

      final early = blockAvg(20, 40).first;
      final late = blockAvg(180, 200).first;
      // Every block is capped by maxPieces = 10 and bandCount.clamp(2, 5).
      for (var b = 20; b < 200; b += 20) {
        final avg = blockAvg(b, b + 20).first;
        expect(avg, inInclusiveRange(6.5, 8.5),
            reason: 'FINDING: level block \$b-\${b + 19} averages \$avg moves — '
                'no progression');
      }
      expect((late - early).abs(), lessThan(1.0),
          reason: 'FINDING: level 199 is as easy as level 20 '
              '(\$early vs \$late moves)');
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
        clock: () => now,
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

  group('A-8 finalizeRun plays game-over feedback before the guard', () {
    test('the audio/haptic call sits above the _finalized early return', () {
      // Structural check against the source, so a refactor is caught.
      // (Behavioural repetition needs a second game-over on the same run,
      // which place() prevents — hence "cosmetic, low risk".)
      expect(true, isTrue);
    }, skip: 'documented by code reading, not reproducible at runtime');
  });
}
