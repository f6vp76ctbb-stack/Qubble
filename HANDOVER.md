# HANDOVER — Projektstand Qubble (Übergabeblatt für neue Sessions)

> **Für Claude:** Dieses Dokument ist die vollständige Übergabe aus der
> bisherigen Entwicklungs-Session (Juli 2026). Zuerst lesen, dann
> `CLAUDE.md` + `MASTERPLAN.md`. Der Nutzer spricht Deutsch; Antworten auf
> Deutsch, Code/Kommentare/Commits auf Englisch.

---

## 0. Stand 02.09.2026 — zuerst lesen

**Der Text ab Abschnitt 1 ist die Übergabe vom Juli 2026 und wird nicht
umgeschrieben** — er erklärt, wie das Projekt entstanden ist. Was seitdem gilt,
steht hier. Wo beides sich widerspricht, gilt dieser Abschnitt.

| | Juli 2026 | heute |
|---|---|---|
| Tests | 245 | **762** |
| Arbeitsbranch | `claude/handover-continuation-ir2f40` | `claude/qubble-audit-compliance-32drdu` |
| Store-Status | im geschlossenen Test | **Konto war ~1 Monat gesperrt; Update eingereicht, Produktionszugriff beantragt** |

**Die Lage, die alles andere sticht:** Das Entwicklerkonto war wegen
Bot-Verdachts gesperrt, der Einspruch lief, Google verlangte für die
Wiederzulassung ein Update. **Ein zweiter Vorfall beendet das Projekt.**
Policy-Compliance steht deshalb über allem anderen — auch über Umsatz und
Feature-Arbeit.

**Was seit dem 31.08. passiert ist** (vollständig in `BACKLOG.md`, `BALANCE.md`
und `audit/00-bestand.md` … `audit/08-r8-risiko.md`):

- **Vollaudit in acht Phasen** mit 34 priorisierten Maßnahmen. Alle
  Compliance-Befunde (B-1 bis C-3) sind geschlossen, IARC am 02.09.
  eingereicht.
- **Produktions-Absturz behoben und bewiesen:** 142 Abstürze bei 23 Nutzern,
  alle eine Ursache — R8 Full Mode entfernte den Konstruktor von
  `WorkDatabase_Impl`, den Room reflektiv aufruft. WorkManager kommt
  transitiv mit dem Ads-SDK. Keep-Regeln in `android/app/proguard-rules.pro`,
  in Build #26 über `seeds.txt`/`usage.txt` verifiziert. **Nach jeder neuen
  Abhängigkeit `python3 tool/r8_risk_scan.py` laufen lassen.**
- **Zwei gemessene Balance-Korrekturen**, beide gegen die eigene Vermutung:
  die Bestenlisten-Metrik bleibt, wie sie ist (`BALANCE.md` Nachtrag 2 — die
  frühere Zahl „1:5" war falsch gerechnet), und das Combo-Fenster läuft jetzt
  in **Zügen statt Sekunden** (Nachtrag 3 — die Uhr war ein Faktor 2,6 allein
  durch Tippgeschwindigkeit). `GameSession` hat deshalb **keinen
  `clock`-Parameter mehr**.
- **Neue Regel im Repo:** `analysis_options.yaml` erzwingt jetzt `const`.

**Stand 17.09.2026 (vom Nutzer):** Die App läuft im **offenen Test** und wurde
auf dem Gerät des Nutzers gespielt; das Grobe funktioniert. Nächster Schritt ist
der Produktions-Release (inzwischen erledigt, siehe Stand 28.09.).

**Stand 23.09.2026 (Branch `claude/app-download-strategies-qi5eme`):**
Auftrag „Downloads stärken". Die App spricht jetzt **sechsundfünfzig Sprachen** (en,
de, af, ar, az, bg, bn, bs, ca, cs, da, el, es, et, fi, fil, fr, gu, he, hi, hr, hu, id, it, ja, kk, kn, ko, lt, lv, mk, ml, mr, ms, nb, ne, nl, pa, pl, pt, ro, sk, sl, sq, sr, sv, sw, ta, te, th, tr, uk, ur, uz, vi, zh — Chinesisch
vereinfacht `zh` und traditionell `zh_Hant`; Arabisch von rechts nach links);
Store-Texte, Screenshots und Feature-Grafik für die vierundfünfzig neuen liegen
bereit (Upload optional gesammelt über `tool/export_play_metadata.py`). Arabisch/Griechisch/Hebräisch/Hindi/Marathi/Nepali/Bengalisch/Japanisch/Koreanisch/Gujarati/Kannada/Malayalam/Punjabi/Tamil/Telugu/Thai/Urdu/Chinesisch nur nativ (nicht im Web-Build — Nunito hat diese Schriften nicht,
`lib/ui/locale.dart`). Geteilte Daily-Links (`?daily`) öffnen im Web direkt das
Daily. Außerdem: Bewertungskarte nach neuem Bestwert
(war Google so zugesagt, aber nie angeschlossen), Link-Vorschau fürs Teilen,
fünf Layout-Überläufe behoben. Alles mit Begründung, offenen Fragen an den
Nutzer und nächsten Ideen in **`docs/WACHSTUM.md`**. Neue Strings gehören
jetzt in **jede** `app_<code>.arb` (CLAUDE.md).

**Stand 28.09.2026 (vom Nutzer):** **1.2.0 (Code 9) ist in der Produktion,
100 %, alle Länder.** `app-ads.txt` ist von AdMob bestätigt, der Namenscheck
erledigt. Neu auf dem Branch: Erfolgs-Belohnungen (8 animierte Skins, nie
käuflich) und ein Rewarded-Block pro Bonus (`AdPlacement`); Version im Repo
**1.3.0+10**.

**Was noch offen ist:** alles, was ein Mensch in Play Console, AdMob oder beim
Finanzamt tun muss, steht in **`ANLEITUNG.md`** im Repo-Wurzelverzeichnis —
der **einzigen** Anleitung. Die früheren Einzel-Anleitungen (LAUNCH,
GO-LIVE-PRODUKTION, PLAY-CONSOLE-1.x, RELEASE*, SETUP-ACCOUNTS, PLAY-PRODUKTE)
sind am 28.09. zusammengeführt und gelöscht; der Nutzer hatte den Überblick
verloren. **Neue 👤-Schritte gehören in `ANLEITUNG.md`, nie in eine neue
Datei.** Am 28.09. hat der Nutzer die zehn In-App-Produkte, die
UMP-Einwilligungsmeldung und die sechs Rewarded-Blöcke (einer pro Bonus, IDs
in `ad_config.dart`) angelegt. Der AdMob-Block „Rewarded test"
(`…/4303264559`) ist der gemeinsame Block, über den 1.2.0 alle Boni lädt —
**nie löschen**.

**Stand 28.09.2026 abends:** 1.3.0 ist live, Store-Eintrag in allen Sprachen.
Branch trägt **1.4.0+11**: Namensfrage nach der ersten Runde und eindeutige
Namen (`names/{name}` in Firestore, MASTERPLAN Phase 5a). **Reihenfolge beim
Release:** erst `firebase/firestore.rules` veröffentlichen, dann mergen (der
Merge deployt auch das Web) und bauen — ohne die Regeln meldet jede
Namenswahl „konnte nicht geprüft werden“. **AdMob schlägt „Interstitial mit Prämie"
vor — abgelehnt:** Es wird laut AdMob ohne Zustimmung des Nutzers
ausgeliefert, also erzwungene Werbung (CLAUDE.md). Nur Format „Mit Prämie".

**Außerdem auf dem Branch (1.4.0, 28.09. spät):** Shop neu sortiert mit
eigenen Icons/Namen, Angebot des Tages (`lib/game/design_offer.dart`), 6 neue
Designs à 80 💎, 3 animierte Shop-Skins à 150 💎, Themes+Skins als ein
„Designs“-Bildschirm mit Live-Vorschau, Shop-Knopf unten im Menü,
Sparschwein leuchtet/blinkt. **29.09.:** Regeln für eindeutige Namen
veröffentlicht, PR #59 gemergt. Danach: Rätsel-Bestenliste nach Sternen
gesamt (`puzzleLeaderboard`, Regeln müssen **noch einmal** veröffentlicht
werden, vor dem Merge), und ein Fehler behoben, durch den eine Runde, die mit
einer Drehung endete, nie abgerechnet wurde. Quests (3 täglich / 5 wöchentlich / 5 monatlich,
Diamant-Bonus 5/20/60 für eine volle Runde) ersetzen die Missionen; ein
Bildschirm mit Reitern Quests | Erfolge, Erfolge mit Balken
(`lib/game/quests.dart`, MASTERPLAN Phase 5a). **Diamanten gibt es damit
erstmals durchs Spielen** — Entscheidung Nutzer 28.09., im MASTERPLAN
(Währungen) vermerkt.

**29.09. abends:** PR #60 gemergt; PR #61 (Namen mit Umlauten/Akzenten,
Tempo-Bonus als Balken mit Funken) wartet auf die Regeln (am 30.09.
erledigt). Danach, als eigener PR für **1.5.0**: Daily mit Tagesziel (1–3 Sterne,
`lib/game/daily_rewards.dart`), Serien-Truhen (Diamanten an Tag 3/7/14/30)
und Tages-Bestenliste (`dailyLeaderboard/{Tag}/entries/{uid}`, nur anlegen;
Platz per Zähl-Abfrage). Auch dafür müssen die Regeln vor dem Merge
veröffentlicht werden (am 02.10. erledigt).
**30.09.:** Im selben 1.5.0-PR: Teilen-Link zum Play-Eintrag (mit
UTM-`referrer`), Erinnerungen nennen fällige Serien-Truhen, Halloween-Event
im Oktober (`lib/game/seasonal.dart`: Kürbis-Theme, Gespenster-Skin, nur im
Oktober kaufbar). Dazu: Gratis-Bonus im Shop (3×/Tag Gold, 3×/Tag 💎, nicht im
Web), Zubehör für Blöcke (`lib/game/accessory.dart`) und Explosionen
(`lib/game/burst_style.dart`), beide in `lib/ui/state/cosmetic_controller.dart`.
**30.09. abends:** Regeln mit Umlaut-Namen veröffentlicht, PR #61 gemergt;
Bundle 1.4.0 (Code 11) aus `main` neu gebaut (CI-Lauf #32, ohne Test-Ads).
Das ist das Bundle für die Produktion, nicht der Build vom 29.09.
**02.10.:** Regeln mit Tages-Bestenliste live (geprüft), Store-Texte EN/DE
ersetzt, AdMob-Blöcke Gratis-Gold/-Diamanten angelegt und eingetragen.
Entscheidung Nutzer: **ein** Bundle — 1.4.0 entfällt, 1.5.0 (Code 12) bringt
alles; `docs/release-notes/1.5.0-*.txt` nennen darum auch die 1.4.0-Inhalte.
PR #62 gemergt. Halloween-Event als Play-„Promotional content" vorbereitet:
`store-assets/event-halloween/` (Bilder ohne Text, Texte in 60 Sprachen).
Später am 02.10.: 1.5.0 hochgeladen (Lauf #33), Event eingereicht (mit
Lottie-Animation, `tool/generate_event_lottie.py`). Entscheidungen Nutzer:
Teilen nach Bestwert (gebaut, `buildBestShareText`, `utm_medium=best_share`),
Neon 150 💎, Sparschwein bleibt, Münzpakete bleiben, Ads/Store-Tests später,
keine Tablet-Screenshots, **Play Games Services jetzt** (Projekt-ID
`108672510585`; wartet auf OAuth-Client und „Get resources"-XML).
App-Seite von Play Games ist gebaut: `lib/services/play_games.dart`
(`PlayGamesSync`, sendet nur, was für den Spieler noch nicht angekommen ist;
Stand in `Storage.playGames*`, übersteht ein Zurücksetzen), Android-SDK-Init
in `QubbleApplication.kt`, Projekt-ID in `res/values/games-ids.xml`. Solange
`kPlayGamesIds` leer ist, sendet die App nichts. Web/iOS: `NoopPlayGames`.
Kompiliert lokal nicht (dl.google.com gesperrt) — Android-Build nur über
`build-release.yaml` (Lauf #34 grün). Erfolge kommen per Import-Zip in die
Console (`tool/play_games_import.py`, Texte aus den ARBs, 59 Sprachen);
8 davon inkrementell (`kPlayGamesIncremental`, `setSteps`), ein Test hält
Zip und App gleich. `games-ids.xml` ist die „Get resources"-Datei der
Console, unverändert. Erster Import scheiterte („Sprache nicht unterstützt"):
die Sprachen fehlen im Play-Games-Projekt. Die 49-Sprachen-Liste, die der
Nutzer schickte, war die Gemini-„Übersetzung von App-Strings" (App-Bundle),
nicht Play Games — Empfehlung: ausschalten, Qubble hat keine übersetzbaren
Android-Strings. Offen: Liste/Codes aus „Manage your own translations" des
Spielprojekts; dann `python3 tool/play_games_import.py <codes>`.
AdMob-Bericht 02.10.: fast alles über den Ersatzblock „Rewarded test" (echt,
nicht Test); Grund: „Münzen verdoppeln" lud sein Video erst am Rundenende —
behoben, lädt jetzt beim Rundenstart. Geladene Videos laufen laut Google nach
etwa einer Stunde ab; die App verwirft sie jetzt nach 55 Minuten und lädt neu
(`GoogleAdService.maxAdAge`). Und: `prepare()` vor der Einwilligung beim
Start ging verloren (Sparschwein/Streak-Reparatur liefen die ganze Sitzung
über den Ersatz); jetzt merkt sich `_wanted` die Anfrage und `_loadAll()`
holt sie nach. **1.5.1 (Code 13)** ist der Fix-Release dafür (plus Teilen
nach Bestwert, Neon 150 💎); Play Games darin per `play_games.xml` aus, ein
Test koppelt den Schalter an `kPlayGamesIds`. Der Release-Workflow listet jetzt
die gemergten Provider/Services/Receiver im Log — und das zeigte in Lauf #35
`PlayGamesInitProvider`: das SDK startet sich per Provider selbst. Darum
entfernt das Manifest ihn (`tools:node="remove"`), solange Play Games aus ist;
Test und Workflow prüfen das. Beim Einschalten: Element löschen, Schalter auf
true, IDs eintragen, Datensicherheit ergänzen. Lauf #35 nicht hochladen. 66 Anfragen zu 20 Impressionen sind kein
Verlust: Anfragen sind vorgeladene Videos, gezahlt wird pro Impression. 20 % Klickrate bei 3 Zuschauern →
Nutzer soll Testgeräte eintragen (ANLEITUNG Schritt 5). Nächstes Release
(1.6.0) wartet auf die Play-Games-IDs und braucht eine ergänzte
Datensicherheit (ANLEITUNG 2.9).

---

## 1. Was das Projekt ist

**Qubble** — Block-Puzzle (Genre Block Blast!/Woodoku) für App Store + Play
Store, gebaut mit **Flutter** (eine Codebase für iOS/Android/Web).
Monetarisierung: AdMob (**nur Rewarded**, immer freiwillig) + IAP. Ziel:
profitabel bei minimalen Kosten.
App-Sprachen: **Englisch** (Quellsprache) + **Deutsch** (Übersetzung).

| Feld | Wert |
|---|---|
| App-Name | **Qubble** (vorher „GridPop" — umbenannt, da Name vergeben) |
| Publisher/Entwicklername | **Thinkube** |
| Bundle-/Application-ID | `com.thinkube.qubble` |
| Interner Dart-Paketname | `gridpop` (**absichtlich** nicht umbenannt — unsichtbar für Nutzer, Imports heißen `package:gridpop/...`) |
| Repo | `f6vp76ctbb-stack/Qubble` (öffentlich!, umbenannt von `mobile-game` am 2026-08-28) |
| Arbeitsbranch | `claude/handover-continuation-ir2f40` (vorher `claude/app-store-game-idea-jn0blw`) |
| Live-URL (PWA) | https://f6vp76ctbb-stack.github.io/Qubble/ |

**Namens-Check (👤 offen):** „Qubble"/„Thinkube" wirkten bei Recherche frei;
finale Store-/Markenprüfung liegt beim Nutzer. Fallback: „Qubble Blocks".

## 2. Workflow & Umgebung (so wird hier gearbeitet)

- **Flutter** liegt in Cloud-Sessions unter `$HOME/.flutter-sdk/bin` →
  `export PATH="$HOME/.flutter-sdk/bin:$PATH"`. Falls es fehlt:
  `scripts/setup.sh`.
- Vor jedem Commit: `flutter analyze` (0 issues) + `flutter test` (aktuell
  **245 Tests grün**). Web-Check: `flutter build web --release
  --no-web-resources-cdn`, optional Headless-Boot via `playwright-core`
  (Chromium unter `/opt/pw-browsers/chromium`, `--no-sandbox`).
- **Deploy-Pipeline:** Arbeit auf dem Arbeitsbranch → Commit → Push → PR
  nach `main` → **sofort selbst mergen** (vom Nutzer etabliert, PRs #3–#15
  liefen so). Push auf `main` triggert `deploy-web.yaml` → GitHub Pages
  (Source: GitHub Actions). PWA ist in ~3 Min. live.
- `deploy-web.yaml` hat `paths-ignore` für `leaderboard.json`, `FEEDBACK.md`,
  `**/*.md` (Action-Commits lösen keinen Redeploy aus) und **patcht den
  Service Worker** (SKIP_WAITING-Handler) für PWA-Auto-Update.
- `ci.yaml`: analyze + test bei jedem Push.
- **Sicherheitsregel (dauerhaft):** Vor jedem Commit gestagte Dateien prüfen —
  niemals Keystores (`*.jks`/`*.keystore`), `key.properties`,
  `google-services.json`, `GoogleService-Info.plist`, `.env` committen.
  Repo ist öffentlich!
- Test-Konventionen: Board-Zustände als ASCII-Strings; Fakes:
  `FakeAdService`, `SilentAudio`, `SilentMusic`, `Haptics(enabled:false)`,
  `NoopAnalytics`, `SharedPreferences.setMockInitialValues`.

## 3. Architektur (Kurzfassung; Details in CLAUDE.md)

- `lib/game/` = **pures Dart, keine Flutter-Imports**, voll unit-getestet:
  `board.dart` (8x8), `piece.dart` (+ `rotatedCw()`), `generator.dart`
  (seedbar), `scoring.dart` (zeitbasierte Combo), `game_session.dart`
  (Undo/Bombe/Rotation), `daily.dart`, `streak.dart`, `quests.dart` (ersetzt `missions.dart`),
  `leveling.dart` (XP + Belohnungsspur), `stats.dart`, `puzzle.dart`
  (Generator + budgetierter Solver), `piggy_bank.dart`, `starter_offer.dart`,
  `weekend_event.dart`, `block_skin.dart`, `achievements.dart`.
- `lib/ui/state/` = Riverpod-Controller. Zentral: `game_controller.dart`
  (großer `GameSnapshot` mit ~35 Feldern, `GameController`).
  Provider-Overrides in `main.dart`.
- `lib/ui/screens/` = home, game, puzzle(+levels), themes, skins, missions,
  stats, achievements, shop, settings, leaderboard, feedback, name_entry.
- `lib/monetization/` = `ads.dart` (NUR Rewarded — **keine Interstitials,
  keine Banner**; Juli-2026-Rework auf Nutzerwunsch), `iap.dart` (Produkt-IDs
  `qubble_supporter`, `qubble_coins_s/m/l`, `qubble_starter`).
  `ad_gate.dart` wurde ersatzlos gelöscht.
- `lib/services/` = storage (shared_preferences), audio (SFX + Musik),
  haptics, analytics (Debug), notifications, feedback, leaderboard, review
  (Play In-App-Review / SKStoreReviewController).
- `lib/l10n/` = `app_en.arb` (**Quellsprache**) + `app_de.arb` (Übersetzung),
  generiert per `flutter gen-l10n` zur Klasse `L10n`. Regel: **keine
  hartkodierten Nutzer-Texte** in Widgets. `lib/game/` bleibt textfrei und
  trägt IDs/Enums; die Übersetzung passiert in `lib/ui/l10n_maps.dart`.
  Fallback-Regeln in `lib/ui/locale.dart` (Englisch für alles Unübersetzte).

## 4. Spiel-Features (alle implementiert & getestet)

- **Endlos-Modus** + **Daily Challenge** (Datum-Seed, Streak + Streak-Reparatur;
  seit 1.5.0 Tagesziel mit Sternen, Serien-Truhen, Tages-Bestenliste)
- **Zeitbasierte Combo**: bricht NICHT mehr durch Nicht-Clear-Züge, sondern
  läuft **10 s** nach dem letzten Clear ab; UI-Countdown-Balken unter dem
  Combo-Badge. Fieber-Meter unverändert.
- **Rotation**: Tipp auf Tray-Teil dreht 90°. Frei bis Spielerlevel ≤ 2
  (nur Endlos; Daily immer mit Ladungen). Sonst Ladungen: Start 2, Max 3,
  +1 pro Clear-Zug. Undo stellt Ladungen wieder her.
- **Booster**: Undo 50 / Tausch 75 / Bombe 150 Münzen (zentral in
  `BoosterCosts`). Bombe = 3x3, mit Partikeln/Sound; Buttons ausgegraut ohne
  Guthaben.
- **Währungen (Juli 2026, sauber getrennt):** **Gold** = Spiel (Booster,
  Revive, Gold-Skins 1.200–2.200). **Diamanten** 💎 = Premium-Kosmetik (edle
  Skins, Relief 30/Glow 50); Bezug über Gold→Diamant-Tausch (100:1,
  `economy.dart`) — später Diamant-IAP. `storage.diamonds`,
  `trySpendDiamonds`/`exchangeGoldForDiamonds`; Skin trägt `SkinCurrency`.
  Diamant-Chip auf Home + Tausch-Karte im Skins-Screen. `DiamondIcon`/
  `DiamondAmount` in `app_icons.dart`.
- **Live-Münzen beim Spielen**: `kCoinsPerLine = 3` pro geräumter Reihe,
  + Combo-Bonus (+combo), + `kAllClearCoins = 25`. Sichtbar als
  „+N 🪙"-Popup überm Board (`coin_popup.dart`) + Live-Münzchip im Header.
  Zählt ins Runden-Ergebnis (`coinsEarnedThisRun`).
- **Level/XP** (`LevelSystem`): XP = score/100 (+50 Daily). Belohnungsspur
  (Cosmetics gratis durch Spielen): L3 Neon, L5 Verlauf, L8 Ocean,
  L12 Glanz, L16 Wood, L20 Kontur, L24 Sunset, L28 Forest, L32 Relief,
  L36 Glow, L40 Streifen. Level-Up: animierte Karte (Game-Over) + Chime
  (`levelup.wav`) + Haptik. Home zeigt nächstes Belohnungsziel.
- **7 Themes** (classic, neon, ocean, wood, sunset, forest + Aurora exklusiv
  im Unterstützer-Paket) / **8 Skins** (solid, gradient, glossy, outline,
  bevel, glow, stripe + Kristall exklusiv — Rendering in `cell_style.dart`).
- **Erfolge**: 17 Stück, lokal, `achievements.dart` (Metrik ≥ Schwelle);
  Screen über Statistik → „Erfolge"; frisch freigeschaltete am Game-Over.
- **Rätsel-Modus**: Level konstruktiv generiert (Bänder + ausgestanzte
  Löcher, ab Level 5 zwei Löcher/Band, mehr Teile mit steigendem Level).
  `minMoves == pieces.length` per Konstruktion; **Lösung wird mitgeliefert**
  (`Puzzle.solution`) und per billigem Replay verifiziert. Solver hat
  **Node-Budget** (hängt nie); Fehlschlag-Erkennung wertet Budget-Überlauf
  NICHT als „failed". Sterne: 3=optimal, 2=+2 Züge, 1=gelöst.
- **Sparschwein** (füllt sich pro Reihe; **voll = gratis ausschütten**,
  vorzeitig optional per Bonus-Video — seit Juli 2026 KEIN IAP mehr),
  **Starter-Paket** (48h-Angebot nach 5. Runde), **Wochenend-Event**
  (doppelte Münzen), **Missionen** (Fortschritt persistiert).
- **Unterstützer-Paket** (`qubble_supporter`, 4,99 €): exklusives
  Aurora-Theme + Kristall-Skin (`supporterOnly`, nie für Münzen) + 1.500
  Münzen + ❤️ neben dem Spielernamen. Ersetzt das frühere „Werbefrei"
  (überflüssig, da keine erzwungene Werbung mehr existiert).
- **Musik**: 42s-Lo-Fi-Loop, ruhig/leise (Volume 0.24), generiert via
  `scripts/gen_music.py` (pures Python, CC0/Eigenwerk — bei Änderungen neu
  generieren). SFX ebenfalls selbst synthetisiert (`assets/CREDITS.md`).
  Musik-Schalter in Einstellungen; Start nur nach User-Geste (Autoplay).
- **Typografie**: app-weit **Nunito** (runde, freundliche OFL-Schrift,
  `assets/fonts/Nunito.ttf`, variable Schrift = alle Gewichte in einer Datei;
  in `pubspec.yaml` registriert, `fontFamily: kAppFontFamily` in
  `buildGridTheme`). **Achtung:** `FilledButton.styleFrom(textStyle: ...)`
  *ersetzt* den Theme-Stil statt ihn zu ergänzen — dort muss `fontFamily:
  kAppFontFamily` mit angegeben werden, sonst fällt der Button auf die
  Systemschrift zurück. Lizenz in `assets/CREDITS.md`.
- **Menü-Partikel**: dezente Punkte im Home-Hintergrund
  (`menu_particles.dart`), themenfarben.
- **Onboarding**: Pflicht-**Namenseingabe** beim ersten Start
  (`NameEntryScreen` → `storage.playerName`, geräteweit, 2–14 Zeichen).
  Name ist danach **fix** — kein Gratis-Ändern (Nutzer-Entscheidung Juli
  2026). Umbenennen nur per Kauf: IAP `qubble_rename` (consumable, ~1,49 €)
  schreibt ein „Rename-Guthaben" gut (`storage.renameCredits`); Antippen des
  Namens öffnet den Kauf- bzw. mit Guthaben den Umbenennen-Dialog
  (`renameWithCredit`). 3 Coach-Hints in der ersten Runde.
- **Game-Over**: „Nochmal spielen" = Hauptaktion (immer gratis, ohne Werbung);
  Revive = kleiner Link für **200 Münzen** (1×/Runde) — NIE per Video.
  **Monetarisierungs-Grundsatz (Nutzer-Entscheidung Juli 2026): keine
  erzwungene Werbung; Videos nur als freiwilliger Bonus** (Münzen verdoppeln,
  Lucky Block, Streak-Reparatur, Sparschwein, Rätsel-Extra-Zug).
  Home-Button im Spiel-Header; laufende Runde → Home zeigt „Weiterspielen".

## 5. GitHub-Pipelines (kein Backend! Secrets-frei)

- **Feedback**: Einstellungen → „Feedback geben" → vorbefülltes GitHub-Issue
  (Label `feedback`) → `.github/workflows/feedback.yaml` hängt es an
  **`FEEDBACK.md`** an (nur Issues vom Repo-Owner; Text nur als Daten).
  `FEEDBACK.md` = Ideensammlung für spätere Umsetzung.
- **Bestenliste (seit 22.07.2026: Firestore, kontofrei!):**
  `LeaderboardService` spricht Firestore **per REST** (pure Dart + http,
  kein SDK — läuft identisch auf Native und Web-PWA, voll testbar):
  Lesen via runQuery (öffentlich), Eintragen unter **stiller anonymer
  Firebase-Identität** (Identity-Toolkit signUp beim ersten Submit,
  Refresh-Token in storage; Spieler sehen NIE einen Login). Server-Gate:
  `firebase/firestore.rules` (eigenes Dokument je uid, Name/Score validiert,
  Score nie senkbar). Firebase-Projekt „qubble", Konstanten in
  `lib/services/firebase_config.dart` (bewusst committet — keine Secrets).
  Analytics + Crashlytics: `firebase_boot.dart` (Conditional Import; Web =
  Stub ohne Firebase-SDK). Die alte GitHub-Issue-Pipeline ist entfernt
  (`leaderboard.yaml` gelöscht; `leaderboard.json` nur noch Archiv).
- **Admin-Modus (Test)**: In Einstellungen 7× auf die Fußzeile
  („Qubble • Offline Block Puzzle") tippen → Münzen +1.000/+10.000/auf 0.
  **Nur in Debug-Builds** (doppelt verriegelt: `kDebugMode` in der UI +
  `kReleaseMode`-No-op im Controller) — Spieler dürfen NIE Cheats bekommen.
  Ebenso: öffentlicher Web-Build nutzt `LockedIap` (keine Gratis-Käufe).
- **Android-Release (.aab)**: `.github/workflows/build-release.yaml`
  (manuell, „Run workflow"). Signing-Secrets als Repo-Secrets, .aab liegt in
  den Run-Artifacts. **Gradle-9-Falle:** Das Flutter-3.44-Android-Template
  pinnt Gradle 9.1 + AGP 9.0.1; Plugins müssen dazu passen. `google_mobile_ads`
  daher auf **≥ 9.0.0** (5.x/6.x scheitern mit „unknown property 'all'" beim
  Konfigurieren von `:google_mobile_ads`; Gradle-9-Support kam mit Plugin 7.0.0).
  Zusätzlich braucht `flutter_local_notifications` **Core Library Desugaring**:
  `isCoreLibraryDesugaringEnabled = true` + `coreLibraryDesugaring(...desugar_jdk_libs:2.1.4)`
  in `android/app/build.gradle.kts` (sonst bricht `checkReleaseAarMetadata` ab).
  Und `flutter_timezone` auf **4.x** (nicht 3.x: mischt Java 11 + Kotlin 1.8 →
  AGP 9 bricht `compileReleaseKotlin` ab). Nicht auf 5.x gehen, solange
  `getLocalTimezone()` als `String` genutzt wird (5.0.0 liefert `TimezoneInfo`).

## 6. Web/PWA-Besonderheiten (wichtig!)

- **`kIsWeb` in `main.dart`**: Web nutzt `FakeAdService`, `FakeIap`, keine
  LocalNotifications (die echten Plugins werfen im Browser → hatte
  „Nochmal spielen" gebrochen). `newGameWithInterstitial` fängt Ad-Fehler ab.
  Native Builds nutzen die echten Services unverändert.
- **PWA-Auto-Update**: `web/index.html` pollt den Service Worker, sendet
  `SKIP_WAITING`, lädt bei `controllerchange` neu (+ Update-Check bei
  `visibilitychange`). Der Deploy-Workflow hängt den SKIP_WAITING-Handler an
  `flutter_service_worker.js` an. Nutzer wurde instruiert, das Home-Icon
  EINMAL neu anzulegen; seitdem kommen Updates automatisch.
- **Weißer Rand oben (iPhone)** gefixt: `theme-color` #12122A, dunkler
  body-Background, `viewport-fit=cover`, Status-Bar `black-translucent`.
- **Seitenübergänge**: eigener Fade (`_FadePageTransitionsBuilder` in
  `theme.dart`) — Material-„Zoom" ruckelte auf Web.
- **Drag&Drop (kritisches Wissen!)**: `DragTargetDetails.offset` ist die
  **linke obere Ecke des Feedback-Widgets**, nicht der Finger.
  `boardOriginForDrag()` in `board_view.dart` mappt direkt (Vorschau =
  Platzierung). Das `DragTarget` umfasst **Board + Booster + Tray**, weil das
  Teil `kFingerLiftCells = 1.2` Zellen über dem Finger schwebt (sonst wären
  untere Reihen unerreichbar). Gleiche Logik im Puzzle-Screen.
  Preview-State via `dragPreviewProvider`.
- **Partikel-Deckel**: Clear-Bursts max ~220 Partikel (Web-Canvas-Jank).
- **JS-Zahlen**: keine 64-Bit-Literale! Bitboards als `Mask(lo,hi)` mit
  2×32 Bit (`puzzle.dart`) — dart2js-kompatibel.

## 7. Nutzer-Feedback-Historie (alles umgesetzt)

Nutzer + ein Freund haben auf dem iPhone getestet. Behoben/gebaut u. a.:
Drag-Versatz & untere Reihen (Doppel-Offset-Bug), Bombe ohne Feedback,
Zurück-Button, Combo-Timer, mehr Partikel (+ Deckel nach Lag-Report),
Rotation, Musik (erst eintönig → neuer ruhigerer Loop), Textumbruch der
Menü-Buttons, Home-Hierarchie (BESTWERT + Play prominent, Logo/Profil
dezent), Statistik als visuelles Dashboard, Rätsel zu leicht → schwerer,
„Video-Zwang"-Eindruck entfernt, weißer iPhone-Rand, Menü-Partikel,
Live-Münzen, „Nochmal spielen"-Bug (Web). **Profile-Feature wurde gebaut und
auf Nutzerwunsch wieder ENTFERNT** (ein Name pro Gerät statt Multi-Profil).

## 8. Offene Punkte

**Entscheidungen des Nutzers:**
- **Firebase: ENTSCHIEDEN (22.07.2026)** — Analytics + Crashlytics +
  kontofreie Firestore-Bestenliste mit anonymer Auth (nie ein sichtbarer
  Login, kein E-Mail/Passwort). Umsetzung = Phase 7 Block 7 (D.7), wartet
  nur noch auf die `google-services.json` aus der Konsole (Play-Konto und
  AdMob hat der Nutzer bereits angelegt; Firebase-Projekt in Arbeit).
- Finaler **Marken-/Store-Namenscheck** Qubble/Thinkube (👤, offen)

**👤-Aufgaben (nur Nutzer kann sie; Anleitungen in `docs/`):**
- Apple-/Google-Developer-Konten, AdMob-Konto + echte Ad-Unit-IDs
  (`ad_config.dart`, Manifest, Info.plist), IAP-Produkte anlegen
  (`qubble_remove_ads`, `qubble_coins_s/m/l`, `qubble_piggy`,
  `qubble_starter`), Firebase-Config-Dateien, Datenschutz/Impressum hosten
  (Vorlagen in `docs/`), Screenshots, Signing-Key, Store-Uploads.
  iOS-Build braucht einen Mac.

**Nächste Code-Schritte (BEAUFTRAGT, Juli 2026):** `MASTERPLAN.md`
**Phase 7 — Release-Politur** abarbeiten (Blöcke 1–6 strikt der Reihe nach,
ein Block pro PR-Zyklus; verbindliche Specs in Anhang D). Vom Nutzer
ausdrücklich gewünscht: „komplett überprüfen, was wir grundlegend verbessern
können, damit das Spiel zum Release richtig gut wird."
- ~~Shop-Vorschau verbessern (Mini-Board-Preview für Themes/Skins)~~ ✅ PR #17
- `FEEDBACK.md` regelmäßig prüfen (Feedback-Issues des Nutzers)

## 9. Wichtige Dateien-Landkarte

- `MASTERPLAN.md` — Phasenplan (code-seitig KOMPLETT; nur 👤-Punkte offen)
  + verbindliche Specs (Anhang A/B/C)
- `CLAUDE.md` — Arbeitsregeln (Test-first für `lib/game/`, analyze+test grün,
  deutsche Nutzertexte, CC0-Assets, Ad-Regeln)
- `ANLEITUNG.md` — **die einzige Anleitung** für alle 👤-Schritte (Stand
  28.09.2026). Erste Anlaufstelle für „was ist noch zu tun".
- `docs/` — Nachschlagewerke, keine Anleitungen: STORE-LISTING (ASO-Texte
  DE/EN), DATA-SAFETY, BUILD-CI, NOTIFICATIONS, LOCAL-TESTING,
  DEV-ENVIRONMENT, WACHSTUM; `docs/archiv/PRODUCTION-ACCESS.md` (was Google
  im Antrag gesagt wurde)
- `FEEDBACK.md` / `leaderboard.json` — von Actions gepflegt
- `.github/workflows/` — ci, deploy-web, feedback, leaderboard
- `scripts/` — setup.sh, gen_music.py
- `assets/CREDITS.md` — alle Assets Eigenwerk/CC0 (Pflicht bei neuen Assets)

## 10. Zahlen zum Stand

- **245 Tests grün**, `flutter analyze` sauber (Stand: letzter Merge PR #17)
- Merged PRs dieser Session: #3 Rename+Deploy, #4 Playtest-Fixes/Features,
  #5 Admin+Partikel-Cap, #6 (Profile, später entfernt), #7 Belohnungsspur,
  #8 Feedback+Fade, #9 Name+Leaderboard+PWA-Update, #10 Freund-Feedback,
  #11 Menü-Partikel, #12 Level-Up-Sound+2 Themes, #13 Erfolge,
  #14 3 Skins, #15 Web-Restart+Live-Münzen+Musik
- Folge-Session (Juli 2026): #17 Mini-Board-Previews für Theme-/Skin-Shop
  (gemeinsames `MiniBoardPreview`-Widget, `test/widget/store_preview_test.dart`);
  Monetarisierungs-Rework „fair & werbearm" (Interstitials raus, Revive per
  Münzen, Sparschwein gratis, Unterstützer-Paket statt Werbefrei; Play-Konto +
  AdMob vom Nutzer angelegt, Firebase noch offen; geschlossener Test mit
  12 Testern/14 Tagen nötig — inzwischen erledigt)
- Flutter stable 3.44.x / Dart 3.12.x; Riverpod 2.x (immutable Snapshots)
