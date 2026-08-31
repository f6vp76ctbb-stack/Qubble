import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The settings list is long and lazily built — give the test a tall viewport
/// so the entry is actually laid out.
void _useTallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(600, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

/// A device that has entered the leaderboard.
const _entered = <String, Object>{
  'fbUid': 'uid-abc',
  'fbRefreshToken': 'refresh-abc',
  'playerName': 'Anna',
  'highscore': 4200,
  'lastSubmittedScore': 4200,
};

MockClient _client({required int deleteStatus, List<String>? methods}) {
  return MockClient((request) async {
    methods?.add(request.method);
    if (request.url.host == 'securetoken.googleapis.com') {
      return http.Response(jsonEncode({'id_token': 'fresh'}), 200);
    }
    if (request.method == 'DELETE') {
      return http.Response('{}', deleteStatus);
    }
    return http.Response('{}', 200);
  });
}

Future<Widget> _app(Storage storage, LeaderboardService leaderboard) async {
  return ProviderScope(
    overrides: [
      storageProvider.overrideWithValue(storage),
      leaderboardServiceProvider.overrideWithValue(leaderboard),
    ],
    child: MaterialApp(
      theme: buildGridTheme(),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: const SettingsScreen(),
    ),
  );
}

Future<Storage> _storage([Map<String, Object> prefs = const {}]) async {
  SharedPreferences.setMockInitialValues(prefs);
  return Storage.create();
}

void main() {
  testWidgets('a player who entered the leaderboard can delete their entry',
      (tester) async {
    _useTallViewport(tester);
    final methods = <String>[];
    final storage = await _storage(_entered);
    await tester.pumpWidget(await _app(
      storage,
      LeaderboardService(
        client: _client(deleteStatus: 200, methods: methods),
        storage: storage,
      ),
    ));
    await tester.pumpAndSettle();

    final entry = find.text('Delete leaderboard entry');
    expect(entry, findsOneWidget,
        reason: 'the deletion path has to be reachable from inside the app');

    await tester.tap(entry);
    await tester.pumpAndSettle();

    // A destructive action gets a confirmation.
    expect(find.text('Delete your entry?'), findsOneWidget);
    await tester.tap(find.text('Delete leaderboard entry').last);
    await tester.pumpAndSettle();

    expect(methods, contains('DELETE'));
    expect(find.text('Your leaderboard entry was deleted.'), findsOneWidget);
    expect(storage.firebaseUid, isNull,
        reason: 'the anonymous identity goes with the entry');
  });

  testWidgets('cancelling leaves the entry alone', (tester) async {
    _useTallViewport(tester);
    final methods = <String>[];
    final storage = await _storage(_entered);
    await tester.pumpWidget(await _app(
      storage,
      LeaderboardService(
        client: _client(deleteStatus: 200, methods: methods),
        storage: storage,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete leaderboard entry'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(methods, isEmpty);
    expect(storage.firebaseUid, 'uid-abc');
  });

  testWidgets('a refused deletion says so instead of claiming success',
      (tester) async {
    _useTallViewport(tester);
    final storage = await _storage(_entered);
    await tester.pumpWidget(await _app(
      storage,
      LeaderboardService(
        client: _client(deleteStatus: 403),
        storage: storage,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete leaderboard entry'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete leaderboard entry').last);
    await tester.pumpAndSettle();

    expect(
      find.text(
          'The entry could not be deleted. Check your connection and try again.'),
      findsOneWidget,
    );
    expect(storage.firebaseUid, 'uid-abc',
        reason: 'the identity must survive a failed deletion');
  });

  testWidgets('a player who never entered is not offered the action',
      (tester) async {
    _useTallViewport(tester);
    final storage = await _storage();
    await tester.pumpWidget(await _app(
      storage,
      LeaderboardService(client: _client(deleteStatus: 200), storage: storage),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Delete leaderboard entry'), findsNothing);
  });
}
