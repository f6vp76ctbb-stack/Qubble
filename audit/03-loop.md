# 03 — Game-Loop und Retention

Aus dem Code und aus eigenen Messungen, nicht aus Annahmen. Wo `BALANCE.md`
bereits Simulationsdaten enthält, habe ich geprüft, ob sie den heutigen Code
noch beschreiben — zwei der dort gemeldeten Befunde sind inzwischen behoben,
zwei bestehen unverändert.

## Die Uhr: was tatsächlich passiert

### Sekunde 0–30 (allererster Start)

Belegter Ablauf:

1. `main()` läuft vier `await`s durch, dann `runApp` (`lib/main.dart:36-75`).
2. `AppBootstrap` rendert `HomeScreen` (`app_bootstrap.dart:221`).
3. Im `addPostFrameCallback` startet `_init()` (`:39`) und arbeitet
   **sequenziell** ab: IAP-Init → Housekeeping → `_showRulesOnFirstLaunch()`
   → Ads/Consent (`:85-96`).
4. `_showRulesOnFirstLaunch()` schiebt beim allerersten Start die
   `HowToPlayScreen` **über** den Startbildschirm und **wartet, bis der Spieler
   sie schließt** (`:115-123`).

Der erste Bildschirm nach dem Icon-Tap ist also für einen Sekundenbruchteil das
Hauptmenü und danach ein Regeltext. Der erste Block wird frühestens nach zwei
bewussten Entscheidungen gesetzt: Regeln schließen, „Spielen" tippen.

**Das ist der teuerste Moment im ganzen Spiel, und er ist mit Text belegt.**
Block Blast — der weltweit meistgeladene Titel derselben Kategorie (Phase 1c) —
hat kein Regelwerk und keinen Shop. Ein 8×8-Raster mit drei Blöcken darunter
erklärt sich in diesem Genre selbst; das beweist die Existenz von Dutzenden
Klonen, die alle ohne Tutorial auskommen.

Der Kommentar an der Stelle erklärt, warum es so gebaut wurde
(`app_bootstrap.dart:112-114`): die Regeln waren vorher nur hinter einem
Hilfe-Icon erreichbar. Das war ein echtes Problem — die Lösung schießt aber
über das Ziel hinaus, weil sie den Regeltext **vor** statt **neben** das Spiel
setzt.

Nebeneffekt derselben Sequenz: Weil `_init()` sequenziell awaitet, läuft
`adServiceProvider.initialize()` — und damit der **UMP-Consent-Flow** — erst,
nachdem der Spieler die Regeln geschlossen hat. Funktional richtig (Consent vor
erstem Ad-Request), aber es verzögert den Consent-Dialog an eine Stelle, an der
er noch überraschender wirkt.

Was gut gelöst ist: Der **Name wird nicht abgefragt**. Es gibt keinen
Namens-Gate beim ersten Start; der Dialog hängt an der Bestenliste
(`home_screen.dart:169-176`). Das passt zum Datenschutzversprechen „Ohne Name
spielst du komplett anonym weiter" und ist genau richtig.

Danach greift die In-Game-Einführung, und die ist sauber gebaut
(`game_controller.dart:886-899`), drei Stufen:

| Stufe | Bedingung zum Weiterrücken |
|---|---|
| 0 | irgendeine Platzierung |
| 1 | eine Linie geräumt **oder** eine Reihe fast voll (≥ 6 Zellen) |
| 2 | eine Linie tatsächlich geräumt |

Der Kommentar darüber dokumentiert, dass früher schlicht Platzierungen gezählt
wurden — der Spieler bekam „fülle eine Reihe" zu lesen, ohne je eine geräumt zu
haben. Die jetzige Fassung koppelt die Erklärung an den erlebten Effekt. Das
ist die richtige Konstruktion.

### Minute 1–3

`BALANCE.md` misst über simulierte Runden:

| Kennwert | Wert |
|---|---|
| Rundendauer p25 / **Median** / p75 / p95 | 57 s / **84 s** / 117 s / 183 s |
| Runden, die zwischen Zug 21 und 60 enden | **70,4 %** |
| Punkte aus Platzieren | 3,4 % |
| Punkte aus Clears (Linien-, Combo-, Fieber-Multiplikator) | **96,6 %** |

In drei Minuten spielt ein Spieler also rund **zwei Runden**. Zum Vergleich mit
dem Genre (Phase 1d): Median-Sessionlänge im Casual-Bereich liegt bei 5–6
Minuten. Eine Session besteht bei Qubble folglich aus drei bis vier Runden mit
je einem Game-Over dazwischen.

Das ist nicht per se falsch — es ist die Struktur des Genres. Es heißt aber,
dass **der Game-Over-Bildschirm der meistgesehene Bildschirm des Spiels ist**,
häufiger als jeder Menüpunkt. Was dort steht und was von dort erreichbar ist,
entscheidet über die Session-Länge mehr als jeder andere Screen.

### Session 2

- Beim **zweiten** App-Start erscheint der Opt-in-Dialog für Benachrichtigungen
  (`app_bootstrap.dart:163`, `if (opens == 2 && …)`). Bewusst nicht beim ersten
  — das ist richtig getimt.
- Ein laufendes Endlos-Spiel wird geparkt und wiederhergestellt
  (`activeRun.v1`, `storage.dart:59`).

### Tag 7

Wiederkehr-Mechanik, alles belegt:

| Haken | Auslöser | Fundstelle |
|---|---|---|
| Tägliche Erinnerung | 19:00 Uhr, entfällt wenn Daily schon gespielt | `notification_planner.dart:61, 92` |
| Streak-Warnung | 21:30 Uhr, **nur ab Streak ≥ 3** | `notification_planner.dart:62-64` |
| Comeback-Geschenk | nach 72 h Abwesenheit, 100 Münzen | `notification_planner.dart:65-66`, `app_bootstrap.dart:131-142` |
| Daily-Belohnung | 50 Münzen + 10 je Streak-Tag, gedeckelt bei +100 | `streak.dart:27-37` |
| Streak-Reparatur | einmalig, gegen Münzen | `game_controller.dart:1271` |

Die Kette ist vollständig und richtig konstruiert. Eine Lücke: Die
Streak-Warnung — der schärfste Verlust-Anreiz — greift **erst ab Streak 3**.
Genau die Spieler, die an Tag 2 oder 3 abspringen, bekommen sie nie. Das ist
verteidigbar (nicht nerven, bevor etwas auf dem Spiel steht), aber es
verschenkt den Moment, in dem die Gewohnheit entsteht.

---

## Wo Spieler abbrechen — belegt am Code

### L-1 · Der Regeltext vor dem ersten Block · **P1**

Siehe oben. Der Abbruch passiert vor der ersten Interaktion mit dem eigentlichen
Produkt.

**Änderung.** Regeln nicht mehr vorschieben. Stattdessen: direkt ins Spiel, die
vorhandene dreistufige Coach-Einführung trägt die Erklärung ohnehin
(`game_controller.dart:886-899`). Den `HowToPlayScreen` über das bestehende
Hilfe-Icon erreichbar lassen (`home_screen.dart:382-391`) und einmalig nach der
**ersten beendeten Runde** anbieten, wenn der Spieler weiß, wovon die Rede ist.

**Erwartete Wirkung.** Weniger Abbrüche zwischen Install und erster
Platzierung. **Messbar über** das Verhältnis `first_open` zu `game_start`
(Phase 6) — heute nicht messbar, weil es kein `first_open`-Ereignis gibt.

**Aufwand:** 1 h.

### L-2 · Der Rätsel-Modus ist ab Level 9 konstant, und die Sterne sind Dekoration · **P1**

Das ist der schwerwiegendste Loop-Befund, und ich habe ihn in dieser Session
neu nachgemessen — `BALANCE.md` hatte ihn gemeldet, er ist **nicht behoben**.

**Messung** (eigene Sonde über `PuzzleGenerator.generate`):

| Level-Block | Züge ø | Züge min–max | `minMoves == Teilezahl` |
|---|---:|---|---|
| 1–20 | 6,37 | 2–10 | 19/19 |
| 20–40 | 7,75 | 6–10 | 20/20 |
| 40–60 | 7,45 | 6–10 | 20/20 |
| 100–120 | 7,00 | 6–10 | 20/20 |
| 180–200 | 7,45 | 6–10 | 20/20 |
| **480–500** | **8,00** | **6–10** | 20/20 |

**Level 500 ist so schwer wie Level 20.** Die Ursache steht direkt im
Generator (`lib/game/puzzle.dart:314-316`):

```dart
final bandCount = (2 + level ~/ 3).clamp(2, 5);   // sättigt bei Level 9
final holesPerBand = level < 5 ? 1 : 2;           // sättigt bei Level 5
const maxPieces = 10;                             // deckelt alles
```

Ab Level 9 sind sämtliche Generator-Parameter identisch. Was sich noch ändert,
ist der Seed — also das Muster, nicht der Anspruch.

**Und die Sterne sind unerreichbar.** In **200 von 200** geprüften Levels gilt
`minMoves == Anzahl Teile`. Das Brett leert sich per Konstruktion erst, wenn
jedes Teil liegt. Also ist `moves` beim Sieg immer exakt `minMoves`, und
`PuzzleRules.stars` (`puzzle.dart:277-282`) gibt immer 3 zurück:

```
stars(moves: 7, minMoves: 7) = 3
stars(moves: 8, minMoves: 7) = 2   // dieser Zustand tritt nie ein
```

Ein Spieler kann nur gewinnen (3 Sterne) oder scheitern (keine). Die
Sternanzeige auf drei Bildschirmen zeigt eine Bewertung an, die keine ist. Der
Undo im Rätselmodus setzt `moves` korrekt zurück (`puzzle_controller.dart:203`),
kann das also auch nicht aufweichen.

**Warum das Retention kostet.** Der Rätselmodus ist der einzige Inhalt mit
*Fortschritt statt Zufall* — und damit strukturell der beste Grund, an Tag 7
wiederzukommen. Er liefert stattdessen: gleiche Schwierigkeit ab Level 9,
garantierte Bestnote, keine Meisterschaft. Ein Spieler, der Level 40 erreicht,
hat keinen Grund, Level 41 zu spielen.

**Änderung, zwei Teile:**

1. *Schwierigkeit.* Die Deckel öffnen: `maxPieces` mit dem Level wachsen lassen
   (z. B. `(8 + level ~/ 10).clamp(8, 16)`) und `holesPerBand` ab Level ~15 auf
   3 anheben. Beides sind Einzeiler und über `PuzzleSolver.solve` verifizierbar.
2. *Sterne.* Entweder ehrlich machen oder abschaffen. Ehrlich machen heißt: die
   Bewertung an etwas koppeln, das variieren kann — Züge über dem Optimum sind
   es nicht, aber **verbrauchte Undos** oder **Zeit** wären es. Abschaffen heißt:
   die Sternanzeige durch „gelöst / offen" ersetzen. Abschaffen ist die
   ehrlichere und billigere Variante.

**Erwartete Wirkung.** Der Rätselmodus wird von Dekoration zu einem
Fortschrittsgrund. **Messbar über** die Verteilung des höchsten erreichten
Levels je Spieler (Phase 6).

**Aufwand:** 3 h Schwierigkeit inkl. Solver-Test, 1 h Sterne.

### L-3 · In der Bestenliste schlägt Glück Können 5 : 1 · **P1**

`BALANCE.md` misst nach der Umsetzung von Combo-Deckel, Fieber-Abbau und
All-Clear-Bonus:

| Messwert | vorher | nachher |
|---|---|---|
| Runden ohne Fieber-Ausbruch | 46,7 % | **23,9 %** |
| Fieber-Ausbrüche pro Runde | 0,82 | **1,52** |
| Streuung σ/ø | 1,07 | **0,86** |
| p95/p05 Score | 31,6× | **23,4 ×** |
| **Können : Zufall** | **1 : 5,0** | **1 : 5,0** |

Die Balance-Analyse ist an dieser Stelle bemerkenswert ehrlich — sie hält fest,
dass die eigene Prognose falsch war: Der Deckel senkt die Streuung, skaliert
aber Können und Glück **gleichmäßig** herunter, weil beide über dieselbe Größe
wirken (die Rundenlänge). Das Verhältnis bleibt exakt 1 : 5.

**Warum das jetzt wichtiger ist als vor dem Playtest.** Qubble hat inzwischen
eine **öffentliche Bestenliste** (`lib/services/leaderboard.dart`). Eine
Rangliste, deren Platzierung zu 5/6 vom Seed abhängt, ist kein Wettbewerb,
sondern eine Lotterie — und sie ist der einzige soziale Haken des Spiels.

Der in `BALANCE.md` vorgeschlagene Hebel ist richtig und steht noch offen:
nicht das Score-Modell ändern, sondern **die Bestenlisten-Metrik**. Punkte pro
Zug oder ein Wochen-Median über mehrere Runden statt des Einzelbestwerts. Beides
mittelt den Seed heraus, ohne die Tiefe des Score-Modells anzutasten (die Tiefe
lebt gerade von der Linien-Staffelung 1 Linie ≈ 80 → 4 Linien ≈ 1 200 Punkte).

**Aufwand:** Punkte-pro-Zug ist billig (Feld existiert bereits im Session-State);
Wochen-Median braucht ein zweites Firestore-Feld und eine Regel-Anpassung.
4–8 h je nach Variante.

### L-4 · Das Werbeversprechen und das Punktemodell widersprechen sich · **P2**

`docs/STORE-LISTING.md`, Vollbeschreibung DE:

> „Kein Zeitdruck, kein Timer: Du bist erst raus, wenn kein Teil mehr passt."

Der Code (`lib/game/scoring.dart:50`):

```dart
this.comboWindow = const Duration(seconds: 10),
```

Die Combo läuft nach 10 Sekunden ohne Clear ab, und die UI zeigt den
Countdown dazu an (`game_screen.dart:704`, `game_controller.dart:1235`). Da
96,6 % aller Punkte aus Clears mit Combo-Multiplikator stammen und die Combo
auf 70,7 % aller Züge aktiv ist, ist **das Punktemodell durchgehend
zeitgetrieben**.

Die Runde hat keinen Timer — das stimmt. Aber wer entspannt spielt, wie die
Beschreibung einlädt, punktet systematisch schlechter als wer hetzt. Das Spiel
verspricht Ruhe und belohnt Tempo.

Das ist kein Policy-Verstoß (die wörtliche Aussage über den Timer trifft zu),
aber es ist ein Produktwiderspruch, der in Bewertungen landet.

**Änderung**, eine von zwei — nicht beide:

- *Beschreibung anpassen:* „Kein Timer" bleibt, „kein Zeitdruck" streichen, und
  die Combo als das verkaufen, was sie ist: ein Tempo-Bonus für die, die ihn
  wollen.
- *Mechanik anpassen:* Combo-Fenster nicht in Sekunden, sondern in **Zügen**
  messen (z. B. „hält 3 Züge ohne Clear"). Das erhält den Combo-Anreiz
  vollständig und entfernt die Uhr. Für ein Spiel, das mit Entspannung wirbt,
  ist das die stimmigere Variante.

**Aufwand:** Beschreibung 10 min. Mechanik 3 h inkl. Anpassung der Tests und
einer Nachmessung mit `scripts/audit/balance.dart`.

### L-5 · Der Meta-Layer ist breiter als der Kern trägt · **P2**

Qubble hat, alles im Code belegt: Daily Challenge mit Streak, Rätsel-Modus mit
Levelbaum, Missionen, Spieler-Level und XP, Erfolge, Statistiken, 8 Themes,
8 Block-Skins, Sparschwein, drei Booster, Bestenliste, Wochenend-Event,
Starter-Angebot, Unterstützer-Paket.

Das sind vierzehn Systeme um eine Kernrunde von **84 Sekunden** Median.

Zum Vergleich, belegt in Phase 1c: Block Blast hat **keinen Shop und keine
sozialen Funktionen** und ist der meistgeladene Mobile-Titel der Welt.

Ich empfehle **nicht**, Systeme zu streichen — sie sind gebaut, getestet und
kosten im Betrieb nichts. Der Befund ist ein anderer: **Feature-Breite ist in
diesem Genre kein Wachstumshebel.** Jede weitere Stunde in ein fünfzehntes
System ist eine Stunde, die nicht in L-1 bis L-3 fließt. Für die Priorisierung
in Phase 8 heißt das: keine neuen Meta-Systeme, bis der Kern-Loop und der
Rätsel-Fortschritt sitzen.

Zwei Systeme verdienen dabei eine Sonderbehandlung, weil sie **wenig kosten und
viel tragen**: der Rätselmodus (L-2, weil er der einzige echte Fortschritt ist)
und die Bestenliste (L-3, weil sie der einzige soziale Haken ist).

---

## Was gemessen wurde und in Ordnung ist

| Bereich | Befund | Beleg |
|---|---|---|
| Fehlstarts | **0** von 3 000 Seeds starten tot | `BALANCE.md` D.4 |
| Seeds, bei denen keine Heuristik 10 Züge schafft | 0,00 % | `BALANCE.md` D.4 |
| Rettungsregel im Generator | garantiert ein platzierbares Teil, wenn eines existiert | `generator.dart:43-48` |
| Früh-Phase-Bonus | erste 10 Züge, ×1,5 auf platzierbare Teile | `generator.dart:38, 52-56` |
| Fieber-Erlebbarkeit | 76,1 % der Runden sehen mindestens einen Ausbruch | `BALANCE.md` Nachtrag |
| Sparschwein | **behoben** — 2 Münzen/Linie, Kapazität 200 → erste Auszahlung nach ~7 Runden | `piggy_bank.dart:20-22` |
| Coach-Einführung | koppelt Erklärung an erlebten Effekt | `game_controller.dart:886-899` |
| Namensabfrage | kein Gate beim ersten Start, rein optional | `home_screen.dart:169` |
| Laufendes Spiel überlebt Daily und App-Wechsel | ja, `activeRun.v1` + Lifecycle-Observer | `storage.dart:59`, `app_bootstrap.dart:52-63` |

---

## Priorisierte Kurzliste

| # | Befund | Schwere | Aufwand | Messbar über |
|---|---|---|---|---|
| L-1 | Regeltext vor dem ersten Block | P1 | 1 h | `first_open` → `game_start` |
| L-2 | Rätselmodus flach ab Level 9, Sterne unerreichbar | P1 | 4 h | höchstes Level je Spieler |
| L-3 | Bestenliste: Glück : Können = 5 : 1 | P1 | 4–8 h | Streuung der eingereichten Scores |
| L-4 | „Kein Zeitdruck" vs. 10-Sekunden-Combo | P2 | 10 min oder 3 h | Bewertungstexte, Rundendauer |
| L-5 | Keine neuen Meta-Systeme | P2 | — | — |

---

## Quellen

Alle Aussagen dieser Phase stützen sich auf Fundstellen in diesem Repo, auf
`BALANCE.md` (Simulation mit `scripts/audit/balance.dart`, 2 000–15 000 Runden)
oder auf eine eigene Messsonde über `PuzzleGenerator.generate`, die in dieser
Session gegen diesen Checkout lief. Externe Vergleichszahlen (Sessionlänge im
Genre, Marktführer ohne Shop) sind in `audit/01-markt.md` belegt.
