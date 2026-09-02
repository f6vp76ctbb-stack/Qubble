/// Pure-Dart decision logic for one-time, contextual in-game hints.
///
/// The hint *text* is localized in the UI layer (see `coachHintText`); this
/// file only decides which hint is due. The controller owns persistence and
/// presentation. Keeping the decision
/// here makes the order and trigger rules deterministic and unit-testable.
library;

enum CoachHintType { combo, fever, rotation, booster, strategy }

class CoachHintSignals {
  const CoachHintSignals({
    this.comboActive = false,
    this.feverActive = false,
    this.rotationUsed = false,
    this.boosterAffordable = false,
    this.strategyReady = false,
  });

  final bool comboActive;
  final bool feverActive;
  final bool rotationUsed;
  final bool boosterAffordable;

  /// The player has enough runs behind them for the deeper lesson to land.
  final bool strategyReady;
}

class CoachHints {
  const CoachHints._();

  /// Returns the highest-priority unseen hint whose trigger is active.
  ///
  /// Combo and fever are time-sensitive, so they take precedence over the
  /// persistent booster-affordability signal.
  /// Runs a player needs before the strategy hint is offered.
  ///
  /// It contradicts what the tutorial teaches ("clear a full row"), so it is
  /// held back until clearing is a habit rather than a new instruction. The
  /// weaker style is measurably weaker: `scripts/audit/balance.dart 800` puts
  /// `corner-pack` at 5025 average score against `lines-first` at 3781 — the
  /// tutorial teaches the variant that scores 33 % lower.
  static const int strategyAfterGames = 5;

  static CoachHintType? next({
    required CoachHintSignals signals,
    required Set<CoachHintType> seen,
  }) {
    final candidates = <(CoachHintType, bool)>[
      (CoachHintType.combo, signals.comboActive),
      (CoachHintType.fever, signals.feverActive),
      (CoachHintType.rotation, signals.rotationUsed),
      (CoachHintType.booster, signals.boosterAffordable),
      (CoachHintType.strategy, signals.strategyReady),
    ];
    for (final (hint, active) in candidates) {
      if (active && !seen.contains(hint)) return hint;
    }
    return null;
  }

}
