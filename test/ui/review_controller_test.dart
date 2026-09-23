import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/game/review_prompt.dart';
import 'package:gridpop/game/stats.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/audio.dart';
import 'package:gridpop/services/haptics.dart';
import 'package:gridpop/services/review.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records what the platform was asked to do, and can pretend the store is
/// missing (emulator without Play services, sideloaded build).
class _FakeReview implements ReviewService {
  _FakeReview({this.available = true, this.listingOpens = true});

  final bool available;
  final bool listingOpens;
  int requests = 0;
  int listings = 0;

  @override
  Future<bool> requestReview() async {
    requests++;
    return available;
  }

  @override
  Future<bool> openStoreListing() async {
    listings++;
    return listingOpens;
  }
}

/// A storage that has already cleared every [ReviewPrompt] gate.
Future<Storage> _seasonedStorage() async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  await storage.setAppOpenCount(ReviewPrompt.minAppOpens);
  await storage.setLifetimeStats(
    const LifetimeStats(games: ReviewPrompt.minGamesPlayed),
  );
  return storage;
}

GameController _controller(Storage storage, ReviewService review) {
  return GameController(
    storage,
    Haptics(enabled: false),
    SilentAudio(),
    FakeAdService(),
    NoopAnalytics(),
    review: review,
  );
}

/// Plays first-fit moves (rotating a piece when that rescues it) until the
/// run ends.
void _playToGameOver(GameController c) {
  bool tryPlace(int slot) {
    for (var r = 0; r < Board.size; r++) {
      for (var col = 0; col < Board.size; col++) {
        if (c.canPlace(slot, Cell(r, col))) {
          c.place(slot, Cell(r, col));
          return true;
        }
      }
    }
    return false;
  }

  var guard = 0;
  while (!c.state.gameOver && guard++ < 5000) {
    var moved = false;
    for (var slot = 0; slot < c.state.tray.length && !moved; slot++) {
      if (c.state.tray[slot] != null) moved = tryPlace(slot);
    }
    if (moved) continue;
    final budget =
        c.state.rotationFree ? 3 : c.state.rotationCharges.clamp(0, 3);
    for (var slot = 0; slot < c.state.tray.length && !moved; slot++) {
      var rotated = c.state.tray[slot];
      if (rotated == null) continue;
      for (var rot = 1; rot <= budget && !moved; rot++) {
        rotated = rotated!.rotatedCw();
        if (c.state.board.hasAnyPlacement(rotated)) {
          for (var i = 0; i < rot; i++) {
            c.rotateTray(slot);
          }
          moved = tryPlace(slot);
        }
      }
    }
    if (!moved) break;
  }
}

/// Lets the unawaited end-of-run bookkeeping (storage writes, then the
/// review request) finish.
Future<void> _settle() => Future<void>.delayed(const Duration(milliseconds: 50));

void main() {
  group('maybeAskForReview', () {
    test('asks the platform and records the attempt', () async {
      final storage = await _seasonedStorage();
      final review = _FakeReview();
      final controller = _controller(storage, review);

      final asked = await controller.maybeAskForReview(
        ReviewTrigger.newHighscore,
      );

      expect(asked, isTrue);
      expect(review.requests, 1);
      expect(storage.reviewPromptCount, 1);
      expect(storage.reviewLastPromptAt, isNotNull);
    });

    test('stays silent on a fresh install', () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await Storage.create();
      final review = _FakeReview();
      final controller = _controller(storage, review);

      expect(
        await controller.maybeAskForReview(ReviewTrigger.newHighscore),
        isFalse,
      );
      expect(review.requests, 0);
      expect(storage.reviewPromptCount, 0);
    });

    test('does not spend the budget when the platform declines', () async {
      final storage = await _seasonedStorage();
      final review = _FakeReview(available: false);
      final controller = _controller(storage, review);

      expect(
        await controller.maybeAskForReview(ReviewTrigger.newHighscore),
        isFalse,
      );
      expect(review.requests, 1);
      expect(storage.reviewPromptCount, 0, reason: 'nothing was actually shown');
    });

    test('honours the cooldown after a successful prompt', () async {
      final storage = await _seasonedStorage();
      final review = _FakeReview();
      final controller = _controller(storage, review);
      final first = DateTime(2026, 8, 30);

      expect(
        await controller.maybeAskForReview(
          ReviewTrigger.newHighscore,
          now: first,
        ),
        isTrue,
      );
      expect(
        await controller.maybeAskForReview(
          ReviewTrigger.puzzlePerfect,
          now: first.add(const Duration(days: 1)),
        ),
        isFalse,
      );
      expect(
        await controller.maybeAskForReview(
          ReviewTrigger.puzzlePerfect,
          now: first.add(ReviewPrompt.cooldown + const Duration(days: 1)),
        ),
        isTrue,
      );
      expect(storage.reviewPromptCount, 2);
    });
  });

  group('openStoreListingForRating', () {
    test('opens the listing and stops the automatic prompt', () async {
      final storage = await _seasonedStorage();
      final review = _FakeReview();
      final controller = _controller(storage, review);

      expect(await controller.openStoreListingForRating(), isTrue);
      expect(review.listings, 1);
      expect(storage.reviewRated, isTrue);

      expect(
        await controller.maybeAskForReview(ReviewTrigger.newHighscore),
        isFalse,
      );
      expect(review.requests, 0);
    });

    test('reports failure without marking the player as rated', () async {
      final storage = await _seasonedStorage();
      final review = _FakeReview(listingOpens: false);
      final controller = _controller(storage, review);

      expect(await controller.openStoreListingForRating(), isFalse);
      expect(storage.reviewRated, isFalse);
    });
  });

  group('a new personal best asks on its own', () {
    // MASTERPLAN.md Phase 7b names two moments: a new best and a three-star
    // puzzle, and that is what docs/PRODUCTION-ACCESS.md told Google. Only the
    // puzzle was wired, so most players could never see the card.

    test('an endless run that sets a new best requests the card', () async {
      final storage = await _seasonedStorage();
      final review = _FakeReview();
      final controller = _controller(storage, review);

      controller.newGame(seed: 1);
      _playToGameOver(controller);
      await _settle();

      expect(controller.state.gameOver, isTrue);
      expect(controller.state.isNewHighscore, isTrue);
      expect(review.requests, 1);
      expect(storage.reviewPromptCount, 1);
    });

    test('a run below the best does not', () async {
      final storage = await _seasonedStorage();
      await storage.setHighscore(100000000);
      final review = _FakeReview();
      final controller = _controller(storage, review);

      controller.newGame(seed: 1);
      _playToGameOver(controller);
      await _settle();

      expect(controller.state.gameOver, isTrue);
      expect(controller.state.isNewHighscore, isFalse);
      expect(review.requests, 0);
    });

    test('the daily never counts as a new best, so it does not ask', () async {
      final storage = await _seasonedStorage();
      final review = _FakeReview();
      final controller = _controller(storage, review);

      controller.startDaily(now: DateTime(2026, 7, 5));
      _playToGameOver(controller);
      await _settle();

      expect(controller.state.gameOver, isTrue);
      expect(review.requests, 0);
    });

    test('a fresh install with a first best still stays silent', () async {
      // The gates in ReviewPrompt still apply: the very first run is always a
      // new best, and it must not bring a rating card with it.
      SharedPreferences.setMockInitialValues({});
      final storage = await Storage.create();
      final review = _FakeReview();
      final controller = _controller(storage, review);

      controller.newGame(seed: 1);
      _playToGameOver(controller);
      await _settle();

      expect(controller.state.isNewHighscore, isTrue);
      expect(review.requests, 0);
    });
  });
}
