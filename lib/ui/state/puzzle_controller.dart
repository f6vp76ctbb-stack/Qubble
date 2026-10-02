/// Riverpod controller for a single puzzle level: placement, win/fail, stars,
/// coin reward, restart, the one-shot "extra move" undo and the hint.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/board.dart';
import '../../game/piece.dart';
import '../../game/puzzle.dart';
import '../../monetization/ads.dart';
import '../../services/analytics.dart';
import '../../services/crash_reporter.dart';
import '../../services/storage.dart';
import 'game_controller.dart';

@immutable
class PuzzleState {
  const PuzzleState({
    required this.level,
    required this.board,
    required this.pieces,
    required this.pieceIndex,
    required this.moves,
    required this.minMoves,
    required this.solved,
    required this.failed,
    required this.stars,
    required this.coinsAwarded,
    required this.extraMoveUsed,
    this.hint,
    this.hintUsed = false,
  });

  final int level;
  final Board board;
  final List<Piece> pieces;
  final int pieceIndex;
  final int moves;
  final int minMoves;
  final bool solved;
  final bool failed;
  final int stars;
  final int coinsAwarded;
  final bool extraMoveUsed;

  /// Where the current piece goes, after the player watched a hint video;
  /// gone once the piece is placed.
  final Cell? hint;

  /// Whether a hint was used in this attempt: it costs a star.
  final bool hintUsed;

  Piece? get currentPiece =>
      pieceIndex < pieces.length ? pieces[pieceIndex] : null;

  bool get canExtraMove => failed && !extraMoveUsed;

  /// A hint can be asked for while the level is running and none is shown.
  bool get canHint =>
      !solved && !failed && currentPiece != null && hint == null;
}

typedef _Snapshot = ({Board board, int index, int moves, Cell origin});

/// What came of asking for a hint.
enum HintOutcome {
  /// The video ran to its reward; the hint is on the board.
  shown,

  /// No video, or the player closed it early.
  notEarned,

  /// There is no way to empty the board from here, so no video was offered.
  none,
}

final puzzleControllerProvider =
    StateNotifierProvider<PuzzleController, PuzzleState>((ref) {
      return PuzzleController(ref, ref.read(storageProvider));
    });

class PuzzleController extends StateNotifier<PuzzleState> {
  PuzzleController(this._ref, this._storage)
    : _puzzle = PuzzleGenerator.generate(0),
      super(_stateOf(PuzzleGenerator.generate(0)));

  final Ref _ref;
  final Storage _storage;
  final List<_Snapshot> _history = [];

  /// The level being played; its solution answers most hints.
  Puzzle _puzzle;

  /// The hint found for a piece index, so the tap that finds it and the
  /// video that pays for it do not search twice.
  ({int index, Cell? hint})? _hintCache;

  /// The deferred stuck-check for the most recent placement.
  ///
  /// [place] returns as soon as the move is on screen and finishes the
  /// (potentially tens-of-milliseconds) search afterwards. Await this to
  /// observe the final solved/failed verdict. In a widget test the deferral
  /// is a timer, so pump once before awaiting it.
  @visibleForTesting
  Future<void> get settled => _pendingCheck ?? Future<void>.value();

  Future<void>? _pendingCheck;

  static PuzzleState _stateOf(Puzzle puzzle) {
    return PuzzleState(
      level: puzzle.level,
      board: puzzle.start,
      pieces: puzzle.pieces,
      pieceIndex: 0,
      moves: 0,
      minMoves: puzzle.minMoves,
      solved: false,
      failed: false,
      stars: 0,
      coinsAwarded: 0,
      extraMoveUsed: false,
    );
  }

  void loadLevel(int level) {
    _attempts = 1;
    _ref.read(crashReporterProvider)
      ..setKey(CrashKey.mode, 'puzzle')
      ..setKey(CrashKey.puzzleLevel, level);
    _restartLevel(PuzzleGenerator.generate(level));
  }

  void restart() {
    _attempts += 1;
    _restartLevel(_puzzle);
  }

  void _restartLevel(Puzzle puzzle) {
    _offersReported.clear();
    _history.clear();
    _hintCache = null;
    _puzzle = puzzle;
    state = _stateOf(puzzle);
  }

  bool canPlace(Cell origin) {
    final piece = state.currentPiece;
    if (piece == null || state.solved || state.failed) return false;
    return state.board.canPlace(piece, origin);
  }

  Future<void> place(Cell origin) async {
    final piece = state.currentPiece;
    if (piece == null ||
        state.solved ||
        state.failed ||
        !state.board.canPlace(piece, origin)) {
      return;
    }

    _history.add((
      board: state.board,
      index: state.pieceIndex,
      moves: state.moves,
      origin: origin,
    ));
    final result = state.board.place(piece, origin);
    final board = result.board;
    final index = state.pieceIndex + 1;
    final moves = state.moves + 1;
    final solved = board.isEmpty;

    var stars = 0;
    var coins = 0;
    if (solved) {
      stars = PuzzleRules.stars(
        attempts: _attempts,
        usedExtraMove: state.extraMoveUsed,
        usedHint: state.hintUsed,
      );
      coins = await _recordWin(state.level, stars);
    }

    // Show the move first. The stuck-check below is a bounded search that can
    // still take tens of milliseconds; running it before this emit meant the
    // board did not update until it finished, so every placement in the
    // puzzle mode stuttered.
    state = PuzzleState(
      level: state.level,
      board: board,
      pieces: state.pieces,
      pieceIndex: index,
      moves: moves,
      minMoves: state.minMoves,
      solved: solved,
      failed: false,
      stars: stars,
      coinsAwarded: coins,
      extraMoveUsed: state.extraMoveUsed,
      hintUsed: state.hintUsed,
    );
    if (solved) return;

    // Let the frame carrying the placement render before the search runs.
    // Not awaited here: place() must return once the move is visible, or the
    // caller is blocked on exactly the work being deferred.
    _pendingCheck = _runStuckCheck(board, index, moves);
  }

  /// Decides, off the placement frame, whether the level is now unwinnable.
  Future<void> _runStuckCheck(Board board, int index, int moves) async {
    await Future<void>.delayed(Duration.zero);
    if (!mounted) return;
    // Another placement (or a restart) landed while we yielded — its own
    // check owns the outcome.
    if (state.pieceIndex != index || state.solved || state.failed) return;

    // The level is failed the moment it can no longer be emptied with the
    // remaining pieces — not merely when the current piece does not fit.
    // Only "can this still be emptied?" matters; the minimum move count is
    // fixed at generation time. The search is bounded, and an exhausted
    // budget means "unproven", so the player keeps playing rather than
    // being failed on a guess.
    final solveResult = PuzzleSolver.canEmpty(
      board,
      state.pieces.sublist(index),
    );
    final failed = !solveResult.budgetExceeded && solveResult.moves == null;
    if (!failed) return;

    state = PuzzleState(
      level: state.level,
      board: board,
      pieces: state.pieces,
      pieceIndex: index,
      moves: moves,
      minMoves: state.minMoves,
      solved: false,
      failed: true,
      stars: 0,
      coinsAwarded: 0,
      extraMoveUsed: state.extraMoveUsed,
      hintUsed: state.hintUsed,
    );
  }

  /// Undoes the last placement (used by the rewarded "extra move"). Once/level.
  /// How many times this level has been started, restarts included. Feeds the
  /// star rating, so it resets with the level and survives a restart.
  int _attempts = 1;

  /// The offers already reported for this attempt. The screen rebuilds, and
  /// a rebuild must not inflate the denominator.
  final Set<AdPlacement> _offersReported = {};

  /// Reports that [placement] is on screen. Idempotent for the current
  /// attempt.
  void noteRewardedOffered(AdPlacement placement) {
    _ref.read(adServiceProvider).prepare(placement);
    if (!_offersReported.add(placement)) return;
    _ref.read(analyticsProvider).logEvent(
      AnalyticsEvent.rewardedOffered,
      {'placement': placement.analyticsName},
    );
  }

  /// Offers the one-shot extra move in exchange for a rewarded video.
  ///
  /// The ad call lives here rather than in the screen so the placement is
  /// reported from the same place as every other rewarded placement — the
  /// screen used to call [AdService.showRewarded] directly, which left this
  /// one placement out of the funnel entirely.
  ///
  /// Returns true when the reward was earned and the move was granted.
  /// Whether a rewarded video could be shown right now, so the offer can say
  /// "no video available" instead of doing nothing. Same service, same rule as
  /// in endless mode.
  bool get rewardedAvailable => _ref
      .read(adServiceProvider)
      .rewardedReadyFor(AdPlacement.puzzleExtraMove);

  /// Whether the hint's video could be shown right now.
  bool get hintAdAvailable =>
      _ref.read(adServiceProvider).rewardedReadyFor(AdPlacement.puzzleHint);

  /// Where the current piece goes so the board can still be emptied, or
  /// null when it cannot ([PuzzleHint.next]). Free to call: the answer is
  /// kept until the next move.
  Cell? findHint() {
    final cached = _hintCache;
    if (cached != null && cached.index == state.pieceIndex) return cached.hint;
    final hint = PuzzleHint.next(_puzzle, [
      for (final step in _history) step.origin,
    ], state.board);
    _hintCache = (index: state.pieceIndex, hint: hint);
    return hint;
  }

  /// The rewarded hint (owner decision 02.10.2026): after the video, the
  /// board shows where the current piece goes. Any number per level; using
  /// one costs a star ([PuzzleRules.stars]).
  ///
  /// The hint is looked for before the video: when the board cannot be
  /// emptied any more there is nothing to reward, so no video is offered
  /// ([HintOutcome.none]) — a video must always pay what it promised.
  Future<HintOutcome> hintWithAd() async {
    if (!state.canHint) return HintOutcome.notEarned;
    final index = state.pieceIndex;
    final hint = findHint();
    if (hint == null) return HintOutcome.none;

    final analytics = _ref.read(analyticsProvider);
    final placement = {'placement': AdPlacement.puzzleHint.analyticsName};
    final ads = _ref.read(adServiceProvider);
    final available = ads.rewardedReadyFor(AdPlacement.puzzleHint);
    analytics.logEvent(AnalyticsEvent.rewardedAccepted, {
      ...placement,
      'ad_available': available,
    });
    if (!available) return HintOutcome.notEarned;
    final earned = await ads.showRewarded(AdPlacement.puzzleHint);
    analytics.logEvent(AnalyticsEvent.rewardedWatched, {
      ...placement,
      'earned': earned,
    });
    if (!earned || !mounted) return HintOutcome.notEarned;
    // The video paid for this piece's hint; nothing can move meanwhile, but
    // a level that changed under it gets no stale cells.
    if (state.pieceIndex != index || !state.canHint) {
      return HintOutcome.notEarned;
    }
    state = PuzzleState(
      level: state.level,
      board: state.board,
      pieces: state.pieces,
      pieceIndex: state.pieceIndex,
      moves: state.moves,
      minMoves: state.minMoves,
      solved: state.solved,
      failed: state.failed,
      stars: state.stars,
      coinsAwarded: state.coinsAwarded,
      extraMoveUsed: state.extraMoveUsed,
      hint: hint,
      hintUsed: true,
    );
    return HintOutcome.shown;
  }

  Future<bool> extraMoveWithAd() async {
    if (!state.canExtraMove) return false;
    final analytics = _ref.read(analyticsProvider);
    final placement = {'placement': AdPlacement.puzzleExtraMove.analyticsName};

    // Same rule as the endless controller: a tap with no ad to show is still
    // an acceptance, and hiding it would understate the opt-in rate.
    final ads = _ref.read(adServiceProvider);
    final available = ads.rewardedReadyFor(AdPlacement.puzzleExtraMove);
    analytics.logEvent(AnalyticsEvent.rewardedAccepted, {
      ...placement,
      'ad_available': available,
    });
    if (!available) return false;
    final earned = await ads.showRewarded(AdPlacement.puzzleExtraMove);
    analytics.logEvent(AnalyticsEvent.rewardedWatched, {
      ...placement,
      'earned': earned,
    });
    if (!earned) return false;
    applyExtraMove();
    return true;
  }

  void applyExtraMove() {
    if (!state.canExtraMove || _history.isEmpty) return;
    final prev = _history.removeLast();
    state = PuzzleState(
      level: state.level,
      board: prev.board,
      pieces: state.pieces,
      pieceIndex: prev.index,
      moves: prev.moves,
      minMoves: state.minMoves,
      solved: false,
      failed: false,
      stars: 0,
      coinsAwarded: 0,
      extraMoveUsed: true,
      hintUsed: state.hintUsed,
    );
  }

  /// Persists best stars and grants coins only on the first solve of a level.
  Future<int> _recordWin(int level, int stars) async {
    final all = _storage.puzzleStars;
    final firstSolve = !all.containsKey(level);
    final best = all[level] ?? 0;
    if (stars > best) {
      all[level] = stars;
      await _storage.setPuzzleStars(all);
      // More stars: the puzzle ranking hears of it (silently, when a name
      // is set and the network is there).
      _ref.read(gameControllerProvider.notifier).autoUploadBestScore();
    }
    if (firstSolve) {
      final coins = PuzzleRules.coinReward(level);
      final game = _ref.read(gameControllerProvider.notifier);
      await game.grantCoins(coins);
      // Quests pay on their own (balance, not this level's reward line).
      await game.recordPuzzleForQuests();
      return coins;
    }
    return 0;
  }
}
