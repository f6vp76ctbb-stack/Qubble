/// Live coin rewards earned while a run is being played.
///
/// This is game logic, not presentation: it decides income, and the economy
/// corridor test (MASTERPLAN.md D.4.1) measures it. Keeping it here rather
/// than in the controller means that test exercises the rule the game really
/// applies instead of a copy that can drift away from it.
///
/// Coins from missions, the daily challenge and level-ups are *not* part of
/// this — they are awarded outside a run and are excluded from the corridor
/// on purpose.
class CoinRules {
  const CoinRules._();

  /// Coins per cleared line (MASTERPLAN.md Anhang C.1 / A.3).
  static const int perLine = 3;

  /// Bonus for emptying the whole board (All Clear).
  static const int allClearBonus = 25;

  /// Live coins for a single move that cleared [lines] lines.
  ///
  /// [combo] is the combo count after the move; a running combo (> 1) adds
  /// its own count on top, so a long streak pays progressively more.
  /// Callers apply this only to moves that actually cleared something.
  static int forClear({
    required int lines,
    required int combo,
    required bool allClear,
  }) {
    var coins = lines * perLine;
    if (combo > 1) coins += combo;
    if (allClear) coins += allClearBonus;
    return coins;
  }
}
