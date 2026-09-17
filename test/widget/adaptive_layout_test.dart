// What Android 16 does to a portrait-locked game, measured instead of assumed.
//
// Two Play Console findings on release 9 (1.2.0) point at the same place:
//
//  1. Apps targeting API 36 have `android:screenOrientation` ignored on
//     displays of at least sw600dp, so the portrait lock this app relies on
//     (main.dart, AndroidManifest.xml) does not hold on tablets and unfolded
//     foldables. Landscape is therefore already reachable in production.
//  2. Apps targeting API 35 and up are laid out edge to edge, so system bars
//     overlap content that does not apply insets.
//
// docs/PLAY-CONSOLE-1.1.0.md claims landscape drops the booster bar and the
// "new pieces" button. That was written before the 3 September change that
// keeps the bar in compact mode, so it needs re-measuring rather than
// repeating. These tests are that measurement.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:gridpop/ui/widgets/tray_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Renders [home] at [size], optionally with system bars of [barInset] logical
/// pixels at top and bottom, and returns every overflow reported while doing so.
Future<List<FlutterErrorDetails>> _pump(
  WidgetTester tester,
  Widget home,
  Size size, {
  double barInset = 0,
}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  if (barInset > 0) {
    // What edge-to-edge looks like to Flutter: the window keeps its full size
    // and reports the bars as padding the app is expected to honour.
    tester.view.viewPadding = FakeViewPadding(top: barInset, bottom: barInset);
    tester.view.padding = FakeViewPadding(top: barInset, bottom: barInset);
  }
  addTearDown(tester.view.reset);

  final errors = <FlutterErrorDetails>[];
  final previous = FlutterError.onError;
  FlutterError.onError = errors.add;
  addTearDown(() => FlutterError.onError = previous);

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

  return errors
      .where((e) => e.exception.toString().contains('overflowed'))
      .toList();
}

/// A tablet held sideways: smallest width 800 dp, so well past the sw600dp
/// line where the orientation lock stops being honoured.
const _tabletLandscape = Size(1280, 800);
const _tabletPortrait = Size(800, 1280);

void main() {
  group('landscape on a large screen (the lock no longer holds there)', () {
    testWidgets('the game screen lays out without overflowing', (tester) async {
      expect(await _pump(tester, const GameScreen(), _tabletLandscape), isEmpty);
    });

    testWidgets('the board is still there and still capped', (tester) async {
      await _pump(tester, const GameScreen(), _tabletLandscape);

      final board = tester.widgetList<BoardView>(find.byType(BoardView)).first;
      expect(board.size, lessThanOrEqualTo(kMaxBoardWidth));
      expect(board.size, greaterThan(0));
    });

    testWidgets('the board fits inside the viewport, not past its bottom',
        (tester) async {
      await _pump(tester, const GameScreen(), _tabletLandscape);

      // A board taller than the window is the failure a portrait-only layout
      // produces when the height halves: it draws, reports no overflow, and
      // the lower rows sit off-screen where no finger reaches them.
      final board = tester.getRect(find.byType(BoardView).first);
      expect(board.bottom, lessThanOrEqualTo(_tabletLandscape.height));
      expect(board.top, greaterThanOrEqualTo(0));
    });

    testWidgets('the home screen lays out without overflowing', (tester) async {
      expect(await _pump(tester, const HomeScreen(), _tabletLandscape), isEmpty);
    });

    testWidgets('the shop lays out without overflowing', (tester) async {
      expect(await _pump(tester, const ShopScreen(), _tabletLandscape), isEmpty);
    });
  });

  group('landscape on a phone (where the lock still holds)', () {
    // sw360dp keeps its lock even on API 36, so this is not a requirement --
    // it records what the compact path does if the lock is ever dropped, and
    // it did hold when measured: zero overflows at 800x360.
    const phoneLandscape = Size(800, 360);

    testWidgets('the compact layout absorbs a 360 dp height', (tester) async {
      expect(await _pump(tester, const GameScreen(), phoneLandscape), isEmpty);
    });
  });

  group('edge-to-edge: content clear of the system bars', () {
    const inset = 48.0;

    testWidgets('the game screen keeps the board below the status bar',
        (tester) async {
      final overflows = await _pump(
        tester,
        const GameScreen(),
        _tabletPortrait,
        barInset: inset,
      );
      expect(overflows, isEmpty);

      final board = tester.getRect(find.byType(BoardView).first);
      expect(
        board.top,
        greaterThanOrEqualTo(inset),
        reason: 'the board would be drawn under the status bar',
      );
      expect(
        board.bottom,
        lessThanOrEqualTo(_tabletPortrait.height - inset),
        reason: 'the board would be drawn under the navigation bar',
      );
    });

    testWidgets('the tray, the lowest element, clears the navigation bar',
        (tester) async {
      await _pump(
        tester,
        const GameScreen(),
        _tabletPortrait,
        barInset: inset,
      );

      // The board is not the bottom of the screen -- the piece tray is, and it
      // is the one element a player drags from. A tray drawn under the
      // navigation bar loses the gesture, not just the pixels.
      final tray = tester.getRect(find.byType(TrayView).first);
      expect(
        tray.bottom,
        lessThanOrEqualTo(_tabletPortrait.height - inset),
        reason: 'the piece tray would be drawn under the navigation bar',
      );
    });

    testWidgets('the tray clears the navigation bar on a phone too',
        (tester) async {
      await _pump(tester, const GameScreen(), const Size(360, 800),
          barInset: inset);

      final tray = tester.getRect(find.byType(TrayView).first);
      expect(tray.bottom, lessThanOrEqualTo(800 - inset));
    });

    testWidgets('the home screen lays out under system bars without overflow',
        (tester) async {
      expect(
        await _pump(tester, const HomeScreen(), _tabletPortrait,
            barInset: inset),
        isEmpty,
      );
    });

    testWidgets('the shop lays out under system bars without overflow',
        (tester) async {
      expect(
        await _pump(tester, const ShopScreen(), _tabletPortrait,
            barInset: inset),
        isEmpty,
      );
    });
  });
}
