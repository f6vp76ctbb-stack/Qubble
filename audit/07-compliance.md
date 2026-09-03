# 07 — Compliance-Reaudit (P0)

Checkliste gegen die in `audit/01a-compliance-recherche.md` live geprüften
Regeln (alle Quellen dort, abgerufen 2026-08-31). Je Punkt: **erfüllt** /
**nicht erfüllt** / **unklar**, mit Fundstelle.

Die Reihenfolge folgt dem Risiko für ein **erneutes** Enforcement, nicht der
Reihenfolge der Policy-Seiten. Bei einem Konto mit Vorgeschichte ist das der
richtige Maßstab: Google erwartet nach einem Vorfall ausdrücklich eine
Eigenprüfung des gesamten Kontos, nicht nur die Behebung des gerügten Punktes.

---

## Gesamtbild

| Bereich | Status |
|---|---|
| Technische Fristen (Target API, Billing) | **erfüllt**, beide am Stichtag heute |
| Ads-Policy | **erfüllt**, strukturell |
| Datenschutzerklärung, Impressum | **erfüllt** |
| Admin-/Cheat-Riegel | **erfüllt**, doppelt verifiziert |
| **UGC-Moderation** | **nicht erfüllt** — schwerwiegendster Befund |
| **Metadaten-Genauigkeit** | **nicht erfüllt** — drei falsche Aussagen |
| **Löschpfad für Nutzerdaten** | **nicht erfüllt** |
| Data-Safety-Deklaration | **unklar** — Console-Zugriff fehlt |
| Content Rating (IARC) | **unklar** — Console-Zugriff fehlt |
| AD_ID im gemergten Manifest | **unklar** — CI-Lauf beantwortet es |

> Das ist der Stand vom 31.08.2026. Fünf der sechs offenen Punkte sind
> inzwischen erledigt — siehe „Umsetzungsstand 2026-09-02" direkt darunter.

---

## Umsetzungsstand 2026-09-02

**Der Befundtext unten steht auf dem Stand vom 31.08.2026 und wird nicht
umgeschrieben** — er ist der Nachweis, was geprüft wurde. Diese Tabelle sagt,
was seitdem passiert ist. Bei einem Konto in der Wiederzulassung wäre ein
Dokument, das zehnmal „nicht erfüllt" sagt, obwohl es behoben ist, selbst ein
Risiko: Wer es öffnet, zieht den falschen Schluss.

| Befund | Stand heute | Beleg |
|---|---|---|
| **B-1** UGC-Moderation | **erfüllt**, Filter am 02.09. nachgeschärft | Melden (`leaderboard_screen.dart:_report`), Blockieren mit Fußzeile und Rückgängig (`_block`, `storage.blockedNames`), Nutzungsregel **mit Bestätigung** („I understand") vor der Namensvergabe, Löschweg siehe B-3. Abgesichert in `test/widget/ugc_moderation_test.dart` |
| **B-2** Metadaten-Genauigkeit | **erfüllt** | Alle drei Aussagen sind aus `audit/copy/long-*.txt` **und** aus `store-assets/store-listing.csv` entfernt; `test/store_claims_test.dart` lässt sie nicht zurückkommen. Auch die Screenshot-Untertitel waren betroffen und sind korrigiert |
| **B-3** Löschpfad | **erfüllt** | `LeaderboardService.deleteEntry()` mit Identitätsabgleich, Einstiegspunkt in den Einstellungen, Firestore-Regel `allow delete: if isOwner(uid)` |
| **C-1** Data-Safety | **geklärt, korrekt eingereicht** | Der Console-Export wurde am 02.09. Zeile für Zeile gegen den Code geprüft: nichts unterdeklariert. Vier Zeilen **dieses Audits** waren falsch, nicht das Formular — korrigiert in `docs/DATA-SAFETY.md` |
| **C-2** Content Rating (IARC) | **erledigt** — der Fragebogen ist am 02.09. vom Kontoinhaber neu ausgefüllt und eingereicht. Damit sind **alle** Compliance-Befunde dieses Audits geschlossen | Bestätigung des Kontoinhabers. Die Analyse der Einstiegsfrage (Einzel-/Mehrspieler-Abgrenzung) steht unten bei C-2 und war die Grundlage der Antworten |
| **C-4** Google-Fonts-Abruf im Web-Build (neu 03.09.) | **behoben** | Im gebauten PWA beobachtet: Flutter forderte `fonts.gstatic.com/s/notocoloremoji/…` nach, weil der Web-Renderer keine Emoji-Schrift mitbringt. Das sendet die IP des Spielers an einen Google-Server, den `web/privacy.html` **nicht** nennt (dort stehen AdMob, Firebase, UMP — keine Schriftarten), und es widerspricht dem erklärten Ziel des Workflows, dass die PWA „vollständig offline" läuft: ohne Netz wäre jedes Emoji ein leeres Kästchen. Emoji sind aus allen Texten entfernt, die der Web-Build zeichnet; die Anfrage tritt danach nicht mehr auf (erneut im Browser gemessen). `test/no_web_emoji_test.dart` hält es fest |
| **C-3** AD_ID im Manifest | **geklärt** | Der CI-Build gibt die gemergten Permissions aus. `com.google.android.gms.permission.AD_ID` ist enthalten — damit ist Zeile 1 der Data-Safety-Deklaration zwingend, und sie ist gesetzt |

**Nachträglich gefunden, nicht Teil des ursprünglichen Reaudits:** ein
R8-Startabsturz, der 23 Nutzer traf (`audit/08-r8-risiko.md`). Behoben und im
Build nachgewiesen.

**Zum Namensfilter:** Der Befundtext nennt ihn „umgehbar", ohne zu sagen wie.
Am 02.09. nachgemessen — elf Umgehungsversuche, vier kamen durch:

| Umgehung | Ursache |
|---|---|
| `niggggger`, `assss` | Die Kollaps-Normalisierung reduzierte Läufe auf **einen** Buchstaben und zerstörte damit den Treffer, den sie finden sollte |
| `ni66er` | `6` fehlte in der Leet-Tabelle (ebenso `2`) |
| `reggin` | Umkehrung wurde nicht geprüft |
| `xXfuckXx`, `thefuck` | Als Token-Treffer geführt, also nur als ganzes Wort geprüft |

Alle vier geschlossen, festgehalten in `test/game/name_filter_bypass_test.dart`
— zusammen mit **33 harmlosen Namen**, die weiter durchkommen müssen. Das ist
die Hälfte, die die Regeln überhaupt begrenzt: Ein Filter, der echte Namen
sperrt, ist nicht strenger, sondern kaputt, und der Spieler kann nicht
widersprechen.

Eine Wortliste wird nie vollständig — das behauptet auch keiner. Sie ist die
Schicht für die offensichtlichen Fälle **unter** Melden und Blockieren, kein
Ersatz dafür.

---

## A · Erfüllt und belegt

### A-1 · Target API Level — **erfüllt**

Seit **31.08.2026** (heute) müssen neue Apps und Updates API 36 targetieren.
Qubble: `targetSdk = 36` (`android/app/build.gradle.kts:47` →
`FlutterExtension.kt:34`), im CI hart nachgeprüft
(`.github/workflows/build-release.yaml`, `check targetSdkVersion … "36"`).

### A-2 · Play Billing Library — **erfüllt**

Seit **31.08.2026** ist Version 8+ Pflicht. Qubble bindet über
`in_app_purchase_android` 0.5.1 die Version
`com.android.billingclient:billing:8.0.0`
(`~/.pub-cache/.../in_app_purchase_android-0.5.1/android/build.gradle.kts:76`).

> **Regressionsrisiko, benannt:** Beide Punkte hängen an transitiv aufgelösten
> Versionen. Ein unbedachtes `flutter pub upgrade` kann die Billing-Version
> senken, ohne dass ein Test anschlägt. Empfehlung: einen Test ergänzen, der
> `pubspec.lock` auf `in_app_purchase_android >= 0.5.1` prüft — Aufwand 30 min.

### A-3 · Ads-Policy — **erfüllt, und zwar strukturell**

Rewarded ist von der „Better Ads Experiences"-Policy ausdrücklich ausgenommen.
Qubble bindet kein anderes Format ein: `grep -rn
"InterstitialAd\|BannerAd\|AppOpenAd" lib/` → **keine Treffer**.

Das ist der einzige Bereich, in dem Qubble beim Policy-Risiko **unter** der
Kategorie liegt. Für die Wiedereinreichung ist das ein Argument, das im Appeal
benannt werden sollte.

### A-4 · UMP-Consent vor dem ersten Ad-Request — **erfüllt**

`ads.dart:52-58`: `initialize()` ruft `_requestConsent()` **vor**
`MobileAds.instance.initialize()` und lädt nur bei `_canRequestAds` (`:57`).
Ein fehlgeschlagener oder unbekannter Consent-Zustand führt nie zu einem
Request (`:64-72`). Die Datenschutz-Optionen sind in den Einstellungen erneut
aufrufbar (`ads.dart:93-115`, aufgerufen in `settings_screen.dart:327`) — das
erfüllt die UMP-Anforderung eines In-App-Einstiegspunkts.

### A-5 · Test-Ad-Units in Nicht-Produktionsbuilds — **erfüllt**

`ad_config.dart:42`: `usesTestAds => kDebugMode || forceTestAds`, wobei
`forceTestAds` aus `--dart-define=QUBBLE_TEST_ADS` kommt (`:37`). Der
Release-Workflow setzt den Schalter standardmäßig auf `true`
(`build-release.yaml`, Input `test_ads`, Default `true`) mit der Begründung,
dass Produktions-Units an eine bekannte Testerschar als Invalid Traffic gewertet
werden.

Das ist über die Anforderung hinaus sorgfältig und genau richtig für ein Konto,
das bereits unter Bot-Verdacht stand.

### A-6 · Datenschutzerklärung und Impressum — **erfüllt**

`web/privacy.html` ist vollständig ausgefüllt (Verantwortlich: Thinkube,
Mähderweg 5, 88451 Dettingen, thinkube@outlook.de; Stand 23.07.2026) und deckt
AdMob, Firebase Analytics/Crashlytics, **die Bestenliste inklusive anonymer
Kennung**, IAP und Kinder ab. `web/impressum.html` erfüllt § 5 DDG. Beide sind
in der App verlinkt (`settings_screen.dart:39, 42`).

Die Erklärung ist inhaltlich genauer als das Store-Listing — sie benennt die
Datenübertragung, die die Beschreibung bestreitet (siehe B-2).

> **Aufräumbedarf, kein Verstoß:** `docs/PRIVACY-POLICY.md` und
> `docs/IMPRESSUM.md` sind widersprüchliche Altfassungen mit ungefüllten
> `[…]`-Platzhaltern; die erste behauptet wörtlich „Diese Daten verlassen das
> Gerät nicht". Sie sind nirgends verlinkt, aber sie sind eine Fehlerquelle für
> jeden, der später das Data-Safety-Formular ausfüllt. **Löschen oder durch
> einen Verweis auf die HTML-Fassung ersetzen.**

### A-7 · Admin-/Cheat-Riegel — **erfüllt, doppelt verifiziert**

`CLAUDE.md` verlangt eine doppelte Verriegelung. Beide Ebenen existieren:

| Ebene | Fundstelle |
|---|---|
| UI: versteckte Admin-Sektion nur in Debug | `settings_screen.dart:46` (`if (!kDebugMode) return;`), `:364` (`if (kDebugMode && _adminUnlocked)`) |
| Controller: No-op im Release | `game_controller.dart:682` und `:695` (`if (kReleaseMode) return;`) |

Der Kommentar bei `:693` hält ausdrücklich fest, dass ein reiner UI-Riegel „nur
zufällig" gewirkt hätte. Das ist die richtige Konstruktion.

### A-8 · Web-Build liefert keine Käufe gratis aus — **erfüllt**

`main.dart:86-88`: Der öffentliche Web-Build nutzt `LockedIap`
(`iap.dart:156-174`: keine Produkte, `buy()` liefert nie aus); `FakeIap` nur in
lokalen Debug-Web-Builds. Damit kann der PWA-Build die Bestenlisten-Fairness
nicht unterlaufen.

### A-9 · Signatur — **erfüllt**

Ein Release-Artefakt kann nicht versehentlich mit dem Debug-Key signiert werden:
Gradle bricht ab (`build.gradle.kts:88-104`), und der CI-Job prüft das gebaute
Bundle zusätzlich auf `CN=Android Debug` (`build-release.yaml`).

---

## B · Nicht erfüllt

### B-1 · UGC-Moderation — **nicht erfüllt** · **P0**

**Das ist der schwerwiegendste Compliance-Befund des gesamten Audits.**

Googles UGC-Policy verlangt für Apps mit nutzergenerierten Inhalten: ein
In-App-System zum **Melden und Blockieren** anstößiger Inhalte und Nutzer,
**Nutzungsbedingungen**, die der Nutzer vor dem Erstellen von UGC akzeptiert,
und **zeitnahes Handeln** auf Meldungen (Quelle in `01a`, Abschnitt 8).

Qubble hat UGC: Der Spieler wählt einen Anzeigenamen, dieser geht an Firestore
und wird **allen anderen Spielern öffentlich angezeigt**
(`lib/services/leaderboard.dart:133-166`,
`lib/ui/screens/leaderboard_screen.dart`, Firestore-Regel
`allow read: if true`).

Vorhanden:

| Schutz | Fundstelle |
|---|---|
| Client-Wortliste mit Normalisierung (Leetspeak, Dehnung) | `lib/game/name_filter.dart` |
| Zeichen- und Längenregel `[A-Za-z0-9 _-]{2,14}` | `name_filter.dart:21`, gespiegelt in `firebase/firestore.rules` |

Nicht vorhanden — verifiziert per Suche über `leaderboard_screen.dart`,
`home_screen.dart` und `lib/l10n/app_en.arb` nach
`report|melde|block|flag|abuse|terms`:

| Anforderung | Status |
|---|---|
| In-App-Meldefunktion für einen anstößigen Namen | **fehlt** (einziger `flag`-Treffer ist `Icons.flag_outlined` in `home_screen.dart:560` — der Missionen-Knopf) |
| Blockfunktion | **fehlt** |
| Nutzungsbedingungen vor der Namensvergabe | **fehlt** |
| Weg, einen gemeldeten Eintrag zu entfernen | **fehlt** — `firebase/firestore.rules`: `allow delete: if false`, kategorisch, auch für den Betreiber über den normalen Client |

Ein Wortfilter ist keine Moderation im Sinne der Policy — die Policy verlangt
das Meldesystem **zusätzlich**. Und der Filter ist umgehbar: Nach Normalisierung
kennt er nur `[a-z]`, also passiert jeder beleidigende Name, der nicht auf der
Liste steht.

**Warum das jetzt zählt:** Die App wurde bereits einmal gesperrt. Ein
öffentlich sichtbares Namensfeld ohne Meldeweg ist eine offene Flanke, die
Google bei einer Neuprüfung findet — unabhängig davon, worum es beim ersten
Vorfall ging.

**Fix, drei Teile:**

1. **Meldefunktion** im Bestenlisten-Screen: Long-Press oder Overflow-Menü je
   Zeile → „Melden". Ohne Backend genügt ein `mailto:`-Aufruf über den
   vorhandenen `url_launcher` an `thinkube@outlook.de` mit vorbefülltem Betreff
   und der gemeldeten Zeile. Das ist ein legitimer Meldeweg.
2. **Löschweg schaffen:** Firestore-Regel um ein Betreiber-Löschrecht
   erweitern (oder Löschung über die Firebase-Console dokumentieren) und dazu
   das Eigen-Löschrecht aus B-3.
3. **Kurze Nutzungsregel** beim Namensdialog: ein Satz plus Bestätigung
   („Keine beleidigenden oder personenbezogenen Namen. Verstöße werden
   entfernt.").

**Aufwand:** 4–6 h, ohne Backend.

### B-2 · Metadaten-Genauigkeit — **nicht erfüllt** · **P0**

Google verlangt, dass Metadaten die Funktionalität **präzise** abbilden;
irreführende Beschreibungen fallen unter Deceptive Behavior.

Drei Aussagen im dokumentierten Listing (`docs/STORE-LISTING.md`) halten dem
Abgleich mit dem Code nicht stand:

| Aussage | Widerspruch | Beleg |
|---|---|---|
| „Kein Internet nötig, kein Konto, **kein Server**" | Die Bestenliste sendet Anzeigename und Punktestand an Cloud Firestore und legt dafür eine anonyme Firebase-Auth-Identität an. | `leaderboard.dart:133-210` |
| „Wer es in der **Mindestzahl an Zügen** schafft, holt **drei Sterne**" | In 200 von 200 geprüften Leveln gilt `minMoves == Teilezahl` → `moves` ist beim Sieg immer `minMoves` → **immer 3 Sterne**. Die beschriebene Abstufung existiert nicht. | Phase 3, L-2 |
| „**Kein Zeitdruck**, kein Timer" | Combo-Fenster 10 s mit sichtbarem Countdown; 96,6 % aller Punkte hängen an Clears mit Combo-Multiplikator. | `scoring.dart:50`, `game_screen.dart:704`, `BALANCE.md` D.3 |

Die erste ist die kritischste, weil sie **denselben Sachverhalt bestreitet, den
das Data-Safety-Formular deklarieren muss**. Ein Prüfer, der Beschreibung und
Formular nebeneinanderlegt, findet dort einen Widerspruch — und das ist laut
der Recherche in `01a` der häufigste Enforcement-Auslöser.

**Fix:** bereits erledigt. Bereinigte Fassungen liegen in
`audit/copy/long-de.txt` und `audit/copy/long-en.txt`, Begründung in
`audit/05-aso.md`, Abschnitt 1. **Vor der Wiedereinreichung eintragen.**

**Aufwand:** 15 min (Copy-Paste).

### B-3 · Löschpfad für Nutzerdaten — **nicht erfüllt** · **P1**

Googles Anforderung: Wenn Nutzer in der App Konten anlegen können, muss es
einen Weg zur Löschung des Kontos und der zugehörigen Daten geben, in der App
**und** außerhalb.

Der Sachverhalt bei Qubble:

- Beim ersten Bestenlisten-Submit wird still ein anonymes
  Firebase-Auth-Konto angelegt (`leaderboard.dart:192-209`).
- `uid` und `refreshToken` werden lokal persistiert (`storage.dart:46-47`).
- Der Eintrag ist **öffentlich lesbar** (`firestore.rules`:
  `allow read: if true`) und **nicht löschbar** (`allow delete: if false`).
- Die Einstellungen bieten „Fortschritt löschen"
  (`settings_screen.dart:357`) — das ruft `Storage.resetProgress()`
  (`storage.dart:150-154`) und räumt **nur die `progressKeys`**. `fbUid` und
  `fbRefreshToken` liegen in `entitlementKeys` (`storage.dart:113-114`) und
  **überleben** die Zurücksetzung. Der Firestore-Eintrag bleibt ohnehin.

Ergebnis: Ein Spieler, der „Fortschritt löschen" drückt, behält seine anonyme
Identität und seinen öffentlich sichtbaren Namen in der Bestenliste. Ein
in-App-Löschweg für den Bestenlisten-Eintrag existiert **nicht**.

Der Außer-App-Weg existiert: `web/privacy.html` nennt thinkube@outlook.de
ausdrücklich „Zur Löschung deines Bestenlisten-Eintrags". Das ist die halbe
Anforderung.

**Ob Google ein stilles anonymes Auth-Konto als „account" wertet, ist aus dem
Policy-Text nicht eindeutig ableitbar** — Konfidenz mittel. Was eindeutig ist:
Der öffentliche Eintrag ist vom Spieler nicht entfernbar, und das ist unabhängig
von der Policy-Auslegung ein DSGVO-Thema.

**Fix:** In den Einstellungen ein „Bestenlisten-Eintrag löschen" ergänzen, das
(a) den Firestore-Eintrag löscht — dafür muss die Regel `allow delete: if
isOwner(uid)` erlauben — und (b) `fbUid`/`fbRefreshToken` lokal entfernt. Beides
zusammen ist die vollständige Erfüllung und schließt zugleich einen Teil von
B-1.

**Aufwand:** 3 h inkl. Regeländerung und Test.

---

## C · Unklar — Console-Zugriff erforderlich

Diese drei Punkte kann ich nicht entscheiden. Sie sind **die wichtigsten
verbleibenden Risiken**, weil sie genau dort liegen, wo laut Recherche das
meiste Enforcement passiert.

### C-1 · Data-Safety-Deklaration — **unklar** · **P0**

Der tatsächliche Datenfluss ist aus dem Code vollständig bekannt (Phase 0,
Abschnitt 6). Zu deklarieren wäre mindestens:

| Datenart | Erhoben | Geteilt | Zweck | Auslöser |
|---|---|---|---|---|
| Geräte- oder andere IDs (Werbe-ID) | ja | ja (Google) | Werbung | AdMob |
| App-Interaktionen | ja | ja (Google) | Analyse | Firebase Analytics |
| Absturzprotokolle, Diagnose | ja | ja (Google) | Diagnose | Crashlytics |
| **Sonstige nutzergenerierte Inhalte** (Anzeigename) | **ja** | **ja, öffentlich** | App-Funktion | Bestenliste |
| **Sonstige IDs** (anonyme Auth-Kennung) | **ja** | ja (Google) | App-Funktion | Bestenliste |
| Kaufhistorie | über Play abgewickelt | — | — | IAP |

Die beiden fett markierten Zeilen sind die, die beim Ausfüllen am ehesten
übersehen werden — besonders, wenn man die Marketing-Erzählung „komplett
offline, kein Server" im Kopf hat.

**Was zu tun ist:** Die Deklaration in der Console gegen diese Tabelle prüfen.
Wenn dort „Es werden keine Daten erhoben" steht, ist das nachweislich falsch
und **muss vor der Wiedereinreichung korrigiert werden** — das allein wäre ein
hinreichender Enforcement-Grund.

### C-2 · Content Rating (IARC) — **unklar** · **P1**

Der IARC-Fragebogen berücksichtigt ausdrücklich, ob eine App **Nutzerinteraktion
ermöglicht und nutzergenerierte Inhalte teilt**. Wegen der öffentlichen
Bestenliste lautet die richtige Antwort **ja**, nicht nein.

`docs/STORE-LISTING.md` plant „voraussichtlich USK 0 / PEGI 3". Die Einstufung
selbst ist plausibel; die Frage nach Interaktion/UGC muss trotzdem bejaht
werden. Eine falsche Antwort hier ist eine Fehldeklaration gegenüber IARC.

Zusätzlich muss im Fragebogen angegeben sein, dass die App Werbung enthält und
In-App-Käufe anbietet. Beides trifft zu.

### C-3 · AD_ID im gemergten Manifest — **unklar** · **P1**

`android/app/src/main/AndroidManifest.xml` deklariert
`com.google.android.gms.permission.AD_ID` **nicht** (Zeilen 2-5). Qubble bindet
aber `play-services-ads:25.3.0` ein
(`~/.pub-cache/.../google_mobile_ads-9.0.0/android/build.gradle:71`), das die
Permission laut Google in seinem eigenen Library-Manifest führt — sie kommt also
vermutlich per Merge hinein.

Relevant ist nicht der Build, sondern die Konsequenz: **Wenn AD_ID im gemergten
Manifest steht, nutzt die App die Werbe-ID**, und das muss im Data-Safety-
Formular stehen (C-1).

**Das ist ohne Rätselraten beantwortbar.** Der CI-Job gibt die gemergten
Permissions bereits aus (`build-release.yaml`, Schritt „Verify the bundle",
`q /manifest/uses-permission/@android:name`). Ein manueller Lauf von
„Build Android Release" klärt es in zehn Minuten — und liefert nebenbei die in
Phase 2 offenen Messwerte.

---

## D · Signale, die Bot- oder Wiederholungsverdacht nähren könnten

Ich habe nach Mustern gesucht, die in einer Neuprüfung negativ auffallen
könnten. Befund:

| Signal | Bewertung |
|---|---|
| Ein einziges Produkt, keine App-Serie | unauffällig |
| 151 Commits über zwei Monate, nachvollziehbare Historie | unauffällig, eher positiv |
| Produktions-Ad-Units im Testbuild | **aktiv vermieden** (`ad_config.dart:37`, CI-Default `test_ads: true`) — genau das richtige Verhalten für ein Konto unter Bot-Verdacht |
| Feedback läuft über GitHub-Issues des Eigentümers | unauffällig; der Workflow filtert auf `github.event.issue.user.login == github.repository_owner` (`feedback.yaml`) |
| Bestenliste ohne Meldeweg | **auffällig** — siehe B-1 |
| Beschreibung bestreitet die Datenübertragung | **auffällig** — siehe B-2 |

Der oft genannte Bot-Auslöser „mehrere App-Uploads in kurzer Zeit" trifft hier
nicht zu (eine App, eine Historie). Die Quelle dafür ist allerdings sekundär und
mit niedriger Konfidenz belegt (`01a`, Abschnitt 11) — was den ursprünglichen
Vorfall ausgelöst hat, ist ohne den Wortlaut der Enforcement-Mail nicht
bestimmbar.

**Der wichtigste Satz aus der Enforcement-Recherche** bleibt: Google erwartet
nach einem Vorfall „extra due diligence to ensure that the remainder of your app
or account is fully policy compliant". Genau darum gehören B-1 bis B-3 vor die
Wiedereinreichung — auch wenn keiner davon der ursprüngliche Grund war.

---

## Reihenfolge vor der Wiedereinreichung

| # | Maßnahme | Status | Aufwand |
|---|---|---|---|
| 1 | CI-Release-Build starten → AD_ID, Manifest, AAB-Größe klären (C-3) | unklar | 10 min |
| 2 | Data-Safety-Deklaration gegen die Tabelle in C-1 prüfen und korrigieren | unklar | 1 h |
| 3 | Store-Beschreibung durch die bereinigte Fassung ersetzen (B-2) | nicht erfüllt | 15 min |
| 4 | IARC-Fragebogen: Nutzerinteraktion/UGC auf „ja" (C-2) | unklar | 30 min |
| 5 | Meldefunktion + Nutzungsregel in der Bestenliste (B-1) | nicht erfüllt | 4–6 h |
| 6 | „Bestenlisten-Eintrag löschen" + Firestore-Regel (B-3) | nicht erfüllt | 3 h |
| 7 | `docs/PRIVACY-POLICY.md` / `docs/IMPRESSUM.md` aufräumen (A-6) | Aufräumen | 15 min |
| 8 | Lock-Test gegen Billing-Downgrade (A-2) | Absicherung | 30 min |

Punkte 1–4 sind zusammen unter zwei Stunden und decken das größte Risiko ab.
Punkte 5 und 6 sind die eigentliche Arbeit — und der Teil, der die App von
„vermutlich konform" auf „nachweislich konform" hebt.

---

## Quellen

Alle Policy-Belege mit URL und Abrufdatum stehen in
`audit/01a-compliance-recherche.md`. Alle Aussagen über die App tragen eine
Fundstelle in diesem Repo oder ein in dieser Session ausgeführtes Kommando.
