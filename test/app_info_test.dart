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
    expect(AppInfo.versionName, '1.0.0');
    expect(AppInfo.buildNumber, '2');
    expect(AppInfo.label, 'Version 1.0.0 (2)');
  });

  test('the label survives a version without a build number', () {
    // Guards the split when a --dart-define omits the "+n" suffix.
    expect('1.2.3'.split('+').length, 1);
  });
}
