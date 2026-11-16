/// The bright layer of the menus (owner, 15.11.2026: the home screen did not
/// look inviting, the game-over menu button was too small — "übersichtlicher,
/// moderner, farbiger, froh, schön").
///
/// Everything here takes its colours from the active theme, so a player's
/// chosen look carries through: the glows behind the home screen are the
/// theme's tray colours, the big buttons a gradient of its accent. Only the
/// tiles of the home grid get fixed colours of their own, so each mode is
/// recognisable at a glance in every theme.
library;

import 'package:flutter/material.dart';

import '../theme.dart';

/// Dark ink for text and icons on the bright gradients and bubbles.
const Color kVividInk = Color(0xFF14102E);

/// Fixed accents for the home grid, one per mode.
class VividAccents {
  const VividAccents._();

  static const Color gold = Color(0xFFFFC24B);
  static const Color violet = Color(0xFFA58BFF);
  static const Color pink = Color(0xFFFF7EB6);
  static const Color mint = Color(0xFF4FE0B8);
  static const Color sky = Color(0xFF5CC8FF);
  static const Color orange = Color(0xFFFF9A52);
  static const Color coral = Color(0xFFFF6F91);
}

/// The shadows of a raised, pressable surface: a solid edge in a deep shade
/// of [color] right under it — the "3D" lip of a game button — and a soft
/// glow below that. [lift] is how far the surface stands above its edge;
/// pressed, it sinks to 1.
List<BoxShadow> vividLip(Color color, {double lift = 4, double glow = 0.3}) {
  return [
    BoxShadow(
      color: Color.lerp(color, Colors.black, 0.42)!,
      offset: Offset(0, lift),
    ),
    BoxShadow(
      color: color.withValues(alpha: glow),
      blurRadius: 20,
      offset: Offset(0, lift + 6),
    ),
  ];
}

/// Wraps a raised surface so it sinks onto its edge while pressed.
Widget _pressable(Set<WidgetState> states, double lift, Widget child) {
  final pressed = states.contains(WidgetState.pressed);
  return Transform.translate(
    offset: Offset(0, pressed ? lift - 1 : 0),
    child: child,
  );
}

/// A gradient [FilledButton] style: two tones of [color], rounded, standing
/// on a darker edge with a soft glow under it; it sinks onto the edge while
/// pressed. Disabled, it falls back to a flat grey. [fullWidth] stretches it
/// across its parent; otherwise it is as wide as its label.
ButtonStyle vividFilledStyle(
  BuildContext context, {
  required Color color,
  double height = 60,
  TextStyle? textStyle,
  bool fullWidth = true,
}) {
  final light = Color.lerp(color, Colors.white, 0.3)!;
  final deep = Color.lerp(color, Colors.black, 0.06)!;
  final radius = BorderRadius.circular(height >= 56 ? 22 : 18);
  const lift = 4.0;
  return FilledButton.styleFrom(
    minimumSize: fullWidth ? Size.fromHeight(height) : Size(0, height),
    padding: const EdgeInsets.symmetric(horizontal: 22),
    backgroundColor: Colors.transparent,
    disabledBackgroundColor: Colors.transparent,
    foregroundColor: kVividInk,
    shadowColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: radius),
    textStyle: textStyle,
  ).copyWith(
    // The ink of a tap is the sinking itself; a splash on top of the
    // gradient only muddies it.
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    backgroundBuilder: (context, states, child) {
      final disabled = states.contains(WidgetState.disabled);
      final pressed = states.contains(WidgetState.pressed);
      return _pressable(
        states,
        lift,
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: disabled
                ? null
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [light, deep],
                  ),
            color: disabled ? const Color(0xFF3A3F5C) : null,
            boxShadow: disabled
                ? null
                : vividLip(color, lift: pressed ? 1 : lift),
          ),
          child: child,
        ),
      );
    },
  );
}

/// A tinted, rounded style for secondary actions: [accent] at low strength
/// over the card, a brighter edge, and the accent as the label colour.
/// [fullWidth] stretches it across its parent; otherwise it hugs its label.
ButtonStyle vividTonalStyle({
  required Color accent,
  required Color base,
  double height = 52,
  Color? foreground,
  bool fullWidth = true,
}) {
  return TextButton.styleFrom(
    minimumSize: fullWidth ? Size.fromHeight(height) : Size(0, height),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    backgroundColor: Color.alphaBlend(accent.withValues(alpha: 0.14), base),
    disabledBackgroundColor: Color.alphaBlend(
      Colors.white.withValues(alpha: 0.05),
      base,
    ),
    foregroundColor: foreground ?? accent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(height / 2.6),
      side: BorderSide(color: accent.withValues(alpha: 0.4), width: 1.5),
    ),
  );
}

/// The style of a tile in the home grid: [accent] tints it and edges it, and
/// like the big buttons it stands on a coloured lip and sinks when pressed.
ButtonStyle vividTileStyle({required Color accent, required Color base}) {
  final radius = BorderRadius.circular(20);
  const lift = 3.0;
  return OutlinedButton.styleFrom(
    minimumSize: const Size.fromHeight(78),
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
    foregroundColor: Colors.white,
    backgroundColor: Colors.transparent,
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: radius),
  ).copyWith(
    backgroundBuilder: (context, states, child) {
      final pressed = states.contains(WidgetState.pressed);
      return _pressable(
        states,
        lift,
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.alphaBlend(accent.withValues(alpha: 0.22), base),
                Color.alphaBlend(accent.withValues(alpha: 0.10), base),
              ],
            ),
            border: Border.all(
              color: accent.withValues(alpha: 0.55),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.lerp(
                  Color.alphaBlend(accent.withValues(alpha: 0.35), base),
                  Colors.black,
                  0.25,
                )!,
                offset: Offset(0, pressed ? 1 : lift),
              ),
            ],
          ),
          child: child,
        ),
      );
    },
  );
}

/// A rounded counter at the top of the home screen (coins, diamonds,
/// piggy bank): tinted with [accent], edged with it, and all of the same
/// height whatever the icon inside.
class VividPill extends StatelessWidget {
  const VividPill({
    super.key,
    required this.accent,
    required this.base,
    required this.child,
  });

  final Color accent;
  final Color base;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 38),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color.alphaBlend(accent.withValues(alpha: 0.16), base),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
      ),
      // A row, not an alignment: it centres the content in the minimum
      // height without stretching the pill across its parent.
      child: Row(mainAxisSize: MainAxisSize.min, children: [child]),
    );
  }
}

/// The colours of the play button: pink over violet, the logo's own
/// (owner's choice, 16.11.2026, from four variants).
const Color kPlayTop = Color(0xFFFF8CC6);
const Color kPlayBottom = Color(0xFF9B6BFF);

/// The one button that starts a game — "Play" on the home screen, "Play
/// again" after a run: a glossy pill in [kPlayTop] over [kPlayBottom] with a
/// light rim, standing on a violet edge and sinking onto it when pressed; the
/// icon sits in a white disc, the label is white.
///
/// A [FilledButton] underneath, so it behaves (focus, semantics, tests) like
/// every other filled button.
class VividPlayButton extends StatelessWidget {
  const VividPlayButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.play_arrow_rounded,
    this.height = 64,
    this.fontSize = 24,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final double height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(height / 2);
    const lift = 5.0;
    final disc = height * 0.53;
    return FilledButton(
      style:
          FilledButton.styleFrom(
            minimumSize: Size.fromHeight(height),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: radius),
            // styleFrom's textStyle replaces the theme's, so the family has
            // to be repeated (appTextStyle keeps the fallback fonts).
            textStyle:
                appTextStyle(
                  context,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                ).copyWith(
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      offset: const Offset(0, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
          ).copyWith(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            backgroundBuilder: (context, states, child) {
              final pressed = states.contains(WidgetState.pressed);
              return _pressable(
                states,
                lift,
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [kPlayTop, kPlayBottom],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.lerp(kPlayBottom, Colors.black, 0.35)!,
                        offset: Offset(0, pressed ? 1 : lift),
                      ),
                      BoxShadow(
                        color: kPlayBottom.withValues(alpha: 0.45),
                        blurRadius: 24,
                        offset: Offset(0, (pressed ? 1 : lift) + 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    // The label in the middle, as on any button.
                    alignment: Alignment.center,
                    children: [
                      // Gloss on the upper half.
                      PositionedDirectional(
                        start: height * 0.22,
                        end: height * 0.22,
                        top: height * 0.08,
                        height: height * 0.34,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(height),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.45),
                                  Colors.white.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ?child,
                    ],
                  ),
                ),
              );
            },
          ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: disc,
            height: disc,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(icon, size: disc * 0.76, color: kPlayBottom),
          ),
          SizedBox(width: height * 0.18),
          Flexible(
            child: FittedBox(fit: BoxFit.scaleDown, child: Text(label)),
          ),
        ],
      ),
    );
  }
}

/// An icon on a round bubble of [accent].
class VividIconBubble extends StatelessWidget {
  const VividIconBubble({
    super.key,
    required this.icon,
    required this.accent,
    this.size = 34,
  });

  final IconData icon;
  final Color accent;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.lerp(accent, Colors.white, 0.25)!, accent],
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, size: size * 0.58, color: kVividInk),
    );
  }
}

/// Text painted with a gradient of [colors] — for the brand and big titles.
class VividGradientText extends StatelessWidget {
  const VividGradientText(
    this.text, {
    super.key,
    required this.colors,
    required this.style,
    this.textAlign,
  });

  final String text;
  final List<Color> colors;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        maxLines: 1,
        textAlign: textAlign,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

/// The backdrop of the home screen: the theme's background lifted into a
/// gentle gradient, with three wide, soft glows in the theme's tray colours.
/// Static — the drifting particles above it are what moves.
class VividBackdrop extends StatelessWidget {
  const VividBackdrop({super.key, required this.base, required this.glows});

  final Color base;

  /// At least one colour; the first three are used.
  final List<Color> glows;

  @override
  Widget build(BuildContext context) {
    final top = Color.lerp(base, glows.first, 0.22)!;
    final bottom = Color.lerp(base, Colors.black, 0.18)!;
    Color glow(int i) => glows[i % glows.length];
    return LayoutBuilder(
      builder: (context, box) {
        final w = box.maxWidth;
        final h = box.maxHeight;
        Widget blob(Color color, double dx, double dy, double radius) {
          return Positioned(
            left: dx * w - radius,
            top: dy * h - radius,
            width: radius * 2,
            height: radius * 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    color.withValues(alpha: 0.34),
                    color.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [top, base, bottom],
                  stops: const [0, 0.45, 1],
                ),
              ),
            ),
            blob(glow(0), 0.05, 0.12, w * 0.7),
            blob(glow(1), 1.0, 0.42, w * 0.65),
            blob(glow(2), 0.1, 0.92, w * 0.75),
          ],
        );
      },
    );
  }
}
