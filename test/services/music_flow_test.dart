// The music belongs to the whole app (owner, 12.10.2026): "Die
// Hintergrundmusik hat erst mit dem Spiel gestartet bzw. ist nach Werbung
// gucken gestoppt. Das muss alles fließend funktionieren."
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/monetization/music_aware_ads.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/app_bootstrap.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records what the app asked of the music, in order.
class _Music implements MusicService {
  final calls = <String>[];

  @override
  bool enabled = true;

  @override
  Future<void> ensureStarted() async => calls.add('start');

  @override
  Future<void> pauseForBackground() async => calls.add('pause');

  @override
  Future<void> resumeIfEnabled() async => calls.add('resume');

  @override
  Future<void> recover() async => calls.add('recover');
}

class _Ads extends FakeAdService {
  _Ads({this.ready = true, this.fails = false});

  final bool ready;
  final bool fails;
  final log = <String>[];

  @override
  bool rewardedReadyFor(AdPlacement placement) => ready;

  @override
  Future<bool> showRewarded(AdPlacement placement) async {
    log.add('video');
    if (fails) throw StateError('ad crashed');
    return ready;
  }
}

void main() {
  group('a rewarded video', () {
    test('pauses the music for the video and brings it back after', () async {
      final music = _Music();
      final inner = _Ads();
      final ads = MusicAwareAds(inner, music);

      expect(await ads.showRewarded(AdPlacement.freeCoins), isTrue);
      expect(music.calls, ['pause', 'resume', 'recover']);
      expect(inner.log, ['video']);
    });

    test('brings the music back even when the video fails', () async {
      final music = _Music();
      final ads = MusicAwareAds(_Ads(fails: true), music);

      await expectLater(
        ads.showRewarded(AdPlacement.piggy),
        throwsStateError,
      );
      expect(music.calls, ['pause', 'resume', 'recover']);
    });

    test('with no video to show, leaves the music alone', () async {
      final music = _Music();
      final ads = MusicAwareAds(_Ads(ready: false), music);

      expect(await ads.showRewarded(AdPlacement.freeCoins), isFalse);
      expect(music.calls, isEmpty);
    });
  });

  group('the app', () {
    Future<_Music> boot(WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'onboardingDone': true});
      final storage = await Storage.create();
      final music = _Music();
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            storageProvider.overrideWithValue(storage),
            musicProvider.overrideWithValue(music),
            leaderboardServiceProvider.overrideWithValue(
              LeaderboardService(
                client: MockClient((_) async => http.Response('[]', 200)),
                storage: storage,
              ),
            ),
          ],
          child: MaterialApp(
            theme: buildGridTheme(),
            localizationsDelegates: L10n.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            home: const AppBootstrap(),
          ),
        ),
      );
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
      return music;
    }

    testWidgets('starts the music on the menu, before any run', (
      tester,
    ) async {
      final music = await boot(tester);
      expect(music.calls, contains('start'));
    });

    testWidgets('recovers the music when it comes back to the front', (
      tester,
    ) async {
      final music = await boot(tester);
      music.calls.clear();
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(music.calls, ['pause', 'resume', 'recover']);
    });
  });
}
