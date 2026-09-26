// Section labels are set in capitals. Greek writes capitals without the
// accent (tonos); String.toUpperCase keeps it, and "ΉΧΟΣ" reads as a typo.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/ui/format.dart';

void main() {
  test('Greek capitals drop the tonos', () {
    expect(upperCaseFor('Ήχος και δόνηση', 'el'), 'ΗΧΟΣ ΚΑΙ ΔΟΝΗΣΗ');
    expect(upperCaseFor('Άνεση', 'el'), 'ΑΝΕΣΗ');
    expect(upperCaseFor('Αγορές', 'el'), 'ΑΓΟΡΕΣ');
    expect(upperCaseFor('Ρυθμίσεις', 'el'), 'ΡΥΘΜΙΣΕΙΣ');
  });

  test('a diaeresis stays, only the accent above it goes', () {
    expect(upperCaseFor('\u0390 \u03B0', 'el'), '\u03AA \u03AB'); // ΐ ΰ → Ϊ Ϋ
  });

  test('every other language keeps its marks', () {
    expect(upperCaseFor('Sprache', 'de'), 'SPRACHE');
    expect(upperCaseFor('Français', 'fr'), 'FRANÇAIS');
    expect(upperCaseFor('Ήχος', 'en'), 'ΉΧΟΣ');
  });
}
