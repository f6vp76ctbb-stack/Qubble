/// Pure-Dart block skin catalog (MASTERPLAN.md C, Tier 3). No Flutter imports.
///
/// A block skin changes how filled cells and tray pieces are drawn (on top of
/// the active theme's colour). Cosmetic only. Currency separation (Juli 2026):
/// **gold** is the play currency (boosters + entry-level "gold skins"),
/// **diamonds** are the premium cosmetic currency for the fancy skins.
/// Supporter-only skins come exclusively with the supporter pack.
library;

enum BlockSkinStyle { solid, gradient, glossy, outline, bevel, glow, stripe, crystal }

/// Which currency unlocks a skin.
enum SkinCurrency { gold, diamond }

class BlockSkin {
  const BlockSkin({
    required this.id,
    required this.cost,
    required this.style,
    this.currency = SkinCurrency.gold,
    this.supporterOnly = false,
  });

  /// Stable catalog id. The name a player reads comes from the l10n layer
  /// (`skinName` in lib/ui/l10n_maps.dart) — this file carries no display
  /// text, which is how German skin names once reached English players.
  final String id;

  /// Price to unlock, in [currency] (0 = free / always owned; ignored if
  /// [supporterOnly]).
  final int cost;
  final BlockSkinStyle style;

  /// Whether [cost] is in gold or diamonds.
  final SkinCurrency currency;

  /// Exclusive to the supporter pack — never purchasable at all.
  final bool supporterOnly;
}

const String kDefaultSkinId = 'classic';

// Prices are deliberately steep so a skin is a real goal, not "two bombs".
// Gold skins are earned by playing; diamond skins are premium (diamonds come
// from the gold→diamond exchange or a future diamond purchase).
const List<BlockSkin> kSkinCatalog = [
  BlockSkin(
    id: kDefaultSkinId,
    cost: 0,
    style: BlockSkinStyle.solid,
  ),
  // --- Gold skins (earned by playing) ---
  BlockSkin(
    id: 'gradient',
    cost: 1200,
    style: BlockSkinStyle.gradient,
  ),
  BlockSkin(
    id: 'outline',
    cost: 1500,
    style: BlockSkinStyle.outline,
  ),
  BlockSkin(
    id: 'glossy',
    cost: 1800,
    style: BlockSkinStyle.glossy,
  ),
  BlockSkin(
    id: 'stripe',
    cost: 2200,
    style: BlockSkinStyle.stripe,
  ),
  // --- Diamond skins (premium) ---
  BlockSkin(
    id: 'bevel',
    cost: 30,
    style: BlockSkinStyle.bevel,
    currency: SkinCurrency.diamond,
  ),
  BlockSkin(
    id: 'glow',
    cost: 50,
    style: BlockSkinStyle.glow,
    currency: SkinCurrency.diamond,
  ),
  // --- Supporter exclusive ---
  BlockSkin(
    id: 'crystal',
    cost: 0,
    style: BlockSkinStyle.crystal,
    supporterOnly: true,
  ),
];

BlockSkinStyle skinStyleById(String id) {
  return kSkinCatalog
      .firstWhere((s) => s.id == id, orElse: () => kSkinCatalog.first)
      .style;
}
