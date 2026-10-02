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
import '../game/daily.dart';
import '../game/name_filter.dart';
import '../game/name_prompt.dart';
import '../game/piggy_bank.dart';
import '../game/quests.dart';
import '../game/stats.dart';
import 'haptics.dart';

class Storage {
  Storage(this._prefs);

  final SharedPreferences _prefs;

  static const _kHighscore = 'highscore';
  static const _kCoins = 'coins';
  static const _kDiamonds = 'diamonds';
  static const _kStreak = 'streak';
  static const _kLastDailyDate = 'lastDailyDate';
  static const _kDailyPlayedDates = 'dailyDatesPlayed';
  static const _kDailyBest = 'dailyBest';
  static const _kLastDailyScore = 'lastDailyScore';
  static const _kActiveTheme = 'activeTheme';
  static const _kUnlockedThemes = 'unlockedThemes';
  static const _kActiveSkin = 'activeSkin';
  static const _kUnlockedSkins = 'unlockedSkins';
  // Accessories and explosions (owner, 30.09.2026), bought with diamonds.
  static const _kAccessoryUnlocked = 'cosmetic.accessory.unlocked';
  static const _kAccessoryActive = 'cosmetic.accessory.active';
  static const _kBurstUnlocked = 'cosmetic.burst.unlocked';
  static const _kBurstActive = 'cosmetic.burst.active';
  static const _kQuests = 'quests';
  /// The career missions the quests replaced (28.09.2026); dropped on the
  /// first quest save.
  static const _kLegacyMissionProgress = 'missionProgress';
  static const _kPuzzleStars = 'puzzleStars';
  static const _kLifetimeStats = 'lifetimeStats';
  static const _kOnboardingDone = 'onboardingDone';
  static const _kHowToPlaySeen = 'howToPlaySeen';
  static const _kHintCombo = 'hint.combo';
  static const _kHintFever = 'hint.fever';
  static const _kHintRotation = 'hint.rotation';
  static const _kHintBooster = 'hint.booster';
  static const _kHintStrategy = 'hint.strategy';
  static const _kLastStreakRepair = 'lastStreakRepairDate';
  static const _kXp = 'xp';
  static const _kPlayerLevel = 'playerLevel';
  static const _kPiggyCoins = 'piggyCoins';
  static const _kPiggyCapacity = 'piggyCapacity';
  static const _kPiggyFullSeen = 'piggy.fullSeen';
  static const _kSupporter = 'supporter';
  static const _kFirebaseUid = 'fbUid';
  static const _kFirebaseRefreshToken = 'fbRefreshToken';
  static const _kSoundEnabled = 'settings.sound';
  static const _kHapticsEnabled = 'settings.haptics';
  static const _kHapticStrength = 'settings.hapticStrength';
  static const _kReducedEffects = 'settings.reducedEffects';
  static const _kBlockedNames = 'leaderboard.blockedNames';
  static const _kMusicEnabled = 'settings.music';
  static const _kNotificationsEnabled = 'settings.notifications';
  static const _kStarterStart = 'starterOfferStart';
  static const _kStarterPurchased = 'starterPurchased';
  static const _kLastActiveMillis = 'lastActiveMillis';
  static const _kAppOpenCount = 'appOpenCount';
  static const _kPlayerName = 'playerName';
  static const _kRenameCredits = 'renameCredits';
  static const _kNamePromptStage = 'namePrompt.stage';
  static const _kNameToRelease = 'nameToRelease';
  static const _kLostName = 'lostName';
  static const _kLastSubmittedScore = 'lastSubmittedScore';
  static const _kLastSubmittedPuzzleStars = 'lastSubmittedPuzzleStars';
  static const _kPendingDaily = 'leaderboard.pendingDaily';
  static const _kFreeRewardPrefix = 'freeReward.';
  static const _kDailySubmittedDays = 'leaderboard.dailyDays';
  static const _kActiveRun = 'activeRun.v1';
  static const _kAchievements = 'achievements';
  static const _kAchievementRewardsPaid = 'achievements.rewardsPaid';
  static const _kPlayGamesPlayer = 'playGames.player';
  static const _kPlayGamesAchievements = 'playGames.achievementsSent';
  static const _kPlayGamesBestScore = 'playGames.bestScoreSent';
  static const _kPlayGamesStreak = 'playGames.streakSent';
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
    _kQuests,
    _kLegacyMissionProgress,
    _kPuzzleStars,
    _kLifetimeStats,
    _kActiveRun,
    _kAchievements,
    _kAchievementRewardsPaid,
    _kHighscore,
    _kCoins,
    _kDiamonds,
    _kStreak,
    _kLastDailyDate,
    _kDailyPlayedDates,
    _kDailyBest,
    _kLastDailyScore,
    _kLastStreakRepair,
    _kXp,
    _kPlayerLevel,
    _kPiggyCoins,
    _kPiggyCapacity,
    _kPiggyFullSeen,
    _kLastSubmittedScore,
    _kLastSubmittedPuzzleStars,
    _kPendingDaily,
    '${_kFreeRewardPrefix}coins',
    '${_kFreeRewardPrefix}diamonds',
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
    _kDailySubmittedDays,
    _kUnlockedThemes,
    _kUnlockedSkins,
    _kActiveTheme,
    _kActiveSkin,
    _kAccessoryUnlocked,
    _kAccessoryActive,
    _kBurstUnlocked,
    _kBurstActive,
    // What already reached the Play Games account, which a reset cannot
    // take back there either.
    _kPlayGamesPlayer,
    _kPlayGamesAchievements,
    _kPlayGamesBestScore,
    _kPlayGamesStreak,
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

  /// The player's display name. Empty until chosen (it is optional).
  String get playerName => _prefs.getString(_kPlayerName) ?? '';
  Future<void> setPlayerName(String value) =>
      _prefs.setString(_kPlayerName, NameFilter.canonical(value));

  /// Forgets the display name, e.g. when another player turned out to hold
  /// it. The player is then asked again, as if they had never chosen one.
  Future<void> clearPlayerName() => _prefs.remove(_kPlayerName);

  /// How far the "join the leaderboard?" question has got ([NamePrompt]).
  /// Not progress: a reset save must not start asking again.
  NamePromptStage get namePromptStage =>
      NamePromptStage.fromIndex(_prefs.getInt(_kNamePromptStage));
  Future<void> setNamePromptStage(NamePromptStage stage) =>
      _prefs.setInt(_kNamePromptStage, stage.index);

  /// A name this player gave up (renamed away from) whose server reservation
  /// could not be released yet; retried on the next upload so the name does
  /// not stay blocked for everyone else.
  String? get nameToRelease => _prefs.getString(_kNameToRelease);
  Future<void> setNameToRelease(String? name) => name == null
      ? _prefs.remove(_kNameToRelease)
      : _prefs.setString(_kNameToRelease, name);

  /// The name this player had until it turned out another player holds it
  /// (names chosen before 1.4.0 were never reserved). Shown when they are
  /// asked for a new one, so the question does not come out of nowhere.
  String? get lostName => _prefs.getString(_kLostName);
  Future<void> setLostName(String? name) => name == null
      ? _prefs.remove(_kLostName)
      : _prefs.setString(_kLostName, name);

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

  /// The puzzle stars already pushed to the puzzle ranking; like
  /// [lastSubmittedScore].
  int get lastSubmittedPuzzleStars =>
      _prefs.getInt(_kLastSubmittedPuzzleStars) ?? 0;
  Future<void> setLastSubmittedPuzzleStars(int value) =>
      _prefs.setInt(_kLastSubmittedPuzzleStars, value);

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

  /// Premium diamond balance (skins). Earned via the gold→diamond exchange, a
  /// diamond purchase, or a finished set of quests (5 / 20 / 60, the owner's
  /// decision of 28.09.2026 — before that, gameplay never granted any).
  int get diamonds => _prefs.getInt(_kDiamonds) ?? 0;
  Future<void> setDiamonds(int value) =>
      _prefs.setInt(_kDiamonds, value < 0 ? 0 : value);

  /// Adds [delta] diamonds (never below zero) and returns the new balance.
  Future<int> addDiamonds(int delta) async {
    final next = (diamonds + delta).clamp(0, 1 << 31);
    await setDiamonds(next);
    return next;
  }

  /// Progress of the daily, weekly and monthly quests. A period that is
  /// missing or unreadable starts fresh.
  Map<QuestPeriod, QuestProgress> get questProgress => _readJsonMap(
        _kQuests,
        <QuestPeriod, QuestProgress>{},
        (decoded) => {
          for (final period in QuestPeriod.values)
            if (decoded[period.name] != null)
              period: QuestProgress.fromJson(decoded[period.name]),
        },
      );

  Future<void> setQuestProgress(Map<QuestPeriod, QuestProgress> state) async {
    await _prefs.setString(
      _kQuests,
      jsonEncode({
        for (final e in state.entries) e.key.name: e.value.toJson(),
      }),
    );
    await _prefs.remove(_kLegacyMissionProgress);
  }

  /// All puzzle stars: the best per solved level, summed. The puzzle
  /// ranking's score.
  int get puzzleStarTotal =>
      puzzleStars.values.fold(0, (sum, stars) => sum + stars);

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
    // Below full again (emptied): the next time it fills, it blinks again.
    if (!piggy.isFull) await _prefs.remove(_kPiggyFullSeen);
  }

  /// Whether the player tapped the full piggy bank since it became full; it
  /// blinks on the home screen until then ([PiggyAttention]).
  bool get piggyFullSeen => _prefs.getBool(_kPiggyFullSeen) ?? false;
  Future<void> setPiggyFullSeen() => _prefs.setBool(_kPiggyFullSeen, true);

  String? get lastDailyDate => _prefs.getString(_kLastDailyDate);
  Future<void> setLastDailyDate(String key) =>
      _prefs.setString(_kLastDailyDate, key);

  /// Every daily day played, newest last, capped by
  /// [DailyChallenge.playedHistoryDays]. Feeds the calendar on the daily
  /// screen; `lastDailyDate` alone can only ever answer "today or not".
  List<String> get dailyPlayedDates =>
      _prefs.getStringList(_kDailyPlayedDates) ?? const [];

  Future<void> markDailyPlayed(String key) => _prefs.setStringList(
    _kDailyPlayedDates,
    DailyChallenge.recordPlayed(dailyPlayedDates, key),
  );

  /// Best score reached in a daily run. Separate from the endless highscore:
  /// every player faces the same board, so this is the only score in the game
  /// that is comparable between two players without a leaderboard.
  int get dailyBest => _prefs.getInt(_kDailyBest) ?? 0;

  Future<void> setDailyBest(int value) => _prefs.setInt(_kDailyBest, value);

  /// Score of the last counted Daily (the day is [lastDailyDate]), for the
  /// stars the Daily screen shows for today.
  int get lastDailyScore => _prefs.getInt(_kLastDailyScore) ?? 0;
  Future<void> setLastDailyScore(int value) =>
      _prefs.setInt(_kLastDailyScore, value);

  /// The counted Daily that still has to reach the day's ranking, as
  /// `(day, score)`; null when there is none.
  ({String day, int score})? get pendingDaily {
    final raw = _prefs.getString(_kPendingDaily);
    final parts = raw?.split('|');
    if (parts == null || parts.length != 2) return null;
    final score = int.tryParse(parts[1]);
    if (score == null) return null;
    return (day: parts[0], score: score);
  }

  Future<void> setPendingDaily(({String day, int score})? entry) =>
      entry == null
      ? _prefs.remove(_kPendingDaily)
      : _prefs.setString(_kPendingDaily, '${entry.day}|${entry.score}');

  /// Every day this identity entered the Daily ranking, so deleting the
  /// entry can find them all. Part of the identity: it survives a progress
  /// reset and goes with [clearFirebaseIdentity].
  List<String> get dailySubmittedDays =>
      _prefs.getStringList(_kDailySubmittedDays) ?? const [];

  Future<void> addDailySubmittedDay(String day) async {
    final days = dailySubmittedDays;
    if (days.contains(day)) return;
    await _prefs.setStringList(_kDailySubmittedDays, [...days, day]);
  }

  /// The shop's reward videos of one kind: the day they were last watched
  /// (yyyy-mm-dd) and how many that day; (null, 0) before the first.
  ({String? day, int used}) freeRewardRecord(String kind) {
    final raw = _prefs.getString('$_kFreeRewardPrefix$kind')?.split('|');
    if (raw == null || raw.length != 2) return (day: null, used: 0);
    return (day: raw[0], used: int.tryParse(raw[1]) ?? 0);
  }

  Future<void> setFreeRewardRecord(String kind, String day, int used) =>
      _prefs.setString('$_kFreeRewardPrefix$kind', '$day|$used');

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
    if (_prefs.getBool(_kHintStrategy) ?? false) CoachHintType.strategy,
  };

  Future<void> markCoachHintSeen(CoachHintType hint) =>
      _prefs.setBool(_coachHintKey(hint), true);

  static String _coachHintKey(CoachHintType hint) => switch (hint) {
    CoachHintType.combo => _kHintCombo,
    CoachHintType.fever => _kHintFever,
    CoachHintType.rotation => _kHintRotation,
    CoachHintType.booster => _kHintBooster,
    CoachHintType.strategy => _kHintStrategy,
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

  /// Owned accessories or explosions ([kind] `accessory` or `burst`); the
  /// free default ([defaultId]) is always owned.
  Set<String> unlockedCosmetics(String kind, String defaultId) {
    final list = _prefs.getStringList(_cosmeticKey(kind, 'unlocked')) ??
        const <String>[];
    return {defaultId, ...list};
  }

  Future<void> setUnlockedCosmetics(String kind, Set<String> ids) =>
      _prefs.setStringList(_cosmeticKey(kind, 'unlocked'), ids.toList());

  String activeCosmetic(String kind, String defaultId) =>
      _prefs.getString(_cosmeticKey(kind, 'active')) ?? defaultId;

  Future<void> setActiveCosmetic(String kind, String id) =>
      _prefs.setString(_cosmeticKey(kind, 'active'), id);

  static String _cosmeticKey(String kind, String field) => switch ((
    kind,
    field,
  )) {
    ('accessory', 'unlocked') => _kAccessoryUnlocked,
    ('accessory', 'active') => _kAccessoryActive,
    ('burst', 'unlocked') => _kBurstUnlocked,
    ('burst', 'active') => _kBurstActive,
    _ => throw ArgumentError('unknown cosmetic $kind.$field'),
  };

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
    await _prefs.remove(_kLastSubmittedPuzzleStars);
    await _prefs.remove(_kDailySubmittedDays);
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

  /// Haptic strength (MASTERPLAN.md D.5.3).
  ///
  /// Falls back to the older on/off flag so nobody who already turned haptics
  /// off gets them back when they update: off stays off, on becomes strong,
  /// which is what the single-strength build always played.
  HapticStrength get hapticStrength {
    final stored = _prefs.getString(_kHapticStrength);
    if (stored != null) {
      for (final value in HapticStrength.values) {
        if (value.name == stored) return value;
      }
    }
    return hapticsEnabled ? HapticStrength.strong : HapticStrength.off;
  }

  Future<void> setHapticStrength(HapticStrength value) async {
    await _prefs.setString(_kHapticStrength, value.name);
    // Keep the old flag in step: other code (and any older build the player
    // rolls back to) still reads it.
    await setHapticsEnabled(value != HapticStrength.off);
  }

  /// Leaderboard names this player has blocked.
  ///
  /// Google's UGC policy requires a way to block user-generated content, not
  /// only to report it. Qubble has no backend that could act on a report, so
  /// blocking is local and immediate: the entry disappears for this player
  /// straight away, which is the part a report cannot deliver.
  ///
  /// Stored by name rather than by id because the leaderboard document id is
  /// the author's anonymous uid, which never reaches the client -- and because
  /// the name is the objectionable content in the first place.
  Set<String> get blockedNames =>
      (_prefs.getStringList(_kBlockedNames) ?? const <String>[]).toSet();

  Future<void> setBlockedNames(Set<String> names) =>
      _prefs.setStringList(_kBlockedNames, names.toList()..sort());

  Future<void> blockName(String name) =>
      setBlockedNames({...blockedNames, name});

  Future<void> unblockName(String name) =>
      setBlockedNames({...blockedNames}..remove(name));

  /// Fewer particles, no screen shake, no glow (MASTERPLAN.md D.5.1).
  bool get reducedEffects => _prefs.getBool(_kReducedEffects) ?? false;
  Future<void> setReducedEffects(bool value) =>
      _prefs.setBool(_kReducedEffects, value);

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

  /// Ids of achievements whose reward (coins or skin) has been paid out.
  ///
  /// Kept apart from [unlockedAchievements] because the rewards came later
  /// (28.09.2026): players who unlocked achievements before that are owed
  /// them, and this set is how the back-pay knows what is still open.
  Set<String> get paidAchievementRewards =>
      (_prefs.getStringList(_kAchievementRewardsPaid) ?? const []).toSet();

  Future<void> setPaidAchievementRewards(Set<String> ids) =>
      _prefs.setStringList(_kAchievementRewardsPaid, ids.toList());

  // ---------------------------------------------------------------------------
  // Play Games Services (see services/play_games.dart)

  /// The Play Games player the sent-state below belongs to.
  String? get playGamesPlayer => _prefs.getString(_kPlayGamesPlayer);

  /// Starts the sent-state over for [player].
  Future<void> resetPlayGamesSent(String player) async {
    await _prefs.setString(_kPlayGamesPlayer, player);
    await _prefs.remove(_kPlayGamesAchievements);
    await _prefs.remove(_kPlayGamesBestScore);
    await _prefs.remove(_kPlayGamesStreak);
  }

  /// Qubble ids of the achievements Play Games already has unlocked.
  Set<String> get playGamesAchievementsSent =>
      (_prefs.getStringList(_kPlayGamesAchievements) ?? const []).toSet();

  Future<void> setPlayGamesAchievementsSent(Set<String> ids) =>
      _prefs.setStringList(_kPlayGamesAchievements, ids.toList());

  /// Highest best score the Play Games leaderboard already has.
  int get playGamesBestScoreSent => _prefs.getInt(_kPlayGamesBestScore) ?? 0;

  Future<void> setPlayGamesBestScoreSent(int value) =>
      _prefs.setInt(_kPlayGamesBestScore, value);

  /// Daily streak last sent to the Play Games leaderboard.
  int get playGamesStreakSent => _prefs.getInt(_kPlayGamesStreak) ?? 0;

  Future<void> setPlayGamesStreakSent(int value) =>
      _prefs.setInt(_kPlayGamesStreak, value);

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

  /// Language override as a locale code ('en', 'de', …), or empty to follow the
  /// device language. English is the app's source language and the fallback
  /// for every device language it has no translation for.
  String get languageCode => _prefs.getString(_kLanguage) ?? '';
  Future<void> setLanguageCode(String value) =>
      _prefs.setString(_kLanguage, value);
}
