import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/feedback.dart';

void main() {
  group('buildReportMailUri', () {
    test('addresses the operator and names what is being reported', () {
      final uri = buildReportMailUri('BadName', score: 4200)!;

      expect(uri.scheme, 'mailto');
      expect(uri.path, kFeedbackEmail);
      expect(uri.queryParameters['body'], contains('BadName'));
      expect(uri.queryParameters['body'], contains('4200'));
    });

    test('keeps the reported name out of the subject line', () {
      // A 14-character name is attacker-chosen text, and a subject is the part
      // most likely to end up somewhere unescaped.
      final uri = buildReportMailUri('<script>x')!;
      expect(uri.queryParameters['subject'], isNot(contains('script')));
      expect(uri.queryParameters['subject'], 'Qubble: report a leaderboard name');
    });

    test('percent-encodes umlauts and newlines rather than breaking the link',
        () {
      final uri = buildReportMailUri('Grüße', score: 7)!;
      // Uri does the encoding; the round trip is what matters.
      expect(Uri.parse(uri.toString()).queryParameters['body'],
          contains('Grüße'));
    });

    test('carries the build context when given', () {
      final uri = buildReportMailUri('X_Y', context: {'Version': '1.1.0+4'})!;
      expect(uri.queryParameters['body'], contains('1.1.0+4'));
    });

    test('returns null for a blank name or an unset address', () {
      expect(buildReportMailUri('   '), isNull);
      expect(buildReportMailUri('Name', address: ''), isNull);
      expect(buildReportMailUri('Name', address: '   '), isNull);
    });

    test('omits the score line when there is none', () {
      final uri = buildReportMailUri('Name')!;
      expect(uri.queryParameters['body'], isNot(contains('Score:')));
    });
  });
}
