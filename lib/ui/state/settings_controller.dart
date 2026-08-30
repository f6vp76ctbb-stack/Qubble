/// Riverpod controller for user settings (sound, music, haptics). Applies the
/// flags to the live [Haptics], [AudioService] and [MusicService] instances
/// and persists them.
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
    required this.languageCode,
  });

  final bool sound;
  final bool music;
  final bool haptics;

  /// '' = follow the device language; otherwise a supported locale code.
  final String languageCode;

  /// The locale to force on [MaterialApp], or null to follow the device.
  Locale? get locale => languageCode.isEmpty ? null : Locale(languageCode);

  SettingsState copyWith({
    bool? sound,
    bool? music,
    bool? haptics,
    String? languageCode,
  }) {
    return SettingsState(
      sound: sound ?? this.sound,
      music: music ?? this.music,
      haptics: haptics ?? this.haptics,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}

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
          haptics: _storage.hapticsEnabled,
          languageCode: _storage.languageCode,
        )) {
    _apply();
  }

  final Storage _storage;
  final Haptics _haptics;
  final AudioService _audio;
  final MusicService _music;

  void _apply() {
    _haptics.enabled = state.haptics;
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

  Future<void> setHaptics(bool value) async {
    await _storage.setHapticsEnabled(value);
    state = state.copyWith(haptics: value);
    _apply();
  }

  /// Sets the language override. Pass '' to follow the device language again.
  Future<void> setLanguageCode(String value) async {
    await _storage.setLanguageCode(value);
    state = state.copyWith(languageCode: value);
  }
}
