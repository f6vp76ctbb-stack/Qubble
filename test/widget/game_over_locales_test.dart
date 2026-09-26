// The game-over overlay is the most crowded text in the game: a headline, the
// reason the run ended, the score, rewards, the revive link, "double coins",
// "play again" and, in the daily, a share button — all on one card. The menu
// screens run through screen_overflow_test.dart in every language; this does
// the same for the overlay, in the endless run and in the daily, where the
// daily-only buttons appear.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

Future<List<String>> _overflows(
  WidgetTester tester, {
  required Locale locale,
  required double textScale,
  required bool daily,
}) async {
  // Coins in hand so the revive link shows; a best of 1 so the run is a new
  // record and the record line shows too — the fullest the card gets.
  SharedPreferences.setMockInitialValues({
    'highscore': 1,
    'coins': 5000,
    'onboardingDone': true,
  });
  final storage = await Storage.create();

  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      gameClockProvider.overrideWithValue(SteppingClock().call),
    ],
  );
  addTearDown(container.dispose);

  final overflows = <String>[];
  final previous = FlutterError.onError;
  // Overflows are collected so one failure names them all; any other error
  // still fails the test instead of being dropped.
  FlutterError.onError = (details) {
    final text = details.exceptionAsString();
    if (text.contains('overflowed')) {
      overflows.add(text.split('\n').first);
    } else {
      previous?.call(details);
    }
  };
  try {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: buildGridTheme(),
          locale: locale,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          localeResolutionCallback: resolveAppLocale,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          home: const GameScreen(),
        ),
      ),
    );
    await tester.pump();

    final c = container.read(gameControllerProvider.notifier);
    if (daily) {
      c.startDaily();
    } else {
      c.newGame(seed: 4242);
    }
    playToGameOver(c);
    expect(c.state.gameOver, isTrue, reason: 'the harness never lost');
    // Not pumpAndSettle: the level-up glow and particles may keep animating.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  } finally {
    FlutterError.onError = previous;
  }
  return overflows;
}

void main() {
  for (final locale in L10n.supportedLocales) {
    for (final daily in [false, true]) {
      for (final scale in [1.0, 1.3]) {
        final mode = daily ? 'daily' : 'endless';
        testWidgets(
          'game over ($mode) fits in ${locale.languageCode} at $scale',
          (tester) async {
            final overflows = await _overflows(
              tester,
              locale: locale,
              textScale: scale,
              daily: daily,
            );
            expect(
              overflows,
              isEmpty,
              reason: 'game over ($mode) overflows in '
                  '${locale.languageCode} at $scale:\n  '
                  '${overflows.join('\n  ')}',
            );
          },
        );
      }
    }
  }
}
