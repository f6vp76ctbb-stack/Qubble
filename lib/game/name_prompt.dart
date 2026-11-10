/// Pure-Dart policy for when to ask a player for a leaderboard name.
/// No Flutter imports — fully unit-testable.
///
/// Owner's decision (28.09.2026): the leaderboard stayed empty because the
/// only way in was a small name chip on the home screen. So the game asks —
/// at the end of a round, when there is a score worth showing — and asks
/// once more on the next personal best if the player said "later". After
/// that it stays quiet; the chip on the home screen remains.
///
/// Since 10.11.2026 not at the end of the very first round: see
/// [NamePrompt.firstAskRun].
///
/// The question is always skippable: the store listing and the data-safety
/// declaration both promise that the leaderboard is optional and that
/// without a name the game is played anonymously.
library;

/// How far the question has got. Stored as its index.
enum NamePromptStage {
  /// Never asked.
  notAsked,

  /// Asked once and skipped; one more chance on the next personal best.
  skippedOnce,

  /// Asked twice (or otherwise finished). Never asked again.
  done;

  /// Reads a stored index; unknown values are clamped, so a corrupted or
  /// future value can never make the game ask forever.
  static NamePromptStage fromIndex(int? index) {
    if (index == null || index < 0) return notAsked;
    if (index >= values.length) return done;
    return values[index];
  }
}

class NamePrompt {
  const NamePrompt._();

  /// The first finished run after which the question may come.
  ///
  /// Not the very first (changed 10.11.2026; it was, since 28.09.): a player
  /// a minute and a half into the game, looking at their first score, is
  /// asked to pick a public name before they know whether they will play a
  /// second round. From the second run the question waits for a moment that
  /// gives it a reason — a new personal best — and comes at the latest
  /// after run [latestAskRun].
  static const int firstAskRun = 2;

  /// The run after which the question comes even without a personal best.
  static const int latestAskRun = 4;

  /// Whether the game-over screen that just opened should ask for a name.
  ///
  /// [newPersonalBest] is whether the round that just ended set a new best,
  /// [finishedRuns] how many runs the player has finished, this one included.
  static bool shouldAsk({
    required bool hasName,
    required NamePromptStage stage,
    required bool newPersonalBest,
    required int finishedRuns,
  }) {
    if (hasName) return false;
    return switch (stage) {
      NamePromptStage.notAsked =>
        finishedRuns >= firstAskRun &&
            (newPersonalBest || finishedRuns >= latestAskRun),
      NamePromptStage.skippedOnce => newPersonalBest,
      NamePromptStage.done => false,
    };
  }

  /// The stage after the question was shown. Choosing a name ends the
  /// question by itself (a named player is never asked), so this only has to
  /// count the times it was put.
  static NamePromptStage afterAsking(NamePromptStage stage) => switch (stage) {
    NamePromptStage.notAsked => NamePromptStage.skippedOnce,
    NamePromptStage.skippedOnce || NamePromptStage.done => NamePromptStage.done,
  };
}
