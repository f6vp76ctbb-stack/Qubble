/// Pure-Dart policy for when to surface the native store-rating prompt.
/// No Flutter imports — fully unit-testable.
///
/// Play's In-App Review API (and StoreKit's equivalent) shows its own
/// dismissible card and enforces a server-side quota. Google explicitly
/// forbids gating it behind a custom "do you like the game?" dialog, so the
/// app never asks a question first — it only decides *when* asking is
/// appropriate. That decision lives here:
///
/// * only after a genuinely positive moment ([ReviewTrigger]), never after a
///   loss and never mid-run,
/// * only once the player has actually played enough to have an opinion,
/// * never on the first session, so a fresh install is never nagged,
/// * with a long cooldown and a lifetime cap, so declining is respected.
library;

/// The positive moments that may lead into a rating request.
enum ReviewTrigger {
  /// A new Endless best score.
  newHighscore,

  /// A puzzle level finished with all three stars.
  puzzlePerfect,

  /// A daily streak milestone was reached.
  streakMilestone,
}

/// Everything the policy needs to know, gathered by the caller from storage.
class ReviewPromptState {
  const ReviewPromptState({
    required this.gamesPlayed,
    required this.appOpens,
    required this.promptCount,
    this.lastPromptAt,
    this.rated = false,
  });

  /// Lifetime finished runs (`LifetimeStats.games`).
  final int gamesPlayed;

  /// Lifetime app launches (`Storage.appOpenCount`).
  final int appOpens;

  /// How often the native prompt was already requested.
  final int promptCount;

  /// When the native prompt was last requested, or null if never.
  final DateTime? lastPromptAt;

  /// True once the player used the explicit "App bewerten" entry in the
  /// settings — they have been to the store listing, so stop asking.
  final bool rated;
}

class ReviewPrompt {
  const ReviewPrompt._();

  /// Finished runs before the game may ask. Roughly "played a few rounds and
  /// knows what the game is".
  static const int minGamesPlayed = 8;

  /// Never on the first session — a rating card during the first launch is
  /// pure noise and burns the yearly quota.
  static const int minAppOpens = 3;

  /// Requests over the lifetime of the install. Play's own quota is stricter
  /// still; this keeps the app from spending it pointlessly.
  static const int maxPrompts = 3;

  /// Gap between two requests.
  static const Duration cooldown = Duration(days: 60);

  /// Whether [trigger] may open the native rating card right now.
  static bool shouldAsk(
    ReviewPromptState state, {
    required ReviewTrigger trigger,
    required DateTime now,
  }) {
    if (state.rated) return false;
    if (state.promptCount >= maxPrompts) return false;
    if (state.gamesPlayed < minGamesPlayed) return false;
    if (state.appOpens < minAppOpens) return false;

    final last = state.lastPromptAt;
    if (last != null && now.difference(last) < cooldown) return false;

    // `trigger` is not filtered further today: every member is a positive
    // moment by construction. It stays in the signature so a future
    // trigger-specific rule (or analytics) has the context, and so callers are
    // forced to name the moment they are asking from.
    return true;
  }
}
