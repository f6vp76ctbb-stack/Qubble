/// Shared leaderboard: shows the public ranking. The player's best score is
/// uploaded automatically in the background (silent anonymous identity, no
/// account) — opening this screen just triggers a fresh upload attempt.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../services/leaderboard.dart';
import '../state/game_controller.dart';
import '../theme.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  late Future<List<LeaderboardEntry>> _future;

  @override
  void initState() {
    super.initState();
    // Make sure the player's best is uploaded, then show the ranking.
    ref.read(gameControllerProvider.notifier).autoUploadBestScore();
    _future = ref.read(leaderboardServiceProvider).fetchTop();
  }

  void _reload() {
    ref.read(gameControllerProvider.notifier).autoUploadBestScore();
    setState(() {
      _future = ref.read(leaderboardServiceProvider).fetchTop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final snap = ref.watch(gameControllerProvider);
    final me = snap.playerName;
    final pending = snap.highscore > snap.lastSubmittedScore &&
        snap.highscore > 0;

    return Scaffold(
      backgroundColor: GridColors.background,
      appBar: AppBar(
        title: Text(l10n.leaderboardTitle),
        backgroundColor: GridColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.leaderboardRefresh,
            onPressed: _reload,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _reload(),
              child: FutureBuilder<List<LeaderboardEntry>>(
                future: _future,
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
                  final entries = snapshot.data ?? const [];
                  if (entries.isEmpty) {
                    return _Message(
                      icon: Icons.emoji_events_outlined,
                      text: l10n.leaderboardEmpty,
                    );
                  }
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: entries.length,
                    itemBuilder: (context, i) {
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
                              fontWeight:
                                  isMe ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                          trailing: Text(
                            '${e.score}',
                            style: const TextStyle(
                              color: GridColors.placed,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                pending
                    ? l10n.leaderboardSubmitting(snap.highscore)
                    : l10n.leaderboardAutoSubmit,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
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
                    colors: [
                      Color.lerp(medal, Colors.white, 0.35)!,
                      medal,
                    ],
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
            : Text(
                '$rank',
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
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
