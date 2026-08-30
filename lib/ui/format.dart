/// User-facing number formatting.
///
/// Deliberately a small helper rather than `intl`: the app has no other use
/// for it yet, and adding a localization dependency days before a playtest to
/// group digits is not a trade worth making. Swap this for
/// `NumberFormat.decimalPattern` when the app is actually localized.
library;

/// Groups [value] with German thousands separators: 12840 -> "12.840".
///
/// Scores reach five figures (measured p95 ≈ 9.600, max ≈ 29.000), and the
/// home screen renders the best score at 52 pt — ungrouped it is both hard to
/// read at a glance and wide enough to crowd the line.
String formatCount(int value) {
  final negative = value < 0;
  final digits = value.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return negative ? '-$buffer' : buffer.toString();
}
