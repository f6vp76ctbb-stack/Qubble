// Flutter's web build carries no emoji font. When a glyph is missing it
// fetches NotoColorEmoji from fonts.gstatic.com on demand — observed directly:
// loading the built PWA issues a request to
// fonts.gstatic.com/s/notocoloremoji/... That has two consequences the project
// did not intend.
//
// The workflow bundles CanvasKit locally with --no-web-resources-cdn so the
// PWA "works fully offline once added to the home screen". Offline, that font
// never arrives and every emoji renders as a blank box.
//
// And the request itself sends the player's IP to a Google server, which
// web/privacy.html does not mention — it lists AdMob, Firebase and UMP, not
// fonts. Removing the emoji removes the request; the alternative, bundling a
// ~10 MB colour font into a puzzle game's web build, is not a trade worth
// making for decoration.
//
// Notification titles keep theirs: they are rendered by Android, not by
// Flutter, using the system emoji font, and never reach the web build.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Emoji blocks plus the variation selector that turns a symbol into one.
final _emoji = RegExp(
  '[\u{1F000}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE0F}\u{2B00}-\u{2BFF}]',
  unicode: true,
);

/// Rendered by the OS, never by Flutter's web renderer.
const _nativeOnly = {
  'notificationDailyTitle',
  'notificationStreakTitle',
  'notificationComebackTitle',
};

void main() {
  for (final path in ['lib/l10n/app_en.arb', 'lib/l10n/app_de.arb']) {
    test('no emoji in strings the web build renders ($path)', () {
      final map = jsonDecode(File(path).readAsStringSync()) as Map;
      final offenders = <String>[];
      map.forEach((key, value) {
        if (key is! String || value is! String) return;
        if (key.startsWith('@') || _nativeOnly.contains(key)) return;
        if (_emoji.hasMatch(value)) offenders.add('$key: $value');
      });
      expect(
        offenders,
        isEmpty,
        reason:
            'these render as blank boxes in an offline PWA, and drawing them '
            'online costs a request to fonts.gstatic.com that the privacy '
            'policy does not declare',
      );
    });
  }

  test('the guard would notice an emoji if one came back', () {
    // Without this the regex could quietly stop matching and every check above
    // would pass on nothing.
    expect(_emoji.hasMatch('coins 🪙'), isTrue);
    expect(_emoji.hasMatch('heart ❤️'), isTrue);
    expect(_emoji.hasMatch('plain text — with a dash'), isFalse);
  });
}
