// Tapping the Daily Challenge card used to delete the Endless run in progress:
// the checkpoint slot is rewritten on every move, and a Daily move wrote null.
// The Daily now leaves that slot alone and the home screen offers the parked
// run back.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

GameController _controller(Storage s, {int seed = 777}) => GameController(
      s,
      Haptics(),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
      seed: seed,
    );

bool _playOneMove(GameController c) {
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

/// Lets the controller's serialized persistence queue drain.
Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<Storage> fresh() async {
    SharedPreferences.setMockInitialValues({});
    return Storage.create();
  }

  test('starting the Daily keeps the Endless checkpoint', () async {
    final storage = await fresh();
    final c = _controller(storage);

    expect(_playOneMove(c), isTrue);
    expect(_playOneMove(c), isTrue);
    await _settle();
    final parked = storage.activeRunCheckpoint;
    expect(parked, isNotNull);
    final endlessScore = c.state.score;
    expect(endlessScore, greaterThan(0));

    c.startDaily();
    await _settle();

    expect(storage.activeRunCheckpoint, isNotNull,
        reason: 'the Endless run must survive a Daily');
    expect(storage.activeRunCheckpoint, parked);
    expect(c.state.isDaily, isTrue);
    expect(c.state.parkedEndlessRun, isTrue);
    expect(c.state.score, 0, reason: 'the Daily starts fresh');
  });

  test('Daily moves never overwrite the parked Endless run', () async {
    final storage = await fresh();
    final c = _controller(storage);
    expect(_playOneMove(c), isTrue);
    await _settle();
    final parked = storage.activeRunCheckpoint;

    c.startDaily();
    for (var i = 0; i < 5; i++) {
      if (!_playOneMove(c)) break;
    }
    await _settle();

    expect(storage.activeRunCheckpoint, parked,
        reason: 'the slot belongs to Endless only');
  });

  test('resumeEndlessRun restores the parked run', () async {
    final storage = await fresh();
    final c = _controller(storage);
    expect(_playOneMove(c), isTrue);
    expect(_playOneMove(c), isTrue);
    await _settle();
    final endlessScore = c.state.score;
    final endlessBoard = c.state.board.toAscii().join();

    c.startDaily();
    await _settle();
    expect(c.state.parkedEndlessRun, isTrue);

    expect(c.resumeEndlessRun(), isTrue);

    expect(c.state.isDaily, isFalse);
    expect(c.state.score, endlessScore);
    expect(c.state.board.toAscii().join(), endlessBoard);
    expect(c.state.runActive, isTrue);
    expect(c.state.parkedEndlessRun, isFalse);
  });

  test('resumeEndlessRun is a no-op when nothing is parked', () async {
    final storage = await fresh();
    final c = _controller(storage);
    expect(c.resumeEndlessRun(), isFalse);

    c.startDaily();
    expect(c.state.parkedEndlessRun, isFalse,
        reason: 'no Endless run was in progress');
    expect(c.resumeEndlessRun(), isFalse);
  });

  test('an explicit new game does discard the parked run', () async {
    final storage = await fresh();
    final c = _controller(storage);
    expect(_playOneMove(c), isTrue);
    await _settle();
    c.startDaily();
    await _settle();
    expect(c.state.parkedEndlessRun, isTrue);

    // "Neue Runde starten" is the deliberate act, and its label says so.
    c.newGame();
    await _settle();

    expect(storage.activeRunCheckpoint, isNull);
    expect(c.state.parkedEndlessRun, isFalse);
    expect(c.state.score, 0);
  });

  test('a finished Endless run leaves no parked checkpoint behind', () async {
    final storage = await fresh();
    final c = _controller(storage);
    var guard = 0;
    while (!c.state.gameOver && guard++ < 400) {
      if (!_playOneMove(c)) break;
    }
    await _settle();
    if (!c.state.gameOver) return; // seed survived the guard; nothing to assert

    expect(storage.activeRunCheckpoint, isNull);
    c.startDaily();
    await _settle();
    expect(c.state.parkedEndlessRun, isFalse);
  });
}
