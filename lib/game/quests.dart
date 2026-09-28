/// Pure-Dart quests: daily, weekly and monthly goals. No Flutter imports.
///
/// Replaces the career missions (owner, 28.09.2026). Every period draws a
/// fixed number of quests from its pool — 3 a day, 5 a week, 5 a month —
/// seeded by the period, so every player sees the same set and a restart
/// cannot reroll it. Each quest pays coins when done; finishing all quests
/// of a period pays a diamond bonus. The weekly and monthly sets always ask
/// for play on several different days: the point of the system is a reason to
/// come back tomorrow, not a longer session today.
///
/// Periods follow the player's local calendar: a day ends at midnight, a
/// week on Sunday night, a month on its last night.
library;

import 'dart:math' as math;

enum QuestPeriod { daily, weekly, monthly }

enum QuestMetric {
  /// Rounds finished (endless or daily challenge).
  rounds,

  /// Lines cleared, summed over rounds.
  lines,

  /// Pieces placed, summed over rounds.
  pieces,

  /// Best combo in a single round.
  combo,

  /// Best score in a single round.
  score,

  /// Daily challenges completed (the counted attempt of each day).
  dailyChallenge,

  /// Puzzle levels solved for the first time.
  puzzles,

  /// Different days with any play.
  days,

  /// Days on which every daily quest was done.
  dailySets,
}

class Quest {
  const Quest(this.period, this.metric, this.target, this.coins);

  final QuestPeriod period;
  final QuestMetric metric;
  final int target;
  final int coins;

  /// Stable key, unique across periods.
  String get id => '${period.name}.${metric.name}';

  @override
  bool operator ==(Object other) =>
      other is Quest &&
      other.period == period &&
      other.metric == metric &&
      other.target == target &&
      other.coins == coins;

  @override
  int get hashCode => Object.hash(period, metric, target, coins);

  @override
  String toString() => 'Quest($id, $target, $coins)';
}

/// How many quests a period draws.
const Map<QuestPeriod, int> kQuestCount = {
  QuestPeriod.daily: 3,
  QuestPeriod.weekly: 5,
  QuestPeriod.monthly: 5,
};

/// Diamonds for finishing every quest of a period (owner, 28.09.2026).
const Map<QuestPeriod, int> kQuestBonusDiamonds = {
  QuestPeriod.daily: 5,
  QuestPeriod.weekly: 20,
  QuestPeriod.monthly: 60,
};

/// Drawn every time, ahead of the random ones.
const Map<QuestPeriod, List<QuestMetric>> _kFixed = {
  QuestPeriod.daily: [],
  QuestPeriod.weekly: [QuestMetric.days],
  QuestPeriod.monthly: [QuestMetric.days],
};

/// The pools. Targets are set against the measured round (BALANCE.md: about
/// 15 lines, 42 pieces, a best combo near 8 and a median score near 3,000),
/// so a day's set takes a few rounds, not an evening. Coins stay below what
/// the rounds themselves pay (100–200 each): quests steer play, they do not
/// replace it.
const Map<QuestPeriod, List<Quest>> kQuestPools = {
  QuestPeriod.daily: [
    Quest(QuestPeriod.daily, QuestMetric.rounds, 3, 30),
    Quest(QuestPeriod.daily, QuestMetric.lines, 25, 40),
    Quest(QuestPeriod.daily, QuestMetric.pieces, 80, 30),
    Quest(QuestPeriod.daily, QuestMetric.combo, 4, 50),
    Quest(QuestPeriod.daily, QuestMetric.score, 2000, 50),
    Quest(QuestPeriod.daily, QuestMetric.dailyChallenge, 1, 50),
    Quest(QuestPeriod.daily, QuestMetric.puzzles, 2, 40),
  ],
  QuestPeriod.weekly: [
    Quest(QuestPeriod.weekly, QuestMetric.days, 4, 200),
    Quest(QuestPeriod.weekly, QuestMetric.rounds, 15, 120),
    Quest(QuestPeriod.weekly, QuestMetric.lines, 150, 150),
    Quest(QuestPeriod.weekly, QuestMetric.pieces, 400, 120),
    Quest(QuestPeriod.weekly, QuestMetric.combo, 8, 200),
    Quest(QuestPeriod.weekly, QuestMetric.score, 5000, 200),
    Quest(QuestPeriod.weekly, QuestMetric.dailyChallenge, 4, 150),
    Quest(QuestPeriod.weekly, QuestMetric.puzzles, 8, 150),
    Quest(QuestPeriod.weekly, QuestMetric.dailySets, 3, 200),
  ],
  QuestPeriod.monthly: [
    Quest(QuestPeriod.monthly, QuestMetric.days, 15, 500),
    Quest(QuestPeriod.monthly, QuestMetric.rounds, 60, 300),
    Quest(QuestPeriod.monthly, QuestMetric.lines, 600, 400),
    Quest(QuestPeriod.monthly, QuestMetric.pieces, 1500, 300),
    Quest(QuestPeriod.monthly, QuestMetric.combo, 12, 500),
    Quest(QuestPeriod.monthly, QuestMetric.score, 10000, 500),
    Quest(QuestPeriod.monthly, QuestMetric.dailyChallenge, 12, 500),
    Quest(QuestPeriod.monthly, QuestMetric.puzzles, 25, 400),
    Quest(QuestPeriod.monthly, QuestMetric.dailySets, 10, 500),
  ],
};

String _two(int v) => v.toString().padLeft(2, '0');

String _dayKey(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

/// The period [now] falls in, as a stable key: the date, the date of the
/// week's Monday, or the month.
String questPeriodKey(QuestPeriod period, DateTime now) => switch (period) {
      QuestPeriod.daily => _dayKey(now),
      QuestPeriod.weekly =>
        _dayKey(DateTime(now.year, now.month, now.day - (now.weekday - 1))),
      QuestPeriod.monthly => '${now.year}-${_two(now.month)}',
    };

/// Time until the next set of [period] — local midnight, Monday 00:00, or
/// the first of next month.
Duration questsResetIn(QuestPeriod period, DateTime now) {
  final next = switch (period) {
    QuestPeriod.daily => DateTime(now.year, now.month, now.day + 1),
    QuestPeriod.weekly =>
      DateTime(now.year, now.month, now.day + 8 - now.weekday),
    QuestPeriod.monthly => DateTime(now.year, now.month + 1),
  };
  return next.difference(now);
}

/// FNV-1a over the key's code units: the same number on every platform,
/// which [String.hashCode] does not promise.
int _seed(QuestPeriod period, String key) {
  var h = 0x811c9dc5;
  for (final unit in '${period.name}:$key'.codeUnits) {
    h = ((h ^ unit) * 0x01000193) & 0x7fffffff;
  }
  return h;
}

/// The quests of [period] at [now]: the fixed ones, then a seeded draw from
/// the rest of the pool, in pool order so the list reads the same each time.
List<Quest> questsFor(QuestPeriod period, DateTime now) {
  final pool = kQuestPools[period]!;
  final fixed = _kFixed[period]!;
  final rest = [
    for (final q in pool)
      if (!fixed.contains(q.metric)) q,
  ]..shuffle(math.Random(_seed(period, questPeriodKey(period, now))));
  final picked = {
    for (final q in pool)
      if (fixed.contains(q.metric)) q,
    ...rest.take(kQuestCount[period]! - fixed.length),
  };
  return [
    for (final q in pool)
      if (picked.contains(q)) q,
  ];
}

/// One period's progress, as stored.
class QuestProgress {
  const QuestProgress({
    required this.key,
    this.values = const {},
    this.paid = const {},
    this.bonusPaid = false,
    this.lastDay,
  });

  /// Fresh progress for the period [now] falls in.
  factory QuestProgress.start(QuestPeriod period, DateTime now) =>
      QuestProgress(key: questPeriodKey(period, now));

  /// Reads what [toJson] wrote; anything malformed reads as a fresh start of
  /// an unknown period, which the next roll-over replaces.
  factory QuestProgress.fromJson(Object? json) {
    if (json is! Map) return const QuestProgress(key: '');
    final values = <String, int>{};
    final rawValues = json['values'];
    if (rawValues is Map) {
      rawValues.forEach((k, v) {
        if (k is String && v is num) values[k] = v.toInt();
      });
    }
    final rawPaid = json['paid'];
    return QuestProgress(
      key: json['key'] is String ? json['key'] as String : '',
      values: values,
      paid: {
        if (rawPaid is List)
          for (final p in rawPaid)
            if (p is String) p,
      },
      bonusPaid: json['bonusPaid'] == true,
      lastDay: json['lastDay'] is String ? json['lastDay'] as String : null,
    );
  }

  /// [questPeriodKey] of the period this progress belongs to.
  final String key;

  /// Metric name -> progress.
  final Map<String, int> values;

  /// Metric names of the quests already paid out.
  final Set<String> paid;

  /// Whether the all-quests diamond bonus was paid.
  final bool bonusPaid;

  /// The last day that counted towards [QuestMetric.days].
  final String? lastDay;

  int valueOf(QuestMetric metric) => values[metric.name] ?? 0;

  Map<String, Object?> toJson() => {
        'key': key,
        'values': values,
        'paid': paid.toList()..sort(),
        'bonusPaid': bonusPaid,
        if (lastDay != null) 'lastDay': lastDay,
      };
}

/// Something the player did that quests count.
class QuestActivity {
  const QuestActivity({
    this.rounds = 0,
    this.lines = 0,
    this.pieces = 0,
    this.combo = 0,
    this.score = 0,
    this.dailyChallenges = 0,
    this.puzzles = 0,
  });

  /// A finished round; [dailyChallenge] when it was the day's counted daily.
  factory QuestActivity.round({
    required int score,
    required int lines,
    required int pieces,
    required int combo,
    bool dailyChallenge = false,
  }) =>
      QuestActivity(
        rounds: 1,
        lines: lines,
        pieces: pieces,
        combo: combo,
        score: score,
        dailyChallenges: dailyChallenge ? 1 : 0,
      );

  /// A puzzle level solved for the first time.
  const QuestActivity.puzzle() : this(puzzles: 1);

  final int rounds;
  final int lines;
  final int pieces;
  final int combo;
  final int score;
  final int dailyChallenges;
  final int puzzles;
}

/// A quest and how far the player is.
class QuestView {
  const QuestView(this.quest, this.progress, {required this.paid});

  final Quest quest;
  final int progress;

  /// Done and paid out.
  final bool paid;

  bool get done => paid || progress >= quest.target;
  double get fraction => (progress / quest.target).clamp(0.0, 1.0);
}

/// What one [QuestBook.record] paid.
class QuestOutcome {
  const QuestOutcome({
    this.completed = const [],
    this.coins = 0,
    this.diamonds = 0,
    this.setsCompleted = const [],
  });

  final List<Quest> completed;
  final int coins;
  final int diamonds;

  /// Periods whose every quest is now done (the diamond bonus was paid).
  final List<QuestPeriod> setsCompleted;

  bool get isEmpty => completed.isEmpty && setsCompleted.isEmpty;
}

/// All three periods' progress, and the rules that move it.
class QuestBook {
  QuestBook([Map<QuestPeriod, QuestProgress>? state])
      : _state = {...?state};

  final Map<QuestPeriod, QuestProgress> _state;

  Map<QuestPeriod, QuestProgress> get state => Map.unmodifiable(_state);

  /// Drops all progress (a full progress reset).
  void reset() => _state.clear();

  /// [period]'s progress at [now]; a stored period that has ended reads as a
  /// fresh one.
  QuestProgress progressAt(QuestPeriod period, DateTime now) {
    final stored = _state[period];
    final key = questPeriodKey(period, now);
    return stored != null && stored.key == key
        ? stored
        : QuestProgress(key: key);
  }

  /// The quests of [period] at [now] with the player's progress.
  List<QuestView> views(QuestPeriod period, DateTime now) {
    final p = progressAt(period, now);
    return [
      for (final q in questsFor(period, now))
        QuestView(q, p.valueOf(q.metric), paid: p.paid.contains(q.metric.name)),
    ];
  }

  /// Whether every quest of [period] is done (its bonus paid).
  bool setDone(QuestPeriod period, DateTime now) =>
      progressAt(period, now).bonusPaid;

  /// Counts [activity] at [now] and pays what it completes: coins per quest,
  /// diamonds per finished set. Nothing is paid twice.
  ///
  /// The daily period goes first: finishing today's set is itself progress
  /// for the weekly and monthly [QuestMetric.dailySets] quests.
  QuestOutcome record(QuestActivity activity, DateTime now) {
    final today = _dayKey(now);
    final completed = <Quest>[];
    final sets = <QuestPeriod>[];
    var coins = 0;
    var diamonds = 0;
    var dailySetsDone = 0;

    for (final period in QuestPeriod.values) {
      final before = progressAt(period, now);
      final values = {...before.values};
      void add(QuestMetric m, int n) {
        if (n > 0) values[m.name] = (values[m.name] ?? 0) + n;
      }

      void best(QuestMetric m, int n) {
        if (n > (values[m.name] ?? 0)) values[m.name] = n;
      }

      add(QuestMetric.rounds, activity.rounds);
      add(QuestMetric.lines, activity.lines);
      add(QuestMetric.pieces, activity.pieces);
      best(QuestMetric.combo, activity.combo);
      best(QuestMetric.score, activity.score);
      add(QuestMetric.dailyChallenge, activity.dailyChallenges);
      add(QuestMetric.puzzles, activity.puzzles);
      if (before.lastDay != today) add(QuestMetric.days, 1);
      if (period != QuestPeriod.daily) {
        add(QuestMetric.dailySets, dailySetsDone);
      }

      final quests = questsFor(period, now);
      final paid = {...before.paid};
      for (final q in quests) {
        if (!paid.contains(q.metric.name) &&
            (values[q.metric.name] ?? 0) >= q.target) {
          paid.add(q.metric.name);
          completed.add(q);
          coins += q.coins;
        }
      }
      var bonusPaid = before.bonusPaid;
      if (!bonusPaid && quests.every((q) => paid.contains(q.metric.name))) {
        bonusPaid = true;
        sets.add(period);
        diamonds += kQuestBonusDiamonds[period]!;
        if (period == QuestPeriod.daily) dailySetsDone = 1;
      }

      _state[period] = QuestProgress(
        key: before.key,
        values: values,
        paid: paid,
        bonusPaid: bonusPaid,
        lastDay: today,
      );
    }

    return QuestOutcome(
      completed: completed,
      coins: coins,
      diamonds: diamonds,
      setsCompleted: sets,
    );
  }
}
