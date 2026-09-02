/// Shared entry point for the voluntary rewarded offers.
///
/// Every one of them used to be fire-and-forget: with no ad loaded — no fill,
/// offline, consent declined — the player tapped and nothing happened at all.
/// A button that appears broken is the worst possible shape for the one ad
/// format in the game, which CLAUDE.md requires to be voluntary and honest.
library;

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Runs [action] if a video can actually be shown, and otherwise says so.
///
/// Generic over the action's result because the offers do not agree on one:
/// the piggy bank reports how many coins it paid out, the rest report whether
/// the reward landed. Nothing here inspects the value — a `false` (or a null
/// payout) after the video ran is left silent on purpose, since the player
/// closed it themselves and does not need telling what they just did.
/// [available] comes from whichever controller owns the offer — endless and
/// puzzle mode have their own, and both ask the same ad service.
Future<T?> runRewardedAction<T>(
  BuildContext context, {
  required bool available,
  required Future<T> Function() action,
}) async {
  if (!available) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(
      SnackBar(content: Text(L10n.of(context).adNotAvailable)),
    );
    return null;
  }
  return action();
}
