/// Pure-Dart mission system for GridPop. No Flutter imports.
///
/// Missions are cumulative "career" goals that reward coins, driving the coin
/// economy (MASTERPLAN.md §4). Progress is a plain id->value map so it can be
/// persisted as JSON without extra machinery.
library;

import 'dart:math' as math;

import 'game_session.dart';

enum MissionMetric {
  piecesPlaced,
  linesCleared,
  maxComboReached,
  scoreReached,
  gamesPlayed,
}

class Mission {
  const Mission({
    required this.id,
    required this.metric,
    required this.target,
    required this.reward,
  });

  /// Stable key. Also the lookup key for the localized description — see
  /// `missionDescription` in the UI layer.
  final String id;
  final MissionMetric metric;
  final int target;
  final int reward;
}

/// A mission plus the player's current progress toward it.
class MissionView {
  const MissionView({required this.mission, required this.progress});

  final Mission mission;
  final int progress;

  bool get completed => progress >= mission.target;
  double get fraction =>
      mission.target == 0 ? 1.0 : (progress / mission.target).clamp(0.0, 1.0);
}

/// Escalating targets per metric.
///
/// The old set was five fixed goals. BALANCE.md measured what that produced:
/// every one of them is permanently done after roughly ten runs, after which
/// the missions screen is a wall of ticks that never changes again — a whole
/// retention system switched off for anyone who keeps playing.
///
/// Tiers fix that without inventing new content: when a goal is met, the next
/// one for that metric takes its place. Progress is kept per METRIC rather
/// than per mission id, so it carries across tiers instead of restarting.
const Map<MissionMetric, List<int>> kMissionTiers = {
  MissionMetric.piecesPlaced: [100, 300, 750, 1500, 3000, 6000],
  MissionMetric.linesCleared: [50, 150, 400, 800, 1600, 3200],
  // Combo and score are high-water marks, not sums, so their tiers climb far
  // more slowly — a 20x combo is a genuine achievement, 3000 placements is a
  // fortnight of play.
  MissionMetric.maxComboReached: [5, 8, 12, 16, 20, 25],
  MissionMetric.scoreReached: [1000, 5000, 15000, 40000, 100000, 250000],
  MissionMetric.gamesPlayed: [10, 30, 75, 150, 300, 600],
};

/// Coins for completing tier [index] of any metric.
///
/// Flat within a tier across metrics: the point is that later goals are worth
/// more than earlier ones, not that one metric outpays another.
int missionReward(int index) => 30 + index * 20;

/// The mission a player on [progress] is currently working toward for
/// [metric], or null once every tier is done.
Mission? missionFor(MissionMetric metric, int progress) {
  final targets = kMissionTiers[metric]!;
  for (var i = 0; i < targets.length; i++) {
    if (progress < targets[i]) {
      return Mission(
        id: '${metric.name}_${targets[i]}',
        metric: metric,
        target: targets[i],
        reward: missionReward(i),
      );
    }
  }
  return null;
}

/// Old per-mission-id keys mapped to the metric they tracked.
///
/// Without this an existing player's progress would read as zero and every
/// tier-one goal would be handed back to them, rewards included.
const Map<String, MissionMetric> kLegacyMissionIds = {
  'place_100': MissionMetric.piecesPlaced,
  'clear_50': MissionMetric.linesCleared,
  'combo_5': MissionMetric.maxComboReached,
  'score_1000': MissionMetric.scoreReached,
  'games_10': MissionMetric.gamesPlayed,
};

/// Rewrites a stored map that may still use the old ids into metric keys.
Map<String, int> migrateMissionProgress(Map<String, int> stored) {
  final out = <String, int>{};
  stored.forEach((key, value) {
    final metric = kLegacyMissionIds[key];
    final k = metric?.name ?? key;
    // Take the larger if both forms are present, so a partial migration never
    // moves a player backwards.
    out[k] = value > (out[k] ?? 0) ? value : out[k]!;
  });
  return out;
}

class MissionEngine {
  /// [progress] is keyed by metric name. Legacy per-mission-id keys are
  /// migrated on the way in, so an existing player keeps what they earned.
  MissionEngine({Map<String, int>? progress})
      : _progress = migrateMissionProgress({...?progress});

  final Map<String, int> _progress;

  Map<String, int> get progress => Map.unmodifiable(_progress);

  int progressOf(MissionMetric metric) => _progress[metric.name] ?? 0;

  /// Drops all recorded progress (used by a full progress reset).
  void reset() => _progress.clear();

  /// The missions currently on offer: the lowest unmet tier per metric.
  ///
  /// A metric whose tiers are exhausted disappears rather than showing a
  /// permanently ticked row, which is what made the old screen feel finished.
  List<MissionView> get views => [
        for (final metric in MissionMetric.values)
          if (missionFor(metric, progressOf(metric)) case final m?)
            MissionView(mission: m, progress: progressOf(metric)),
      ];

  /// Whether every tier of every metric is done.
  bool get allComplete => views.isEmpty;

  int _apply(MissionMetric metric, int current, GameStats s) {
    switch (metric) {
      case MissionMetric.piecesPlaced:
        return current + s.piecesPlaced;
      case MissionMetric.linesCleared:
        return current + s.linesCleared;
      case MissionMetric.gamesPlayed:
        return current + 1;
      case MissionMetric.maxComboReached:
        return math.max(current, s.maxCombo);
      case MissionMetric.scoreReached:
        return math.max(current, s.score);
    }
  }

  /// Folds a finished run's [stats] into progress and returns every mission
  /// completed by it, for the coin reward.
  ///
  /// A single run can cross more than one tier -- a first run of 400 lines
  /// clears two at once -- so this walks the tiers rather than checking only
  /// the one that was on offer beforehand. Paying for just one would quietly
  /// swallow the other.
  List<Mission> recordGame(GameStats stats) {
    final newlyCompleted = <Mission>[];
    for (final metric in MissionMetric.values) {
      final before = progressOf(metric);
      final after = _apply(metric, before, stats);
      _progress[metric.name] = after;

      for (final target in kMissionTiers[metric]!) {
        if (before < target && after >= target) {
          final m = missionFor(metric, target - 1);
          if (m != null) newlyCompleted.add(m);
        }
      }
    }
    return newlyCompleted;
  }
}
