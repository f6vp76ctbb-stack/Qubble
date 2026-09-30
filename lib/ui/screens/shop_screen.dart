/// The shop (reworked on the owner's request, 28.09.2026): the balance on top,
/// the deal of the day, the designs for diamonds, then diamonds, coins and
/// packs — each product with its own symbol and its own name. Names come from
/// the l10n layer, never from the store: Play appends "(app name)" to every
/// product title.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/block_skin.dart';
import '../../game/design_offer.dart';
import '../../game/economy.dart';
import '../../game/seasonal.dart';
import '../../l10n/app_localizations.dart';
import '../../monetization/iap.dart';
import '../format.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/settings_controller.dart';
import '../state/skin_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import '../widgets/mini_board_preview.dart';
import '../widgets/screen_title.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  /// Where "get diamonds" scrolls to.
  final _diamondsKey = GlobalKey();

  void _showDiamonds() {
    final target = _diamondsKey.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  /// Buys and equips a design for diamonds at today's price.
  Future<void> _buyDesign(ShopDesign design, int price) async {
    final l10n = L10n.of(context);
    bool ok;
    if (design.kind == DesignKind.theme) {
      final entry = kThemeCatalog.firstWhere((e) => e.id == design.id);
      ok = await ref
          .read(themeControllerProvider.notifier)
          .selectOrUnlock(entry, price: price);
    } else {
      final skin = kSkinCatalog.firstWhere((s) => s.id == design.id);
      ok = await ref
          .read(skinControllerProvider.notifier)
          .selectOrUnlock(skin, price: price);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? l10n.shopDesignUnlocked(_designName(l10n, design))
              : l10n.designsNotEnoughDiamonds,
        ),
        action: ok
            ? null
            : SnackBarAction(
                label: l10n.designsGetDiamonds,
                onPressed: _showDiamonds,
              ),
      ),
    );
  }

  bool _owns(ShopDesign design) => design.kind == DesignKind.theme
      ? ref.read(themeControllerProvider).isUnlocked(design.id)
      : ref.read(skinControllerProvider).isUnlocked(design.id);

  @override
  Widget build(BuildContext context) {
    final iap = ref.watch(iapServiceProvider);
    final l10n = L10n.of(context);
    final snap = ref.watch(gameControllerProvider);
    // Rebuild on purchases so "owned" is current.
    ref.watch(themeControllerProvider);
    ref.watch(skinControllerProvider);
    final now = ref.watch(gameCalendarProvider)();
    final deal = dailyDeal(now);
    final products = {for (final p in iap.products) p.id: p};

    ShopProduct? product(String id) => products[id];

    return Scaffold(
      appBar: AppBar(
        // A text action beside the title leaves little room; at a large system
        // font the German "Wiederherstellen" pushes the title off the bar.
        title: ScreenTitle(l10n.shopTitle),
        backgroundColor: GridColors.background,
        actions: [
          Flexible(
            child: TextButton(
              onPressed: iap.restore,
              child: Text(l10n.commonRestore, overflow: TextOverflow.fade),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          _Balance(coins: snap.coins, diamonds: snap.diamonds),
          const SizedBox(height: 18),
          // Halloween (owner, 30.09.2026): October only, first in the shop.
          if (halloweenActive(now)) ...[
            _SectionTitle(l10n.halloweenTitle, icon: Icons.nightlight_round),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                l10n.halloweenBody,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ),
            _DesignRow(
              designs: const [
                ShopDesign(DesignKind.theme, kHalloweenThemeId),
                ShopDesign(DesignKind.skin, kHalloweenSkinId),
              ],
              now: now,
              owns: _owns,
              onBuy: _buyDesign,
            ),
            const SizedBox(height: 22),
          ],
          _SectionTitle(l10n.shopDealTitle, icon: Icons.local_fire_department_rounded),
          _DealCard(
            design: deal,
            price: designPrice(deal, now),
            owned: _owns(deal),
            onBuy: () => _buyDesign(deal, designPrice(deal, now)),
          ),
          const SizedBox(height: 22),
          _SectionTitle(l10n.shopAnimatedSkins, icon: Icons.auto_awesome_rounded),
          _DesignRow(
            designs: [
              for (final s in kSkinCatalog)
                // Seasonal skins have their own section, in their month.
                if (s.style.isAnimated && s.isPurchasable && s.saleMonth == null)
                  ShopDesign(DesignKind.skin, s.id),
            ],
            now: now,
            owns: _owns,
            onBuy: _buyDesign,
          ),
          const SizedBox(height: 22),
          _SectionTitle(l10n.shopNewDesigns, icon: Icons.palette_rounded),
          _DesignRow(
            designs: kRotatingDesigns,
            now: now,
            owns: _owns,
            onBuy: _buyDesign,
          ),
          const SizedBox(height: 22),
          // Locked storefront (public web/PWA): purchases only exist in the
          // store apps, so the web demo can't hand out anything for free.
          if (products.isEmpty) ...[
            _Note(l10n.shopWebDemoNote),
            const SizedBox(height: 22),
          ],
          KeyedSubtree(
            key: _diamondsKey,
            child: _SectionTitle(l10n.shopDiamonds, diamond: true),
          ),
          for (final (id, badge) in [
            (IapProducts.diamondsS, null),
            (IapProducts.diamondsM, l10n.shopPopular),
            (IapProducts.diamondsL, l10n.shopBestValue),
          ])
            if (product(id) case final p?)
              _ProductRow(
                product: p,
                title: iapProductTitle(l10n, id),
                blurb: l10n.shopDiamondsBlurb,
                badge: badge,
                onBuy: () => iap.buy(id),
              ),
          _ExchangeCard(coins: snap.coins),
          const SizedBox(height: 22),
          if ([
            IapProducts.coinsS,
            IapProducts.coinsM,
            IapProducts.coinsL,
          ].any(products.containsKey)) ...[
            _SectionTitle(l10n.statsCoins, coin: true),
            for (final (id, badge) in [
              (IapProducts.coinsS, null),
              (IapProducts.coinsM, l10n.shopPopular),
              (IapProducts.coinsL, l10n.shopBestValue),
            ])
              if (product(id) case final p?)
                _ProductRow(
                  product: p,
                  title: iapProductTitle(l10n, id),
                  blurb: l10n.shopCoinsBlurb,
                  badge: badge,
                  onBuy: () => iap.buy(id),
                ),
            const SizedBox(height: 22),
          ],
          if ([
            IapProducts.supporter,
            IapProducts.starter,
            IapProducts.neonTheme,
            IapProducts.rename,
          ].any(products.containsKey)) ...[
            _SectionTitle(l10n.shopPacks, icon: Icons.card_giftcard_rounded),
            if (product(IapProducts.supporter) case final p?)
              _ProductRow(
                product: p,
                title: iapProductTitle(l10n, p.id),
                blurb: l10n.shopSupporterContents,
                highlight: true,
                owned: snap.supporter,
                onBuy: () => iap.buy(p.id),
              ),
            // A one-time offer with a real 48-hour window: only while it runs.
            if (snap.starterOfferActive)
              if (product(IapProducts.starter) case final p?)
                _ProductRow(
                  product: p,
                  title: iapProductTitle(l10n, p.id),
                  blurb: l10n.gameStarterOfferReward,
                  badge: l10n.shopHoursLeft(snap.starterHoursLeft),
                  onBuy: () => iap.buy(p.id),
                ),
            if (product(IapProducts.neonTheme) case final p?)
              _ProductRow(
                product: p,
                title: iapProductTitle(l10n, p.id),
                blurb: l10n.shopNeonBlurb,
                owned: ref.watch(themeControllerProvider).isUnlocked('neon'),
                onBuy: () => iap.buy(p.id),
              ),
            if (product(IapProducts.rename) case final p?)
              _ProductRow(
                product: p,
                title: iapProductTitle(l10n, p.id),
                blurb: l10n.shopRenameBlurb,
                onBuy: () => iap.buy(p.id),
              ),
            const SizedBox(height: 14),
          ],
          Text(
            l10n.shopSupporterExplainer,
            style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

String _designName(L10n l10n, ShopDesign design) =>
    design.kind == DesignKind.theme
    ? l10n.rewardThemeName(themeName(l10n, design.id))
    : l10n.rewardSkinName(skinName(l10n, design.id));

/// A preview of [design] in the player's current setup: a theme with their
/// skin, a skin on their theme.
class _DesignPreview extends ConsumerWidget {
  const _DesignPreview({required this.design, required this.size});

  final ShopDesign design;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reduced = ref.watch(reducedEffectsProvider);
    final isTheme = design.kind == DesignKind.theme;
    final style = isTheme
        ? ref.watch(activeSkinProvider)
        : skinStyleById(design.id);
    return MiniBoardPreview(
      theme: isTheme ? themeById(design.id) : ref.watch(activeThemeProvider),
      style: style,
      size: size,
      animate: style.isAnimated && !reduced,
    );
  }
}

class _Balance extends StatelessWidget {
  const _Balance({required this.coins, required this.diamonds});

  final int coins;
  final int diamonds;

  @override
  Widget build(BuildContext context) {
    Widget pill(Widget child) => Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: GridColors.gridLine),
        ),
        child: Center(child: FittedBox(child: child)),
      ),
    );
    return Row(
      children: [
        pill(
          CoinAmount(amount: coins, size: 20, color: GridColors.textPrimary),
        ),
        const SizedBox(width: 12),
        pill(
          DiamondAmount(
            amount: diamonds,
            size: 20,
            color: GridColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(
    this.text, {
    this.icon,
    this.diamond = false,
    this.coin = false,
  });

  final String text;
  final IconData? icon;
  final bool diamond;
  final bool coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          if (diamond)
            const DiamondIcon(size: 20)
          else if (coin)
            const CoinIcon(size: 20)
          else if (icon != null)
            Icon(icon, size: 20, color: GridColors.fever),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              upperCaseFor(
                text,
                Localizations.maybeLocaleOf(context)?.languageCode,
              ),
              style: TextStyle(
                color: GridColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: labelTracking(context, 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Text(
        text,
        style: const TextStyle(color: GridColors.textMuted, fontSize: 14),
      ),
    );
  }
}

/// The deal of the day: large preview, the old price struck out, and the
/// time until the next one.
class _DealCard extends StatelessWidget {
  const _DealCard({
    required this.design,
    required this.price,
    required this.owned,
    required this.onBuy,
  });

  final ShopDesign design;
  final int price;
  final bool owned;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final accent = design.kind == DesignKind.theme
        ? themeById(design.id).placed
        : GridColors.fever;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.28),
            GridColors.boardBackground,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.8), width: 1.5),
      ),
      child: Row(
        children: [
          _DesignPreview(design: design, size: 104),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: GridColors.fever,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '-$kDailyDealDiscountPercent%',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _designName(l10n, design),
                  style: const TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                _DealCountdown(),
                const SizedBox(height: 10),
                if (owned)
                  Text(
                    l10n.designsOwned,
                    style: const TextStyle(color: GridColors.placed),
                  )
                else
                  FilledButton(
                    onPressed: onBuy,
                    child: _PriceLabel(
                      cost: kRotatingDesignPrice,
                      price: price,
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

/// "New deal in 5h 12m", refreshed every half minute.
class _DealCountdown extends ConsumerStatefulWidget {
  @override
  ConsumerState<_DealCountdown> createState() => _DealCountdownState();
}

class _DealCountdownState extends ConsumerState<_DealCountdown> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => mounted ? setState(() {}) : null,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final left = untilNextDeal(ref.read(gameCalendarProvider)());
    return Text(
      L10n.of(context).shopNewDealIn(formatRemaining(left)),
      style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
    );
  }
}

/// A diamond price, the old one struck out when it is a deal.
class _PriceLabel extends StatelessWidget {
  const _PriceLabel({required this.cost, required this.price});

  final int cost;
  final int price;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DiamondIcon(size: 16),
          const SizedBox(width: 5),
          if (price < cost) ...[
            Text(
              '$cost',
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            '$price',
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

/// A row of design cards that scrolls sideways.
class _DesignRow extends StatelessWidget {
  const _DesignRow({
    required this.designs,
    required this.now,
    required this.owns,
    required this.onBuy,
  });

  final List<ShopDesign> designs;
  final DateTime now;
  final bool Function(ShopDesign) owns;
  final void Function(ShopDesign, int) onBuy;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final deal = dailyDeal(now);
    final scale = MediaQuery.textScalerOf(context).scale(1);
    return SizedBox(
      height: 190 + 30 * (scale - 1).clamp(0.0, 1.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: designs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final d = designs[i];
          final cost = d.kind == DesignKind.skin
              ? kSkinCatalog.firstWhere((s) => s.id == d.id).cost
              : kThemeCatalog.firstWhere((e) => e.id == d.id).cost;
          final price = kRotatingDesigns.contains(d)
              ? designPrice(d, now)
              : cost;
          final owned = owns(d);
          return Container(
            width: 132,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: GridColors.boardBackground,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: d == deal ? GridColors.fever : GridColors.gridLine,
                width: d == deal ? 1.5 : 1,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(child: _DesignPreview(design: d, size: 90)),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      d.kind == DesignKind.theme
                          ? themeName(l10n, d.id)
                          : skinName(l10n, d.id),
                      style: const TextStyle(
                        color: GridColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: owned
                      ? Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              l10n.designsOwned,
                              style: const TextStyle(color: GridColors.placed),
                            ),
                          ),
                        )
                      : FilledButton(
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onPressed: () => onBuy(d, price),
                          child: _PriceLabel(cost: cost, price: price),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// A store product with its own symbol, our name for it, a line on what it
/// is, and the store's price.
class _ProductRow extends StatelessWidget {
  const _ProductRow({
    required this.product,
    required this.title,
    required this.blurb,
    required this.onBuy,
    this.badge,
    this.owned = false,
    this.highlight = false,
  });

  final ShopProduct product;
  final String title;
  final String blurb;
  final VoidCallback onBuy;
  final String? badge;
  final bool owned;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: highlight
                ? const Color(0xFFFF6FB0).withValues(alpha: 0.7)
                : GridColors.gridLine,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/product_icons/${product.id}.png',
                width: 52,
                height: 52,
                errorBuilder: (_, _, _) => const SizedBox.square(
                  dimension: 52,
                  child: Center(child: CoinIcon(size: 28)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (badge != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: GridColors.fever.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badge!,
                          style: const TextStyle(
                            color: GridColors.fever,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: GridColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    blurb,
                    style: const TextStyle(
                      color: GridColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (owned)
              Text(
                l10n.designsOwned,
                style: const TextStyle(color: GridColors.placed),
              )
            else
              FilledButton(onPressed: onBuy, child: Text(product.price)),
          ],
        ),
      ),
    );
  }
}

/// Gold → diamond exchange. Deliberately steep so it takes real playtime.
class _ExchangeCard extends ConsumerWidget {
  const _ExchangeCard({required this.coins});

  final int coins;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> exchange(int diamonds) async {
      final ok = await ref
          .read(gameControllerProvider.notifier)
          .exchangeGoldForDiamonds(diamonds);
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.of(context).skinsNotEnoughGold)),
        );
      }
    }

    // Three equal tiles rather than tonal buttons: a two-line child made the
    // stadium-shaped buttons round, and the gold price in muted grey on teal
    // could hardly be read.
    Widget option(int diamonds) {
      final cost = Economy.goldCostForDiamonds(diamonds);
      final canAfford = coins >= cost;
      const shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      );
      return Expanded(
        child: Opacity(
          opacity: canAfford ? 1 : 0.4,
          child: Material(
            color: GridColors.background,
            shape: shape.copyWith(
              side: const BorderSide(color: GridColors.gridLine),
            ),
            child: InkWell(
              customBorder: shape,
              onTap: canAfford ? () => exchange(diamonds) : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: DiamondAmount(
                        amount: diamonds,
                        size: 16,
                        color: GridColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CoinAmount(
                        amount: cost,
                        size: 13,
                        color: GridColors.fever,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CoinIcon(size: 18),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: GridColors.textMuted,
              ),
              const DiamondIcon(size: 18),
              const SizedBox(width: 8),
              // Flexible: at a large system font "Gold eintauschen" ran 36 px
              // past the card.
              Flexible(
                child: Text(
                  L10n.of(context).skinsExchangeGold,
                  style: const TextStyle(
                    color: GridColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            L10n.of(context).skinsExchangeHint(Economy.goldPerDiamond),
            style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              option(1),
              const SizedBox(width: 8),
              option(10),
              const SizedBox(width: 8),
              option(50),
            ],
          ),
        ],
      ),
    );
  }
}
