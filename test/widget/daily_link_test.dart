// A shared Daily result links to the web build with `?daily`. Whoever follows
// it came to play that board, so the app opens it for them — once, without
// throwing away a run already under way, and never for a Daily already played.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/daily.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/app_bootstrap.dart';
import 'package:gridpop/ui/daily_link.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/how_to_play_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _sharedLink = Uri.parse(kQubbleDailyUrl);
final _plainLink = Uri.parse(kQubbleWebUrl);

Future<ProviderContainer> _container({
  Uri? launch,
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  return ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      launchUriProvider.overrideWithValue(launch),
      leaderboardServiceProvider.overrideWithValue(
        LeaderboardService(
          client: MockClient((_) async => http.Response('[]', 200)),
          storage: storage,
        ),
      ),
    ],
  );
}

/// Boots the real AppBootstrap, as the web build does on page load.
Future<void> _boot(WidgetTester tester, ProviderContainer container) async {
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const AppBootstrap(),
      ),
    ),
  );
  // _init runs in a post-frame callback and awaits several steps; the screens
  // animate forever, so pump fixed frames rather than settling.
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void _placeOnePiece(GameController c) {
  for (var slot = 0; slot < c.state.tray.length; slot++) {
    final p = c.state.tray[slot];
    if (p == null) continue;
    for (var r = 0; r <= Board.size - p.height; r++) {
      for (var col = 0; col <= Board.size - p.width; col++) {
        if (c.canPlace(slot, Cell(r, col))) {
          c.place(slot, Cell(r, col));
          return;
        }
      }
    }
  }
  fail('no piece fits an empty board');
}

void main() {
  test('the shared link is the web build with the daily flag', () {
    expect(kQubbleDailyUrl, startsWith(kQubbleWebUrl));
    expect(isDailyLink(_sharedLink), isTrue);
    expect(isDailyLink(_plainLink), isFalse,
        reason: 'links shared before the flag existed open the home screen');
    expect(isDailyLink(null), isFalse, reason: 'native builds have no URL');
  });

  testWidgets('following a shared result opens today\'s Daily', (
    tester,
  ) async {
    final container = await _container(launch: _sharedLink);
    addTearDown(container.dispose);
    await _boot(tester, container);

    expect(find.byType(GameScreen), findsOneWidget);
    expect(container.read(gameControllerProvider).isDaily, isTrue);
  });

  testWidgets('the plain web address still opens the home screen', (
    tester,
  ) async {
    final container = await _container(launch: _plainLink);
    addTearDown(container.dispose);
    await _boot(tester, container);

    expect(find.byType(GameScreen), findsNothing);
  });

  testWidgets('a Daily already played today is not opened again', (
    tester,
  ) async {
    final container = await _container(
      launch: _sharedLink,
      prefs: {'lastDailyDate': DailyChallenge.dateKey(DateTime.now())},
    );
    addTearDown(container.dispose);
    await _boot(tester, container);

    expect(find.byType(GameScreen), findsNothing,
        reason: 'one run a day; the home card shows when the next one starts');
  });

  testWidgets('reloading the page resumes the Daily instead of restarting it', (
    tester,
  ) async {
    final container = await _container(launch: _sharedLink);
    addTearDown(container.dispose);
    await _boot(tester, container);
    final controller = container.read(gameControllerProvider.notifier);
    _placeOnePiece(controller);
    final board = container.read(gameControllerProvider).board.toString();

    // The same page loaded again: a fresh widget tree over the same state.
    await tester.pumpWidget(const SizedBox());
    await _boot(tester, container);

    final state = container.read(gameControllerProvider);
    expect(state.isDaily, isTrue);
    expect(state.runActive, isTrue, reason: 'the run was thrown away');
    expect(state.board.toString(), board);
    expect(find.byType(GameScreen), findsOneWidget);
  });

  testWidgets('the rules do not open on top of the board', (tester) async {
    // Third launch: the rules would show unprompted (first_launch_rules_test).
    final container = await _container(
      launch: _sharedLink,
      prefs: {'appOpenCount': 2},
    );
    addTearDown(container.dispose);
    await _boot(tester, container);

    expect(find.byType(GameScreen), findsOneWidget);
    expect(find.byType(HowToPlayScreen), findsNothing);
  });
}
