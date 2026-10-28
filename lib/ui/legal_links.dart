/// The hosted legal pages (`web/privacy.html`, `web/privacy-en.html`,
/// `web/impressum.html`), published under /Qubble/ by the Pages workflow.
///
/// Full literals on purpose: `test/published_links_test.dart` finds every
/// linked page by its URL and checks that the file exists in web/.
library;

import 'dart:ui' show Locale;

final Uri _privacyDe = Uri.parse(
  'https://f6vp76ctbb-stack.github.io/Qubble/privacy.html',
);
final Uri _privacyEn = Uri.parse(
  'https://f6vp76ctbb-stack.github.io/Qubble/privacy-en.html',
);

final Uri imprintUri = Uri.parse(
  'https://f6vp76ctbb-stack.github.io/Qubble/impressum.html',
);

/// The privacy policy in German for German, in English for everyone else.
///
/// The app speaks 57 languages; a policy only in German told most players
/// nothing (Art. 12 GDPR: clear and plain language for the people addressed).
Uri privacyPolicyUri(Locale locale) =>
    locale.languageCode == 'de' ? _privacyDe : _privacyEn;
