import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/app_bootstrap.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/stats_consent_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void main() {
  testWidgets('first start asks, and "no" is stored and applied', (
    tester,
  ) async {
    final collection = RecordingCollection();
    final storage = await _boot(tester, collection: collection);

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
    await _boot(tester, collection: RecordingCollection());
    await tester.tapAt(const Offset(5, 5));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Statistics and crash reports'), findsOneWidget);
  });

  testWidgets('an answered question is not asked again', (tester) async {
    await _boot(
      tester,
      prefs: {'settings.statsConsent': true},
      collection: RecordingCollection(),
    );
    expect(find.text('Statistics and crash reports'), findsNothing);
  });

  testWidgets('a build without statistics never asks', (tester) async {
    await _boot(tester);
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
