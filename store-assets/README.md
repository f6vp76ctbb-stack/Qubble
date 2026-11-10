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
| `af/`, `az/`, `bg/`, `bs/`, `ca/`, `cs/`, `da/`, `es/`, `et/`, `fi/`, `fil/`, `fr/`, `hr/`, `hu/`, `id/`, `it/`, `kk/`, `lt/`, `lv/`, `mk/`, `ms/`, `nb/`, `nl/`, `pl/`, `pt/`, `ro/`, `sk/`, `sl/`, `sq/`, `sr/`, `sv/`, `sw/`, `tr/`, `uk/`, `uz/`, `vi/` | Screenshots + Feature-Grafik dieser sechsunddreißig Sprachen (seit 23.09.2026); `es/` gilt für **beide** spanischen Einträge (`es-419` und `es-ES`), `pt/` für `pt-BR`, `nl/` für `nl-NL`, `pl/` für `pl-PL`, `cs/` für `cs-CZ`, `hu/` für `hu-HU`, `sv/` für `sv-SE`, `da/` für `da-DK`, `nb/` für `no-NO`, `fi/` für `fi-FI`, `az/` für `az-AZ`, `mk/` für `mk-MK` | wie oben |
| `ja/`, `ko/`, `th/`, `zh/`, `zh_Hant/`, `ar/`, `hi/`, `el/`, `he/`, `ur/`, `ta/`, `te/`, `gu/`, `kn/`, `ml/`, `pa/`, `bn/`, `mr/`, `ne/` | Screenshots + Feature-Grafik Gujarati (`gu`, Noto Sans Gujarati), Kannada (`kn/` → `kn-IN`, Noto Sans Kannada), Malayalam (`ml/` → `ml-IN`, Noto Sans Malayalam), Punjabi (`pa`, Gurmukhi, Noto Sans Gurmukhi), Bengalisch (`bn/` → `bn-BD`, Noto Sans Bengali), Marathi (`mr/` → `mr-IN`) und Nepali (`ne/` → `ne-NP`, beide Noto Sans Devanagari wie Hindi), Tamil (`ta/` → `ta-IN`, Noto Sans Tamil), Telugu (`te/` → `te-IN`, Noto Sans Telugu), Urdu (`ur`, von rechts nach links, Noto Sans Arabic), Hebräisch (`he/` → `iw-IL`, von rechts nach links, Noto Sans Hebrew), Griechisch (`el/` → `el-GR`, griechische Buchstaben in Noto Sans), Japanisch (`ja-JP`), Koreanisch (`ko-KR`), Thai (`th`), Hindi (`hi/` → `hi-IN`), Chinesisch vereinfacht (`zh/` → `zh-CN`) und traditionell (`zh_Hant/` → `zh-TW` **und** `zh-HK`), Arabisch (`ar`, von rechts nach links gesetzt) — Texte in Noto Sans CJK/Thai/Arabic/Devanagari | wie oben |
| `listing/<code>/` | Titel, Kurz- und Vollbeschreibung **aller** Sprachen als Textdateien (EN/DE seit 23.09.2026 ohne harte Zeilenumbrüche) | — |
| `video/qubble-gameplay.mp4` | Gameplay-Clip, sprachneutral (Endkarte ohne Text): Promo-Video des Store-Eintrags (Play verlangt dafür einen **YouTube-Link** — hochladen musst du) und Shorts/Reels/TikTok | 1080×1920, 30 fps, ~25 s, H.264 + AAC |
| `video/qubble-neon.mp4`, `qubble-ocean.mp4`, `qubble-sunset.mp4` | Drei weitere Clips für Shorts/Reels/TikTok — jeweils eine andere Partie in einem anderen Theme, damit regelmäßige Posts nicht dasselbe Video zeigen. Neu rendern: `QUBBLE_CLIP=<name> flutter test tool/generate_video.dart`, dann `python3 tool/encode_video.py <name>` | wie oben |

Auch die **Feature-Grafik ist pro Sprache** — sie trägt Text. Vorher gab es sie
nur auf Deutsch, die englische Standardsprache hatte also keine.

Der Store-Eintrag hat pro Sprache eigene Screenshots. Englisch ist die
Standardsprache (größter Markt), Deutsch die zweite — jeweils den passenden
Ordner hochladen, sonst sehen deutsche Nutzer englische Bilder und umgekehrt.

## Die acht Motive (seit 02.10.2026)

Reihenfolge wie unten hochladen — der erste Screenshot trägt den Großteil der
Entscheidung. Auftrag des Eigentümers am 02.10.2026: **die vielen
Design-Möglichkeiten stehen im Fokus.** Darum drehen sich die ersten fünf
Bilder um Designs; Daily, Rätsel und „keine Zwangswerbung" folgen. Die
Begründung hinter Auswahl und Aufbau steht in `docs/STORE-SCREENSHOTS.md`.

| # | Datei | Zeigt | Überschrift (EN / DE) |
|---|---|---|---|
| 1 | `screenshot-1-designs` | Neun echte Boards in neun Looks (Theme + Skin + Zubehör), darunter die Zahlen: Themes, Block-Skins, Zubehör, Explosionen | Your board. Your style. / Dein Brett. Dein Stil. |
| 2 | `screenshot-2-clear` | Clear mitten im Konfetti, Candy + Jelly; die Unterzeile nennt den Look | Fill a line. Watch it blow. / Reihe voll. Reihe weg. |
| 3 | `screenshot-3-skins` | Neun Block-Skins mit ihrem Namen aus der App | 23 block skins / 23 Block-Skins |
| 4 | `screenshot-4-themes` | Neun Themes mit ihrem Namen aus der App | 12 themes. Pick your mood. / 12 Themes. Deine Stimmung. |
| 5 | `screenshot-5-extras` | Sechs Zubehörteile, Ausschnitt nah am Block | The finishing touch / Das gewisse Extra |
| 6 | `screenshot-6-daily` | Tägliche Challenge mit Punkteanzeige (Glacier) | A new board every day / Jeden Tag ein neues Board |
| 7 | `screenshot-7-puzzle` | Rätsel-Modus (Wood) | Every puzzle has a solution / Jedes Rätsel ist lösbar |
| 8 | `screenshot-8-offline` | „Keine Zwangswerbung" + Startbildschirm | No forced ads. Ever. / Keine Zwangswerbung. |

**Zahlen und Namen werden nie eingetippt.** Der Generator schreibt sie aus den
Katalogen und den App-Übersetzungen nach `store-assets/raw/<sprache>/designs.json`
(vorher stand auf Bild 4 noch „Eight themes", als es längst zwölf gab).
Ändert sich eine Zahl, bricht `caption_screenshots.py` ab, bis die
Zahlwörter aller Sprachen geprüft sind (`WRITTEN_FOR`): Polnisch sagt
„12 motywów", aber „23 skórki".

Nichts Saisonales im Bild: Halloween-Designs gibt es nur im Oktober zu kaufen.

**Feature-Grafik:** Statt des App-Symbols stehen dort jetzt drei echte Boards
in drei Looks, gefächert. Der Text („Keine Zwangswerbung …") bleibt.

## Neu erzeugen

Die Screenshots sind **aus den echten Screens gerendert**, nicht abfotografiert
— sie bleiben damit reproduzierbar und aktuell:

```bash
pip install Pillow fonttools                  # einmalig; dazu apt install fonts-noto-cjk fonts-noto-core
flutter test tool/generate_screenshots.dart   # rohe Aufnahmen -> store-assets/raw/<lang>/
python3 tool/caption_screenshots.py           # mit Text versehen -> store-assets/<lang>/
python3 tool/feature_graphic.py               # Feature-Grafik  -> store-assets/<lang>/ (braucht raw/en/)
```

`QUBBLE_LOCALES=en,de flutter test tool/generate_screenshots.dart` rendert nur
diese Sprachen (die sprachneutralen Design-Kacheln kommen immer mit).

Beide Python-Werkzeuge nehmen optional Sprachcodes
(`python3 tool/caption_screenshots.py es fr`) und bauen dann nur diese —
so bleiben bereits hochgeladene Bilder anderer Sprachen unangetastet.

Der erste Schritt rendert die App bei 1080×1920 mit fest eingestelltem
Spielstand (Bestwert 18 740, Name „Puzzlerin", Level 14 — reine Demo-Werte) und
schreibt zu jeder Aufnahme die exakte Board-Geometrie als JSON daneben. Der
zweite schneidet danach zu, setzt Überschrift und Unterzeile und legt das
Ganze auf einen Hintergrund. Captions ändern: `CAPTIONS` und
`DESIGN_CAPTIONS` in `tool/caption_screenshots.py`; welche Kacheln die
Design-Bilder zeigen: `MOSAIC`, `SKIN_TILES`, `THEME_TILES`,
`ACCESSORY_TILES` dort, die Looks selbst: `_looks` in
`tool/generate_screenshots.dart`.

Alles ist geseedet, also liefert ein erneuter Lauf dieselben Bilder.

**Hintergrund austauschen:** liegt `store-assets/plates/<stem>.png` (z. B.
`plates/2-clear.png`), nimmt der Compositor dieses Bild statt des selbst
erzeugten Verlaufs. Dort gehört die Ausgabe eines Bildmodells hin — die
Spiel-Oberfläche selbst wird nie von einer KI angefasst, siehe
`docs/STORE-SCREENSHOTS.md`, Abschnitt 5.

`store-assets/raw/` ist ein Zwischenergebnis und wird nicht eingecheckt.

## Hinweise für den Upload

- **Telefon-Screenshots:** mindestens 2, erlaubt bis 8 — hier 8.
- **Tablet-Screenshots (7" + 10")**: dieselben Dateien erfüllen die Vorgaben
  (9:16, 1080 px) und können in beide Tablet-Felder hochgeladen werden.
- **Optional/überspringen:** Video, Google Play Games auf PC, Chromebook,
  Android XR.

## Gameplay-Video neu erzeugen

```bash
pip install imageio-ffmpeg                    # bringt ein ffmpeg mit H.264 mit
flutter test tool/generate_video.dart         # Frames + Sound-Ereignisse -> build/video/en/
python3 tool/encode_video.py                  # -> store-assets/video/qubble-gameplay.mp4
```

Alles im Bild ist die App: Die Teile werden mit echten Drag-Gesten über den
echten `Draggable`/`DragTarget` gezogen. Einzige Zutat ist ein weicher
Fingerpunkt. Die Tonspur sind die Spiel-Sounds genau auf den Frames und in
der Tonhöhe, die das Spiel selbst anfordert (ein aufzeichnender
`AudioService`), über der Spielmusik. Der Aufbau folgt dem 3-Sekunden-Konzept
aus `audit/05-aso.md` §6: sofort das Brett, der erste Zug räumt eine Reihe,
das Logo erst am Ende. Deterministisch — derselbe Lauf ergibt dasselbe Video.
