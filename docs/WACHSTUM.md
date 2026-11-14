# Wachstum: der Weg Richtung Top 100

Stand 13.11.2026 · ersetzt die Fassung vom 23.09.
(`docs/archiv/WACHSTUM-2026-09.md`: was damals für die Sprachen gemacht wurde).

Auftrag (09./10.11.): „Ich will, dass die App irgendwann in den Top 100
auftaucht. Wir machen alles, was dahin führt. Du sollst am besten alles
automatisiert machen können." Grundregel wie immer: **Richtlinien vor allem
anderen** — das Konto war einmal gesperrt, ein zweiter Vorfall beendet das
Projekt (`HANDOVER.md`).

Deine Schritte stehen nicht hier, sondern in `ANLEITUNG.md`. Hier steht der
Plan: was wirkt, in welcher Reihenfolge, woran man es misst.

---

## 0 · Kurzfassung

- **Niemand kann einen Platz in den Top 100 zusagen.** Ein Platz in einer
  Rangliste ist die Folge von Installationen pro Tag in einem Land, und die
  sind die Folge von: gefunden werden × überzeugen × bleiben. An allen dreien
  ist im November gebaut worden; ob es wirkt, sagen erst Zahlen, die nur du
  siehst (§5).
- **Der Plan hat vier Stufen mit Toren.** Durch ein Tor geht es erst, wenn
  die Zahl dahinter stimmt — vor allem: **kein Geld für Werbung, bevor
  belegt ist, dass ein Spieler mehr einbringt, als er kostet.**
- **Automatisch läuft jetzt:** Store-Texte und -Bilder hochladen, eine
  Version als Entwurf in die Console legen, Bewertungen der Woche abholen,
  alle Bilder und Videos neu erzeugen. Was nur du kannst, steht in §4.

---

## 1 · Wo wir stehen (13.11.2026)

Befunde: `audit/10-relaunch.md`. Was daraus geworden ist:

| Hebel | Vorher | Jetzt | Soll bewirken |
|---|---|---|---|
| Erste Minuten | zwei Dialoge und ein Menü vor dem ersten Block | Neulinge landen auf dem Brett; höchstens eine Frage pro Game Over | mehr Spieler, die überhaupt eine Runde beenden |
| Rundenlänge | Median 37 Züge, 13,7 % der Runden vor Zug 21 zu Ende | Median 65, früh zu Ende 2,3 % (`BALANCE.md` Nachtrag 6, Simulation) | D1-Bindung |
| Game Over | Text über dem abgedunkelten Brett | Ergebnis-Karte mit Bestwert-Vergleich | „noch eine Runde" |
| Unterscheidung | ein Block-Puzzle unter hunderten | **Qubbies**: Haustiere, die mitspielen; das erste gratis nach Runde 3 | Grund zu installieren, Grund zu bleiben, etwas zu sammeln |
| Store-Eintrag | Bilder vom September, 60 Sprachen von Hand | neu in 4 Sprachen, Qubbie im ersten Bild, im Titel „Offline" | Umwandlung Besucher → Installation |
| Video | eins, nie hochgeladen | dazu ein Schnellschnitt-Video mit 12 Looks | Promo-Video, Kurzvideos |
| Pflege des Eintrags | Handarbeit je Sprache | ein Workflow | der Eintrag veraltet nicht wieder |

**Was davon belegt ist:** die Simulation der Rundenlänge und alles, was Tests
prüfen. **Was nicht belegt ist:** jede Wirkung auf echte Spieler. Dafür gibt
es Stufe 1.

---

## 2 · Was „Top 100" heißt — und was wir darüber wissen

Play führt Ranglisten **je Land** und je Kategorie (Spiele gesamt, Puzzle),
getrennt nach „Top kostenlos" und Umsatz. „Top 100" ist also erst mit Land
und Liste eine Zahl. **Vorschlag: Top 100 „Puzzle, kostenlos" in einem Land**
als erstes Ziel — welches Land, entscheidet sich an den Zahlen aus Stufe 1.

| Frage | Stand |
|---|---|
| Wie viele Installationen pro Tag braucht Platz 100 in „Puzzle" in Land X? | **Nicht belegt.** Öffentlich fand sich nur eine Anbieter-Angabe für *alle Spiele* (das oberste Prozent liegt bei rund 900.000 Downloads in 30 Tagen, MWM, April 2026) — das ist weder Puzzle noch Platz 100. AppTweak führt Schätzungen je Land und Kategorie; die Werte selbst waren von hier nicht abrufbar. |
| Woher kommen Installationen? | 88 % der Spiele-Downloads bei Play aus Suche und Stöbern (Sensor Tower, über `audit/01-markt.md`) — der Store selbst ist der Kanal. |
| Was zählt für die Sichtbarkeit? | Übereinstimmend aus Branchenquellen, **nicht von Google bestätigt**: seit 2024 stärker das Verhalten nach der Installation (Bindung an Tag 1/7/30, Deinstallationen in den ersten 24 Stunden, Abstürze und ANRs), dazu Bewertungen (Zahl und Aktualität) und die Umwandlung auf der Store-Seite. |
| Was kostet eine gekaufte Installation? | Puzzle auf Android, AppsFlyer Q3 2026 laut Suchauszug: USA etwa 4,81 $, Deutschland 3,10 $, Großbritannien 3,45 $, **Brasilien 0,49 $, Indien 0,10 $**. Andere Quellen weichen stark ab; als Größenordnung lesen. |

**Die Rechnung, sobald die Zahlen da sind:**

```
Installationen/Tag = Besucher des Eintrags/Tag × Umwandlung
Wert eines Spielers (30 Tage) = Bonus-Videos je Spieler × Erlös je Video
                                + Käufe je Spieler
Werbung lohnt sich, wenn:  Wert eines Spielers ≥ Preis einer Installation
```

Alle drei Zeilen hängen an Zahlen aus Play Console, Firebase und AdMob.
Heute sind es rund zehn aktive Spieler; daraus lässt sich nichts hochrechnen.

---

## 3 · Der Plan in vier Stufen

### Stufe 0 · Ausliefern (diese Woche)

| Was | Wer |
|---|---|
| 1.6.0 veröffentlichen (Qubbies, faire Runden, neue erste Minuten) | du, `ANLEITUNG.md` Schritt 1 |
| Schlüssel für den automatischen Upload einrichten | du, Schritt 9 |
| Neuen Store-Eintrag veröffentlichen — **erst wenn 1.6.0 bei allen ist**, denn die Bilder zeigen Qubbies | Workflow, Schritt 10 |
| Videos auf YouTube; Schnellschnitt-Video als Promo-Video eintragen | du, Schritt 3 |
| Ausgangswerte festhalten (§5) — **vor** dem neuen Eintrag, sonst gibt es kein Vorher | du → ich |

### Stufe 1 · Messen und nachbessern (Wochen 1–4)

Ziel: wissen, ob Spieler bleiben und ob der Eintrag überzeugt.

| Zahl | Tor | Wenn verfehlt |
|---|---|---|
| D1-Bindung | ≥ 30 % (gut: 40 %) | erste Runde und Fairness weiter verbessern — nicht mehr Werbung, nicht mehr Systeme |
| D7-Bindung | ≥ 10 % (gut: 15 %) | Gründe zum Wiederkommen: Daily, Qubbie-Wachstum, Quests |
| Anteil neuer Spieler mit geschlüpftem Qubbie nach 5 Runden | ≥ 70 % (`pet_hatched`) | Ei früher anbieten oder schneller schlüpfen lassen |
| Umwandlung Besucher → Installation | höher als vor dem neuen Eintrag | Store-Experiment: Symbol mit Qubbie, dann Bild 1 |
| Bewertungen | Schnitt ≥ 4,3; jede beantwortet | die genannten Gründe beheben |
| Abstürze, ANRs | unter Googles Schwellen in Android Vitals | zuerst beheben, vor allem anderen |

Die Tore für die Bindung sind die aus `MASTERPLAN.md` („KPI-Ziele"). Mit
wenigen Spielern sind es Richtungen, keine Beweise — bei zehn Installationen
am Tag braucht eine belastbare D7-Zahl Wochen.

Was ich in dieser Stufe auf Zuruf mache: jede Zahl, die du schickst,
auswerten; Bewertungen der Woche lesen (Workflow) und Antworten vorschlagen;
Änderungen bauen, testen, ausliefern.

### Stufe 2 · Reichweite ohne Geld (Monate 2–3)

Erst wenn Stufe 1 hält — sonst füllt man ein Sieb.

| Hebel | Was | Stand |
|---|---|---|
| **Kurzvideos** | Jede Woche ein Clip. `tool/generate_showreel.dart` rendert auf Knopfdruck neue Schnittfolgen (andere Looks, andere Qubbies); vier Clips liegen schon da | Werkzeug fertig; Posten bist du (ein eigener Upload per Programm bräuchte Zugänge zu YouTube/TikTok/Instagram — erst sinnvoll, wenn es sich zeigt, dass Videos Installationen bringen) |
| **Play-Karte „großes Update"** mit Featuring-Antrag | „Die Qubbies sind da" — 28 Tage, frühestens 60, für Featuring mindestens 14 Tage vor Start einreichen (`docs/HAUSTIERE.md` §9, Belege §14) | Bilder und Texte baue ich, sobald du ein Startdatum nennst |
| **Play Games Level Up** | Googles Programm für Spiele mit Play Games Services: laut Suchauszug Sichtbarkeit im „You"-Tab und Play-Points-Aktionen; verlangt unter anderem das PGS-v2-SDK, mindestens 10 Erfolge, Cloud-Speicherstand und einen Einstieg für „Sidekick"; Anmeldung seit 01.09.2026 über die Console. **Termine und Bedingungen widersprechen sich zwischen den Quellen** — vor Arbeit daran die Seite in der Console lesen | App ist für Play Games vorbereitet (`ANLEITUNG.md` Schritt 2); Cloud-Speicherstand fehlt und wäre das größte Stück |
| **Haustiere ausbauen** (Phase 8.3) | Laune, Futter, Tagesgeschenk: ein Grund, jeden Tag kurz reinzuschauen | wartet auf deine Entscheidungen (`MASTERPLAN.md` Phase 8) und auf die Zahl „bleiben Spieler mit Qubbie länger?" |
| **Store-Experimente** | Symbol mit Qubbie gegen heute; Titel mit und ohne „Offline"; Bild 1 | Varianten liegen bereit; ein Experiment braucht Besucher, sonst läuft es Wochen ohne Ergebnis |
| **Bewertungen** | Die Karte fragt nach neuem Bestwert und nach gelösten Rätseln; ein dritter Moment (Qubbie geschlüpft) wäre möglich | erst die Annahmequote der Karte ansehen |
| **Eigene Store-Einträge** je Land oder Kampagne | bis zu 50; erst mit Kampagnen sinnvoll | Stufe 3 |

### Stufe 3 · Bezahlte Installationen (ab dem Tor)

**Tor:** Der Wert eines Spielers über 30 Tage ist in einem Land belegt und
liegt über dem Preis einer Installation dort (§2). Vorher: nichts ausgeben.

- Beginnen, wo eine Installation wenig kostet und eine Rangliste weniger
  Installationen verlangt — nach den Zahlen oben eher Brasilien als die USA.
  Portugiesisch (Brasilien) und Spanisch sind deshalb zwei der vier Sprachen,
  die von Hand gepflegt werden.
- Klein anfangen (ein Tagesbudget, das nicht wehtut), eine Woche messen:
  Preis je Installation, D1/D7 dieser Spieler, Erlös je Spieler.
- Ein Ranglistenplatz, der gekauft ist, hält nur, solange die Spieler bleiben
  und weitere von selbst kommen. Darum steht diese Stufe am Ende.
- Über Werbung wird nie etwas versprochen, was die App nicht hält, und
  **nie** werden Installationen oder Bewertungen gegen Belohnung gekauft —
  das ist bei Play verboten und wäre der zweite Vorfall.

---

## 4 · Was automatisch läuft, was auf Zuruf, was nur du kannst

| | Was | Wie |
|---|---|---|
| **automatisch** | Tests und Analyse bei jedem Push | `ci.yaml` |
| | Web-Version nach jedem Merge | `deploy-web.yaml` |
| | Bewertungen der letzten Woche (ohne Namen) ins Protokoll | `play-store.yaml`, montags — sobald der Schlüssel da ist |
| **ein Klick** | Store-Texte und -Bilder prüfen oder veröffentlichen | Workflow „Play Store", `check-listing` / `publish-listing` |
| | Signiertes Bundle bauen | Workflow „Build Android Release" |
| | Version als Entwurf in die Console legen | Workflow „Play Store", `draft-release` |
| **auf Zuruf, ich** | Screenshots, Feature-Grafik, Symbol-Varianten neu | `tool/generate_screenshots.dart` → `caption_screenshots.py` → `feature_graphic.py` |
| | Neue Videos | `tool/generate_showreel.dart`, `tool/generate_video.dart` → `encode_video.py` |
| | Texte in den vier Sprachen, „Was ist neu" | `store-assets/listing/`, `docs/release-notes/` (Tests prüfen Längen, Zahlen, Behauptungen) |
| | Jeden Bildschirm ansehen, bevor er rausgeht | `tool/review_screens.dart` |
| **nur du** | In der Console auf „Einführen" drücken, Prozente erhöhen | bewusst kein Automat: der Knopf bleibt bei einem Menschen |
| | Übrige Store-Sprachen übersetzen lassen | die Übersetzung der Console |
| | Videos posten, Promo-Video-Link eintragen | |
| | Zahlen schicken (§5) | Screenshot oder CSV-Export genügt |
| | Geld ausgeben, Experimente starten, Featuring beantragen | deine Entscheidungen |

**Noch nicht automatisch, aber möglich** (jeweils: was es von dir bräuchte):

- **Kennzahlen ins Repo** — Installationen und Besucher liegen bei Play als
  Berichte in einem Cloud-Speicher, Bindung in Firebase (über einen
  BigQuery-Export). Beides ließe sich wöchentlich abholen; dafür müsstest du
  den Export einschalten und dem Schlüssel aus Schritt 9 Leserechte geben.
  Ob das den Aufwand lohnt, zeigt sich, wenn es mehr als zehn Spieler sind.
- **Videos selbst hochladen** — braucht Zugänge zu den Plattformen.

---

## 5 · Zahlen, die ich brauche

Einmal jetzt (als Ausgangswert), dann alle zwei Wochen. Ein Screenshot der
jeweiligen Seite genügt.

| Zahl | Woher |
|---|---|
| Besucher des Store-Eintrags und Installationen je Tag, je Land | Play Console |
| Umwandlung Besucher → Installation | Play Console |
| Bindung an Tag 1, 7, 30 | Play Console oder Firebase |
| Deinstallationen | Play Console |
| Bewertungen: Zahl, Schnitt | Play Console (die Texte holt der Workflow) |
| Abstürze, ANRs | Android Vitals |
| `round_complete`, `onboarding_step`, `pet_egg`, `pet_hatched`, `rewarded_*` je Tag | Firebase (nur Spieler, die Statistiken erlaubt haben) |
| Impressionen und Erlös je Land, je Anzeigenblock | AdMob |

---

## 6 · Was wir nicht tun

- Keine Zwischenwerbung, keine Banner, kein „Video, um weiterzuspielen" —
  nicht verhandelbar (`CLAUDE.md`), und im Store das Versprechen in Bild 8.
- Keine Belohnung für Bewertungen oder Einladungen, keine gekauften
  Bewertungen oder Installationen aus Belohnungs-Netzwerken.
- Kein Wort im Titel, das Leistung, Preis oder Rang behauptet („beste",
  „gratis", „Nr. 1"); ein Test hält das in jeder der vier Sprachen fest.
- Keine fremden Spieltitel in Texten oder Bildern.
- Nichts im Store zeigen, was die ausgelieferte App nicht kann — darum der
  neue Eintrag erst, wenn 1.6.0 bei allen ist.
- Nicht nach Kinder-App aussehen: Die App richtet sich nicht an Kinder; ein
  Eintrag, der so wirkt, kann von Google den Familien-Regeln unterstellt
  werden (`docs/HAUSTIERE.md` §8.1). Das Brett bleibt in jedem Spielbild das
  Größte, die Texte bleiben sachlich. **Das Risiko liegt bei den neuen
  Bildern höher als vorher** — sieh sie dir an, bevor sie live gehen.
- Kein Zufall gegen Geld (Lootboxen, Zufalls-Eier).

---

## 7 · Quellen

Googles Hilfeseiten sind aus dieser Umgebung gesperrt; was von dort stammt,
ist ein Suchauszug und so gekennzeichnet. Zahlen aus Anbieter-Blogs sind
Größenordnungen, keine Messungen.

- [88 % of Google Play Game Downloads Come From Search and Browse](https://sensortower.com/blog/google-play-download-sources) (Sensor Tower, über `audit/01-markt.md`)
- [Top Free — Rankings & Market Intelligence](https://mwm.ai/glossary/top-free) (MWM, April 2026; Suchauszug)
- [How Many Downloads Does Your App Need to Reach Top Rankings?](https://www.apptweak.com/en/aso-blog/number-of-downloads-to-reach-top-rankings) (AppTweak; nur die Methode war abrufbar)
- [Gaming app market benchmarks for Q3 2026](https://www.appsflyer.com/?p=549948) (AppsFlyer; Suchauszug)
- [Mobile game CPI benchmarks 2026](https://blog.playio.co/mobile-game-cpi-benchmarks-2026) (Playio; Suchauszug)
- [Google Play ranking factors](https://www.apptweak.com/en/aso-blog/google-play-ranking-factors) und [App Store Ranking Factors](https://appradar.com/academy/app-store-ranking-factors) (Branchenquellen, nicht Google)
- [Google Play Games Level Up](https://play.google.com/console/about/levelup/) und [Richtlinien](https://developer.android.com/games/guidelines) (Suchauszug, 13.11.2026)
- [Metadata – Play Console Help](https://support.google.com/googleplay/android-developer/answer/9898842) und [Preview assets](https://support.google.com/googleplay/android-developer/answer/9866151) (Suchauszug)
- Google Play Developer API: Beschreibung der Schnittstelle, Revision 20261026, wie sie `google-api-python-client` 2.202.0 mitliefert (direkt gelesen)
