/// Pure-Dart block skin catalog (MASTERPLAN.md C, Tier 3). No Flutter imports.
///
/// A block skin changes how filled cells and tray pieces are drawn (on top of
/// the active theme's colour). Cosmetic only. Currency separation (Juli 2026):
/// **gold** is the play currency (boosters + entry-level "gold skins"),
/// **diamonds** are the premium cosmetic currency for the fancy skins.
/// Supporter-only skins come exclusively with the supporter pack.
library;

import 'design_offer.dart';

enum BlockSkinStyle {
  solid,
  gradient,
  glossy,
  outline,
  bevel,
  glow,
  stripe,
  crystal,
  // Static diamond skins in the daily rotation (owner, 28.09.2026).
  pixel,
  marble,
  jelly,
  // Animated from here on — the achievement rewards (decided 28.09.2026) …
  pulse,
  shimmer,
  wave,
  ember,
  prism,
  stardust,
  circuit,
  ripple,
  // … and three for sale in the shop (owner, 28.09.2026).
  liquid,
  fizz,
  plasma;

  /// Whether cells in this style move over time, so the painters need a
  /// running clock. Every style from [pulse] on is animated; static styles
  /// go before it.
  bool get isAnimated => index >= pulse.index;
}

/// Which currency unlocks a skin.
enum SkinCurrency { gold, diamond }

class BlockSkin {
  const BlockSkin({
    required this.id,
    required this.cost,
    required this.style,
    this.currency = SkinCurrency.gold,
    this.supporterOnly = false,
    this.achievementId,
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

  /// Earned only by unlocking this achievement — never for coins, diamonds
  /// or money. Null for every other skin.
  final String? achievementId;

  /// Whether the shop may sell this skin.
  bool get isPurchasable => !supporterOnly && achievementId == null;
}

const String kDefaultSkinId = 'classic';

/// Price of each animated skin in the shop, in diamonds.
const int kAnimatedSkinPrice = 150;

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
  // --- Diamond skins in the daily rotation (owner, 28.09.2026) ---
  // Always for sale; one design a day is the deal of the day at a discount
  // (lib/game/design_offer.dart). The price here is the regular one.
  BlockSkin(
    id: 'pixel',
    cost: kRotatingDesignPrice,
    style: BlockSkinStyle.pixel,
    currency: SkinCurrency.diamond,
  ),
  BlockSkin(
    id: 'marble',
    cost: kRotatingDesignPrice,
    style: BlockSkinStyle.marble,
    currency: SkinCurrency.diamond,
  ),
  BlockSkin(
    id: 'jelly',
    cost: kRotatingDesignPrice,
    style: BlockSkinStyle.jelly,
    currency: SkinCurrency.diamond,
  ),
  // --- Animated skins for sale (owner, 28.09.2026: 150 diamonds each) ---
  // Separate from the achievement skins, which stay unbuyable.
  BlockSkin(
    id: 'liquid',
    cost: kAnimatedSkinPrice,
    style: BlockSkinStyle.liquid,
    currency: SkinCurrency.diamond,
  ),
  BlockSkin(
    id: 'fizz',
    cost: kAnimatedSkinPrice,
    style: BlockSkinStyle.fizz,
    currency: SkinCurrency.diamond,
  ),
  BlockSkin(
    id: 'plasma',
    cost: kAnimatedSkinPrice,
    style: BlockSkinStyle.plasma,
    currency: SkinCurrency.diamond,
  ),
  // --- Supporter exclusive ---
  BlockSkin(
    id: 'crystal',
    cost: 0,
    style: BlockSkinStyle.crystal,
    supporterOnly: true,
  ),
  // --- Achievement rewards (animated) ---
  // One per achievement category, earned by its highest tier.
  BlockSkin(
    id: 'pulse',
    cost: 0,
    style: BlockSkinStyle.pulse,
    achievementId: 'games_100',
  ),
  BlockSkin(
    id: 'shimmer',
    cost: 0,
    style: BlockSkinStyle.shimmer,
    achievementId: 'score_25k',
  ),
  BlockSkin(
    id: 'wave',
    cost: 0,
    style: BlockSkinStyle.wave,
    achievementId: 'lines_1000',
  ),
  BlockSkin(
    id: 'ember',
    cost: 0,
    style: BlockSkinStyle.ember,
    achievementId: 'combo_10',
  ),
  BlockSkin(
    id: 'prism',
    cost: 0,
    style: BlockSkinStyle.prism,
    achievementId: 'level_20',
  ),
  BlockSkin(
    id: 'stardust',
    cost: 0,
    style: BlockSkinStyle.stardust,
    achievementId: 'streak_30',
  ),
  BlockSkin(
    id: 'circuit',
    cost: 0,
    style: BlockSkinStyle.circuit,
    achievementId: 'puzzles_10',
  ),
  BlockSkin(
    id: 'ripple',
    cost: 0,
    style: BlockSkinStyle.ripple,
    achievementId: 'pieces_5000',
  ),
];

BlockSkinStyle skinStyleById(String id) {
  return kSkinCatalog
      .firstWhere((s) => s.id == id, orElse: () => kSkinCatalog.first)
      .style;
}
