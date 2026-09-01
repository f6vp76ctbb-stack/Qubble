# Icon-Variante für den A/B-Test

Kandidat für Test #1 aus `audit/05-aso.md`, Abschnitt 8. **Nicht** die
ausgelieferte Grafik — die liegt weiter in `assets/icon/` und
`store-assets/app-icon-512.png`.

Erzeugt mit `python3 tool/icon_variant.py`, deterministisch.

| Datei | Verwendung |
|---|---|
| `icon.png` | 1024×1024, Quelle für `flutter_launcher_icons` |
| `app-icon-512.png` | 512×512 deckend, Play-Console-Feld „App-Symbol" |
| `icon_foreground.png` | 1024×1024 mit Safe-Zone-Rand, adaptives Icon |

## Was getestet wird

Drei Unterschiede zum aktuellen Icon, alle aus der Icon-Kritik in
`audit/05-aso.md`:

1. **Es zeigt ein Blockteil, nicht nur ein Raster.** Die definierende Form des
   Genres ist ein mehrzelliges Teil; ein Feld gleichmäßiger Kacheln liest sich
   näher an einem Sudoku oder am generischen „Apps"-Glyph vieler Launcher.
2. **4×4 statt 3×3.** Näher am 8×8-Brett, ohne bei 48 px zu zerfallen.
3. **Hellerer Grund.**

## Was gegen die Variante spricht

Das gehört dazu, sonst ist der Test eine Formalie.

**Das aktuelle Icon ist bei 48 px kräftiger.** Alle neun Kacheln sind gesättigt,
das Icon ist eine dichte Farbfläche und setzt sich in einer Trefferliste
durch. Die Variante gibt einen Teil dieser Fläche an leere Zellen ab, um die
Teileform überhaupt zeigen zu können. Sie ist **beschreibender**, nicht
zwingend **auffälliger** — und was in der Play-Suche gewinnt, entscheidet der
Test, nicht diese Datei.

Gemessen wurde beides nebeneinander bei 48/72/96 px auf hellem und dunklem
Grund. Ein erster Entwurf mit Zellen in der In-App-Farbe (`0x424467`) fiel
dabei durch: Bei 48 px verschwanden die leeren Zellen und das Icon zerfiel zu
verstreuten Punkten. Die Zellfarbe hier ist deshalb heller als im Spiel, und
das Teil ist per Schlagschatten vom Brett getrennt statt allein per Kontrast.

**Die Annahme „die Kategorie ist durchgehend hell" ist unbelegt.** Die
Wettbewerber-Icons ließen sich in der Audit-Session nicht abrufen
(`play.google.com` ist gesperrt, siehe `audit/01-markt.md`). Der hellere Grund
ist deshalb eine Hypothese, kein Befund — und genau darum ein A/B-Test.

## Erfolgskriterium

Store-Listing-Conversion-Rate, Mindestlaufzeit 14 Tage. Ein Icon-Test läuft
zuerst, weil das Icon in jeder Oberfläche sichtbar ist — Suchergebnis,
Kategorie-Browse, „Ähnliche Apps" — und ein Titeltest davor die Titelwirkung
durch ein Icon hindurch misst, das die Klicks begrenzt.

Bei den Installationszahlen eines Solo-Titels kann ein Test 14 Tage ohne
verwertbares Signal laufen. Dann nach Augenmaß entscheiden und weitergehen,
nicht auf Signifikanz warten, die nicht kommt.
