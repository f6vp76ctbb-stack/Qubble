/// Build identity, shown in the settings footer and attached to every piece of
/// feedback. Pure Dart, no Flutter imports.
///
/// Deliberately not `package_info_plus`: that would add a platform plugin on
/// both stores right before a playtest, to read a string the build already
/// knows. The release workflow passes the real value; the default below is the
/// fallback for local runs and is kept in sync with `pubspec.yaml` by
/// `test/app_info_test.dart`.
library;

class AppInfo {
  const AppInfo._();

  /// `version+build` exactly as declared in pubspec.yaml. Override at build
  /// time with `--dart-define=QUBBLE_VERSION=1.0.0+7`.
  static const String version = String.fromEnvironment(
    'QUBBLE_VERSION',
    defaultValue: _pubspecVersion,
  );

  /// Mirror of the `version:` line in pubspec.yaml. Pinned by a test.
  static const String _pubspecVersion = '1.0.0+2';

  /// Marketing version without the build number ("1.0.0").
  static String get versionName => version.split('+').first;

  /// Build number as a string, or empty when the version carries none.
  static String get buildNumber {
    final parts = version.split('+');
    return parts.length > 1 ? parts.last : '';
  }

  /// One-line label for the settings footer, e.g. "Version 1.0.0 (2)".
  static String get label {
    final build = buildNumber;
    return build.isEmpty
        ? 'Version $versionName'
        : 'Version $versionName ($build)';
  }
}
