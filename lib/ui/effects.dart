/// Scaling for the game's decorative effects (MASTERPLAN.md D.5.1).
///
/// Reduced effects exist for two different players: older or weaker devices
/// that drop frames on a 220-particle burst, and people who find flashing,
/// shaking and glowing screens genuinely unpleasant. Both want the same
/// thing -- the game still readable, the celebration turned down -- so this
/// is one switch rather than a graphics menu.
///
/// Kept as pure functions so the rule is testable and identical everywhere,
/// rather than a factor sprinkled across five painters.
library;

import 'dart:math' as math;

class Effects {
  const Effects._();

  /// How much of an effect survives when the switch is on.
  static const double reducedFactor = 0.4;

  /// Particle count, never dropping to zero: a clear with no burst at all
  /// reads as a missed input rather than a calmer effect.
  static int particles(int full, {required bool reduced}) =>
      reduced ? math.max(1, (full * reducedFactor).round()) : full;

  /// Blur radius for glow shadows. Reduced play gets a hard edge instead of
  /// a halo -- the shape still marks the element, without the bloom.
  static double blur(double full, {required bool reduced}) =>
      reduced ? 0 : full;

  /// Spread radius of the same glow, kept small rather than removed so the
  /// element does not visibly change size when the switch is flipped.
  static double spread(double full, {required bool reduced}) =>
      reduced ? full * reducedFactor : full;
}
