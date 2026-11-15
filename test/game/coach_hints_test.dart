import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/coach_hints.dart';

void main() {
  group('CoachHints.next', () {
    test('prioritizes time-sensitive combo and fever signals', () {
      const allSignals = CoachHintSignals(
        comboActive: true,
        feverActive: true,
        rotationUsed: true,
        boosterAffordable: true,
      );

      expect(
        CoachHints.next(signals: allSignals, seen: const {}),
        CoachHintType.combo,
      );
      expect(
        CoachHints.next(signals: allSignals, seen: const {CoachHintType.combo}),
        CoachHintType.fever,
      );
    });

    test(
      'falls through to rotation and booster when earlier hints were seen',
      () {
        const signals = CoachHintSignals(
          comboActive: true,
          feverActive: true,
          rotationUsed: true,
          boosterAffordable: true,
        );

        expect(
          CoachHints.next(
            signals: signals,
            seen: const {CoachHintType.combo, CoachHintType.fever},
          ),
          CoachHintType.rotation,
        );
        expect(
          CoachHints.next(
            signals: signals,
            seen: const {
              CoachHintType.combo,
              CoachHintType.fever,
              CoachHintType.rotation,
            },
          ),
          CoachHintType.booster,
        );
      },
    );

    test('holds the strategy hint behind every earlier one', () {
      // It is the second learning stage, not a competing instruction: it must
      // never appear before the basics the tutorial actually teaches.
      const signals = CoachHintSignals(
        comboActive: true,
        feverActive: true,
        rotationUsed: true,
        boosterAffordable: true,
        strategyReady: true,
      );
      expect(
        CoachHints.next(
          signals: signals,
          seen: const {
            CoachHintType.combo,
            CoachHintType.fever,
            CoachHintType.rotation,
          },
        ),
        CoachHintType.booster,
      );
      expect(
        CoachHints.next(
          signals: signals,
          seen: const {
            CoachHintType.combo,
            CoachHintType.fever,
            CoachHintType.rotation,
            CoachHintType.booster,
          },
        ),
        CoachHintType.strategy,
      );
    });

    test('offers the strategy hint on its own once the run count is met', () {
      expect(
        CoachHints.next(
          signals: const CoachHintSignals(strategyReady: true),
          seen: const {},
        ),
        CoachHintType.strategy,
      );
      // Below the threshold the controller passes strategyReady: false, and
      // nothing is due.
      expect(
        CoachHints.next(
          signals: const CoachHintSignals(),
          seen: const {},
        ),
        isNull,
      );
    });

    test('returns null when no active signal is unseen', () {
      expect(
        CoachHints.next(signals: const CoachHintSignals(), seen: const {}),
        isNull,
      );
      expect(
        CoachHints.next(
          signals: const CoachHintSignals(boosterAffordable: true),
          seen: const {CoachHintType.booster},
        ),
        isNull,
      );
    });
  });

  group('how to turn a piece', () {
    // There is no rotate button since 15.11.2026: a tap on a piece turns it,
    // and so does a second finger while it is held. Nothing on screen shows
    // that, so the tip comes on its own as soon as the tutorial is done —
    // and to every existing player once, because the button they knew is
    // gone.
    test('comes on its own, before the hint about charges', () {
      expect(
        CoachHints.next(
          signals: const CoachHintSignals(turnTipReady: true),
          seen: const {},
        ),
        CoachHintType.turnHow,
      );
      expect(
        CoachHints.next(
          signals: const CoachHintSignals(
            turnTipReady: true,
            rotationUsed: true,
            boosterAffordable: true,
          ),
          seen: const {},
        ),
        CoachHintType.turnHow,
      );
    });

    test('waits behind combo and fever, which are about this very move', () {
      expect(
        CoachHints.next(
          signals: const CoachHintSignals(
            comboActive: true,
            turnTipReady: true,
          ),
          seen: const {},
        ),
        CoachHintType.combo,
      );
    });

    test('is shown once', () {
      expect(
        CoachHints.next(
          signals: const CoachHintSignals(turnTipReady: true),
          seen: const {CoachHintType.turnHow},
        ),
        isNull,
      );
    });
  });

  test('every hint type is distinct', () {
    // The copy itself is localized in the UI layer (coachHintText); this file
    // only guards the decision logic, so it checks the enum stays a set of
    // distinct, stable cases.
    expect(CoachHintType.values.toSet().length, CoachHintType.values.length);
  });
}
