/// Themes and block skins in one place (owner, 28.09.2026), with the player's
/// setup as a live stage at the top: tapping a theme or a skin shows it there
/// straight away — owned ones are equipped, locked ones are previewed with
/// what it takes to get them.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/achievements.dart';
import '../../game/block_skin.dart';
import '../../game/design_offer.dart';
import '../../game/seasonal.dart';
import '../../l10n/app_localizations.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/settings_controller.dart';
import '../state/skin_controller.dart';
import '../state/theme_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import '../widgets/mini_board_preview.dart';
import '../widgets/screen_title.dart';
import 'shop_screen.dart';

class DesignsScreen extends ConsumerStatefulWidget {
  const DesignsScreen({super.key, this.initialTab = 0});

  /// 0 = themes, 1 = skins.
  final int initialTab;

  @override
  ConsumerState<DesignsScreen> createState() => _DesignsScreenState();
}

class _DesignsScreenState extends ConsumerState<DesignsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(
    length: 2,
    vsync: this,
    initialIndex: widget.initialTab,
  );

  /// What the stage shows. Null means "what is equipped".
  String? _previewTheme;
  String? _previewSkin;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  ThemeEntry get _stageTheme {
    final id = _previewTheme ?? ref.read(themeControllerProvider).activeId;
    return kThemeCatalog.firstWhere(
      (e) => e.id == id,
      orElse: () => kThemeCatalog.first,
    );
  }

  BlockSkin get _stageSkin {
    final id = _previewSkin ?? ref.read(skinControllerProvider).activeId;
    return kSkinCatalog.firstWhere(
      (s) => s.id == id,
      orElse: () => kSkinCatalog.first,
    );
  }

  Future<void> _tapTheme(ThemeEntry entry) async {
    if (ref.read(themeControllerProvider).isUnlocked(entry.id)) {
      await ref.read(themeControllerProvider.notifier).selectOrUnlock(entry);
      setState(() => _previewTheme = null);
    } else {
      setState(() => _previewTheme = entry.id);
    }
  }

  Future<void> _tapSkin(BlockSkin skin) async {
    if (ref.read(skinControllerProvider).isUnlocked(skin.id)) {
      await ref.read(skinControllerProvider.notifier).selectOrUnlock(skin);
      setState(() => _previewSkin = null);
    } else {
      setState(() => _previewSkin = skin.id);
    }
  }

  /// The price a locked design costs right now: the deal of the day is
  /// cheaper ([designPrice]).
  int _priceOf(DesignKind kind, String id, int catalogCost) {
    final design = ShopDesign(kind, id);
    if (!kRotatingDesigns.contains(design)) return catalogCost;
    return designPrice(design, ref.read(gameCalendarProvider)());
  }

  Future<void> _buyPreview() async {
    final l10n = L10n.of(context);
    final theme = _previewTheme;
    final skin = _previewSkin;
    bool ok;
    SkinCurrency currency;
    if (theme != null) {
      final entry = _stageTheme;
      currency = entry.currency;
      ok = await ref
          .read(themeControllerProvider.notifier)
          .selectOrUnlock(
            entry,
            price: _priceOf(DesignKind.theme, entry.id, entry.cost),
          );
      if (ok) setState(() => _previewTheme = null);
    } else if (skin != null) {
      final s = _stageSkin;
      currency = s.currency;
      ok = await ref
          .read(skinControllerProvider.notifier)
          .selectOrUnlock(s, price: _priceOf(DesignKind.skin, s.id, s.cost));
      if (ok) setState(() => _previewSkin = null);
    } else {
      return;
    }
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            currency == SkinCurrency.diamond
                ? l10n.designsNotEnoughDiamonds
                : l10n.skinsNotEnoughCoins,
          ),
        ),
      );
    }
  }

  /// A seasonal design outside its month (lib/game/seasonal.dart).
  static bool _outOfSeason(int? saleMonth, DateTime now) =>
      !forSaleIn(saleMonth, now);

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final themeState = ref.watch(themeControllerProvider);
    final skinState = ref.watch(skinControllerProvider);
    final snap = ref.watch(gameControllerProvider);
    final reduced = ref.watch(reducedEffectsProvider);
    final stageTheme = _stageTheme;
    final stageSkin = _stageSkin;
    final t = stageTheme.theme;
    final now = ref.watch(gameCalendarProvider)();

    return Scaffold(
      // The whole screen wears the theme on stage, so a theme is seen the way
      // it will be played, not as a swatch.
      backgroundColor: t.background,
      appBar: AppBar(
        title: ScreenTitle(l10n.designsTitle),
        backgroundColor: t.background,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: FittedBox(
                child: Row(
                  children: [
                    CoinAmount(
                      amount: snap.coins,
                      size: 15,
                      color: GridColors.textPrimary,
                    ),
                    const SizedBox(width: 10),
                    DiamondAmount(
                      amount: snap.diamonds,
                      size: 15,
                      color: GridColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: t.placed,
          labelColor: GridColors.textPrimary,
          unselectedLabelColor: GridColors.textMuted,
          tabs: [
            Tab(text: l10n.themesTitle),
            Tab(text: l10n.skinsTitle),
          ],
        ),
      ),
      body: Column(
        children: [
          _Stage(
            theme: stageTheme,
            skin: stageSkin,
            animate: stageSkin.style.isAnimated && !reduced,
            previewing: _previewTheme != null || _previewSkin != null,
          ),
          if (_previewTheme != null || _previewSkin != null)
            _PreviewBar(
              kind: _previewTheme != null ? DesignKind.theme : DesignKind.skin,
              theme: stageTheme,
              skin: stageSkin,
              outOfSeason: _previewTheme != null
                  ? _outOfSeason(stageTheme.saleMonth, now)
                  : _outOfSeason(stageSkin.saleMonth, now),
              price: _previewTheme != null
                  ? _priceOf(DesignKind.theme, stageTheme.id, stageTheme.cost)
                  : _priceOf(DesignKind.skin, stageSkin.id, stageSkin.cost),
              coins: snap.coins,
              diamonds: snap.diamonds,
              onBuy: _buyPreview,
              onBack: () => setState(() {
                _previewTheme = null;
                _previewSkin = null;
              }),
            ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _Grid(
                  children: [
                    for (final entry in kThemeCatalog)
                      _DesignCard(
                        key: ValueKey('theme-${entry.id}'),
                        preview: MiniBoardPreview(
                          theme: entry.theme,
                          style: skinStyleById(skinState.activeId),
                          size: 72,
                        ),
                        name: themeName(l10n, entry.id),
                        background: entry.theme.boardBackground,
                        accent: entry.theme.placed,
                        active: themeState.activeId == entry.id,
                        onStage: stageTheme.id == entry.id,
                        status: _status(
                          l10n,
                          owned: themeState.isUnlocked(entry.id),
                          active: themeState.activeId == entry.id,
                          supporterOnly: entry.supporterOnly,
                          achievementId: null,
                          outOfSeason: _outOfSeason(entry.saleMonth, now),
                          currency: entry.currency,
                          cost: entry.cost,
                          price: _priceOf(
                            DesignKind.theme,
                            entry.id,
                            entry.cost,
                          ),
                        ),
                        onTap: () => _tapTheme(entry),
                      ),
                  ],
                ),
                _Grid(
                  children: [
                    for (final skin in kSkinCatalog)
                      _DesignCard(
                        key: ValueKey('skin-${skin.id}'),
                        preview: MiniBoardPreview(
                          theme: themeById(themeState.activeId),
                          style: skin.style,
                          size: 72,
                          animate: skin.style.isAnimated && !reduced,
                        ),
                        name: skinName(l10n, skin.id),
                        background: GridColors.boardBackground,
                        accent: t.placed,
                        active: skinState.activeId == skin.id,
                        onStage: stageSkin.id == skin.id,
                        status: _status(
                          l10n,
                          owned: skinState.isUnlocked(skin.id),
                          active: skinState.activeId == skin.id,
                          supporterOnly: skin.supporterOnly,
                          achievementId: skin.achievementId,
                          outOfSeason: _outOfSeason(skin.saleMonth, now),
                          currency: skin.currency,
                          cost: skin.cost,
                          price: _priceOf(DesignKind.skin, skin.id, skin.cost),
                        ),
                        onTap: () => _tapSkin(skin),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _status(
    L10n l10n, {
    required bool owned,
    required bool active,
    required bool supporterOnly,
    required String? achievementId,
    required bool outOfSeason,
    required SkinCurrency currency,
    required int cost,
    required int price,
  }) {
    const muted = TextStyle(color: GridColors.textMuted, fontSize: 12);
    if (active) {
      return Text(
        l10n.commonActive,
        style: muted.copyWith(color: GridColors.placed),
      );
    }
    if (owned) return Text(l10n.designsOwned, style: muted);
    if (achievementId != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events_rounded, size: 13, color: GridColors.fever),
          const SizedBox(width: 3),
          Text(l10n.designsAchievementOnly, style: muted),
        ],
      );
    }
    if (outOfSeason) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.nightlight_round, size: 13, color: GridColors.fever),
          const SizedBox(width: 3),
          Flexible(child: Text(l10n.designsBackInOctober, style: muted)),
        ],
      );
    }
    if (supporterOnly) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite_rounded, size: 13, color: Color(0xFFFF6FB0)),
          const SizedBox(width: 3),
          Text(l10n.designsSupporterOnly, style: muted),
        ],
      );
    }
    return _Price(currency: currency, cost: cost, price: price, size: 13);
  }
}

/// A price with its currency icon; a deal shows the old price struck out.
class _Price extends StatelessWidget {
  const _Price({
    required this.currency,
    required this.cost,
    required this.price,
    this.size = 14,
  });

  final SkinCurrency currency;
  final int cost;
  final int price;
  final double size;

  @override
  Widget build(BuildContext context) {
    final icon = currency == SkinCurrency.diamond
        ? DiamondIcon(size: size)
        : CoinIcon(size: size);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 3),
          if (price < cost) ...[
            Text(
              '$cost',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: GridColors.textMuted,
                fontSize: size - 1,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            '$price',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: price < cost ? GridColors.fever : GridColors.textPrimary,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// The player's setup — or the design being previewed — shown large.
class _Stage extends StatelessWidget {
  const _Stage({
    required this.theme,
    required this.skin,
    required this.animate,
    required this.previewing,
  });

  final ThemeEntry theme;
  final BlockSkin skin;
  final bool animate;
  final bool previewing;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final height = MediaQuery.sizeOf(context).height;
    // A third of a tall phone; less on a short one so the grid keeps room.
    final size = (height * 0.26).clamp(120.0, 260.0);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme.theme.placed.withValues(alpha: 0.25),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: MiniBoardPreview(
                  theme: theme.theme,
                  style: skin.style,
                  size: size,
                  animate: animate,
                ),
              ),
              if (previewing)
                PositionedDirectional(
                  top: -8,
                  end: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: GridColors.fever,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      l10n.designsPreview,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${themeName(l10n, theme.id)} · ${skinName(l10n, skin.id)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GridColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Under the stage while a locked design is previewed: what it takes.
class _PreviewBar extends StatelessWidget {
  const _PreviewBar({
    required this.kind,
    required this.theme,
    required this.skin,
    required this.price,
    required this.coins,
    required this.diamonds,
    required this.onBuy,
    required this.onBack,
    this.outOfSeason = false,
  });

  final DesignKind kind;

  /// A seasonal design outside its month: it can be looked at, not bought.
  final bool outOfSeason;
  final ThemeEntry theme;
  final BlockSkin skin;
  final int price;
  final int coins;
  final int diamonds;
  final VoidCallback onBuy;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final isTheme = kind == DesignKind.theme;
    final supporterOnly = isTheme ? theme.supporterOnly : skin.supporterOnly;
    final achievementId = isTheme ? null : skin.achievementId;
    final currency = isTheme ? theme.currency : skin.currency;
    final cost = isTheme ? theme.cost : skin.cost;
    final affordable = currency == SkinCurrency.diamond
        ? diamonds >= price
        : coins >= price;

    Widget action;
    if (achievementId != null) {
      action = Text(
        l10n.skinsAchievementReward(
          Achievements.byId(achievementId).title(l10n),
        ),
        style: const TextStyle(color: GridColors.textMuted),
      );
    } else if (supporterOnly) {
      action = Text(
        l10n.themesSupporterOnly,
        style: const TextStyle(color: GridColors.textMuted),
      );
    } else if (outOfSeason) {
      action = Text(
        l10n.designsBackInOctober,
        style: const TextStyle(color: GridColors.textMuted),
      );
    } else if (!affordable && currency == SkinCurrency.diamond) {
      action = FilledButton.icon(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => const ShopScreen()),
        ),
        icon: const DiamondIcon(size: 16),
        label: Text(l10n.designsGetDiamonds),
      );
    } else {
      action = FilledButton(
        onPressed: affordable ? onBuy : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(l10n.commonBuy)),
            const SizedBox(width: 8),
            _Price(currency: currency, cost: cost, price: price),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          IconButton(
            tooltip: l10n.commonCancel,
            onPressed: onBack,
            icon: const Icon(Icons.close_rounded, color: GridColors.textMuted),
          ),
          Expanded(
            child: Align(alignment: AlignmentDirectional.centerEnd, child: action),
          ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 520 ? 4 : 3;
        return GridView.count(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
          crossAxisCount: columns,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.72,
          children: children,
        );
      },
    );
  }
}

class _DesignCard extends StatelessWidget {
  const _DesignCard({
    super.key,
    required this.preview,
    required this.name,
    required this.background,
    required this.accent,
    required this.active,
    required this.onStage,
    required this.status,
    required this.onTap,
  });

  final Widget preview;
  final String name;
  final Color background;
  final Color accent;
  final bool active;

  /// Shown on the stage right now (equipped or previewed).
  final bool onStage;
  final Widget status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: onStage ? accent : GridColors.gridLine,
            width: onStage ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FittedBox(
                child: Stack(
                  children: [
                    preview,
                    if (active)
                      PositionedDirectional(
                        top: 2,
                        end: 2,
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 18,
                          color: accent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            // A long name or a large system font shrinks rather than being
            // cut off: the card's height is fixed by the grid.
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
