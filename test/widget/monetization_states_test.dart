// The monetization surfaces, in the states a player actually meets
// (MASTERPLAN.md D.6). Controller tests already cover what the buttons do;
// these cover what is on screen before anyone presses anything, because the
// rules CLAUDE.md calls non-negotiable are mostly rules about what must NOT
// appear — and an absence is what a refactor removes unnoticed.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/piggy_bank.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/monetization/iap.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> _pump(
  WidgetTester tester,
  Widget home, {
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final storage = await Storage.create();
  tester.view.physicalSize = const Size(500, 1800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        storageProvider.overrideWithValue(storage),
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
        home: home,
      ),
    ),
  );
  // The home screen animates its menu particles forever, so settle is not an
  // option here.
  await tester.pump(const Duration(milliseconds: 400));
  return storage;
}

void main() {
  group('shop', () {
    testWidgets('the supporter pack shows a price until it is owned',
        (tester) async {
      await _pump(tester, const ShopScreen());

      expect(find.text('Active'), findsNothing);
      expect(find.byType(FilledButton), findsWidgets);
    });

    testWidgets('an owned supporter pack cannot be bought again',
        (tester) async {
      await _pump(tester, const ShopScreen(), prefs: {'supporter': true});

      // Non-consumable: offering "buy" again would charge for nothing.
      expect(find.text('Active'), findsOneWidget);
    });

    testWidgets('coin packs stay buyable for a supporter', (tester) async {
      // Consumables, unlike the pack itself -- owning the supporter pack must
      // not hide them.
      await _pump(tester, const ShopScreen(), prefs: {'supporter': true});

      expect(find.byType(FilledButton), findsWidgets);
      expect(IapProducts.isConsumable(IapProducts.coinsS), isTrue);
    });
  });

  group('piggy bank', () {
    // CLAUDE.md: the piggy bank is a reward, never a purchase. A full one pays
    // out free; opening early is an optional video. Neither may become a sale.

    Future<void> openPiggy(WidgetTester tester) async {
      await tester.tap(find.byIcon(Icons.savings_rounded).first);
      await tester.pump(const Duration(milliseconds: 400));
    }

    testWidgets('an empty bank explains itself instead of opening a dialog',
        (tester) async {
      await _pump(tester, const HomeScreen(), prefs: {'piggyCoins': 0});
      await openPiggy(tester);

      expect(find.byType(AlertDialog), findsNothing);
      expect(find.textContaining('fills up while you clear rows'),
          findsOneWidget);
    });

    testWidgets('a part-filled bank offers the optional early open',
        (tester) async {
      await _pump(tester, const HomeScreen(), prefs: {
        'piggyCoins': 50,
        'piggyCapacity': PiggyBank.baseCapacity,
      });
      await openPiggy(tester);

      expect(find.byType(AlertDialog), findsOneWidget);
      // "or open it early with a bonus video" -- optional, and it is the only
      // ad-shaped thing the piggy may ever offer.
      expect(find.textContaining('bonus video'), findsOneWidget);
    });

    testWidgets('a full bank pays out free, with no video and no price',
        (tester) async {
      await _pump(tester, const HomeScreen(), prefs: {
        'piggyCoins': PiggyBank.baseCapacity,
        'piggyCapacity': PiggyBank.baseCapacity,
      });
      await openPiggy(tester);

      expect(find.text('Piggy bank is full!'), findsOneWidget);
      expect(find.text('Collect'), findsOneWidget);
      // The moment this offers a video or a price, the piggy has become a
      // product -- which CLAUDE.md rules out.
      expect(find.textContaining('bonus video'), findsNothing);
      expect(find.textContaining('€'), findsNothing);
    });
  });
}
