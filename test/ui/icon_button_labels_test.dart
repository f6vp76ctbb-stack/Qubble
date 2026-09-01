import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every icon-only button has to carry a tooltip.
///
/// An IconButton with no tooltip is silent to TalkBack: it announces as a
/// button with no name, so the whole navigation row on the home screen —
/// shop, stats, settings — was three unnamed buttons. Flutter uses the
/// tooltip as the semantic label, so one property fixes both the hover hint
/// and the screen reader.
///
/// The board itself is deliberately out of scope. A drag-and-drop grid is not
/// usefully operable with a screen reader, and pretending otherwise by
/// labelling 64 cells would be worse than leaving it. The menus are a
/// different matter: they are ordinary lists and buttons.
void main() {
  test('no IconButton is left without a tooltip', () {
    final offenders = <String>[];

    for (final entity in Directory('lib/ui').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        if (!lines[i].contains('IconButton(')) continue;
        // The tooltip, if present, is one of the first few arguments.
        final window = lines.skip(i).take(14).join('\n');
        if (!window.contains('tooltip:')) {
          offenders.add('${entity.path}:${i + 1}');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: 'These buttons announce as unnamed to a screen reader:\n  '
          '${offenders.join('\n  ')}\n'
          'Add tooltip: — Flutter uses it as the semantic label too.',
    );
  });
}
