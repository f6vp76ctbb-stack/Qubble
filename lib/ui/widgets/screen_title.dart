import 'package:flutter/material.dart';

/// An app-bar title that shrinks to fit instead of being cut off.
///
/// A plain [Text] title ends in "…" once it outgrows the bar, and at a larger
/// system font size several did on a 360 dp phone: "Comment jouer à Q…",
/// "Skinuri pentru bl…". A title that reads to the end at a slightly smaller
/// size is the better trade — the bar has one line and nothing else to give.
class ScreenTitle extends StatelessWidget {
  const ScreenTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}
