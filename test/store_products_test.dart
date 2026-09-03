// Every product ID the code expects must exist in the console, and the only
// record of what was created there is docs/LAUNCH.md. qubble_neon_theme showed
// what happens when the two drift: the code queried a product nobody had ever
// created, and nothing said so — an unknown product simply does not come back
// from the store, and the shop only lists what it gets.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/iap.dart';

void main() {
  final launchDoc = File('docs/LAUNCH.md').readAsStringSync();

  test('every product the app queries is listed for the console', () {
    for (final id in IapProducts.all) {
      expect(
        launchDoc.contains('`$id`'),
        isTrue,
        reason:
            '$id is in IapProducts.all but not in the console product table '
            'of docs/LAUNCH.md, so it would never be created and the app '
            'would query a product that does not exist',
      );
    }
  });

  test('the doc lists no product the app does not know', () {
    // The other direction: a product created in the console that the app never
    // queries is money asked for and never delivered.
    final listed = RegExp(r'^\| `(qubble_[a-z_]+)`', multiLine: true)
        .allMatches(launchDoc)
        .map((m) => m.group(1)!)
        .toSet();
    expect(listed, isNotEmpty, reason: 'the table must be parseable');
    expect(listed.difference(IapProducts.all), isEmpty);
  });

  test('the coin packs and the consumable flag agree', () {
    for (final id in IapProducts.coinAmounts.keys) {
      expect(IapProducts.isConsumable(id), isTrue, reason: '$id grants coins');
      expect(IapProducts.all, contains(id));
    }
    // The supporter pack and the neon theme are permanent unlocks; selling
    // either as a consumable would let the store charge twice for something
    // the player already owns.
    expect(IapProducts.isConsumable(IapProducts.supporter), isFalse);
    expect(IapProducts.isConsumable(IapProducts.neonTheme), isFalse);
  });
}
