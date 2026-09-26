/// Guards the translation files themselves.
///
/// English (`app_en.arb`) is the source language: every key the app uses is
/// defined there. Every other language is a translation of it, and a key that
/// only exists on one side is a bug — a missing entry silently falls back to
/// English mid-screen, and a leftover one is dead weight.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/locale.dart';

Map<String, dynamic> _arb(String locale) {
  final raw = File('lib/l10n/app_$locale.arb').readAsStringSync();
  return jsonDecode(raw) as Map<String, dynamic>;
}

/// Message keys only — drops `@@locale` and the `@key` metadata entries.
Set<String> _messageKeys(Map<String, dynamic> arb) =>
    arb.keys.where((k) => !k.startsWith('@')).toSet();

/// The placeholder names used in a message, read the way ICU reads it.
///
/// A plain `{word}` scan is not enough once translations use plural forms:
/// Polish writes `{streak, plural, =1{dzień} other{dni}}`, and a scan would
/// report the branch text `dni` as a placeholder. This walks the braces: a
/// top-level `{name}` or `{name, plural|select, …}` names a placeholder, and
/// the branch bodies of a plural or select are parsed again as messages.
Set<String> _placeholders(String message) {
  final names = <String>{};
  final head = RegExp(r'^\s*(\w+)\s*(?:,\s*(?:plural|select)\s*,(.*))?$',
      dotAll: true);

  /// Index of the brace that closes the one at [open].
  int close(String s, int open) {
    var depth = 0;
    for (var i = open; i < s.length; i++) {
      if (s[i] == '{') depth++;
      if (s[i] == '}' && --depth == 0) return i;
    }
    throw FormatException('unbalanced braces', s, open);
  }

  void parse(String s) {
    var i = 0;
    while (i < s.length) {
      if (s[i] != '{') {
        i++;
        continue;
      }
      final end = close(s, i);
      final match = head.firstMatch(s.substring(i + 1, end));
      if (match != null) {
        names.add(match.group(1)!);
        final branches = match.group(2);
        if (branches != null) {
          var j = 0;
          while ((j = branches.indexOf('{', j)) != -1) {
            final branchEnd = close(branches, j);
            parse(branches.substring(j + 1, branchEnd));
            j = branchEnd + 1;
          }
        }
      }
      i = end + 1;
    }
  }

  parse(message);
  return names;
}

/// Every translation shipped next to the English source, by locale code.
Map<String, Map<String, dynamic>> _translations() {
  final result = <String, Map<String, dynamic>>{};
  for (final entity in Directory('lib/l10n').listSync()) {
    final match = RegExp(r'app_(\w+)\.arb$').firstMatch(entity.path);
    if (match == null || match.group(1) == 'en') continue;
    result[match.group(1)!] = _arb(match.group(1)!);
  }
  return result;
}

void main() {
  final en = _arb('en');
  final translations = _translations();

  test('placeholder parsing reads plural branches as text', () {
    expect(_placeholders('{n} items'), {'n'});
    expect(
      _placeholders('Seria: {streak} {streak, plural, =1{dzień} other{dni}}'),
      {'streak'},
    );
    expect(
      _placeholders('{count, plural, =1{{count} entry} other{{count} entries}}'),
      {'count'},
    );
    expect(_placeholders('no placeholders here'), isEmpty);
  });

  test('the translations are all there', () {
    // Guards the directory scan itself: an empty map would make every loop
    // below pass without checking anything.
    expect(
      translations.keys,
      containsAll(<String>[
        'de', 'es', 'fr', 'id', 'it', 'ja', 'ko', 'nl', 'pl', 'pt', 'tr', //
        'vi',
      ]),
    );
  });

  test('every translation covers every English key and adds none', () {
    final enKeys = _messageKeys(en);
    translations.forEach((code, arb) {
      final keys = _messageKeys(arb);
      expect(
        enKeys.difference(keys),
        isEmpty,
        reason: 'missing $code translations',
      );
      expect(
        keys.difference(enKeys),
        isEmpty,
        reason: '$code keys with no English source',
      );
      expect(arb['@@locale'], code, reason: 'app_$code.arb names its locale');
    });
  });

  test('translations keep the same placeholders as the source', () {
    translations.forEach((code, arb) {
      for (final key in _messageKeys(en)) {
        final source = en[key] as String;
        final translated = arb[key] as String?;
        if (translated == null) continue;
        expect(
          _placeholders(translated),
          _placeholders(source),
          reason: 'placeholder mismatch in $code "$key"',
        );
      }
    });
  });

  test('a plural branch for one never hardcodes the number', () {
    // gen-l10n turns `=1{…}` into the CLDR "one" category, and in French and
    // Portuguese that category also covers 0 — a literal "1" in that branch
    // would tell a player with nothing solved that they had solved one.
    final literalOne = RegExp(r'=1\{[^{}]*(?<![\d.,])1(?![\d.,])');
    translations.forEach((code, arb) {
      for (final key in _messageKeys(arb)) {
        final message = arb[key] as String;
        if (!message.contains(', plural,')) continue;
        expect(
          literalOne.hasMatch(message),
          isFalse,
          reason: '$code "$key" writes 1 instead of the placeholder',
        );
      }
    });
  });

  test('the web build leaves out the languages Nunito cannot draw', () {
    final web = appSupportedLocales(web: true).map((l) => l.languageCode);
    final native = appSupportedLocales(web: false).map((l) => l.languageCode);
    expect(native, containsAll(kNativeOnlyLanguages));
    for (final code in kNativeOnlyLanguages) {
      expect(web, isNot(contains(code)), reason: code);
      expect(languageChoices(web: false).keys, contains(code));
      // A Japanese browser gets English on the web, not a broken page.
      expect(
        resolveAppLocale(Locale(code), appSupportedLocales(web: true)),
        kFallbackLocale,
      );
    }
    // Every script of such a language is gone from the web picker, zh_Hant
    // as well as zh.
    for (final code in languageChoices(web: true).keys) {
      expect(
        kNativeOnlyLanguages,
        isNot(contains(localeFromCode(code).languageCode)),
        reason: code,
      );
    }
    expect(
      web.length,
      native.where((c) => !kNativeOnlyLanguages.contains(c)).length,
    );
  });

  test('every shipped language can be picked in the settings', () {
    // Codes as the .arb files name them: `zh_Hant` for Traditional Chinese.
    final shipped = {'en', ...translations.keys};
    expect(kLanguageEndonyms.keys.toSet(), shipped);
    expect(L10n.supportedLocales.map(localeCode).toSet(), shipped);
    for (final code in shipped) {
      expect(localeCode(localeFromCode(code)), code);
    }
  });

  test('a Chinese phone gets the script it reads', () {
    Locale pick(Locale device) =>
        resolveAppLocale(device, L10n.supportedLocales);
    const traditional = Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
    );
    // Many phones report a region only.
    expect(pick(const Locale('zh', 'TW')), traditional);
    expect(pick(const Locale('zh', 'HK')), traditional);
    expect(pick(const Locale('zh', 'MO')), traditional);
    expect(
      pick(const Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
        countryCode: 'TW',
      )),
      traditional,
    );
    expect(pick(const Locale('zh', 'CN')), const Locale('zh'));
    expect(pick(const Locale('zh', 'SG')), const Locale('zh'));
    expect(pick(const Locale('zh')), const Locale('zh'));
    expect(
      pick(const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans')),
      const Locale('zh'),
    );
  });

  test('every key is actually used somewhere in the app', () {
    // Dead keys are not free: every language added later has to translate
    // them. This caught 21 left over from screens that had been deleted.
    //
    // Safe as a plain text scan because nothing looks a key up dynamically —
    // the ids from lib/game/ are mapped in lib/ui/l10n_maps.dart by naming
    // each getter explicitly.
    final source = StringBuffer();
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.path.contains('${Platform.pathSeparator}l10n${Platform.pathSeparator}')) {
        continue; // the generated bindings name every key by definition
      }
      source.writeln(entity.readAsStringSync());
    }
    final text = source.toString();

    final unused = _messageKeys(en)
        .where((key) => !RegExp('\\b$key\\b').hasMatch(text))
        .toList();
    expect(unused, isEmpty, reason: 'unused translation keys');
  });

  test('no message is left empty', () {
    for (final arb in [en, ...translations.values]) {
      for (final key in _messageKeys(arb)) {
        expect((arb[key] as String).trim(), isNotEmpty, reason: key);
      }
    }
  });

  group('locale resolution', () {
    test('English and German are shipped', () {
      expect(
        L10n.supportedLocales.map((l) => l.languageCode),
        containsAll(<String>['en', 'de']),
      );
    });

    test('a supported device language is used as-is', () {
      expect(
        resolveAppLocale(const Locale('de'), L10n.supportedLocales),
        const Locale('de'),
      );
      expect(
        resolveAppLocale(const Locale('en'), L10n.supportedLocales),
        const Locale('en'),
      );
    });

    test('regional variants match on the language code', () {
      expect(
        resolveAppLocale(const Locale('de', 'AT'), L10n.supportedLocales),
        const Locale('de'),
      );
      expect(
        resolveAppLocale(const Locale('en', 'GB'), L10n.supportedLocales),
        const Locale('en'),
      );
    });

    test('a Brazilian or Portuguese device gets the one Portuguese', () {
      for (final region in ['BR', 'PT']) {
        expect(
          resolveAppLocale(Locale('pt', region), L10n.supportedLocales),
          const Locale('pt'),
        );
      }
    });

    test('an untranslated device language falls back to English', () {
      for (final code in ['ru', 'el', 'bn', 'fi']) {
        expect(
          resolveAppLocale(Locale(code), L10n.supportedLocales),
          kFallbackLocale,
          reason: code,
        );
        expect(kFallbackLocale, const Locale('en'));
      }
    });

    test('no reported device locale falls back to English', () {
      expect(resolveAppLocale(null, L10n.supportedLocales), kFallbackLocale);
    });
  });
}
