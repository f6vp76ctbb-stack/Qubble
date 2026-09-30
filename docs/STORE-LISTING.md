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
| 11 Themes, 11 Block-Skins | ✅ ja — Aurora nur im Unterstützer-Paket, **das gehört in die Beschreibung**; Bonbon/Vulkan/Gletscher + Pixel/Marmor/Gelee für je 80 💎, täglich eins davon als Angebot des Tages (`lib/game/design_offer.dart`) |
| 3 animierte Shop-Skins (Flüssig, Sprudel, Plasma) | ✅ ja — je 150 💎 (`kAnimatedSkinPrice`) |
| 8 animierte Block-Skins, nicht käuflich, nur über Erfolge | ✅ ja — höchste Stufe jeder Erfolgs-Kategorie (`lib/game/achievements.dart`), nie für Münzen, Diamanten oder Geld (`BlockSkin.isPurchasable`) |
| Tägliche Challenge mit Streak | ✅ ja |
| Rätsel-Modus | ✅ ja |
| Rätsel-**3-Sterne-Wertung** als Leistungsabstufung | ❌ **nein** — `minMoves == Teilezahl` in 200/200 geprüften Leveln, also immer 3 Sterne (`audit/03-loop.md` L-2) |
| Quests (täglich/wöchentlich/monatlich), Level, Erfolge, Statistiken | ✅ ja — `lib/game/quests.dart` |
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
• 11 Themes: Classic, Fade, Neon, Ocean, Wood, Sunset, Forest, Bonbon,
  Vulkan, Gletscher und Aurora (Aurora ist dem Unterstützer-Paket vorbehalten)
• 11 Block-Skins von schlicht bis Kristall
• 8 animierte Block-Skins, die man nicht kaufen kann — jeder wird mit einem
  Erfolg verdient
• 3 weitere animierte Skins und ein Angebot des Tages im Shop
• Tägliche, wöchentliche und monatliche Quests, Spieler-Level, Erfolge und
  eine ausführliche Statistik
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
• 11 themes: Classic, Fade, Neon, Ocean, Wood, Sunset, Forest, Candy,
  Volcano, Glacier and Aurora (Aurora is reserved for the supporter pack)
• 11 block skins, from plain to crystal
• 8 animated block skins that can't be bought — each one is earned with an
  achievement
• 3 more animated skins and a daily deal in the shop
• Daily, weekly and monthly quests, player levels, achievements and
  detailed stats
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

Place the first block. Clear the grid. Beat your high score.
```

---

## Kategorien & Einstufung

- **Kategorie:** Spiele → Puzzle (Play) / Games → Puzzle (App Store).
- **Altersfreigabe:** voraussichtlich USK 0 / PEGI 3 / Apple 4+. Achtung: Enthält
  Werbung + In-App-Käufe → in den Fragebögen entsprechend angeben (nicht als
  „für Kinder" labeln, um COPPA/AdMob-Kinderwerbung-Themen zu vermeiden).

## Store-Eintrag befüllen

**Wie** die Texte in die Console kommen (von Hand, Dateiimport, fastlane) und
welche Datei zu welcher Play-Sprache gehört, steht in **`ANLEITUNG.md`**, „Store-Eintrag in 54 weiteren Sprachen".
Hier steht nur, **was** die Texte sind.

- Je Sprache liegen Titel, Kurz- und Vollbeschreibung als eigene Dateien in
  `store-assets/listing/<Play-Code>/`, ohne Markdown. Auch für Englisch und
  Deutsch gelten nur `listing/en-US/` und `listing/de-DE/`: Die Fassungen
  weiter oben in diesem Dokument sind für den Editor auf 80 Zeichen umbrochen
  und zeigen auf Play halbe Zeilen.
- `store-assets/store-listing.csv` enthält dieselben Texte, eine Zeile je
  Play-Sprache. `test/store_listing_test.dart` hält beide gleich und prüft die
  Feldlängen (30 / 80 / 4000). Die Spaltennamen sind nicht gegen die Console
  geprüft; der Import schlug am 28.09. ohne Fehlermeldung fehl.
- Die App spricht 56 Sprachen. Arabisch, Bengalisch, Chinesisch, Griechisch,
  Gujarati, Hebräisch, Hindi, Japanisch, Kannada, Koreanisch, Malayalam,
  Marathi, Nepali, Punjabi, Tamil, Telugu, Thai und Urdu gibt es nur in der
  Android-/iOS-App, nicht im Web-Build (Nunito hat diese Schriften nicht,
  `lib/ui/locale.dart`). Für den Play-Eintrag spielt das keine Rolle.

## Weitere Sprachen (seit 23.09.2026)

**Was die Übersetzungen inhaltlich sind:** dieselbe Beschreibung wie die
englische, Aussage für Aussage — keine neue Behauptung, keine weggelassene
Einschränkung (Aurora bleibt dem Unterstützer-Paket vorbehalten, Weiterspielen
kostet Münzen, die Bestenliste braucht Internet). Die Theme-Namen sind die,
die die App in der jeweiligen Sprache zeigt (vom Test geprüft).

**Kein Absatz mit Konkurrenz-Titeln** („Du magst Woodoku, Block Blast …"),
in keiner Sprache — seit 29.09.2026 auch nicht mehr in EN/DE (Entscheidung
Nutzer). Googles Metadaten-Richtlinie untersagt „irreführende Verweise"; ob
das Nennen fremder Spieltitel darunter fällt, war nicht zu belegen, und bei
einem Konto mit Sperr-Vorgeschichte ist Weglassen die billigere Seite des
Risikos. `test/store_claims_test.dart` hält fremde Spieltitel aus allen
Store-Texten heraus.

**Keine harten Zeilenumbrüche im Absatz.** Play zeigt einen Zeilenumbruch
dort, wo der Text einen hat. Die EN/DE-Fassungen oben sind für den Editor
auf 80 Zeichen umbrochen; wurden sie so eingefügt, zeigt der Eintrag auf
dem Handy halbe Zeilen. Die Dateien in `store-assets/listing/` haben pro
Absatz genau eine Zeile (ein Test verhindert neue Umbrüche).

**Screenshots und Feature-Grafik** liegen je Sprache in
`store-assets/<sprache>/` (aus der App in der jeweiligen Sprache gerendert,
Untertitel übersetzt). Ohne Upload zeigt Play in diesen Sprachen die Bilder
der Standardsprache Englisch. Details in `store-assets/README.md`.

## Screenshots

Die Grafiken liegen fertig in `store-assets/` — inklusive der nach dem
Closed-Test-Feedback ergänzten Bildunterschriften. Details, Reihenfolge und
Upload-Hinweise: `store-assets/README.md`.
