# Store-Assets (Play Console)

Fertige Grafiken, Texte und Videos für den Play-Store-Eintrag. Stand
13.11.2026. Was du damit tun musst, steht in `ANLEITUNG.md` (Schritte 3, 9,
10); was ein Text behaupten darf, in `docs/STORE-LISTING.md`.

**Vier Sprachen** werden von Hand gepflegt (Entscheidung Nutzer 09.11.2026):
Englisch, Deutsch, Spanisch (Lateinamerika), Portugiesisch (Brasilien). Alle
anderen Store-Sprachen übersetzt die Play Console; für sie liegt hier nichts.

## Was wohin gehört

| Datei | Verwendung | Format |
|---|---|---|
| `listing/<Play-Code>/` | Titel, Kurz- und Vollbeschreibung (`en-US`, `de-DE`, `es-419`, `pt-BR`); dasselbe in `store-listing.csv` | Text |
| `en/`, `de/`, `es/`, `pt/` → `screenshot-*.png` | 8 Telefon-Screenshots je Sprache | 1080×1920, ohne Alpha |
| `en/`, `de/`, `es/`, `pt/` → `feature-graphic-1024x500.png` | Feature-Grafik je Sprache (sie trägt Text) | 1024×500, ohne Alpha |
| `app-icon-512.png` | das ausgelieferte App-Symbol | 512×512 |
| `icon-variant/` | zwei Kandidaten für ein Store-Experiment (Blockteil; Qubbie) — **nicht** ausgeliefert, siehe dort `README.md` | 512 / 1024 |
| `video/qubble-showreel.mp4` | Schnellschnitt: zwölf Szenen, je ein anderes Design, anderer Effekt, anderes Qubbie; ohne Text | 1080×1920, 30 fps, 17 s, H.264 + AAC |
| `video/qubble-gameplay.mp4`, `-neon`, `-ocean`, `-sunset` | je eine Partie am Stück (vom September, noch ohne Qubbie) | wie oben, ~25 s |
| `product-icons/` | Symbole der In-App-Produkte | — |
| `play-games/` | Symbole der Play-Games-Erfolge | — |
| `event-halloween/` | Bilder und Texte des Halloween-Events (Oktober) | — |

`es/` gilt auch für Spanisch (Spanien), wenn es denselben Eintrag bekommen
soll (`tool/export_play_metadata.py --with-copies`).

## Die acht Motive (seit 13.11.2026)

Reihenfolge wie nummeriert hochladen — das erste Bild trägt den Großteil der
Entscheidung. Auftrag: Die Haustiere sollen auf den Bildern zu sehen sein;
sie sind das, was Qubble von anderen Block-Puzzles unterscheidet.

| # | Datei | Zeigt | Überschrift (EN / DE) |
|---|---|---|---|
| 1 | `screenshot-1-qubbie` | Der Drache fliegt die Reihe entlang, die er abbrennt; darunter groß mit Namen | Pets that play along. / Haustiere, die mitspielen. |
| 2 | `screenshot-2-clear` | Reihe platzt im Konfetti (Bonbon + Gelee), die Katze fliegt mit | Fill a line. Watch it blow. / Reihe voll. Reihe weg. |
| 3 | `screenshot-3-qubbies` | Alle neun Qubbies mit ihren Namen | 9 Qubbies to hatch / 9 Qubbies zum Ausbrüten |
| 4 | `screenshot-4-designs` | Neun echte Bretter in neun Looks, darunter die Zahlen | Your board. Your style. / Dein Brett. Dein Stil. |
| 5 | `screenshot-5-skins` | Neun Block-Skins mit ihrem Namen aus der App | 22 block skins / 22 Block-Skins |
| 6 | `screenshot-6-daily` | Tägliche Challenge mit Punkteanzeige; das Qubbie sitzt auf der Brettkante | A new board every day / Jeden Tag ein neues Brett |
| 7 | `screenshot-7-puzzle` | Rätsel-Modus | Every puzzle has a solution / Jedes Rätsel ist lösbar |
| 8 | `screenshot-8-offline` | „Keine Zwangswerbung", drei Belege, Startbildschirm | No forced ads. Ever. / Keine Zwangswerbung. |

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
`PET_TILES`, `MASCOT` dort und `_shots`, `_looks` in
`tool/generate_screenshots.dart`. Alles ist geseedet: Ein erneuter Lauf
liefert dieselben Bilder.

`store-assets/raw/` ist ein Zwischenergebnis und wird nicht eingecheckt.

## Videos neu erzeugen

```bash
flutter test tool/generate_showreel.dart         # zwölf Szenen -> build/video/showreel/
python3 tool/encode_video.py showreel            # -> video/qubble-showreel.mp4

flutter test tool/generate_video.dart            # eine Partie -> build/video/classic/
python3 tool/encode_video.py                     # -> video/qubble-gameplay.mp4
```

Alles im Bild ist die App: Die Teile werden mit echten Drag-Gesten gezogen;
einzige Zutat ist ein weicher Fingerpunkt. Die Tonspur sind die Spiel-Sounds
auf den Frames und in der Tonhöhe, die das Spiel selbst anfordert, über der
Spielmusik. Die Szenen des Schnellschnitt-Videos stehen als Liste in
`tool/generate_showreel.dart` (`_scenes`) — andere Looks oder Qubbies sind
eine Zeile.

## Hochladen

Per Workflow oder von Hand: `ANLEITUNG.md`, Schritte 9 und 10.
`tool/export_play_metadata.py` legt Texte, Bilder und „Was ist neu" so ab,
wie die Schnittstelle sie braucht (`build/play-metadata/android/<Code>/`),
`tool/play_publish.py` sendet sie.
