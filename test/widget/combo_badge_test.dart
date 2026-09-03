// The combo badge used to be a draining time bar. That bar was honest about
// the old rule and would be a lie about this one — nothing expires with the
// clock any more.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/scoring.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('no wall-clock progress bar is left in the game HUD', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [storageProvider.overrideWithValue(storage)],
        child: MaterialApp(
          theme: buildGridTheme(),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const GameScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 400));

    // The fever bar is a LinearProgressIndicator too, so this asserts the
    // absence of the SECOND one the combo countdown used to add.
    expect(
      find.byType(LinearProgressIndicator).evaluate().length,
      lessThanOrEqualTo(1),
    );
  });

  test('the window is stated in moves and matches what the rules promise', () {
    // The how-to-play text says "within three moves"; if the constant ever
    // moves, that sentence becomes false and this fails first.
    expect(ScoreKeeper.defaultComboWindowMoves, 3);
  });

  test('a fresh keeper reports no combo and no window', () {
    final s = ScoreKeeper();
    expect(s.comboMovesLeft, isNull);
  });
}
