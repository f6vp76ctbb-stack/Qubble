// The store listings are text a player reads before installing, so they are
// held to the same two standards as the app: they must fit the fields, and
// they must describe the game that ships.
//
// Field limits: 30 / 80 / 4000 characters (docs/STORE-LISTING.md). A listing
// over the limit is not truncated by the console, it is refused — and a
// translation is where that happens without anyone noticing.
//
// Title words: Google's metadata policy bars store-performance and price or
// promotion claims from the title ("top", "#1", "best", "free", "no ads" …),
// per the policy summary cited in audit/05-aso.md. A translated title can
// smuggle one in ("gratis"), so the local words are checked too.
//
// Consistency: each translated listing names the eight themes. The names must
// be the ones the app shows in that language, or the listing promises a
// "Madera" theme the player then cannot find.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/l10n_maps.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/theme.dart';

/// Minimal RFC 4180 reader: quoted fields may hold commas, quotes and line
/// breaks. The listing CSV is written with every field quoted.
List<List<String>> _readCsv(String text) {
  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var quoted = false;
  for (var i = 0; i < text.length; i++) {
    final c = text[i];
    if (quoted) {
      if (c == '"') {
        if (i + 1 < text.length && text[i + 1] == '"') {
          field.write('"');
          i++;
        } else {
          quoted = false;
        }
      } else {
        field.write(c);
      }
    } else if (c == '"') {
      quoted = true;
    } else if (c == ',') {
      row.add(field.toString());
      field.clear();
    } else if (c == '\n') {
      row.add(field.toString());
      field.clear();
      rows.add(row);
      row = <String>[];
    } else if (c != '\r') {
      field.write(c);
    }
  }
  if (field.isNotEmpty || row.isNotEmpty) {
    row.add(field.toString());
    rows.add(row);
  }
  return rows;
}

/// Play locale code -> app language code.
const _appLanguage = {
  'es-419': 'es',
  'es-ES': 'es',
  'pt-BR': 'pt',
  'pt-PT': 'pt',
  'fr-FR': 'fr',
  'it-IT': 'it',
  'tr-TR': 'tr',
  'id': 'id',
  'nl-NL': 'nl',
  'pl-PL': 'pl',
  'vi': 'vi',
  'ja-JP': 'ja',
  'ko-KR': 'ko',
  'th': 'th',
  'zh-TW': 'zh_Hant',
  'zh-HK': 'zh_Hant',
  'zh-CN': 'zh',
  'ar': 'ar',
  'uk': 'uk',
  'hi-IN': 'hi',
  'ms': 'ms',
  'ro': 'ro',
  'cs-CZ': 'cs',
  'hu-HU': 'hu',
  'sv-SE': 'sv',
  'sk': 'sk',
  'el-GR': 'el',
  'da-DK': 'da',
  'no-NO': 'nb',
  'fi-FI': 'fi',
};

// Words are matched whole: no letter or digit may touch either end. `\b`
// could not do that — it only knows ASCII letters, so a word starting or
// ending in "ü", "í" or "á" ("ücretsiz", "miễn phí") never matched at all.
// Scripts without spaces between words (Japanese, Thai, Chinese …) sit outside
// the group: there a banned word is banned wherever it appears.
final _bannedInTitle = RegExp(
  r'(?<![\p{L}\p{N}])(top|best|#1|no\.? ?1|free|no ads|ad[- ]free|gratis|grátis|'
  r'gratuit|ücretsiz|kostenlos|sin anuncios|sem anúncios|sans pub|darmowe?|'
  r'za darmo|miễn phí|percuma|tanpa iklan|terbaik|fără reclame|cel mai bun|'
  r'zdarma|bez reklam|nejlepší|ingyen\p{L}*|reklámmentes|reklám nélkül|'
  r'legjobb|bäst|bästa|reklamfri|utan reklam|zadarmo|bez reklám|najlepš\p{L}*|δωρεάν|χωρίς διαφημίσεις|καλύτερ\p{L}*|κορυφαί\p{L}*|bedste|uden reklamer|reklamefri|beste|uten reklame|uten annonser|reklamefritt|ilmai\p{L}*|paras|parhaat|mainokseton|ilman mainoksia)(?![\p{L}\p{N}])|#1|無料|広告なし|人気|무료|광고 없는|인기|ฟรี|'
  r'ไม่มีโฆษณา|ดีที่สุด|免費|免费|無廣告|无广告|最好玩|最佳|مجاني|مجانًا|مجانا|'
  r'بدون إعلانات|بلا إعلانات|الأفضل|безкоштовн|без реклами|найкращ|मुफ़्त|मुफ्त|'
  r'फ्री|फ़्री|बिना विज्ञापन|सर्वश्रेष्ठ',
  caseSensitive: false,
  unicode: true,
);

void main() {
  test('the banned-word check sees words that start or end in a non-ASCII '
      'letter', () {
    for (final title in [
      'Qubble: ücretsiz blok',
      'Qubble – miễn phí',
      'Qubble: nejlepší hlavolam',
      'Qubble: Ingyenes kirakós',
      'Qubble: legjobb',
    ]) {
      expect(_bannedInTitle.hasMatch(title), isTrue, reason: title);
    }
    // … and still only whole words: "Topaz" is not "top".
    expect(_bannedInTitle.hasMatch('Qubble: Topaz Blocks'), isFalse);
  });

  final csvRows = _readCsv(
    File('store-assets/store-listing.csv').readAsStringSync(),
  );
  final header = csvRows.first;
  final listings = [
    for (final r in csvRows.skip(1))
      if (r.length == header.length) Map.fromIterables(header, r),
  ];

  test('the CSV parses into one listing per language', () {
    expect(header, [
      'language_code',
      'title',
      'short_description',
      'full_description',
    ]);
    expect(listings.length, csvRows.length - 1, reason: 'a malformed row');
    expect(
      listings.map((l) => l['language_code']),
      containsAll(<String>['en-US', 'de-DE', ..._appLanguage.keys]),
    );
  });

  for (final listing in listings) {
    final code = listing['language_code']!;
    group(code, () {
      test('fits the store fields', () {
        final title = listing['title']!;
        final short = listing['short_description']!;
        final full = listing['full_description']!;
        expect(title.length, inInclusiveRange(1, 30), reason: title);
        expect(short.length, inInclusiveRange(1, 80), reason: short);
        expect(full.length, inInclusiveRange(1, 4000));
      });

      test('keeps the brand and no banned claim in the title', () {
        final title = listing['title']!;
        expect(title, startsWith('Qubble'));
        expect(_bannedInTitle.hasMatch(title), isFalse, reason: title);
      });
    });
  }

  for (final entry in _appLanguage.entries) {
    final code = entry.key;
    test('$code names the themes the app shows in that language', () {
      final listing = listings.firstWhere((l) => l['language_code'] == code);
      final l10n = lookupL10n(localeFromCode(entry.value));
      final full = listing['full_description']!;
      for (final theme in kThemeCatalog) {
        expect(
          full,
          contains(themeName(l10n, theme.id)),
          reason: '$code lists a theme name the app does not use',
        );
      }
    });
  }

  test('every listing has its images and release notes', () {
    // A language whose texts are ready but whose screenshots are not would
    // show English pictures under a translated description — and
    // tool/export_play_metadata.py refuses to lay it out.
    for (final listing in listings) {
      final code = listing['language_code']!;
      final app = _appLanguage[code] ?? {'en-US': 'en', 'de-DE': 'de'}[code];
      expect(app, isNotNull, reason: '$code maps to no app language');
      final shots = Directory('store-assets/$app')
          .listSync()
          .whereType<File>()
          .where((f) => f.uri.pathSegments.last.startsWith('screenshot-'));
      expect(shots, hasLength(6), reason: '$code screenshots');
      expect(
        File('store-assets/$app/feature-graphic-1024x500.png').existsSync(),
        isTrue,
        reason: '$code feature graphic',
      );
      expect(
        File('docs/release-notes/next-$app.txt').existsSync(),
        isTrue,
        reason: '$code "What\'s new"',
      );
    }
  });

  test('the per-language files match the CSV', () {
    // The CSV is for a file import, the folders are for copy and paste; they
    // must not drift apart.
    final dirs = Directory('store-assets/listing')
        .listSync()
        .whereType<Directory>()
        .toList();
    expect(dirs, isNotEmpty);
    for (final dir in dirs) {
      final code = dir.uri.pathSegments.where((s) => s.isNotEmpty).last;
      final listing = listings.firstWhere(
        (l) => l['language_code'] == code,
        orElse: () => throw StateError('$code has no CSV row'),
      );
      for (final field in ['title', 'short_description', 'full_description']) {
        final text = File('${dir.path}/$field.txt').readAsStringSync();
        expect(text.trimRight(), listing[field], reason: '$code $field');
      }
    }
  });

  test('no description is hard-wrapped', () {
    // Play shows a line break where the text has one. A paragraph wrapped at
    // 80 columns for an editor reads as ragged half-lines on a phone — which
    // is how the English and German texts sat in the CSV until 23.09.2026.
    for (final listing in listings) {
      final code = listing['language_code']!;
      final full = listing['full_description']!;
      final lines = full.split('\n');
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.isEmpty || line.startsWith('▸') || line.startsWith('•')) {
          continue;
        }
        if (code == 'th') {
          // Thai ends a sentence with a space, not a mark, so the check below
          // cannot apply. Every paragraph is one line, followed by a blank
          // line or the end — a wrapped one would run on into the next.
          expect(
            i == lines.length - 1 || lines[i + 1].isEmpty,
            isTrue,
            reason: '$code: "$line" looks like a wrapped line',
          );
          continue;
        }
        // A real paragraph line ends a sentence (。！？ in Japanese, । in
        // Hindi).
        expect(
          line.trimRight(),
          matches(RegExp(r'[.!?…:»"。！？」।]$')),
          reason: '$code: "$line" looks like a wrapped line',
        );
      }
    }
  });
}
