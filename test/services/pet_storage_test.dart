// Where a player's Qubbies are kept (lib/services/storage.dart): what was
// chosen, bought and hatched survives a progress reset like a bought design;
// how far each one has grown is progress and does not.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/pet.dart';
import 'package:gridpop/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('a fresh install has no Qubbies', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    expect(storage.pets.hasAnything, isFalse);
    expect(storage.pets.starterChosen, isFalse);
  });

  test('round-trips through the two keys', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    var pets = PetState.empty.chooseStarter('bit').addLines(10);
    pets = pets.hatchReady().state.addLines(37).addBoughtEgg('zapp')!;
    pets = pets.addLines(4);
    await storage.setPets(pets);

    final again = await Storage.create();
    expect(again.pets.owned, {'bit'});
    expect(again.pets.activeId, 'bit');
    expect(again.pets.xpOf('bit'), 41);
    expect(again.pets.eggs.single.petId, 'zapp');
    expect(again.pets.eggs.single.linesLeft, PetRules.boughtEggLines - 4);
    expect(again.pets.eggs.single.linesTotal, PetRules.boughtEggLines);
  });

  test('each key is in exactly one of the two lists', () {
    // A key in neither list would survive a reset silently; one in both
    // would let a reset take away something that was paid for.
    const entitlement = 'pets.entitlement';
    const progress = 'pets.progress';
    expect(Storage.entitlementKeys, contains(entitlement));
    expect(Storage.progressKeys, isNot(contains(entitlement)));
    expect(Storage.progressKeys, contains(progress));
    expect(Storage.entitlementKeys, isNot(contains(progress)));
  });

  test('a progress reset keeps the Qubbies and the eggs, not their growth',
      () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    var pets = PetState.empty.chooseStarter('kiki').addLines(10);
    pets = pets.hatchReady().state.addLines(320).addBoughtEgg('pyra')!;
    await storage.setPets(pets);
    expect(storage.pets.stageOf('kiki'), 2);

    await storage.resetProgress();
    expect(storage.pets.owned, {'kiki'});
    expect(storage.pets.activeId, 'kiki');
    expect(storage.pets.starterChosen, isTrue,
        reason: 'the free egg is not handed out twice');
    expect(storage.pets.eggs.single.petId, 'pyra',
        reason: 'an egg paid for with diamonds is not lost');
    expect(storage.pets.xpOf('kiki'), 0);
    expect(storage.pets.stageOf('kiki'), 1);
  });

  test('a damaged save reads as no Qubbies instead of taking the app down',
      () async {
    SharedPreferences.setMockInitialValues({
      'pets.entitlement': '{not json',
      'pets.progress': '[1,2,3]',
    });
    final storage = await Storage.create();
    expect(storage.pets.hasAnything, isFalse);
  });
}
