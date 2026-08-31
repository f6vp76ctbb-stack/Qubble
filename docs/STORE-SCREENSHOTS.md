# Store-Screenshots: Strategie, Pipeline und KI-Übergabe

Stand: August 2026. Betrifft `store-assets/en/` und `store-assets/de/`,
erzeugt von `tool/generate_screenshots.dart` + `tool/caption_screenshots.py`.

---

## 1 · Warum die alte Serie nicht funktioniert hat

Nicht „Geschmackssache" — die sechs alten Kacheln hatten benennbare Fehler:

| Problem | Konkret |
|---|---|
| **Alles zu klein** | Der komplette 360×640-Screen wurde in eine Karte geschrumpft. In der Suchergebnis-Vorschau (~200 px breit), die die meisten Leute überhaupt nur sehen, war ein Block ca. 16 px groß. |
| **Leeres Board** | Kachel 1 zeigte ein zu 45 % gefülltes, Kachel 2 ein zu 75 % **leeres** Board. Die größte Fläche im Bild war graues Nichts. |
| **Werbe-Button im Bild** | „New pieces (video)" stand in fast jeder Kachel — ausgerechnet bei einer App, deren Alleinstellungsmerkmal „keine Zwangswerbung" ist. |
| **Preisschilder** | Undo 50 / Swap 75 / Bomb 150 belegten das untere Drittel. Das erste Signal war „will mein Geld", nicht „macht Spaß". |
| **Kein Moment** | Alle Aufnahmen waren Standbilder eines ruhenden Boards. Kein Clear, keine Partikel, keine Punkte-Anzeige. Die App *hat* diese Effekte — sie wurden nur nie fotografiert. |
| **Kachel 5 war ein Menü** | Fünf „Tap to activate"-Zeilen aus den Einstellungen. Das verkauft eine Konfigurationsseite. |
| **Sechsmal dasselbe Bild** | Gleiche Farbe, gleiche Position, gleiche Größe. Beim Durchwischen passierte nichts. |
| **Schwacher Punktestand** | `SCORE 31` neben `BEST 18.740` — es sah aus, als würde man gerade verlieren. |

---

## 2 · Was die erfolgreichen Titel anders machen

Recherchiert im August 2026 (Quellen unten):

- **Die erste Kachel entscheidet.** Sie trägt rund 60 % der Installations­entscheidung; sie allein zu ändern bewegt die Conversion in kontrollierten Tests um 15–30 %.
- **Puzzle-Titel zeigen sofort den Kern-Loop.** Bei Candy Crush, Block Blast und Woodoku ist in den ersten zwei Kacheln klar: Teil setzen, Reihe voll, Reihe explodiert. Kein Aufbau von Spannung — die Leute entscheiden in Sekunden, ob sich die Schleife befriedigend anfühlt.
- **Überschrift oben, groß, kurz.** 3–6 Wörter. Oben gestapelte Überschriften unter 30 Zeichen schlagen Bildunterschriften unten um 15–25 %. Schriftgröße mindestens 56–72 px auf 1080 px Breite, Gewicht 700–900.
- **Der Test:** Bild auf 25 % verkleinern. Wenn die Überschrift dann nicht sofort lesbar ist, ist sie zu klein oder zu lang.
- **Woodoku** setzt genau auf sichtbare Feier-Momente: „2X COMBO!"-Animation, „BEST SCORE EVER!"-Banner, befriedigendes Clear-Feedback.
- **Der visuelle Trend 2026** heißt „tactile minimalism": Oberflächen mit spürbarem Material und Gewicht, in bewusst einfacher Komposition. Wirkt hochwertig, ohne kompliziert zu sein — und funktioniert deshalb gerade in der Miniatur.
- **Geräterahmen vs. randlos** hat keinen Universalsieger; das hängt an der Kategorie. Deshalb: A/B-testen (Abschnitt 8).

---

## 3 · Die neue Serie

Sechs Kacheln, drei verschiedene Kompositionen, jede in einer eigenen Farbwelt.
Die Reihenfolge folgt der Regel „Kern-Loop zuerst":

| # | Datei | Zeigt | Komposition | Farbe |
|---|---|---|---|---|
| 1 | `screenshot-1-clear` | Volles Board, Spalte platzt, Partikel + `+303` | Board formatfüllend | Classic (Indigo/Mint) |
| 2 | `screenshot-2-combo` | Zweiter Clear, `+643`, Neon-Palette | Board formatfüllend | Neon (Schwarz/Grün) |
| 3 | `screenshot-3-daily` | Daily Challenge mit Punkteanzeige | Header + Board | Ocean (Petrol) |
| 4 | `screenshot-4-themes` | Vier echte Boards in vier Themes, 2×2 | Collage | Sunset (Violett) |
| 5 | `screenshot-5-puzzle` | Rätsel-Modus | Ganzer Screen | Wood (Braun) |
| 6 | `screenshot-6-offline` | „Keine Zwangswerbung", drei Belege, Startbildschirm | Statement | Classic |

Zwei Entscheidungen dahinter, die den größten Unterschied machen:

**Auf das Board zuschneiden.** Das Board ist das Produkt, also bekommt es den
Platz. Der Generator schreibt die exakte Board-Geometrie als JSON neben jedes
PNG — sie ist nicht auf jedem Screen gleich groß (die Daily Challenge blendet
die Booster-Leiste aus und bekommt ein größeres Board), also wird gemessen
statt geraten.

**Den Clear fotografieren.** Die Aufnahmen entstehen jetzt 150 ms nach dem
Zug, mitten im Partikel-Burst. Vorher wurde der Zug *vor* dem Rendern gespielt,
weshalb die Effekt-Ebene die Änderung nie gesehen hat und jedes Bild ein
ruhendes Board zeigte.

---

## 4 · Die Pipeline: drei Schichten

```
1. Flutter  →  echte App-Aufnahme  (store-assets/raw/<locale>/*.png + *.json)
2. KI       →  Hintergrundplatte    (store-assets/plates/<stem>.png)   ← optional
3. Pillow   →  Platte + Board-Ausschnitt + Typografie → store-assets/<locale>/
```

```bash
flutter test tool/generate_screenshots.dart   # Schicht 1
python3 tool/caption_screenshots.py           # Schicht 3
```

Schicht 2 ist optional. Liegt keine Platte vor, erzeugt der Compositor den
Hintergrund selbst aus der Theme-Palette. Legst du eine KI-Platte unter
`store-assets/plates/<stem>.png` ab, wird sie automatisch verwendet — kein
Code-Eingriff nötig.

---

## 5 · Die Grenze, die nicht verhandelbar ist

**Die KI fasst die Spiel-Oberfläche nicht an.**

Googles Store-Listing-Richtlinie verlangt Screenshots, die die tatsächliche
App zeigen, und warnt ausdrücklich vor „Rahmen oder starkem Styling, das die
Oberfläche verdeckt oder falsch darstellt". Ein Verstoß fällt unter
*Misrepresentation* — und das ist eine Ablehnungs- bis Sperr-Kategorie, nicht
nur ein Hinweis.

Dazu kommt ein praktisches Problem: **kein aktuelles Bildmodell hält eine
UI-Region pixelgenau.** Gib ihm den fertigen Screenshot und bitte um
„schöner", und du bekommst ein 8×8-Gitter, das plötzlich 9 Spalten hat,
verrutschte Ziffern und einen Score, der `18,74O` heißt.

Deshalb ist die Pipeline so gebaut, dass die KI **nur den Hintergrund** liefert
und der echte Board-Ausschnitt unverändert darübergelegt wird. Das ist
gleichzeitig richtlinienkonform, wiederholbar und für Deutsch/Englisch mit
demselben Hintergrund machbar.

Wenn du das anders machen willst: die eine Sache, die eine KI am fertigen Bild
gefahrlos tun kann, ist Retusche *außerhalb* des Boards. Alles, was Zahlen,
Raster oder Buttons berührt, ist tabu.

---

## 6 · Welche KI

| Modell | Wofür hier | Warum |
|---|---|---|
| **Nano Banana Pro** (Gemini 3 Pro Image) | **Erste Wahl für die Platten** | Bis zu 14 Referenzbilder, 4K-Ausgabe, sehr stabile Referenz-Treue. Man kann ihm die Theme-Farbe als Referenz mitgeben, statt sie zu beschreiben. |
| **GPT Image 2** | Alternative | Am stärksten, wenn im Bild verlässlich Text/Layout stehen muss. Für reine Hintergründe brauchst du das nicht — aber falls du später ein Feature-Grafik mit Schrift willst, ist es dort besser. |
| **Gemini 3.1 Flash Image** | Schnelle Iteration | Führt im August 2026 die Bild-Editing-Rangliste an (Arena 2870 vs. 2782 für GPT Image 2). Gut, um zehn Varianten einer Platte zu sichten. |

**Konkrete Empfehlung:** Nano Banana Pro, 1080×1920 (oder größer und dann
herunterskalieren — der Compositor skaliert automatisch). Sechs Platten, je
2–3 Varianten, dann die dunkelste nehmen.

---

## 7 · Die Prompts

Für jede Platte gilt derselbe **Negativ-Block**, immer anhängen:

> No text, no letters, no numbers, no logo, no watermark, no signature.
> No user interface, no app screen, no phone, no tablet, no device frame,
> no mockup. No people, no hands, no faces. No foreground objects — this is
> an empty backdrop, not a scene. No border, no vignette ring, no frame.

Und dieselben **Anti-KI-Regeln** (aus der Recherche zu erkennbaren Modell-Artefakten):

> Restrained saturation, closer to a colour negative than to a screen.
> No uniform glossiness — surfaces should be matte unless stated otherwise.
> Believable light falloff with a single light direction. Fine, even sensor
> grain. No repeating or tiling texture. Avoid the words "perfect", "8k",
> "hyperrealistic", "masterpiece" — they push the model toward plastic.

Wichtig für alle sechs: **die Bildmitte muss dunkel und ruhig bleiben.** Dort
landet das Board. Eine helle oder unruhige Mitte frisst den Kontrast der
Blöcke, und dann war die ganze Übung umsonst.

---

### Platte 1 — `1-clear` (Classic, Indigo/Mint)

> A deep indigo backdrop, photographed as a seamless studio wall rather than a
> scene. Matte painted plaster with faint, irregular vertical brush variation.
> A single soft light enters from the upper left and falls away towards the
> lower right; a cool mint-green bounce just grazes the left edge. The centre
> of the frame is the darkest part of the image, so that an object placed there
> reads as lit from behind. Vertical, 1080×1920.

### Platte 2 — `2-combo` (Neon, Schwarz/Grün)

> A near-black seamless backdrop with a faint acid-green light spilling up from
> below the bottom edge, the way one gelled lamp behind a subject would look.
> The spill is uneven — a little brighter left of centre, fading to true black
> in the upper corners. Matte, slightly dusty surface. The green should read as
> a whisper, not as a glow stick. Vertical, 1080×1920.

### Platte 3 — `3-daily` (Ocean, Petrol)

> Deep teal, like looking down into still water in open shade. A soft, very
> low-contrast caustic light pattern drifts across the upper third — irregular,
> never repeating, no distinct shapes. Light comes from above and dies out
> before the bottom edge. Matte, no specular highlights, no bubbles, no
> visible water surface. Vertical, 1080×1920.

### Platte 4 — `4-themes` (neutrale Matte für die Collage)

> A warm graphite backdrop: dark grey with a trace of plum in it. Matte, like
> unpolished concrete photographed indoors, with a subtle uneven patina and no
> repeating texture. A soft warm wash along the top edge falls away downward.
> Deliberately quiet and low-contrast — this is a mat that four bright objects
> will sit on. Vertical, 1080×1920.

### Platte 5 — `5-puzzle` (Wood, Braun)

> A dark walnut surface photographed straight down, filling the frame. Real
> open grain, matte oiled finish — no lacquer, no varnish shine. One warm lamp
> from the upper left with visible falloff into the lower right corner. Colour
> restrained and a little desaturated: brown, not orange. Vertical, 1080×1920.

### Platte 6 — `6-offline` (Classic, viel Ruhe)

> A deep indigo backdrop with far more empty space than incident. Near-black
> across the top third, where type will sit. A wide, very soft pool of cool
> light in the lower half, as if from a large diffused source well off to the
> left. Matte painted surface, no pattern, no texture repeat. Calm and cold.
> Vertical, 1080×1920.

### Prüfung, bevor du eine Platte übernimmst

1. Kein Text, keine Zahl, kein Logo im Bild — auch nicht klein in einer Ecke.
2. Die mittleren zwei Drittel sind dunkler als der Rand.
3. Keine Kachelung: kein Muster, das sich sichtbar wiederholt.
4. Nichts Gegenständliches, das man benennen kann.
5. Auf 25 % verkleinern: bleibt es ruhig, oder flackert es?

Dann als `store-assets/plates/<stem>.png` ablegen (Dateiname = Spalte „Datei"
aus Abschnitt 3, ohne `screenshot-`) und `python3 tool/caption_screenshots.py`
neu laufen lassen.

---

## 8 · Nach dem Hochladen: testen statt raten

Play Console → **Store-Präsenz → Store-Eintrag-Tests**. Bis zu drei Varianten
gegen den Ist-Zustand, Traffic wird automatisch aufgeteilt. Mindestens 7 Tage
laufen lassen (besser 14, wegen Wochenrhythmus); ab 95 % Konfidenz gibt Google
eine Empfehlung.

Der lohnendste erste Test ist **Kachel 1 gegen Kachel 1** — nicht die ganze
Serie. Sie trägt den Großteil der Entscheidung, und ein Test mit einer
Variablen ist auswertbar.

---

## 9 · Was in der App selbst noch im Weg steht

Screenshots können die Oberfläche nicht überholen. Zwei Punkte, die sowohl das
Spiel als auch jede künftige Aufnahme verbessern würden:

1. **Der „New pieces (video)"-Button steht als volle Zeile zwischen Punkte­anzeige
   und Board.** Er ist der Grund, warum die Kacheln 1 und 2 die Punkteanzeige
   *nicht* mitzeigen können: ein zusammenhängender Ausschnitt müsste ihn
   mitnehmen. Als kleiner Eintrag in der Booster-Leiste (bei Undo/Swap/Bomb)
   wäre er weiterhin freiwillig verfügbar, würde aber das Spielfeld nicht mehr
   mit einem Werbe-Aufruf einrahmen. Das ist eine App-Änderung, keine
   Screenshot-Änderung — sag Bescheid, dann mache ich sie.

2. **Die Punkte-Anzeige beim Clear (`+643`) nimmt die Theme-Akzentfarbe** und
   steht damit im Neon-Theme grün auf grünen Partikeln — praktisch unlesbar.
   Eine feste helle Farbe mit dunklem Schatten wäre in jedem Theme lesbar.

---

## Quellen

Recherchiert am 31.08.2026:

- [ASO Screenshots: 2026 Best Practices & App Store Image Specs — AppFollow](https://appfollow.io/blog/aso-screenshots-best-practices)
- [Gaming App Store Screenshots — Action Guide 2026, Nuvex](https://nuvex.design/use-cases/gaming)
- [How to Design App Store Screenshots That Lift CVR in 2026](https://www.strataigize.com/blog/app-store-screenshot-design-guide)
- [App Store Screenshot Design: A/B Test Results From 8 Categories](https://semnexus.com/app-store-screenshot-design-ab-test-results-8-categories)
- [How to Write App Store Screenshot Captions That Convert](https://screenshototter.com/blog/app-store-screenshot-captions)
- [Google Play Screenshot Requirements 2026 — Complete Guide](https://screenshots.live/en/guides/google-play-screenshot-requirements)
- [Best practices for your store listing — Play Console Help](https://support.google.com/googleplay/android-developer/answer/13393723)
- [Misrepresentation — Play Console Help](https://support.google.com/googleplay/android-developer/answer/9888689)
- [Run A/B tests on your store listing — Play Console Help](https://support.google.com/googleplay/android-developer/answer/12053285)
- [Best AI for Image Editing in 2026 — llm-stats Leaderboard](https://llm-stats.com/leaderboards/best-ai-for-image-editing)
- [24 Nano Banana Pro Use Cases — ImagineArt](https://www.imagine.art/blogs/nano-banana-pro-use-cases)
- [Top Game Art Trends in 2026 — RetroStyle Games](https://retrostylegames.com/blog/top-game-art-trends-2026/)
- [How to Make AI Images Look Less Like AI — Pixova](https://www.pixova.io/blog/how-to-make-ai-images-look-less-like-ai)
- [Woodoku — Wood Block Puzzles, App Store](https://apps.apple.com/us/app/woodoku-wood-block-puzzles/id1496354836)
- [Block Blast! — Google Play](https://play.google.com/store/apps/details?id=com.block.juggle&hl=en)
