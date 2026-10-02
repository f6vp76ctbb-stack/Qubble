// The Halloween designs can be bought in October only; one bought then stays
// the player's all year (owner, 30.09.2026).
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/seasonal.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/skin_controller.dart';
import 'package:gridpop/ui/state/theme_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container(
  DateTime now,
  Map<String, Object> prefs,
) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      hapticsProvider.overrideWithValue(Haptics(enabled: false)),
      audioProvider.overrideWithValue(SilentAudio()),
      gameCalendarProvider.overrideWithValue(() => now),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

final _ghost = kSkinCatalog.singleWhere((s) => s.id == kHalloweenSkinId);
final _pumpkin = kThemeCatalog.singleWhere((t) => t.id == kHalloweenThemeId);
final _october = DateTime(2026, 10, 20, 18);
final _november = DateTime(2026, 11, 2, 18);

void main() {
  test('in October both can be bought for diamonds', () async {
    final c = await _container(_october, {'diamonds': 500});
    expect(
      await c.read(skinControllerProvider.notifier).selectOrUnlock(_ghost),
      isTrue,
    );
    expect(
      await c.read(themeControllerProvider.notifier).selectOrUnlock(_pumpkin),
      isTrue,
    );
    expect(c.read(storageProvider).diamonds, 500 - _ghost.cost - _pumpkin.cost);
    expect(c.read(skinControllerProvider).activeId, kHalloweenSkinId);
    expect(c.read(themeControllerProvider).activeId, kHalloweenThemeId);
  });

  test('after October neither can, and nothing is spent', () async {
    final c = await _container(_november, {'diamonds': 500});
    expect(
      await c.read(skinControllerProvider.notifier).selectOrUnlock(_ghost),
      isFalse,
    );
    expect(
      await c.read(themeControllerProvider.notifier).selectOrUnlock(_pumpkin),
      isFalse,
    );
    expect(c.read(storageProvider).diamonds, 500);
    expect(
      c.read(skinControllerProvider).isUnlocked(kHalloweenSkinId),
      isFalse,
    );
  });

  test('one bought in October stays usable in November', () async {
    final c = await _container(_november, {
      'unlockedSkins': ['classic', kHalloweenSkinId],
      'unlockedThemes': ['classic', kHalloweenThemeId],
    });
    expect(
      await c.read(skinControllerProvider.notifier).selectOrUnlock(_ghost),
      isTrue,
    );
    expect(
      await c.read(themeControllerProvider.notifier).selectOrUnlock(_pumpkin),
      isTrue,
    );
    expect(c.read(skinControllerProvider).activeId, kHalloweenSkinId);
    expect(c.read(themeControllerProvider).activeId, kHalloweenThemeId);
  });
}
