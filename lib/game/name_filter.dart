/// Pure-Dart player-name validation + profanity screening. No Flutter imports.
///
/// The name is public (it shows on the shared leaderboard), so it is screened
/// for slurs and insults. Like most casual games this is a **local blocklist
/// with normalization** — it catches the obvious cases and common obfuscation
/// (leetspeak "n1gg3r", spaced "f u c k", elongated "fuuuck"), but it is not a
/// perfect moderation system (no server-side AI here by design). Keep the
/// lists conservative to avoid false positives on innocent names.
library;

/// Why a name was rejected. The message shown to the player is localized in
/// the UI layer (see `nameProblemText`).
enum NameProblem { tooShort, tooLong, invalidCharacters, offensive }

class NameFilter {
  const NameFilter._();

  static const int minLength = 2;
  static const int maxLength = 14;

  static final RegExp _allowed = RegExp(r'^[A-Za-z0-9 _\-]+$');

  /// Returns why [raw] is unacceptable, or null if it's fine. Covers length,
  /// allowed characters, and profanity.
  static NameProblem? problem(String raw) {
    final name = raw.trim();
    if (name.length < minLength) return NameProblem.tooShort;
    if (name.length > maxLength) return NameProblem.tooLong;
    if (!_allowed.hasMatch(name)) return NameProblem.invalidCharacters;
    if (isOffensive(name)) return NameProblem.offensive;
    return null;
  }

  static bool isAcceptable(String raw) => problem(raw) == null;

  /// Whether [raw] contains a blocked term (after normalization).
  static bool isOffensive(String raw) {
    // Three forms, because one collapse rule cannot catch both shapes of
    // repetition. Collapsing runs to a single letter turns "fuuuck" into
    // "fuck" but also turns "niggggger" into "niger" and "assss" into "as" --
    // destroying the very match it is meant to find. Collapsing to at most
    // two keeps the doubled letters those words actually have.
    // Measured before this change: "niggggger" and "assss" both passed.
    final forms = <String>{
      _normalize(raw, runLimit: 0),
      _normalize(raw, runLimit: 1),
      _normalize(raw, runLimit: 2),
    };

    // Hard slurs: blocked anywhere in the string (catches "xXniggerXx").
    for (final w in _hardBlock) {
      for (final f in forms) {
        if (f.contains(w)) return true;
        // Reversal is a standard dodge ("reggin"). Only applied to the hard
        // list: reversing a mild word invites false positives for no gain.
        if (f.split('').reversed.join().contains(w)) return true;
      }
    }
    // Milder insults: only as a standalone token or the whole name, so
    // innocent names that merely contain the letters (e.g. "Cassie") pass.
    final tokens = <String>{
      ...forms,
      for (final t in raw.toLowerCase().split(RegExp(r'[^a-z0-9]+')))
        for (final limit in const [0, 1, 2]) _normalize(t, runLimit: limit),
    };
    for (final w in _wordBlock) {
      if (tokens.contains(w)) return true;
    }
    return false;
  }

  /// Lowercases, maps common leetspeak to letters, drops everything that isn't
  /// a-z, and shortens runs of the same letter to [runLimit] characters.
  ///
  /// [runLimit] 0 leaves runs untouched, 1 collapses them to a single letter,
  /// 2 to a pair. Callers check all three: no single limit catches both
  /// "fuuuck" (needs 1) and "niggggger" (needs 2).
  static String _normalize(String s, {required int runLimit}) {
    final lower = s.toLowerCase();
    final buf = StringBuffer();
    for (final ch in lower.split('')) {
      buf.write(_leet[ch] ?? ch);
    }
    final t = buf.toString().replaceAll(RegExp(r'[^a-z]'), '');
    if (runLimit == 0) return t;
    // replaceAllMapped, not replaceAll: the latter does not expand $1.
    return t.replaceAllMapped(
      RegExp(r'(.)\1+'),
      (m) => m.group(1)! * runLimit,
    );
  }

  static const Map<String, String> _leet = {
    '0': 'o',
    '1': 'i',
    '2': 'z',
    '3': 'e',
    '4': 'a',
    '5': 's',
    // 6 was missing, which let "ni66er" through unchanged.
    '6': 'g',
    '7': 't',
    '8': 'b',
    '9': 'g',
    '@': 'a',
    r'$': 's',
    '!': 'i',
    '+': 't',
  };

  // Content-moderation blocklists (normalized, letters only). Kept deliberately
  // small and unambiguous. `_hardBlock` = slurs blocked anywhere; `_wordBlock`
  // = insults blocked only as a whole token to avoid false positives.
  static const Set<String> _hardBlock = {
    // English slurs / strong profanity
    'nigger', 'nigga', 'faggot', 'retard', 'motherfucker',
    'whore', 'rapist', 'pedophile', 'nazi', 'hitler',
    'kike', 'chink',
    // Moved up from the token list: "xXfuckXx", "thefuck" and "fuckyou" all
    // passed as tokens. No allowed name contains it innocently -- German
    // "Fuchs" normalizes to "fuchs", which does not.
    'fuck',
    // German slurs / strong profanity
    'hurensohn', 'wichser', 'fotze', 'nutte', 'missgeburt', 'schwuchtel',
    'neger', 'judensau', 'vergewaltiger', 'kinderficker', 'spast', 'spasti',
  };

  static const Set<String> _wordBlock = {
    // English (token-matched to avoid false positives like "Scunthorpe")
    'shit', 'bitch', 'ass', 'asshole', 'dick', 'cock', 'pussy',
    'bastard', 'slut', 'penis', 'vagina', 'porn', 'cunt', 'rape', 'pedo',
    'spic', 'coon', 'nigga',
    // German
    'arsch', 'arschloch', 'scheisse', 'scheis', 'schlampe', 'hure', 'penner',
    'fick', 'ficker', 'ficken', 'schwanz', 'muschi',
  };
}
