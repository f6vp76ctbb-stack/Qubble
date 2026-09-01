import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

Future<(GameController, RecordingAnalytics)> _controller({
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final analytics = RecordingAnalytics();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      analyticsProvider.overrideWithValue(analytics),
      // The real Haptics reaches a platform channel, which a plain test has
      // no binding for.
      hapticsProvider.overrideWithValue(Haptics(enabled: false)),
    ],
  );
  addTearDown(container.dispose);
  return (container.read(gameControllerProvider.notifier), analytics);
}

/// Places the first tray piece wherever it fits.
bool _placeAnywhere(GameController c) {
  final snap = c.state;
  for (var slot = 0; slot < snap.tray.length; slot++) {
    final piece = snap.tray[slot];
    if (piece == null) continue;
    for (var r = 0; r < Board.size; r++) {
      for (var col = 0; col < Board.size; col++) {
        if (!c.canPlace(slot, Cell(r, col))) continue;
        c.place(slot, Cell(r, col));
        return true;
      }
    }
  }
  return false;
}

void main() {
  group('FTUE events', () {
    test('a brand new player is marked as such on their first run', () async {
      final (c, analytics) = await _controller();
      c.newGame();

      final start = analytics.of(AnalyticsEvent.gameStart).single;
      expect(start['mode'], 'endless');
      expect(start['is_first_game'], isTrue,
          reason: 'without this the funnel cannot separate first runs from '
              'the rest, and the FTUE cannot be measured at all');
    });

    test('a player with runs behind them is not', () async {
      final (c, analytics) = await _controller(
        prefs: {'lifetimeStats': '{"games": 7}'},
      );
      c.newGame();
      expect(analytics.of(AnalyticsEvent.gameStart).single['is_first_game'],
          isFalse);
    });

    test('the first placement reports coach step 0', () async {
      // Step 0 is the FTUE measure: of everyone who opens the app, how many
      // ever put a block down.
      final (c, analytics) = await _controller();
      c.newGame();
      expect(analytics.of(AnalyticsEvent.onboardingStep), isEmpty);

      expect(_placeAnywhere(c), isTrue);

      expect(analytics.of(AnalyticsEvent.onboardingStep).first['step'], 0);
    });

    test('a player past onboarding reports no steps', () async {
      final (c, analytics) = await _controller(prefs: {'onboardingDone': true});
      c.newGame();
      _placeAnywhere(c);
      expect(analytics.of(AnalyticsEvent.onboardingStep), isEmpty);
    });

    test('the daily challenge reports no coach steps', () async {
      // The coach is deliberately silent in the Daily; the funnel must agree.
      final (c, analytics) = await _controller();
      c.startDaily();
      _placeAnywhere(c);
      expect(analytics.of(AnalyticsEvent.onboardingStep), isEmpty);
    });
  });
}
