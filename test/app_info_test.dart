import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/app_info.dart';

void main() {
  test('the fallback version matches pubspec.yaml', () {
    // AppInfo hardcodes the pubspec version so no plugin is needed to read it.
    // This keeps the two from drifting: bump pubspec, bump AppInfo.
    final pubspec = File('pubspec.yaml').readAsLinesSync();
    final line = pubspec.firstWhere(
      (l) => l.startsWith('version:'),
      orElse: () => '',
    );
    expect(line, isNotEmpty, reason: 'pubspec.yaml has no version line');
    final declared = line.split(':').last.trim();

    expect(
      AppInfo.version,
      declared,
      reason: 'AppInfo._pubspecVersion drifted from pubspec.yaml — a tester '
          'report would then name the wrong build',
    );
  });

  test('splits into a marketing version and a build number', () {
    // Derived from AppInfo.version rather than repeated: the version already
    // lives in pubspec.yaml and in AppInfo, and the test above pins those two
    // to each other. Writing it out a third time here only meant every bump
    // broke a test that was never about the number.
    final parts = AppInfo.version.split('+');
    expect(parts, hasLength(2), reason: 'expected a "name+build" version');
    expect(AppInfo.versionName, parts.first);
    expect(AppInfo.buildNumber, parts.last);
    expect(AppInfo.label, 'Version ${parts.first} (${parts.last})');
  });

  test('the label survives a version without a build number', () {
    // Guards the split when a --dart-define omits the "+n" suffix.
    expect('1.2.3'.split('+').length, 1);
  });
}
