import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/name_filter.dart';

void main() {
  group('length + characters', () {
    test('rejects too short / too long', () {
      expect(NameFilter.problem('a'), isNotNull);
      expect(NameFilter.problem('a' * 15), isNotNull);
    });

    test('rejects disallowed characters', () {
      expect(NameFilter.problem('Max!'), isNotNull);
      expect(NameFilter.problem('a.b'), isNotNull);
    });

    test('accepts normal names', () {
      for (final n in ['Max', 'Anna_1', 'cool-kid', 'Player 2', 'Cassie']) {
        expect(NameFilter.problem(n), isNull, reason: n);
      }
    });

    test('rejects the shape Firestore reserves for document ids', () {
      // A name is also the id of its reservation document, and Firestore
      // refuses ids of the form __…__.
      expect(NameFilter.problem('__abc__'), NameProblem.invalidCharacters);
      expect(NameFilter.problem('____'), NameProblem.invalidCharacters);
      expect(NameFilter.problem('__abc'), isNull);
      expect(NameFilter.problem('abc__'), isNull);
    });
  });

  group('canonical', () {
    test('trims and collapses runs of spaces', () {
      // "Max  1" and "Max 1" look the same on the leaderboard; if both were
      // allowed, a name could be taken twice in all but the spacing.
      expect(NameFilter.canonical('  Max   1 '), 'Max 1');
      expect(NameFilter.canonical('Max 1'), 'Max 1');
    });

    test('keeps case: "Max" and "max" are different names (owner, '
        '28.09.2026)', () {
      expect(NameFilter.canonical('Max'), isNot(NameFilter.canonical('max')));
    });

    test('checks the canonical form, so spacing cannot sneak past the length '
        'limit', () {
      expect(NameFilter.problem('Max${' ' * 20}1'), isNull);
      expect(NameFilter.canonical('Max${' ' * 20}1'), 'Max 1');
    });
  });

  group('profanity screening', () {
    test('blocks obvious slurs and insults', () {
      for (final n in ['Hurensohn', 'fuck', 'Wichser', 'bitch', 'arschloch']) {
        expect(NameFilter.isOffensive(n), isTrue, reason: n);
      }
    });

    test('catches leetspeak and spacing obfuscation', () {
      for (final n in ['f u c k', 'Fuuuck', 'Sh1t', 'a55hole', 'n1gg3r']) {
        expect(NameFilter.isOffensive(n), isTrue, reason: n);
      }
    });

    test('does not flag innocent names that merely contain letters', () {
      // "Cassie" contains "ass", "Dickson" contains "dick" — must still pass
      // via whole-token matching.
      for (final n in ['Cassie', 'Dickson', 'Assam', 'Scunthorpe', 'Klaus']) {
        expect(NameFilter.isOffensive(n), isFalse, reason: n);
      }
    });

    test('problem() surfaces a friendly message for offensive names', () {
      expect(NameFilter.problem('Hurensohn'), NameProblem.offensive);
    });
  });

  group('the languages the app speaks since 2026-09-23', () {
    // A player who reads the game in Spanish or Turkish types insults in
    // Spanish or Turkish. The leaderboard shows names to everyone, so the
    // filter has to know at least the unambiguous ones.
    test('blocks the obvious ones, with the usual obfuscation', () {
      for (final n in [
        'HijoDePuta', 'puta', 'Mierda', 'Caralho', 'Porra', 'Salope',
        'Connard', 'Vaffanculo', 'Stronzo', 'Orospu', 'Siktir', 'Kontol',
        'Bangsat', 'Klootzak', 'Kanker', 'Kurwa', 'Chuj', 'Ditme', 'DCM',
        'k u r w a', 'Kurwaaa', 'c4ralho', 'xXsiktirXx',
      ]) {
        expect(NameFilter.isOffensive(n), isTrue, reason: n);
      }
    });

    test('does not flag innocent names that contain the letters', () {
      // Each of these contains a token-only word inside an ordinary one:
      // "puta" in Reputation and Diputado, "pute" in Computer, "kut" in
      // Kutay, "porra" in Porras, "kanker" in Kankerman. Token matching is
      // what lets them through.
      for (final n in [
        'Reputation', 'Computer', 'Diputado', 'Lulu', 'Kutay', 'Porras',
        'Merdan', 'Picasso', 'Amka', 'Tolola', 'Cazzola', 'Duman',
        'Chujo', 'Anjani', 'Kankerman',
      ]) {
        expect(NameFilter.isOffensive(n), isFalse, reason: n);
      }
    });
  });
}
