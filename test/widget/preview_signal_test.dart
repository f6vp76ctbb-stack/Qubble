// The board tells the player one thing above all else while a piece is being
// dragged: does it fit here. Until the outline in board_view.dart that was
// carried by hue alone, which fails outright for anyone with a red-green
// deficiency -- the most common theme pairing -- and is thin even for
// everyone else: sunset puts its two previews at 1,20:1, fade at 1,12:1
// (measured in test/ui/board_contrast_test.dart).
//
// So the invalid preview draws a stroked outline on top of its fill. These
// tests pin the signal itself rather than any colour: an invalid preview
// strokes, a valid one does not.
//
// The painter is exercised through its own paint() against a recording canvas
// rather than the paints matcher, because that matcher anchors on the first
// canvas call and the board lays down 64 empty cells before it reaches the
// preview.
import 'dart:ui' show Canvas, PictureRecorder, RRect;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records the paint of every rounded rectangle and swallows everything else.
class _RecordingCanvas implements Canvas {
  final List<Paint> rrects = [];

  @override
  void drawRRect(RRect rrect, Paint paint) => rrects.add(paint);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

/// Pumps a board with a drag preview and returns the paints it draws.
Future<List<Paint>> previewPaints(
  WidgetTester tester, {
  required bool valid,
}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        dragPreviewProvider.overrideWith(
          (ref) => DragPreview(
            piece: Piece('probe', const [Cell(0, 0), Cell(0, 1)], 1),
            origin: const Cell(3, 3),
            valid: valid,
          ),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: BoardView(
              size: 320,
              board: Board.empty(),
              boardKey: GlobalKey(),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();

  final painter = tester
      .widget<CustomPaint>(
        find
            .descendant(
              of: find.byType(BoardView),
              matching: find.byType(CustomPaint),
            )
            .first,
      )
      .painter!;

  final canvas = _RecordingCanvas();
  painter.paint(canvas, const Size(320, 320));
  // Keeps the real Canvas API honest: if the painter ever needs a method the
  // recorder swallows, this catches the divergence rather than hiding it.
  painter.paint(Canvas(PictureRecorder()), const Size(320, 320));
  return canvas.rrects;
}

void main() {
  testWidgets('an invalid preview is outlined, not just tinted', (
    tester,
  ) async {
    final paints = await previewPaints(tester, valid: false);
    final strokes = paints.where((p) => p.style == PaintingStyle.stroke);

    // Two cells in the probe piece, so two outlines.
    expect(strokes.length, 2);
    expect(strokes.every((p) => p.strokeWidth > 0), isTrue);
  });

  testWidgets('a valid preview stays a flat fill', (tester) async {
    final paints = await previewPaints(tester, valid: true);

    // The common case must not gain visual noise: the outline works as a
    // signal precisely because it is absent when the piece fits.
    expect(paints.where((p) => p.style == PaintingStyle.stroke), isEmpty);
  });

  testWidgets('the outline is fully opaque against its own faint fill', (
    tester,
  ) async {
    final paints = await previewPaints(tester, valid: false);
    final stroke = paints.firstWhere((p) => p.style == PaintingStyle.stroke);

    // The fill is drawn at ~40 % alpha. An outline at the same alpha would be
    // the same colour at the same weight and read as nothing at all.
    expect(stroke.color.a, 1.0);
  });
}
