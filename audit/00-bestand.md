# 00 — Bestandsaufnahme

Reine Fakten. Keine Bewertung, keine Empfehlung. Jede Zeile ist entweder eine
Fundstelle (`datei:zeile`) oder die Ausgabe eines in dieser Session ausgeführten
Kommandos.

Erhoben am 2026-08-31 auf Commit `e07354f`, Branch
`claude/qubble-audit-compliance-32drdu`.

---

## 1. Stack und Toolchain

Der Auftragstext nennt das Repo „mobile game". Das Repo heißt heute `Qubble`
(Umbenennung dokumentiert in Commit `e9d28f1` „Fix links broken by the
mobile-game → Qubble repo rename"). Remote: `https://github.com/f6vp76ctbb-stack/Qubble`.

Es ist **kein** JS/TS-Projekt. Ermittelt aus `pubspec.yaml:1` und der
Verzeichnisstruktur:

| Merkmal | Wert | Beleg |
|---|---|---|
| Framework | Flutter | `pubspec.yaml:31-33` |
| Sprache | Dart | alle 79 Quelldateien unter `lib/` sind `.dart` |
| Pubspec-Paketname | `gridpop` | `pubspec.yaml:1` |
| App-Name (Anzeige) | Qubble | `android/app/src/main/AndroidManifest.xml:6` |
| Version | `1.1.0+4` | `pubspec.yaml:19` |
| Dart-SDK-Constraint | `^3.12.2` | `pubspec.yaml:22` |
| Engine/Renderer | Flutter-Standard (kein Game-Engine-Paket) | keine `flame`/`bonfire`-Abhängigkeit in `pubspec.yaml` |
| State Management | Riverpod | `pubspec.yaml:46` |

Installierte Toolchain in dieser Session (`flutter --version`, nachdem
`scripts/setup.sh` den SDK geklont hat — Flutter ist in der Cloud-Umgebung nicht
vorinstalliert):

```
Flutter 3.47.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision d3b14c8769 (5 days ago) • 2026-08-26 16:07:51 -0700
Engine • hash 1cf1c4773fb941c4c74a7f8bb144a8837596c0f4 (revision a804b26164)
Tools • Dart 3.13.2 • DevTools 2.60.0
```

---

## 2. Verzeichnisstruktur

```
lib/
  app_info.dart          Build-Identität (Version aus --dart-define)
  main.dart              Einstiegspunkt, DI-Overrides
  game/       (22 Dateien) Pure-Dart-Spiellogik
  ui/         (35 Dateien) Screens, Widgets, Controller
  monetization/ (4)        Ads, IAP, Purchase-Delivery
  services/   (13)         Storage, Analytics, Audio, Notifications, Leaderboard …
  l10n/       (5)          2 .arb-Quellen + 3 generierte Dateien
test/         (61 Dateien)
android/  ios/  web/
store-assets/  docs/  firebase/  assets/  scripts/  tool/
```

Zeilenzahlen (`find … | xargs cat | wc -l`):

| Bereich | Zeilen |
|---|---:|
| `lib/ui` | 9 682 |
| `lib/l10n` (davon generiert) | 3 747 |
| `lib/game` | 2 787 |
| `lib/services` | 1 544 |
| `lib/monetization` | 615 |
| `lib` (Wurzel) | 218 |
| `test` | 7 168 |
| `scripts/audit` (Dev-Werkzeuge) | 1 240 |
| `tool` (Screenshot-/Grafik-Generatoren) | 1 167 |

Die in `CLAUDE.md` beschriebene Trennung ist eingehalten: `lib/game/` enthält
keinen Flutter-Import (geprüft: kein `package:flutter/` in den 22 Dateien außer
`foundation.dart`-freien Pure-Dart-Modulen).

---

## 3. Abhängigkeiten mit aufgelösten Versionen

Aus `pubspec.lock`, gefiltert auf die in `pubspec.yaml` direkt deklarierten
Pakete:

| Paket | Aufgelöste Version | Zweck laut `pubspec.yaml` |
|---|---|---|
| `flutter_riverpod` | 2.6.1 | State Management |
| `shared_preferences` | 2.5.5 | lokale Persistenz |
| `audioplayers` | 6.8.1 | Soundeffekte, Musik |
| `google_mobile_ads` | 9.0.0 | AdMob + UMP-Consent |
| `in_app_purchase` | 3.3.0 | IAP |
| `flutter_local_notifications` | 18.0.1 | lokale Erinnerungen |
| `timezone` | 0.9.4 | Zeitzonen für geplante Notifications |
| `flutter_timezone` | 4.1.1 | Geräte-Zeitzone |
| `url_launcher` | 6.3.2 | Feedback-Mail, Rechtstexte |
| `in_app_review` | 2.0.12 | Play In-App-Review |
| `http` | 1.6.0 | Firestore-REST (Bestenliste) |
| `firebase_core` | 4.12.1 | Firebase-Bootstrap |
| `firebase_analytics` | 12.4.5 | Analytics |
| `firebase_crashlytics` | 5.2.6 | Crash-Reporting |
| `intl` | 0.20.3 | Zahlen-/Datumsformatierung |
| `cupertino_icons` | 1.0.9 | Icons |
| `flutter_lints` (dev) | 6.0.0 | Lint-Regelsatz |
| `flutter_launcher_icons` (dev) | 0.14.4 | Icon-Generierung |

`flutter pub get` meldet: „51 packages have newer versions incompatible with
dependency constraints."

---

## 4. Build-Konfiguration Android

| Merkmal | Wert | Beleg |
|---|---|---|
| `applicationId` / `namespace` | `com.thinkube.qubble` | `android/app/build.gradle.kts:41,44` |
| `minSdk` | **24** | `build.gradle.kts:46` → `FlutterExtension.kt:26` |
| `targetSdk` | **36** | `build.gradle.kts:47` → `FlutterExtension.kt:34` |
| `compileSdk` | 36 | `build.gradle.kts:35` → `FlutterExtension.kt:23` |
| NDK | 28.2.13676358 | `FlutterExtension.kt:42` |
| Java/Kotlin-Target | 17 | `build.gradle.kts:37-38`, `:112` |
| Core Library Desugaring | an, `desugar_jdk_libs:2.1.4` | `build.gradle.kts:35`, `:122` |
| AGP | 9.0.1 | `android/settings.gradle.kts:16` |
| Kotlin | 2.3.20 | `android/settings.gradle.kts:17` |
| Gradle | 9.1.0 | `android/gradle/wrapper/gradle-wrapper.properties:5` |
| R8 / Minify | `isMinifyEnabled = true` | `build.gradle.kts:76` |
| Resource Shrinking | `isShrinkResources = true` | `build.gradle.kts:77` |
| ProGuard-Regeln | `android/app/proguard-rules.pro` (21 Zeilen) | Keep-Regeln für Flutter, GMS Ads, UMP, Billing, Firebase |

`android/app/proguard-rules.pro` enthält **keine** Keep-Regel für
`com.dexterous.**` (flutter_local_notifications). Geprüft im Pub-Cache: die
Version 18.0.1 liefert selbst keine Consumer-ProGuard-Datei
(`find ~/.pub-cache/hosted/pub.dev/flutter_local_notifications-18.0.1/android
-iname '*proguard*'` → leer) und nutzt Gson-Reflexion in
`ScheduledNotificationReceiver.java`, `models/NotificationDetails.java`,
`models/ScheduleMode.java`, `RuntimeTypeAdapterFactory.java`.

### Signing

`android/app/build.gradle.kts:22-33, 62-84`: Release-Signing wird aus dem
git-ignorierten `android/key.properties` gelesen. Fehlt die Datei, fällt der
Build auf die Debug-Keys zurück; ein Guard auf `bundleRelease`/`assembleRelease`
(`:88-104`) bricht dann ab, außer `-Pqubble.allowDebugSigning=true` ist gesetzt.
`android/key.properties.example` ist als Vorlage eingecheckt.

### Firebase-Gradle-Plugins

`android/app/build.gradle.kts:14-17`: `google-services` (4.5.0) und
`firebase-crashlytics` (3.0.6) werden nur angewendet, wenn
`android/app/google-services.json` existiert. Diese Datei ist git-ignoriert
(`.gitignore:60`).

---

## 5. Permissions im Manifest

`android/app/src/main/AndroidManifest.xml:2-5`:

| Permission | Zeile |
|---|---|
| `android.permission.INTERNET` | 2 |
| `android.permission.POST_NOTIFICATIONS` | 4 |
| `android.permission.RECEIVE_BOOT_COMPLETED` | 5 |

Weitere manifest-relevante Einträge:

- AdMob-App-ID `ca-app-pub-8596176219181991~9674890597` als `meta-data`
  (`:12-14`) — real, nicht Test.
- Activity: `screenOrientation="portrait"`, `launchMode="singleTop"`,
  `exported="true"` (`:15-24`).
- Zwei Receiver von `flutter_local_notifications`, beide `exported="false"`
  (`:39-53`).
- `<queries>` für `PROCESS_TEXT`, `https`-VIEW und `mailto`-SENDTO (`:60-77`).

Zusätzliche Permissions können durch Manifest-Merging aus den Plugin-AARs
hinzukommen (z. B. `AD_ID`, `ACCESS_NETWORK_STATE`, `WAKE_LOCK`,
`SCHEDULE_EXACT_ALARM`). Das ist in dieser Session **nicht** verifiziert — dafür
müsste das gemergte Manifest aus einem echten Android-Build gelesen werden, und
in dieser Umgebung ist kein Android-SDK installiert. Der CI-Job
`build-release.yaml` gibt die gemergten Permissions aus
(`.github/workflows/build-release.yaml`, Schritt „Verify the bundle",
`q /manifest/uses-permission/@android:name`).

---

## 6. Eingebundene SDKs und ihre Datenflüsse

| SDK | Aktiv auf | Fundstelle |
|---|---|---|
| Google Mobile Ads (AdMob) + UMP | nur nativ; Web nutzt `FakeAdService` | `lib/main.dart:81-82`, `lib/monetization/ads.dart:41` |
| Firebase Analytics | nur nativ, nur wenn `initFirebase()` gelingt | `lib/services/firebase_boot_native.dart:39` |
| Firebase Crashlytics | nur nativ, Android ja / iOS derzeit nein | `firebase_boot_native.dart:50-65`, `firebase_config.dart:18` |
| Firebase Auth (anonym, via REST) | nativ + Web, beim ersten Bestenlisten-Submit | `lib/services/leaderboard.dart:192-209` |
| Cloud Firestore (via REST) | nativ + Web | `lib/services/leaderboard.dart:101-166` |
| Google Play Billing (`in_app_purchase`) | nur nativ; Web-Release nutzt `LockedIap` | `lib/main.dart:86-88`, `lib/monetization/iap.dart:176` |
| Play In-App Review | nur nativ | `lib/main.dart:92-93` |

Firebase-Client-Konstanten stehen bewusst im Klartext im Repo
(`lib/services/firebase_config.dart:10-19`): `projectId=qubble`,
`apiKey=AIzaSy…fOfaY`, `messagingSenderId=108672510585`,
`androidAppId=1:108672510585:android:4ceeb3ce32d40a2d8302a8`,
`storageBucket=qubble.firebasestorage.app`. `iosAppId` ist der Platzhalter
`REPLACE_ME_FIREBASE_IOS_APP_ID`.

### Was die Bestenliste überträgt

`lib/services/leaderboard.dart`:
- Lesen (`fetchTop`, `:101-127`): POST auf
  `firestore.googleapis.com/v1/projects/qubble/databases/(default)/documents:runQuery`
  mit API-Key im Query-String. Kein Auth-Token.
- Schreiben (`submit`, `:133-166`): PATCH auf
  `…/documents/leaderboard/<uid>` mit `Authorization: Bearer <idToken>`,
  Body = `{name, score}`.
- Identität (`_ensureIdentity`, `:170-210`): erst `securetoken.googleapis.com`
  Refresh, sonst `identitytoolkit.googleapis.com/v1/accounts:signUp`
  (anonymer Nutzer). `uid` und `refreshToken` werden lokal persistiert
  (`lib/services/storage.dart:46-47`).

Serverseitige Regeln: `firebase/firestore.rules` — öffentliches Lesen,
Schreiben nur auf das eigene `uid`-Dokument, Name-Regex
`[A-Za-z0-9 _-]{2,14}`, Score `1..100000000`, kein Löschen, Score nie senkbar.

### Lokal persistierte Schlüssel

`lib/services/storage.dart:22-66` — 43 Schlüssel, darunter
`fbUid` (`:46`) und `fbRefreshToken` (`:47`) als einzige Identitätsdaten,
außerdem `playerName` (`:56`), `schemaVersion` (`:66`) und ein serialisierter
laufender Spielstand `activeRun.v1` (`:59`).

### Ad-Unit-IDs

`lib/monetization/ad_config.dart`:
- Test (Google-Sample): Android `…3940256099942544/5224354917` (`:22`),
  iOS `…/1712485313` (`:23`).
- Produktion Android: `ca-app-pub-8596176219181991/4303264559` (`:29`).
- Produktion iOS: `REPLACE_ME_REWARDED_IOS` (`:30`).
- `usesTestAds => kDebugMode || forceTestAds` (`:42`), `forceTestAds` kommt aus
  `--dart-define=QUBBLE_TEST_ADS` (`:37`).
- Ein `REPLACE_ME`-Produktions-Id fällt auf die Test-Unit zurück (`:63-67`).

Einziges Anzeigenformat ist Rewarded (`lib/monetization/ads.dart:1-8`). Im
Repo existiert kein Interstitial- oder Banner-Aufruf (`grep -rn
"InterstitialAd\|BannerAd\|AppOpenAd" lib/` → keine Treffer).

---

## 7. Store-Assets im Repo

```
store-assets/app-icon-512.png
store-assets/de/feature-graphic-1024x500.png
store-assets/de/screenshot-{1-clear,2-combo,3-daily,4-themes,5-puzzle,6-offline}.png
store-assets/en/  (dieselben 7 Dateien)
store-assets/store-listing.csv
store-assets/README.md
```

Fertige Listing-Texte (DE + EN: Titel, Kurz-, Vollbeschreibung, iOS-Keywords,
Promo-Text) liegen in `docs/STORE-LISTING.md`. Release-Notes für 1.1.0 in
`docs/release-notes/1.1.0-{de,en}.txt`.

Rechtstexte existieren doppelt:
- `docs/PRIVACY-POLICY.md` und `docs/IMPRESSUM.md` — **Vorlagen mit
  ungefüllten Platzhaltern** (`[DATUM]`, `[NAME/FIRMA, ANSCHRIFT, E-MAIL]`,
  `[VORNAME NACHNAME]`, `[E-MAIL-ADRESSE]`).
- `web/privacy.html` und `web/impressum.html` — **ausgefüllt**: Verantwortlich
  „Thinkube, Mähderweg 5, 88451 Dettingen, thinkube@outlook.de", Stand
  23. Juli 2026. Diese beiden werden in der App verlinkt
  (`lib/ui/screens/settings_screen.dart:39,42`, Ziel
  `https://f6vp76ctbb-stack.github.io/Qubble/privacy.html` bzw. `…/impressum.html`).

Die App selbst ist auf Englisch und Deutsch lokalisiert: je 281 Schlüssel in
`lib/l10n/app_en.arb` und `lib/l10n/app_de.arb`.

---

## 8. Testabdeckung

Ausgeführt in dieser Session:

```
$ flutter analyze
Analyzing Qubble...
No issues found! (ran in 12.6s)

$ flutter test
00:32 +441: All tests passed!
```

61 Testdateien, 441 Testfälle, 7 168 Zeilen. Verteilung:

| Verzeichnis | Dateien |
|---|---:|
| `test/game` | 25 |
| `test/ui` | 17 |
| `test/widget` | 9 |
| `test/services` | 5 |
| `test/monetization` | 3 |
| `test/l10n` | 2 |

Zeilenabdeckung (`flutter test --coverage`, ausgewertet aus `coverage/lcov.info`):

| Bereich | Abgedeckt / Zeilen | Quote |
|---|---:|---:|
| **gesamt** | 3 717 / 5 663 | **65,6 %** |
| `lib/game` | 782 / 827 | 94,6 % |
| `lib/services` | 325 / 431 | 75,4 % |
| `lib/ui` | 2 376 / 3 580 | 66,4 % |
| `lib/l10n` (generiert) | 193 / 649 | 29,7 % |
| `lib/monetization` | 33 / 166 | 19,9 % |

Dateien mit der niedrigsten Abdeckung:

| Datei | Quote |
|---|---:|
| `lib/services/notifications.dart` | 0,0 % (0/31) |
| `lib/ui/screens/stats_screen.dart` | 0,8 % (1/120) |
| `lib/ui/screens/leaderboard_screen.dart` | 1,1 % (1/87) |
| `lib/ui/screens/achievements_screen.dart` | 1,3 % (1/79) |
| `lib/monetization/ads.dart` | 1,4 % (1/73) |
| `lib/ui/screens/shop_screen.dart` | 1,9 % (1/54) |
| `lib/monetization/iap.dart` | 16,4 % (10/61) |
| `lib/services/audio.dart` | 8,5 % (4/47) |

Lint-Konfiguration: `analysis_options.yaml` — `package:flutter_lints/flutter.yaml`
plus vier zusätzliche Regeln (`prefer_single_quotes`, `prefer_final_locals`,
`unnecessary_parenthesis`, `directives_ordering`). Ausgeschlossen von der
Analyse: `build/`, `android/`, `ios/`, `web/`, `tool/`.

Zusätzliche Dev-Werkzeuge unter `scripts/audit/` (nicht Teil der Test-Suite):
`soak.dart` (22 841 B), `balance.dart` (12 846 B), `verify_findings.dart`
(8 154 B).

---

## 9. CI

Vier Workflows in `.github/workflows/`:

| Datei | Trigger | Inhalt |
|---|---|---|
| `ci.yaml` | jeder Push, jeder PR | `flutter pub get`, `flutter analyze`, `flutter test` auf Channel `stable` (nicht gepinnt) |
| `build-release.yaml` | nur manuell (`workflow_dispatch`) | signiertes AAB, Flutter **3.47.2 gepinnt**, Eingabe `test_ads` (Default `true`) |
| `deploy-web.yaml` | Push auf `main` (ohne `*.md`, `leaderboard.json`) | `flutter build web --release --base-href /Qubble/ --no-web-resources-cdn` → GitHub Pages |
| `feedback.yaml` | Issue geöffnet/gelabelt | hängt Feedback-Issues des Repo-Eigentümers an `FEEDBACK.md` an |

`build-release.yaml` verifiziert das gebaute Bundle mit `bundletool` 1.18.1:
`applicationId`, `versionCode`, `versionName`, `targetSdkVersion == 36`,
gemergte Permissions, Signatur (Abbruch bei `CN=Android Debug`), eingebettetes
R8-Mapping, und 16-KB-Page-Alignment aller `.so`-Dateien.

---

## 10. Git-Historie

```
$ git log --oneline | wc -l
151
$ git log --date=format:'%Y-%m' --pretty=format:'%ad' | sort | uniq -c
    105 2026-07
     46 2026-08
```

Erster Commit `19eed6c` am 2026-07-05. Das Projekt ist also knapp zwei Monate
alt. `git shortlog -sne` liefert in diesem Klon keine Ausgabe.

Die jüngsten Commits (`git log --oneline -12`) betreffen Store-Grafiken,
Lokalisierung, Playtest-Fixes und den Release-Build:

```
e07354f Merge pull request #47: per-language feature graphic
a2b385a Give the feature graphic an English version, and a generator
3067350 Merge pull request #46: rebuild the store screenshots around the clear
48e3443 Merge pull request #45: note that the production build needs real ad units
414cbb7 Merge pull request #44: English/German localization, rating prompt, store assets …
9faa18c Bump to build 4; the Play Console has already seen 3
```

---

## 11. Offene Markierungen und Platzhalter

`grep -rn "TODO\|FIXME\|HACK\|XXX\|REPLACE_ME"` über `lib/ test/ android/ ios/
web/ tool/ scripts/` — vollständige Trefferliste (ohne die ASCII-Board-Strings
in `test/game/game_over_rotation_test.dart`):

| Fundstelle | Inhalt |
|---|---|
| `android/app/build.gradle.kts:43` | `// TODO: Specify your own unique Application ID` — Rest-Kommentar aus dem Flutter-Template; die ID darunter ist gesetzt |
| `lib/services/firebase_config.dart:18` | `iosAppId = 'REPLACE_ME_FIREBASE_IOS_APP_ID'` |
| `lib/monetization/ad_config.dart:30` | `_prodRewardedIos = 'REPLACE_ME_REWARDED_IOS'` |
| `docs/PRIVACY-POLICY.md`, `docs/IMPRESSUM.md` | ungefüllte `[…]`-Platzhalter (siehe Abschnitt 7) |

Kein einziges `TODO`/`FIXME` in `lib/`.

## 12. Tote und ungenutzte Pfade

- `leaderboard.json` (Repo-Wurzel, 20 Byte) — Rest der früheren
  Repo-JSON-Bestenliste. Kein Dart-Code liest die Datei
  (`grep -rn "leaderboard.json" lib/` → keine Treffer); die Bestenliste läuft
  heute über Firestore.
- `lib/services/analytics.dart:31` `DebugAnalytics` — im Release aktiv, wann
  immer `initFirebase()` `null` liefert (`lib/main.dart:90`), d. h. auf Web und
  auf iOS. Dort werden Events nur per `debugPrint` ausgegeben.
- `IapProducts.rename` und `IapProducts.neonTheme`
  (`lib/monetization/iap.dart:26-27`) sind im Katalog, tauchen in
  `docs/STORE-LISTING.md` aber nicht als Produkte auf.
- `docs/PRIVACY-POLICY.md` / `docs/IMPRESSUM.md` werden von nichts referenziert;
  die App verlinkt die HTML-Fassungen.

---

## Quellen

Nur repo-interne Belege und in dieser Session ausgeführte Kommandos; externe
Quellen folgen in `audit/01-markt.md`.

| Kommando / Datei | Zweck |
|---|---|
| `flutter --version` | Toolchain-Stand |
| `flutter pub get` | Abhängigkeitsauflösung |
| `flutter analyze` | statische Analyse |
| `flutter test` | Testlauf |
| `flutter test --coverage` | Zeilenabdeckung |
| `git log`, `git shortlog` | Historie |
| `~/.flutter-sdk/packages/flutter_tools/gradle/src/main/kotlin/FlutterExtension.kt` | min/target/compileSdk-Auflösung |
| `~/.pub-cache/hosted/pub.dev/flutter_local_notifications-18.0.1/` | Consumer-ProGuard-Regeln, Gson-Nutzung |
