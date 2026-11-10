/// The one-time question whether the game may send reminders.
///
/// Shared by the two places that may put it (lib/game/first_session.dart):
/// the end of a player's first Daily Challenge, where "come back tomorrow"
/// points at something, and — for players who never play one — a later
/// launch.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/notifications_controller.dart';

/// Asks, and switches the reminders on after a yes. Counted as asked the
/// moment it is shown: a dialog closed by leaving the app is an answer too.
Future<void> askForReminders(BuildContext context, WidgetRef ref) async {
  // Resolved before the dialog awaits, so it survives the async gap.
  final l10n = L10n.of(context);
  final notifications = ref.read(notificationsControllerProvider.notifier);
  final game = ref.read(gameControllerProvider.notifier);
  await ref.read(storageProvider).setReminderPromptAsked(true);
  if (!context.mounted) return;
  final enable = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(L10n.of(context).notificationsOptInTitle),
      content: Text(L10n.of(context).notificationsOptInBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(L10n.of(context).commonNotNow),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(L10n.of(context).notificationsOptInAccept),
        ),
      ],
    ),
  );
  if (enable ?? false) {
    await notifications.enable(
      texts: notificationTexts(l10n),
      channelDescription: l10n.notificationChannelDescription,
    );
  }
  // The answer to this prompt is one of the cohort properties, and whether
  // it earns its interruption is the question it exists to answer.
  if (game.mounted) game.refreshCohortProperties();
}
