# Haustiere („Qubbies") — das Konzept

Stand 13.10.2026 · Auftrag des Nutzers vom 12./13.10.2026 · **Konzept, nichts
davon ist gebaut** (außer den Konzeptbildern in `docs/haustiere/`, erzeugt von
`tool/pet_concept.dart`). Die Entscheidungen, die vor dem Bau fallen müssen,
und die Bau-Reihenfolge stehen als Checkliste in `MASTERPLAN.md` Phase 8.
Dieses Dokument ist das Nachschlagewerk dazu: was, warum, mit welchen Zahlen
und Belegen.

Der Auftrag, wörtlich:

> Großes Ziel ist es, dass die Haustiere neue Nutzer locken. Außerdem soll es
> den Spielspaß erhöhen, und neue Möglichkeiten, dass Nutzer potentiell wieder
> Geld ausgeben können bzw. Werbung gucken. Und dass das Tier dann „mitspielt"
> und vielleicht rumfliegt, wenn man eine Reihe löst, und visuelle Effekte
> auslöst. Die Haustiere sollten auch recht teuer sein, teurer als Designs. Und
> das wird dann auch gut beworben, dass Nutzer schnell sehen, dass es
> Haustiere hier gibt. Also Store-Assets etc. Evtl. auch Event planen für den
> Release.

---

## 0 · Kurzfassung

![Die zehn Qubbies](haustiere/roster.png)

- **Zehn Qubbies** — Würfelwesen im Stil der Blöcke: drei Starter, fünf
  Premium, ein legendäres, ein Gründer-Qubbie nur zum Start.
- **Es spielt mit:** Das Qubbie sitzt auf der Brettkante, schaut deinem Stück
  nach, und wenn eine Reihe voll ist, **fliegt es die Reihe entlang und löst
  sie mit seinem Effekt auf** — der Drache mit Feuer, der Pinguin mit Frost,
  die Robo-Eule mit Laseraugen.
- **Teurer als Designs:** Ein Starter ist gratis, die übrigen kosten
  **300 / 600 / 900 / 1.500 💎** — das Zwei- bis Zehnfache des teuersten
  Designs heute (150 💎).
- **Neue Einnahmen:** zwei Kaufangebote (Qubbie-Starterangebot, Gründer-Paket
  nur zum Start), zwei freiwillige Videos (Snack, sofort schlüpfen), Futter als
  Gold-Senke.
- **Fair:** kein Qubbie gibt Punkte, Züge oder Hinweise; ein gekauftes Qubbie
  ist nie stärker als ein Starter; keine Zufalls-Eier.
- **Werbung:** neuer erster Screenshot, Feature-Grafik, Video und
  Kurzbeschreibung mit Qubbie; eine Karte im Play Store („Promotional content")
  mit Featuring-Anfrage; Event „Schlüpf-Wochen" zum Start.
- **Größtes Risiko:** Google lehnt Store-Grafik ab, die nach Kinder-App
  aussieht, obwohl die App nicht für Kinder ist (Beleg in §8.1). Deshalb gibt
  es Leitplanken für jede Grafik.

---

## 1 · Ziele und woran man sie misst

| Ziel (Nutzer) | Wie das Konzept es angeht | Woran man es misst |
|---|---|---|
| **Neue Nutzer locken** | Qubbie im ersten Screenshot, in Feature-Grafik, Video und Kurzbeschreibung; Play-Karte mit Featuring-Anfrage; Teilen-Karte mit Qubbie | Store-Umwandlung (Besucher → Installationen) vier Wochen vor/nach dem Start in der Play Console; Installationen über `utm_medium=pet_share` |
| **Mehr Spielspaß** | Qubbie fliegt bei jeder Reihe, reagiert auf Combo, Fieber, Bestwert, Game Over; wächst in drei Stufen; Sammeln | D1-/D7-Bindung vorher/nachher (Firebase), Runden pro Tag |
| **Geld ausgeben** | Premium-Qubbies für Diamanten, zwei neue Kaufangebote | Erstkäufe, Käufe pro Produkt (`purchase`-Ereignis), Diamant-Ausgaben (neues Ereignis, §10) |
| **Werbung schauen** | Snack-Video (1×/Tag), Sofort-Schlüpfen-Video (1× pro Ei) — beide freiwillig | `rewarded_*`-Trichter je Platzierung, Videos pro aktivem Nutzer |
| **Teurer als Designs** | Preisleiter ab 300 💎 (§5.3) | Test pinnt: jedes kaufbare Qubbie > teuerstes Design |
| **Schnell sichtbar** | Startseite zeigt das Qubbie; erstes Ei nach Runde 3; bestehende Spieler bekommen ihr Ei beim ersten Öffnen | Anteil neuer Spieler mit geschlüpftem Qubbie nach drei Runden (Ziel: ≥ 70 %) |

**Ehrlich zu den Zahlen:** Mit etwa zehn aktiven Spielern ist keine dieser
Messungen statistisch belastbar. Sie zeigen Richtungen, keine Beweise. Belege
dafür, dass Haustiere in Puzzlespielen Nutzer bringen, haben wir **nicht** —
die Marktrecherche dazu ist ausgefallen und wird hier nicht durch Vermutungen
ersetzt. Das Konzept ist eine Wette, und die Messung oben sagt, ob sie
aufgeht.

---

## 2 · Die Qubbies

Würfelkörper wie die Blöcke, große Augen, eine unverwechselbare Silhouette
pro Art (Ohren, Flügel, Horn), damit man sie auch klein auf dem Brett
erkennt. Alles wird im Code gezeichnet (`CustomPaint`), keine fremden
Grafiken — wie die Blöcke, die Effekte und der Gespenster-Skin heute
(`CLAUDE.md`: nur Eigenwerk/CC0). Die Konzeptbilder zeigen, dass das geht:
`tool/pet_concept.dart` hat alle zehn schon mit Pfaden gezeichnet, und der
Code lässt sich für die App übernehmen.

| # | Vorschlag Name | Art | Klasse | Preis | Signatur beim Reihe-Lösen |
|---|---|---|---|---|---|
| 1 | Kiki | Würfelkatze, mint | Starter | gratis (eine Wahl) / 300 💎 | dein Reihen-Effekt, mit Funkeln |
| 2 | Bit | Pixelhund, orange | Starter | gratis (eine Wahl) / 300 💎 | dein Reihen-Effekt, mit Pixeln |
| 3 | Glim | Schleimwürfel, limette | Starter | gratis (eine Wahl) / 300 💎 | dein Reihen-Effekt, mit Blasen |
| 4 | Frosti | Pinguin mit Schal | Premium | 600 💎 | **Frosthauch**: Reihe gefriert und zerspringt |
| 5 | Optik | Robo-Eule | Premium | 600 💎 | **Laserblick**: Laser aus den Augen schneidet die Reihe |
| 6 | Zapp | Donnervogel | Premium | 600 💎 | **Kettenblitz**: Blitz springt durch die Reihe |
| 7 | Funki | Mini-Drache | Premium (Aushängeschild) | 900 💎 | **Feuerwelle**: Drache speit Feuer, Reihe brennt ab |
| 8 | Prisma | Einhorn | Premium | 900 💎 | **Regenbogen**: Spur verwandelt die Blöcke in Sterne |
| 9 | Pyra | Phönix | Legendär | 1.500 💎 | **Phönixflamme**; beim Weiterspielen (Revive) ein Flammenkreis |
| 10 | Goldi | goldener Würfel mit Krone | Gründer | nur in den Schlüpf-Wochen (§9) | goldener Funkenregen |

Die Namen sind Vorschläge. Bewusst vermieden: „Pixel" (gibt es schon als Skin
und als Explosion). Sie bleiben in allen Sprachen gleich, stehen aber trotzdem
in jeder ARB-Datei (Regel in `CLAUDE.md`), damit eine Sprache bei Bedarf
abweichen kann.

---

## 3 · Im Spiel: das Qubbie spielt mit

![Der Flug über eine volle Reihe](haustiere/flight-filmstrip.png)

### 3.1 · Wo es sitzt

Auf der **oberen Brettkante, rechts** — im Streifen zwischen Kopfzeile und
Brett, halb über dem Rand. Es nimmt **keinen Platz im Layout** (die Spalte mit
Brett und Ablage ist auf 360×640 bei doppelter Schriftgröße ausgereizt,
`test/widget/compact_layout_test.dart`), sondern liegt als Ebene über dem
Brett, wie Explosion und Reihen-Effekt. Nie über der Ablage, nie über den
Booster-Knöpfen. Im kompakten Layout schwebt dort links der Tipp-Hinweis
(`game_screen.dart`), deshalb rechts.

### 3.2 · Worauf es reagiert

![Stimmungen](haustiere/moods-cat.png)

| Moment | Reaktion | Signal im Code (heute vorhanden) |
|---|---|---|
| Stück wird gezogen | schaut dem Stück nach | `dragPreviewProvider` |
| Stück abgelegt | kleines Nicken | `lastPlacementAt` |
| **Reihe gelöst** | **Flug über die Reihe mit Signatur-Effekt (§3.3)** | `clearEventId` ändert sich **und** `lastGained > 0` |
| Combo ab ×3 | Funkenspur beim Flug | `combo` |
| Combo läuft aus | nervöser Blick | `comboMovesLeft == 1` |
| Fieber | tanzt, leuchtet | `feverLevel` |
| Blitzblank (Brett leer) | Ehrenrunde ums Brett | `lastWasAllClear` |
| Brett fast voll | Schweißtropfen | `board` (wie `_hasNearlyFullLine`) |
| 20 s nichts passiert | schläft ein | `lastPlacementAt` |
| Game Over | sackt zusammen, dann „Nochmal!"-Hüpfer | `gameOver` |
| Neuer Bestwert | Jubel mit Funken | `isNewHighscore` |
| Bombe | **kein Flug** (Bombe räumt keine Reihe) | `lastGained == 0` beim Lösch-Ereignis |

Zwei Signale fehlen heute und kommen dazu: ein eigener Zähler für den
Fieber-Ausbruch (das Spiel kennt ihn nur intern) und — damit Bomben nicht als
Reihe zählen — die Prüfung `lastGained > 0` statt `lastClearedLineCount`, das
nach einer Bombe den alten Wert behält.

### 3.3 · Der Flug

1. Reihe voll → das Qubbie springt ab und fliegt zum Anfang der Reihe.
2. Es gleitet die Reihe entlang; **hinter ihm** löst sich die Reihe auf —
   der vorhandene Reihen-Effekt (`ClearSweep`) läuft dafür nicht mehr nach
   eigener Uhr, sondern folgt der Position des Qubbies.
3. Es kehrt mit einem kleinen Salto auf seinen Platz zurück.

**Dauer höchstens 600 ms** (der Reihen-Effekt dauert heute 560 ms). Bei
mehreren Reihen fliegt es die längste ab, die übrigen lösen sich gleichzeitig.
**Sobald der Spieler das nächste Stück greift, bricht der Flug ab** und das
Qubbie ist sofort zurück — es verdeckt nie die frisch geräumten Felder, auf die
man gerade zielt. Die Explosionen fliegen wie heute darüber.

### 3.4 · Signatur-Effekte, Reihen-Effekte, Explosionen

![Signatur-Effekte](haustiere/effects.png)

- **Starter** sprühen den **Reihen-Effekt, den der Spieler ausgerüstet hat**
  (Klassisch, Laser, Flammen, Frost, Blitz). Gekaufte Reihen-Effekte werden
  dadurch wertvoller, nicht überflüssig.
- **Premium-Qubbies** bringen ihren **eigenen Effekt** mit, den es einzeln nicht
  zu kaufen gibt. Ein Schalter im Nest wählt „Signatur" oder „mein
  Reihen-Effekt".
- **Explosionen** bleiben, wie sie sind, und liegen über allem.

### 3.5 · Daily und Rätsel

- **Daily:** Das Qubbie spielt mit (es ist reine Optik), aber keine Boni —
  die Daily bleibt für alle gleich, wie sie heute schon alle Booster sperrt.
- **Rätsel:** zunächst nicht. Der Rätsel-Modus hat keine Lösch-Ereignisse und
  keine Effekte (`puzzle_screen.dart`). Später: Jubel auf dem Sieg-Fenster.

### 3.6 · Reduzierte Effekte, Web, Leistung

- **Reduzierte Effekte:** kein Flug; das Qubbie bleibt sitzen, nur das Gesicht
  reagiert. Der Reihen-Effekt fällt wie heute auf „Klassisch" zurück.
- **Web:** läuft mit (alles gezeichnet), aber ohne Kauf (dort gibt es keine
  Käufe) und ohne Videos (die Web-Werbung zahlt ohne Video aus, deshalb ist
  jede Video-Belohnung im Web gesperrt — wie der Gratis-Bonus heute).
- **Leistung:** höchstens 30 Partikel für die Flugspur, innerhalb des
  bestehenden Deckels von etwa 220 pro Explosion; eine dauerhaft eingehängte
  Zeichenfläche mit eigener `RepaintBoundary` (sonst blitzt iOS-Safari weiß).

### 3.7 · Was ein Qubbie nie tut

- **nie zeigen, wohin ein Stück passt** — kein Schnüffeln, kein Blick auf ein
  passendes Feld, nichts;
- nie Punkte, Züge, Teile oder Drehungen geben;
- nie ein Video verlangen, um weiterzuspielen;
- nie die Bestenliste beeinflussen.

---

## 4 · Außerhalb des Spiels: Nest, Pflege, Wachstum

### 4.1 · Das Nest

Eigener Bildschirm, erreichbar über einen Knopf **„Qubbies"** auf der
Startseite (in der Reihe „Rangliste | Rätsel", die erst zwei Knöpfe hat) und
über das Qubbie selbst, das auf der Startseite neben „Spielen" sitzt. Im Nest:
das aktive Qubbie groß, Futter, Streicheln (antippen), Stufe und Fortschritt,
Brutkasten mit Eiern, alle Qubbies mit Preis und Vorschau. Der Knopf trägt das
wippende „!" (gibt es schon, `NoticeBadge`), wenn ein Ei schlüpfbereit ist,
ein Geschenk wartet oder das Qubbie hungrig ist.

### 4.2 · Laune und Futter

- Laune 0–100, sinkt langsam: von voll auf leer in etwa **drei Tagen**.
- **Futter kostet Gold:** Snack 100, Mahlzeit 300, Festmahl 800 (mit
  Extra-Erfahrung). Eine Mahlzeit am Tag hält ein Qubbie glücklich — das sind
  etwa 12 % des Golds, das ein aktiver Spieler am Tag verdient (rund 2.500,
  `BALANCE.md`-Zahlen, Rechnung im Wirtschafts-Abschnitt). Das ist die
  Gold-Senke, die seit dem 12.10. fehlt (`BALANCE.md` Nachtrag 5).
- **Keine Strafe:** Ein vernachlässigtes Qubbie wird schläfrig, nie krank, es
  läuft nicht weg und stirbt nicht. Es spielt weiter mit, nur verschlafener.
  Das ist Absicht: Ein Energie-System ist im Plan ausdrücklich ausgeschlossen
  („killt die entspannt-Positionierung").

### 4.3 · Boni — nur Wirtschaft, nie Spielstärke

Ein glückliches Qubbie (Laune ≥ 60)

- bringt **beim ersten Öffnen des Tages ein Geschenk**, nach festem
  Wochenplan, damit nichts zufällig ist (z. B. Mo 150 Gold · Di 3 💎 · Mi
  150 Gold · Do Snack · Fr 3 💎 · Sa 300 Gold · So 5 💎); das Geschenk lässt
  sich einmal am Tag per Video verdoppeln;
- **sammelt doppelte Erfahrung** (wächst schneller).

**Alle Qubbies geben genau dieselben Boni.** Ein Premium-Qubbie kauft Aussehen
und Effekt, nie Stärke. Es gibt bewusst **keinen Bonus im Spiel** (keine
Extra-Münzen pro Reihe): Gold kauft Booster, die Endlos-Runden verlängern, und
der Münz-Korridor der Wirtschaftstests würde wandern
(`test/game/economy_corridor_test.dart`). Die im alten Entwurf vorgesehene
„Serien-Schutz"-Idee entfällt, weil sie der Serien-Reparatur (Video oder
150 Gold) die Grundlage nimmt.

### 4.4 · Wachsen in drei Stufen

![Drei Stufen](haustiere/evolution-dragon.png)

- 1 Erfahrung pro geräumter Reihe, solange das Qubbie aktiv ist (glücklich:
  doppelt), Festmahl +50.
- **Stufe 2 ab 300**, **Stufe 3 ab 1.500** Erfahrung — bei etwa 15 Reihen pro
  Runde: Stufe 2 nach 10–20 Runden, Stufe 3 nach 50–100.
- Jede Stufe: größer, mehr Details, ein neuer Trick (Salto, Winken, Tanz); auf
  Stufe 3 wird der Signatur-Effekt größer.
- Die Entwicklung ist ein eigener Moment mit Teilen-Knopf (§8.6).

### 4.5 · Erinnerung

Höchstens einmal am Tag und nie als zusätzliche Meldung: Die bestehende
19:00-Erinnerung bekommt eine Textvariante („Funki hat Hunger"), nur wenn die
Laune niedrig ist — so wie heute an Truhen-Tagen der Truhen-Text erscheint.

---

## 5 · Bekommen: Eier, Preise, Kauf

### 5.1 · Das erste Qubbie ist gratis — und kommt früh

- **Neue Spieler:** am Ende der **dritten Runde insgesamt** (nicht pro Start —
  `reach_round_3` zählt pro Start). Davor ist das Game Over schon voll
  (Runde 1: Namensfrage, Stufe 1 von „Runden"), danach kommt in Runde 5 das
  Starterpaket.
- Der Spieler **wählt** eins der drei Starter-Eier. Es schlüpft nach **10
  geräumten Reihen** — also in der nächsten Runde; das Ei sitzt dabei schon auf
  der Brettkante und bekommt Risse. Der Schlüpf-Moment kommt beim Game Over,
  nie mitten im Zug.
- **Bestehende Spieler** bekommen ihr Ei beim ersten Öffnen nach dem Update —
  über einen Banner auf der Startseite und das „!" am Qubbies-Knopf, nicht als
  zusätzliches Fenster (Start 2 und 3 sind schon von Erinnerungs- und
  Regel-Fenster belegt).

### 5.2 · Eier schlüpfen durch Spielen

Jedes Qubbie kommt als Ei — auch ein gekauftes. Gekaufte Eier schlüpfen nach
**15 Reihen** (etwa eine Runde). **Freiwillig:** ein Video lässt ein Ei sofort
schlüpfen (einmal pro Ei). Der Inhalt eines Eis steht immer drauf — es gibt
**keine Zufalls-Eier** (§5.6).

### 5.3 · Preisleiter

Heute kostet das teuerste Design 150 💎 (animierte Skins, Neon). Ein
aktiver Gratis-Spieler bekommt etwa **12 💎 am Tag ohne Videos, 30 mit den
Gratis-Videos** (Quests, Serien-Truhen, Gratis-Bonus; Rechnung aus den
Code-Zahlen, keine Messung).

| Klasse | Preis | × teuerstes Design | Gratis erspielt (ohne / mit Videos) | Über Diamantpakete |
|---|---|---|---|---|
| Starter (2. und 3.) | 300 💎 | 2× | 25 / 10 Tage | M-Paket 2,99 € |
| Premium | 600 💎 | 4× | 50 / 20 Tage | etwa 5–6 € |
| Premium (Drache, Einhorn) | 900 💎 | 6× | 75 / 30 Tage | L-Paket 7,99 € |
| Legendär (Phönix) | 1.500 💎 | 10× | 125 / 50 Tage | etwa 12–13 € |

Damit sind Qubbies **recht teuer**, aber für jeden erspielbar — das ist die
Linie, die das Spiel bei Diamanten seit dem 28.09. fährt.

### 5.4 · Gold-Tausch begrenzen (Empfehlung)

Der Tausch 100 Gold → 1 💎 hat **kein Tageslimit**. Ein fleißiger Spieler mit
allen Videos verdient seit dem 12.10. rund 5.600 Gold am Tag — umgetauscht gut
50 💎 zusätzlich. Dann kostet der Drache keine 30 Tage mehr, sondern etwa 10,
und die Diamantpakete verlieren ihren Sinn. **Empfehlung:** höchstens 50 💎
pro Tag eintauschbar. Das ist eine Änderung an der Wirtschaft und deshalb
deine Entscheidung (sie hängt mit der offenen Frage aus `BALANCE.md`
Nachtrag 5 zusammen).

### 5.5 · Kaufangebote (echtes Geld)

| Angebot | Inhalt | Preis | Typ | Wann |
|---|---|---|---|---|
| **Qubbie-Starterangebot** | 2. Starter-Qubbie + 300 💎 + 3 Festmahl | 1,99 € | einmalig | 48 h ab dem Schlüpfen des ersten Qubbies — echtes Fenster, kein Countdown-Trick (wie das Starterpaket); nicht gleichzeitig mit dem Starterpaket |
| **Gründer-Paket** | **Goldi** (danach nie wieder erhältlich) + 500 💎 + goldene Krone fürs Qubbie | 4,99 € | einmalig (nicht verbrauchbar) | nur in den Schlüpf-Wochen (§9) |
| optional: **Diamanten XL** | 2.500 💎 | 17,99 € | verbrauchbar | dauerhaft — nur wenn Käufe über das L-Paket hinaus gewünscht sind |

Goldi gibt es in den Schlüpf-Wochen zusätzlich für 1.200 💎 — wer gespart hat,
kommt auch ohne Geld dran. Nach dem Event ist Goldi dauerhaft weg; das muss
stimmen, wie beim Aurora-Theme des Unterstützer-Pakets.

Jedes neue Produkt braucht: den Eintrag in der Produkttabelle in
`ANLEITUNG.md` (ein Test prüft beide Richtungen), ein Symbol ohne Text
(`tool/product_icons.py`), einen **ausdrücklichen Zweig in der Auslieferung**
(`purchase_delivery.dart` — ohne ihn landet ein Kauf im Münz-Zweig und liefert
0), und das Anlegen in der Play Console durch dich. Die Formularfelder schreibe
ich erst, wenn du mir das Formular zeigst (`CLAUDE.md`).

### 5.6 · Keine Zufallsinhalte — und warum

- Google Play verlangt bei Zufallsgegenständen, die man mit einem Kauf
  bekommt, die **Wahrscheinlichkeiten vor dem Kauf** (Zahlungs-Richtlinie,
  Beleg §14). Ob Diamanten, die man auch kaufen kann, als „Kauf" zählen, sagt
  die Richtlinie nicht — sicher ist nur: ohne Zufall stellt sich die Frage nicht.
- Belgiens Glücksspielbehörde hat bezahlte Lootboxen 2018 als Glücksspiel
  eingestuft; die Niederlande sahen es 2022 anders. Es gibt keine einheitliche
  Regel.
- Südkorea schreibt die Anzeige von Wahrscheinlichkeiten vor.
- Werbevideos mit Zufallsbelohnung müssten bei AdMob die Chancen vorher nennen.

Deshalb: **Jedes Ei zeigt, was drin ist. Jedes Geschenk steht im Wochenplan.**
Der Plan schließt Lootboxen ohnehin aus (`MASTERPLAN.md`, „bewusst nicht").

### 5.7 · Im Shop

Neuer Abschnitt **„Qubbies"** direkt nach dem Gratis-Bonus. Jede Karte öffnet
— wie seit dem 12.10. jedes Design — eine **Vorschau mit Kaufknopf**, hier mit
dem fliegenden Qubbie und seinem Effekt über einer Probereihe. Achtung beim
Bau: Der Shop kennt heute nur Themes und Skins (`DesignKind`); ein dritter
Typ läuft durch zweiwertige Verzweigungen und wirft dort Fehler. Qubbies
bekommen deshalb einen eigenen Abschnitt, keinen dritten `DesignKind`.

---

## 6 · Werbevideos — freiwillig wie alles

| Video | Belohnung (vorher genannt) | Grenze | Neuer AdMob-Block |
|---|---|---|---|
| **Snack-Video** | eine Mahlzeit für das Qubbie | 1× am Tag | ja |
| **Sofort schlüpfen** | Ei schlüpft sofort | 1× pro Ei | ja |
| Geschenk verdoppeln | Tagesgeschenk doppelt | 1× am Tag | optional (dritter Block) |

- Jedes Video startet **nur nach einem Tippen** und zahlt immer, was es
  verspricht. AdMob verlangt genau das (Opt-in, Belohnung vorher nennen,
  Beleg §14) — das Format „Interstitial mit Prämie" bleibt verboten.
- Im Web gesperrt (dort zahlt die Test-Werbung ohne Video aus).
- Jedes Video bekommt eine eigene Platzierung mit festem Analytics-Namen; bis
  du den Block angelegt hast, lädt es über den gemeinsamen Block.
- **Vorsicht ungültige Zugriffe:** Mit wenigen Spielern bündeln sich mehr
  Video-Anfragen auf wenige Geräte; das Konto hat eine Sperre hinter sich.
  Vorher eigene Geräte als Testgeräte eintragen (`ANLEITUNG.md` Schritt 5).

---

## 7 · Wirtschaft im Gleichgewicht

| | pro Woche (aktiver Spieler) |
|---|---|
| Futter, um glücklich zu bleiben (eine Mahlzeit am Tag) | −2.100 Gold |
| Tagesgeschenke | +900 Gold, +11 💎, 1 Snack |
| Ergebnis | etwa −1.200 Gold, +11 💎 |

Futter ist damit eine echte Gold-Senke, das Geschenk der Grund, trotzdem zu
füttern. Nichts davon ändert Punkte, Booster-Preise, das Sparschwein, die
Gratis-Videos oder die Serien-Reparatur. Die Diamant-Rechnung (§5.3) bleibt
nur stimmig, wenn der Gold-Tausch begrenzt wird (§5.4).

---

## 8 · Werbung im Store: „schnell sehen, dass es Haustiere gibt"

### 8.1 · Leitplanken (vor jeder Grafik)

1. **Nur zeigen, was die App wirklich tut.** Store-Grafik und Video müssen
   die ausgelieferte App zeigen (Google: „Deceptive Behavior", Beleg §14). Die
   Bilder in `docs/haustiere/` sind deshalb nur Entwürfe; die echten Grafiken
   rendert die bestehende Pipeline aus der fertigen App, und erst wenn das
   Update bei allen angekommen ist, gehen sie in den Store.
2. **Nicht nach Kinder-App aussehen.** Google kann eine App ablehnen, die
   nicht für Kinder unter 13 gedacht ist, deren Store-Grafik aber so wirkt
   („youthful animation or young characters", Beleg §14). Qubble hat Google
   gesagt: „we do not target children". Kommt die Zielgruppe „Kinder" dazu,
   gelten die Familien-Richtlinien — unter anderem müssten Belohnungsvideos
   **nach 5 Sekunden schließbar** sein, das Ende des heutigen Werbemodells.
   Darum: das Brett bleibt im Bild das Wichtigste, das Qubbie ist ein
   Begleiter **mit Kraft** (Feuer, Laser, Blitz); keine Babysprache, kein
   „für Kinder", keine Kindergarten-Typografie; Texte im Ton des heutigen
   Eintrags.
3. **Keine Werbe-Wörter im Titel und Symbol:** kein „Neu", „#1", „Gratis",
   kein Preis (Metadaten-Richtlinie). Neuheit sagen Screenshot, Feature-Grafik
   und die Play-Karte.
4. Keine fremden Spieltitel, Behauptungen müssen stimmen — die Store-Tests
   (`store_claims_test`, `store_listing_test`) gelten auch hier; ein neuer Test
   prüft, dass der Eintrag die Qubbie-Namen so schreibt wie die App.

### 8.2 · Was neu gemacht wird

![Entwurf Screenshot 1](haustiere/store-screenshot-1-mockup.png)
![Entwurf Feature-Grafik](haustiere/feature-graphic-mockup.png)

| Asset | Was | Werkzeug | Sprachen | Wer lädt hoch |
|---|---|---|---|---|
| **Screenshot 1** (neu) | Qubbie fliegt über eine Reihe, mitten im Effekt — „Dein Haustier spielt mit." | `tool/generate_screenshots.dart` (Qubbie im Demo-Spielstand ausgerüstet) + `tool/caption_screenshots.py` | alle 57 Bildsprachen | du |
| **Screenshot „Sammeln"** (neu) | die Qubbies nebeneinander mit ihren Namen | Collage wie heute die Themes | alle | du |
| Screenshot-Reihe | es bleiben **sechs** (zwei Tests und das Export-Werkzeug zählen genau sechs): raus fällt die Theme-Collage, deren Überschrift „Acht Themes" ohnehin veraltet ist (es sind 11) | — | — | — |
| **Feature-Grafik** | Qubbies vor dem Brett, Zeile „Puzzle-Haustiere, die mitspielen." — die Grafik erscheint auch, wenn das Video nicht automatisch startet | `tool/feature_graphic.py` | alle | du |
| **Kurzbeschreibung** | Qubbies rein, z. B. EN „Block puzzle with pets that play along: clear lines, hatch your Qubbie." (≤ 80) | Text je Sprache | alle 60 Einträge | du |
| **Vollbeschreibung** | neuer Abschnitt ▸ QUBBIES, mit Preisweg und Gründer-Hinweis | Text je Sprache | alle | du |
| **Promo-Video** | 25 s: Ei schlüpft (erste 3 s), Drache brennt eine Reihe ab; ohne Ton verständlich, denn es startet stumm bis 30 s | `tool/generate_video.dart` (neuer Clip „pets") + `encode_video.py` | eins für alle | du (YouTube) |
| **Shorts/Reels/TikTok** | vier Clips mit verschiedenen Qubbies | wie oben | — | du |
| „Was ist neu" | Qubbies + Event, ≤ 500 Zeichen | `docs/release-notes/` | alle 57 | du |
| Symbol | Variante mit Qubbie — nur als Store-Experiment, nicht direkt | `tool/icon_variant.py` | — | du |

Titel bleibt „Qubble: Block Puzzle". Ob „& Pets" im Titel erlaubt und klug
ist, ist nicht belegt; die Kurzbeschreibung wird von Play durchsucht und trägt
das Stichwort auch.

### 8.3 · Store-Experimente und eigene Store-Einträge

- **Experimente** können Symbol, Feature-Grafik, Screenshots und
  Beschreibungen testen, mit höchstens zwei Varianten, in bis zu fünf Sprachen
  gleichzeitig (Beleg §14). Kandidat: Screenshot 1 mit Qubbie gegen heute.
  Bei wenig Besuchern kann ein Test lange ohne Ergebnis laufen — du hattest
  Experimente auf „später, bei mehr Besuchern" gestellt.
- **Eigene Store-Einträge** (bis zu 50) gibt es zielgerichtet für Google-Ads-
  App-Kampagnen; ein Qubbie-Eintrag wäre der Landeplatz, sobald eine Kampagne
  messbar ist (deine Entscheidung vom 02.10.).

### 8.4 · Teilen

Nach dem Schlüpfen und nach jeder Entwicklung: „Zeig dein Qubbie" — ein Bild
des Qubbies mit Link zum Play-Eintrag und eigenem Merkmal
`utm_medium=pet_share`. Heute teilt das Spiel nur Text; ein Bild zu teilen ist
neu.

---

## 9 · Release-Event „Schlüpf-Wochen"

![Entwurf Event-Bild](haustiere/event-card-1920x1080.png)

### 9.1 · Was Play bietet (belegt, §14)

- „Promotional content" ist **für alle Spiele** verfügbar. Typen: Angebote,
  zeitlich begrenzte Events, **große Updates** (darunter „neue Inhalte"; ein
  großes Update läuft fest **28 Tage**).
- Einreichen **frühestens 60 Tage** vor Start; die Prüfung dauert **bis zu
  vier Tage**; ein Event dauert **höchstens vier Wochen**.
- **Featuring** lässt sich in der Einreichung beantragen — dann **mindestens
  14 Tage vorher** einreichen; Spiele haben **4 Anträge pro Quartal**
  (breites Publikum), ohne Garantie. Eine Selbstbewerbung fürs Featuring gibt
  es sonst nicht.
- Bild: **1920×1080, JPG oder 24-bit-PNG, höchstens 1 MB, ohne jeden Text**
  (kein Logo, kein Slogan, kein Spielname), dazu ein quadratisches Bild
  (Größe nicht belegt; Halloween nutzte 1080×1080). Das Entwurfsbild hier hat
  1,35 MB und muss als JPG kommen.
- Text: Tagline **≤ 80 Zeichen** (für das „Spotlight"-Format 48), Beschreibung
  **≤ 500**; ein Video muss öffentlich auf YouTube und nicht monetarisiert sein.
- Nicht belegt: ob ein großes Update, ein Event und ein Angebot gleichzeitig
  laufen dürfen, und in welchen Ländern es den Events-Tab gibt.

**Vorschlag:** **eine** Karte vom Typ „großes Update / neue Inhalte" („Die
Qubbies sind da") **mit Featuring-Antrag**. Die Schlüpf-Wochen liegen in diesen
28 Tagen, eine zweite Karte braucht es nicht.

### 9.2 · Zeitplan

| Wann | Was | Wer |
|---|---|---|
| T − 60 bis T − 14 | Karte einreichen (Bilder, Texte in 60 Sprachen, Featuring-Antrag) | du |
| T − 10 | Update in die Produktion (Prüfdauer schwankt — Puffer) | du |
| bis T − 3 | Ausrollen auf 100 % | du |
| T − 7 | Teaser-Clip als Short/Reel | du |
| **T** | Event startet in der App (Datum im Build, wie Halloween im Oktober); Store-Grafik, Video, Texte umstellen | du |
| T + 28 | Ende: Goldi und Gründer-Paket verschwinden; Karte läuft aus | automatisch |
| T + 30 | Auswerten (§1) | beide |

Das Datum steht fest im Build, weil die App keine Fernsteuerung hat — das
Update muss also vor dem Start bei den Spielern sein. Wer das Datum am Handy
verstellt, sieht das Event früher; das ist harmlos.

### 9.3 · Was in der App passiert

- Jeder Spieler, auch ein bestehender, bekommt sein **Starter-Ei**.
- **Goldi** und das **Gründer-Paket** sind da (§5.5).
- **Wochenenden: doppelte Qubbie-Erfahrung** (wie das Münz-Wochenende).
- **−25 % auf das erste Premium-Qubbie**, einmal pro Spieler (wie das Angebot
  des Tages).
- Banner auf der Startseite, Shop-Abschnitt oben — wie Halloween.

Bewusst nicht: Event-Quests. Neue Einträge in den Quest-Töpfen würfeln die
laufenden Tages-, Wochen- und Monatsquests aller Spieler neu.

---

## 10 · Technik

**Spiellogik (pures Dart, Tests zuerst):** `lib/game/pet.dart` mit Katalog
(Art, Klasse, Preis, Verkaufsfenster, Exklusivität), Zustand (Besitz, aktives
Qubbie, Erfahrung je Qubbie, Laune mit Zeitstempel, Eier mit Restreihen,
Geschenk-Tag, Video-Tage) und reinen Regeln (Laune zu Zeitpunkt X, Füttern,
Erfahrung, Stufe, Brut, Geschenk nach Datum). Uhr wird hereingereicht.

**Speicher:** Besitz und aktives Qubbie gehören zu den Schlüsseln, die einen
Fortschritts-Reset überleben (`Storage.entitlementKeys`, wie gekaufte Designs);
Laune, Erfahrung und Eier sind Fortschritt. Die beiden Listen dürfen sich nicht
überschneiden (Test vorhanden).

**Zeichnen:** `lib/ui/widgets/pet_painter.dart` übernimmt die Wesen aus
`tool/pet_concept.dart`. Ein `PetOverlay` liegt im Brett-Stack als
`Positioned.fill` neben `ClearSweep`/`ClearBurst` — **nicht** als teilweise
überstehendes `Positioned`, sonst schneidet der Stack alle Effekte am Brettrand
ab (Flutter clippt erst, wenn ein positioniertes Kind übersteht). Die
Zeichenfläche darf über den Rand malen.

**Fallen, die die Recherche gefunden hat:**

| Falle | Gegenmittel |
|---|---|
| Bombe löst `clearEventId` aus, mit altem `lastClearedLineCount` | Flug nur bei `lastGained > 0` |
| Fieber-Ausbruch ist im Snapshot nicht sichtbar | eigener Zähler im `GameSnapshot` |
| Dauer-Animation lässt `pumpAndSettle`-Tests nie fertig werden (Smoke-, Game-Over-, Daily-Tests) | Leerlauf-Animation stoppt wie die Tempo-Leiste, wenn nichts passiert; in Tests abschaltbar |
| Neue `CosmeticKind` ohne Speicher-Schlüssel wirft zur Laufzeit | Schlüssel in `_cosmeticKey` + Reset-Liste |
| Neuer Produkt-Id ohne Auslieferungs-Zweig liefert 0 | eigener Zweig + Test |
| Web zahlt Videos ohne Video aus | `kIsWeb`-Sperre wie `watchFreeReward` |
| Shop kennt nur zwei Design-Typen | eigener Abschnitt statt `DesignKind.pet` |
| Weißes Aufblitzen auf iOS-Safari | eine dauerhaft eingehängte Zeichenfläche + `RepaintBoundary` |
| Store-Bilder werden aufs Brett ±6 % zugeschnitten | Sitzplatz nah an der Brettkante |

**Analytics (neu):** `pet_egg_received`, `pet_hatched`, `pet_fed`,
`pet_evolved`, `pet_gift_claimed`, `pet_share`, dazu endlich ein Ereignis für
Diamant-Ausgaben (heute misst nichts, wofür Diamanten ausgegeben werden) und
eine Nutzer-Eigenschaft „hat Qubbie". Nur Katalog-Ids, nie Namen.

**Was sich nicht ändert:** Firestore und Datensicherheit (keine neuen Daten
nach außen; Käufe sind schon deklariert). Erst ein Qubbie neben dem Namen in
der Bestenliste würde beides berühren (Regeln vor dem Merge veröffentlichen,
Formular prüfen) — deshalb nicht im ersten Wurf.

**Übersetzung:** etwa 60 neue Texte in allen 57 ARB-Dateien; Store- und
Event-Texte für 60 Store-Sprachen (ohne Russisch, wie bei Halloween).

---

## 11 · Reihenfolge

| Schritt | Inhalt |
|---|---|
| 8.1 | Logik + Speicher + Zeichnen; Qubbie sitzt, reagiert, **fliegt mit Effekt**; Startseite + einfaches Nest |
| 8.2 | Eier, erstes Gratis-Qubbie nach Runde 3, Schlüpf-Moment, Erfahrung und Stufen |
| 8.3 | Laune, Futter, Tagesgeschenk, Snack- und Schlüpf-Video, „!"-Hinweis, Erinnerungstext |
| 8.4 | Shop-Abschnitt mit Vorschau, Diamantpreise, Starterangebot und Gründer-Paket, Analytics |
| 8.5 | Store-Grafik, Video, Texte, „Was ist neu" in allen Sprachen; Event-Bilder und -Texte; Event-Logik |
| 8.6 | später: Saison-Qubbies (Fledermaus im Oktober, Schneemann im Dezember), Hüte fürs Qubbie, Bestenlisten-Abzeichen, Rätsel-Jubel, Qubbie-Geräusche |

Bewusst nicht: ein Qubbie-Pass (der Plan sagt „Season Pass erst ab stabiler
D30-Basis"), Zufalls-Eier, Qubbie-Energie.

---

## 12 · Risiken

| Risiko | Gegenmittel |
|---|---|
| Store-Grafik wirkt kindlich → Ablehnung oder Familien-Regeln | Leitplanken §8.1; Brett im Mittelpunkt; vor dem Hochladen gemeinsam prüfen |
| Grafik zeigt mehr als die App | nur aus der fertigen App rendern; erst nach 100 % Ausrollen hochladen |
| Qubbie stört beim Spielen | Flug ≤ 600 ms, bricht beim Greifen ab, nie über der Ablage; reduzierte Effekte |
| Bezahlvorteil | gleiche Boni für alle Qubbies, keine Boni im Spiel, keine in der Daily |
| Diamanten zu leicht (Gold-Tausch) | Tauschgrenze §5.4 |
| Mehr Videos auf wenigen Geräten → ungültige Zugriffe | Testgeräte eintragen; Grenzen pro Tag/Ei |
| Noch ein Meta-System (das Audit warnte davor) | ausdrücklich gewollt; Kern bleibt das Brett, das Qubbie spielt dort mit |
| Arbeit für dich (Store in 60 Sprachen, Produkte, Blöcke, Karte) | alles vorbereitet als Dateien und Werte in `ANLEITUNG.md`, wenn es soweit ist |
| Veröffentlichungen stauen sich (1.5.1 nicht hochgeladen, 1.6.0 wartet auf Play Games) | Reihenfolge entscheiden, bevor 8.1 beginnt |
| Keine Marktbelege | Konzept als Wette behandeln, Messung §1 |

---

## 13 · Offene Entscheidungen

Stehen als Checkliste in `MASTERPLAN.md` Phase 8 — vorher wird nichts gebaut.

---

## 14 · Quellen

Belegt aus Googles Hilfe-Seiten und Behörden-Seiten (13.10.2026). Hinweis: Die
Seiten selbst waren aus dieser Umgebung gesperrt; die Zitate stammen aus
Such-Auszügen dieser Seiten und sind dort so gekennzeichnet. Vor Formularen
gilt, was die Console tatsächlich anzeigt.

- Zahlungs-Richtlinie (Lootbox-Wahrscheinlichkeiten, Preise klar nennen):
  https://support.google.com/googleplay/android-developer/answer/9858738
- Belgische Glücksspielbehörde, Lootbox-Bericht 2018:
  https://www.gamingcommission.be/sites/default/files/2021-08/onderzoeksrapport-loot-boxen-Engels-publicatie.pdf
- Raad van State (Niederlande) 2022:
  https://www.raadvanstate.nl/@130206/dwangsom-onterecht-opgelegd-loot-boxes/
- Länderanforderungen (Korea, Wahrscheinlichkeiten):
  https://support.google.com/googleplay/android-developer/answer/6223646
- Metadaten-Richtlinie: https://support.google.com/googleplay/android-developer/answer/9898842
- Store-Grafik ohne Ranking/Preis: https://support.google.com/googleplay/android-developer/answer/13393723
- Deceptive Behavior: https://support.google.com/googleplay/android-developer/answer/17006354
- Kinder-Wirkung im Eintrag: https://support.google.com/googleplay/android-developer/answer/9285070
- Familien-Richtlinien (5-Sekunden-Regel): https://support.google.com/googleplay/android-developer/answer/9893335
- AdMob, Belohnungsvideos: https://support.google.com/admob/answer/7313578
- Promotional content: https://support.google.com/googleplay/android-developer/answer/12932541
  und https://support.google.com/googleplay/android-developer/answer/12929944
- Store-Experimente: https://support.google.com/googleplay/android-developer/answer/12053285
- Eigene Store-Einträge: https://support.google.com/googleplay/android-developer/answer/9867158
- Keine Selbstbewerbung fürs Featuring: https://support.google.com/googleplay/android-developer/answer/9042516
- Vorschau-Video: https://support.google.com/googleplay/android-developer/answer/9866151
- „Was ist neu" ≤ 500 Zeichen: https://support.google.com/googleplay/android-developer/answer/9859348
