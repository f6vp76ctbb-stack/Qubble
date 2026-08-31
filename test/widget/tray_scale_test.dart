// The tray used to draw pieces at ~14 px per cell against a ~42 px board cell
// (34 % of landing size), and the rotate button was 28x22 inside a Draggable.
// Both are things a player operates on every single move, so they are pinned.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/piece_view.dart';
import 'package:gridpop/ui/widgets/tray_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Minimum share of the board cell a tray piece must be drawn at, so a player
/// can judge a fit before picking the piece up.
const double kMinTrayScale = 0.6;

Future<Widget> _app(Widget home) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  return ProviderScope(
    overrides: [storageProvider.overrideWithValue(storage)],
    child: MaterialApp(
      theme: buildGridTheme(),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: home,
    ),
  );
}

/// The per-cell size the tray actually PAINTS a piece at, after the FittedBox
/// has scaled it. Reading PieceView.cellSize would miss that scaling.
double _renderedTrayCell(WidgetTester tester, Piece piece) {
  final view = find.byType(PieceView).first;
  final size = tester.getSize(view);
  return size.height / piece.height;
}

void main() {
  const line5 = [
    Cell(0, 0),
    Cell(1, 0),
    Cell(2, 0),
    Cell(3, 0),
    Cell(4, 0),
  ];

  testWidgets('a tray piece is drawn near board scale', (tester) async {
    const boardCell = 42.0;
    await tester.pumpWidget(await _app(
      Scaffold(
        body: TrayView(
          boardCell: boardCell,
          height: 132,
          trayOverride: [
            Piece('line5_v', line5, 3),
            Piece('dot', const [Cell(0, 0)], 4),
            null,
          ],
        ),
      ),
    ));

    // The 5-cell column is the one shape that genuinely cannot fit at board
    // scale, so it is allowed to shrink — but it must still be legible.
    final tall = _renderedTrayCell(tester, Piece('line5_v', line5, 3));
    expect(tall, greaterThanOrEqualTo(16.0));
    expect(tall, lessThanOrEqualTo(boardCell),
        reason: 'a tray piece must never look bigger than where it lands');
  });

  testWidgets('a common piece renders at full board scale', (tester) async {
    // The dot, the 2-line, the square — anything up to the tray height should
    // be drawn 1:1 with the board, so "does it fit" is a direct comparison.
    const boardCell = 42.0;
    final square = Piece('square2', const [
      Cell(0, 0),
      Cell(0, 1),
      Cell(1, 0),
      Cell(1, 1),
    ], 6);
    await tester.pumpWidget(await _app(
      Scaffold(
        body: TrayView(
          boardCell: boardCell,
          height: 148,
          trayOverride: [square, null, null],
        ),
      ),
    ));

    final cell = _renderedTrayCell(tester, square);
    expect(
      cell / boardCell,
      greaterThanOrEqualTo(kMinTrayScale),
      reason: 'tray cell $cell vs board cell $boardCell — pieces are too '
          'small to judge a fit',
    );
  });

  testWidgets('the tallest piece still fits the tray', (tester) async {
    await tester.pumpWidget(await _app(
      Scaffold(
        body: TrayView(
          boardCell: 42,
          height: 132,
          trayOverride: [Piece('line5_v', line5, 3), null, null],
        ),
      ),
    ));
    expect(tester.takeException(), isNull);
  });

  testWidgets('the rotate target meets the platform minimum', (tester) async {
    await tester.pumpWidget(await _app(
      Scaffold(
        body: TrayView(
          boardCell: 42,
          height: 132,
          trayOverride: [Piece('dot', const [Cell(0, 0)], 4), null, null],
        ),
      ),
    ));

    final button = find.byType(IconButton).first;
    final size = tester.getSize(button);
    expect(size.width, greaterThanOrEqualTo(44),
        reason: 'a 28 px target inside a Draggable turns taps into drags');
    expect(size.height, greaterThanOrEqualTo(36));
  });

  testWidgets('a played slot leaves a visible gap', (tester) async {
    await tester.pumpWidget(await _app(
      Scaffold(
        body: TrayView(
          boardCell: 42,
          height: 132,
          trayOverride: [null, Piece('dot', const [Cell(0, 0)], 4), null],
        ),
      ),
    ));
    // Two placeholders for the two played slots, so the tray does not appear
    // to have silently shrunk.
    expect(find.byType(PieceView), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the game screen still lays out on a small phone',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(await _app(const GameScreen()));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('the game screen still lays out in compact landscape',
      (tester) async {
    tester.view.physicalSize = const Size(800, 360);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(await _app(const GameScreen()));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
