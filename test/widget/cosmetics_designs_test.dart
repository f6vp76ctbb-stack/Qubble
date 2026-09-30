// Accessories and explosions on the designs screen (owner, 30.09.2026):
// a tab each, a locked one previews on the stage with its price, and
// buying equips it.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/accessory.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/burst_style.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/clear_burst.dart';
import 'package:gridpop/ui/widgets/mini_board_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> _pump(WidgetTester tester, {required int tab}) async {
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

/// Not pumpAndSettle: the explosion previews loop forever.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('an accessory: preview, buy for 60 diamonds, worn', (
    tester,
  ) async {
    final storage = await _pump(tester, tab: 2);
    expect(find.text('Accessories'), findsOneWidget);
    for (final name in ['None', 'Cobweb', 'Snow cap', 'Crown']) {
      expect(find.text(name), findsWidgets, reason: name);
    }

    await tester.tap(find.text('Cobweb'));
    await _settle(tester);
    final stage = tester.widgetList<MiniBoardPreview>(
      find.byType(MiniBoardPreview),
    );
    expect(
      stage.first.accessory,
      AccessoryStyle.cobweb,
      reason: 'the stage wears the previewed accessory',
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
    await _settle(tester);
    expect(storage.diamonds, 90);
    expect(storage.activeCosmetic('accessory', kNoAccessoryId), 'cobweb');
  });

  testWidgets('an explosion: the stage plays it, buying costs 100', (
    tester,
  ) async {
    final storage = await _pump(tester, tab: 3);
    expect(find.text('Explosions'), findsOneWidget);
    expect(find.text('Confetti'), findsOneWidget);

    await tester.tap(find.text('Confetti'));
    await _settle(tester);
    final stage = tester.widgetList<BurstPreview>(find.byType(BurstPreview));
    expect(stage.first.style, BurstStyle.confetti);

    await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
    await _settle(tester);
    expect(storage.diamonds, 50);
    expect(storage.activeCosmetic('burst', kDefaultBurstId), 'confetti');
  });

  testWidgets('every accessory and explosion paints', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Wrap(
          children: [
            for (final a in AccessoryStyle.values)
              MiniBoardPreview(
                theme: themeById(kDefaultThemeId),
                style: BlockSkinStyle.solid,
                accessory: a,
              ),
            for (final b in BurstStyle.values)
              BurstPreview(
                style: b,
                color: const Color(0xFF4FE0C6),
                background: const Color(0xFF191B40),
                animate: false,
              ),
          ],
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
