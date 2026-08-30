# Store-Assets (Play Console)

Fertige Grafiken zum Hochladen im Play-Console-Store-Eintrag.
Die zugehörigen Texte stehen in `docs/STORE-LISTING.md`.

## Was wohin gehört

| Datei | Verwendung | Format |
|---|---|---|
| `app-icon-512.png` | App-Symbol (deckend, keine Transparenz) | 512×512 |
| `feature-graphic-1024x500.png` | Feature-/Vorstellungsgrafik (Kopfbanner) | 1024×500 |
| `en/screenshot-*.png` | Telefon-Screenshots, **Sprache Englisch (USA)** | 1080×1920 |
| `de/screenshot-*.png` | Telefon-Screenshots, **Sprache Deutsch** | 1080×1920 |

Der Store-Eintrag hat pro Sprache eigene Screenshots. Englisch ist die
Standardsprache (größter Markt), Deutsch die zweite — jeweils den passenden
Ordner hochladen, sonst sehen deutsche Nutzer englische Bilder und umgekehrt.

## Die sechs Motive

Reihenfolge wie unten hochladen — der erste Screenshot ist der wichtigste.

| # | Zeigt | Überschrift (EN / DE) |
|---|---|---|
| 1 | Laufende Runde, gut gefülltes Board (Classic) | Clear rows and columns / Räume Reihen und Spalten |
| 2 | Combo ×2 mit Fieber-Anzeige (Neon) | Ignite Combo Fever / Combo-Fieber entfachen |
| 3 | Tägliche Challenge mit Streak (Ocean) | A new challenge every day / Jeden Tag eine neue Challenge |
| 4 | Rätsel-Modus mit Zug-Ziel (Wood) | Puzzle mode, three stars / Rätsel-Modus mit drei Sternen |
| 5 | Theme-Auswahl (Sunset) | 8 themes, 8 block skins / 8 Themes, 8 Block-Skins |
| 6 | Startbildschirm mit Bestwert und Modi | Plays fully offline / Komplett offline spielbar |

Die Motive nutzen absichtlich verschiedene Themes, damit die visuelle
Bandbreite im Store sichtbar wird.

## Neu erzeugen

Die Screenshots sind **aus den echten Screens gerendert**, nicht abfotografiert
— sie bleiben damit reproduzierbar und aktuell:

```bash
flutter test tool/generate_screenshots.dart   # rohe Aufnahmen -> store-assets/raw/<lang>/
python3 tool/caption_screenshots.py           # mit Text versehen -> store-assets/<lang>/
```

Der erste Schritt rendert die App bei 1080×1920 mit fest eingestelltem
Spielstand (Bestwert 18 740, Name „Puzzlerin", Level 14 — reine Demo-Werte).
Der zweite setzt Überschrift, Unterzeile und Rahmen darauf. Captions ändern:
`CAPTIONS` in `tool/caption_screenshots.py`.

`store-assets/raw/` ist ein Zwischenergebnis und wird nicht eingecheckt.

## Hinweise für den Upload

- **Telefon-Screenshots:** mindestens 2, erlaubt bis 8 — hier 6.
- **Tablet-Screenshots (7" + 10")**: dieselben Dateien erfüllen die Vorgaben
  (9:16, 1080 px) und können in beide Tablet-Felder hochgeladen werden.
- **Optional/überspringen:** Video, Google Play Games auf PC, Chromebook,
  Android XR.
