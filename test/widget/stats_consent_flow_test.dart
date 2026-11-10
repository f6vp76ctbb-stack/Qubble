import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/app_bootstrap.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/stats_consent_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';
import '../support/recording_stats_collection.dart';

/// The one-time question and the settings switch for statistics and crash
/// reports. Every other test runs without a [StatsCollection] — the web and
/// test default — and so never sees the question.
Future<Storage> _boot(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  RecordingCollection? collection,
  Widget home = const AppBootstrap(),
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        if (collection != null)
          statsCollectionProvider.overrideWithValue(collection),
        leaderboardServiceProvider.overrideWithValue(
          LeaderboardService(
            client: MockClient((_) async => http.Response('[]', 200)),
            storage: storage,
          ),
        ),
      ],
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: home,
      ),
    ),
  );
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  return storage;
}

/// A player who has finished a run: the question opens their launch.
const _played = <String, Object>{'lifetimeStats': '{"games":1}'};

void main() {
  testWidgets('a first launch does not ask: the board comes first', (
    tester,
  ) async {
    // It used to be the first thing a new player saw, before the first block.
    // Nothing is collected until there is an answer, so asking later costs
    // measurements, not compliance (lib/game/first_session.dart).
    final collection = RecordingCollection();
    final storage = await _boot(tester, collection: collection);

    expect(find.text('Statistics and crash reports'), findsNothing);
    expect(find.byType(GameScreen), findsOneWidget);
    expect(storage.statsConsent, isNull);
    expect(collection.calls, isEmpty);
  });

  testWidgets('the first game over asks, once the result has been seen', (
    tester,
  ) async {
    final collection = RecordingCollection();
    final storage = await _boot(tester, collection: collection);
    final container = ProviderScope.containerOf(
      tester.element(find.byType(GameScreen)),
    );
    playToGameOver(container.read(gameControllerProvider.notifier));
    // The run is booked, the overlay builds ...
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Game Over'), findsOneWidget);
    expect(
      find.text('Statistics and crash reports'),
      findsNothing,
      reason: 'the result stands alone first',
    );
    // ... and then the question opens over it.
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Statistics and crash reports'), findsOneWidget);
    expect(
      find.textContaining('Pick a name'),
      findsNothing,
      reason: 'one question per game over',
    );

    await tester.tap(find.text('Allow'));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }
    expect(find.text('Statistics and crash reports'), findsNothing);
    expect(storage.statsConsent, isTrue);
    expect(collection.calls.single, (enabled: true, answerChanged: true));
  });

  testWidgets('a quick "Play again" is not interrupted; the question keeps', (
    tester,
  ) async {
    final storage = await _boot(tester, collection: RecordingCollection());
    final container = ProviderScope.containerOf(
      tester.element(find.byType(GameScreen)),
    );
    final controller = container.read(gameControllerProvider.notifier);
    playToGameOver(controller);
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    controller.newGame(seed: 5);
    for (var i = 0; i < 14; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Statistics and crash reports'), findsNothing);
    expect(storage.statsConsent, isNull);
  });

  testWidgets('a launch asks a player who has finished a run, and "no" is '
      'stored and applied', (tester) async {
    final collection = RecordingCollection();
    final storage = await _boot(
      tester,
      prefs: _played,
      collection: collection,
    );

    expect(find.text('Statistics and crash reports'), findsOneWidget);
    // Neither answer is the default: both buttons look the same.
    expect(find.widgetWithText(OutlinedButton, 'Allow'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, "Don't allow"), findsOneWidget);

    await tester.tap(find.text("Don't allow"));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 200));
    }

    expect(find.text('Statistics and crash reports'), findsNothing);
    expect(storage.statsConsent, isFalse);
    expect(collection.calls.single, (enabled: false, answerChanged: true));
  });

  testWidgets('a tap beside the question does not dismiss it', (tester) async {
    await _boot(tester, prefs: _played, collection: RecordingCollection());
    await tester.tapAt(const Offset(5, 5));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Statistics and crash reports'), findsOneWidget);
  });

  testWidgets('the third launch asks even without a finished run', (
    tester,
  ) async {
    // Someone who only plays puzzles never sees a game over.
    await _boot(
      tester,
      prefs: {'appOpenCount': 2},
      collection: RecordingCollection(),
    );
    expect(find.text('Statistics and crash reports'), findsOneWidget);
  });

  testWidgets('an answered question is not asked again', (tester) async {
    await _boot(
      tester,
      prefs: {..._played, 'settings.statsConsent': true},
      collection: RecordingCollection(),
    );
    expect(find.text('Statistics and crash reports'), findsNothing);
  });

  testWidgets('a build without statistics never asks', (tester) async {
    await _boot(tester, prefs: _played);
    expect(find.text('Statistics and crash reports'), findsNothing);
  });

  testWidgets('the settings switch withdraws consent', (tester) async {
    final collection = RecordingCollection();
    final storage = await _boot(
      tester,
      prefs: {'settings.statsConsent': true},
      collection: collection,
      home: const SettingsScreen(),
    );

    final tile = find.widgetWithText(
      SwitchListTile,
      'Statistics & crash reports',
    );
    await tester.scrollUntilVisible(tile, 200);
    expect(tester.widget<SwitchListTile>(tile).value, isTrue);

    await tester.tap(tile);
    await tester.pump();

    expect(storage.statsConsent, isFalse);
    expect(collection.calls.single, (enabled: false, answerChanged: true));
    expect(tester.widget<SwitchListTile>(tile).value, isFalse);
  });

  testWidgets('no switch where the build sends no statistics', (tester) async {
    await _boot(tester, home: const SettingsScreen());
    expect(find.text('Statistics & crash reports'), findsNothing);
    // The licenses entry is there either way.
    await tester.scrollUntilVisible(find.text('Licenses'), 200);
    expect(find.text('Licenses'), findsOneWidget);
  });
}
