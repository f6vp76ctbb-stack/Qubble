import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/leaderboard_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _rows(List<(String, int)> rows) => jsonEncode([
      for (final (name, score) in rows)
        {
          'document': {
            'fields': {
              'name': {'stringValue': name},
              'score': {'integerValue': '$score'},
            },
          },
        },
    ]);

MockClient _client(String body) => MockClient((_) async => http.Response(body, 200));

void _tallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(600, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<Widget> _app(Storage storage, Widget home, {String? body}) async {
  return ProviderScope(
    overrides: [
      storageProvider.overrideWithValue(storage),
      leaderboardServiceProvider.overrideWithValue(
        LeaderboardService(
          client: _client(body ?? _rows([('Anna', 900), ('Ben', 500)])),
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
  );
}

Future<Storage> _storage([Map<String, Object> prefs = const {}]) async {
  SharedPreferences.setMockInitialValues(prefs);
  return Storage.create();
}

void main() {
  testWidgets('every other player\'s name can be reported from the list',
      (tester) async {
    _tallViewport(tester);
    final storage = await _storage({'playerName': 'Ben', 'highscore': 500});
    await tester.pumpWidget(await _app(storage, const LeaderboardScreen()));
    await tester.pumpAndSettle();

    // Two rows, one of them the player's own.
    expect(find.text('Anna'), findsOneWidget);
    expect(find.text('Ben'), findsOneWidget);

    // The report action exists, and only on the row that is not the player's.
    final reports = find.byTooltip('Report this name');
    expect(reports, findsOneWidget,
        reason: 'Anna is reportable; the player does not report themselves');
  });

  testWidgets('with no own entry, every row is reportable', (tester) async {
    _tallViewport(tester);
    final storage = await _storage();
    await tester.pumpWidget(await _app(storage, const LeaderboardScreen()));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Report this name'), findsNWidgets(2));
  });

  testWidgets('the naming rule is shown where the name is chosen',
      (tester) async {
    _tallViewport(tester);
    final storage = await _storage();
    await tester.pumpWidget(await _app(storage, const HomeScreen()));
    // The home screen animates its menu particles forever, so pumpAndSettle
    // never returns here — pump fixed frames instead.
    await tester.pump(const Duration(milliseconds: 300));

    // With no name set, the home screen offers joining the leaderboard.
    final join = find.text('Join the leaderboard');
    expect(join, findsOneWidget,
        reason: 'the entry point to naming has to exist for this test');

    await tester.tap(join);
    await tester.pump(const Duration(milliseconds: 400));

    expect(
      find.textContaining('Names are public'),
      findsOneWidget,
      reason: 'the rule must be stated before the name is created, not after',
    );
    expect(find.text('I understand'), findsOneWidget);
  });

  group('blocking (UGC policy: report is not enough)', () {
    testWidgets('a blocked name disappears from the list', (tester) async {
      _tallViewport(tester);
      final storage = await _storage();
      await tester.pumpWidget(await _app(storage, const LeaderboardScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Anna'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off_outlined).first);
      await tester.pumpAndSettle();

      // The point of blocking rather than reporting: relief is immediate.
      expect(find.text('Anna'), findsNothing);
      expect(find.text('Ben'), findsOneWidget);
      expect(storage.blockedNames, {'Anna'});
    });

    testWidgets('the block survives a restart', (tester) async {
      _tallViewport(tester);
      final storage = await _storage({
        'leaderboard.blockedNames': <String>['Anna'],
      });
      await tester.pumpWidget(await _app(storage, const LeaderboardScreen()));
      await tester.pumpAndSettle();

      // A block that forgets itself on the next launch is not a block.
      expect(find.text('Anna'), findsNothing);
      expect(find.text('Ben'), findsOneWidget);
    });

    testWidgets('the screen says what it is hiding, and can undo it',
        (tester) async {
      _tallViewport(tester);
      final storage = await _storage({
        'leaderboard.blockedNames': <String>['Anna'],
      });
      await tester.pumpWidget(await _app(storage, const LeaderboardScreen()));
      await tester.pumpAndSettle();

      // Without this the player cannot tell a blocked leaderboard from a
      // short one, and has no way back.
      expect(find.textContaining('1'), findsWidgets);
      await tester.tap(find.byType(TextButton).last);
      await tester.pumpAndSettle();

      expect(find.text('Anna'), findsOneWidget);
      expect(storage.blockedNames, isEmpty);
    });

    testWidgets('blocking everyone does not look like an empty leaderboard',
        (tester) async {
      _tallViewport(tester);
      final storage = await _storage({
        'leaderboard.blockedNames': <String>['Anna', 'Ben'],
      });
      await tester.pumpWidget(await _app(storage, const LeaderboardScreen()));
      await tester.pumpAndSettle();

      // "No entries yet" would be a lie the player cannot recover from.
      expect(find.text('Anna'), findsNothing);
      expect(find.byType(TextButton), findsWidgets);
    });

    testWidgets('your own row offers neither report nor block',
        (tester) async {
      _tallViewport(tester);
      final storage = await _storage({'playerName': 'Anna'});
      await tester.pumpWidget(await _app(storage, const LeaderboardScreen()));
      await tester.pumpAndSettle();

      // Own name is removed in settings; reporting or blocking yourself is
      // noise at best and a way to hide your own rank at worst.
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
    });
  });
}
