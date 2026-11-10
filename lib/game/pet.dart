/// Pets — the "Qubbies" (owner, 12./13.10.2026; MASTERPLAN.md Phase 8,
/// docs/HAUSTIERE.md). Pure Dart, no Flutter imports; the creatures are
/// drawn in lib/ui/widgets/qubbie_art.dart.
///
/// A Qubbie sits on the edge of the board and flies along a row when it is
/// cleared. That is all it does to the game: it never gives points, moves,
/// pieces or hints, and a bought one is never stronger than a free one.
/// Nothing here is random — an egg always says what is in it.
library;

/// The creature a Qubbie is; its look lives in the UI layer.
enum PetSpecies {
  cat,
  dog,
  slime,
  penguin,
  owl,
  thunderbird,
  dragon,
  unicorn,
  phoenix,
}

enum PetTier { starter, premium, legendary }

/// The row effect a Qubbie brings along. Starters have none and fly with the
/// effect the player has equipped, which makes bought row effects worth more
/// rather than pointless.
enum PetSignature { frost, laser, lightning, fire, rainbow, phoenix }

class Pet {
  const Pet({
    required this.id,
    required this.species,
    required this.tier,
    required this.cost,
    this.signature,
  });

  /// Stable id: storage, analytics, the localized name (`petName` in
  /// lib/ui/l10n_maps.dart).
  final String id;
  final PetSpecies species;
  final PetTier tier;

  /// Price in diamonds. A starter is free once (the first egg); the other
  /// two cost this.
  final int cost;
  final PetSignature? signature;
}

/// Prices by class: two to ten times the dearest design (150 diamonds).
const int kStarterPetPrice = 300;
const int kPremiumPetPrice = 600;
const int kFlagshipPetPrice = 900;
const int kLegendaryPetPrice = 1500;

/// The three a player chooses their free first egg from.
const List<String> kStarterPetIds = ['kiki', 'bit', 'glim'];

/// Everything that can be had all year. (Goldi, the founder's Qubbie of the
/// concept, belongs to the launch event and is not built yet.)
const List<Pet> kPetCatalog = [
  Pet(
    id: 'kiki',
    species: PetSpecies.cat,
    tier: PetTier.starter,
    cost: kStarterPetPrice,
  ),
  Pet(
    id: 'bit',
    species: PetSpecies.dog,
    tier: PetTier.starter,
    cost: kStarterPetPrice,
  ),
  Pet(
    id: 'glim',
    species: PetSpecies.slime,
    tier: PetTier.starter,
    cost: kStarterPetPrice,
  ),
  Pet(
    id: 'frosti',
    species: PetSpecies.penguin,
    tier: PetTier.premium,
    cost: kPremiumPetPrice,
    signature: PetSignature.frost,
  ),
  Pet(
    id: 'optik',
    species: PetSpecies.owl,
    tier: PetTier.premium,
    cost: kPremiumPetPrice,
    signature: PetSignature.laser,
  ),
  Pet(
    id: 'zapp',
    species: PetSpecies.thunderbird,
    tier: PetTier.premium,
    cost: kPremiumPetPrice,
    signature: PetSignature.lightning,
  ),
  Pet(
    id: 'funki',
    species: PetSpecies.dragon,
    tier: PetTier.premium,
    cost: kFlagshipPetPrice,
    signature: PetSignature.fire,
  ),
  Pet(
    id: 'prisma',
    species: PetSpecies.unicorn,
    tier: PetTier.premium,
    cost: kFlagshipPetPrice,
    signature: PetSignature.rainbow,
  ),
  Pet(
    id: 'pyra',
    species: PetSpecies.phoenix,
    tier: PetTier.legendary,
    cost: kLegendaryPetPrice,
    signature: PetSignature.phoenix,
  ),
];

Pet? petById(String id) {
  for (final pet in kPetCatalog) {
    if (pet.id == id) return pet;
  }
  return null;
}

class PetRules {
  const PetRules._();

  /// Finished runs after which the first egg is offered. Not the first: the
  /// game over of a first run has enough to say.
  static const int firstEggAfterRuns = 3;

  /// Cleared lines until the free first egg hatches — within the next run.
  static const int starterEggLines = 10;

  /// Cleared lines until a bought egg hatches, about one run.
  static const int boughtEggLines = 15;

  /// Experience (one per cleared line while active) at which a Qubbie grows.
  static const int stage2Xp = 300;
  static const int stage3Xp = 1500;

  /// 1, 2 or 3.
  static int stageFor(int xp) => xp >= stage3Xp
      ? 3
      : xp >= stage2Xp
      ? 2
      : 1;

  /// How far along its current stage a Qubbie is, 0..1; 1 once fully grown.
  static double stageProgress(int xp) {
    if (xp >= stage3Xp) return 1;
    if (xp >= stage2Xp) return (xp - stage2Xp) / (stage3Xp - stage2Xp);
    return xp <= 0 ? 0 : xp / stage2Xp;
  }

  /// Whether the game should offer the free first egg now.
  static bool offersFirstEgg(PetState state, {required int finishedRuns}) =>
      !state.starterChosen && finishedRuns >= firstEggAfterRuns;
}

/// An egg on its way. What is in it is always known.
class PetEgg {
  const PetEgg({required this.petId, required this.linesLeft});

  final String petId;

  /// Cleared lines until it hatches; 0 means it hatches at the next game
  /// over.
  final int linesLeft;

  bool get ready => linesLeft <= 0;
}

/// Everything about a player's Qubbies. Immutable.
class PetState {
  const PetState._({
    required this.owned,
    required this.activeId,
    required this.starterChosen,
    required this.eggs,
    required Map<String, int> xp,
  }) : _xp = xp;

  static const PetState empty = PetState._(
    owned: <String>{},
    activeId: null,
    starterChosen: false,
    eggs: <PetEgg>[],
    xp: <String, int>{},
  );

  /// Hatched Qubbies.
  final Set<String> owned;

  /// The one that plays along, or null before the first has hatched.
  final String? activeId;

  /// Whether the free first egg has been taken.
  final bool starterChosen;

  /// Eggs still being hatched, oldest first.
  final List<PetEgg> eggs;

  final Map<String, int> _xp;

  int xpOf(String id) => _xp[id] ?? 0;
  int stageOf(String id) => PetRules.stageFor(xpOf(id));

  bool get hasAnything => owned.isNotEmpty || eggs.isNotEmpty;

  /// Whether an egg is waiting for the game over to open.
  bool get hasReadyEgg => eggs.any((e) => e.ready);

  bool _inEgg(String id) => eggs.any((e) => e.petId == id);

  /// Whether [id] can be bought: known, not hatched, not already an egg.
  bool canBuy(String id) =>
      petById(id) != null && !owned.contains(id) && !_inEgg(id);

  PetState _copy({
    Set<String>? owned,
    String? activeId,
    bool? starterChosen,
    List<PetEgg>? eggs,
    Map<String, int>? xp,
  }) => PetState._(
    owned: owned ?? this.owned,
    activeId: activeId ?? this.activeId,
    starterChosen: starterChosen ?? this.starterChosen,
    eggs: eggs ?? this.eggs,
    xp: xp ?? _xp,
  );

  /// Takes the free first egg. Returns this unchanged if it was taken
  /// before or [id] is not a starter.
  PetState chooseStarter(String id) {
    if (starterChosen || !kStarterPetIds.contains(id) || !canBuy(id)) {
      return this;
    }
    return _copy(
      starterChosen: true,
      eggs: [
        ...eggs,
        PetEgg(petId: id, linesLeft: PetRules.starterEggLines),
      ],
    );
  }

  /// Adds the egg of a Qubbie paid for with diamonds; null if it cannot be
  /// bought ([canBuy]). The caller takes the diamonds.
  PetState? addBoughtEgg(String id) {
    if (!canBuy(id)) return null;
    return _copy(
      eggs: [
        ...eggs,
        PetEgg(petId: id, linesLeft: PetRules.boughtEggLines),
      ],
    );
  }

  /// Books [lines] cleared lines: every egg comes closer to hatching, and
  /// the active Qubbie gains experience.
  PetState addLines(int lines) {
    if (lines <= 0 || (eggs.isEmpty && activeId == null)) return this;
    final active = activeId;
    return _copy(
      eggs: [
        for (final egg in eggs)
          PetEgg(
            petId: egg.petId,
            linesLeft: egg.linesLeft - lines < 0 ? 0 : egg.linesLeft - lines,
          ),
      ],
      xp: active == null ? _xp : {..._xp, active: xpOf(active) + lines},
    );
  }

  /// Opens every egg that is ready — at a game over, never in mid-move. The
  /// first Qubbie becomes the active one at once.
  ({PetState state, List<String> hatched}) hatchReady() {
    final hatched = [
      for (final egg in eggs)
        if (egg.ready) egg.petId,
    ];
    if (hatched.isEmpty) return (state: this, hatched: const []);
    return (
      state: _copy(
        owned: {...owned, ...hatched},
        activeId: activeId ?? hatched.first,
        eggs: [
          for (final egg in eggs)
            if (!egg.ready) egg,
        ],
      ),
      hatched: hatched,
    );
  }

  /// Makes a hatched Qubbie the one that plays along.
  PetState withActive(String id) =>
      owned.contains(id) && id != activeId ? _copy(activeId: id) : this;

  /// What survives a progress reset: what was chosen, bought and hatched.
  Map<String, Object?> entitlementJson() => {
    'owned': owned.toList(),
    'active': activeId,
    'starter': starterChosen,
    'eggs': [
      for (final egg in eggs) {'id': egg.petId, 'left': egg.linesLeft},
    ],
  };

  /// Progress: how far each Qubbie has grown.
  Map<String, Object?> progressJson() => {'xp': _xp};

  /// Reads both parts back. Anything missing, malformed or no longer in the
  /// catalog is dropped rather than thrown: a save written by another
  /// version must never take the app down.
  factory PetState.fromJson({
    required Map<String, dynamic>? entitlement,
    required Map<String, dynamic>? progress,
  }) {
    final owned = <String>{};
    final rawOwned = entitlement?['owned'];
    if (rawOwned is List) {
      for (final id in rawOwned) {
        if (id is String && petById(id) != null) owned.add(id);
      }
    }
    final eggs = <PetEgg>[];
    final rawEggs = entitlement?['eggs'];
    if (rawEggs is List) {
      for (final raw in rawEggs) {
        if (raw is! Map) continue;
        final id = raw['id'];
        final left = raw['left'];
        if (id is! String || left is! num) continue;
        if (petById(id) == null || owned.contains(id)) continue;
        if (eggs.any((e) => e.petId == id)) continue;
        eggs.add(PetEgg(petId: id, linesLeft: left < 0 ? 0 : left.toInt()));
      }
    }
    final rawActive = entitlement?['active'];
    final active = rawActive is String && owned.contains(rawActive)
        ? rawActive
        : owned.isEmpty
        ? null
        : owned.first;
    final xp = <String, int>{};
    final rawXp = progress?['xp'];
    if (rawXp is Map) {
      rawXp.forEach((id, value) {
        if (id is String && value is num && owned.contains(id) && value > 0) {
          xp[id] = value.toInt();
        }
      });
    }
    return PetState._(
      owned: owned,
      activeId: active,
      starterChosen: entitlement?['starter'] == true || owned.isNotEmpty,
      eggs: eggs,
      xp: xp,
    );
  }
}
