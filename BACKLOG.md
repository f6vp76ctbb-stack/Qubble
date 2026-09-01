# BACKLOG — Qubble

Stand 2026-08-31. Grundlage: `audit/00-bestand.md` bis `audit/07-compliance.md`.
Jede Zeile trägt eine Fundstelle oder eine Messung in der jeweiligen Phasendatei.

## RICE-Methode

`RICE = (Reach × Impact × Confidence) / Effort`

| Faktor | Skala | Begründung der Wahl |
|---|---|---|
| **Reach** | Anteil betroffener Spieler in Prozent (0–100) | Absolute Nutzerzahlen sind unbekannt (Phase 1c: Solo-Titel ohne UA-Budget). Ein Anteil ist die einzige ehrlich schätzbare Größe. **Compliance-Punkte bekommen 100**, weil bei gesperrter App niemand spielt. |
| **Impact** | 3 massiv · 2 hoch · 1 mittel · 0,5 gering · 0,25 minimal | Standard-RICE-Skala. |
| **Confidence** | 1,0 gemessen · 0,8 belegt aber nicht gemessen · 0,5 begründete Annahme | 1,0 nur, wo eine Messung in dieser Session vorliegt oder der Code eindeutig ist. |
| **Effort** | Personenstunden, Solo-Entwickler, inkl. Tests | Aufwände aus den Phasendateien. |

**Warnung zur Interpretation:** RICE ordnet nach Effizienz, nicht nach
Notwendigkeit. Ein Punkt mit RICE 48 (UGC-Meldefunktion) kann trotzdem
zwingend vor der Wiedereinreichung stehen, weil er ein Zulassungsrisiko ist.
Die Blockeinteilung sticht die RICE-Reihenfolge.

Gesamtaufwand: **P0 11,5 h · P1 27 h · P2 29 h** — rund 68 Stunden.

---

## Stand 2026-09-01

Die Umsetzung läuft; erledigte Punkte sind unten mit ✅ markiert und tragen den
Commit. Testzahl 441 → **586**, `flutter analyze` durchgehend ohne Befund.

| Block | erledigt | offen |
|---|---|---|
| **P0** | 7 von 10 — alles, was im Code liegt | 3 Console-Aktionen (#2, #4, #5) |
| **P1** | **12 von 12** | — |
| **P2** | 4 von 12 | die übrigen acht |

**Die drei offenen P0 kann nur der Kontoinhaber ausführen** — sie brauchen
Zugang zur Play Console bzw. zu GitHub Actions:

1. **CI-Release-Build starten** (`build-release.yaml`) → klärt AD_ID im
   gemergten Manifest, AAB-Größe und R8-Verhalten. **Jetzt zusätzlich dringend:**
   Ein gemeldeter `androidx.startup.StartupException` deutet auf einen
   R8-Startabsturz; die Keep-Regeln dafür sind ergänzt (`b3bd70d`), aber nicht
   auf einem Gerät verifiziert.
2. **Data-Safety-Formular** korrigieren — Vorlage liegt fertig in
   `docs/DATA-SAFETY.md`, aus dem Code abgeleitet.
3. **IARC-Fragebogen**: Nutzerinteraktion/UGC auf „ja".

Nachträglich ergänzt, nicht aus dem ursprünglichen Audit: **R8-Keep-Regeln für
`androidx.startup`** (`b3bd70d`). `google_mobile_ads` zieht
`androidx.lifecycle:lifecycle-process` herein, das seinen Initializer über
Manifest-Metadaten benennt — eine Namensform, die AGP nicht als Klassenreferenz
behandelt.

---

## Block P0 — vor der Wiedereinreichung

Alles hier adressiert entweder ein Zulassungsrisiko oder ist Voraussetzung für
die Bewertung eines solchen. Zusammen **11,5 Stunden**.

| # | Maßnahme | R | I | C | E (h) | RICE | Abhängig von | Beleg |
|---|---|---:|---:|---:|---:|---:|---|---|
| 1 | ✅ `8fea9ce` **Store-Beschreibung durch die bereinigte Fassung ersetzen** | 100 | 3 | 1,0 | 0,25 | **1200** | — | Phase 7 B-2; Copy liegt fertig in `audit/copy/` |
| 2 | **CI-Release-Build starten** (`build-release.yaml`) | 100 | 2 | 1,0 | 0,2 | **1000** | — | Phase 2; klärt AD_ID, Manifest, AAB-Größe, R8 |
| 3 | ✅ `1ee0292` **Lock-Test gegen Billing-Downgrade** | 100 | 2 | 1,0 | 0,5 | **400** | — | Phase 7 A-2 |
| 4 | **IARC-Fragebogen: Nutzerinteraktion/UGC auf „ja"** | 100 | 2 | 0,8 | 0,5 | **320** | — | Phase 7 C-2 |
| 5 | **Data-Safety-Deklaration korrigieren** | 100 | 3 | 0,8 | 1,0 | **240** | #2 | Phase 7 C-1 |
| 6 | ✅ `d00d226` **Rätsel-Rewarded instrumentieren** | 100 | 1 | 1,0 | 0,5 | **200** | — | Phase 4 M-1 |
| 7 | ✅ `d0d4915` **Alte Rechtsdoku aufräumen** (`docs/PRIVACY-POLICY.md`, `docs/IMPRESSUM.md`) | 100 | 0,5 | 1,0 | 0,25 | **200** | — | Phase 7 A-6 |
| 8 | ✅ `5650e08` **R8-Keep-Regeln für `flutter_local_notifications`** | 60 | 3 | 0,8 | 0,75 | **192** | #2 | Phase 2 T-4 |
| 9 | ✅ `296c2ed` **Bestenlisten-Eintrag löschbar machen** (+ Firestore-Regel) | 100 | 2 | 0,8 | 3,0 | **53** | — | Phase 7 B-3 |
| 10 | ✅ `ace65ca` **UGC: Meldefunktion + Nutzungsregel** | 100 | 3 | 0,8 | 5,0 | **48** | #9 | Phase 7 B-1 |

### Reihenfolge und Begründung

**#1 und #2 zuerst**, weil beide unter 20 Minuten kosten und #2 vier andere
Punkte entblockt. #5 und #8 hängen an #2, weil erst der gemergte Manifest-Dump
zeigt, ob AD_ID drin ist und ob das Bundle sauber ist.

**#9 vor #10**, weil die Meldefunktion einen Löschweg braucht, um mehr als eine
Geste zu sein. Die Firestore-Regel `allow delete: if false` verhindert heute
sogar, dass der Betreiber einen gemeldeten Eintrag über den normalen Client
entfernt.

**#10 hat den niedrigsten RICE des Blocks und bleibt trotzdem P0.** Ein
öffentlich sichtbares Namensfeld ohne Meldeweg ist bei einem Konto mit
Enforcement-Vorgeschichte eine offene Flanke — und Google verlangt nach einem
Vorfall ausdrücklich die Eigenprüfung des gesamten Kontos, nicht nur die
Behebung des gerügten Punktes (Phase 1a, Abschnitt 11).

---

## Block P1 — vor dem Release

Zusammen **27 Stunden**. Nichts hier ist ein Zulassungsrisiko; alles ist
entweder ein sichtbarer Produktfehler oder die Voraussetzung dafür, spätere
Entscheidungen zu messen statt zu raten.

| # | Maßnahme | R | I | C | E (h) | RICE | Abhängig von | Beleg |
|---|---|---:|---:|---:|---:|---:|---|---|
| 11 | ✅ `81050af` **Regeltext nicht mehr vor die erste Runde schieben** | 100 | 2 | 0,5 | 1 | **100** | — | Phase 3 L-1 |
| 12 | ✅ `37339d1` **`rewarded_offered` / `_accepted` einführen** | 100 | 2 | 1,0 | 2 | **100** | #6 | Phase 4 M-2, Phase 6 A-3 |
| 13 | ✅ `5c32d95` **`migrate()`: Vorwärtsfall implementieren + Test** | 100 | 1 | 0,8 | 1 | **80** | — | Phase 2 T-5 |
| 14 | ✅ `2342eff` **Ad-Revenue über `onPaidEvent`** | 100 | 2 | 1,0 | 3 | **67** | — | Phase 6 A-4 |
| 15 | ✅ `1f99c3c` **Hartkodiertes Deutsch + Wächter in Gegenrichtung** | 50 | 2 | 1,0 | 2 | **50** | — | Phase 2 T-3 |
| 16 | ✅ `a8040d2` **FTUE-Ereignisse** (`tutorial_*`, `first_placement`) | 100 | 1 | 1,0 | 2 | **50** | — | Phase 6 |
| 17 | ✅ `ac36bfb` **Screenshot 1 neu bauen** (Aufnahme nach dem Burst; „Ablage im Bild" war ein Fehlurteil, siehe `audit/05-aso.md`) | 100 | 2 | 0,5 | 2 | **50** | — | Phase 5 |
| 18 | ✅ `9af0de6` **Layout-Overflows auf Stats/Achievements/Themes** | 60 | 2 | 1,0 | 3 | **40** | — | Phase 2 T-1, gemessen |
| 19 | ✅ `d6681ca` **Lucky Block: Deckel von 3** (Bestätigungsdialog verworfen — der Knopf liegt nicht in der Zieh-Fläche, siehe Commit) | 30 | 1 | 1,0 | 1 | **30** | — | Phase 4 M-3 |
| 20 | ✅ `e1cbe80` **Rätsel: Schwierigkeit öffnen, Sterne ehrlich machen** | 40 | 2 | 0,8 | 4 | **16** | — | Phase 3 L-2, gemessen |
| 21 | ✅ `6991fef` **Timeout auf `fetchTop()`** | 15 | 1 | 1,0 | 1 | **15** | — | Phase 2 T-9 |
| 22 | ✅ `e174b41` **Systemschriftgröße behandeln** | 25 | 2 | 1,0 | 5 | **10** | #18 | Phase 2 T-2, gemessen |

### Begründung der Ausreißer

**#11 hat Confidence 0,5**, obwohl der Befund eindeutig ist. Grund: Dass der
Regeltext Spieler *kostet*, ist plausibel und marktgestützt, aber nicht
gemessen — es gibt heute kein `first_placement`-Ereignis. Deshalb ist #16 die
sinnvolle Begleitmaßnahme: erst messen, dann bewerten.

**#20 rangiert trotz starker Messung niedrig**, weil der Rätselmodus nur einen
Teil der Spieler erreicht (Reach 40). Er bleibt in P1, weil er der einzige
Inhalt mit echtem Fortschritt ist — der strukturell beste Grund, an Tag 7
wiederzukommen (Phase 3).

**#22 rangiert zuletzt** und ist trotzdem P1: 5 Stunden für 25 % der Spieler
ist ineffizient, aber ein abgeschnittener Startbildschirm ab Schriftskala 1.3
(gemessen) landet direkt in den Bewertungen — und Bewertungen speisen laut
Phase 1c den Suchkanal, der 88 % der Installs liefert.

---

## Block P2 — danach

Zusammen **29 Stunden**. Sortiert nach RICE.

| # | Maßnahme | R | I | C | E (h) | RICE | Beleg |
|---|---|---:|---:|---:|---:|---:|---|
| 23 | Nutzereigenschaften für Kohorten | 100 | 1 | 1,0 | 1 | **100** | Phase 6 A-5 |
| 24 | ✅ `a807cc5` `music.wav` verkleinert (1,14 MB — **nicht** OGG: iOS decodiert Vorbis nicht, MP3 bricht den nahtlosen Loop; stattdessen 8 kHz PCM, Inhalt endet bei 663 Hz) | 100 | 0,25 | 1,0 | 0,5 | **50** | Phase 2 T-7, gemessen |
| 25 | Crashlytics Custom Keys | 100 | 0,5 | 1,0 | 1 | **50** | Phase 6 C-2 |
| 26 | UMP-Consent an Firebase Analytics durchreichen | 100 | 1 | 0,8 | 2 | **40** | Phase 6 |
| 27 | Icon-Variante für den A/B-Test | 100 | 2 | 0,5 | 3 | **33** | Phase 5 |
| 28 | Kaltstartkette entzerren | 100 | 1 | 0,5 | 2 | **25** | Phase 2 T-8 |
| 29 | Combo-Fenster in Zügen statt Sekunden | 100 | 1 | 0,5 | 3 | **17** | Phase 3 L-4 |
| 30 | ✅ `182c5d3` IAP-Fehlerlog entschärfen (`\$` entfernen) | 5 | 0,5 | 1,0 | 0,25 | **10** | Phase 2 T-6 |
| 31 | Bestenlisten-Metrik gegen den Seed-Zufall | 40 | 2 | 0,5 | 6 | **7** | Phase 3 L-3 |
| 32 | Zwei weitere freiwillige Rewarded-Platzierungen | 50 | 1 | 0,5 | 4 | **6** | Phase 4 M-5 |
| 33 | Barrierefreiheit in den Menüs | 10 | 1 | 1,0 | 2 | **5** | Phase 2 T-10 |
| 34 | Münzpakete durch Kosmetik ersetzen | 20 | 1 | 0,5 | 4 | **2** | Phase 4 M-4 |

**#30 sieht falsch platziert aus und ist es nicht.** Ein escapetes `${}` in
einer Log-Zeile ist in 15 Minuten behoben — aber es betrifft nur den
Entwickler, nicht die Spieler, und ohne Absturzbericht merkt es niemand. Es
gehört in den nächsten Durchlauf, nicht vor die Wiedereinreichung.

**#31 ist der inhaltlich interessanteste Punkt des Blocks.** Die Bestenliste
ist der einzige soziale Haken, und ihre Platzierung hängt zu 5/6 vom Seed ab
(Phase 3 L-3, in `BALANCE.md` nachgemessen). Der Punkt landet trotzdem in P2,
weil er 6 Stunden kostet und eine Produktentscheidung voraussetzt (Punkte pro
Zug oder Wochen-Median), die niemand unter Zeitdruck treffen sollte.

---

## Bewusst nicht tun

| Nicht tun | Begründung |
|---|---|
| **Interstitials oder Banner einführen** | `CLAUDE.md` setzt das als nicht verhandelbar. Und es ist der einzige Bereich, in dem Qubble strukturell unter dem Policy-Risiko der Kategorie liegt (Phase 7 A-3) — bei einem Konto mit Enforcement-Vorgeschichte ist das mehr wert als der Umsatz. |
| **Revive gegen Werbung anbieten** | Ebenfalls `CLAUDE.md`. Zusätzlich ist es genau das Muster, das die Beschreibung ausschließt („Kein ‚schau ein Video, um weiterzuspielen'"). Es einzuführen würde die Beschreibung falsch machen — ein Metadaten-Risiko obendrauf. |
| **Ein weiteres Analytics- oder Mediation-SDK** | Jedes SDK vergrößert die Data-Safety-Fläche. Bei einem Konto mit Vorgeschichte ist das das falsche Risiko für den Nutzen (Phase 6, Abschnitt 9). Firebase reicht für alles, was dieses Audit messen will. |
| **Ein fünfzehntes Meta-System** | Qubble hat vierzehn Systeme um eine 84-Sekunden-Kernrunde. Der Marktführer der Kategorie hat keinen Shop und keine sozialen Funktionen und ist der meistgeladene Mobile-Titel der Welt (Phase 1c). Feature-Breite ist in diesem Genre kein Wachstumshebel. |
| **Weitere Store-Sprachen** | `docs/STORE-LISTING.md` schlägt Spanisch, Portugiesisch und weitere vor. Solange die App nur EN/DE spricht und `AchievementsScreen` selbst im Englischen deutsch ist (Phase 2 T-3), erzeugt eine dritte Store-Sprache Erwartungen, die das Produkt nicht einlöst. |
| **`setUserId` oder Verknüpfung Bestenliste ↔ Analytics** | Die Datenschutzerklärung verspricht ausdrücklich, dass der Bestenlistenname nicht als Analytics-Parameter gesendet wird. Das einzuhalten kostet nichts und zu brechen wäre eine Falschaussage in einem veröffentlichten Rechtstext. |
| **Landschaftsmodus** | Die App ist bewusst auf Hochformat verriegelt, mit dokumentierter Begründung (`main.dart:36-39`): Im Querformat fiel die Booster-Leiste weg. Ein echtes Landschafts-Layout ist eigene Arbeit ohne belegbaren Nutzen. |
| **Auf iOS ausweichen** | `ad_config.dart:30` und `firebase_config.dart:18` sind Platzhalter — iOS liefe ohne Werbeumsatz und ohne Crash-Reporting (Phase 4 M-6). Der Aufwand für eine zweite Plattform ist erheblich und löst das Android-Zulassungsproblem nicht. |
| **A/B-Tests auf Signifikanz warten lassen** | Play-Listing-Experimente brauchen Traffic. Bei realistischen Installationszahlen (Phase 1c) liefert ein Test nach 14 Tagen oft kein Signal. Dann nach Augenmaß entscheiden und weitergehen — nicht auf Signifikanz warten, die nicht kommt. |

---

## Abhängigkeitsgraph, verkürzt

```
#2 CI-Build ──┬── #5 Data Safety
              └── #8 R8-Regeln

#9 Löschweg ───── #10 UGC-Melden

#6 Rätsel-Analytics ── #12 offered/accepted ── (Opt-in-Rate messbar)

#16 FTUE-Ereignisse ── (macht #11 bewertbar)

#18 Overflows ───── #22 Schriftskalierung
```

Alles andere ist unabhängig und kann in beliebiger Reihenfolge laufen.
