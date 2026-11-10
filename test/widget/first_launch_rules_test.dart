import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/notification_planner.dart';
import 'package:gridpop/services/notifications.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/app_bootstrap.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/how_to_play_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/notifications_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A phone's notification service that never touches the platform.
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

/// Boots the real AppBootstrap. Every service provider already defaults to a
/// silent or fake implementation; only storage and the leaderboard need
/// overriding, the latter so nothing reaches the network. [phone] swaps the
/// default notification service (the web build's, which has none) for one
/// that can deliver.
Future<Storage> _boot(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  bool phone = false,
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        if (phone)
          notificationServiceProvider.overrideWithValue(_PhoneNotifications()),
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
  // _init runs in a post-frame callback and awaits several steps. The home
  // screen animates forever, so pump fixed frames rather than settling.
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  return storage;
}

/// A player who has finished a run. Until then every launch opens the board
/// (lib/game/first_session.dart) and nothing else may open over it.
const _played = <String, Object>{'lifetimeStats': '{"games":1}'};

void main() {
  testWidgets('the first launch goes straight to the game, not to a rules wall',
      (tester) async {
    await _boot(tester, phone: true);

    expect(
      find.byType(HowToPlayScreen),
      findsNothing,
      reason: 'a wall of text between the icon tap and the first block is the '
          'most expensive thing this app can do to a new player',
    );
    expect(
      find.byType(GameScreen),
      findsOneWidget,
      reason: 'not the menu either: a best score of zero and six doors',
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('every launch opens the board until a run has been finished',
      (tester) async {
    // Second launch of someone who closed the app in their first run: still
    // the board, and no question over it.
    final storage = await _boot(
      tester,
      prefs: {'appOpenCount': 1},
      phone: true,
    );
    expect(find.byType(GameScreen), findsOneWidget);
    expect(find.text('Reminders?'), findsNothing);
    expect(find.byType(HowToPlayScreen), findsNothing);
    expect(storage.reminderPromptAsked, isFalse);
  });

  testWidgets('a player who has finished a run starts on the menu',
      (tester) async {
    await _boot(tester, prefs: _played);
    expect(find.byType(GameScreen), findsNothing);
  });

  testWidgets('the second launch belongs to the notification prompt alone',
      (tester) async {
    // Housekeeping takes appOpenCount to 2 and asks about notifications. The
    // rules must not stack on top of that dialog.
    final storage = await _boot(
      tester,
      prefs: {..._played, 'appOpenCount': 1},
      phone: true,
    );
    expect(find.text('Reminders?'), findsOneWidget);
    expect(find.byType(HowToPlayScreen), findsNothing);
    expect(storage.reminderPromptAsked, isTrue);
  });

  testWidgets('the reminder question is put once', (tester) async {
    await _boot(
      tester,
      prefs: {
        ..._played,
        'appOpenCount': 1,
        'settings.reminderPromptAsked': true,
      },
      phone: true,
    );
    expect(find.text('Reminders?'), findsNothing);
  });

  testWidgets('a later launch catches up when the second had no finished run',
      (tester) async {
    await _boot(
      tester,
      prefs: {
        ..._played,
        'appOpenCount': 4,
        'settings.reminderPromptAsked': false,
        'howToPlaySeen': true,
      },
      phone: true,
    );
    expect(find.text('Reminders?'), findsOneWidget);
  });

  testWidgets('an install from before 1.6.0 was asked at its second launch '
      'and is not asked again', (tester) async {
    final storage = await _boot(
      tester,
      prefs: {..._played, 'appOpenCount': 6, 'howToPlaySeen': true},
      phone: true,
    );
    expect(find.text('Reminders?'), findsNothing);
    expect(storage.reminderPromptAsked, isTrue);
  });

  testWidgets('the web build does not ask for reminders it cannot send',
      (tester) async {
    // Its "yes" used to do nothing: no permission, no reminder, no word.
    await _boot(tester, prefs: {..._played, 'appOpenCount': 1});
    expect(find.text('Reminders?'), findsNothing);
  });

  testWidgets('a returning player who never opened the rules is shown them',
      (tester) async {
    // Third launch: appOpenCount reaches 3 during housekeeping.
    final storage = await _boot(
      tester,
      prefs: {..._played, 'appOpenCount': 2},
    );

    expect(find.byType(HowToPlayScreen), findsOneWidget,
        reason: 'the screen still exists for players who never find the '
            'help icon — just after they have played, not before');
    expect(storage.howToPlaySeen, isTrue);
  });

  testWidgets('a player who already read the rules is not shown them again',
      (tester) async {
    await _boot(
      tester,
      prefs: {..._played, 'appOpenCount': 2, 'howToPlaySeen': true},
    );
    expect(find.byType(HowToPlayScreen), findsNothing);
  });

  testWidgets('a player past onboarding is not shown them either',
      (tester) async {
    // Someone who learnt the game from the in-run coach needs no preamble.
    await _boot(
      tester,
      prefs: {..._played, 'appOpenCount': 2, 'onboardingDone': true},
    );
    expect(find.byType(HowToPlayScreen), findsNothing);
  });

  testWidgets('it shows once, not on every later launch', (tester) async {
    await _boot(tester, prefs: {..._played, 'appOpenCount': 9});
    expect(find.byType(HowToPlayScreen), findsOneWidget);

    // The flag is now set, so the next launch stays clear.
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('howToPlaySeen'), isTrue);
  });
}
