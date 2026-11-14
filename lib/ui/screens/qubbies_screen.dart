/// The nest: every Qubbie, the one that plays along, and the eggs on their
/// way (docs/HAUSTIERE.md §4.1, core scope: no food, no mood, no videos).
///
/// A Qubbie is bought with diamonds and arrives as an egg that says what is
/// in it. Nothing on this screen changes how the game plays.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/pet.dart';
import '../../l10n/app_localizations.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/pet_controller.dart';
import '../state/settings_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import '../widgets/pet_moments.dart';
import '../widgets/qubbie_art.dart';
import '../widgets/qubbie_picture.dart';
import '../widgets/screen_title.dart';
import 'shop_screen.dart';

class QubbiesScreen extends ConsumerStatefulWidget {
  const QubbiesScreen({super.key});

  @override
  ConsumerState<QubbiesScreen> createState() => _QubbiesScreenState();
}

class _QubbiesScreenState extends ConsumerState<QubbiesScreen>
    with SingleTickerProviderStateMixin {
  /// A small hop when the Qubbie on the stage is tapped or chosen.
  late final AnimationController _hop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  @override
  void dispose() {
    _hop.dispose();
    super.dispose();
  }

  Future<void> _tap(Pet pet, PetState pets) async {
    if (pets.owned.contains(pet.id)) {
      ref.read(petControllerProvider.notifier).setActive(pet.id);
      if (!ref.read(reducedEffectsProvider)) _hop.forward(from: 0);
      return;
    }
    // The free first egg comes first: until it is chosen a starter is not
    // for sale, so nobody pays for what they are about to be given.
    final forSale =
        pets.canBuy(pet.id) &&
        (pets.starterChosen || !kStarterPetIds.contains(pet.id));
    if (!forSale) return;
    // A sheet rather than the stage: the card may be far down the list,
    // and what it opens has to be where the finger is.
    final buy = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: GridColors.boardBackground,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => _PetSheet(pet: pet),
    );
    if (buy != true || !mounted) return;
    final l10n = L10n.of(context);
    final ok = await ref.read(petControllerProvider.notifier).buy(pet.id);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.designsNotEnoughDiamonds)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final view = ref.watch(petControllerProvider);
    final controller = ref.read(petControllerProvider.notifier);
    final diamonds = ref.watch(
      gameControllerProvider.select((s) => s.diamonds),
    );
    final pets = view.pets;
    final active = view.active;

    return Scaffold(
      appBar: AppBar(
        title: ScreenTitle(l10n.petsTitle),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: FittedBox(
                child: DiamondAmount(
                  amount: diamonds,
                  size: 15,
                  color: GridColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                if (active != null)
                  _Stage(
                    pet: active,
                    stage: pets.stageOf(active.id),
                    xp: pets.xpOf(active.id),
                    hop: _hop,
                    onTap: ref.watch(reducedEffectsProvider)
                        ? null
                        : () => _hop.forward(from: 0),
                  )
                else if (pets.eggs.isEmpty && controller.offersFirstEgg)
                  PetChoice(onChoose: controller.chooseStarter)
                else if (pets.eggs.isEmpty)
                  const _Teaser(),
                for (final egg in pets.eggs)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PetEggProgress(egg: egg),
                  ),
                const SizedBox(height: 14),
                Text(
                  l10n.petsIntro,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) => GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: constraints.maxWidth >= 480 ? 4 : 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    children: [
                      for (final pet in kPetCatalog)
                        _PetCard(
                          key: ValueKey('pet-card-${pet.id}'),
                          pet: pet,
                          name: petName(l10n, pet.id),
                          pets: pets,
                          onTap: () => _tap(pet, pets),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Before the first egg: what is coming, and when.
class _Teaser extends StatelessWidget {
  const _Teaser();

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Column(
      children: [
        const QubbiePicture.egg(width: 130),
        const SizedBox(height: 8),
        Text(
          l10n.petsFirstEggAfter(PetRules.firstEggAfterRuns),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: GridColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

/// The Qubbie that plays along — or one being looked at — shown large, with
/// what it does and how far it has grown.
class _Stage extends StatelessWidget {
  const _Stage({
    required this.pet,
    required this.stage,
    required this.xp,
    required this.hop,
    required this.onTap,
  });

  final Pet pet;
  final int stage;
  final int xp;
  final Animation<double> hop;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final width = (MediaQuery.sizeOf(context).height * 0.24).clamp(
      120.0,
      210.0,
    );
    final next = stage == 1
        ? PetRules.stage2Xp
        : stage == 2
        ? PetRules.stage3Xp
        : null;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedBuilder(
            animation: hop,
            builder: (context, _) {
              final t = hop.isAnimating ? math.sin(hop.value * math.pi) : 0.0;
              return Transform.translate(
                offset: Offset(0, -12 * t),
                child: QubbiePicture(
                  species: pet.species,
                  stage: stage,
                  width: width,
                  pose: t > 0
                      ? QubbiePose(
                          eyes: QubbieEyes.happy,
                          mouth: QubbieMouth.grin,
                          wing: t,
                          squash: -0.05 * t,
                        )
                      : const QubbiePose(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(
          petName(l10n, pet.id),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: GridColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        _EffectLine(pet: pet),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.commonLevelShort(stage),
                      style: const TextStyle(
                        color: GridColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (next != null)
                    Text(
                      l10n.statsAchievementsRatio(xp, next),
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: next == null ? 1 : xp / next,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                  color: GridColors.placed,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.petGrows,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 13,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// What a Qubbie does to a cleared row: its own effect, or the player's.
class _EffectLine extends StatelessWidget {
  const _EffectLine({required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(AppIcons.sparkle, size: 14, color: GridColors.fever),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            pet.signature == null ? l10n.petEffectYours : l10n.petEffectOwn,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GridColors.fever,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

/// A Qubbie the player does not have, looked at: grown, with what it does
/// and its price in diamonds — or the way to more of them. Pops true to buy.
class _PetSheet extends ConsumerWidget {
  const _PetSheet({required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final diamonds = ref.watch(
      gameControllerProvider.select((s) => s.diamonds),
    );
    final affordable = diamonds >= pet.cost;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QubbiePicture(species: pet.species, stage: 3, width: 190),
            const SizedBox(height: 8),
            Text(
              petName(l10n, pet.id),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: GridColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            _EffectLine(pet: pet),
            const SizedBox(height: 16),
            if (affordable)
              FilledButton(
                key: const ValueKey('pet-buy'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Text(l10n.commonBuy)),
                    const SizedBox(width: 10),
                    DiamondAmount(amount: pet.cost, size: 16),
                  ],
                ),
              )
            else ...[
              DiamondAmount(
                amount: pet.cost,
                size: 17,
                color: GridColors.textPrimary,
              ),
              const SizedBox(height: 10),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(builder: (_) => const ShopScreen()),
                ),
                icon: const DiamondIcon(size: 16),
                label: Text(l10n.designsGetDiamonds),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PetCard extends StatelessWidget {
  const _PetCard({
    super.key,
    required this.pet,
    required this.name,
    required this.pets,
    required this.onTap,
  });

  final Pet pet;
  final String name;
  final PetState pets;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final owned = pets.owned.contains(pet.id);
    final active = pets.activeId == pet.id;
    PetEgg? egg;
    for (final e in pets.eggs) {
      if (e.petId == pet.id) egg = e;
    }
    const muted = TextStyle(color: GridColors.textMuted, fontSize: 12);
    final Widget status;
    if (active) {
      status = Text(
        l10n.commonActive,
        style: muted.copyWith(color: GridColors.placed),
      );
    } else if (owned) {
      status = Text(l10n.designsOwned, style: muted);
    } else if (egg != null) {
      status = Text(l10n.petInEgg, style: muted);
    } else if (!pets.starterChosen && kStarterPetIds.contains(pet.id)) {
      // One of these is the free first egg; no price until it is chosen.
      status = const SizedBox(height: 14);
    } else {
      status = DiamondAmount(
        amount: pet.cost,
        size: 13,
        color: GridColors.textPrimary,
      );
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active ? GridColors.placed : GridColors.gridLine,
            width: active ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FittedBox(
                child: egg != null
                    ? QubbiePicture.egg(width: 80, cracks: egg.progress)
                    : QubbiePicture(
                        species: pet.species,
                        // What it is now if it is the player's, what it
                        // grows into if it is not.
                        stage: owned ? pets.stageOf(pet.id) : 3,
                        width: 80,
                      ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  name,
                  style: const TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: double.infinity,
              child: FittedBox(fit: BoxFit.scaleDown, child: status),
            ),
          ],
        ),
      ),
    );
  }
}
