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
// Consistency: each listing names a few themes. The names must be the ones
// the app shows in that language, or the listing promises a "Madera" theme
// the player then cannot find. The same goes for the Qubbies it names.
//
// Google's own pages, read at the source on 14.11.2026 (docs/STORE-LISTING.md
// has the links and what is binding):
//  * Metadata policy: no word lists, nothing in capitals or special
//    characters to stand out, a succinct description.
//  * Preview assets, "Highly recommended": no "Best", "#1", "Top", "New",
//    "Free", "Discount", "Sale" and no "Play now" in the short description,
//    on a screenshot or on the feature graphic; a short description without
//    symbols, and with full stops only between sentences; alt text of at
//    most 140 characters for every graphic.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/pet.dart';
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

/// The four listings written by hand (owner, 09.11.2026): Play locale code ->
/// app language code. Every other store language is translated by the Play
/// Console itself and has no file in this repository — sixty hand-kept
/// listings were why the store entry stood still from September on.
const _appLanguage = {
  'en-US': 'en',
  'de-DE': 'de',
  'es-419': 'es',
  'pt-BR': 'pt',
};

// Words are matched whole: no letter or digit may touch either end. `\b`
// could not do that — it only knows ASCII letters, so a word starting or
// ending in "ü", "í" or "á" ("ücretsiz", "miễn phí") never matched at all.
// Scripts without spaces between words (Japanese, Thai, Chinese …) sit outside
// the group: there a banned word is banned wherever it appears. So does
// Hebrew, which writes "for free" as one word (בחינם), and the Indic
// languages, which glue endings onto it (இலவசமாக, ఉచితంగా, મફતમાં).
final _bannedInTitle = RegExp(
  r'(?<![\p{L}\p{N}])(top|best|#1|no\.? ?1|free|no ads|ad[- ]free|gratis|grátis|'
  r'gratuit|ücretsiz|kostenlos|sin anuncios|sem anúncios|sans pub|darmowe?|'
  r'za darmo|miễn phí|percuma|tanpa iklan|terbaik|fără reclame|cel mai bun|'
  r'zdarma|bez reklam|nejlepší|ingyen\p{L}*|reklámmentes|reklám nélkül|'
  r'legjobb|bäst|bästa|reklamfri|utan reklam|zadarmo|bez reklám|najlepš\p{L}*|δωρεάν|χωρίς διαφημίσεις|καλύτερ\p{L}*|κορυφαί\p{L}*|bedste|uden reklamer|reklamefri|beste|uten reklame|uten annonser|reklamefritt|ilmai\p{L}*|paras|parhaat|mainokseton|ilman mainoksia|безплатн\p{L}*|най-добр\p{L}*|besplatn\p{L}*|bez oglasa|najbolj\p{L}*|libre|walang ads?|pinakamahusay|pinakamagaling|مفت|بلا معاوضہ|اشتہارات کے بغیر|بغیر اشتہارات|بہترین|سب سے اچھا|gratuït|gratuïta|sense anuncis|el millor|millors?|bure|bila matangazo|bora|bora zaidi|bepul|reklamasiz|eng yaxshi|eng zo‘r|pulsuz|reklamsız|ən yaxşı|nemokam\p{L}*|be reklam\p{L}*|geriausi\p{L}*|tasuta|reklaamivaba|ilma reklaamideta|parim\p{L}*|bezmaksas|bez maksas|bez reklām\p{L}*|labāk\p{L}*|brezplačn\p{L}*|brez oglasov|najboljš\p{L}*|бесплатн\p{L}*|без огласа|најбољ\p{L}*|тегін\p{L}*|жарнамасыз\p{L}*|ең жақсы|үздік\p{L}*|falas|pa reklama|më (?:i|e) mir\p{L}*|më të mirat|без реклами|најдобр\p{L}*|sonder advertensies|advertensievry)(?![\p{L}\p{N}])|#1|無料|広告なし|人気|무료|광고 없는|인기|ฟรี|'
  r'ไม่มีโฆษณา|ดีที่สุด|免費|免费|無廣告|无广告|最好玩|最佳|مجاني|مجانًا|مجانا|'
  r'بدون إعلانات|بلا إعلانات|الأفضل|безкоштовн|без реклами|найкращ|मुफ़्त|मुफ्त|'
  r'फ्री|फ़्री|बिना विज्ञापन|सर्वश्रेष्ठ|חינם|ללא פרסומות|בלי פרסומות|הכי טוב|'
  r'הטוב ביותר|இலவச|விளம்பரமில்லா|விளம்பரம் இல்லா|சிறந்த|ఉచిత|ప్రకటనలు లేని|ఉత్తమ|મફત|જાહેરાત વગર|જાહેરાત વિના|શ્રેષ્ઠ|ઉત્તમ|ಉಚಿತ|ಜಾಹೀರಾತು ರಹಿತ|ಜಾಹೀರಾತುಗಳಿಲ್ಲದ|ಅತ್ಯುತ್ತಮ|സൗജന്യ|പരസ്യരഹിത|പരസ്യമില്ലാത്ത|ഏറ്റവും മികച്ച|ਮੁਫ਼ਤ|ਮੁਫਤ|ਇਸ਼ਤਿਹਾਰ-ਮੁਕਤ|ਬਿਨਾਂ ਇਸ਼ਤਿਹਾਰ|ਇਸ਼ਤਿਹਾਰਾਂ ਤੋਂ ਬਿਨਾਂ|ਸਭ ਤੋਂ ਵਧੀਆ|ਸਰਵੋਤਮ|ਸਰਬੋਤਮ|বিনামূল্যে|বিনা মূল্যে|ফ্রি|বিজ্ঞাপনমুক্ত|বিজ্ঞাপন ছাড়া|বিজ্ঞাপনহীন|সেরা|সর্বশ্রেষ্ঠ|मोफत|फ्री|जाहिरातमुक्त|जाहिरातींशिवाय|जाहिरातीशिवाय|सर्वोत्तम|सर्वोत्कृष्ट|निःशुल्क|नि:शुल्क|विज्ञापनरहित|विज्ञापनबिना|विज्ञापन बिना|सबैभन्दा राम्रो',
  caseSensitive: false,
  unicode: true,
);

/// The words Google names for the short description, the screenshots and the
/// feature graphic ("Best", "#1", "Top", "New", "Free", "Discount", "Sale",
/// "Million Downloads"), and its examples of a call to action — in the four
/// languages written here. Whole words only.
final _promotional = RegExp(
  r'(?<![\p{L}\p{N}])('
  r'best|top|new|free|discount|sale|million downloads|'
  r'download now|install now|play now|try now|'
  r'beste[rsnm]?|neu|neue[rsnm]?|gratis|kostenlos\p{L}*|rabatt\p{L}*|'
  r'sonderangebot\p{L}*|millionen downloads|jetzt (?:herunterladen|laden|'
  r'installieren|spielen|testen|ausprobieren)|'
  r'mejor(?:es)?|nuev[oa]s?|gratuit[oa]s?|descuento|rebaja|oferta|'
  r'millones de descargas|(?:descarga|instala|juega|prueba)(?:r)? (?:ya|ahora)|'
  r'melhor(?:es)?|nov[oa]s?|grátis|gratuit[oa]s?|desconto|promoção|'
  r'milhões de downloads|(?:baixe|instale|jogue|experimente) (?:já|agora)'
  r')(?![\p{L}\p{N}])|#1',
  caseSensitive: false,
  unicode: true,
);

/// The text between two markers of a tool's source: the captions of the
/// screenshots and the copy of the feature graphic live there as literals.
String _between(String path, String from, String to) {
  final src = File(path).readAsStringSync();
  final start = src.indexOf(from);
  final end = src.indexOf(to, start + from.length);
  if (start < 0 || end < 0) throw StateError('$path: "$from" … "$to"');
  return src.substring(start, end);
}

/// Width, height and colour type of a PNG, from its header.
({int width, int height, int colourType}) _pngHeader(String path) {
  final b = File(path).readAsBytesSync();
  int be(int at) =>
      (b[at] << 24) | (b[at + 1] << 16) | (b[at + 2] << 8) | b[at + 3];
  return (width: be(16), height: be(20), colourType: b[25]);
}

void main() {
  test('the promotional-word check finds what it is for', () {
    for (final text in [
      'A new board every day',
      'Jeden Tag ein neues Brett',
      'Un tablero nuevo cada día',
      'Um tabuleiro novo todo dia',
      'The best block puzzle',
      'Play now',
      'Jetzt spielen',
      '#1 puzzle',
      'Jogue agora',
    ]) {
      expect(_promotional.hasMatch(text), isTrue, reason: text);
    }
    // … and whole words only.
    for (final text in ['Topaz', 'Neon', 'Renew your streak', 'Novembro']) {
      expect(_promotional.hasMatch(text), isFalse, reason: text);
    }
  });

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
      listings.map((l) => l['language_code']).toSet(),
      _appLanguage.keys.toSet(),
      reason: 'exactly the four listings kept by hand',
    );
  });

  test('no other store language has files in the repository', () {
    final folders = Directory('store-assets/listing')
        .listSync()
        .whereType<Directory>()
        .map((d) => d.uri.pathSegments.where((s) => s.isNotEmpty).last)
        .toSet();
    expect(folders, _appLanguage.keys.toSet());
    // Image folders are named after the app language.
    final images = Directory('store-assets')
        .listSync()
        .whereType<Directory>()
        .where(
          (d) => File('${d.path}/feature-graphic-1024x500.png').existsSync(),
        )
        .map((d) => d.uri.pathSegments.where((s) => s.isNotEmpty).last)
        .toSet();
    expect(images, _appLanguage.values.toSet());
    final notes = Directory('docs/release-notes')
        .listSync()
        .whereType<File>()
        .map((f) => f.uri.pathSegments.last)
        .where((name) => name.endsWith('.txt'))
        .map((name) => name.substring(name.indexOf('-') + 1, name.length - 4))
        .toSet();
    expect(notes, _appLanguage.values.toSet());
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
    test('$code names a few themes, under the names the app shows', () {
      final listing = listings.firstWhere((l) => l['language_code'] == code);
      final l10n = lookupL10n(localeFromCode(entry.value));
      final full = listing['full_description']!;
      bool names(String theme) => RegExp(
        '(?<![\\p{L}\\p{N}])${RegExp.escape(theme)}(?![\\p{L}\\p{N}])',
        unicode: true,
      ).hasMatch(full);
      // The ones it names are in the catalog under these names — in this
      // language: "Candy" is "Bonbon" in German and "Doce" in Portuguese.
      for (final id in ['neon', 'ocean', 'candy', 'glacier', 'aurora']) {
        expect(
          names(themeName(l10n, id)),
          isTrue,
          reason: '$code: the app calls it "${themeName(l10n, id)}"',
        );
      }
      // Aurora is the one that takes the supporter pack, and the text says so.
      expect(
        kThemeCatalog.where((t) => t.supporterOnly).map((t) => t.id),
        ['aurora'],
      );
      // … and no more than those. All eleven in a row is the "horizontal
      // word list" Google's metadata policy shows as a violation, which is
      // what the listing had until 14.11.2026. A seasonal theme is not named
      // at all: it is for sale one month a year.
      final named = [
        for (final theme in kThemeCatalog)
          if (names(themeName(l10n, theme.id))) theme.id,
      ];
      expect(named, hasLength(lessThanOrEqualTo(5)), reason: '$code: $named');
      for (final theme in kThemeCatalog.where((t) => t.saleMonth != null)) {
        expect(named, isNot(contains(theme.id)), reason: '$code: seasonal');
      }
    });
  }

  for (final entry in _appLanguage.entries) {
    final code = entry.key;
    test('$code says about the Qubbies what the game does', () {
      final listing = listings.firstWhere((l) => l['language_code'] == code);
      final l10n = lookupL10n(localeFromCode(entry.value));
      final full = listing['full_description']!;
      // The three it names are in the catalog under these names.
      for (final id in ['kiki', 'funki', 'pyra']) {
        expect(petById(id), isNotNull);
        expect(full, contains(petName(l10n, id)), reason: '$code: $id');
      }
      // "Nine are waiting", "after your third run", "one of three".
      expect(kPetCatalog, hasLength(9));
      expect(PetRules.firstEggAfterRuns, 3);
      expect(kStarterPetIds, hasLength(3));
      // Funki is the one that burns rows.
      expect(petById('funki')!.signature, PetSignature.fire);
      // "11 themes" and "22 block skins" are the ones for sale all year.
      expect(kThemeCatalog.where((t) => t.saleMonth == null), hasLength(11));
      expect(kSkinCatalog.where((s) => s.saleMonth == null), hasLength(22));
      expect(
        kSkinCatalog.where((s) => s.achievementId != null),
        hasLength(8),
      );
      expect(full, contains('11 '));
      expect(full, contains('22 '));
    });
  }

  test('every listing has its images and release notes', () {
    // A language whose texts are ready but whose screenshots are not would
    // show English pictures under a translated description — and
    // tool/export_play_metadata.py refuses to lay it out.
    final version = RegExp(r'^version:\s*([0-9.]+)\+', multiLine: true)
        .firstMatch(File('pubspec.yaml').readAsStringSync())!
        .group(1)!;
    for (final listing in listings) {
      final code = listing['language_code']!;
      final app = _appLanguage[code];
      expect(app, isNotNull, reason: '$code maps to no app language');
      final shots = Directory('store-assets/$app')
          .listSync()
          .whereType<File>()
          .where((f) => f.uri.pathSegments.last.startsWith('screenshot-'));
      expect(shots, hasLength(8), reason: '$code screenshots');
      expect(
        File('store-assets/$app/feature-graphic-1024x500.png').existsSync(),
        isTrue,
        reason: '$code feature graphic',
      );
      expect(
        File('docs/release-notes/$version-$app.txt').existsSync(),
        isTrue,
        reason: '$code "What\'s new" for $version',
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
        if (line.isEmpty) continue;
        // A section heading: a short line of its own, after a blank line and
        // right above its paragraph.
        final heading =
            line.length <= 40 &&
            i > 0 &&
            lines[i - 1].isEmpty &&
            i + 1 < lines.length &&
            lines[i + 1].isNotEmpty;
        if (heading) continue;
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
        // Hindi, ۔ in Urdu).
        expect(
          line.trimRight(),
          matches(RegExp(r'[.!?…:»"。！？」।۔؟]$')),
          reason: '$code: "$line" looks like a wrapped line',
        );
      }
    }
  });

  test('no description shouts, decorates or lists', () {
    // Metadata policy: "Don't use special characters or all caps to
    // manipulate search ranking"; "word blocks and vertical/horizontal word
    // lists" is one of its examples of a violation. The listings had
    // capital headings behind a "▸" and a bulleted block until 14.11.2026.
    // Arrows, dingbats, geometric shapes, stars and hearts, and the emoji
    // planes — as ranges, because the analyzer does not know the
    // "Extended_Pictographic" property.
    final decoration = RegExp(
      r'[•\u{2190}-\u{21FF}\u{2300}-\u{23FF}\u{25A0}-\u{27BF}'
      r'\u{2900}-\u{297F}\u{2B00}-\u{2BFF}\u{1F000}-\u{1FAFF}]',
      unicode: true,
    );
    final capitals = RegExp(r'^[^\p{Ll}]*\p{Lu}[^\p{Ll}]*$', unicode: true);
    for (final listing in listings) {
      final code = listing['language_code']!;
      final full = listing['full_description']!;
      expect(
        decoration.allMatches(full).map((m) => m.group(0)),
        isEmpty,
        reason: '$code: decoration in the description',
      );
      for (final line in full.split('\n')) {
        final letters = RegExp(r'\p{L}', unicode: true).allMatches(line).length;
        if (letters < 4) continue;
        expect(capitals.hasMatch(line), isFalse, reason: '$code: "$line"');
      }
      // A word in capitals inside a sentence: only the brand may.
      final shouted = RegExp(
        r'(?<![\p{L}\p{N}])\p{Lu}{4,}(?![\p{L}\p{N}])',
        unicode: true,
      ).allMatches(full).map((m) => m.group(0));
      expect(shouted, isEmpty, reason: '$code: $shouted');
    }
  });

  test('the short descriptions are plain sentences', () {
    // Preview-assets page, short description: no special characters, line
    // breaks, emojis, repeated punctuation or symbols; full stops only when
    // there is more than one sentence; none of the promotional words and no
    // call to action.
    final plain = RegExp(r"^[\p{L}\p{N} .,:;'’&-]+$", unicode: true);
    for (final listing in listings) {
      final code = listing['language_code']!;
      final short = listing['short_description']!;
      expect(plain.hasMatch(short), isTrue, reason: '$code: "$short"');
      expect(short, isNot(contains('  ')), reason: code);
      expect(
        RegExp(r'[.,:;!?-]{2,}').hasMatch(short),
        isFalse,
        reason: '$code: repeated punctuation',
      );
      final stops = '.'.allMatches(short).length;
      if (stops == 1) {
        fail('$code: one sentence takes no full stop — "$short"');
      }
      if (stops > 1) expect(short, endsWith('.'), reason: code);
      expect(
        _promotional.allMatches(short).map((m) => m.group(0)),
        isEmpty,
        reason: '$code: "$short"',
      );
    }
  });

  test('no caption or banner uses a word Google bars from them', () {
    final sources = {
      'screenshot captions': _between(
        'tool/caption_screenshots.py',
        'CAPTIONS = {',
        '# The numbers the captions were written for.',
      ),
      'feature graphic': _between(
        'tool/feature_graphic.py',
        'COPY = {',
        'def scene(',
      ),
    };
    for (final entry in sources.entries) {
      expect(entry.value.length, greaterThan(200), reason: entry.key);
      expect(
        _promotional.allMatches(entry.value).map((m) => m.group(0)),
        isEmpty,
        reason: entry.key,
      );
    }
  });

  test('the first screenshot, the banner and the short description each say '
      'something of their own', () {
    // "Avoid duplication and redundancy of messaging across your short
    // description, screenshots, feature graphics … these assets may be shown
    // side by side." All three said "pets that play along" until 14.11.2026.
    final captions = _between(
      'tool/caption_screenshots.py',
      'CAPTIONS = {',
      '# The numbers the captions were written for.',
    );
    final banner = _between('tool/feature_graphic.py', 'COPY = {', 'def scene(');
    String firstHeadline(String app) {
      final block = captions.substring(captions.indexOf('"$app": {'));
      final m = RegExp(r'"1-qubbie": \("([^"]+)"').firstMatch(block)!;
      return m.group(1)!.replaceAll(r'\n', ' ').replaceAll('.', '').trim();
    }

    String tagline(String app) {
      final m = RegExp(
        '"$app": \\("[^"]+", "([^"]+)"',
      ).firstMatch(banner)!;
      return m.group(1)!.replaceAll('.', '').trim();
    }

    for (final entry in _appLanguage.entries) {
      final short = listings.firstWhere(
        (l) => l['language_code'] == entry.key,
      )['short_description']!.toLowerCase();
      final headline = firstHeadline(entry.value).toLowerCase();
      final line = tagline(entry.value).toLowerCase();
      expect(headline, isNot(line), reason: entry.key);
      expect(short, isNot(contains(headline)), reason: entry.key);
      expect(short, isNot(contains(line)), reason: entry.key);
    }
  });

  test('every graphic has an alt text a screen reader can use', () {
    // "Include alt text with each graphic asset … using 140 characters or
    // less", without "photo of" / "image of". The Play API has no field for
    // it (androidpublisher v3, revision 20261026), so these are typed into
    // the Console by hand — ANLEITUNG.md.
    final opener = RegExp(
      r'^(photo|image|picture|screenshot|bild|foto|screenshot|imagen|captura|'
      r'imagem) (of|von|vom|de|da|do)\b',
      caseSensitive: false,
    );
    for (final entry in _appLanguage.entries) {
      final lines = File(
        'store-assets/listing/${entry.key}/alt_texts.txt',
      ).readAsLinesSync().where((l) => l.trim().isNotEmpty).toList();
      final alt = {
        for (final line in lines)
          line.substring(0, line.indexOf(': ')): line.substring(
            line.indexOf(': ') + 2,
          ),
      };
      final graphics = Directory('store-assets/${entry.value}')
          .listSync()
          .whereType<File>()
          .map((f) => f.uri.pathSegments.last)
          .where((n) => n.endsWith('.png'))
          .map(
            (n) => n.startsWith('feature-graphic')
                ? 'feature-graphic'
                : n.substring(0, n.length - 4),
          )
          .toSet();
      expect(alt.keys.toSet(), graphics, reason: entry.key);
      alt.forEach((name, text) {
        expect(
          text.length,
          inInclusiveRange(20, 140),
          reason: '${entry.key} $name',
        );
        expect(opener.hasMatch(text), isFalse, reason: '${entry.key} $name');
      });
    }
  });

  test('the graphics have the sizes Play takes, without transparency', () {
    // Requirements of the preview-assets page: screenshots as JPEG or 24-bit
    // PNG without alpha; three or more at 1080×1920 for the formats that
    // recommend games; the feature graphic exactly 1024×500.
    for (final app in _appLanguage.values) {
      final dir = Directory('store-assets/$app');
      for (final file in dir.listSync().whereType<File>()) {
        final name = file.uri.pathSegments.last;
        if (!name.endsWith('.png')) continue;
        final png = _pngHeader(file.path);
        // Colour type 2 is RGB; 6 would be RGB with alpha.
        expect(png.colourType, 2, reason: '${file.path} has an alpha channel');
        if (name.startsWith('screenshot-')) {
          expect((png.width, png.height), (1080, 1920), reason: file.path);
        } else {
          expect((png.width, png.height), (1024, 500), reason: file.path);
        }
      }
    }
  });
}
