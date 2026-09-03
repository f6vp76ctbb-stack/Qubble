// The score header is a Row that already overflowed once at larger system font
// sizes (BACKLOG #22). The speed-bonus readout was added into it, next to a
// combo badge that is itself only sometimes present — so the worst case is
// both showing at once, in German, on the tightest phone, at the largest font
// scale Android offers.
import 'package:flutter/material.dart';
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

/// Plays until a clear lands, so the combo badge and the speed readout are
/// both on screen. Returns whether that state was reached.
///
/// Prefers a placement that clears a line rather than taking the first legal
/// slot: the run is seeded randomly, and first-fit play did not reach a combo
/// on every seed, which made this a flaky layout test with a misleading
/// failure message.
bool _playUntilClear(GameController controller) {
  for (var move = 0; move < 120; move++) {
    if (controller.state.gameOver) return false;
    (int, Cell)? fallback;
    (int, Cell)? clearing;
    final snap = controller.state;
    for (var slot = 0; slot < snap.tray.length; slot++) {
      final piece = snap.tray[slot];
      if (piece == null) continue;
      for (var r = 0; r <= Board.size - piece.height; r++) {
        for (var c = 0; c <= Board.size - piece.width; c++) {
          final cell = Cell(r, c);
          if (!controller.canPlace(slot, cell)) continue;
          fallback ??= (slot, cell);
          if (snap.board.place(piece, cell).clearedLines > 0) {
            clearing = (slot, cell);
          }
        }
      }
    }
    final pick = clearing ?? fallback;
    if (pick == null) return false;
    controller.place(pick.$1, pick.$2);
    if (controller.state.combo > 0) return true;
  }
  return false;
}

Future<List<String>> _overflows(
  WidgetTester tester,
  Locale locale,
  double textScale,
) async {
  SharedPreferences.setMockInitialValues({});
  final storage = Storage(await SharedPreferences.getInstance());

  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final container = ProviderContainer(
    overrides: [storageProvider.overrideWithValue(storage)],
  );
  addTearDown(container.dispose);

  final overflows = <String>[];
  final previous = FlutterError.onError;
  FlutterError.onError = (details) {
    final text = details.exceptionAsString();
    if (text.contains('overflowed')) {
      overflows.add(details.toString().split('The overflowing').first);
    }
  };
  try {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          locale: locale,
          theme: buildGridTheme(),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          builder: (context, child) => MediaQuery.withClampedTextScaling(
            minScaleFactor: textScale,
            maxScaleFactor: textScale,
            child: child!,
          ),
          home: const GameScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    final reached = _playUntilClear(
      container.read(gameControllerProvider.notifier),
    );
    expect(reached, isTrue, reason: 'the harness never reached a combo state');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
  } finally {
    FlutterError.onError = previous;
  }
  return overflows;
}

void main() {
  for (final locale in [const Locale('en'), const Locale('de')]) {
    for (final scale in [1.0, 1.3, 2.0]) {
      testWidgets(
        'game HUD with combo and speed bonus: ${locale.languageCode} @$scale',
        (tester) async {
          expect(await _overflows(tester, locale, scale), isEmpty);
        },
      );
    }
  }
}
