/// Attaches state to crash reports.
///
/// A release stack trace says where the app died, not what it was doing. With
/// R8 mapping applied it names the method; it still does not say whether the
/// player was in the Daily, on puzzle level 40, or three runs into their first
/// session. Those are the keys that turn "a crash in placement" into something
/// reproducible.
///
/// Kept separate from [Analytics] because the two answer different questions
/// and have different lifetimes: analytics is a funnel, this is the state of
/// the world at the moment something broke.
library;

import 'package:flutter/foundation.dart';

/// Canonical key names. Crashlytics allows 64 custom keys per report.
class CrashKey {
  const CrashKey._();

  /// `endless`, `daily` or `puzzle`.
  static const mode = 'mode';

  /// The puzzle level being played, when in puzzle mode.
  static const puzzleLevel = 'puzzle_level';

  /// Placements in the current run — distinguishes a crash on the first move
  /// from one two hundred moves in.
  static const placements = 'placements';

  /// Lifetime runs, bucketed the same way the analytics cohort is.
  static const playerTier = 'player_tier';
}

abstract class CrashReporter {
  /// Attaches [value] to every subsequent report under [key].
  void setKey(String key, Object value);

  /// Reports a caught error that did not crash the app.
  void record(Object error, StackTrace? stack, {String? reason});
}

/// Used on the web, in tests, and whenever Firebase is unavailable.
class NoopCrashReporter implements CrashReporter {
  const NoopCrashReporter();

  @override
  void setKey(String key, Object value) {}

  @override
  void record(Object error, StackTrace? stack, {String? reason}) {}
}

/// Prints instead of reporting, so the keys can be checked without Firebase.
class DebugCrashReporter implements CrashReporter {
  @override
  void setKey(String key, Object value) {
    debugPrint('[crash] $key=$value');
  }

  @override
  void record(Object error, StackTrace? stack, {String? reason}) {
    debugPrint('[crash] recorded${reason == null ? '' : ' ($reason)'}: $error');
  }
}
