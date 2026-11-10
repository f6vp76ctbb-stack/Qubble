/// Pure-Dart piggy bank logic (MASTERPLAN.md C.5). No Flutter imports.
///
/// Fills with [PiggyBank.coinsPerLine] coins per cleared line during play
/// (separate from the normal coin balance). A FULL bank can be emptied for free; a partially filled one
/// can optionally be opened early by watching a rewarded video. Never a
/// purchase. Capacity grows each time it is opened, up to a cap.
library;

/// How loudly the home-screen chip calls for attention (owner, 28.09.2026).
enum PiggyAttention {
  /// Empty: nothing to see.
  none,

  /// Coins inside: a soft glow, stronger the fuller it is.
  glow,

  /// Full and not yet looked at: blinks until tapped once.
  blink,
}

class PiggyBank {
  const PiggyBank({required this.coins, required this.capacity});

  /// Coins banked per cleared line.
  ///
  /// At 1 per line against a 500 capacity, and ~15 lines in a typical run,
  /// the first payout took ~33 runs — roughly 50 minutes of play. Nobody in a
  /// closed test would ever see the piggy bank pay out, so a whole feature
  /// (and its rewarded-video hook) was invisible. Two per line against a 200
  /// starting capacity brought the first payout to ~7 runs.
  ///
  /// 12.10.2026 (owner: "viel mehr und schneller"): the shop's free videos
  /// now pay 500 gold each, and a piggy bank banking 30 coins a run lost to
  /// them on every count. Twelve per line banks ~180 a run, six times as
  /// fast. After three runs an early opening (~540) already beats a shop
  /// video — with no daily limit, so it stays worth a video once the shop's
  /// three are used up. Left alone, the first bank is full after five runs
  /// and pays 800 for free; each opening grows the next by 400, up to 4000.
  static const int coinsPerLine = 12;
  static const int baseCapacity = 800;
  static const int capacityStep = 400;
  static const int maxCapacity = 4000;

  /// Fill level warranting the "nearly full" hint (never nags earlier).
  static const double hintThreshold = 0.8;

  final int coins;
  final int capacity;

  factory PiggyBank.initial() =>
      const PiggyBank(coins: 0, capacity: baseCapacity);

  double get fillFraction => capacity == 0 ? 0 : (coins / capacity).clamp(0, 1);
  bool get showHint => fillFraction >= hintThreshold;
  bool get isEmpty => coins == 0;

  /// A full bank pays out for free (tap to collect).
  bool get isFull => coins >= capacity;

  /// The chip's state. [fullSeen] is whether the player tapped it since it
  /// last became full — one tap is enough, whether or not they empty it.
  PiggyAttention attention({required bool fullSeen}) {
    if (isEmpty) return PiggyAttention.none;
    if (isFull && !fullSeen) return PiggyAttention.blink;
    return PiggyAttention.glow;
  }

  /// 0 when empty, otherwise 0.25–1.0 with the fill: a few coins already
  /// show, a nearly full bank is bright.
  double get glowStrength => isEmpty ? 0 : 0.25 + 0.75 * fillFraction;

  /// Adds [lines] worth of coins, capped at [capacity].
  PiggyBank addLines(int lines) {
    if (lines <= 0) return this;
    final next = (coins + lines * coinsPerLine).clamp(0, capacity);
    return PiggyBank(coins: next, capacity: capacity);
  }

  /// Empties the bank and raises capacity by one step (up to the max). Returns
  /// the emptied bank; the payout is [coins].
  PiggyBank opened() {
    final nextCapacity =
        (capacity + capacityStep).clamp(baseCapacity, maxCapacity);
    return PiggyBank(coins: 0, capacity: nextCapacity);
  }
}
