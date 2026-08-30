import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Widget> _homeApp() async {
  SharedPreferences.setMockInitialValues({'onboardingDone': true});
  final storage = await Storage.create();
  return ProviderScope(
    overrides: [storageProvider.overrideWithValue(storage)],
    child: MaterialApp(
      theme: buildGridTheme(),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: const HomeScreen(),
    ),
  );
}

void main() {
  testWidgets('home help opens the complete how-to guide', (tester) async {
    await tester.pumpWidget(await _homeApp());

    final helpButton = find.byTooltip('How to play Qubble');
    expect(helpButton, findsOneWidget);

    await tester.tap(helpButton);
    await tester.pumpAndSettle();

    expect(find.text('How to play Qubble'), findsOneWidget);
    expect(find.text('Drag & place'), findsOneWidget);
    expect(find.text('Clear lines'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.fling(find.byType(ListView), const Offset(0, -1200), 2000);
    await tester.pumpAndSettle();
    expect(find.text('Fill the piggy bank'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Got it'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(helpButton, findsOneWidget);
  });
}
