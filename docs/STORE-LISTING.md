# Store-Listing & ASO (App Store + Play Store)

Fertige Texte zum Einfügen. Zeichenlimits sind pro Feld notiert. Zwei Sprachen:
**DE** (Primärmarkt) und **EN** (International). Vor Live-Gang final gegen die
aktuellen Store-Limits prüfen.

- **App-Name:** Qubble
- **Entwickler/Publisher:** Thinkube
- **Bundle-ID / Application-ID:** `com.thinkube.qubble`

> Namens-Check vor Launch (👤): „Qubble" und „Thinkube" in beiden Stores und
> als Marke prüfen, bevor die Entwicklerkonten final auf diese Namen laufen.

> **Stand 31. August 2026 — gegen den Code geprüft.** Die Vollbeschreibungen
> unten sind die einzige Fassung, die in die Play Console gehört. Gegenüber dem
> Stand vom August sind drei Aussagen entfernt, die dem Abgleich mit dem Code
> nicht standhielten und unter Googles Metadaten-Policy fallen:
>
> 1. **„kein Server“** — die Bestenliste überträgt Anzeigename und Punktestand
>    an Cloud Firestore (`lib/services/leaderboard.dart:133-210`). Das ist
>    derselbe Sachverhalt, den das Data-Safety-Formular deklarieren muss.
> 2. **„drei Sterne für die Mindestzahl an Zügen“** — die Abstufung existiert
>    nicht; jedes gelöste Level gibt 3 Sterne (`audit/03-loop.md` L-2).
> 3. **„kein Zeitdruck“** — die Combo läuft nach 10 s ab, mit sichtbarem
>    Countdown (`lib/game/scoring.dart:50`).
>
> Titel- und Kurzbeschreibungs-Varianten für einen A/B-Test stehen in
> `audit/05-aso.md`. Begründung aller Änderungen ebendort, Abschnitt 1.

---

## Was in der Beschreibung stehen DARF (Realitätsabgleich)

Store-Texte müssen zur App passen, sonst droht eine Ablehnung wegen
irreführender Angaben. Der aktuelle Stand:

| Aussage | Trifft zu? |
|---|---|
| Das Spiel selbst offline spielbar, kein Konto, kein Login | ✅ ja |
| „Kein Server“ | ❌ **nein** — die Bestenliste sendet Name + Score an Firestore (`lib/services/leaderboard.dart:133`) |
| „Kein Zeitdruck“ | ⚠️ **nur halb** — die Runde hat keinen Timer, aber die Combo läuft nach 10 s ab (`lib/game/scoring.dart:50`) |
| Keine Interstitials, keine Banner, keine Zwangswerbung | ✅ ja (nur Rewarded) |
| Video-Belohnungen immer freiwillig | ✅ ja |
| „Werbung dauerhaft entfernen"-Kauf | ❌ **nein** — gibt es nicht mehr |
| Unterstützer-Paket (Theme + Skin + Münzen) | ✅ ja (`qubble_supporter`) |
| Münzpakete / Starter-Paket | ✅ ja |
| 8 Themes, 8 Block-Skins | ✅ ja — Aurora nur im Unterstützer-Paket, **das gehört in die Beschreibung** |
| Tägliche Challenge mit Streak | ✅ ja |
| Rätsel-Modus | ✅ ja |
| Rätsel-**3-Sterne-Wertung** als Leistungsabstufung | ❌ **nein** — `minMoves == Teilezahl` in 200/200 geprüften Leveln, also immer 3 Sterne (`audit/03-loop.md` L-2) |
| Missionen, Level, Erfolge, Statistiken | ✅ ja |
| Online-Bestenliste | ✅ ja (optional, Name freiwillig) — überträgt Daten, siehe oben |

---

## App-Name / Titel  (iOS 30, Play 30 Zeichen)

- **DE:** `Qubble – Block Puzzle`  (21)
- **EN:** `Qubble: Block Puzzle`  (20)

> Namens-Check vor Launch: prüfen, ob „Qubble" in beiden Stores frei ist; sonst
> Zusatz wie „Qubble Blocks". Bundle-ID bleibt unabhängig davon.

## Untertitel (iOS, 30 Zeichen)

- **DE:** `Blöcke setzen, Reihen räumen`  (28)
- **EN:** `Drop blocks, clear the grid`  (27)

## Kurzbeschreibung (Play, 80 Zeichen)

Die Kurzbeschreibung ist bei Play **indexiert** — die wichtigsten Keywords
gehören hier hinein, nicht nur ein Slogan.

- **DE:** `Block Puzzle offline: Blöcke setzen, Reihen räumen, Highscore knacken.`  (70)
- **EN:** `Offline block puzzle: drop blocks, clear lines, beat your high score.`  (69)

## Keywords (iOS, 100 Zeichen, kommagetrennt, keine Leerzeichen)

Der Titel-Text wird von Apple bereits indexiert — „qubble", „block" und
„puzzle" stehen deshalb bewusst **nicht** mehr im Keyword-Feld (kein Platz
verschwenden).

- **DE:** `blöcke,klötzchen,knobeln,denkspiel,gehirnjogging,logik,raster,offline,entspannen,woodoku,combo`  (94)
- **EN:** `blocks,blast,woodoku,blockudoku,sudoku,brain,logic,grid,offline,relax,tile,combo,daily,1010`  (91)

## Werbetext / Promotional Text (iOS, 170 Zeichen)

- **DE:** `Neu: Rätsel-Modus, tägliche Challenge mit Streak und acht Themes. Ohne Anmeldung, ohne Zwangswerbung – das Spiel selbst läuft komplett offline.`  (149)
- **EN:** `New: puzzle mode, a daily challenge with streaks and eight themes. No sign-up, no forced ads — the game itself plays fully offline.`  (133)

---

## Vollbeschreibung — Deutsch (max. 4000 Zeichen)

```
Qubble ist das entspannte Block Puzzle, das dich nicht mehr loslässt. Blöcke
setzen, Reihen räumen, Highscore knacken – offline spielbar, ohne Anmeldung und
ohne eine einzige erzwungene Werbung.

Zieh Blockformen auf das 8×8-Raster, fülle Reihen und Spalten und lass sie mit
einem befriedigenden Pop verschwinden. Kein Countdown, keine Runde, die dir
weggenommen wird: Du bist erst raus, wenn kein Teil mehr passt. Einfach zu
lernen, schwer zu meistern – genau richtig für fünf Minuten in der Bahn und für
die lange Highscore-Jagd am Abend.

▸ SO WIRD GESPIELT
Drei Blöcke liegen bereit, du entscheidest, wohin. Volle Reihen und Spalten
lösen sich auf. Klingt simpel – aber jedes Teil, das du falsch setzt, engt das
Raster weiter ein. Wer vorausdenkt statt nur zu stapeln, kommt weiter. Teile
lassen sich außerdem drehen, wenn es eng wird.

▸ COMBO-FIEBER
Räum mehrere Linien kurz hintereinander ab und der Punkte-Multiplikator
explodiert. Das Board glüht, der Sound zieht an, das Fieber-Meter füllt sich –
und der nächste große Ausbruch zählt doppelt. Wer zügig kombiniert, wird belohnt;
wer in Ruhe knobelt, spielt trotzdem jede Runde zu Ende.

▸ TÄGLICHE CHALLENGE
Jeden Tag dieselben Teile in derselben Reihenfolge – für alle Spieler weltweit.
Faire Bedingungen, ein Versuch, ein Ergebnis. Spiel jeden Tag und bau deinen
Streak auf; ein verpasster Tag lässt sich einmal reparieren.

▸ RÄTSEL-MODUS
Garantiert lösbare Level: Räum das Board komplett ab. Jedes Level wird erzeugt
und vorab von einem Solver geprüft, Nachschub geht also nie aus. Ein ruhiger
Gegenpol zur Highscore-Jagd, wenn du lieber tüftelst als hetzt.

▸ SAMMELN & FREISCHALTEN
• 8 Themes: Classic, Fade, Neon, Ocean, Wood, Sunset, Forest und Aurora
  (Aurora ist dem Unterstützer-Paket vorbehalten)
• 8 Block-Skins von schlicht bis Kristall
• Missionen, Spieler-Level, Erfolge und eine ausführliche Statistik
• Booster für knappe Runden: Rückgängig, Teile-Tausch, Board-Bombe
• Sparschwein: Jede geräumte Linie füllt es, voll gibt's die Münzen geschenkt

▸ BESTENLISTE
Trag dich freiwillig mit einem selbst gewählten Namen ein und miss dich mit
anderen. Dafür braucht es kein Konto und keine E-Mail. Ohne Namen spielst du
komplett anonym weiter – die Bestenliste ist Kür, nicht Pflicht.

▸ FAIR UND OHNE NERVEREI
Keine Interstitials. Keine Banner. Kein „schau ein Video, um weiterzuspielen".
Qubble unterbricht dein Spiel nicht – nie. Videos gibt es nur, wenn du sie
selbst antippst, zum Beispiel um Münzen zu verdoppeln, und sie geben immer
genau das, was versprochen wurde. Auch das Weiterspielen nach dem Aus kostet
Münzen, die du im Spiel verdienst – niemals ein Video.

▸ OHNE INTERNET SPIELBAR
Das Spiel selbst läuft komplett offline: Flugzeug, U-Bahn, Funkloch – egal.
Dein Fortschritt bleibt auf dem Gerät. Nur die optionale Bestenliste braucht
eine Verbindung.

Du magst Woodoku, Block Blast, Blockudoku oder 1010!? Dann fühlt sich Qubble
sofort vertraut an – mit eigenem Look, eigenem Sound und dem „nur noch eine
Runde"-Gefühl.

Setz den ersten Block. Räum das Raster. Knack deinen Highscore.
```

## Vollbeschreibung — English (max 4000 chars)

```
Qubble is the relaxing block puzzle that's impossible to put down. Drop blocks,
clear lines, chase high scores — playable offline, no sign-up, and not a single
forced ad.

Drag block shapes onto the 8×8 grid, fill rows and columns, and watch them
vanish with a satisfying pop. No countdown, no round taken away from you: the
run ends only when nothing fits any more. Easy to learn, hard to master —
perfect for five minutes on the bus and for the long high-score run at night.

▸ HOW IT PLAYS
Three blocks are ready, you decide where they go. Full rows and columns clear
out. Sounds simple — but every piece in the wrong spot boxes the grid in a
little more. Thinking one move ahead beats stacking. Pieces can be rotated when
things get tight.

▸ COMBO FEVER
Clear several lines in quick succession and the score multiplier explodes. The
board glows, the sound builds, the fever meter fills — and the next big break
counts double. Chain them quickly and you're rewarded; take your time and you
still finish every run.

▸ DAILY CHALLENGE
The same pieces in the same order for every player worldwide, every day. Same
conditions, one run, one result. Play daily to build your streak — and a missed
day can be repaired once.

▸ PUZZLE MODE
Levels that are guaranteed solvable: clear the board completely. Every level is
generated and verified by a solver up front, so you'll never run out. A calmer
counterweight to the high-score chase, for when you'd rather think than rush.

▸ COLLECT AND UNLOCK
• 8 themes: Classic, Fade, Neon, Ocean, Wood, Sunset, Forest and Aurora
  (Aurora is reserved for the supporter pack)
• 8 block skins, from plain to crystal
• Missions, player levels, achievements and detailed stats
• Boosters for tight runs: undo, swap pieces, board bomb
• Piggy bank: every cleared line fills it — when it's full, the coins are yours

▸ LEADERBOARD
Add a name you choose yourself and measure up against others. No account and no
email required. Without a name you play completely anonymously — the leaderboard
is optional, always.

▸ FAIR, WITH NO NAGGING
No interstitials. No banners. No "watch a video to keep playing". Qubble never
interrupts your game — not once. Videos only ever run when you tap them
yourself, for example to double your coins, and they always pay out exactly
what was promised. Carrying on after a game over costs coins you earn by
playing — never a video.

▸ PLAYS WITHOUT INTERNET
The game itself runs fully offline: plane, subway, dead zone — it doesn't
matter. Your progress stays on your device. Only the optional leaderboard needs
a connection.

Love Woodoku, Block Blast, Blockudoku or 1010!? Qubble will feel familiar right
away — with its own look, its own sound and that "just one more round" feeling.

Place the first block. Clear the grid. Beat your high score.
```

---

## Kategorien & Einstufung

- **Kategorie:** Spiele → Puzzle (Play) / Games → Puzzle (App Store).
- **Altersfreigabe:** voraussichtlich USK 0 / PEGI 3 / Apple 4+. Achtung: Enthält
  Werbung + In-App-Käufe → in den Fragebögen entsprechend angeben (nicht als
  „für Kinder" labeln, um COPPA/AdMob-Kinderwerbung-Themen zu vermeiden).

## Store-Eintrag befüllen

### Für Englisch und Deutsch: von Hand eintippen

Klingt nach mehr Arbeit als es ist: **sechs Felder insgesamt** (Titel,
Kurzbeschreibung, Vollbeschreibung × 2 Sprachen), zusammen keine fünf Minuten.
Kopieren aus diesem Dokument, einfügen, fertig.

Das ist bewusst die Empfehlung, aus zwei Gründen:

1. **Die KI-Übersetzung wäre hier schlechter.** Beide Texte sind von Hand
   geschrieben, nicht übersetzt — jeder nutzt die Suchbegriffe, nach denen in
   *seiner* Sprache gesucht wird. Ließe man den deutschen Text übersetzen, käme
   ein schlechterer englischer heraus als der hier, und umgekehrt.
2. **Der Dateiimport ist bei zwei Sprachen kein Gewinn.** Google dokumentiert
   das erwartete Spaltenschema nicht öffentlich, und der Dialog bietet keine
   Vorlage zum Herunterladen an. Ein fehlgeschlagener Import kostet mehr Zeit
   als das Eintippen gespart hätte.

### Wofür der Dateiimport sich lohnt

Für **weitere** Sprachen. Ab etwa der dritten Sprache dreht sich das Verhältnis,
und dort ist maschinelle Übersetzung auch inhaltlich vertretbar — sie
konkurriert dann nicht mehr mit einem handgeschriebenen Text, sondern mit gar
keinem. Sinnvolle Kandidaten für ein Casual-Puzzle: Spanisch, Portugiesisch
(BR), Französisch, Italienisch, Türkisch, Indonesisch.

`store-assets/store-listing.csv` liegt als Startpunkt bereit (eine Zeile je
Sprache, Zeichenlimits geprüft, UTF-8). **Achtung:** Die Spaltennamen
(`language_code, title, short_description, full_description`) sind geraten, weil
Google das Schema nicht veröffentlicht. Wenn der Dialog die Datei ablehnt oder
eine Vorlage anbietet: Kopfzeile schicken, dann passe ich die Datei an.

> **Wichtig bei weiteren Sprachen:** Die **App** selbst spricht nur Englisch und
> Deutsch. Ein spanischer Store-Eintrag mit englischer App ist bei Casual-Spielen
> üblich und vertretbar — aber die Beschreibung darf dann nichts anderes
> behaupten. Wer die App-Sprachen mitwachsen lassen will: eine neue
> `lib/l10n/app_<code>.arb` anlegen; die Infrastruktur steht, und
> `test/l10n/translations_test.dart` erzwingt Vollständigkeit.

---

## Screenshots

Die Grafiken liegen fertig in `store-assets/` — inklusive der nach dem
Closed-Test-Feedback ergänzten Bildunterschriften. Details, Reihenfolge und
Upload-Hinweise: `store-assets/README.md`.
