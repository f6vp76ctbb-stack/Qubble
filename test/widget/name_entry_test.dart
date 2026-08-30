import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/screens/name_entry_screen.dart';

void main() {
  testWidgets('submits a valid name', (tester) async {
    String? saved;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: NameEntryScreen(onSubmit: (n) async => saved = n),
    ));

    await tester.enterText(find.byType(TextField), '  Max  ');
    await tester.tap(find.text("Let's go"));
    await tester.pump();

    expect(saved, 'Max');
  });

  testWidgets('rejects a too-short name', (tester) async {
    var calls = 0;
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: NameEntryScreen(onSubmit: (n) async => calls++),
    ));

    await tester.enterText(find.byType(TextField), 'M');
    await tester.tap(find.text("Let's go"));
    await tester.pump();

    expect(calls, 0);
    expect(find.text('At least 2 characters.'), findsOneWidget);
  });
}
