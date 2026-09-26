// Small labels such as "BEST SCORE" are letterspaced. That suits Latin,
// Cyrillic and CJK, but it tears Arabic (joined letters), Hindi and Thai
// (marks stacked on consonants) apart — the Hindi screenshots showed
// "सर्वश्रेष्ठ" in broken pieces.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/theme.dart';

Future<double> _trackingIn(WidgetTester tester, String language) async {
  late double tracking;
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale(language),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: Builder(
        builder: (context) {
          tracking = labelTracking(context, 2);
          return const SizedBox();
        },
      ),
    ),
  );
  return tracking;
}

void main() {
  for (final language in ['en', 'de', 'uk', 'ja', 'zh']) {
    testWidgets('$language labels keep their tracking', (tester) async {
      expect(await _trackingIn(tester, language), 2);
    });
  }

  for (final language in ['ar', 'hi', 'th', 'ur']) {
    testWidgets('$language labels are not letterspaced', (tester) async {
      expect(await _trackingIn(tester, language), 0);
    });
  }
}
