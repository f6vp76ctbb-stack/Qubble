/// Thin wrapper around Flutter's haptic feedback, gated by a user setting.
library;

import 'package:flutter/services.dart';

/// How hard the phone taps back (MASTERPLAN.md D.5.3).
///
/// [light] is not a quieter version of the same pattern -- it maps every
/// event down to the gentlest impact the platform offers, so the feedback
/// stays informative for players who find the default jarring without
/// forcing them to choose between "distracting" and "nothing at all".
enum HapticStrength { off, light, strong }

class Haptics {
  /// On/off convenience. [HapticStrength.strong] is what the single-strength
  /// build always played, so "on" keeps feeling exactly as it did.
  Haptics({bool enabled = true})
      : strength = enabled ? HapticStrength.strong : HapticStrength.off;

  Haptics.withStrength(this.strength);

  HapticStrength strength;

  bool get enabled => strength != HapticStrength.off;
  set enabled(bool value) =>
      strength = value ? HapticStrength.strong : HapticStrength.off;

  /// Light tick when a piece locks onto the board.
  ///
  /// Already the gentlest feedback there is, so both strengths play it -- a
  /// "light" setting that muted the most frequent event would read as broken.
  void place() {
    if (enabled) HapticFeedback.selectionClick();
  }

  /// Medium bump when one or more lines clear.
  void clear() => _impact(
        light: HapticFeedback.selectionClick,
        strong: HapticFeedback.lightImpact,
      );

  /// Stronger feedback for a fever burst.
  void feverBurst() => _impact(
        light: HapticFeedback.lightImpact,
        strong: HapticFeedback.heavyImpact,
      );

  /// Feedback on game over.
  void gameOver() => _impact(
        light: HapticFeedback.lightImpact,
        strong: HapticFeedback.mediumImpact,
      );

  void _impact({
    required void Function() light,
    required void Function() strong,
  }) {
    switch (strength) {
      case HapticStrength.off:
        return;
      case HapticStrength.light:
        light();
      case HapticStrength.strong:
        strong();
    }
  }
}
