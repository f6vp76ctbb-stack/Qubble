/// Renders a short gameplay clip straight from the real game — for the store
/// listing's promo video and for short-form social clips (MASTERPLAN.md
/// Phase 5: "satisfying" clips; the opening follows the three-second concept
/// in audit/05-aso.md §6: board first, a piece dragged into an almost-full
/// line, the clear, the combo — no logo until the end).
///
/// Not a test; run it explicitly:
///
/// ```bash
/// flutter test tool/generate_video.dart   # frames + sound events -> build/video/
/// python3 tool/encode_video.py            # -> store-assets/video/qubble-gameplay.mp4
/// ```
///
/// Everything on screen is the app: the pieces are moved with real drag
/// gestures through the real Draggable and DragTarget, so every drop goes
/// through the same code a player's finger does. The only thing drawn on top
/// is a soft touch dot where the finger is, because a moving piece with no
/// finger reads as an animation rather than as something you do.
///
/// The sound track is not a guess either: the game's AudioService is replaced
/// by a recorder, so every place/clear/combo sound lands on the frame the game
/// itself asked for it, with the pitch it asked for.
///
/// Deterministic: the daily seed and the move policy are fixed, so a re-run
/// renders the same clip.
library;

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/coach_hints.dart';
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

const String _outDir = 'build/video/en';

/// Portrait phone at 3x: 1080x1920 frames.
const Size _logicalSize = Size(360, 640);
const double _pixelRatio = 3;

const int _fps = 30;
const Duration _frame = Duration(microseconds: 1000000 ~/ _fps);

/// Length of the gameplay part; the end card is added by the encoder.
const int _maxGameplayFrames = 22 * _fps;

/// Moves the seed search looks ahead, and so the most the clip will play.
const int _plannedMoves = 18;

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
  bool recording = false;

  @override
  bool enabled = true;

  @override
  void play(Sfx sfx, {double pitch = 1.0}) {
    if (recording) events.add(_Event(_currentFrame, sfx, pitch));
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

// --- Game staging ----------------------------------------------------------

/// Same demo profile as the store screenshots, with every coach hint marked
/// as seen — a hint banner sliding over the board would cover the clears.
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
  await storage.setOnboardingDone(true);
  for (final hint in CoachHintType.values) {
    await storage.markCoachHintSeen(hint);
  }
  return storage;
}

/// Row and column fill counts, for scoring candidate moves cheaply.
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

  int cleared(Piece piece, Cell origin) {
    final addRows = <int, int>{};
    final addCols = <int, int>{};
    for (final cell in piece.cells) {
      addRows[origin.row + cell.row] = (addRows[origin.row + cell.row] ?? 0) + 1;
      addCols[origin.col + cell.col] = (addCols[origin.col + cell.col] ?? 0) + 1;
    }
    var lines = 0;
    addRows.forEach((r, n) {
      if (rows[r] + n >= Board.size) lines++;
    });
    addCols.forEach((c, n) {
      if (cols[c] + n >= Board.size) lines++;
    });
    return lines;
  }

  /// How close the board gets to lines after the move: rewards building
  /// lines up instead of scattering blocks.
  int shape(Piece piece, Cell origin) {
    final r2 = [...rows];
    final c2 = [...cols];
    for (final cell in piece.cells) {
      r2[origin.row + cell.row]++;
      c2[origin.col + cell.col]++;
    }
    var s = 0;
    for (final v in [...r2, ...c2]) {
      s += v * v;
    }
    return s;
  }
}

typedef _Move = ({int slot, Cell cell, int lines});

/// The move the clip plays: the biggest clear if there is one, otherwise the
/// placement that builds lines up the most. Deterministic on the state.
_Move? _pickMove(GameController c, {bool allowClears = true}) {
  final lines = _Lines(c.state.board);
  _Move? best;
  var bestScore = -1;
  for (var slot = 0; slot < c.state.tray.length; slot++) {
    final piece = c.state.tray[slot];
    if (piece == null) continue;
    for (var row = 0; row < Board.size; row++) {
      for (var col = 0; col < Board.size; col++) {
        final cell = Cell(row, col);
        if (!c.canPlace(slot, cell)) continue;
        final cleared = lines.cleared(piece, cell);
        if (!allowClears && cleared > 0) continue;
        final score = cleared * 100000 + lines.shape(piece, cell);
        if (score > bestScore) {
          bestScore = score;
          best = (slot: slot, cell: cell, lines: cleared);
        }
      }
    }
  }
  return best;
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

/// Fills the board without clearing until it looks like a run in progress,
/// then plays on until the tray is full again.
void _stage(GameController c, DateTime day) {
  c.startDaily(now: day);
  for (var i = 0; i < 200 && _fill(c) < 0.5; i++) {
    final move = _pickMove(c, allowClears: false) ?? _pickMove(c);
    if (move == null || c.state.gameOver) return;
    c.place(move.slot, move.cell);
  }
  for (var i = 0; i < 12; i++) {
    if (c.state.tray.every((p) => p != null)) return;
    final move = _pickMove(c, allowClears: false) ?? _pickMove(c);
    if (move == null || c.state.gameOver) return;
    c.place(move.slot, move.cell);
  }
}

/// Plays [_plannedMoves] with the clip's policy and scores how watchable the
/// result is. Null when the day is unusable (no clear to open on, or the run
/// ends inside the clip).
int? _rate(GameController c, DateTime day) {
  _stage(c, day);
  if (c.state.gameOver) return null;
  var score = 0;
  var maxCombo = 0;
  for (var i = 0; i < _plannedMoves; i++) {
    final move = _pickMove(c);
    if (move == null) return null;
    // The audit's hook: the very first thing on screen is a clear.
    if (i == 0 && move.lines == 0) return null;
    c.place(move.slot, move.cell);
    if (c.state.gameOver) return null;
    score += move.lines * 10 + (move.lines >= 2 ? 15 : 0);
    maxCombo = math.max(maxCombo, c.state.combo);
  }
  return score + maxCombo * 8;
}

// --- Rendering -------------------------------------------------------------

void main() {
  setUpAll(_loadFonts);

  testWidgets('gameplay clip', (tester) async {
    tester.view.physicalSize = _logicalSize * _pixelRatio;
    tester.view.devicePixelRatio = _pixelRatio;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Pick the day whose pieces make the best clip. Storage work is real
    // async, so all of it happens before anything is mounted.
    final searchStorage = await _seededStorage();
    final search = ProviderContainer(
      overrides: [storageProvider.overrideWithValue(searchStorage)],
    );
    final searcher = search.read(gameControllerProvider.notifier);
    DateTime? bestDay;
    var bestScore = -1;
    for (var d = 0; d < 150; d++) {
      final day = DateTime(2026, 1, 1).add(Duration(days: d));
      final score = _rate(searcher, day);
      if (score != null && score > bestScore) {
        bestScore = score;
        bestDay = day;
      }
    }
    search.dispose();
    expect(bestDay, isNotNull, reason: 'no usable day in the search range');
    // ignore: avoid_print
    print('  day ${bestDay!.toIso8601String().substring(0, 10)}, score $bestScore');

    final storage = await _seededStorage();
    final audio = _RecordingAudio();
    final container = ProviderContainer(
      overrides: [
        storageProvider.overrideWithValue(storage),
        audioProvider.overrideWithValue(audio),
      ],
    );
    addTearDown(container.dispose);
    final controller = container.read(gameControllerProvider.notifier);
    _stage(controller, bestDay);

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

    final dir = Directory(_outDir);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
    dir.createSync(recursive: true);

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
      File('$_outDir/$name.png').writeAsBytesSync(png!.buffer.asUint8List());
      _currentFrame++;
    }

    Future<void> tick([int frames = 1]) async {
      for (var i = 0; i < frames; i++) {
        await tester.pump(_frame);
        await snap();
      }
    }

    Rect boardRect() {
      final boardBox = find.descendant(
        of: find.byType(BoardView),
        matching: find.byWidgetPredicate((w) => w.key is GlobalKey),
      );
      return tester.getRect(boardBox.first);
    }

    Offset trayPieceCenter(int slot) {
      final draggable = find.byWidgetPredicate(
        (w) => w is Draggable<int> && w.data == slot,
      );
      return tester.getCenter(
        find.descendant(of: draggable, matching: find.byType(PieceView)).first,
      );
    }

    audio.recording = true;
    await snap();

    var moves = 0;
    while (_currentFrame < _maxGameplayFrames && moves < _plannedMoves) {
      final move = _pickMove(controller);
      if (move == null) break;
      final piece = controller.state.tray[move.slot]!;
      final board = boardRect();
      final cell = board.width / Board.size;
      final start = trayPieceCenter(move.slot);
      // Where the finger has to be for the dragged piece's top-left corner
      // to land on the target cell: the tray's drag anchor puts the piece
      // centre kFingerLiftCells above the finger (tray_view.dart, board_view.dart).
      final end = board.topLeft +
          Offset(
            move.cell.col * cell + piece.width * cell / 2,
            move.cell.row * cell + piece.height * cell / 2 +
                kFingerLiftCells * cell,
          );

      finger.value = start;
      await tick(3);
      final gesture = await tester.startGesture(start);
      const steps = 16;
      for (var i = 1; i <= steps; i++) {
        final t = Curves.easeInOutCubic.transform(i / steps);
        final at = Offset.lerp(start, end, t)!;
        await gesture.moveTo(at);
        finger.value = at;
        await tick();
      }
      await tick(2);
      await gesture.up();
      finger.value = null;
      moves++;
      // Let a clear play out — the burst, the floating score, the combo
      // badge. A plain placement only needs a beat before the next pick-up.
      await tick(move.lines > 0 ? 22 : 7);
      expect(
        controller.state.gameOver,
        isFalse,
        reason: 'the clip must not run into Game Over',
      );
    }
    audio.recording = false;

    File('$_outDir/events.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert({
        'fps': _fps,
        'frames': _currentFrame,
        'events': [for (final e in audio.events) e.toJson()],
      }),
    );
    // ignore: avoid_print
    print('  ✓ $_currentFrame frames, ${audio.events.length} sounds, '
        '$moves moves -> $_outDir');
  });
}
