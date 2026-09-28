// Quests in the running app (owner, 28.09.2026): a finished round and a
// solved puzzle count, a finished set pays its diamonds, and the screen shows
// every period with its countdown and every achievement with a bar.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/quests.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/quests_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

// Tuesday 29.09.2026, noon — no event weekend, so coins are not doubled.
final _day = DateTime(2026, 9, 29, 12);

Future<(GameController, Storage)> _controller([
  Map<String, Object> prefs = const {},
]) async {
  SharedPreferences.setMockInitialValues({'onboardingDone': true, ...prefs});
  final storage = await Storage.create();
  final c = GameController(
    storage,
    Haptics(enabled: false),
    SilentAudio(),
    FakeAdService(),
    NoopAnalytics(),
    clock: SteppingClock().call,
    calendar: () => _day,
  );
  return (c, storage);
}

Future<void> _playRound(GameController c) async {
  c.newGame(seed: 7);
  playToGameOver(c);
  await Future<void>.delayed(const Duration(milliseconds: 50));
}

void main() {
  test('a finished round counts towards every period', () async {
    final (c, storage) = await _controller();
    await _playRound(c);

    for (final period in QuestPeriod.values) {
      final p = storage.questProgress[period]!;
      expect(p.valueOf(QuestMetric.rounds), 1, reason: '$period');
      expect(p.valueOf(QuestMetric.days), 1, reason: '$period');
    }
  });

  test('the last daily quest pays the set bonus: 5 diamonds', () async {
    // Every daily quest one step from done.
    final daily = questsFor(QuestPeriod.daily, _day);
    final (c, storage) = await _controller({
      'quests': jsonEncode({
        'daily': QuestProgress(
          key: questPeriodKey(QuestPeriod.daily, _day),
          values: {for (final q in daily) q.metric.name: q.target},
        ).toJson(),
      }),
    });
    await _playRound(c);

    expect(storage.diamonds, kQuestBonusDiamonds[QuestPeriod.daily]);
    expect(c.state.questSetsThisRun, [QuestPeriod.daily]);
    expect(c.state.completedQuests, containsAll(daily));
    expect(c.questSetDone(QuestPeriod.daily), isTrue);

    await _playRound(c);
    expect(storage.diamonds, kQuestBonusDiamonds[QuestPeriod.daily],
        reason: 'the bonus is paid once');
    expect(c.state.questSetsThisRun, isEmpty);
  });

  test('a first puzzle solve counts', () async {
    final (c, storage) = await _controller();
    await c.recordPuzzleForQuests();
    expect(
      storage.questProgress[QuestPeriod.weekly]!.valueOf(QuestMetric.puzzles),
      1,
    );
  });

  testWidgets('the screen shows every period with its countdown, and every '
      'achievement with a bar', (tester) async {
    SharedPreferences.setMockInitialValues({'onboardingDone': true});
    final storage = await Storage.create();
    tester.view.physicalSize = const Size(412, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageProvider.overrideWithValue(storage),
          gameCalendarProvider.overrideWithValue(() => _day),
        ],
        child: MaterialApp(
          theme: buildGridTheme(),
          locale: const Locale('en'),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const QuestsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('DAILY'), findsOneWidget);
    expect(find.text('WEEKLY'), findsOneWidget);
    expect(find.text('MONTHLY'), findsOneWidget);
    expect(find.text('New quests in 12h 0m'), findsOneWidget);
    expect(find.text('New quests in 5d 12h'), findsOneWidget,
        reason: 'the week ends on Sunday night');
    expect(find.text('Bonus for all'), findsNWidgets(3));
    expect(find.byType(LinearProgressIndicator), findsNWidgets(13),
        reason: '3 daily, 5 weekly and 5 monthly quests');

    await tester.tap(find.text('Achievements'));
    // Not pumpAndSettle: the animated skin rewards never settle.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('0 / 1'), findsOneWidget,
        reason: 'the first achievement, one game, shows its bar');
    expect(find.byType(LinearProgressIndicator), findsWidgets);
  });
}
