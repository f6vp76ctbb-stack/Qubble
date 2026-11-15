// How a piece turns since 15.11.2026 (owner): no rotate button any more. A
// tap on a piece in the tray turns it, and while a piece is held, a tap with
// a second finger turns the held piece. One charge pays for a whole piece.
//
// These tests drive the real game screen with real pointer gestures.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/coach_hints.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:gridpop/ui/widgets/piece_view.dart';
import 'package:gridpop/ui/widgets/tray_view.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The game screen on a phone, with [level] deciding whether turning is free
/// (beginners, level 2 and below) or costs charges.
Future<ProviderContainer> _pump(WidgetTester tester, {int level = 5}) async {
  // The how-to-turn tip is marked seen: this file is about the gestures, and
  // the tip would otherwise take the hint slot after the first drop.
  SharedPreferences.setMockInitialValues({
    'onboardingDone': true,
    'hint.turnHow': true,
  });
  final storage = await Storage.create();
  await storage.setPlayerLevel(level);
  tester.view.physicalSize = const Size(400, 820);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      leaderboardServiceProvider.overrideWithValue(
        LeaderboardService(
          client: MockClient((_) async => http.Response('[]', 200)),
          storage: storage,
        ),
      ),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildGridTheme(),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        home: const GameScreen(),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 400));
  return container;
}

/// The slot of the first tray piece that changes shape when turned.
int _turnableSlot(ProviderContainer c) {
  final tray = c.read(gameControllerProvider).tray;
  for (var slot = 0; slot < tray.length; slot++) {
    final piece = tray[slot];
    if (piece != null && !_sameCells(piece, piece.rotatedCw())) return slot;
  }
  throw StateError('no piece in the opening tray changes when turned');
}

bool _sameCells(Piece a, Piece b) =>
    a.cells.length == b.cells.length &&
    a.cells.every((cell) => b.cells.contains(cell));

/// Centre of the tray piece in [slot] on screen.
Offset _slotCenter(WidgetTester tester, int slot) {
  final tray = find.byType(TrayView);
  final pieces = find.descendant(of: tray, matching: find.byType(PieceView));
  // Every live slot draws exactly one PieceView in the tray (the feedback
  // only exists while dragging); empty slots draw none.
  return tester.getCenter(pieces.at(slot));
}

void main() {
  testWidgets('there is no rotate button any more', (tester) async {
    await _pump(tester);
    expect(find.byIcon(Icons.rotate_right_rounded), findsNothing);
  });

  testWidgets('a tap on a piece turns it; turning it again is free',
      (tester) async {
    final c = await _pump(tester);
    final slot = _turnableSlot(c);
    final before = c.read(gameControllerProvider).tray[slot]!;
    final charges = c.read(gameControllerProvider).rotationCharges;

    await tester.tapAt(_slotCenter(tester, slot));
    await tester.pump();
    var state = c.read(gameControllerProvider);
    expect(_sameCells(state.tray[slot]!, before.rotatedCw()), isTrue);
    expect(state.rotationCharges, charges - 1, reason: 'the first turn pays');

    await tester.tapAt(_slotCenter(tester, slot));
    await tester.pump();
    state = c.read(gameControllerProvider);
    expect(_sameCells(state.tray[slot]!, before.rotatedCw().rotatedCw()),
        isTrue);
    expect(state.rotationCharges, charges - 1, reason: 'the same piece again');
  });

  testWidgets('a second finger turns the piece that is held', (tester) async {
    final c = await _pump(tester);
    final slot = _turnableSlot(c);
    final before = c.read(gameControllerProvider).tray[slot]!;

    // Pick the piece up and carry it over the board.
    final hold = await tester.startGesture(_slotCenter(tester, slot));
    await tester.pump();
    final board = tester.getCenter(find.byType(BoardView));
    await hold.moveTo(Offset(board.dx, board.dy - 10));
    await tester.pump();
    await hold.moveTo(board);
    await tester.pump();
    expect(c.read(activeDragProvider)?.slot, slot);

    // A second finger taps somewhere else.
    final second = await tester.startGesture(const Offset(30, 300));
    await tester.pump();
    await second.up();
    await tester.pump();

    final turned = c.read(gameControllerProvider).tray[slot]!;
    expect(_sameCells(turned, before.rotatedCw()), isTrue);
    // The board preview shows the turned piece at once, without a move.
    final preview = c.read(dragPreviewProvider);
    expect(preview, isNotNull);
    expect(_sameCells(preview!.piece, turned), isTrue);
    expect(preview.valid, isTrue, reason: 'the opening board is empty');
    // No hint banner appears mid-drag: it would resize the board under the
    // finger, and the piece would land a row away from its preview.
    expect(c.read(gameControllerProvider).contextualHint, isNull);

    // Let go: the piece lands exactly where the preview showed it.
    await hold.up();
    await tester.pump(const Duration(milliseconds: 400));
    expect(c.read(activeDragProvider), isNull);
    final state = c.read(gameControllerProvider);
    expect(state.tray[slot], isNull, reason: 'the piece was placed');
    expect(state.contextualHint, CoachHintType.rotation,
        reason: 'the hint about turning comes with the drop');
    for (final cell in turned.cells) {
      expect(
        state.board.filledAt(
          preview.origin.row + cell.row,
          preview.origin.col + cell.col,
        ),
        isTrue,
        reason: 'cell $cell of the turned piece',
      );
    }
  });

  testWidgets('while a piece is held, the booster bar does not take taps',
      (tester) async {
    final c = await _pump(tester);
    final slot = _turnableSlot(c);
    final l10n = await L10n.delegate.load(const Locale('en'));

    final hold = await tester.startGesture(_slotCenter(tester, slot));
    await tester.pump();
    await hold.moveBy(const Offset(0, -60));
    await tester.pump();
    expect(c.read(activeDragProvider), isNotNull);

    final guarded = find.ancestor(
      of: find.text(l10n.boosterUndo),
      matching: find.byWidgetPredicate(
        (widget) => widget is IgnorePointer && widget.ignoring,
      ),
    );
    expect(guarded, findsWidgets);

    await hold.up();
    await tester.pump(const Duration(milliseconds: 400));
    expect(
      find.ancestor(
        of: find.text(l10n.boosterUndo),
        matching: find.byWidgetPredicate(
          (widget) => widget is IgnorePointer && widget.ignoring,
        ),
      ),
      findsNothing,
      reason: 'after the drag the boosters work again',
    );
  });
}
