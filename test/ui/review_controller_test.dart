import 'package:flutter_test/flutter_test.dart';
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
}
