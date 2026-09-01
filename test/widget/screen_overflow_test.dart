import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/achievements_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/how_to_play_screen.dart';
import 'package:gridpop/ui/screens/missions_screen.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/screens/stats_screen.dart';
import 'package:gridpop/ui/screens/themes_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Renders every menu screen on the tightest phone the game targets and fails
/// on any layout overflow.
///
/// compact_layout_test.dart covers the home and game screens at three sizes.
/// The secondary screens were in no layout test at all, and three of them
/// overflowed at the default font size: achievements by 177 logical pixels,
/// themes by 122 in German, and every stat card by 14 at the bottom. Their
/// line coverage — 1.3%, 2.6% and 0.8% — is why nobody noticed.
///
/// Both languages run, because German is materially longer: themes overflowed
/// five times further in German than in English.
///
/// Every screen also runs at three larger system font sizes. Android's
/// accessibility settings go well past 1.0, and 1.3 is only the first step up
/// from the factory default — the home screen used to lose its title there,
/// and the stats screen clipped by 176 pixels at 2.0 in German. Two of the
/// three causes were in text that had never been given room to shrink; the
/// third was a grid asking for a fixed cell height.
Future<List<String>> _overflowsOn(
  WidgetTester tester,
  Widget screen,
  Locale locale, [
  double textScale = 1.0,
]) async {
  SharedPreferences.setMockInitialValues({});
  final storage = Storage(await SharedPreferences.getInstance());

  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final overflows = <String>[];
  final previous = FlutterError.onError;
  FlutterError.onError = (details) {
    final text = details.exceptionAsString();
    if (text.contains('overflowed')) overflows.add(text.split('\n').first);
  };
  try {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [storageProvider.overrideWithValue(storage)],
        child: MaterialApp(
          theme: buildGridTheme(),
          locale: locale,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          localeResolutionCallback: resolveAppLocale,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          home: screen,
        ),
      ),
    );
    // Not pumpAndSettle: the home screen animates its particles forever.
    await tester.pump(const Duration(milliseconds: 400));
  } finally {
    FlutterError.onError = previous;
  }
  return overflows;
}

void main() {
  final screens = <String, Widget Function()>{
    'home': () => const HomeScreen(),
    'settings': () => const SettingsScreen(),
    'shop': () => const ShopScreen(),
    'how to play': () => const HowToPlayScreen(),
    'stats': () => const StatsScreen(),
    'achievements': () => const AchievementsScreen(),
    'missions': () => const MissionsScreen(),
    'themes': () => const ThemesScreen(),
  };

  for (final scale in [1.0, 1.3, 1.5, 2.0]) {
    for (final locale in [const Locale('en'), const Locale('de')]) {
      for (final entry in screens.entries) {
        testWidgets(
          'the ${entry.key} screen fits a 360x640 phone in '
          '${locale.languageCode} at text scale $scale',
          (tester) async {
            final overflows =
                await _overflowsOn(tester, entry.value(), locale, scale);
            expect(
              overflows,
              isEmpty,
              reason: 'the ${entry.key} screen overflows in '
                  '${locale.languageCode} at scale $scale:\n  '
                  '${overflows.join('\n  ')}',
            );
          },
        );
      }
    }
  }
}
