// A rejected or unavailable purchase used to be swallowed: PurchaseStatus
// .error and .canceled were ignored, and buy() returned silently when the
// product was not published. During a closed test — where the items usually
// are not published yet — that made "Kaufen" indistinguishable from a dead
// button, which is exactly the kind of noise a playtest should not collect.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/iap.dart';

/// Records what the UI would have been told.
class _Recorder {
  final List<String> delivered = [];
  final List<IapFailure> failures = [];

  FutureOr<void> deliver(String id) {
    delivered.add(id);
  }

  void fail(IapFailure reason) => failures.add(reason);
}

void main() {
  group('IapFailure', () {
    test('covers the outcomes the UI has to distinguish', () {
      expect(IapFailure.values, hasLength(3));
      expect(
        IapFailure.values,
        containsAll([
          IapFailure.error,
          IapFailure.canceled,
          IapFailure.unavailable,
        ]),
      );
    });
  });

  group('every implementation accepts the failure callback', () {
    test('FakeIap still delivers and never reports a failure', () async {
      final r = _Recorder();
      final iap = FakeIap();
      await iap.initialize(r.deliver, onFailure: r.fail);
      await iap.buy(IapProducts.coinsS);

      expect(r.delivered, [IapProducts.coinsS]);
      expect(r.failures, isEmpty);
    });

    test(
      'LockedIap delivers nothing — the web build must not grant coins',
      () async {
        final r = _Recorder();
        final iap = LockedIap();
        await iap.initialize(r.deliver, onFailure: r.fail);
        await iap.buy(IapProducts.supporter);

        expect(iap.available, isFalse);
        expect(iap.products, isEmpty);
        expect(
          r.delivered,
          isEmpty,
          reason: 'the public web build must never hand out entitlements',
        );
      },
    );

    test('the callback is optional', () async {
      final r = _Recorder();
      final iap = FakeIap();
      await iap.initialize(r.deliver);
      await iap.buy(IapProducts.coinsM);
      expect(r.delivered, [IapProducts.coinsM]);
    });
  });
}
