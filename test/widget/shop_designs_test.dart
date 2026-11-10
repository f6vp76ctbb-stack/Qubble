// The reworked shop and the combined designs screen (owner, 28.09.2026): one
// of six diamond designs is the deal of the day at a discount, and the
// designs screen previews a locked design on the whole screen before it is
// bought.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/design_offer.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/mini_board_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A day whose deal of the day is the Candy theme.
DateTime _candyDay() {
  var day = DateTime(2026, 9, 28, 12);
  while (dailyDeal(day) != const ShopDesign(DesignKind.theme, 'candy')) {
    day = DateTime(day.year, day.month, day.day + 1, 12);
  }
  return day;
}

Future<Storage> _pump(
  WidgetTester tester,
  Widget home, {
  int diamonds = 95,
}) async {
  SharedPreferences.setMockInitialValues({
    'onboardingDone': true,
    'diamonds': diamonds,
  });
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(412, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final day = _candyDay();
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
        home: home,
      ),
    ),
  );
  await _settle(tester);
  return storage;
}

/// Not pumpAndSettle: the animated skins and the countdown never settle.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Taps the buy button of the open design preview.
Future<void> _buyInPreview(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(Dialog),
      matching: find.byType(FilledButton),
    ),
  );
  await _settle(tester);
}

void main() {
  testWidgets(
      'tapping a skin opens its preview, moving, with the price '
      '(owner, 12.10.2026)', (tester) async {
    final storage = await _pump(tester, const ShopScreen(), diamonds: 200);

    await tester.tap(find.text('Plasma').first);
    await _settle(tester);

    final dialog = find.byType(Dialog);
    expect(dialog, findsOneWidget);
    expect(
      find.descendant(of: dialog, matching: find.text('Plasma skin')),
      findsOneWidget,
    );
    final preview = tester.widget<MiniBoardPreview>(
      find.descendant(of: dialog, matching: find.byType(MiniBoardPreview)),
    );
    expect(preview.style, skinStyleById('plasma'));
    expect(preview.animate, isTrue);
    expect(
      find.descendant(of: dialog, matching: find.text('150')),
      findsOneWidget,
    );

    // Cancel buys nothing.
    await tester.tap(find.text('Cancel'));
    await _settle(tester);
    expect(find.byType(Dialog), findsNothing);
    expect(storage.diamonds, 200);

    await tester.tap(find.text('Plasma').first);
    await _settle(tester);
    await _buyInPreview(tester);
    expect(storage.diamonds, 50);
    expect(storage.unlockedSkins, contains('plasma'));
  });

  testWidgets('the deal of the day sells at the discounted price',
      (tester) async {
    final storage = await _pump(tester, const ShopScreen());

    expect(find.text('Deal of the day'.toUpperCase()), findsOneWidget);
    expect(find.text('Candy theme'), findsOneWidget);
    expect(designPrice(dailyDeal(_candyDay()), _candyDay()), 60);

    // The deal card comes first; the same design further down carries the
    // same discounted price. A tap opens the preview, which sells it.
    await tester.tap(find.widgetWithText(FilledButton, '60').first);
    await _settle(tester);
    expect(storage.diamonds, 95, reason: 'nothing bought on the first tap');
    await _buyInPreview(tester);

    expect(storage.diamonds, 95 - 60);
    expect(storage.unlockedThemes, contains('candy'));
    expect(find.text('Candy theme unlocked!'), findsOneWidget);
  });

  testWidgets('too few diamonds: nothing is spent and the shop points to '
      'the diamond packs', (tester) async {
    final storage = await _pump(tester, const ShopScreen(), diamonds: 10);

    await tester.tap(find.widgetWithText(FilledButton, '60').first);
    await _settle(tester);
    await _buyInPreview(tester);

    expect(storage.diamonds, 10);
    expect(storage.unlockedThemes, isNot(contains('candy')));
    expect(find.text('Not enough diamonds.'), findsOneWidget);
    expect(find.text('Get diamonds'), findsOneWidget);
  });

  testWidgets('a locked theme is previewed on the whole screen, then bought',
      (tester) async {
    final storage = await _pump(tester, const DesignsScreen());
    Color background() =>
        tester.widget<Scaffold>(find.byType(Scaffold).first).backgroundColor!;
    final volcano = kThemeCatalog.firstWhere((t) => t.id == 'volcano');

    expect(find.text('Preview'), findsNothing);
    await tester.tap(find.text('Volcano'));
    await _settle(tester);

    expect(find.text('Preview'), findsOneWidget);
    expect(background(), volcano.theme.background,
        reason: 'the screen shows the design being looked at');
    expect(storage.activeTheme, 'classic', reason: 'looking is not buying');

    await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
    await _settle(tester);

    expect(storage.diamonds, 95 - kRotatingDesignPrice);
    expect(storage.unlockedThemes, contains('volcano'));
    expect(storage.activeTheme, 'volcano');
    expect(find.text('Preview'), findsNothing);
  });
}
