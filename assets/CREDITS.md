# Asset-Credits & Lizenzen

Alle Assets sind entweder selbst erstellt oder CC0 (siehe CLAUDE.md).
Neue Assets hier mit Quelle und Lizenz eintragen.

## Audio (`assets/audio/`)

| Datei | Quelle | Lizenz |
|---|---|---|
| `place.wav` | Selbst synthetisiert (`scripts`-Generator, Sinus + Hüllkurve) | Eigenwerk / CC0 |
| `clear.wav` | Selbst synthetisiert | Eigenwerk / CC0 |
| `combo.wav` | Selbst synthetisiert | Eigenwerk / CC0 |
| `fever.wav` | Selbst synthetisiert | Eigenwerk / CC0 |
| `gameover.wav` | Selbst synthetisiert | Eigenwerk / CC0 |
| `music.wav` | Selbst synthetisiert (`scripts/gen_music.py`, Ambient-Loop aus Sinustönen) | Eigenwerk / CC0 |
| `levelup.wav` | Selbst synthetisiert (aufsteigendes C-Dur-Arpeggio) | Eigenwerk / CC0 |

Die WAV-Dateien wurden prozedural erzeugt (kurz, mono, 16-bit PCM; Effekte
22050 Hz, der Musik-Loop 8000 Hz — dessen höchste Teiltonfrequenz liegt bei
663 Hz, gemessen, weshalb mehr Abtastrate nur Downloadgröße gekostet hätte
mit Attack/Release-Hüllkurve). Kein Fremdmaterial, damit keine Lizenzfragen.

## Grafik

Board, Teile und Effekte werden zur Laufzeit gezeichnet (CustomPaint) — keine
externen Grafik-Assets.

| Datei | Quelle | Lizenz |
|---|---|---|
| `assets/icon/icon.png` | Selbst erstellt (prozedural, Pillow) | Eigenwerk / CC0 |
| `assets/icon/icon_foreground.png` | Selbst erstellt (adaptiver Vordergrund) | Eigenwerk / CC0 |

Aus diesen Quellen generiert `flutter_launcher_icons` die Android-Mipmaps und
das iOS-AppIcon-Set.

## Schrift

| Datei | Quelle | Lizenz |
|---|---|---|
| `assets/fonts/Nunito.ttf` | Nunito (Vernon Adams, Cyreal, Jacques Le Bailly) via Google Fonts | SIL Open Font License 1.1 |

Nunito ist unter der **SIL OFL 1.1** frei nutzbar (auch kommerziell,
Einbettung erlaubt). Variable Schrift — eine Datei deckt alle Gewichte ab.
Lizenztext: https://openfontlicense.org

### Nur für Store-Grafiken (nicht in der App)

Die Screenshot-Werkzeuge (`tool/generate_screenshots.dart`,
`tool/caption_screenshots.py`, `tool/feature_graphic.py`) rendern mit zwei
Systemschriften, die **nicht** gebündelt werden — sie stecken nur als
gezeichnete Pixel in den PNGs unter `store-assets/`:

| Schrift | Wofür | Quelle | Lizenz |
|---|---|---|---|
| Noto Sans CJK (Regular, Bold) | Japanisch und Koreanisch — Nunito hat keine Kana/Kanji/Hangul; auf Android zeichnet das Handy diese Texte ebenfalls in Noto Sans CJK | Debian/Ubuntu-Paket `fonts-noto-cjk` | SIL OFL 1.1 (laut `/usr/share/doc/fonts-noto-cjk/copyright`) |
| Noto Color Emoji | Emojis in den Screenshots | Debian/Ubuntu-Paket `fonts-noto-color-emoji` | Schriftdatei SIL OFL 1.1 (laut Paket-`copyright`) |
