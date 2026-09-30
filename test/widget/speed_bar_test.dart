// The speed bonus as a bar (owner, 29.09.2026): full while the whole bonus
// is on offer, draining with it, shaking and sparking while full.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/scoring.dart';
import 'package:gridpop/ui/widgets/speed_bar.dart';

void main() {
  test('the fill follows the bonus: whole, then falling to nothing', () {
    expect(SpeedBar.fillAfter(Duration.zero), 1);
    expect(SpeedBar.fillAfter(ScoreKeeper.defaultSpeedFullBelow), 1);
    expect(
      SpeedBar.fillAfter(const Duration(milliseconds: 2750)),
      closeTo(0.5, 1e-9),
    );
    expect(SpeedBar.fillAfter(ScoreKeeper.defaultSpeedZeroAbove), 0);
    expect(SpeedBar.fillAfter(const Duration(minutes: 1)), 0);

    // In step with the scoring: the bar shows the share of the maximum.
    final keeper = ScoreKeeper();
    final placed = DateTime(2026, 9, 29, 12);
    keeper.applyPlacement(
      placedCells: 1,
      clearedLines: 0,
      clearedCells: 0,
      isAllClear: false,
      now: placed,
    );
    for (final ms in [0, 1000, 2000, 3000, 3900, 5000]) {
      final at = placed.add(Duration(milliseconds: ms));
      expect(
        SpeedBar.fillAfter(Duration(milliseconds: ms)),
        closeTo(keeper.speedBonusAt(at) / ScoreKeeper.defaultSpeedBonusMax,
            1e-9),
        reason: '$ms ms',
      );
    }
  });

  Future<List<double>> shakes(WidgetTester tester, {required bool reduced}) async {
    var now = DateTime(2026, 9, 29, 12);
    final placed = now;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SpeedBar(
              lastPlacementAt: placed,
              color: Colors.cyan,
              reducedEffects: reduced,
              now: () => now,
            ),
          ),
        ),
      ),
    );
    final offsets = <double>[];
    for (var i = 0; i < 6; i++) {
      now = now.add(const Duration(milliseconds: 17));
      await tester.pump(const Duration(milliseconds: 17));
      final t = tester.widget<Transform>(
        find.descendant(
          of: find.byType(SpeedBar),
          matching: find.byType(Transform),
        ).first,
      );
      offsets.add(t.transform.getTranslation().x);
    }
    return offsets;
  }

  testWidgets('a full bar shakes', (tester) async {
    final offsets = await shakes(tester, reduced: false);
    expect(offsets.toSet().length, greaterThan(2));
  });

  testWidgets('with reduced effects it holds still', (tester) async {
    final offsets = await shakes(tester, reduced: true);
    expect(offsets.toSet(), {0.0});
  });

  testWidgets('an old placement leaves nothing running', (tester) async {
    final now = DateTime(2026, 9, 29, 12);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpeedBar(
            lastPlacementAt: now.subtract(const Duration(seconds: 10)),
            color: Colors.cyan,
            now: () => now,
          ),
        ),
      ),
    );
    expect(tester.hasRunningAnimations, isFalse);
  });
}
