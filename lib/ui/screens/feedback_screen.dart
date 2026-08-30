/// In-app feedback.
///
/// Mail is the primary route: it needs no account and no login, so ordinary
/// playtesters actually use it. The GitHub issue composer stays as a second
/// route for testers who already have an account — a GitHub Action appends
/// each feedback issue to `FEEDBACK.md`.
///
/// The app never holds a GitHub token (public build); both routes only hand a
/// prefilled URL to the system.
library;

import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_info.dart';
import '../../l10n/app_localizations.dart';
import '../../services/feedback.dart';
import '../theme.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({
    super.key,
    this.launcher,
    this.email = kFeedbackEmail,
  });

  /// Injectable URL launcher for tests; defaults to url_launcher.
  final Future<bool> Function(Uri uri)? launcher;

  /// Destination address. Overridable so both routes stay testable whichever
  /// way [kFeedbackEmail] is currently configured.
  final String email;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _sending = false;

  /// Attached to every report so a message can be tied to a build and device.
  /// Without this a tester's "it crashed" cannot be matched to a version.
  Map<String, String> get _context => {
    'Version': AppInfo.version,
    'Platform': kIsWeb ? 'Web/PWA' : defaultTargetPlatform.name,
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _launch(Uri uri) {
    final launcher = widget.launcher;
    if (launcher != null) return launcher(uri);
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _send(Uri? uri, {required String failureHint}) async {
    if (uri == null) {
      _toast(L10n.of(context).feedbackEmptyHint);
      return;
    }

    setState(() => _sending = true);
    final ok = await _launch(uri);
    if (!mounted) return;
    setState(() => _sending = false);

    if (ok) {
      _toast(L10n.of(context).feedbackThanksMail);
      Navigator.of(context).maybePop();
    } else {
      _toast(failureHint);
    }
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitMail() => _send(
    buildFeedbackMailUri(
      _controller.text,
      address: widget.email,
      context: _context,
    ),
    failureHint: L10n.of(context).feedbackNoMailApp,
  );

  Future<void> _submitGithub() => _send(
    buildFeedbackIssueUri(_controller.text, context: _context),
    failureHint: L10n.of(context).feedbackOpenFailed,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final mailAvailable = widget.email.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.feedbackTitle),
        backgroundColor: GridColors.background,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.feedbackIntroShort,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(color: GridColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: l10n.feedbackHint,
                    hintStyle: const TextStyle(color: GridColors.textMuted),
                    filled: true,
                    fillColor: GridColors.boardBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.feedbackAttachmentNote(AppInfo.label),
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              if (mailAvailable)
                FilledButton.icon(
                  onPressed: _sending ? null : _submitMail,
                  icon: _sending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.mail_outline_rounded),
                  label: Text(l10n.feedbackSendByMail),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: GridColors.placed,
                    foregroundColor: GridColors.background,
                  ),
                ),
              if (mailAvailable) const SizedBox(height: 8),
              // Kept for testers who already have a GitHub account; it is the
              // only route when no address is configured.
              mailAvailable
                  ? TextButton.icon(
                      onPressed: _sending ? null : _submitGithub,
                      icon: const Icon(Icons.code_rounded, size: 18),
                      label: Text(l10n.feedbackPreferGithub),
                      style: TextButton.styleFrom(
                        foregroundColor: GridColors.textMuted,
                      ),
                    )
                  : FilledButton.icon(
                      onPressed: _sending ? null : _submitGithub,
                      icon: _sending
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                      label: Text(l10n.feedbackSubmit),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: GridColors.placed,
                        foregroundColor: GridColors.background,
                      ),
                    ),
              if (!mailAvailable)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l10n.feedbackGithubNote,
                    style: const TextStyle(
                      color: GridColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
