/// Renders the App-campaign video as a frame sequence, straight from the app.
///
/// Not a test — it lives outside `test/` so `flutter test` never picks it up.
/// Run it explicitly, then encode:
///
/// ```bash
/// flutter test tool/generate_clip.dart   # -> store-assets/raw/clip/<locale>/
/// python3 tool/make_clip.py              # -> store-assets/ads/<locale>/clip-9x16.mp4
/// ```
///
/// Why this exists: an App campaign takes video only from YouTube, and without
/// one Google assembles a slideshow out of the still images — regularly the
/// weakest asset in the campaign. Filming a phone gets you a video with a
/// thumb in it; this gets a clean 1080x1920 capture of the real board, and it
/// is reproducible, so a balance change can be re-rendered rather than
/// re-filmed.
///
/// The frames are the real app. Nothing here is drawn on top, for the same
/// reason `tool/generate_screenshots.dart` does not repaint the board: an ad
/// that shows a UI the app does not have is a Misrepresentation case.
///
/// Everything is seeded, so a re-run produces the same frames.
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 405x720 at 2.667x — 1080x1920, the shape App campaigns want for 9:16.
///
/// Wider than the 360 dp the store screenshots use, and deliberately so. Those
/// crop to the board; this one shows the HUD, and at 360 dp with a high combo
/// the score row runs out of width — the SCORE label breaks across two lines
/// and the value across three. That is a real layout bug on narrow phones
/// (tracked separately, it needs an app release to fix), but it is not what an
/// ad should be showing, and 405 dp is squarely inside the range most current
/// phones report.
const Size _logicalSize = Size(405, 720);
const double _pixelRatio = 8 / 3;

/// 30 fps. App campaigns accept 10-60 s; 12 s clears the floor with room to
/// spare and still fits the attention span these placements actually get.
const int _fps = 30;
const Duration _frameStep = Duration(milliseconds: 1000 ~/ _fps);
const int _totalFrames = 12 * _fps;

/// One move every 0.6 s, which is roughly how fast the game reads when someone
/// who knows it is playing. Slower looks hesitant, faster looks like a demo
/// reel and the clears stop landing as individual events.
const int _movesEvery = 18;
const int _firstMoveFrame = 12;

/// Stop placing here and let the last burst play out. A clip that ends on the
/// frame a piece lands looks cut off.
const int _lastMoveFrame = _totalFrames - 60;

/// Each locale gets its own clip: the HUD carries SCORE and BEST, and a German
/// campaign showing an English HUD is the same mismatch as a German listing
/// with English screenshots.
const _locales = ['en', 'de'];

/// Neon: the burst reads strongest against it, and it is the palette the combo
/// screenshot already uses, so the ad and the listing agree.
const _theme = 'neon';

/// The Daily seed comes from the calendar, so without a fixed date the clip is
/// a different board every run and the promise of reproducible output is a
/// fiction. Same date the combo screenshot uses.
final _dailyDate = DateTime.utc(2026, 3, 14);

String _outDir(String locale) => 'store-assets/raw/clip/$locale';

Future<void> _loadFont(String family, String path) async {
  final bytes = File(path).readAsBytesSync();
  final loader = FontLoader(family)
    ..addFont(Future.value(ByteData.sublistView(bytes)));
  await loader.load();
}

Future<void> _loadFonts() async {
  const nunito = 'assets/fonts/Nunito.ttf';
  await _loadFont('Nunito', nunito);
  await _loadFont('Roboto', nunito);
  final flutterRoot =
      Platform.environment['FLUTTER_ROOT'] ??
      '${Platform.environment['HOME']}/.flutter-sdk';
  await _loadFont(
    'MaterialIcons',
    '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
}

/// A save file that has clearly been played, so the HUD is not full of zeroes.
Future<Storage> _seededStorage() async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  await storage.setPlayerName('Puzzlerin');
  await storage.setHighscore(18740);
  await storage.setCoins(2480);
  await storage.setDiamonds(12);
  await storage.setPlayerLevel(14);
  await storage.setXp(120);
  await storage.setStreak(6);
  await storage.setAppOpenCount(37);
  for (final id in ['fade', 'neon', 'ocean', 'wood', 'sunset']) {
    await storage.addUnlockedTheme(id);
  }
  await storage.setActiveTheme(_theme);
  // The onboarding coach would sit over the board for the whole clip.
  await storage.setOnboardingDone(true);
  return storage;
}

ProviderContainer _container(Storage storage) =>
    ProviderContainer(overrides: [storageProvider.overrideWithValue(storage)]);

enum _Prefer { any, fill, clear }

/// How full each row and column is, so a clearing move can be spotted without
/// actually playing it first.
class _LineCounts {
  _LineCounts(Board board)
    : rows = List<int>.filled(Board.size, 0),
      cols = List<int>.filled(Board.size, 0) {
    for (var r = 0; r < Board.size; r++) {
      for (var c = 0; c < Board.size; c++) {
        if (board.filledAt(r, c)) {
          rows[r]++;
          cols[c]++;
        }
      }
    }
  }

  final List<int> rows;
  final List<int> cols;

  bool completesLine(Piece piece, Cell origin) {
    final addedRows = <int, int>{};
    final addedCols = <int, int>{};
    for (final cell in piece.cells) {
      addedRows[origin.row + cell.row] =
          (addedRows[origin.row + cell.row] ?? 0) + 1;
      addedCols[origin.col + cell.col] =
          (addedCols[origin.col + cell.col] ?? 0) + 1;
    }
    for (final e in addedRows.entries) {
      if (rows[e.key] + e.value >= Board.size) return true;
    }
    for (final e in addedCols.entries) {
      if (cols[e.key] + e.value >= Board.size) return true;
    }
    return false;
  }
}

bool _playOneMove(GameController c, _Prefer prefer) {
  final counts = _LineCounts(c.state.board);
  for (var slot = 0; slot < 3; slot++) {
    final piece = c.state.tray[slot];
    if (piece == null) continue;
    for (var row = 0; row < Board.size; row++) {
      for (var col = 0; col < Board.size; col++) {
        final cell = Cell(row, col);
        if (!c.canPlace(slot, cell)) continue;
        if (prefer != _Prefer.any) {
          final clears = counts.completesLine(piece, cell);
          if (prefer == _Prefer.fill && clears) continue;
          if (prefer == _Prefer.clear && !clears) continue;
        }
        c.place(slot, cell);
        return true;
      }
    }
  }
  return false;
}

/// Prefer a clear, then a fill, then anything. Over the clip this reads as
/// someone playing well rather than as a scripted sequence — and it keeps the
/// board from packing itself into a Game Over, which is the one thing that
/// must not appear in an ad.
bool _playBeat(GameController c) =>
    _playOneMove(c, _Prefer.clear) ||
    _playOneMove(c, _Prefer.fill) ||
    _playOneMove(c, _Prefer.any);

double _fillRatio(GameController c) {
  var filled = 0;
  for (var r = 0; r < Board.size; r++) {
    for (var col = 0; col < Board.size; col++) {
      if (c.state.board.filledAt(r, col)) filled++;
    }
  }
  return filled / (Board.size * Board.size);
}

/// Starts the clip on a board that is already in progress. An empty grid for
/// the first three seconds sells nothing: the whole point of the first frame
/// is that a clear is about to be possible.
void _stageBoard(GameController c, {double targetFill = 0.40}) {
  for (var i = 0; i < 200; i++) {
    if (c.state.gameOver) return;
    if (_fillRatio(c) >= targetFill) return;
    if (_playOneMove(c, _Prefer.fill)) continue;
    if (!_playOneMove(c, _Prefer.any)) return;
  }
}

void main() {
  setUpAll(_loadFonts);

  for (final locale in _locales) {
    testWidgets('clip ($locale)', (tester) async {
      tester.view.physicalSize = _logicalSize * _pixelRatio;
      tester.view.devicePixelRatio = _pixelRatio;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final storage = await _seededStorage();
      final container = _container(storage);
      addTearDown(container.dispose);

      final controller = container.read(gameControllerProvider.notifier);
      // The Daily Challenge, not a free run — and not for the daily angle.
      // A free run draws a full-width "New pieces (video)" button above the
      // board and the booster bar below it. In an ad whose whole claim is that
      // the game never makes you watch a video, a video call-to-action in
      // frame is the one thing that must not be there. game_screen.dart gates
      // both on `!isDaily`, so the Daily is the app's own clean composition.
      controller.startDaily(now: _dailyDate);
      _stageBoard(controller);
      expect(
        container.read(gameControllerProvider).gameOver,
        isFalse,
        reason: 'the board ran to Game Over while being staged',
      );

      final dir = Directory(_outDir(locale));
      if (dir.existsSync()) dir.deleteSync(recursive: true);
      dir.createSync(recursive: true);

      final key = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: buildGridTheme(),
              locale: Locale(locale),
              localizationsDelegates: L10n.localizationsDelegates,
              supportedLocales: L10n.supportedLocales,
              home: const GameScreen(),
            ),
          ),
        ),
      );
      // Let the screen finish its entrance before the first move, or the first
      // burst lands next to a board that is still sliding in.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));

      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;

      var moves = 0;
      for (var frame = 0; frame < _totalFrames; frame++) {
        if (frame >= _firstMoveFrame &&
            frame <= _lastMoveFrame &&
            (frame - _firstMoveFrame) % _movesEvery == 0 &&
            !container.read(gameControllerProvider).gameOver) {
          if (_playBeat(controller)) moves++;
        }
        await tester.pump(_frameStep);

        // Rasterizing needs the real event loop: outside runAsync the first
        // capture happens to succeed and every later one waits forever.
        final png = await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: _pixelRatio);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          image.dispose();
          return bytes;
        });
        final name = frame.toString().padLeft(4, '0');
        File('${_outDir(locale)}/frame-$name.png')
            .writeAsBytesSync(png!.buffer.asUint8List());
      }

      // A Game Over overlay in an ad sells the opposite of the headline over
      // it. Fail loudly rather than ship one.
      expect(
        container.read(gameControllerProvider).gameOver,
        isFalse,
        reason: 'the run hit Game Over inside the clip',
      );
      expect(moves, greaterThan(10), reason: 'the clip barely plays anything');
      // ignore: avoid_print
      print('$locale: $_totalFrames frames, $moves moves -> ${_outDir(locale)}');
    }, timeout: const Timeout(Duration(minutes: 10)));
  }
}
