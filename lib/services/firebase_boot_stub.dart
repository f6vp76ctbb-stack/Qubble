/// Web variant of the Firebase bootstrap: no Firebase SDK on the web build.
library;

import 'firebase_services.dart';
import 'stats_consent.dart';

Future<FirebaseServices?> initFirebase(StatsConsentGate gate) async => null;
