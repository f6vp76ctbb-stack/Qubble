/// A still picture of a Qubbie or of its egg, for menus and cards. The
/// creatures themselves are drawn in qubbie_art.dart; on the board they are
/// painted by pet_overlay.dart.
library;

import 'package:flutter/material.dart';

import '../../game/pet.dart';
import 'qubbie_art.dart';

/// The drawing of [species].
QubbieKind qubbieKindOf(PetSpecies species) => switch (species) {
  PetSpecies.cat => QubbieKind.cat,
  PetSpecies.dog => QubbieKind.dog,
  PetSpecies.slime => QubbieKind.slime,
  PetSpecies.penguin => QubbieKind.penguin,
  PetSpecies.owl => QubbieKind.owl,
  PetSpecies.thunderbird => QubbieKind.thunderbird,
  PetSpecies.dragon => QubbieKind.dragon,
  PetSpecies.unicorn => QubbieKind.unicorn,
  PetSpecies.phoenix => QubbieKind.phoenix,
};

/// The drawing stage of game stage 1, 2 or 3.
QubbieStage qubbieStageOf(int stage) =>
    QubbieStage.values[(stage - 1).clamp(0, QubbieStage.values.length - 1)];

/// The adult body width at which a Qubbie of [stage] is [width] wide, wings
/// and tail included. The art draws the young ones smaller with shorter
/// wings; a picture wants each of them to fill its box.
double qubbieSizeForWidth(double width, int stage) {
  final s = (stage - 1).clamp(0, 2);
  const scale = [0.64, 0.82, 1.0];
  const grow = [0.36, 0.68, 1.0];
  return width / (scale[s] * (1 + 1.2 * grow[s]));
}

class QubbiePicture extends StatelessWidget {
  const QubbiePicture({
    super.key,
    required this.species,
    this.stage = 3,
    this.width = 96,
    this.pose = const QubbiePose(),
  }) : egg = false,
       eggOpen = false,
       cracks = 0;

  /// The egg a Qubbie comes in, cracked as far as [cracks] (0..1).
  const QubbiePicture.egg({super.key, this.width = 96, this.cracks = 0})
    : species = PetSpecies.cat,
      stage = 1,
      pose = const QubbiePose(),
      egg = true,
      eggOpen = false;

  /// The moment it hatches: the open egg, and the Qubbie coming out of it.
  const QubbiePicture.hatching({
    super.key,
    required this.species,
    this.width = 96,
  }) : stage = 1,
       pose = const QubbiePose(
         eyes: QubbieEyes.happy,
         mouth: QubbieMouth.grin,
         shadow: false,
       ),
       egg = true,
       eggOpen = true,
       cracks = 0;

  final PetSpecies species;

  /// Game stage, 1 to 3.
  final int stage;

  /// The box is [width] by four fifths of it; the creature fills it.
  final double width;
  final QubbiePose pose;
  final bool egg;
  final bool eggOpen;
  final double cracks;

  /// Height of the box for [width].
  static double heightFor(double width) => width * 0.8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heightFor(width),
      child: CustomPaint(
        painter: _PicturePainter(
          kind: qubbieKindOf(species),
          stage: stage,
          pose: pose,
          egg: egg,
          eggOpen: eggOpen,
          cracks: cracks,
        ),
      ),
    );
  }
}

class _PicturePainter extends CustomPainter {
  _PicturePainter({
    required this.kind,
    required this.stage,
    required this.pose,
    required this.egg,
    required this.eggOpen,
    required this.cracks,
  });

  final QubbieKind kind;
  final int stage;
  final QubbiePose pose;
  final bool egg;
  final bool eggOpen;
  final double cracks;

  @override
  void paint(Canvas canvas, Size box) {
    final ground = Offset(box.width / 2, box.height * 0.94);
    if (!egg) {
      paintQubbie(
        canvas,
        kind,
        ground,
        qubbieSizeForWidth(box.width * 0.94, stage),
        stage: qubbieStageOf(stage),
        pose: pose,
      );
      return;
    }
    if (!eggOpen) {
      paintQubbieEgg(canvas, ground, box.height * 0.86, cracks: cracks);
      return;
    }
    // The lower shell stays on the ground; the newborn stands in it.
    final eggHeight = box.height * 0.6;
    paintQubbieEgg(canvas, ground, eggHeight, open: true);
    paintQubbie(
      canvas,
      kind,
      ground.translate(0, -eggHeight * 0.52),
      qubbieSizeForWidth(box.width * 0.4, 1),
      stage: QubbieStage.baby,
      pose: pose,
    );
  }

  @override
  bool shouldRepaint(_PicturePainter old) =>
      old.kind != kind ||
      old.stage != stage ||
      old.pose != pose ||
      old.egg != egg ||
      old.eggOpen != eggOpen ||
      old.cracks != cracks;
}
