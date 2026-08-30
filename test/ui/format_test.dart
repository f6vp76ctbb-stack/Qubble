import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/ui/format.dart';

void main() {
  group('English (the source language, and the fallback)', () {
    test('groups thousands with a comma', () {
      expect(formatCount(0, locale: 'en'), '0');
      expect(formatCount(7, locale: 'en'), '7');
      expect(formatCount(999, locale: 'en'), '999');
      expect(formatCount(1000, locale: 'en'), '1,000');
      expect(formatCount(12840, locale: 'en'), '12,840');
      expect(formatCount(100000, locale: 'en'), '100,000');
      expect(formatCount(1234567, locale: 'en'), '1,234,567');
    });

    test('handles the boundaries a score can actually reach', () {
      // Measured over 60,000 simulated runs: p95 ~9,600, max ~29,000.
      expect(formatCount(9602, locale: 'en'), '9,602');
      expect(formatCount(28894, locale: 'en'), '28,894');
    });

    test('a negative value keeps its sign', () {
      // Not reachable from a score today, but the helper is general.
      expect(formatCount(-4200, locale: 'en'), '-4,200');
    });
  });

  group('German', () {
    test('groups thousands with a period', () {
      // The separator has to follow the language: a German player reading
      // "18,740" would see a decimal, not a score.
      expect(formatCount(1000, locale: 'de'), '1.000');
      expect(formatCount(12840, locale: 'de'), '12.840');
      expect(formatCount(1234567, locale: 'de'), '1.234.567');
      expect(formatCount(-4200, locale: 'de'), '-4.200');
    });

    test('small numbers are identical in both languages', () {
      for (final value in [0, 7, 42, 999]) {
        expect(formatCount(value, locale: 'de'), formatCount(value, locale: 'en'));
      }
    });
  });
}
