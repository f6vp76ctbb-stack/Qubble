import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

GameController _controller(Storage s) => GameController(
      s,
      Haptics(),
      SilentAudio(),
      FakeAdService(),
      NoopAnalytics(),
      seed: 4242,
    );

/// Plays the first legal move available.
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('resetProgress clears the snapshot the UI renders', () async {
    SharedPreferences.setMockInitialValues({
      'highscore': 12840,
      'coins': 900,
      'xp': 90,
      'playerLevel': 5,
      'streak': 4,
      'onboardingDone': true,
      'supporter': true,
      'playerName': 'Puzzlerin',
      'lifetimeStats': '{"games": 21, "totalScore": 40000}',
      'missionProgress': '{"place_100": 100}',
    });
    final storage = await Storage.create();
    final c = _controller(storage);

    expect(_playOneMove(c), isTrue);
    expect(c.state.runActive, isTrue);
    expect(c.state.highscore, 12840);

    await c.resetProgress();

    expect(c.state.highscore, 0);
    expect(c.state.coins, Storage.startingCoins);
    expect(c.state.playerLevel, 1);
    expect(c.state.xpIntoLevel, 0);
    expect(c.state.streak, 0);
    expect(c.state.score, 0);
    expect(c.state.runActive, isFalse,
        reason: 'the in-flight run must not survive the reset');
    expect(storage.activeRunCheckpoint, isNull);
    expect(c.state.board.isEmpty, isTrue);
    expect(storage.lifetimeStats.games, 0);
    expect(storage.missionProgress, isEmpty);
    expect(c.missionViews.every((v) => v.progress == 0), isTrue,
        reason: 'the in-memory mission engine must be cleared too');

    // Onboarding runs again, so the next tester session starts like a first one.
    expect(c.state.onboardingHintStep, isNotNull);

    // What was paid for stays.
    expect(c.state.supporter, isTrue);
    expect(c.state.playerName, 'Puzzlerin');
  });

  test('a run started after the reset records fresh lifetime stats', () async {
    SharedPreferences.setMockInitialValues({
      'lifetimeStats': '{"games": 21}',
    });
    final storage = await Storage.create();
    final c = _controller(storage);
    await c.resetProgress();

    await storage.setLifetimeStats(
      storage.lifetimeStats.merge(
        const GameStats(
          score: 100,
          piecesPlaced: 5,
          linesCleared: 1,
          maxCombo: 1,
        ),
      ),
    );
    expect(storage.lifetimeStats.games, 1);
  });
}
