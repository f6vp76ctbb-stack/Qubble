import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/designs_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/mini_board_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _app(Widget home) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  return ProviderScope(
    overrides: [storageProvider.overrideWithValue(storage)],
    child: MaterialApp(
      theme: buildGridTheme(),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: home,
    ),
  );
}

void main() {
  testWidgets('designs screen shows a mini board preview per theme',
      (tester) async {
    await tester.pumpWidget(await _app(const DesignsScreen()));
    await tester.pump(const Duration(milliseconds: 500));
    // The stage on top plus one card per theme; the grid builds lazily, so
    // only the visible cards exist in the test viewport.
    expect(find.byType(MiniBoardPreview), findsAtLeastNWidgets(4));
    expect(tester.takeException(), isNull);
  });

  testWidgets('designs screen shows a mini board preview per skin',
      (tester) async {
    await tester.pumpWidget(
      await _app(const DesignsScreen(initialTab: 1)),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(MiniBoardPreview), findsAtLeastNWidgets(4));
    expect(tester.takeException(), isNull);
  });
}
