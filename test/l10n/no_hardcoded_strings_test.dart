import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the direction `translations_test.dart` structurally cannot.
///
/// All four of its checks run arb → code: every English key is translated,
/// placeholders match, every key is used, no message is empty. A string that
/// never made it into an .arb at all is invisible to every one of them — which
/// is how `Text('Erfolge')` sat on the achievements screen, shown to English
/// players, while the suite stayed green and `achievementsTitle` already
/// existed unused... except it did not even trip the "unused key" check,
/// because the key was used elsewhere.
///
/// This test walks the other way: any user-visible string literal in the UI
/// has to be either localized or explicitly allowed here.
void main() {
  /// Literals that are legitimately not translated, with the reason.
  const allowed = <String>{
    // Language names belong in their own language, never translated.
    'English',
    'Deutsch',
  };

  /// A literal is only interesting if it could be read as a sentence: it has
  /// letters, and more than one of them.
  bool looksLikeProse(String literal) {
    final letters = RegExp(r'[A-Za-zÀ-ÿ]').allMatches(literal).length;
    if (letters < 2) return false;
    // Interpolation-only strings like '$a / $b' are formatting, not prose.
    final withoutInterpolation =
        literal.replaceAll(RegExp(r'\$\{[^}]*\}|\$[A-Za-z_][A-Za-z0-9_]*'), '');
    return RegExp(r'[A-Za-zÀ-ÿ]{2,}').hasMatch(withoutInterpolation);
  }

  test('no user-visible string is hardcoded in the UI', () {
    final offenders = <String>[];
    final widgetText = RegExp(r"""(?:Text|_SectionLabel)\(\s*(?:const\s+)?'((?:[^'\\]|\\.)*)'""");
    final namedText = RegExp(
        r"""(?:label|title|tooltip|hintText|semanticLabel)\s*:\s*(?:const\s+)?'((?:[^'\\]|\\.)*)'""");

    for (final entity in Directory('lib/ui').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.trimLeft().startsWith('//')) continue;
        for (final pattern in [widgetText, namedText]) {
          for (final match in pattern.allMatches(line)) {
            final literal = match.group(1)!;
            if (allowed.contains(literal)) continue;
            if (!looksLikeProse(literal)) continue;
            offenders.add('${entity.path}:${i + 1}  \'$literal\'');
          }
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'These strings are shown to players but never reach an .arb, so '
          'they appear untranslated in every language:\n  '
          '${offenders.join('\n  ')}\n'
          'Move them to lib/l10n/app_en.arb and app_de.arb, or add them to '
          'the allowlist in this test with a reason.',
    );
  });
}
