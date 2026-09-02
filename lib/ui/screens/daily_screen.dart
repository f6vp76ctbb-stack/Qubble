/// Daily Challenge overview: month calendar, streak, and the daily best.
///
/// `lastDailyDate` alone can only answer "today or not". The calendar is the
/// first place a player can see the run of days they actually kept — which is
/// the thing the streak is asking them to protect.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/daily.dart';
import '../../l10n/app_localizations.dart';
import '../state/game_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';
import 'game_screen.dart';

class DailyScreen extends ConsumerWidget {
  const DailyScreen({super.key, this.today});

  /// Injectable so a test can assert a specific month without waiting for one.
  final DateTime? today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final storage = ref.watch(storageProvider);
    final now = today ?? DateTime.now();
    final played = storage.dailyPlayedDates.toSet();
    final playedToday = DailyChallenge.playedToday(
      lastKey: storage.lastDailyDate,
      now: now,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeDailyChallenge),
        backgroundColor: GridColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: _Metric(
                  icon: AppIcons.streak,
                  color: GridColors.fever,
                  label: l10n.dailyStreakLabel,
                  value: '${storage.streak}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Metric(
                  icon: AppIcons.trophy,
                  color: GridColors.placed,
                  label: l10n.dailyBestLabel,
                  value: '${storage.dailyBest}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _MonthCalendar(month: now, played: played, today: now),
          const SizedBox(height: 12),
          Text(
            l10n.dailyHistoryNote(DailyChallenge.playedHistoryDays),
            style: const TextStyle(
              color: GridColors.textMuted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
          _PlayButton(
            playedToday: playedToday,
            onPlay: () {
              ref.read(gameControllerProvider.notifier).startDaily();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(builder: (_) => const GameScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.playedToday, required this.onPlay});

  final bool playedToday;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    if (playedToday) {
      // Deliberately not a disabled button: today's board can still be
      // replayed, it just no longer counts. Saying so is more useful than
      // greying out a control with no explanation.
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GridColors.boardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: GridColors.gridLine),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: GridColors.placed),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.homeDailyNextIn(
                  _formatRemaining(DailyChallenge.untilNextDaily()),
                ),
                style: const TextStyle(color: GridColors.textMuted),
              ),
            ),
          ],
        ),
      );
    }
    return FilledButton.icon(
      onPressed: onPlay,
      icon: const Icon(Icons.play_arrow_rounded),
      label: Text(l10n.homeDailyOpenToday),
      style: FilledButton.styleFrom(
        backgroundColor: GridColors.placed,
        foregroundColor: GridColors.background,
        minimumSize: const Size.fromHeight(52),
      ),
    );
  }

  static String _formatRemaining(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h > 0 ? '${h}h ${m}m' : '${m}m';
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: GridColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: GridColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({
    required this.month,
    required this.played,
    required this.today,
  });

  final DateTime month;
  final Set<String> played;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final materialL10n = MaterialLocalizations.of(context);
    // MaterialLocalizations counts from Sunday = 0; DateTime from Monday = 1.
    final firstWeekday = materialL10n.firstDayOfWeekIndex == 0
        ? DateTime.sunday
        : materialL10n.firstDayOfWeekIndex;
    final cells = DailyChallenge.monthCells(
      month.year,
      month.month,
      firstWeekday: firstWeekday,
    );
    final narrowWeekdays = materialL10n.narrowWeekdays;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GridColors.boardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GridColors.gridLine),
      ),
      child: Column(
        children: [
          Text(
            materialL10n.formatMonthYear(month),
            style: const TextStyle(
              color: GridColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: Center(
                    child: Text(
                      // narrowWeekdays is Sunday-first; firstWeekday follows
                      // DateTime, where Sunday is 7.
                      narrowWeekdays[(firstWeekday + i) % 7],
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          for (var week = 0; week * 7 < cells.length; week++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  for (var i = 0; i < 7; i++)
                    Expanded(
                      child: _DayCell(
                        day: cells[week * 7 + i],
                        month: month,
                        played: played,
                        today: today,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.month,
    required this.played,
    required this.today,
  });

  final int? day;
  final DateTime month;
  final Set<String> played;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final d = day;
    if (d == null) return const SizedBox(height: 34);

    final date = DateTime(month.year, month.month, d);
    final isPlayed = played.contains(DailyChallenge.dateKey(date));
    final isToday =
        DailyChallenge.dateKey(date) == DailyChallenge.dateKey(today);
    final isFuture = date.isAfter(DateTime(today.year, today.month, today.day));

    return Semantics(
      // Its own node, not merged into the month: without this the whole
      // calendar collapses into one label and a screen reader reads all
      // thirty days as a single utterance, with no way to move day by day.
      container: true,
      label: isPlayed
          ? L10n.of(context).dailyDayPlayed(d)
          : L10n.of(context).dailyDayMissed(d),
      excludeSemantics: true,
      child: Container(
        height: 34,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isPlayed ? GridColors.placed : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isToday
              ? Border.all(color: GridColors.fever, width: 2)
              : Border.all(color: GridColors.emptyCell),
        ),
        child: Center(
          child: Text(
            '$d',
            style: TextStyle(
              // A played day carries the filled background, so its number is
              // read against that, not against the card.
              color: isPlayed
                  ? GridColors.background
                  : isFuture
                  ? GridColors.textMuted
                  : GridColors.textPrimary,
              fontSize: 13,
              fontWeight: isPlayed || isToday
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
