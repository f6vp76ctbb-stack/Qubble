// The playtest stands or falls on this screen: a feedback route that needs a
// GitHub account produces no feedback at all, so mail is the primary path and
// both routes have to keep working whichever way kFeedbackEmail is set.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/app_info.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/screens/feedback_screen.dart';

const _address = 'playtest@example.com';

Future<Uri?> _pumpAndSubmit(
  WidgetTester tester, {
  required String email,
  required String text,
  required String buttonLabel,
  bool launchSucceeds = true,
}) async {
  Uri? launched;
  await tester.pumpWidget(MaterialApp(
    localizationsDelegates: L10n.localizationsDelegates,
    supportedLocales: L10n.supportedLocales,
    home: FeedbackScreen(
      email: email,
      launcher: (uri) async {
        launched = uri;
        return launchSucceeds;
      },
    ),
  ));
  if (text.isNotEmpty) {
    await tester.enterText(find.byType(TextField), text);
  }
  await tester.tap(find.text(buttonLabel));
  await tester.pumpAndSettle();
  return launched;
}

void main() {
  group('with a mail address configured', () {
    testWidgets('mail is the primary route', (tester) async {
      final launched = await _pumpAndSubmit(
        tester,
        email: _address,
        text: 'Drehen klemmt',
        buttonLabel: 'Send by email',
      );

      expect(launched, isNotNull);
      expect(launched!.scheme, 'mailto');
      expect(launched.path, _address);
      expect(launched.queryParameters['body'], contains('Drehen klemmt'));
    });

    testWidgets('every report names the build and the platform',
        (tester) async {
      final launched = await _pumpAndSubmit(
        tester,
        email: _address,
        text: 'Ruckelt',
        buttonLabel: 'Send by email',
      );

      final body = launched!.queryParameters['body']!;
      expect(body, contains(AppInfo.version));
      expect(body, contains('Platform:'));
      expect(launched.queryParameters['subject'], contains(AppInfo.version));
    });

    testWidgets('GitHub stays available as a second route', (tester) async {
      final launched = await _pumpAndSubmit(
        tester,
        email: _address,
        text: 'Bombe ruckelt',
        buttonLabel: 'Prefer a GitHub issue',
      );

      expect(launched!.host, 'github.com');
      expect(launched.queryParameters['labels'], 'feedback');
      expect(launched.queryParameters['body'], contains('Bombe ruckelt'));
    });

    testWidgets('a missing mail app points at the other route', (tester) async {
      await _pumpAndSubmit(
        tester,
        email: _address,
        text: 'Test',
        buttonLabel: 'Send by email',
        launchSucceeds: false,
      );

      expect(find.textContaining('No mail app'), findsOneWidget);
    });

    testWidgets('blank text launches nothing on the mail route',
        (tester) async {
      final launched = await _pumpAndSubmit(
        tester,
        email: _address,
        text: '',
        buttonLabel: 'Send by email',
      );

      expect(launched, isNull);
      expect(find.text('Please type something first.'), findsOneWidget);
    });
  });

  group('without a mail address configured', () {
    testWidgets('GitHub becomes the primary route again', (tester) async {
      final launched = await _pumpAndSubmit(
        tester,
        email: '',
        text: 'Bombe ruckelt',
        buttonLabel: 'Send feedback',
      );

      expect(launched!.host, 'github.com');
      expect(launched.queryParameters['body'], contains('Bombe ruckelt'));
      expect(launched.queryParameters['labels'], 'feedback');
    });

    testWidgets('no dead mail button is shown', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const FeedbackScreen(email: ''),
        ),
      );
      expect(find.text('Send by email'), findsNothing);
      expect(find.textContaining('GitHub login'), findsOneWidget);
    });

    testWidgets('a whitespace-only address counts as unset', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const FeedbackScreen(email: '   '),
        ),
      );
      expect(find.text('Send by email'), findsNothing);
      expect(find.text('Send feedback'), findsOneWidget);
    });

    testWidgets('blank feedback does not launch anything', (tester) async {
      final launched = await _pumpAndSubmit(
        tester,
        email: '',
        text: '',
        buttonLabel: 'Send feedback',
      );

      expect(launched, isNull);
      expect(find.text('Please type something first.'), findsOneWidget);
    });
  });
}
