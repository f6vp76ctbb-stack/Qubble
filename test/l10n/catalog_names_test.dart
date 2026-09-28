/// Theme, skin and level-reward names reach the player through the l10n layer.
///
/// They used to be string fields on the catalogs themselves, written in
/// German: an English player opened the skins screen and read "Verlauf",
/// "Kontur" and "Kristall", and the home screen promised "Level 4:
/// Verlauf-Skin". Nothing caught it, because every l10n test walks the .arb
/// files and these names were never in one.
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/block_skin.dart';
import 'package:gridpop/game/leveling.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/ui/l10n_maps.dart';
import 'package:gridpop/ui/theme.dart';

void main() {
  test('every theme and skin id has a name in every language', () {
    for (final locale in L10n.supportedLocales) {
      final l10n = lookupL10n(locale);
      for (final theme in kThemeCatalog) {
        final name = themeName(l10n, theme.id);
        expect(name.trim(), isNotEmpty, reason: '$locale ${theme.id}');
        // The fallback returns the raw id; a real name is capitalised.
        expect(name, isNot(theme.id), reason: '$locale ${theme.id}');
      }
      for (final skin in kSkinCatalog) {
        final name = skinName(l10n, skin.id);
        expect(name.trim(), isNotEmpty, reason: '$locale ${skin.id}');
        expect(name, isNot(skin.id), reason: '$locale ${skin.id}');
      }
    }
  });

  test('English players see English skin names', () {
    final en = lookupL10n(const Locale('en'));
    final names = [for (final s in kSkinCatalog) skinName(en, s.id)];
    for (final german in ['Verlauf', 'Kontur', 'Glanz', 'Streifen', 'Kristall']) {
      expect(names, isNot(contains(german)));
    }
  });

  test('every level reward gets a label built from the localized name', () {
    for (final locale in L10n.supportedLocales) {
      final l10n = lookupL10n(locale);
      for (final reward in LevelSystem.rewardTrack) {
        final label = levelRewardName(l10n, reward);
        final base = reward.kind == LevelRewardKind.theme
            ? themeName(l10n, reward.id)
            : skinName(l10n, reward.id);
        expect(label, contains(base), reason: '$locale level ${reward.level}');
        expect(label, isNot(base), reason: 'kind word missing in $locale');
      }
    }
  });

  test('the English reward label reads naturally', () {
    final en = lookupL10n(const Locale('en'));
    final gradient =
        LevelSystem.rewardTrack.firstWhere((r) => r.id == 'gradient');
    final ocean = LevelSystem.rewardTrack.firstWhere((r) => r.id == 'ocean');
    expect(levelRewardName(en, gradient), 'Gradient skin');
    expect(levelRewardName(en, ocean), 'Ocean theme');
  });
}
