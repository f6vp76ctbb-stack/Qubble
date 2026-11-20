# Wachstum: der Weg Richtung Top 100

Stand 13.11.2026, Befund vom 20.11.2026 in §1a · ersetzt die Fassung vom 23.09.
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

## 1a · Befund 20.11.2026: Fast niemand findet Qubble

Auftrag (20.11.): „Die Nutzeranzahl wächst schon lange nicht mehr weiter …
Es müssen mehr Nutzer in die App, dringend." Alle Zahlen unten sind an diesem
Tag selbst abgerufen; nichts ist geschätzt.

| Quelle | Was sie zeigt |
|---|---|
| Öffentliche Play-Seite (`tool/play_listing_check.py`) | **10+ Downloads**, keine Bewertung. Kategorie **„Casual"**, **kein Tag**. Block Blast, Block Puzzle (zwei Titel) und Woodoku: Kategorie „Puzzle", dazu Tags wie „Block", „Single player", „Offline". **Jedes Store-Bild trägt das Label „AI"** (7 auf der englischen, 9 auf der deutschen Seite). Suche „block puzzle", „block puzzle offline", „block puzzle pet" (US), „blockpuzzle offline" (DE), „block puzzle" (BR): Qubble nicht unter den ersten 20 (mehr liefert die Web-Suche nicht); „qubble": Platz 1. |
| Bestenlisten in Firestore (`tool/player_activity.py`, nur Zählungen) | 7 Namen vergeben, **der letzte am 09.10.**; 11 Bestenlisten-Einträge, der letzte neue am 20.10.; Tages-Bestenliste insgesamt **3 Einträge** (03.10., 10.10., 16.11.). Untergrenze: Es zählt nur, wer einen Namen wählt und online ist. |
| Buffer, 21.10.–20.11. | Instagram: 36 Posts, **32.629 Aufrufe**, Reichweite 29.291, im Schnitt **5,0 s** geschaut, **0 neue Follower, 0 geteilt, 0 gespeichert**. YouTube: 29 Posts, 7.350 Aufrufe, 43 Likes, 2 Kommentare. X: 14 Posts, **3 Impressionen**, 0 Klicks. |
| Bericht vom 18.11. (`ANLEITUNG.md` Schritt 13) | rund 14.000 Aufrufe, **0 Store-Besuche** über die Social-Links. |
| AdMob, Play Console, Firebase Analytics | **nicht abrufbar**: kein Connector in dieser Umgebung, die AdMob-Schnittstelle verlangt die Anmeldung des Kontoinhabers. |

**Was daraus folgt:**

1. **Es fehlt oben im Trichter, nicht unten.** Mit zehn Spielern lässt sich
   Bindung nicht messen (Stufe 1 bleibt blind), und jede Verbesserung im Spiel
   erreicht niemanden. Zuerst müssen Menschen die Seite sehen.
2. **Falsche Schublade.** In „Casual" ohne Tags steht Qubble nicht dort, wo
   Block-Puzzle-Spieler stöbern, und Play hat weniger Hinweise, worum es geht.
   Google: „Categories and tags help users to search for and discover the most
   relevant apps in Google Play" (9859673). Dass der Wechsel Installationen
   bringt, ist nicht belegt; er kostet fünf Minuten. Wichtig auch für §2: Das
   Ziel „Top 100 Puzzle" setzt voraus, dass Qubble überhaupt in „Puzzle" steht.
3. **„AI" auf jedem Bild.** Google druckt das Label, weil die Bilder beim
   Hochladen als KI-Inhalt erklärt wurden: „Declared assets will be
   AI-labeled on the Google Play Store" (17262077). Die Bilder sind Aufnahmen
   der echten App. Ob das Label Besucher abschreckt, ist nicht belegt; die
   Erklärung ist Sache des Kontoinhabers (`ANLEITUNG.md` Schritt 12).
4. **Social bringt Aufrufe, keine Spieler.** Fünf Sekunden Sehdauer, niemand
   folgt, und in Reels und Shorts sind Links nicht klickbar. Am besten liefen
   **echte Spielszenen eines Looks mit Qubbie** (1.600–2.400 Aufrufe, 6–9 s
   Sehdauer) und „combo-chase" (5.702 Aufrufe, 7,2 s). Schnellschnitt-Reels
   (looks, pets, skins, clutch, turbo) blieben bei 140–670 Aufrufen und
   1,6–3,9 s. Karussells und Bilder: fast null. X hat keine Reichweite.
5. **Play Games Level Up ist nicht erreichbar.** Google (18018581):
   „Currently, enrollment is open to developer account groups that have
   generated at least $1M (USD) of earnings over the last 12 months", dazu
   sechs Monate in der Produktion. Aus Stufe 2 gestrichen.
6. **Neu: Play Shorts.** Google (18611720) beschreibt einen 9:16-Video-Feed
   auf Play, „starting with Apps Home"; Upload in der Console unter „Store
   presence → Play Shorts"; 10–60 s, mindestens 720p, Englisch zum Start,
   keine Logos von Social-Plattformen, keine Ranglisten-Behauptungen, nicht
   mehr als drei Blitze pro Sekunde. Ob Spiele schon teilnehmen können, sagt
   die Seite nicht (ihre Beispiele sind Apps).
7. **Events (Promotional content)** gibt es für alle Spiele. Sie erscheinen
   im eigenen Store-Eintrag, in Suchergebnissen, im Spiele-Tab und im
   Events-Tab (unter anderem Deutschland, Brasilien, Großbritannien, USA);
   Zielgruppe wahlweise „Potential users", also Leute, die die App nie
   installiert haben (12929029, 12932541). Featuring: 4 Anträge pro Quartal
   für Spiele, Einreichung mindestens 14 Tage vor Start, ohne Garantie; laut
   Google nur für Titel, die die Bedingungen für „Premium growth tools"
   erfüllen. Diese Bedingungen stehen auf keiner der gelesenen Seiten.

**Reihenfolge, solange es weniger als hundert Spieler sind** (die Stufen
unten gelten weiter, aber Stufe 1 kann ohne Spieler nichts messen):

| # | Was | Wer | Kosten |
|---|---|---|---|
| 1 | Kategorie „Puzzle", fünf Tags, KI-Label prüfen | Kontoinhaber, 10 Minuten (`ANLEITUNG.md` 14) | keine |
| 2 | Link in Instagram-Bio und auf der YouTube-Kanalseite | Kontoinhaber (`ANLEITUNG.md` 13) | keine |
| 3 | Event-Karte „Qubbies" (großes Update, 28 Tage) mit Featuring-Antrag, Zielgruppe „Potential users" | Bilder und Texte ich, einreichen der Kontoinhaber | keine |
| 4 | Play Shorts: Menüpunkt prüfen; wenn da, ein 20–30-s-Video | prüfen Kontoinhaber, rendern ich | keine |
| 5 | Social: mehr echte Spielszenen mit Qubbie, weniger Schnellschnitt | ich, im Redaktionsplan | keine |
| 6 | Kleiner bezahlter Test (ein Land, ein Tagesbudget, eine Woche) | Entscheidung Kontoinhaber | Budget |
| 7 | Zahlen aus der Console (`ANLEITUNG.md` 14, Punkt 6) | Kontoinhaber → ich | keine |

Zu 6: Das Tor aus Stufe 3 (erst zahlen, wenn ein Spieler mehr einbringt, als
er kostet) bleibt die Empfehlung. Bezahlte Installationen sind aber das
Einzige, was sicher Spieler bringt; die Preise in §2 sind
Branchenschätzungen, keine Angebote.

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
| 1.7.0 veröffentlichen (baut auf 1.6.0 auf: Qubbies, faire Runden; neu: Drehen ohne Knopf, neues Design) | du, `ANLEITUNG.md` Schritt 1 |
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
| **Play-Karte „großes Update"** mit Featuring-Antrag | „Die Qubbies sind da" — 28 Tage, frühestens 60, für Featuring mindestens 14 Tage vor Start einreichen (`docs/HAUSTIERE.md` §9; am 20.11. auf Googles Seiten nachgelesen, §1a Punkt 7) | **vorgezogen** (§1a, Reihenfolge Nr. 3); Bilder und Texte baue ich, sobald ein Startdatum feststeht |
| **Play Shorts** | Hochkant-Videos in einem Feed auf Play (§1a Punkt 6) | prüfen, ob Spiele teilnehmen können (`ANLEITUNG.md` 14) |
| ~~**Play Games Level Up**~~ | **Nicht erreichbar** (§1a, Punkt 5): Google lässt derzeit nur Konten zu, die in den letzten 12 Monaten mindestens 1 Mio. USD verdient haben, nach sechs Monaten in der Produktion (18018581, gelesen 20.11.2026) | gestrichen |
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
- Nicht nach Kinder-App aussehen: Die App richtet sich nicht an Kinder.
  Wirkt der Eintrag trotzdem so („youthful animation or young characters in
  the graphic assets"), „Google Play may reject your app"; dann bleibt nur,
  die Bilder zu ändern oder die Zielgruppe auf Kinder zu stellen — mit den
  Familien-Regeln und dem Ende des heutigen Werbemodells
  (`docs/HAUSTIERE.md` §8.1; Wortlaut von Googles Seite, gelesen
  14.11.2026). Das Brett bleibt in jedem Spielbild das Größte, die Texte
  bleiben sachlich. **Das Risiko liegt bei den neuen Bildern höher als
  vorher** — sieh sie dir an, bevor sie live gehen.
- Googles Vorgaben für Texte und Bilder stehen mit Wortlaut und Stand in
  `docs/STORE-LISTING.md` („Was Google verlangt"); die Tests prüfen sie bei
  jedem Lauf.
- Kein Zufall gegen Geld (Lootboxen, Zufalls-Eier).

---

## 7 · Quellen

Googles Hilfe-Seiten (`support.google.com`) sind seit 14.11.2026 aus dieser
Umgebung lesbar; was unten „direkt gelesen" heißt, ist der Wortlaut der
Seite an diesem Tag. Alles andere von Google (die Seiten unter
`play.google.com` und `developer.android.com`) ist weiterhin ein Suchauszug
und so gekennzeichnet. Zahlen aus Anbieter-Blogs sind Größenordnungen, keine
Messungen.

- [88 % of Google Play Game Downloads Come From Search and Browse](https://sensortower.com/blog/google-play-download-sources) (Sensor Tower, über `audit/01-markt.md`)
- [Top Free — Rankings & Market Intelligence](https://mwm.ai/glossary/top-free) (MWM, April 2026; Suchauszug)
- [How Many Downloads Does Your App Need to Reach Top Rankings?](https://www.apptweak.com/en/aso-blog/number-of-downloads-to-reach-top-rankings) (AppTweak; nur die Methode war abrufbar)
- [Gaming app market benchmarks for Q3 2026](https://www.appsflyer.com/?p=549948) (AppsFlyer; Suchauszug)
- [Mobile game CPI benchmarks 2026](https://blog.playio.co/mobile-game-cpi-benchmarks-2026) (Playio; Suchauszug)
- [Google Play ranking factors](https://www.apptweak.com/en/aso-blog/google-play-ranking-factors) und [App Store Ranking Factors](https://appradar.com/academy/app-store-ranking-factors) (Branchenquellen, nicht Google)
- [Google Play Games Level Up](https://play.google.com/console/about/levelup/) und [Richtlinien](https://developer.android.com/games/guidelines) (Suchauszug, 13.11.2026)
- [Metadata – Play Console Help](https://support.google.com/googleplay/android-developer/answer/9898842), [Add preview assets to showcase your app](https://support.google.com/googleplay/android-developer/answer/9866151), [Translate and localize your app](https://support.google.com/googleplay/android-developer/answer/9844778), [Target audience and app content](https://support.google.com/googleplay/android-developer/answer/9285070) (direkt gelesen, 14.11.2026; ausgewertet in `docs/STORE-LISTING.md`)
- Direkt gelesen am 20.11.2026 (`support.google.com`, englische Fassung):
  [Choose a category and tags](https://support.google.com/googleplay/android-developer/answer/9859673),
  [Declaring AI-generated content in Play Console](https://support.google.com/googleplay/android-developer/answer/17262077),
  [Create promotional content](https://support.google.com/googleplay/android-developer/answer/12932541),
  [Understand promotional content](https://support.google.com/googleplay/android-developer/answer/12929029),
  [Evaluate your promotional content performance](https://support.google.com/googleplay/android-developer/answer/12932124),
  [Getting Started with Google Play Shorts](https://support.google.com/googleplay/android-developer/answer/18611720),
  [Enroll in the … revamped Level Up program](https://support.google.com/googleplay/android-developer/answer/18018581),
  [Understand and grow your app's user base](https://support.google.com/googleplay/android-developer/answer/9859173),
  [Grow overview](https://support.google.com/googleplay/android-developer/answer/16394358),
  [Get discovered on Google Play search](https://support.google.com/googleplay/android-developer/answer/4448378)
- Öffentliche Play-Seiten von Qubble, Block Blast (`com.block.juggle`),
  Block Puzzle (`blockpuzzle.new1010.jewelgames.puzzlegames`,
  `game.puzzle.blockpuzzle`) und Woodoku (`com.tripledot.woodoku`), abgerufen
  20.11.2026 (`tool/play_listing_check.py`)
- Google Play Developer API: Beschreibung der Schnittstelle, Revision 20261026, wie sie `google-api-python-client` 2.202.0 mitliefert (direkt gelesen)
