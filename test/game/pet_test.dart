// The pets ("Qubbies", MASTERPLAN.md Phase 8, docs/HAUSTIERE.md): who they
// are, what they cost, how an egg hatches and how a Qubbie grows. Nothing in
// here touches the score, the pieces or the board.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/accessory.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/burst_style.dart';
import 'package:gridpop/game/clear_effect.dart';
import 'package:gridpop/game/pet.dart';

void main() {
  group('the catalog', () {
    test('nine Qubbies: three starters, five premium, one legendary', () {
      expect(kPetCatalog, hasLength(9));
      expect(kPetCatalog.map((p) => p.id).toSet(), hasLength(9));
      expect(kPetCatalog.where((p) => p.tier == PetTier.starter), hasLength(3));
      expect(kPetCatalog.where((p) => p.tier == PetTier.premium), hasLength(5));
      expect(
        kPetCatalog.where((p) => p.tier == PetTier.legendary),
        hasLength(1),
      );
      expect(kStarterPetIds, ['kiki', 'bit', 'glim']);
    });

    test('prices are the ones from the concept', () {
      int cost(String id) => petById(id)!.cost;
      for (final id in kStarterPetIds) {
        expect(cost(id), 300);
      }
      expect(cost('frosti'), 600);
      expect(cost('optik'), 600);
      expect(cost('zapp'), 600);
      expect(cost('funki'), 900);
      expect(cost('prisma'), 900);
      expect(cost('pyra'), 1500);
    });

    test('every Qubbie costs more than the dearest design (owner, 13.10.)', () {
      final dearestDesign = [
        kAnimatedSkinPrice,
        for (final a in kAccessoryCatalog) a.cost,
        for (final b in kBurstCatalog) b.cost,
        for (final e in kClearEffectCatalog) e.cost,
      ].reduce((a, b) => a > b ? a : b);
      for (final pet in kPetCatalog) {
        expect(pet.cost, greaterThan(dearestDesign), reason: pet.id);
      }
    });

    test('starters fly with the player\'s own row effect, the others bring '
        'theirs', () {
      for (final pet in kPetCatalog) {
        expect(
          pet.signature == null,
          pet.tier == PetTier.starter,
          reason: pet.id,
        );
      }
      expect(petById('frosti')!.signature, PetSignature.frost);
      expect(petById('optik')!.signature, PetSignature.laser);
      expect(petById('zapp')!.signature, PetSignature.lightning);
      expect(petById('funki')!.signature, PetSignature.fire);
      expect(petById('prisma')!.signature, PetSignature.rainbow);
      expect(petById('pyra')!.signature, PetSignature.phoenix);
    });

    test('an unknown id is no pet', () {
      expect(petById('goldi'), isNull);
      expect(petById(''), isNull);
    });
  });

  group('the first egg', () {
    test('is offered after the third finished run, to a player without one',
        () {
      const none = PetState.empty;
      expect(PetRules.offersFirstEgg(none, finishedRuns: 2), isFalse);
      expect(PetRules.offersFirstEgg(none, finishedRuns: 3), isTrue);
      expect(PetRules.offersFirstEgg(none, finishedRuns: 400), isTrue);
    });

    test('is chosen from the three starters, once', () {
      final chosen = PetState.empty.chooseStarter('bit');
      expect(chosen.starterChosen, isTrue);
      expect(chosen.eggs.single.petId, 'bit');
      expect(chosen.eggs.single.linesLeft, PetRules.starterEggLines);
      expect(PetRules.starterEggLines, 10);
      expect(PetRules.offersFirstEgg(chosen, finishedRuns: 9), isFalse);

      // A second choice changes nothing.
      expect(chosen.chooseStarter('kiki'), same(chosen));
    });

    test('cannot be a premium Qubbie', () {
      expect(PetState.empty.chooseStarter('funki'), same(PetState.empty));
      expect(PetState.empty.chooseStarter('nope'), same(PetState.empty));
    });
  });

  group('hatching', () {
    test('cleared lines count an egg down; it hatches when the run is over',
        () {
      var state = PetState.empty.chooseStarter('kiki');
      state = state.addLines(4);
      expect(state.eggs.single.linesLeft, 6);
      expect(state.owned, isEmpty);

      // Ready, but not out: the moment belongs to the game over.
      state = state.addLines(9);
      expect(state.eggs.single.linesLeft, 0);
      expect(state.eggs.single.ready, isTrue);
      expect(state.owned, isEmpty);

      final result = state.hatchReady();
      expect(result.hatched, ['kiki']);
      expect(result.state.owned, {'kiki'});
      expect(result.state.eggs, isEmpty);
      expect(result.state.activeId, 'kiki',
          reason: 'the first Qubbie comes along at once');
    });

    test('nothing ready, nothing happens', () {
      final state = PetState.empty.chooseStarter('kiki').addLines(3);
      final result = state.hatchReady();
      expect(result.hatched, isEmpty);
      expect(result.state, same(state));
    });

    test('a later hatch does not push the active Qubbie aside', () {
      var state = PetState.empty.chooseStarter('kiki').addLines(10);
      state = state.hatchReady().state;
      state = state.addBoughtEgg('funki')!;
      state = state.addLines(PetRules.boughtEggLines);
      final result = state.hatchReady();
      expect(result.hatched, ['funki']);
      expect(result.state.owned, {'kiki', 'funki'});
      expect(result.state.activeId, 'kiki');
    });
  });

  group('buying', () {
    test('a bought Qubbie comes as an egg that hatches after 15 lines', () {
      final state = PetState.empty.addBoughtEgg('frosti')!;
      expect(state.eggs.single.petId, 'frosti');
      expect(state.eggs.single.linesLeft, 15);
    });

    test('not twice: neither an owned one nor one still in its egg', () {
      final egg = PetState.empty.addBoughtEgg('frosti')!;
      expect(egg.addBoughtEgg('frosti'), isNull);
      expect(egg.canBuy('frosti'), isFalse);
      final owned = egg.addLines(15).hatchReady().state;
      expect(owned.addBoughtEgg('frosti'), isNull);
      expect(owned.canBuy('frosti'), isFalse);
      expect(owned.canBuy('optik'), isTrue);
      expect(owned.canBuy('nope'), isFalse);
    });

    test('several eggs count down together', () {
      var state = PetState.empty.addBoughtEgg('frosti')!.addBoughtEgg('zapp')!;
      state = state.addLines(15);
      expect(state.hatchReady().hatched, ['frosti', 'zapp']);
    });
  });

  group('how far along an egg is', () {
    test('runs from 0 to 1 over the lines it started with', () {
      var state = PetState.empty.chooseStarter('kiki');
      expect(state.eggs.single.linesTotal, PetRules.starterEggLines);
      expect(state.eggs.single.progress, 0);
      state = state.addLines(4);
      expect(state.eggs.single.linesDone, 4);
      expect(state.eggs.single.progress, closeTo(0.4, 1e-9));
      state = state.addLines(40);
      expect(state.eggs.single.progress, 1);
      expect(state.eggs.single.linesDone, PetRules.starterEggLines);
    });

    test('a bought egg has its own total', () {
      final egg = PetState.empty.addBoughtEgg('frosti')!.addLines(3);
      expect(egg.eggs.single.linesTotal, PetRules.boughtEggLines);
      expect(egg.eggs.single.progress, closeTo(3 / 15, 1e-9));
    });

    test('the total survives storage; a save without one gets one that fits',
        () {
      final state = PetState.empty.chooseStarter('glim').addLines(2);
      final back = PetState.fromJson(
        entitlement: state.entitlementJson(),
        progress: state.progressJson(),
      );
      expect(back.eggs.single.linesTotal, PetRules.starterEggLines);
      expect(back.eggs.single.linesLeft, 8);

      final old = PetState.fromJson(
        entitlement: {
          'eggs': [
            {'id': 'zapp', 'left': 4},
            {'id': 'pyra', 'left': 40},
            {'id': 'optik', 'left': 9, 'of': 2},
          ],
        },
        progress: null,
      );
      expect(old.eggs[0].linesTotal, PetRules.boughtEggLines);
      expect(old.eggs[1].linesTotal, 40);
      expect(old.eggs[2].linesTotal, PetRules.boughtEggLines,
          reason: 'a total below what is left is not believed');
      for (final egg in old.eggs) {
        expect(egg.progress, inInclusiveRange(0, 1));
      }
    });
  });

  group('growing', () {
    test('the active Qubbie gains one experience per cleared line', () {
      var state = PetState.empty.chooseStarter('glim').addLines(10);
      state = state.hatchReady().state;
      expect(state.xpOf('glim'), 0);
      state = state.addLines(7);
      expect(state.xpOf('glim'), 7);
    });

    test('only the active one', () {
      var state = PetState.empty.chooseStarter('glim').addLines(10);
      state = state.hatchReady().state;
      state = state.addBoughtEgg('zapp')!.addLines(15).hatchReady().state;
      final before = state.xpOf('zapp');
      state = state.addLines(5);
      expect(state.xpOf('zapp'), before);
      state = state.withActive('zapp').addLines(5);
      expect(state.xpOf('zapp'), before + 5);
    });

    test('three stages: 300 and 1500 experience', () {
      expect(PetRules.stageFor(0), 1);
      expect(PetRules.stageFor(299), 1);
      expect(PetRules.stageFor(300), 2);
      expect(PetRules.stageFor(1499), 2);
      expect(PetRules.stageFor(1500), 3);
      expect(PetRules.stageFor(999999), 3);
    });

    test('progress within a stage runs from 0 to 1', () {
      expect(PetRules.stageProgress(0), 0);
      expect(PetRules.stageProgress(150), closeTo(0.5, 1e-9));
      expect(PetRules.stageProgress(300), 0);
      expect(PetRules.stageProgress(900), closeTo(0.5, 1e-9));
      expect(PetRules.stageProgress(1500), 1, reason: 'fully grown');
    });
  });

  group('choosing who comes along', () {
    test('only a hatched Qubbie can be made active', () {
      final state = PetState.empty.addBoughtEgg('zapp')!;
      expect(state.withActive('zapp'), same(state));
      expect(state.withActive('nope'), same(state));
    });
  });

  group('storage', () {
    test('round-trips through its two parts', () {
      var state = PetState.empty.chooseStarter('kiki').addLines(10);
      state = state.hatchReady().state.addLines(42);
      state = state.addBoughtEgg('pyra')!.addLines(3);

      final back = PetState.fromJson(
        entitlement: state.entitlementJson(),
        progress: state.progressJson(),
      );
      expect(back.owned, state.owned);
      expect(back.activeId, state.activeId);
      expect(back.starterChosen, isTrue);
      expect(back.xpOf('kiki'), state.xpOf('kiki'));
      expect(back.eggs.single.petId, 'pyra');
      expect(back.eggs.single.linesLeft, state.eggs.single.linesLeft);
    });

    test('experience is progress; what was bought is not', () {
      // A progress reset drops the progress part only.
      var state = PetState.empty.chooseStarter('kiki').addLines(10);
      state = state.hatchReady().state.addLines(42).addBoughtEgg('pyra')!;
      final back = PetState.fromJson(
        entitlement: state.entitlementJson(),
        progress: null,
      );
      expect(back.owned, {'kiki'});
      expect(back.eggs.single.petId, 'pyra');
      expect(back.xpOf('kiki'), 0);
    });

    test('junk reads as empty instead of throwing', () {
      expect(PetState.fromJson(entitlement: null, progress: null).owned,
          isEmpty);
      final junk = PetState.fromJson(
        entitlement: {'owned': 7, 'eggs': 'x', 'active': 3},
        progress: {'xp': 'no'},
      );
      expect(junk.owned, isEmpty);
      expect(junk.eggs, isEmpty);
      expect(junk.activeId, isNull);
    });

    test('ids the catalog no longer knows are dropped', () {
      final state = PetState.fromJson(
        entitlement: {
          'owned': ['kiki', 'ghost'],
          'active': 'ghost',
          'starter': true,
          'eggs': [
            {'id': 'ghost', 'left': 3},
            {'id': 'zapp', 'left': 4},
          ],
        },
        progress: {
          'xp': {'kiki': 12, 'ghost': 99},
        },
      );
      expect(state.owned, {'kiki'});
      expect(state.activeId, 'kiki', reason: 'falls back to an owned one');
      expect(state.eggs.single.petId, 'zapp');
      expect(state.xpOf('ghost'), 0);
    });
  });
}
