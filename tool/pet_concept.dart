/// Concept art for the planned pets, the "Qubbies" (MASTERPLAN.md Phase 8):
/// the roster, the dragon's three stages, the cat's moods, the dragon's
/// flight over a full row, the signature effects, and mockups of a store
/// screenshot, a feature graphic and an event image.
///
/// Every creature is drawn here with Canvas paths: no image assets, no
/// downloads (CLAUDE.md: only self-made or CC0 art). The board, the blocks and
/// the row effects come from the game's own painters (`paintCell`,
/// `paintClearSweep`), so the mockups look like the real thing.
///
/// Not a test: it lives outside `test/` so `flutter test` never picks it up.
/// Run it explicitly:
///
/// ```bash
/// flutter test tool/pet_concept.dart
/// PET_ONLY=roster flutter test tool/pet_concept.dart   # one image only
/// ```
///
/// Output: `docs/haustiere/*.png`. Concept art only: nothing here ships in
/// the app, and the store and event images are mockups, not upload-ready.
library;

import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/clear_effect.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/cell_style.dart';
import 'package:gridpop/ui/widgets/clear_sweep.dart';

const _outDir = 'docs/haustiere';

// ---------------------------------------------------------------------------
// Small drawing helpers
// ---------------------------------------------------------------------------

const _ink = Color(0xFF2A2142);
const _white = Color(0xFFFFFFFF);
const _black = Color(0xFF000000);

Paint _fill(Color c) => Paint()..color = c;

Paint _stroke(Color c, double width) => Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = width
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..color = c;

Paint _blur(Color c, double sigma) => Paint()
  ..color = c
  ..maskFilter = MaskFilter.blur(BlurStyle.normal, math.max(0.1, sigma));

Paint _grad(
  Rect r,
  List<Color> colors, {
  Alignment begin = Alignment.topCenter,
  Alignment end = Alignment.bottomCenter,
  List<double>? stops,
}) => Paint()
  ..shader = LinearGradient(
    begin: begin,
    end: end,
    colors: colors,
    stops: stops,
  ).createShader(r);

Color _mix(Color a, Color b, double t) => Color.lerp(a, b, t)!;

Offset _bez(Offset a, Offset b, Offset c, Offset d, double t) {
  final u = 1 - t;
  return a * (u * u * u) +
      b * (3 * u * u * t) +
      c * (3 * u * t * t) +
      d * (t * t * t);
}

List<Offset> _cubicPts(Offset a, Offset b, Offset c, Offset d, [int n = 28]) =>
    [for (var i = 0; i <= n; i++) _bez(a, b, c, d, i / n)];

/// A filled stroke along [pts] whose width runs from [w0] to [w1], with a
/// round end.
Path _taper(List<Offset> pts, double w0, double w1) {
  final left = <Offset>[];
  final right = <Offset>[];
  for (var i = 0; i < pts.length; i++) {
    final a = pts[math.max(0, i - 1)];
    final b = pts[math.min(pts.length - 1, i + 1)];
    final d = b - a;
    final len = d.distance == 0 ? 1.0 : d.distance;
    final n = Offset(-d.dy / len, d.dx / len);
    final hw = (w0 + (w1 - w0) * i / (pts.length - 1)) / 2;
    left.add(pts[i] + n * hw);
    right.add(pts[i] - n * hw);
  }
  final path = Path()..moveTo(left.first.dx, left.first.dy);
  for (final p in left.skip(1)) {
    path.lineTo(p.dx, p.dy);
  }
  if (w1 > 0) {
    path.arcToPoint(
      right.last,
      radius: Radius.circular(w1 / 2),
      clockwise: false,
    );
  }
  for (final p in right.reversed) {
    path.lineTo(p.dx, p.dy);
  }
  return path..close();
}

/// A triangle with a rounded [tip]; its base a–b is usually hidden behind
/// the body.
Path _roundTri(Offset a, Offset tip, Offset b, [double round = 0.22]) {
  final p1 = Offset.lerp(tip, a, round)!;
  final p2 = Offset.lerp(tip, b, round)!;
  return Path()
    ..moveTo(a.dx, a.dy)
    ..lineTo(p1.dx, p1.dy)
    ..quadraticBezierTo(tip.dx, tip.dy, p2.dx, p2.dy)
    ..lineTo(b.dx, b.dy)
    ..close();
}

/// A polygon from unit points, placed at [o] and scaled by [sx]/[sy].
Path _poly(List<(double, double)> pts, Offset o, double sx, [double? sy]) {
  final path = Path();
  for (var i = 0; i < pts.length; i++) {
    final (x, y) = pts[i];
    final p = Offset(o.dx + x * sx, o.dy + y * (sy ?? sx));
    i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
  }
  return path..close();
}

/// A four-pointed sparkle.
Path _star4(Offset c, double r, [double waist = 0.22]) {
  final w = r * waist;
  return Path()
    ..moveTo(c.dx, c.dy - r)
    ..quadraticBezierTo(c.dx + w, c.dy - w, c.dx + r, c.dy)
    ..quadraticBezierTo(c.dx + w, c.dy + w, c.dx, c.dy + r)
    ..quadraticBezierTo(c.dx - w, c.dy + w, c.dx - r, c.dy)
    ..quadraticBezierTo(c.dx - w, c.dy - w, c.dx, c.dy - r)
    ..close();
}

Path _heart(Offset c, double s) => Path()
  ..moveTo(c.dx, c.dy + s * 0.42)
  ..cubicTo(
    c.dx - s * 0.95,
    c.dy - s * 0.2,
    c.dx - s * 0.5,
    c.dy - s * 0.95,
    c.dx,
    c.dy - s * 0.42,
  )
  ..cubicTo(
    c.dx + s * 0.5,
    c.dy - s * 0.95,
    c.dx + s * 0.95,
    c.dy - s * 0.2,
    c.dx,
    c.dy + s * 0.42,
  )
  ..close();

/// A glowing sparkle: soft halo, coloured star, white core.
void _sparkle(Canvas c, Offset at, double r, Color color, [double alpha = 1]) {
  c
    ..drawCircle(at, r * 0.9, _blur(color.withValues(alpha: 0.45 * alpha), r * 0.5))
    ..drawPath(_star4(at, r), _fill(color.withValues(alpha: alpha)))
    ..drawPath(_star4(at, r * 0.55), _fill(_white.withValues(alpha: alpha)));
}

// ---------------------------------------------------------------------------
// Text (Nunito, loaded from the repo's own font file)
// ---------------------------------------------------------------------------

Future<void> _loadFonts() async {
  final bytes = File('assets/fonts/Nunito.ttf').readAsBytesSync();
  final loader = FontLoader('Nunito')
    ..addFont(Future.value(ByteData.sublistView(bytes)));
  await loader.load();
}

/// Nunito at [weight]. The font is variable and its default instance is
/// Light, so the weight goes onto the `wght` axis as well.
TextStyle _nunito(
  double size,
  Color color, {
  int weight = 800,
  double spacing = 0,
  double height = 1.12,
  List<Shadow>? shadows,
}) => TextStyle(
  fontFamily: 'Nunito',
  fontSize: size,
  color: color,
  fontWeight: FontWeight(weight),
  fontVariations: [FontVariation('wght', weight.toDouble())],
  letterSpacing: spacing,
  height: height,
  shadows: shadows,
);

/// Paints [text] with its top at [at]; returns its size. [tail] is painted
/// right after it in [tailColor] (the wordmark's dot).
Size _text(
  Canvas c,
  String text,
  Offset at,
  double size,
  Color color, {
  int weight = 800,
  double spacing = 0,
  TextAlign align = TextAlign.left,
  double height = 1.12,
  List<Shadow>? shadows,
  String? tail,
  Color? tailColor,
}) {
  final style = _nunito(
    size,
    color,
    weight: weight,
    spacing: spacing,
    height: height,
    shadows: shadows,
  );
  final tp = TextPainter(
    text: TextSpan(
      text: text,
      style: style,
      children: [
        if (tail != null)
          TextSpan(text: tail, style: style.copyWith(color: tailColor)),
      ],
    ),
    textAlign: align,
    textDirection: TextDirection.ltr,
  )..layout();
  final dx = switch (align) {
    TextAlign.center => at.dx - tp.width / 2,
    TextAlign.right => at.dx - tp.width,
    _ => at.dx,
  };
  tp.paint(c, Offset(dx, at.dy));
  final out = tp.size;
  tp.dispose();
  return out;
}

// ---------------------------------------------------------------------------
// The Qubbies
// ---------------------------------------------------------------------------

enum _Species {
  cat,
  dog,
  slime,
  dragon,
  penguin,
  thunderbird,
  owl,
  unicorn,
  phoenix,
  golden,
}

enum _Stage { baby, junior, adult }

enum _Eyes { open, happy, closed, squint, worried, fierce }

enum _Mouth { smile, grin, o, breath, wavy }

/// What a Qubbie is doing.
class _Pose {
  const _Pose({
    this.eyes = _Eyes.open,
    this.mouth = _Mouth.smile,
    this.wing = 0,
    this.look = Offset.zero,
    this.turn = 0,
    this.tilt = 0,
    this.facing = 1,
    this.flying = false,
    this.sweat = false,
    this.zzz = false,
    this.squash = 0,
    this.shadow = true,
  });

  final _Eyes eyes;
  final _Mouth mouth;

  /// -1 wings down, 0 at rest, 1 up.
  final double wing;

  /// Where the pupils point, -1..1 on each axis.
  final Offset look;

  /// 0 faces the viewer, 1 turns the face towards where it is facing.
  final double turn;

  /// Radians, clockwise.
  final double tilt;

  /// 1 faces right, -1 faces left (the art is mirrored).
  final double facing;
  final bool flying;
  final bool sweat;
  final bool zzz;

  /// Positive is wider and flatter.
  final double squash;
  final bool shadow;
}

/// A species' colours.
class _Look {
  const _Look({
    required this.top,
    required this.bottom,
    required this.line,
    required this.iris,
    required this.glow,
    this.blush = const Color(0xFFFF8FB3),
    this.body,
    this.stops,
  });

  final Color top;
  final Color bottom;
  final Color line;
  final Color iris;
  final Color glow;
  final Color blush;

  /// A body gradient of more than two colours (metal, gold).
  final List<Color>? body;
  final List<double>? stops;

  Color get mid => _mix(top, bottom, 0.5);
  Color get shade => _mix(bottom, line, 0.3);
}

const Map<_Species, _Look> _looks = {
  _Species.cat: _Look(
    top: Color(0xFFA2F7E2),
    bottom: Color(0xFF3FCDAF),
    line: Color(0xFF1C6F66),
    iris: Color(0xFF2CC7A8),
    glow: Color(0xFF4FE0C6),
  ),
  _Species.dog: _Look(
    top: Color(0xFFFFCB85),
    bottom: Color(0xFFF2892F),
    line: Color(0xFF8A4214),
    iris: Color(0xFFC0672A),
    glow: Color(0xFFFF9F43),
  ),
  _Species.slime: _Look(
    top: Color(0xFFE6FFA0),
    bottom: Color(0xFF8DD63B),
    line: Color(0xFF468A1B),
    iris: Color(0xFF66BB2A),
    glow: Color(0xFFB4F05A),
  ),
  _Species.dragon: _Look(
    top: Color(0xFFFF9A84),
    bottom: Color(0xFFE5474D),
    line: Color(0xFF861C2E),
    iris: Color(0xFFFF8A3D),
    glow: Color(0xFFFF6B5B),
    blush: Color(0xFFFFC4D0),
  ),
  _Species.penguin: _Look(
    top: Color(0xFF93D9FF),
    bottom: Color(0xFF3F92E3),
    line: Color(0xFF1A4C8A),
    iris: Color(0xFF4FA8F0),
    glow: Color(0xFF6EC8FF),
  ),
  _Species.thunderbird: _Look(
    top: Color(0xFFFFEE85),
    bottom: Color(0xFFFFB524),
    line: Color(0xFF94570A),
    iris: Color(0xFF8B5CF6),
    glow: Color(0xFFFFD43B),
    blush: Color(0xFFFFA0A8),
  ),
  _Species.owl: _Look(
    top: Color(0xFFEEF3F8),
    bottom: Color(0xFF7488A0),
    line: Color(0xFF34445A),
    iris: Color(0xFF3FE6D6),
    glow: Color(0xFF3FE6D6),
    body: [
      Color(0xFFF1F5F9),
      Color(0xFFC6D2DE),
      Color(0xFF93A5B9),
      Color(0xFF6C8098),
    ],
    stops: [0, 0.38, 0.72, 1],
  ),
  _Species.unicorn: _Look(
    top: Color(0xFFFFFFFF),
    bottom: Color(0xFFDCCBFF),
    line: Color(0xFF8B70CC),
    iris: Color(0xFFB07CFF),
    glow: Color(0xFFC4A7FF),
    blush: Color(0xFFFF9FC8),
  ),
  _Species.phoenix: _Look(
    top: Color(0xFFFFD764),
    bottom: Color(0xFFFF7A22),
    line: Color(0xFFA2380A),
    iris: Color(0xFFFF5A1F),
    glow: Color(0xFFFF9A2E),
    blush: Color(0xFFFF8F9A),
  ),
  _Species.golden: _Look(
    top: Color(0xFFFFF6C4),
    bottom: Color(0xFFD99520),
    line: Color(0xFF8E550C),
    iris: Color(0xFFB8761A),
    glow: Color(0xFFFFC24B),
    blush: Color(0xFFFF9F9F),
    body: [
      Color(0xFFFFF8D2),
      Color(0xFFFFDC6E),
      Color(0xFFF2B232),
      Color(0xFFC9851C),
    ],
    stops: [0, 0.36, 0.7, 1],
  ),
};

const _violet = Color(0xFF8E5CF6);
const _violetLight = Color(0xFFB792FF);
const _violetLine = Color(0xFF4C2A9A);
const _beakTop = Color(0xFFFFC23D);
const _beakBottom = Color(0xFFF0921C);
const _beakLine = Color(0xFFA85A0C);
const _teal = Color(0xFF3FE6D6);
const _cream = Color(0xFFFFF0D2);
const _gold = Color(0xFFFFC24B);
const _goldDeep = Color(0xFFE09A1E);
const _goldLine = Color(0xFF9A5E0A);
const _rainbow = [
  Color(0xFFFF8DB8),
  Color(0xFFFFB877),
  Color(0xFFFFE27A),
  Color(0xFF8FF0C2),
  Color(0xFF8CC8FF),
  Color(0xFFC3A0FF),
];

/// The geometry of one Qubbie in its local frame: the origin is the middle
/// of the body's bottom edge, the body spans x = ±w/2 and y = -h..0, and +x
/// is the way it faces.
class _G {
  _G(this.species, this.stage, this.pose, this.size);

  final _Species species;
  final _Stage stage;
  final _Pose pose;

  /// The adult body width at this scale; line weights follow it, so the
  /// stages share one line weight.
  final double size;

  _Look get look => _looks[species]!;
  int get s => stage.index;
  double get scale => const [0.64, 0.82, 1.0][s];
  double get w => size * scale * (1 + pose.squash);
  double get h => size * scale * const [0.86, 0.89, 0.92][s] * (1 - pose.squash);
  double get radius => w * const [0.4, 0.33, 0.28][s];
  double get lw => size * 0.026;

  /// How grown the appendages are: horns, wings, tails.
  double get grow => const [0.36, 0.68, 1.0][s];

  /// Mirrors the art's x, so the light stays top left whichever way it faces.
  double get lightX => pose.facing;
  double get fx => pose.turn * w * 0.08;

  bool get beaked =>
      species == _Species.penguin ||
      species == _Species.thunderbird ||
      species == _Species.owl ||
      species == _Species.phoenix;
  bool get _faceHigh => beaked || species == _Species.dragon;

  double get ew => w * const [0.29, 0.26, 0.235][s];
  double get eh => ew * 1.14;
  double get ex => w * const [0.205, 0.2, 0.195][s];
  double get ey => -h * ((_faceHigh ? 0.58 : 0.53) - const [0.03, 0.01, 0][s]);
  double get my => -h * (species == _Species.dog
      ? 0.27
      : _faceHigh
      ? 0.4
      : 0.33);

  Rect get bodyRect => Rect.fromLTRB(-w / 2, -h, w / 2, 0);
  RRect get bodyRRect =>
      RRect.fromRectAndRadius(bodyRect, Radius.circular(radius));
}

/// Where the parts of a painted Qubbie ended up, in canvas coordinates.
class _Anchors {
  const _Anchors({
    required this.mouth,
    required this.eyeL,
    required this.eyeR,
    required this.center,
    required this.w,
    required this.h,
  });

  final Offset mouth;
  final Offset eyeL;
  final Offset eyeR;
  final Offset center;
  final double w;
  final double h;
}

/// Paints a Qubbie standing (or hovering) with the middle of its body's
/// bottom edge at [at]; [size] is the adult body width.
_Anchors _paintPet(
  Canvas c,
  _Species species,
  Offset at,
  double size, {
  _Stage stage = _Stage.adult,
  _Pose pose = const _Pose(),
}) {
  final g = _G(species, stage, pose, size);
  if (pose.shadow && !pose.flying) {
    c.drawOval(
      Rect.fromCenter(
        center: at + Offset(0, g.h * 0.015),
        width: g.w * 1.05,
        height: g.w * 0.17,
      ),
      _blur(_black.withValues(alpha: 0.42), g.w * 0.035),
    );
  }
  c
    ..save()
    ..translate(at.dx, at.dy - g.h / 2)
    ..rotate(pose.tilt)
    ..scale(pose.facing, 1)
    ..translate(0, g.h / 2);
  _aura(c, g);
  _back(c, g);
  _feet(c, g);
  _body(c, g);
  _front(c, g);
  _face(c, g);
  _top(c, g);
  _extras(c, g);
  c.restore();

  Offset toCanvas(Offset p) {
    final q = Offset(p.dx * pose.facing, p.dy + g.h / 2);
    final cs = math.cos(pose.tilt);
    final sn = math.sin(pose.tilt);
    return Offset(
      at.dx + q.dx * cs - q.dy * sn,
      at.dy - g.h / 2 + q.dx * sn + q.dy * cs,
    );
  }

  return _Anchors(
    mouth: toCanvas(Offset(g.fx, g.my + g.w * 0.02)),
    eyeL: toCanvas(Offset(g.fx - g.ex, g.ey)),
    eyeR: toCanvas(Offset(g.fx + g.ex, g.ey)),
    center: toCanvas(Offset(0, -g.h / 2)),
    w: g.w,
    h: g.h,
  );
}

/// Fills [p] and outlines it in the species' line colour.
void _part(
  Canvas c,
  _G g,
  Path p, {
  Color? color,
  List<Color>? colors,
  Alignment begin = Alignment.topCenter,
  Alignment end = Alignment.bottomCenter,
  Color? line,
  double lineScale = 1,
}) {
  final paint = colors != null
      ? _grad(p.getBounds(), colors, begin: begin, end: end)
      : _fill(color ?? g.look.mid);
  c
    ..drawPath(p, paint)
    ..drawPath(p, _stroke(line ?? g.look.line, g.lw * lineScale));
}

/// Gives a flat-filled [shape] the body's volume: darker bottom right, lit
/// top left, a soft highlight.
void _shade(Canvas c, _G g, Path shape, {double opacity = 1}) {
  final look = g.look;
  final rect = shape.getBounds();
  final colors = look.body ?? [look.top, look.bottom];
  c
    ..drawPath(shape, _fill(look.shade.withValues(alpha: opacity)))
    ..save()
    ..clipPath(shape)
    ..drawPath(
      shape.shift(Offset(-g.w * 0.045 * g.lightX, -g.h * 0.06)),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [for (final col in colors) col.withValues(alpha: opacity)],
          stops: look.stops,
        ).createShader(rect)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, g.w * 0.03),
    )
    ..drawOval(
      Rect.fromCenter(
        center: Offset(-g.w * 0.17 * g.lightX, -g.h * 0.8),
        width: g.w * 0.5,
        height: g.h * 0.26,
      ),
      _blur(_white.withValues(alpha: 0.3 * opacity), g.w * 0.06),
    );
  // A small glossy highlight, like on a toy.
  c
    ..save()
    ..translate(-g.w * 0.31 * g.lightX, -g.h * 0.83)
    ..rotate(-0.75 * g.lightX)
    ..drawOval(
      Rect.fromCenter(center: Offset.zero, width: g.w * 0.13, height: g.w * 0.06),
      _fill(_white.withValues(alpha: 0.6 * opacity)),
    )
    ..restore()
    ..restore()
    ..drawPath(shape, _stroke(look.line, g.lw));
}

void _aura(Canvas c, _G g) {
  final color = switch (g.species) {
    _Species.phoenix => const Color(0xFFFF8A2A),
    _Species.golden => _gold,
    _ => null,
  };
  if (color == null) return;
  c.drawCircle(
    Offset(0, -g.h * 0.55),
    g.w * 0.8,
    _blur(color.withValues(alpha: 0.32), g.w * 0.28),
  );
}

void _back(Canvas c, _G g) {
  switch (g.species) {
    case _Species.cat:
      _catTail(c, g);
      _catEars(c, g);
    case _Species.dog:
      _dogTail(c, g);
    case _Species.slime:
      c.drawOval(
        Rect.fromCenter(
          center: Offset(0, g.h * 0.03),
          width: g.w * 1.1,
          height: g.w * 0.16,
        ),
        _fill(g.look.bottom.withValues(alpha: 0.45)),
      );
    case _Species.dragon:
      _dragonTail(c, g);
      _batWing(c, g, -1);
      _batWing(c, g, 1);
      _dragonHorns(c, g);
    case _Species.penguin:
      _flipper(c, g, -1);
      _flipper(c, g, 1);
      _penguinTuft(c, g);
    case _Species.thunderbird:
      _zigTail(c, g);
      _featherWing(c, g, -1, _Feather.zig);
      _featherWing(c, g, 1, _Feather.zig);
      _zigCrest(c, g);
    case _Species.owl:
      _featherWing(c, g, -1, _Feather.metal);
      _featherWing(c, g, 1, _Feather.metal);
      _owlTufts(c, g);
      _antenna(c, g);
    case _Species.unicorn:
      _unicornTail(c, g);
      _maneBack(c, g);
      _unicornEars(c, g);
      _unicornHorn(c, g);
    case _Species.phoenix:
      _phoenixTail(c, g);
      _featherWing(c, g, -1, _Feather.flame);
      _featherWing(c, g, 1, _Feather.flame);
      _flameCrest(c, g);
    case _Species.golden:
      _catEars(c, g, gold: true);
  }
}

void _feet(Canvas c, _G g) {
  switch (g.species) {
    case _Species.slime:
      return;
    case _Species.penguin || _Species.thunderbird || _Species.phoenix:
      _birdFeet(c, g, _beakBottom, _beakLine);
    case _Species.owl:
      _birdFeet(c, g, const Color(0xFF8293A8), g.look.line);
    case _Species.unicorn:
      _nubFeet(c, g, const Color(0xFFCDB8FF));
    default:
      _nubFeet(c, g, g.look.shade);
  }
}

void _nubFeet(Canvas c, _G g, Color color) {
  final drop = g.pose.flying ? g.h * 0.05 : 0.0;
  for (final side in const [-1.0, 1.0]) {
    final r = Rect.fromCenter(
      center: Offset(side * g.w * 0.21, -g.h * 0.005 + drop),
      width: g.w * 0.21,
      height: g.w * 0.14,
    );
    c
      ..drawOval(r, _fill(color))
      ..drawOval(r, _stroke(g.look.line, g.lw));
  }
}

void _birdFeet(Canvas c, _G g, Color color, Color line) {
  final drop = g.pose.flying ? g.h * 0.05 : 0.0;
  for (final side in const [-1.0, 1.0]) {
    final base = Offset(side * g.w * 0.17, -g.h * 0.02 + drop);
    final toe = g.w * 0.075;
    final foot = Path()
      ..moveTo(base.dx - toe * 1.3, base.dy + toe * 0.9)
      ..quadraticBezierTo(base.dx - toe * 0.9, base.dy - toe * 0.6, base.dx, base.dy - toe * 0.6)
      ..quadraticBezierTo(base.dx + toe * 0.9, base.dy - toe * 0.6, base.dx + toe * 1.3, base.dy + toe * 0.9)
      ..quadraticBezierTo(base.dx + toe * 0.9, base.dy + toe * 0.55, base.dx + toe * 0.45, base.dy + toe * 1.0)
      ..quadraticBezierTo(base.dx, base.dy + toe * 0.6, base.dx - toe * 0.45, base.dy + toe * 1.0)
      ..quadraticBezierTo(base.dx - toe * 0.9, base.dy + toe * 0.55, base.dx - toe * 1.3, base.dy + toe * 0.9)
      ..close();
    c
      ..drawPath(foot, _fill(color))
      ..drawPath(foot, _stroke(line, g.lw * 0.9));
  }
}

void _body(Canvas c, _G g) {
  if (g.species == _Species.slime) {
    _shade(c, g, _slimeShape(g), opacity: 0.9);
    return;
  }
  _shade(c, g, Path()..addRRect(g.bodyRRect));
}

void _front(Canvas c, _G g) {
  switch (g.species) {
    case _Species.cat:
      _catStripes(c, g);
      _paws(c, g, _mix(g.look.top, _white, 0.45));
    case _Species.dog:
      _dogPatch(c, g);
      _dogMuzzle(c, g);
      _paws(c, g, const Color(0xFFFFE9CF));
      _dogEars(c, g);
    case _Species.slime:
      _slimeInner(c, g);
    case _Species.dragon:
      _bellyPlate(c, g);
    case _Species.penguin:
      _penguinBelly(c, g);
    case _Species.thunderbird:
      _birdBelly(c, g, const Color(0xFFFFF8D6), const Color(0xFFFFE08A));
      _boltMark(c, g);
    case _Species.owl:
      _owlFace(c, g);
    case _Species.unicorn:
      break;
    case _Species.phoenix:
      _birdBelly(c, g, const Color(0xFFFFF2B0), const Color(0xFFFFC84E));
    case _Species.golden:
      _goldShine(c, g);
      _paws(c, g, const Color(0xFFFFF0B8));
  }
}

void _face(Canvas c, _G g) {
  // Blush first, so the eyes sit over it.
  if (g.species != _Species.owl) {
    for (final side in const [-1.0, 1.0]) {
      c.drawOval(
        Rect.fromCenter(
          center: Offset(g.fx + side * g.w * 0.335, g.ey + g.eh * 0.66),
          width: g.w * 0.15,
          height: g.w * 0.085,
        ),
        _blur(g.look.blush.withValues(alpha: 0.62), g.w * 0.012),
      );
    }
  }
  for (final side in const [-1.0, 1.0]) {
    final ctr = Offset(g.fx + side * g.ex, g.ey);
    if (g.species == _Species.owl) {
      _visorEye(c, g, ctr, side);
    } else {
      _eye(c, g, ctr, side);
    }
  }
  _mouth(c, g);
  if (g.species == _Species.cat) _whiskers(c, g);
}

void _top(Canvas c, _G g) {
  switch (g.species) {
    case _Species.penguin:
      _scarf(c, g);
    case _Species.unicorn:
      _bangs(c, g);
    case _Species.golden:
      _crown(c, g);
    default:
      break;
  }
}

void _extras(Canvas c, _G g) {
  if (g.pose.sweat) {
    final at = Offset(g.fx + g.w * 0.44, -g.h * 0.86);
    final s = g.w * 0.085;
    final drop = Path()
      ..moveTo(at.dx, at.dy - s * 1.35)
      ..cubicTo(at.dx + s * 0.25, at.dy - s * 0.7, at.dx + s, at.dy - s * 0.1, at.dx + s, at.dy + s * 0.35)
      ..arcToPoint(Offset(at.dx - s, at.dy + s * 0.35), radius: Radius.circular(s), clockwise: true)
      ..cubicTo(at.dx - s, at.dy - s * 0.1, at.dx - s * 0.25, at.dy - s * 0.7, at.dx, at.dy - s * 1.35)
      ..close();
    c
      ..drawPath(drop, _grad(drop.getBounds(), const [Color(0xFFE6F7FF), Color(0xFF8FD3FF)]))
      ..drawPath(drop, _stroke(const Color(0xFF3B86C9), g.lw * 0.85))
      ..drawOval(
        Rect.fromCenter(center: at + Offset(-s * 0.35, s * 0.15), width: s * 0.32, height: s * 0.5),
        _fill(_white.withValues(alpha: 0.9)),
      );
  }
  if (g.pose.zzz) {
    // Drawn with x times the facing, so the canvas mirror turns it back into
    // a proper Z.
    final f = g.pose.facing;
    var at = Offset(g.w * 0.5 * f, -g.h * 1.02);
    var s = g.w * 0.1;
    for (var i = 0; i < 3; i++) {
      final z = Path()
        ..moveTo(at.dx - s / 2 * f, at.dy - s / 2)
        ..lineTo(at.dx + s / 2 * f, at.dy - s / 2)
        ..lineTo(at.dx - s / 2 * f, at.dy + s / 2)
        ..lineTo(at.dx + s / 2 * f, at.dy + s / 2);
      c
        ..drawPath(z, _stroke(const Color(0xFF3A3570), g.lw * 1.9 + s * 0.12))
        ..drawPath(z, _stroke(const Color(0xFFEDEBFF), s * 0.16));
      at += Offset(s * 1.3 * f, -s * 1.25);
      s *= 1.3;
    }
  }
}

// --- Eyes and mouths -------------------------------------------------------

void _eye(Canvas c, _G g, Offset ctr, double side) {
  final ew = g.ew;
  final eh = g.eh;
  final toward = -side; // towards the middle of the face
  switch (g.pose.eyes) {
    case _Eyes.happy:
      final p = Path()
        ..moveTo(ctr.dx - ew * 0.42, ctr.dy + eh * 0.14)
        ..quadraticBezierTo(ctr.dx, ctr.dy - eh * 0.62, ctr.dx + ew * 0.42, ctr.dy + eh * 0.14);
      c.drawPath(p, _stroke(_ink, g.lw * 1.65));
      return;
    case _Eyes.closed:
      final p = Path()
        ..moveTo(ctr.dx - ew * 0.42, ctr.dy)
        ..quadraticBezierTo(ctr.dx, ctr.dy + eh * 0.42, ctr.dx + ew * 0.42, ctr.dy);
      c.drawPath(p, _stroke(_ink, g.lw * 1.55));
      if (g.species == _Species.unicorn) _lashes(c, g, ctr, side, closed: true);
      return;
    case _Eyes.squint:
      final p = Path()
        ..moveTo(ctr.dx - toward * ew * 0.36, ctr.dy - eh * 0.3)
        ..lineTo(ctr.dx + toward * ew * 0.3, ctr.dy)
        ..lineTo(ctr.dx - toward * ew * 0.36, ctr.dy + eh * 0.3);
      c.drawPath(p, _stroke(_ink, g.lw * 1.65));
      return;
    case _Eyes.open || _Eyes.worried || _Eyes.fierce:
      break;
  }
  final eye = Rect.fromCenter(center: ctr, width: ew, height: eh);
  final look = g.pose.look;
  final small = g.pose.eyes == _Eyes.worried ? 0.86 : 1.0;
  final ic = ctr + Offset(look.dx * ew * 0.13, look.dy * eh * 0.1 + eh * 0.05);
  final iw = ew * 0.7 * small;
  final ih = eh * 0.74 * small;
  final iris = Rect.fromCenter(center: ic, width: iw, height: ih);
  c
    ..drawOval(eye, _fill(_white))
    ..save()
    ..clipPath(Path()..addOval(eye))
    ..drawOval(iris, _fill(_ink))
    ..save()
    ..clipPath(Path()..addOval(iris))
    ..drawOval(
      Rect.fromCenter(center: ic + Offset(0, ih * 0.38), width: iw * 0.92, height: ih * 0.56),
      _blur(g.look.iris.withValues(alpha: 0.9), iw * 0.09),
    )
    ..restore()
    ..drawCircle(ic + Offset(-iw * 0.2 * g.lightX, -ih * 0.2), ew * 0.155, _fill(_white))
    ..drawCircle(ic + Offset(iw * 0.22 * g.lightX, ih * 0.23), ew * 0.065, _fill(_white.withValues(alpha: 0.95)))
    ..restore()
    ..drawOval(eye, _stroke(_ink, g.lw * 0.8));
  if (g.pose.eyes == _Eyes.worried || g.pose.eyes == _Eyes.fierce) {
    final up = g.pose.eyes == _Eyes.worried;
    final outer = ctr + Offset(-toward * ew * 0.4, -eh * (up ? 0.7 : 0.9));
    final inner = ctr + Offset(toward * ew * 0.28, -eh * (up ? 0.93 : 0.66));
    c.drawLine(outer, inner, _stroke(_ink, g.lw * 1.3));
  }
  if (g.species == _Species.unicorn) _lashes(c, g, ctr, side);
}

void _lashes(Canvas c, _G g, Offset ctr, double side, {bool closed = false}) {
  final ew = g.ew;
  final eh = g.eh;
  final base = closed
      ? ctr + Offset(side * ew * 0.4, 0)
      : ctr + Offset(side * ew * 0.36, -eh * 0.3);
  for (var i = 0; i < 2; i++) {
    final a = -0.5 - i * 0.55;
    final dir = Offset(side * math.cos(a), math.sin(a));
    final from = base + Offset(0, i * eh * 0.1);
    c.drawLine(from, from + dir * ew * 0.22, _stroke(_ink, g.lw * 0.8));
  }
}

void _visorEye(Canvas c, _G g, Offset ctr, double side) {
  final r = g.w * const [0.17, 0.16, 0.15][g.s];
  final rim = Rect.fromCircle(center: ctr, radius: r * 1.14);
  final glass = Rect.fromCircle(center: ctr, radius: r * 0.92);
  c
    ..drawCircle(ctr, r * 1.14, _grad(rim, const [Color(0xFFFAFCFF), Color(0xFF8395AA)]))
    ..drawCircle(ctr, r * 1.14, _stroke(g.look.line, g.lw * 0.9))
    ..drawCircle(ctr, r * 0.92, _grad(glass, const [Color(0xFF1F3B57), Color(0xFF0A1522)]))
    ..drawCircle(ctr, r * 0.92, _stroke(g.look.line, g.lw * 0.6));
  final glow = g.pose.mouth == _Mouth.breath ? const Color(0xFFFF4D6D) : _teal;
  final look = Offset(g.pose.look.dx * r * 0.18, g.pose.look.dy * r * 0.15);
  switch (g.pose.eyes) {
    case _Eyes.happy:
      final p = Path()
        ..moveTo(ctr.dx - r * 0.45, ctr.dy + r * 0.15)
        ..quadraticBezierTo(ctr.dx, ctr.dy - r * 0.6, ctr.dx + r * 0.45, ctr.dy + r * 0.15);
      c
        ..drawPath(p, _stroke(glow.withValues(alpha: 0.7), r * 0.3)..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.12))
        ..drawPath(p, _stroke(_mix(glow, _white, 0.5), r * 0.14));
    case _Eyes.closed:
      c.drawLine(
        ctr + Offset(-r * 0.45, r * 0.05),
        ctr + Offset(r * 0.45, r * 0.05),
        _stroke(glow.withValues(alpha: 0.55), r * 0.13),
      );
    default:
      final small = g.pose.eyes == _Eyes.worried ? 0.75 : 1.0;
      final ic = ctr + look;
      c
        ..drawCircle(ic, r * 0.62 * small, _blur(glow.withValues(alpha: 0.55), r * 0.2))
        ..drawCircle(ic, r * 0.5 * small, _stroke(glow, r * 0.17))
        ..drawCircle(ic, r * 0.2 * small, _fill(_mix(glow, _white, 0.7)));
  }
  // The glass catches the light.
  final arc = Rect.fromCircle(center: ctr, radius: r * 0.72);
  c
    ..drawArc(arc, math.pi * 1.05, math.pi * 0.42, false, _stroke(_white.withValues(alpha: 0.5), r * 0.1))
    ..drawCircle(ctr + Offset(-r * 0.05, -r * 0.62), r * 0.06, _fill(_white.withValues(alpha: 0.7)));
  if (g.pose.eyes == _Eyes.worried) {
    final toward = -side;
    c.drawLine(
      ctr + Offset(-toward * r * 0.8, -r * 1.25),
      ctr + Offset(toward * r * 0.5, -r * 1.5),
      _stroke(g.look.line, g.lw * 1.3),
    );
  }
}

void _mouth(Canvas c, _G g) {
  final m = Offset(g.fx, g.my);
  final mw = g.w * 0.13;
  if (g.beaked) {
    _beak(c, g, m);
    return;
  }
  if (g.species == _Species.dog) {
    _dogMouth(c, g, m);
    return;
  }
  switch (g.pose.mouth) {
    case _Mouth.smile:
      if (g.species == _Species.cat) {
        _catNose(c, g, m + Offset(0, -mw * 0.32));
        final p = Path()
          ..moveTo(m.dx - mw * 0.62, m.dy - mw * 0.08)
          ..quadraticBezierTo(m.dx - mw * 0.31, m.dy + mw * 0.45, m.dx, m.dy - mw * 0.04)
          ..quadraticBezierTo(m.dx + mw * 0.31, m.dy + mw * 0.45, m.dx + mw * 0.62, m.dy - mw * 0.08);
        c.drawPath(p, _stroke(_ink, g.lw));
      } else {
        final p = Path()
          ..moveTo(m.dx - mw * 0.5, m.dy - mw * 0.05)
          ..quadraticBezierTo(m.dx, m.dy + mw * 0.55, m.dx + mw * 0.5, m.dy - mw * 0.05);
        c.drawPath(p, _stroke(_ink, g.lw * 1.05));
      }
    case _Mouth.grin:
      if (g.species == _Species.cat) _catNose(c, g, m + Offset(0, -mw * 0.38));
      _openMouth(c, g, m, mw * 1.05, mw * 0.8);
    case _Mouth.o:
      if (g.species == _Species.cat) _catNose(c, g, m + Offset(0, -mw * 0.45));
      final r = Rect.fromCenter(center: m + Offset(0, mw * 0.1), width: mw * 0.42, height: mw * 0.5);
      c
        ..drawOval(r, _fill(const Color(0xFF6E2140)))
        ..drawOval(r, _stroke(_ink, g.lw * 0.9));
    case _Mouth.breath:
      if (g.species == _Species.cat) _catNose(c, g, m + Offset(0, -mw * 0.55));
      final r = Rect.fromCenter(center: m + Offset(0, mw * 0.12), width: mw * 0.82, height: mw * 0.74);
      c
        ..drawOval(r, _fill(const Color(0xFF5A1430)))
        ..drawOval(
          Rect.fromCenter(center: r.center + Offset(0, r.height * 0.12), width: r.width * 0.6, height: r.height * 0.5),
          _blur(const Color(0xFFFFB347).withValues(alpha: 0.85), r.width * 0.1),
        )
        ..drawOval(r, _stroke(_ink, g.lw));
    case _Mouth.wavy:
      final p = Path()
        ..moveTo(m.dx - mw * 0.55, m.dy + mw * 0.08)
        ..cubicTo(m.dx - mw * 0.3, m.dy - mw * 0.22, m.dx - mw * 0.1, m.dy - mw * 0.22, m.dx, m.dy + mw * 0.05)
        ..cubicTo(m.dx + mw * 0.1, m.dy + mw * 0.3, m.dx + mw * 0.3, m.dy + mw * 0.3, m.dx + mw * 0.55, m.dy + mw * 0.02);
      c.drawPath(p, _stroke(_ink, g.lw));
  }
}

void _openMouth(Canvas c, _G g, Offset m, double mw, double mh) {
  final top = m.dy - mh * 0.18;
  final p = Path()
    ..moveTo(m.dx - mw / 2, top)
    ..quadraticBezierTo(m.dx, top + mh * 0.12, m.dx + mw / 2, top)
    ..cubicTo(m.dx + mw / 2, top + mh * 0.95, m.dx - mw / 2, top + mh * 0.95, m.dx - mw / 2, top)
    ..close();
  c
    ..drawPath(p, _fill(const Color(0xFF7A2442)))
    ..save()
    ..clipPath(p)
    ..drawOval(
      Rect.fromCenter(center: Offset(m.dx, top + mh * 0.78), width: mw * 0.7, height: mh * 0.6),
      _fill(const Color(0xFFFF7FA2)),
    )
    ..restore()
    ..drawPath(p, _stroke(_ink, g.lw));
}

void _catNose(Canvas c, _G g, Offset at) {
  final s = g.w * 0.05;
  final p = Path()
    ..moveTo(at.dx - s, at.dy - s * 0.45)
    ..quadraticBezierTo(at.dx, at.dy - s * 0.75, at.dx + s, at.dy - s * 0.45)
    ..quadraticBezierTo(at.dx + s * 0.4, at.dy + s * 0.5, at.dx, at.dy + s * 0.55)
    ..quadraticBezierTo(at.dx - s * 0.4, at.dy + s * 0.5, at.dx - s, at.dy - s * 0.45)
    ..close();
  c
    ..drawPath(p, _fill(const Color(0xFFFF7FA8)))
    ..drawPath(p, _stroke(_ink, g.lw * 0.6));
}

void _beak(Canvas c, _G g, Offset m) {
  final open = switch (g.pose.mouth) {
    _Mouth.grin => 0.55,
    _Mouth.o => 0.4,
    _Mouth.breath => 1.0,
    _ => 0.0,
  };
  final metal = g.species == _Species.owl;
  final topColor = metal ? const Color(0xFFFFD27A) : _beakTop;
  final bottomColor = metal ? const Color(0xFFE59A2E) : _beakBottom;
  final bw = g.w * 0.15;
  final bh = g.w * 0.105;
  final drop = bh * 0.55 * open;
  final l = Offset(m.dx - bw / 2, m.dy);
  final r = Offset(m.dx + bw / 2, m.dy);
  if (open > 0) {
    final inside = Path()
      ..moveTo(l.dx + bw * 0.05, l.dy)
      ..lineTo(r.dx - bw * 0.05, r.dy)
      ..lineTo(m.dx + bw * 0.32, m.dy + drop + bh * 0.1)
      ..lineTo(m.dx - bw * 0.32, m.dy + drop + bh * 0.1)
      ..close();
    c.drawPath(inside, _fill(const Color(0xFF6E1F3A)));
  }
  final lower = Path()
    ..moveTo(m.dx - bw * 0.36, m.dy + drop)
    ..lineTo(m.dx + bw * 0.36, m.dy + drop)
    ..quadraticBezierTo(m.dx + bw * 0.12, m.dy + drop + bh * 0.62, m.dx, m.dy + drop + bh * 0.62)
    ..quadraticBezierTo(m.dx - bw * 0.12, m.dy + drop + bh * 0.62, m.dx - bw * 0.36, m.dy + drop)
    ..close();
  final upper = Path()
    ..moveTo(l.dx, l.dy)
    ..quadraticBezierTo(m.dx - bw * 0.28, m.dy - bh * 0.62, m.dx, m.dy - bh * 0.62)
    ..quadraticBezierTo(m.dx + bw * 0.28, m.dy - bh * 0.62, r.dx, r.dy)
    ..quadraticBezierTo(m.dx, m.dy + bh * 0.32, l.dx, l.dy)
    ..close();
  c
    ..drawPath(lower, _fill(bottomColor))
    ..drawPath(lower, _stroke(_beakLine, g.lw * 0.8))
    ..drawPath(upper, _grad(upper.getBounds(), [_mix(topColor, _white, 0.25), topColor]))
    ..drawPath(upper, _stroke(_beakLine, g.lw * 0.8))
    ..drawOval(
      Rect.fromCenter(center: Offset(m.dx - bw * 0.12, m.dy - bh * 0.3), width: bw * 0.18, height: bh * 0.16),
      _fill(_white.withValues(alpha: 0.6)),
    );
}

// --- Cat -------------------------------------------------------------------

void _catEars(Canvas c, _G g, {bool gold = false}) {
  final inner = gold ? const Color(0xFFFFB0A0) : const Color(0xFFFF9EC4);
  final size = gold ? 0.6 : 1.0;
  for (final side in const [-1.0, 1.0]) {
    final a = Offset(side * g.w * 0.44, -g.h * 0.74);
    final b = Offset(side * g.w * 0.06, -g.h * 0.985);
    final tip = Offset(side * g.w * 0.38, -g.h - g.h * 0.3 * g.grow * size);
    final ear = _roundTri(a, tip, b, 0.24);
    _part(c, g, ear, colors: [g.look.top, g.look.mid]);
    final cen = (a + tip + b) / 3;
    c.drawPath(
      _roundTri(
        Offset.lerp(a, cen, 0.42)!,
        Offset.lerp(tip, cen, 0.36)!,
        Offset.lerp(b, cen, 0.42)!,
        0.28,
      ),
      _fill(inner),
    );
  }
}

void _catTail(Canvas c, _G g) {
  final k = 0.55 + 0.45 * g.grow;
  final o = Offset(-g.w * 0.3, -g.h * 0.12);
  Offset p(double x, double y) => o + Offset(x, y) * g.w * k;
  final path = Path()
    ..moveTo(o.dx, o.dy)
    ..cubicTo(p(-0.42, 0.06).dx, p(-0.42, 0.06).dy, p(-0.58, -0.34).dx, p(-0.58, -0.34).dy, p(-0.4, -0.52).dx, p(-0.4, -0.52).dy)
    ..cubicTo(p(-0.3, -0.62).dx, p(-0.3, -0.62).dy, p(-0.14, -0.56).dx, p(-0.14, -0.56).dy, p(-0.22, -0.44).dx, p(-0.22, -0.44).dy);
  final tw = g.w * 0.125;
  c
    ..drawPath(path, _stroke(g.look.line, tw + g.lw * 2))
    ..drawPath(path, _stroke(g.look.mid, tw))
    ..drawPath(
      path,
      _stroke(_white.withValues(alpha: 0.25), tw * 0.3)..strokeCap = StrokeCap.round,
    );
}

void _catStripes(Canvas c, _G g) {
  final paint = _stroke(g.look.line.withValues(alpha: 0.32), g.lw * 1.25);
  c
    ..save()
    ..clipRRect(g.bodyRRect);
  for (final (dx, len) in const [(-0.085, 0.09), (0.0, 0.13), (0.085, 0.09)]) {
    final x = g.fx + dx * g.w;
    c.drawLine(Offset(x, -g.h * 1.02), Offset(x * 0.96, -g.h + g.h * len), paint);
  }
  c.restore();
}

void _paws(Canvas c, _G g, Color color) {
  final drop = g.pose.flying ? g.h * 0.03 : 0.0;
  for (final side in const [-1.0, 1.0]) {
    final r = Rect.fromCenter(
      center: Offset(g.fx * 0.5 + side * g.w * 0.17, -g.h * 0.05 + drop),
      width: g.w * 0.2,
      height: g.w * 0.13,
    );
    c
      ..drawOval(r, _fill(color))
      ..drawOval(r, _stroke(g.look.line, g.lw * 0.85));
    for (final t in const [-0.22, 0.22]) {
      c.drawLine(
        Offset(r.center.dx + t * r.width, r.bottom - r.height * 0.1),
        Offset(r.center.dx + t * r.width * 0.9, r.bottom - r.height * 0.42),
        _stroke(g.look.line.withValues(alpha: 0.75), g.lw * 0.6),
      );
    }
  }
}

void _whiskers(Canvas c, _G g) {
  final paint = _stroke(g.look.line.withValues(alpha: 0.85), g.lw * 0.6);
  final y = g.my - g.w * 0.02;
  for (final side in const [-1.0, 1.0]) {
    final x0 = g.fx + side * g.w * 0.31;
    c
      ..drawLine(Offset(x0, y - g.w * 0.025), Offset(x0 + side * g.w * 0.3, y - g.w * 0.085), paint)
      ..drawLine(Offset(x0, y + g.w * 0.025), Offset(x0 + side * g.w * 0.3, y + g.w * 0.05), paint);
  }
}

// --- Dog -------------------------------------------------------------------

void _dogEars(Canvas c, _G g) {
  // Pixel-step edges: the outline walks a grid, like a sprite.
  const pts = [
    (4.0, 0.0), (-0.7, 0.0), (-0.7, 1.0), (-1.5, 1.0), (-1.5, 5.4),
    (-0.7, 5.4), (-0.7, 6.2), (1.1, 6.2), (1.1, 5.4), (1.9, 5.4),
    (1.9, 2.3), (2.7, 2.3), (2.7, 1.3), (4.0, 1.3),
  ];
  final u = g.w * 0.066 * (0.8 + 0.2 * g.grow);
  for (final side in const [-1.0, 1.0]) {
    final o = Offset(side * g.w * 0.5, -g.h - g.h * 0.03);
    final ear = _poly([for (final (x, y) in pts) (-side * x, y)], o, u);
    c
      ..drawPath(ear, _grad(ear.getBounds(), const [Color(0xFFC86D2B), Color(0xFF9C4B17)]))
      ..drawPath(ear, _stroke(g.look.line, g.lw)..strokeJoin = StrokeJoin.miter)
      ..drawRect(
        Rect.fromLTWH(o.dx + (side < 0 ? -0.7 : -0.1) * u, o.dy + 1.4 * u, 0.8 * u, 0.8 * u),
        _fill(const Color(0xFFE09656)),
      );
  }
}

void _dogPatch(Canvas c, _G g) {
  const pts = [
    (-2.4, -2.6), (2.0, -2.6), (2.0, -1.8), (2.8, -1.8), (2.8, 2.0),
    (2.0, 2.0), (2.0, 2.8), (-2.0, 2.8), (-2.0, 2.0), (-2.8, 2.0),
    (-2.8, -1.8), (-2.4, -1.8),
  ];
  final o = Offset(g.fx + g.ex, g.ey);
  c.drawPath(
    _poly(pts, o, g.w * 0.056),
    _fill(_mix(g.look.bottom, g.look.line, 0.18)),
  );
}

void _dogMuzzle(Canvas c, _G g) {
  final r = Rect.fromCenter(
    center: Offset(g.fx, g.my - g.w * 0.035),
    width: g.w * 0.4,
    height: g.w * 0.24,
  );
  c.drawOval(r, _grad(r, const [Color(0xFFFFF3E2), Color(0xFFFFDDB8)]));
}

void _dogMouth(Canvas c, _G g, Offset m) {
  final mw = g.w * 0.13;
  final nose = m + Offset(0, -mw * 0.72);
  final ns = g.w * 0.062;
  final np = Path()
    ..moveTo(nose.dx - ns, nose.dy - ns * 0.45)
    ..quadraticBezierTo(nose.dx, nose.dy - ns * 0.8, nose.dx + ns, nose.dy - ns * 0.45)
    ..quadraticBezierTo(nose.dx + ns * 0.55, nose.dy + ns * 0.55, nose.dx, nose.dy + ns * 0.6)
    ..quadraticBezierTo(nose.dx - ns * 0.55, nose.dy + ns * 0.55, nose.dx - ns, nose.dy - ns * 0.45)
    ..close();
  c
    ..drawPath(np, _fill(const Color(0xFF3A2317)))
    ..drawOval(
      Rect.fromCenter(center: nose + Offset(-ns * 0.3, -ns * 0.25), width: ns * 0.5, height: ns * 0.28),
      _fill(_white.withValues(alpha: 0.7)),
    )
    ..drawLine(nose + Offset(0, ns * 0.55), m + Offset(0, -mw * 0.08), _stroke(_ink, g.lw * 0.8));
  if (g.pose.mouth == _Mouth.grin || g.pose.mouth == _Mouth.breath) {
    _openMouth(c, g, m + Offset(0, mw * 0.12), mw * 1.05, mw * 0.85);
    return;
  }
  if (g.pose.mouth == _Mouth.wavy) {
    final p = Path()
      ..moveTo(m.dx - mw * 0.5, m.dy + mw * 0.12)
      ..quadraticBezierTo(m.dx - mw * 0.25, m.dy - mw * 0.12, m.dx, m.dy + mw * 0.06)
      ..quadraticBezierTo(m.dx + mw * 0.25, m.dy + mw * 0.25, m.dx + mw * 0.5, m.dy + mw * 0.02);
    c.drawPath(p, _stroke(_ink, g.lw * 0.9));
    return;
  }
  // The tongue hangs out of a happy "w".
  final tongue = RRect.fromRectAndCorners(
    Rect.fromLTWH(m.dx - mw * 0.02, m.dy - mw * 0.02, mw * 0.55, mw * 0.68),
    bottomLeft: Radius.circular(mw * 0.27),
    bottomRight: Radius.circular(mw * 0.27),
  );
  c
    ..drawRRect(tongue, _fill(const Color(0xFFFF7FA2)))
    ..drawRRect(tongue, _stroke(_ink, g.lw * 0.75))
    ..drawLine(
      Offset(tongue.center.dx, tongue.top + mw * 0.12),
      Offset(tongue.center.dx, tongue.bottom - mw * 0.2),
      _stroke(const Color(0xFFD9507A), g.lw * 0.6),
    );
  final p = Path()
    ..moveTo(m.dx - mw * 0.62, m.dy - mw * 0.12)
    ..quadraticBezierTo(m.dx - mw * 0.31, m.dy + mw * 0.32, m.dx, m.dy - mw * 0.06)
    ..quadraticBezierTo(m.dx + mw * 0.31, m.dy + mw * 0.32, m.dx + mw * 0.62, m.dy - mw * 0.12);
  c.drawPath(p, _stroke(_ink, g.lw * 0.9));
}

void _dogTail(Canvas c, _G g) {
  final path = Path()
    ..moveTo(-g.w * 0.36, -g.h * 0.28)
    ..quadraticBezierTo(-g.w * 0.62, -g.h * 0.32, -g.w * (0.6 + 0.04 * g.grow), -g.h * (0.5 + 0.12 * g.grow));
  final tw = g.w * 0.13;
  c
    ..drawPath(path, _stroke(g.look.line, tw + g.lw * 2))
    ..drawPath(path, _stroke(const Color(0xFFC86D2B), tw));
}

// --- Slime -----------------------------------------------------------------

Path _drip(double cx, double top, double len, double wd, double flare) {
  final hw = wd / 2;
  return Path()
    ..moveTo(cx - hw - flare, top)
    ..quadraticBezierTo(cx - hw, top, cx - hw, top + flare)
    ..lineTo(cx - hw, len - hw)
    ..arcToPoint(Offset(cx + hw, len - hw), radius: Radius.circular(hw), clockwise: false)
    ..lineTo(cx + hw, top + flare)
    ..quadraticBezierTo(cx + hw, top, cx + hw + flare, top)
    ..close();
}

Path _slimeShape(_G g) {
  var shape = Path()..addRRect(g.bodyRRect);
  for (final (x, len, wd) in const [(-0.27, 0.1, 0.13), (0.05, 0.17, 0.15), (0.3, 0.07, 0.11)]) {
    shape = Path.combine(
      PathOperation.union,
      shape,
      _drip(x * g.w, -g.h * 0.004, len * g.h, wd * g.w, g.w * 0.05),
    );
  }
  final k = g.grow;
  final tip = Path()
    ..moveTo(g.fx - g.w * 0.13, -g.h + g.h * 0.06)
    ..cubicTo(g.fx - g.w * 0.11, -g.h - g.h * 0.08 * k, g.fx + g.w * 0.0, -g.h - g.h * 0.1 * k, g.fx + g.w * 0.1, -g.h - g.h * 0.2 * (0.5 + 0.5 * k))
    ..cubicTo(g.fx + g.w * 0.07, -g.h - g.h * 0.06 * k, g.fx + g.w * 0.13, -g.h - g.h * 0.02, g.fx + g.w * 0.15, -g.h + g.h * 0.06)
    ..close();
  return Path.combine(PathOperation.union, shape, tip);
}

void _slimeInner(Canvas c, _G g) {
  final shape = _slimeShape(g);
  c
    ..save()
    ..clipPath(shape)
    // Light gathers along the bottom, like in a jelly.
    ..drawOval(
      Rect.fromCenter(center: Offset(0, -g.h * 0.04), width: g.w * 0.8, height: g.h * 0.22),
      _blur(const Color(0xFFF4FFC0).withValues(alpha: 0.55), g.w * 0.06),
    )
    ..restore();
  final bubble = Offset(-g.w * 0.2, -g.h * 0.66);
  final br = g.w * 0.12;
  c
    ..drawCircle(bubble, br, _fill(_white.withValues(alpha: 0.2)))
    ..drawArc(
      Rect.fromCircle(center: bubble, radius: br * 0.75),
      math.pi * 1.0,
      math.pi * 0.6,
      false,
      _stroke(_white.withValues(alpha: 0.75), g.lw * 0.9),
    )
    ..drawCircle(bubble + Offset(br * 0.35, br * 0.35), br * 0.16, _fill(_white.withValues(alpha: 0.55)));
  for (final (x, y, r) in const [(0.3, -0.22, 0.035), (0.36, -0.42, 0.022), (-0.33, -0.2, 0.028)]) {
    final at = Offset(x * g.w, y * g.h);
    c
      ..drawCircle(at, r * g.w, _fill(_white.withValues(alpha: 0.3)))
      ..drawCircle(at, r * g.w, _stroke(_white.withValues(alpha: 0.65), g.lw * 0.5));
  }
  // A long glossy streak down the left.
  c.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(-g.w * 0.39, -g.h * 0.42), width: g.w * 0.05, height: g.h * 0.3),
      Radius.circular(g.w * 0.025),
    ),
    _fill(_white.withValues(alpha: 0.4)),
  );
}

// --- Dragon ----------------------------------------------------------------

void _batWing(Canvas c, _G g, double side) {
  final span = g.w * const [0.3, 0.5, 0.74][g.s];
  final root = Offset(side * g.w * 0.34, -g.h * 0.68);
  c
    ..save()
    ..translate(root.dx, root.dy)
    ..scale(side, 1)
    ..rotate(0.12 - g.pose.wing * 0.6);
  Offset p(double x, double y) => Offset(x * span, y * span);
  final elbow = p(0.42, -0.5);
  final membrane = Path()
    ..moveTo(0, span * 0.14)
    ..lineTo(0, -span * 0.06)
    ..quadraticBezierTo(p(0.14, -0.46).dx, p(0.14, -0.46).dy, elbow.dx, elbow.dy)
    ..quadraticBezierTo(p(0.76, -0.54).dx, p(0.76, -0.54).dy, p(1.0, -0.3).dx, p(1.0, -0.3).dy)
    ..quadraticBezierTo(p(0.86, -0.14).dx, p(0.86, -0.14).dy, p(0.9, 0.08).dx, p(0.9, 0.08).dy)
    ..quadraticBezierTo(p(0.72, -0.04).dx, p(0.72, -0.04).dy, p(0.6, 0.2).dx, p(0.6, 0.2).dy)
    ..quadraticBezierTo(p(0.44, 0.04).dx, p(0.44, 0.04).dy, p(0.28, 0.22).dx, p(0.28, 0.22).dy)
    ..quadraticBezierTo(p(0.14, 0.08).dx, p(0.14, 0.08).dy, 0, span * 0.14)
    ..close();
  c
    ..drawPath(
      membrane,
      _grad(membrane.getBounds(), const [Color(0xFFFF8A7F), Color(0xFFC2304B)], begin: Alignment.topLeft, end: Alignment.bottomRight),
    )
    ..save()
    ..clipPath(membrane);
  final bone = _stroke(const Color(0xFFFFB0A3), g.lw * 0.9);
  for (final tip in [p(0.9, 0.08), p(0.6, 0.2), p(0.28, 0.22)]) {
    c.drawLine(elbow, tip, bone);
  }
  c
    ..restore()
    ..drawPath(membrane, _stroke(g.look.line, g.lw))
    ..drawPath(
      Path()
        ..moveTo(0, -span * 0.04)
        ..quadraticBezierTo(p(0.14, -0.44).dx, p(0.14, -0.44).dy, elbow.dx, elbow.dy)
        ..quadraticBezierTo(p(0.76, -0.52).dx, p(0.76, -0.52).dy, p(0.98, -0.3).dx, p(0.98, -0.3).dy),
      _stroke(const Color(0xFFFF9C8C), g.lw * 1.1),
    );
  // A little claw at the elbow.
  final claw = _roundTri(elbow + Offset(-span * 0.05, 0), elbow + Offset(span * 0.02, -span * 0.13), elbow + Offset(span * 0.07, 0), 0.3);
  _part(c, g, claw, color: _cream, lineScale: 0.8);
  c.restore();
}

void _dragonHorns(Canvas c, _G g) {
  final len = g.h * (0.06 + 0.22 * g.grow);
  final width = g.w * (0.09 + 0.04 * g.grow);
  for (final side in const [-1.0, 1.0]) {
    final base = Offset(g.fx + side * g.w * 0.21, -g.h * 0.93);
    final tip = base + Offset(side * len * 0.42, -len);
    final horn = Path()
      ..moveTo(base.dx - width / 2, base.dy)
      ..quadraticBezierTo(base.dx - width * 0.45 + side * len * 0.05, base.dy - len * 0.6, tip.dx, tip.dy)
      ..quadraticBezierTo(base.dx + width * 0.45 + side * len * 0.3, base.dy - len * 0.4, base.dx + width / 2, base.dy)
      ..close();
    _part(c, g, horn, colors: const [Color(0xFFFFF6E2), Color(0xFFE8C08A)]);
    if (g.grow > 0.5) {
      final ridge = _stroke(const Color(0xFFC9955C), g.lw * 0.7);
      for (final t in const [0.42, 0.66]) {
        final y = base.dy - len * t;
        final x = base.dx + side * len * 0.42 * t * t;
        final hw = width * 0.5 * (1 - t * 0.85);
        c.drawLine(Offset(x - hw, y + hw * 0.25 * side), Offset(x + hw, y - hw * 0.25 * side), ridge);
      }
    }
  }
}

void _dragonTail(Canvas c, _G g) {
  final s = g.w * (0.5 + 0.5 * g.grow);
  final o = Offset(-g.w * 0.3, -g.h * 0.16);
  final pts = _cubicPts(o, o + const Offset(-0.5, 0.14) * s, o + const Offset(-0.8, -0.08) * s, o + const Offset(-0.78, -0.5) * s);
  final spike = _fill(_gold);
  // Spikes along the back of the tail, behind it.
  for (final t in const [0.3, 0.55, 0.78]) {
    final i = (t * (pts.length - 1)).round();
    final a = pts[i - 1];
    final b = pts[i + 1];
    final d = (b - a) / (b - a).distance;
    var n = Offset(-d.dy, d.dx);
    if (n.dx + n.dy > 0) n = -n;
    final at = pts[i];
    final wHere = g.w * (0.2 - 0.13 * t) / 2;
    final tri = _roundTri(at - d * s * 0.06 + n * wHere * 0.6, at + n * (wHere + s * 0.1), at + d * s * 0.06 + n * wHere * 0.6, 0.25);
    c
      ..drawPath(tri, spike)
      ..drawPath(tri, _stroke(g.look.line, g.lw * 0.85));
  }
  _part(c, g, _taper(pts, g.w * 0.2, g.w * 0.07), colors: [g.look.top, g.look.bottom], begin: Alignment.topLeft, end: Alignment.bottomRight);
  // A spade at the tip.
  final e = pts.last;
  final d = (pts.last - pts[pts.length - 3]) / (pts.last - pts[pts.length - 3]).distance;
  final n = Offset(-d.dy, d.dx);
  final ts = s * 0.15;
  final spade = Path()
    ..moveTo(e.dx + d.dx * ts * 1.2, e.dy + d.dy * ts * 1.2)
    ..quadraticBezierTo(e.dx + n.dx * ts + d.dx * ts * 0.4, e.dy + n.dy * ts + d.dy * ts * 0.4, e.dx + n.dx * ts * 0.75 - d.dx * ts * 0.35, e.dy + n.dy * ts * 0.75 - d.dy * ts * 0.35)
    ..lineTo(e.dx + d.dx * ts * 0.05, e.dy + d.dy * ts * 0.05)
    ..lineTo(e.dx - n.dx * ts * 0.75 - d.dx * ts * 0.35, e.dy - n.dy * ts * 0.75 - d.dy * ts * 0.35)
    ..quadraticBezierTo(e.dx - n.dx * ts + d.dx * ts * 0.4, e.dy - n.dy * ts + d.dy * ts * 0.4, e.dx + d.dx * ts * 1.2, e.dy + d.dy * ts * 1.2)
    ..close();
  _part(c, g, spade, colors: const [Color(0xFFFFD87A), _goldDeep], lineScale: 0.9);
}

void _bellyPlate(Canvas c, _G g) {
  final rect = Rect.fromLTRB(g.fx - g.w * 0.27, -g.h * 0.35, g.fx + g.w * 0.27, g.h * 0.05);
  final plate = RRect.fromRectAndCorners(
    rect,
    topLeft: Radius.circular(g.w * 0.22),
    topRight: Radius.circular(g.w * 0.22),
    bottomLeft: Radius.circular(g.w * 0.08),
    bottomRight: Radius.circular(g.w * 0.08),
  );
  c
    ..save()
    ..clipRRect(g.bodyRRect.deflate(g.lw * 0.5))
    ..drawRRect(plate, _grad(rect, const [Color(0xFFFFF3DA), Color(0xFFFFCF94)]));
  final seg = _stroke(const Color(0xFFDDA062), g.lw * 0.75);
  for (final t in const [0.3, 0.6]) {
    final y = rect.top + rect.height * t;
    c.drawPath(
      Path()
        ..moveTo(rect.left + g.w * 0.05, y)
        ..quadraticBezierTo(rect.center.dx, y + g.h * 0.035, rect.right - g.w * 0.05, y),
      seg,
    );
  }
  c
    ..drawRRect(plate, _stroke(g.look.line.withValues(alpha: 0.55), g.lw * 0.8))
    ..restore();
}

// --- Penguin ---------------------------------------------------------------

void _flipper(Canvas c, _G g, double side) {
  final root = Offset(side * g.w * 0.44, -g.h * 0.5);
  final len = g.w * (0.18 + 0.12 * g.grow);
  final wid = g.w * 0.13;
  c
    ..save()
    ..translate(root.dx, root.dy)
    ..scale(side, 1)
    ..rotate(0.55 - g.pose.wing * 0.85);
  final p = Path()
    ..moveTo(0, -wid / 2)
    ..quadraticBezierTo(len * 0.85, -wid * 0.6, len, 0)
    ..quadraticBezierTo(len * 0.7, wid * 0.75, 0, wid / 2)
    ..close();
  _part(c, g, p, colors: const [Color(0xFF5AAEF0), Color(0xFF2A6FC0)]);
  c.restore();
}

void _penguinTuft(Canvas c, _G g) {
  for (final (dx, a, len) in const [(-0.03, -0.35, 0.16), (0.05, 0.3, 0.12)]) {
    final base = Offset(g.fx + dx * g.w, -g.h * 0.97);
    final l = len * g.h * (0.6 + 0.4 * g.grow);
    final tip = base + Offset(math.sin(a) * l, -math.cos(a) * l);
    final p = Path()
      ..moveTo(base.dx - g.w * 0.035, base.dy)
      ..quadraticBezierTo(base.dx - g.w * 0.04, tip.dy + l * 0.2, tip.dx, tip.dy)
      ..quadraticBezierTo(base.dx + g.w * 0.04, tip.dy + l * 0.5, base.dx + g.w * 0.035, base.dy)
      ..close();
    _part(c, g, p, colors: [g.look.top, g.look.mid], lineScale: 0.85);
  }
}

void _penguinBelly(Canvas c, _G g) {
  final lobe = g.w * 0.205;
  final mask = Path.combine(
    PathOperation.union,
    Path()
      ..addOval(Rect.fromCircle(center: Offset(g.fx - g.w * 0.165, g.ey - g.h * 0.02), radius: lobe))
      ..addOval(Rect.fromCircle(center: Offset(g.fx + g.w * 0.165, g.ey - g.h * 0.02), radius: lobe)),
    Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(g.fx - g.w * 0.35, g.ey, g.fx + g.w * 0.35, g.h * 0.1),
          Radius.circular(g.w * 0.26),
        ),
      ),
  );
  c
    ..save()
    ..clipRRect(g.bodyRRect.deflate(g.lw * 0.5))
    ..drawPath(mask, _grad(mask.getBounds(), const [Color(0xFFFFFFFF), Color(0xFFD5EAFA)]))
    ..drawPath(mask, _stroke(g.look.line.withValues(alpha: 0.35), g.lw * 0.7))
    ..restore();
}

void _scarf(Canvas c, _G g) {
  final y = g.my + g.h * 0.11;
  final band = Path()
    ..moveTo(-g.w * 0.53, y - g.h * 0.03)
    ..quadraticBezierTo(g.fx, y + g.h * 0.06, g.w * 0.53, y - g.h * 0.03)
    ..lineTo(g.w * 0.53, y + g.h * 0.09)
    ..quadraticBezierTo(g.fx, y + g.h * 0.18, -g.w * 0.53, y + g.h * 0.09)
    ..close();
  const red = [Color(0xFFFF7A8E), Color(0xFFE63E5C)];
  const line = Color(0xFF8F1C35);
  // The loose end hangs at the back.
  final end = Path()
    ..moveTo(-g.w * 0.3, y + g.h * 0.06)
    ..lineTo(-g.w * 0.15, y + g.h * 0.08)
    ..lineTo(-g.w * 0.21, y + g.h * 0.34)
    ..lineTo(-g.w * 0.38, y + g.h * 0.31)
    ..close();
  _part(c, g, end, colors: red, line: line, lineScale: 0.85);
  final fringe = _stroke(const Color(0xFFE63E5C), g.lw * 0.8);
  for (var i = 0; i < 4; i++) {
    final x = -g.w * (0.37 - i * 0.05);
    final yy = y + g.h * (0.31 + i * 0.008);
    c.drawLine(Offset(x, yy), Offset(x - g.w * 0.005, yy + g.h * 0.06), fringe);
  }
  c
    ..save()
    ..clipRRect(g.bodyRRect.inflate(g.w * 0.035));
  _part(c, g, band, colors: red, line: line, lineScale: 0.85);
  final stripe = _stroke(_white.withValues(alpha: 0.85), g.lw * 0.75);
  for (final t in const [0.33, 0.66]) {
    c.drawPath(
      Path()
        ..moveTo(-g.w * 0.53, y - g.h * 0.03 + g.h * 0.12 * t)
        ..quadraticBezierTo(g.fx, y + g.h * 0.06 + g.h * 0.12 * t, g.w * 0.53, y - g.h * 0.03 + g.h * 0.12 * t),
      stripe,
    );
  }
  c.restore();
}

// --- Birds -----------------------------------------------------------------

enum _Feather { zig, flame, metal }

void _featherWing(Canvas c, _G g, double side, _Feather kind) {
  final span = g.w * const [0.28, 0.48, 0.66][g.s] * (kind == _Feather.metal ? 0.82 : 1);
  final root = Offset(side * g.w * 0.4, -g.h * (kind == _Feather.metal ? 0.5 : 0.6));
  final (base, tip, line) = switch (kind) {
    _Feather.zig => (const Color(0xFFFFE680), _violet, _violetLine),
    _Feather.flame => (const Color(0xFFFFD45A), const Color(0xFFFF4A2A), const Color(0xFFA2300A)),
    _Feather.metal => (const Color(0xFFE6EDF4), const Color(0xFF7E92A8), g.look.line),
  };
  c
    ..save()
    ..translate(root.dx, root.dy)
    ..scale(side, 1)
    ..rotate(0.18 - g.pose.wing * 0.6);
  const angles = [-0.95, -0.5, -0.08, 0.34];
  const lens = [1.0, 0.92, 0.78, 0.6];
  for (var i = angles.length - 1; i >= 0; i--) {
    final len = span * lens[i];
    final wid = span * 0.3;
    c
      ..save()
      ..rotate(angles[i]);
    final p = switch (kind) {
      _Feather.zig => Path()
        ..moveTo(0, -wid / 2)
        ..quadraticBezierTo(len * 0.55, -wid * 0.62, len, -wid * 0.08)
        ..lineTo(len * 0.8, wid * 0.08)
        ..lineTo(len * 0.86, wid * 0.26)
        ..quadraticBezierTo(len * 0.5, wid * 0.62, 0, wid / 2)
        ..close(),
      _Feather.flame => Path()
        ..moveTo(0, -wid / 2)
        ..cubicTo(len * 0.4, -wid * 0.7, len * 0.7, -wid * 0.1, len * 1.04, -wid * 0.3)
        ..cubicTo(len * 0.86, wid * 0.05, len * 0.8, wid * 0.3, len * 0.6, wid * 0.42)
        ..quadraticBezierTo(len * 0.3, wid * 0.6, 0, wid / 2)
        ..close(),
      _Feather.metal => Path()
        ..addRRect(RRect.fromRectAndRadius(Rect.fromLTRB(0, -wid * 0.42, len, wid * 0.42), Radius.circular(wid * 0.42))),
    };
    c.drawPath(
      p,
      _grad(p.getBounds(), [base, tip], begin: Alignment.centerLeft, end: Alignment.centerRight),
    );
    if (kind == _Feather.metal) {
      c.drawLine(Offset(len * 0.62, -wid * 0.3), Offset(len * 0.62, wid * 0.3), _stroke(_teal, g.lw * 0.8));
    }
    c
      ..drawPath(p, _stroke(line, g.lw * 0.9))
      ..restore();
  }
  // The covert hides where the feathers meet.
  final covert = Rect.fromCenter(center: Offset(span * 0.1, -span * 0.08), width: span * 0.46, height: span * 0.42);
  c
    ..drawOval(covert, _grad(covert, [_mix(base, _white, 0.2), base]))
    ..drawOval(covert, _stroke(line, g.lw * 0.9))
    ..restore();
}

Path _boltShape(double s) => _poly(const [
  (-0.17, 0.08), (-0.03, -0.5), (-0.16, -0.46), (0.1, -1.0),
  (0.05, -0.42), (0.18, -0.46), (0.11, 0.08),
], Offset.zero, s);

void _zigCrest(Canvas c, _G g) {
  final s = g.h * (0.2 + 0.28 * g.grow);
  final base = Offset(g.fx - g.w * 0.01, -g.h * 0.95);
  for (final side in const [-1.0, 1.0]) {
    c
      ..save()
      ..translate(base.dx + side * g.w * 0.1, base.dy + g.h * 0.03)
      ..rotate(side * 0.5)
      ..scale(side, 1);
    _part(c, g, _boltShape(s * 0.62), colors: const [_violetLight, _violet], line: _violetLine, lineScale: 0.9);
    c.restore();
  }
  c
    ..save()
    ..translate(base.dx, base.dy);
  _part(c, g, _boltShape(s), colors: const [Color(0xFFFFF7C2), Color(0xFFFFD43B)], line: _violetLine);
  c.restore();
}

void _zigTail(Canvas c, _G g) {
  final s = g.w * (0.18 + 0.2 * g.grow);
  for (final (a, l) in const [(-2.2, 0.9), (-1.75, 1.0), (-1.35, 0.8)]) {
    c
      ..save()
      ..translate(-g.w * 0.36, -g.h * 0.2)
      ..rotate(a + math.pi / 2);
    final len = s * l;
    final p = Path()
      ..moveTo(-s * 0.13, 0)
      ..quadraticBezierTo(-s * 0.16, -len * 0.6, 0, -len)
      ..quadraticBezierTo(s * 0.16, -len * 0.6, s * 0.13, 0)
      ..close();
    _part(c, g, p, colors: const [_violet, _violetLight], line: _violetLine, lineScale: 0.9);
    c.restore();
  }
}

void _birdBelly(Canvas c, _G g, Color top, Color bottom) {
  final r = Rect.fromLTRB(g.fx - g.w * 0.28, -g.h * 0.36, g.fx + g.w * 0.28, g.h * 0.12);
  c
    ..save()
    ..clipRRect(g.bodyRRect.deflate(g.lw * 0.5))
    ..drawOval(r, _grad(r, [top, bottom]))
    ..restore();
}

void _boltMark(Canvas c, _G g) {
  c
    ..save()
    ..translate(g.fx + g.w * 0.01, -g.h * 0.06)
    ..rotate(0.15);
  final bolt = _boltShape(g.h * 0.24);
  c
    ..drawPath(bolt, _fill(_violet))
    ..drawPath(bolt, _stroke(_violetLine, g.lw * 0.7))
    ..restore();
}

void _flameCrest(Canvas c, _G g) {
  final base = Offset(g.fx - g.w * 0.02, -g.h * 0.93);
  final len = g.h * (0.2 + 0.26 * g.grow);
  for (final (dx, a, l) in const [(-0.12, -0.55, 0.62), (0.12, 0.45, 0.6), (0.0, -0.08, 1.0)]) {
    c
      ..save()
      ..translate(base.dx + dx * g.w, base.dy)
      ..rotate(a);
    _flame(c, g, len * l, g.w * 0.17 * (0.7 + 0.3 * l));
    c.restore();
  }
}

/// A flame feather pointing up from the origin.
void _flame(Canvas c, _G g, double len, double wid, {bool outline = true}) {
  Path shape(double l, double w) => Path()
    ..moveTo(-w / 2, 0)
    ..cubicTo(-w * 0.65, -l * 0.35, -w * 0.05, -l * 0.5, -w * 0.25, -l * 0.74)
    ..quadraticBezierTo(-w * 0.1, -l * 0.9, w * 0.14, -l)
    ..cubicTo(w * 0.06, -l * 0.8, w * 0.6, -l * 0.6, w * 0.46, -l * 0.3)
    ..quadraticBezierTo(w * 0.5, -l * 0.1, w / 2, 0)
    ..close();
  final outer = shape(len, wid);
  c.drawPath(
    outer,
    _grad(outer.getBounds(), const [Color(0xFFFF3D3D), Color(0xFFFF8A1F), Color(0xFFFFD45A)], stops: const [0, 0.55, 1]),
  );
  if (outline) c.drawPath(outer, _stroke(const Color(0xFFA2300A), g.lw * 0.85));
  final inner = shape(len * 0.62, wid * 0.5);
  c.drawPath(inner, _grad(inner.getBounds(), const [Color(0xFFFFC23D), Color(0xFFFFF4B0)]));
}

void _phoenixTail(Canvas c, _G g) {
  final len = g.w * (0.35 + 0.45 * g.grow);
  for (final (a, l) in const [(-2.05, 0.75), (-1.55, 1.0), (-1.1, 0.8)]) {
    c
      ..save()
      ..translate(-g.w * 0.34, -g.h * 0.22)
      ..rotate(a);
    _flame(c, g, len * l, g.w * 0.2);
    c.restore();
  }
}

// --- Robot owl -------------------------------------------------------------

void _owlTufts(Canvas c, _G g) {
  for (final side in const [-1.0, 1.0]) {
    final a = Offset(side * g.w * 0.45, -g.h * 0.76);
    final b = Offset(side * g.w * 0.12, -g.h * 0.985);
    final tip = Offset(side * g.w * 0.5, -g.h - g.h * 0.22 * (0.4 + 0.6 * g.grow));
    final tuft = _roundTri(a, tip, b, 0.12);
    _part(c, g, tuft, colors: const [Color(0xFFE9EFF5), Color(0xFF8A9CB0)]);
    c.drawLine(Offset.lerp(tip, a, 0.12)!, Offset.lerp(tip, a, 0.7)!, _stroke(_teal, g.lw * 0.9));
  }
}

void _antenna(Canvas c, _G g) {
  final base = Offset(g.fx * 0.5, -g.h * 0.96);
  final tip = base + Offset(g.w * 0.05, -g.h * 0.26 * (0.5 + 0.5 * g.grow));
  final r = g.w * 0.05;
  c
    ..drawLine(base, tip, _stroke(g.look.line, g.lw * 2.1))
    ..drawLine(base, tip, _stroke(const Color(0xFFB8C6D4), g.lw * 0.9))
    ..drawCircle(tip, r * 2.1, _blur(_teal.withValues(alpha: 0.55), r))
    ..drawCircle(tip, r, _grad(Rect.fromCircle(center: tip, radius: r), const [Color(0xFFCFFFFA), _teal]))
    ..drawCircle(tip, r, _stroke(g.look.line, g.lw * 0.8))
    ..drawCircle(tip + Offset(-r * 0.35, -r * 0.35), r * 0.28, _fill(_white.withValues(alpha: 0.9)));
}

void _owlFace(Canvas c, _G g) {
  final r = g.w * const [0.17, 0.16, 0.15][g.s];
  // The facial disc: two plates behind the visors.
  final disc = Path.combine(
    PathOperation.union,
    Path()..addOval(Rect.fromCircle(center: Offset(g.fx - g.ex, g.ey), radius: r * 1.42)),
    Path()..addOval(Rect.fromCircle(center: Offset(g.fx + g.ex, g.ey), radius: r * 1.42)),
  );
  c
    ..save()
    ..clipRRect(g.bodyRRect.deflate(g.lw * 0.5))
    ..drawPath(disc, _grad(disc.getBounds(), const [Color(0xFFF8FBFE), Color(0xFFB9C7D5)]))
    ..drawPath(disc, _stroke(g.look.line.withValues(alpha: 0.4), g.lw * 0.7))
    ..restore();
  // A seam with rivets, and a chest light.
  final seamY = -g.h * 0.24;
  c
    ..save()
    ..clipRRect(g.bodyRRect)
    ..drawLine(Offset(-g.w * 0.5, seamY), Offset(g.w * 0.5, seamY), _stroke(g.look.line.withValues(alpha: 0.45), g.lw * 0.7))
    ..restore();
  for (final x in const [-0.36, 0.36]) {
    c.drawCircle(Offset(x * g.w, seamY + g.h * 0.06), g.w * 0.016, _fill(g.look.line.withValues(alpha: 0.6)));
  }
  final light = Offset(g.fx, -g.h * 0.12);
  c
    ..drawCircle(light, g.w * 0.07, _blur(_teal.withValues(alpha: 0.55), g.w * 0.035))
    ..drawCircle(light, g.w * 0.042, _fill(const Color(0xFFB8FFF6)))
    ..drawCircle(light, g.w * 0.042, _stroke(g.look.line, g.lw * 0.7));
}

// --- Unicorn ---------------------------------------------------------------

/// A lock of mane from [root] to [tip], bent by [bend] (a fraction of its
/// length, to the left of the direction of travel).
Path _lock(Offset root, Offset tip, double width, double bend) {
  final d = tip - root;
  final len = d.distance;
  final n = Offset(-d.dy, d.dx) / len;
  final mid = root + d * 0.5 + n * len * bend;
  return Path()
    ..moveTo(root.dx + n.dx * width / 2, root.dy + n.dy * width / 2)
    ..quadraticBezierTo(mid.dx + n.dx * width * 0.55, mid.dy + n.dy * width * 0.55, tip.dx, tip.dy)
    ..quadraticBezierTo(mid.dx - n.dx * width * 0.45, mid.dy - n.dy * width * 0.45, root.dx - n.dx * width / 2, root.dy - n.dy * width / 2)
    ..close();
}

void _unicornEars(Canvas c, _G g) {
  for (final side in const [-1.0, 1.0]) {
    final a = Offset(side * g.w * 0.43, -g.h * 0.8);
    final b = Offset(side * g.w * 0.16, -g.h * 0.99);
    final tip = Offset(side * g.w * 0.39, -g.h - g.h * 0.2 * (0.5 + 0.5 * g.grow));
    _part(c, g, _roundTri(a, tip, b, 0.35), colors: [g.look.top, g.look.bottom]);
    final cen = (a + tip + b) / 3;
    c.drawPath(
      _roundTri(Offset.lerp(a, cen, 0.45)!, Offset.lerp(tip, cen, 0.4)!, Offset.lerp(b, cen, 0.45)!, 0.35),
      _fill(const Color(0xFFFFB6D5)),
    );
  }
}

void _unicornHorn(Canvas c, _G g) {
  final base = Offset(g.fx + g.w * 0.03, -g.h * 0.95);
  final len = g.h * (0.12 + 0.34 * g.grow);
  final width = g.w * (0.1 + 0.06 * g.grow);
  final tip = base + Offset(len * 0.12, -len);
  final horn = Path()
    ..moveTo(base.dx - width / 2, base.dy)
    ..quadraticBezierTo(base.dx - width * 0.3, base.dy - len * 0.55, tip.dx, tip.dy)
    ..quadraticBezierTo(base.dx + width * 0.42, base.dy - len * 0.5, base.dx + width / 2, base.dy)
    ..close();
  c.drawPath(
    horn,
    _grad(horn.getBounds(), const [Color(0xFFFFF4C2), Color(0xFFFFCF4A), Color(0xFFE39A22)], begin: Alignment.centerLeft, end: Alignment.centerRight, stops: const [0, 0.45, 1]),
  );
  c
    ..save()
    ..clipPath(horn);
  final spiral = _stroke(const Color(0xFFC57F14).withValues(alpha: 0.75), g.lw * 0.8);
  for (var i = 1; i <= 4; i++) {
    final t = i / 5;
    final y = base.dy - len * t;
    final x = base.dx + (tip.dx - base.dx) * t;
    final hw = width * 0.62 * (1 - t);
    c.drawLine(Offset(x - hw, y + hw * 0.55), Offset(x + hw, y - hw * 0.55), spiral);
  }
  c
    ..restore()
    ..drawPath(horn, _stroke(_goldLine, g.lw * 0.9));
  if (g.grow > 0.5) _sparkle(c, tip + Offset(g.w * 0.02, -g.w * 0.02), g.w * 0.06, const Color(0xFFFFE680));
}

void _maneBack(Canvas c, _G g) {
  final locks = [
    (Offset(-g.w * 0.15, -g.h * 0.96), Offset(-g.w * 0.62, -g.h * 0.84), 0),
    (Offset(-g.w * 0.28, -g.h * 0.8), Offset(-g.w * 0.67, -g.h * 0.58), 2),
    (Offset(-g.w * 0.3, -g.h * 0.6), Offset(-g.w * 0.64, -g.h * 0.35), 3),
    (Offset(-g.w * 0.3, -g.h * 0.42), Offset(-g.w * 0.57, -g.h * 0.14), 4),
  ];
  final k = 0.6 + 0.4 * g.grow;
  for (final (root, tip, ci) in locks) {
    final t = root + (tip - root) * k;
    _part(c, g, _lock(root, t, g.w * 0.22, -0.18), colors: [_rainbow[ci], _mix(_rainbow[ci], _white, 0.35)], line: g.look.line, lineScale: 0.85);
  }
}

void _unicornTail(Canvas c, _G g) {
  final k = 0.55 + 0.45 * g.grow;
  final root = Offset(-g.w * 0.36, -g.h * 0.22);
  for (final (dx, dy, ci) in const [(-0.42, -0.36, 5), (-0.46, -0.08, 0), (-0.36, 0.16, 2)]) {
    _part(c, g, _lock(root, root + Offset(dx, dy) * g.w * k, g.w * 0.2, 0.2), colors: [_rainbow[ci], _mix(_rainbow[ci], _white, 0.3)], lineScale: 0.85);
  }
}

void _bangs(Canvas c, _G g) {
  final top = -g.h * 0.985;
  final locks = [
    (Offset(g.fx + g.w * 0.16, top), Offset(g.fx - g.w * 0.14, -g.h * 0.76), 4),
    (Offset(g.fx + g.w * 0.06, top), Offset(g.fx - g.w * 0.3, -g.h * 0.78), 2),
    (Offset(g.fx - g.w * 0.02, top), Offset(g.fx - g.w * 0.42, -g.h * 0.86), 0),
  ];
  for (final (root, tip, ci) in locks) {
    _part(c, g, _lock(root, tip, g.w * 0.17, 0.22), colors: [_mix(_rainbow[ci], _white, 0.3), _rainbow[ci]], lineScale: 0.85);
  }
}

// --- Golden founder ----------------------------------------------------------

void _goldShine(Canvas c, _G g) {
  c
    ..save()
    ..clipRRect(g.bodyRRect.deflate(g.lw * 0.5))
    ..translate(-g.w * 0.05, -g.h * 0.62)
    ..rotate(-0.7);
  c
    ..drawRect(Rect.fromCenter(center: Offset(-g.w * 0.12, 0), width: g.w * 0.09, height: g.w * 1.6), _fill(_white.withValues(alpha: 0.28)))
    ..drawRect(Rect.fromCenter(center: Offset(-g.w * 0.25, 0), width: g.w * 0.035, height: g.w * 1.6), _fill(_white.withValues(alpha: 0.22)))
    ..restore();
  _sparkle(c, Offset(g.w * 0.3, -g.h * 0.78), g.w * 0.06, _white);
}

void _crown(Canvas c, _G g) {
  final k = 0.75 + 0.25 * g.grow;
  final s = g.w * 0.42 * k;
  c
    ..save()
    ..translate(g.fx + g.w * 0.05, -g.h * 0.98)
    ..rotate(0.14);
  final crown = Path()
    ..moveTo(-s / 2, 0)
    ..lineTo(-s / 2, -s * 0.42)
    ..lineTo(-s * 0.24, -s * 0.2)
    ..lineTo(0, -s * 0.55)
    ..lineTo(s * 0.24, -s * 0.2)
    ..lineTo(s / 2, -s * 0.42)
    ..lineTo(s / 2, 0)
    ..close();
  c
    ..drawPath(crown, _grad(crown.getBounds(), const [Color(0xFFFFF0A0), _gold, _goldDeep], stops: const [0, 0.5, 1]))
    ..drawPath(crown, _stroke(_goldLine, g.lw * 0.9))
    ..drawLine(Offset(-s / 2, -s * 0.1), Offset(s / 2, -s * 0.1), _stroke(_goldLine.withValues(alpha: 0.6), g.lw * 0.7));
  for (final (x, y) in const [(-0.5, -0.42), (0.0, -0.55), (0.5, -0.42)]) {
    final at = Offset(x * s, y * s);
    c
      ..drawCircle(at, s * 0.07, _fill(const Color(0xFFFFFBF0)))
      ..drawCircle(at, s * 0.07, _stroke(_goldLine, g.lw * 0.6));
  }
  for (final (x, color) in const [(-0.27, Color(0xFF4FE0C6)), (0.0, Color(0xFFFF6FB0)), (0.27, Color(0xFF7C6BFF))]) {
    final at = Offset(x * s, -s * 0.2);
    c
      ..drawCircle(at, s * 0.065, _fill(color))
      ..drawCircle(at + Offset(-s * 0.02, -s * 0.02), s * 0.022, _fill(_white.withValues(alpha: 0.8)));
  }
  c.restore();
}

// ---------------------------------------------------------------------------
// Backgrounds and cards
// ---------------------------------------------------------------------------

/// The store plates' look: the Classic background as a vertical gradient
/// with a soft accent glow.
void _plate(Canvas c, Size size, {Color accent = const Color(0xFF4FE0C6), Rect? glow, double glowAlpha = 0.16}) {
  final rect = Offset.zero & size;
  const base = Color(0xFF0F1030);
  c.drawRect(
    rect,
    _grad(rect, [_mix(base, _black, 0.35), _mix(base, _white, 0.06)]),
  );
  final g = glow ?? Rect.fromLTRB(-size.width * 0.2, size.height * 0.28, size.width * 1.2, size.height * 0.94);
  c.drawOval(g, _blur(accent.withValues(alpha: glowAlpha), size.shortestSide * 0.16));
}

void _card(Canvas c, Rect r, Color tint) {
  final rr = RRect.fromRectAndRadius(r, const Radius.circular(30));
  c
    ..drawRRect(rr.shift(const Offset(0, 12)), _blur(_black.withValues(alpha: 0.45), 18))
    ..drawRRect(rr, _grad(r, const [Color(0xFF22265C), Color(0xFF15173D)]))
    ..save()
    ..clipRRect(rr)
    ..drawCircle(r.center + Offset(0, -r.height * 0.06), r.width * 0.36, _blur(tint.withValues(alpha: 0.3), r.width * 0.15))
    ..drawOval(
      Rect.fromCenter(center: Offset(r.center.dx, r.bottom - r.height * 0.2), width: r.width * 0.7, height: r.height * 0.12),
      _fill(const Color(0xFF2B2F6B).withValues(alpha: 0.6)),
    )
    ..restore()
    ..drawRRect(rr.deflate(0.75), _stroke(tint.withValues(alpha: 0.38), 1.5));
}

// ---------------------------------------------------------------------------
// The board, from the game's own painters
// ---------------------------------------------------------------------------

GameTheme get _classic =>
    kThemeCatalog.firstWhere((e) => e.id == kDefaultThemeId).theme;

/// I, T and P are the Classic tray colours (indigo, teal, pink); anything
/// else is an empty cell.
Color? _blockColor(String ch) => switch (ch) {
  'I' => _classic.traySlots[0],
  'T' => _classic.traySlots[1],
  'P' => _classic.traySlots[2],
  _ => null,
};

/// A board of [cols]×[rows] cells in [area], drawn the way `BoardView` draws
/// it on a phone (40 logical px a cell, inset 1.5 px, corners at 22 %) and
/// scaled up as if by the device pixel ratio, so the blocks' thin rims come
/// out as thick as in a real screenshot.
class _Board {
  const _Board(this.area, {this.cols = 8, this.rows = 8});

  static const double unit = 40;

  final Rect area;
  final int cols;
  final int rows;

  double get cell => area.width / cols;
  double get k => cell / unit;

  /// A cell in board-local logical coordinates.
  static Rect local(int row, num col) =>
      Rect.fromLTWH(col * unit + 1.5, row * unit + 1.5, unit - 3, unit - 3);

  /// The middle of a cell on the canvas; [row] and [col] may be fractional.
  Offset at(num row, num col) =>
      Offset(area.left + (col + 0.5) * cell, area.top + (row + 0.5) * cell);

  /// Runs [draw] in board-local logical coordinates.
  void scaled(Canvas c, void Function() draw) {
    c
      ..save()
      ..translate(area.left, area.top)
      ..scale(k);
    draw();
    c.restore();
  }
}

const double _cellRadius = _Board.unit * 0.22;

/// The board's plate, its empty cells and the blocks of [cells]. Rows in
/// [cleared] are drawn empty: the game removes a row at once and the sweep
/// plays over the empty cells.
void _paintBoard(
  Canvas c,
  _Board b,
  List<String> cells, {
  Set<int> cleared = const {},
  bool shadow = true,
}) {
  final t = _classic;
  final plate = RRect.fromRectAndRadius(b.area, Radius.circular(b.cell * 0.25));
  if (shadow) {
    c.drawRRect(
      plate.shift(Offset(0, b.cell * 0.18)),
      _blur(_black.withValues(alpha: 0.5), b.cell * 0.3),
    );
  }
  c.drawRRect(plate, _fill(t.boardBackground));
  b.scaled(c, () {
    c.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, b.cols * _Board.unit, b.rows * _Board.unit).deflate(0.5),
        const Radius.circular(_Board.unit * 0.25),
      ),
      _stroke(t.emptyCell, 1),
    );
    for (var r = 0; r < b.rows; r++) {
      for (var col = 0; col < b.cols; col++) {
        final color = cleared.contains(r) ? null : _blockColor(cells[r][col]);
        final rect = _Board.local(r, col);
        if (color == null) {
          c.drawRRect(
            RRect.fromRectAndRadius(rect, const Radius.circular(_cellRadius)),
            _fill(t.emptyCell),
          );
        } else {
          paintCell(c, rect, _cellRadius, color, BlockSkinStyle.solid, phase: (r + col).toDouble());
        }
      }
    }
  });
}

/// A soft glow round row [row]: it is full and about to go.
void _rowGlow(Canvas c, _Board b, int row, Color color) {
  final r = RRect.fromRectAndRadius(
    Rect.fromLTWH(b.area.left, b.area.top + row * b.cell, b.area.width, b.cell).inflate(b.cell * 0.04),
    Radius.circular(b.cell * 0.26),
  );
  c
    ..drawRRect(r, _stroke(color.withValues(alpha: 0.75), b.cell * 0.12)..maskFilter = MaskFilter.blur(BlurStyle.normal, b.cell * 0.12))
    ..drawRRect(r, _stroke(_mix(color, _white, 0.55), b.cell * 0.035));
}

// --- The row effects ---------------------------------------------------------

/// How far along its line the sweep is when the last cell starts, as
/// `_spread` in lib/ui/widgets/clear_sweep.dart (private there).
double _spreadOf(ClearEffectStyle style) => switch (style) {
  ClearEffectStyle.classic => 0.25,
  ClearEffectStyle.frost => 0.3,
  _ => 0.45,
};

/// The sweep time at which the cell at [order] (0..1 along the line) starts
/// to dissolve: matching it to the pet's position keeps pet and row in step.
double _sweepAt(ClearEffectStyle style, double order) => _spreadOf(style) * order;

/// The blocks of row [row] as `ClearSweep` hands them to `paintClearSweep`,
/// board-local. [fromRight] orders the sweep the way the pet flies.
List<SweepCell> _rowSweep(List<String> cells, int row, {bool fromRight = false}) {
  final n = cells[row].length;
  return [
    for (var col = 0; col < n; col++)
      if (_blockColor(cells[row][col]) case final color?)
        SweepCell(
          rect: _Board.local(row, col),
          color: color,
          order: (fromRight ? n - 1 - col : col) / (n - 1),
          horizontal: true,
          seed: row * 8 + col,
        ),
  ];
}

/// A sweep at time [t]: the blocks it has not reached yet stand as real
/// blocks (`paintCell`), the rest dissolve in the game's own effect.
void _paintSweep(Canvas c, List<SweepCell> cells, ClearEffectStyle style, double t) {
  final started = <SweepCell>[];
  for (final cell in cells) {
    if (t <= _sweepAt(style, cell.order)) {
      paintCell(c, cell.rect, _cellRadius, cell.color, BlockSkinStyle.solid);
    } else {
      started.add(cell);
    }
  }
  paintClearSweep(c, started, style, t);
}

/// A stable pseudo-random 0..1, like `_noise` in clear_sweep.dart.
double _hash(int seed, int i) {
  final x = math.sin(seed * 12.9898 + i * 78.233) * 43758.5453;
  return x - x.floorToDouble();
}

/// The rainbow trail's own dissolve (new; the game has no rainbow effect
/// yet): the block takes on a rainbow colour, spins away small and bursts
/// into stars. Same timing as the game's effects.
void _paintPrismSweep(Canvas c, List<SweepCell> cells, double t) {
  const spread = 0.45;
  for (final cell in cells) {
    final p = ((t - cell.order * spread) / (1 - spread)).clamp(0.0, 1.0);
    final r = cell.rect;
    if (p <= 0) {
      paintCell(c, r, _cellRadius, cell.color, BlockSkinStyle.solid);
      continue;
    }
    if (p >= 1) continue;
    final hue = _rainbow[cell.seed % _rainbow.length];
    final tint = (p / 0.3).clamp(0.0, 1.0);
    final shrink = Curves.easeIn.transform(((p - 0.15) / 0.85).clamp(0.0, 1.0));
    c.drawCircle(
      r.center,
      r.width * (0.45 + 0.35 * tint),
      _blur(hue.withValues(alpha: 0.6 * (1 - shrink)), r.width * 0.22),
    );
    c
      ..save()
      ..translate(r.center.dx, r.center.dy)
      ..rotate((cell.seed.isEven ? 1 : -1) * 1.3 * shrink)
      ..scale(1 - shrink * 0.8);
    paintCell(
      c,
      Rect.fromCenter(center: Offset.zero, width: r.width, height: r.height),
      _cellRadius,
      Color.lerp(cell.color, _mix(hue, _white, 0.2), tint)!,
      BlockSkinStyle.solid,
    );
    c.restore();
    final burst = Curves.easeOut.transform(p);
    for (var i = 0; i < 5; i++) {
      final a = i / 5 * 2 * math.pi + _hash(cell.seed, i) * 0.9;
      final dist = r.width * (0.2 + 0.9 * burst);
      final s = r.width * (0.11 + 0.07 * _hash(cell.seed, i + 7)) * math.sin(math.pi * math.min(1.0, p * 1.15));
      if (s < 0.5) continue;
      _sparkle(c, r.center + Offset(math.cos(a), math.sin(a)) * dist, s, _rainbow[(cell.seed + i) % _rainbow.length]);
    }
  }
}

// --- Breath, beams, bolts, trails ---------------------------------------------

Offset _quad(Offset a, Offset b, Offset c, double t) {
  final u = 1 - t;
  return a * (u * u) + b * (2 * u * t) + c * (t * t);
}

/// Points on a gentle curve from [from] to [to], bent by [bend] (a share of
/// its length, to the left of the way it runs).
List<Offset> _arc(Offset from, Offset to, double bend, [int n = 40]) {
  final d = to - from;
  final ctrl = from + d * 0.5 + Offset(-d.dy, d.dx) * bend;
  return [for (var i = 0; i <= n; i++) _quad(from, ctrl, to, i / n)];
}

/// The unit normal of [pts] at [i], pointing up the screen.
Offset _upNormal(List<Offset> pts, int i) {
  final n = pts.length - 1;
  final d = pts[math.min(n, i + 1)] - pts[math.max(0, i - 1)];
  final nn = Offset(-d.dy, d.dx) / d.distance;
  return nn.dy > 0 ? -nn : nn;
}

/// A breath along [pts]: narrow at the mouth, [width] at the end, its edges
/// rippling by [ripple], ending in a round puff.
Path _stream(List<Offset> pts, double width, {double ripple = 0, double phase = 0, double start = 0.12}) {
  final left = <Offset>[];
  final right = <Offset>[];
  final n = pts.length - 1;
  for (var i = 0; i <= n; i++) {
    final t = i / n;
    final d = pts[math.min(n, i + 1)] - pts[math.max(0, i - 1)];
    final nn = Offset(-d.dy, d.dx) / d.distance;
    final w = width * (start + (1 - start) * math.pow(t, 0.7)) / 2;
    final edge = math.min(1.0, t * 4);
    left.add(pts[i] + nn * (w * (1 + ripple * edge * math.sin(t * 19 + phase))));
    right.add(pts[i] - nn * (w * (1 + ripple * edge * math.sin(t * 15 + phase * 1.7 + 1))));
  }
  final path = Path()..moveTo(left.first.dx, left.first.dy);
  for (final p in left.skip(1)) {
    path.lineTo(p.dx, p.dy);
  }
  path.arcToPoint(right.last, radius: Radius.circular(width * 0.55), clockwise: false);
  for (final p in right.reversed) {
    path.lineTo(p.dx, p.dy);
  }
  return path..close();
}

/// A flame tongue standing on [base], pointing along [dir].
Path _tongue(Offset base, Offset dir, double len, double wid) {
  final n = Offset(-dir.dy, dir.dx);
  final tip = base + dir * len;
  final l = base + n * (wid / 2);
  final r = base - n * (wid / 2);
  final cl = base + n * (wid * 0.55) + dir * (len * 0.55);
  final cr = base - n * (wid * 0.3) + dir * (len * 0.6);
  return Path()
    ..moveTo(l.dx, l.dy)
    ..quadraticBezierTo(cl.dx, cl.dy, tip.dx, tip.dy)
    ..quadraticBezierTo(cr.dx, cr.dy, r.dx, r.dy)
    ..arcToPoint(l, radius: Radius.circular(wid / 2))
    ..close();
}

void _ember(Canvas c, Offset at, double r, [Color color = const Color(0xFFFF9A2E)]) {
  c
    ..drawCircle(at, r * 2.6, _blur(color.withValues(alpha: 0.45), r * 1.3))
    ..drawCircle(at, r, _fill(_mix(color, _white, 0.3)))
    ..drawCircle(at, r * 0.45, _fill(_white.withValues(alpha: 0.95)));
}

/// The dragon's fire breath from [from] (its mouth) to [to], [width] wide
/// at the far end, where it billows.
void _fireBreath(Canvas c, Offset from, Offset to, double width, {double bend = 0.1, int seed = 0}) {
  final pts = _arc(from, to, bend);
  final n = pts.length - 1;
  final ph = seed * 1.7;
  double halfAt(double t) => width * (0.12 + 0.88 * math.pow(t, 0.7)) / 2;
  // Billows: puffs round the far end, bigger towards it.
  List<(Offset, double)> billows(double k) => [
    for (var b = 0; b < 5; b++)
      () {
        final t = 0.6 + b * 0.1;
        final i = (math.min(t, 1.0) * n).round();
        final side = b.isEven ? 1.0 : -1.0;
        return (
          pts[i] + _upNormal(pts, i) * (side * halfAt(t) * 0.35),
          halfAt(t) * (0.62 + 0.18 * _hash(seed, b)) * k,
        );
      }(),
  ];
  Paint body(List<Color> colors, List<double> stops) =>
      Paint()..shader = ui.Gradient.linear(from, to, colors, stops);

  c
    ..drawCircle(to, width * 0.75, _blur(const Color(0xFFFF7A1F).withValues(alpha: 0.4), width * 0.5))
    ..drawPath(
      _stream(pts, width * 1.5, ripple: 0.1, phase: ph),
      _blur(const Color(0xFFFF4A1F).withValues(alpha: 0.5), width * 0.24),
    );
  // Tongues licking up off the stream behind the body: fire rises.
  for (var k = 0; k < 6; k++) {
    final t = 0.3 + k * 0.13;
    final i = (math.min(t, 1.0) * n).round();
    final up = _upNormal(pts, i);
    final d = pts[math.min(n, i + 1)] - pts[math.max(0, i - 1)];
    final back = -d / d.distance;
    final low = k == 2 || k == 4; // a couple hang down off the underside
    final base = pts[i] + up * (halfAt(t) * (low ? -0.5 : 0.5));
    var dir = low ? -up * 0.7 + back * 0.6 : up * 0.9 + back * 0.4 + const Offset(0, -0.35);
    dir = dir / dir.distance;
    final tl = width * (low ? 0.28 : 0.42 + 0.3 * _hash(seed, k)) * (0.6 + t * 0.6);
    c
      ..drawPath(_tongue(base, dir, tl, width * 0.3), _fill(const Color(0xFFF2402A)))
      ..drawPath(_tongue(base + dir * (tl * 0.06), dir, tl * 0.7, width * 0.2), _fill(const Color(0xFFFF8A1F)))
      ..drawPath(_tongue(base + dir * (tl * 0.1), dir, tl * 0.38, width * 0.1), _fill(const Color(0xFFFFD45A)));
  }
  final outer = body(const [Color(0xFFFFC94A), Color(0xFFFF7A1F), Color(0xFFE8362A)], const [0, 0.45, 1]);
  c.drawPath(_stream(pts, width, ripple: 0.2, phase: ph), outer);
  for (final (at, r) in billows(1)) {
    c.drawCircle(at, r, outer);
  }
  final mid = body(const [Color(0xFFFFF0B0), Color(0xFFFFB02E), Color(0xFFFF7A1F)], const [0, 0.5, 1]);
  c.drawPath(_stream(pts, width * 0.62, ripple: 0.14, phase: ph + 2), mid);
  for (final (at, r) in billows(0.55)) {
    c.drawCircle(at, r, mid);
  }
  // The white-hot core fades out well before the end.
  c.drawPath(
    _stream(pts, width * 0.3, ripple: 0.08, phase: ph + 4, start: 0.32),
    body([
      const Color(0xFFFFFDF0),
      const Color(0xFFFFF0A8),
      const Color(0xFFFFE07A).withValues(alpha: 0),
    ], const [0, 0.45, 0.8]),
  );
  // Embers rising off the far end.
  for (var i = 0; i < 10; i++) {
    final at = to + Offset((_hash(seed + 3, i) - 0.55) * width * 2.4, -_hash(seed + 5, i) * width * 2.0 - width * 0.25);
    _ember(c, at, width * (0.03 + 0.035 * _hash(seed + 9, i)), i.isEven ? const Color(0xFFFF9A2E) : const Color(0xFFFFC23D));
  }
}

void _snowflake(Canvas c, Offset at, double r, double rot, [double alpha = 1]) {
  final paint = _stroke(_white.withValues(alpha: alpha), r * 0.17);
  c.drawCircle(at, r * 1.25, _blur(const Color(0xFF8FD8FF).withValues(alpha: 0.5 * alpha), r * 0.6));
  for (var i = 0; i < 6; i++) {
    final a = rot + i * math.pi / 3;
    final dir = Offset(math.cos(a), math.sin(a));
    c.drawLine(at, at + dir * r, paint);
    final mid = at + dir * (r * 0.56);
    for (final s in const [-1.0, 1.0]) {
      final b = a + s * 0.8;
      c.drawLine(mid, mid + Offset(math.cos(b), math.sin(b)) * (r * 0.34), paint);
    }
  }
}

/// The penguin's frost breath: a cold, curling stream with snowflakes.
void _frostBreath(Canvas c, Offset from, Offset to, double width, {double bend = 0.08, int seed = 0}) {
  final pts = _arc(from, to, bend);
  final ph = seed * 1.3;
  c
    ..drawPath(
      _stream(pts, width * 1.5, ripple: 0.1, phase: ph),
      _blur(const Color(0xFF7FD4FF).withValues(alpha: 0.5), width * 0.25),
    )
    ..drawPath(
      _stream(pts, width, ripple: 0.13, phase: ph),
      Paint()
        ..shader = ui.Gradient.linear(from, to, [
          _white.withValues(alpha: 0.95),
          const Color(0xFFCDEFFF).withValues(alpha: 0.85),
          const Color(0xFF7CC8FF).withValues(alpha: 0.6),
        ], const [0, 0.5, 1]),
    )
    ..drawPath(
      _stream(pts, width * 0.5, ripple: 0.1, phase: ph + 2, start: 0.25),
      Paint()
        ..shader = ui.Gradient.linear(from, to, [
          _white,
          _white.withValues(alpha: 0.55),
        ]),
    );
  // Curls of cold air.
  final n = pts.length - 1;
  final curl = _stroke(_white.withValues(alpha: 0.85), width * 0.05);
  for (final (t, side) in const [(0.35, 1.0), (0.6, -1.0), (0.84, 1.0)]) {
    final i = (t * n).round();
    final up = _upNormal(pts, i) * side;
    final w = width * (0.12 + 0.88 * math.pow(t, 0.7)) / 2;
    final ctr = pts[i] + up * (w * 0.55);
    final r = width * 0.16 * (0.6 + t);
    c.drawArc(Rect.fromCircle(center: ctr, radius: r), math.atan2(up.dy, up.dx) - 0.4, 4.2, false, curl);
  }
  // Snowflakes and ice glints along the way and past its end.
  for (var i = 0; i < 9; i++) {
    final t = 0.25 + 0.8 * _hash(seed + 2, i);
    final j = (math.min(t, 1.0) * n).round();
    final up = _upNormal(pts, j);
    final w = width * (0.12 + 0.88 * math.pow(math.min(t, 1.0), 0.7)) / 2;
    final at = pts[j] + up * ((_hash(seed + 4, i) * 2 - 1) * w * 1.5) + (t > 1 ? (to - from) / (to - from).distance * ((t - 1) * width * 2) : Offset.zero);
    final r = width * (0.07 + 0.08 * _hash(seed + 6, i));
    if (i % 3 == 2) {
      _sparkle(c, at, r * 0.9, const Color(0xFFBFEFFF));
    } else {
      _snowflake(c, at, r, _hash(seed + 8, i) * math.pi);
    }
  }
}

/// A laser beam, red with a white-hot core.
void _laser(Canvas c, Offset from, Offset to, double w) {
  c
    ..drawLine(from, to, _stroke(const Color(0xFFFF2D55).withValues(alpha: 0.55), w * 3.6)..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 1.4))
    ..drawLine(from, to, _stroke(const Color(0xFFFF4D6D), w * 1.3))
    ..drawLine(from, to, _stroke(const Color(0xFFFFE9EE), w * 0.48))
    ..drawCircle(from, w * 2.8, _blur(const Color(0xFFFF4D6D).withValues(alpha: 0.75), w * 1.3))
    ..drawCircle(from, w * 1.05, _fill(const Color(0xFFFFE9EE)));
}

/// Where a beam or a bolt lands: a flash and a fan of sparks.
void _impact(Canvas c, Offset at, double r, Color color, {int seed = 0}) {
  c
    ..drawCircle(at, r * 1.7, _blur(color.withValues(alpha: 0.6), r * 0.8))
    ..drawCircle(at, r * 0.5, _fill(_mix(color, _white, 0.7)));
  final spark = _stroke(_mix(color, _white, 0.55), r * 0.13);
  for (var i = 0; i < 7; i++) {
    final a = -math.pi * (0.08 + 0.84 * _hash(seed, i));
    final dir = Offset(math.cos(a), math.sin(a));
    final len = r * (0.7 + 0.9 * _hash(seed, i + 9));
    c.drawLine(at + dir * (r * 0.75), at + dir * (r * 0.75 + len), spark);
  }
  _sparkle(c, at, r * 0.7, _mix(color, _white, 0.4));
}

/// A jagged line from [a] to [b] that keeps its ends.
List<Offset> _zigzag(Offset a, Offset b, double jag, int seed, [int n = 7]) {
  final d = b - a;
  final nrm = Offset(-d.dy, d.dx) / d.distance;
  return [
    for (var i = 0; i <= n; i++)
      a + d * (i / n) + nrm * (i == 0 || i == n ? 0.0 : (_hash(seed, i) - 0.5) * 2 * jag),
  ];
}

/// A lightning bolt through [pts]: violet glow, yellow body, white core.
void _bolt(Canvas c, List<Offset> pts, double w, {double alpha = 1}) {
  final path = Path()..addPolygon(pts, false);
  c
    ..drawPath(path, _stroke(const Color(0xFFA98BFF).withValues(alpha: 0.65 * alpha), w * 4.4)..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 1.7))
    ..drawPath(path, _stroke(const Color(0xFFFFEE7A).withValues(alpha: alpha), w * 1.7)..strokeJoin = StrokeJoin.miter)
    ..drawPath(path, _stroke(_white.withValues(alpha: alpha), w * 0.62)..strokeJoin = StrokeJoin.miter);
}

/// A rainbow ribbon along [pts], fading out towards its start.
void _rainbowTrail(Canvas c, List<Offset> pts, double band, {double fade = 0.45}) {
  final n = pts.length - 1;
  final from = pts.first;
  final to = pts.last;
  c.drawPath(
    Path()..addPolygon(pts, false),
    _stroke(_white, band * 8)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, band * 1.8)
      ..shader = ui.Gradient.linear(from, to, [
        _white.withValues(alpha: 0),
        _white.withValues(alpha: 0.35),
      ]),
  );
  for (var k = 0; k < _rainbow.length; k++) {
    final off = (k - (_rainbow.length - 1) / 2) * band;
    final path = Path();
    for (var i = 0; i <= n; i++) {
      final p = pts[i] + _upNormal(pts, i) * off;
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    final color = _rainbow[_rainbow.length - 1 - k];
    c.drawPath(
      path,
      _stroke(color, band * 1.12)
        ..strokeCap = StrokeCap.butt
        ..shader = ui.Gradient.linear(from, to, [
          color.withValues(alpha: 0),
          color,
          color,
        ], [0, fade, 1]),
    );
  }
  // A glossy line along the top band.
  final gloss = Path();
  for (var i = (n * fade).round(); i <= n; i++) {
    final p = pts[i] + _upNormal(pts, i) * (band * 2.2);
    i == (n * fade).round() ? gloss.moveTo(p.dx, p.dy) : gloss.lineTo(p.dx, p.dy);
  }
  c.drawPath(gloss, _stroke(_white.withValues(alpha: 0.55), band * 0.3));
}

/// A dotted line along [path], fainter towards its start.
void _dotted(Canvas c, Path path, Color color, double r, double step) {
  for (final m in path.computeMetrics()) {
    for (var d = step * 0.5; d < m.length; d += step) {
      final tan = m.getTangentForOffset(d);
      if (tan == null) continue;
      c.drawCircle(tan.position, r, _fill(color.withValues(alpha: color.a * (0.25 + 0.75 * d / m.length))));
    }
  }
}

/// Little puffs of dust where a pet took off or landed.
void _puffs(Canvas c, Offset at, double s) {
  for (final (dx, dy, r) in const [(-0.55, -0.1, 0.16), (-0.32, -0.22, 0.12), (0.5, -0.12, 0.15), (0.28, -0.24, 0.1)]) {
    final p = at + Offset(dx, dy) * s;
    c
      ..drawCircle(p, r * s, _fill(const Color(0xFFDCDDF5).withValues(alpha: 0.55)))
      ..drawCircle(p, r * s, _stroke(const Color(0xFF8C8FC4).withValues(alpha: 0.6), s * 0.02));
  }
}

/// A small soft shadow on the ground under something in the air.
void _groundShadow(Canvas c, Offset at, double w) {
  c.drawOval(
    Rect.fromCenter(center: at, width: w, height: w * 0.18),
    _blur(_black.withValues(alpha: 0.35), w * 0.05),
  );
}

/// A piece of confetti: a little block in one of the game's colours.
void _confetti(Canvas c, Offset at, double s, double rot, Color color) {
  c
    ..save()
    ..translate(at.dx, at.dy)
    ..rotate(rot);
  final r = Rect.fromCenter(center: Offset.zero, width: s, height: s * 0.62);
  final rr = RRect.fromRectAndRadius(r, Radius.circular(s * 0.16));
  c
    ..drawRRect(rr, _grad(r, [_mix(color, _white, 0.3), color]))
    ..drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(r.left + s * 0.12, r.top + s * 0.08, s * 0.5, s * 0.12), Radius.circular(s * 0.06)),
      _fill(_white.withValues(alpha: 0.45)),
    )
    ..restore();
}

// --- The egg ------------------------------------------------------------------

Path _eggPath(double w, double h) {
  final yMax = h * 0.1; // the widest point sits below the middle
  return Path()
    ..moveTo(0, -h / 2)
    ..cubicTo(w * 0.31, -h / 2, w / 2, -h * 0.2, w / 2, yMax)
    ..cubicTo(w / 2, h * 0.36, w * 0.29, h / 2, 0, h / 2)
    ..cubicTo(-w * 0.29, h / 2, -w / 2, h * 0.36, -w / 2, yMax)
    ..cubicTo(-w / 2, -h * 0.2, -w * 0.31, -h / 2, 0, -h / 2)
    ..close();
}

/// One part of the shell: cream with a band of blocks, dots and a gloss.
void _shell(Canvas c, Path part, double w, double h, double lw) {
  final bounds = Rect.fromCenter(center: Offset.zero, width: w, height: h);
  c
    ..drawPath(
      part,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(-w * 0.2, -h * 0.24),
          h * 0.74,
          const [Color(0xFFFFFFFF), Color(0xFFFFF3DE), Color(0xFFD6C4FF)],
          const [0, 0.46, 1],
        ),
    )
    ..save()
    ..clipPath(part);
  // A band of the game's blocks round the middle, curving with the shell.
  final colors = [..._classic.traySlots, _gold];
  final s = w * 0.15;
  final bandY = h * 0.13;
  for (var i = -3; i <= 3; i++) {
    final a = i * 0.43;
    c
      ..save()
      ..translate(math.sin(a) * w * 0.5, bandY + math.cos(a) * h * 0.035)
      ..scale(math.cos(a), 1);
    paintCell(c, Rect.fromCenter(center: Offset.zero, width: s, height: s), s * 0.24, colors[(i + 7) % colors.length], BlockSkinStyle.solid);
    c.restore();
  }
  for (final (x, y, r, k) in const [
    (-0.2, -0.36, 0.034, 2), (0.15, -0.3, 0.025, 1), (0.27, -0.13, 0.03, 0),
    (-0.3, -0.07, 0.022, 3), (-0.22, 0.31, 0.03, 1), (0.05, 0.37, 0.024, 2),
    (0.3, 0.27, 0.028, 3),
  ]) {
    c.drawCircle(Offset(x * w, y * h), r * h, _fill(_mix(colors[k], _white, 0.3)));
  }
  // Shade to the right and along the bottom, a gloss top left.
  c
    ..drawRect(
      bounds,
      Paint()
        ..shader = ui.Gradient.linear(bounds.centerLeft, bounds.centerRight, [
          const Color(0x007C5FD0),
          const Color(0x007C5FD0),
          const Color(0xFF7C5FD0).withValues(alpha: 0.28),
        ], const [0, 0.55, 1]),
    )
    ..drawRect(
      bounds,
      Paint()
        ..shader = ui.Gradient.linear(bounds.topCenter, bounds.bottomCenter, [
          const Color(0x007C5FD0),
          const Color(0x007C5FD0),
          const Color(0xFF7C5FD0).withValues(alpha: 0.22),
        ], const [0, 0.7, 1]),
    )
    ..save()
    ..translate(-w * 0.25, -h * 0.26)
    ..rotate(-0.55)
    ..drawOval(Rect.fromCenter(center: Offset.zero, width: w * 0.2, height: h * 0.075), _fill(_white.withValues(alpha: 0.9)))
    ..restore()
    ..drawCircle(Offset(-w * 0.13, -h * 0.36), w * 0.025, _fill(_white.withValues(alpha: 0.9)))
    ..restore()
    ..drawPath(part, _stroke(const Color(0xFF7F67C8), lw));
}

/// A hatching egg, [h] tall, standing on [bottom]: the cap above the crack
/// is lifted off and light pours out of the opening.
void _paintEgg(Canvas c, Offset bottom, double h, {double tilt = 0}) {
  final w = h * 0.76;
  final lw = h * 0.013;
  c.drawOval(
    Rect.fromCenter(center: bottom, width: w * 1.05, height: w * 0.2),
    _blur(_black.withValues(alpha: 0.45), w * 0.04),
  );
  c
    ..save()
    ..translate(bottom.dx, bottom.dy - h / 2)
    ..rotate(tilt);
  final egg = _eggPath(w, h);
  c.drawPath(egg, _blur(const Color(0xFFFFE6A0).withValues(alpha: 0.75), h * 0.06));
  final crackY = -h * 0.17;
  final zig = [
    for (var i = 0; i <= 8; i++)
      Offset(-w * 0.6 + i * w * 1.2 / 8, crackY + (i.isEven ? -1 : 1) * h * 0.04 + i * h * 0.005),
  ];
  Path side(double y) {
    final p = Path()..moveTo(zig.first.dx, zig.first.dy);
    for (final z in zig.skip(1)) {
      p.lineTo(z.dx, z.dy);
    }
    return p
      ..lineTo(w * 0.6, y)
      ..lineTo(-w * 0.6, y)
      ..close();
  }

  final base = Path.combine(PathOperation.intersect, egg, side(h));
  final cap = Path.combine(PathOperation.intersect, egg, side(-h));
  // Light pouring out of the opening.
  final mouth = Offset(0, crackY - h * 0.04);
  c
    ..drawOval(Rect.fromCenter(center: mouth, width: w * 1.25, height: h * 0.42), _blur(const Color(0xFFFFE39A).withValues(alpha: 0.9), h * 0.07))
    ..drawOval(Rect.fromCenter(center: mouth, width: w * 0.85, height: h * 0.2), _blur(const Color(0xFFFFFCEB), h * 0.025));
  _shell(c, base, w, h, lw);
  // The broken edge glows, and light spills up out of it.
  c
    ..save()
    ..clipPath(egg)
    ..drawPath(Path()..addPolygon(zig, false), _stroke(const Color(0xFFFFF2B8), lw * 2.2)..maskFilter = MaskFilter.blur(BlurStyle.normal, lw * 0.9))
    ..drawPath(Path()..addPolygon(zig, false), _stroke(const Color(0xFFFFFDF0), lw * 0.7))
    ..restore();
  _rays(c, mouth, h * 0.62, 9, const Color(0xFFFFF4CC), from: -math.pi * 0.94, to: -math.pi * 0.06, alpha: 0.55);
  // The cap, lifted off and tipped.
  final capMid = Offset(0, -h * 0.34);
  c
    ..save()
    ..translate(capMid.dx - w * 0.06, capMid.dy - h * 0.13)
    ..rotate(-0.24)
    ..translate(-capMid.dx, -capMid.dy);
  _shell(c, cap, w, h, lw);
  c
    ..restore()
    ..restore();
}

/// Light rays fanning out from [at].
void _rays(Canvas c, Offset at, double len, int n, Color color, {double from = -math.pi, double to = 0, double alpha = 0.16}) {
  for (var i = 0; i < n; i++) {
    final a = from + (to - from) * (i + 0.5) / n;
    final half = (to - from) / n * 0.28;
    final p = Path()
      ..moveTo(at.dx, at.dy)
      ..lineTo(at.dx + math.cos(a - half) * len, at.dy + math.sin(a - half) * len)
      ..lineTo(at.dx + math.cos(a + half) * len, at.dy + math.sin(a + half) * len)
      ..close();
    c.drawPath(
      p,
      Paint()
        ..shader = ui.Gradient.radial(at, len, [
          color.withValues(alpha: alpha * (i.isEven ? 1 : 0.6)),
          color.withValues(alpha: 0),
        ])
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, len * 0.012),
    );
  }
}

// ---------------------------------------------------------------------------
// Images
// ---------------------------------------------------------------------------

const _rosterOrder = [
  _Species.cat,
  _Species.dog,
  _Species.slime,
  _Species.dragon,
  _Species.penguin,
  _Species.thunderbird,
  _Species.owl,
  _Species.unicorn,
  _Species.phoenix,
  _Species.golden,
];

/// 1 = free starter, 2 = premium, 3 = legendary, 4 = launch event.
int _tier(_Species s) => switch (s) {
  _Species.cat || _Species.dog || _Species.slime => 1,
  _Species.phoenix => 3,
  _Species.golden => 4,
  _ => 2,
};

void _paintRoster(Canvas c, Size size) {
  _plate(c, size, glowAlpha: 0.12);
  const cols = 5;
  const cw = 340.0;
  const ch = 400.0;
  const gap = 28.0;
  final left = (size.width - cols * cw - (cols - 1) * gap) / 2;
  final top = (size.height - 2 * ch - gap) / 2;
  for (var i = 0; i < _rosterOrder.length; i++) {
    final sp = _rosterOrder[i];
    final r = Rect.fromLTWH(left + (i % cols) * (cw + gap), top + (i ~/ cols) * (ch + gap), cw, ch);
    final look = _looks[sp]!;
    _card(c, r, look.glow);
    final pose = switch (sp) {
      _Species.dragon => const _Pose(wing: 0.35),
      _Species.thunderbird => const _Pose(wing: 0.25, mouth: _Mouth.grin),
      _Species.phoenix => const _Pose(wing: 0.3),
      _Species.dog => const _Pose(look: Offset(0.2, 0)),
      _Species.golden => const _Pose(eyes: _Eyes.happy, mouth: _Mouth.grin),
      _ => const _Pose(),
    };
    _paintPet(c, sp, Offset(r.center.dx, r.bottom - r.height * 0.2), 128, pose: pose);
    // Rarity pips along the bottom.
    final tier = _tier(sp);
    final color = switch (tier) {
      1 => const Color(0xFF4FE0C6),
      2 => const Color(0xFFB792FF),
      _ => _gold,
    };
    final n = math.min(tier, 3);
    for (var p = 0; p < n; p++) {
      final at = Offset(r.center.dx + (p - (n - 1) / 2) * 26, r.bottom - 34);
      final pip = RRect.fromRectAndRadius(Rect.fromCenter(center: at, width: 16, height: 16), const Radius.circular(5));
      c
        ..drawRRect(pip, _fill(color))
        ..drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTWH(pip.left + 2, pip.top + 2, 12, 5), const Radius.circular(2.5)),
          _fill(_white.withValues(alpha: 0.35)),
        );
    }
    if (tier == 4) _sparkle(c, Offset(r.right - 40, r.top + 40), 14, _gold);
  }
}


const _muted = Color(0xFF9B9BC7);
const _mint = Color(0xFF4FE0C6);

/// A caption under a card or frame: [title] in white, [sub] muted below.
void _caption(Canvas c, Offset at, String title, {String? sub, double size = 30}) {
  _text(c, title, at, size, GridColors.textPrimary, weight: 800, align: TextAlign.center);
  if (sub != null) {
    _text(c, sub, at + Offset(0, size * 1.3), size * 0.68, _muted, weight: 600, align: TextAlign.center);
  }
}

/// A round stage for a creature to stand on.
void _pedestal(Canvas c, Offset at, double w, Color tint) {
  final top = Rect.fromCenter(center: at, width: w, height: w * 0.22);
  final depth = w * 0.09;
  final side = Path()
    ..moveTo(top.left, top.center.dy)
    ..arcTo(top, math.pi, -math.pi, false)
    ..lineTo(top.right, top.center.dy + depth)
    ..arcTo(top.shift(Offset(0, depth)), 0, math.pi, false)
    ..close();
  c
    ..drawOval(top.shift(Offset(0, depth + w * 0.04)).inflate(w * 0.04), _blur(_black.withValues(alpha: 0.5), w * 0.05))
    ..drawPath(side, _grad(side.getBounds(), const [Color(0xFF262A66), Color(0xFF161840)]))
    ..drawOval(top, _grad(top, const [Color(0xFF353A84), Color(0xFF22265C)]))
    ..drawOval(top.deflate(w * 0.05), _stroke(tint.withValues(alpha: 0.35), w * 0.012))
    ..drawOval(top, _stroke(_mix(tint, _white, 0.3).withValues(alpha: 0.6), w * 0.008));
}

/// Three chevrons pointing right, brightest at the front.
void _chevrons(Canvas c, Offset at, double s, Color color) {
  for (var i = 0; i < 3; i++) {
    final x = at.dx + (i - 1) * s * 0.62;
    final p = Path()
      ..moveTo(x - s * 0.18, at.dy - s * 0.32)
      ..lineTo(x + s * 0.16, at.dy)
      ..lineTo(x - s * 0.18, at.dy + s * 0.32);
    c.drawPath(p, _stroke(color.withValues(alpha: 0.3 + 0.35 * i), s * 0.13));
  }
}

void _paintEvolution(Canvas c, Size size) {
  final dragon = _looks[_Species.dragon]!;
  _plate(c, size, accent: dragon.glow, glowAlpha: 0.1);
  const xs = [330.0, 840.0, 1460.0];
  const ground = 520.0;
  const names = ['Baby', 'Junior', 'Adult'];
  for (var i = 0; i < 3; i++) {
    final at = Offset(xs[i], ground);
    c.drawCircle(at + const Offset(0, -110), 210 + i * 30.0, _blur(dragon.glow.withValues(alpha: 0.16), 90));
    _pedestal(c, at + const Offset(0, 18), 300 + i * 40.0, dragon.glow);
    final pose = switch (i) {
      0 => const _Pose(look: Offset(0.15, -0.35)),
      1 => const _Pose(mouth: _Mouth.grin, wing: 0.25),
      _ => const _Pose(mouth: _Mouth.grin, wing: 0.55, look: Offset(0.1, 0)),
    };
    _paintPet(c, _Species.dragon, at, 230, stage: _Stage.values[i], pose: pose);
    _caption(c, at + const Offset(0, 92), names[i]);
    // One pip per stage, like the rarity pips on the roster.
    for (var p = 0; p <= i; p++) {
      final pip = RRect.fromRectAndRadius(
        Rect.fromCenter(center: at + Offset((p - i / 2) * 26, 160), width: 16, height: 16),
        const Radius.circular(5),
      );
      c.drawRRect(pip, _fill(_gold));
    }
  }
  _chevrons(c, const Offset(535, ground - 100), 60, _gold);
  _chevrons(c, const Offset(1095, ground - 110), 60, _gold);
  // The adult's new tricks sparkle.
  _sparkle(c, const Offset(1700, 214), 16, _gold);
  _sparkle(c, const Offset(1236, 196), 11, _white);
  _sparkle(c, const Offset(1012, 300), 9, _gold);
}

void _paintMoods(Canvas c, Size size) {
  final cat = _looks[_Species.cat]!;
  _plate(c, size, accent: cat.glow, glowAlpha: 0.1);
  const moods = [
    ('Idle', _Pose(look: Offset(0.15, 0.1))),
    ('Happy', _Pose(eyes: _Eyes.happy, mouth: _Mouth.grin, squash: 0.05)),
    ('Worried', _Pose(eyes: _Eyes.worried, mouth: _Mouth.wavy, sweat: true, look: Offset(0.55, 0.35), squash: -0.03)),
    ('Sleepy', _Pose(eyes: _Eyes.closed, mouth: _Mouth.o, zzz: true, squash: 0.07, tilt: 0.05)),
    ('Flying', _Pose(eyes: _Eyes.happy, mouth: _Mouth.grin, flying: true, tilt: -0.14)),
  ];
  const cw = 340.0;
  const ch = 500.0;
  const gap = 28.0;
  final left = (size.width - 5 * cw - 4 * gap) / 2;
  final top = (size.height - ch) / 2;
  for (var i = 0; i < moods.length; i++) {
    final (name, pose) = moods[i];
    final r = Rect.fromLTWH(left + i * (cw + gap), top, cw, ch);
    _card(c, r, cat.glow);
    final ground = Offset(r.center.dx, r.bottom - r.height * 0.2);
    if (pose.flying) {
      _groundShadow(c, ground, 104);
      final body = ground + const Offset(12, -104);
      // Swooshes and a trail of sparkles behind it.
      for (final (dy, len) in const [(-40.0, 70.0), (-8.0, 92.0), (24.0, 60.0)]) {
        final from = body + Offset(-88, dy);
        c.drawPath(
          _taper(_cubicPts(from, from + Offset(-len * 0.3, 4), from + Offset(-len * 0.7, 8), from + Offset(-len, 14)), 7, 0),
          _fill(_white.withValues(alpha: 0.32)),
        );
      }
      for (final (dx, dy, s) in const [(-128.0, -88.0, 11.0), (-150.0, -40.0, 7.0), (-112.0, 8.0, 8.0), (-160.0, 40.0, 5.0)]) {
        _sparkle(c, body + Offset(dx, dy), s, const Color(0xFFBFFFF2));
      }
      _paintPet(c, _Species.cat, body, 150, pose: pose);
    } else {
      _paintPet(c, _Species.cat, ground, 150, pose: pose);
    }
    if (i == 1) {
      for (final (dx, dy, s) in const [(-108.0, -196.0, 18.0), (104.0, -214.0, 14.0)]) {
        final at = ground + Offset(dx, dy);
        c
          ..drawPath(_heart(at, s), _fill(const Color(0xFFFF6FB0)))
          ..drawPath(_heart(at, s), _stroke(const Color(0xFF9C2A62), 2.4))
          ..drawCircle(at + Offset(-s * 0.3, -s * 0.28), s * 0.13, _fill(_white.withValues(alpha: 0.8)));
      }
      _sparkle(c, ground + const Offset(122, -128), 9, _gold);
    }
    _caption(c, Offset(r.center.dx, r.bottom - 64), name);
  }
}

// --- The flight ---------------------------------------------------------------

/// The board in the flight: row 3 is full; the others look like a game in
/// progress.
const _filmRows = [
  'TT...PP.',
  'T..I.PP.',
  'T.III..P',
  'PPTTIIPT',
  'P..TI.TT',
  'PI.T..T.',
  '.I..PPT.',
  'II..PP..',
];
const _filmRow = 3;

void _paintFilmstrip(Canvas c, Size size) {
  _plate(c, size, glowAlpha: 0.08);
  const fw = 600.0;
  const gap = 26.0;
  const captions = [
    ('Row complete', 'Funki watches from the edge'),
    ('Take-off', 'wings up, off the perch'),
    ('Fire breath', 'the row catches fire under it'),
    ('Burns away', 'the blaze follows the dragon'),
    ('Back home', 'a sparkle, the row is gone'),
  ];
  for (var i = 0; i < 5; i++) {
    final f = Rect.fromLTWH(gap + i * (fw + gap), gap, fw, size.height - 2 * gap);
    final rr = RRect.fromRectAndRadius(f, const Radius.circular(30));
    c
      ..drawRRect(rr.shift(const Offset(0, 10)), _blur(_black.withValues(alpha: 0.4), 16))
      ..drawRRect(rr, _grad(f, const [Color(0xFF171A40), Color(0xFF0E1030)]))
      ..drawRRect(rr.deflate(0.75), _stroke(const Color(0xFF2E3270), 1.5))
      ..save()
      ..clipRRect(rr);
    _filmFrame(c, f, i);
    c.restore();
    // The frame number in a badge, then the caption.
    final badge = Offset(f.left + 58, f.bottom - 76);
    c
      ..drawCircle(badge, 24, _fill(_mint))
      ..drawCircle(badge, 24, _stroke(_mix(_mint, _white, 0.5), 2));
    _text(c, '${i + 1}', badge + const Offset(0, -17), 28, const Color(0xFF0F1030), weight: 900, align: TextAlign.center);
    final (title, sub) = captions[i];
    _text(c, title, Offset(f.left + 98, f.bottom - 100), 30, GridColors.textPrimary, weight: 800);
    _text(c, sub, Offset(f.left + 98, f.bottom - 60), 21, _muted, weight: 600);
  }
}

void _filmFrame(Canvas c, Rect f, int i) {
  final b = _Board(Rect.fromLTWH(f.left + 52, f.top + 196, 496, 496));
  final cell = b.cell;
  final size = cell * 1.45;
  final burning = i == 2 || i == 3;
  _paintBoard(c, b, _filmRows, cleared: i >= 2 ? const {_filmRow} : const {});
  if (i < 2) _rowGlow(c, b, _filmRow, const Color(0xFFFFB02E));

  final perch = Offset(b.area.right - cell * 1.05, b.area.top + 2);
  final perchCenter = perch + Offset(0, -size * 0.46);
  // Where the dragon is (the middle of its body's bottom edge) and where its
  // fire lands, per frame.
  final flyY = b.at(_filmRow, 0).dy - cell * 0.7;
  final (at, target) = switch (i) {
    1 => (Offset(b.area.right - cell * 2.4, b.area.top - cell * 0.5), null),
    2 => (Offset(b.at(0, 5.5).dx, flyY), 3.9),
    3 => (Offset(b.at(0, 2.1).dx, flyY), 0.6),
    _ => (perch, null),
  };
  // The flight so far, dotted.
  if (i >= 1 && i <= 3) {
    final centre = at + Offset(0, -size * 0.46);
    final path = Path()..moveTo(perchCenter.dx, perchCenter.dy);
    if (i == 1) {
      path.quadraticBezierTo(perchCenter.dx, centre.dy - cell * 0.4, centre.dx, centre.dy);
    } else {
      final entry = Offset(b.at(0, 7.3).dx, flyY - size * 0.46);
      path
        ..cubicTo(perchCenter.dx - cell * 1.4, perchCenter.dy - cell * 1.2, entry.dx + cell * 1.2, entry.dy - cell * 1.4, entry.dx, entry.dy)
        ..lineTo(centre.dx + cell * 0.9, centre.dy);
    }
    _dotted(c, path, _white.withValues(alpha: 0.5), 3.2, 15);
  }
  if (i == 1) _puffs(c, perch, size);

  if (burning) {
    final order = (7 - target!) / 7;
    final t = _sweepAt(ClearEffectStyle.blaze, order);
    b.scaled(c, () => _paintSweep(c, _rowSweep(_filmRows, _filmRow, fromRight: true), ClearEffectStyle.blaze, t));
  }

  final pose = switch (i) {
    1 => const _Pose(facing: -1, turn: 1, wing: 1, flying: true, tilt: -0.2, mouth: _Mouth.grin, look: Offset(-0.6, 0.5)),
    2 || 3 => const _Pose(facing: -1, turn: 1, wing: 0.25, flying: true, tilt: -0.14, eyes: _Eyes.fierce, mouth: _Mouth.breath, look: Offset(-0.6, 0.6)),
    4 => const _Pose(eyes: _Eyes.happy, mouth: _Mouth.grin),
    _ => const _Pose(look: Offset(-0.65, 0.75)),
  };
  final a = _paintPet(c, _Species.dragon, at, size, pose: pose);
  if (burning) {
    final hit = b.at(_filmRow, target!) + Offset(0, -cell * 0.12);
    _fireBreath(c, a.mouth, hit, cell * 0.95, bend: -0.12, seed: i);
  }
  if (i == 4) {
    for (final (dx, dy, s, col) in const [(-0.75, -1.25, 13.0, _gold), (0.62, -1.4, 10.0, _white), (0.9, -0.6, 8.0, _gold), (-0.95, -0.45, 7.0, _white)]) {
      _sparkle(c, perchCenter + Offset(dx, dy) * size * 0.8, s, col);
    }
    // The last embers over the empty row.
    for (var k = 0; k < 7; k++) {
      final p = b.at(_filmRow, 0.3 + k * 1.05) + Offset((_hash(4, k) - 0.5) * cell * 0.6, -cell * (0.2 + 0.6 * _hash(7, k)));
      _ember(c, p, 2.2 + 2 * _hash(9, k), k.isEven ? const Color(0xFFFF9A2E) : const Color(0xFFFFC23D));
    }
  }
}


// --- The signature effects ------------------------------------------------------

/// A bolt that arches from [a] to [b], [rise] above the straight line.
List<Offset> _archBolt(Offset a, Offset b, double rise, double jag, int seed, [int n = 6]) {
  final ctrl = Offset.lerp(a, b, 0.5)! + Offset(0, -rise);
  return [
    for (var i = 0; i <= n; i++)
      _quad(a, ctrl, b, i / n) +
          (i == 0 || i == n ? Offset.zero : Offset((_hash(seed, i) - 0.5) * jag, (_hash(seed, i + 11) - 0.5) * jag * 1.6)),
  ];
}

typedef _Panel = ({
  _Species species,
  String name,
  String effect,
  Color tint,
  String row,
  String below,
});

const List<_Panel> _panels = [
  (species: _Species.dragon, name: 'Funki', effect: 'Fire breath', tint: Color(0xFFFF7A3D), row: 'TPPITT', below: 'P.TI..'),
  (species: _Species.penguin, name: 'Frosti', effect: 'Frost breath', tint: Color(0xFF6EC8FF), row: 'IITPPT', below: '.TP.II'),
  (species: _Species.owl, name: 'Optik', effect: 'Laser eyes', tint: Color(0xFFFF4D6D), row: 'PTTIPP', below: 'I..TP.'),
  (species: _Species.thunderbird, name: 'Zapp', effect: 'Chain lightning', tint: Color(0xFFA98BFF), row: 'TIIPTI', below: 'PT..T.'),
  (species: _Species.unicorn, name: 'Prisma', effect: 'Rainbow trail', tint: Color(0xFFFF8DB8), row: 'PPITTI', below: '.I.PTT'),
];

void _paintEffects(Canvas c, Size size) {
  _plate(c, size, glowAlpha: 0.08);
  const pw = 404.0;
  const ph = 540.0;
  const gap = 24.0;
  final left = (size.width - _panels.length * pw - (_panels.length - 1) * gap) / 2;
  for (var i = 0; i < _panels.length; i++) {
    final r = Rect.fromLTWH(left + i * (pw + gap), (size.height - ph) / 2, pw, ph);
    final panel = _panels[i];
    final rr = RRect.fromRectAndRadius(r, const Radius.circular(30));
    c
      ..drawRRect(rr.shift(const Offset(0, 12)), _blur(_black.withValues(alpha: 0.45), 18))
      ..drawRRect(rr, _grad(r, const [Color(0xFF1D2152), Color(0xFF12143A)]))
      ..save()
      ..clipRRect(rr)
      ..drawCircle(r.topCenter + const Offset(0, 190), 230, _blur(panel.tint.withValues(alpha: 0.2), 90));
    _effectPanel(c, r, panel);
    c
      ..restore()
      ..drawRRect(rr.deflate(0.75), _stroke(panel.tint.withValues(alpha: 0.4), 1.5));
    _caption(c, Offset(r.center.dx, r.bottom - 104), panel.name, sub: panel.effect);
  }
}

void _effectPanel(Canvas c, Rect r, _Panel p) {
  final b = _Board(Rect.fromLTWH(r.left + 40, r.top + 290, 324, 108), cols: 6, rows: 2);
  final cells = [p.row, p.below];
  _paintBoard(c, b, cells, cleared: const {0});
  final sweep = _rowSweep(cells, 0);
  final cell = b.cell;
  switch (p.species) {
    case _Species.dragon:
      const front = 3.4;
      b.scaled(c, () => _paintSweep(c, sweep, ClearEffectStyle.blaze, _sweepAt(ClearEffectStyle.blaze, front / 5)));
      final a = _paintPet(
        c,
        _Species.dragon,
        Offset(r.left + 138, r.top + 214),
        96,
        pose: const _Pose(flying: true, wing: 0.35, turn: 1, tilt: 0.14, eyes: _Eyes.fierce, mouth: _Mouth.breath, look: Offset(0.6, 0.6)),
      );
      _fireBreath(c, a.mouth, b.at(0, front) + Offset(0, -cell * 0.12), cell * 0.95, bend: 0.14, seed: 3);
    case _Species.penguin:
      // The breath covers the row; frost freezes it all and shatters from the
      // start of the line.
      b.scaled(c, () => _paintSweep(c, sweep, ClearEffectStyle.frost, 0.42));
      final a = _paintPet(
        c,
        _Species.penguin,
        Offset(r.left + 118, r.top + 206),
        100,
        pose: const _Pose(flying: true, wing: 1, turn: 1, tilt: 0.1, eyes: _Eyes.fierce, mouth: _Mouth.breath, look: Offset(0.6, 0.5)),
      );
      _frostBreath(c, a.mouth, b.at(0, 4.9) + Offset(0, -cell * 0.2), cell * 1.1, bend: 0.12, seed: 2);
    case _Species.owl:
      const front = 3.5;
      b.scaled(c, () => _paintSweep(c, sweep, ClearEffectStyle.laser, _sweepAt(ClearEffectStyle.laser, front / 5)));
      final a = _paintPet(
        c,
        _Species.owl,
        Offset(r.left + 128, r.top + 204),
        100,
        pose: const _Pose(flying: true, wing: 0.6, turn: 1, tilt: 0.08, mouth: _Mouth.breath, look: Offset(0.7, 0.7)),
      );
      final target = b.at(0, front);
      _laser(c, a.eyeL, target, 4.2);
      _laser(c, a.eyeR, target, 4.2);
      _impact(c, target, cell * 0.36, const Color(0xFFFF4D6D), seed: 5);
    case _Species.thunderbird:
      const front = 3.5;
      b.scaled(c, () => _paintSweep(c, sweep, ClearEffectStyle.lightning, _sweepAt(ClearEffectStyle.lightning, front / 5)));
      final a = _paintPet(
        c,
        _Species.thunderbird,
        Offset(r.left + 126, r.top + 196),
        96,
        pose: const _Pose(flying: true, wing: 1, turn: 1, eyes: _Eyes.fierce, mouth: _Mouth.grin, look: Offset(0.4, 0.8)),
      );
      // One strike, then it jumps from block to block.
      final hits = [for (final col in const [1, 2, 3, 4]) b.at(0, col) + Offset(0, -cell * 0.18)];
      _bolt(c, _zigzag(a.mouth + const Offset(0, 6), hits.first, cell * 0.28, 7, 8), 3.4);
      for (var k = 0; k < hits.length - 1; k++) {
        _bolt(c, _archBolt(hits[k], hits[k + 1], cell * (k.isEven ? 1.5 : 1.15), cell * 0.24, 20 + k), 3, alpha: k == hits.length - 2 ? 0.65 : 1);
      }
      for (final h in hits.take(3)) {
        _impact(c, h, cell * 0.22, const Color(0xFFFFE066), seed: h.dx.round());
      }
    case _Species.unicorn:
      const front = 3.5;
      b.scaled(c, () => _paintPrismSweep(c, sweep, _sweepAt(ClearEffectStyle.blaze, front / 5)));
      final at = Offset(b.at(0, 4.15).dx, r.top + 200);
      // The trail runs low over the row it clears, then up to the unicorn.
      final start = Offset(b.area.left - 30, b.at(0, 0).dy - cell * 0.15);
      final pts = [
        for (var k = 0; k <= 40; k++)
          _bez(start, start + Offset(cell * 1.6, cell * 0.2), at + Offset(-cell * 2.2, cell * 0.9), at + Offset(-cell * 0.6, -cell * 0.55), k / 40),
      ];
      _rainbowTrail(c, pts, cell * 0.12, fade: 0.25);
      for (final (k, s) in const [(12, 7.0), (20, 9.0), (28, 6.0), (34, 8.0)]) {
        _sparkle(c, pts[k] + _upNormal(pts, k) * (cell * (k.isEven ? 0.55 : -0.55)), s, _white);
      }
      _paintPet(
        c,
        _Species.unicorn,
        at,
        96,
        pose: const _Pose(flying: true, turn: 1, tilt: -0.12, eyes: _Eyes.happy, mouth: _Mouth.grin),
      );
    default:
      break;
  }
}


// --- Store and event mockups --------------------------------------------------------

/// The board in the store shot; the dragon burns row 3.
const _shotRows = [
  'II..TT.P',
  'I...TP.P',
  '.T..IIP.',
  'PPTTIIPT',
  'TT.PP..I',
  'T..PP.II',
  '.IIT..T.',
  'PP.T.TT.',
];
const _shotRow = 3;

/// A mockup of a store screenshot in the layout of
/// store-assets/en/screenshot-1-clear.png (headline, subline, accent bar,
/// the board on a card).
void _paintStoreShot(Canvas c, Size size) {
  _plate(c, size, glow: Rect.fromLTRB(-300, 1080, size.width + 300, 2200), glowAlpha: 0.2);
  _text(c, 'Your pet', const Offset(72, 104), 116, _white, weight: 900, height: 1.0);
  _text(c, 'plays along.', const Offset(72, 226), 116, _white, weight: 900, height: 1.0);
  _text(c, 'Clear a line and your Qubbie joins in', const Offset(76, 374), 40, const Color(0xFFA9ACD6), weight: 600);
  c.drawRRect(
    RRect.fromRectAndRadius(const Rect.fromLTWH(76, 450, 150, 10), const Radius.circular(5)),
    _fill(_mint),
  );

  final card = RRect.fromRectAndRadius(const Rect.fromLTWH(26, 640, 1028, 1028), const Radius.circular(56));
  c
    ..drawRRect(card.shift(const Offset(0, 26)), _blur(_black.withValues(alpha: 0.5), 30))
    ..drawRRect(card, _fill(GridColors.background));
  const b = _Board(Rect.fromLTWH(84, 698, 912, 912));
  final cell = b.cell;
  _paintBoard(c, b, _shotRows, cleared: const {_shotRow}, shadow: false);

  // The dragon glides right to left along the row and the blaze follows it.
  const target = 1.7;
  final t = _sweepAt(ClearEffectStyle.blaze, (7 - target) / 7);
  b.scaled(c, () => _paintSweep(c, _rowSweep(_shotRows, _shotRow, fromRight: true), ClearEffectStyle.blaze, t));
  // Embers rising off the burnt part (behind the dragon), the higher the
  // smaller.
  for (var k = 0; k < 34; k++) {
    final up = _hash(37, k);
    final p = b.at(_shotRow, 2.6 + 4.8 * _hash(31, k)) + Offset(0, -cell * (0.35 + 2.4 * up));
    _ember(c, p, (2.5 + 5 * _hash(41, k)) * (1.2 - up * 0.6), k.isEven ? const Color(0xFFFF9A2E) : const Color(0xFFFFC23D));
  }
  // The fire lights up the board round it.
  c.drawCircle(
    b.at(_shotRow - 0.3, 2.4),
    cell * 1.9,
    _blur(const Color(0xFFFF8A3D).withValues(alpha: 0.22), cell * 0.9)..blendMode = BlendMode.screen,
  );
  final at = Offset(b.at(0, 3.85).dx, b.at(_shotRow, 0).dy - cell * 0.6);
  final a = _paintPet(
    c,
    _Species.dragon,
    at,
    cell * 2.0,
    pose: const _Pose(facing: -1, turn: 1, wing: 0.45, flying: true, tilt: -0.12, eyes: _Eyes.fierce, mouth: _Mouth.breath, look: Offset(-0.6, 0.6)),
  );
  _fireBreath(c, a.mouth, b.at(_shotRow, target) + Offset(0, -cell * 0.12), cell * 1.0, bend: -0.12, seed: 7);
}

const _featureRows = [
  'T.PPI.T',
  'TTIP.TI',
  'PI.TTIP',
];

/// A mockup of a feature graphic in the style of
/// store-assets/en/feature-graphic-1024x500.png.
void _paintFeature(Canvas c, Size size) {
  final rect = Offset.zero & size;
  c
    ..drawRect(
      rect,
      Paint()
        ..shader = ui.Gradient.linear(Offset(0, size.height), Offset(size.width, 0), const [
          Color(0xFF243C51),
          Color(0xFF121B31),
          Color(0xFF08091C),
        ], const [0, 0.5, 1]),
    )
    ..drawCircle(const Offset(262, 250), 230, _blur(const Color(0xFFFF6B5B).withValues(alpha: 0.16), 100))
    ..drawCircle(const Offset(120, 430), 180, _blur(_mint.withValues(alpha: 0.12), 80));
  const b = _Board(Rect.fromLTWH(56, 186, 7 * 58.0, 3 * 58.0), cols: 7, rows: 3);
  _paintBoard(c, b, _featureRows);
  // Ground glow under the line-up.
  c.drawOval(Rect.fromCenter(center: const Offset(262, 446), width: 470, height: 46), _blur(_black.withValues(alpha: 0.4), 14));
  _paintPet(
    c,
    _Species.dragon,
    const Offset(262, 248),
    122,
    pose: const _Pose(flying: true, wing: 0.7, mouth: _Mouth.grin, look: Offset(0.1, 0.25)),
  );
  _sparkle(c, const Offset(168, 92), 9, _gold);
  _sparkle(c, const Offset(372, 118), 7, _white);
  _paintPet(c, _Species.cat, const Offset(122, 440), 108, pose: const _Pose(eyes: _Eyes.happy, mouth: _Mouth.grin, facing: 1, turn: 0.4));
  _paintPet(c, _Species.unicorn, const Offset(404, 440), 108, pose: const _Pose(facing: -1, turn: 0.4, look: Offset(-0.3, -0.1)));
  _paintPet(c, _Species.slime, const Offset(262, 452), 96, pose: const _Pose(mouth: _Mouth.o, look: Offset(0, -0.6)));

  _text(c, 'MEET THE QUBBIES', const Offset(530, 98), 24, _gold, weight: 800, spacing: 5);
  _text(c, 'Qubble', const Offset(523, 138), 116, GridColors.textPrimary, weight: 900, height: 1.0, tail: '.', tailColor: _mint);
  _text(c, 'Puzzle pets that play along.', const Offset(530, 286), 32, const Color(0xFFB4B8DE), weight: 600);
  final pips = [..._classic.traySlots, _white, _gold];
  for (var i = 0; i < pips.length; i++) {
    final r = Rect.fromLTWH(530 + i * 60.0, 350, 46, 46);
    paintCell(c, r, 10, pips[i], BlockSkinStyle.solid);
  }
}

/// The event image: a glowing egg hatching, the three starters round it and
/// the dragon peeking out from behind. No text, logo or slogan (Play's event
/// image guidance, as for the Halloween images).
void _paintEvent(Canvas c, Size size) {
  final wide = size.width > size.height;
  final w = size.width;
  final h = size.height;
  final eggH = wide ? 500.0 : 450.0;
  final eggBottom = Offset(w / 2, wide ? 848 : 800);
  final glowAt = eggBottom + Offset(0, -eggH * 0.68);
  final rect = Offset.zero & size;
  c.drawRect(
    rect,
    Paint()
      ..shader = ui.Gradient.radial(glowAt, w * (wide ? 0.62 : 0.85), const [
        Color(0xFF3B3388),
        Color(0xFF1B1A52),
        Color(0xFF0A0A24),
      ], const [0, 0.42, 1]),
  );
  _rays(c, glowAt, h * 1.05, 16, const Color(0xFFFFE9A8), from: -math.pi * 1.12, to: math.pi * 0.12, alpha: 0.13);
  // Soft lights in the distance.
  final rnd = math.Random(5);
  final bokeh = [..._classic.traySlots, _gold];
  for (var i = 0; i < 22; i++) {
    final p = Offset(rnd.nextDouble() * w, rnd.nextDouble() * h * 0.75);
    c.drawCircle(p, 18 + rnd.nextDouble() * 46, _blur(bokeh[i % bokeh.length].withValues(alpha: 0.08 + rnd.nextDouble() * 0.1), 18));
  }
  for (var i = 0; i < 70; i++) {
    final p = Offset(rnd.nextDouble() * w, rnd.nextDouble() * h * 0.8);
    c.drawCircle(p, 1.2 + rnd.nextDouble() * 2.2, _fill(_white.withValues(alpha: 0.2 + rnd.nextDouble() * 0.45)));
  }
  // Confetti, behind everything else and kept off the egg.
  final colors = [..._classic.traySlots, _gold, _white];
  var placed = 0;
  for (var i = 0; placed < (wide ? 46 : 34) && i < 400; i++) {
    final p = Offset(40 + rnd.nextDouble() * (w - 80), 40 + rnd.nextDouble() * (h * 0.62));
    if ((p - glowAt).distance < eggH * 0.62) continue;
    _confetti(c, p, 14 + rnd.nextDouble() * 12, rnd.nextDouble() * math.pi, colors[placed % colors.length]);
    placed++;
  }
  // The stage.
  c
    ..drawOval(
      Rect.fromCenter(center: eggBottom + const Offset(0, 14), width: wide ? 1240 : 960, height: 150),
      _blur(const Color(0xFF7C6BFF).withValues(alpha: 0.32), 50),
    )
    ..drawOval(
      Rect.fromCenter(center: eggBottom + const Offset(0, 6), width: wide ? 760 : 640, height: 84),
      _blur(const Color(0xFFFFE9A8).withValues(alpha: 0.16), 30),
    );
  c.drawCircle(glowAt, eggH * 0.7, _blur(const Color(0xFFFFE6A0).withValues(alpha: 0.32), eggH * 0.3));

  // The dragon peeks out between the egg and the dog.
  _paintPet(
    c,
    _Species.dragon,
    eggBottom + Offset(eggH * 0.47, -eggH * 0.15),
    wide ? 196 : 176,
    pose: const _Pose(tilt: 0.16, turn: 0.4, wing: 0.7, mouth: _Mouth.o, look: Offset(-0.9, -0.35), shadow: false),
  );
  _paintEgg(c, eggBottom, eggH, tilt: -0.04);
  // Shell chips flying off the crack.
  for (final (dx, dy, s, rot) in const [(-0.42, -0.9, 0.05, 0.5), (0.42, -0.98, 0.04, -0.7), (0.3, -1.2, 0.03, 1.4)]) {
    final at = eggBottom + Offset(dx, dy) * eggH;
    final chip = _poly(const [(0.0, -0.6), (0.7, 0.2), (0.1, 0.55), (-0.6, 0.1)], Offset.zero, s * eggH);
    c
      ..save()
      ..translate(at.dx, at.dy)
      ..rotate(rot)
      ..drawPath(chip, _fill(const Color(0xFFFFF5E4)))
      ..drawPath(chip, _stroke(const Color(0xFF7F67C8), eggH * 0.008))
      ..restore();
  }

  // The three starters round it.
  final side = wide ? 380.0 : 320.0;
  _paintPet(
    c,
    _Species.cat,
    eggBottom + Offset(-side, 26),
    wide ? 186 : 168,
    pose: const _Pose(eyes: _Eyes.happy, mouth: _Mouth.grin, turn: 0.5, squash: 0.03),
  );
  _paintPet(
    c,
    _Species.dog,
    eggBottom + Offset(side + 10, 26),
    wide ? 190 : 170,
    pose: const _Pose(facing: -1, turn: 0.5, look: Offset(-0.5, -0.3)),
  );
  _paintPet(
    c,
    _Species.slime,
    eggBottom + Offset(-side * 0.52, 78),
    wide ? 140 : 126,
    pose: const _Pose(mouth: _Mouth.o, look: Offset(0.55, -0.7)),
  );

  for (final (dx, dy, s) in const [(-0.55, -1.0, 16.0), (0.62, -0.92, 13.0), (-0.3, -1.26, 10.0), (0.22, -1.3, 12.0), (0.8, -0.5, 9.0), (-0.85, -0.45, 9.0)]) {
    _sparkle(c, eggBottom + Offset(dx, dy) * eggH, s, dx > 0 ? _gold : _white);
  }
}

// ---------------------------------------------------------------------------
// Rendering
// ---------------------------------------------------------------------------

typedef _Painter = void Function(Canvas c, Size size);

final List<(String, Size, _Painter)> _jobs = [
  ('roster.png', const Size(1920, 900), _paintRoster),
  ('evolution-dragon.png', const Size(1920, 760), _paintEvolution),
  ('moods-cat.png', const Size(1920, 600), _paintMoods),
  ('flight-filmstrip.png', const Size(3156, 860), _paintFilmstrip),
  ('effects.png', const Size(2240, 620), _paintEffects),
  ('store-screenshot-1-mockup.png', const Size(1080, 1920), _paintStoreShot),
  ('feature-graphic-mockup.png', const Size(1024, 500), _paintFeature),
  ('event-card-1920x1080.png', const Size(1920, 1080), _paintEvent),
  ('event-card-1080x1080.png', const Size(1080, 1080), _paintEvent),
];

Future<void> _render(WidgetTester tester, String name, Size size, _Painter paint) async {
  final recorder = ui.PictureRecorder();
  paint(Canvas(recorder, Offset.zero & size), size);
  final picture = recorder.endRecording();
  final w = size.width.toInt();
  final h = size.height.toInt();
  final rgba = await tester.runAsync(() async {
    final image = await picture.toImage(w, h);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    return data!.buffer.asUint8List();
  });
  picture.dispose();
  final png = _encodePng(rgba!, w, h);
  Directory(_outDir).createSync(recursive: true);
  File('$_outDir/$name').writeAsBytesSync(png);
  stdout.writeln('$name  ${w}x$h  ${(png.length / 1024).round()} KB');
}

/// An opaque RGB PNG with a per-row filter choice and maximum compression:
/// the engine's own encoder writes RGBA at a lower level, and these images
/// should stay small in the repo.
Uint8List _encodePng(Uint8List rgba, int width, int height) {
  const bpp = 3;
  final stride = width * bpp;
  final raw = Uint8List((stride + 1) * height);
  var prev = Uint8List(stride);
  var cur = Uint8List(stride);
  final trial = List.generate(5, (_) => Uint8List(stride));
  for (var y = 0; y < height; y++) {
    var si = y * width * 4;
    for (var x = 0; x < stride; x += 3) {
      cur[x] = rgba[si];
      cur[x + 1] = rgba[si + 1];
      cur[x + 2] = rgba[si + 2];
      si += 4;
    }
    var best = 0;
    var bestSum = -1;
    for (var f = 0; f < 5; f++) {
      final t = trial[f];
      var sum = 0;
      for (var i = 0; i < stride; i++) {
        final a = i >= bpp ? cur[i - bpp] : 0;
        final b = prev[i];
        final cc = i >= bpp ? prev[i - bpp] : 0;
        final v = cur[i];
        final p = switch (f) {
          0 => v,
          1 => v - a,
          2 => v - b,
          3 => v - ((a + b) >> 1),
          _ => v - _paeth(a, b, cc),
        };
        final byte = p & 0xFF;
        t[i] = byte;
        sum += byte < 128 ? byte : 256 - byte;
      }
      if (bestSum < 0 || sum < bestSum) {
        bestSum = sum;
        best = f;
      }
    }
    final o = y * (stride + 1);
    raw[o] = best;
    raw.setRange(o + 1, o + 1 + stride, trial[best]);
    final swap = prev;
    prev = cur;
    cur = swap;
  }
  final out = BytesBuilder(copy: false)
    ..add(const [137, 80, 78, 71, 13, 10, 26, 10]);
  final header = ByteData(13)
    ..setUint32(0, width)
    ..setUint32(4, height)
    ..setUint8(8, 8)
    ..setUint8(9, 2);
  _chunk(out, 'IHDR', header.buffer.asUint8List());
  _chunk(out, 'IDAT', ZLibEncoder(level: 9).convert(raw));
  _chunk(out, 'IEND', const []);
  return out.takeBytes();
}

int _paeth(int a, int b, int c) {
  final p = a + b - c;
  final pa = (p - a).abs();
  final pb = (p - b).abs();
  final pc = (p - c).abs();
  if (pa <= pb && pa <= pc) return a;
  return pb <= pc ? b : c;
}

final List<int> _crcTable = List<int>.generate(256, (n) {
  var c = n;
  for (var k = 0; k < 8; k++) {
    c = (c & 1) != 0 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1;
  }
  return c;
});

void _chunk(BytesBuilder out, String type, List<int> data) {
  final body = [...type.codeUnits, ...data];
  var crc = 0xFFFFFFFF;
  for (final b in body) {
    crc = _crcTable[(crc ^ b) & 0xFF] ^ (crc >>> 8);
  }
  out
    ..add((ByteData(4)..setUint32(0, data.length)).buffer.asUint8List())
    ..add(body)
    ..add((ByteData(4)..setUint32(0, crc ^ 0xFFFFFFFF)).buffer.asUint8List());
}

void main() {
  setUpAll(_loadFonts);
  testWidgets('Qubbies concept art', (tester) async {
    final only = Platform.environment['PET_ONLY'];
    for (final (name, size, paint) in _jobs) {
      if (only != null && !name.contains(only)) continue;
      await _render(tester, name, size, paint);
    }
  });
}
