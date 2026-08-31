/// Pure-Dart planning for local notifications. No Flutter imports — decides
/// WHAT to schedule and WHEN from the current state (MASTERPLAN.md C.2). The
/// delivery plugin is wired separately in `notifications.dart`.
library;

enum GridNotification { dailyReminder, streakWarning, comeback }

/// The already-localized copy for the scheduled notifications. Built in the UI
/// layer (where [L10n] is available) and passed down, so this file stays pure
/// Dart and the planner stays unit-testable.
class NotificationTexts {
  const NotificationTexts({
    required this.dailyReminderTitle,
    required this.dailyReminderBody,
    required this.streakWarningTitle,
    required this.streakWarningBody,
    required this.comebackTitle,
    required this.comebackBody,
  });

  final String dailyReminderTitle;
  final String dailyReminderBody;

  /// Takes the streak length, which is part of the headline.
  final String Function(int streak) streakWarningTitle;
  final String streakWarningBody;
  final String comebackTitle;
  final String comebackBody;

  /// Placeholder copy for tests and for any code path without a locale.
  static NotificationTexts get fallback => NotificationTexts(
    dailyReminderTitle: 'Your daily puzzle is waiting 🧩',
    dailyReminderBody: "Play today's challenge!",
    streakWarningTitle: (streak) => '🔥 Your $streak-day streak is at risk!',
    streakWarningBody: 'Play today to keep it alive.',
    comebackTitle: 'Your puzzle misses you 🧩',
    comebackBody: 'Come back and pick up a gift!',
  );
}

class ScheduledNote {
  const ScheduledNote({
    required this.type,
    required this.when,
    required this.title,
    required this.body,
  });

  final GridNotification type;
  final DateTime when;
  final String title;
  final String body;

  /// Stable per-type id for the plugin (so re-scheduling replaces cleanly).
  int get id => type.index;
}

class NotificationPlanner {
  const NotificationPlanner._();

  static const int dailyReminderHour = 19;
  static const int streakWarningHour = 21;
  static const int streakWarningMinute = 30;
  static const int streakWarningMinStreak = 3;
  static const Duration comebackAfter = Duration(hours: 72);
  static const int comebackGiftCoins = 100;

  static DateTime _nextAt(
    DateTime now,
    int hour,
    int minute, {
    required bool skipToday,
  }) {
    var d = DateTime(now.year, now.month, now.day, hour, minute);
    if (skipToday || !d.isAfter(now)) {
      d = d.add(const Duration(days: 1));
    }
    return d;
  }

  /// The set of notifications to (re)schedule right now. Callers cancel all,
  /// then schedule these.
  static List<ScheduledNote> plan({
    required DateTime now,
    required bool dailyDoneToday,
    required int streak,
    required NotificationTexts texts,
  }) {
    return [
      ScheduledNote(
        type: GridNotification.dailyReminder,
        when: _nextAt(now, dailyReminderHour, 0, skipToday: dailyDoneToday),
        title: texts.dailyReminderTitle,
        body: texts.dailyReminderBody,
      ),
      if (streak >= streakWarningMinStreak)
        ScheduledNote(
          type: GridNotification.streakWarning,
          when: _nextAt(
            now,
            streakWarningHour,
            streakWarningMinute,
            skipToday: dailyDoneToday,
          ),
          title: texts.streakWarningTitle(streak),
          body: texts.streakWarningBody,
        ),
      ScheduledNote(
        type: GridNotification.comeback,
        when: now.add(comebackAfter),
        title: texts.comebackTitle,
        body: texts.comebackBody,
      ),
    ];
  }

  /// Coins to grant on opening after a long absence (comeback gift, C.2).
  static int comebackGift({
    required DateTime? lastActive,
    required DateTime now,
  }) {
    if (lastActive == null) return 0;
    return now.difference(lastActive) >= comebackAfter ? comebackGiftCoins : 0;
  }
}
