import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/puzzle_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

/// Grants or refuses the reward on demand.
class ScriptedAdService implements AdService {
  @override
  bool get rewardedReady => true;

  ScriptedAdService({required this.grants});

  final bool grants;
  int shown = 0;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> showRewarded() async {
    shown += 1;
    return grants;
  }

  @override
  Future<bool> showPrivacyOptions() async => false;
}

Future<(ProviderContainer, RecordingAnalytics)> _container({
  required bool adGrants,
  ScriptedAdService? ads,
}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  final analytics = RecordingAnalytics();
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      analyticsProvider.overrideWithValue(analytics),
      adServiceProvider
          .overrideWithValue(ads ?? ScriptedAdService(grants: adGrants)),
    ],
  );
  addTearDown(container.dispose);
  return (container, analytics);
}

/// Drives the level into the failed state by placing the first piece where it
/// cannot lead to an empty board, then waiting for the deferred stuck-check.
Future<bool> _playIntoFailure(PuzzleController c) async {
  for (var guard = 0; guard < 40 && !c.state.failed; guard++) {
    final piece = c.state.currentPiece;
    if (piece == null) return false;
    Cell? spot;
    for (var r = 0; r < Board.size && spot == null; r++) {
      for (var col = 0; col < Board.size; col++) {
        if (c.state.board.canPlace(piece, Cell(r, col))) {
          spot = Cell(r, col);
          break;
        }
      }
    }
    if (spot == null) return false;
    await c.place(spot);
    await c.settled;
  }
  return c.state.failed;
}

void main() {
  group('puzzle extra move', () {
    test('a watched video reports its placement and grants the move', () async {
      final (container, analytics) = await _container(adGrants: true);
      final controller = container.read(puzzleControllerProvider.notifier);

      expect(await _playIntoFailure(controller), isTrue,
          reason: 'the level must reach the failed state for this test');
      expect(controller.state.canExtraMove, isTrue);

      final granted = await controller.extraMoveWithAd();

      expect(granted, isTrue);
      expect(controller.state.failed, isFalse);
      expect(controller.state.extraMoveUsed, isTrue);

      final watched =
          analytics.paramsFor(AnalyticsEvent.rewardedWatched).single;
      expect(watched['placement'], 'puzzle_extra_move');
      expect(watched['earned'], isTrue);
    });

    test('a refused video is still reported, and leaves the level failed',
        () async {
      final (container, analytics) = await _container(adGrants: false);
      final controller = container.read(puzzleControllerProvider.notifier);

      expect(await _playIntoFailure(controller), isTrue);

      final granted = await controller.extraMoveWithAd();

      expect(granted, isFalse);
      expect(controller.state.failed, isTrue);
      expect(controller.state.extraMoveUsed, isFalse,
          reason: 'a refused reward must not consume the one-shot move');

      // A tap that yields no ad has to stay visible in the funnel, or it is
      // indistinguishable from never tapping and the opt-in rate is wrong.
      expect(
        analytics.paramsFor(AnalyticsEvent.rewardedAccepted).single['placement'],
        'puzzle_extra_move',
      );
      final watched =
          analytics.paramsFor(AnalyticsEvent.rewardedWatched).single;
      expect(watched['earned'], isFalse);
    });

    test('the offer is one-shot: no second ad is ever requested', () async {
      final ads = ScriptedAdService(grants: true);
      final (container, _) = await _container(adGrants: true, ads: ads);
      final controller = container.read(puzzleControllerProvider.notifier);

      expect(await _playIntoFailure(controller), isTrue);
      expect(await controller.extraMoveWithAd(), isTrue);
      expect(ads.shown, 1);

      // Play back into failure; the move is already spent, so canExtraMove is
      // false and no further ad may be requested.
      await _playIntoFailure(controller);
      expect(controller.state.canExtraMove, isFalse);
      expect(await controller.extraMoveWithAd(), isFalse);
      expect(ads.shown, 1);
    });
  });
}
