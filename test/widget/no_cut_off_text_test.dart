// No label on a menu screen may end in "…" on a 360 dp phone — at the default
// font size or at twice it.
//
// screen_overflow_test.dart cannot see this: an ellipsis is not an error, and
// it measures with the test font, whose square glyphs are far wider than
// Nunito's. Measured with the real font, the daily card cut its status in
// English ("6-day streak · Open t…"), every stat card cut its label at a
// larger system font ("Wyczyszczone rz…"), the home screen cut the XP, the
// weekend bonus and the next reward, and two titles lost their ends
// ("Comment jouer à Q…"). Each now wraps or shrinks instead.
//
// Only the languages Nunito can draw run here: the others use the phone's own
// fonts (lib/ui/locale.dart), which a test machine does not have. The weekend
// banner shows only on Saturdays and Sundays, so it is covered on those days.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/achievements_screen.dart';
import 'package:gridpop/ui/screens/daily_screen.dart';
import 'package:gridpop/ui/screens/feedback_screen.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/how_to_play_screen.dart';
import 'package:gridpop/ui/screens/missions_screen.dart';
import 'package:gridpop/ui/screens/puzzle_levels_screen.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/screens/skins_screen.dart';
import 'package:gridpop/ui/screens/stats_screen.dart';
import 'package:gridpop/ui/screens/themes_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

Future<void> _loadNunito() async {
  final bytes = File('assets/fonts/Nunito.ttf').readAsBytesSync();
  // Material widgets that fall back to the platform default would otherwise
  // measure in the test font.
  for (final family in ['Nunito', 'Roboto']) {
    await (FontLoader(
      family,
    )..addFont(Future.value(ByteData.sublistView(bytes)))).load();
  }
}

/// A player some way in: a running streak, a level with a reward ahead and a
/// five-figure best score, so every conditional label is on screen.
Future<Storage> _player() async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  await storage.setPlayerName('Puzzlerin');
  await storage.setHighscore(18740);
  await storage.setCoins(2480);
  await storage.setDiamonds(12);
  await storage.setPlayerLevel(14);
  await storage.setXp(120);
  await storage.setStreak(6);
  await storage.setOnboardingDone(true);
  return storage;
}

const _scales = [1.0, 1.3, 2.0];

Widget _app(Widget home, Locale locale, double scale) => MaterialApp(
  theme: buildGridTheme(),
  locale: locale,
  localizationsDelegates: L10n.localizationsDelegates,
  supportedLocales: L10n.supportedLocales,
  builder: (context, child) => MediaQuery(
    data: MediaQuery.of(
      context,
    ).copyWith(textScaler: TextScaler.linear(scale)),
    child: child!,
  ),
  home: home,
);

/// Menu screens get a tall view, so every list lays out all its rows; the
/// width is what decides whether a label fits. The game fills the screen, so
/// it gets a real phone.
Future<void> _pump(
  WidgetTester tester,
  Widget app, {
  Size size = const Size(360, 2400),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  // Not pumpAndSettle: the home screen animates its particles forever.
  await tester.pump(const Duration(milliseconds: 400));
}

void _expectNothingCut(WidgetTester tester) {
  final cut = [
    for (final paragraph in tester.allRenderObjects.whereType<RenderParagraph>())
      if (paragraph.didExceedMaxLines) paragraph.text.toPlainText(),
  ];
  expect(cut, isEmpty, reason: 'cut off: ${cut.join(' | ')}');
}

void main() {
  setUpAll(_loadNunito);

  final screens = <String, Widget Function()>{
    'home': () => const HomeScreen(),
    'settings': () => const SettingsScreen(),
    'shop': () => const ShopScreen(),
    'how to play': () => const HowToPlayScreen(),
    'stats': () => const StatsScreen(),
    'achievements': () => const AchievementsScreen(),
    'missions': () => const MissionsScreen(),
    'themes': () => const ThemesScreen(),
    'skins': () => const SkinsScreen(),
    'daily': () => const DailyScreen(),
    'puzzle levels': () => const PuzzleLevelsScreen(),
    'feedback': () => const FeedbackScreen(email: 'test@example.com'),
  };

  final locales = L10n.supportedLocales.where(
    (locale) => !kNativeOnlyLanguages.contains(locale.languageCode),
  );

  for (final scale in _scales) {
    for (final locale in locales) {
      for (final entry in screens.entries) {
        testWidgets('nothing on the ${entry.key} screen is cut off in '
            '${localeCode(locale)} at text scale $scale', (tester) async {
          final storage = await _player();
          await _pump(
            tester,
            ProviderScope(
              overrides: [storageProvider.overrideWithValue(storage)],
              child: _app(entry.value(), locale, scale),
            ),
          );
          _expectNothingCut(tester);
        });
      }

      // The game itself: mid-run, and over — in the endless run and in the
      // daily, whose HUD and game-over card carry extra labels.
      for (final (stage, daily, toTheEnd) in [
        ('mid-run', false, false),
        ('game over', false, true),
        ('daily mid-run', true, false),
        ('daily game over', true, true),
      ]) {
        testWidgets('nothing in the game ($stage) is cut off in '
            '${localeCode(locale)} at text scale $scale', (tester) async {
          final storage = await _player();
          // A best of 1, so the run ends on a new record: the fullest the
          // game-over card gets.
          await storage.setHighscore(1);
          final container = ProviderContainer(
            overrides: [
              storageProvider.overrideWithValue(storage),
              gameClockProvider.overrideWithValue(SteppingClock().call),
            ],
          );
          addTearDown(container.dispose);
          await _pump(
            tester,
            UncontrolledProviderScope(
              container: container,
              child: _app(const GameScreen(), locale, scale),
            ),
            size: const Size(360, 640),
          );

          final c = container.read(gameControllerProvider.notifier);
          if (daily) {
            c.startDaily();
          } else {
            c.newGame(seed: 4242);
          }
          if (toTheEnd) {
            playToGameOver(c);
            expect(c.state.gameOver, isTrue, reason: 'the harness never lost');
          } else {
            for (var i = 0; i < 12; i++) {
              placeSomething(c);
            }
          }
          // Not pumpAndSettle: the level-up glow and particles may animate on.
          for (var i = 0; i < 10; i++) {
            await tester.pump(const Duration(milliseconds: 100));
          }
          _expectNothingCut(tester);
        });
      }
    }
  }
}
