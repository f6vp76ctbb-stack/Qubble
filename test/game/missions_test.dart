// Missions used to be five fixed goals. BALANCE.md measured the result: all
// five are permanently done after roughly ten runs, leaving a screen of ticks
// that never changes -- a retention system that switches itself off for
// exactly the players who kept playing.
//
// They are tiered now. Progress is kept per metric so it carries across
// tiers, which is also what makes the migration below possible.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/game_session.dart';
import 'package:gridpop/game/missions.dart';

GameStats _stats({
  int placed = 0,
  int lines = 0,
  int combo = 0,
  int score = 0,
}) =>
    GameStats(
      score: score,
      piecesPlaced: placed,
      linesCleared: lines,
      maxCombo: combo,
    );

void main() {
  group('tiers', () {
    test('a fresh player gets the first tier of every metric', () {
      final e = MissionEngine();
      expect(e.views.length, MissionMetric.values.length);
      for (final v in e.views) {
        expect(v.mission.target, kMissionTiers[v.mission.metric]!.first);
      }
    });

    test('finishing a tier offers the next, not a tick', () {
      final e = MissionEngine();
      e.recordGame(_stats(placed: 100));

      final placing = e.views
          .firstWhere((v) => v.mission.metric == MissionMetric.piecesPlaced);
      expect(placing.mission.target, 300);
      expect(placing.completed, isFalse);
    });

    test('progress carries into the next tier instead of restarting', () {
      final e = MissionEngine();
      e.recordGame(_stats(placed: 150));

      final placing = e.views
          .firstWhere((v) => v.mission.metric == MissionMetric.piecesPlaced);
      // 150 of 300, not 0 of 300 -- the old per-id scheme would have lost it.
      expect(placing.progress, 150);
    });

    test('an exhausted metric disappears rather than sitting ticked', () {
      final e = MissionEngine();
      e.recordGame(_stats(placed: kMissionTiers[MissionMetric.piecesPlaced]!.last));

      expect(
        e.views.any((v) => v.mission.metric == MissionMetric.piecesPlaced),
        isFalse,
      );
    });

    test('rewards grow with the tier', () {
      expect(missionReward(1), greaterThan(missionReward(0)));
      expect(missionReward(5), greaterThan(missionReward(1)));
    });
  });

  group('completion pays out', () {
    test('one crossed tier pays once', () {
      final e = MissionEngine();
      final done = e.recordGame(_stats(placed: 100));

      final placed =
          done.where((m) => m.metric == MissionMetric.piecesPlaced).toList();
      expect(placed.length, 1);
      expect(placed.single.target, 100);
    });

    test('a run crossing two tiers pays for both', () {
      // The old engine checked only the goal that was on offer beforehand, so
      // a big first run would have swallowed the second reward silently.
      final e = MissionEngine();
      final done = e.recordGame(_stats(lines: 400));

      final lines =
          done.where((m) => m.metric == MissionMetric.linesCleared).toList();
      expect(lines.map((m) => m.target), [50, 150, 400]);
    });

    test('an already-finished tier never pays again', () {
      final e = MissionEngine();
      e.recordGame(_stats(placed: 100));
      final again = e.recordGame(_stats(placed: 1));

      expect(
        again.where((m) => m.metric == MissionMetric.piecesPlaced),
        isEmpty,
      );
    });

    test('high-water metrics do not accumulate', () {
      // A 6x combo twice is still a 6x combo, not a 12x one.
      final e = MissionEngine();
      e.recordGame(_stats(combo: 6));
      e.recordGame(_stats(combo: 6));

      expect(e.progressOf(MissionMetric.maxComboReached), 6);
    });
  });

  group('migration from the old per-id keys', () {
    test('an existing player keeps every earned unit of progress', () {
      // The case that matters: without this they would read as zero and be
      // handed tier one of everything back, rewards included.
      final e = MissionEngine(progress: {
        'place_100': 143,
        'clear_50': 62,
        'combo_5': 7,
        'score_1000': 4200,
        'games_10': 18,
      });

      expect(e.progressOf(MissionMetric.piecesPlaced), 143);
      expect(e.progressOf(MissionMetric.linesCleared), 62);
      expect(e.progressOf(MissionMetric.maxComboReached), 7);
      expect(e.progressOf(MissionMetric.scoreReached), 4200);
      expect(e.progressOf(MissionMetric.gamesPlayed), 18);
    });

    test('a migrated player is on the right tier, not back at the start', () {
      final e = MissionEngine(progress: {'place_100': 143});
      final placing = e.views
          .firstWhere((v) => v.mission.metric == MissionMetric.piecesPlaced);

      expect(placing.mission.target, 300);
      expect(placing.progress, 143);
    });

    test('a migrated player is not paid again for what they already did', () {
      final e = MissionEngine(progress: {'place_100': 143});
      final done = e.recordGame(_stats(placed: 1));

      expect(done.where((m) => m.metric == MissionMetric.piecesPlaced), isEmpty);
    });

    test('new keys pass through untouched', () {
      final e = MissionEngine(progress: {'piecesPlaced': 500});
      expect(e.progressOf(MissionMetric.piecesPlaced), 500);
    });

    test('both key forms present takes the larger, never the smaller', () {
      // A half-finished migration must not move anyone backwards.
      final e = MissionEngine(
        progress: {'place_100': 900, 'piecesPlaced': 400},
      );
      expect(e.progressOf(MissionMetric.piecesPlaced), 900);
    });
  });

  test('reset clears everything', () {
    final e = MissionEngine(progress: {'piecesPlaced': 500})..reset();
    expect(e.progressOf(MissionMetric.piecesPlaced), 0);
    expect(e.views.first.mission.target, kMissionTiers[MissionMetric.piecesPlaced]!.first);
  });
}
