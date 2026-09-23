// The reminders switch appears only where a reminder can arrive. On the web
// build it could never turn on and answered every tap with "allow it in your
// system settings" — advice a browser tab cannot follow.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/notification_planner.dart';
import 'package:gridpop/services/notifications.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/notifications_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _PhoneNotifications implements NotificationService {
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
  }) async {}
  @override
  Future<void> cancelAll() async {}
}

Future<void> _pumpSettings(
  WidgetTester tester,
  NotificationService notifications,
) async {
  // Tall, so the lazily built list lays out every section.
  tester.view.physicalSize = const Size(600, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        notificationServiceProvider.overrideWithValue(notifications),
      ],
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const SettingsScreen(),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('a phone offers the reminders switch', (tester) async {
    await _pumpSettings(tester, _PhoneNotifications());
    expect(find.text('Daily reminder & streak protection'), findsOneWidget);
  });

  testWidgets('the web build does not', (tester) async {
    await _pumpSettings(tester, NoopNotifications());
    expect(find.text('Daily reminder & streak protection'), findsNothing);
    expect(find.text('Reminders'), findsNothing);
  });
}
