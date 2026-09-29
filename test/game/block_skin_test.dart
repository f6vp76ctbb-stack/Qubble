import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';

void main() {
  test('catalog has unique ids and a free default', () {
    final ids = kSkinCatalog.map((s) => s.id).toSet();
    expect(ids.length, kSkinCatalog.length);
    final classic = kSkinCatalog.firstWhere((s) => s.id == kDefaultSkinId);
    expect(classic.cost, 0);
  });

  test('paid skins have positive costs; supporter skins are never sold', () {
    for (final s in kSkinCatalog.where(
      (s) =>
          s.id != kDefaultSkinId && !s.supporterOnly && s.achievementId == null,
    )) {
      expect(s.cost, greaterThan(0));
    }
    // Supporter-only skins exist and carry no coin price.
    final crystal = kSkinCatalog.singleWhere((s) => s.id == 'crystal');
    expect(crystal.supporterOnly, isTrue);
    expect(crystal.cost, 0);
  });

  test('skinStyleById resolves known ids and falls back for unknown', () {
    expect(skinStyleById('gradient'), BlockSkinStyle.gradient);
    expect(skinStyleById('nope'), BlockSkinStyle.solid); // default
  });

  test('achievement skins can never be bought', () {
    final rewards = kSkinCatalog.where((s) => s.achievementId != null);
    expect(rewards, hasLength(8));
    for (final s in rewards) {
      expect(s.cost, 0, reason: s.id);
      expect(s.supporterOnly, isFalse, reason: s.id);
      expect(s.isPurchasable, isFalse, reason: s.id);
    }
    expect(
      kSkinCatalog.singleWhere((s) => s.id == 'gradient').isPurchasable,
      isTrue,
    );
    expect(
      kSkinCatalog.singleWhere((s) => s.id == 'crystal').isPurchasable,
      isFalse,
    );
  });

  test('the animated skins are the achievement rewards and the three shop '
      'skins, each in its own style', () {
    final animated = kSkinCatalog.where((s) => s.style.isAnimated).toList();
    final shop = kSkinCatalog
        .where((s) => s.style.isAnimated && s.achievementId == null)
        .toList();
    expect(
      animated.where((s) => s.achievementId != null),
      hasLength(8),
    );
    // Owner, 28.09.2026: three animated skins for 150 diamonds each.
    expect(shop.map((s) => s.id), ['liquid', 'fizz', 'plasma']);
    for (final s in shop) {
      expect(s.isPurchasable, isTrue, reason: s.id);
      expect(s.currency, SkinCurrency.diamond, reason: s.id);
      expect(s.cost, 150, reason: s.id);
    }
    expect(animated.map((s) => s.style).toSet(), hasLength(animated.length));
  });

  test('the achievement skins stay out of every shop', () {
    for (final s in kSkinCatalog.where((s) => s.achievementId != null)) {
      expect(s.isPurchasable, isFalse, reason: s.id);
    }
  });
}
