/// The pair a successful Firebase init hands back.
///
/// Its own file so both halves of the conditional import in `firebase_boot.dart`
/// can name it without importing each other.
library;

import 'analytics.dart';
import 'crash_reporter.dart';
import 'stats_consent.dart';

/// A record rather than separate calls: they are initialised together, and
/// either all exist or none does. [analytics] and [crashes] only pass anything
/// on while the player allows statistics (`stats_consent.dart`).
typedef FirebaseServices = ({
  Analytics analytics,
  CrashReporter crashes,
  StatsCollection collection,
});
