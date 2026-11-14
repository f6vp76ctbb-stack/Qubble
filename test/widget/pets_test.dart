// The Qubbies on screen (docs/HAUSTIERE.md, core scope): on the board, on the
// game-over card, in the nest and on the home screen.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/pet.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/l10n/app_localizations.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/locale.dart';
import 'package:gridpop/ui/screens/game_screen.dart';
import 'package:gridpop/ui/screens/home_screen.dart';
import 'package:gridpop/ui/screens/qubbies_screen.dart';
import 'package:gridpop/ui/screens/shop_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/pet_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:gridpop/ui/widgets/board_view.dart';
import 'package:gridpop/ui/widgets/notice_badge.dart';
import 'package:gridpop/ui/widgets/pet_moments.dart';
import 'package:gridpop/ui/widgets/pet_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/play_to_game_over.dart';

/// A hatched Qubbie that plays along, on top of the free starter.
PetState _hatched(String id, {int xp = 0}) {
  var pets = PetState.empty.chooseStarter('kiki').addLines(10);
  pets = pets.hatchReady().state;
  if (id != 'kiki') {
    pets = pets.addBoughtEgg(id)!.addLines(PetRules.boughtEggLines);
    pets = pets.hatchReady().state.withActive(id);
  }
  return pets.addLines(xp);
}

Future<Storage> _storage({
  PetState? pets,
  int diamonds = 0,
  int finishedRuns = 0,
  bool reducedEffects = false,
}) async {
  SharedPreferences.setMockInitialValues({
    if (finishedRuns > 0) 'lifetimeStats': '{"games":$finishedRuns}',
    if (reducedEffects) 'settings.reducedEffects': true,
  });
  final storage = await Storage.create();
  await storage.setOnboardingDone(true);
  // A name is set, so the leaderboard question never opens here.
  await storage.setPlayerName('Puzzlerin');
  if (pets != null) await storage.setPets(pets);
  if (diamonds > 0) await storage.setDiamonds(diamonds);
  return storage;
}

ProviderContainer _container(Storage storage) {
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      hapticsProvider.overrideWithValue(Haptics(enabled: false)),
      gameClockProvider.overrideWithValue(SteppingClock().call),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

Future<void> _pump(
  WidgetTester tester,
  ProviderContainer container,
  Widget home, {
  Locale locale = const Locale('en'),
  double textScale = 1,
  Size size = const Size(360, 800),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildGridTheme(),
        locale: locale,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: home,
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 300));
}

/// Not pumpAndSettle: the home screen's particles and a moving skin never
/// come to rest.
Future<void> _settle(WidgetTester tester, [int steps = 20]) async {
  for (var i = 0; i < steps; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Places pieces until a line is cleared.
void _playToClear(GameController c) {
  final before = c.state.clearEventId;
  var guard = 0;
  while (c.state.clearEventId == before && guard++ < 400) {
    expect(placeSomething(c), isTrue, reason: 'the run ended before a clear');
  }
}

PetOverlayState _overlay(WidgetTester tester) =>
    tester.state<PetOverlayState>(find.byType(PetOverlay));

bool _overlayPaints(WidgetTester tester) => find
    .descendant(of: find.byType(PetOverlay), matching: find.byType(CustomPaint))
    .evaluate()
    .isNotEmpty;

void main() {
  group('the line a Qubbie flies along', () {
    List<Cell> row(int r) => [for (var c = 0; c < 8; c++) Cell(r, c)];
    List<Cell> col(int c) => [for (var r = 0; r < 8; r++) Cell(r, c)];

    test('a row', () {
      final line = PetFlightLine.first(row(5))!;
      expect(line.horizontal, isTrue);
      expect(line.index, 5);
    });

    test('a column', () {
      final line = PetFlightLine.first(col(2))!;
      expect(line.horizontal, isFalse);
      expect(line.index, 2);
    });

    test('of several, the topmost row; a row before a column', () {
      expect(PetFlightLine.first([...row(6), ...row(3)])!.index, 3);
      final cross = PetFlightLine.first({...col(1), ...row(7)}.toList())!;
      expect(cross.horizontal, isTrue);
      expect(cross.index, 7);
      final columns = PetFlightLine.first([...col(6), ...col(4)])!;
      expect(columns.horizontal, isFalse);
      expect(columns.index, 4);
    });

    test('a bomb clears no whole line: nowhere to fly', () {
      expect(
        PetFlightLine.first(const [Cell(2, 2), Cell(2, 3), Cell(3, 2)]),
        isNull,
      );
      expect(PetFlightLine.first(const []), isNull);
    });
  });

  group('on the board', () {
    testWidgets('without a Qubbie or an egg nothing is drawn', (tester) async {
      final container = _container(await _storage());
      container.read(gameControllerProvider.notifier).newGame(seed: 11);
      await _pump(tester, container, const GameScreen());
      expect(find.byType(PetOverlay), findsOneWidget);
      expect(_overlayPaints(tester), isFalse);
    });

    testWidgets('a Qubbie flies along a cleared line and is back in time', (
      tester,
    ) async {
      final container = _container(await _storage(pets: _hatched('funki')));
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 11);
      await _pump(tester, container, const GameScreen());
      expect(_overlayPaints(tester), isTrue);
      expect(_overlay(tester).isFlying, isFalse);

      _playToClear(c);
      await tester.pump();
      expect(_overlay(tester).isFlying, isTrue);
      expect(_overlay(tester).flightLine, isNotNull);

      // docs/HAUSTIERE.md §3.3: 600 ms at most.
      expect(
        PetOverlay.flightDuration,
        lessThanOrEqualTo(const Duration(milliseconds: 600)),
      );
      await tester.pump(PetOverlay.flightDuration);
      await tester.pump(const Duration(milliseconds: 20));
      expect(_overlay(tester).isFlying, isFalse);
      await _settle(tester);
    });

    testWidgets('it takes no room and no touch', (tester) async {
      final plain = _container(await _storage());
      plain.read(gameControllerProvider.notifier).newGame(seed: 11);
      await _pump(tester, plain, const GameScreen());
      final boardWithout = tester.getRect(find.byType(BoardView));

      final container = _container(await _storage(pets: _hatched('pyra')));
      container.read(gameControllerProvider.notifier).newGame(seed: 11);
      await _pump(tester, container, const GameScreen());
      expect(tester.getRect(find.byType(BoardView)), boardWithout);
      expect(
        find.ancestor(
          of: find.byType(PetOverlay),
          matching: find.byWidgetPredicate(
            (w) => w is IgnorePointer && w.ignoring,
          ),
        ),
        findsWidgets,
      );
    });

    testWidgets('reduced effects: it stays seated', (tester) async {
      final container = _container(
        await _storage(pets: _hatched('funki'), reducedEffects: true),
      );
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 11);
      await _pump(tester, container, const GameScreen());
      _playToClear(c);
      await tester.pump();
      expect(_overlay(tester).isFlying, isFalse);
      await _settle(tester);
    });

    testWidgets('an egg sits there and does not fly', (tester) async {
      final container = _container(
        await _storage(pets: PetState.empty.chooseStarter('kiki')),
      );
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 11);
      await _pump(tester, container, const GameScreen());
      expect(_overlayPaints(tester), isTrue);
      _playToClear(c);
      await tester.pump();
      expect(_overlay(tester).isFlying, isFalse);
      await _settle(tester);
    });

    testWidgets('the next piece over the board ends the flight at once', (
      tester,
    ) async {
      final container = _container(await _storage(pets: _hatched('zapp')));
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 11);
      await _pump(tester, container, const GameScreen());
      _playToClear(c);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      expect(_overlay(tester).isFlying, isTrue);

      final piece = c.state.tray.whereType<Piece>().first;
      container.read(dragPreviewProvider.notifier).state = DragPreview(
        piece: piece,
        origin: const Cell(4, 4),
        valid: true,
      );
      await tester.pump();
      expect(_overlay(tester).isFlying, isFalse);
      container.read(dragPreviewProvider.notifier).state = null;
      await _settle(tester);
    });
  });

  group('on the game-over card', () {
    testWidgets('run three brings the free first egg; choosing turns it '
        'into the egg on its way', (tester) async {
      final container = _container(await _storage(finishedRuns: 2));
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 4242);
      await _pump(tester, container, const GameScreen());
      playToGameOver(c);
      await _settle(tester);

      expect(find.byType(PetChoice), findsOneWidget);
      expect(find.text('Choose your first Qubbie'), findsOneWidget);
      for (final name in ['Kiki', 'Bit', 'Glim']) {
        expect(find.text(name), findsOneWidget);
      }

      await tester.ensureVisible(find.byKey(const ValueKey('pet-choose-bit')));
      await tester.tap(find.byKey(const ValueKey('pet-choose-bit')));
      await _settle(tester, 5);
      expect(find.byType(PetChoice), findsNothing);
      expect(find.byType(PetEggProgress), findsOneWidget);
      expect(find.text('0 / 10'), findsOneWidget);
      expect(
        container.read(petControllerProvider).pets.eggs.single.petId,
        'bit',
      );
    });

    testWidgets('before run three there is nothing about Qubbies', (
      tester,
    ) async {
      final container = _container(await _storage(finishedRuns: 1));
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 4242);
      await _pump(tester, container, const GameScreen());
      playToGameOver(c);
      await _settle(tester);
      expect(find.byType(PetChoice), findsNothing);
      expect(find.byType(PetEggProgress), findsNothing);
      expect(find.byType(PetHatched), findsNothing);
    });

    testWidgets('no question opens over the egg: the name keeps for the '
        'next run', (tester) async {
      SharedPreferences.setMockInitialValues({
        'lifetimeStats': '{"games":2}',
      });
      final storage = await Storage.create();
      await storage.setOnboardingDone(true);
      final container = _container(storage);
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 4242);
      await _pump(tester, container, const GameScreen());
      playToGameOver(c);
      await _settle(tester, 30);
      // A first best score on run three would have asked for a name.
      expect(c.state.askForName, isTrue);
      expect(find.byType(PetChoice), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.byType(Dialog), findsNothing);
    });

    testWidgets('a ready egg opens: the newcomer is named and plays along '
        'in the next run', (tester) async {
      final container = _container(
        await _storage(
          finishedRuns: 3,
          pets: PetState.empty.chooseStarter('kiki').addLines(10),
        ),
      );
      final c = container.read(gameControllerProvider.notifier)
        ..newGame(seed: 4242);
      await _pump(tester, container, const GameScreen());
      playToGameOver(c);
      await _settle(tester);

      expect(find.byType(PetHatched), findsOneWidget);
      expect(find.text('Kiki has hatched!'), findsOneWidget);
      expect(find.text('It plays along from now on.'), findsOneWidget);

      c.newGame(seed: 5);
      await _settle(tester, 5);
      expect(find.byType(PetHatched), findsNothing);
      expect(container.read(petControllerProvider).active?.id, 'kiki');
      expect(_overlayPaints(tester), isTrue);
    });
  });

  group('in the nest', () {
    testWidgets('a new player is told when the first egg comes', (
      tester,
    ) async {
      final container = _container(await _storage());
      await _pump(tester, container, const QubbiesScreen());
      expect(
        find.text('Your first egg comes after run 3 — free.'),
        findsOneWidget,
      );
      expect(find.byType(PetChoice), findsNothing);
      // All nine are on show.
      for (final pet in kPetCatalog) {
        expect(find.byKey(ValueKey('pet-card-${pet.id}')), findsOneWidget);
      }
    });

    testWidgets('after three runs the egg is chosen here as well', (
      tester,
    ) async {
      final container = _container(await _storage(finishedRuns: 3));
      await _pump(tester, container, const QubbiesScreen());
      expect(find.byType(PetChoice), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('pet-choose-glim')));
      await tester.pumpAndSettle();
      expect(find.byType(PetChoice), findsNothing);
      expect(find.byType(PetEggProgress), findsOneWidget);
      expect(find.text('In the egg'), findsOneWidget);
    });

    testWidgets('a starter is not for sale while the free egg is unchosen', (
      tester,
    ) async {
      final container = _container(await _storage(diamonds: 5000));
      await _pump(tester, container, const QubbiesScreen());
      await tester.tap(find.byKey(const ValueKey('pet-card-kiki')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('pet-buy')), findsNothing);
      expect(container.read(petControllerProvider).pets.eggs, isEmpty);
    });

    testWidgets('buying: a sheet with the price, then an egg and fewer '
        'diamonds', (tester) async {
      final storage = await _storage(pets: _hatched('kiki'), diamonds: 1000);
      final container = _container(storage);
      await _pump(tester, container, const QubbiesScreen());

      final card = find.byKey(const ValueKey('pet-card-funki'));
      await tester.ensureVisible(card);
      await tester.pumpAndSettle();
      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(find.text('Brings its own row effect'), findsOneWidget);
      expect(find.text('$kFlagshipPetPrice'), findsWidgets);

      await tester.tap(find.byKey(const ValueKey('pet-buy')));
      await tester.pumpAndSettle();
      expect(storage.diamonds, 1000 - kFlagshipPetPrice);
      final pets = container.read(petControllerProvider).pets;
      expect(pets.eggs.single.petId, 'funki');
      expect(pets.owned, {'kiki'});
      expect(find.text('In the egg'), findsOneWidget);
      expect(find.text('0 / 15'), findsOneWidget);
    });

    testWidgets('too few diamonds: the price and the way to the shop, no '
        'buy button', (tester) async {
      final storage = await _storage(pets: _hatched('kiki'), diamonds: 100);
      final container = _container(storage);
      await _pump(tester, container, const QubbiesScreen());
      final card = find.byKey(const ValueKey('pet-card-frosti'));
      await tester.ensureVisible(card);
      await tester.pumpAndSettle();
      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('pet-buy')), findsNothing);
      expect(find.text('Get diamonds'), findsOneWidget);
      await tester.tap(find.text('Get diamonds'));
      await _settle(tester, 8);
      expect(find.byType(ShopScreen), findsOneWidget);
      expect(storage.diamonds, 100);
    });

    testWidgets('tapping a hatched Qubbie makes it the one that plays along', (
      tester,
    ) async {
      final container = _container(await _storage(pets: _hatched('funki')));
      await _pump(tester, container, const QubbiesScreen());
      expect(container.read(petControllerProvider).active?.id, 'funki');
      // Level and experience of the active one.
      expect(find.text('Level 1'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('pet-card-kiki')));
      await tester.pumpAndSettle();
      expect(container.read(petControllerProvider).active?.id, 'kiki');
      expect(find.text('Flies with your row effect'), findsOneWidget);
    });

    testWidgets('a grown Qubbie shows its level', (tester) async {
      final container = _container(
        await _storage(pets: _hatched('funki', xp: 420)),
      );
      await _pump(tester, container, const QubbiesScreen());
      expect(find.text('Level 2'), findsOneWidget);
      expect(find.text('420 / 1500'), findsOneWidget);
    });
  });

  group('on the home screen', () {
    testWidgets('the Qubbies button opens the nest', (tester) async {
      final container = _container(await _storage());
      await _pump(tester, container, const HomeScreen());
      final button = find.widgetWithText(OutlinedButton, 'Qubbies');
      await tester.ensureVisible(button);
      await tester.pump();
      await tester.tap(button);
      await _settle(tester, 8);
      expect(find.byType(QubbiesScreen), findsOneWidget);
    });

    testWidgets('it carries the "!" while the free egg waits, and not '
        'before or after', (tester) async {
      Finder badge() => find.descendant(
        of: find.byKey(const ValueKey('home-qubbies')),
        matching: find.byType(NoticeBadge),
      );

      var container = _container(await _storage(finishedRuns: 2));
      await _pump(tester, container, const HomeScreen());
      expect(badge(), findsNothing);

      container = _container(await _storage(finishedRuns: 3));
      await _pump(tester, container, const HomeScreen());
      expect(badge(), findsOneWidget);

      container = _container(
        await _storage(
          finishedRuns: 3,
          pets: PetState.empty.chooseStarter('kiki'),
        ),
      );
      await _pump(tester, container, const HomeScreen());
      expect(badge(), findsNothing);
    });

    testWidgets('the Qubbie on the play button leads to the nest, and the '
        'button still starts a run', (tester) async {
      final container = _container(await _storage(pets: _hatched('funki')));
      await _pump(tester, container, const HomeScreen());
      final qubbie = find.byKey(const ValueKey('home-qubbie'));
      expect(qubbie, findsOneWidget);
      await tester.tap(qubbie);
      await _settle(tester, 8);
      expect(find.byType(QubbiesScreen), findsOneWidget);

      await tester.pageBack();
      await _settle(tester, 8);
      expect(find.byType(QubbiesScreen), findsNothing);
      await tester.tap(find.widgetWithText(FilledButton, 'Play'));
      await _settle(tester, 8);
      expect(find.byType(GameScreen), findsOneWidget);
    });

    testWidgets('no Qubbie, no picture on the play button', (tester) async {
      final container = _container(await _storage());
      await _pump(tester, container, const HomeScreen());
      expect(find.byKey(const ValueKey('home-qubbie')), findsNothing);
    });
  });

  group('nothing overflows', () {
    // The nest with a Qubbie and an egg, the choice, and the sheet — in
    // every language, on a small phone, at the largest font the game is
    // tested with.
    for (final locale in L10n.supportedLocales) {
      testWidgets('the nest and its sheet fit in ${localeCode(locale)}', (
        tester,
      ) async {
        final overflows = <String>[];
        final previous = FlutterError.onError;
        FlutterError.onError = (details) {
          final text = details.exceptionAsString();
          if (text.contains('overflowed')) {
            overflows.add(text.split('\n').first);
          } else {
            previous?.call(details);
          }
        };
        try {
          for (final scale in [1.0, 2.0]) {
            var container = _container(
              await _storage(
                pets: _hatched('funki', xp: 420).addBoughtEgg('pyra')!,
                diamonds: 100,
              ),
            );
            await _pump(
              tester,
              container,
              const QubbiesScreen(),
              locale: locale,
              textScale: scale,
              size: const Size(360, 640),
            );
            // The list builds its rows as they come near: scroll to the
            // card rather than look for it.
            final card = find.byKey(const ValueKey('pet-card-optik'));
            await tester.scrollUntilVisible(
              card,
              120,
              scrollable: find.byType(Scrollable).first,
            );
            await tester.pumpAndSettle();
            await tester.tap(card);
            await tester.pumpAndSettle();
            expect(find.byIcon(Icons.auto_awesome_rounded), findsWidgets);
            // Close the sheet, so the next round starts from the screen.
            await tester.tapAt(const Offset(180, 20));
            await tester.pumpAndSettle();

            container = _container(await _storage(finishedRuns: 3));
            await _pump(
              tester,
              container,
              const QubbiesScreen(),
              locale: locale,
              textScale: scale,
              size: const Size(360, 640),
            );
          }
        } finally {
          FlutterError.onError = previous;
        }
        expect(overflows, isEmpty, reason: overflows.join('\n'));
      });
    }
  });
}
