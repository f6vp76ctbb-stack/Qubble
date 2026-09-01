import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Catches `\${...}` in Dart source: an escaped braced interpolation.
///
/// `debugPrint('Purchase failed: \${purchase.error}')` in iap.dart printed the
/// literal text `${purchase.error}` for as long as it existed. The comment two
/// lines above it explained that a failed purchase used to be swallowed — and
/// the line meant to stop that from happening was throwing the reason away.
///
/// Nothing catches this: it compiles, it analyses clean, and it only shows in
/// a log nobody reads until something has already gone wrong.
///
/// A bare `\$` is left alone, because it is how a literal dollar sign is
/// written and a price string legitimately needs one. `\${` is different: a
/// literal `${` in user-facing or logged text is essentially never intended.
void main() {
  test('no Dart source escapes a braced interpolation', () {
    final offenders = <String>[];
    final escaped = RegExp(r'\\\$\{');

    for (final dir in ['lib', 'test', 'tool', 'scripts']) {
      final directory = Directory(dir);
      if (!directory.existsSync()) continue;
      for (final entity in directory.listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;
        // This file necessarily contains the pattern it looks for.
        if (entity.path.endsWith('no_escaped_interpolation_test.dart')) {
          continue;
        }
        final lines = entity.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          if (escaped.hasMatch(lines[i])) {
            offenders.add('${entity.path}:${i + 1}  ${lines[i].trim()}');
          }
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'These lines print a literal \${...} instead of the value:\n  '
          '${offenders.join('\n  ')}\n'
          'Drop the backslash. If a literal is genuinely wanted, write it in '
          'a way that does not look like a mistake.',
    );
  });
}
