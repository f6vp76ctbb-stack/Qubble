// The end-of-round question for a leaderboard name (owner, 28.09.2026):
// asked after a round, skippable, and a name can only be taken once.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/name_prompt.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

class _Names extends LeaderboardService {
  _Names(this.heldByOthers);

  final Set<String> heldByOthers;

  @override
  Future<NameClaim> claimName(String name) async =>
      heldByOthers.contains(name) ? NameClaim.taken : NameClaim.claimed;

  @override
  Future<bool> submit({required String name, required int score}) async =>
      true;
}

Future<(ProviderContainer, Storage)> _pumpGameOver(
  WidgetTester tester, {
  Set<String> heldByOthers = const {},
}) async {
  SharedPreferences.setMockInitialValues({'onboardingDone': true});
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      gameClockProvider.overrideWithValue(SteppingClock().call),
      leaderboardServiceProvider.overrideWithValue(_Names(heldByOthers)),
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
  await _settle(tester);
  return (container, storage);
}

/// Not pumpAndSettle: the level-up glow and particles may keep animating.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

const _body =
    'Pick a name and your best score goes on the leaderboard. Without a name '
    'you keep playing anonymously.';

void main() {
  testWidgets('the first round ends with the question, and "Later" is '
      'respected', (tester) async {
    final (container, storage) = await _pumpGameOver(tester);

    expect(find.text(_body), findsOneWidget);
    expect(storage.namePromptStage, NamePromptStage.skippedOnce,
        reason: 'counted as asked the moment it shows');

    await tester.tap(find.text('Later'));
    await _settle(tester);
    expect(find.text(_body), findsNothing);
    expect(storage.playerName, isEmpty, reason: 'skipping is allowed');
  });

  testWidgets('a taken name is refused in the dialog; a free one joins',
      (tester) async {
    final (container, storage) = await _pumpGameOver(
      tester,
      heldByOthers: {'Max'},
    );

    await tester.enterText(find.byType(TextField), 'Max');
    await tester.tap(find.text('I understand'));
    await _settle(tester);

    expect(
      find.text('This name is already taken. Try another one.'),
      findsOneWidget,
    );
    expect(find.text(_body), findsOneWidget, reason: 'the dialog stays open');
    expect(storage.playerName, isEmpty);

    await tester.enterText(find.byType(TextField), 'Max 2');
    await tester.tap(find.text('I understand'));
    await _settle(tester);

    expect(find.text(_body), findsNothing);
    expect(find.text("You're on the leaderboard now."), findsOneWidget);
    expect(storage.playerName, 'Max 2');
  });

  testWidgets('a name the filter rejects never reaches the server',
      (tester) async {
    await _pumpGameOver(tester);
    await tester.enterText(find.byType(TextField), 'M');
    await tester.tap(find.text('I understand'));
    await _settle(tester);
    expect(find.text('At least 2 characters.'), findsOneWidget);
  });
}
