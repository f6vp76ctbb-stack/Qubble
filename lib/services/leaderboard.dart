/// Shared leaderboard on Firestore — account-free by design.
///
/// Reads the top list via the public Firestore REST API and submits scores
/// under a silent anonymous Firebase-Auth identity (created lazily on the
/// first submit; players never see any login UI). Pure Dart + http, so it
/// behaves identically on native and web and is fully unit-testable with a
/// fake client. Server-side enforcement lives in `firebase/firestore.rules`.
library;

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../game/name_filter.dart';
import 'firebase_config.dart';
import 'storage.dart';

/// One row on the leaderboard.
class LeaderboardEntry {
  const LeaderboardEntry({required this.name, required this.score});

  final String name;
  final int score;
}

/// Client-side mirror of the Firestore security rules (the rules are the
/// actual gate; this just avoids pointless requests). A name is 2–14
/// characters in [NameFilter.canonical] form: no leading, trailing or double
/// spaces, so that two names cannot differ in spacing alone.
final RegExp kLeaderboardNameRule = RegExp(
  '^(?=.{2,14}\$)[${NameFilter.nameCharacters}]+'
  '( [${NameFilter.nameCharacters}]+)*\$',
);

/// Outcome of entering a Daily ranking.
enum DailySubmit {
  /// The entry is in.
  stored,

  /// There already was one for this day; entries are written once.
  alreadyStored,

  /// The server (or the client-side check) will never take it.
  refused,

  /// Could not ask: offline or a server error. Worth another try.
  failed,
}

/// Outcome of trying to take a display name.
enum NameClaim {
  /// The name belongs to this player now (or already did).
  claimed,

  /// Another player holds it.
  taken,

  /// Nothing was decided: offline, a timeout, or the server refused the
  /// request (for example while the rules that allow `names` are not
  /// published yet). Never reported as [taken] — that would send a player
  /// looking for a new name when theirs was free.
  failed,
}

const int kLeaderboardMaxScore = 100000000;

/// Parses a Firestore `runQuery` REST response (a JSON array of rows with an
/// optional `document`), dropping malformed rows; sorted by score descending.
List<LeaderboardEntry> parseRunQueryResponse(String body) {
  final decoded = jsonDecode(body);
  if (decoded is! List) return const [];

  final entries = <LeaderboardEntry>[];
  for (final row in decoded) {
    if (row is! Map) continue;
    final document = row['document'];
    if (document is! Map) continue;
    final fields = document['fields'];
    if (fields is! Map) continue;

    final name = _stringField(fields, 'name');
    final score = _intField(fields, 'score');
    if (name != null &&
        kLeaderboardNameRule.hasMatch(name) &&
        score != null &&
        score > 0 &&
        score <= kLeaderboardMaxScore) {
      entries.add(LeaderboardEntry(name: name, score: score));
    }
  }
  entries.sort((a, b) => b.score.compareTo(a.score));
  return entries;
}

String? _stringField(Map<dynamic, dynamic> fields, String key) {
  final field = fields[key];
  if (field is! Map) return null;
  final value = field['stringValue'];
  return value is String ? value : null;
}

int? _intField(Map<dynamic, dynamic> fields, String key) {
  final field = fields[key];
  if (field is! Map) return null;
  // Firestore REST encodes integerValue as a string.
  final value = field['integerValue'];
  if (value is String) return int.tryParse(value);
  if (value is num) return value.toInt();
  return null;
}

/// Firestore-backed leaderboard client.
class LeaderboardService {
  LeaderboardService({
    http.Client? client,
    this.storage,
    this.projectId = FirebaseConfig.projectId,
    this.apiKey = FirebaseConfig.apiKey,
    this.readTimeout = defaultReadTimeout,
    this.writeTimeout = defaultWriteTimeout,
  }) : _client = client ?? http.Client();

  final http.Client _client;

  /// Needed only for submitting (persists the anonymous identity); reading
  /// works without it.
  final Storage? storage;

  final String projectId;
  final String apiKey;

  static const _firestoreHost = 'firestore.googleapis.com';
  static const _collection = 'leaderboard';

  /// The puzzle ranking (owner, 29.09.2026): total stars over all solved
  /// levels, the best per level. Same document shape and rules as the score
  /// board — `score` holds the stars.
  static const _puzzleCollection = 'puzzleLeaderboard';

  /// The Daily's ranking (owner, 29.09.2026): `dailyLeaderboard/{day}/
  /// entries/{uid}`, one entry per player and day, written once.
  static const _daily = 'dailyLeaderboard';
  static const _dailyEntries = 'entries';

  /// One document per display name, id = the name itself, field `uid` = its
  /// holder. Firestore allows only one document per id and the rules allow
  /// creating but never updating one, so a name can have only one holder —
  /// and the rules only accept a leaderboard entry whose name the writer
  /// holds.
  static const _names = 'names';

  /// How long a read may take before the UI is told it failed.
  ///
  /// Without a bound, a connection that accepts but never answers — a captive
  /// portal, a dying signal — leaves the leaderboard spinning forever. The
  /// retry button only appears in the error state, which such a connection
  /// never reaches, so the screen had no way out but the back button.
  static const Duration defaultReadTimeout = Duration(seconds: 10);

  /// Longer than the read timeout: a write is worth more patience, and its
  /// caller is a background upload nobody is waiting on.
  static const Duration defaultWriteTimeout = Duration(seconds: 30);

  /// Overridable so a test can assert the bound without waiting for it.
  final Duration readTimeout;
  final Duration writeTimeout;

  String get _documentsPath =>
      '/v1/projects/$projectId/databases/(default)/documents';

  /// Fetches the top [limit] entries. Throws on network/HTTP errors so the
  /// UI can show its retry state.
  Future<List<LeaderboardEntry>> fetchTop({int limit = 50}) =>
      _fetchTop(_collection, limit);

  /// The puzzle ranking by total stars; otherwise like [fetchTop].
  Future<List<LeaderboardEntry>> fetchTopPuzzle({int limit = 50}) =>
      _fetchTop(_puzzleCollection, limit);

  /// The Daily's ranking for [day] (yyyy-mm-dd), best first.
  Future<List<LeaderboardEntry>> fetchDailyTop(String day, {int limit = 50}) =>
      _fetchTop(_dailyEntries, limit, parent: '/$_daily/$day');

  Future<List<LeaderboardEntry>> _fetchTop(
    String collection,
    int limit, {
    String parent = '',
  }) async {
    final uri = Uri.https(_firestoreHost, '$_documentsPath$parent:runQuery', {
      'key': apiKey,
    });
    final res = await _client
        .post(
          uri,
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'structuredQuery': {
              'from': [
                {'collectionId': collection},
              ],
              'orderBy': [
                {
                  'field': {'fieldPath': 'score'},
                  'direction': 'DESCENDING',
                },
              ],
              'limit': limit,
            },
          }),
        )
        .timeout(readTimeout);
    if (res.statusCode != 200) {
      throw Exception('Leaderboard HTTP ${res.statusCode}');
    }
    return parseRunQueryResponse(res.body);
  }

  /// Submits the player's best score under their silent anonymous identity.
  /// Returns true on success; returns false (never throws) on any failure —
  /// offline play must degrade quietly. The security rules reject lowering
  /// an existing score.
  Future<bool> submit({required String name, required int score}) =>
      _submit(_collection, name, score);

  /// Submits the player's total puzzle stars; otherwise like [submit].
  Future<bool> submitPuzzle({required String name, required int stars}) =>
      _submit(_puzzleCollection, name, stars);

  Future<bool> _submit(String collection, String name, int score) async {
    final trimmed = NameFilter.canonical(name);
    if (!kLeaderboardNameRule.hasMatch(trimmed) ||
        score <= 0 ||
        score > kLeaderboardMaxScore) {
      return false;
    }
    try {
      final identity = await _ensureIdentity();
      if (identity == null) return false;

      final uri = Uri.https(
        _firestoreHost,
        '$_documentsPath/$collection/${identity.uid}',
        {'key': apiKey},
      );
      final res = await _client
          .patch(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${identity.idToken}',
            },
            body: jsonEncode({
              'fields': {
                'name': {'stringValue': trimmed},
                'score': {'integerValue': '$score'},
              },
            }),
          )
          .timeout(writeTimeout);
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Enters the Daily of [day] with [score]. Written once: a second entry for
  /// the same day is [DailySubmit.alreadyStored], never an improvement.
  Future<DailySubmit> submitDaily({
    required String name,
    required int score,
    required String day,
  }) async {
    final trimmed = NameFilter.canonical(name);
    if (!kLeaderboardNameRule.hasMatch(trimmed) ||
        score <= 0 ||
        score > kLeaderboardMaxScore) {
      return DailySubmit.refused;
    }
    try {
      final identity = await _ensureIdentity();
      if (identity == null) return DailySubmit.failed;
      final uri = Uri.https(
        _firestoreHost,
        '$_documentsPath/$_daily/$day/$_dailyEntries',
        {'documentId': identity.uid, 'key': apiKey},
      );
      final res = await _client
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${identity.idToken}',
            },
            body: jsonEncode({
              'fields': {
                'name': {'stringValue': trimmed},
                'score': {'integerValue': '$score'},
              },
            }),
          )
          .timeout(writeTimeout);
      return switch (res.statusCode) {
        200 => DailySubmit.stored,
        409 => DailySubmit.alreadyStored,
        // The rules said no: a day too far back, or a name not held. Trying
        // again would get the same answer.
        403 => DailySubmit.refused,
        _ => DailySubmit.failed,
      };
    } catch (_) {
      return DailySubmit.failed;
    }
  }

  /// Where [score] stands in the Daily of [day]: 1 + the entries that beat
  /// it, out of all entries. [entered] says whether the player's own entry
  /// is among them; if not (no name yet), they are counted in on top, so the
  /// answer reads the same either way. Null when the server could not be
  /// asked.
  Future<({int rank, int total})?> dailyRank({
    required String day,
    required int score,
    bool entered = true,
  }) async {
    try {
      final better = await _countDaily(day, above: score);
      final all = await _countDaily(day);
      if (better == null || all == null) return null;
      final rank = better + 1;
      final total = entered ? all : all + 1;
      return (rank: rank, total: total < rank ? rank : total);
    } catch (_) {
      return null;
    }
  }

  Future<int?> _countDaily(String day, {int? above}) async {
    final uri = Uri.https(
      _firestoreHost,
      '$_documentsPath/$_daily/$day:runAggregationQuery',
      {'key': apiKey},
    );
    final res = await _client
        .post(
          uri,
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({
            'structuredAggregationQuery': {
              'structuredQuery': {
                'from': [
                  {'collectionId': _dailyEntries},
                ],
                if (above != null)
                  'where': {
                    'fieldFilter': {
                      'field': {'fieldPath': 'score'},
                      'op': 'GREATER_THAN',
                      'value': {'integerValue': '$above'},
                    },
                  },
              },
              'aggregations': [
                {'alias': 'n', 'count': <String, Object>{}},
              ],
            },
          }),
        )
        .timeout(readTimeout);
    if (res.statusCode != 200) return null;
    final decoded = jsonDecode(res.body);
    if (decoded is! List || decoded.isEmpty) return null;
    final value =
        (decoded.first
            as Map)['result']?['aggregateFields']?['n']?['integerValue'];
    return value == null ? null : int.tryParse('$value');
  }

  /// Deletes the player's own leaderboard entries (score and puzzle).
  ///
  /// Returns true when the entry is gone — including when there was nothing to
  /// delete, since the caller only cares that no entry remains. Returns false
  /// when the request could not be made or the server refused it, so the UI
  /// can say the entry is still there rather than claim a deletion that did
  /// not happen.
  ///
  /// The server-side gate is `allow delete: if isOwner(uid)` in
  /// `firebase/firestore.rules`; this can therefore only ever remove the
  /// caller's own document.
  Future<bool> deleteEntry({List<String> dailyDays = const []}) async {
    final storage = this.storage;
    if (storage == null) return false;
    // No identity means nothing was ever submitted from this device.
    final storedUid = storage.firebaseUid;
    if (storedUid == null) return true;
    try {
      final identity = await _ensureIdentity();
      if (identity == null) return false;
      // A revoked or expired refresh token makes _ensureIdentity mint a FRESH
      // anonymous user. Deleting under that uid would remove a document that
      // does not exist, return 404, and report success while the player's
      // actual entry stayed up. Only ever delete the identity we already held.
      if (identity.uid != storedUid) return false;

      // Both rankings: the entry is the player's name in public, wherever
      // it shows.
      for (final collection in [
        _collection,
        _puzzleCollection,
        for (final day in dailyDays) '$_daily/$day/$_dailyEntries',
      ]) {
        final uri = Uri.https(
          _firestoreHost,
          '$_documentsPath/$collection/${identity.uid}',
          {'key': apiKey},
        );
        final res = await _client
            .delete(
              uri,
              headers: {'Authorization': 'Bearer ${identity.idToken}'},
            )
            .timeout(writeTimeout);
        // Firestore answers 200 for a delete and 404 when the document is
        // already gone; both mean there is no entry left.
        if (res.statusCode != 200 && res.statusCode != 404) return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Takes [name] for this player, unless another player holds it.
  ///
  /// Checks the reservation first, so a name this player already holds is
  /// [NameClaim.claimed] without a write. Creating goes through
  /// `createDocument`, which fails with 409 when the id exists: two players
  /// racing for one name cannot both win, whatever the check said.
  Future<NameClaim> claimName(String name) async {
    final canonical = NameFilter.canonical(name);
    if (!kLeaderboardNameRule.hasMatch(canonical)) return NameClaim.failed;
    try {
      final identity = await _ensureIdentity();
      if (identity == null) return NameClaim.failed;
      final holder = await _nameHolder(canonical, identity.idToken);
      if (holder.failed) return NameClaim.failed;
      if (holder.uid != null) {
        return holder.uid == identity.uid ? NameClaim.claimed : NameClaim.taken;
      }
      final res = await _client
          .post(
            Uri.https(_firestoreHost, '$_documentsPath/$_names', {
              'documentId': canonical,
              'key': apiKey,
            }),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${identity.idToken}',
            },
            body: jsonEncode({
              'fields': {
                'uid': {'stringValue': identity.uid},
              },
            }),
          )
          .timeout(writeTimeout);
      if (res.statusCode == 200) return NameClaim.claimed;
      if (res.statusCode == 409) return NameClaim.taken;
      return NameClaim.failed;
    } catch (_) {
      return NameClaim.failed;
    }
  }

  /// Gives [name] back, so another player can take it.
  ///
  /// Returns true when this player no longer holds it — also when they never
  /// did, or when the name is held under an identity this device no longer
  /// has (nothing can release that one from here). Returns false only when a
  /// release that is possible did not happen, so the caller can retry.
  Future<bool> releaseName(String name) async {
    final storage = this.storage;
    if (storage == null) return false;
    final storedUid = storage.firebaseUid;
    if (storedUid == null) return true;
    final canonical = NameFilter.canonical(name);
    if (!kLeaderboardNameRule.hasMatch(canonical)) return true;
    try {
      final identity = await _ensureIdentity();
      if (identity == null) return false;
      // As in deleteEntry: a fresh identity cannot own the old reservation.
      if (identity.uid != storedUid) return true;
      final holder = await _nameHolder(canonical, identity.idToken);
      if (holder.failed) return false;
      if (holder.uid != identity.uid) return true;
      final res = await _client
          .delete(
            Uri.https(_firestoreHost, '$_documentsPath/$_names/$canonical', {
              'key': apiKey,
            }),
            headers: {'Authorization': 'Bearer ${identity.idToken}'},
          )
          .timeout(writeTimeout);
      return res.statusCode == 200 || res.statusCode == 404;
    } catch (_) {
      return false;
    }
  }

  /// Who holds [name]: a uid, nobody (`uid` null), or unknown (`failed`).
  Future<({String? uid, bool failed})> _nameHolder(
    String name,
    String idToken,
  ) async {
    final res = await _client
        .get(
          Uri.https(_firestoreHost, '$_documentsPath/$_names/$name', {
            'key': apiKey,
          }),
          headers: {'Authorization': 'Bearer $idToken'},
        )
        .timeout(readTimeout);
    if (res.statusCode == 404) return (uid: null, failed: false);
    if (res.statusCode != 200) return (uid: null, failed: true);
    final data = jsonDecode(res.body);
    final fields = data is Map ? data['fields'] : null;
    final uid = fields is Map ? _stringField(fields, 'uid') : null;
    // A document without a readable holder cannot be claimed or released
    // safely; treat it as unknown rather than as free.
    if (uid == null) return (uid: null, failed: true);
    return (uid: uid, failed: false);
  }

  /// Returns a usable anonymous identity: refreshes the stored one, or signs
  /// up a fresh anonymous user on first use (or when the token was revoked).
  Future<({String uid, String idToken})?> _ensureIdentity() async {
    final storage = this.storage;
    if (storage == null) return null;

    final uid = storage.firebaseUid;
    final refreshToken = storage.firebaseRefreshToken;
    if (uid != null && refreshToken != null) {
      final res = await _client
          .post(
            Uri.https('securetoken.googleapis.com', '/v1/token', {
              'key': apiKey,
            }),
            body: {
              'grant_type': 'refresh_token',
              'refresh_token': refreshToken,
            },
          )
          .timeout(writeTimeout);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final idToken = data is Map ? data['id_token'] : null;
        if (idToken is String) return (uid: uid, idToken: idToken);
      }
      // Fall through: token revoked/expired — start a fresh identity.
    }

    final res = await _client
        .post(
          Uri.https('identitytoolkit.googleapis.com', '/v1/accounts:signUp', {
            'key': apiKey,
          }),
          headers: const {'Content-Type': 'application/json'},
          body: jsonEncode({'returnSecureToken': true}),
        )
        .timeout(writeTimeout);
    if (res.statusCode != 200) return null;
    final data = jsonDecode(res.body);
    if (data is! Map) return null;
    final localId = data['localId'];
    final idToken = data['idToken'];
    final newRefresh = data['refreshToken'];
    if (localId is! String || idToken is! String || newRefresh is! String) {
      return null;
    }
    await storage.setFirebaseIdentity(uid: localId, refreshToken: newRefresh);
    return (uid: localId, idToken: idToken);
  }
}
