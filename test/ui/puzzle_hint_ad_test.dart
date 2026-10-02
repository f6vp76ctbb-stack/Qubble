// The rewarded puzzle hint (owner decision 02.10.2026): a video shows where
// the current piece goes, any number per level, and using one costs a star.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/game/board.dart';
import 'package:gridpop/game/piece.dart' show Cell;
import 'package:gridpop/game/puzzle.dart';
import 'package:gridpop/monetization/ads.dart';
import 'package:gridpop/services/analytics.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/state/puzzle_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/recording_analytics.dart';

class _Ads implements AdService {
  _Ads({this.grants = true, this.ready = true});

  bool grants;
  bool ready;
  final shown = <AdPlacement>[];
  final prepared = <AdPlacement>[];

  @override
  Future<void> initialize() async {}

  @override
  void prepare(AdPlacement placement) => prepared.add(placement);

  @override
  bool rewardedReadyFor(AdPlacement placement) => ready;

  @override
  Future<bool> showRewarded(AdPlacement placement) async {
    shown.add(placement);
    return grants;
  }

  @override
  Future<bool> showPrivacyOptions() async => false;
}

Future<(PuzzleController, _Ads, RecordingAnalytics)> _controller({
  bool grants = true,
  bool ready = true,
}) async {
  SharedPreferences.setMockInitialValues({});
  final storage = await Storage.create();
  final analytics = RecordingAnalytics();
  final ads = _Ads(grants: grants, ready: ready);
  final container = ProviderContainer(
    overrides: [
      storageProvider.overrideWithValue(storage),
      analyticsProvider.overrideWithValue(analytics),
      adServiceProvider.overrideWithValue(ads),
    ],
  );
  addTearDown(container.dispose);
  final controller = container.read(puzzleControllerProvider.notifier)
    ..loadLevel(3);
  return (controller, ads, analytics);
}

/// Places every remaining piece where the hint says, watching a video for
/// each.
Future<void> _solveWithHints(PuzzleController c) async {
  while (!c.state.solved) {
    expect(await c.hintWithAd(), HintOutcome.shown);
    await c.place(c.state.hint!);
    await c.settled;
  }
}

void main() {
  test('a watched video puts the hint on the board, for the current piece',
      () async {
    final (c, ads, analytics) = await _controller();
    final puzzle = PuzzleGenerator.generate(3);
    expect(c.state.canHint, isTrue);

    expect(await c.hintWithAd(), HintOutcome.shown);
    expect(c.state.hint, puzzle.solution.first);
    expect(c.state.hintUsed, isTrue);
    expect(c.state.canHint, isFalse, reason: 'one hint is already showing');
    expect(ads.shown, [AdPlacement.puzzleHint]);

    expect(
      analytics.paramsFor(AnalyticsEvent.rewardedAccepted).single['placement'],
      'puzzle_hint',
    );
    final watched = analytics.paramsFor(AnalyticsEvent.rewardedWatched).single;
    expect(watched['placement'], 'puzzle_hint');
    expect(watched['earned'], isTrue);
  });

  test('placing the piece clears the hint; the next one is another video',
      () async {
    final (c, ads, _) = await _controller();
    await c.hintWithAd();
    await c.place(c.state.hint!);
    await c.settled;
    expect(c.state.hint, isNull);
    expect(c.state.hintUsed, isTrue);
    expect(c.state.canHint, isTrue);

    expect(await c.hintWithAd(), HintOutcome.shown);
    expect(ads.shown, hasLength(2));
  });

  test('hints solve the level, and cost one star however many were used',
      () async {
    final (c, ads, _) = await _controller();
    await _solveWithHints(c);
    expect(c.state.solved, isTrue);
    expect(ads.shown.length, greaterThan(1));
    expect(c.state.stars, 2);
  });

  test('a closed video gives no hint and costs no star', () async {
    final (c, _, analytics) = await _controller(grants: false);
    expect(await c.hintWithAd(), HintOutcome.notEarned);
    expect(c.state.hint, isNull);
    expect(c.state.hintUsed, isFalse);
    expect(
      analytics.paramsFor(AnalyticsEvent.rewardedWatched).single['earned'],
      isFalse,
    );
  });

  test('without a loaded video nothing is shown, and the tap still counts',
      () async {
    final (c, ads, analytics) = await _controller(ready: false);
    expect(await c.hintWithAd(), HintOutcome.notEarned);
    expect(ads.shown, isEmpty);
    expect(c.state.hintUsed, isFalse);
    final accepted =
        analytics.paramsFor(AnalyticsEvent.rewardedAccepted).single;
    expect(accepted['placement'], 'puzzle_hint');
    expect(accepted['ad_available'], isFalse);
  });

  test('with no way left to empty the board, no video is offered', () async {
    final (c, ads, analytics) = await _controller();
    // A first move outside every hole that provably loses the level.
    final piece = c.state.currentPiece!;
    final solution = PuzzleGenerator.generate(3).solution;
    Cell? wrong;
    for (var r = Board.size - piece.height; r >= 0 && wrong == null; r--) {
      for (var col = 0; col <= Board.size - piece.width; col++) {
        final spot = Cell(r, col);
        if (c.state.board.canPlace(piece, spot) && !solution.contains(spot)) {
          final next = c.state.board.place(piece, spot).board;
          final rest = PuzzleGenerator.generate(3).pieces.sublist(1);
          final proof = PuzzleSolver.canEmpty(next, rest, budget: 300000);
          if (!proof.budgetExceeded && proof.moves == null) {
            wrong = spot;
            break;
          }
        }
      }
    }
    expect(wrong, isNotNull, reason: 'the level needs a losing move');
    await c.place(wrong!);
    // Asked before the stuck check has run: the hint search alone must say
    // no.
    expect(c.findHint(), isNull);
    expect(await c.hintWithAd(), HintOutcome.none);
    expect(ads.shown, isEmpty);
    expect(analytics.paramsFor(AnalyticsEvent.rewardedAccepted), isEmpty);
    await c.settled;
  });

  test('a restart takes the hint and its star cost off the new attempt',
      () async {
    final (c, _, _) = await _controller();
    await c.hintWithAd();
    c.restart();
    expect(c.state.hint, isNull);
    expect(c.state.hintUsed, isFalse);
  });

  test('the hint offer is reported once per attempt and loads its video',
      () async {
    final (c, ads, analytics) = await _controller();
    c
      ..noteRewardedOffered(AdPlacement.puzzleHint)
      ..noteRewardedOffered(AdPlacement.puzzleHint)
      ..noteRewardedOffered(AdPlacement.puzzleExtraMove);
    expect(
      analytics
          .paramsFor(AnalyticsEvent.rewardedOffered)
          .map((p) => p['placement']),
      ['puzzle_hint', 'puzzle_extra_move'],
    );
    expect(ads.prepared, contains(AdPlacement.puzzleHint));
  });

  test('the hint is looked for once per piece', () async {
    final (c, _, _) = await _controller();
    final first = c.findHint();
    expect(first, isNotNull);
    expect(c.findHint(), same(first), reason: 'cached until the next move');
  });
}
