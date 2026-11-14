/// The Qubbie on the board (docs/HAUSTIERE.md §3): it sits on the top edge,
/// watches the piece being dragged, and when a line is cleared it flies along
/// it. Before the first Qubbie has hatched, its egg sits there instead.
///
/// It is a picture over the board and nothing else. It takes no room in the
/// layout, catches no touch, and has no say in what the game does.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/board.dart';
import '../../game/pet.dart';
import '../../game/piece.dart';
import '../state/game_controller.dart';
import '../state/pet_controller.dart';
import '../state/settings_controller.dart';
import 'board_view.dart';
import 'qubbie_art.dart';
import 'qubbie_picture.dart';

/// The colours of the trail a flying Qubbie leaves: its signature's, and for
/// a starter (which flies with the player's own row effect) its own.
List<Color> petTrailColors(Pet pet) => switch (pet.signature) {
  PetSignature.frost => const [Color(0xFFBFE9FF), Color(0xFFFFFFFF)],
  PetSignature.laser => const [Color(0xFFFF3B5C), Color(0xFF3FE6D6)],
  PetSignature.lightning => const [Color(0xFFFFE27A), Color(0xFF6FD3FF)],
  PetSignature.fire => const [Color(0xFFFF9A2E), Color(0xFFFFE27A)],
  PetSignature.phoenix => const [Color(0xFFFF6A2E), Color(0xFFFFD36A)],
  PetSignature.rainbow => const [
    Color(0xFFFF8DB8),
    Color(0xFFFFE27A),
    Color(0xFF8FF0C2),
    Color(0xFF8CC8FF),
    Color(0xFFC3A0FF),
  ],
  null => switch (pet.species) {
    PetSpecies.dog => const [Color(0xFFFFB25C), Color(0xFFFFFFFF)],
    PetSpecies.slime => const [Color(0xFFC6F56B), Color(0xFFFFFFFF)],
    _ => const [Color(0xFFA2F7E2), Color(0xFFFFFFFF)],
  },
};

/// The line a Qubbie flies along.
@immutable
class PetFlightLine {
  const PetFlightLine({required this.horizontal, required this.index});

  final bool horizontal;

  /// The row (or column) on the board.
  final int index;

  /// The first line [cleared] holds in full: the topmost row, otherwise the
  /// leftmost column. Null when no whole line is in it (a bomb).
  static PetFlightLine? first(List<Cell> cleared) {
    final rows = List<int>.filled(Board.size, 0);
    final cols = List<int>.filled(Board.size, 0);
    for (final cell in cleared) {
      rows[cell.row]++;
      cols[cell.col]++;
    }
    for (var r = 0; r < Board.size; r++) {
      if (rows[r] == Board.size) {
        return PetFlightLine(horizontal: true, index: r);
      }
    }
    for (var c = 0; c < Board.size; c++) {
      if (cols[c] == Board.size) {
        return PetFlightLine(horizontal: false, index: c);
      }
    }
    return null;
  }
}

class PetOverlay extends ConsumerStatefulWidget {
  const PetOverlay({
    super.key,
    required this.size,
    required this.cellSize,
    this.hidden = false,
  });

  /// The board's side.
  final double size;
  final double cellSize;

  /// Set while something else needs the top of the board (a coach hint on a
  /// compact screen).
  final bool hidden;

  /// How long a flight takes, there and back. The row effects take 560 ms.
  static const Duration flightDuration = Duration(milliseconds: 600);

  @override
  ConsumerState<PetOverlay> createState() => PetOverlayState();
}

class PetOverlayState extends ConsumerState<PetOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _flight = AnimationController(
    vsync: this,
    duration: PetOverlay.flightDuration,
  );

  /// A short nod when a piece lands (and the egg's wobble on a clear).
  late final AnimationController _nod = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );

  PetFlightLine? _line;

  /// Whether the Qubbie is in the air right now.
  @visibleForTesting
  bool get isFlying => _flight.isAnimating;

  /// The line of the flight in progress or last flown.
  @visibleForTesting
  PetFlightLine? get flightLine => _line;

  @override
  void dispose() {
    _flight.dispose();
    _nod.dispose();
    super.dispose();
  }

  void _onGame(GameSnapshot? previous, GameSnapshot next) {
    if (previous == null || !mounted) return;
    final view = ref.read(petControllerProvider);
    if (view.active == null && view.perchEgg == null) return;
    final cleared =
        next.clearEventId != previous.clearEventId &&
        next.lastGained > 0 &&
        next.clearedCells.isNotEmpty;
    if (cleared) {
      final line = PetFlightLine.first(next.clearedCells);
      final still = ref.read(reducedEffectsProvider);
      if (view.active != null && line != null && !still) {
        _line = line;
        _flight.forward(from: 0);
        return;
      }
      _nod.forward(from: 0);
    } else if (next.lastPlacementAt != previous.lastPlacementAt &&
        !_flight.isAnimating) {
      _nod.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameControllerProvider, _onGame);
    // The next piece is on its way: the Qubbie is out of it at once, so it
    // never covers the cells being aimed at.
    ref.listen(dragPreviewProvider, (previous, next) {
      if (next != null && previous == null && _flight.isAnimating) {
        _flight
          ..stop()
          ..value = 0;
      }
    });
    final view = ref.watch(petControllerProvider);
    final pet = view.active;
    final egg = view.perchEgg;
    if (widget.hidden || (pet == null && egg == null)) {
      return const SizedBox.shrink();
    }
    // Only what changes the picture: the board itself repaints on its own.
    final (gameOver, cheering, fever) = ref.watch(
      gameControllerProvider.select(
        (s) => (
          s.gameOver,
          s.gameOver && !s.finalizing && s.isNewHighscore,
          s.feverLevel >= 1,
        ),
      ),
    );
    final preview = ref.watch(dragPreviewProvider);
    return CustomPaint(
      size: Size.square(widget.size),
      painter: _PetPainter(
        pet: pet,
        stage: pet == null ? 1 : view.pets.stageOf(pet.id),
        cracks: egg?.progress ?? 0,
        size: widget.size,
        cell: widget.cellSize,
        flight: _flight,
        nod: _nod,
        line: _line,
        lookAt: preview == null
            ? null
            : Offset(
                (preview.origin.col + preview.piece.width / 2) *
                    widget.cellSize,
                (preview.origin.row + preview.piece.height / 2) *
                    widget.cellSize,
              ),
        gameOver: gameOver,
        cheering: cheering,
        fever: fever,
        trail: pet == null ? const [] : petTrailColors(pet),
      ),
    );
  }
}

class _PetPainter extends CustomPainter {
  _PetPainter({
    required this.pet,
    required this.stage,
    required this.cracks,
    required this.size,
    required this.cell,
    required this.flight,
    required this.nod,
    required this.line,
    required this.lookAt,
    required this.gameOver,
    required this.cheering,
    required this.fever,
    required this.trail,
  }) : super(repaint: Listenable.merge([flight, nod]));

  final Pet? pet;
  final int stage;

  /// How far the egg on the perch has cracked, 0..1.
  final double cracks;
  final double size;
  final double cell;
  final Animation<double> flight;
  final Animation<double> nod;
  final PetFlightLine? line;
  final Offset? lookAt;
  final bool gameOver;
  final bool cheering;
  final bool fever;
  final List<Color> trail;

  /// Where it sits: on the top edge, to the right, feet just inside the
  /// board — far enough in that a grown one's wing stays on the screen.
  Offset get _perch => Offset(size - cell * 1.2, cell * 0.16);

  /// The art draws a baby at 0.64 of an adult. On the board that would be
  /// two thirds of a cell, too small to read, so the young ones are drawn
  /// up: about one cell wide as a baby, 1.2 when grown.
  double get _bodySize => cell * const [1.5, 1.35, 1.2][(stage - 1).clamp(0, 2)];

  @override
  void paint(Canvas canvas, Size _) {
    final pet = this.pet;
    final bump = math.sin(nod.value * math.pi);
    if (pet == null) {
      // The egg, rocking a little whenever something happens.
      paintQubbieEgg(
        canvas,
        _perch,
        cell * 0.98,
        tilt: math.sin(nod.value * math.pi * 3) * 0.12 * (1 - nod.value),
        cracks: cracks,
      );
      return;
    }
    final kind = qubbieKindOf(pet.species);
    final artStage = qubbieStageOf(stage);
    final t = flight.value;
    final line = this.line;
    if (t <= 0 || t >= 1 || line == null) {
      paintQubbie(
        canvas,
        kind,
        _perch.translate(0, -bump * cell * 0.05),
        _bodySize,
        stage: artStage,
        pose: _restingPose(bump),
      );
      return;
    }
    _paintFlight(canvas, pet, kind, artStage, line, t);
  }

  QubbiePose _restingPose(double bump) {
    if (gameOver) {
      return cheering
          ? const QubbiePose(
              eyes: QubbieEyes.happy,
              mouth: QubbieMouth.grin,
              wing: 1,
            )
          : const QubbiePose(
              eyes: QubbieEyes.worried,
              mouth: QubbieMouth.wavy,
              squash: 0.06,
            );
    }
    var look = Offset.zero;
    final target = lookAt;
    if (target != null) {
      final d = target - _perch.translate(0, -_bodySize * 0.5);
      final length = d.distance;
      if (length > 1) look = d / length;
    }
    return QubbiePose(
      eyes: fever ? QubbieEyes.happy : QubbieEyes.open,
      mouth: fever ? QubbieMouth.grin : QubbieMouth.smile,
      look: look,
      turn: look.dx.clamp(-1.0, 1.0) * -0.5,
      facing: -1,
      squash: bump * 0.07,
    );
  }

  /// Out to the line, along it, and back with a flip.
  void _paintFlight(
    Canvas canvas,
    Pet pet,
    QubbieKind kind,
    QubbieStage artStage,
    PetFlightLine line,
    double t,
  ) {
    const outEnd = 0.2;
    const glideEnd = 0.78;
    final mid = (line.index + 0.82) * cell;
    final across = (line.index + 0.5) * cell;
    final start = line.horizontal
        ? Offset(cell * 0.4, mid)
        : Offset(across, cell * 0.95);
    final end = line.horizontal
        ? Offset(size - cell * 0.4, mid)
        : Offset(across, size - cell * 0.1);

    Offset at;
    var tilt = 0.0;
    var facing = 1.0;
    var gliding = false;
    if (t < outEnd) {
      final k = Curves.easeOut.transform(t / outEnd);
      at = Offset.lerp(_perch, start, k)!;
      facing = start.dx < _perch.dx ? -1 : 1;
    } else if (t < glideEnd) {
      final k = Curves.easeInOut.transform((t - outEnd) / (glideEnd - outEnd));
      at = Offset.lerp(start, end, k)!;
      gliding = true;
      // A small bob, so it reads as flying rather than sliding.
      at = at.translate(0, math.sin(k * math.pi * 4) * cell * 0.04);
      _paintTrail(canvas, start, end, k);
    } else {
      final k = Curves.easeInOut.transform((t - glideEnd) / (1 - glideEnd));
      at = Offset.lerp(end, _perch, k)!;
      // An arc over the board, and one flip on the way home.
      at = at.translate(0, -math.sin(k * math.pi) * cell * 0.9);
      tilt = k * 2 * math.pi;
      facing = _perch.dx < end.dx ? -1 : 1;
    }
    final breathes =
        gliding &&
        (pet.signature == PetSignature.fire ||
            pet.signature == PetSignature.frost ||
            pet.signature == PetSignature.phoenix);
    paintQubbie(
      canvas,
      kind,
      at,
      _bodySize,
      stage: artStage,
      pose: QubbiePose(
        eyes: pet.signature == null ? QubbieEyes.happy : QubbieEyes.fierce,
        mouth: breathes ? QubbieMouth.breath : QubbieMouth.grin,
        wing: math.sin(t * math.pi * 10),
        turn: gliding ? 1 : 0.4,
        tilt: tilt,
        facing: facing,
        flying: true,
        shadow: false,
      ),
    );
  }

  /// Sparks left behind on the stretch of the line already flown ([k] of
  /// it); a handful, fading. docs/HAUSTIERE.md §3.6 allows thirty.
  void _paintTrail(Canvas canvas, Offset from, Offset to, double k) {
    if (trail.isEmpty) return;
    const sparks = 16;
    for (var i = 0; i < sparks; i++) {
      final f = i / sparks;
      if (f > k) break;
      final age = k - f;
      final alpha = (1 - age * 2.6).clamp(0.0, 1.0);
      if (alpha <= 0) continue;
      final seed = i * 37 % 11;
      final p = Offset.lerp(from, to, f)!.translate(
        (seed - 5) * cell * 0.03,
        -cell * 0.45 + (seed % 5 - 2) * cell * 0.09 + age * cell * 0.3,
      );
      final r = cell * (0.07 + 0.05 * (seed % 3)) * alpha;
      final color = trail[i % trail.length];
      canvas
        ..drawCircle(
          p,
          r * 2.2,
          Paint()
            ..color = color.withValues(alpha: 0.35 * alpha)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 1.4),
        )
        ..drawCircle(
          p,
          r,
          Paint()
            ..color = Color.lerp(
              color,
              Colors.white,
              0.4,
            )!.withValues(alpha: alpha),
        );
    }
  }

  @override
  bool shouldRepaint(_PetPainter old) =>
      old.pet != pet ||
      old.stage != stage ||
      old.cracks != cracks ||
      old.size != size ||
      old.line != line ||
      old.lookAt != lookAt ||
      old.gameOver != gameOver ||
      old.cheering != cheering ||
      old.fever != fever;
}
