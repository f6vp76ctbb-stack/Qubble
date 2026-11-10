import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/quest_notice.dart';

/// The small "!" on the Quests button (owner, 12.10.2026): every day brings
/// new quests, and finished quests should be noticed too.
void main() {
  const today = '2026-10-12';

  test('never opened: there is something to see', () {
    expect(
      QuestNotice.show(seenDay: null, seenDone: 0, today: today, doneNow: 0),
      isTrue,
    );
  });

  test('a new day brings new quests', () {
    expect(
      QuestNotice.show(
        seenDay: '2026-10-11',
        seenDone: 5,
        today: today,
        doneNow: 0,
      ),
      isTrue,
    );
  });

  test('opened today and nothing finished since: quiet', () {
    expect(
      QuestNotice.show(seenDay: today, seenDone: 2, today: today, doneNow: 2),
      isFalse,
    );
  });

  test('a quest finished since the last look', () {
    expect(
      QuestNotice.show(seenDay: today, seenDone: 2, today: today, doneNow: 3),
      isTrue,
    );
  });

  test('a reward waiting for a tap calls even when all else is seen', () {
    expect(
      QuestNotice.show(
        seenDay: today,
        seenDone: 2,
        today: today,
        doneNow: 2,
        claimable: 1,
      ),
      isTrue,
    );
  });
}
