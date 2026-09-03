// CLAUDE.md makes this non-negotiable: admin/test functions are locked twice,
// in the UI and in the controller, and "these locks must not be removed or
// weakened". A rule with no test is a rule until someone refactors.
//
// kReleaseMode is a compile-time constant, so a test cannot execute the
// release branch. What it can do is read the source and prove the guards are
// still written down — which is the thing that would actually get lost.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The body of [name] in [source], from its signature to the matching brace.
String _methodBody(String source, String name) {
  final start = source.indexOf(name);
  expect(start, greaterThan(-1), reason: '$name no longer exists');
  var i = source.indexOf('{', start);
  var depth = 0;
  final from = i;
  while (i < source.length) {
    if (source[i] == '{') depth++;
    if (source[i] == '}') {
      depth--;
      if (depth == 0) break;
    }
    i++;
  }
  return source.substring(from, i + 1);
}

void main() {
  final controller = File(
    'lib/ui/state/game_controller.dart',
  ).readAsStringSync();
  final settings = File(
    'lib/ui/screens/settings_screen.dart',
  ).readAsStringSync();

  group('layer 2 — the controller refuses in release builds', () {
    for (final method in ['setCoinsForTest', 'grantDebugCoins']) {
      test('$method is a no-op in release', () {
        expect(
          _methodBody(controller, 'Future<void> $method'),
          contains('kReleaseMode'),
          reason:
              '$method is reachable from the hidden admin section. Without '
              'the release guard a player who reaches the UI gets coins for '
              'free, which CLAUDE.md forbids outright.',
        );
      });
    }

    test('the legitimate coin path stays unguarded, and separately named', () {
      // grantCoins is used by purchase delivery and the comeback gift, so it
      // cannot carry a release guard. That is precisely why the admin entry
      // points must not call it directly — grantDebugCoins exists to keep the
      // two apart.
      expect(controller, contains('Future<void> grantDebugCoins'));
      expect(controller, contains('Future<void> grantCoins'));
    });
  });

  group('layer 1 — the UI never offers the admin section in release', () {
    test('unlocking the hidden section is debug-only', () {
      expect(_methodBody(settings, 'void _onFooterTap'), contains('kDebugMode'));
    });

    test('the admin widgets are rendered behind kDebugMode', () {
      // Not just behind the unlock flag: the flag alone could be set by a
      // future code path, so the build-time constant has to gate it too.
      expect(settings, contains('kDebugMode && _adminUnlocked'));
    });
  });

  test('the public web build gets the locked IAP service', () {
    // The web build is public and its leaderboard is shared with the stores,
    // so it must never be able to buy or be granted anything.
    final main = File('lib/main.dart').readAsStringSync();
    expect(main, contains('kIsWeb ? (kDebugMode ? FakeIap() : LockedIap())'));
  });
}
