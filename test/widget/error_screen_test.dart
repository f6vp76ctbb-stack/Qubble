// Flutter's release-mode ErrorWidget is a grey rectangle with no text, which
// makes a tester's "it went grey" report unusable. These pin the replacement.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/widgets/error_screen.dart';

FlutterErrorDetails _details([Object? exception]) => FlutterErrorDetails(
      exception: exception ?? Exception('Board konnte nicht gezeichnet werden'),
      library: 'qubble',
    );

/// The test binding asserts ErrorWidget.builder is back to the default by the
/// end of each test body, so it has to be restored inside the body — a
/// tearDown runs too late.
Future<void> withInstalledErrorScreen(Future<void> Function() body) async {
  final original = ErrorWidget.builder;
  try {
    installErrorScreen();
    await body();
  } finally {
    ErrorWidget.builder = original;
  }
}

void main() {
  testWidgets('shows a readable cause instead of a blank surface',
      (tester) async {
    await tester.pumpWidget(ErrorScreen(details: _details()));

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(
      find.textContaining('Board konnte nicht gezeichnet werden'),
      findsOneWidget,
    );
    expect(find.textContaining('into your feedback'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders without an ambient MaterialApp or Directionality',
      (tester) async {
    // ErrorWidget.builder can fire before the app itself is built.
    await tester.pumpWidget(ErrorScreen(details: _details()));
    expect(tester.takeException(), isNull);
  });

  testWidgets('offers no reset when none was wired', (tester) async {
    await tester.pumpWidget(ErrorScreen(details: _details()));
    expect(find.text('Reset progress'), findsNothing);
  });

  testWidgets('the reset runs once and reports back', (tester) async {
    var calls = 0;
    await tester.pumpWidget(
      ErrorScreen(
        details: _details(),
        onReset: () async => calls++,
      ),
    );

    await tester.tap(find.text('Reset progress'));
    await tester.pumpAndSettle();

    expect(calls, 1);
    expect(
      find.textContaining('Progress reset'),
      findsOneWidget,
    );
  });

  testWidgets('a failing reset leaves the button usable again', (tester) async {
    var calls = 0;
    await tester.pumpWidget(
      ErrorScreen(
        details: _details(),
        onReset: () async {
          calls++;
          throw Exception('prefs unavailable');
        },
      ),
    );

    await tester.tap(find.text('Reset progress'));
    await tester.pumpAndSettle();

    expect(calls, 1);
    expect(find.text('Reset progress'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a very long exception is truncated, not overflowed',
      (tester) async {
    await tester.pumpWidget(
      ErrorScreen(details: _details(Exception('x' * 5000))),
    );
    expect(tester.takeException(), isNull);
    expect(find.textContaining('…'), findsOneWidget);
  });

  testWidgets('installErrorScreen replaces the default builder',
      (tester) async {
    await withInstalledErrorScreen(() async {
      expect(ErrorWidget.builder(_details()), isA<ErrorScreen>());
    });
  });

  testWidgets('a broken widget renders the error screen in-tree',
      (tester) async {
    await withInstalledErrorScreen(() async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: Builder(
            builder: (context) => throw Exception('kaputtes Widget'),
          ),
        ),
      );
      // The thrown build error is expected; consume it.
      expect(tester.takeException(), isNotNull);
      expect(find.text('Something went wrong'), findsOneWidget);
    });
  });
}
