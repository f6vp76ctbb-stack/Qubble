/// Renders the social reels (owner, 16.11.2026: "5 weitere videos für die 3
/// plattformen … die sollen viral gehen und zum spielen animieren"): short
/// vertical clips for TikTok, Instagram Reels and YouTube Shorts, each built
/// around one moment.
///
/// * `turbo`    — the showreel, faster (owner: "mit den krassesten designs …
///   viele explosionen, mehrere hintereinander vom gleichen, alles
///   schneller"): the flashiest looks a player can get, three clears in a row
///   per look, so every scene builds a combo and most of them a fever burst.
/// * `allclear` — the bottom half of the board, a well, and the long piece
///   that empties the whole board.
/// * `clutch`   — a nearly full board and the one drop that clears three
///   lines at once.
/// * `looks`    — one board in ten looks, cut on the beat, then the clear.
/// * `pets`     — the same board and the same drop, nine times: every Qubbie
///   flies the line once (owner, 16.11.2026: "mach alle sinnvollen Aufgaben").
/// * `bursts`   — the same drop with each of the six explosions.
/// * `skins`    — one board in eleven animated block skins, then the clear.
/// * `turbo2`, `clutch2`, `clutch3` — the same formats in other looks and
///   games, so a series can run for a week.
///
/// Not a test; run it explicitly:
///
/// ```bash
/// QUBBLE_REEL=turbo flutter test tool/generate_reels.dart
/// python3 tool/encode_video.py reel-turbo   # -> store-assets/video/qubble-reel-turbo.mp4
/// ```
///
/// Everything on screen is the app, as in tool/generate_showreel.dart: the
/// real game screen, pieces moved with real drag gestures through the real
/// Draggable and DragTarget, and the sounds the game asked for on the frame
/// it asked for them. Three reels play seeded games found by search. The
/// all-clear reel resumes a saved run instead — the checkpoint the app writes
/// when a player leaves in the middle of a run — because a seed whose pieces
/// empty a half-full board is too rare to search for. Its position is legal,
/// its pieces are the game's own, and the game scores the clear.
///
/// These clips are for social media, not for the store listing: the
/// all-clear position is set up, and the encoder may put a line of text over
/// the opening (QUBBLE_HOOK in tool/encode_video.py).
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

final String _reel = Platform.environment['QUBBLE_REEL'] ?? 'turbo';
String get _root => 'build/video/reel-$_reel';

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
  /// Three clears in a row with the tray the scene opens on.
  chain,

  /// The saved run whose last two moves empty the board.
  allClear,

  /// A nearly full board; one drop clears three lines.
  clutch,

  /// The board as it stands, no move: one cut of the looks reel.
  still,

  /// The looks reel's last cut: the same board, and the clear.
  stillThenClear,

  /// A beat on the board, then the clear: one cut of a reel that plays the
  /// same drop in every look.
  cut,
}

/// [seed] is where the search for the scene's game starts: scenes that share
/// it stage the very same board.
typedef _Scene = ({_Kind kind, _Look look, int seed});

/// Chains in [looks], each a different game: seeds are walked from
/// [firstSeed] in steps far apart.
List<_Scene> _chainScenes(int firstSeed, List<_Look> looks) => [
  for (var i = 0; i < looks.length; i++)
    (kind: _Kind.chain, look: looks[i], seed: firstSeed + i * 501),
];

/// The same board in every look; the last one plays the clear.
List<_Scene> _sameBoard(int seed, List<_Look> looks, {required _Kind last}) => [
  for (var i = 0; i < looks.length; i++)
    (
      kind: i == looks.length - 1 ? last : _Kind.still,
      look: looks[i],
      seed: seed,
    ),
];

/// The same board and the same drop in every look.
List<_Scene> _sameDrop(int seed, List<_Look> looks) => [
  for (final look in looks) (kind: _Kind.cut, look: look, seed: seed),
];

_Look _look(
  String theme,
  String skin,
  String burst,
  String pet, {
  String clearEffect = 'classic',
  String accessory = 'none',
  int stage = 3,
}) => (
  theme: theme,
  skin: skin,
  burst: burst,
  clearEffect: clearEffect,
  accessory: accessory,
  pet: pet,
  stage: stage,
);

/// The cut lists. Every look is one a player can have all year: nothing
/// seasonal, nothing supporter-only — a clip should not advertise what most
/// players cannot get. The animated skins are the achievement skins (every
/// player can earn them) and the three for sale. A Qubbie with a row effect
/// of its own flies with it; a starter flies with an equipped one.
final Map<String, List<_Scene>> _reels = {
  'turbo': _chainScenes(1, [
    _look('neon', 'plasma', 'stars', 'zapp'),
    _look('volcano', 'ember', 'fire', 'pyra'),
    _look('sunset', 'prism', 'confetti', 'prisma', accessory: 'crown'),
    _look('ocean', 'ripple', 'bubbles', 'frosti'),
    _look('fade', 'stardust', 'stars', 'funki', accessory: 'sparkle'),
    _look('forest', 'circuit', 'pixels', 'optik'),
    _look('candy', 'fizz', 'confetti', 'kiki',
        clearEffect: 'blaze', accessory: 'flower', stage: 2),
    _look('glacier', 'shimmer', 'bubbles', 'glim',
        clearEffect: 'lightning', accessory: 'snowCap'),
  ]),
  'turbo2': _chainScenes(10001, [
    _look('wood', 'liquid', 'fire', 'funki'),
    _look('glacier', 'pulse', 'bubbles', 'frosti', accessory: 'snowCap'),
    _look('neon', 'circuit', 'pixels', 'optik'),
    _look('candy', 'prism', 'confetti', 'prisma', accessory: 'flower'),
    _look('volcano', 'stardust', 'stars', 'pyra'),
    _look('sunset', 'wave', 'bubbles', 'zapp', accessory: 'crown'),
    _look('classic', 'fizz', 'confetti', 'bit', clearEffect: 'frost'),
    _look('fade', 'ripple', 'stars', 'kiki',
        clearEffect: 'laser', accessory: 'sparkle'),
  ]),
  'allclear': [
    (
      kind: _Kind.allClear,
      look: _look('volcano', 'ember', 'fire', 'pyra'),
      seed: 0,
    ),
  ],
  'clutch': [
    (
      kind: _Kind.clutch,
      look: _look('candy', 'jelly', 'confetti', 'bit',
          accessory: 'flower', stage: 2),
      seed: 20001,
    ),
  ],
  'clutch2': [
    (kind: _Kind.clutch, look: _look('neon', 'glow', 'stars', 'zapp'), seed: 30001),
  ],
  'clutch3': [
    (
      kind: _Kind.clutch,
      look: _look('wood', 'bevel', 'pixels', 'glim',
          clearEffect: 'laser', accessory: 'dewdrop'),
      seed: 40001,
    ),
  ],
  'looks': _sameBoard(7001, [
    _look('classic', 'glossy', 'fire', 'funki', accessory: 'sparkle'),
    _look('neon', 'glow', 'stars', 'zapp'),
    _look('candy', 'jelly', 'confetti', 'kiki', accessory: 'flower', stage: 2),
    _look('volcano', 'ember', 'fire', 'pyra'),
    _look('glacier', 'marble', 'bubbles', 'frosti', accessory: 'snowCap'),
    _look('wood', 'bevel', 'pixels', 'bit',
        clearEffect: 'laser', accessory: 'dewdrop', stage: 2),
    _look('ocean', 'wave', 'bubbles', 'glim', clearEffect: 'frost'),
    _look('sunset', 'prism', 'stars', 'prisma', accessory: 'crown'),
    _look('forest', 'pixel', 'confetti', 'optik'),
    _look('fade', 'plasma', 'stars', 'funki', accessory: 'sparkle'),
  ], last: _Kind.stillThenClear),
  // One look, nine Qubbies: the starters fly with the row effect a new
  // player has, the others bring their own.
  'pets': _sameDrop(8001, [
    for (final pet in kPetCatalog) _look('classic', 'glossy', 'stars', pet.id),
  ]),
  'bursts': _sameDrop(9001, [
    for (final burst in kBurstCatalog)
      _look('classic', 'glossy', burst.id, 'kiki'),
  ]),
  'skins': _sameBoard(11001, [
    for (final skin in const [
      'liquid', 'fizz', 'plasma', 'pulse', 'shimmer', 'wave',
      'ember', 'prism', 'stardust', 'circuit', 'ripple',
    ])
      _look('classic', skin, 'stars', 'funki'),
  ], last: _Kind.stillThenClear),
};

/// Frames a still cut of the looks reel stays on screen.
const int _stillFrames = 11;

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
/// Qubbie hatched and grown to the scene's stage. [checkpoint] is a saved run
/// for the controller to resume.
Future<Storage> _seededStorage(
  _Look look, {
  Map<String, Object?>? checkpoint,
}) async {
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
  await storage.addUnlockedTheme(look.theme);
  await storage.setActiveTheme(look.theme);
  await storage.addUnlockedSkin(look.skin);
  await storage.setActiveSkin(look.skin);
  await storage.setUnlockedCosmetics('accessory', {look.accessory});
  await storage.setActiveCosmetic('accessory', look.accessory);
  await storage.setUnlockedCosmetics('burst', {look.burst});
  await storage.setActiveCosmetic('burst', look.burst);
  await storage.setUnlockedCosmetics('clearEffect', {look.clearEffect});
  await storage.setActiveCosmetic('clearEffect', look.clearEffect);

  // A starter is the free first egg; any other Qubbie is bought after it.
  final starter = kStarterPetIds.contains(look.pet) ? look.pet : 'kiki';
  var pets = PetState.empty
      .chooseStarter(starter)
      .addLines(PetRules.starterEggLines);
  pets = pets.hatchReady().state;
  if (look.pet != starter) {
    pets = pets.addBoughtEgg(look.pet)!.addLines(PetRules.boughtEggLines);
    pets = pets.hatchReady().state.withActive(look.pet);
  }
  final xp = switch (look.stage) {
    3 => PetRules.stage3Xp + 40,
    2 => PetRules.stage2Xp + 20,
    _ => 0,
  };
  await storage.setPets(pets.addLines(xp));
  if (checkpoint != null) await storage.setActiveRunCheckpoint(checkpoint);
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

  /// How close the board gets to lines after the move: rewards building
  /// lines up instead of scattering blocks (tool/generate_video.dart).
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

/// Plays the placement that builds lines up the most without clearing one;
/// false if every legal move would clear.
bool _buildOne(GameController c) {
  final board = c.state.board;
  final lines = _Lines(board);
  ({int slot, Cell cell})? best;
  var bestScore = -1;
  for (var slot = 0; slot < 3; slot++) {
    final piece = c.state.tray[slot];
    if (piece == null) continue;
    for (var row = 0; row <= Board.size - piece.height; row++) {
      for (var col = 0; col <= Board.size - piece.width; col++) {
        final cell = Cell(row, col);
        if (!board.canPlace(piece, cell)) continue;
        if (board.place(piece, cell).clearedLines > 0) continue;
        final score = lines.shape(piece, cell);
        if (score > bestScore) {
          bestScore = score;
          best = (slot: slot, cell: cell);
        }
      }
    }
  }
  if (best == null) return false;
  c.place(best.slot, best.cell);
  return true;
}

double _fill(Board board) => board.filledCount / (Board.size * Board.size);

/// Fills a fresh game of [seed] to [target] without clearing, then until the
/// tray is full again. False if the game got stuck on the way.
bool _stage(GameController c, int seed, double target) {
  c.newGame(seed: seed);
  for (var i = 0; i < 200 && _fill(c.state.board) < target; i++) {
    if (c.state.gameOver || !_buildOne(c)) return false;
  }
  for (var i = 0; i < 12 && c.state.tray.any((p) => p == null); i++) {
    if (c.state.gameOver || !_buildOne(c)) return false;
  }
  return !c.state.gameOver && c.state.tray.every((p) => p != null);
}

typedef _Step = ({int slot, Cell cell, int lines});

/// Every order and position of the tray in which each move clears; the best
/// by [score]. Simulated on [Board], which is what the session plays on.
List<_Step> _bestChain(
  Board board,
  List<Piece?> tray,
  int Function(List<_Step>) score,
) {
  var best = const <_Step>[];
  var bestScore = -1;
  void search(Board b, List<Piece?> t, List<_Step> path) {
    final s = score(path);
    if (s > bestScore) {
      bestScore = s;
      best = List.of(path);
    }
    for (var slot = 0; slot < 3; slot++) {
      final piece = t[slot];
      if (piece == null) continue;
      for (var row = 0; row <= Board.size - piece.height; row++) {
        for (var col = 0; col <= Board.size - piece.width; col++) {
          final cell = Cell(row, col);
          if (!b.canPlace(piece, cell)) continue;
          final result = b.place(piece, cell);
          if (result.clearedLines == 0) continue;
          search(result.board, List.of(t)..[slot] = null, [
            ...path,
            (slot: slot, cell: cell, lines: result.clearedLines),
          ]);
        }
      }
    }
  }

  search(board, tray, const []);
  return best;
}

int _lines(List<_Step> path) => path.fold(0, (s, e) => s + e.lines);

/// Three clears, as many lines as possible, at least one of them a
/// multi-line clear — and five lines in all fill the fever meter.
int _chainScore(List<_Step> path) {
  final lines = _lines(path);
  final multi = path.where((e) => e.lines >= 2).length;
  return path.length * 100 + lines * 10 + multi * 15 + (lines >= 5 ? 60 : 0);
}

/// Stages a busy board whose tray clears three times in a row. Seeds are
/// walked from [firstSeed], so every scene is a different game.
List<_Step>? _armChain(GameController c, int firstSeed) {
  List<_Step>? fallback;
  int? fallbackSeed;
  for (var seed = firstSeed; seed < firstSeed + 500; seed++) {
    if (!_stage(c, seed, 0.56)) continue;
    final chain = _bestChain(c.state.board, c.state.tray, _chainScore);
    if (chain.length < 3) continue;
    if (_lines(chain) >= 5 && chain.any((e) => e.lines >= 2)) return chain;
    if (fallback == null || _chainScore(chain) > _chainScore(fallback)) {
      fallback = chain;
      fallbackSeed = seed;
    }
  }
  if (fallbackSeed == null) return null;
  _stage(c, fallbackSeed, 0.56);
  return fallback;
}

/// Stages a nearly full board with a single drop that clears three lines (or
/// more). Seeds are walked from [firstSeed].
List<_Step>? _armClutch(GameController c, int firstSeed) {
  for (final need in const [3, 2]) {
    for (var seed = firstSeed; seed < firstSeed + 1500; seed++) {
      if (!_stage(c, seed, 0.70)) continue;
      final board = c.state.board;
      for (var slot = 0; slot < 3; slot++) {
        final piece = c.state.tray[slot]!;
        for (var row = 0; row <= Board.size - piece.height; row++) {
          for (var col = 0; col <= Board.size - piece.width; col++) {
            final cell = Cell(row, col);
            if (!board.canPlace(piece, cell)) continue;
            final lines = board.place(piece, cell).clearedLines;
            if (lines >= need) {
              // ignore: avoid_print
              print('  clutch: seed $seed, ${piece.id} clears $lines lines, '
                  'board ${(_fill(board) * 100).round()} % full');
              return [(slot: slot, cell: cell, lines: lines)];
            }
          }
        }
      }
    }
  }
  return null;
}

/// Stages the looks reel's board: busy, with a drop that clears two lines.
/// Deterministic, so every cut of the reel stages the very same board.
List<_Step>? _armLooks(GameController c, int firstSeed) {
  for (var seed = firstSeed; seed < firstSeed + 600; seed++) {
    if (!_stage(c, seed, 0.62)) continue;
    final board = c.state.board;
    for (var slot = 0; slot < 3; slot++) {
      final piece = c.state.tray[slot]!;
      for (var row = 0; row <= Board.size - piece.height; row++) {
        for (var col = 0; col <= Board.size - piece.width; col++) {
          final cell = Cell(row, col);
          if (!board.canPlace(piece, cell)) continue;
          final lines = board.place(piece, cell).clearedLines;
          if (lines >= 2) return [(slot: slot, cell: cell, lines: lines)];
        }
      }
    }
  }
  return null;
}

// --- The all-clear position --------------------------------------------------

Map<String, Object?> _pieceJson(String id) {
  final piece = buildCatalog().firstWhere((p) => p.id == id);
  return {
    'id': piece.id,
    'weight': piece.weight,
    'cells': [
      for (final cell in piece.cells) [cell.row, cell.col],
    ],
  };
}

/// A run in progress, as the app saves it: the bottom half built up around a
/// well in column five, one gap left in the row above it. The dot closes the
/// row (the combo opens), the long piece drops down the well and takes the
/// four rows with it — and with them the last block on the board.
Map<String, Object?> _allClearCheckpoint() {
  const board = [
    '........',
    '........',
    '........',
    '#.######',
    '#####.##',
    '#####.##',
    '#####.##',
    '#####.##',
  ];
  // Tray-slot colours, mixed the way a run mixes them.
  const colors = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [2, 0, 1, 1, 1, 0, 0, 2],
    [2, 2, 1, 0, 0, 0, 1, 2],
    [0, 2, 1, 0, 2, 0, 1, 1],
    [0, 0, 2, 2, 2, 0, 1, 0],
    [1, 1, 1, 2, 2, 0, 0, 0],
  ];
  return {
    'version': 1,
    'seed': 424242,
    'earlyPhaseMoves': 0,
    'freeRotation': false,
    'board': board,
    'boardColors': colors,
    'tray': [_pieceJson('square2'), _pieceJson('dot'), _pieceJson('line4_v')],
    'placements': 31,
    'generatedTrays': 11,
    'rotationCharges': 3,
    'rotationPaid': [false, false, false],
    'linesCleared': 14,
    'maxCombo': 3,
    'score': {'total': 2140, 'combo': 1, 'fever': 0.6, 'movesSinceClear': 1},
  };
}

/// The all-clear position's two moves, worked out on the board itself: the
/// dot that closes row three, then the long piece in the well.
List<_Step> _allClearMoves(GameController c) {
  final tray = c.state.tray;
  final dot = tray.indexWhere((p) => p?.id == 'dot');
  final long = tray.indexWhere((p) => p?.id == 'line4_v');
  var board = c.state.board;
  final first = board.place(tray[dot]!, const Cell(3, 1));
  board = first.board;
  final last = board.place(tray[long]!, const Cell(4, 5));
  expect(last.isAllClear, isTrue, reason: 'the position must end empty');
  return [
    (slot: dot, cell: const Cell(3, 1), lines: first.clearedLines),
    (slot: long, cell: const Cell(4, 5), lines: last.clearedLines),
  ];
}

/// A Wednesday in March: no weekend banner, nothing seasonal.
final _renderDay = DateTime(2026, 3, 11);

void main() {
  setUpAll(_loadFonts);

  final scenes =
      _reels[_reel] ??
      (throw ArgumentError('QUBBLE_REEL must be one of ${_reels.keys}'));
  for (var index = 0; index < scenes.length; index++) {
    final scene = scenes[index];
    final look = scene.look;
    final number = (index + 1).toString().padLeft(2, '0');
    testWidgets('$_reel $number: ${scene.kind.name} in ${look.theme}', (
      tester,
    ) async {
      tester.view.physicalSize = _logicalSize * _pixelRatio;
      tester.view.devicePixelRatio = _pixelRatio;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // The looks in the cut list must exist and be ones a player can get:
      // a typo would silently fall back to the default.
      final theme = kThemeCatalog.firstWhere((t) => t.id == look.theme);
      expect(theme.supporterOnly || theme.saleMonth != null, isFalse);
      final skin = kSkinCatalog.firstWhere((s) => s.id == look.skin);
      expect(skin.supporterOnly || skin.saleMonth != null, isFalse);
      expect(kBurstCatalog.map((b) => b.id), contains(look.burst));
      expect(kClearEffectCatalog.map((e) => e.id), contains(look.clearEffect));
      expect(kAccessoryCatalog.map((a) => a.id), contains(look.accessory));
      expect(petById(look.pet), isNotNull);

      final storage = await _seededStorage(
        look,
        checkpoint: scene.kind == _Kind.allClear ? _allClearCheckpoint() : null,
      );
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
      final moves = switch (scene.kind) {
        _Kind.chain => _armChain(controller, scene.seed),
        _Kind.allClear => _allClearMoves(controller),
        _Kind.clutch => _armClutch(controller, scene.seed),
        _Kind.still ||
        _Kind.stillThenClear ||
        _Kind.cut => _armLooks(controller, scene.seed),
      };
      expect(moves, isNotNull, reason: 'no position for scene $number');
      // ignore: avoid_print
      print('  scene $number: ${moves!.map((m) => m.lines).join('+')} lines');
      audio.events.clear();

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
              locale: const Locale('en'),
              localizationsDelegates: L10n.localizationsDelegates,
              supportedLocales: L10n.supportedLocales,
              home: const GameScreen(),
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

      /// Drags the piece of [move] onto its cell in [steps] frames and drops
      /// it; the clear must happen.
      Future<void> drop(_Step move, {required int steps}) async {
        final boardBox = find.descendant(
          of: find.byType(BoardView),
          matching: find.byWidgetPredicate((w) => w.key is GlobalKey),
        );
        final board = tester.getRect(boardBox.first);
        final cell = board.width / Board.size;
        final piece = controller.state.tray[move.slot]!;
        final draggable = find.byWidgetPredicate(
          (w) => w is Draggable<int> && w.data == move.slot,
        );
        final start = tester.getCenter(
          find.descendant(of: draggable, matching: find.byType(PieceView)).first,
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
        final gesture = await tester.startGesture(start);
        for (var i = 1; i <= steps; i++) {
          await gesture.moveTo(
            Offset.lerp(start, end, Curves.easeInOutCubic.transform(i / steps))!,
          );
          await tick();
        }
        await tick();
        final clearsBefore = controller.state.clearEventId;
        await gesture.up();
        expect(
          controller.state.clearEventId,
          isNot(clearsBefore),
          reason: 'scene $number: the drop cleared nothing',
        );
      }

      switch (scene.kind) {
        case _Kind.chain:
          // Three clears back to back: the next piece is picked up while the
          // last burst is still in the air. The Qubbie's flight takes 600 ms;
          // the cut comes once the last one has landed.
          await snap();
          for (var i = 0; i < moves.length; i++) {
            await drop(moves[i], steps: 5);
            await tick(i == moves.length - 1 ? 21 : 8);
          }
        case _Kind.allClear:
          // A beat to take the board in, the dot, then the long piece down
          // the well, slow enough to follow; the banner gets its time.
          await snap();
          await tick(14);
          await drop(moves[0], steps: 7);
          await tick(9);
          await drop(moves[1], steps: 12);
          await tick(48);
        case _Kind.clutch:
          // Long enough on the full board to look for the spot yourself.
          await snap();
          await tick(44);
          await drop(moves.single, steps: 14);
          await tick(36);
        case _Kind.still:
          await snap();
          await tick(_stillFrames - 1);
        case _Kind.stillThenClear:
          await snap();
          await tick(_stillFrames);
          await drop(moves.single, steps: 8);
          await tick(34);
        case _Kind.cut:
          // Short: the drop, the burst, the Qubbie's 600 ms flight, cut.
          await snap();
          await tick(3);
          await drop(moves.single, steps: 6);
          await tick(24);
      }
      expect(controller.state.gameOver, isFalse);

      File('$outDir/events.json').writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert({
          'fps': _fps,
          'frames': _currentFrame,
          'events': [for (final e in audio.events) e.toJson()],
        }),
      );
      // ignore: avoid_print
      print(
        '  ✓ $_reel $number: $_currentFrame frames, '
        '${audio.events.length} sounds -> $outDir',
      );
    });
  }
}
