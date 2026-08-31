import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Storage> _storage([Map<String, Object> prefs = const {}]) async {
  SharedPreferences.setMockInitialValues(prefs);
  return Storage.create();
}

/// A device that has already submitted once: it carries an identity.
const _submitted = <String, Object>{
  'fbUid': 'uid-abc',
  'fbRefreshToken': 'refresh-abc',
  'lastSubmittedScore': 4200,
  'playerName': 'Anna',
  'highscore': 4200,
};

/// Answers the token refresh, then hands [onDelete] every DELETE.
MockClient _client({
  required int deleteStatus,
  List<http.Request>? seen,
  bool refreshOk = true,
}) {
  return MockClient((request) async {
    seen?.add(request);
    if (request.url.host == 'securetoken.googleapis.com') {
      return refreshOk
          ? http.Response(jsonEncode({'id_token': 'fresh-token'}), 200)
          : http.Response('{}', 400);
    }
    if (request.url.host == 'identitytoolkit.googleapis.com') {
      return http.Response(
        jsonEncode({
          'localId': 'uid-new',
          'idToken': 'tok-new',
          'refreshToken': 'ref-new',
        }),
        200,
      );
    }
    if (request.method == 'DELETE') {
      return http.Response('{}', deleteStatus);
    }
    return http.Response('{}', 200);
  });
}

void main() {
  group('deleteEntry', () {
    test('deletes the caller\'s own document with its bearer token', () async {
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(deleteStatus: 200, seen: seen),
        storage: await _storage(_submitted),
      );

      expect(await service.deleteEntry(), isTrue);

      final delete = seen.singleWhere((r) => r.method == 'DELETE');
      expect(delete.url.path, endsWith('/leaderboard/uid-abc'),
          reason: 'must address the caller\'s own document, nobody else\'s');
      expect(delete.headers['Authorization'], 'Bearer fresh-token');
    });

    test('treats an already-missing document as deleted', () async {
      // Firestore answers 404 when there is nothing to remove. The caller only
      // cares that no entry remains, so that is a success.
      final service = LeaderboardService(
        client: _client(deleteStatus: 404),
        storage: await _storage(_submitted),
      );
      expect(await service.deleteEntry(), isTrue);
    });

    test('reports failure when the server refuses', () async {
      final service = LeaderboardService(
        client: _client(deleteStatus: 403),
        storage: await _storage(_submitted),
      );
      expect(await service.deleteEntry(), isFalse,
          reason: 'the UI must not claim a deletion that did not happen');
    });

    test('succeeds without a request when nothing was ever submitted',
        () async {
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(deleteStatus: 200, seen: seen),
        storage: await _storage(),
      );

      expect(await service.deleteEntry(), isTrue);
      expect(seen, isEmpty,
          reason: 'no identity means there is nothing to delete');
    });

    test('refuses to delete under a freshly minted identity', () async {
      // A revoked refresh token makes _ensureIdentity sign up a NEW anonymous
      // user. Deleting under that uid would hit a document that never existed,
      // get a 404, and report success while the player's real entry stayed
      // up — the one failure mode where a wrong answer is worse than an error.
      final seen = <http.Request>[];
      final service = LeaderboardService(
        client: _client(deleteStatus: 200, seen: seen, refreshOk: false),
        storage: await _storage(_submitted),
      );

      expect(await service.deleteEntry(), isFalse);
      expect(
        seen.where((r) => r.method == 'DELETE'),
        isEmpty,
        reason: 'nothing may be deleted under an identity we did not hold',
      );
    });
  });

  group('clearFirebaseIdentity', () {
    test('forgets the identity and the upload guard, keeps progress', () async {
      final storage = await _storage({..._submitted, 'coins': 900});

      await storage.clearFirebaseIdentity();

      expect(storage.firebaseUid, isNull);
      expect(storage.firebaseRefreshToken, isNull);
      expect(storage.lastSubmittedScore, 0,
          reason: 'otherwise a re-entry would be suppressed by the guard');
      expect(storage.highscore, 4200, reason: 'progress must survive');
      expect(storage.coins, 900, reason: 'progress must survive');
      expect(storage.playerName, 'Anna',
          reason: 'the chosen name is kept; only the public entry goes');
    });

    test('resetProgress still keeps the identity', () async {
      // The two paths have opposite intent and must not drift into each other.
      final storage = await _storage(_submitted);
      await storage.resetProgress();
      expect(storage.firebaseUid, 'uid-abc');
    });
  });
}
