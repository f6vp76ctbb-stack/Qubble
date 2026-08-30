/// Compact, visual rules overview for new and returning players.
library;

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../state/game_controller.dart';
import '../theme.dart';
import '../widgets/app_icons.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.howToPlayTitle),
        backgroundColor: GridColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _IntroCard(),
          const SizedBox(height: 20),
          _GuideCard(
            icon: Icons.open_with_rounded,
            accent: GridColors.placed,
            title: l10n.howToPlayDragTitle,
            body: l10n.howToPlayDragBody,
          ),
          _GuideCard(
            icon: Icons.grid_view_rounded,
            accent: const Color(0xFF7C9BFF),
            title: l10n.howToPlayClearTitle,
            body: l10n.howToPlayClearBody,
          ),
          _GuideCard(
            icon: Icons.timer_outlined,
            accent: const Color(0xFFFF8DBE),
            title: l10n.howToPlayComboTitle,
            body: l10n.howToPlayComboBody,
          ),
          _GuideCard(
            icon: Icons.local_fire_department_rounded,
            accent: GridColors.fever,
            title: l10n.howToPlayFeverTitle,
            body: l10n.howToPlayFeverBody,
          ),
          _GuideCard(
            icon: Icons.auto_awesome_rounded,
            accent: const Color(0xFF9C8CFF),
            title: l10n.howToPlayBoosterTitle,
            body: l10n.howToPlayBoosterBody,
            footer: const _BoosterLegend(),
          ),
          _GuideCard(
            icon: Icons.today_rounded,
            accent: const Color(0xFF65D7FF),
            title: l10n.howToPlayDailyTitle,
            body: l10n.howToPlayDailyBody,
          ),
          _GuideCard(
            icon: Icons.savings_outlined,
            accent: const Color(0xFFFFC86B),
            title: l10n.howToPlayPiggyTitle,
            body: l10n.howToPlayPiggyBody,
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.check_rounded),
            label: Text(l10n.commonGotIt),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: L10n.of(context).howToPlayIntroSemantics,
      child: ExcludeSemantics(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF24275A), Color(0xFF1A1C43)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF3B3F7A)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.of(context).howToPlayIntroHeadline,
                      style: const TextStyle(
                        color: GridColors.textPrimary,
                        fontSize: 22,
                        height: 1.12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      L10n.of(context).howToPlayIntroBody,
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              const _MiniBoard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniBoard extends StatelessWidget {
  const _MiniBoard();

  static const _filled = <int>{3, 7, 8, 9, 10, 11, 12, 13, 14, 18, 23};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      height: 92,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 25,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
        ),
        itemBuilder: (context, index) => DecoratedBox(
          decoration: BoxDecoration(
            color: _filled.contains(index)
                ? GridColors.placed
                : GridColors.emptyCell,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({
    required this.icon,
    required this.accent,
    required this.title,
    required this.body,
    this.footer,
  });

  final IconData icon;
  final Color accent;
  final String title;
  final String body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: '$title. $body',
      child: ExcludeSemantics(
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: GridColors.boardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: GridColors.gridLine),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accent, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: GridColors.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      body,
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    if (footer != null) ...[
                      const SizedBox(height: 12),
                      footer!,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BoosterLegend extends StatelessWidget {
  const _BoosterLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        _CostChip(
          icon: AppIcons.undo,
          label: L10n.of(context).boosterUndo,
          cost: BoosterCosts.undo,
        ),
        _CostChip(
          icon: AppIcons.swap,
          label: L10n.of(context).boosterSwap,
          cost: BoosterCosts.swap,
        ),
        _CostChip(
          icon: AppIcons.bomb,
          label: L10n.of(context).boosterBomb,
          cost: BoosterCosts.bomb,
        ),
      ],
    );
  }
}

class _CostChip extends StatelessWidget {
  const _CostChip({
    required this.icon,
    required this.label,
    required this.cost,
  });

  final IconData icon;
  final String label;
  final int cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: GridColors.background.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: GridColors.textPrimary),
          const SizedBox(width: 4),
          Text(
            '$label · $cost',
            style: const TextStyle(
              color: GridColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
