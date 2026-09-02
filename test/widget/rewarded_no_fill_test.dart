// Every voluntary rewarded offer used to be fire-and-forget. With no ad loaded
// — no fill, offline, consent declined — the player tapped and nothing at all
// happened. For the single ad format in a game whose whole monetization pitch
// is "always optional, always honest", a button that looks broken is the worst
// possible shape.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/rewarded_action.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// No ad is ever loaded — the state a player hits on a bad connection or with
/// no fill in their country.
class _NoFillAds implements AdService {
  int shown = 0;

  @override
  bool get rewardedReady => false;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> showRewarded() async {
    shown++;
    return false;
  }

  @override
  Future<bool> showPrivacyOptions() async => false;
}

class _ReadyAds extends FakeAdService {
  int shown = 0;

  @override
  Future<bool> showRewarded() async {
    shown++;
    return true;
  }
}

Future<({Widget widget, GameController controller})> _harness(
  AdService ads,
) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      adServiceProvider.overrideWithValue(ads),
    ],
  );
  final controller = container.read(gameControllerProvider.notifier);
  return (
    widget: UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => runRewardedAction(
                context,
                available: controller.rewardedAvailable,
                action: controller.luckyBlock,
              ),
              child: const Text('offer'),
            ),
          ),
        ),
      ),
    ),
    controller: controller,
  );
}

void main() {
  testWidgets('with no ad loaded the offer says so and shows no video', (
    tester,
  ) async {
    final ads = _NoFillAds();
    final h = await _harness(ads);
    await tester.pumpWidget(h.widget);
    await tester.tap(find.text('offer'));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(
      find.text('No video available right now — try again in a moment'),
      findsOneWidget,
    );
    // Nothing was requested: the offer was refused before the ad call.
    expect(ads.shown, 0);
  });

  testWidgets('with an ad loaded the offer runs and stays quiet', (
    tester,
  ) async {
    final ads = _ReadyAds();
    final h = await _harness(ads);
    await tester.pumpWidget(h.widget);
    await tester.tap(find.text('offer'));
    await tester.pumpAndSettle();

    expect(ads.shown, 1);
    // A video that ran is its own feedback.
    expect(find.byType(SnackBar), findsNothing);
  });

  test('readiness is reported honestly by both ad services', () {
    // FakeAdService always grants, so it must always look ready; the real
    // service must not claim readiness without consent AND a loaded ad.
    expect(FakeAdService().rewardedReady, isTrue);
    expect(GoogleAdService().rewardedReady, isFalse);
  });

  test('every rewarded entry point can report readiness', () {
    // Five offers exist across two controllers. The puzzle one was missed on
    // the first pass precisely because it lives on the other controller, so
    // this pins the surface rather than the four that were easy to find.
    final source = <String, String>{
      'game_screen': File('lib/ui/screens/game_screen.dart').readAsStringSync(),
      'home_screen': File('lib/ui/screens/home_screen.dart').readAsStringSync(),
      'puzzle_screen':
          File('lib/ui/screens/puzzle_screen.dart').readAsStringSync(),
    };
    // Every rewarded call in a screen goes through the helper, never straight
    // at the controller method.
    for (final entry in source.entries) {
      for (final call in [
        'luckyBlock',
        'doubleCoinsWithAd',
        'doubleDailyRewardWithAd',
        'openPiggyWithAd',
        'extraMoveWithAd',
      ]) {
        if (!entry.value.contains(call)) continue;
        expect(
          entry.value,
          contains('runRewardedAction'),
          reason: '${entry.key} calls $call outside the helper',
        );
      }
    }
  });
}
