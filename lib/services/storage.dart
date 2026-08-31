/// Local persistence for Qubble. Wraps shared_preferences.
///
/// Keys follow MASTERPLAN.md Anhang A.5. There is a single player identity per
/// device (see [playerName]); progress is stored under flat keys. Real-money
/// purchase flags (ad-free, starter pack) belong to the device/store account.
library;

import 'dart:convert';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:shared_preferences/shared_preferences.dart';

import '../game/coach_hints.dart';
import '../game/piggy_bank.dart';
import '../game/stats.dart';

class Storage {
  Storage(this._prefs);

  final SharedPreferences _prefs;

  static const _kHighscore = 'highscore';
  static const _kCoins = 'coins';
  static const _kDiamonds = 'diamonds';
  static const _kStreak = 'streak';
  static const _kLastDailyDate = 'lastDailyDate';
  static const _kActiveTheme = 'activeTheme';
  static const _kUnlockedThemes = 'unlockedThemes';
  static const _kActiveSkin = 'activeSkin';
  static const _kUnlockedSkins = 'unlockedSkins';
  static const _kMissionProgress = 'missionProgress';
  static const _kPuzzleStars = 'puzzleStars';
  static const _kLifetimeStats = 'lifetimeStats';
  static const _kOnboardingDone = 'onboardingDone';
  static const _kHowToPlaySeen = 'howToPlaySeen';
  static const _kHintCombo = 'hint.combo';
  static const _kHintFever = 'hint.fever';
  static const _kHintRotation = 'hint.rotation';
  static const _kHintBooster = 'hint.booster';
  static const _kLastStreakRepair = 'lastStreakRepairDate';
  static const _kXp = 'xp';
  static const _kPlayerLevel = 'playerLevel';
  static const _kPiggyCoins = 'piggyCoins';
  static const _kPiggyCapacity = 'piggyCapacity';
  static const _kSupporter = 'supporter';
  static const _kFirebaseUid = 'fbUid';
  static const _kFirebaseRefreshToken = 'fbRefreshToken';
  static const _kSoundEnabled = 'settings.sound';
  static const _kHapticsEnabled = 'settings.haptics';
  static const _kMusicEnabled = 'settings.music';
  static const _kNotificationsEnabled = 'settings.notifications';
  static const _kStarterStart = 'starterOfferStart';
  static const _kStarterPurchased = 'starterPurchased';
  static const _kLastActiveMillis = 'lastActiveMillis';
  static const _kAppOpenCount = 'appOpenCount';
  static const _kPlayerName = 'playerName';
  static const _kRenameCredits = 'renameCredits';
  static const _kLastSubmittedScore = 'lastSubmittedScore';
  static const _kActiveRun = 'activeRun.v1';
  static const _kAchievements = 'achievements';
  static const _kReviewPromptCount = 'review.promptCount';
  static const _kReviewLastPrompt = 'review.lastPromptMillis';
  static const _kReviewRated = 'review.rated';
  static const _kLanguage = 'settings.language';

  static const _kSchemaVersion = 'schemaVersion';

  static const int startingCoins = 100;

  /// Current on-disk layout. Bump this whenever a stored value changes shape
  /// in a way older data cannot satisfy; [migrate] then clears exactly the
  /// progress keys rather than letting a decode blow up at startup.
  static const int schemaVersion = 1;

  /// Keys holding derived progress. Safe to drop when data is unreadable:
  /// annoying, but the player keeps identity, purchases and settings.
  @visibleForTesting
  static const progressKeys = <String>[
    _kMissionProgress,
    _kPuzzleStars,
    _kLifetimeStats,
    _kActiveRun,
    _kAchievements,
    _kHighscore,
    _kCoins,
    _kDiamonds,
    _kStreak,
    _kLastDailyDate,
    _kLastStreakRepair,
    _kXp,
    _kPlayerLevel,
    _kPiggyCoins,
    _kPiggyCapacity,
    _kLastSubmittedScore,
    _kOnboardingDone,
    _kHowToPlaySeen,
    _kHintCombo,
    _kHintFever,
    _kHintRotation,
    _kHintBooster,
  ];

  /// Real-money entitlements and the player's identity. These must survive a
  /// reset — they belong to the store account, not to the save file. Kept
  /// explicit so a test can prove the two sets never overlap.
  @visibleForTesting
  static const entitlementKeys = <String>[
    _kSupporter,
    _kStarterPurchased,
    _kRenameCredits,
    _kPlayerName,
    _kFirebaseUid,
    _kFirebaseRefreshToken,
    _kUnlockedThemes,
    _kUnlockedSkins,
    _kActiveTheme,
    _kActiveSkin,
  ];

  static Future<Storage> create() async {
    final storage = Storage(await SharedPreferences.getInstance());
    await storage.migrate();
    return storage;
  }

  /// Reconciles the stored layout with [schemaVersion].
  ///
  /// A fresh install and an install written by this same version are both
  /// no-ops. Any *other* stored version — older or newer — has its progress
  /// dropped, because this build cannot know the shape of data it did not
  /// write.
  ///
  /// The older direction is the one the whole mechanism exists for and it used
  /// to be missing: only `stored > schemaVersion` (a downgrade) cleared
  /// anything, while a genuine upgrade just stamped the new number and left
  /// the old data in place. That made [schemaVersion] inert exactly when it
  /// was needed. It never showed, because the version has been 1 since it was
  /// introduced, so no smaller value has ever existed on a device.
  ///
  /// Dropping progress is deliberately blunt: entitlements, identity and
  /// settings survive (see [resetProgress]), and a targeted migration can
  /// always be added later for a specific version step.
  Future<void> migrate() async {
    final stored = _prefs.getInt(_kSchemaVersion);
    if (stored == schemaVersion) return;
    if (stored == null) {
      // Pre-versioning install (or a first launch). Nothing to reshape yet;
      // just stamp it so future migrations have a starting point.
      await _prefs.setInt(_kSchemaVersion, schemaVersion);
      return;
    }
    await resetProgress();
    await _prefs.setInt(_kSchemaVersion, schemaVersion);
  }

  /// Clears derived progress but keeps purchases, identity and settings.
  /// Reachable from the settings screen so a tester with a broken save can
  /// recover without reinstalling.
  Future<void> resetProgress() async {
    for (final key in progressKeys) {
      await _prefs.remove(key);
    }
  }

  /// Decodes the JSON stored under [key], returning [fallback] whenever the
  /// value is missing, not valid JSON, or not the shape [parse] expects.
  ///
  /// Testers receive updates over an existing install, so a save written by an
  /// older build must never be able to take the app down. Two of these getters
  /// are read from [GameController]'s initializer list — a throw there kills
  /// the provider and leaves nothing on screen.
  T _readJsonMap<T>(
    String key,
    T fallback,
    T Function(Map<dynamic, dynamic> decoded) parse,
  ) {
    final raw = _prefs.getString(key);
    if (raw == null) return fallback;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return fallback;
      return parse(decoded);
    } catch (_) {
      return fallback;
    }
  }

  // ---------------------------------------------------------------------------
  // Player identity (single per device; leaderboard name)

  /// The player's display name. Empty until entered on first launch.
  String get playerName => _prefs.getString(_kPlayerName) ?? '';
  Future<void> setPlayerName(String value) =>
      _prefs.setString(_kPlayerName, value.trim());

  bool get hasPlayerName => playerName.isNotEmpty;

  /// Purchased-but-unused name changes (consumable IAP `qubble_rename`). The
  /// name is otherwise fixed after onboarding.
  int get renameCredits => _prefs.getInt(_kRenameCredits) ?? 0;
  Future<void> setRenameCredits(int value) =>
      _prefs.setInt(_kRenameCredits, value < 0 ? 0 : value);

  /// The highest score already pushed to the shared leaderboard, so the app
  /// only prompts to submit when a run beats it.
  int get lastSubmittedScore => _prefs.getInt(_kLastSubmittedScore) ?? 0;
  Future<void> setLastSubmittedScore(int value) =>
      _prefs.setInt(_kLastSubmittedScore, value);

  /// Opaque checkpoint for one unfinished Endless run. Invalid JSON is treated
  /// as absent; the controller performs stricter semantic validation.
  Map<String, dynamic>? get activeRunCheckpoint {
    final raw = _prefs.getString(_kActiveRun);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map ? Map<String, dynamic>.from(decoded) : null;
    } catch (_) {
      return null;
    }
  }

  Future<void> setActiveRunCheckpoint(Map<String, Object?> checkpoint) =>
      _prefs.setString(_kActiveRun, jsonEncode(checkpoint));
  Future<void> clearActiveRunCheckpoint() async {
    await _prefs.remove(_kActiveRun);
  }

  // ---------------------------------------------------------------------------
  // Progress

  int get highscore => _prefs.getInt(_kHighscore) ?? 0;
  Future<void> setHighscore(int value) => _prefs.setInt(_kHighscore, value);

  /// Records [score] if it beats the stored highscore. Returns true if it was
  /// a new record.
  Future<bool> submitScore(int score) async {
    if (score > highscore) {
      await setHighscore(score);
      return true;
    }
    return false;
  }

  int get coins => _prefs.getInt(_kCoins) ?? startingCoins;
  Future<void> setCoins(int value) => _prefs.setInt(_kCoins, value);

  /// Adds [delta] coins (never drops below zero) and returns the new balance.
  Future<int> addCoins(int delta) async {
    final next = (coins + delta).clamp(0, 1 << 31);
    await setCoins(next);
    return next;
  }

  /// Premium diamond balance (skins). Earned via the gold→diamond exchange or
  /// a diamond purchase; never granted for free by gameplay.
  int get diamonds => _prefs.getInt(_kDiamonds) ?? 0;
  Future<void> setDiamonds(int value) =>
      _prefs.setInt(_kDiamonds, value < 0 ? 0 : value);

  /// Adds [delta] diamonds (never below zero) and returns the new balance.
  Future<int> addDiamonds(int delta) async {
    final next = (diamonds + delta).clamp(0, 1 << 31);
    await setDiamonds(next);
    return next;
  }

  /// Mission id -> progress. Always a fresh, mutable map; callers may edit the
  /// result and hand it back to [setMissionProgress].
  Map<String, int> get missionProgress =>
      _readJsonMap(_kMissionProgress, <String, int>{}, (decoded) {
        final out = <String, int>{};
        decoded.forEach((k, v) {
          if (k is String && v is num) out[k] = v.toInt();
        });
        return out;
      });

  Future<void> setMissionProgress(Map<String, int> progress) =>
      _prefs.setString(_kMissionProgress, jsonEncode(progress));

  /// Best stars per puzzle level (level -> stars). Always a fresh, mutable
  /// map; [PuzzleController] edits the result in place before storing it.
  Map<int, int> get puzzleStars =>
      _readJsonMap(_kPuzzleStars, <int, int>{}, (decoded) {
        final out = <int, int>{};
        decoded.forEach((k, v) {
          final level = k is String ? int.tryParse(k) : null;
          if (level != null && v is num) out[level] = v.toInt();
        });
        return out;
      });

  Future<void> setPuzzleStars(Map<int, int> stars) {
    final encoded = stars.map((k, v) => MapEntry(k.toString(), v));
    return _prefs.setString(_kPuzzleStars, jsonEncode(encoded));
  }

  LifetimeStats get lifetimeStats => _readJsonMap(
    _kLifetimeStats,
    const LifetimeStats(),
    (decoded) => LifetimeStats.fromJson(Map<String, dynamic>.from(decoded)),
  );

  Future<void> setLifetimeStats(LifetimeStats stats) =>
      _prefs.setString(_kLifetimeStats, jsonEncode(stats.toJson()));

  int get streak => _prefs.getInt(_kStreak) ?? 0;
  Future<void> setStreak(int value) => _prefs.setInt(_kStreak, value);

  int get playerLevel => _prefs.getInt(_kPlayerLevel) ?? 1;
  Future<void> setPlayerLevel(int value) => _prefs.setInt(_kPlayerLevel, value);

  int get xp => _prefs.getInt(_kXp) ?? 0;
  Future<void> setXp(int value) => _prefs.setInt(_kXp, value);

  PiggyBank get piggyBank => PiggyBank(
    coins: _prefs.getInt(_kPiggyCoins) ?? 0,
    capacity: _prefs.getInt(_kPiggyCapacity) ?? PiggyBank.baseCapacity,
  );

  Future<void> setPiggyBank(PiggyBank piggy) async {
    await _prefs.setInt(_kPiggyCoins, piggy.coins);
    await _prefs.setInt(_kPiggyCapacity, piggy.capacity);
  }

  String? get lastDailyDate => _prefs.getString(_kLastDailyDate);
  Future<void> setLastDailyDate(String key) =>
      _prefs.setString(_kLastDailyDate, key);

  String? get lastStreakRepairDate => _prefs.getString(_kLastStreakRepair);
  Future<void> setLastStreakRepairDate(String key) =>
      _prefs.setString(_kLastStreakRepair, key);

  bool get onboardingDone => _prefs.getBool(_kOnboardingDone) ?? false;

  /// Whether the rules screen has been shown once, unprompted.
  ///
  /// It is otherwise only reachable behind a 21 px help icon next to the
  /// title, so a first-time player never saw the rules at all.
  bool get howToPlaySeen => _prefs.getBool(_kHowToPlaySeen) ?? false;
  Future<void> setHowToPlaySeen(bool value) =>
      _prefs.setBool(_kHowToPlaySeen, value);
  Future<void> setOnboardingDone(bool value) =>
      _prefs.setBool(_kOnboardingDone, value);

  Set<CoachHintType> get seenCoachHints => {
    if (_prefs.getBool(_kHintCombo) ?? false) CoachHintType.combo,
    if (_prefs.getBool(_kHintFever) ?? false) CoachHintType.fever,
    if (_prefs.getBool(_kHintRotation) ?? false) CoachHintType.rotation,
    if (_prefs.getBool(_kHintBooster) ?? false) CoachHintType.booster,
  };

  Future<void> markCoachHintSeen(CoachHintType hint) =>
      _prefs.setBool(_coachHintKey(hint), true);

  static String _coachHintKey(CoachHintType hint) => switch (hint) {
    CoachHintType.combo => _kHintCombo,
    CoachHintType.fever => _kHintFever,
    CoachHintType.rotation => _kHintRotation,
    CoachHintType.booster => _kHintBooster,
  };

  String get activeTheme => _prefs.getString(_kActiveTheme) ?? 'classic';
  Future<void> setActiveTheme(String id) => _prefs.setString(_kActiveTheme, id);

  /// Theme ids the player owns. 'classic' is always included.
  Set<String> get unlockedThemes {
    final list = _prefs.getStringList(_kUnlockedThemes) ?? const [];
    return {'classic', ...list};
  }

  Future<void> setUnlockedThemes(Set<String> ids) =>
      _prefs.setStringList(_kUnlockedThemes, ids.toList());

  /// Adds [id] to the owned themes. Returns true if it was newly unlocked.
  Future<bool> addUnlockedTheme(String id) async {
    final current = unlockedThemes;
    if (current.contains(id)) return false;
    await setUnlockedThemes({...current, id});
    return true;
  }

  String get activeSkin => _prefs.getString(_kActiveSkin) ?? 'classic';
  Future<void> setActiveSkin(String id) => _prefs.setString(_kActiveSkin, id);

  Set<String> get unlockedSkins {
    final list = _prefs.getStringList(_kUnlockedSkins) ?? const [];
    return {'classic', ...list};
  }

  Future<void> setUnlockedSkins(Set<String> ids) =>
      _prefs.setStringList(_kUnlockedSkins, ids.toList());

  /// Adds [id] to the owned skins. Returns true if it was newly unlocked.
  Future<bool> addUnlockedSkin(String id) async {
    final current = unlockedSkins;
    if (current.contains(id)) return false;
    await setUnlockedSkins({...current, id});
    return true;
  }

  // ---------------------------------------------------------------------------
  // Device-global state (settings, purchases, notification bookkeeping)

  /// Whether the supporter pack (non-consumable IAP) is owned.
  bool get supporter => _prefs.getBool(_kSupporter) ?? false;
  Future<void> setSupporter(bool value) => _prefs.setBool(_kSupporter, value);

  /// Silent anonymous Firebase identity for the leaderboard (no visible
  /// login, ever). Created lazily on the first score submission.
  String? get firebaseUid => _prefs.getString(_kFirebaseUid);
  String? get firebaseRefreshToken => _prefs.getString(_kFirebaseRefreshToken);
  Future<void> setFirebaseIdentity({
    required String uid,
    required String refreshToken,
  }) async {
    await _prefs.setString(_kFirebaseUid, uid);
    await _prefs.setString(_kFirebaseRefreshToken, refreshToken);
  }

  /// Forgets the anonymous leaderboard identity.
  ///
  /// Deliberately not part of [resetProgress]: that keeps identity so a player
  /// clearing a broken save does not lose their leaderboard entry. This is the
  /// opposite intent — the player is asking for the entry to be gone, so the
  /// next submit has to start a fresh anonymous user rather than reuse the
  /// document that was just deleted. [lastSubmittedScore] goes too, or the
  /// upload guard would suppress the re-submit if they change their mind.
  Future<void> clearFirebaseIdentity() async {
    await _prefs.remove(_kFirebaseUid);
    await _prefs.remove(_kFirebaseRefreshToken);
    await _prefs.remove(_kLastSubmittedScore);
  }

  int? get starterOfferStart => _prefs.getInt(_kStarterStart);
  Future<void> setStarterOfferStart(int millis) =>
      _prefs.setInt(_kStarterStart, millis);

  bool get starterPurchased => _prefs.getBool(_kStarterPurchased) ?? false;
  Future<void> setStarterPurchased(bool value) =>
      _prefs.setBool(_kStarterPurchased, value);

  bool get soundEnabled => _prefs.getBool(_kSoundEnabled) ?? true;
  Future<void> setSoundEnabled(bool value) =>
      _prefs.setBool(_kSoundEnabled, value);

  bool get hapticsEnabled => _prefs.getBool(_kHapticsEnabled) ?? true;
  Future<void> setHapticsEnabled(bool value) =>
      _prefs.setBool(_kHapticsEnabled, value);

  bool get musicEnabled => _prefs.getBool(_kMusicEnabled) ?? true;
  Future<void> setMusicEnabled(bool value) =>
      _prefs.setBool(_kMusicEnabled, value);

  bool get notificationsEnabled =>
      _prefs.getBool(_kNotificationsEnabled) ?? false;
  Future<void> setNotificationsEnabled(bool value) =>
      _prefs.setBool(_kNotificationsEnabled, value);

  DateTime? get lastActive {
    final ms = _prefs.getInt(_kLastActiveMillis);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  Future<void> setLastActive(DateTime when) =>
      _prefs.setInt(_kLastActiveMillis, when.millisecondsSinceEpoch);

  int get appOpenCount => _prefs.getInt(_kAppOpenCount) ?? 0;
  Future<void> setAppOpenCount(int value) =>
      _prefs.setInt(_kAppOpenCount, value);

  /// Ids of unlocked achievements.
  Set<String> get unlockedAchievements =>
      (_prefs.getStringList(_kAchievements) ?? const []).toSet();

  Future<void> setUnlockedAchievements(Set<String> ids) =>
      _prefs.setStringList(_kAchievements, ids.toList());

  // ---------------------------------------------------------------------------
  // Store rating (see game/review_prompt.dart for the policy)

  /// How often the native rating card was already requested on this install.
  int get reviewPromptCount => _prefs.getInt(_kReviewPromptCount) ?? 0;

  /// When the native rating card was last requested, or null if never.
  DateTime? get reviewLastPromptAt {
    final ms = _prefs.getInt(_kReviewLastPrompt);
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  /// Records one request of the native rating card.
  Future<void> recordReviewPrompt(DateTime when) async {
    await _prefs.setInt(_kReviewPromptCount, reviewPromptCount + 1);
    await _prefs.setInt(_kReviewLastPrompt, when.millisecondsSinceEpoch);
  }

  /// True once the player opened the store listing themselves. The game then
  /// stops requesting the card on its own.
  bool get reviewRated => _prefs.getBool(_kReviewRated) ?? false;
  Future<void> setReviewRated(bool value) =>
      _prefs.setBool(_kReviewRated, value);

  // ---------------------------------------------------------------------------
  // Language

  /// Language override as a locale code ('en', 'de'), or empty to follow the
  /// device language. English is the app's source language and the fallback
  /// for every device language it has no translation for.
  String get languageCode => _prefs.getString(_kLanguage) ?? '';
  Future<void> setLanguageCode(String value) =>
      _prefs.setString(_kLanguage, value);
}
