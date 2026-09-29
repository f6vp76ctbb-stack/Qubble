// Display names are unique (owner, 28.09.2026). The server enforces it: one
// `names/{name}` document per name, create-only (firebase/firestore.rules).
// These tests pin the client's side of that contract.
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _identity = {'fbUid': 'uid-me', 'fbRefreshToken': 'refresh-me'};

Future<Storage> _storage([Map<String, Object> prefs = _identity]) async {
  SharedPreferences.setMockInitialValues(prefs);
  return Storage.create();
}

http.Response _holder(String uid) => http.Response(
  jsonEncode({
    'name': 'projects/qubble/databases/(default)/documents/names/x',
    'fields': {
      'uid': {'stringValue': uid},
    },
  }),
  200,
);

/// A fake backend: token refresh always works, the rest is up to [firestore].
MockClient _client(
  Future<http.Response> Function(http.Request req) firestore, {
  List<http.Request>? seen,
}) => MockClient((req) async {
  seen?.add(req);
  if (req.url.host == 'securetoken.googleapis.com') {
    return http.Response(jsonEncode({'id_token': 'token-me'}), 200);
  }
  if (req.url.host == 'firestore.googleapis.com') return firestore(req);
  fail('unexpected request: ${req.url}');
});

void main() {
  group('claimName', () {
    test('creates the reservation when the name is free', () async {
      final seen = <http.Request>[];
      final client = _client((req) async {
        if (req.method == 'GET') return http.Response('{}', 404);
        expect(req.method, 'POST');
        expect(req.url.path, endsWith('/documents/names'));
        expect(req.url.queryParameters['documentId'], 'Max 1');
        expect(req.headers['Authorization'], 'Bearer token-me');
        expect(jsonDecode(req.body)['fields']['uid']['stringValue'], 'uid-me');
        return http.Response('{}', 200);
      }, seen: seen);
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );

      expect(await service.claimName('  Max   1 '), NameClaim.claimed);
      expect(
        seen.where(
          (r) => r.method == 'POST' && r.url.host == 'firestore.googleapis.com',
        ),
        hasLength(1),
        reason: 'reserved in canonical form, exactly once',
      );
    });

    test('a name this player already holds is claimed without a write',
        () async {
      final client = _client((req) async {
        expect(req.method, 'GET', reason: 'nothing to write');
        expect(req.url.path, endsWith('/names/Max'));
        return _holder('uid-me');
      });
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.claimName('Max'), NameClaim.claimed);
    });

    test('a name another player holds is taken', () async {
      final client = _client((req) async {
        expect(req.method, 'GET');
        return _holder('uid-someone-else');
      });
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.claimName('Max'), NameClaim.taken);
    });

    test('losing the race to create it is taken, not a failure', () async {
      // Both players saw the name free; Firestore lets only one create win.
      final client = _client((req) async {
        if (req.method == 'GET') return http.Response('{}', 404);
        return http.Response('{"error":{"status":"ALREADY_EXISTS"}}', 409);
      });
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.claimName('Max'), NameClaim.taken);
    });

    test('a refused request is a failure, never "taken"', () async {
      // Before the new rules are published, `names` is locked and every
      // request is refused. Calling that "taken" would turn every name away.
      for (final status in [403, 500]) {
        final client = _client((req) async => http.Response('{}', status));
        final service = LeaderboardService(
          client: client,
          storage: await _storage(),
        );
        expect(
          await service.claimName('Max'),
          NameClaim.failed,
          reason: 'GET $status',
        );
      }
      final refusedCreate = _client((req) async {
        if (req.method == 'GET') return http.Response('{}', 404);
        return http.Response('{"error":{"status":"PERMISSION_DENIED"}}', 403);
      });
      final service = LeaderboardService(
        client: refusedCreate,
        storage: await _storage(),
      );
      expect(await service.claimName('Max'), NameClaim.failed);
    });

    test('offline is a failure', () async {
      final client = MockClient(
        (req) async => throw http.ClientException('offline'),
      );
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.claimName('Max'), NameClaim.failed);
    });

    test('an invalid name makes no request', () async {
      final client = MockClient((req) async => fail('no request expected'));
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.claimName('x'), NameClaim.failed);
      expect(await service.claimName('Max!'), NameClaim.failed);
    });

    test('the first claim signs up the anonymous identity', () async {
      final storage = await _storage(const {});
      final client = MockClient((req) async {
        if (req.url.host == 'identitytoolkit.googleapis.com') {
          return http.Response(
            jsonEncode({
              'localId': 'uid-new',
              'idToken': 'token-new',
              'refreshToken': 'refresh-new',
            }),
            200,
          );
        }
        if (req.method == 'GET') return http.Response('{}', 404);
        expect(jsonDecode(req.body)['fields']['uid']['stringValue'], 'uid-new');
        return http.Response('{}', 200);
      });
      final service = LeaderboardService(client: client, storage: storage);
      expect(await service.claimName('Max'), NameClaim.claimed);
      expect(storage.firebaseUid, 'uid-new');
    });
  });

  group('releaseName', () {
    test('deletes the reservation this player holds', () async {
      final seen = <http.Request>[];
      final client = _client((req) async {
        if (req.method == 'GET') return _holder('uid-me');
        expect(req.method, 'DELETE');
        expect(req.url.path, endsWith('/names/Max'));
        expect(req.headers['Authorization'], 'Bearer token-me');
        return http.Response('{}', 200);
      }, seen: seen);
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.releaseName('Max'), isTrue);
      expect(seen.where((r) => r.method == 'DELETE'), hasLength(1));
    });

    test('never deletes a name someone else holds', () async {
      final client = _client((req) async {
        expect(req.method, 'GET', reason: 'no DELETE on another holder');
        return _holder('uid-someone-else');
      });
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.releaseName('Max'), isTrue);
    });

    test('a name nobody holds is already released', () async {
      final client = _client((req) async => http.Response('{}', 404));
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.releaseName('Max'), isTrue);
    });

    test('reports a release that could not happen, so it is retried',
        () async {
      final offline = MockClient(
        (req) async => throw http.ClientException('offline'),
      );
      expect(
        await LeaderboardService(
          client: offline,
          storage: await _storage(),
        ).releaseName('Max'),
        isFalse,
      );
      final refused = _client((req) async {
        if (req.method == 'GET') return _holder('uid-me');
        return http.Response('{}', 403);
      });
      expect(
        await LeaderboardService(
          client: refused,
          storage: await _storage(),
        ).releaseName('Max'),
        isFalse,
      );
    });

    test('without an identity there is nothing to release', () async {
      final client = MockClient((req) async => fail('no request expected'));
      final service = LeaderboardService(
        client: client,
        storage: await _storage(const {}),
      );
      expect(await service.releaseName('Max'), isTrue);
    });
  });

  group('the name rule', () {
    test('matches the canonical form only', () {
      for (final ok in ['Max', 'Max 1', 'a_b-c', 'Ab', 'Abcdefghijklmn']) {
        expect(kLeaderboardNameRule.hasMatch(ok), isTrue, reason: ok);
      }
      for (final bad in [
        'M',
        'Abcdefghijklmno',
        ' Max',
        'Max ',
        'Max  1',
        'Max!',
      ]) {
        expect(kLeaderboardNameRule.hasMatch(bad), isFalse, reason: bad);
      }
    });

    test('submit sends the canonical form', () async {
      final client = _client((req) async {
        expect(jsonDecode(req.body)['fields']['name']['stringValue'], 'Max 1');
        return http.Response('{}', 200);
      });
      final service = LeaderboardService(
        client: client,
        storage: await _storage(),
      );
      expect(await service.submit(name: ' Max  1 ', score: 10), isTrue);
    });
  });
}
