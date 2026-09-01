import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/analytics.dart';

import '../support/recording_analytics.dart';

/// Covers the analytics side of the consent handover.
///
/// The other end cannot be unit-tested: GoogleAdService talks to the UMP SDK
/// over a platform channel, and FirebaseAnalyticsBackend to Firebase over
/// another, so the round trip needs a device. What is testable is that the
/// contract carries the decision at all — before this it had nowhere to go —
/// and that both no-op implementations accept it, since the web build and
/// every test run on those.
void main() {
  group('ad consent', () {
    test('a granted decision reaches the backend', () {
      final analytics = RecordingAnalytics();
      analytics.setAdConsent(granted: true);
      expect(analytics.adConsent, [true]);
    });

    test('a refusal is reported too, not merely omitted', () {
      // Silence would be indistinguishable from consent never having been
      // asked for, which is the state the app was in before.
      final analytics = RecordingAnalytics();
      analytics.setAdConsent(granted: false);
      expect(analytics.adConsent, [false]);
    });

    test('a later change is passed on, not swallowed', () {
      // The player can reopen the privacy options from settings; a withdrawal
      // there is the case that matters most.
      final analytics = RecordingAnalytics();
      analytics
        ..setAdConsent(granted: true)
        ..setAdConsent(granted: false);
      expect(analytics.adConsent, [true, false]);
    });

    test('the no-op implementations accept it', () {
      // The web build and every test run on these.
      expect(() => NoopAnalytics().setAdConsent(granted: true), returnsNormally);
      expect(
        () => DebugAnalytics().setAdConsent(granted: false),
        returnsNormally,
      );
    });
  });
}
