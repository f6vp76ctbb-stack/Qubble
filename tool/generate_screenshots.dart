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
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/puzzle_screen.dart';
import 'package:gridpop/ui/screens/themes_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One directory per locale. English is the primary store listing.
String _outDir(String locale) => 'store-assets/raw/$locale';

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
  // Without an emoji face the 🪙/🔥/⏱ in the copy render as empty boxes, which
  // would look like a bug in a store screenshot.
  for (final path in const [
    '/usr/share/fonts/truetype/noto/NotoColorEmoji.ttf',
    '/System/Library/Fonts/Apple Color Emoji.ttc',
  ]) {
    if (File(path).existsSync()) {
      await _loadFont('NotoColorEmoji', path);
      break;
    }
  }
}

/// A player who has clearly been at it for a while — the store should not show
/// an empty save file.
///
/// Call this before the test pumps anything: `SharedPreferences` does real
/// async work, and once a widget is mounted the test's clock no longer drives
/// it to completion. One capture per test keeps that ordering trivially true.
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
  required String locale,
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
          theme: buildGridTheme().copyWith(
            textTheme: buildGridTheme().textTheme.apply(
              fontFamilyFallback: const ['NotoColorEmoji'],
            ),
          ),
          locale: Locale(locale),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: screen,
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(settle);

  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  // Rasterizing needs the real event loop: outside runAsync the first capture
  // happens to succeed and every later one waits forever.
  final png = await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: _pixelRatio);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return bytes;
  });
  final path = '${_outDir(locale)}/$name.png';
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(png!.buffer.asUint8List());
  // ignore: avoid_print
  print('  ✓ $path');
}

/// Per-row and per-column fill counts for the current board.
///
/// Recomputed once per move so a candidate placement can be tested for "does
/// this complete a line?" in a few additions instead of rebuilding the whole
/// board — the naive version made this generator take minutes.
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

  /// Whether dropping [piece] at [origin] fills a whole row or column.
  bool completesLine(Piece piece, Cell origin) {
    final addedRows = <int, int>{};
    final addedCols = <int, int>{};
    for (final cell in piece.cells) {
      final r = origin.row + cell.row;
      final c = origin.col + cell.col;
      addedRows[r] = (addedRows[r] ?? 0) + 1;
      addedCols[c] = (addedCols[c] ?? 0) + 1;
    }
    for (final entry in addedRows.entries) {
      if (rows[entry.key] + entry.value >= Board.size) return true;
    }
    for (final entry in addedCols.entries) {
      if (cols[entry.key] + entry.value >= Board.size) return true;
    }
    return false;
  }
}

/// Plays one move.
///
/// [prefer] decides which placements are acceptable: `_Prefer.fill` refuses
/// moves that clear a line (so the board fills up and looks like a real run),
/// `_Prefer.clear` takes only clearing moves, `_Prefer.any` takes the first
/// legal one. Returns false when no matching move exists.
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

enum _Prefer { any, fill, clear }

/// Builds up a busy-looking board: fill without clearing until roughly
/// [targetFill] of the grid is occupied, so it reads as "a real run in
/// progress" instead of three lonely blocks.
///
/// Driven by how full the board actually is rather than a move count. A fixed
/// count is hostage to generator and balance tuning — it once produced a good
/// board and later ran the run all the way to Game Over, which is not what the
/// store should show.
void _buildBusyBoard(GameController c, {double targetFill = 0.45}) {
  const cells = Board.size * Board.size;
  for (var i = 0; i < 200; i++) {
    if (c.state.gameOver) return;
    var filled = 0;
    for (var r = 0; r < Board.size; r++) {
      for (var col = 0; col < Board.size; col++) {
        if (c.state.board.filledAt(r, col)) filled++;
      }
    }
    if (filled / cells >= targetFill) return;
    if (_playOneMove(c, _Prefer.fill)) continue;
    if (!_playOneMove(c, _Prefer.any)) return;
  }
}

/// Plays until two clears land back to back, which lights up the combo and
/// fever indicators in the header.
void _chaseCombo(GameController c, {int maxMoves = 80}) {
  for (var i = 0; i < maxMoves; i++) {
    if (c.state.combo >= 2 || c.state.gameOver) return;
    if (_playOneMove(c, _Prefer.clear)) continue;
    if (_playOneMove(c, _Prefer.fill)) continue;
    if (!_playOneMove(c, _Prefer.any)) return;
  }
}

ProviderContainer _container(Storage storage) =>
    ProviderContainer(overrides: [storageProvider.overrideWithValue(storage)]);

/// One screenshot: the state to seed, the screen to render, and the file stem.
class _Shot {
  const _Shot({
    required this.name,
    required this.screen,
    this.theme = kDefaultThemeId,
    this.prepare,
    this.settle = const Duration(milliseconds: 400),
  });

  /// File stem; `tool/caption_screenshots.py` maps it to a caption.
  final String name;
  final Widget screen;
  final String theme;

  /// Drives the game into the state worth showing (a filled board, a combo).
  final void Function(GameController controller)? prepare;
  final Duration settle;
}

final _shots = <_Shot>[
  // Endless run in progress, board comfortably filled (Classic).
  _Shot(
    name: '1-gameplay',
    screen: const GameScreen(),
    prepare: (c) => _buildBusyBoard(c),
  ),
  // Combo/fever moment, in Neon so it reads as a different mood.
  _Shot(
    name: '2-combo',
    screen: const GameScreen(),
    theme: 'neon',
    prepare: _chaseCombo,
  ),
  // Daily Challenge with an active streak (Ocean).
  _Shot(
    name: '3-daily',
    screen: const GameScreen(),
    theme: 'ocean',
    prepare: (c) {
      c.startDaily();
      _buildBusyBoard(c, targetFill: 0.32);
    },
  ),
  // Puzzle mode (Wood).
  const _Shot(
    name: '4-puzzle',
    screen: PuzzleScreen(level: 6),
    theme: 'wood',
    settle: Duration(milliseconds: 700),
  ),
  // Theme picker, showing the range of looks.
  const _Shot(name: '5-themes', screen: ThemesScreen(), theme: 'sunset'),
  // Home: best score, level, streak, the modes at a glance.
  const _Shot(name: '6-home', screen: HomeScreen()),
];

/// Locales to render. English first: it is the primary store listing.
const _locales = ['en', 'de'];

void main() {
  setUpAll(_loadFonts);

  // One capture per test on purpose. Seeding storage needs real async work,
  // which only completes reliably before the test mounts its first widget —
  // so each capture gets a test of its own rather than sharing a binding.
  for (final locale in _locales) {
    for (final shot in _shots) {
      testWidgets('${shot.name} ($locale)', (tester) async {
        tester.view.physicalSize = _logicalSize * _pixelRatio;
        tester.view.devicePixelRatio = _pixelRatio;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final storage = await _seededStorage(theme: shot.theme);
        final container = _container(storage);
        addTearDown(container.dispose);

        shot.prepare?.call(container.read(gameControllerProvider.notifier));

        // A Game Over overlay in a store screenshot sells the opposite of
        // what the caption promises. Fail loudly rather than ship one.
        expect(
          container.read(gameControllerProvider).gameOver,
          isFalse,
          reason: '${shot.name} ran to Game Over while being set up',
        );

        await _capture(
          tester,
          shot.name,
          container: container,
          screen: shot.screen,
          locale: locale,
          settle: shot.settle,
        );
      });
    }
  }
}
