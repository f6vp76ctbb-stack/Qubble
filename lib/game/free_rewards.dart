/// Voluntary reward videos in the shop (owner, 30.09.2026): three a day for
/// gold and three a day for diamonds, each counted on its own. Pure Dart, no
/// Flutter imports.
///
/// Like every video in Qubble they are a bonus the player asks for, never a
/// price for playing (CLAUDE.md). The day is the player's local calendar day,
/// like the Daily.
library;

import 'daily.dart';

/// What a reward video pays in.
enum FreeReward { coins, diamonds }

class FreeRewards {
  const FreeRewards._();

  /// Videos per kind and day.
  static const int perDay = 3;

  /// What one video pays.
  static const int coins = 100;
  static const int diamonds = 3;

  static int amount(FreeReward reward) => switch (reward) {
    FreeReward.coins => coins,
    FreeReward.diamonds => diamonds,
  };

  /// Videos of one kind still open at [now], given the stored record: the day
  /// it was last used ([day], yyyy-mm-dd) and how often ([used]). A new day
  /// starts at [perDay] again.
  static int left({
    required String? day,
    required int used,
    required DateTime now,
  }) {
    if (day != DailyChallenge.dateKey(now)) return perDay;
    final rest = perDay - used;
    return rest < 0 ? 0 : rest;
  }
}
