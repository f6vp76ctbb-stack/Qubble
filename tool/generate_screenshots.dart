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

import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/accessory.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/burst_style.dart';
import 'package:gridpop/game/clear_effect.dart';
import 'package:gridpop/game/pet.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/format.dart';
import 'package:gridpop/ui/l10n_maps.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/puzzle_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:gridpop/ui/widgets/qubbie_picture.dart';
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
/// A hatched Qubbie that plays along, with [xp] experience — the way a player
/// has it who chose the free starter and (for any other) bought this one.
PetState _petState(String id, {int xp = 0}) {
  var pets = PetState.empty.chooseStarter('kiki').addLines(10);
  pets = pets.hatchReady().state;
  if (id != 'kiki') {
    pets = pets.addBoughtEgg(id)!.addLines(PetRules.boughtEggLines);
    pets = pets.hatchReady().state.withActive(id);
  }
  return pets.addLines(xp);
}

Future<Storage> _seededStorage({
  String theme = kDefaultThemeId,
  String skin = kDefaultSkinId,
  String accessory = kNoAccessoryId,
  String burst = kDefaultBurstId,
  String clearEffect = kDefaultClearEffectId,
  String? pet,
  int petXp = 0,
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
  // The look on show is one the player owns, as it would be in the app.
  await storage.addUnlockedTheme(theme);
  await storage.addUnlockedSkin(skin);
  await storage.setActiveTheme(theme);
  await storage.setActiveSkin(skin);
  await storage.setUnlockedCosmetics('accessory', {accessory});
  await storage.setActiveCosmetic('accessory', accessory);
  await storage.setUnlockedCosmetics('burst', {burst});
  await storage.setActiveCosmetic('burst', burst);
  await storage.setUnlockedCosmetics('clearEffect', {clearEffect});
  await storage.setActiveCosmetic('clearEffect', clearEffect);
  if (pet != null) await storage.setPets(_petState(pet, xp: petXp));
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
  void Function()? act,
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
          locale: localeFromCode(locale),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: screen,
        ),
      ),
    ),
  );
  await tester.pump();
  if (act == null) {
    await tester.pump(settle);
  } else {
    // Let the screen finish laying out first: a move played into a
    // mid-entrance tree lands its burst off the board.
    await tester.pump(const Duration(milliseconds: 350));
    act();
    await tester.pump();
    await tester.pump(settle);
  }

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

  // Where the board sits, in capture pixels. The compositor crops to it, and
  // the board is not the same size on every screen — the Daily Challenge hides
  // the booster bar and gets a bigger one — so measuring it here beats
  // guessing from the image later.
  final board = find.byType(BoardView);
  if (board.evaluate().isNotEmpty) {
    final box = tester.renderObject<RenderBox>(board.first);
    final origin = box.localToGlobal(Offset.zero);
    final rect = {
      'x': (origin.dx * _pixelRatio).round(),
      'y': (origin.dy * _pixelRatio).round(),
      'w': (box.size.width * _pixelRatio).round(),
      'h': (box.size.height * _pixelRatio).round(),
    };
    File('${_outDir(locale)}/$name.json').writeAsStringSync(jsonEncode(rect));
  }
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

  /// How many rows and columns dropping [piece] at [origin] would clear.
  int linesCleared(Piece piece, Cell origin) {
    final addedRows = <int, int>{};
    final addedCols = <int, int>{};
    for (final cell in piece.cells) {
      final r = origin.row + cell.row;
      final c = origin.col + cell.col;
      addedRows[r] = (addedRows[r] ?? 0) + 1;
      addedCols[c] = (addedCols[c] ?? 0) + 1;
    }
    var lines = 0;
    for (final entry in addedRows.entries) {
      if (rows[entry.key] + entry.value >= Board.size) lines++;
    }
    for (final entry in addedCols.entries) {
      if (cols[entry.key] + entry.value >= Board.size) lines++;
    }
    return lines;
  }

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
  for (var i = 0; i < 200; i++) {
    if (c.state.gameOver) return;
    if (_fillRatio(c) >= targetFill) return;
    if (_playOneMove(c, _Prefer.fill)) continue;
    if (!_playOneMove(c, _Prefer.any)) return;
  }
}

double _fillRatio(GameController c) {
  var filled = 0;
  for (var r = 0; r < Board.size; r++) {
    for (var col = 0; col < Board.size; col++) {
      if (c.state.board.filledAt(r, col)) filled++;
    }
  }
  return filled / (Board.size * Board.size);
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

/// Plays on until the tray has just refilled.
///
/// A capture taken mid-round shows one lonely piece next to two empty slots,
/// which reads as a broken screen rather than a game in progress.
void _settleOnFullTray(GameController c, {int maxMoves = 12}) {
  for (var i = 0; i < maxMoves; i++) {
    if (c.state.tray.every((p) => p != null)) return;
    if (_playOneMove(c, _Prefer.fill)) continue;
    if (!_playOneMove(c, _Prefer.any)) return;
  }
}

/// The placement that clears the most lines, left unplayed.
///
/// The whole point of the hero shots is the clear itself — the particle burst,
/// the floating score, the shake. Those are driven by `clearEventId`, so the
/// move has to happen *after* the widget is mounted or the effect layers never
/// see the change. This finds the move; the test plays it on the live tree.
({int slot, Cell cell, int lines})? _bestClearingMove(GameController c) {
  final counts = _LineCounts(c.state.board);
  ({int slot, Cell cell, int lines})? best;
  for (var slot = 0; slot < 3; slot++) {
    final piece = c.state.tray[slot];
    if (piece == null) continue;
    for (var row = 0; row < Board.size; row++) {
      for (var col = 0; col < Board.size; col++) {
        final cell = Cell(row, col);
        if (!c.canPlace(slot, cell)) continue;
        final lines = counts.linesCleared(piece, cell);
        if (lines > (best?.lines ?? 0)) {
          best = (slot: slot, cell: cell, lines: lines);
        }
      }
    }
  }
  return best;
}

/// Plays one seed through to a dense board and reports the clear it leaves
/// available, or null if that seed is unusable.
({int slot, Cell cell, int lines})? _stageSeed(
  GameController c,
  int seed, {
  required double fill,
  required bool combo,
}) {
  c.newGame(seed: seed);
  if (combo) _chaseCombo(c);
  _buildBusyBoard(c, targetFill: fill);
  _settleOnFullTray(c);
  if (c.state.gameOver) return null;
  if (combo && c.state.combo < 2) return null;
  return _bestClearingMove(c);
}

/// A clear of exactly one row somewhere in the middle of the board, waiting
/// to be triggered: the line a Qubbie flies along in the opening frame. A row
/// rather than a column, because the frame is read left to right; one line,
/// so nothing else on the board goes off at the same time; rows two to five,
/// so the flight sits where the eye lands.
({int slot, Cell cell, int lines})? _armRowClear(
  GameController c, {
  double fill = 0.62,
  int seeds = 400,
}) {
  for (var seed = 1; seed <= seeds; seed++) {
    c.newGame(seed: seed);
    _buildBusyBoard(c, targetFill: fill);
    _settleOnFullTray(c);
    if (c.state.gameOver) continue;
    final counts = _LineCounts(c.state.board);
    for (var slot = 0; slot < 3; slot++) {
      final piece = c.state.tray[slot];
      if (piece == null) continue;
      for (var row = 0; row < Board.size; row++) {
        for (var col = 0; col < Board.size; col++) {
          final cell = Cell(row, col);
          if (!c.canPlace(slot, cell)) continue;
          if (counts.linesCleared(piece, cell) != 1) continue;
          // Which row does it fill?
          final added = <int, int>{};
          for (final part in piece.cells) {
            added[row + part.row] = (added[row + part.row] ?? 0) + 1;
          }
          final full = [
            for (final e in added.entries)
              if (counts.rows[e.key] + e.value >= Board.size) e.key,
          ];
          if (full.length == 1 && full.single >= 2 && full.single <= 5) {
            return (slot: slot, cell: cell, lines: 1);
          }
        }
      }
    }
  }
  return null;
}

/// Fills the board and hands back a big clear waiting to be triggered.
///
/// Filling without ever clearing leaves every row one cell short, and only the
/// rare `dot` piece can close a gap like that — so simply packing the board
/// and hoping usually arms nothing. The piece generator is seedable, so walk
/// seeds instead until one produces a position with a real clear, preferring a
/// double. Deterministic: the same range always picks the same seed, which is
/// what the file's promise of reproducible output actually requires.
({int slot, Cell cell, int lines})? _armBigClear(
  GameController c, {
  double fill = 0.6,
  bool combo = false,
  int seeds = 120,
}) {
  int? bestSeed;
  var bestLines = 0;
  for (var seed = 1; seed <= seeds; seed++) {
    final move = _stageSeed(c, seed, fill: fill, combo: combo);
    if (move == null) continue;
    if (move.lines > bestLines) {
      bestLines = move.lines;
      bestSeed = seed;
    }
    if (bestLines >= 2) break;
  }
  if (bestSeed == null) return null;
  return _stageSeed(c, bestSeed, fill: fill, combo: combo);
}

/// A Wednesday. Date-based rules follow the calendar the game reads, and on a
/// weekend the home screen shows the double-coins banner — a set rendered on a
/// Saturday would not match one rendered on a Monday.
final _renderDay = DateTime(2026, 3, 11);

ProviderContainer _container(Storage storage) => ProviderContainer(
  overrides: [
    storageProvider.overrideWithValue(storage),
    gameCalendarProvider.overrideWithValue(() => _renderDay),
  ],
);

/// One screenshot: the state to seed, the screen to render, and the file stem.
class _Shot {
  const _Shot({
    required this.name,
    required this.screen,
    this.theme = kDefaultThemeId,
    this.skin = kDefaultSkinId,
    this.accessory = kNoAccessoryId,
    this.burst = kDefaultBurstId,
    this.clearEffect = kDefaultClearEffectId,
    this.pet,
    this.petXp = 0,
    this.stage,
    this.arm,
    this.settle = const Duration(milliseconds: 400),
  });

  /// File stem; `tool/caption_screenshots.py` maps it to a caption and a crop.
  final String name;
  final Widget screen;
  final String theme;
  final String skin;
  final String accessory;
  final String burst;

  /// The row effect the player has equipped. A starter Qubbie flies with it;
  /// the others bring their own.
  final String clearEffect;

  /// The Qubbie that plays along, and how far it has grown.
  final String? pet;
  final int petXp;

  /// Drives the game into the state worth showing, before the widget mounts.
  final void Function(GameController controller)? stage;

  /// Picks the move to play *after* mounting, so the clear animates on screen.
  /// Returning null fails the shot — see [_armBigClear].
  final ({int slot, Cell cell, int lines})? Function(GameController controller)?
  arm;

  /// How far to advance the clock after the armed move. The burst peaks early:
  /// past ~250 ms the particles have faded and the capture is static again.
  final Duration settle;
}

/// When to capture the clear animation. Measured against `ClearBurst`, whose
/// particles launch on the clear event and fade out over roughly half a second.
///
/// This was 150 ms, which is the burst at its densest — and dense enough that
/// the particles covered the board and hid the very thing the caption promises,
/// a row going away. The score popup was half-covered too. At 300 ms the
/// particles have thrown outward far enough to read as motion around the board
/// rather than a veil over it, while the cleared row is plainly empty.
///
/// The old note here estimated the particles had faded by ~250 ms. They have
/// not; they are still clearly visible at 300, which is what makes this the
/// better frame rather than a compromise.
const Duration _burstPeak = Duration(milliseconds: 300);

/// When the Qubbie is caught in the air: a little later than the burst, so
/// it is past the middle of the row with the effect still burning behind it.
const Duration _flightPeak = Duration(milliseconds: 330);

final _shots = <_Shot>[
  // The opener (owner, 09.11.2026: the pets are what sets the game apart, and
  // they go on the pictures). The grown dragon flies along a row it is
  // burning away. The default theme, because this is the frame that has to
  // look like the game's own icon and name.
  _Shot(
    name: 'qubbie',
    screen: const GameScreen(),
    skin: 'glossy',
    burst: 'fire',
    pet: 'funki',
    petXp: PetRules.stage3Xp + 40,
    arm: _armRowClear,
    settle: _flightPeak,
  ),
  // The clear, in a look that is not the default one (owner, 02.10.2026: the
  // design options come first) — candy, jelly blocks and the confetti
  // explosion. Dense board, biggest available clear going off, full tray.
  // The free starter is along, as it is for every player from run four on.
  _Shot(
    name: 'clear',
    screen: const GameScreen(),
    theme: 'candy',
    skin: 'jelly',
    burst: 'confetti',
    pet: 'kiki',
    petXp: PetRules.stage3Xp + 40,
    arm: _armBigClear,
    settle: _burstPeak,
  ),
  // Daily Challenge. Hides the booster bar on its own, so this frame is the
  // app's cleanest real composition; the Qubbie sits on the board's edge.
  _Shot(
    name: 'daily',
    screen: const GameScreen(),
    theme: 'glacier',
    skin: 'glossy',
    pet: 'frosti',
    petXp: PetRules.stage2Xp + 20,
    stage: (c) {
      // A fixed date, not today's: the Daily seed is derived from the calendar,
      // so without this the frame is a different board on every run and the
      // file's promise of reproducible output is a fiction.
      c.startDaily(now: DateTime.utc(2026, 3, 14));
      // Clear a few lines before packing the board. Filling without ever
      // clearing leaves SCORE at almost nothing, which reads badly next to a
      // BEST of 18,740 in the same header.
      _chaseCombo(c);
      _buildBusyBoard(c, targetFill: 0.5);
      _settleOnFullTray(c);
    },
  ),
  // Puzzle mode (Wood).
  const _Shot(
    name: 'puzzle',
    screen: PuzzleScreen(level: 6),
    theme: 'wood',
    settle: Duration(milliseconds: 700),
  ),
  // Home: best score, level, streak, the modes at a glance — and the Qubbie
  // on the play button.
  const _Shot(
    name: 'home',
    screen: HomeScreen(),
    pet: 'funki',
    petXp: PetRules.stage3Xp + 40,
  ),
];

/// One board in one look, no text: the tiles of the design frames.
typedef _Tile = ({String name, String theme, String skin, String accessory});

/// Board-only captures for the design frames: every skin on the same theme,
/// and a set of full looks. Each is a real board in that look;
/// `caption_screenshots.py` crops and tiles the ones it uses.
final List<_Tile> _tiles = [
  for (final skin in kSkinCatalog)
    (
      name: 'skin-${skin.id}',
      theme: 'classic',
      skin: skin.id,
      accessory: kNoAccessoryId,
    ),
  ..._looks,
];

/// Whole looks — theme, skin and accessory together — for the mosaic that
/// opens the gallery. Nothing seasonal: a Halloween design is for sale in
/// October only, and a store image should not promise it in March.
const List<_Tile> _looks = [
  (name: 'look-1', theme: 'classic', skin: 'glossy', accessory: 'sparkle'),
  (name: 'look-2', theme: 'neon', skin: 'glow', accessory: kNoAccessoryId),
  (name: 'look-3', theme: 'candy', skin: 'jelly', accessory: 'flower'),
  (name: 'look-4', theme: 'volcano', skin: 'ember', accessory: kNoAccessoryId),
  (name: 'look-5', theme: 'glacier', skin: 'marble', accessory: 'snowCap'),
  (name: 'look-6', theme: 'wood', skin: 'bevel', accessory: 'dewdrop'),
  (name: 'look-7', theme: 'ocean', skin: 'wave', accessory: kNoAccessoryId),
  (name: 'look-8', theme: 'sunset', skin: 'prism', accessory: 'crown'),
  (name: 'look-9', theme: 'forest', skin: 'pixel', accessory: kNoAccessoryId),
];

/// What the design frames count and name, per locale: the catalog sizes, so
/// a caption never claims a number the app does not have, and the names the
/// app itself shows, so a label under a tile matches the Designs screen.
Map<String, Object> _designFacts(String locale) {
  final l10n = lookupL10n(localeFromCode(locale));
  // Counted without the seasonal designs: a number in a store image is a
  // promise, and a Halloween design is for sale one month a year. These are
  // the numbers the listing text gives as well (test/store_listing_test.dart).
  final themes = kThemeCatalog.where((t) => t.saleMonth == null).toList();
  final skins = kSkinCatalog.where((s) => s.saleMonth == null).toList();
  return {
    'counts': {
      'themes': themes.length,
      'skins': skins.length,
      'animated': skins.where((s) => s.style.isAnimated).length,
      'accessories': kAccessoryCatalog
          .where((a) => a.id != kNoAccessoryId)
          .length,
      'bursts': kBurstCatalog.length,
      'pets': kPetCatalog.length,
      'firstEggAfterRuns': PetRules.firstEggAfterRuns,
    },
    'themes': {for (final e in kThemeCatalog) e.id: themeName(l10n, e.id)},
    'skins': {for (final s in kSkinCatalog) s.id: skinName(l10n, s.id)},
    'accessories': {
      for (final a in kAccessoryCatalog) a.id: accessoryName(l10n, a.id),
    },
    'bursts': {for (final b in kBurstCatalog) b.id: burstName(l10n, b.id)},
    'pets': {for (final pet in kPetCatalog) pet.id: petName(l10n, pet.id)},
    // What the nest says under a Qubbie, in the app's own words: the line a
    // frame puts next to the one it shows large.
    'petLines': {
      for (final pet in kPetCatalog)
        pet.id: pet.signature == null
            ? l10n.petEffectYours
            : l10n.petEffectOwn,
    },
    // The Designs screen's own tab labels, for the counts under the mosaic.
    'tabs': {
      'themes': l10n.themesTitle,
      'skins': l10n.skinsTitle,
      'accessories': l10n.designsAccessories,
      'bursts': l10n.designsBursts,
    },
  };
}

/// Locales to render: the four store listings kept by hand (owner,
/// 09.11.2026). English first: it is the primary listing.
const _locales = ['en', 'de', 'es', 'pt'];

void main() {
  // As the app's main does: 0–9 in every language.
  setUpAll(useLatinDigits);
  setUpAll(_loadFonts);

  // QUBBLE_LOCALES=en,de renders only those languages; the design tiles are
  // English only and always come along.
  final only = Platform.environment['QUBBLE_LOCALES'];
  final locales = only == null || only.isEmpty ? _locales : only.split(',');

  // One capture per test on purpose. Seeding storage needs real async work,
  // which only completes reliably before the test mounts its first widget —
  // so each capture gets a test of its own rather than sharing a binding.
  for (final locale in locales) {
    test('design facts ($locale)', () {
      File('${_outDir(locale)}/designs.json')
        ..createSync(recursive: true)
        ..writeAsStringSync(
          const JsonEncoder.withIndent('  ').convert(_designFacts(locale)),
        );
    });
    for (final shot in _shots) {
      testWidgets('${shot.name} ($locale)', (tester) async {
        tester.view.physicalSize = _logicalSize * _pixelRatio;
        tester.view.devicePixelRatio = _pixelRatio;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final storage = await _seededStorage(
          theme: shot.theme,
          skin: shot.skin,
          accessory: shot.accessory,
          burst: shot.burst,
          clearEffect: shot.clearEffect,
          pet: shot.pet,
          petXp: shot.petXp,
        );
        final container = _container(storage);
        addTearDown(container.dispose);

        final controller = container.read(gameControllerProvider.notifier);
        shot.stage?.call(controller);

        ({int slot, Cell cell, int lines})? armed;
        if (shot.arm != null) {
          armed = shot.arm!(controller);
          expect(
            armed,
            isNotNull,
            reason: '${shot.name}: no clearing move to show',
          );
        }

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
          act: armed == null
              ? null
              : () => controller.place(armed!.slot, armed.cell),
        );
      });
    }
  }

  // The Qubbies, one portrait each, fully grown: the tiles of the roster
  // frame. Drawn by the app's own painter, on nothing — the frame gives them
  // their card.
  for (final pet in kPetCatalog) {
    testWidgets('pet-${pet.id}', (tester) async {
      const side = 300.0;
      tester.view.physicalSize = const Size(side, side) * _pixelRatio;
      tester.view.devicePixelRatio = _pixelRatio;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final key = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: QubbiePicture(species: pet.species, width: side * 0.92),
            ),
          ),
        ),
      );
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final png = await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: _pixelRatio);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        image.dispose();
        return bytes;
      });
      final path = '${_outDir('en')}/pet-${pet.id}.png';
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(png!.buffer.asUint8List());
      // ignore: avoid_print
      print('  ✓ $path');
    });
  }

  // The design tiles: English only, since the board carries no text.
  for (final tile in _tiles) {
    testWidgets(tile.name, (tester) async {
      tester.view.physicalSize = _logicalSize * _pixelRatio;
      tester.view.devicePixelRatio = _pixelRatio;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final storage = await _seededStorage(
        theme: tile.theme,
        skin: tile.skin,
        accessory: tile.accessory,
      );
      final container = _container(storage);
      addTearDown(container.dispose);

      final controller = container.read(gameControllerProvider.notifier);
      // Seeded: without this the tile is a fresh random run every time, which
      // is how one of them arrived at Game Over.
      controller.newGame(seed: 7);
      _buildBusyBoard(controller, targetFill: 0.5);
      _settleOnFullTray(controller);
      expect(container.read(gameControllerProvider).gameOver, isFalse);

      await _capture(
        tester,
        tile.name,
        container: container,
        screen: const GameScreen(),
        locale: 'en',
      );
    });
  }
}
