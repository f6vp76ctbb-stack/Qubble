/// Locale resolution for Qubble.
///
/// English is the source language: every string is authored in `app_en.arb`
/// and translated from there. It is therefore also the fallback for any device
/// language Qubble has no translation for — without this, Flutter would fall
/// back to whichever locale happens to sort first in the generated list, which
/// would show German to a player whose phone is set to, say, Japanese.
library;

import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

/// The source language, and the fallback for unsupported device languages.
const Locale kFallbackLocale = Locale('en');

/// Picks the locale to render in.
///
/// [device] is the phone's preferred locale (null when the platform has not
/// reported one yet). Matching is by language code, so `de_AT` and `de_CH`
/// both get the German translation — except where a language ships in two
/// scripts: a Traditional Chinese phone gets `zh_Hant`, every other Chinese
/// phone the Simplified `zh`.
Locale resolveAppLocale(Locale? device, Iterable<Locale> supported) {
  if (device == null) return kFallbackLocale;
  final language =
      _languageAliases[device.languageCode] ?? device.languageCode;
  final script = device.scriptCode ?? _impliedScript(device);
  if (script != null) {
    for (final locale in supported) {
      if (locale.languageCode == language && locale.scriptCode == script) {
        return locale;
      }
    }
  }
  // The plain language before any script variant of it.
  for (final locale in supported) {
    if (locale.languageCode == language && locale.scriptCode == null) {
      return locale;
    }
  }
  for (final locale in supported) {
    if (locale.languageCode == language) return locale;
  }
  return kFallbackLocale;
}

/// Device language codes that mean a language the app has under another code.
///
/// Norwegian is `nb` (Bokmål) on current Android, `no` on older phones; a
/// Nynorsk (`nn`) reader reads Bokmål far better than the English fallback.
/// (dart:ui already maps retired codes such as `in` → `id` and `iw` → `he`.)
const Map<String, String> _languageAliases = {'no': 'nb', 'nn': 'nb'};

/// Many Chinese phones report a region and no script (`zh_TW`, not
/// `zh_Hant_TW`). Taiwan, Hong Kong and Macau read Traditional characters.
String? _impliedScript(Locale device) {
  if (device.languageCode != 'zh') return null;
  return const {'TW', 'HK', 'MO'}.contains(device.countryCode) ? 'Hant' : null;
}

/// The code a locale is stored and listed under: `de`, or `zh_Hant` where
/// the script matters.
String localeCode(Locale locale) => locale.scriptCode == null
    ? locale.languageCode
    : '${locale.languageCode}_${locale.scriptCode}';

/// The locale behind a [localeCode].
Locale localeFromCode(String code) {
  final parts = code.split('_');
  return Locale.fromSubtags(
    languageCode: parts.first,
    scriptCode: parts.length > 1 ? parts[1] : null,
  );
}

/// Every shipped language, as the player picks it in the settings: the key is
/// the locale code, the value its endonym. Endonyms stay untranslated, so a
/// player can find their own language even while the app shows one they
/// cannot read. Order is the order of the menu — English first as the source,
/// then the rest alphabetically by endonym.
///
/// `test/l10n/translations_test.dart` keeps this in step with the .arb files:
/// a translation nobody can pick, or a menu entry with no translation behind
/// it, fails the build.
const Map<String, String> kLanguageEndonyms = {
  'en': 'English',
  'id': 'Bahasa Indonesia',
  'ms': 'Bahasa Melayu',
  'cs': 'Čeština',
  'da': 'Dansk',
  'de': 'Deutsch',
  'es': 'Español',
  'fr': 'Français',
  'hr': 'Hrvatski',
  'it': 'Italiano',
  'hu': 'Magyar',
  'nl': 'Nederlands',
  'nb': 'Norsk bokmål',
  'pl': 'Polski',
  'pt': 'Português',
  'ro': 'Română',
  'sk': 'Slovenčina',
  'fi': 'Suomi',
  'sv': 'Svenska',
  'vi': 'Tiếng Việt',
  'tr': 'Türkçe',
  'el': 'Ελληνικά',
  'bg': 'Български',
  'uk': 'Українська',
  'he': 'עברית',
  'ar': 'العربية',
  'hi': 'हिन्दी',
  'th': 'ไทย',
  'ja': '日本語',
  'zh': '简体中文',
  'zh_Hant': '繁體中文',
  'ko': '한국어',
};

/// Languages whose script the bundled font (Nunito) cannot draw.
///
/// On Android and iOS that is fine: the system font fills in the missing
/// glyphs. The web build has no system font to fall back on — it would fetch
/// one from fonts.gstatic.com, which the offline PWA cannot reach and the
/// privacy policy does not name (see test/no_web_emoji_test.dart). So the
/// web build does not offer these languages; an Arabic, Greek, Hebrew,
/// Hindi, Japanese, Korean, Thai or Chinese browser gets English there, as it
/// did before they existed. Listed
/// by language code, so `zh` covers both Chinese scripts.
///
/// `test/l10n/font_coverage_test.dart` holds every other translation to
/// Nunito's character map, and fails if a language needs this list but is
/// not on it.
const Set<String> kNativeOnlyLanguages = {
  'ar',
  'el',
  'he',
  'hi',
  'ja',
  'ko',
  'th',
  'zh',
};

/// The locales the app offers on this platform.
List<Locale> appSupportedLocales({required bool web}) => [
  for (final locale in L10n.supportedLocales)
    if (!web || !kNativeOnlyLanguages.contains(locale.languageCode)) locale,
];

/// The settings picker's entries on this platform, in menu order.
Map<String, String> languageChoices({required bool web}) => {
  for (final entry in kLanguageEndonyms.entries)
    if (!web ||
        !kNativeOnlyLanguages.contains(localeFromCode(entry.key).languageCode))
      entry.key: entry.value,
};
