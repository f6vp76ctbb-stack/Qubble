/// Last-resort UI for a widget that failed to build.
///
/// Flutter's release-mode default is a bare grey rectangle with no text, which
/// turns a tester report into "it went grey, no idea why". During a closed test
/// the details are what make a report usable, so they are shown here — together
/// with the two things a stuck player can actually do.
library;

import 'package:flutter/material.dart';

import '../theme.dart';

/// Installs [ErrorScreen] as the app-wide fallback for build failures.
///
/// Call once before `runApp`. [onReset] wipes local progress (see
/// `Storage.resetProgress`) and is offered only when a reset can actually be
/// performed, because a broken save is the most likely cause we can fix
/// from inside the app.
void installErrorScreen({Future<void> Function()? onReset}) {
  ErrorWidget.builder = (details) => ErrorScreen(
    details: details,
    onReset: onReset,
  );
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.details, this.onReset});

  final FlutterErrorDetails details;

  /// Clears local progress, then the player restarts the app manually.
  final Future<void> Function()? onReset;

  /// A short, human-readable cause. The full stack goes to Crashlytics, not
  /// on screen — it would only push the buttons out of view.
  String get _summary {
    final exception = details.exception;
    final text = exception.toString().trim();
    if (text.isEmpty) return 'Unbekannter Fehler';
    final firstLine = text.split('\n').first;
    return firstLine.length > 240
        ? '${firstLine.substring(0, 240)}…'
        : firstLine;
  }

  @override
  Widget build(BuildContext context) {
    // ErrorWidget.builder can fire before (or instead of) a MaterialApp, so
    // this must not assume Directionality, Material or a theme are in scope.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: GridColors.background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '🧩',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 44),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Hier ist etwas schiefgelaufen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GridColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Starte Qubble neu. Wenn der Fehler bleibt, hilft ein '
                      'Zurücksetzen des Spielstands — Käufe und Name bleiben '
                      'dabei erhalten.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: GridColors.boardBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: GridColors.gridLine),
                      ),
                      child: SelectableText(
                        _summary,
                        style: const TextStyle(
                          color: GridColors.textMuted,
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Bitte diesen Text mit ins Feedback kopieren.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    if (onReset != null) ...[
                      const SizedBox(height: 22),
                      _ResetButton(onReset: onReset!),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Separate stateful widget so the reset can report back without rebuilding
/// the (possibly still broken) tree around it.
class _ResetButton extends StatefulWidget {
  const _ResetButton({required this.onReset});

  final Future<void> Function() onReset;

  @override
  State<_ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<_ResetButton> {
  bool _busy = false;
  bool _done = false;

  Future<void> _run() async {
    setState(() => _busy = true);
    try {
      await widget.onReset();
      if (mounted) setState(() => _done = true);
    } catch (error) {
      debugPrint('Progress reset from the error screen failed: $error');
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_done) {
      return const Text(
        'Spielstand zurückgesetzt. Bitte Qubble neu starten.',
        textAlign: TextAlign.center,
        style: TextStyle(color: GridColors.placed, fontSize: 14),
      );
    }
    return FilledButton(
      onPressed: _busy ? null : _run,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: GridColors.fever,
        foregroundColor: GridColors.background,
      ),
      child: Text(_busy ? 'Wird zurückgesetzt…' : 'Spielstand zurücksetzen'),
    );
  }
}
