// Bengali, Marathi and Nepali default to digits of their own script; the app
// writes 0–9 everywhere so a screen never mixes two digit systems.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/format.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:intl/intl.dart';

// Any decimal digit of any script other than 0–9.
final _nonLatinDigit = RegExp(r'(?![0-9])\p{Nd}', unicode: true);

void main() {
  test('bn, mr and ne would get digits of their own without it', () {
    // Guards the guard: if intl ever defaulted to 0–9 here, or the pattern
    // missed these digits, the tests below would pass without
    // useLatinDigits doing anything.
    for (final code in ['bn', 'mr', 'ne']) {
      final seven = NumberFormat.decimalPattern(code).format(7);
      expect(seven.contains(_nonLatinDigit), isTrue, reason: '$code: $seven');
    }
  });

  group('after useLatinDigits', () {
    setUpAll(useLatinDigits);

    test('every app language groups a score in 0–9', () {
      for (final locale in L10n.supportedLocales) {
        final code = localeCode(locale);
        final text = formatCount(1234567, locale: code);
        expect(
          text.contains(_nonLatinDigit),
          isFalse,
          reason: '$code formats 1234567 as "$text"',
        );
      }
    });

    test('generated strings format their counts in 0–9 too', () {
      for (final locale in L10n.supportedLocales) {
        final l10n = lookupL10n(locale);
        final text = l10n.missionClearRows(12000);
        expect(
          text.contains(_nonLatinDigit),
          isFalse,
          reason: '${localeCode(locale)}: "$text"',
        );
      }
    });

    test('Indian digit grouping is kept', () {
      expect(NumberFormat.decimalPattern('mr').format(1234567), '12,34,567');
      expect(NumberFormat.decimalPattern('bn').format(1234567), '12,34,567');
    });
  });
}
