/// Shared leaderboards: the public ranking by best score, the puzzle
/// ranking by total stars, and today's Daily (owner, 29.09.2026). All are
/// uploaded
/// automatically in the background (silent anonymous identity, no account) —
/// opening this screen just triggers a fresh upload attempt.
///
/// Each ranking shows its top [kLeaderboardTop] and, pinned below them, the
/// player's own place and value (owner, 12.10.2026).
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_info.dart';
import '../../game/daily.dart';
import '../../l10n/app_localizations.dart';
import '../../services/feedback.dart';
import '../../services/leaderboard.dart';
import '../format.dart';
import '../state/game_controller.dart';
import '../theme.dart';
import '../widgets/screen_title.dart';

/// The rankings, in the order of their tabs.
enum LeaderboardTab { score, puzzle, daily }

/// The rankings players see. The puzzle and Daily rankings are hidden while
/// few players take part (owner, 12.10.2026): a ranking of one or two reads
/// as an empty game. Entries are still uploaded in the background, so adding
/// a tab back here shows real data at once.
const List<LeaderboardTab> kShownLeaderboards = [LeaderboardTab.score];

/// How many places a ranking lists above the player's own row.
const int kLeaderboardTop = 10;

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key, this.initialTab = LeaderboardTab.score});

  final LeaderboardTab initialTab;

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(
    length: kShownLeaderboards.length,
    initialIndex: kShownLeaderboards.contains(widget.initialTab)
        ? kShownLeaderboards.indexOf(widget.initialTab)
        : 0,
    vsync: this,
  );
  late Future<List<LeaderboardEntry>> _scores;
  late Future<List<LeaderboardEntry>> _puzzles;
  late Future<List<LeaderboardEntry>> _daily;
  late Future<int?> _scoreRank;
  late Future<int?> _puzzleRank;

  @override
  void initState() {
    super.initState();
    // Make sure the player's best is uploaded, then show the rankings.
    ref.read(gameControllerProvider.notifier).autoUploadBestScore();
    _fetch();
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void _fetch() {
    final service = ref.read(leaderboardServiceProvider);
    final storage = ref.read(storageProvider);
    final today = DailyChallenge.dateKey(ref.read(gameCalendarProvider)());
    // Enough rows that the top ten survive the names this player blocked.
    final limit = kLeaderboardTop + storage.blockedNames.length;
    // Only the shown tabs load; offline, an unawaited error would surface as
    // uncaught, so each is ignored here and shown by its own tab.
    _scores = service.fetchTop(limit: limit)..ignore();
    _puzzles = kShownLeaderboards.contains(LeaderboardTab.puzzle)
        ? (service.fetchTopPuzzle(limit: limit)..ignore())
        : Future.value(const []);
    _daily = kShownLeaderboards.contains(LeaderboardTab.daily)
        ? (service.fetchDailyTop(today, limit: limit)..ignore())
        : Future.value(const []);
    final best = storage.highscore;
    _scoreRank = best > 0 ? service.scoreRank(best) : Future.value(null);
    final stars = storage.puzzleStarTotal;
    _puzzleRank = stars > 0 && kShownLeaderboards.contains(LeaderboardTab.puzzle)
        ? service.puzzleRank(stars)
        : Future.value(null);
  }

  void _reload() {
    ref.read(gameControllerProvider.notifier).autoUploadBestScore();
    setState(_fetch);
  }

  /// Hides [entry] for this player, with one undo.
  ///
  /// Reporting mails a human and changes nothing on screen; Google's UGC
  /// policy asks for blocking as well, and blocking is the half that gives
  /// the player relief now instead of eventually.
  Future<void> _block(LeaderboardEntry entry) async {
    final l10n = L10n.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final storage = ref.read(storageProvider);

    await storage.blockName(entry.name);
    if (!mounted) return;
    setState(() {});

    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.leaderboardBlocked(entry.name)),
        action: SnackBarAction(
          label: l10n.leaderboardUndo,
          onPressed: () async {
            await storage.unblockName(entry.name);
            if (mounted) setState(() {});
          },
        ),
      ),
    );
  }

  Future<void> _unblockAll() async {
    await ref.read(storageProvider).setBlockedNames({});
    if (mounted) setState(() {});
  }

  /// Opens a prefilled report mail for an offensive name.
  ///
  /// Google's UGC policy requires an in-app way to report objectionable
  /// content. Qubble has no backend to receive a report, so this mails the
  /// operator — the same address the privacy policy names for entry removal.
  Future<void> _report(LeaderboardEntry entry) async {
    final l10n = L10n.of(context);
    final uri = buildReportMailUri(
      entry.name,
      score: entry.score,
      context: {'Version': AppInfo.version},
    );
    final opened =
        uri != null &&
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          opened
              ? l10n.leaderboardReportSent
              : l10n.leaderboardReportUnavailable,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final snap = ref.watch(gameControllerProvider);
    final storage = ref.watch(storageProvider);
    final pending =
        snap.highscore > snap.lastSubmittedScore && snap.highscore > 0;

    final boards = {
      LeaderboardTab.score: _board(
        _scores,
        me: snap.playerName,
        own: snap.highscore > 0
            ? (value: snap.highscore, rank: _scoreRank)
            : null,
        footer: pending
            ? l10n.leaderboardSubmitting(snap.highscore)
            : l10n.leaderboardAutoSubmit,
      ),
      LeaderboardTab.puzzle: _board(
        _puzzles,
        me: snap.playerName,
        stars: true,
        own: storage.puzzleStarTotal > 0
            ? (value: storage.puzzleStarTotal, rank: _puzzleRank)
            : null,
        footer: storage.puzzleStarTotal > storage.lastSubmittedPuzzleStars
            ? l10n.leaderboardPuzzleSubmitting(storage.puzzleStarTotal)
            : l10n.leaderboardPuzzleAutoSubmit,
      ),
      LeaderboardTab.daily: _board(
        _daily,
        me: snap.playerName,
        footer: l10n.leaderboardDailyFooter,
      ),
    };
    final tabLabels = {
      LeaderboardTab.score: l10n.leaderboardTabScore,
      LeaderboardTab.puzzle: l10n.leaderboardTabPuzzle,
      LeaderboardTab.daily: l10n.leaderboardTabDaily,
    };

    return Scaffold(
      backgroundColor: GridColors.background,
      appBar: AppBar(
        title: ScreenTitle(l10n.leaderboardTitle),
        backgroundColor: GridColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.leaderboardRefresh,
            onPressed: _reload,
          ),
        ],
        // A single ranking needs no tab bar.
        bottom: kShownLeaderboards.length < 2
            ? null
            : TabBar(
                controller: _tabs,
                // Labels that are long in some languages; scrolling beats
                // squeezing them.
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                indicatorColor: GridColors.placed,
                labelColor: GridColors.textPrimary,
                unselectedLabelColor: GridColors.textMuted,
                tabs: [
                  for (final tab in kShownLeaderboards)
                    Tab(text: tabLabels[tab]),
                ],
              ),
      ),
      body: kShownLeaderboards.length < 2
          ? boards[kShownLeaderboards.single]!
          : TabBarView(
              controller: _tabs,
              children: [
                for (final tab in kShownLeaderboards) boards[tab]!,
              ],
            ),
    );
  }

  /// One ranking: the top [kLeaderboardTop] (or the empty and error
  /// states), the player's [own] place and value pinned below them, and a
  /// footer that says how the player's own entry gets there. [stars] shows
  /// the value as puzzle stars rather than points.
  Widget _board(
    Future<List<LeaderboardEntry>> future, {
    required String me,
    required String footer,
    ({int value, Future<int?> rank})? own,
    bool stars = false,
  }) {
    final l10n = L10n.of(context);
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => _reload(),
            child: FutureBuilder<List<LeaderboardEntry>>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _Message(
                    icon: Icons.wifi_off,
                    text: l10n.leaderboardUnreachable,
                    onRetry: _reload,
                  );
                }
                final blocked = ref.watch(storageProvider).blockedNames;
                final all = snapshot.data ?? const <LeaderboardEntry>[];
                final visible = [
                  for (final e in all)
                    if (!blocked.contains(e.name)) e,
                ];
                final hiddenCount = all.length - visible.length;
                final entries = visible.take(kLeaderboardTop).toList();
                // Blocking everyone would otherwise look like an empty
                // leaderboard, with no hint that the player did it.
                if (entries.isEmpty && hiddenCount == 0) {
                  return _Message(
                    icon: Icons.emoji_events_outlined,
                    text: l10n.leaderboardEmpty,
                  );
                }
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  // One extra row for the "n hidden by you" footer, so a
                  // block is always reversible from the screen it happened
                  // on rather than only from the snackbar that vanishes.
                  itemCount: entries.length + (hiddenCount > 0 ? 1 : 0),
                  itemBuilder: (context, i) {
                    if (i == entries.length) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                l10n.leaderboardBlockedCount(hiddenCount),
                                style: const TextStyle(
                                  color: GridColors.textMuted,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: _unblockAll,
                              child: Text(l10n.leaderboardUnblockAll),
                            ),
                          ],
                        ),
                      );
                    }
                    final e = entries[i];
                    final isMe = e.name == me;
                    return Container(
                      color: isMe
                          ? GridColors.placed.withValues(alpha: 0.15)
                          : null,
                      child: ListTile(
                        leading: _RankBadge(rank: i + 1),
                        title: Text(
                          e.name,
                          style: TextStyle(
                            color: GridColors.textPrimary,
                            fontWeight: isMe
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _Value(value: e.score, stars: stars),
                            // Your own name is removed in settings, not
                            // reported, so the action is only on other rows.
                            if (!isMe)
                              IconButton(
                                icon: const Icon(
                                  Icons.flag_outlined,
                                  size: 20,
                                  color: GridColors.textMuted,
                                ),
                                tooltip: l10n.leaderboardReport,
                                onPressed: () => _report(e),
                              ),
                            if (!isMe)
                              IconButton(
                                icon: const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 20,
                                  color: GridColors.textMuted,
                                ),
                                tooltip: l10n.leaderboardBlock,
                                onPressed: () => _block(e),
                              )
                            else
                              const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        if (own != null)
          _OwnRow(
            name: me.isEmpty ? l10n.leaderboardYou : me,
            value: own.value,
            rank: own.rank,
            stars: stars,
          ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              footer,
              textAlign: TextAlign.center,
              style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}

/// A ranking's value: points, or puzzle stars with a star in front.
class _Value extends StatelessWidget {
  const _Value({required this.value, required this.stars});

  final int value;
  final bool stars;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (stars)
          const Padding(
            padding: EdgeInsetsDirectional.only(end: 3),
            child: Icon(
              Icons.star_rounded,
              size: 18,
              color: GridColors.fever,
            ),
          ),
        Text(
          L10n.of(context).count(value),
          style: TextStyle(
            color: stars ? GridColors.fever : GridColors.placed,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// The player's own place and value, pinned under the top of the ranking so
/// it is visible however far down the player stands. Shows nothing until the
/// place is known — offline the list above says why.
class _OwnRow extends StatelessWidget {
  const _OwnRow({
    required this.name,
    required this.value,
    required this.rank,
    required this.stars,
  });

  final String name;
  final int value;
  final Future<int?> rank;
  final bool stars;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: rank,
      builder: (context, snapshot) {
        final place = snapshot.data;
        if (place == null) return const SizedBox.shrink();
        return Container(
          margin: const EdgeInsets.fromLTRB(12, 4, 12, 0),
          decoration: BoxDecoration(
            color: GridColors.placed.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: GridColors.placed.withValues(alpha: 0.6),
            ),
          ),
          child: ListTile(
            leading: _RankBadge(rank: place),
            title: Text(
              name,
              style: const TextStyle(
                color: GridColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: _Value(value: value, stars: stars),
            ),
          ),
        );
      },
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  // Gold / silver / bronze for the podium; a plain number below.
  static const _podium = {
    1: Color(0xFFFFC24B),
    2: Color(0xFFC6CEE0),
    3: Color(0xFFD9955B),
  };

  @override
  Widget build(BuildContext context) {
    final medal = _podium[rank];
    return SizedBox(
      width: 34,
      child: Center(
        child: medal != null
            ? Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color.lerp(medal, Colors.white, 0.35)!, medal],
                  ),
                ),
                child: Center(
                  child: Text(
                    '$rank',
                    style: const TextStyle(
                      color: Color(0xFF2A2010),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )
            // The own row can stand far down: a four-digit place shrinks
            // rather than spill out of the badge.
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: GridColors.textMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.text, this.onRetry});

  final IconData icon;
  final String text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // ListView so RefreshIndicator/pull-to-retry works even when empty.
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 120),
        Icon(icon, size: 56, color: GridColors.textMuted),
        const SizedBox(height: 16),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: GridColors.textMuted, fontSize: 16),
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: onRetry,
              child: Text(L10n.of(context).leaderboardRetry),
            ),
          ),
        ],
      ],
    );
  }
}
