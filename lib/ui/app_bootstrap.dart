/// Runs one-time monetization init (ads consent + SDK, IAP purchase stream)
/// and wires IAP delivery to entitlements. Wraps the home screen.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../monetization/iap.dart';
import '../monetization/purchase_delivery.dart';
import '../services/notification_planner.dart';
import 'l10n_maps.dart';
import 'screens/home_screen.dart';
import 'screens/how_to_play_screen.dart';
import 'state/game_controller.dart';
import 'state/notifications_controller.dart';
import 'state/settings_controller.dart';
import 'state/skin_controller.dart';
import 'state/theme_controller.dart';

class AppBootstrap extends ConsumerStatefulWidget {
  const AppBootstrap({super.key});

  @override
  ConsumerState<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends ConsumerState<AppBootstrap>
    with WidgetsBindingObserver {
  PurchaseDelivery? _purchaseDelivery;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Fire-and-forget: the UI is usable while ads/IAP warm up.
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Nothing observed the app lifecycle at all, so the music kept playing
  /// after the player switched away, and the run checkpoint was only ever
  /// written on a placement.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        unawaited(ref.read(musicProvider).pauseForBackground());
        unawaited(ref.read(storageProvider).setLastActive(DateTime.now()));
      case AppLifecycleState.resumed:
        unawaited(ref.read(musicProvider).resumeIfEnabled());
      case AppLifecycleState.inactive:
        break;
    }
  }

  /// Surfaces a failed or unavailable purchase. Without this a rejected
  /// purchase and a dead button looked exactly the same.
  void _onPurchaseFailure(IapFailure reason) {
    if (!mounted || reason == IapFailure.canceled) return;
    final message = switch (reason) {
      IapFailure.unavailable => L10n.of(context).iapUnavailable,
      IapFailure.error => L10n.of(context).iapFailed,
      IapFailure.canceled => '',
    };
    ScaffoldMessenger.maybeOf(
      context,
    )?.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _init() async {
    // Force settings creation so sound/haptics flags apply from launch. Each
    // external subsystem is isolated: a store, notification or consent outage
    // must never prevent the remaining startup work.
    ref.read(settingsControllerProvider);
    await _runSafely(
      'in-app purchases',
      () => ref
          .read(iapServiceProvider)
          .initialize(_deliver, onFailure: _onPurchaseFailure),
    );
    await _runSafely('session housekeeping', _sessionStartHousekeeping);
    await _runSafely('first-launch rules', _showRulesOnFirstLaunch);
    await _runSafely(
      'ads/consent',
      () => ref.read(adServiceProvider).initialize(),
    );
  }

  Future<void> _runSafely(
    String subsystem,
    Future<void> Function() task,
  ) async {
    try {
      await task();
    } catch (error) {
      debugPrint('$subsystem initialization failed: $error');
    }
  }

  /// Shows the rules once, on the very first launch.
  ///
  /// The screen was only reachable behind a small help icon, so a first-time
  /// player never met the rules — the in-game coach hints were the entire
  /// explanation. Skippable, and never shown again.
  Future<void> _showRulesOnFirstLaunch() async {
    final storage = ref.read(storageProvider);
    if (storage.howToPlaySeen || storage.onboardingDone) return;
    await storage.setHowToPlaySeen(true);
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const HowToPlayScreen()),
    );
  }

  /// Comeback gift, app-open counting, opt-in prompt, and re-scheduling.
  Future<void> _sessionStartHousekeeping() async {
    final storage = ref.read(storageProvider);
    final now = DateTime.now();

    // Comeback gift for returning after a long absence (before updating time).
    final gift = NotificationPlanner.comebackGift(
      lastActive: storage.lastActive,
      now: now,
    );
    if (gift > 0) {
      await ref.read(gameControllerProvider.notifier).grantCoins(gift);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(L10n.of(context).comebackGift(gift))),
        );
      }
    }
    await storage.setLastActive(now);

    final opens = storage.appOpenCount + 1;
    await storage.setAppOpenCount(opens);

    // Retry a best-score upload that may have failed offline last time.
    ref.read(gameControllerProvider.notifier).autoUploadBestScore();

    // Keep any already-scheduled notifications fresh, in the current language.
    if (mounted) {
      final l10n = L10n.of(context);
      await ref
          .read(notificationsControllerProvider.notifier)
          .refresh(
            texts: notificationTexts(l10n),
            channelDescription: l10n.notificationChannelDescription,
          );
    }

    // Opt-in on the second launch (never on the very first).
    if (opens == 2 && !storage.notificationsEnabled && mounted) {
      await _promptNotificationsOptIn();
    }
  }

  Future<void> _promptNotificationsOptIn() async {
    // Resolved before the dialog awaits, so it survives the async gap.
    final l10n = L10n.of(context);
    final enable = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(L10n.of(context).notificationsOptInTitle),
        content: Text(L10n.of(context).notificationsOptInBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(L10n.of(context).commonNotNow),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(L10n.of(context).notificationsOptInAccept),
          ),
        ],
      ),
    );
    if ((enable ?? false) && mounted) {
      await ref
          .read(notificationsControllerProvider.notifier)
          .enable(
            texts: notificationTexts(l10n),
            channelDescription: l10n.notificationChannelDescription,
          );
    }
  }

  PurchaseDelivery _createPurchaseDelivery() {
    final controller = ref.read(gameControllerProvider.notifier);
    return PurchaseDelivery(
      storage: ref.read(storageProvider),
      grantCoins: controller.grantCoins,
      grantTheme: ref.read(themeControllerProvider.notifier).grantTheme,
      grantSkin: ref.read(skinControllerProvider.notifier).grantSkin,
      markSupporter: controller.applySupporter,
      markStarterPurchased: controller.markStarterPurchased,
      grantRenameCredit: controller.grantRenameCredit,
      analytics: ref.read(analyticsProvider),
    );
  }

  /// Applies a purchased/restored product through one serialized delivery
  /// queue for the lifetime of this app instance.
  Future<void> _deliver(String productId) {
    final delivery = _purchaseDelivery ??= _createPurchaseDelivery();
    return delivery.deliver(productId);
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
