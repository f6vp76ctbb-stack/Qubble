// A tester receives every new build over the existing install, so a save
// written by an older (or newer, or half-broken) version must never be able to
// take the app down. missionProgress and lifetimeStats are read from
// GameController's initializer list — a throw there kills the provider and
// leaves nothing on screen.
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/stats.dart';
import 'package:gridpop/services/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> storageWith(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  return Storage.create();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('corrupt JSON never throws', () {
    const garbage = <String, String>{
      'not json at all': 'kaputt{{{',
      'a JSON array': '[1,2,3]',
      'a bare number': '42',
      'a JSON string': '"nope"',
      'null': 'null',
      'empty string': '',
    };

    garbage.forEach((label, raw) {
      test('missionProgress survives $label', () async {
        final s = await storageWith({'missionProgress': raw});
        expect(s.missionProgress, isEmpty);
      });

      test('puzzleStars survives $label', () async {
        final s = await storageWith({'puzzleStars': raw});
        expect(s.puzzleStars, isEmpty);
      });

      test('lifetimeStats survives $label', () async {
        final s = await storageWith({'lifetimeStats': raw});
        expect(s.lifetimeStats.games, 0);
      });
    });

    test('missionProgress drops entries of the wrong value type', () async {
      final s = await storageWith({
        'missionProgress': '{"place_100": 12, "clear_50": "viele", '
            '"combo_5": null, "score_1000": 3.7}',
      });
      expect(s.missionProgress, {'place_100': 12, 'score_1000': 3});
    });

    test('puzzleStars drops non-numeric level keys', () async {
      // int.parse used to throw here and take the level screen down with it.
      final s = await storageWith({
        'puzzleStars': '{"0": 3, "eins": 3, "2": 3, "": 1}',
      });
      expect(s.puzzleStars, {0: 3, 2: 3});
    });

    test('lifetimeStats ignores unexpected fields and keeps known ones',
        () async {
      final s = await storageWith({
        'lifetimeStats': '{"games": 7, "totalScore": 900, "newField": "x"}',
      });
      expect(s.lifetimeStats.games, 7);
      expect(s.lifetimeStats.totalScore, 900);
      expect(s.lifetimeStats.bestCombo, 0);
    });

    test('the returned maps are mutable — PuzzleController edits in place',
        () async {
      // A const empty fallback here broke _recordWin with
      // "Cannot modify unmodifiable map".
      final s = await storageWith({});
      expect(() => s.puzzleStars[1] = 3, returnsNormally);
      expect(() => s.missionProgress['x'] = 1, returnsNormally);

      final withData = await storageWith({'puzzleStars': '{"0": 3}'});
      expect(() => withData.puzzleStars[1] = 2, returnsNormally);
    });

    test('valid data still round-trips', () async {
      final s = await storageWith({});
      await s.setMissionProgress({'place_100': 40});
      await s.setPuzzleStars({3: 2});
      await s.setLifetimeStats(const LifetimeStats(games: 5, bestCombo: 9));
      expect(s.missionProgress, {'place_100': 40});
      expect(s.puzzleStars, {3: 2});
      expect(s.lifetimeStats.games, 5);
      expect(s.lifetimeStats.bestCombo, 9);
    });
  });

  group('schema version', () {
    test('a fresh install is stamped with the current version', () async {
      SharedPreferences.setMockInitialValues({});
      await Storage.create();
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('schemaVersion'), Storage.schemaVersion);
    });

    test('a pre-versioning save is kept, not wiped', () async {
      final s = await storageWith({
        'highscore': 4200,
        'lifetimeStats': '{"games": 9}',
      });
      expect(s.highscore, 4200);
      expect(s.lifetimeStats.games, 9);
    });

    test('a save from a newer build is dropped rather than misread', () async {
      final s = await storageWith({
        'schemaVersion': Storage.schemaVersion + 1,
        'highscore': 4200,
        'supporter': true,
        'playerName': 'Puzzlerin',
      });
      expect(s.highscore, 0, reason: 'unknown-shape progress is cleared');
      expect(s.supporter, isTrue, reason: 'a purchase must survive');
      expect(s.playerName, 'Puzzlerin', reason: 'identity must survive');
    });
  });

  group('resetProgress', () {
    test('clears progress but keeps purchases, identity and cosmetics',
        () async {
      final s = await storageWith({
        'highscore': 12840,
        'coins': 900,
        'xp': 120,
        'playerLevel': 4,
        'onboardingDone': true,
        'activeRun.v1': '{"version":1}',
        'supporter': true,
        'starterPurchased': true,
        'renameCredits': 2,
        'playerName': 'Puzzlerin',
        'unlockedThemes': <String>['aurora'],
        'activeSkin': 'crystal',
      });

      await s.resetProgress();

      expect(s.highscore, 0);
      expect(s.coins, Storage.startingCoins);
      expect(s.xp, 0);
      expect(s.playerLevel, 1);
      expect(s.onboardingDone, isFalse);
      expect(s.activeRunCheckpoint, isNull);

      expect(s.supporter, isTrue);
      expect(s.starterPurchased, isTrue);
      expect(s.renameCredits, 2);
      expect(s.playerName, 'Puzzlerin');
      expect(s.unlockedThemes, contains('aurora'));
      expect(s.activeSkin, 'crystal');
    });

    test('settings are not part of a progress reset', () async {
      final s = await storageWith({
        'settings.sound': false,
        'settings.music': false,
        'settings.haptics': false,
        'settings.notifications': true,
      });
      await s.resetProgress();
      expect(s.soundEnabled, isFalse);
      expect(s.musicEnabled, isFalse);
      expect(s.hapticsEnabled, isFalse);
      expect(s.notificationsEnabled, isTrue);
    });

    test('progress and entitlement keys never overlap', () {
      expect(
        Storage.progressKeys.toSet()
            .intersection(Storage.entitlementKeys.toSet()),
        isEmpty,
        reason: 'a reset must never touch something the player paid for',
      );
    });
  });
}
