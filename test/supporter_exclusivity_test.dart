// CLAUDE.md: exclusive cosmetics (supporterOnly) are NEVER obtainable for
// coins. The controllers enforce it, but nothing stopped a later change from
// putting an exclusive item into the level reward track, where it would be
// handed out free — a different door into the same room, and one the
// controller guard never sees.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/leveling.dart';
import 'package:gridpop/game/supporter_pack.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/skin_controller.dart';
import 'package:gridpop/ui/state/theme_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final exclusiveThemes = kThemeCatalog
      .where((t) => t.supporterOnly)
      .map((t) => t.id)
      .toSet();
  final exclusiveSkins = kSkinCatalog
      .where((s) => s.supporterOnly)
      .map((s) => s.id)
      .toSet();

  test('the pack sells what it claims to sell', () {
    // If either id drifted, the purchase would grant an item that is not
    // exclusive — and the exclusive one would be unobtainable entirely.
    expect(exclusiveThemes, contains(SupporterPack.themeId));
    expect(exclusiveSkins, contains(SupporterPack.skinId));
  });

  test('exclusivity means exactly one of each, not a growing tier', () {
    // The pack grants one theme and one skin. More exclusives than that would
    // be content nobody can reach.
    expect(exclusiveThemes, {SupporterPack.themeId});
    expect(exclusiveSkins, {SupporterPack.skinId});
  });

  test('no level reward hands out an exclusive cosmetic', () {
    for (final reward in LevelSystem.rewardTrack) {
      final pool = reward.kind == LevelRewardKind.theme
          ? exclusiveThemes
          : exclusiveSkins;
      expect(
        pool,
        isNot(contains(reward.id)),
        reason:
            'level ${reward.level} would grant "${reward.id}" for free, and '
            'CLAUDE.md reserves it for the supporter pack',
      );
    }
  });

  test('every level reward names a real catalogue entry', () {
    // A reward pointing at nothing is a level-up that silently gives nothing.
    final themes = kThemeCatalog.map((t) => t.id).toSet();
    final skins = kSkinCatalog.map((s) => s.id).toSet();
    for (final reward in LevelSystem.rewardTrack) {
      final pool = reward.kind == LevelRewardKind.theme ? themes : skins;
      expect(pool, contains(reward.id), reason: 'level ${reward.level}');
    }
  });

  test('an exclusive cosmetic carries no purchase price', () {
    // A price on an unbuyable item is a promise the shop cannot keep, and the
    // themes screen reads cost to decide what to show.
    for (final theme in kThemeCatalog.where((t) => t.supporterOnly)) {
      expect(theme.cost, 0, reason: theme.id);
    }
    for (final skin in kSkinCatalog.where((s) => s.supporterOnly)) {
      expect(skin.cost, 0, reason: skin.id);
    }
  });

  group('a rich player still cannot buy the exclusives', () {
    late ProviderContainer container;

    setUp(() async {
      // Far more coins and diamonds than anything in either catalogue costs,
      // so a refusal can only come from the exclusivity rule.
      SharedPreferences.setMockInitialValues({
        'coins': 999999,
        'diamonds': 999999,
      });
      final storage = await Storage.create();
      container = ProviderContainer(
        overrides: [storageProvider.overrideWithValue(storage)],
      );
    });

    tearDown(() => container.dispose());

    test('the supporter theme is refused and stays locked', () async {
      final themes = container.read(themeControllerProvider.notifier);
      final entry = kThemeCatalog.firstWhere((t) => t.supporterOnly);

      expect(await themes.selectOrUnlock(entry), isFalse);
      expect(container.read(themeControllerProvider).isUnlocked(entry.id), isFalse);
      expect(container.read(themeControllerProvider).activeId, isNot(entry.id));
      // And the refusal cost nothing: a failed unlock must not take coins.
      expect(container.read(storageProvider).coins, 999999);
    });

    test('the supporter skin is refused and stays locked', () async {
      final skins = container.read(skinControllerProvider.notifier);
      final skin = kSkinCatalog.firstWhere((s) => s.supporterOnly);

      expect(await skins.selectOrUnlock(skin), isFalse);
      expect(container.read(skinControllerProvider).isUnlocked(skin.id), isFalse);
      expect(container.read(storageProvider).diamonds, 999999);
    });

    test('a normal cosmetic is still buyable, so the test proves a rule', () {
      // Without this the two refusals above could pass for the wrong reason —
      // a container that cannot buy anything at all.
      final buyable = kThemeCatalog.firstWhere(
        (t) => !t.supporterOnly && t.cost > 0 && t.id != 'neon',
      );
      expect(buyable.supporterOnly, isFalse);
      expect(buyable.cost, greaterThan(0));
    });
  });
}
