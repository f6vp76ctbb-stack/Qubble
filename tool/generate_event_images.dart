/// Renders the images for the Play Store Halloween event (promotional
/// content) from the game's own painters: the pumpkin theme's colours and
/// the ghost skin.
///
/// Not a test — it lives outside `test/` so `flutter test` never picks it up.
/// Run it explicitly:
///
/// ```bash
/// flutter test tool/generate_event_images.dart
/// ```
///
/// Output: `store-assets/event-halloween/` — a landscape image (1920×1080)
/// and a square one (1080×1080), each as PNG and JPG. No text on them: the
/// Play guidelines ask for event images without a logo, slogan or event name.
library;

import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/seasonal.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/cell_style.dart';
import 'package:image/image.dart' as img;

const _outDir = 'store-assets/event-halloween';

/// The board: a jack-o'-lantern in ghost blocks. O = pumpkin orange,
/// G = slime-green stem, . = empty (the eyes and the grin are holes).
const _board = [
  '...GG...',
  '.OOOOOO.',
  'OOOOOOOO',
  'O..OO..O',
  'OOOOOOOO',
  'O.O..O.O',
  '.OOOOOO.',
  '........',
];

GameTheme get _theme =>
    kThemeCatalog.firstWhere((t) => t.id == kHalloweenThemeId).theme;

Color _colorFor(String c, GameTheme t) => switch (c) {
  'O' => t.traySlots[0],
  'P' => t.traySlots[1],
  'G' => t.traySlots[2],
  _ => t.emptyCell,
};

void _paintBackground(Canvas canvas, Size size) {
  final t = _theme;
  final rect = Offset.zero & size;
  canvas.drawRect(
    rect,
    Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF221335), Color(0xFF0B0710)],
      ).createShader(rect),
  );
  // Purple fog along the bottom.
  canvas.drawOval(
    Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 1.02),
      width: size.width * 1.3,
      height: size.height * 0.5,
    ),
    Paint()
      ..color = t.traySlots[1].withValues(alpha: 0.22)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.height * 0.08),
  );
  // Stars, the same every run.
  final rnd = math.Random(31);
  for (var i = 0; i < 90; i++) {
    final p = Offset(
      rnd.nextDouble() * size.width,
      rnd.nextDouble() * size.height * 0.7,
    );
    canvas.drawCircle(
      p,
      size.shortestSide * (0.0015 + rnd.nextDouble() * 0.0025),
      Paint()..color = Colors.white.withValues(alpha: 0.25 + rnd.nextDouble() * 0.5),
    );
  }
}

void _paintMoon(Canvas canvas, Offset center, double r) {
  canvas.drawCircle(
    center,
    r * 1.6,
    Paint()
      ..color = const Color(0xFFFFE6A8).withValues(alpha: 0.28)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.6),
  );
  canvas.drawCircle(center, r, Paint()..color = const Color(0xFFFFF1C9));
  // A few craters.
  final crater = Paint()..color = const Color(0xFFF1DDA6);
  canvas.drawCircle(center + Offset(-r * 0.3, -r * 0.2), r * 0.18, crater);
  canvas.drawCircle(center + Offset(r * 0.32, r * 0.25), r * 0.12, crater);
  canvas.drawCircle(center + Offset(r * 0.05, r * 0.45), r * 0.08, crater);
}

void _paintBoard(Canvas canvas, Rect area) {
  final t = _theme;
  final pad = area.width * 0.035;
  final outer = RRect.fromRectAndRadius(area, Radius.circular(area.width * 0.05));
  canvas.drawRRect(
    outer.shift(Offset(0, area.width * 0.02)),
    Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, area.width * 0.03),
  );
  canvas.drawRRect(outer, Paint()..color = t.boardBackground);
  final inner = area.deflate(pad);
  final cell = inner.width / 8;
  final gap = cell * 0.08;
  for (var r = 0; r < 8; r++) {
    for (var c = 0; c < 8; c++) {
      final ch = _board[r][c];
      final rect = Rect.fromLTWH(
        inner.left + c * cell + gap / 2,
        inner.top + r * cell + gap / 2,
        cell - gap,
        cell - gap,
      );
      final radius = rect.width * 0.22;
      if (ch == '.') {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(radius)),
          Paint()..color = t.emptyCell,
        );
      } else {
        paintCell(
          canvas,
          rect,
          radius,
          _colorFor(ch, t),
          BlockSkinStyle.ghost,
          phase: (r + c).toDouble(),
        );
      }
    }
  }
}

/// A tray piece in ghost blocks, cells given as (row, col).
void _paintPiece(
  Canvas canvas,
  Offset topLeft,
  double cell,
  List<(int, int)> cells,
  Color color,
) {
  final gap = cell * 0.08;
  canvas.drawCircle(
    topLeft + Offset(cell, cell),
    cell * 1.6,
    Paint()
      ..color = color.withValues(alpha: 0.18)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, cell * 0.8),
  );
  for (final (r, c) in cells) {
    final rect = Rect.fromLTWH(
      topLeft.dx + c * cell + gap / 2,
      topLeft.dy + r * cell + gap / 2,
      cell - gap,
      cell - gap,
    );
    paintCell(
      canvas,
      rect,
      rect.width * 0.22,
      color,
      BlockSkinStyle.ghost,
      phase: (r * 3 + c).toDouble(),
    );
  }
}

void _paintLandscape(Canvas canvas, Size size) {
  final t = _theme;
  _paintBackground(canvas, size);
  _paintMoon(canvas, Offset(size.width * 0.86, size.height * 0.2), 95);
  const side = 820.0;
  _paintBoard(
    canvas,
    Rect.fromLTWH(size.width * 0.33 - side / 2, (size.height - side) / 2, side, side),
  );
  const cell = 92.0;
  _paintPiece(canvas, const Offset(1180, 330), cell, const [
    (0, 0), (0, 1), (0, 2), (1, 1),
  ], t.traySlots[1]);
  _paintPiece(canvas, const Offset(1520, 520), cell, const [
    (0, 0), (1, 0), (2, 0), (2, 1),
  ], t.traySlots[2]);
  _paintPiece(canvas, const Offset(1230, 640), cell, const [
    (0, 0), (0, 1), (1, 0), (1, 1),
  ], t.traySlots[0]);
}

void _paintSquare(Canvas canvas, Size size) {
  final t = _theme;
  _paintBackground(canvas, size);
  _paintMoon(canvas, Offset(size.width * 0.83, size.height * 0.15), 80);
  const side = 700.0;
  _paintBoard(
    canvas,
    Rect.fromLTWH((size.width - side) / 2, size.height * 0.29, side, side),
  );
  const cell = 64.0;
  _paintPiece(canvas, const Offset(70, 70), cell, const [
    (0, 0), (0, 1), (0, 2), (1, 1),
  ], t.traySlots[1]);
  _paintPiece(canvas, const Offset(480, 90), cell, const [
    (0, 0), (0, 1), (1, 0), (1, 1),
  ], t.traySlots[2]);
}

Future<void> _render(
  WidgetTester tester,
  String name,
  Size size,
  void Function(Canvas, Size) paint,
) async {
  final recorder = ui.PictureRecorder();
  paint(Canvas(recorder), size);
  final picture = recorder.endRecording();
  final bytes = await tester.runAsync(() async {
    final image = await picture.toImage(size.width.toInt(), size.height.toInt());
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  });
  Directory(_outDir).createSync(recursive: true);
  File('$_outDir/$name.png').writeAsBytesSync(bytes!);
  final decoded = img.decodePng(bytes)!;
  File('$_outDir/$name.jpg').writeAsBytesSync(img.encodeJpg(decoded, quality: 92));
}

void main() {
  testWidgets('Halloween event images', (tester) async {
    await _render(tester, 'halloween-1920x1080', const Size(1920, 1080), _paintLandscape);
    await _render(tester, 'halloween-1080x1080', const Size(1080, 1080), _paintSquare);
  });
}
