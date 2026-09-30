// The Halloween event (owner, 30.09.2026): in October the shop leads with the
// pumpkin theme and the ghost skin and the home screen says so; after October
// they are shown but cannot be bought.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _october = DateTime(2026, 10, 12, 12);
final _november = DateTime(2026, 11, 12, 12);
const _body = 'Pumpkin theme and ghost skin — only in October.';

Future<void> _pump(WidgetTester tester, Widget home, DateTime now) async {
  SharedPreferences.setMockInitialValues({
    'onboardingDone': true,
    'diamonds': 500,
  });
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(412, 2600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        gameCalendarProvider.overrideWithValue(() => now),
      ],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: home,
      ),
    ),
  );
  // Not pumpAndSettle: the animated skins never settle.
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('in October the shop leads with the Halloween designs', (
    tester,
  ) async {
    await _pump(tester, const ShopScreen(), _october);
    expect(find.text('HALLOWEEN'), findsOneWidget);
    expect(find.text(_body), findsOneWidget);
    expect(find.text('Pumpkin'), findsOneWidget);
    expect(find.text('Ghost'), findsOneWidget);
  });

  testWidgets('after October the shop has no Halloween section', (
    tester,
  ) async {
    await _pump(tester, const ShopScreen(), _november);
    expect(find.text('HALLOWEEN'), findsNothing);
    expect(
      find.text('Ghost'),
      findsNothing,
      reason: 'not in the animated skins row either',
    );
  });

  testWidgets('the home banner shows in October only', (tester) async {
    await _pump(tester, const HomeScreen(), _october);
    expect(find.text(_body), findsOneWidget);

    await _pump(tester, const HomeScreen(), _november);
    expect(find.text(_body), findsNothing);
  });

  testWidgets('after October the designs say when they come back', (
    tester,
  ) async {
    await _pump(tester, const DesignsScreen(), _november);
    expect(
      find.text('Back in October'),
      findsOneWidget,
      reason: 'the pumpkin theme',
    );
    await tester.tap(find.text('Pumpkin'));
    await tester.pump(const Duration(milliseconds: 200));
    // The preview bar offers no purchase.
    expect(find.text('Back in October'), findsNWidgets(2));
    expect(find.widgetWithText(FilledButton, 'Buy'), findsNothing);

    await tester.tap(find.text('Block skins'));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Ghost'), findsOneWidget);
  });
}
