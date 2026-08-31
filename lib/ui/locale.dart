/// Locale resolution for Qubble.
///
/// English is the source language: every string is authored in `app_en.arb`
/// and translated from there. It is therefore also the fallback for any device
/// language Qubble has no translation for — without this, Flutter would fall
/// back to whichever locale happens to sort first in the generated list, which
/// would show German to a player whose phone is set to, say, Japanese.
library;

import 'package:flutter/widgets.dart';

/// The source language, and the fallback for unsupported device languages.
const Locale kFallbackLocale = Locale('en');

/// Picks the locale to render in.
///
/// [device] is the phone's preferred locale (null when the platform has not
/// reported one yet). Matching is by language code only, so `de_AT` and
/// `de_CH` both get the German translation.
Locale resolveAppLocale(Locale? device, Iterable<Locale> supported) {
  if (device == null) return kFallbackLocale;
  for (final locale in supported) {
    if (locale.languageCode == device.languageCode) return locale;
  }
  return kFallbackLocale;
}
