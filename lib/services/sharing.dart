/// The system share sheet, behind a provider so tests never touch the
/// platform channel.
///
/// `share_plus` talks to `ACTION_SEND` on Android and
/// `UIActivityViewController` on iOS. Neither exists in a widget test, and on
/// the web the Share API is missing in whole browser families — so every
/// failure is turned into a clipboard copy rather than an exception: a share
/// sheet that will not open must not take the game-over screen down with it,
/// and must not leave a button that visibly does nothing.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

/// What actually happened, so the UI can confirm a copy without claiming a
/// share that never took place.
enum ShareOutcome {
  /// The player picked a target in the system sheet.
  shared,

  /// No share sheet was available; the text is on the clipboard instead.
  copied,

  /// The player opened the sheet and backed out. Says nothing.
  dismissed,

  /// Neither route worked.
  failed,
}

typedef Sharer = Future<ShareOutcome> Function(String text);

Future<ShareOutcome> shareText(String text) async {
  try {
    final result = await SharePlus.instance.share(
      // Without this, a browser with no Share API opens the player's MAIL
      // client with the result pre-filled. For a game score that is a
      // startling gesture and a dead end; the clipboard is what a browser
      // share actually means.
      ShareParams(text: text, mailToFallbackEnabled: false),
    );
    switch (result.status) {
      case ShareResultStatus.success:
        return ShareOutcome.shared;
      case ShareResultStatus.dismissed:
        // A deliberate cancel. Copying anyway would override the player's
        // decision and clobber whatever they had on the clipboard.
        return ShareOutcome.dismissed;
      case ShareResultStatus.unavailable:
        break;
    }
  } catch (e) {
    debugPrint('share failed, falling back to the clipboard: $e');
  }

  try {
    await Clipboard.setData(ClipboardData(text: text));
    return ShareOutcome.copied;
  } catch (e) {
    debugPrint('clipboard failed: $e');
    return ShareOutcome.failed;
  }
}

/// Overridden in tests with a recorder.
final sharerProvider = Provider<Sharer>((ref) => shareText);
