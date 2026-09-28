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

  test('exactly the achievement skins are animated, each in its own style',
      () {
    final animated = kSkinCatalog.where((s) => s.style.isAnimated).toList();
    expect(
      animated.map((s) => s.id).toSet(),
      kSkinCatalog
          .where((s) => s.achievementId != null)
          .map((s) => s.id)
          .toSet(),
    );
    expect(animated.map((s) => s.style).toSet(), hasLength(animated.length));
  });
}
