// Sharing a new best (owner, 02.10.2026): an endless run that sets a record
// offers the same share button as the daily, with the score to beat and the
// Play listing. A run that sets no record offers nothing.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/sharing.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/format.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

Future<ProviderContainer> _endlessGameOver(
  WidgetTester tester, {
  required int best,
  required void Function(String) onShare,
}) async {
  SharedPreferences.setMockInitialValues({
    'highscore': best,
    'onboardingDone': true,
    // The leaderboard question would sit on top of the card.
    'namePrompt.stage': 2,
  });
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      gameClockProvider.overrideWithValue(SteppingClock().call),
      sharerProvider.overrideWithValue((text) async {
        onShare(text);
        return ShareOutcome.shared;
      }),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const GameScreen(),
      ),
    ),
  );
  await tester.pump();
  final c = container.read(gameControllerProvider.notifier);
  c.newGame(seed: 4242);
  playToGameOver(c);
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  return container;
}

void main() {
  testWidgets('a new best offers to share the score and the Play link', (
    tester,
  ) async {
    String? shared;
    final container = await _endlessGameOver(
      tester,
      best: 1,
      onShare: (t) => shared = t,
    );
    final state = container.read(gameControllerProvider);
    expect(state.isNewHighscore, isTrue);

    final button = find.text('Share result');
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    final score = L10n.of(tester.element(button)).count(state.score);
    expect(shared, contains('My new Qubble record: $score points!'));
    expect(shared, contains(kQubbleBestShareUrl));
    final link = Uri.parse(kQubbleBestShareUrl);
    expect(link.host, 'play.google.com');
    expect(link.queryParameters['id'], 'com.thinkube.qubble');
    expect(
      Uri.splitQueryString(link.queryParameters['referrer']!),
      {'utm_source': 'qubble', 'utm_medium': 'best_share'},
    );
  });

  testWidgets('a run without a new best offers no share', (tester) async {
    final container = await _endlessGameOver(
      tester,
      best: 99999999,
      onShare: (_) {},
    );
    expect(container.read(gameControllerProvider).isNewHighscore, isFalse);
    expect(find.text('Share result'), findsNothing);
  });
}
