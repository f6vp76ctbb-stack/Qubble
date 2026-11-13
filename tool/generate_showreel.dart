/// Renders the fast-cut showreel (owner, 09.11.2026): many short scenes, each
/// a line going off in a different look — theme, block skin, explosion, row
/// effect — with a different Qubbie flying along it.
///
/// Not a test; run it explicitly:
///
/// ```bash
/// flutter test tool/generate_showreel.dart   # frames + sounds -> build/video/showreel/
/// python3 tool/encode_video.py showreel      # -> store-assets/video/qubble-showreel.mp4
/// ```
///
/// Like tool/generate_video.dart, everything on screen is the app: each scene
/// is the real game screen, the piece is moved with a real drag gesture, and
/// the sounds are the ones the game asked for, on the frame it asked for
/// them. The only thing drawn on top is the touch dot. No text is added, so
/// the one clip serves every language.
///
/// One scene is one test: seeding a save file is real async work that only
/// completes reliably before a test mounts its first widget.
/// Deterministic — the same run renders the same frames.
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
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:gridpop/ui/widgets/piece_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _root = 'build/video/showreel';

/// Portrait phone at 3x: 1080x1920 frames.
const Size _logicalSize = Size(360, 640);
const double _pixelRatio = 3;

const int _fps = 30;
const Duration _frame = Duration(microseconds: 1000000 ~/ _fps);

/// A scene: the look, the Qubbie, and how grown it is.
typedef _Scene = ({
  String theme,
  String skin,
  String burst,
  String clearEffect,
  String accessory,
  String pet,
  int stage,
});

/// The cut list. Every look here is one a player can have all year: no
/// seasonal design, and not the supporter-only theme — a clip should not
/// advertise what most players cannot get. Premium Qubbies bring their own
/// row effect; where a starter flies, the scene shows a row effect a player
/// can equip. The first scene is the frame of the first store screenshot.
const List<_Scene> _scenes = [
  (theme: 'classic', skin: 'glossy', burst: 'fire', clearEffect: 'classic', accessory: 'none', pet: 'funki', stage: 3),
  (theme: 'neon', skin: 'glow', burst: 'stars', clearEffect: 'classic', accessory: 'none', pet: 'zapp', stage: 3),
  (theme: 'candy', skin: 'jelly', burst: 'confetti', clearEffect: 'classic', accessory: 'flower', pet: 'kiki', stage: 2),
  (theme: 'glacier', skin: 'marble', burst: 'bubbles', clearEffect: 'classic', accessory: 'snowCap', pet: 'frosti', stage: 3),
  (theme: 'volcano', skin: 'ember', burst: 'fire', clearEffect: 'classic', accessory: 'none', pet: 'pyra', stage: 3),
  (theme: 'ocean', skin: 'wave', burst: 'bubbles', clearEffect: 'laser', accessory: 'dewdrop', pet: 'glim', stage: 2),
  (theme: 'sunset', skin: 'prism', burst: 'stars', clearEffect: 'classic', accessory: 'crown', pet: 'prisma', stage: 3),
  (theme: 'wood', skin: 'bevel', burst: 'pixels', clearEffect: 'lightning', accessory: 'none', pet: 'bit', stage: 2),
  (theme: 'forest', skin: 'pixel', burst: 'confetti', clearEffect: 'classic', accessory: 'none', pet: 'optik', stage: 3),
  (theme: 'fade', skin: 'crystal', burst: 'stars', clearEffect: 'frost', accessory: 'sparkle', pet: 'kiki', stage: 3),
  (theme: 'neon', skin: 'plasma', burst: 'pixels', clearEffect: 'classic', accessory: 'none', pet: 'frosti', stage: 2),
  (theme: 'classic', skin: 'stardust', burst: 'confetti', clearEffect: 'blaze', accessory: 'crown', pet: 'glim', stage: 3),
];

// --- Sound recording -------------------------------------------------------

int _currentFrame = 0;

class _Event {
  _Event(this.frame, this.sfx, this.pitch);
  final int frame;
  final Sfx sfx;
  final double pitch;
  Map<String, Object> toJson() =>
      {'frame': frame, 'sfx': sfx.name, 'pitch': pitch};
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

/// The demo profile of the store screenshots, in this scene's look, with its
/// Qubbie hatched and grown to the scene's stage.
Future<Storage> _seededStorage(_Scene scene) async {
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
  await storage.addUnlockedTheme(scene.theme);
  await storage.setActiveTheme(scene.theme);
  await storage.addUnlockedSkin(scene.skin);
  await storage.setActiveSkin(scene.skin);
  await storage.setUnlockedCosmetics('accessory', {scene.accessory});
  await storage.setActiveCosmetic('accessory', scene.accessory);
  await storage.setUnlockedCosmetics('burst', {scene.burst});
  await storage.setActiveCosmetic('burst', scene.burst);
  await storage.setUnlockedCosmetics('clearEffect', {scene.clearEffect});
  await storage.setActiveCosmetic('clearEffect', scene.clearEffect);

  var pets = PetState.empty.chooseStarter('kiki').addLines(10);
  pets = pets.hatchReady().state;
  if (scene.pet != 'kiki') {
    pets = pets.addBoughtEgg(scene.pet)!.addLines(PetRules.boughtEggLines);
    pets = pets.hatchReady().state.withActive(scene.pet);
  }
  final xp = switch (scene.stage) {
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

  /// The rows and the number of columns that dropping [piece] at [origin]
  /// would fill.
  ({List<int> rows, int cols}) completed(Piece piece, Cell origin) {
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
      ].length,
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
        if (done.rows.isNotEmpty || done.cols > 0) continue;
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

/// Stages a busy board with one row waiting to be completed — a row in the
/// middle of the board, so the Qubbie's flight sits where the eye is — and
/// returns the move that completes it. Seeds are walked from [firstSeed], so
/// every scene is a different game.
({int slot, Cell cell})? _arm(GameController c, int firstSeed) {
  for (var seed = firstSeed; seed < firstSeed + 400; seed++) {
    c.newGame(seed: seed);
    for (var i = 0; i < 200 && _fill(c) < 0.6 && !c.state.gameOver; i++) {
      if (!_fillOne(c)) break;
    }
    // A full tray: a scene that opens on one lonely piece looks broken.
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
          if (done.cols == 0 &&
              done.rows.length == 1 &&
              done.rows.single >= 2 &&
              done.rows.single <= 5) {
            return (slot: slot, cell: cell);
          }
        }
      }
    }
  }
  return null;
}

/// A Wednesday in March: no weekend banner, nothing seasonal.
final _renderDay = DateTime(2026, 3, 11);

void main() {
  setUpAll(_loadFonts);

  for (var index = 0; index < _scenes.length; index++) {
    final scene = _scenes[index];
    final number = (index + 1).toString().padLeft(2, '0');
    testWidgets('scene $number: ${scene.theme} with ${scene.pet}', (
      tester,
    ) async {
      tester.view.physicalSize = _logicalSize * _pixelRatio;
      tester.view.devicePixelRatio = _pixelRatio;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // The looks in the cut list must exist: a typo would silently fall
      // back to the default and the clip would show the same thing twice.
      expect(kThemeCatalog.map((t) => t.id), contains(scene.theme));
      expect(kBurstCatalog.map((b) => b.id), contains(scene.burst));
      expect(kClearEffectCatalog.map((e) => e.id), contains(scene.clearEffect));
      expect(kAccessoryCatalog.map((a) => a.id), contains(scene.accessory));
      expect(petById(scene.pet), isNotNull);

      final storage = await _seededStorage(scene);
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
      final move = _arm(controller, 1 + index * 401);
      expect(move, isNotNull, reason: 'no row to clear for scene $number');
      audio.events.clear();

      final finger = ValueNotifier<Offset?>(null);
      final key = GlobalKey();
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stack(
              children: [
                UncontrolledProviderScope(
                  container: container,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: buildGridTheme().copyWith(
                      textTheme: buildGridTheme().textTheme.apply(
                        fontFamilyFallback: const ['NotoColorEmoji'],
                      ),
                    ),
                    locale: const Locale('en'),
                    localizationsDelegates: L10n.localizationsDelegates,
                    supportedLocales: L10n.supportedLocales,
                    home: const GameScreen(),
                  ),
                ),
                ValueListenableBuilder<Offset?>(
                  valueListenable: finger,
                  builder: (context, at, _) => at == null
                      ? const SizedBox.shrink()
                      : Positioned(
                          left: at.dx - 17,
                          top: at.dy - 17,
                          child: IgnorePointer(
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.28),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
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
        find.descendant(of: draggable, matching: find.byType(PieceView)).first,
      );
      // Where the finger has to be for the piece to land on the target cell:
      // the tray's drag anchor holds the piece kFingerLiftCells above it.
      final end = board.topLeft +
          Offset(
            move.cell.col * cell + piece.width * cell / 2,
            move.cell.row * cell + piece.height * cell / 2 +
                kFingerLiftCells * cell,
          );

      // A beat on the board, a quick drag, and the clear played out: the
      // Qubbie's flight takes 600 ms, the cut comes right after it lands.
      await snap();
      finger.value = start;
      await tick(4);
      final gesture = await tester.startGesture(start);
      const steps = 9;
      for (var i = 1; i <= steps; i++) {
        final at = Offset.lerp(
          start,
          end,
          Curves.easeInOutCubic.transform(i / steps),
        )!;
        await gesture.moveTo(at);
        finger.value = at;
        await tick();
      }
      await tick();
      final clearsBefore = controller.state.clearEventId;
      await gesture.up();
      finger.value = null;
      await tick(21);
      expect(
        controller.state.clearEventId,
        isNot(clearsBefore),
        reason: 'scene $number: the drop cleared nothing',
      );
      expect(controller.state.gameOver, isFalse);

      File('$outDir/events.json').writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert({
          'fps': _fps,
          'frames': _currentFrame,
          'events': [for (final e in audio.events) e.toJson()],
        }),
      );
      // ignore: avoid_print
      print('  ✓ scene $number: $_currentFrame frames, '
          '${audio.events.length} sounds -> $outDir');
    });
  }
}
