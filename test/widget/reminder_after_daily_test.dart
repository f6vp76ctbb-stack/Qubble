// The reminder question follows a player's first finished Daily Challenge
// (lib/game/first_session.dart): the one moment "come back tomorrow" points
// at something. It used to come at the second launch, to everyone, whether
// or not they had ever seen the Daily.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/notification_planner.dart';
import 'package:gridpop/services/notifications.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/notifications_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

/// A phone's notification service that never touches the platform.
class _PhoneNotifications implements NotificationService {
  int scheduled = 0;

  @override
  bool get supported => true;
  @override
  Future<void> initialize() async {}
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<void> reschedule(
    List<ScheduledNote> notes, {
    String? channelDescription,
  }) async {
    scheduled += 1;
  }

  @override
  Future<void> cancelAll() async {}
}

Future<(GameController, Storage, _PhoneNotifications?)> _game(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  bool phone = true,
}) async {
  // A named player past their first runs: no other question is due.
  SharedPreferences.setMockInitialValues({
    'onboardingDone': true,
    'playerName': 'Max',
    'lifetimeStats': '{"games":6}',
    ...prefs,
  });
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final notifications = phone ? _PhoneNotifications() : null;
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      gameClockProvider.overrideWithValue(SteppingClock().call),
      if (notifications != null)
        notificationServiceProvider.overrideWithValue(notifications),
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
  return (
    container.read(gameControllerProvider.notifier),
    storage,
    notifications,
  );
}

/// The run is booked, the result stands alone for a moment, then a question
/// may open. Not pumpAndSettle: a reward may be shown moving.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('the first finished Daily ends with the question; yes switches '
      'the reminders on', (tester) async {
    final (controller, storage, notifications) = await _game(tester);
    controller.startDaily(now: DateTime(2026, 7, 23));
    playToGameOver(controller);
    await _settle(tester);

    expect(find.text('Reminders?'), findsOneWidget);
    expect(storage.reminderPromptAsked, isTrue,
        reason: 'counted as asked the moment it shows');

    await tester.tap(find.byType(FilledButton).last);
    await _settle(tester);
    expect(find.text('Reminders?'), findsNothing);
    expect(storage.notificationsEnabled, isTrue);
    expect(notifications!.scheduled, greaterThan(0));
  });

  testWidgets('an endless run does not bring it', (tester) async {
    final (controller, storage, _) = await _game(tester);
    controller.newGame(seed: 4242);
    playToGameOver(controller);
    await _settle(tester);

    expect(find.text('Game Over'), findsOneWidget);
    expect(find.text('Reminders?'), findsNothing);
    expect(storage.reminderPromptAsked, isNot(isTrue));
  });

  testWidgets('not twice', (tester) async {
    final (controller, _, _) = await _game(
      tester,
      prefs: {'settings.reminderPromptAsked': true},
    );
    controller.startDaily(now: DateTime(2026, 7, 23));
    playToGameOver(controller);
    await _settle(tester);
    expect(find.text('Reminders?'), findsNothing);
  });

  testWidgets('not when they are already on', (tester) async {
    final (controller, _, _) = await _game(
      tester,
      prefs: {'settings.notifications': true},
    );
    controller.startDaily(now: DateTime(2026, 7, 23));
    playToGameOver(controller);
    await _settle(tester);
    expect(find.text('Reminders?'), findsNothing);
  });

  testWidgets('not where no reminder can arrive (web)', (tester) async {
    final (controller, _, _) = await _game(tester, phone: false);
    controller.startDaily(now: DateTime(2026, 7, 23));
    playToGameOver(controller);
    await _settle(tester);
    expect(find.text('Reminders?'), findsNothing);
  });
}
