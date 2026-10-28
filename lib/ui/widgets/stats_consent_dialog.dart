/// The one-time question whether statistics and crash reports may be sent.
library;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../legal_links.dart';
import '../theme.dart';

/// Returns the player's answer. The dialog cannot be dismissed without one:
/// until there is an answer nothing is collected, so a stray tap beside it
/// would only bring the same question back on the next launch.
Future<bool?> showStatsConsentDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const StatsConsentDialog(),
  );
}

class StatsConsentDialog extends StatelessWidget {
  const StatsConsentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: GridColors.boardBackground,
        title: Text(
          l10n.statsConsentTitle,
          style: const TextStyle(color: GridColors.textPrimary),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.statsConsentBody,
                style: const TextStyle(color: GridColors.textMuted),
              ),
              const SizedBox(height: 4),
              TextButton(
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () => launchUrl(
                  privacyPolicyUri(Localizations.localeOf(context)),
                  mode: LaunchMode.externalApplication,
                ),
                child: Text(l10n.settingsPrivacy),
              ),
            ],
          ),
        ),
        // Both answers look the same: saying no must be as easy as saying
        // yes, or the consent is not freely given.
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.statsConsentDecline),
          ),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.statsConsentAccept),
          ),
        ],
      ),
    );
  }
}
