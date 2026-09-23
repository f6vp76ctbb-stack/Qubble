// Every character the game draws has to be in the font it ships.
//
// The web build bundles Nunito and nothing else. When a glyph is missing,
// Flutter's web renderer fetches a fallback font from fonts.gstatic.com — the
// same request no_web_emoji_test.dart exists to prevent: offline the PWA shows
// an empty box, online it sends the player's IP to a server the privacy policy
// does not name. On Android a missing glyph falls back to the system font,
// which works but breaks the look mid-sentence.
//
// With eight languages this is no longer a German-umlaut question: Turkish
// needs ğ, ş and ı, French œ and its no-break spaces. This reads the font's
// own character map, so a translation that introduces a new character is
// caught before it ships, not on a player's screen.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/ui/locale.dart';

/// Code points mapped by the font's Unicode BMP cmap subtable (format 4).
///
/// Nunito carries exactly two cmap subtables, both format 4 (checked with
/// fontTools); a format this parser does not know fails the test loudly
/// instead of passing on an empty set.
Set<int> _cmap(Uint8List bytes) {
  final data = ByteData.sublistView(bytes);
  final numTables = data.getUint16(4);
  int? cmapOffset;
  for (var i = 0; i < numTables; i++) {
    final record = 12 + i * 16;
    final tag = ascii.decode(bytes.sublist(record, record + 4));
    if (tag == 'cmap') cmapOffset = data.getUint32(record + 8);
  }
  if (cmapOffset == null) throw StateError('font has no cmap table');

  final subtables = data.getUint16(cmapOffset + 2);
  for (var i = 0; i < subtables; i++) {
    final record = cmapOffset + 4 + i * 8;
    final platform = data.getUint16(record);
    final encoding = data.getUint16(record + 2);
    final offset = cmapOffset + data.getUint32(record + 4);
    // Windows Unicode BMP — the subtable Flutter's shaper reads first.
    if (platform != 3 || encoding != 1) continue;
    final format = data.getUint16(offset);
    if (format != 4) throw StateError('unexpected cmap format $format');

    final segX2 = data.getUint16(offset + 6);
    final endCodes = offset + 14;
    final startCodes = endCodes + segX2 + 2;
    final deltas = startCodes + segX2;
    final rangeOffsets = deltas + segX2;
    final mapped = <int>{};
    for (var s = 0; s < segX2 ~/ 2; s++) {
      final end = data.getUint16(endCodes + s * 2);
      final start = data.getUint16(startCodes + s * 2);
      final delta = data.getInt16(deltas + s * 2);
      final rangeOffsetPos = rangeOffsets + s * 2;
      final rangeOffset = data.getUint16(rangeOffsetPos);
      for (var c = start; c <= end && c != 0xFFFF; c++) {
        int glyph;
        if (rangeOffset == 0) {
          glyph = (c + delta) & 0xFFFF;
        } else {
          final glyphPos = rangeOffsetPos + rangeOffset + (c - start) * 2;
          glyph = data.getUint16(glyphPos);
          if (glyph != 0) glyph = (glyph + delta) & 0xFFFF;
        }
        if (glyph != 0) mapped.add(c);
      }
    }
    return mapped;
  }
  throw StateError('font has no Windows Unicode BMP cmap');
}

/// Drawn by the operating system, never by Flutter (see no_web_emoji_test).
const _nativeOnly = {
  'notificationDailyTitle',
  'notificationStreakTitle',
  'notificationComebackTitle',
};

void main() {
  final glyphs = _cmap(File('assets/fonts/Nunito.ttf').readAsBytesSync());

  test('the parser reads the font it is pointed at', () {
    // Guards the parser: an empty or wrong set would make the checks below
    // meaningless in one direction or the other.
    for (final c in 'AZaz09äöüßğşıİçœ€'.runes) {
      expect(glyphs, contains(c), reason: String.fromCharCode(c));
    }
    // Known absentees: an arrow and the narrow no-break space French numbers
    // default to (lib/ui/format.dart swaps it out for that reason).
    expect(glyphs, isNot(contains(0x2192)));
    expect(glyphs, isNot(contains(0x202F)));
  });

  final arbs = Directory('lib/l10n')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  for (final file in arbs) {
    final code = RegExp(r'app_(\w+)\.arb$').firstMatch(file.path)!.group(1)!;
    final nativeOnly = kNativeOnlyLanguages.contains(code);
    test(
      nativeOnly
          ? '$code is native-only because Nunito cannot draw it'
          : 'every character in app_$code.arb is in Nunito',
      () {
        final map =
            jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        final missing = <String>[];
        map.forEach((key, value) {
          if (key.startsWith('@') || _nativeOnly.contains(key)) return;
          if (value is! String) return;
          for (final rune in value.runes) {
            if (rune == 0x0A) continue; // line break, not drawn
            if (!glyphs.contains(rune)) {
              final hex = rune.toRadixString(16).toUpperCase().padLeft(4, '0');
              missing.add('$key: U+$hex "${String.fromCharCode(rune)}"');
            }
          }
        });
        if (nativeOnly) {
          // The web build leaves these out (lib/ui/locale.dart). A language
          // on that list that Nunito can draw after all is being withheld
          // from web players for nothing.
          expect(
            missing,
            isNotEmpty,
            reason: '$code needs no other font — take it off '
                'kNativeOnlyLanguages',
          );
          return;
        }
        expect(
          missing,
          isEmpty,
          reason: 'Nunito cannot draw these. On the web that means a font '
              'request to Google or an empty box offline; pick a character '
              'the font has, or — for a whole script — put the language on '
              'kNativeOnlyLanguages.',
        );
      },
    );
  }
}
