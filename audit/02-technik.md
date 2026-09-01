# 02 — Technikaudit

Erhoben am 2026-08-31 auf Commit `e07354f` (+ Audit-Commits), Flutter 3.47.2 /
Dart 3.13.2.

## Was in dieser Session tatsächlich lief

| Kommando | Ergebnis |
|---|---|
| `flutter analyze` | `No issues found! (ran in 12.6s)` |
| `flutter test` | `00:32 +441: All tests passed!` |
| `flutter test --coverage` | 3 717 / 5 663 Zeilen = **65,6 %** |
| `flutter build web --release --base-href /Qubble/ --no-web-resources-cdn` | `✓ Built build/web` in 46,5 s |
| eigene Messsonde: Layout-Overflow über 8 Screens × 4 Textskalen × 2 Sprachen | 64 Fälle, Befunde unten |

## Was in dieser Session nicht geht

**Der Release-AAB lässt sich hier nicht bauen.** `flutter doctor` meldet
`✗ Unable to locate Android SDK`, und der Download der Command-Line-Tools
scheitert am Egress-Proxy:

```
$ curl -sSI https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
curl: (56) CONNECT tunnel failed, response 403
```

Damit sind **AAB-Größe, Download-Größe, R8-Verhalten, das gemergte Manifest,
Kaltstartzeit auf Gerät, Frame-Timing und Speicherverhalten in dieser Session
nicht messbar**. Ich schreibe für diese Punkte keine Schätzwerte hin.

Der Weg dorthin existiert bereits im Repo: Der Workflow
`.github/workflows/build-release.yaml` baut das signierte Bundle, gibt die
gemergten Permissions aus, prüft `targetSdkVersion`, die Signatur, das
eingebettete R8-Mapping und die 16-KB-Page-Ausrichtung. **Ein manueller Lauf von
„Build Android Release" beantwortet alle oben offenen Punkte.** Das ist die
erste Empfehlung dieser Phase und kostet 10 Minuten.

Als Ersatz-Compile-Nachweis dient der Web-Release-Build (baut sauber, 46,5 s).
Er beweist, dass die gesamte Dart-Kompilierung im Release-Modus mit
Tree-Shaking durchläuft, sagt aber nichts über R8 oder die Android-Plattform.

---

## Befunde

Sortiert nach Schweregrad.

### T-1 — Layout-Overflows auf drei Screens, schon bei Standard-Textgröße · **P1**

**Fundstellen:** `lib/ui/screens/achievements_screen.dart`,
`lib/ui/screens/themes_screen.dart`, `lib/ui/screens/stats_screen.dart`

**Messung.** Ich habe eine Sonde geschrieben, die acht Screens auf 360×640 in
beiden Sprachen bei vier Textskalen rendert und `RenderFlex overflowed`-Fehler
zählt. Bei **Textskala 1.0**, also der Werkseinstellung:

| Screen | Sprache | Overflows | größter |
|---|---|---:|---|
| `StatsScreen` | EN + DE | 7 | 14 px unten |
| `AchievementsScreen` | EN + DE | 1 | **177 px rechts** |
| `ThemesScreen` | EN | 5 | 22 px rechts |
| `ThemesScreen` | **DE** | 5 | **122 px rechts** |

`HomeScreen`, `SettingsScreen`, `ShopScreen`, `HowToPlayScreen` sind bei 1.0
sauber.

**Warum das bisher niemandem auffiel.** `test/widget/compact_layout_test.dart`
prüft 360×640, 360×800 und 800×360 — aber nur für Home und das Spielfeld.
Stats, Achievements und Themes sind in keinem Layout-Test enthalten. Ihre
Coverage bestätigt das: `stats_screen.dart` 0,8 %,
`achievements_screen.dart` 1,3 %.

**Reproduktion.** Screen auf einem 360×640-Viewport rendern und auf
`RenderFlex overflowed` prüfen — genau das, was die Sonde tat.

**Fix.** Die betroffenen `Row`s mit `Expanded`/`Flexible` versehen und den
Texten `overflow: TextOverflow.ellipsis` geben. Bei `ThemesScreen` ist die
Ursache erkennbar der `Row` ab `themes_screen.dart:98` mit `Expanded` nur auf
einem Kind. Dazu die drei Screens in `compact_layout_test.dart` aufnehmen.

**Aufwand:** 2–3 h inklusive Tests.

### T-2 — Systemschriftgröße wird nirgends berücksichtigt · **P1**

**Fundstelle:** kein Treffer für `textScaler`/`textScaleFactor` in `lib/`
(`grep -rn "textScaler\|textScaleFactor" lib/` → leer)

**Messung**, dieselbe Sonde, 360×640, größter Overflow je Skala:

| Screen | 1.0 | 1.3 | 1.5 | 2.0 |
|---|---:|---:|---:|---:|
| `AchievementsScreen` | 177 px | 303 px | 387 px | **597 px** |
| `ThemesScreen` (DE) | 122 px | 206 px | 262 px | **402 px** |
| `StatsScreen` | 14 px | 30 px | 64 px | 176 px |
| `HomeScreen` | sauber | 6 px | 47 px | 149 px |
| `ShopScreen` (DE) | sauber | sauber | sauber | 106 px |

Ab Skala 1.3 — der ersten Stufe über der Werkseinstellung, die Android in den
Bedienungshilfen anbietet — ist auch der **Startbildschirm** betroffen.

**Warum das zählt.** Vergrößerte Systemschrift ist bei der Zielgruppe eines
entspannten Casual-Puzzles überdurchschnittlich verbreitet. Ein Spieler mit
Skala 1.5 sieht auf dem Startbildschirm abgeschnittene Beschriftungen — und
schreibt darüber eine Bewertung.

**Fix.** Zwei Ebenen: (a) die Overflows aus T-1 sauber machen, das trägt bis
etwa 1.3; (b) für die Kacheln mit fixer Höhe einen `TextScaler`-Deckel
einziehen (`MediaQuery.withClampedTextScaling(maxScaleFactor: 1.3, …)`), damit
das Spielfeld-Layout nicht kippt. Dazu die Sonde als dauerhafter Test.

**Aufwand:** 4–6 h.

### T-3 — Drei hartkodierte deutsche Strings; der l10n-Test kann sie nicht finden · **P1**

**Fundstellen:**

| Datei:Zeile | String |
|---|---|
| `lib/ui/screens/achievements_screen.dart:38` | `title: const Text('Erfolge')` |
| `lib/ui/screens/achievements_screen.dart:89` | `'$unlocked / $total freigeschaltet'` |
| `lib/ui/screens/settings_screen.dart:351` | `const _SectionLabel('Spielstand')` |

Ein englischsprachiger Spieler sieht auf dem Erfolge-Bildschirm eine deutsche
Titelzeile und eine deutsche Fortschrittsangabe. Das verstößt gegen die
Projektregel in `CLAUDE.md` („nie hartkodiert ins Widget") und widerspricht dem
Store-Versprechen einer englischen Fassung.

**Die eigentliche Ursache ist der Wächter.** `test/l10n/translations_test.dart`
prüft laut seinen Testnamen: dass Deutsch jeden englischen Schlüssel übersetzt
(`:36`), dass Platzhalter übereinstimmen (`:52`), dass **jeder Schlüssel
irgendwo benutzt wird** (`:65`) und dass keine Nachricht leer ist (`:88`).

Alle vier prüfen die Richtung `arb → Code`. Ein String, der **nie** in eine
`.arb` gelangt ist, ist für diesen Test unsichtbar. Der Test kann per
Konstruktion genau die Klasse Fehler nicht finden, gegen die er aufgestellt
wurde.

**Fix.** Die drei Strings nach `app_en.arb`/`app_de.arb` ziehen. Dazu einen
Test in der Gegenrichtung: `lib/ui/**` nach `Text('…')`-Literalen mit mehr als
zwei Zeichen scannen und gegen eine kurze Allowlist prüfen (`'English'`,
`'Deutsch'`, reine Trennzeichen). Das schließt die Lücke dauerhaft.

**Aufwand:** 2 h.

### T-4 — R8 ohne Keep-Regeln für `flutter_local_notifications` · **P1** (hier nicht verifizierbar)

**Fundstellen:** `android/app/build.gradle.kts:76-81` (`isMinifyEnabled = true`,
`isShrinkResources = true`), `android/app/proguard-rules.pro` (21 Zeilen, keine
Regel für `com.dexterous.**`)

**Beleg für das Risiko**, im Pub-Cache geprüft:
- `flutter_local_notifications` 18.0.1 liefert **keine** Consumer-ProGuard-Datei
  (`find …/flutter_local_notifications-18.0.1/android -iname '*proguard*'` → leer)
- der Code nutzt Gson-Reflexion in `ScheduledNotificationReceiver.java`,
  `models/NotificationDetails.java`, `models/ScheduleMode.java` und
  `RuntimeTypeAdapterFactory.java`

Gson serialisiert geplante Benachrichtigungen über Feldnamen. R8 benennt
Felder um, wenn keine Keep-Regel sie schützt. Die Wirkung zeigt sich erst nach
einem Neustart des Geräts oder einem App-Update, wenn der `BootReceiver` die
gespeicherten Benachrichtigungen deserialisiert — also genau dort, wo niemand
hinschaut.

Das ist derselbe Punkt, den das frühere `AUDIT.md` als P1-14 offen ließ. Er ist
seither nicht geschlossen worden.

**Fix.** In `proguard-rules.pro`:

```
-keep class com.dexterous.** { *; }
-keep class com.google.gson.** { *; }
-keepattributes Signature, *Annotation*, InnerClasses, EnclosingMethod
```

Danach Release-Build via CI, auf einem Gerät installieren, Erinnerung
aktivieren, Gerät neu starten, prüfen ob die Benachrichtigung kommt.

**Aufwand:** 15 min Regeln + 30 min Gerätetest.

### T-5 — `migrate()` implementiert den Fall nicht, für den es gebaut wurde · **P2**

**Fundstelle:** `lib/services/storage.dart:131-145`

```dart
Future<void> migrate() async {
  final stored = _prefs.getInt(_kSchemaVersion);
  if (stored == schemaVersion) return;
  if (stored == null) { … return; }
  if (stored > schemaVersion) { await resetProgress(); }
  await _prefs.setInt(_kSchemaVersion, schemaVersion);
}
```

Der Docstring bei `schemaVersion` (`storage.dart:72-74`) sagt:

> Bump this whenever a stored value changes shape in a way older data cannot
> satisfy; `migrate` then clears exactly the progress keys rather than letting
> a decode blow up at startup.

Der Fall `stored < schemaVersion` — also **das Upgrade**, für das der ganze
Mechanismus existiert — hat keinen Zweig. Er stempelt nur die neue Version und
lässt die alten Daten stehen.

**Warum es heute nicht knallt:** `schemaVersion` steht auf 1, es gibt keine
kleinere gespeicherte Version. Der Fehler ist eine gestellte Falle, kein
aktueller Absturz.

**Testabdeckung**, geprüft in `test/services/storage_corruption_test.dart`:
Zeile 101 deckt `stored == schemaVersion` ab, Zeile 115 deckt
`schemaVersion + 1` ab. Der Vorwärtsfall ist **nicht getestet**.

Entschärft wird das teilweise durch `_readJsonMap` (`storage.dart:159-172`), das
jeden Decode-Fehler abfängt und den Fallback liefert. Das ist ein guter zweiter
Riegel — aber er macht `schemaVersion` funktionslos, statt es zu retten.

**Fix.** Entweder den Vorwärtszweig implementieren (`if (stored != schemaVersion)
await resetProgress();`) oder den Docstring auf das reduzieren, was der Code
tut. Ersteres, plus ein Test mit `schemaVersion - 1`.

**Aufwand:** 1 h.

### T-6 — Der IAP-Fehlergrund wird nie geloggt · **P2**

**Fundstelle:** `lib/monetization/iap.dart:226`

```dart
debugPrint('Purchase failed: \${purchase.error}');
```

Das `\$` in einem einfach gequoteten Dart-String macht die Interpolation zum
Literal. Ausgegeben wird wörtlich `Purchase failed: ${purchase.error}`.

Die Ironie: Der Kommentar zwei Zeilen darüber erklärt, dass ein fehlgeschlagener
Kauf früher „swallowed" wurde. Der Fehler wird jetzt an die UI gemeldet
(`_onFailure`), aber der *Grund* geht weiterhin verloren — und zwar in genau
der Zeile, die ihn festhalten sollte.

**Fix.** Backslash entfernen. Ein Test, der `debugPrint` abfängt und prüft, dass
der Fehlertext vorkommt.

**Aufwand:** 15 min.

### T-7 — `music.wav`: 1,78 MB unkomprimiert · **P2**

**Messung:**

| Datei | Format | Größe |
|---|---|---:|
| `music.wav` | 22 050 Hz, mono, 16 bit PCM | **1 824,0 KB** |
| die sechs Effekte zusammen | dito | 69,3 KB |
| `Nunito.ttf` | Variable Font | 270,4 KB |

Rund 42 Sekunden Hintergrundmusik als unkomprimiertes PCM. Als OGG Vorbis bei
64 kbit/s mono wären das etwa 330 KB — eine Ersparnis von **rund 1,5 MB** im
AAB. `audioplayers` 6.8.1 spielt OGG auf Android nativ ab.

**Einordnung**, damit die Zahl nicht überverkauft wird: Google beziffert den
Zusammenhang mit **6 MB Größenzuwachs ≈ 1 % weniger Installationen**
(<https://medium.com/googleplaydev/shrinking-apks-growing-installs-5d3fcba23ce2>,
abgerufen 2026-08-31). 1,5 MB entsprechen damit rund 0,25 % Installationsrate.
Das ist wenig — aber es ist eine halbe Stunde Arbeit und kostet nichts.

**Fix.** `music.wav` → `music.ogg` konvertieren, `pubspec.yaml`-Assets und
`lib/services/audio.dart` anpassen, `assets/CREDITS.md` nachziehen. Der Web-Build
profitiert doppelt (siehe unten).

**Aufwand:** 30 min.

### T-8 — Kaltstart: vier `await`s vor dem ersten Frame · **P2**

**Fundstelle:** `lib/main.dart:36, 45, 65, 69` — alle vor `runApp` in `:75`

```
:36  await SystemChrome.setPreferredOrientations(…)
:45  storage = await Storage.create()
:65  await configureGameAudioSession()
:69  final firebaseAnalytics = await initFirebase()
:75  runApp(…)
```

`Storage.create()` ist berechtigt — ohne Save kein Spiel, und der Fehlerpfad
darunter ist sauber gebaut. Die anderen drei sind es nicht:

- `initFirebase()` (`:69`) startet Firebase Core, Analytics und Crashlytics über
  Plattform-Kanäle. Das ist die teuerste Operation der Kette und **nichts an
  der ersten Bildschirmseite hängt davon ab** — `analyticsProvider` könnte mit
  `DebugAnalytics` starten und nachträglich überschrieben werden.
- `configureGameAudioSession()` (`:65`) wird gebraucht, bevor der erste Ton
  spielt, nicht bevor der erste Frame steht.

**Was ich nicht behaupte:** Ich habe die Kaltstartzeit nicht gemessen — dafür
fehlt das Android SDK. Dass diese Kette den ersten Frame verzögert, folgt aus
der Programmstruktur; **um wie viel**, ist unbekannt und über die Play-Console
(Android Vitals → Startzeit) oder ein lokales `flutter run --profile --trace-startup`
messbar.

**Fix.** Crashlytics-Handler früh installieren (die sind billig), Analytics und
Audio-Session nach `runApp` nachladen.

**Aufwand:** 2 h inklusive Test, dass die App ohne fertiges Firebase startet.

### T-9 — Kein Timeout auf den Bestenlisten-Abrufen · **P2**

**Fundstelle:** `lib/services/leaderboard.dart:105, 149, 177, 192` — vier
`http`-Aufrufe, keiner mit `.timeout(...)`
(`grep -nE "timeout|Duration" lib/services/leaderboard.dart` → leer)

**Was davon gut ist:** Der Upload ist korrekt entkoppelt.
`autoUploadBestScore()` (`game_controller.dart:579-595`) kapselt den Aufruf in
`unawaited(...)`, und `submit()` fängt jeden Fehler ab und gibt `false` zurück.
Ein hängender Upload blockiert das Spiel **nicht**. Das ist sauber gelöst.

**Was fehlt:** `fetchTop()` (`leaderboard_screen.dart:29, 35`) hängt in einem
`FutureBuilder`. Bei einer Verbindung, die annimmt aber nie antwortet — Hotelnetz
mit Captive Portal, Funkloch mit Restverbindung — dreht der Spinner unbegrenzt.
Der Retry-Knopf existiert, erscheint aber nur im Fehlerzustand, den es dann nie
gibt.

**Fix.** `.timeout(const Duration(seconds: 10))` auf `fetchTop()`, damit der
vorhandene Fehlerpfad greift. Beim Upload ein großzügigeres Timeout (30 s),
damit die Retry-Logik nicht an einem toten Socket klebt.

**Aufwand:** 1 h mit Test über den vorhandenen Fake-Client.

### T-10 — Barrierefreiheit ist praktisch nicht adressiert · **P3**

**Messung:**

| Kennzahl | Wert |
|---|---|
| `Semantics`/`semanticLabel`-Vorkommen in `lib/ui/` (9 682 Zeilen) | **7** |
| davon in nur drei Dateien | `how_to_play_screen`, `game_screen` |
| `IconButton`-Instanzen | 8 |
| davon mit `tooltip:` | 3 |
| Behandlung der Systemschriftgröße | keine (siehe T-2) |

Für das Spielfeld selbst ist das vertretbar — ein Drag-and-Drop-Raster ist mit
TalkBack ohnehin schwer bedienbar, und niemand erwartet das von einem
Block-Puzzle. Für **Menüs, Shop und Einstellungen** ist es das nicht: Fünf
Icon-Knöpfe ohne Beschriftung sind für TalkBack stumm.

**Fix.** `tooltip:` auf allen `IconButton`s (ist zugleich der Semantics-Label),
`semanticLabel` auf den bedeutungstragenden Icons. Das Spielfeld bleibt
ausgenommen und wird als solches dokumentiert.

**Aufwand:** 2 h.

---

## Bereiche, die geprüft wurden und in Ordnung sind

Der Vollständigkeit halber, weil ein Audit ohne diese Liste ein verzerrtes Bild
gibt:

| Bereich | Befund | Beleg |
|---|---|---|
| Statische Analyse | sauber | `flutter analyze` → No issues found |
| Testsuite | 441 Tests grün | `flutter test` |
| Abdeckung der Spiellogik | **94,6 %** in `lib/game` | lcov |
| Rätsel-Solver auf dem UI-Thread | bewusst budgetiert (25 000 Knoten), Ausstieg dokumentiert | `lib/game/puzzle.dart:216-263` |
| Rewarded-Ad ohne Rückmeldung | 120-s-Timeout vorhanden | `lib/monetization/ads.dart:44, 172-180` |
| Bestenlisten-Upload blockiert Gameplay | nein, `unawaited` + Fehler abgefangen | `game_controller.dart:588-594` |
| Absturz beim Laden eines kaputten Saves | abgefangen, eigener Fehlerschirm | `main.dart:43-57`, `storage.dart:159-172` |
| Rotation | auf Hochformat verriegelt, begründet | `main.dart:36-39` |
| Fehlerschirm vor dem ersten Frame | installiert | `main.dart:28` |
| Web-Build ohne Plattform-Plugins | Fakes statt Abstürze | `main.dart:75-97` |
| Signatur-Fallback auf Debug-Key | durch Gradle-Guard blockiert | `build.gradle.kts:88-104` |
| Release-Artefakt-Verifikation | umfangreich (Signatur, Mapping, 16 KB, targetSdk) | `build-release.yaml` |

Das Fundament ist solide. Die Befunde oben sitzen fast alle in der Peripherie —
Nebenbildschirme, Assets, Startreihenfolge — nicht in der Spiellogik.

## Nebenbefund für den Web-Build

`build/web` ist nach dem Release-Build **44 MB** groß. Der Löwenanteil sind
sechs CanvasKit-Varianten (`canvaskit.wasm` 6,95 MB, `skwasm_heavy.wasm`
4,97 MB, …), von denen der Browser jeweils nur eine lädt — die Zahl ist also
nicht die Downloadgröße. Der größte selbst verschuldete Posten ist
`music.wav` mit 1,78 MB (T-7), und der wird auf dem Web tatsächlich vollständig
geladen.

---

## Priorisierte Kurzliste

| # | Befund | Schwere | Aufwand |
|---|---|---|---|
| 0 | CI-Release-Build starten — beantwortet AAB-Größe, Manifest, R8 | Voraussetzung | 10 min |
| T-4 | R8-Keep-Regeln für `flutter_local_notifications` | P1 | 45 min |
| T-1 | Layout-Overflows auf drei Screens bei Standardgröße | P1 | 2–3 h |
| T-3 | Hartkodierte deutsche Strings + Wächter in Gegenrichtung | P1 | 2 h |
| T-2 | Systemschriftgröße | P1 | 4–6 h |
| T-5 | `migrate()` Vorwärtsfall | P2 | 1 h |
| T-6 | IAP-Fehlerlogging | P2 | 15 min |
| T-9 | Timeout auf `fetchTop()` | P2 | 1 h |
| T-7 | `music.wav` → OGG | P2 | 30 min |
| T-8 | Kaltstartkette entzerren | P2 | 2 h |
| T-10 | Barrierefreiheit in den Menüs | P3 | 2 h |

---

## Quellen

| URL | Titel | Abrufdatum |
|---|---|---|
| <https://medium.com/googleplaydev/shrinking-apks-growing-installs-5d3fcba23ce2> | Shrinking APKs, growing installs (Sam Tolomei, Google Play) | 2026-08-31, über Websuche |
| <https://developer.android.com/games/optimize/game-size> | Reduce game size | 2026-08-31, über Websuche |

Alle übrigen Aussagen dieser Phase beruhen auf Kommandos, die in dieser Session
gegen diesen Checkout ausgeführt wurden, oder auf Fundstellen im Repo.
