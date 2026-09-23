// Strings written for a closed playtest read wrong in a public release: they
// point players at a test programme they were never part of. The storage
// error screen did exactly that — it asked for a report "in the playtest",
// which for a store user names nothing they can act on.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Words that only make sense while the app is in a closed test.
final _testOnlyWording = RegExp(
  r'playtest|closed test|geschlossene[nr]? test|Testphase',
  caseSensitive: false,
);

void main() {
  final arbs = Directory('lib/l10n')
      .listSync()
      .map((e) => e.path)
      .where((path) => path.endsWith('.arb'))
      .toList()
    ..sort();
  test('the scan finds every translation', () {
    expect(arbs.length, greaterThanOrEqualTo(8));
  });
  for (final path in arbs) {
    test('no closed-test wording reaches players ($path)', () {
      final map = jsonDecode(File(path).readAsStringSync()) as Map;
      final offenders = <String>[];
      map.forEach((key, value) {
        if (key is! String || value is! String || key.startsWith('@')) return;
        if (_testOnlyWording.hasMatch(value)) offenders.add('$key: $value');
      });
      expect(
        offenders,
        isEmpty,
        reason: 'a store user is not in a playtest and cannot act on this',
      );
    });
  }

  test('the guard would still catch the wording it was written for', () {
    expect(_testOnlyWording.hasMatch('report it in the playtest'), isTrue);
    expect(_testOnlyWording.hasMatch('melde das im Playtest'), isTrue);
    expect(_testOnlyWording.hasMatch('Settings, then Feedback'), isFalse);
  });
}
