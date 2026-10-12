// Every design category shows together (owner, 12.10.2026): "Themes, Block
// Skins, Accessoires müssen, wenn man bei jedem eins ausrüstet, alle
// angezeigt werden." The puzzle mode drew plain blocks with neither skin nor
// accessory, and the theme and skin cards (designs screen, shop) left the
// equipped accessory off.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/accessory.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/screens/puzzle_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/mini_board_preview.dart';
import 'package:gridpop/ui/widgets/piece_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wood theme, glossy skin, cobweb: one of each category equipped.
const _equipped = <String, Object>{
  'onboardingDone': true,
  'activeTheme': 'wood',
  'unlockedThemes': ['classic', 'wood'],
  'activeSkin': 'glossy',
  'unlockedSkins': ['classic', 'glossy'],
  'cosmetic.accessory.active': 'cobweb',
  'cosmetic.accessory.unlocked': ['none', 'cobweb'],
};

Future<void> _pump(WidgetTester tester, Widget home) async {
  SharedPreferences.setMockInitialValues(_equipped);
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
        home: home,
      ),
    ),
  );
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  for (final tab in [0, 1]) {
    testWidgets('designs tab $tab: every card wears the accessory', (
      tester,
    ) async {
      await _pump(tester, DesignsScreen(initialTab: tab));
      final previews = tester.widgetList<MiniBoardPreview>(
        find.byType(MiniBoardPreview),
      );
      expect(previews, isNotEmpty);
      for (final p in previews) {
        expect(p.accessory, AccessoryStyle.cobweb);
      }
    });
  }

  testWidgets('shop: every design preview wears the accessory', (
    tester,
  ) async {
    await _pump(tester, const ShopScreen());
    final previews = tester.widgetList<MiniBoardPreview>(
      find.byType(MiniBoardPreview),
    );
    expect(previews, isNotEmpty);
    for (final p in previews) {
      expect(p.accessory, AccessoryStyle.cobweb);
    }
  });

  testWidgets('puzzle: the pieces wear the skin and the accessory', (
    tester,
  ) async {
    await _pump(tester, const PuzzleScreen(level: 0));
    final pieces = tester.widgetList<PieceView>(find.byType(PieceView));
    expect(pieces, isNotEmpty);
    final current = pieces.first;
    expect(current.skin, skinStyleById('glossy'));
    expect(current.accessory, AccessoryStyle.cobweb);
  });
}
