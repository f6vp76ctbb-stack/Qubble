/// Renders the store promo (owner, 15.11.2026: "ein perfektes Playstore-Video
/// zur Vorstellung … schnell, schnell alles zeigen, paar Designs"): a fast cut
/// of line clears in many looks, opened and closed by a multi-line combo, with
/// three glimpses of the menus in between — the home screen, the Qubbies and
/// a theme being switched on the designs screen.
///
/// Not a test; run it explicitly, once per store language:
///
/// ```bash
/// QUBBLE_PROMO_LOCALE=de flutter test tool/generate_promo.dart
/// python3 tool/encode_video.py promo-de   # -> store-assets/video/qubble-promo-de.mp4
/// ```
///
/// What Google asks of a preview video (Play Console Help, "Add preview
/// assets to showcase your app", read 15.11.2026) and how this cut answers it:
///
/// * "Show the actual in-app or in-game experience … within the first 10
///   seconds" — the first frame is the game.
/// * "Aim for at least 80% of the video to be representative of the user
///   experience" — everything before the end card is the real app; the end
///   card is about a sixth.
/// * "only the first 30 seconds autoplays" — the whole clip is shorter.
/// * "Do not include people interacting with the device" — no touch dot.
/// * "Properly localize the video including the UI" — the menus show text,
///   so there is one render per store language (en, de, es, pt).
///
/// Like tool/generate_showreel.dart, everything on screen is the app: the
/// real screens, pieces moved with real drag gestures, themes switched with
/// real taps, and the sounds the game asked for on the frame it asked.
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
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/burst_style.dart';
import 'package:gridpop/game/clear_effect.dart';
import 'package:gridpop/game/coach_hints.dart';
import 'package:gridpop/game/pet.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/qubbies_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:gridpop/ui/widgets/piece_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String _locale = Platform.environment['QUBBLE_PROMO_LOCALE'] ?? 'en';
String get _root => 'build/video/promo-$_locale';

/// Portrait phone at 3x: 1080x1920 frames.
const Size _logicalSize = Size(360, 640);
const double _pixelRatio = 3;

const int _fps = 30;
const Duration _frame = Duration(microseconds: 1000000 ~/ _fps);

typedef _Look = ({
  String theme,
  String skin,
  String burst,
  String clearEffect,
  String accessory,
  String pet,
  int stage,
});

enum _Kind {
  /// One row cleared: the quick cut between looks.
  clear,

  /// Two or more lines at once: the opening hook and the finale.
  combo,

  /// The main menu as it greets a player.
  home,

  /// The Qubbies, with a tap that makes the one on stage hop.
  qubbies,

  /// The designs screen; two taps switch the theme, and the whole screen
  /// takes it on.
  designs,
}

typedef _Shot = ({_Kind kind, _Look look});

/// The cut list. Every look is one a player can have all year: nothing
/// seasonal and not the supporter-only theme — a clip should not advertise
/// what most players cannot get.
const List<_Shot> _shots = [
  (
    kind: _Kind.combo,
    look: (
      theme: 'neon',
      skin: 'glow',
      burst: 'stars',
      clearEffect: 'laser',
      accessory: 'none',
      pet: 'zapp',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'classic',
      skin: 'glossy',
      burst: 'fire',
      clearEffect: 'classic',
      accessory: 'none',
      pet: 'funki',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'candy',
      skin: 'jelly',
      burst: 'confetti',
      clearEffect: 'classic',
      accessory: 'flower',
      pet: 'kiki',
      stage: 2,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'glacier',
      skin: 'marble',
      burst: 'bubbles',
      clearEffect: 'frost',
      accessory: 'snowCap',
      pet: 'frosti',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.home,
    look: (
      theme: 'classic',
      skin: 'glossy',
      burst: 'confetti',
      clearEffect: 'classic',
      accessory: 'none',
      pet: 'funki',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'volcano',
      skin: 'ember',
      burst: 'fire',
      clearEffect: 'blaze',
      accessory: 'none',
      pet: 'pyra',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'ocean',
      skin: 'wave',
      burst: 'bubbles',
      clearEffect: 'classic',
      accessory: 'dewdrop',
      pet: 'glim',
      stage: 2,
    ),
  ),
  (
    kind: _Kind.qubbies,
    look: (
      theme: 'sunset',
      skin: 'prism',
      burst: 'stars',
      clearEffect: 'classic',
      accessory: 'crown',
      pet: 'prisma',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'sunset',
      skin: 'prism',
      burst: 'stars',
      clearEffect: 'classic',
      accessory: 'crown',
      pet: 'prisma',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'wood',
      skin: 'bevel',
      burst: 'pixels',
      clearEffect: 'lightning',
      accessory: 'none',
      pet: 'bit',
      stage: 2,
    ),
  ),
  (
    kind: _Kind.designs,
    look: (
      theme: 'forest',
      skin: 'pixel',
      burst: 'confetti',
      clearEffect: 'classic',
      accessory: 'none',
      pet: 'optik',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.clear,
    look: (
      theme: 'fade',
      skin: 'crystal',
      burst: 'stars',
      clearEffect: 'frost',
      accessory: 'sparkle',
      pet: 'kiki',
      stage: 3,
    ),
  ),
  (
    kind: _Kind.combo,
    look: (
      theme: 'classic',
      skin: 'stardust',
      burst: 'confetti',
      clearEffect: 'blaze',
      accessory: 'crown',
      pet: 'glim',
      stage: 3,
    ),
  ),
];

/// The Qubbies the Qubbies shot puts on stage, in order.
const List<String> _qubbieTaps = ['zapp', 'frosti'];

/// The themes the designs shot switches to, in order.
const List<String> _designTaps = ['neon', 'sunset'];

// --- Sound recording -------------------------------------------------------

int _currentFrame = 0;

class _Event {
  _Event(this.frame, this.sfx, this.pitch);
  final int frame;
  final Sfx sfx;
  final double pitch;
  Map<String, Object> toJson() => {
    'frame': frame,
    'sfx': sfx.name,
    'pitch': pitch,
  };
}

/// Stands in for the game's audio: remembers what was played, and when.
class _RecordingAudio implements AudioService {
  final events = <_Event>[];

  @override
  bool enabled = true;

  @override
  void play(Sfx sfx, {double pitch = 1.0}) {
    events.add(_Event(_currentFrame, sfx, pitch));
  }
}

// --- Fonts (same set the screenshot generator loads) -----------------------

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

// --- Staging ---------------------------------------------------------------

/// The demo profile of the store screenshots, in this shot's look: a player
/// a few weeks in, with a small flock of Qubbies and some designs unlocked.
Future<Storage> _seededStorage(_Look look) async {
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
  await storage.setOnboardingDone(true);
  for (final hint in CoachHintType.values) {
    await storage.markCoachHintSeen(hint);
  }
  for (final id in {look.theme, ..._designTaps, 'fade', 'ocean', 'sunset'}) {
    await storage.addUnlockedTheme(id);
  }
  await storage.setActiveTheme(look.theme);
  await storage.addUnlockedSkin(look.skin);
  await storage.setActiveSkin(look.skin);
  await storage.setUnlockedCosmetics('accessory', {look.accessory});
  await storage.setActiveCosmetic('accessory', look.accessory);
  await storage.setUnlockedCosmetics('burst', {look.burst});
  await storage.setActiveCosmetic('burst', look.burst);
  await storage.setUnlockedCosmetics('clearEffect', {look.clearEffect});
  await storage.setActiveCosmetic('clearEffect', look.clearEffect);

  // The starter plus three hatched friends, so the Qubbies screen is not a
  // lone figure; the shot's own Qubbie is the one playing along.
  var pets = PetState.empty.chooseStarter('kiki').addLines(10);
  pets = pets.hatchReady().state;
  for (final id in {'frosti', 'zapp', 'funki', look.pet}..remove('kiki')) {
    pets = pets.addBoughtEgg(id)!.addLines(PetRules.boughtEggLines);
    pets = pets.hatchReady().state;
  }
  pets = pets.withActive(look.pet);
  final xp = switch (look.stage) {
    3 => PetRules.stage3Xp + 40,
    2 => PetRules.stage2Xp + 20,
    _ => 0,
  };
  await storage.setPets(pets.addLines(xp));
  return storage;
}

/// Per-row and per-column fill counts of a board.
class _Lines {
  _Lines(Board board)
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

  /// The rows and columns that dropping [piece] at [origin] would fill.
  ({List<int> rows, List<int> cols}) completed(Piece piece, Cell origin) {
    final addedRows = <int, int>{};
    final addedCols = <int, int>{};
    for (final cell in piece.cells) {
      final r = origin.row + cell.row;
      final c = origin.col + cell.col;
      addedRows[r] = (addedRows[r] ?? 0) + 1;
      addedCols[c] = (addedCols[c] ?? 0) + 1;
    }
    return (
      rows: [
        for (final e in addedRows.entries)
          if (rows[e.key] + e.value >= Board.size) e.key,
      ],
      cols: [
        for (final e in addedCols.entries)
          if (cols[e.key] + e.value >= Board.size) e.key,
      ],
    );
  }
}

/// Plays one move that fills the board without clearing; false if none.
bool _fillOne(GameController c) {
  final lines = _Lines(c.state.board);
  for (var slot = 0; slot < 3; slot++) {
    final piece = c.state.tray[slot];
    if (piece == null) continue;
    for (var row = 0; row < Board.size; row++) {
      for (var col = 0; col < Board.size; col++) {
        final cell = Cell(row, col);
        if (!c.canPlace(slot, cell)) continue;
        final done = lines.completed(piece, cell);
        if (done.rows.isNotEmpty || done.cols.isNotEmpty) continue;
        c.place(slot, cell);
        return true;
      }
    }
  }
  return false;
}

double _fill(GameController c) {
  var filled = 0;
  for (var r = 0; r < Board.size; r++) {
    for (var col = 0; col < Board.size; col++) {
      if (c.state.board.filledAt(r, col)) filled++;
    }
  }
  return filled / (Board.size * Board.size);
}

/// Stages a busy board with a full tray and returns a move that clears: one
/// row in the middle of the board for [_Kind.clear], two or more lines at
/// once for [_Kind.combo]. Seeds are walked from [firstSeed], so every shot
/// is a different game.
({int slot, Cell cell})? _arm(GameController c, int firstSeed, _Kind kind) {
  final combo = kind == _Kind.combo;
  for (var seed = firstSeed; seed < firstSeed + 600; seed++) {
    c.newGame(seed: seed);
    final target = combo ? 0.66 : 0.6;
    for (var i = 0; i < 200 && _fill(c) < target && !c.state.gameOver; i++) {
      if (!_fillOne(c)) break;
    }
    for (var i = 0; i < 12 && c.state.tray.any((p) => p == null); i++) {
      if (!_fillOne(c)) break;
    }
    if (c.state.gameOver || c.state.tray.any((p) => p == null)) continue;
    final lines = _Lines(c.state.board);
    for (var slot = 0; slot < 3; slot++) {
      final piece = c.state.tray[slot]!;
      for (var row = 0; row < Board.size; row++) {
        for (var col = 0; col < Board.size; col++) {
          final cell = Cell(row, col);
          if (!c.canPlace(slot, cell)) continue;
          final done = lines.completed(piece, cell);
          final count = done.rows.length + done.cols.length;
          final fits = combo
              ? count >= 2
              : done.cols.isEmpty &&
                    done.rows.length == 1 &&
                    done.rows.single >= 2 &&
                    done.rows.single <= 5;
          if (fits) return (slot: slot, cell: cell);
        }
      }
    }
  }
  return null;
}

/// A Wednesday in March: no weekend banner, nothing seasonal.
final _renderDay = DateTime(2026, 3, 11);

Widget _app(ProviderContainer container, Widget home) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildGridTheme().copyWith(
        textTheme: buildGridTheme().textTheme.apply(
          fontFamilyFallback: const ['NotoColorEmoji'],
        ),
      ),
      locale: localeFromCode(_locale),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: home,
    ),
  );
}

void main() {
  setUpAll(_loadFonts);

  for (var index = 0; index < _shots.length; index++) {
    final shot = _shots[index];
    final look = shot.look;
    final number = (index + 1).toString().padLeft(2, '0');
    testWidgets('shot $number: ${shot.kind.name} in ${look.theme}', (
      tester,
    ) async {
      tester.view.physicalSize = _logicalSize * _pixelRatio;
      tester.view.devicePixelRatio = _pixelRatio;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // The looks in the cut list must exist: a typo would silently fall
      // back to the default and the clip would show the same thing twice.
      expect(kThemeCatalog.map((t) => t.id), contains(look.theme));
      expect(kBurstCatalog.map((b) => b.id), contains(look.burst));
      expect(kClearEffectCatalog.map((e) => e.id), contains(look.clearEffect));
      expect(kAccessoryCatalog.map((a) => a.id), contains(look.accessory));
      expect(petById(look.pet), isNotNull);

      final storage = await _seededStorage(look);
      final audio = _RecordingAudio();
      final container = ProviderContainer(
        overrides: [
          storageProvider.overrideWithValue(storage),
          audioProvider.overrideWithValue(audio),
          gameCalendarProvider.overrideWithValue(() => _renderDay),
        ],
      );
      addTearDown(container.dispose);
      final controller = container.read(gameControllerProvider.notifier);
      final playing = shot.kind == _Kind.clear || shot.kind == _Kind.combo;
      final move = playing
          ? _arm(controller, 1 + index * 601, shot.kind)
          : null;
      if (playing) {
        expect(move, isNotNull, reason: 'no move to stage shot $number');
      }
      audio.events.clear();

      final key = GlobalKey();
      final screen = switch (shot.kind) {
        _Kind.clear || _Kind.combo => const GameScreen(),
        _Kind.home => const HomeScreen(),
        _Kind.qubbies => const QubbiesScreen(),
        _Kind.designs => const DesignsScreen(),
      };
      await tester.pumpWidget(
        RepaintBoundary(key: key, child: _app(container, screen)),
      );
      await tester.pump(const Duration(milliseconds: 500));

      final outDir = '$_root/scene-$number';
      final dir = Directory(outDir);
      if (dir.existsSync()) dir.deleteSync(recursive: true);
      dir.createSync(recursive: true);
      _currentFrame = 0;

      Future<void> snap() async {
        final boundary =
            key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final png = await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: _pixelRatio);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          image.dispose();
          return bytes;
        });
        final name = 'frame_${(_currentFrame + 1).toString().padLeft(5, '0')}';
        File('$outDir/$name.png').writeAsBytesSync(png!.buffer.asUint8List());
        _currentFrame++;
      }

      Future<void> tick([int frames = 1]) async {
        for (var i = 0; i < frames; i++) {
          await tester.pump(_frame);
          await snap();
        }
      }

      switch (shot.kind) {
        case _Kind.clear || _Kind.combo:
          final combo = shot.kind == _Kind.combo;
          final boardBox = find.descendant(
            of: find.byType(BoardView),
            matching: find.byWidgetPredicate((w) => w.key is GlobalKey),
          );
          final board = tester.getRect(boardBox.first);
          final cell = board.width / Board.size;
          final piece = controller.state.tray[move!.slot]!;
          final draggable = find.byWidgetPredicate(
            (w) => w is Draggable<int> && w.data == move.slot,
          );
          final start = tester.getCenter(
            find
                .descendant(of: draggable, matching: find.byType(PieceView))
                .first,
          );
          // Where the finger has to be for the piece to land on the target
          // cell: the tray holds the piece kFingerLiftCells above it.
          final end =
              board.topLeft +
              Offset(
                move.cell.col * cell + piece.width * cell / 2,
                move.cell.row * cell +
                    piece.height * cell / 2 +
                    kFingerLiftCells * cell,
              );
          await snap();
          await tick(combo ? 3 : 2);
          final gesture = await tester.startGesture(start);
          final steps = combo ? 8 : 7;
          for (var i = 1; i <= steps; i++) {
            await gesture.moveTo(
              Offset.lerp(
                start,
                end,
                Curves.easeInOutCubic.transform(i / steps),
              )!,
            );
            await tick();
          }
          await tick();
          final clearsBefore = controller.state.clearEventId;
          await gesture.up();
          // The Qubbie's flight takes 600 ms; a combo gets its badge and
          // the bigger burst played out.
          await tick(combo ? 32 : 18);
          expect(
            controller.state.clearEventId,
            isNot(clearsBefore),
            reason: 'shot $number: the drop cleared nothing',
          );
          expect(controller.state.gameOver, isFalse);
        case _Kind.home:
          await snap();
          await tick(29);
        case _Kind.qubbies:
          await snap();
          await tick(7);
          // A tap on a card puts that Qubbie on stage, with a hop.
          for (final id in _qubbieTaps) {
            final card = find.byKey(ValueKey('pet-card-$id'));
            expect(card, findsOneWidget, reason: 'Qubbie $id on the list');
            await tester.tap(card, warnIfMissed: false);
            await tick(12);
          }
        case _Kind.designs:
          await snap();
          await tick(9);
          for (final id in _designTaps) {
            final tile = find.byKey(ValueKey('theme-$id'));
            expect(tile, findsOneWidget, reason: 'theme $id on the grid');
            await tester.tap(tile, warnIfMissed: false);
            await tick(14);
          }
      }

      File('$outDir/events.json').writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert({
          'fps': _fps,
          'frames': _currentFrame,
          'events': [for (final e in audio.events) e.toJson()],
        }),
      );
      // ignore: avoid_print
      print(
        '  ✓ shot $number: $_currentFrame frames, '
        '${audio.events.length} sounds -> $outDir',
      );
    });
  }
}
