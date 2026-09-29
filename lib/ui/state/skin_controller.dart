/// Riverpod controller for unlockable block skins (mirrors the theme system).
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/block_skin.dart';
import '../../services/storage.dart';
import 'game_controller.dart';

@immutable
class SkinState {
  const SkinState({required this.activeId, required this.unlocked});

  final String activeId;
  final Set<String> unlocked;

  bool isUnlocked(String id) => unlocked.contains(id);
}

final skinControllerProvider =
    StateNotifierProvider<SkinController, SkinState>((ref) {
  return SkinController(ref.read(storageProvider), ref);
});

/// The active block-skin style for painters.
final activeSkinProvider = Provider<BlockSkinStyle>((ref) {
  return skinStyleById(ref.watch(skinControllerProvider).activeId);
});

class SkinController extends StateNotifier<SkinState> {
  SkinController(this._storage, this._ref)
      : super(SkinState(
          activeId: _storage.activeSkin,
          unlocked: _storage.unlockedSkins,
        ));

  final Storage _storage;
  final Ref _ref;

  Future<void> setActive(String id) async {
    if (!state.isUnlocked(id)) return;
    await _storage.setActiveSkin(id);
    state = SkinState(activeId: id, unlocked: state.unlocked);
  }

  /// Unlocks a skin for free (e.g. from a bundle/IAP), without spending coins.
  Future<void> grantSkin(String id) async {
    if (state.isUnlocked(id)) return;
    final unlocked = {...state.unlocked, id};
    await _storage.setUnlockedSkins(unlocked);
    state = SkinState(activeId: state.activeId, unlocked: unlocked);
  }

  /// Buys (if needed) and equips [skin]. Returns false if unaffordable.
  /// Gold skins cost coins, diamond skins cost diamonds; supporter-only and
  /// achievement skins can never be bought — the latter cost 0, so without
  /// this check a tap would have handed them out for free.
  ///
  /// [price] overrides the catalog price — the deal of the day
  /// (`designPrice` in lib/game/design_offer.dart) is cheaper.
  Future<bool> selectOrUnlock(BlockSkin skin, {int? price}) async {
    if (state.isUnlocked(skin.id)) {
      await setActive(skin.id);
      return true;
    }
    if (!skin.isPurchasable) return false;
    final game = _ref.read(gameControllerProvider.notifier);
    final cost = price ?? skin.cost;
    final paid = skin.currency == SkinCurrency.diamond
        ? await game.trySpendDiamonds(cost)
        : await game.trySpendCoins(cost);
    if (!paid) return false;

    final unlocked = {...state.unlocked, skin.id};
    await _storage.setUnlockedSkins(unlocked);
    await _storage.setActiveSkin(skin.id);
    state = SkinState(activeId: skin.id, unlocked: unlocked);
    return true;
  }
}
