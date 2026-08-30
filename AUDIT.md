# Qubble — Playtest-Audit

Stand: 2026-08-26 · Commit `c6d2b05` · Branch `claude/qubble-playtest-audit-7j36la`
Balance-Zahlen: siehe `BALANCE.md`. Tester-Einweisung: siehe `PLAYTEST.md`.

**Vorbemerkung zum Auftrag:** Der Auftrag nennt Expo / React Native / TypeScript.
Das Repo enthält kein einziges JS/TS-File — Qubble ist **Flutter/Dart** (Paketname
`gridpop`, Flutter 3.47.1 / Dart 3.13.1). Die Auftragspunkte sind entsprechend
gemappt: `npx tsc --noEmit` → `flutter analyze`, `expo-doctor` → `flutter pub
outdated`, AsyncStorage → `shared_preferences`.

## Status Phase 2 (Stand 2026-08-26)

Alle P0 und alle P1 sind abgearbeitet, dazu die P2 und die Balance-Empfehlungen
aus `BALANCE.md`. Die Befundtexte unten bleiben als Protokoll stehen — sie
beschreiben den Zustand bei Commit `c6d2b05`.

| Befund | Status |
|---|---|
| P0-1 Error Boundary + Crashlytics iOS | behoben |
| P0-2 Daily löscht Endlos-Runde | behoben |
| P0-3 Alter Spielstand killt die App | behoben |
| P0-4 Echte Ad-Units im Testbuild | behoben |
| P0-5 Feedback-Kanal über GitHub | behoben (Mail-Weg aktiv) |
| P1-1 Zurück-Taste | behoben (Home, Spiel, Bombenmodus, Rätsel) |
| P1-2 App-Lifecycle | behoben (Musik pausiert, lastActive) |
| P1-3 `showRewarded()` ohne Timeout | behoben (120 s) |
| P1-4 IAP-Fehlerzustände verschluckt | behoben |
| P1-5 Rätsel-Solver blockiert UI | behoben (63→7,7 ms Median) |
| P1-6 Regeln werden nie gezeigt | behoben |
| P1-7 Game Over ohne Grund | behoben |
| P1-8 Overlay springt unter dem Finger | behoben |
| P1-9 Belohnungskurve zu langsam | behoben |
| P1-10 Ablage-Teile zu klein | behoben |
| P1-11 Dreh-Button unter 44 px | behoben |
| P1-12 Gitter-Kontrast 1,14:1 | behoben (~1,77:1, alle 8 Themes) |
| P1-13 Versionsanzeige | behoben |
| P1-15 `<queries>` für url_launcher | behoben |
| P2 (Preis, Meldungen, Zahlen, toter Code, Admin-Riegel) | behoben |
| BALANCE 1/4/5 (Combo-Deckel, Fieber, All-Clear) | behoben, nachgemessen |

**Nebenbei gefunden und behoben** — Bugs, die im Audit nicht standen und erst
durch die neuen Tests auffielen:

- 14-px-Layout-Overflow auf 360×640 (Coach-Hinweis mit 52 px reserviert,
  zweizeilig aber 68 px hoch)
- `CoinPopup` hatte `Positioned` innerhalb eines `IgnorePointer` — die
  Stack-Positionierung griff nicht, das „+N 🪙" erschien in der Ecke
- Audio-Playbackrate wurde nie zurückgesetzt → Sounds mit zufälliger Tonhöhe
- Bombe zeigte den Score-Popup des Vorzugs
- Bomben-Partikel platzten auch aus leeren Feldern

**Weiterhin offen — nicht im Code lösbar (P1-14):** R8 ist seit `3438a3d` aktiv
und wurde nie an einem Release-Build geprüft; die Keep-Regeln für
`flutter_local_notifications` fehlen. Vor dem Testbeginn einmal das signierte
Bundle auf einem Gerät installieren, eine Runde spielen, Benachrichtigungen
aktivieren und die Links in den Einstellungen öffnen.

Testabdeckung: 292 → **409 Tests**, `flutter analyze` durchgehend ohne Befund,
Soak nach jedem Schritt bei 0 Invariantenbrüchen.

---

**Urteil: playtest-tauglich JA.** Die
Kernlogik ist außergewöhnlich solide (1,44 Mio. simulierte Züge ohne einen
einzigen Invarianten-Bruch). Die Risiken liegen nicht im Spiel, sondern im
Drumherum: Datenverlust an zwei Stellen, echte Ad-Units im Testbuild, kein
Crash-Reporting auf iOS, und ein Feedback-Kanal, der ein GitHub-Konto verlangt.

---

## Phase 0 — Was das Spiel ist

| Frage | Befund |
|---|---|
| Genre / Kernmechanik | Block-Puzzle (Block Blast!/Woodoku). 8×8-Gitter, 3-Teile-Ablage. Spieler zieht ein Teil aufs Gitter; volle Reihen/Spalten lösen sich auf. Neue Ablage erst, wenn alle 3 verbaut sind. Kein Zeitdruck, kein Gegner. |
| Sekunde für Sekunde | Ablage scannen → Zielzelle wählen → ziehen (Teil schwebt 1,2 Zellen über dem Finger) → loslassen. Optional: Ablage-Teil antippen = 90°-Drehung (kostet eine Ladung, außer Level ≤ 2). |
| Logik-Trennung | Sauber. `lib/game/**` (15 Dateien, ~2.100 Zeilen) ist reines Dart ohne Flutter-Import. `GameSession` kapselt Board+Generator+Scoring, Uhr per `clock`-Callback injizierbar, Generator seed-bar. **Vollständig headless und deterministisch lauffähig** — Balance-Analyse war ohne Umbau möglich. |
| Screens (15) | Home → Game / Daily / Rätsel-Levels → Rätsel · Bestenliste · Missionen · Erfolge · Themes · Skins · Shop · Stats · Einstellungen → Feedback / Anleitung. Flach, alles per `Navigator.push` von Home. |
| Spieldaten | Konstanten im Code, keine Datendateien: Teile-Katalog `piece.dart:93`, Scoring `scoring.dart:43`, Level/Belohnungen `leveling.dart:53`, Missionen `missions.dart:49`, Erfolge `achievements.dart`, Rätsel prozedural `puzzle.dart:245`, Preise `iap.dart:38`. |
| Monetarisierung | AdMob **nur Rewarded** (keine Interstitials/Banner), IAP über `in_app_purchase`. Regel „Spielen erfordert nie ein Video" ist im Code eingehalten — Revive kostet Münzen. |
| Persistenz | `shared_preferences`, flache Keys, kein Backend. Laufende Runde als JSON-Checkpoint (`activeRun.v1`). |
| Netzwerk | Nur Bestenliste (Firestore REST) + Analytics. Gameplay läuft offline. |

---

## A) Gesundheits-Check

| Prüfung | Ergebnis |
|---|---|
| `flutter analyze` | **0 Issues** (18,8 s) |
| `flutter test` | **292/292 grün** (28 s) |
| Lint-Set | `flutter_lints` + 4 eigene Regeln. Sauber, aber ohne `unawaited_futures`/`discarded_futures` — genau die Klasse, die in P1-8 zuschlägt. |
| TODO/FIXME/HACK | **3 Fundstellen, alle relevant** (unten). Keine auskommentierten Blöcke, kein Copy-Paste-Duplikat. |
| Abhängigkeiten | 8 direkte Pakete veraltet. Zwei davon relevant: `flutter_local_notifications` 18.0.1 → 22.3.0 (3 Major zurück), `timezone` 0.9.4 → 0.11.1. `flutter_riverpod` 2.6.1 → 3.4.2 ist ein Major-Sprung und **vor dem Playtest nicht anzufassen**. |
| Toter Code | `NameEntryScreen` (134 Zeilen + eigene Test-Suite) wird von **keinem** Screen geroutet — die Namenseingabe läuft über `_renameDialog` in `home_screen.dart:92`. |

Offene `REPLACE_ME`/TODO:

- `ad_config.dart:24` — `_prodRewardedIos = 'REPLACE_ME_REWARDED_IOS'`
- `ios/Runner/Info.plist:72` — `GADApplicationIdentifier` ist Googles **Test**-App-ID
- `android/app/build.gradle.kts:43` — kosmetischer Flutter-Template-TODO, ApplicationId ist gesetzt

Die Codebasis ist für 12.900 Zeilen ungewöhnlich diszipliniert: keine Duplikate,
konsequente Doc-Kommentare, Testabdeckung dort, wo sie zählt. Das ist die
Ausgangslage — die folgenden Befunde sind Ausnahmen, nicht die Regel.

---

## B) Crash- und Stabilitätsjagd

### P0-1 · Kein globaler Error Boundary — weißer Screen ohne Meldung

`main.dart:33` startet `runApp` ohne `runZonedGuarded`; nirgends im Repo gibt es
ein `ErrorWidget.builder` (verifiziert per Volltextsuche). Ein Build-Fehler in
einem beliebigen Widget zeigt im Release-Build eine **graue Fläche ohne Text**.

Verschärfend: `firebase_boot_native.dart:23` — `if (!Platform.isAndroid) return
null;`. Damit werden `FlutterError.onError` und `PlatformDispatcher.onError` auf
iOS **nie gesetzt**. Auf iOS gibt es also weder Crashlytics noch einen sichtbaren
Fehler.

*Tester-Erlebnis:* „App ist grau geworden, keine Ahnung warum." — unverwertbar.

*Fix:* `ErrorWidget.builder` auf einen lesbaren Fallback-Screen setzen (Fehlertext
+ „Neu starten" + „Spielstand zurücksetzen"), `runApp` in `runZonedGuarded`
wickeln. Crashlytics-Guard von `Platform.isAndroid` auf „Firebase-Init
erfolgreich" umstellen, sobald die iOS-App in Firebase registriert ist.

### P0-2 · Tägliche Challenge löscht die laufende Endlos-Runde

`game_controller.dart:446` `startDaily()` → `_resetRunState(daily: true)` →
`_queueActiveRunCheckpoint()`. Dort (Zeile 652):

```dart
final checkpoint = !_isDaily && !_session.isGameOver && _session.placements > 0
    ? _session.toCheckpoint() : null;   // isDaily → null → clearActiveRunCheckpoint()
```

Der Home-Screen bietet die Daily-Karte (`home_screen.dart:466`) **ohne jede
Warnung** an, während oben noch „Weiterspielen" steht. Ein Tipp darauf löscht die
laufende Runde unwiderruflich.

**Verifiziert** — `scripts/audit/verify_findings.dart`, Test A-1: Checkpoint ist
nach `startDaily()` `null`, ein frischer Controller startet bei 0.

*Tester-Erlebnis:* „Ich hatte 8.000 Punkte, habe kurz die Daily angetippt — Runde weg."

*Fix:* Zwei getrennte Checkpoint-Slots (`activeRun.endless` / `activeRun.daily`),
oder minimal: Bestätigungsdialog, wenn `runActive && !isDaily`. Dasselbe gilt für
„Neue Runde starten" (`home_screen.dart:425`) — dort immerhin mit sprechendem Label.

### P0-3 · Alter Spielstand kann die neue Version killen

`storage.dart` liest drei Werte **ohne `try`/`catch` und ohne Schema-Version**:

| Zeile | Feld | Bruchstelle |
|---|---|---|
| 146-151 | `missionProgress` | `jsonDecode(raw) as Map<String,dynamic>` + `(v as num)` |
| 157-162 | `puzzleStars` | zusätzlich `int.parse(k)` — jeder nicht-numerische Key wirft |
| 169-173 | `lifetimeStats` | `jsonDecode(raw) as Map<String,dynamic>` |

`missionProgress` und `lifetimeStats` werden in der **Initialisierungsliste** von
`GameController` gelesen (`game_controller.dart:271` und `:277`). Eine Exception
dort lässt den Provider werfen → mit P0-1 zusammen: grauer Screen beim Start,
App unbenutzbar, **keine Möglichkeit für den Tester, das zu reparieren** außer
Deinstallieren.

`puzzleStars` wird zusätzlich direkt in `build()` gelesen
(`puzzle_levels_screen.dart:23`).

Der Run-Checkpoint ist vorbildlich abgesichert (`storage.dart:90` + Controller
`catch (_)`) — genau dieses Muster fehlt bei den drei anderen.

*Tester-Erlebnis:* Update über die bestehende Installation → App startet nicht mehr.
Genau das Szenario, das ein geschlossener Test mit mehreren Builds erzeugt.

*Fix:* (1) Alle drei Getter in `try/catch` mit Rückfall auf den Leerwert; (2) einen
Key `schemaVersion` einführen und bei unbekannter Version alle Progress-Keys
kontrolliert zurücksetzen; (3) „Spielstand zurücksetzen" in die Einstellungen.

### P0-4 · Release-Build serviert echte AdMob-Units an Tester

`ad_config.dart:28`:

```dart
static String get rewardedUnitId {
  if (kDebugMode) return _isAndroid ? _testRewardedAndroid : _testRewardedIos;
  return _isAndroid ? _prodRewardedAndroid : _prodRewardedIos;
}
```

Ein Playtest-Build ist ein **Release**-Build (`flutter build appbundle --release`
in `.github/workflows/build-release.yaml:73`) → `kDebugMode == false` → echte
Unit `ca-app-pub-8596176219181991/4303264559`, dazu die echte App-ID im
`AndroidManifest.xml:12`. Eine Handvoll Tester, die wiederholt „Münzen
verdoppeln", „Neue Teile (Video)" und „Sparschwein öffnen" antippen, ist genau
das Muster, das Google als Invalid Traffic wertet. **Risiko: AdMob-Konto.**

*Fix (eine Zeile):* Umschaltung auf `--dart-define`, nicht auf `kDebugMode`:

```dart
static const _forceTestAds = bool.fromEnvironment('QUBBLE_TEST_ADS');
… if (kDebugMode || _forceTestAds) return …test…;
```

und den Playtest mit `flutter build appbundle --release --dart-define=QUBBLE_TEST_ADS=true`
bauen. Alternativ/zusätzlich Googles offizieller Weg:
`MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: [...]))`
mit den Geräte-IDs der Tester.

### P1-1 · Kein Android-Zurück-Button-Handling in irgendeinem Screen

`PopScope`/`WillPopScope` kommen im gesamten Repo **null Mal** vor. Konkret:

- **Im laufenden Spiel:** Zurück verlässt den Game-Screen sofort. Die Runde
  überlebt zwar (Checkpoint), aber ohne jede Rückmeldung — der Tester glaubt,
  sie sei weg, und drückt auf Home „Neue Runde starten".
- **Auf Home:** Zurück beendet die App direkt aus dem Hauptmenü. Kein
  „Nochmal drücken zum Beenden".
- **Im Game-Over-Overlay:** Das Overlay ist ein `Stack`-Kind, kein Dialog. Zurück
  verlässt den Screen, statt das Overlay zu schließen.
- **Im Bomben-Zielmodus** (`bombModeProvider`): Zurück verlässt den Screen und
  lässt `bombMode` global auf `true` — beim nächsten Betreten ist der Bombenmodus
  noch aktiv, obwohl die Bombe schon bezahlt/abgebrochen wurde.

*Fix:* `PopScope` auf `GameScreen` (bei aktivem Bombenmodus: nur Modus beenden;
bei `runActive`: Snackbar „Runde ist gespeichert") und `PuzzleScreen`;
Doppel-Zurück-zum-Beenden auf Home.

### P1-2 · Kein App-Lifecycle-Handling

`WidgetsBindingObserver` / `didChangeAppLifecycleState` kommen nirgends vor.
Folgen:

- Der Checkpoint wird nur bei Zügen geschrieben (`_queueActiveRunCheckpoint`),
  nicht beim Wechsel in den Hintergrund. Ein vom System gekilltes App-Objekt
  verliert die Züge seit dem letzten `place()` — in der Praxis wenig, weil nach
  **jedem** Zug geschrieben wird. Akzeptabel.
- **Die Combo-Uhr läuft im Hintergrund weiter** (`scoring.dart:117`,
  `now.difference(last) > comboWindow`). Handy weglegen, 30 s später zurück:
  Combo ist tot, ohne dass der Spieler etwas falsch gemacht hat. Der
  `_ComboBadge`-Countdown (`game_screen.dart:610`) zeigt bis zum nächsten Rebuild
  weiterhin einen falschen Balken.
- Die Hintergrundmusik wird nicht pausiert. Auf Android (`AndroidAudioFocus.none`)
  spielt sie potenziell weiter, während der Nutzer etwas anderes tut.

*Fix:* `AppLifecycleListener`: bei `paused` Checkpoint erzwingen + Musik pausieren
+ Combo-Referenzzeit einfrieren; bei `resumed` Musik fortsetzen und `_emit()`.

### P1-3 · `showRewarded()` kann unendlich hängen

`ads.dart:148-164`: `await ad.show(...)` und danach `return completer.future`.
Der Completer wird ausschließlich aus `onAdDismissedFullScreenContent` bzw.
`onAdFailedToShowFullScreenContent` bedient. Bleibt einer der Callbacks aus
(bekanntes Verhalten bei Prozess-Unterbrechung während des Ads), wartet der
Aufrufer ewig. Die UI ruft das ohne Timeout und ohne Ladeindikator auf
(`game_screen.dart:121`, `:769`; `home_screen.dart:222`).

*Fix:* `.timeout(const Duration(seconds: 90), onTimeout: () => false)` auf den
Completer, plus Ladezustand am Button.

### P1-4 · Ausgelassene Fehlerzustände beim Kauf

`iap.dart:196` behandelt nur `purchased` und `restored`.
`PurchaseStatus.error` und `.canceled` werden verschluckt — keine Snackbar, keine
Meldung. Zusätzlich (`iap.dart:207`): `buy()` kehrt still zurück, wenn
`queryProductDetails` leer ist. Während eines geschlossenen Tests sind die IAP-
Produkte oft noch nicht freigeschaltet — dann passiert beim Tippen auf „Kaufen"
**exakt nichts**.

*Tester-Erlebnis:* „Kaufen-Button ist tot." Das ist Rauschen, keine Substanz.

*Fix:* `error`/`canceled` in `_onPurchases` behandeln und über einen Callback an
die UI melden; bei leeren Produktdetails eine Meldung zeigen. Optional: den Shop
im Playtest-Build ausblenden, wenn `iap.available == false`.

### P2-1 · `boardColors`-Korruption wirft `RangeError` statt `FormatException`

`game_session.dart:65` prüft die äußere Länge der Farbmatrix, nicht die der
Zeilen. Bei kürzeren Zeilen wirft `Board.fromAscii` (`board.dart:61`) einen
`RangeError` — der Doc-Kommentar in `fromCheckpoint` verspricht ausdrücklich
`FormatException`. Der einzige Aufrufer fängt mit `catch (_)`
(`game_controller.dart:359`), deshalb **kein Absturz**. Verifiziert (Test A-5):
tritt nur auf, wenn das Board belegte Zellen hat.

### P2-2 · Nicht aufgeräumt / Kleinkram

- `home_screen.dart:97` — `TextEditingController` im Rename-Dialog wird nie
  `dispose()`t (kleines Leck pro Öffnung).
- `iap.dart:220` — `StoreIap.dispose()` existiert, wird nie aufgerufen; der
  Purchase-Stream bleibt für die App-Lebensdauer offen. Praktisch harmlos.
- `game_session.dart:306` — `bombAt` baut eine ASCII-Kopie des Boards auf,
  mutiert sie und **verwirft sie**; die Arbeit macht `clearCells(hit)`. Toter Code.
- `game_session.dart:307-313` — `hit` enthält alle 9 Zellen, auch bereits leere;
  die Partikel platzen also auch aus leeren Feldern.
- `game_controller.dart:846` — `_haptics.gameOver()` / `_audio.play(Sfx.gameOver)`
  stehen **vor** dem `if (_finalized) return`. Aktuell nicht auslösbar, weil
  `place()` nach Game Over nichts mehr tut — aber eine Falle für den nächsten Umbau.
- Animations-Controller (`clear_burst.dart`, `juice_overlay.dart`, `shake.dart`,
  `menu_particles.dart`, `coin_popup.dart`) werden alle korrekt disposed. Sauber.

---

## C) Logik-Korrektheit der Kernmechanik

**Soak-Test:** `scripts/audit/soak.dart` — 3 Strategien × 20.000 Seeds.

```
runs executed:                          60.000
placements simulated:                1.438.158
invariant violations / crashes:              0
non-termination (>5000 Züge):                0
NaN / Infinity / negative Werte:             0
Zellzahl-Mismatch nach Platzierung:          0
Determinismus-Fehler (500 Wiederholungen):   0
Checkpoint-Roundtrip-Fehler (1.000):         0
Laufzeit pro Runde: median 1,50 ms · p99 7,07 ms · max 38,5 ms
```

Geprüfte Invarianten pro Zug: Zellzahl = vorher + Teilgröße − geräumt;
`0 ≤ filledCount ≤ 64`; Score ≥ 0; Fieber ∈ [0,1] und nicht NaN; Combo ≥ 0;
Drehladungen ∈ [0,3]; kein leeres Teil in der Ablage; `isGameOver` konsistent mit
„kein legaler Zug".

**Terminierung:** Endlosschleifen sind strukturell ausgeschlossen — Clears sind
nicht rekursiv (kein Nachrutschen, `board.dart:105` räumt genau einmal). Ein
Board mit 64 belegten Zellen kann nicht entstehen, weil das Füllen der letzten
Zelle einer Reihe diese sofort räumt; folglich passt immer mindestens das
`dot`-Teil, und die Rettungsregel (`generator.dart:44`) findet es. **Ein
unspielbarer Start ist unmöglich** — verifiziert über 3.000 Seeds (Test A-7).
Game Over entsteht ausschließlich dadurch, dass die *verbleibenden* Teile einer
Ablage nach eigenen Zügen nicht mehr passen. Korrekt so.

**Kantenfälle geprüft:** leeres Board ✓ · fast volles Board ✓ · Teil am Rand ✓ ·
gleichzeitiger Reihen- und Spaltenclear ✓ (`board.dart:139`, Set-basiert, keine
Doppelzählung) · Undo über einen Clear hinweg ✓ · Drehen bei 0 Ladungen ✓ ·
Reroll bei totem Board ✓ · Checkpoint mit 17 mutierten Feldern gefuzzt → 16×
sauberes `FormatException`, 1× `RangeError` (P2-1).

**Rätsel-Modus:** 120 Level generiert, **0 unlösbar**. Die Lösbarkeitsgarantie
hängt allerdings an einem `assert` (`puzzle.dart:338`), das im Release-Build
**abgeschaltet** ist — sie ist konstruktiv korrekt (jedes Loch wird von genau
einem Teil getilgt, jede Bandzeile schließt sich, wenn ihre Löcher gefüllt sind;
Zeile 7 bleibt immer frei, deshalb kann keine Spalte vorzeitig räumen), aber im
Release ungeprüft. Der Nachweis läuft jetzt in `soak.dart` mit Asserts aus.

### P1-5 · `PuzzleSolver` blockiert den UI-Thread nach jedem Zug

`puzzle_controller.dart:118` ruft nach **jeder** Platzierung synchron
`PuzzleSolver.solve(board, remaining, budget: 60000)` auf. Gemessen auf der
Desktop-VM (`soak.dart`, Abschnitt 7):

```
median 62,7 ms · p95 106,2 ms · max 176,3 ms
```

Auf einem Mittelklasse-Android-ARM ist das erfahrungsgemäß der 3-5-fache Wert →
**200–500 ms Standbild nach jedem Zug im Rätsel-Modus**. Der Solver alloziert
zudem pro Knoten einen Memo-String (`'${board.lo}_${board.hi}_$idx'`, Zeile 187)
— bis zu 60.000 String-Allokationen pro Zug.

*Tester-Erlebnis:* „Rätsel-Modus ruckelt/hängt nach jedem Teil."

*Fix (aufsteigend nach Aufwand):* (a) Budget auf ~8.000 senken — die Level haben
maximal 10 Teile, der Suchraum ist klein; (b) Memo-Key auf `int` umstellen
(`lo * 2^32`-frei: `(lo << 5) ^ hi ^ idx` in einer `Map<int,int?>`); (c) den
Solver erst laufen lassen, wenn für das *aktuelle* Teil kein Zug mehr existiert;
(d) in einen `Isolate` auslagern.

---

## E) Erste Sitzung — die kritischsten 60 Sekunden

Ablauf im Code nachverfolgt: `main()` → `AppBootstrap` → `HomeScreen` →
„Spielen" → `GameScreen`.

**Was funktioniert:** Kein Login, kein Namenszwang, kein Splash, kein Ad. Direkt
vom Start in die Runde. Die ersten 20 Züge einer allerersten Runde bekommen
gewichteten Fairness-Bonus (`firstRunEarlyPhaseMoves = 20`), Drehen ist bis
Level 2 gratis. Der erste Durchgang ist gewinnbar — 99,7 % aller Runden dauern
über 10 Züge. Das ist gut gemacht.

### P1-6 · Die Regeln werden dem Erstspieler nie gezeigt

`HowToPlayScreen` ist **ausschließlich** über ein 21 px großes
`help_outline`-Icon neben dem Titel (`home_screen.dart:340`) und über die
Einstellungen erreichbar. Es gibt keinen automatischen Erstaufruf.

Was der Erstspieler stattdessen bekommt: drei Einzeiler in der laufenden Runde
(`game_controller.dart:335`), die nach **drei Platzierungen** verbraucht sind —
`_advanceOnboarding()` zählt jede Platzierung, nicht jeden gelernten Schritt. Wer
seine ersten drei Teile irgendwohin legt, hat „Fülle eine ganze Reihe oder Spalte"
gelesen, ohne je eine Reihe geräumt zu haben, und das Onboarding ist beendet.

*Fix:* Beim allerersten Start `HowToPlayScreen` als Vollbild zeigen (mit
„Überspringen"), **oder** die Onboarding-Schritte an Ereignisse koppeln statt an
Zugzähler: Schritt 2 erst, wenn eine Reihe zu ≥ 6/8 gefüllt ist; Schritt 3 erst
nach dem ersten Clear.

### P1-7 · Game Over sagt nicht, warum

`_GameOverOverlay` (`game_screen.dart:665`) zeigt „Game Over" und die Punktzahl.
Der eigentliche Grund — *keines der verbleibenden Ablage-Teile passt noch* — wird
nirgends benannt und die betreffenden Teile werden nicht hervorgehoben. In einem
Genre, in dem der Tod immer überraschend kommt, ist das der wichtigste
Lernmoment, und er fehlt.

*Fix:* Eine Zeile „Kein Teil passt mehr" plus ein kurzes Aufblinken der
verbliebenen Ablage-Teile, bevor das Overlay einblendet (300 ms Verzögerung).

### P1-8 · Das Game-Over-Overlay baut sich unter dem Finger um

`place()` ruft bei Game Over `_finalizeRun()` → `_finalizeAsync()` — **ohne
`await`** (`game_controller.dart:862`). Das Overlay erscheint sofort mit
`coinsEarnedThisRun = 0`, `isNewHighscore = false`, ohne Level-Up-Karte, ohne
Missionen, ohne Erfolge. Erst nach ~10 `await`s auf `shared_preferences`
(Zeilen 868-985) folgt ein zweites `_emit()`, das bis zu sechs Blöcke **oberhalb**
der Buttons einfügt.

Ein schneller Tipp auf „Nochmal spielen" landet dann auf dem, was danach an
dieser Stelle steht — im Extremfall auf „Weiterspielen · 200 Münzen".

*Tester-Erlebnis:* „Der Bildschirm springt", „ich habe aus Versehen 200 Münzen
ausgegeben".

*Fix:* Overlay erst nach Abschluss von `_finalizeAsync()` einblenden (Flag
`_finalizing`, solange ein schlichtes „Game Over"), oder die Belohnungsblöcke in
einem Bereich fester Höhe reservieren.

### P2-3 · Sackgassen und fehlende Zustände

Sauber: Bestenliste hat Lade-, Fehler- und Leerzustand mit Retry
(`leaderboard_screen.dart:63-85`). Alle Screens haben einen Rückweg.

Offen:
- `_BoosterBar` meldet jeden Fehlschlag mit derselben Meldung „Nicht möglich (zu
  wenig Münzen?)" (`game_screen.dart:340`) — deckt drei verschiedene Ursachen ab
  (kein Undo verfügbar / zu wenig Münzen / Daily-Modus). Der Fragezeichen-Ton
  liest sich, als wisse die App es selbst nicht.
- Kein Ladezustand an den Video-Buttons. `showRewarded()` braucht real 1-3 s;
  bis dahin passiert sichtbar nichts.

---

## F) Spielschleife, Motivation, Wiederkehr

**Core Loop, wie sie im Code existiert:**
Teil ziehen → (evtl.) Linie räumen → Punkte + 3 Münzen/Linie + Combo-Bonus →
Ablage leer → 3 neue Teile → … → Game Over → Belohnungsbildschirm (Münzen, XP,
evtl. Level-Up mit Kosmetik, Missionen, Erfolge) → „Nochmal spielen".

**Sitzungslänge:** Median 84 s pro Runde, p95 183 s (BALANCE.md D.5). Für ein
Handyspiel richtig dimensioniert.

**Der „das war stark"-Moment existiert** und ist gut gebaut: Mehrfach-Clear →
Screen-Shake ab 3 Linien (`shake.dart`), Partikelburst skaliert mit Linienzahl
(`clear_burst.dart:33`), Score-Popup, aufsteigender Combo-Sound
(`game_controller.dart:717`), Fieber-Glow um das Board. Das ist mehr Juice als
die meisten Block-Puzzles haben.

**Grund, morgen wiederzukommen:** Daily Challenge + Streak (bis 150 Münzen/Tag)
+ lokale Benachrichtigungen (19:00 Erinnerung, 21:30 Streak-Warnung). Das ist
vorhanden und funktioniert. Die Bestenliste ist der eigentliche
Wiederkehr-Motor — sie ist global, es gibt keine Freundes- oder Wochenliste.

### P1-9 · Die Belohnungskurve trifft den Playtest nicht

Mit den gemessenen Median-Werten (BALANCE.md D.1, ~3.000 Punkte/Runde für
kompetente Spieler, ~200-500 für Erstspieler):

| Feature | Erste Auszahlung nach | Im Playtest sichtbar? |
|---|---|---|
| Level 2 | ~7 Runden (Guter) / ~30 (Anfänger) | knapp |
| Level 3 = erste Kosmetik „Fade-Theme" | ~15 / ~75 Runden | selten |
| Level 5 = erster Skin | ~38 / ~190 Runden | **nein** |
| Level 8-40 = 8 weitere Kosmetika | 88 – 475 Runden | **nein** |
| Sparschwein (500 Münzen, 1 pro Linie, ø 15 Linien/Runde) | **~33 Runden** | **nein** |
| Starter-Angebot | nach 5 Runden, 48 h Fenster | ja |
| Missionen (5 Stück, einmalig) | 100 Teile / 50 Linien / 10 Runden | ja, dann für immer erledigt |

Zwei Dinge fallen daraus:

1. **Der Belohnungspfad ist im Playtest praktisch unsichtbar.** Tester spielen
   10-20 Runden. Sie sehen: kein Skin, kein Sparschwein, ein Theme mit Glück.
   Das Feedback wird lauten „es gibt nichts zu erreichen" — und das wäre ein
   Messfehler, kein echtes Urteil über das Spiel.
2. **Die Missionen sind endlich.** `defaultMissions()` (`missions.dart:49`) ist
   eine feste Liste von fünf Karriere-Zielen ohne Rotation. Nach ~10 Runden ist
   der Missionen-Screen eine dauerhaft abgehakte Liste — ein Menüpunkt auf dem
   Home-Screen, der nie wieder etwas tut.

*Fix vor dem Playtest (klein und wirksam):* Sparschwein-Kapazität für den
Playtest auf 150-200 senken oder `coinsPerLine` auf 3 anheben; erste
Kosmetik-Belohnung von Level 3 auf Level 2 ziehen. Danach Tageszähler statt
Karriere-Zähler für 2-3 der Missionen (Daily-Missionen sind das
Standard-Retention-Werkzeug des Genres und fehlen komplett).

### P2-4 · Juice — die drei wirksamsten Stellen

Der vorhandene Juice ist überdurchschnittlich. Was am meisten fehlt:

1. **Die Platzierung selbst.** `place()` löst Haptik + Sound aus, aber das Teil
   erscheint ohne Übergang auf dem Board (`_BoardPainter.paint`, keine
   Einrast-Animation). Der Kernakt des Spiels — 40-mal pro Runde — hat keine
   visuelle Reaktion. Ein 120-ms-Scale-Punch (1,15 → 1,0) auf den gerade
   gesetzten Zellen ist der billigste große Gewinn im ganzen Spiel.
2. **Das Auflösen der Linie.** Zellen verschwinden im selben Frame; die Partikel
   starten aus dem Nichts. Ein 100-ms-Wipe entlang der Linie (links→rechts bzw.
   oben→unten), bevor die Zellen gelöscht werden, macht aus einem Zustandswechsel
   ein Ereignis.
3. **Das Aufnehmen aus der Ablage.** Kein Scale-Up, kein Schatten, kein
   Haptik-Tick beim Anfassen. Zusammen mit P2-6 (Teile sind winzig) ist das der
   Grund, warum sich das Ziehen unpräzise anfühlt.

---

## G) UI, Design, Gerätevielfalt

### P1-10 · Ablage-Teile sind ein Drittel so groß wie auf dem Board

`tray_view.dart:38`: `trayCell = ((height - 24) / 5).clamp(12.0, boardCell)`.
Bei `height = 96` ergibt das **14,4 px**. Die Board-Zelle ist bei 360 dp
Bildschirmbreite `(360 − 24) / 8 = 42 px`. Das Teil in der Ablage ist also **34 %
seiner tatsächlichen Größe** — beim Ziehen springt es auf das Dreifache
(`feedback: PieceView(cellSize: boardCell)`, Zeile 101).

Im Store-Screenshot `store-assets/screenshot-2-gameplay.png` ist der Effekt
deutlich sichtbar. Das Genre (Block Blast, Woodoku) hält Ablage und Board bei
70-100 % Größenverhältnis, genau weil der Spieler vor dem Anfassen abschätzen
muss, ob das Teil passt.

*Tester-Erlebnis:* „Man sieht die Teile schlecht", „ich verschätze mich dauernd".

*Fix:* Ablagehöhe auf 120-130 px erhöhen und `trayCell` auf `boardCell * 0.7`
als Untergrenze setzen; die Slots leer als schwach umrandete Kästen zeichnen
(aktuell ist ein verbrauchter Slot ein unsichtbares `SizedBox.shrink()`,
Zeile 75 — man sieht nicht, dass da mal ein Teil war).

### P1-11 · Dreh-Button ist 28 × 22 px — halb so groß wie das Minimum

`tray_view.dart:133`: `BoxConstraints.tightFor(width: 28, height: 22)`. Apple
und Google fordern beide **44 × 44** bzw. 48 × 48 dp. Verschärfend: der Button
liegt **innerhalb** des `Draggable` (Zeile 93). Ein Tipp, der um wenige Pixel
verrutscht, wird zum Drag-Start — das Teil hebt ab, statt sich zu drehen.

*Tester-Erlebnis:* „Drehen klappt manchmal nicht." Klassischer Rauschbefund.

*Fix:* `tightFor(width: 44, height: 36)` mit unverändert 21 px Icon; alternativ
Doppeltipp auf das Teil selbst zum Drehen und den Button entfernen.

### P1-12 · Kontrast des leeren Gitters: 1,14 : 1

Aus `theme.dart:9-12` berechnet (WCAG-Relativluminanz):

| Paar | Kontrast | WCAG-Minimum (Non-Text) |
|---|---|---|
| `emptyCell #23254E` vs `boardBackground #191B40` | **1,14 : 1** | 3 : 1 |
| `boardBackground #191B40` vs `background #0F1030` | **1,12 : 1** | 3 : 1 |
| `placed #4FE0C6` vs `emptyCell` | 8,7 : 1 | ✓ |

Der Spieler muss genau das lesen, was am schlechtesten sichtbar ist: **wo noch
Platz ist**. Im Screenshot verschwindet das Gitter fast vollständig im
Hintergrund. Draußen bei Sonnenlicht oder auf einem Display mit niedriger
Helligkeit ist das Board eine dunkle Fläche.

*Fix:* `emptyCell` auf ca. `#2E3170` anheben (→ ~1,9 : 1) und zusätzlich eine
1 px `gridLine`-Trennung zwischen den Zellen zeichnen — die Farbe `gridLine
#2E3068` existiert bereits und wird vom `_BoardPainter` **gar nicht benutzt**.

### P2-5 · Keine Orientierungssperre

Weder `SystemChrome.setPreferredOrientations` im Code noch
`android:screenOrientation` im Manifest; `ios/Runner/Info.plist:56` erlaubt
ausdrücklich Landscape. Beim Drehen ins Querformat greift `compactLayout`
(`game_screen.dart:99`, `height < 560`) und blendet **die komplette Booster-Leiste,
den „Neue Teile"-Button und alle Coach-Hinweise aus**.

*Tester-Erlebnis:* „Im Querformat sind die Booster weg."

*Fix:* Für den Playtest auf Portrait sperren (`setPreferredOrientations` in
`main()`, zusätzlich `android:screenOrientation="portrait"` und die Landscape-
Einträge aus der Info.plist entfernen). Ein echtes Querformat-Layout ist nach
dem Release ein eigenes Thema.

### P2-6 · Sicherer Bereich unten

Nur 6 von 15 Screens verwenden `SafeArea`; die übrigen verlassen sich auf
`AppBar` + Listenpadding. Kritisch sind die, die einen Button am unteren Rand
haben: `how_to_play_screen.dart` schließt mit 32 px Bottom-Padding unter dem
„Verstanden"-Button ab — auf Geräten mit Gestenleiste (typisch 24-34 dp) liegt
der Button auf der Kante. `settings_screen.dart` endet mit `SizedBox(height: 24)`.

*Fix:* `MediaQuery.viewPaddingOf(context).bottom` in das jeweilige Bottom-Padding
addieren, oder `SafeArea(bottom: true)` um den Body.

### P2-7 · Zahlen ohne Tausendertrennung

`'${snap.score}'` (`game_screen.dart:559`), `'$highscore'` (:548),
`'${snap.highscore}'` (`home_screen.dart:409`, 52 pt). Ein realistischer
Bestwert liegt bei 8.000-48.000 (BALANCE.md); als `48091` gerendert ist er
schwer zu erfassen und sprengt bei 52 pt die Zeile. Die App bringt `intl` nicht
mit — `NumberFormat.decimalPattern('de')` müsste als Abhängigkeit dazu, oder eine
zehnzeilige Hilfsfunktion.

Inkonsistent ist es ohnehin schon: `+1.000 Münzen`, `1.500 Münzen` und
`Räume insgesamt 1.000 Reihen` verwenden den Punkt, `2000 Münzen`, `6000 Münzen`,
`1200 Münzen` und `Knacke 1000 Punkte` nicht.

### P2-8 · Hardcodierter Preis „1,99 €"

`game_screen.dart:1062` — die Starter-Paket-Karte behauptet einen Preis, statt
`ShopProduct.price` aus dem Store zu lesen (der Shop-Screen macht es richtig,
`shop_screen.dart:135`). Bei abweichendem Store-Preis oder anderer Währung zeigt
die App eine falsche Zahl. Neben dem Tester-Befund ist das auch ein
Store-Richtlinien-Thema.

### P2-9 · Weitere Textbefunde

Rechtschreibung und Tonalität sind durchweg sauber — kein einziger Tippfehler in
~100 geprüften Strings. Zwei Kleinigkeiten:

- `feedback_screen.dart:116` — `„Submit new issue"` öffnet mit dem deutschen
  Anführungszeichen unten und schließt mit dem geraden `"`. Korrekt wäre `„…"`.
- Gedankenstriche wechseln zwischen `—` (em) und `–` (en), z. B.
  `coach_hints.dart:52` gegen `:49`.
- Alle Nutzertexte sind hardcodiert; es gibt keine `intl`-Vorbereitung, obwohl
  `CLAUDE.md` sie vorsieht. Für den Playtest irrelevant, für den Release nicht.

### P2-10 · Leerraum auf dem Home-Screen

`Spacer(flex: 2)` + `Spacer(flex: 3)` (`home_screen.dart:319`, `:398`) lassen auf
einem 20:9-Display rund 40 % der Fläche zwischen Titel und Bestwert leer (im
Screenshot gut sichtbar), während unten 13 Bedienelemente gedrängt stehen. Der
Bildschirm wirkt oben unfertig und unten überladen.

---

## H) Performance

Statisch geprüft, **nicht auf einem Gerät gemessen**:

| Punkt | Befund |
|---|---|
| Re-Renders | `GameSnapshot` hat kein `==` → jedes `_emit()` löst einen vollständigen Rebuild von `GameScreen` aus. Wegen der `RepaintBoundary`-Kapselung (`game_screen.dart:183`, `:195`, `:205`) bleibt der Schaden begrenzt. Vertretbar. |
| `_BoardPainter` | Alloziert pro Frame bis zu 64 `Paint()`-Objekte (`board_view.dart:198`). Auf schwacher Hardware GC-Druck während der Partikel-Animation. Ein wiederverwendetes `Paint` mit gesetzter Farbe kostet nichts. |
| `shouldRepaint` | Vergleicht `Board` per Identität (`Board` hat kein `==`). Korrekt, da jede Platzierung ein neues Objekt erzeugt. |
| Listen | Alle Listen sind kurz (Bestenliste ≤ 50, Level-Grid) und nutzen `.builder`. Keine fehlenden Keys mit Auswirkung. |
| Bundle | `assets/audio/music.wav` = **1,87 MB unkomprimiert** und damit 81 % aller Assets. Als `.ogg`/`.m4a` sind das 50-150 KB. Wird als Loop dauerhaft im Speicher gehalten. |
| Speicher über Runden | Alle Animations-Controller werden disposed; `_bursts`/`_popups` entfernen sich per Status-Listener. Kein erkennbares Wachstum. |
| Kaltstart | `main()` `await`et `Storage.create()` und `configureGameAudioSession()` vor `runApp` — beides schnell. Ads/IAP/Notifications laufen korrekt in `addPostFrameCallback`. Gut gebaut. |
| Rätsel-Modus | Siehe P1-5 — die einzige gemessene Blockade. |

`main.dart:19` — `await Storage.create()` ohne `try`/`catch`: schlägt
`SharedPreferences.getInstance()` fehl, stirbt die App vor dem ersten Frame ohne
Meldung. Selten, aber mit P0-1 zusammen unerklärlich für den Tester.

---

## I) Playtest-Infrastruktur

| Frage | Antwort |
|---|---|
| Crash-Reporting | **Android ja, iOS nein.** `firebase_boot_native.dart:23` bricht bei `!Platform.isAndroid` ab. Kommt Crashlytics auf Android durch, ist es korrekt verdrahtet (Flutter- **und** Plattform-Fehler). |
| Versions-/Buildnummer in der App | **Nein.** Nirgends im Repo. Die Einstellungs-Fußzeile sagt „Qubble • Offline Block Puzzle" (`settings_screen.dart:295`) — genau der Ort dafür. |
| Feedback-Weg | Vorhanden, aber **untauglich**: `feedback_screen.dart` öffnet einen vorbefüllten **GitHub-Issue-Composer** im Browser. Der eigene Hinweistext gibt es zu: „(Einmaliger GitHub-Login nötig.)" |
| Analytics-Ereignisse | 7 Ereignisse definiert (`analytics.dart:13`), davon werden 6 gefeuert. |
| Testbuild = echter Release-Build | Ja — und das ist Teil des Problems (P0-4). |

### P0-5 · Der Feedback-Kanal wird nichts liefern

Ein geschlossener Playtest mit normalen Testern und einem Feedback-Weg, der ein
GitHub-Konto voraussetzt, produziert null Rückmeldungen. Das ist der teuerste
Einzelbefund dieses Audits, weil er den Zweck des gesamten Tests aushebelt.

*Fix (Aufwand ~1 h):* Google-Form (oder Tally) verlinken und mit `url_launcher`
öffnen, Buildnummer + Plattform als vorbefüllte Query-Parameter anhängen — die
Kontextlogik dafür existiert bereits in `services/feedback.dart`. GitHub bleibt
als Zweitweg für technisch versierte Tester.

### P1-13 · Ohne Versionsanzeige ist jede Meldung wertlos

Bei mehreren Builds im Test lässt sich eine Meldung ohne Buildnummer keiner
Version zuordnen. *Fix:* `package_info_plus` als Abhängigkeit, in der
Einstellungs-Fußzeile `Qubble $version ($buildNumber)`, und dieselbe Zeichenkette
automatisch in den Feedback-Text.

### P1-14 · R8 ist neu aktiv und nie mit einem Release-Build geprüft

`android/app/build.gradle.kts:75` hat seit Commit `3438a3d`
`isMinifyEnabled = true` und `isShrinkResources = true`. Die `proguard-rules.pro`
sagt selbst: „Test a release build after enabling." — es gibt keinen Hinweis, dass
das je passiert ist, und die CI baut das Bundle, startet es aber nie.

Die Keep-Regeln decken Flutter, AdMob/UMP, Billing und Firebase ab. **Es fehlt
`flutter_local_notifications`**, obwohl das Manifest zwei seiner Receiver
namentlich referenziert und das Plugin seine Notification-Details per Gson
serialisiert. Das ist der bekannteste R8-Fallstrick dieses Pakets.

*Fix:*

```proguard
-keep class com.dexterous.** { *; }
-keep class com.google.gson.** { *; }
-keepattributes Signature, *Annotation*
```

und **vor dem Playtest** einmal das signierte Bundle auf einem echten Gerät
installieren: starten, Runde spielen, Benachrichtigungen aktivieren, Links in
den Einstellungen öffnen.

### P1-15 · `url_launcher` ohne `<queries>`-Eintrag

`AndroidManifest.xml` deklariert nur `PROCESS_TEXT` unter `<queries>`. Seit
Android 11 braucht `url_launcher` für externe Links einen expliziten
`<intent>`-Eintrag mit `android.intent.action.VIEW` und Schema `https`. Betroffen
sind drei Wege: Feedback (P0-5), Datenschutz und Impressum
(`settings_screen.dart:240`, `:248`) — also beide **rechtlich erforderlichen**
Links.

Ich habe das **nicht auf einem Gerät verifiziert**; das Fehlen des Eintrags ist
verifiziert, das konkrete Scheitern nicht.

*Fix:*

```xml
<queries>
  <intent>
    <action android:name="android.intent.action.VIEW"/>
    <data android:scheme="https"/>
  </intent>
</queries>
```

### P2-11 · Minimales Ereignis-Set für verwertbare Testdaten

Vorhanden: `game_start`, `round_complete` (mit Score + Modus), `reach_round_3`,
`daily_played`, `rewarded_watched` (mit Platzierung), `purchase`,
`theme_unlocked`.

Das trägt schon weit. Für die Fragen, die ein Playtest beantworten soll, fehlen
fünf:

| Ereignis | Beantwortet |
|---|---|
| `tutorial_step` (Schritt-Index) | Wo bricht das Onboarding ab? (→ P1-6) |
| `run_end` mit `placements` + `max_combo` | Ist es Können oder Pech? Wo endet die Runde? |
| `screen_view` (Screen-Name) | Welche der 13 Menüpunkte werden je geöffnet? |
| `booster_used` (Typ, Münzstand davor) | Werden die Booster überhaupt benutzt? |
| `session_end` (Dauer, Runden) | Sitzungslänge — heute nicht messbar |

Alle fünf sind Einzeiler im bestehenden `Analytics`-Interface.

### P2-12 · Admin-Riegel: halb erfüllt

`CLAUDE.md` verlangt doppelte Verriegelung (UI **und** Controller).
`setCoinsForTest` ist korrekt doppelt gesichert (`game_controller.dart:579`).
Die Einträge „+1.000 Münzen" und „+10.000 Münzen"
(`settings_screen.dart:265`, `:272`) rufen dagegen `grantCoins()` auf — eine
reguläre öffentliche API ohne `kReleaseMode`-Riegel. Praktisch **nicht
ausnutzbar**, weil `kDebugMode` im Release eine Compile-Zeit-Konstante `false` ist
und der ganze Zweig wegoptimiert wird. Aber die Regel ist so nicht erfüllt.

*Fix:* Eine `grantDebugCoins(int)`-Methode mit eigenem `if (kReleaseMode) return;`
für diese zwei Einträge.

---

## J) Vorhersage — was Tester zuerst melden

Sortiert nach Wahrscheinlichkeit. „Fixbar" = vor dem Testbeginn machbar.

| # | Meldung | Ursache | Fixbar |
|---|---|---|---|
| 1 | „Drehen funktioniert nicht zuverlässig" | P1-11 · 28×22 px innerhalb des Draggable | **Ja** — eine Zeile |
| 2 | „Man sieht schlecht, was passt / ich verschätze mich" | P1-10 + P1-12 · Teile 34 % zu klein, Gitter 1,14:1 | **Ja** — zwei Konstanten |
| 3 | „Es gibt nichts zu erreichen / Belohnungen kommen nie" | P1-9 · Sparschwein 33 Runden, erster Skin 38 Runden | **Ja** — Zahlen senken |
| 4 | „Warum bin ich gestorben?" | P1-7 · Game Over nennt den Grund nicht | **Ja** — eine Zeile Text |
| 5 | „Der Game-Over-Bildschirm springt" / Fehltipp auf Revive | P1-8 · `_finalizeAsync` ohne await | **Ja** |
| 6 | „Zurück-Taste macht komische Sachen" | P1-1 · kein `PopScope` | **Ja** |
| 7 | „Sounds klingen mal höher, mal tiefer" | `audio.dart:94` · `setPlaybackRate` wird nie zurückgesetzt, Pool rotiert | **Ja** — `if` streichen |
| 8 | „Meine Runde war weg" | P0-2 · Daily löscht den Endlos-Checkpoint | **Ja** |
| 9 | „Rätsel-Modus ruckelt nach jedem Zug" | P1-5 · Solver 63-176 ms auf dem UI-Thread | **Ja** — Budget senken |
| 10 | „Im Querformat fehlen die Booster" | P2-5 · keine Orientierungssperre | **Ja** |

Knapp darunter, gleiche Kategorie: „Kaufen-Button tut nichts" (P1-4), „Bombe zeigt
Punkte, obwohl sie keine gibt" (`_lastGained` wird von `tryBomb` nicht
zurückgesetzt, `game_controller.dart:832`, verifiziert Test A-2), „alle Rätsel
geben 3 Sterne" (verifiziert Test A-3), „Zahlen ohne Punkt sind schwer zu lesen"
(P2-7).

**Alle zehn sind vor dem Test behebbar.** Neun davon sind Änderungen von unter
20 Zeilen.

---

## Was ich nicht prüfen konnte

| Bereich | Grund |
|---|---|
| Tatsächliche Bildrate, Ruckler, Speicherwachstum auf Hardware | Kein Gerät und kein Emulator in dieser Umgebung. Alle Performance-Aussagen sind aus dem Code abgeleitet, die Solver-Zeiten auf der Desktop-VM gemessen. |
| Ob `url_launcher` ohne `<queries>` real scheitert (P1-15) | Fehlen des Eintrags verifiziert, Verhalten nicht. |
| Ob R8 die Benachrichtigungen bricht (P1-14) | Kein Android-SDK/Gradle hier; Regel-Lücke verifiziert, Auswirkung nicht. |
| iOS insgesamt | Keine macOS-Toolchain. Aussagen zu iOS stammen aus `Info.plist` und `ad_config.dart`. |
| Reales AdMob-/UMP-Verhalten und Kaufabläufe | Erfordert Store-Konten und echte Geräte. |
| Touch-Genauigkeit, Drag-Gefühl, Haptik | Nicht simulierbar. P1-10/P1-11 sind aus Pixelmaßen abgeleitet. |
| Kaltstartzeit, Bundle-Größe des fertigen `.aab` | Kein Build möglich. |
| Store-Screenshots | `store-assets/*.png` stammen aus einem älteren Build (zeigen einen inzwischen entfernten „Drehen"-Booster-Chip). Für Layout-Aussagen verwendet, für Feature-Aussagen nicht. |

---

## Verwendete Werkzeuge

Alle unter `scripts/audit/` — reine Analyse, kein App-Code:

- `soak.dart` — Stabilität, Determinismus, Checkpoint-Fuzzing, Rätsel-Validierung.
  `dart run scripts/audit/soak.dart 20000`
- `balance.dart` — Schwierigkeitskurve, dominante Strategie, Fehlstart-Fairness.
  `dart run scripts/audit/balance.dart 3000`
- `verify_findings.dart` — beweist die Befunde A-1 bis A-7 als Tests.
  `flutter test scripts/audit/verify_findings.dart`
