// The daily share text is the only viral loop the game has, and it must not
// depend on a server or on a store listing that is not reachable.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/daily_share.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/sharing.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('DailyShare.grid', () {
    test('renders one emoji per cell, eight rows of eight', () {
      final grid = DailyShare.grid(Board.empty());
      final rows = grid.split('\n');
      expect(rows.length, Board.size);
      for (final row in rows) {
        // Emoji are outside the BMP, so count runes, not code units.
        expect(row.runes.length, Board.size);
      }
    });

    test('an empty board is all empty cells, a filled one is not', () {
      final empty = DailyShare.grid(Board.empty());
      expect(empty.contains(DailyShare.filledCell), isFalse);

      final withPiece = Board.empty()
          .place(buildCatalog().firstWhere((p) => p.id == 'square2'), const Cell(0, 0))
          .board;
      final grid = DailyShare.grid(withPiece);
      expect(grid.contains(DailyShare.filledCell), isTrue);
      expect(grid.contains(DailyShare.emptyCell), isTrue);
      // The piece sits in the top-left corner, so the first row starts filled.
      expect(grid.split('\n').first.runes.first,
          DailyShare.filledCell.runes.first);
    });

    test('the two cell glyphs are distinct', () {
      // A share text where filled and empty look alike carries no information.
      expect(DailyShare.filledCell, isNot(DailyShare.emptyCell));
    });
  });

  testWidgets('the share text carries date, score, grid and a working link', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    late String captured;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          storageProvider.overrideWithValue(storage),
          sharerProvider.overrideWithValue((text) async {
            captured = text;
            return true;
          }),
        ],
        child: MaterialApp(
          theme: buildGridTheme(),
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: Builder(
            builder: (context) => Consumer(
              builder: (context, ref, _) => TextButton(
                onPressed: () => ref.read(sharerProvider)(
                  buildDailyShareText(
                    l10n: L10n.of(context),
                    board: Board.empty()
                        .place(buildCatalog().firstWhere((p) => p.id == 'square2'), const Cell(0, 0))
                        .board,
                    score: 4213,
                    bestCombo: 7,
                    date: DateTime(2026, 9, 2),
                  ),
                ),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('go'));
    await tester.pump();

    expect(captured, contains('2026-09-02'));
    // Grouped by the app's own number format, not raw digits — the share text
    // should read the way the score reads on screen.
    expect(captured, contains('4,213'));
    expect(captured, contains('x7'));
    expect(captured, contains(DailyShare.filledCell));
    // The link has to point at something reachable. The Play listing is not,
    // so the web build is what gets shared.
    expect(captured, contains(kQubbleWebUrl));
    expect(captured, isNot(contains('play.google.com')));
  });
}
