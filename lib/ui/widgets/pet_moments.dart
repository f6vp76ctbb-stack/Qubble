/// What the game says about Qubbies between runs: the choice of the free
/// first egg, an egg on its way, and the moment one hatches. The game-over
/// card and the nest show the same three pieces.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/pet.dart';
import '../../l10n/app_localizations.dart';
import '../l10n_maps.dart';
import '../state/pet_controller.dart';
import '../state/settings_controller.dart';
import '../theme.dart';
import 'qubbie_picture.dart';

/// The frame the three pieces share.
class _MomentCard extends StatelessWidget {
  const _MomentCard({required this.child, this.highlight = false});

  final Widget child;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: highlight ? 0.09 : 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: highlight
              ? GridColors.fever.withValues(alpha: 0.7)
              : Colors.white.withValues(alpha: 0.12),
          width: highlight ? 1.5 : 1,
        ),
      ),
      child: child,
    );
  }
}

/// The free first egg: one of the three starters, chosen by the player.
/// What is in each egg is shown — nothing here is left to chance.
class PetChoice extends StatelessWidget {
  const PetChoice({super.key, required this.onChoose});

  final ValueChanged<String> onChoose;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return _MomentCard(
      highlight: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.petChooseTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GridColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final id in kStarterPetIds)
                Expanded(
                  child: _StarterTile(
                    pet: petById(id)!,
                    name: petName(l10n, id),
                    onTap: () => onChoose(id),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.petChooseBody,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GridColors.textMuted,
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _StarterTile extends StatelessWidget {
  const _StarterTile({
    required this.pet,
    required this.name,
    required this.onTap,
  });

  final Pet pet;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Material(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          key: ValueKey('pet-choose-${pet.id}'),
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: QubbiePicture(
                    species: pet.species,
                    stage: 1,
                    width: 76,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: GridColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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

/// An egg on its way: whose it is, and how many cleared lines it has had.
class PetEggProgress extends StatelessWidget {
  const PetEggProgress({super.key, required this.egg});

  final PetEgg egg;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return _MomentCard(
      child: Row(
        children: [
          QubbiePicture.egg(width: 58, cracks: egg.progress),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        petName(l10n, egg.petId),
                        style: const TextStyle(
                          color: GridColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.statsAchievementsRatio(
                        egg.linesDone,
                        egg.linesTotal,
                      ),
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        color: GridColors.fever,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: egg.progress,
                    minHeight: 7,
                    backgroundColor: Colors.white.withValues(alpha: 0.12),
                    color: GridColors.fever,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.petEggHint,
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
      ),
    );
  }
}

/// The egg has opened. Pops in once; stands still under reduced effects.
class PetHatched extends StatelessWidget {
  const PetHatched({super.key, required this.pet, this.reduced = false});

  final Pet pet;
  final bool reduced;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final picture = QubbiePicture.hatching(species: pet.species, width: 150);
    return _MomentCard(
      highlight: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (reduced)
            picture
          else
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              builder: (context, t, child) =>
                  Transform.scale(scale: 0.6 + 0.4 * t, child: child),
              child: picture,
            ),
          const SizedBox(height: 6),
          Text(
            l10n.petHatchedTitle(petName(l10n, pet.id)),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GridColors.fever,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.petHatchedBody,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GridColors.textMuted,
              fontSize: 14,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// The Qubbie part of a finished run, if there is one: a newcomer, the free
/// first egg to choose, or the egg being hatched. Empty otherwise.
class PetResultSection extends ConsumerWidget {
  const PetResultSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(petControllerProvider);
    final controller = ref.read(petControllerProvider.notifier);
    final Widget child;
    final hatched = view.justHatched.isEmpty
        ? null
        : petById(view.justHatched.first);
    if (hatched != null) {
      child = PetHatched(
        pet: hatched,
        reduced: ref.watch(reducedEffectsProvider),
      );
    } else if (controller.offersFirstEgg) {
      child = PetChoice(onChoose: controller.chooseStarter);
    } else if (view.pets.eggs.isNotEmpty) {
      child = PetEggProgress(egg: view.pets.eggs.first);
    } else {
      return const SizedBox.shrink();
    }
    return Padding(padding: const EdgeInsets.only(top: 14), child: child);
  }
}
