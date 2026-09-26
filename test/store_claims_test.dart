// Store metadata must survive a reading of the code, because a listing that
// overstates the app is a Misrepresentation case rather than a marketing
// choice -- and Google cross-checks the listing against the Data safety
// declaration in docs/DATA-SAFETY.md.
//
// This exists because the same three claims were removed twice and came back
// a third time in a place nobody looked. Phase 5 of the audit took them out of
// docs/STORE-LISTING.md; store-assets/store-listing.csv still carried all
// three, and the screenshot captions carried two more of their own -- one of
// them "your data stays on the phone", flatly contradicting a declaration that
// names five shared data types.
//
// Every entry below is disproved by a specific line of code, named with it.
// If a claim here becomes true, delete its entry -- do not weaken the match.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Claim -> why it is false.
const disproved = <String, String>{
  'no server':
      'the leaderboard writes name and score to Cloud Firestore '
          '(lib/services/leaderboard.dart:133-166)',
  'kein server':
      'die Bestenliste schreibt Name und Punktestand nach Cloud Firestore '
          '(lib/services/leaderboard.dart:133-166)',
  // The same claim in the languages added on 2026-09-23, so a later edit of
  // a translated listing cannot bring it back either.
  'sin servidor': 'the leaderboard writes to Cloud Firestore',
  'sem servidor': 'the leaderboard writes to Cloud Firestore',
  'sans serveur': 'the leaderboard writes to Cloud Firestore',
  'senza server': 'the leaderboard writes to Cloud Firestore',
  'sunucu yok': 'the leaderboard writes to Cloud Firestore',
  'tanpa server': 'the leaderboard writes to Cloud Firestore',
  'zonder server': 'the leaderboard writes to Cloud Firestore',
  'bez serwera': 'the leaderboard writes to Cloud Firestore',
  'không cần máy chủ': 'the leaderboard writes to Cloud Firestore',
  'サーバー不要': 'the leaderboard writes to Cloud Firestore',
  'サーバーなし': 'the leaderboard writes to Cloud Firestore',
  '서버 없이': 'the leaderboard writes to Cloud Firestore',
  '서버가 필요 없': 'the leaderboard writes to Cloud Firestore',
  'ไม่มีเซิร์ฟเวอร์': 'the leaderboard writes to Cloud Firestore',
  'ไม่ต้องใช้เซิร์ฟเวอร์': 'the leaderboard writes to Cloud Firestore',
  '無伺服器': 'the leaderboard writes to Cloud Firestore',
  '不需要伺服器': 'the leaderboard writes to Cloud Firestore',
  '无服务器': 'the leaderboard writes to Cloud Firestore',
  '不需要服务器': 'the leaderboard writes to Cloud Firestore',
  'بدون خادم': 'the leaderboard writes to Cloud Firestore',
  'بلا خادم': 'the leaderboard writes to Cloud Firestore',
  'لا يحتاج إلى خادم': 'the leaderboard writes to Cloud Firestore',
  'без сервера': 'the leaderboard writes to Cloud Firestore',
  'без серверу': 'the leaderboard writes to Cloud Firestore',
  'बिना सर्वर': 'the leaderboard writes to Cloud Firestore',
  'सर्वर की ज़रूरत नहीं': 'the leaderboard writes to Cloud Firestore',
  'tanpa pelayan': 'the leaderboard writes to Cloud Firestore',
  'fără server': 'the leaderboard writes to Cloud Firestore',
  'bez serveru': 'the leaderboard writes to Cloud Firestore',
  'szerver nélkül': 'the leaderboard writes to Cloud Firestore',
  'nincs szerver': 'the leaderboard writes to Cloud Firestore',
  'utan server': 'the leaderboard writes to Cloud Firestore',
  'ingen server': 'the leaderboard writes to Cloud Firestore',
  'bez servera': 'the leaderboard writes to Cloud Firestore',
  'χωρίς διακομιστή': 'the leaderboard writes to Cloud Firestore',
  'χωρίς server': 'the leaderboard writes to Cloud Firestore',
  'uden server': 'the leaderboard writes to Cloud Firestore',
  'data stays on the phone':
      'docs/DATA-SAFETY.md declares five shared data types',
  'daten bleiben auf dem handy':
      'docs/DATA-SAFETY.md deklariert fünf geteilte Datenarten',
  'minimum number of moves':
      'every solved level awards 3 stars regardless of move count '
          '(audit/03-loop.md L-2)',
  'mindestzahl an zügen':
      'jedes gelöste Level gibt 3 Sterne, unabhängig von der Zugzahl '
          '(audit/03-loop.md L-2)',
  'kein zeitdruck':
      'the combo expires after 10 s with a visible countdown '
          '(lib/game/scoring.dart:50)',
};

/// Files whose text reaches the store listing.
const storeFacing = <String>[
  'store-assets/store-listing.csv',
  'tool/caption_screenshots.py',
  'audit/copy/long-en.txt',
  'audit/copy/long-de.txt',
  'store-assets/listing/es-419/full_description.txt',
  'store-assets/listing/fr-FR/full_description.txt',
  'store-assets/listing/id/full_description.txt',
  'store-assets/listing/it-IT/full_description.txt',
  'store-assets/listing/pt-BR/full_description.txt',
  'store-assets/listing/pt-PT/full_description.txt',
  'store-assets/listing/tr-TR/full_description.txt',
  'store-assets/listing/nl-NL/full_description.txt',
  'store-assets/listing/pl-PL/full_description.txt',
  'store-assets/listing/vi/full_description.txt',
  'store-assets/listing/ja-JP/full_description.txt',
  'store-assets/listing/ko-KR/full_description.txt',
  'store-assets/listing/th/full_description.txt',
  'store-assets/listing/zh-TW/full_description.txt',
  'store-assets/listing/zh-CN/full_description.txt',
  'store-assets/listing/ar/full_description.txt',
  'store-assets/listing/uk/full_description.txt',
  'store-assets/listing/hi-IN/full_description.txt',
  'store-assets/listing/ms/full_description.txt',
  'store-assets/listing/ro/full_description.txt',
  'store-assets/listing/cs-CZ/full_description.txt',
  'store-assets/listing/hu-HU/full_description.txt',
  'store-assets/listing/sv-SE/full_description.txt',
  'store-assets/listing/sk/full_description.txt',
  'store-assets/listing/el-GR/full_description.txt',
  'store-assets/listing/da-DK/full_description.txt',
];

void main() {
  for (final path in storeFacing) {
    test('$path makes no claim the code disproves', () {
      final file = File(path);
      expect(file.existsSync(), isTrue, reason: '$path is missing');
      final text = file.readAsStringSync().toLowerCase();

      final found = <String>[];
      disproved.forEach((claim, why) {
        if (text.contains(claim)) found.add('"$claim" — $why');
      });

      expect(
        found,
        isEmpty,
        reason: 'Claims that do not survive a reading of the code:\n'
            '  ${found.join('\n  ')}',
      );
    });
  }

  test('the claim list is actually checked against something', () {
    // Guards the guard: a typo in a path would make every test above pass by
    // reading an empty string.
    for (final path in storeFacing) {
      expect(
        File(path).readAsStringSync().length,
        greaterThan(200),
        reason: '$path looks empty — the checks above would be vacuous',
      );
    }
  });
}
