import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the two Google Play publishing gates that are satisfied by a
/// transitively resolved dependency rather than by anything in our own code.
///
/// Both took effect on 31 August 2026, and both are *publishing* gates: an
/// update that misses them is rejected at upload, long after `flutter test`
/// and `flutter analyze` have gone green. A careless `flutter pub upgrade`
/// could therefore make the app unshippable without a single test failing —
/// which is exactly what these tests are here to prevent.
void main() {
  /// Reads the resolved version of [package] out of the checked-in lockfile.
  String lockedVersion(String package) {
    final lines = File('pubspec.lock').readAsLinesSync();
    final start = lines.indexWhere((l) => l.trimRight() == '  $package:');
    expect(start, isNot(-1), reason: '$package is not in pubspec.lock');
    for (var i = start + 1; i < lines.length; i++) {
      final line = lines[i];
      // The next top-level package entry ends this block.
      if (line.startsWith('  ') && !line.startsWith('    ')) break;
      final match = RegExp(r'^\s+version: "([^"]+)"').firstMatch(line);
      if (match != null) return match.group(1)!;
    }
    fail('no version line found for $package in pubspec.lock');
  }

  /// Compares dotted versions numerically, ignoring any `+build` suffix.
  int compareVersions(String a, String b) {
    List<int> parts(String v) => v
        .split('+')
        .first
        .split('.')
        .map((p) => int.tryParse(p) ?? 0)
        .toList();
    final pa = parts(a);
    final pb = parts(b);
    for (var i = 0; i < (pa.length > pb.length ? pa.length : pb.length); i++) {
      final x = i < pa.length ? pa[i] : 0;
      final y = i < pb.length ? pb[i] : 0;
      if (x != y) return x.compareTo(y);
    }
    return 0;
  }

  test('Play Billing Library 8 is still in the resolved dependencies', () {
    // Google requires Billing Library 8 or later for every new app and every
    // update from 31 August 2026 (extension to 1 November 2026 on request).
    // in_app_purchase_android bundles the billing client; 0.5.0 is the release
    // that moved it from 7.1.1 to 8.0.0, so anything below that reintroduces a
    // deprecated version and blocks publishing.
    const minimum = '0.5.0';
    final resolved = lockedVersion('in_app_purchase_android');

    expect(
      compareVersions(resolved, minimum) >= 0,
      isTrue,
      reason: 'in_app_purchase_android resolved to $resolved, below $minimum. '
          'That build ships Play Billing Library 7 or older, which Google '
          'stopped accepting on 2026-08-31 — the upload would be rejected.',
    );
  });

  test('the Gradle config still targets the API level Play requires', () {
    // From 31 August 2026 new apps and updates must target Android 16
    // (API 36). The value itself comes from the Flutter SDK
    // (flutter.targetSdkVersion), so this asserts we have not started
    // overriding it downwards — the CI release job additionally checks the
    // built artifact's merged manifest.
    final gradle = File('android/app/build.gradle.kts').readAsStringSync();
    final override = RegExp(r'targetSdk\s*=\s*(\d+)').firstMatch(gradle);

    if (override != null) {
      final value = int.parse(override.group(1)!);
      expect(
        value >= 36,
        isTrue,
        reason: 'targetSdk is pinned to $value; Play requires 36 or higher '
            'for updates from 2026-08-31.',
      );
    } else {
      expect(
        gradle.contains('targetSdk = flutter.targetSdkVersion'),
        isTrue,
        reason: 'targetSdk is neither pinned nor taken from the Flutter SDK — '
            'the Play requirement can no longer be reasoned about here.',
      );
    }
  });

  test('release builds still minify, and the notification keeps are present',
      () {
    // R8 is what makes the keep rules necessary in the first place. If
    // minification is ever turned off these rules become dead weight, and if
    // it is on without them, scheduled notifications break silently after a
    // reboot (see the comment block in proguard-rules.pro).
    final gradle = File('android/app/build.gradle.kts').readAsStringSync();
    if (!gradle.contains('isMinifyEnabled = true')) return;

    final rules = File('android/app/proguard-rules.pro').readAsStringSync();
    expect(
      rules.contains('-keep class com.dexterous.** { *; }'),
      isTrue,
      reason: 'R8 is on but flutter_local_notifications is not kept; Gson '
          'renames its model fields and reminders stop surviving a reboot.',
    );
    expect(
      rules.contains('-keepattributes Signature'),
      isTrue,
      reason: 'Gson needs generic signatures kept, and gson 2.8.9 ships no '
          'rules of its own.',
    );
    // The head of the rule alone is not enough, and that is the whole point
    // of testing it: R8 full mode (the default since AGP 8.0, and not
    // disabled in android/gradle.properties) "removes the no-args/default
    // constructor even when the class itself is retained"
    // (developer.android.com/topic/performance/app-optimization/full-mode).
    // AppInitializer reflects on exactly that constructor
    // (getDeclaredConstructor().newInstance()), so a rule that keeps the
    // class but drops the `<init>();` member looks correct, passes a naive
    // substring check, and still crashes the app at launch.
    expect(
      RegExp(
        r'-keep\s+class\s+\*\s+extends\s+androidx\.startup\.Initializer'
        r'\s*\{[^}]*<init>\(\)\s*;[^}]*\}',
      ).hasMatch(rules),
      isTrue,
      reason: 'androidx.startup names its Initializers in manifest meta-data, '
          'which AGP does not treat as a class reference, and instantiates '
          'them through their no-args constructor. The keep must cover both '
          'the class and `<init>();` -- otherwise R8 full mode strips the '
          'constructor and the app dies at launch with a StartupException.',
    );
    expect(
      rules.contains('-keep class * extends androidx.room.RoomDatabase'),
      isTrue,
      reason: 'WorkManager arrives transitively with the ads SDK, is started '
          'by androidx.startup, and its WorkDatabase is a Room database that '
          'Room resolves by name (Class.forName(name + "_Impl")). Renaming it '
          'crashed the published build at launch.',
    );
    expect(
      rules.contains('-keep class androidx.work.impl.WorkDatabase_Impl'),
      isTrue,
      reason: 'Names the generated class directly rather than relying on the '
          'hierarchy match above finding it.',
    );
    expect(
      rules.contains('-keep class androidx.startup.**'),
      isTrue,
      reason: 'AppInitializer resolves the Initializer names with '
          'Class.forName; without the runtime package kept, that throws '
          'ClassNotFoundException at launch.',
    );
  });

  test('R8 full mode is not silently switched off', () {
    // Not a policy about which mode is better: the keep rules above are
    // written for full mode, and audit/08-r8-risiko.md derives the whole
    // StartupException diagnosis from it being on. If someone disables it to
    // paper over a shrinking problem, that reasoning stops holding and the
    // document needs revisiting -- so make the change loud instead of silent.
    final props = File('android/gradle.properties').readAsStringSync();
    final off = RegExp(
      r'^\s*android\.enableR8\.fullMode\s*=\s*false',
      multiLine: true,
    );
    expect(
      off.hasMatch(props),
      isFalse,
      reason: 'android.enableR8.fullMode=false changes which keep rules are '
          'needed. If this is deliberate, update audit/08-r8-risiko.md and '
          'this test together.',
    );
  });
}
