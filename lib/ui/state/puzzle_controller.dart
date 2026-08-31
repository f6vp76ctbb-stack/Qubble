/// Riverpod controller for a single puzzle level: placement, win/fail, stars,
/// coin reward, restart and the one-shot "extra move" undo.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/board.dart';
import '../../game/piece.dart';
import '../../game/puzzle.dart';
import '../../services/analytics.dart';
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

  Piece? get currentPiece =>
      pieceIndex < pieces.length ? pieces[pieceIndex] : null;

  bool get canExtraMove => failed && !extraMoveUsed;
}

typedef _Snapshot = ({Board board, int index, int moves});

final puzzleControllerProvider =
    StateNotifierProvider<PuzzleController, PuzzleState>((ref) {
      return PuzzleController(ref, ref.read(storageProvider));
    });

class PuzzleController extends StateNotifier<PuzzleState> {
  PuzzleController(this._ref, this._storage) : super(_load(0));

  final Ref _ref;
  final Storage _storage;
  final List<_Snapshot> _history = [];

  /// The deferred stuck-check for the most recent placement.
  ///
  /// [place] returns as soon as the move is on screen and finishes the
  /// (potentially tens-of-milliseconds) search afterwards. Await this to
  /// observe the final solved/failed verdict. In a widget test the deferral
  /// is a timer, so pump once before awaiting it.
  @visibleForTesting
  Future<void> get settled => _pendingCheck ?? Future<void>.value();

  Future<void>? _pendingCheck;

  static PuzzleState _load(int level) {
    final puzzle = PuzzleGenerator.generate(level);
    return PuzzleState(
      level: level,
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
    _history.clear();
    state = _load(level);
  }

  void restart() {
    _history.clear();
    state = _load(state.level);
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
    ));
    final result = state.board.place(piece, origin);
    final board = result.board;
    final index = state.pieceIndex + 1;
    final moves = state.moves + 1;
    final solved = board.isEmpty;

    var stars = 0;
    var coins = 0;
    if (solved) {
      stars = PuzzleRules.stars(moves: moves, minMoves: state.minMoves);
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
    );
  }

  /// Undoes the last placement (used by the rewarded "extra move"). Once/level.
  /// Offers the one-shot extra move in exchange for a rewarded video.
  ///
  /// The ad call lives here rather than in the screen so the placement is
  /// reported from the same place as every other rewarded placement — the
  /// screen used to call [AdService.showRewarded] directly, which left this
  /// one placement out of the funnel entirely.
  ///
  /// Returns true when the reward was earned and the move was granted.
  Future<bool> extraMoveWithAd() async {
    if (!state.canExtraMove) return false;
    final earned = await _ref.read(adServiceProvider).showRewarded();
    if (!earned) return false;
    _ref.read(analyticsProvider).logEvent(
      AnalyticsEvent.rewardedWatched,
      const {'placement': 'puzzle_extra_move'},
    );
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
    }
    if (firstSolve) {
      final coins = PuzzleRules.coinReward(level);
      await _ref.read(gameControllerProvider.notifier).grantCoins(coins);
      return coins;
    }
    return 0;
  }
}
