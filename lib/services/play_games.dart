/// Google Play Games Services (owner decision 02.10.2026): Qubble's
/// achievements and best score also show in the player's Play Games profile.
///
/// Android only. The SDK signs the player in by itself when the app starts
/// (`QubbleApplication`); this side only sends what the player has earned.
/// The web build, iOS (Game Center comes with the App Store, MASTERPLAN C.9)
/// and tests get [NoopPlayGames]. Nothing here ever blocks a run: without
/// Play Games, without a network or without the ids below the game is the
/// same.
library;

import 'dart:async';

import 'package:games_services/games_services.dart' as gs;

import '../game/achievements.dart';
import 'storage.dart';

/// The ids Play Console gave the leaderboards and achievements (its "Get
/// resources" XML). Until an id is here, nothing is sent for it.
class PlayGamesIds {
  const PlayGamesIds({
    this.bestScore,
    this.dailyStreak,
    this.achievements = const {},
  });

  /// Leaderboard of the endless best score.
  final String? bestScore;

  /// Leaderboard of the daily streak; Play Games keeps each player's longest.
  final String? dailyStreak;

  /// Qubble achievement id (`lib/game/achievements.dart`) → Play Games id.
  final Map<String, String> achievements;
}

/// Not created in Play Console yet (02.10.2026).
const kPlayGamesIds = PlayGamesIds();

/// Achievements set up as *incremental* in Play Console, with the
/// achievement's threshold as its steps: Play Games then shows a progress
/// bar, which Google recommends for anything that builds up over many
/// sessions. Best-of values (score, combo, streak) stay standard — the streak
/// can drop, and Play Games never takes progress back.
/// `tool/play_games_import.py` writes the Console import from the same split;
/// a test keeps the two in step.
const kPlayGamesIncremental = {
  'games_25',
  'games_100',
  'lines_100',
  'lines_1000',
  'level_10',
  'level_20',
  'puzzles_10',
  'pieces_5000',
};

abstract class PlayGamesService {
  /// The signed-in player's id, or null when nobody is signed in.
  Future<String?> playerId();

  /// Unlocks the achievement with Play Games id [id]. True once Play Games
  /// has it.
  Future<bool> unlock(String id);

  /// Raises the incremental achievement with Play Games id [id] to at least
  /// [steps]; reaching its total unlocks it. True once Play Games has it.
  Future<bool> setSteps(String id, int steps);

  /// Sends [score] to the leaderboard with Play Games id [id]. True once Play
  /// Games has it.
  Future<bool> submitScore(String id, int score);
}

/// Web, iOS and tests: nobody is ever signed in.
class NoopPlayGames implements PlayGamesService {
  const NoopPlayGames();

  @override
  Future<String?> playerId() async => null;

  @override
  Future<bool> unlock(String id) async => false;

  @override
  Future<bool> setSteps(String id, int steps) async => false;

  @override
  Future<bool> submitScore(String id, int score) async => false;
}

/// Play Games Services v2 through the `games_services` plugin.
class GooglePlayGames implements PlayGamesService {
  const GooglePlayGames();

  @override
  Future<String?> playerId() async {
    try {
      // The plugin answers once the start-up sign-in has settled. A device
      // without Play services could leave it unanswered; the timeout keeps
      // that from holding a sync open forever.
      final player = await gs.GameAuth.player.first.timeout(
        const Duration(seconds: 30),
      );
      return player?.playerID;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> unlock(String id) async {
    try {
      await gs.Achievements.unlock(achievement: gs.Achievement(androidID: id));
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> setSteps(String id, int steps) async {
    try {
      await gs.Achievements.setSteps(
        achievement: gs.Achievement(androidID: id, steps: steps),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> submitScore(String id, int score) async {
    try {
      await gs.Leaderboards.submitScore(
        score: gs.Score(androidLeaderboardID: id, value: score),
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

/// Brings Play Games up to the local save: unlocked achievements, the best
/// score and the daily streak. Remembers per player what already arrived, so
/// a sync after a run only sends what is new — and a player who earned
/// achievements before Play Games existed gets them on the first sync.
class PlayGamesSync {
  PlayGamesSync(this._games, this._storage, {this.ids = kPlayGamesIds});

  final PlayGamesService _games;
  final Storage _storage;
  final PlayGamesIds ids;

  Future<void> _last = Future.value();

  /// Runs one sync after any still running. Never throws.
  ///
  /// [runScore] is the endless run that just ended: every run is sent, so the
  /// leaderboard's daily and weekly views count it too, not only a new best.
  Future<void> sync({int? runScore}) =>
      _last = _last.then((_) => _run(runScore)).catchError((_) {});

  Future<void> _run(int? runScore) async {
    if (ids.bestScore == null &&
        ids.dailyStreak == null &&
        ids.achievements.isEmpty) {
      return;
    }
    final player = await _games.playerId();
    if (player == null) return;
    if (_storage.playGamesPlayer != player) {
      // Another Play Games account on this device: what reached the old one
      // says nothing about the new one.
      await _storage.resetPlayGamesSent(player);
    }

    final progress = _storage.achievementProgress;
    final unlocked = _storage.unlockedAchievements;
    final sent = _storage.playGamesAchievementsSent;
    final steps = _storage.playGamesStepsSent;
    final arrived = <String>{};
    final stepsArrived = <String, int>{};
    for (final a in Achievements.catalog) {
      final remote = ids.achievements[a.id];
      if (remote == null) continue;
      if (kPlayGamesIncremental.contains(a.id)) {
        // Progress so far, capped at the total; a level starts at 1, so
        // every value above 0 is progress worth showing.
        final value = progress.value(a.metric).clamp(0, a.threshold);
        if (value > (steps[a.id] ?? 0) &&
            await _games.setSteps(remote, value)) {
          stepsArrived[a.id] = value;
        }
      } else if (unlocked.contains(a.id) && !sent.contains(a.id)) {
        if (await _games.unlock(remote)) arrived.add(a.id);
      }
    }
    if (arrived.isNotEmpty) {
      await _storage.setPlayGamesAchievementsSent({...sent, ...arrived});
    }
    if (stepsArrived.isNotEmpty) {
      await _storage.setPlayGamesStepsSent({...steps, ...stepsArrived});
    }

    final bestBoard = ids.bestScore;
    if (bestBoard != null) {
      final best = _storage.highscore;
      if (runScore != null && runScore > 0 && runScore < best) {
        await _games.submitScore(bestBoard, runScore);
      }
      // A new best goes here, and so does one an offline run could not send.
      if (best > _storage.playGamesBestScoreSent &&
          await _games.submitScore(bestBoard, best)) {
        await _storage.setPlayGamesBestScoreSent(best);
      }
    }

    final streak = _storage.streak;
    final streakBoard = ids.dailyStreak;
    if (streakBoard != null &&
        streak > 0 &&
        streak != _storage.playGamesStreakSent &&
        await _games.submitScore(streakBoard, streak)) {
      await _storage.setPlayGamesStreakSent(streak);
    }
  }
}
