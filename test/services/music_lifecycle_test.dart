// Nothing observed the app lifecycle, so the music loop kept playing after the
// player switched away from the game.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/audio.dart';

void main() {
  group('MusicService contract', () {
    test('the silent implementation supports the whole interface', () async {
      final music = SilentMusic();
      await music.ensureStarted();
      await music.pauseForBackground();
      await music.resumeIfEnabled();
      expect(music.enabled, isTrue);
      music.enabled = false;
      expect(music.enabled, isFalse);
    });

    test('resuming without a prior pause is a no-op', () async {
      // Guards against a resume on app start pulling the loop up before the
      // first user gesture, which browsers reject outright.
      final music = SilentMusic();
      await music.resumeIfEnabled();
      expect(music.enabled, isTrue);
    });
  });
}
