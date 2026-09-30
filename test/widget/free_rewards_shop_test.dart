// The shop's reward videos (owner, 30.09.2026) as the player sees them.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('three videos for gold, then back tomorrow', (tester) async {
    SharedPreferences.setMockInitialValues({
      'onboardingDone': true,
      'coins': 0,
      'diamonds': 0,
    });
    final storage = await Storage.create();
    tester.view.physicalSize = const Size(412, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final day = DateTime(2026, 11, 3, 12);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageProvider.overrideWithValue(storage),
          gameCalendarProvider.overrideWithValue(() => day),
        ],
        child: MaterialApp(
          theme: buildGridTheme(),
          locale: const Locale('en'),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const ShopScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('FREE BONUS'), findsOneWidget);
    expect(find.text('Today: 3/3'), findsNWidgets(2));

    final gold = find.widgetWithText(FilledButton, 'Watch video').first;
    for (var i = 0; i < 3; i++) {
      await tester.tap(gold);
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(storage.coins, 300);
    expect(find.text('Back tomorrow'), findsOneWidget);
    expect(
      find.text('Today: 3/3'),
      findsOneWidget,
      reason: 'diamonds untouched',
    );
  });
}
