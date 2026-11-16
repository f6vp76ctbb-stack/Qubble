# Store-Assets (Play Console)

Fertige Grafiken, Texte und Videos für den Play-Store-Eintrag. Stand
15.11.2026. Was du damit tun musst, steht in `ANLEITUNG.md` (Schritte 3, 9,
10); was ein Text behaupten darf und was Google von Text und Bild verlangt,
in `docs/STORE-LISTING.md`.

**Vier Sprachen** werden von Hand gepflegt (Entscheidung Nutzer 09.11.2026):
Englisch, Deutsch, Spanisch (Lateinamerika), Portugiesisch (Brasilien). Alle
anderen Store-Sprachen übersetzt die Play Console; für sie liegt hier nichts.

## Was wohin gehört

| Datei | Verwendung | Format |
|---|---|---|
| `listing/<Play-Code>/` | Titel, Kurz- und Vollbeschreibung (`en-US`, `de-DE`, `es-419`, `pt-BR`); dasselbe in `store-listing.csv`. Dazu `alt_texts.txt`: ein Satz je Grafik für Screenreader (≤ 140 Zeichen), von Hand in die Console einzutragen | Text |
| `en/`, `de/`, `es/`, `pt/` → `screenshot-*.png` | 8 Telefon-Screenshots je Sprache | 1080×1920, ohne Alpha |
| `en/`, `de/`, `es/`, `pt/` → `feature-graphic-1024x500.png` | Feature-Grafik je Sprache (sie trägt Text) | 1024×500, ohne Alpha |
| `app-icon-512.png` | das ausgelieferte App-Symbol | 512×512 |
| `icon-variant/` | zwei Kandidaten für ein Store-Experiment (Blockteil; Qubbie) — **nicht** ausgeliefert, siehe dort `README.md` | 512 / 1024 |
| `video/qubble-showreel.mp4` | Schnellschnitt: zwölf Szenen, je ein anderes Design, anderer Effekt, anderes Qubbie; ohne Text | 1080×1920, 30 fps, 17 s, H.264 + AAC |
| `video/YOUTUBE.md` | Titel, Beschreibung und Tags für YouTube (Showreel und Clips), vom Behauptungs-Test mitgeprüft | Text |
| `video/qubble-gameplay.mp4`, `-neon`, `-ocean`, `-sunset` | je eine Partie am Stück, jede mit einem anderen Qubbie (Katze, Donnervogel, Pinguin, Drache) | wie oben, ~25 s |
| `product-icons/` | Symbole der In-App-Produkte | — |
| `play-games/` | Symbole der Play-Games-Erfolge | — |
| `event-halloween/` | Bilder und Texte des Halloween-Events (Oktober) | — |

`es/` gilt auch für Spanisch (Spanien), wenn es denselben Eintrag bekommen
soll (`tool/export_play_metadata.py --with-copies`).

## Die acht Motive (seit 13.11.2026, neu verteilt 16.11.)

Reihenfolge wie nummeriert hochladen — das erste Bild trägt den Großteil der
Entscheidung. Auftrag: Die Haustiere sollen auf den Bildern zu sehen sein;
sie sind das, was Qubble von anderen Block-Puzzles unterscheidet.

| # | Datei | Zeigt | Überschrift (EN / DE) |
|---|---|---|---|
| 1 | `screenshot-1-qubbie` | Der Drache fliegt die Reihe entlang, die er abbrennt; darunter groß mit Namen | Pets that play along. / Haustiere, die mitspielen. |
| 2 | `screenshot-2-clear` | Reihe platzt im Konfetti (Bonbon + Gelee), die Katze fliegt mit | Fill a line. Watch it blow. / Reihe voll. Reihe weg. |
| 3 | `screenshot-3-qubbies` | Der Qubbies-Bildschirm der App: der Drache auf Level 3, ein Ei auf halbem Weg, die Karten der anderen | 9 Qubbies to hatch / 9 Qubbies zum Ausbrüten |
| 4 | `screenshot-4-designs` | Neun echte Bretter in neun Looks, darunter die Zahlen | Your board. Your style. / Dein Brett. Dein Stil. |
| 5 | `screenshot-5-combo` | Eine Combo geht los: Neon-Brett, Sterne, oben „Combo x3", der Donnervogel fliegt mit | Chain your clears. / Combos zünden. |
| 6 | `screenshot-6-rewards` | Zwei Ausschnitte des Quests-Bildschirms: Tagesquests mit Häkchen, ein Erfolg zum Abholen | Quests & achievements / Quests & Erfolge |
| 7 | `screenshot-7-daily` | Tägliche Challenge mit Punkteanzeige; das Qubbie sitzt auf der Brettkante | Every day, a different board / Jeden Tag ein anderes Brett |
| 8 | `screenshot-8-offline` | „Keine Zwangswerbung" über dem Startbildschirm (neues Design) | No forced ads. Ever. / Keine Zwangswerbung. |

**Zahlen und Namen werden nie eingetippt.** Der Generator schreibt sie aus
den Katalogen und den App-Übersetzungen nach
`store-assets/raw/<sprache>/designs.json`. Gezählt wird, was es das ganze
Jahr gibt (11 Themes, 22 Skins) — wie im Beschreibungstext. Ändert sich eine
Zahl, bricht `caption_screenshots.py` ab, bis die Bildtexte neu gelesen sind
(`WRITTEN_FOR`).

**Alles im Bild ist die App:** Bretter, Qubbies und Bildschirme sind
Aufnahmen der echten Oberfläche; dazu kommen nur Hintergrund, Überschrift
und Anordnung. Nichts Saisonales, nichts, was nur Käufer bekommen — außer
den Qubbies selbst, und die sind mit Namen und Preisweg im Text erklärt.

**Googles Vorgaben sind eingebaut** (Wortlaut und Quelle:
`docs/STORE-LISTING.md`, „Was Google verlangt"):

- Der Text, den ein Bild zur Aufnahme hinzufügt, darf höchstens 20 % der
  Fläche einnehmen. `caption_screenshots.py` misst das bei jedem Lauf, gibt
  den Anteil aus (zurzeit 6–11 %) und bricht darüber ab; der
  Überschriften-Block endet im obersten Fünftel. Darum steht unter der
  Überschrift genau eine Zeile, und neben dem großen Qubbie nur sein Name.
- Die ersten drei Bilder zeigen die Oberfläche: Brett, Brett,
  Qubbies-Bildschirm.
- Kein „neu", „best", „top", „gratis", „#1", keine Aufforderung („Jetzt
  spielen") in Bildtext, Feature-Grafik oder Kurzbeschreibung;
  Kurzbeschreibung, Bild 1 und Feature-Grafik sagen drei verschiedene Sätze.
  `test/store_listing_test.dart` prüft beides.
- Feature-Grafik auf kräftigem Violett statt auf dem dunklen Marineblau der
  App (Google: kein Weiß, Schwarz, Dunkelgrau), alles Wichtige mit 112 px
  Abstand zum Rand. Googles eigene „cutoff zones" stehen nur in einem Bild,
  das sich nicht laden ließ — der Abstand ist eine Annahme.
- Kein Geräterahmen, keine Hand, kein Finger; in den Videos kein aufgemalter
  Fingerpunkt mehr.

**Vor dem Hochladen ansehen:** Die Bilder sind verspielter als die vom
Oktober. Warum das eine Rolle spielt: `docs/HAUSTIERE.md` §8.1 und
`ANLEITUNG.md` Schritt 10.

## Neu erzeugen

```bash
pip install Pillow imageio-ffmpeg                # einmalig
flutter test tool/generate_screenshots.dart      # Aufnahmen -> store-assets/raw/<sprache>/
python3 tool/caption_screenshots.py              # Bilder    -> store-assets/<sprache>/
python3 tool/feature_graphic.py                  # Feature-Grafik (braucht raw/en/)
python3 tool/feature_graphic.py og               # Link-Vorschau der Web-Version
python3 tool/icon_variant.py qubbie              # Symbol-Kandidat mit Qubbie
```

`QUBBLE_LOCALES=en flutter test tool/generate_screenshots.dart` rendert nur
Englisch; die Python-Werkzeuge nehmen Sprachcodes
(`python3 tool/caption_screenshots.py de`).

Der erste Schritt rendert die App bei 1080×1920 mit fest eingestelltem
Spielstand (Bestwert 18 740, Name „Puzzlerin", Level 14 — reine Demo-Werte)
und schreibt zu jeder Aufnahme die Lage des Bretts als JSON daneben. Der
zweite schneidet zu, setzt Überschrift und Unterzeile und legt alles auf
einen Hintergrund. Bildtexte: `CAPTIONS` in `tool/caption_screenshots.py`;
welche Looks, Skins und welches Qubbie zu sehen sind: `MOSAIC`, `SKIN_TILES`,
`MASCOT` dort und `_shots`, `_looks`, `_nestState` in
`tool/generate_screenshots.dart`. Bretter, Züge, Punktestände und Qubbies
sind geseedet: Ein erneuter Lauf liefert dieselben Motive. **Nicht**
bit-gleich sind Funken und Partikel (Fieber-Leiste, Feuer, Konfetti) — die
streut die App zufällig, sie liegen bei jedem Lauf etwas anders (nachgemessen
15.11.: nur dort unterscheiden sich zwei Läufe).

`store-assets/raw/` ist ein Zwischenergebnis und wird nicht eingecheckt.

## Videos neu erzeugen

```bash
flutter test tool/generate_showreel.dart         # zwölf Szenen -> build/video/showreel/
python3 tool/encode_video.py showreel            # -> video/qubble-showreel.mp4

flutter test tool/generate_video.dart            # eine Partie -> build/video/classic/
python3 tool/encode_video.py                     # -> video/qubble-gameplay.mp4

QUBBLE_CLIP=neon flutter test tool/generate_video.dart   # ebenso ocean, sunset
python3 tool/encode_video.py neon                # -> video/qubble-neon.mp4
```

Alles im Bild ist die App: Die Teile werden mit echten Drag-Gesten gezogen,
und nichts wird darübergelegt (der weiche Fingerpunkt von früher ist seit
15.11. aus; `QUBBLE_TOUCH_DOT=1` bringt ihn für Clips zurück, die nicht in
den Store gehen). Die Tonspur sind die Spiel-Sounds
auf den Frames und in der Tonhöhe, die das Spiel selbst anfordert, über der
Spielmusik. Die Szenen des Schnellschnitt-Videos stehen als Liste in
`tool/generate_showreel.dart` (`_scenes`) — andere Looks oder Qubbies sind
eine Zeile.

## Hochladen

Per Workflow oder von Hand: `ANLEITUNG.md`, Schritte 9 und 10.
`tool/export_play_metadata.py` legt Texte, Bilder und „Was ist neu" so ab,
wie die Schnittstelle sie braucht (`build/play-metadata/android/<Code>/`),
`tool/play_publish.py` sendet sie.
