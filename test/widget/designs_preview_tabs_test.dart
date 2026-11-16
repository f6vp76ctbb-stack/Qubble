// The designs screen keeps what is being tried on across its tabs (owner,
// 16.11.2026): a block skin previewed on the skins tab stays on the stage
// when the player moves on to the accessories, and the accessory is put on
// top of it. Each kind replaces only its own preview; buying or cancelling
// acts on one kind and leaves the others standing.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/accessory.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/mini_board_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> _pump(WidgetTester tester, {int tab = 1}) async {
  SharedPreferences.setMockInitialValues({
    'onboardingDone': true,
    'diamonds': 150,
  });
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(412, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
        gameCalendarProvider.overrideWithValue(() => DateTime(2026, 11, 5)),
      ],
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: const Locale('en'),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: DesignsScreen(initialTab: tab),
      ),
    ),
  );
  await _settle(tester);
  return storage;
}

/// Not pumpAndSettle: animated skins never settle.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// The big preview at the top of the screen.
MiniBoardPreview _stage(WidgetTester tester) =>
    tester.widgetList<MiniBoardPreview>(find.byType(MiniBoardPreview)).first;

Future<void> _openTab(WidgetTester tester, String label) async {
  await tester.tap(find.descendant(
    of: find.byType(TabBar),
    matching: find.text(label),
  ));
  await _settle(tester);
}

/// A skin that is not owned at the start, so a tap previews it.
const _skin = 'plasma';

void main() {
  testWidgets('a previewed skin stays when an accessory is tried on', (
    tester,
  ) async {
    await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('skin-$_skin')));
    await _settle(tester);
    expect(_stage(tester).style, skinStyleById(_skin));

    await _openTab(tester, 'Accessories');
    expect(
      _stage(tester).style,
      skinStyleById(_skin),
      reason: 'changing the tab keeps the skin on the stage',
    );

    await tester.tap(find.byKey(const ValueKey('accessory-cobweb')));
    await _settle(tester);
    final stage = _stage(tester);
    expect(stage.style, skinStyleById(_skin), reason: 'the skin stays');
    expect(stage.accessory, AccessoryStyle.cobweb, reason: 'and adds the web');
  });

  testWidgets('the cards of another tab show the skin being tried on', (
    tester,
  ) async {
    await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('skin-$_skin')));
    await _settle(tester);
    await _openTab(tester, 'Accessories');

    final card = tester.widget<MiniBoardPreview>(
      find.descendant(
        of: find.byKey(const ValueKey('accessory-crown')),
        matching: find.byType(MiniBoardPreview),
      ),
    );
    expect(card.style, skinStyleById(_skin));
  });

  testWidgets('equipping an owned accessory keeps the skin preview', (
    tester,
  ) async {
    await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('skin-$_skin')));
    await _settle(tester);
    await _openTab(tester, 'Accessories');

    await tester.tap(find.byKey(const ValueKey('accessory-$kNoAccessoryId')));
    await _settle(tester);
    expect(_stage(tester).style, skinStyleById(_skin));
  });

  testWidgets('the buy bar is for the tab that is open', (tester) async {
    final storage = await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('skin-$_skin')));
    await _settle(tester);
    await _openTab(tester, 'Accessories');
    await tester.tap(find.byKey(const ValueKey('accessory-cobweb')));
    await _settle(tester);

    // On the accessories tab, "Buy" buys the cobweb — and only that.
    await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
    await _settle(tester);
    expect(storage.activeCosmetic('accessory', kNoAccessoryId), 'cobweb');
    expect(storage.diamonds, 90);
    expect(
      _stage(tester).style,
      skinStyleById(_skin),
      reason: 'the skin is still being tried on',
    );
  });

  testWidgets('cancelling drops only the preview of the open tab', (
    tester,
  ) async {
    await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('skin-$_skin')));
    await _settle(tester);
    await _openTab(tester, 'Accessories');
    await tester.tap(find.byKey(const ValueKey('accessory-cobweb')));
    await _settle(tester);

    await tester.tap(find.byTooltip('Cancel').first);
    await _settle(tester);
    final stage = _stage(tester);
    expect(stage.accessory, isNot(AccessoryStyle.cobweb));
    expect(stage.style, skinStyleById(_skin), reason: 'the skin stays');

    // With nothing tried on in this tab, the bar is the skin's; cancelling
    // it shows what is equipped.
    await tester.tap(find.byTooltip('Cancel').first);
    await _settle(tester);
    expect(_stage(tester).style, isNot(skinStyleById(_skin)));
  });
}
