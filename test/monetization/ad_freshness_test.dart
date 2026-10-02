// A loaded rewarded video expires after about an hour (Google's ad
// preloading guide). Qubble keeps one loaded from start-up, and the app often
// waits in the background for hours, so an old video is replaced before a
// tap could hit an expired one.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/monetization/ads.dart';

void main() {
  final loaded = DateTime(2026, 10, 2, 9);

  test('a video stays usable for 55 minutes', () {
    expect(
      GoogleAdService.isFresh(loaded, loaded.add(const Duration(minutes: 54))),
      isTrue,
    );
  });

  test('from 55 minutes on it is replaced, before Google lets it expire', () {
    expect(GoogleAdService.maxAdAge, lessThan(const Duration(hours: 1)));
    expect(
      GoogleAdService.isFresh(loaded, loaded.add(GoogleAdService.maxAdAge)),
      isFalse,
    );
    expect(
      GoogleAdService.isFresh(loaded, loaded.add(const Duration(hours: 5))),
      isFalse,
    );
  });
}
