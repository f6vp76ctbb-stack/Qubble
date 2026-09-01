// D.5.1 (reduced effects) and D.5.3 (haptic strength).
//
// Both settings exist for players the default build makes uncomfortable:
// weak devices that drop frames on a 220-particle burst, sensitivity to
// flashing and shaking, and phones whose "strong" haptics are unpleasant.
// The point of testing them is that a silently broken accessibility setting
// looks exactly like a working one to whoever is not affected.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/effects.dart';
import 'package:gridpop/ui/state/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> storageWith(Map<String, Object> prefs) async {
  SharedPreferences.setMockInitialValues(prefs);
  return Storage.create();
}

void main() {
  group('Effects scaling (D.5.1)', () {
    test('full strength leaves every effect untouched', () {
      expect(Effects.particles(220, reduced: false), 220);
      expect(Effects.blur(34, reduced: false), 34);
      expect(Effects.spread(4, reduced: false), 4);
    });

    test('reduced keeps 40 % of the particles', () {
      expect(Effects.particles(10, reduced: true), 4);
      expect(Effects.particles(220, reduced: true), 88);
    });

    test('a burst never reduces to nothing', () {
      // A clear that emits no particles at all reads as a dropped input, not
      // as a calmer effect. One particle still says "that worked".
      expect(Effects.particles(1, reduced: true), 1);
      expect(Effects.particles(2, reduced: true), greaterThanOrEqualTo(1));
    });

    test('reduced replaces the glow with a hard edge', () {
      expect(Effects.blur(34, reduced: true), 0);
      // The spread survives, scaled: zeroing it too would change the drawn
      // size of the element when the switch is flipped.
      expect(Effects.spread(4, reduced: true), greaterThan(0));
    });
  });

  group('haptic strength (D.5.3)', () {
    test('defaults to strong, which is what the old build always played', () {
      expect(Haptics().strength, HapticStrength.strong);
      expect(Haptics().enabled, isTrue);
    });

    test('the on/off convenience still maps both ways', () {
      expect(Haptics(enabled: false).strength, HapticStrength.off);
      final h = Haptics(enabled: false)..enabled = true;
      expect(h.strength, HapticStrength.strong);
    });

    test('light is a real setting, not off in disguise', () {
      expect(Haptics.withStrength(HapticStrength.light).enabled, isTrue);
    });
  });

  group('haptic strength persistence', () {
    test('a fresh install starts strong', () async {
      final storage = await storageWith({});
      expect(storage.hapticStrength, HapticStrength.strong);
    });

    test('someone who turned vibration off keeps it off after the update',
        () async {
      // The migration that matters: the old build stored only a bool. Reading
      // it as "no preference" would hand vibration back to the one group of
      // players who explicitly said they did not want it.
      final storage = await storageWith({'settings.haptics': false});
      expect(storage.hapticStrength, HapticStrength.off);
    });

    test('someone who had it on gets strong, not light', () async {
      final storage = await storageWith({'settings.haptics': true});
      expect(storage.hapticStrength, HapticStrength.strong);
    });

    test('an explicit choice survives a restart', () async {
      final storage = await storageWith({});
      await storage.setHapticStrength(HapticStrength.light);

      final reopened = await Storage.create();
      expect(reopened.hapticStrength, HapticStrength.light);
      // The legacy flag has to follow, or an older build (or any code still
      // reading it) would think haptics were switched off entirely.
      expect(reopened.hapticsEnabled, isTrue);
    });

    test('choosing off also clears the legacy flag', () async {
      final storage = await storageWith({});
      await storage.setHapticStrength(HapticStrength.off);
      expect(storage.hapticsEnabled, isFalse);
    });

    test('an unknown stored value falls back instead of throwing', () async {
      // Defensive: a value written by a future build, or a corrupted pref.
      final storage = await storageWith({
        'settings.hapticStrength': 'brutal',
        'settings.haptics': false,
      });
      expect(storage.hapticStrength, HapticStrength.off);
    });
  });

  group('reduced effects persistence', () {
    test('defaults to off', () async {
      final storage = await storageWith({});
      expect(storage.reducedEffects, isFalse);
    });

    test('survives a restart', () async {
      final storage = await storageWith({});
      await storage.setReducedEffects(true);
      expect((await Storage.create()).reducedEffects, isTrue);
    });
  });

  group('the controller drives the live services', () {
    late Storage storage;
    late Haptics haptics;
    late SettingsController controller;

    Future<void> boot([Map<String, Object> prefs = const {}]) async {
      storage = await storageWith(prefs);
      haptics = Haptics();
      controller = SettingsController(
        storage,
        haptics,
        SilentAudio(),
        SilentMusic(),
      );
    }

    test('the stored strength reaches Haptics on construction', () async {
      await boot({'settings.hapticStrength': 'light'});
      // Not just state: the controller has to push the value into the shared
      // Haptics instance the game already holds, or the setting is cosmetic.
      expect(haptics.strength, HapticStrength.light);
    });

    test('changing the strength applies and persists it', () async {
      await boot();
      await controller.setHapticStrength(HapticStrength.light);

      expect(haptics.strength, HapticStrength.light);
      expect(controller.state.hapticStrength, HapticStrength.light);
      expect(storage.hapticStrength, HapticStrength.light);
    });

    test('the haptics bool stays in step with the strength', () async {
      await boot();
      await controller.setHapticStrength(HapticStrength.off);
      expect(controller.state.haptics, isFalse);

      await controller.setHapticStrength(HapticStrength.light);
      expect(controller.state.haptics, isTrue);
    });

    test('the old on/off setter still works through the new path', () async {
      await boot();
      await controller.setHaptics(false);
      expect(haptics.strength, HapticStrength.off);
      expect(storage.hapticsEnabled, isFalse);
    });

    test('reduced effects round-trip through the controller', () async {
      await boot();
      expect(controller.state.reducedEffects, isFalse);

      await controller.setReducedEffects(true);
      expect(controller.state.reducedEffects, isTrue);
      expect(storage.reducedEffects, isTrue);
    });
  });
}
