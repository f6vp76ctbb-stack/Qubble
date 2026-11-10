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
  ///
  /// 3 until 1.6.0. The generator's opening help (SpawnAssist) made runs about
  /// 60 % longer, and at 3 a line the weakest bot's income rose from 29 to 72
  /// coins a run, past the corridor's upper edge of 60. At 2, with the combo
  /// bonus capped, it is 52 a run and 1,42 a move against 1,28 before
  /// (test/game/economy_corridor_test.dart).
  static const int perLine = 2;

  /// Bonus for emptying the whole board (All Clear).
  static const int allClearBonus = 25;

  /// The most a running combo adds to one clear.
  ///
  /// Uncapped until 1.6.0: a combo of 14 paid 14 on top of every clear, so
  /// income grew faster than the run did.
  static const int comboBonusCap = 5;

  /// Live coins for a single move that cleared [lines] lines.
  ///
  /// [combo] is the combo count after the move; a running combo (> 1) adds
  /// its own count on top, up to [comboBonusCap].
  /// Callers apply this only to moves that actually cleared something.
  static int forClear({
    required int lines,
    required int combo,
    required bool allClear,
  }) {
    var coins = lines * perLine;
    if (combo > 1) coins += combo < comboBonusCap ? combo : comboBonusCap;
    if (allClear) coins += allClearBonus;
    return coins;
  }
}
