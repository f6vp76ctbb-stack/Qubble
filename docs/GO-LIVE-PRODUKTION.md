# Go-Live: vom offenen Test in die Produktion — jeder Punkt einzeln

Stand: 17.09.2026 · App **Qubble** · `com.thinkube.qubble` · Repo-Version
**`1.2.0+9`**

**Ausgangslage (von dir, 17.09.):** Die App läuft im **offenen Test**, du hast
sie auf deinem Handy gespielt, das Grobe funktioniert. Jetzt soll sie in die
**Produktion**.

Diese Datei ist ab jetzt die eine Anleitung für diesen Schritt. Die anderen
Dokumente bleiben als Detail-Nachschlagewerk gültig und werden hier verlinkt —
was dort steht, wird hier **nicht wiederholt**. Zwei Tabellen, die sich
widersprechen, sind schlimmer als eine; genau daran ist diese Doku schon
einmal gescheitert (siehe `docs/LAUNCH.md`, Abschnitt A6).

> **Zu Menüpfaden:** Ich sehe die Play Console nicht. Frühere Fassungen dieser
> Anleitungen enthielten Klickwege, die es so nicht gibt — ich hatte sie aus
> dem Gedächtnis geschrieben. Hier stehen deshalb nur **Werte, Antworten und
> Suchbegriffe**. Verlangt ein Formular ein Feld, das hier fehlt: **schick mir
> den Feldnamen oder den Screenshot, dann bekommst du den Wert dazu.**

---

## 0 · Der Stand, geklärt am 17.09.

| # | Frage | Antwort | Folge |
|---|---|---|---|
| **0.1** | versionCode im Test | **8** — verbraucht | Repo steht jetzt auf **`1.2.0+9`** (`pubspec.yaml`, `lib/app_info.dart`) |
| **0.2** | Ad-Modus des hochgeladenen Builds | **Produktions-Einheiten** — nachgeprüft, nicht angenommen | Punkt 1.1 ist bereits erfüllt |
| **0.3** | Produktionszugriff | **erteilt** | `docs/PRODUCTION-ACCESS.md` wird nicht mehr gebraucht |
| **0.4** | App-Inhalte | **alles erledigt** | Abschnitt 2 dient nur noch der Gegenprobe |

**Zu 0.2 — woher das belegt ist:** Nur zwei Läufe des Workflows konnten
versionCode 8 gebaut haben, Lauf **#27** (05.09., `ae5d391`) und **#28**
(06.09., `9403407`). Beide haben genau ein Bundle-Artefakt hinterlassen, und
beide heißen `qubble-release-aab-PRODUCTION-ads`. Ein `…-TEST-ads`-Artefakt
existiert in keinem der beiden Läufe. Der Build im offenen Test trägt also
echte AdMob-Einheiten — die Sorge aus Punkt 1.1 trifft hier nicht zu.

**Und ein zweiter Befund:** Zwischen dem gebauten Stand (`9403407`) und dem
heutigen `main` hat sich an **`lib/`, `android/`, `ios/`, `pubspec.lock` und
`assets/` nichts geändert** — die Commits seitdem betreffen `CLAUDE.md`,
`docs/`, `store-assets/product-icons/` und `tool/`. Der App-Code des neuen
Builds ist damit identisch mit dem, den du auf dem Handy gespielt hast; es
ändert sich nur der versionCode.

> **Alternative, die du auch hättest:** den Build aus dem Testtrack direkt in
> die Produktion hochstufen. Das wäre exakt das Bundle, das du getestet hast,
> ohne neuen Upload. Du hast einen frischen Build bestellt — der ist
> gleichwertig, weil der Code derselbe ist. Beide Wege sind richtig.

---

## 1 · Der Build — hier kostet ein Fehler am meisten

### 1.1 Ad-Modus: der Store-Build muss echte AdMob-Einheiten haben

Der Workflow **„Build Android Release (.aab)"** hat den Schalter `test_ads`,
und der steht **standardmäßig auf AN** (`.github/workflows/build-release.yaml`,
`default: true`). AN heißt: Googles Testeinheiten, kein Umsatz.

- Für die Produktion: **`test_ads` auf OFF**.
- Das fertige Artefakt heißt dann `qubble-release-aab-PRODUCTION-ads`.
  Das andere (`…-TEST-ads`) gehört **nie** in die Produktion.
- Umgekehrt gilt weiter: jeder interne/geschlossene Test mit `test_ads` **AN** —
  echte Einheiten, die nur ein paar bekannte Geräte anfordern, wertet AdMob als
  ungültigen Traffic (`lib/monetization/ad_config.dart`, Kopfkommentar).

**Für diesen Release geprüft (17.09.):** Der Build im offenen Test trägt
bereits Produktions-Einheiten (Beleg in Abschnitt 0). Der neue Build wird
genauso gebaut — `test_ads` **OFF**. Wäre es andersherum gewesen, hätte ein
Hochstufen des Testbuilds eine App ohne Werbeumsatz ergeben, und sichtbar
geworden wäre das erst daran, dass nichts hereinkommt.

### 1.2 Versionsnummer

Das Repo steht auf **`1.2.0+9`** (angehoben am 17.09., weil Code 8 im offenen
Test verbraucht ist). Der Teil nach `+` muss bei **jedem** Upload steigen —
verbraucht ist er durch den Upload selbst, nicht erst durch das
Veröffentlichen. Zwei Stellen gehören zusammen und werden von
`test/app_info_test.dart` aneinander gebunden: `pubspec.yaml` und
`lib/app_info.dart` (die Versionszeile in den Einstellungen).

### 1.3 Der Build für diesen Release steht bereit

**Lauf #29 vom 17.09.**, auf `main` (`0cd0eef`), gebaut mit `test_ads` **OFF**:
<https://github.com/f6vp76ctbb-stack/Qubble/actions/runs/35193275945>

Unten auf der Seite des Laufs: **`qubble-release-aab-PRODUCTION-ads`** →
herunterladen, entpacken → `app-release.aab`.

> **Auf die Lauf-Nummer achten.** Es liegen mehrere Artefakte mit demselben
> Namen in der Historie, und die tragen versionCode **8** — den die Console
> bereits kennt und ablehnt. Das richtige ist das aus **Lauf #29**.

Der Schritt „Verify the bundle" hat den Inhalt gegengeprüft, nicht nur den
Build-Erfolg:

| geprüft | Ergebnis |
|---|---|
| `applicationId` | `com.thinkube.qubble` |
| `versionCode` | **9** |
| `versionName` | **1.2.0** |
| `targetSdkVersion` | 36 |
| R8-Keep-Regeln | Konstruktoren von `WorkDatabase_Impl` und `WorkManagerInitializer` erhalten — das ist genau der Absturz aus 1.1.0 (142 Abstürze, 23 Nutzer) |
| Signatur | vorhanden, nicht der Debug-Schlüssel (der Build bricht sonst ab) |
| R8-Mapping | im Bundle enthalten (der Build bricht sonst ab) |

**`mapping.txt` musst du nicht hochladen** — AGP legt die R8-Zuordnung in den
AAB selbst, der Build bricht ab, wenn sie fehlt.

---

## 2 · App-Inhalte — die Formulare, Antwort für Antwort

Alles hier ist aus dem Code bzw. den bestehenden Dokumenten belegt, nicht
geschätzt.

| Formular | Antwort |
|---|---|
| **Datenschutzerklärung** (URL) | `https://f6vp76ctbb-stack.github.io/Qubble/privacy.html` (Quelle: `web/privacy.html`, live über Pages) |
| **App-Zugriff / Anmeldedaten** | „Alle Funktionen sind ohne besonderen Zugriff verfügbar" — Qubble hat keinen Login und keine gesperrten Bereiche |
| **Anzeigen** | **Ja, die App enthält Werbung.** Rewarded-Videos zählen als Werbung |
| **Inhaltseinstufung (IARC)** | Kategorie *Spiel*; keine Gewalt, kein Sex, keine Schimpfwörter, kein Glücksspiel, keine Drogen. **Ja** bei: enthält Werbung, digitale Käufe, Nutzer interagieren (die Bestenliste zeigt selbstgewählte Namen öffentlich). Erwartetes Ergebnis: PEGI 3 / USK 0 mit den Hinweisen „In-App-Käufe" und „Nutzer interagieren". **Am 02.09. bereits eingereicht** — nur prüfen, ob die Console sie noch als gültig führt |
| **Zielgruppe** | Altersgruppen **13–15, 16–17, 18+**. Keine Gruppe unter 13, „richtet sich an Kinder?" → **Nein**. Begründung: Werbung + Käufe; eine Kinder-Kennzeichnung zöge die strengen Kinder-/COPPA-Regeln nach sich |
| **Datensicherheit (Data Safety)** | **Nicht aus dem Kopf ausfüllen.** Die sieben Zeilen mit Fundstelle je Zeile stehen in **`docs/DATA-SAFETY.md`** — inklusive der beiden Zeilen, die typischerweise vergessen werden (Bestenlisten-Name, anonyme Nutzer-ID) und der Kaufhistorie. „Es werden keine Daten erhoben" wäre nachweislich falsch |
| ↳ Verschlüsselung bei Übertragung | **Ja** (alles über HTTPS) |
| ↳ Löschung anfragbar | **Ja.** In der App: Einstellungen → „Bestenlisten-Eintrag löschen". Außerhalb: `thinkube@outlook.de`, genannt in `web/privacy.html` |
| ↳ Unabhängige Sicherheitsprüfung | Nein |
| **Werbe-ID** | **Ja** — `play-services-ads` bringt die `AD_ID`-Permission mit; der Build-Workflow gibt die gemergten Permissions im Schritt „Verify the bundle" aus, dort gegenprüfbar |
| **Behörden-App / Finanzfunktionen / Gesundheit** | Jeweils **Nein / trifft nicht zu** |

**Wenn du die Data-Safety-Angaben prüfen willst, ohne sie neu zu tippen:** Die
Console kann sie als **CSV exportieren und importieren**. Genau so wurde am
01.09. festgestellt, dass die Doku falsch lag und das Formular recht hatte.
Erst exportieren, dann vergleichen.

---

## 3 · Store-Eintrag

**Englisch (USA)** als Standard, **Deutsch** als zweite. Ohne englischen
Eintrag sieht der größte Teil des Play Store nur deutschen Text. Seit 23.09.
liegen 24 weitere Einträge bereit (Texte, Bilder, „Was ist neu") — Übersicht in
`docs/STORE-LISTING.md` („Weitere Sprachen"), gesammelt als Upload-Paket über
`tool/export_play_metadata.py`. Sie setzen den **neuen Build** voraus: erst mit
ihm spricht die App diese Sprachen.

| Feld | Wert |
|---|---|
| Kategorie | Spiele → **Puzzle** |
| Kontakt-E-Mail | `thinkube@outlook.de` (dieselbe Adresse, die in der Datenschutzerklärung steht) |
| Website | `https://f6vp76ctbb-stack.github.io` — nicht optional, solange AdMob die App verifizieren soll (Abschnitt 7a) |
| Titel (30 Z.) | DE `Qubble – Block Puzzle` · EN `Qubble: Block Puzzle` |
| Kurzbeschreibung (80 Z.) | `store-assets/listing/en-US/short_description.txt` bzw. `de-DE/` — nur kopieren |
| Vollbeschreibung (4000 Z.) | `store-assets/listing/en-US/full_description.txt` bzw. `de-DE/` — **nicht** die Fassung in `docs/STORE-LISTING.md`, die ist für den Editor auf 80 Zeichen umbrochen und zeigt auf Play halbe Zeilen. Inhaltlich identisch; **nur diese Fassung verwenden:** Drei frühere Aussagen („kein Server", „kein Zeitdruck", „drei Sterne für die Mindestzahl an Zügen") halten dem Code nicht stand und fallen unter Googles Metadaten-Policy |
| App-Symbol 512×512 | `store-assets/app-icon-512.png` |
| Feature-Grafik 1024×500 | pro Sprache: `store-assets/en/feature-graphic-1024x500.png`, `store-assets/de/…` — sie trägt Text, ist also nicht sprachneutral |
| Screenshots | je **6** aus `store-assets/en/` und `store-assets/de/`. Am 03.09. neu erzeugt, weil sich das HUD geändert hat (Tempo-Anzeige, Booster-Leiste). Alte Bilder zeigen eine App, die es nicht mehr gibt — Metadaten-Genauigkeit war ein Audit-Befund |
| Enthält Werbung | **Ja** (muss zur Antwort in Abschnitt 2 passen) |
| App kostenlos / kostenpflichtig | **Kostenlos** (Monetarisierung über Rewarded Ads + IAP) |

Zum Gegenprüfen des Ist-Zustands gibt es auch hier einen CSV-Export:
`store-assets/store-listing.csv`.

---

## 4 · In-App-Produkte — zehn Stück

**Stand 06.09.: Die Liste war leer.** Solange die Produkte fehlen, ist der Shop
in der Produktion wirkungslos: Die App fragt den Store nach den IDs, bekommt
nichts zurück und zeigt die Angebote gar nicht erst an — ohne jede Fehlermeldung.

Feld-für-Feld-Anleitung mit Namen, Beschreibungen, Preisen (EUR + USD),
Produkt-Icons und den Antworten für Kaufoptions-ID, Steuerkategorie und
Verfügbarkeit: **`docs/PLAY-PRODUKTE.md`**.

Die IDs sind im Code fest verdrahtet — ein Tippfehler heißt: Produkt existiert,
App findet es nie. `test/store_products_test.dart` hält Code und Dokument
zusammen.

**Blockiert das den Release?** Nein. Ohne Produkte läuft das Spiel vollständig,
nur der Shop bleibt leer. Du kannst also veröffentlichen und die Produkte
nachziehen — sie brauchen kein neues Bundle.

---

## 5 · Der Produktions-Release selbst

- [ ] **Bundle**: `app-release.aab` aus dem `…-PRODUCTION-ads`-Artefakt. Die
      Console muss **1.2.0** und **versionCode 9** anzeigen. Weicht das ab,
      ist es der falsche Build.
- [ ] **Release Notes** einfügen:
      - Deutsch: `docs/release-notes/1.2.0-de.txt`
      - English: `docs/release-notes/1.2.0-en.txt`
      Beide liegen unter Plays 500-Zeichen-Grenze, per Test abgesichert
      (`test/release_notes_test.dart`).
- [ ] **Länder/Regionen**: siehe Empfehlung unten.
- [ ] **Rollout**: **20 %, nicht 100 %.**

**Warum gestaffelt:** In 1.1.0 gab es 142 Abstürze bei 23 Nutzern durch eine
R8-Wechselwirkung (R8 entfernte einen Konstruktor, den Room reflektiv aufruft).
Behoben und in Build #26 verifiziert — aber „verifiziert" heißt hier „auf einem
CI-Runner", nicht „auf tausend Geräten". Bei 20 % siehst du ein Problem an
einem Fünftel der Nutzer und kannst anhalten. Bei 100 % ist es draußen.

### Länderauswahl — eine Entscheidung, die du treffen musst

`MASTERPLAN.md` (Phase 4) sieht einen **Soft Launch in 1–2 kleinen Märkten**
vor. Dieser Plan stammt aus der Zeit vor dem offenen Test.

**Meine Empfehlung: alle Länder, dafür 20 % Rollout.** Der gestaffelte Rollout
erfüllt denselben Zweck — klein anfangen, beobachten, anhalten können — ohne
den Store-Eintrag in Märkten unsichtbar zu machen, in denen er erste Bewertungen
und Rankings sammeln könnte. Ein Länder-Soft-Launch lohnt sich, wenn man
Marketing-Budget testen will; das ist hier nicht der Fall.

Willst du beim Plan bleiben (1–2 Märkte), ist das genauso vertretbar — dann sag
es mir, und ich halte es in `MASTERPLAN.md` fest. **Entscheidung liegt bei dir.**

---

## 6 · Nach dem Ausrollen

- [ ] **Pre-Launch-Report**: Google fährt die App auf echten Geräten. Prüfen:
      keine Abstürze beim Start, keine ANRs, die Screenshots zeigen Menü und
      Spielfeld — nicht den Fehlerschirm.
- [ ] **Android Vitals**, erste 48 Stunden. Ziel: crashfrei **> 99,5 %**.
- [ ] **Firebase Crashlytics** gegenprüfen — dort landen Abstürze schneller.
- [ ] Bleibt es sauber: **Rollout auf 100 %.**

**Bei Abstürzen:** Rollout **anhalten**, nicht zurückziehen — ein Halt lässt
bestehende Installationen in Ruhe. Dann den Crashlytics-Stacktrace hierher.

**Die Lage, die alles andere sticht:** Das Konto war wegen Bot-Verdachts
gesperrt. Ein zweiter Vorfall beendet das Projekt. Deshalb im Zweifel immer die
vorsichtigere Variante — lieber überdeklarieren als eine Angabe schuldig
bleiben.

---

## 7 · Was du **nicht** anfassen musst

| | Warum |
|---|---|
| `mapping.txt` hochladen | steckt im AAB |
| Firestore-Regeln | am 03.09. veröffentlicht und gegen `firebase/firestore.rules` gediffed (byte-identisch) |
| Altersfreigabe neu ausfüllen | am 02.09. eingereicht |
| Data Safety neu erfinden | im September gegen den Code geprüft; nur prüfen, nicht umschreiben |
| Signing / Keystore | steckt in den GitHub-Secrets, CI signiert |

---

## 7a · app-ads.txt (AdMob-Verifizierung) — erledigt am 17.09.

**Wo die Datei liegt:** im eigenen Repo
[`f6vp76ctbb-stack/f6vp76ctbb-stack.github.io`](https://github.com/f6vp76ctbb-stack/f6vp76ctbb-stack.github.io),
ausgeliefert unter <https://f6vp76ctbb-stack.github.io/app-ads.txt>. Inhalt ist
die eine Zeile aus AdMob:

```
google.com, pub-8596176219181991, DIRECT, f08c47fec0942fa0
```

Die Publisher-ID darin ist dieselbe wie in `lib/monetization/ad_config.dart`
(`_prodRewardedAndroid`). Ändert sich das AdMob-Konto, ändert sich beides.

**Warum nicht in diesem Repo:** `app-ads.txt` wird nach der IAB-Spezifikation
ausschließlich in der **Wurzel** der Entwickler-Website gelesen. Die
Pages-Seite dieses Repos liegt bauartbedingt unter `/Qubble/`
(`--base-href /Qubble/` in `deploy-web.yaml`) — dort sucht kein Crawler. Die
Wurzel von `f6vp76ctbb-stack.github.io` bedient GitHub nur aus einem Repo, das
genau so heißt wie die Adresse. Deshalb das zweite Repo; mit einer eigenen
Domain wäre es ein Schritt weniger.

**Die zweite Hälfte ist der Store-Eintrag:** AdMob findet die Datei über das
Feld **Website** in den Kontaktdaten des Play-Store-Eintrags (öffentlich
sichtbar auf der Store-Seite unter „App-Unterstützung"). Dort stand bis zum
17.09. nur die Support-E-Mail; seitdem steht
`https://f6vp76ctbb-stack.github.io` darin — die Wurzel, ohne `/Qubble/`.
Fehlt dieses Feld, schlägt die Verifizierung fehl, egal wie korrekt die Datei
liegt.

**Wartezeit, damit niemand unnötig sucht:** Google gibt bis zu 24 Stunden bis
zum Crawlen an, nach einer frisch geänderten Entwickler-Website länger — und
rät, eine Woche abzuwarten, bevor man Hilfe sucht. „Konnte nicht bestätigt
werden" direkt nach dem Eintragen ist also der Normalfall, kein Fehler.

**Wenn später Mediation oder ein zweites Ad-Netzwerk dazukommt:** jedes Netz
braucht seine eigene Zeile in derselben Datei. Qubble nutzt heute
ausschließlich AdMob (Rewarded), deshalb genügt eine.

---

## 8 · Was hier bewusst offen bleibt

- **iOS**: `REPLACE_ME_REWARDED_IOS` (`lib/monetization/ad_config.dart:30`) und
  `REPLACE_ME_FIREBASE_IOS_APP_ID` (`lib/services/firebase_config.dart:18`).
  Ohne sie liefe iOS ohne Werbeumsatz und ohne Crash-Reporting. Betrifft nur
  die App-Store-Phase, nicht diesen Release.
- **UMP-Einwilligungsmeldung in AdMob**: Der Code ruft den Consent-Flow
  automatisch auf; die Meldung selbst muss in der AdMob-Oberfläche angelegt
  sein. Ob sie dort steht, sehe ich nicht.
- **app-ads.txt-Verifizierung**: Datei und Store-Website stehen seit dem 17.09.
  (Abschnitt 7a); ob AdMob sie inzwischen bestätigt hat, sehe ich nicht.
- **Play Games Services** (Achievements/Bestenlisten über Google): braucht
  Console-Einträge und eine neue Abhängigkeit. Nach diesem Release neu bewerten.
- **Marken-/Namenscheck** „Qubble"/„Thinkube": liegt bei dir.

---

## 9 · Wenn ein Feld fehlt

Dann fehlt es, weil ich das Formular nicht sehe — nicht, weil es unwichtig ist.
**Schick mir den Feldnamen oder den Screenshot, dann bekommst du den Wert
dazu, belegt aus dem Code.** Geraten wird hier nichts; das war schon einmal der
Grund, warum eine Anleitung Menüpfade enthielt, die es nie gab.
