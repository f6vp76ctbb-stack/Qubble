/// Riverpod controller for user settings (sound, music, haptics, reduced
/// effects). Applies the flags to the live [Haptics], [AudioService] and
/// [MusicService] instances and persists them.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/audio.dart';
import '../../services/haptics.dart';
import '../../services/storage.dart';
import 'game_controller.dart';

@immutable
class SettingsState {
  const SettingsState({
    required this.sound,
    required this.music,
    required this.haptics,
    required this.hapticStrength,
    required this.reducedEffects,
    required this.languageCode,
  });

  final bool sound;
  final bool music;

  /// Whether haptics play at all. Derived from [hapticStrength]; kept so the
  /// existing on/off call sites do not have to know about strengths.
  final bool haptics;

  final HapticStrength hapticStrength;

  /// Fewer particles, no screen shake, no glow (D.5.1).
  final bool reducedEffects;

  /// '' = follow the device language; otherwise a supported locale code.
  final String languageCode;

  /// The locale to force on [MaterialApp], or null to follow the device.
  Locale? get locale => languageCode.isEmpty ? null : Locale(languageCode);

  SettingsState copyWith({
    bool? sound,
    bool? music,
    HapticStrength? hapticStrength,
    bool? reducedEffects,
    String? languageCode,
  }) {
    final strength = hapticStrength ?? this.hapticStrength;
    return SettingsState(
      sound: sound ?? this.sound,
      music: music ?? this.music,
      haptics: strength != HapticStrength.off,
      hapticStrength: strength,
      reducedEffects: reducedEffects ?? this.reducedEffects,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}

/// The one place painters and effect widgets ask whether to hold back.
final reducedEffectsProvider = Provider<bool>(
  (ref) => ref.watch(settingsControllerProvider).reducedEffects,
);

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController(
    ref.read(storageProvider),
    ref.read(hapticsProvider),
    ref.read(audioProvider),
    ref.read(musicProvider),
  );
});

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController(this._storage, this._haptics, this._audio, this._music)
      : super(SettingsState(
          sound: _storage.soundEnabled,
          music: _storage.musicEnabled,
          haptics: _storage.hapticStrength != HapticStrength.off,
          hapticStrength: _storage.hapticStrength,
          reducedEffects: _storage.reducedEffects,
          languageCode: _storage.languageCode,
        )) {
    _apply();
  }

  final Storage _storage;
  final Haptics _haptics;
  final AudioService _audio;
  final MusicService _music;

  void _apply() {
    _haptics.strength = state.hapticStrength;
    _audio.enabled = state.sound;
    _music.enabled = state.music;
  }

  Future<void> setSound(bool value) async {
    await _storage.setSoundEnabled(value);
    state = state.copyWith(sound: value);
    _apply();
  }

  Future<void> setMusic(bool value) async {
    await _storage.setMusicEnabled(value);
    state = state.copyWith(music: value);
    _apply();
    // Turning music on is itself a tap — start the loop right away.
    if (value) await _music.ensureStarted();
  }

  Future<void> setHaptics(bool value) =>
      setHapticStrength(value ? HapticStrength.strong : HapticStrength.off);

  Future<void> setHapticStrength(HapticStrength value) async {
    await _storage.setHapticStrength(value);
    state = state.copyWith(hapticStrength: value);
    _apply();
  }

  Future<void> setReducedEffects(bool value) async {
    await _storage.setReducedEffects(value);
    state = state.copyWith(reducedEffects: value);
  }

  /// Sets the language override. Pass '' to follow the device language again.
  Future<void> setLanguageCode(String value) async {
    await _storage.setLanguageCode(value);
    state = state.copyWith(languageCode: value);
  }
}
