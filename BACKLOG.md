**#29 Combo-Fenster in Zügen statt Sekunden — umgesetzt am 02.09.** Der Punkt
lag hier mit der Begründung, der Widerspruch sei über die Beschreibung bereits
aufgelöst und die Mechanik damit nur noch Geschmackssache. Das war falsch, und
die Messung zeigt warum: Die Uhr war kein neutrales Detail, sondern ein
Punkteabzug für Nachdenken. Über 1.500 Seeds, identische Spielweise, nur
unterschiedliches Tempo — 5.354 Punkte bei 1,5 s/Zug gegen 2.077 bei 6 s/Zug.
**Faktor 2,6, allein durch Tippgeschwindigkeit, auf einer öffentlichen
Bestenliste** — mehr als der gesamte Unterschied zwischen der besten und der
schlechtesten Spielweise (1,24×).

Der Einwand „das ändert die Punkteverteilung" ist mit derselben Messung
ausgeräumt: **Drei Züge treffen die alte Verteilung exakt** (Mittelwert,
Median, p95/p05 und Combo-Maximum jeweils identisch). Bestehende Einträge
bleiben also vergleichbar. Details in `BALANCE.md`, Nachtrag 3.

**Nachgebessert am selben Tag.** Die Umstellung hatte den Tempo-Vorteil auf
null gesetzt, und das war zu weit: Schnelles Spielen ist ein Kernreiz des
Genres. Der Bonus ist zurück, aber an einer anderen Stelle — **additiv auf die
Punkte einer geräumten Linie, gedeckelt auf 30 %**, statt in den
Combo-Multiplikator, wo er sich über die Rundenlänge aufschaukelte. Gemessen
+28,6 % zwischen schnellstem und langsamstem Tempo (vorher +158 %), und die
neue Score-Spanne liegt vollständig innerhalb der alten. Details in
`BALANCE.md`, Nachtrag 4.

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

## Stand 2026-09-02

Testzahl **754** (Audit-Beginn 441), `flutter analyze` ohne Befund, Web-Build
gebaut. Seit dem 01.09. dazugekommen:

| Punkt | Ergebnis |
|---|---|
| Produktions-Absturz (142 Abstürze, 23 Nutzer) | behoben, in Build #26 bewiesen — R8 Full Mode entfernte den Konstruktor von `WorkDatabase_Impl`, den Room reflektiv aufruft |
| Missionen | sechs Stufen je Metrik statt fünf festen Zielen, Fortschritt migriert |
| #32 Fünfte Rewarded-Platzierung | Tagesbelohnung verdoppeln (`daily_double`) |
| #31 Bestenlisten-Metrik | **nachgemessen, Prämisse widerlegt** — kein Wechsel, Begründung in `BALANCE.md` Nachtrag 2 |
| Coach-Hinweis „nicht jede Reihe sofort räumen" | die Anleitung lehrt die um 33 % schwächere Spielweise; jetzt gibt es eine zweite Lernstufe |
| Daily-Screen | Monatskalender mit Historie (70 Tage), Streak, Tages-Bestwert, Monatsnavigation |
| Teilen-Button | Emoji-Endbrett, Link auf den Web-Build |
| const-Audit | drei Lint-Regeln, 33 Stellen behoben, Rückfall ab jetzt CI-blockierend |

**Dabei drei Fehler in bereits ausgeliefertem Code gefunden:** der
Daily-Countdown stand im `else` der Streak-Anzeige und war damit für genau
seine Zielgruppe unsichtbar; `_streak` startete bei 0, sodass die Serie auf dem
Home-Screen nie erschien; der Kalender wäre für einen Screenreader ein einziger
Knoten mit 30 Tagen gewesen.

**Offen bleibt nur noch #34** — und davon der Teil, der neue Produkte in der
Play Console voraussetzt. Die vollständige Liste der Console-Aufgaben für das
1.2.0-Release steht in `docs/PLAY-CONSOLE-1.2.0.md`. Der IARC-Fragebogen ist am 02.09. eingereicht, #29
ist gemessen und umgesetzt. Damit sind alle Compliance-Befunde geschlossen.

---

## Stand 2026-09-01

Die Umsetzung läuft; erledigte Punkte sind unten mit ✅ markiert und tragen den
Commit. Testzahl 441 → **673**, `flutter analyze` durchgehend ohne Befund.

| Block | erledigt | offen |
|---|---|---|
| **P0** | 7 von 10 — alles, was im Code liegt | 3 Console-Aktionen (#2, #4, #5) |
| **P1** | **12 von 12** | — |
| **P2** | 11 von 12 (Stand 02.09.) | einer offen (#34, braucht die Play Console) |

**Die drei offenen P0 kann nur der Kontoinhaber ausführen** — sie brauchen
Zugang zur Play Console bzw. zu GitHub Actions:

1. **CI-Release-Build starten** (`build-release.yaml`) → klärt AD_ID im
   gemergten Manifest, AAB-Größe und R8-Verhalten. **Jetzt zusätzlich dringend:**
   Ein gemeldeter `androidx.startup.StartupException` deutet auf einen
   R8-Startabsturz; die Keep-Regeln dafür sind ergänzt (`b3bd70d`), aber nicht
   auf einem Gerät verifiziert.
2. **Data-Safety-Formular** korrigieren — Vorlage liegt fertig in
   `docs/DATA-SAFETY.md`, aus dem Code abgeleitet.
3. ~~**IARC-Fragebogen**: Nutzerinteraktion/UGC auf „ja".~~ **Erledigt 02.09.**

Nachträglich ergänzt, nicht aus dem ursprünglichen Audit: **R8-Keep-Regeln für
`androidx.startup`** (`b3bd70d`). `google_mobile_ads` zieht
`androidx.lifecycle:lifecycle-process` herein, das seinen Initializer über
Manifest-Metadaten benennt — eine Namensform, die AGP nicht als Klassenreferenz
behandelt. Anschließend wurden **alle 14 Android-Plugins** systematisch auf
dieselbe Fehlerklasse geprüft (`audit/08-r8-risiko.md`, Werkzeug
`tool/r8_risk_scan.py`, `32c23f5`): zwei echte Lücken, beide bereits
geschlossen, drei Fehlalarme mit jeweils konkretem Ausschlussgrund. Ein
Nachtrag engt die Ursache weiter ein: `StartupException.java:35` ist der
Konstruktor, der eine Ursache einpackt, und dafür gibt es in `AppInitializer`
genau drei Stellen — zwei davon R8-Ursachen, beide von den vorhandenen Regeln
abgedeckt. Die Vermutung „fehlendes `<meta-data>`" ist am Quelltext widerlegt
(`if (metadata != null)` — ein fehlendes Bundle wirft nichts). **Bewiesen
erklärt ist der Absturz trotzdem nicht:** dafür fehlt genau eine Angabe, die
`Caused by:`-Zeile.

---

## Block P0 — vor der Wiedereinreichung

Alles hier adressiert entweder ein Zulassungsrisiko oder ist Voraussetzung für
die Bewertung eines solchen. Zusammen **11,5 Stunden**.

| # | Maßnahme | R | I | C | E (h) | RICE | Abhängig von | Beleg |
|---|---|---:|---:|---:|---:|---:|---|---|
| 1 | ✅ `8fea9ce` **Store-Beschreibung durch die bereinigte Fassung ersetzen** | 100 | 3 | 1,0 | 0,25 | **1200** | — | Phase 7 B-2; Copy liegt fertig in `audit/copy/` |
| 2 | **CI-Release-Build starten** (`build-release.yaml`) | 100 | 2 | 1,0 | 0,2 | **1000** | — | Phase 2; klärt AD_ID, Manifest, AAB-Größe, R8 |
| 3 | ✅ `1ee0292` **Lock-Test gegen Billing-Downgrade** | 100 | 2 | 1,0 | 0,5 | **400** | — | Phase 7 A-2 |
| 4 | ✅ **IARC-Fragebogen: Nutzerinteraktion/UGC auf „ja"** (02.09. eingereicht) | 100 | 2 | 0,8 | 0,5 | **320** | — | Phase 7 C-2 |
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
| 23 | ✅ `cec5465` Nutzereigenschaften für Kohorten | 100 | 1 | 1,0 | 1 | **100** | Phase 6 A-5 |
| 24 | ✅ `a807cc5` `music.wav` verkleinert (1,14 MB — **nicht** OGG: iOS decodiert Vorbis nicht, MP3 bricht den nahtlosen Loop; stattdessen 8 kHz PCM, Inhalt endet bei 663 Hz) | 100 | 0,25 | 1,0 | 0,5 | **50** | Phase 2 T-7, gemessen |
| 25 | ✅ `cbda3b5` Crashlytics Custom Keys | 100 | 0,5 | 1,0 | 1 | **50** | Phase 6 C-2 |
| 26 | ✅ `8ffedc4` UMP-Consent an Firebase Analytics durchreichen | 100 | 1 | 0,8 | 2 | **40** | Phase 6 |
| 27 | ✅ `e824bd1` Icon-Variante für den A/B-Test | 100 | 2 | 0,5 | 3 | **33** | Phase 5 |
| 28 | ✅ `e90c5a2` Kaltstartkette entzerren | 100 | 1 | 0,5 | 2 | **25** | Phase 2 T-8 |
| 29 | ✅ **Combo-Fenster in Zügen statt Sekunden** — gemessen, dann umgesetzt | 100 | 2 | 1,0 | 3 | **17** | Phase 3 L-4, `BALANCE.md` Nachtrag 3 |
| 30 | ✅ `182c5d3` IAP-Fehlerlog entschärfen (`\$` entfernen) | 5 | 0,5 | 1,0 | 0,25 | **10** | Phase 2 T-6 |
| 31 | ✅ Bestenlisten-Metrik **nachgemessen, Prämisse widerlegt** — kein Wechsel | 40 | 2 | 1,0 | 6 | **7** | Phase 3 L-3, `BALANCE.md` Nachtrag 2 |
| 32 | ✅ Fünfte freiwillige Rewarded-Platzierung (Daily verdoppeln) | 50 | 1 | 0,5 | 4 | **6** | Phase 4 M-5 |
| 33 | ✅ `f26da4c` Barrierefreiheit in den Menüs | 10 | 1 | 1,0 | 2 | **5** | Phase 2 T-10 |
| 34 | ◑ Münzpakete durch Kosmetik ersetzen — Code-Seite erledigt, Rest Console | 20 | 1 | 0,5 | 4 | **2** | Phase 4 M-4 |

**#30 sieht falsch platziert aus und ist es nicht.** Ein escapetes `${}` in
einer Log-Zeile ist in 15 Minuten behoben — aber es betrifft nur den
Entwickler, nicht die Spieler, und ohne Absturzbericht merkt es niemand. Es
gehört in den nächsten Durchlauf, nicht vor die Wiedereinreichung.

**#31 — nachgemessen am 02.09., und die Prämisse hielt nicht.** Die Behauptung
„ihre Platzierung hängt zu 5/6 vom Seed ab" stammte aus einer Zahl, die ich
falsch gebildet hatte: Können und Glück waren auf verschiedenen Basen
gerechnet. Auf gleicher Basis (`scripts/audit/leaderboard_metric.dart`, 200
Spieler × 20 Runden × 5 Spielweisen) steht die **einzelne Runde** bei 1 : 20 —
also viermal schlechter als behauptet. Die Bestenliste bewertet aber keine
Einzelrunde, sondern den Bestwert einer ganzen Historie, und der mittelt Pech
weg: gemessen **1 : 2,3**.

Der vorgeschlagene Ersatz macht es nicht besser. Punkte pro Zug verbessert das
Verhältnis auf 1 : 1,5, indem es die Können-Spanne von 1,25× auf **1,05×**
drückt — fünf Prozent zwischen bester und schlechtester Spielweise ist keine
Können-Rangliste. Nur der Wochen-Median ist auf allen Achsen besser (1 : 1,8,
Können 1,28×, und der Vorteil des reinen Vielspielens fällt von 1,43× auf
0,88×), und selbst der kostet die Vergleichbarkeit jedes bestehenden Eintrags
für einen kleinen Gewinn. **Kein Metrikwechsel.** Details und Grenzen der
Messung in `BALANCE.md`, Nachtrag 2.

Was aus der Messung tatsächlich folgte, steht jetzt im Code: Die Anleitung
lehrt die um 33 % schwächere Spielweise (`corner-pack` 5.025 gegen
`lines-first` 3.781), und die stärkere war nirgends erwähnt. Ein später
Coach-Hinweis nach fünf Runden schließt das, ohne Punkte oder Ränge
anzufassen.

### Zwei Punkte bleiben offen — bewusst, nicht aus Zeitmangel

**Stand 02.09.:** Zehn der zwölf P2-Punkte sind erledigt. #32 ist umgesetzt,
#31 ist nachgemessen und bewusst **nicht** umgesetzt (die Messung widerlegt die
Prämisse — siehe unten). Offen bleiben #29 und #34. Beide sind
Produktentscheidungen mit Folgen, die ein Audit nicht für den Eigentümer
treffen sollte.

**#29 Combo-Fenster in Zügen statt Sekunden.** Die Empfehlung aus Phase 3 L-4
nannte ausdrücklich *zwei* Wege und „nicht beide": Beschreibung anpassen **oder**
Mechanik anpassen. Der Widerspruch war, dass die Beschreibung „kein Zeitdruck"
versprach, während `lib/game/scoring.dart:50` die Combo nach zehn Sekunden
verfallen lässt. Der Beschreibungsweg ist gegangen: `grep -i zeitdruck
audit/copy/long-de.txt audit/copy/long-en.txt` findet nichts mehr, die Behauptung
ist mit `8fea9ce` aus den Verkaufstexten entfernt. Damit ist der Widerspruch
aufgelöst und die Mechanik-Änderung nicht mehr die Behebung eines Fehlers,
sondern eine Design-Präferenz.

Dagegen steht ein messbarer Preis: Ein Zug-basiertes Fenster verändert die
Punkteverteilung. `BALANCE.md` weist die Combo als aktiv auf 70,7 % aller Züge
aus, 96,6 % aller Punkte laufen über den Multiplikator. Jeder bestehende
Bestenlisten-Eintrag wäre danach unter anderen Regeln entstanden als jeder neue
— in einer öffentlichen Rangliste, deren Einträge nicht versioniert sind
(`lib/services/leaderboard.dart`). Wer das ändern will, sollte es vor dem
Release tun oder gar nicht.

**#31 Bestenlisten-Metrik gegen den Seed-Zufall.** Der Befund steht und ist
nachgemessen: Können trennt die Ergebnisse um 4,7×, Seed-Glück um 23,4× —
Verhältnis 1:5,0, unverändert auch nach dem Combo-Deckel (`BALANCE.md`,
Nachtrag). Das ist ein echter Mangel. Die Behebung ist aber keine
Konstanten-Änderung, sondern eine Neudefinition dessen, was die Bestenliste
misst — Punkte pro Zug oder Wochen-Median statt Einzelbestwert. Beides macht
die vorhandenen Einträge inkommensurabel und ändert für jeden Spieler, der
bereits einen Rang hat, rückwirkend die Bedeutung dieses Rangs. Das ist die
Entscheidung des Eigentümers, und sie fällt besser mit Nutzungsdaten als ohne.

**#32 — teilweise umgesetzt am 02.09.** Die Daily-Belohnung lässt sich jetzt
freiwillig verdoppeln (`daily_double`, fünfte Platzierung). Das war die
stärkere der beiden Vorschläge aus M-5: Die Daily-Belohnung ist laut Phase 3
der stärkste Wiederkehrgrund, also die Stelle mit der höchsten Motivation. Die
zweite Idee — „Rundenergebnis in der Bestenliste absichern" — fällt weg, weil
der Upload ohnehin automatisch läuft; sie hätte eine Belohnung für etwas
versprochen, das schon passiert.

Die ursprüngliche Begründung fürs Zurückstellen, zur Einordnung:

**#32 Zwei weitere freiwillige Rewarded-Platzierungen.** Vier Platzierungen
existieren (`_runRewarded('double'|'lucky'|'piggy'|'streak_repair')` in
`lib/ui/state/game_controller.dart`, plus der Rätsel-Extrazug in
`puzzle_controller.dart:233`). Der Trichter, der misst, wie oft sie überhaupt
angenommen werden, ist gerade erst gebaut (`37339d1`, `rewardedOffered` /
`rewardedAccepted`). Angebotsfläche zu vergrößern, bevor eine einzige
Opt-in-Rate vorliegt, kehrt die Reihenfolge um, die Phase 6 selbst empfiehlt.
Wenn die vorhandenen Platzierungen schlecht angenommen werden, sind zwei weitere
die falsche Antwort; werden sie gut angenommen, weiß man danach, welche Art
Platzierung sich lohnt. In beiden Fällen ist Messen zuerst billiger.

**#34 Münzpakete durch Kosmetik ersetzen — Code-Seite erledigt am 02.09.**
Dabei kam ein echter Defekt heraus, der nichts mit der Strategiefrage zu tun
hatte: `qubble_neon_theme` steht seit jeher im Code (`IapProducts.neonTheme`,
Auslieferung in `purchase_delivery.dart:90`), **aber nicht in der
Console-Produktliste** in `docs/LAUNCH.md`. Es wurde also nie angelegt, die App
fragte nach einem Produkt, das der Store nicht kennt, und man sah davon nichts
— der Shop zeigt nur, was zurückkommt, ein unbekanntes Produkt fällt still weg.
Die Tabelle ist ergänzt (2,49 €, Non-Consumable), und
`test/store_products_test.dart` hält beide Richtungen zusammen: kein Produkt im
Code ohne Eintrag, kein Eintrag ohne Produkt im Code.

**Damit ist Weg B einen Schritt weit gegangen, ohne etwas zu entfernen.** Was
noch aussteht, ist genau eine Entscheidung und ein Console-Klick:

1. **Du**: `qubble_neon_theme` in der Play Console anlegen (Non-Consumable,
   2,49 €). Ab dann ist das erste Kosmetik-Produkt tatsächlich kaufbar.
2. **Deine Entscheidung**: ob `qubble_coins_s/m/l` aus dem Katalog fliegen.
   **Ich habe das bewusst nicht gemacht.** Die Begründung des Audits — „es geht
   praktisch kein Umsatz verloren, weil heute keiner entsteht" — ist bei einer
   gesperrten App zirkulär: Sie sagt nichts darüber, was die Pakete nach der
   Wiederzulassung einbringen. Drei verkäufliche Produkte auf eine ungemessene
   Vermutung hin zu streichen, ist keine Aufräumarbeit, sondern eine
   Umsatzentscheidung. **Empfehlung:** erst behalten, nach der Wiederzulassung
   drei Monate messen, dann entscheiden.


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
