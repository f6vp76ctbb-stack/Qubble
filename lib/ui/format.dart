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
String formatCount(int value, {String? locale}) =>
    NumberFormat.decimalPattern(locale).format(value);

extension CountFormatting on L10n {
  /// [formatCount] in the locale currently being rendered.
  String count(int value) => formatCount(value, locale: localeName);
}
