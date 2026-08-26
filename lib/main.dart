import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'monetization/ads.dart';
import 'monetization/iap.dart';
import 'services/analytics.dart';
import 'services/audio.dart';
import 'services/firebase_boot.dart';
import 'services/notifications.dart';
import 'services/storage.dart';
import 'ui/app_bootstrap.dart';
import 'ui/state/game_controller.dart';
import 'ui/state/notifications_controller.dart';
import 'ui/theme.dart';
import 'ui/widgets/error_screen.dart';

Future<void> main() async {
  // A build failure would otherwise render Flutter's release-mode default: a
  // grey rectangle with no text. Installed before anything else so even a
  // failure during startup lands on a screen that says something.
  installErrorScreen();

  WidgetsFlutterBinding.ensureInitialized();

  // Portrait only. The play screen is a portrait design: in landscape the
  // compact fallback drops the whole booster bar, the "Neue Teile" button and
  // every coach hint, so an accidental rotation silently removed features.
  // A real landscape layout is its own piece of work, after the playtest.
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Storage is the one thing the app genuinely cannot run without. If it
  // fails, say so instead of dying before the first frame.
  final Storage storage;
  try {
    storage = await Storage.create();
  } catch (error, stack) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: 'qubble',
        context: ErrorDescription('loading the local save'),
      ),
    );
    runApp(const StorageFailureApp());
    return;
  }

  // Now that a save exists, the error screen can offer to reset it — a broken
  // save is the failure cause the player can actually clear from in here.
  installErrorScreen(onReset: storage.resetProgress);

  // Configure audio as a GAME (ambient) before any player is created, so the
  // music never shows up in the system media controls like a Spotify track.
  await configureGameAudioSession();

  // Firebase (Analytics + Crashlytics) on native builds; null on web (the
  // stub) or when init fails — the game never depends on it.
  final firebaseAnalytics = await initFirebase();

  // AdMob, in_app_purchase and flutter_local_notifications have no web
  // implementation — on the web/PWA build they throw when invoked (which was
  // breaking "Nochmal spielen"). Use the no-op fakes there; native builds use
  // the real services.
  runApp(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        audioProvider.overrideWithValue(AudioplayersAudio()),
        musicProvider.overrideWithValue(AudioplayersMusic()),
        adServiceProvider
            .overrideWithValue(kIsWeb ? FakeAdService() : GoogleAdService()),
        // Web: the released PWA must never deliver purchases for free
        // (leaderboard fairness) — LockedIap has no products and never
        // delivers. FakeIap only in local debug web builds for development.
        iapServiceProvider.overrideWithValue(
          kIsWeb ? (kDebugMode ? FakeIap() : LockedIap()) : StoreIap(),
        ),
        analyticsProvider
            .overrideWithValue(firebaseAnalytics ?? DebugAnalytics()),
        if (!kIsWeb)
          notificationServiceProvider
              .overrideWithValue(LocalNotifications()),
      ],
      child: const GridPopApp(),
    ),
  );
}

class GridPopApp extends StatelessWidget {
  const GridPopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qubble',
      debugShowCheckedModeBanner: false,
      theme: buildGridTheme(),
      home: const AppBootstrap(),
    );
  }
}

/// Shown when the local save cannot be opened at all — without this the app
/// would exit before the first frame with nothing on screen.
class StorageFailureApp extends StatelessWidget {
  const StorageFailureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qubble',
      debugShowCheckedModeBanner: false,
      theme: buildGridTheme(),
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🧩', style: TextStyle(fontSize: 44)),
                  SizedBox(height: 12),
                  Text(
                    'Qubble kann den Spielstand nicht laden',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bitte starte die App neu. Bleibt der Fehler, hilft nur '
                    'eine Neuinstallation — bitte melde das im Playtest.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
