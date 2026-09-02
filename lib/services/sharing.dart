/// The system share sheet, behind a provider so tests never touch the
/// platform channel.
///
/// `share_plus` talks to `ACTION_SEND` on Android and
/// `UIActivityViewController` on iOS. Neither exists in a widget test, and on
/// the web build the sheet may not exist at all — so the call is wrapped and
/// every failure is swallowed: a share sheet that will not open must not take
/// the game-over screen down with it.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

typedef Sharer = Future<bool> Function(String text);

Future<bool> shareText(String text) async {
  try {
    final result = await SharePlus.instance.share(ShareParams(text: text));
    return result.status == ShareResultStatus.success;
  } catch (e) {
    debugPrint('share failed: $e');
    return false;
  }
}

/// Overridden in tests with a recorder.
final sharerProvider = Provider<Sharer>((ref) => shareText);
