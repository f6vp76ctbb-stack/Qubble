/// The one dialog in which a leaderboard name is chosen: the first choice from
/// the home screen, the question after a round, and a paid rename.
///
/// Names are unique (owner's decision, 28.09.2026), so choosing one is a
/// round trip: the name is claimed on the server before it is kept. The
/// dialog therefore stays open while it checks and shows why a name was not
/// taken — already held by someone, or not checkable offline — instead of
/// closing and leaving the player to guess.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/name_filter.dart';
import '../../l10n/app_localizations.dart';
import '../../services/leaderboard.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../theme.dart';

enum NameDialogMode {
  /// Free first choice, from the name chip on the home screen.
  firstName,

  /// The question at the end of a round ([NamePrompt]); skippable.
  prompt,

  /// A change of name, paid for with a rename credit.
  rename,
}

/// Shows the dialog; resolves to true once a name was taken.
Future<bool> showNameDialog(
  BuildContext context, {
  required NameDialogMode mode,
}) async {
  final taken = await showDialog<bool>(
    context: context,
    builder: (_) => _NameDialog(mode: mode),
  );
  return taken ?? false;
}

class _NameDialog extends ConsumerStatefulWidget {
  const _NameDialog({required this.mode});

  final NameDialogMode mode;

  @override
  ConsumerState<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends ConsumerState<_NameDialog> {
  final _controller = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = L10n.of(context);
    final name = NameFilter.canonical(_controller.text);
    final problem = NameFilter.problem(name);
    if (problem != null) {
      setState(() => _error = nameProblemText(l10n, problem));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final game = ref.read(gameControllerProvider.notifier);
    final claim = widget.mode == NameDialogMode.rename
        ? await game.renameWithCredit(name)
        : await game.claimPlayerName(name);
    if (!mounted) return;
    if (claim == NameClaim.claimed) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = claim == NameClaim.taken ? l10n.nameTaken : l10n.nameCheckFailed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final lostName = ref.watch(gameControllerProvider.select((s) => s.lostName));
    final rename = widget.mode == NameDialogMode.rename;
    const muted = TextStyle(color: GridColors.textMuted, height: 1.35);
    return AlertDialog(
      backgroundColor: GridColors.boardBackground,
      title: Text(
        rename ? l10n.nameNewName : l10n.homeEnableLeaderboard,
        style: const TextStyle(color: GridColors.textPrimary),
      ),
      // The name is published to every other player, so the rule that
      // governs it is stated here, at the moment it is chosen, rather than
      // buried in a terms screen nobody opens. Google's UGC policy asks for
      // exactly this: the rule accepted before the content is created.
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!rename && lostName != null) ...[
              Text(
                l10n.nameLost(lostName),
                style: const TextStyle(color: GridColors.textPrimary),
              ),
              const SizedBox(height: 8),
            ],
            if (widget.mode == NameDialogMode.prompt) ...[
              Text(l10n.namePromptBody, style: muted),
              const SizedBox(height: 4),
            ],
            TextField(
              controller: _controller,
              autofocus: true,
              enabled: !_busy,
              maxLength: NameFilter.maxLength,
              textCapitalization: TextCapitalization.words,
              style: const TextStyle(color: GridColors.textPrimary),
              onSubmitted: (_) => _busy ? null : _submit(),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              decoration: InputDecoration(
                hintText: l10n.nameFieldLabel,
                errorText: _error,
                errorMaxLines: 3,
              ),
            ),
            Text(l10n.leaderboardRules, style: muted.copyWith(fontSize: 12)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          child: Text(
            widget.mode == NameDialogMode.prompt
                ? l10n.commonLater
                : l10n.commonCancel,
          ),
        ),
        FilledButton(
          onPressed: _busy ? null : _submit,
          // Saving is the acknowledgement of the rule shown above it.
          child: _busy
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(rename ? l10n.commonSave : l10n.leaderboardRulesAccept),
        ),
      ],
    );
  }
}
