/// Guards the translation files themselves.
///
/// English (`app_en.arb`) is the source language: every key the app uses is
/// defined there. German is a translation of it, and a key that only exists on
/// one side is a bug — a missing German entry silently falls back to English
/// mid-screen, and a leftover German entry is dead weight.
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

/// The `{placeholder}` names used in a message.
Set<String> _placeholders(String message) => RegExp(r'\{(\w+)\}')
    .allMatches(message)
    .map((m) => m.group(1)!)
    .toSet();

void main() {
  final en = _arb('en');
  final de = _arb('de');

  test('German translates every English key and adds none of its own', () {
    final enKeys = _messageKeys(en);
    final deKeys = _messageKeys(de);

    expect(
      enKeys.difference(deKeys),
      isEmpty,
      reason: 'missing German translations',
    );
    expect(
      deKeys.difference(enKeys),
      isEmpty,
      reason: 'German keys with no English source',
    );
  });

  test('translations keep the same placeholders as the source', () {
    for (final key in _messageKeys(en)) {
      final source = en[key] as String;
      final translated = de[key] as String?;
      if (translated == null) continue;
      expect(
        _placeholders(translated),
        _placeholders(source),
        reason: 'placeholder mismatch in "$key"',
      );
    }
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
    for (final arb in [en, de]) {
      for (final key in _messageKeys(arb)) {
        expect((arb[key] as String).trim(), isNotEmpty, reason: key);
      }
    }
  });

  group('locale resolution', () {
    test('both languages are shipped', () {
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

    test('an untranslated device language falls back to English', () {
      for (final code in ['ja', 'fr', 'pt', 'zh']) {
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
