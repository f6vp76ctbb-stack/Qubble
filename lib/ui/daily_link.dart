/// The Daily link: where a shared Daily result sends whoever reads it.
///
/// The share text (`buildDailyShareText`) points at the web build with
/// `?daily` appended. Whoever follows it came to play that same board, so the
/// web build opens it straight away (`AppBootstrap`) instead of a home screen
/// with the Daily card somewhere below the fold. Without the flag the page is
/// the plain web build, so older shared links keep working unchanged.
library;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Query flag on the shared link.
const String kDailyLinkFlag = 'daily';

/// The page address the app was opened with — on the web only, where
/// `Uri.base` is the browser's current URL. A native app is never opened
/// through that link. A provider so tests can hand one in.
final launchUriProvider = Provider<Uri?>((ref) => kIsWeb ? Uri.base : null);

/// Whether [uri] is the link a shared Daily result carries.
bool isDailyLink(Uri? uri) =>
    uri != null && uri.queryParameters.containsKey(kDailyLinkFlag);
