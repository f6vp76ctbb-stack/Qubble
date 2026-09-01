import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/app_localizations.dart';

import 'monetization/ads.dart';
import 'monetization/iap.dart';
import 'services/analytics.dart';
import 'services/audio.dart';
import 'services/crash_reporter.dart';
import 'services/firebase_boot.dart';
import 'services/notifications.dart';
import 'services/review.dart';
import 'services/storage.dart';
import 'ui/app_bootstrap.dart';
import 'ui/locale.dart';
import 'ui/state/game_controller.dart';
import 'ui/state/notifications_controller.dart';
import 'ui/state/settings_controller.dart';
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
  final firebase = await initFirebase();
  final analytics = firebase?.analytics ?? DebugAnalytics();
  final crashes = firebase?.crashes ?? DebugCrashReporter();

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
        adServiceProvider.overrideWithValue(
          kIsWeb
              ? FakeAdService()
              // Hand it the analytics backend so paid-event revenue is
              // reported; DebugAnalytics prints it when Firebase is absent.
              : GoogleAdService(analytics),
        ),
        // Web: the released PWA must never deliver purchases for free
        // (leaderboard fairness) — LockedIap has no products and never
        // delivers. FakeIap only in local debug web builds for development.
        iapServiceProvider.overrideWithValue(
          kIsWeb ? (kDebugMode ? FakeIap() : LockedIap()) : StoreIap(),
        ),
        analyticsProvider.overrideWithValue(analytics),
        crashReporterProvider.overrideWithValue(crashes),
        // in_app_review has no web implementation either.
        reviewServiceProvider
            .overrideWithValue(kIsWeb ? const NoopReview() : StoreReview()),
        if (!kIsWeb)
          notificationServiceProvider
              .overrideWithValue(LocalNotifications()),
      ],
      child: const QubbleApp(),
    ),
  );
}

class QubbleApp extends ConsumerWidget {
  const QubbleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // English is the source language; German is a translation. Any device
    // language without a translation falls back to English.
    final locale = ref.watch(settingsControllerProvider).locale;

    return MaterialApp(
      onGenerateTitle: (context) => L10n.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildGridTheme(),
      locale: locale,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      localeResolutionCallback: resolveAppLocale,
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
      // The language preference lives in the save file that just failed to
      // open, so this follows the device language instead.
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      localeResolutionCallback: resolveAppLocale,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Builder(
                builder: (context) {
                  final l10n = L10n.of(context);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🧩', style: TextStyle(fontSize: 44)),
                      const SizedBox(height: 12),
                      Text(
                        l10n.storageFailureTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.storageFailureBody,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
