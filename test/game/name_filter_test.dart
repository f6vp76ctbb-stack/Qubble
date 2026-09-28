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
