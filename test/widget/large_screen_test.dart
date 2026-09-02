// Layout on screens bigger than a phone (MASTERPLAN.md D.6).
//
// The app is portrait-locked, so "large" here means tablets and unfolded
// foldables, not landscape. Before the cap the board simply grew with the
// screen: measured at 336 px on a 360 dp phone, 776 on an 800 dp tablet and
// 1176 on a 1200 dp one -- 98 % of the width, which makes a placement a drag
// across the whole display and puts the far corners out of thumb reach.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pump(WidgetTester tester, Widget home, Size size) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  tester.view.physicalSize = size;
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
        home: home,
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 400));
}

double _boardWidth(WidgetTester tester) =>
    tester.widgetList<BoardView>(find.byType(BoardView)).first.size;

void main() {
  testWidgets('a phone still uses nearly the full width', (tester) async {
    await _pump(tester, const GameScreen(), const Size(360, 800));

    // The cap must not reach phones. 336 of 360 before and after.
    expect(_boardWidth(tester), greaterThan(320));
    expect(_boardWidth(tester), lessThanOrEqualTo(kMaxBoardWidth));
  });

  testWidgets('the widest common phone is unaffected by the cap',
      (tester) async {
    await _pump(tester, const GameScreen(), const Size(480, 1000));

    // 480 - 24 = 456, still under the cap: the boundary is where it was
    // chosen to be, not somewhere a phone can reach.
    expect(_boardWidth(tester), closeTo(456, 1));
  });

  testWidgets('a tablet caps the board instead of stretching it',
      (tester) async {
    await _pump(tester, const GameScreen(), const Size(800, 1280));

    expect(_boardWidth(tester), kMaxBoardWidth);
  });

  testWidgets('a very large screen caps it just the same', (tester) async {
    await _pump(tester, const GameScreen(), const Size(1200, 1600));

    expect(_boardWidth(tester), kMaxBoardWidth);
  });

  testWidgets('the capped board is centred, not left-aligned', (tester) async {
    await _pump(tester, const GameScreen(), const Size(1200, 1600));

    final board = tester.getRect(find.byType(BoardView).first);
    // A cap that left the board hugging one edge would trade one layout
    // problem for another.
    expect(board.center.dx, closeTo(600, 1));
  });

  testWidgets('the home screen renders on a tablet without overflowing',
      (tester) async {
    final errors = <FlutterErrorDetails>[];
    final previous = FlutterError.onError;
    FlutterError.onError = errors.add;
    addTearDown(() => FlutterError.onError = previous);

    await _pump(tester, const HomeScreen(), const Size(800, 1280));

    expect(
      errors.where((e) => e.exception.toString().contains('overflowed')),
      isEmpty,
    );
  });
}
