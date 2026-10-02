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

abstract class PlayGamesService {
  /// The signed-in player's id, or null when nobody is signed in.
  Future<String?> playerId();

  /// Unlocks the achievement with Play Games id [id]. True once Play Games
  /// has it.
  Future<bool> unlock(String id);

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

    final sent = _storage.playGamesAchievementsSent;
    final arrived = <String>{};
    for (final id in _storage.unlockedAchievements) {
      final remote = ids.achievements[id];
      if (remote == null || sent.contains(id)) continue;
      if (await _games.unlock(remote)) arrived.add(id);
    }
    if (arrived.isNotEmpty) {
      await _storage.setPlayGamesAchievementsSent({...sent, ...arrived});
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
