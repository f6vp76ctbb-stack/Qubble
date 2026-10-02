/// Riverpod controller for the swappable board themes.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/block_skin.dart';
import '../../services/storage.dart';
import '../theme.dart';
import 'game_controller.dart';

@immutable
class ThemeState {
  const ThemeState({required this.activeId, required this.unlocked});

  final String activeId;
  final Set<String> unlocked;

  bool isUnlocked(String id) => unlocked.contains(id);
}

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeState>((ref) {
      return ThemeController(ref.read(storageProvider), ref);
    });

/// The currently active board palette, derived from the active id.
final activeThemeProvider = Provider<GameTheme>((ref) {
  return themeById(ref.watch(themeControllerProvider).activeId);
});

class ThemeController extends StateNotifier<ThemeState> {
  ThemeController(this._storage, this._ref)
    : super(
        ThemeState(
          activeId: _storage.activeTheme,
          unlocked: _storage.unlockedThemes,
        ),
      );

  final Storage _storage;
  final Ref _ref;

  /// Equips an already-owned theme.
  Future<void> setActive(String id) async {
    if (!state.isUnlocked(id)) return;
    await _storage.setActiveTheme(id);
    state = ThemeState(activeId: id, unlocked: state.unlocked);
  }

  /// Unlocks a theme for free (e.g. from a bundle/IAP), without spending coins.
  Future<void> grantTheme(String id) async {
    if (state.isUnlocked(id)) return;
    final unlocked = {...state.unlocked, id};
    await _storage.setUnlockedThemes(unlocked);
    state = ThemeState(activeId: state.activeId, unlocked: unlocked);
  }

  /// Buys (if needed) and equips [entry]. Returns false if unaffordable.
  /// Supporter-only themes can never be bought with coins.
  ///
  /// [price] overrides the catalog price — the deal of the day
  /// (`designPrice` in lib/game/design_offer.dart) is cheaper.
  Future<bool> selectOrUnlock(ThemeEntry entry, {int? price}) async {
    if (state.isUnlocked(entry.id)) {
      await setActive(entry.id);
      return true;
    }
    // Supporter themes never; seasonal ones only in their month.
    if (!entry.isForSaleAt(_ref.read(gameCalendarProvider)())) return false;
    final game = _ref.read(gameControllerProvider.notifier);
    final cost = price ?? entry.cost;
    final paid = entry.currency == SkinCurrency.diamond
        ? await game.trySpendDiamonds(cost)
        : await game.trySpendCoins(cost);
    if (!paid) return false;

    final unlocked = {...state.unlocked, entry.id};
    await _storage.setUnlockedThemes(unlocked);
    await _storage.setActiveTheme(entry.id);
    state = ThemeState(activeId: entry.id, unlocked: unlocked);
    return true;
  }
}
