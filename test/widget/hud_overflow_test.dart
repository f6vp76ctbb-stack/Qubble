// The score header is a Row that already overflowed once at larger system font
// sizes (BACKLOG #22). The speed-bonus readout was added into it, next to a
// combo badge that is itself only sometimes present — so the worst case is
// both showing at once, in every shipped language, on the tightest phone, at
// the largest font scale Android offers.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/format.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Plays until a second clear lands inside the combo window: the combo badge
/// only shows from x2 on, and until 26.09.2026 this stopped at the first clear
/// — so the badge the test is about was never on screen. Returns whether that
/// state was reached.
///
/// Prefers a placement that clears a line rather than taking the first legal
/// slot: first-fit play did not reach a combo on every seed.
bool _playUntilCombo(GameController controller) {
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
    if (controller.state.combo > 1) return true;
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

  // A fixed run on a fixed-step clock. The run used to be seeded at random
  // and timed by the wall clock, and one run in many failed (Hebrew at 1.3 on
  // 26.09.2026) without failing again on re-runs. One second per move keeps
  // the speed bonus at its widest ("+30%"), the worst case this test is for.
  // The clock starts at the wall clock's now because the HUD's readout counts
  // down from the last move on the wall clock.
  var now = DateTime.now();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      gameClockProvider.overrideWithValue(
        () => now = now.add(const Duration(seconds: 1)),
      ),
    ],
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

    final controller = container.read(gameControllerProvider.notifier)
      ..newGame(seed: 4242);
    final reached = _playUntilCombo(controller);
    expect(reached, isTrue, reason: 'the harness never reached a combo state');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 120));
    // Both transient readouts on screen, or this checks less than it claims.
    final strings = lookupL10n(locale);
    final combo = container.read(gameControllerProvider).combo;
    expect(find.text(strings.gameComboMultiplier(combo)), findsOneWidget);
    expect(find.text(strings.gameSpeedBonus(30)), findsOneWidget);
  } finally {
    FlutterError.onError = previous;
  }

  // Wrapping is not an overflow, so the check above cannot see it — and it
  // is what actually happened: with the combo badge showing, the score broke
  // mid-number over three lines ("4,1/74") and the label read "SCOR/E".
  final l10n = lookupL10n(locale);
  final snap = container.read(gameControllerProvider);
  final mustStayOnOneLine = {
    l10n.commonScore,
    l10n.commonBest,
    formatCount(snap.score, locale: locale.languageCode),
  };
  for (final paragraph in tester.allRenderObjects.whereType<RenderParagraph>()) {
    final text = paragraph.text.toPlainText();
    if (!mustStayOnOneLine.contains(text)) continue;
    // The same text laid out with unlimited width is exactly one line; a
    // paragraph taller than that has wrapped.
    final oneLine = TextPainter(
      text: paragraph.text,
      textDirection: paragraph.textDirection,
      textScaler: paragraph.textScaler,
    )..layout();
    if (paragraph.size.height > oneLine.height * 1.5) {
      overflows.add('"$text" wraps (${paragraph.size.height.round()} px tall, '
          'one line is ${oneLine.height.round()} px)');
    }
    oneLine.dispose();
  }
  return overflows;
}

void main() {
  for (final locale in L10n.supportedLocales) {
    for (final scale in [1.0, 1.3, 2.0]) {
      testWidgets(
        'game HUD with combo and speed bonus fits and does not wrap: '
        '${locale.languageCode} @$scale',
        (tester) async {
          expect(await _overflows(tester, locale, scale), isEmpty);
        },
      );
    }
  }
}
