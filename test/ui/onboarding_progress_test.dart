// The opening lesson advanced on placement count, so three pieces put down
// anywhere ended it. A player could read "fill a whole row or column" without
// ever having cleared one, and then be told lines dissolve while nothing had.
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

Future<GameController> _fresh({int seed = 99}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  return GameController(
    storage,
    Haptics(enabled: false),
    SilentAudio(),
    FakeAdService(),
    NoopAnalytics(),
    seed: seed,
  );
}

/// Plays the first legal move in a corner-packing order, which fills lines.
bool _packOneMove(GameController c) {
  for (var r = 0; r < Board.size; r++) {
    for (var col = 0; col < Board.size; col++) {
      for (var slot = 0; slot < c.state.tray.length; slot++) {
        if (c.state.tray[slot] == null) continue;
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

  test('the first hint asks for a placement', () async {
    final c = await _fresh();
    expect(c.state.onboardingHintStep, 0);
  });

  test('the second hint arrives after the first placement', () async {
    final c = await _fresh();
    expect(_packOneMove(c), isTrue);
    expect(c.state.onboardingHintStep, 1);
  });

  test('the lesson is not over after three arbitrary placements', () async {
    // The old rule ended onboarding here regardless of what had happened.
    final c = await _fresh();
    for (var i = 0; i < 3; i++) {
      expect(_packOneMove(c), isTrue);
    }
    // Still teaching, unless a line genuinely cleared in those three moves.
    if (c.state.lastClearedLineCount == 0) {
      expect(c.state.onboardingHintStep, isNotNull,
          reason: 'the lesson ended before the player cleared anything');
    }
  });

  test('the lesson completes once lines actually clear', () async {
    final c = await _fresh();
    var guard = 0;
    while (c.state.onboardingHintStep != null && guard++ < 200) {
      if (!_packOneMove(c)) break;
    }
    expect(c.state.onboardingHintStep, isNull,
        reason: 'packing pieces into a corner clears lines, which should '
            'finish the lesson');
  });

  test('the daily challenge never shows the lesson', () async {
    final c = await _fresh();
    c.startDaily();
    expect(c.state.onboardingHintStep, isNull);
  });
}
