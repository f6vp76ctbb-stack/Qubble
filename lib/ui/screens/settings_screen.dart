/// Settings: sound/haptics toggles, ad-free/restore, privacy, about.
library;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_info.dart';
import '../../l10n/app_localizations.dart';
import '../../services/haptics.dart';
import '../l10n_maps.dart';
import '../state/game_controller.dart';
import '../state/notifications_controller.dart';
import '../state/settings_controller.dart';
import '../theme.dart';
import 'feedback_screen.dart';
import 'how_to_play_screen.dart';
import 'shop_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  /// Hidden admin/test mode: unlocked by tapping the footer 7 times.
  ///
  /// DEBUG BUILDS ONLY — release players must never get coin cheats. Both
  /// layers are real: kDebugMode here, and a kReleaseMode no-op in every
  /// controller method this section can reach
  /// ([GameController.setCoinsForTest] and [GameController.grantDebugCoins]).
  static const int _adminTapTarget = 7;
  int _footerTaps = 0;
  bool _adminUnlocked = false;

  static final _privacyUri = Uri.parse(
    'https://f6vp76ctbb-stack.github.io/Qubble/privacy.html',
  );
  static final _imprintUri = Uri.parse(
    'https://f6vp76ctbb-stack.github.io/Qubble/impressum.html',
  );

  void _onFooterTap() {
    if (!kDebugMode) return;
    if (_adminUnlocked) return;
    setState(() => _footerTaps += 1);
    if (_footerTaps >= _adminTapTarget) {
      setState(() => _adminUnlocked = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context).settingsAdminEnabled)),
      );
    } else if (_footerTaps >= _adminTapTarget - 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 600),
          content: Text(
            L10n.of(
              context,
            ).settingsAdminTapsLeft(_adminTapTarget - _footerTaps),
          ),
        ),
      );
    }
  }

  /// Escape hatch for a save the app cannot read (or a tester who wants to
  /// replay the first session). Purchases, name and cosmetics are kept —
  /// see [Storage.resetProgress].
  Future<void> _confirmResetProgress() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GridColors.boardBackground,
        title: Text(
          L10n.of(dialogContext).settingsResetConfirmTitle,
          style: const TextStyle(color: GridColors.textPrimary),
        ),
        content: Text(
          L10n.of(dialogContext).settingsResetConfirmBody,
          style: const TextStyle(color: GridColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(L10n.of(dialogContext).commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: GridColors.fever,
              foregroundColor: GridColors.background,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(L10n.of(dialogContext).settingsResetConfirmAction),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(gameControllerProvider.notifier).resetProgress();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.of(context).settingsResetDone)),
        );
      }
    }
  }

  /// In-app removal of the public leaderboard entry.
  ///
  /// Separate from [_confirmResetProgress] on purpose: resetting a broken save
  /// deliberately keeps the player's identity and entry, so without this the
  /// publicly visible display name had no way out from inside the app.
  Future<void> _confirmDeleteLeaderboardEntry() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: GridColors.boardBackground,
        title: Text(
          L10n.of(dialogContext).settingsLeaderboardDeleteConfirmTitle,
          style: const TextStyle(color: GridColors.textPrimary),
        ),
        content: Text(
          L10n.of(dialogContext).settingsLeaderboardDeleteConfirmBody,
          style: const TextStyle(color: GridColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(L10n.of(dialogContext).commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: GridColors.fever,
              foregroundColor: GridColors.background,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(L10n.of(dialogContext).settingsLeaderboardDelete),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;

    final removed =
        await ref.read(gameControllerProvider.notifier).deleteLeaderboardEntry();
    if (!mounted) return;
    final l10n = L10n.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          removed
              ? l10n.settingsLeaderboardDeleteDone
              : l10n.settingsLeaderboardDeleteFailed,
        ),
      ),
    );
  }

  Future<void> _openLegal(Uri uri) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L10n.of(context).settingsPageOpenFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final snap = ref.watch(gameControllerProvider);
    final supporter = snap.supporter;
    final iap = ref.read(iapServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: GridColors.background,
      ),
      body: ListView(
        children: [
          _SectionLabel(l10n.settingsSectionGame),
          ListTile(
            leading: const Icon(
              Icons.help_outline_rounded,
              color: GridColors.textPrimary,
            ),
            title: Text(l10n.settingsGuide, style: _tileStyle),
            subtitle: Text(
              l10n.settingsGuideSubtitle,
              style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: GridColors.textMuted,
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const HowToPlayScreen()),
            ),
          ),
          _SectionLabel(l10n.settingsSectionSoundHaptics),
          SwitchListTile(
            title: Text(l10n.settingsSound, style: _tileStyle),
            value: settings.sound,
            onChanged: controller.setSound,
            activeThumbColor: GridColors.placed,
          ),
          SwitchListTile(
            title: Text(l10n.settingsMusic, style: _tileStyle),
            value: settings.music,
            onChanged: controller.setMusic,
            activeThumbColor: GridColors.placed,
          ),
          ListTile(
            title: Text(l10n.settingsHaptics, style: _tileStyle),
            trailing: DropdownButton<HapticStrength>(
              value: settings.hapticStrength,
              underline: const SizedBox.shrink(),
              dropdownColor: GridColors.boardBackground,
              style: _tileStyle,
              items: [
                DropdownMenuItem(
                  value: HapticStrength.off,
                  child: Text(l10n.settingsHapticsOff),
                ),
                DropdownMenuItem(
                  value: HapticStrength.light,
                  child: Text(l10n.settingsHapticsLight),
                ),
                DropdownMenuItem(
                  value: HapticStrength.strong,
                  child: Text(l10n.settingsHapticsStrong),
                ),
              ],
              onChanged: (value) {
                if (value != null) controller.setHapticStrength(value);
              },
            ),
          ),
          _SectionLabel(l10n.settingsSectionAccessibility),
          SwitchListTile(
            title: Text(l10n.settingsReducedEffects, style: _tileStyle),
            subtitle: Text(
              l10n.settingsReducedEffectsHint,
              style: _tileStyle.copyWith(
                fontSize: 12,
                color: GridColors.textPrimary.withValues(alpha: 0.7),
              ),
            ),
            value: settings.reducedEffects,
            onChanged: controller.setReducedEffects,
            activeThumbColor: GridColors.placed,
          ),
          _SectionLabel(l10n.settingsSectionLanguage),
          ListTile(
            leading: const Icon(
              Icons.translate_rounded,
              color: GridColors.textPrimary,
            ),
            title: Text(l10n.settingsSectionLanguage, style: _tileStyle),
            trailing: DropdownButton<String>(
              value: settings.languageCode,
              underline: const SizedBox.shrink(),
              dropdownColor: GridColors.boardBackground,
              style: _tileStyle,
              items: [
                DropdownMenuItem(
                  value: '',
                  child: Text(l10n.settingsLanguageSystem),
                ),
                // Endonyms, so a player can find their language even when the
                // app is currently showing one they don't read.
                const DropdownMenuItem(value: 'en', child: Text('English')),
                const DropdownMenuItem(value: 'de', child: Text('Deutsch')),
              ],
              onChanged: (value) =>
                  controller.setLanguageCode(value ?? ''),
            ),
          ),
          _SectionLabel(l10n.settingsSectionReminders),
          SwitchListTile(
            title: Text(l10n.settingsNotifications, style: _tileStyle),
            subtitle: Text(
              l10n.settingsNotificationsSubtitle,
              style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
            ),
            value: ref.watch(notificationsControllerProvider),
            activeThumbColor: GridColors.placed,
            onChanged: (want) async {
              final notifier = ref.read(
                notificationsControllerProvider.notifier,
              );
              if (want) {
                final ok = await notifier.enable(
                  texts: notificationTexts(l10n),
                  channelDescription: l10n.notificationChannelDescription,
                );
                if (!ok && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.settingsNotificationsSystemHint),
                    ),
                  );
                }
              } else {
                await notifier.disable();
              }
            },
          ),
          _SectionLabel(l10n.settingsSectionPurchases),
          if (supporter)
            ListTile(
              leading: const Icon(Icons.favorite, color: GridColors.placed),
              title: Text(l10n.settingsSupporterThanks, style: _tileStyle),
            )
          else
            ListTile(
              leading: const Icon(
                Icons.favorite_outline,
                color: GridColors.textPrimary,
              ),
              title: Text(l10n.settingsSupporterPack, style: _tileStyle),
              subtitle: Text(
                l10n.settingsSupporterPackSubtitle,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 13,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: GridColors.textMuted,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ShopScreen()),
              ),
            ),
          ListTile(
            leading: const Icon(Icons.restore, color: GridColors.textPrimary),
            title: Text(l10n.settingsRestorePurchases, style: _tileStyle),
            onTap: () async {
              await iap.restore();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.settingsRestoring)),
                );
              }
            },
          ),
          _SectionLabel(l10n.settingsSectionHelpOut),
          ListTile(
            leading: const Icon(
              Icons.star_outline_rounded,
              color: GridColors.textPrimary,
            ),
            title: Text(l10n.settingsRateApp, style: _tileStyle),
            subtitle: Text(
              l10n.settingsRateAppSubtitle,
              style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
            ),
            trailing: const Icon(
              Icons.open_in_new_rounded,
              color: GridColors.textMuted,
            ),
            onTap: () async {
              final opened = await ref
                  .read(gameControllerProvider.notifier)
                  .openStoreListingForRating();
              if (!opened && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.settingsStoreUnavailable)),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.feedback_outlined,
              color: GridColors.textPrimary,
            ),
            title: Text(l10n.settingsFeedback, style: _tileStyle),
            subtitle: Text(
              l10n.settingsFeedbackSubtitle,
              style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: GridColors.textMuted,
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const FeedbackScreen()),
            ),
          ),
          _SectionLabel(l10n.settingsSectionLegal),
          ListTile(
            leading: const Icon(
              Icons.tune_rounded,
              color: GridColors.textPrimary,
            ),
            title: Text(l10n.settingsAdPrivacy, style: _tileStyle),
            subtitle: Text(
              l10n.settingsAdPrivacySubtitle,
              style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
            ),
            onTap: () async {
              final opened = await ref
                  .read(adServiceProvider)
                  .showPrivacyOptions();
              if (!opened && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.settingsAdPrivacyUnavailable)),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: GridColors.textPrimary,
            ),
            title: Text(l10n.settingsPrivacy, style: _tileStyle),
            onTap: () => _openLegal(_privacyUri),
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: GridColors.textPrimary,
            ),
            title: Text(l10n.settingsImprint, style: _tileStyle),
            onTap: () => _openLegal(_imprintUri),
          ),
          _SectionLabel(l10n.settingsSectionData),
          ListTile(
            leading: const Icon(
              Icons.restart_alt_rounded,
              color: GridColors.fever,
            ),
            title: Text(l10n.settingsResetProgress, style: _tileStyle),
            subtitle: Text(
              l10n.settingsResetProgressSubtitle,
              style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
            ),
            onTap: _confirmResetProgress,
          ),
          // Only meaningful once the player has entered the leaderboard: the
          // anonymous identity is created on the first submit, and a submit
          // requires a name.
          if (snap.playerName.isNotEmpty)
            ListTile(
              leading: const Icon(
                Icons.person_remove_outlined,
                color: GridColors.fever,
              ),
              title: Text(
                l10n.settingsLeaderboardDelete,
                style: _tileStyle,
              ),
              subtitle: Text(
                l10n.settingsLeaderboardDeleteSubtitle,
                style: const TextStyle(color: GridColors.textMuted, fontSize: 13),
              ),
              onTap: _confirmDeleteLeaderboardEntry,
            ),
          if (kDebugMode && _adminUnlocked) ...[
            _SectionLabel(l10n.settingsAdminSection),
            ListTile(
              leading: const Icon(
                Icons.paid_outlined,
                color: GridColors.textPrimary,
              ),
              title: Text(l10n.settingsAdminCoins(snap.coins), style: _tileStyle),
              subtitle: Text(
                l10n.settingsAdminCoinsSubtitle,
                style: const TextStyle(
                  color: GridColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add, color: GridColors.placed),
              title: Text(l10n.settingsAdminAddCoins(1000), style: _tileStyle),
              onTap: () =>
                  ref.read(gameControllerProvider.notifier).grantDebugCoins(1000),
            ),
            ListTile(
              leading: const Icon(Icons.add, color: GridColors.placed),
              title: Text(
                l10n.settingsAdminAddCoins(10000),
                style: _tileStyle,
              ),
              onTap: () =>
                  ref.read(gameControllerProvider.notifier).grantDebugCoins(10000),
            ),
            ListTile(
              leading: const Icon(Icons.exposure_zero, color: GridColors.fever),
              title: Text(l10n.settingsAdminResetCoins, style: _tileStyle),
              onTap: () =>
                  ref.read(gameControllerProvider.notifier).setCoinsForTest(0),
            ),
          ],
          const SizedBox(height: 24),
          Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _onFooterTap,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      l10n.settingsFooter,
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Every bug report has to name a build, otherwise a
                    // playtest with several builds cannot be sorted out.
                    SelectableText(
                      AppInfo.label,
                      style: const TextStyle(
                        color: GridColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SafeArea(top: false, child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

const _tileStyle = TextStyle(color: GridColors.textPrimary);

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: GridColors.textMuted,
          fontSize: 12,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
