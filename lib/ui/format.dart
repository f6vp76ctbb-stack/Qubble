/// User-facing number formatting.
library;

import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

import '../l10n/app_localizations.dart';

/// Groups [value] for the given [locale]: 18740 becomes "18,740" in English
/// and "18.740" in German.
///
/// Scores reach five figures (measured p95 ≈ 9,600, max ≈ 29,000), and the
/// home screen renders the best score at 52 pt — ungrouped it is both hard to
/// read at a glance and wide enough to crowd the line.
///
/// The separator has to follow the language, not the code: a German player
/// reading "18,740" sees a decimal, not a score. This used to be a hand-rolled
/// helper with a hardcoded '.', which was fine while the app was German-only.
///
/// French groups with a narrow no-break space (U+202F). Nunito, the bundled
/// font, has no glyph for it, and the web build ships without fallback fonts —
/// the score would show a tofu box where the space belongs. The ordinary
/// no-break space is in the font and reads the same.
String formatCount(int value, {String? locale}) {
  useLatinDigits();
  return NumberFormat.decimalPattern(locale)
      .format(value)
      .replaceAll('\u202F', '\u00A0');
}

/// Makes every language write its numbers with the digits 0–9.
///
/// A few languages default to digits of their own script — Bengali ০–৯,
/// Marathi and Nepali ०–९ — and intl follows that default. But only the numbers that go
/// through [NumberFormat] would change: a score from [formatCount] or a
/// mission count in the generated strings would read "১৮,৭৪০", while every
/// number a string interpolates as it is ({streak}, {level}) stays "7". One
/// screen would mix two digit systems. 0–9 is the one both paths can agree
/// on, and the one the other Indian languages here (Hindi, Tamil…) already
/// get from intl.
///
/// Rewrites intl's symbol table, which is global, so it runs once, before
/// the first frame (see `main`); [formatCount] calls it as well so a caller
/// that skipped `main`, such as a test, still gets the same digits.
void useLatinDigits() {
  if (_latinDigits) return;
  _latinDigits = true;
  for (final MapEntry(:key, value: s) in numberFormatSymbols.entries.toList()) {
    if (s.ZERO_DIGIT == '0') continue;
    numberFormatSymbols[key] = NumberSymbols(
      NAME: s.NAME,
      DECIMAL_SEP: s.DECIMAL_SEP,
      GROUP_SEP: s.GROUP_SEP,
      PERCENT: s.PERCENT,
      ZERO_DIGIT: '0',
      PLUS_SIGN: s.PLUS_SIGN,
      MINUS_SIGN: s.MINUS_SIGN,
      EXP_SYMBOL: s.EXP_SYMBOL,
      PERMILL: s.PERMILL,
      INFINITY: s.INFINITY,
      NAN: s.NAN,
      DECIMAL_PATTERN: s.DECIMAL_PATTERN,
      SCIENTIFIC_PATTERN: s.SCIENTIFIC_PATTERN,
      PERCENT_PATTERN: s.PERCENT_PATTERN,
      CURRENCY_PATTERN: s.CURRENCY_PATTERN,
      DEF_CURRENCY_CODE: s.DEF_CURRENCY_CODE,
    );
  }
}

bool _latinDigits = false;

extension CountFormatting on L10n {
  /// [formatCount] in the locale currently being rendered.
  String count(int value) => formatCount(value, locale: localeName);
}

/// [text] in capitals, the way [languageCode] writes them.
///
/// Greek drops its accent (the tonos) in all-caps: "Ήχος" becomes "ΗΧΟΣ".
/// [String.toUpperCase] keeps it ("ΉΧΟΣ"), which a Greek reader sees as a
/// spelling mistake.
///
/// Turkish and Azerbaijani have two i's: dotted i capitalises to İ, dotless
/// ı to I. [String.toUpperCase] knows no locale and turns both into I, so
/// "Ses ve titreşim" came out as "SES VE TITREŞIM".
String upperCaseFor(String text, String? languageCode) {
  if (languageCode == 'tr' || languageCode == 'az') {
    return text.replaceAll('i', '\u0130').toUpperCase();
  }
  final upper = text.toUpperCase();
  if (languageCode != 'el') return upper;
  return upper.replaceAllMapped(_greekTonos, (m) => _greekWithoutTonos[m[0]]!);
}

// ΐ and ΰ have no single capital, so toUpperCase leaves them lower-case.
final _greekTonos = RegExp(
  '[\u0386\u0388\u0389\u038A\u038C\u038E\u038F\u0390\u03B0]',
);
const _greekWithoutTonos = {
  '\u0386': '\u0391', // Ά → Α
  '\u0388': '\u0395', // Έ → Ε
  '\u0389': '\u0397', // Ή → Η
  '\u038A': '\u0399', // Ί → Ι
  '\u038C': '\u039F', // Ό → Ο
  '\u038E': '\u03A5', // Ύ → Υ
  '\u038F': '\u03A9', // Ώ → Ω
  '\u0390': '\u03AA', // ΐ → Ϊ
  '\u03B0': '\u03AB', // ΰ → Ϋ
};
