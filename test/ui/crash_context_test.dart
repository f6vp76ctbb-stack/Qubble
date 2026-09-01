import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/crash_reporter.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/puzzle_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

Future<(ProviderContainer, RecordingCrashReporter)> _container([
  Map<String, Object> prefs = const {},
]) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final crashes = RecordingCrashReporter();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      crashReporterProvider.overrideWithValue(crashes),
      hapticsProvider.overrideWithValue(Haptics(enabled: false)),
    ],
  );
  addTearDown(container.dispose);
  return (container, crashes);
}

void main() {
  group('crash context', () {
    test('an endless run says so, with how far in it got', () async {
      final (container, crashes) = await _container();
      final c = container.read(gameControllerProvider.notifier);

      c.newGame();

      expect(crashes.keys[CrashKey.mode], 'endless');
      expect(crashes.keys[CrashKey.placements], 0,
          reason: 'a crash on the first move reads differently from one two '
              'hundred moves in');
      expect(crashes.keys[CrashKey.playerTier], 'new');
    });

    test('the daily challenge is distinguishable from endless', () async {
      final (container, crashes) = await _container();
      final c = container.read(gameControllerProvider.notifier);

      c.startDaily();

      expect(crashes.keys[CrashKey.mode], 'daily');
    });

    test('the tier matches the analytics cohort', () async {
      // Same bucketing on both sides, so a crash can be lined up against the
      // cohort it came from.
      final (container, crashes) = await _container({
        'lifetimeStats': '{"games": 140}',
      });
      container.read(gameControllerProvider.notifier).newGame();

      expect(crashes.keys[CrashKey.playerTier],
          AnalyticsProperty.tierForGames(140));
    });

    test('the puzzle mode records its level', () async {
      final (container, crashes) = await _container();
      final c = container.read(puzzleControllerProvider.notifier);

      c.loadLevel(42);

      expect(crashes.keys[CrashKey.mode], 'puzzle');
      expect(crashes.keys[CrashKey.puzzleLevel], 42);
    });

    test('the reporter defaults to a no-op, so nothing has to override it',
        () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await Storage.create();
      final container = ProviderContainer(
        overrides: [
          storageProvider.overrideWithValue(storage),
          hapticsProvider.overrideWithValue(Haptics(enabled: false)),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(crashReporterProvider), isA<NoopCrashReporter>());
      // And it stays out of the way.
      container.read(gameControllerProvider.notifier).newGame();
    });
  });
}
