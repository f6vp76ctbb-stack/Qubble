// Accessories and explosions (owner, 30.09.2026) are bought with diamonds
// and equipped like the skins.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/accessory.dart';
import 'package:gridpop/game/burst_style.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/cosmetic_controller.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container(Map<String, Object> prefs) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      hapticsProvider.overrideWithValue(Haptics(enabled: false)),
      audioProvider.overrideWithValue(SilentAudio()),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('everyone owns "none" and the classic burst, and wears them', () async {
    final c = await _container({});
    expect(c.read(activeAccessoryProvider), AccessoryStyle.none);
    expect(c.read(activeBurstProvider), BurstStyle.classic);
    expect(
      c.read(accessoryControllerProvider).isUnlocked(kNoAccessoryId),
      isTrue,
    );
    expect(c.read(burstControllerProvider).isUnlocked(kDefaultBurstId), isTrue);
  });

  test('an accessory costs 60 diamonds and is worn at once', () async {
    final c = await _container({'diamonds': 100});
    final ok = await c
        .read(accessoryControllerProvider.notifier)
        .selectOrUnlock('cobweb');
    expect(ok, isTrue);
    expect(c.read(storageProvider).diamonds, 40);
    expect(c.read(activeAccessoryProvider), AccessoryStyle.cobweb);
  });

  test(
    'an explosion costs 100 diamonds; short of that, nothing happens',
    () async {
      final c = await _container({'diamonds': 99});
      final notifier = c.read(burstControllerProvider.notifier);
      expect(await notifier.selectOrUnlock('fire'), isFalse);
      expect(c.read(storageProvider).diamonds, 99);
      expect(c.read(activeBurstProvider), BurstStyle.classic);

      await c.read(storageProvider).addDiamonds(1);
      expect(await notifier.selectOrUnlock('fire'), isTrue);
      expect(c.read(storageProvider).diamonds, 0);
      expect(c.read(activeBurstProvider), BurstStyle.fire);
    },
  );

  test(
    'switching between owned ones is free; unowned cannot be worn',
    () async {
      final c = await _container({
        'diamonds': 0,
        'cosmetic.accessory.unlocked': ['crown'],
      });
      final notifier = c.read(accessoryControllerProvider.notifier);
      expect(await notifier.selectOrUnlock('crown'), isTrue);
      expect(c.read(activeAccessoryProvider), AccessoryStyle.crown);
      await notifier.setActive('flower');
      expect(c.read(activeAccessoryProvider), AccessoryStyle.crown);
      expect(await notifier.selectOrUnlock(kNoAccessoryId), isTrue);
      expect(c.read(activeAccessoryProvider), AccessoryStyle.none);
      expect(await notifier.selectOrUnlock('unknown'), isFalse);
    },
  );

  test('bought ones survive a progress reset, like themes and skins', () async {
    final c = await _container({
      'cosmetic.accessory.unlocked': ['crown'],
      'cosmetic.accessory.active': 'crown',
      'cosmetic.burst.unlocked': ['stars'],
      'cosmetic.burst.active': 'stars',
    });
    final storage = c.read(storageProvider);
    await storage.resetProgress();
    expect(
      storage.unlockedCosmetics('accessory', kNoAccessoryId),
      contains('crown'),
    );
    expect(storage.activeCosmetic('burst', kDefaultBurstId), 'stars');
  });
}
