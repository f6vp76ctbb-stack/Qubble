// The fifth voluntary rewarded placement (audit/04-monetarisierung.md M-5b):
// doubling the daily reward.
//
// The daily reward is the strongest reason to come back, which makes it the
// moment a voluntary offer is worth most. It stays voluntary in the sense
// CLAUDE.md requires -- the reward is already in the player's balance before
// this is offered, so declining costs nothing.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

class _RefusingAds extends FakeAdService {
  @override
  Future<bool> showRewarded() async => false;
}

Future<(GameController, Storage, RecordingAnalytics)> _controller({
  Map<String, Object> prefs = const {},
  AdService? ads,
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final analytics = RecordingAnalytics();
  return (
    GameController(
      storage,
      Haptics(enabled: false),
      SilentAudio(),
      ads ?? FakeAdService(),
      analytics,
    ),
    storage,
    analytics,
  );
}

bool _placeSomething(GameController c) {
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

/// Drives the controller to a real game over.
///
/// Rotation matters: the session only declares game over once nothing fits
/// even after the rotations the player could still afford, so a loop that
/// never rotates stops early with gameOver still false -- and then the daily
/// never finalizes and never pays.
void _playToGameOver(GameController c) {
  var guard = 0;
  while (!c.state.gameOver && guard++ < 3000) {
    if (_placeSomething(c)) continue;
    var rotated = false;
    for (var slot = 0; slot < c.state.tray.length && !rotated; slot++) {
      if (c.state.tray[slot] == null) continue;
      for (var i = 0; i < 3; i++) {
        if (!c.rotateTray(slot)) break;
        if (_placeSomething(c)) {
          rotated = true;
          break;
        }
      }
    }
    if (!rotated) break;
  }
}

void main() {
  test('an endless run offers no daily double', () async {
    final (c, _, _) = await _controller();
    c.newGame(seed: 11);
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);

    expect(c.state.dailyRewardThisRun, 0);
  });

  test('a finished daily reports a reward that can be doubled', () async {
    final (c, _, _) = await _controller();
    c.startDaily();
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);

    expect(c.state.dailyRewardThisRun, greaterThan(0));
    expect(c.state.dailyRewardDoubled, isFalse);
  });

  test('watching the video pays the reward a second time', () async {
    final (c, storage, _) = await _controller();
    c.startDaily();
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);

    final before = storage.coins;
    final reward = c.state.dailyRewardThisRun;
    expect(await c.doubleDailyRewardWithAd(), isTrue);

    expect(storage.coins, before + reward);
    expect(c.state.dailyRewardDoubled, isTrue);
  });

  test('it can only be taken once', () async {
    final (c, storage, _) = await _controller();
    c.startDaily();
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);

    await c.doubleDailyRewardWithAd();
    final after = storage.coins;

    expect(await c.doubleDailyRewardWithAd(), isFalse);
    expect(storage.coins, after);
  });

  test('a declined or failed video pays nothing and stays offered', () async {
    // CLAUDE.md: a rewarded ad always pays what it promised. The other half of
    // that is that a video which did not complete must not pay, and must not
    // consume the offer either.
    final (c, storage, _) = await _controller(ads: _RefusingAds());
    c.startDaily();
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);

    final before = storage.coins;
    expect(await c.doubleDailyRewardWithAd(), isFalse);

    expect(storage.coins, before);
    expect(c.state.dailyRewardDoubled, isFalse);
  });

  test('the placement reports through the same funnel as the others',
      () async {
    final (c, _, analytics) = await _controller();
    c.startDaily();
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);
    await c.doubleDailyRewardWithAd();

    // Every placement goes through _runRewarded, so accepted and watched can
    // never drift apart and a new one cannot skip the reporting.
    final placements = analytics.events
        .where((e) => e.$2['placement'] == 'daily_double')
        .map((e) => e.$1)
        .toSet();
    expect(placements, containsAll(['rewarded_accepted', 'rewarded_watched']));
  });

  test('replaying the same day pays nothing to double', () async {
    // The second play of a day awards no coins, so there is nothing to offer.
    final (c, _, _) = await _controller();
    c.startDaily();
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);

    c.startDaily();
    _playToGameOver(c);
    await Future<void>.delayed(Duration.zero);

    expect(c.state.dailyRewardThisRun, 0);
    expect(await c.doubleDailyRewardWithAd(), isFalse);
  });
}
