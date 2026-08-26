import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/ui/format.dart';

void main() {
  test('groups thousands the German way', () {
    expect(formatCount(0), '0');
    expect(formatCount(7), '7');
    expect(formatCount(999), '999');
    expect(formatCount(1000), '1.000');
    expect(formatCount(12840), '12.840');
    expect(formatCount(100000), '100.000');
    expect(formatCount(1234567), '1.234.567');
  });

  test('handles the boundaries a score can actually reach', () {
    // Measured over 60.000 simulated runs: p95 ~9.600, max ~29.000.
    expect(formatCount(9602), '9.602');
    expect(formatCount(28894), '28.894');
  });

  test('a negative value keeps its sign', () {
    // Not reachable from a score today, but the helper is general.
    expect(formatCount(-4200), '-4.200');
  });
}
