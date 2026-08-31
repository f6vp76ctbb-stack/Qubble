import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/leaderboard.dart';
import 'package:gridpop/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A connection that accepts the request and then never answers — the failure
/// mode a plain `catch` never sees, because nothing is ever thrown.
MockClient _hangs() => MockClient((_) => Completer<http.Response>().future);

Future<Storage> _storage([Map<String, Object> prefs = const {}]) async {
  SharedPreferences.setMockInitialValues(prefs);
  return Storage.create();
}

const _submitted = <String, Object>{
  'fbUid': 'uid-abc',
  'fbRefreshToken': 'refresh-abc',
};

void main() {
  test('the defaults are bounded at all', () {
    // The point of the change: before this, there was no bound.
    expect(LeaderboardService.defaultReadTimeout, const Duration(seconds: 10));
    expect(LeaderboardService.defaultWriteTimeout, const Duration(seconds: 30));
    expect(
      LeaderboardService.defaultWriteTimeout >
          LeaderboardService.defaultReadTimeout,
      isTrue,
      reason: 'a background write may wait longer than a screen a player '
          'is looking at',
    );
  });

  test('a hanging read fails instead of spinning forever', () async {
    final service = LeaderboardService(
      client: _hangs(),
      readTimeout: const Duration(milliseconds: 30),
    );

    // fetchTop throws so the FutureBuilder reaches its error state, which is
    // where the retry button lives.
    await expectLater(service.fetchTop(), throwsA(isA<TimeoutException>()));
  });

  test('a hanging submit gives up quietly', () async {
    final service = LeaderboardService(
      client: _hangs(),
      storage: await _storage(_submitted),
      writeTimeout: const Duration(milliseconds: 30),
    );

    // submit never throws: an offline upload must degrade silently and retry
    // on the next game over.
    expect(await service.submit(name: 'Anna', score: 100), isFalse);
  });

  test('a hanging delete reports failure rather than a false success',
      () async {
    final service = LeaderboardService(
      client: _hangs(),
      storage: await _storage(_submitted),
      writeTimeout: const Duration(milliseconds: 30),
    );

    expect(await service.deleteEntry(), isFalse,
        reason: 'the UI must not claim the entry is gone');
  });
}
