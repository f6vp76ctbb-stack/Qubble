import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/app_bootstrap.dart';
import 'package:gridpop/ui/screens/how_to_play_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Boots the real AppBootstrap. Every service provider already defaults to a
/// silent or fake implementation; only storage and the leaderboard need
/// overriding, the latter so nothing reaches the network.
Future<Storage> _boot(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
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
        home: const AppBootstrap(),
      ),
    ),
  );
  // _init runs in a post-frame callback and awaits several steps. The home
  // screen animates forever, so pump fixed frames rather than settling.
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  return storage;
}

void main() {
  testWidgets('the first launch goes straight to the game, not to a rules wall',
      (tester) async {
    await _boot(tester);

    expect(
      find.byType(HowToPlayScreen),
      findsNothing,
      reason: 'a wall of text between the icon tap and the first block is the '
          'most expensive thing this app can do to a new player',
    );
  });

  testWidgets('the second launch belongs to the notification prompt alone',
      (tester) async {
    // Housekeeping takes appOpenCount to 2 and asks about notifications. The
    // rules must not stack on top of that dialog.
    await _boot(tester, prefs: {'appOpenCount': 1});
    expect(find.byType(HowToPlayScreen), findsNothing);
  });

  testWidgets('a returning player who never opened the rules is shown them',
      (tester) async {
    // Third launch: appOpenCount reaches 3 during housekeeping.
    final storage = await _boot(tester, prefs: {'appOpenCount': 2});

    expect(find.byType(HowToPlayScreen), findsOneWidget,
        reason: 'the screen still exists for players who never find the '
            'help icon — just after they have played, not before');
    expect(storage.howToPlaySeen, isTrue);
  });

  testWidgets('a player who already read the rules is not shown them again',
      (tester) async {
    await _boot(tester, prefs: {'appOpenCount': 2, 'howToPlaySeen': true});
    expect(find.byType(HowToPlayScreen), findsNothing);
  });

  testWidgets('a player past onboarding is not shown them either',
      (tester) async {
    // Someone who learnt the game from the in-run coach needs no preamble.
    await _boot(tester, prefs: {'appOpenCount': 2, 'onboardingDone': true});
    expect(find.byType(HowToPlayScreen), findsNothing);
  });

  testWidgets('it shows once, not on every later launch', (tester) async {
    await _boot(tester, prefs: {'appOpenCount': 9});
    expect(find.byType(HowToPlayScreen), findsOneWidget);

    // The flag is now set, so the next launch stays clear.
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('howToPlaySeen'), isTrue);
  });
}
