/// The pair a successful Firebase init hands back.
///
/// Its own file so both halves of the conditional import in `firebase_boot.dart`
/// can name it without importing each other.
library;

import 'analytics.dart';
import 'crash_reporter.dart';

/// A record rather than two calls: the two are initialised together, and
/// either both exist or neither does.
typedef FirebaseServices = ({Analytics analytics, CrashReporter crashes});
