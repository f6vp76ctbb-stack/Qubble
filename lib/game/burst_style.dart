/// Explosions (owner, 30.09.2026): how cleared blocks burst. Pure Dart, no
/// Flutter imports; the drawing is in lib/ui/widgets/clear_burst.dart.
///
/// The burst the game always had stays free as the default; five more cost
/// 100 diamonds each (owner's choice).
library;

enum BurstStyle { classic, confetti, fire, pixels, stars, bubbles }

class BurstEffect {
  const BurstEffect({required this.id, required this.style, required this.cost});

  /// Stable catalog id; the displayed name is `burstName` in
  /// lib/ui/l10n_maps.dart.
  final String id;
  final BurstStyle style;

  /// Price in diamonds; 0 for the default.
  final int cost;
}

const String kDefaultBurstId = 'classic';

/// Price of each explosion, in diamonds.
const int kBurstPrice = 100;

const List<BurstEffect> kBurstCatalog = [
  BurstEffect(id: kDefaultBurstId, style: BurstStyle.classic, cost: 0),
  BurstEffect(id: 'confetti', style: BurstStyle.confetti, cost: kBurstPrice),
  BurstEffect(id: 'fire', style: BurstStyle.fire, cost: kBurstPrice),
  BurstEffect(id: 'pixels', style: BurstStyle.pixels, cost: kBurstPrice),
  BurstEffect(id: 'stars', style: BurstStyle.stars, cost: kBurstPrice),
  BurstEffect(id: 'bubbles', style: BurstStyle.bubbles, cost: kBurstPrice),
];

BurstStyle burstStyleById(String id) => kBurstCatalog
    .firstWhere((b) => b.id == id, orElse: () => kBurstCatalog.first)
    .style;
