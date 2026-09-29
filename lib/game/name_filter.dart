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

  /// What a name may consist of, besides single spaces: A–Z, digits, _ and
  /// -, and since 29.09.2026 (owner) Latin letters with accents — ä, ß, é, ñ,
  /// ç, ş, ğ, ı, ł, ő, ș, ə, the Vietnamese letters. Only those the bundled
  /// Nunito draws, so the web build shows every name without a fallback font
  /// (test/game/name_filter_test.dart checks the font). Other scripts stay
  /// out: the blocklist below cannot read them, and letters that look alike
  /// across scripts would let "Max" exist twice.
  ///
  /// Mirrored, character for character, in `validName` in
  /// firebase/firestore.rules.
  static const String nameCharacters =
      r'A-Za-z0-9_\-'
      r'\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u0131\u0134-\u0137\u0139-\u013E'
      r'\u0141-\u0148\u014A-\u017E\u018F\u01A0\u01A1\u01AF\u01B0'
      r'\u0218-\u021B\u0259\u1E9E\u1EA0-\u1EF9';

  static final RegExp _allowed = RegExp('^[ $nameCharacters]+\$');

  /// Firestore reserves document ids of this shape, and a name is also the id
  /// of its reservation document (`names/{name}`).
  static final RegExp _reservedId = RegExp(r'^__.*__$');

  /// The form a name is stored, compared and reserved in: trimmed, with runs
  /// of spaces collapsed to one. Otherwise "Max  1" and "Max 1" would be two
  /// names that look identical on the leaderboard. Case is kept: "Max" and
  /// "max" are different names (owner's decision, 28.09.2026).
  static String canonical(String raw) =>
      raw.trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Returns why [raw] is unacceptable, or null if it's fine. Covers length,
  /// allowed characters, and profanity. Judged in [canonical] form, which is
  /// the form that gets saved.
  static NameProblem? problem(String raw) {
    final name = canonical(raw);
    if (name.length < minLength) return NameProblem.tooShort;
    if (name.length > maxLength) return NameProblem.tooLong;
    if (!_allowed.hasMatch(name)) return NameProblem.invalidCharacters;
    if (_reservedId.hasMatch(name)) return NameProblem.invalidCharacters;
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
      for (final t in _foldAll(raw.toLowerCase()).split(RegExp(r'[^a-z0-9]+')))
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
      buf.write(_leet[ch] ?? _fold(ch));
    }
    final t = buf.toString().replaceAll(RegExp(r'[^a-z]'), '');
    if (runLimit == 0) return t;
    // replaceAllMapped, not replaceAll: the latter does not expand $1.
    return t.replaceAllMapped(
      RegExp(r'(.)\1+'),
      (m) => m.group(1)! * runLimit,
    );
  }

  /// A lower-case accented letter as the plain letters it reads as: "ï" is
  /// an "i" to the blocklist, or "nïgger" would pass once accents are
  /// allowed. Covers every lower-case letter of [nameCharacters].
  static String _fold(String ch) {
    final i = _accented.indexOf(ch);
    if (i >= 0) return _plain[i];
    return _foldWide[ch] ?? ch;
  }

  static String _foldAll(String s) => s.split('').map(_fold).join();

  static const String _accented =
      'àáâãäåçèéêëìíîïðñòóôõöøùúûüýÿāăąćĉċčďđēĕėęěĝğġģĥħĩīĭįıĵķĺļľłńņňŋōŏőŕ'
      'ŗřśŝşšţťŧũūŭůűųŵŷźżžơưșțəạảấầẩẫậắằẳẵặẹẻẽếềểễệỉịọỏốồổỗộớờởỡợụủứừửữựỳỵỷỹ';
  static const String _plain =
      'aaaaaaceeeeiiiidnoooooouuuuyyaaaccccddeeeeegggghhiiiiijkllllnnnnooor'
      'rrsssstttuuuuuuwyzzzousteaaaaaaaaaaaaeeeeeeeeiioooooooooooouuuuuuuyyyy';
  static const Map<String, String> _foldWide = {
    'ß': 'ss',
    'æ': 'ae',
    'þ': 'th',
    'œ': 'oe',
  };

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
    // The languages added on 2026-09-23. Names are A-Z only, so every entry
    // is written without accents, the way a player would have to type it.
    // Only words that no innocent name contains go here; anything that
    // hides inside ordinary words ("puta" in "reputation") is token-only.
    // Spanish
    'hijodeputa', 'hijoputa', 'putamadre', 'gilipollas', 'maricon',
    // Portuguese
    'caralho', 'buceta', 'arrombado', 'filhodaputa',
    // French
    'encule', 'salope',
    // Italian
    'vaffanculo', 'puttana', 'frocio',
    // Turkish
    'orospu', 'siktir', 'yarrak', 'aminakoyim',
    // Indonesian
    'kontol', 'memek', 'ngentot',
    // Dutch
    'klootzak', 'flikker', 'kankerlijer',
    // Polish
    'kurwa', 'skurwysyn', 'pierdol', 'jebac', 'jebany', 'pizda',
    // Vietnamese
    'ditme', 'cailon',
  };

  static const Set<String> _wordBlock = {
    // English (token-matched to avoid false positives like "Scunthorpe")
    'shit', 'bitch', 'ass', 'asshole', 'dick', 'cock', 'pussy',
    'bastard', 'slut', 'penis', 'vagina', 'porn', 'cunt', 'rape', 'pedo',
    'spic', 'coon', 'nigga',
    // German
    'arsch', 'arschloch', 'scheisse', 'scheis', 'schlampe', 'hure', 'penner',
    'fick', 'ficker', 'ficken', 'schwanz', 'muschi',
    // Spanish
    'puta', 'pendejo', 'cabron', 'mierda', 'culero', 'verga', 'chinga',
    'chingada', 'zorra',
    // Portuguese
    'porra', 'viado', 'cuzao', 'merda', 'foder', 'fodase', 'vadia', 'otario',
    // French
    'connard', 'connasse', 'pute', 'putain', 'merde', 'batard', 'nique',
    'niquer', 'fdp', 'tapette',
    // Italian
    'stronzo', 'stronza', 'cazzo', 'coglione', 'bastardo', 'minchia',
    'zoccola',
    // Turkish
    'amk', 'ibne', 'gavat', 'pezevenk', 'kahpe', 'yavsak', 'amcik',
    // Indonesian
    'anjing', 'bangsat', 'bajingan', 'goblok', 'tolol', 'kampret', 'jancok',
    // Dutch
    'kanker', 'kut', 'hoer', 'lul', 'tering', 'neuken', 'mongool', 'kutwijf',
    // Polish
    'chuj', 'cwel', 'dziwka', 'kurwy',
    // Vietnamese
    'dume', 'duma', 'dmm', 'dcm', 'vcl', 'occho',
  };
}
