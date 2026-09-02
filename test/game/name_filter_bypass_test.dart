// Bypasses the name filter used to let through, and the innocent names it
// must keep letting through.
//
// The leaderboard shows these names to every other player, which is what
// makes the app a UGC app under Play's policy (audit/07-compliance.md B-1).
// That audit called the filter bypassable without saying how; this file is
// the measurement. Every entry below was run against the filter before the
// fix -- the blocked ones all passed, and the innocent ones all passed too,
// which is the half that constrains the fix.
//
// A blocklist is never complete, and this is not claimed to be. It is the
// obvious-cases layer beneath reporting and blocking, not a substitute for
// them.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/name_filter.dart';

void main() {
  group('repetition no longer destroys the match', () {
    // The original collapse reduced runs to a single letter, which turns
    // "fuuuck" into "fuck" but also "niggggger" into "niger" and "assss" into
    // "as". One rule cannot do both, so all three run lengths are checked.
    test('a lengthened hard slur is still caught', () {
      expect(NameFilter.isOffensive('niggggger'), isTrue);
    });

    test('a lengthened token insult is still caught', () {
      expect(NameFilter.isOffensive('assss'), isTrue);
    });

    test('the case the single collapse was written for still works', () {
      expect(NameFilter.isOffensive('fuuuck'), isTrue);
    });
  });

  group('leetspeak', () {
    test('digits that were missing from the map', () {
      // 6 and 2 had no mapping, so "ni66er" normalized to "nier".
      expect(NameFilter.isOffensive('ni66er'), isTrue);
    });

    test('the digits that were already mapped still work', () {
      expect(NameFilter.isOffensive('n1gg3r'), isTrue);
      expect(NameFilter.isOffensive('a55hole'), isTrue);
    });
  });

  group('structure', () {
    test('separators do not hide a slur', () {
      expect(NameFilter.isOffensive('n i g g e r'), isTrue);
      expect(NameFilter.isOffensive('n-i-g-g-e-r'), isTrue);
    });

    test('reversal does not hide a hard slur', () {
      expect(NameFilter.isOffensive('reggin'), isTrue);
    });

    test('embedding no longer hides the strongest profanity', () {
      // These are token-matched words otherwise; this one was promoted to the
      // hard list because no allowed name contains it innocently.
      expect(NameFilter.isOffensive('xXfuckXx'), isTrue);
      expect(NameFilter.isOffensive('fuckyou'), isTrue);
      expect(NameFilter.isOffensive('thefuck'), isTrue);
    });
  });

  group('innocent names still pass', () {
    // The constraint on every rule above. A filter that blocks real names is
    // not stricter, it is broken -- and the player has no way to argue.
    const names = [
      // Contain a blocked substring by accident
      'Cassie', 'Scunthorpe', 'Assistant', 'Dickens', 'Shitake', 'Pussycat',
      'Analyse', 'Fuchs', 'Grasso', 'Rosso', 'Bossy', 'Sassy',
      // Doubled letters, which the run-length forms rewrite
      'Anna', 'Otto', 'Emma', 'Willi', 'Hanna', 'Anni', 'Elli', 'Hasso',
      // Reversals of these must not hit the hard list either
      'Regina', 'Renner', 'Nagel', 'Regin',
      // Plain names and the default-ish ones
      'Max', 'Bella', 'Klaus', 'Finn', 'Jonas', 'Lea', 'Mia', 'Noah',
      'Ben', 'Paul', 'Lina', 'Player 1', 'Cool_Guy', 'Qubble Fan',
    ];

    for (final name in names) {
      test('"$name" is accepted', () {
        expect(
          NameFilter.problem(name),
          isNot(NameProblem.offensive),
          reason: '$name is a name a real player could choose',
        );
      });
    }
  });
}
