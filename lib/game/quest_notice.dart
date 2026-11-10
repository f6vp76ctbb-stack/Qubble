/// When the Quests button on the home screen calls for attention (owner,
/// 12.10.2026: "ein kleines, minimal bewegendes Ausrufezeichen … weil es
/// jeden Tag neue Quests gibt, aber auch wenn Quests abgeschlossen worden
/// sind"). Pure Dart, no Flutter imports.
library;

class QuestNotice {
  const QuestNotice._();

  /// Whether to show the notice.
  ///
  /// [seenDay] is the day (yyyy-mm-dd) the player last opened the quests and
  /// [seenDone] how many quests were done then, over all periods; [today]
  /// and [doneNow] are the same now. [claimable] counts rewards waiting for
  /// a tap (achievement tiers), which call until they are collected.
  ///
  /// A new week or month always starts on a new day, so a period's done
  /// count dropping back to zero is covered by the day check.
  static bool show({
    required String? seenDay,
    required int seenDone,
    required String today,
    required int doneNow,
    int claimable = 0,
  }) {
    if (claimable > 0) return true;
    if (seenDay != today) return true;
    return doneNow > seenDone;
  }
}
