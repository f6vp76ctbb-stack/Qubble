// The exact REST requests LeaderboardService sends for the Daily ranking
// (lib/services/leaderboard.dart: submitDaily, fetchDailyTop, dailyRank,
// deleteEntry), replayed against the emulator with firebase/firestore.rules.
// rules.test.mjs checks the rules through the JS SDK; this checks that the
// app's own request shapes, paths and status codes (409 for a second entry)
// meet them. Keep the bodies in step with the Dart code. Run like
// rules.test.mjs:
//
//   npx firebase emulators:exec --only firestore --project qubble-rules-test \
//     "node rest.test.mjs"
//
// Last run 29.09.2026: all checks passed.
import { readFileSync } from 'node:fs';
import { initializeTestEnvironment } from '@firebase/rules-unit-testing';

const project = 'qubble-rules-test';
const env = await initializeTestEnvironment({
  projectId: project,
  firestore: { rules: readFileSync('../firestore.rules', 'utf8'), host: '127.0.0.1', port: 8085 },
});
await env.clearFirestore();

const base = `http://127.0.0.1:8085/v1/projects/${project}/databases/(default)/documents`;
const b64 = (o) => Buffer.from(JSON.stringify(o)).toString('base64url');
const token = (uid) => {
  const now = Math.floor(Date.now() / 1000);
  return `${b64({ alg: 'none', typ: 'JWT' })}.${b64({
    sub: uid, user_id: uid, iat: now, exp: now + 3600, auth_time: now,
    aud: project, iss: `https://securetoken.google.com/${project}`,
    firebase: { sign_in_provider: 'anonymous', identities: {} },
  })}.`;
};
const post = (url, body, uid) => fetch(url, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json', ...(uid ? { Authorization: `Bearer ${token(uid)}` } : {}) },
  body: JSON.stringify(body),
});
let failed = 0;
const check = (label, ok, extra = '') => {
  console.log(`${ok ? 'ok  ' : 'FAIL'} ${label} ${extra}`);
  if (!ok) failed++;
};

const d = new Date();
const pad = (n) => String(n).padStart(2, '0');
const today = `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;

// Names, as claimName writes them.
for (const [uid, name] of [['uid-a', 'Anna'], ['uid-b', 'Jürgen'], ['uid-c', 'Cem']]) {
  const r = await post(`${base}/names?documentId=${encodeURIComponent(name)}`, { fields: { uid: { stringValue: uid } } }, uid);
  check(`claim ${name}`, r.status === 200, r.status);
}

// submitDaily: POST .../dailyLeaderboard/{day}/entries?documentId={uid}
const entry = (name, score) => ({ fields: { name: { stringValue: name }, score: { integerValue: `${score}` } } });
const submit = (uid, name, score, day = today) =>
  post(`${base}/dailyLeaderboard/${day}/entries?documentId=${uid}`, entry(name, score), uid);

let r = await submit('uid-a', 'Anna', 4200);
check('submit stored -> 200', r.status === 200, r.status);
r = await submit('uid-a', 'Anna', 9999);
check('second submit same day -> 409', r.status === 409, r.status);
r = await submit('uid-b', 'Jürgen', 3000);
check('accented name -> 200', r.status === 200, r.status);
r = await submit('uid-c', 'Anna', 5000);
check('name held by another -> 403', r.status === 403, r.status);
r = await submit('uid-c', 'Cem', 100, '2026-01-01');
check('old day -> 403', r.status === 403, r.status);
r = await submit('uid-c', 'Cem', 1500);
check('third player -> 200', r.status === 200, r.status);

// fetchDailyTop: POST .../dailyLeaderboard/{day}:runQuery, no auth.
r = await post(`${base}/dailyLeaderboard/${today}:runQuery`, {
  structuredQuery: {
    from: [{ collectionId: 'entries' }],
    orderBy: [{ field: { fieldPath: 'score' }, direction: 'DESCENDING' }],
    limit: 50,
  },
});
const rows = await r.json();
const names = rows.filter((x) => x.document).map((x) => x.document.fields.name.stringValue);
check('runQuery -> best first', r.status === 200 && names.join(',') === 'Anna,Jürgen,Cem', `${r.status} ${names}`);

// dailyRank: two runAggregationQuery calls, no auth.
const count = async (above) => {
  const res = await post(`${base}/dailyLeaderboard/${today}:runAggregationQuery`, {
    structuredAggregationQuery: {
      structuredQuery: {
        from: [{ collectionId: 'entries' }],
        ...(above == null ? {} : { where: { fieldFilter: { field: { fieldPath: 'score' }, op: 'GREATER_THAN', value: { integerValue: `${above}` } } } }),
      },
      aggregations: [{ alias: 'n', count: {} }],
    },
  });
  const body = await res.json();
  return [res.status, body?.[0]?.result?.aggregateFields?.n?.integerValue, body];
};
let [s1, better] = await count(3000);
let [s2, all] = await count(null);
check('count better than 3000 -> 1', s1 === 200 && better === '1', `${s1} ${better}`);
check('count all -> 3', s2 === 200 && all === '3', `${s2} ${all}`);

// deleteEntry: DELETE .../dailyLeaderboard/{day}/entries/{uid}
const del = (uid, owner) => fetch(`${base}/dailyLeaderboard/${today}/entries/${uid}`, {
  method: 'DELETE', headers: { Authorization: `Bearer ${token(owner)}` },
});
r = await del('uid-a', 'uid-b');
check('delete someone else -> 403', r.status === 403, r.status);
r = await del('uid-a', 'uid-a');
check('delete own -> 200', r.status === 200, r.status);
r = await del('uid-a', 'uid-a');
check('delete again (gone) -> 200', r.status === 200, r.status);

await env.clearFirestore();
await env.cleanup();
console.log(failed ? `${failed} FAILED` : 'ALL PASSED');
process.exit(failed ? 1 : 0);
