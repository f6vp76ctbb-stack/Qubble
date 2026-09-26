/// User-facing number formatting.
library;

import 'package:intl/intl.dart';

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
String formatCount(int value, {String? locale}) =>
    NumberFormat.decimalPattern(locale)
        .format(value)
        .replaceAll('\u202F', '\u00A0');

extension CountFormatting on L10n {
  /// [formatCount] in the locale currently being rendered.
  String count(int value) => formatCount(value, locale: localeName);
}

/// [text] in capitals, the way [languageCode] writes them.
///
/// Greek drops its accent (the tonos) in all-caps: "Ήχος" becomes "ΗΧΟΣ".
/// [String.toUpperCase] keeps it ("ΉΧΟΣ"), which a Greek reader sees as a
/// spelling mistake.
String upperCaseFor(String text, String? languageCode) {
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
