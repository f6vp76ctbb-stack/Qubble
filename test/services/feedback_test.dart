import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/feedback.dart';

void main() {
  group('buildFeedbackIssueUri', () {
    test('returns null for blank text', () {
      expect(buildFeedbackIssueUri(''), isNull);
      expect(buildFeedbackIssueUri('   \n  '), isNull);
    });

    test('targets the repo new-issue endpoint with the feedback label', () {
      final uri = buildFeedbackIssueUri('Tolle App')!;
      expect(uri.scheme, 'https');
      expect(uri.host, 'github.com');
      expect(uri.path, '/f6vp76ctbb-stack/mobile-game/issues/new');
      expect(uri.queryParameters['labels'], kFeedbackLabel);
    });

    test('title uses the first line, prefixed and clipped', () {
      final short = buildFeedbackIssueUri('Bombe ruckelt\nmehr Details')!;
      expect(short.queryParameters['title'], 'Feedback: Bombe ruckelt');

      final long = buildFeedbackIssueUri('x' * 100)!;
      final title = long.queryParameters['title']!;
      expect(title.startsWith('Feedback: '), isTrue);
      expect(title.endsWith('…'), isTrue);
      expect(title.length, lessThanOrEqualTo('Feedback: '.length + 60));
    });

    test('body carries the full text plus the context block', () {
      final uri = buildFeedbackIssueUri(
        'Zeile eins\nZeile zwei',
        context: {'Plattform': 'Web/PWA'},
      )!;
      final body = uri.queryParameters['body']!;
      expect(body, contains('Zeile eins'));
      expect(body, contains('Zeile zwei'));
      expect(body, contains('- Plattform: Web/PWA'));
    });

    test('honours a custom target', () {
      final uri = buildFeedbackIssueUri(
        'hi',
        target: const FeedbackTarget(owner: 'me', repo: 'thing'),
      )!;
      expect(uri.path, '/me/thing/issues/new');
    });
  });

  group('buildFeedbackMailUri', () {
    const to = 'playtest@example.com';

    test('returns null without text or without an address', () {
      expect(buildFeedbackMailUri('', address: to), isNull);
      expect(buildFeedbackMailUri('   \n ', address: to), isNull);
      expect(buildFeedbackMailUri('Hallo', address: ''), isNull);
      expect(buildFeedbackMailUri('Hallo', address: '   '), isNull);
    });

    test('builds a mailto with the address as the path', () {
      final uri = buildFeedbackMailUri('Drehen klemmt', address: to)!;
      expect(uri.scheme, 'mailto');
      expect(uri.path, to);
    });

    test('the subject names the build so a report can be placed', () {
      final uri = buildFeedbackMailUri(
        'Ruckelt',
        address: to,
        context: {'Version': '1.0.0+7'},
      )!;
      expect(uri.queryParameters['subject'], 'Qubble Feedback (1.0.0+7)');
    });

    test('falls back to a plain subject without a version', () {
      final uri = buildFeedbackMailUri('Ruckelt', address: to)!;
      expect(uri.queryParameters['subject'], 'Qubble Feedback');
    });

    test('body keeps the text and appends the context block', () {
      final uri = buildFeedbackMailUri(
        'Zeile eins\nZeile zwei',
        address: to,
        context: {'Version': '1.0.0+2', 'Plattform': 'android'},
      )!;
      final body = uri.queryParameters['body']!;
      expect(body, contains('Zeile eins'));
      expect(body, contains('Zeile zwei'));
      expect(body, contains('Version: 1.0.0+2'));
      expect(body, contains('Plattform: android'));
    });

    test('umlauts and newlines survive encoding intact', () {
      // Uri(scheme:) percent-encodes; Uri.parse on a raw string would not,
      // and German feedback is full of umlauts.
      const text = 'Beim Drehen größerer Stücke ruckelt es\nBitte prüfen';
      final uri = buildFeedbackMailUri(text, address: to)!;
      expect(uri.toString(), isNot(contains('ö')));
      expect(uri.toString(), isNot(contains('\n')));
      expect(Uri.parse(uri.toString()).queryParameters['body'],
          contains('größerer Stücke'));
      expect(Uri.parse(uri.toString()).queryParameters['body'],
          contains('Bitte prüfen'));
    });

    test('an address with a plus tag round-trips', () {
      final uri = buildFeedbackMailUri('hi', address: 'me+qubble@example.com')!;
      expect(Uri.parse(uri.toString()).path, 'me+qubble@example.com');
    });

    test('hasFeedbackEmail reflects the configured constant', () {
      expect(hasFeedbackEmail, kFeedbackEmail.trim().isNotEmpty);
    });
  });
}
