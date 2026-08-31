# Store-Assets (Play Console)

Fertige Grafiken zum Hochladen im Play-Console-Store-Eintrag.
Die zugehörigen Texte stehen in `docs/STORE-LISTING.md`.

## Was wohin gehört

| Datei | Verwendung | Format |
|---|---|---|
| `app-icon-512.png` | App-Symbol (deckend, keine Transparenz) | 512×512 |
| `en/feature-graphic-1024x500.png` | Feature-Grafik (Kopfbanner), **Englisch** | 1024×500 |
| `de/feature-graphic-1024x500.png` | Feature-Grafik (Kopfbanner), **Deutsch** | 1024×500 |
| `en/screenshot-*.png` | Telefon-Screenshots, **Sprache Englisch (USA)** | 1080×1920 |
| `de/screenshot-*.png` | Telefon-Screenshots, **Sprache Deutsch** | 1080×1920 |

Auch die **Feature-Grafik ist pro Sprache** — sie trägt Text. Vorher gab es sie
nur auf Deutsch, die englische Standardsprache hatte also keine.

Der Store-Eintrag hat pro Sprache eigene Screenshots. Englisch ist die
Standardsprache (größter Markt), Deutsch die zweite — jeweils den passenden
Ordner hochladen, sonst sehen deutsche Nutzer englische Bilder und umgekehrt.

## Die sechs Motive

Reihenfolge wie unten hochladen — der erste Screenshot trägt den Großteil der
Entscheidung. Die Begründung hinter Auswahl und Aufbau steht in
`docs/STORE-SCREENSHOTS.md`.

| # | Zeigt | Überschrift (EN / DE) |
|---|---|---|
| 1 | Volles Board, Clear mitten im Partikel-Burst (Classic) | Fill a line. Watch it blow. / Reihe voll. Reihe weg. |
| 2 | Zweiter Clear, Neon-Palette | Clear a column. Then chain it. / Spalte weg. Dann verketten. |
| 3 | Tägliche Challenge mit Punkte- und Combo-Anzeige (Ocean) | A new board every day / Jeden Tag ein neues Board |
| 4 | Vier echte Boards in vier Themes, 2×2 | Eight themes. Pick your mood. / Acht Themes. Deine Stimmung. |
| 5 | Rätsel-Modus mit Zug-Ziel (Wood) | Every puzzle has a solution / Jedes Rätsel ist lösbar |
| 6 | „Keine Zwangswerbung" + Startbildschirm | No forced ads. Ever. / Keine Zwangswerbung. |

Jede Kachel hat ihre eigene Farbwelt, damit die Galerie beim Durchwischen nicht
sechsmal dasselbe Bild zeigt.

## Neu erzeugen

Die Screenshots sind **aus den echten Screens gerendert**, nicht abfotografiert
— sie bleiben damit reproduzierbar und aktuell:

```bash
flutter test tool/generate_screenshots.dart   # rohe Aufnahmen -> store-assets/raw/<lang>/
python3 tool/caption_screenshots.py           # mit Text versehen -> store-assets/<lang>/
python3 tool/feature_graphic.py               # Feature-Grafik  -> store-assets/<lang>/
```

Der erste Schritt rendert die App bei 1080×1920 mit fest eingestelltem
Spielstand (Bestwert 18 740, Name „Puzzlerin", Level 14 — reine Demo-Werte) und
schreibt zu jeder Aufnahme die exakte Board-Geometrie als JSON daneben. Der
zweite schneidet danach zu, setzt Überschrift und Unterzeile und legt das
Ganze auf einen Hintergrund. Captions ändern: `CAPTIONS` in
`tool/caption_screenshots.py`.

Alles ist geseedet, also liefert ein erneuter Lauf dieselben Bilder.

**Hintergrund austauschen:** liegt `store-assets/plates/<stem>.png` (z. B.
`plates/1-clear.png`), nimmt der Compositor dieses Bild statt des selbst
erzeugten Verlaufs. Dort gehört die Ausgabe eines Bildmodells hin — die
Spiel-Oberfläche selbst wird nie von einer KI angefasst, siehe
`docs/STORE-SCREENSHOTS.md`, Abschnitt 5.

`store-assets/raw/` ist ein Zwischenergebnis und wird nicht eingecheckt.

## Hinweise für den Upload

- **Telefon-Screenshots:** mindestens 2, erlaubt bis 8 — hier 6.
- **Tablet-Screenshots (7" + 10")**: dieselben Dateien erfüllen die Vorgaben
  (9:16, 1080 px) und können in beide Tablet-Felder hochgeladen werden.
- **Optional/überspringen:** Video, Google Play Games auf PC, Chromebook,
  Android XR.
