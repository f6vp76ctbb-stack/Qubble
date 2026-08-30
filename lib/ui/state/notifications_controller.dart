/// Riverpod controller that owns the on/off state of local notifications and
/// (re)schedules them from the pure [NotificationPlanner].
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/daily.dart';
import '../../services/notification_planner.dart';
import '../../services/notifications.dart';
import '../../services/storage.dart';
import 'game_controller.dart';

/// Default is silent; main overrides with [LocalNotifications].
final notificationServiceProvider =
    Provider<NotificationService>((ref) => NoopNotifications());

final notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, bool>((ref) {
  return NotificationsController(
    ref.read(storageProvider),
    ref.read(notificationServiceProvider),
  );
});

class NotificationsController extends StateNotifier<bool> {
  NotificationsController(this._storage, this._service)
      : super(_storage.notificationsEnabled);

  final Storage _storage;
  final NotificationService _service;

  /// The localized copy for the scheduled notes. Set from the UI (where
  /// [L10n] is available) before scheduling; falls back to English.
  NotificationTexts texts = NotificationTexts.fallback;

  /// Localized description of the Android notification channel.
  String? channelDescription;

  List<ScheduledNote> _plan() {
    final now = DateTime.now();
    return NotificationPlanner.plan(
      now: now,
      dailyDoneToday: _storage.lastDailyDate == DailyChallenge.dateKey(now),
      streak: _storage.streak,
      texts: texts,
    );
  }

  /// Re-schedules if enabled (call on app start and after daily/streak
  /// changes). Pass the localized [texts] so the notifications match the
  /// player's language.
  Future<void> refresh({
    NotificationTexts? texts,
    String? channelDescription,
  }) async {
    if (texts != null) this.texts = texts;
    if (channelDescription != null) this.channelDescription = channelDescription;
    if (!state) return;
    await _service.reschedule(
      _plan(),
      channelDescription: channelDescription,
    );
  }

  /// Requests OS permission and turns notifications on. Returns success.
  Future<bool> enable({
    NotificationTexts? texts,
    String? channelDescription,
  }) async {
    if (texts != null) this.texts = texts;
    if (channelDescription != null) this.channelDescription = channelDescription;
    final granted = await _service.requestPermission();
    if (!granted) return false;
    await _storage.setNotificationsEnabled(true);
    state = true;
    await _service.reschedule(
      _plan(),
      channelDescription: this.channelDescription,
    );
    return true;
  }

  Future<void> disable() async {
    await _storage.setNotificationsEnabled(false);
    state = false;
    await _service.cancelAll();
  }
}
