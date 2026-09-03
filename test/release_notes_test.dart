// Google Play caps the "What's new" text at 500 characters per language. The
// notes are written here and pasted there, so a note that is too long is only
// discovered while standing in the console at release time — exactly when
// nobody wants to be rewriting copy.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Play's limit for the release-notes field.
const int kPlayReleaseNotesLimit = 500;

void main() {
  final dir = Directory('docs/release-notes');
  final notes = dir.listSync().whereType<File>().where(
    (f) => f.path.endsWith('.txt'),
  );

  test('release notes exist for the version in pubspec', () {
    final version = RegExp(r'^version:\s*([0-9.]+)\+', multiLine: true)
        .firstMatch(File('pubspec.yaml').readAsStringSync())!
        .group(1)!;
    for (final locale in ['en', 'de']) {
      expect(
        File('docs/release-notes/$version-$locale.txt').existsSync(),
        isTrue,
        reason:
            'pubspec is at $version but docs/release-notes/$version-$locale.txt '
            'is missing — the store entry would go out with the previous '
            "version's notes",
      );
    }
  });

  for (final file in notes) {
    test('${file.uri.pathSegments.last} fits the store field', () {
      // Characters, not bytes: German umlauts are two bytes each and would
      // make a byte count reject text the store accepts.
      final length = file.readAsStringSync().length;
      expect(
        length,
        lessThanOrEqualTo(kPlayReleaseNotesLimit),
        reason: '$length characters, limit is $kPlayReleaseNotesLimit',
      );
      expect(length, greaterThan(0));
    });
  }
}
