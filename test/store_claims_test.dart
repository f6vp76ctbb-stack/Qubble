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
