/// Riverpod controllers for the accessories on the blocks and the
/// explosions (owner, 30.09.2026): two small diamond catalogs with a free
/// default each, bought and equipped like the skins.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/accessory.dart';
import '../../game/burst_style.dart';
import '../../services/storage.dart';
import 'game_controller.dart';

enum CosmeticKind {
  accessory(kNoAccessoryId),
  burst(kDefaultBurstId);

  const CosmeticKind(this.defaultId);

  /// The free entry everyone owns.
  final String defaultId;

  /// Diamonds for [id]; null for an id the catalog does not know.
  int? costOf(String id) {
    switch (this) {
      case CosmeticKind.accessory:
        for (final a in kAccessoryCatalog) {
          if (a.id == id) return a.cost;
        }
      case CosmeticKind.burst:
        for (final b in kBurstCatalog) {
          if (b.id == id) return b.cost;
        }
    }
    return null;
  }
}

@immutable
class CosmeticState {
  const CosmeticState({required this.activeId, required this.unlocked});

  final String activeId;
  final Set<String> unlocked;

  bool isUnlocked(String id) => unlocked.contains(id);
}

final accessoryControllerProvider =
    StateNotifierProvider<CosmeticController, CosmeticState>((ref) {
      return CosmeticController(
        ref.read(storageProvider),
        ref,
        CosmeticKind.accessory,
      );
    });

final burstControllerProvider =
    StateNotifierProvider<CosmeticController, CosmeticState>((ref) {
      return CosmeticController(
        ref.read(storageProvider),
        ref,
        CosmeticKind.burst,
      );
    });

/// The accessory the painters draw.
final activeAccessoryProvider = Provider<AccessoryStyle>((ref) {
  return accessoryStyleById(ref.watch(accessoryControllerProvider).activeId);
});

/// The explosion the clear burst plays.
final activeBurstProvider = Provider<BurstStyle>((ref) {
  return burstStyleById(ref.watch(burstControllerProvider).activeId);
});

class CosmeticController extends StateNotifier<CosmeticState> {
  CosmeticController(this._storage, this._ref, this.kind)
    : super(
        CosmeticState(
          activeId: _storage.activeCosmetic(kind.name, kind.defaultId),
          unlocked: _storage.unlockedCosmetics(kind.name, kind.defaultId),
        ),
      );

  final Storage _storage;
  final Ref _ref;
  final CosmeticKind kind;

  /// Equips an owned [id].
  Future<void> setActive(String id) async {
    if (!state.isUnlocked(id)) return;
    await _storage.setActiveCosmetic(kind.name, id);
    state = CosmeticState(activeId: id, unlocked: state.unlocked);
  }

  /// Equips [id], buying it for diamonds first if needed. False when it is
  /// unknown or unaffordable; nothing is spent then.
  Future<bool> selectOrUnlock(String id) async {
    if (state.isUnlocked(id)) {
      await setActive(id);
      return true;
    }
    final cost = kind.costOf(id);
    if (cost == null || cost <= 0) return false;
    final paid = await _ref
        .read(gameControllerProvider.notifier)
        .trySpendDiamonds(cost);
    if (!paid) return false;
    final unlocked = {...state.unlocked, id};
    await _storage.setUnlockedCosmetics(kind.name, unlocked);
    await _storage.setActiveCosmetic(kind.name, id);
    state = CosmeticState(activeId: id, unlocked: unlocked);
    return true;
  }
}
