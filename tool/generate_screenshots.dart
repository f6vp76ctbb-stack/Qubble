/// Renders the Play Store screenshots straight from the real screens.
///
/// Not a test — it lives outside `test/` so `flutter test` never picks it up.
/// Run it explicitly:
///
/// ```bash
/// flutter test tool/generate_screenshots.dart
/// ```
///
/// Output: `store-assets/raw/*.png` at 1080×1920. The captions are added
/// afterwards by `tool/caption_screenshots.py`, which writes the finished
/// `store-assets/screenshot-*.png`.
///
/// Everything is seeded deterministically, so re-running produces the same
/// images. The state shown (best score, coins, level, name) is demo data.
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
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/puzzle_screen.dart';
import 'package:gridpop/ui/screens/themes_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _outDir = 'store-assets/raw';

/// Portrait phone at 3× — Play wants at least 1080 px on the short edge.
const Size _logicalSize = Size(360, 640);
const double _pixelRatio = 3;

Future<void> _loadFont(String family, String path) async {
  final bytes = File(path).readAsBytesSync();
  final loader = FontLoader(family)
    ..addFont(Future.value(ByteData.sublistView(bytes)));
  await loader.load();
}

Future<void> _loadFonts() async {
  const nunito = 'assets/fonts/Nunito.ttf';
  await _loadFont('Nunito', nunito);
  // Widgets that fall back to the platform default (buttons, dialogs) would
  // otherwise render as filled boxes in the test environment.
  await _loadFont('Roboto', nunito);
  final flutterRoot =
      Platform.environment['FLUTTER_ROOT'] ??
      '${Platform.environment['HOME']}/.flutter-sdk';
  await _loadFont(
    'MaterialIcons',
    '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );
}

/// A player who has clearly been at it for a while — the store should not show
/// an empty save file.
Future<Storage> _seededStorage({
  String theme = kDefaultThemeId,
  int highscore = 18740,
  int streak = 6,
}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  await storage.setPlayerName('Puzzlerin');
  await storage.setHighscore(highscore);
  await storage.setCoins(2480);
  await storage.setDiamonds(12);
  await storage.setPlayerLevel(14);
  await storage.setXp(120);
  await storage.setStreak(streak);
  await storage.setAppOpenCount(37);
  for (final id in ['fade', 'neon', 'ocean', 'wood', 'sunset']) {
    await storage.addUnlockedTheme(id);
  }
  for (final id in ['gradient', 'outline', 'glossy', 'glow']) {
    await storage.addUnlockedSkin(id);
  }
  await storage.setActiveTheme(theme);
  await storage.setPuzzleStars({1: 3, 2: 3, 3: 2, 4: 3, 5: 1});
  // Onboarding coach marks would cover the board in a screenshot.
  await storage.setOnboardingDone(true);
  return storage;
}

Future<void> _capture(
  WidgetTester tester,
  String name, {
  required ProviderContainer container,
  required Widget screen,
  Duration settle = const Duration(milliseconds: 400),
}) async {
  final key = GlobalKey();
  await tester.pumpWidget(
    RepaintBoundary(
      key: key,
      child: UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: buildGridTheme(),
          home: screen,
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(settle);

  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: _pixelRatio);
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  final file = File('$_outDir/$name.png')..createSync(recursive: true);
  file.writeAsBytesSync(png!.buffer.asUint8List());
  // ignore: avoid_print
  print('  ✓ $_outDir/$name.png  (${image.width}×${image.height})');
}

/// Places the first legal move it finds, optionally refusing moves that clear
/// a line (to fill the board up rather than empty it). Returns false when
/// nothing fits.
bool _playOneMove(GameController c, {bool avoidClears = false}) {
  for (var slot = 0; slot < 3; slot++) {
    if (c.state.tray[slot] == null) continue;
    for (var row = 0; row < Board.size; row++) {
      for (var col = 0; col < Board.size; col++) {
        final cell = Cell(row, col);
        if (!c.canPlace(slot, cell)) continue;
        if (avoidClears && _wouldClear(c, slot, cell)) continue;
        c.place(slot, cell);
        return true;
      }
    }
  }
  return false;
}

/// Whether placing [slot] at [origin] completes a row or column.
bool _wouldClear(GameController c, int slot, Cell origin) {
  final piece = c.state.tray[slot];
  if (piece == null) return false;
  final filled = <Cell>{
    for (var r = 0; r < Board.size; r++)
      for (var col = 0; col < Board.size; col++)
        if (c.state.board.filledAt(r, col)) Cell(r, col),
    for (final cell in piece.cells)
      Cell(origin.row + cell.row, origin.col + cell.col),
  };
  for (var r = 0; r < Board.size; r++) {
    if (List.generate(
      Board.size,
      (col) => filled.contains(Cell(r, col)),
    ).every((f) => f)) {
      return true;
    }
  }
  for (var col = 0; col < Board.size; col++) {
    if (List.generate(
      Board.size,
      (r) => filled.contains(Cell(r, col)),
    ).every((f) => f)) {
      return true;
    }
  }
  return false;
}

/// Builds up a busy-looking board: fill without clearing for a while, so the
/// grid reads as "a real run in progress" instead of three lonely blocks.
void _buildBusyBoard(GameController c, {int moves = 14}) {
  for (var i = 0; i < moves; i++) {
    if (!_playOneMove(c, avoidClears: true)) {
      if (!_playOneMove(c)) return;
    }
  }
}

/// Plays until two clears land back to back, which lights up the combo and
/// fever indicators in the header.
void _chaseCombo(GameController c, {int maxMoves = 120}) {
  for (var i = 0; i < maxMoves; i++) {
    if (c.state.combo >= 2) return;
    // Prefer a clearing move once the board is reasonably full.
    var placed = false;
    for (var slot = 0; slot < 3 && !placed; slot++) {
      if (c.state.tray[slot] == null) continue;
      for (var row = 0; row < Board.size && !placed; row++) {
        for (var col = 0; col < Board.size && !placed; col++) {
          final cell = Cell(row, col);
          if (c.canPlace(slot, cell) && _wouldClear(c, slot, cell)) {
            c.place(slot, cell);
            placed = true;
          }
        }
      }
    }
    if (placed) continue;
    if (!_playOneMove(c, avoidClears: true) && !_playOneMove(c)) return;
  }
}

ProviderContainer _container(Storage storage) =>
    ProviderContainer(overrides: [storageProvider.overrideWithValue(storage)]);

void main() {
  setUpAll(_loadFonts);

  testWidgets('generate store screenshots', (tester) async {
    tester.view.physicalSize = _logicalSize * _pixelRatio;
    tester.view.devicePixelRatio = _pixelRatio;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // ignore: avoid_print
    print('\nRendering store screenshots into $_outDir …');

    // 1 — Endless run in progress, board comfortably filled (Classic).
    {
      final container = _container(await _seededStorage());
      final controller = container.read(gameControllerProvider.notifier);
      _buildBusyBoard(controller, moves: 16);
      await _capture(
        tester,
        '1-gameplay',
        container: container,
        screen: const GameScreen(),
      );
      container.dispose();
    }

    // 2 — Combo/fever moment, in Neon so it reads as a different mood.
    {
      final container = _container(await _seededStorage(theme: 'neon'));
      final controller = container.read(gameControllerProvider.notifier);
      _chaseCombo(controller);
      await _capture(
        tester,
        '2-combo',
        container: container,
        screen: const GameScreen(),
      );
      container.dispose();
    }

    // 3 — Daily Challenge with an active streak (Ocean).
    {
      final container = _container(await _seededStorage(theme: 'ocean'));
      final controller = container.read(gameControllerProvider.notifier);
      controller.startDaily();
      _buildBusyBoard(controller, moves: 10);
      await _capture(
        tester,
        '3-daily',
        container: container,
        screen: const GameScreen(),
      );
      container.dispose();
    }

    // 4 — Puzzle mode (Wood).
    {
      final container = _container(await _seededStorage(theme: 'wood'));
      await _capture(
        tester,
        '4-puzzle',
        container: container,
        screen: const PuzzleScreen(level: 6),
        settle: const Duration(milliseconds: 700),
      );
      container.dispose();
    }

    // 5 — Theme picker, showing the range of looks.
    {
      final container = _container(await _seededStorage(theme: 'sunset'));
      await _capture(
        tester,
        '5-themes',
        container: container,
        screen: const ThemesScreen(),
      );
      container.dispose();
    }

    // 6 — Home: best score, level, streak, the modes at a glance.
    {
      final container = _container(await _seededStorage());
      await _capture(
        tester,
        '6-home',
        container: container,
        screen: const HomeScreen(),
      );
      container.dispose();
    }

    // ignore: avoid_print
    print('\nDone. Next: python3 tool/caption_screenshots.py\n');
  });
}
