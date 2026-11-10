/// Renders the app's screens to PNG so they can be looked at.
///
/// Not a test — it lives outside `test/` so `flutter test` never picks it up:
///
/// ```bash
/// flutter test tool/review_screens.dart            # English
/// QUBBLE_REVIEW_LOCALE=de flutter test tool/review_screens.dart
/// ```
///
/// Output: `build/review/<locale>/*.png`, a modern phone (360×800 at 3×).
/// Two save files are walked: a first launch (what a new player meets, in the
/// order they meet it) and a player a few weeks in. Nothing here is uploaded
/// anywhere; it exists so a change to a screen can be seen before it ships.
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
import 'package:gridpop/ui/format.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/daily_screen.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/how_to_play_screen.dart';
import 'package:gridpop/ui/screens/leaderboard_screen.dart';
import 'package:gridpop/ui/screens/puzzle_levels_screen.dart';
import 'package:gridpop/ui/screens/puzzle_screen.dart';
import 'package:gridpop/ui/screens/quests_screen.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/screens/stats_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String _locale = Platform.environment['QUBBLE_REVIEW_LOCALE'] ?? 'en';
String get _outDir => 'build/review/$_locale';

/// A current mid-range phone: 9:20.
const Size _logicalSize = Size(360, 800);
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

/// A Wednesday, so no weekend banner and no seasonal shop section.
final _renderDay = DateTime(2026, 3, 11);

Future<Storage> _freshStorage() async {
  SharedPreferences.setMockInitialValues({});
  return Storage.create();
}

Future<Storage> _veteranStorage() async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  await storage.setPlayerName('Puzzlerin');
  await storage.setHighscore(18740);
  await storage.setCoins(2480);
  await storage.setDiamonds(120);
  await storage.setPlayerLevel(14);
  await storage.setXp(120);
  await storage.setStreak(6);
  await storage.setAppOpenCount(37);
  for (final id in ['fade', 'neon', 'ocean', 'wood', 'sunset']) {
    await storage.addUnlockedTheme(id);
  }
  for (final id in ['gradient', 'outline', 'glossy', 'glow']) {
    await storage.addUnlockedSkin(id);
  }
  await storage.setPuzzleStars({1: 3, 2: 3, 3: 2, 4: 3, 5: 1});
  await storage.setOnboardingDone(true);
  return storage;
}

ProviderContainer _container(Storage storage) => ProviderContainer(
  overrides: [
    storageProvider.overrideWithValue(storage),
    gameCalendarProvider.overrideWithValue(() => _renderDay),
  ],
);

Future<void> _mount(
  WidgetTester tester,
  GlobalKey key,
  ProviderContainer container,
  Widget screen,
) async {
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
          locale: localeFromCode(_locale),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: screen,
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> _snap(WidgetTester tester, GlobalKey key, String name) async {
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final png = await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: _pixelRatio);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return bytes;
  });
  final path = '$_outDir/$name.png';
  File(path)
    ..createSync(recursive: true)
    ..writeAsBytesSync(png!.buffer.asUint8List());
  // ignore: avoid_print
  print('  ✓ $path');
}

void _useSize(WidgetTester tester) {
  tester.view.physicalSize = _logicalSize * _pixelRatio;
  tester.view.devicePixelRatio = _pixelRatio;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

/// Places the first tray piece that fits anywhere; false if none does.
bool _placeSomething(GameController c) {
  for (var slot = 0; slot < c.state.tray.length; slot++) {
    final p = c.state.tray[slot];
    if (p == null) continue;
    for (var r = 0; r <= Board.size - p.height; r++) {
      for (var col = 0; col <= Board.size - p.width; col++) {
        if (c.canPlace(slot, Cell(r, col))) {
          c.place(slot, Cell(r, col));
          return true;
        }
      }
    }
  }
  return false;
}

/// Plays greedily, rotating when nothing fits, until the run is over.
void _playToGameOver(GameController c) {
  var guard = 0;
  while (!c.state.gameOver && guard++ < 3000) {
    if (_placeSomething(c)) continue;
    var rotated = false;
    for (var slot = 0; slot < c.state.tray.length && !rotated; slot++) {
      if (c.state.tray[slot] == null) continue;
      for (var i = 0; i < 3; i++) {
        if (!c.rotateTray(slot)) break;
        if (_placeSomething(c)) {
          rotated = true;
          break;
        }
      }
    }
    if (!rotated) break;
  }
}

void main() {
  setUpAll(useLatinDigits);
  setUpAll(_loadFonts);

  // --- First launch -------------------------------------------------------

  testWidgets('new-01-home', (tester) async {
    _useSize(tester);
    final container = _container(await _freshStorage());
    addTearDown(container.dispose);
    final key = GlobalKey();
    await _mount(tester, key, container, const HomeScreen());
    await _snap(tester, key, 'new-01-home');
  });

  testWidgets('new-02-first-run', (tester) async {
    _useSize(tester);
    final container = _container(await _freshStorage());
    addTearDown(container.dispose);
    final c = container.read(gameControllerProvider.notifier)..newGame(seed: 3);
    final key = GlobalKey();
    await _mount(tester, key, container, const GameScreen());
    await _snap(tester, key, 'new-02-first-run-start');
    _placeSomething(c);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await _snap(tester, key, 'new-03-first-run-after-1');
    for (var i = 0; i < 6; i++) {
      _placeSomething(c);
    }
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await _snap(tester, key, 'new-04-first-run-after-7');
    _playToGameOver(c);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1500));
    await _snap(tester, key, 'new-05-first-game-over');
    await tester.pump(const Duration(seconds: 3));
    await _snap(tester, key, 'new-06-first-game-over-settled');
  });

  testWidgets('new-07-home-after-first-run', (tester) async {
    _useSize(tester);
    final storage = await _freshStorage();
    final container = _container(storage);
    addTearDown(container.dispose);
    final c = container.read(gameControllerProvider.notifier)..newGame(seed: 3);
    _playToGameOver(c);
    final key = GlobalKey();
    await _mount(tester, key, container, const HomeScreen());
    await _snap(tester, key, 'new-07-home-after-first-run');
  });

  // --- A player a few weeks in -------------------------------------------

  final screens = <String, Widget Function()>{
    'vet-01-home': () => const HomeScreen(),
    'vet-02-daily': () => const DailyScreen(),
    'vet-03-quests': () => const QuestsScreen(),
    'vet-04-shop': () => const ShopScreen(),
    'vet-05-designs': () => const DesignsScreen(),
    'vet-06-leaderboard': () => const LeaderboardScreen(),
    'vet-07-puzzle-levels': () => const PuzzleLevelsScreen(),
    'vet-08-puzzle': () => const PuzzleScreen(level: 6),
    'vet-09-stats': () => const StatsScreen(),
    'vet-10-settings': () => const SettingsScreen(),
    'vet-11-how-to-play': () => const HowToPlayScreen(),
  };
  for (final entry in screens.entries) {
    testWidgets(entry.key, (tester) async {
      _useSize(tester);
      final container = _container(await _veteranStorage());
      addTearDown(container.dispose);
      final key = GlobalKey();
      await _mount(tester, key, container, entry.value());
      await tester.pump(const Duration(milliseconds: 800));
      await _snap(tester, key, entry.key);
    });
  }

  testWidgets('vet-12-game', (tester) async {
    _useSize(tester);
    final container = _container(await _veteranStorage());
    addTearDown(container.dispose);
    final c = container.read(gameControllerProvider.notifier)
      ..newGame(seed: 11);
    for (var i = 0; i < 14; i++) {
      _placeSomething(c);
    }
    final key = GlobalKey();
    await _mount(tester, key, container, const GameScreen());
    await _snap(tester, key, 'vet-12-game');
    _playToGameOver(c);
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await _snap(tester, key, 'vet-13-game-over');
  });
}
