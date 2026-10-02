// Firestore rules, run against the local emulator. Not part of CI (needs
// Java and the emulator download); run it whenever firebase/firestore.rules
// changes, before the owner publishes them:
//
//   cd firebase/rules-test && npm install
//   npx firebase emulators:exec --only firestore --project qubble-rules-test \
//     "node rules.test.mjs"
//
// Last run 29.09.2026: all checks passed (names with accents, other scripts
// refused, unique names, both leaderboards, the Daily ranking).
import { initializeTestEnvironment, assertSucceeds, assertFails } from '@firebase/rules-unit-testing';
import { doc, setDoc, deleteDoc, getDoc, collection, query, where, getCountFromServer } from 'firebase/firestore';
import fs from 'node:fs';

const env = await initializeTestEnvironment({
  projectId: 'qubble-rules-test',
  firestore: { rules: fs.readFileSync('../firestore.rules', 'utf8'), host: '127.0.0.1', port: 8085 },
});
const a = env.authenticatedContext('uid-a').firestore();
const b = env.authenticatedContext('uid-b').firestore();
const anon = env.unauthenticatedContext().firestore();
let failed = 0;
async function check(label, p, ok) {
  try { await (ok ? assertSucceeds(p) : assertFails(p)); console.log('ok  ', label); }
  catch (e) { failed++; console.log('FAIL', label, e.message); }
}
// Names
await check('A takes Jürgen', setDoc(doc(a, 'names', 'Jürgen'), { uid: 'uid-a' }), true);
await check('B cannot take Jürgen', setDoc(doc(b, 'names', 'Jürgen'), { uid: 'uid-b' }), false);
await check('B takes Jurgen (different name)', setDoc(doc(b, 'names', 'Jurgen'), { uid: 'uid-b' }), true);
await check('accents: Łukasz Ñoño', setDoc(doc(a, 'names', 'Łukasz Ñoño'), { uid: 'uid-a' }), true);
await check('Turkish Işık Şahin', setDoc(doc(a, 'names', 'Işık Şahin'), { uid: 'uid-a' }), true);
await check('Vietnamese Nguyễn Đức', setDoc(doc(a, 'names', 'Nguyễn Đức'), { uid: 'uid-a' }), true);
await check('Romanian Ștefan', setDoc(doc(a, 'names', 'Ștefan'), { uid: 'uid-a' }), true);
await check('Azerbaijani Əli', setDoc(doc(a, 'names', 'Əli'), { uid: 'uid-a' }), true);
await check('14 accented chars', setDoc(doc(a, 'names', 'ẪẪẪẪẪẪẪẪẪẪẪẪẪẪ'), { uid: 'uid-a' }), true);
await check('15 chars refused', setDoc(doc(a, 'names', 'ẪẪẪẪẪẪẪẪẪẪẪẪẪẪẪ'), { uid: 'uid-a' }), false);
await check('Cyrillic refused', setDoc(doc(a, 'names', 'Мах'), { uid: 'uid-a' }), false);
await check('mixed Latin+Cyrillic refused', setDoc(doc(a, 'names', 'Mах'), { uid: 'uid-a' }), false);
await check('emoji refused', setDoc(doc(a, 'names', 'Max😀'), { uid: 'uid-a' }), false);
await check('Japanese refused', setDoc(doc(a, 'names', 'たろう'), { uid: 'uid-a' }), false);
await check('multiplication sign refused', setDoc(doc(a, 'names', 'A×B'), { uid: 'uid-a' }), false);
await check('double space refused', setDoc(doc(a, 'names', 'Max  Mo'), { uid: 'uid-a' }), false);
await check('plain Max_1-x', setDoc(doc(a, 'names', 'Max_1-x'), { uid: 'uid-a' }), true);
await check('claim for someone else refused', setDoc(doc(a, 'names', 'Other'), { uid: 'uid-b' }), false);
await check('unauthenticated refused', setDoc(doc(anon, 'names', 'Anon'), { uid: 'x' }), false);
await check('names public read', getDoc(doc(anon, 'names', 'Jürgen')), true);
// Leaderboards
for (const col of ['leaderboard', 'puzzleLeaderboard']) {
  await check(`${col}: A writes under held Jürgen`, setDoc(doc(a, col, 'uid-a'), { name: 'Jürgen', score: 100 }), true);
  await check(`${col}: A cannot lower`, setDoc(doc(a, col, 'uid-a'), { name: 'Jürgen', score: 50 }), false);
  await check(`${col}: A raises`, setDoc(doc(a, col, 'uid-a'), { name: 'Jürgen', score: 150 }), true);
  await check(`${col}: B cannot use A's name`, setDoc(doc(b, col, 'uid-b'), { name: 'Jürgen', score: 10 }), false);
  await check(`${col}: unheld name refused`, setDoc(doc(b, col, 'uid-b'), { name: 'Nobody', score: 10 }), false);
  await check(`${col}: B writes under own Jurgen`, setDoc(doc(b, col, 'uid-b'), { name: 'Jurgen', score: 10 }), true);
  await check(`${col}: B cannot write A's doc`, setDoc(doc(b, col, 'uid-a'), { name: 'Jurgen', score: 999 }), false);
  await check(`${col}: extra field refused`, setDoc(doc(a, col, 'uid-a'), { name: 'Jürgen', score: 200, x: 1 }), false);
  await check(`${col}: public read`, getDoc(doc(anon, col, 'uid-a')), true);
  await check(`${col}: B cannot delete A`, deleteDoc(doc(b, col, 'uid-a')), false);
  await check(`${col}: A deletes own`, deleteDoc(doc(a, col, 'uid-a')), true);
}
// Daily ranking: today (UTC) and near days only, written once.
const iso = (d) => d.toISOString().slice(0, 10);
const today = iso(new Date());
const old = iso(new Date(Date.now() - 10 * 86400000));
const daily = (db, day, uid) => doc(db, 'dailyLeaderboard', day, 'entries', uid);
await check('daily: A enters today under held name', setDoc(daily(a, today, 'uid-a'), { name: 'Jürgen', score: 2400 }), true);
await check('daily: A cannot change it', setDoc(daily(a, today, 'uid-a'), { name: 'Jürgen', score: 9000 }), false);
await check('daily: B cannot use A name', setDoc(daily(b, today, 'uid-b'), { name: 'Jürgen', score: 10 }), false);
await check('daily: B enters under own name', setDoc(daily(b, today, 'uid-b'), { name: 'Jurgen', score: 10 }), true);
await check('daily: B cannot write A doc', setDoc(daily(b, today, 'uid-x'), { name: 'Jurgen', score: 10 }), false);
await check('daily: old day refused', setDoc(daily(a, old, 'uid-a'), { name: 'Jürgen', score: 10 }), false);
await check('daily: garbage day refused', setDoc(daily(a, 'yesterday', 'uid-a'), { name: 'Jürgen', score: 10 }), false);
await check('daily: zero score refused', setDoc(daily(a, iso(new Date(Date.now() - 86400000)), 'uid-a'), { name: 'Jürgen', score: 0 }), false);
await check('daily: yesterday allowed', setDoc(daily(a, iso(new Date(Date.now() - 86400000)), 'uid-a'), { name: 'Jürgen', score: 5 }), true);
await check('daily: public read', getDoc(daily(anon, today, 'uid-a')), true);
{
  // The rank is a count of the better scores: anyone may run it.
  const better = query(collection(anon, 'dailyLeaderboard', today, 'entries'), where('score', '>', 100));
  try {
    const n = (await getCountFromServer(better)).data().count;
    if (n === 1) console.log('ok   daily: rank count'); else { failed++; console.log('FAIL daily: rank count', n); }
  } catch (e) { failed++; console.log('FAIL daily: rank count', e.message); }
}
await check('daily: B cannot delete A', deleteDoc(daily(b, today, 'uid-a')), false);
await check('daily: A deletes own', deleteDoc(daily(a, today, 'uid-a')), true);
await check('B cannot release A name', deleteDoc(doc(b, 'names', 'Jürgen')), false);
await check('A releases Jürgen', deleteDoc(doc(a, 'names', 'Jürgen')), true);
await check('other collections locked', setDoc(doc(a, 'misc', 'x'), { a: 1 }), false);
await env.cleanup();
console.log(failed ? `${failed} FAILED` : 'ALL PASSED');
process.exit(failed ? 1 : 0);
