/// End-to-end check that the German translation actually reaches the screen.
///
/// `translations_test.dart` guards the ARB pair; this guards the wiring around
/// it — delegates, locale resolution and the id-to-text maps. Without it, a
/// screen could silently render English for a German player and every other
/// test would still pass, because they all run in the default locale.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _app(Widget home, {required Locale locale}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  return ProviderScope(
    overrides: [storageProvider.overrideWithValue(storage)],
    child: MaterialApp(
      theme: buildGridTheme(),
      locale: locale,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      localeResolutionCallback: resolveAppLocale,
      home: home,
    ),
  );
}

void main() {
  testWidgets('the home screen renders German for a German device', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      await _app(const HomeScreen(), locale: const Locale('de')),
    );
    await tester.pump();

    expect(find.text('Spielen'), findsOneWidget);
    expect(find.text('BESTWERT'), findsOneWidget);
    expect(find.text('Tägliche Challenge'), findsOneWidget);
    expect(find.text('Rätsel-Modus'), findsOneWidget);
  });

  testWidgets('the same screen renders English for an English device', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      await _app(const HomeScreen(), locale: const Locale('en')),
    );
    await tester.pump();

    expect(find.text('Play'), findsOneWidget);
    expect(find.text('BEST SCORE'), findsOneWidget);
    expect(find.text('Daily Challenge'), findsOneWidget);
    expect(find.text('Puzzle Mode'), findsOneWidget);
  });

  testWidgets('an untranslated device language falls back to English', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Japanese has no translation; the player must not land in German just
    // because 'de' sorts before 'en' in the generated locale list.
    await tester.pumpWidget(
      await _app(const HomeScreen(), locale: const Locale('ja')),
    );
    await tester.pump();

    expect(find.text('Play'), findsOneWidget);
    expect(find.text('Spielen'), findsNothing);
  });

  testWidgets('settings offers the language choice in both languages', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      await _app(const SettingsScreen(), locale: const Locale('de')),
    );
    await tester.pump();

    expect(find.text('Sprache'), findsWidgets);
    // Closed, the dropdown shows only the current choice: follow the device.
    expect(find.text('Systemsprache'), findsOneWidget);

    await tester.tap(find.text('Systemsprache'));
    await tester.pumpAndSettle();

    // Open, it offers the languages as endonyms, so a player can find theirs
    // even when the app is currently showing one they cannot read.
    expect(find.text('English'), findsWidgets);
    expect(find.text('Deutsch'), findsWidgets);
  });
}
