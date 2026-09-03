# Qubble — Balance-Analyse

> **Nachtrag Phase 2.** Die unten empfohlenen Konstanten sind umgesetzt
> (Commit `Cap the combo…`) und **nachgemessen**. Eine meiner Prognosen war
> falsch — siehe „Nachtrag: Was der Combo-Deckel wirklich bewirkt hat" am Ende.
> Die Zahlen im Haupttext beschreiben den Zustand *vor* diesen Änderungen.


Stand: 2026-08-26 · Commit `c6d2b05`
Erzeugt mit `scripts/audit/soak.dart` (60.000 Runden) und
`scripts/audit/balance.dart` (15.000 Runden über 5 Heuristiken).
Technische Befunde: siehe `AUDIT.md`.

Die Spiellogik ist deterministisch und headless lauffähig, deshalb sind alle
folgenden Zahlen gemessen, nicht geschätzt. Was simuliert wurde, ist ein Spieler,
der eine feste Heuristik konsequent anwendet — die Obergrenze menschlicher
Konstanz. Reale Spieler liegen zwischen `random` und `no-holes`.

---

## Zusammenfassung in einem Absatz

Das Spiel hat **mehr Tiefe, als es zeigt**. Die Spielweise entscheidet über den
Faktor 15 im Ergebnis (`corner-pack` 6.131 gegen `worst` 231 Punkte), es gibt
eine nicht offensichtliche dominante Strategie, und Fehlstarts existieren
praktisch nicht (0,00 % der Seeds sind vor Zug 10 verloren). Das trägt über zehn
Sitzungen. Zwei Dinge stehen dem im Weg: **die Combo ist keine
Spannungsmechanik mehr**, weil sie in 70,7 % aller Züge aktiv ist und faktisch nie
abläuft — was die Punktzahl zu einer superlinearen Funktion der Rundenlänge macht
und die Bestenliste zu einer Rundenlängen-Lotterie mit p95/p05 = 31,6×. Und
**die Belohnungskurve ist für den Playtest 3-5× zu langsam kalibriert**: Tester
werden in 10-20 Runden weder das Sparschwein noch einen Skin sehen und daraus
schließen, es gebe nichts zu erreichen.

---

## D.1 Dominante Strategie

15.000 Runden, 3.000 identische Seeds pro Heuristik, jede Heuristik wählt aus
allen legalen Zügen.

| Heuristik | Was sie tut | Score ø | Median | Züge ø | Linien ø | Combo max ø | Fieber/Runde | rel. |
|---|---|---|---|---|---|---|---|---|
| `corner-pack` | Masse in eine Ecke drücken, dann räumen | **6.131** | 4.263 | 48,2 | 18,0 | 10,53 | 0,99 | **100 %** |
| `greedy-size` | größtes Teil zuerst, egal wohin | 5.280 | 3.485 | 45,1 | 16,5 | 9,43 | 0,88 | 86 % |
| `no-holes` | Clears, aber keine Einzellöcher hinterlassen | 4.586 | 3.020 | 42,0 | 15,3 | 8,53 | 0,82 | 75 % |
| `lines-first` | immer sofort räumen, was räumbar ist | 4.382 | 2.958 | 41,6 | 14,9 | 8,64 | 0,74 | 71 % |
| `keep-empty` | Brett möglichst leer halten | 4.377 | 2.953 | 41,6 | 14,9 | 8,63 | 0,73 | 71 % |

**Es gibt eine dominante Strategie, und es ist nicht die, die das Spiel lehrt.**
`corner-pack` — Teile kompakt in eine Ecke stapeln und erst dann räumen — schlägt
das intuitive „räum sofort, was du räumen kannst" um **40 %**. Der Grund ist
mechanisch: die Ecke hält zusammenhängende Freiflächen offen, in die große Teile
(`square3`, `lbig_*`, `line5_*`) noch passen. Wer sofort räumt, zerfasert das
Brett und stirbt früher.

Die Spielanleitung (`how_to_play_screen.dart:34`) lehrt aktiv die schwächere
Variante („Fülle eine komplette Reihe oder Spalte"), und der Onboarding-Hinweis
in der Runde ebenfalls. Das ist kein Fehler — es ist der richtige Einstieg —
aber es bedeutet: **die eigentliche Tiefe des Spiels ist nirgends kommuniziert**
und wird von den meisten Spielern nie entdeckt.

*Vorschlag:* Nicht die Anleitung ändern. Stattdessen einen späteren Coach-Hinweis
ergänzen (er würde perfekt ins bestehende `CoachHints`-System passen, das schon
vier Auslöser hat): nach ~5 Runden „Tipp: Nicht jede Reihe sofort räumen — halte
Platz für große Teile frei." Das gibt dem Spiel eine zweite Lernstufe, die es
mechanisch bereits hat.

**Bandbreite:** Zwischen bester und schlechtester Heuristik auf demselben Seed
liegt im Median der Faktor **6,3×**. Können schlägt Zufall deutlich. Das ist der
wichtigste positive Balance-Befund.

---

## D.2 Schwierigkeitskurve — wo Runden enden

3.000 Seeds, Heuristik `no-holes` (der realistische „kompetente Spieler").

| Züge | Anteil | ≈ Spielzeit | |
|---|---|---|---|
| 1-10 | 0,2 % | 22 s | ▏ |
| 11-20 | 13,2 % | 24-44 s | ██████▌ |
| 21-30 | 20,6 % | 46-66 s | ██████████▎ |
| 31-40 | 21,5 % | 68-88 s | ██████████▊ |
| 41-60 | 28,3 % | 90-132 s | ██████████████▏ |
| 61-80 | 10,3 % | 134-176 s | █████▏ |
| 81-120 | 4,9 % | 178-264 s | ██▌ |
| 121+ | 0,9 % | 266 s+ | ▍ |

**Es gibt keine Wand.** Die Verteilung ist eine glatte, leicht rechtsschiefe
Glocke ohne Sprung. Das Spiel wird nicht plötzlich schwerer — es wird
kontinuierlich schwerer, weil das Brett voller wird. Genau richtig für das Genre.

**Es gibt auch keine Langeweile-Strecke.** Die ersten 10 Züge sind durch den
Fairness-Bonus (`generator.dart:9`, ×1,5 auf platzierbare Teile; für die
allererste Runde 20 Züge) sanft, aber nicht trivial: 13,4 % aller Runden enden
bereits vor Zug 21.

Was diese Kurve **nicht** hat: einen Wendepunkt, an dem das Spiel den Charakter
wechselt. Von Zug 5 bis Zug 80 ist die Aufgabe dieselbe. Zusammen mit D.4 ist das
der Grund, warum Runde 5 sich nicht anders anfühlt als Runde 1.

---

## D.3 Punkte-Zusammensetzung — und das Combo-Problem

`no-holes`, 3.000 Runden:

| Quelle | Punkte ø | Anteil |
|---|---|---|
| Platzieren (1 Punkt/Zelle) | 158 | **3,4 %** |
| Clears inkl. Linien-, Combo- und Fieber-Multiplikator | 4.428 | **96,6 %** |

**Die Platzierungspunkte sind numerisch tot.** 1 Punkt pro Zelle über eine ganze
Runde ergibt 3,4 % der Endpunktzahl — weniger als der Rundungsfehler eines
einzigen Vierfach-Clears. Als Feedback („jeder Zug bringt etwas") haben sie einen
Sinn, als Balance-Größe keinen.

### Die Combo läuft nie ab

| Messwert | Wert |
|---|---|
| Züge mit aktiver Combo (> 1) | **70,7 %** |
| Runden ganz ohne Combo | 2,1 % |
| Höchste erreichte Combo, Durchschnitt | 8,5 (`no-holes`) bis 10,5 (`corner-pack`) |

`scoring.dart:118` — die Combo überlebt seit dem Umbau nicht-räumende Züge und
stirbt nur an der Uhr (10 s Fenster). Ein kompetenter Spieler räumt alle ~2,8
Züge eine Linie, bei ~2,2 s pro Zug also alle ~6 s. **Das Fenster schließt sich
nie.** Verifiziert in `scripts/audit/verify_findings.dart`, Test A-6.

Die Folgen sind gravierender, als es aussieht:

1. **Die Combo ist keine Entscheidung mehr.** Sie ist ein Zähler, der mit der
   Rundenlänge mitwächst. Der Countdown-Balken im Header
   (`game_screen.dart:610`) zeigt eine Spannung an, die es nicht gibt.
2. **Der Multiplikator ist ungedeckelt.** `1.0 + (combo - 1) × 0.5`
   (`scoring.dart:123`). Bei Combo 20 sind das 10,5× — multiplikativ **auf den
   Linien-Multiplikator obendrauf**, der bei 4 gedeckelt ist. Ein Vierfach-Clear
   bei Combo 20 ist rund 12.600 Punkte, derselbe Clear bei Combo 1 rund 1.200.
3. **Deshalb explodiert die Streuung.** Punktzahl ≈ Rundenlänge², nicht
   Rundenlänge. Siehe D.4.

*Vorschlag:* Combo-Multiplikator bei 4,0× deckeln (= Combo 7) **oder** das Fenster
auf 5-6 s halbieren, damit es wieder eine echte Entscheidung ist („räume ich
jetzt suboptimal, um die Combo zu halten?"). Der Deckel ist die sicherere
Änderung vor einem Playtest — er verändert die Bestenliste, nicht das Spielgefühl.

### Fieber und All-Clear werden von den meisten nie gesehen

| Mechanik | Häufigkeit | Belohnung |
|---|---|---|
| Fieber-Ausbruch | **46,7 % der Runden haben keinen einzigen** | Clear-Punkte ×2 |
| All-Clear | **1,97 % der Runden** | +300 Punkte |

Das Fieber füllt sich mit 0,2 pro Linie und baut 0,1 pro clear-losem Zug ab
(`scoring.dart:49-50`). Bei 15 Linien und 42 Zügen steht Aufbau 3,0 gegen Abbau
~2,7 — es reicht für ø 0,8 Ausbrüche. Fast die Hälfte der Spieler erlebt die
Mechanik nie, obwohl die Spielanleitung ihr eine eigene Karte widmet und das
Board dauerhaft einen Fieber-Glow-Layer mitschleppt.

Der All-Clear ist noch krasser: 1 von 50 Runden, und **+300 Punkte sind bei einem
Rundenschnitt von 4.586 belanglos** — ein einzelner Dreifach-Clear bringt mehr.
Dafür existiert eine eigene Banner-Animation (`juice_overlay.dart:59`) und ein
Münz-Bonus. Viel Aufwand für Inhalt, den fast niemand sieht und der sich nicht
lohnt, wenn man ihn sieht.

*Vorschlag:* Fieber-Abbau von 0,1 auf 0,05 senken → ~2 Ausbrüche pro Runde,
Mechanik wird für ~85 % der Spieler real. All-Clear-Bonus von 300 auf 1.500
anheben und die Fieberleiste sofort füllen — dann ist es der Ausnahmemoment, als
den die Animation ihn bereits inszeniert.

---

## D.4 Zufall gegen Können, und Fehlstart-Fairness

### Fehlstarts: gelöst

| Messwert | Wert |
|---|---|
| Seeds, bei denen **keine** der 5 Heuristiken über 10 Züge kommt | **0,00 %** |
| Seeds, bei denen keine über 15 Züge kommt | **0,10 %** |
| Frische Runden, die sofort tot starten (3.000 Seeds) | **0** |

Die Rettungsregel im Generator (`generator.dart:43`) plus die
Rotations-Berücksichtigung in der Game-Over-Prüfung
(`game_session.dart:374`) funktionieren. Eine unrettbare Ausgangslage ist
strukturell unmöglich, weil das Brett nie 64 belegte Zellen erreichen kann und
damit immer mindestens das `dot`-Teil passt. **Hier ist nichts zu tun.**

### Streuung: zu hoch

| Messwert | `no-holes` | `random` |
|---|---|---|
| σ / ø | **1,07** | 1,40 |
| p95 / p05 | **31,6×** | — |
| bester vs. schlechtester Seed | 48.091 gegen 29 | — |

Bei **identischer Spielweise** trennt Seed-Glück die Ergebnisse um den Faktor
31,6. Das ist zu viel: Ein Spieler kann aus einer verlorenen Runde nicht
ableiten, ob er schlecht gespielt hat. Umgekehrt fühlt sich ein Rekord nicht
verdient an.

Die Ursache ist **nicht** ein unfairer Generator (D.4 oben), sondern die
ungedeckelte Combo aus D.3: Wer 10 Züge länger überlebt, bekommt nicht 25 % mehr
Punkte, sondern das Doppelte, weil der Multiplikator inzwischen höher steht. Der
Combo-Deckel aus D.3 würde p95/p05 rechnerisch auf etwa 8-12× drücken — eine
Größenordnung, in der Können sichtbar bleibt und Pech verkraftbar ist.

Zum Vergleich: Können bringt 6,3× (D.1), Zufall 31,6×. **Aktuell entscheidet der
Seed drei- bis fünfmal stärker über die Bestenliste als die Spielweise.** Das ist
die zentrale Balance-Aussage dieses Berichts.

---

## D.5 Sitzungslänge

Eine Runde, `no-holes`, bei 2,2 s pro Zug:

| p25 | Median | p75 | p95 |
|---|---|---|---|
| 57 s | **84 s** | 117 s | 183 s |

Für ein Handyspiel gut getroffen — eine Runde passt in eine Bushaltestelle. Eine
typische Sitzung von 3-5 Runden plus Belohnungsbildschirme liegt bei 5-8 Minuten.

Das Game-Over-Overlay bietet „Nochmal spielen" als primäre, sofortige, kostenlose
Aktion (`game_screen.dart:846`) — die Schleife schließt sich in einem Tipp. Sauber.

---

## D.6 Tote Inhalte

Statistisch wertlose oder nie erreichte Elemente, nach Schwere:

| Element | Befund | Beleg |
|---|---|---|
| **Rätsel-Sterne 1 und 2** | **Unerreichbar.** Das Brett leert sich per Konstruktion exakt nach dem letzten Teil, also gilt immer `moves == minMoves` → 3 Sterne. Die Sternanzeige auf 3 Screens ist Dekoration. | Test A-3, 40 Level |
| **Rätsel-Schwierigkeit ab Level ~20** | **Flach.** `bandCount` sättigt bei Level 9 (`.clamp(2,5)`), `maxPieces = 10` deckelt den Rest. Level-Block 20-39: ø 7,75 Züge · 180-199: ø 7,45 Züge. Level 199 ist so leicht wie Level 20. | Test A-4, 200 Level |
| **Sparschwein** | 1 Münze pro Linie, Kapazität 500, ø 15 Linien/Runde → **erste Auszahlung nach ~33 Runden** (≈ 50 min). Im Playtest unsichtbar. Zudem 3× langsamer als die direkte Münzbelohnung daneben (3/Linie). | `piggy_bank.dart:73`, Soak |
| **Belohnungspfad ab Level 5** | 8 der 11 Kosmetika liegen bei Level 8-40 = **88 bis 475 Runden**. | D.7 |
| **All-Clear** | 1,97 % der Runden, +300 Punkte bei ø 4.586 Rundenpunkten. | D.3 |
| **Fieber** | 46,7 % der Runden ohne einen einzigen Ausbruch. | D.3 |
| **Platzierungspunkte** | 3,4 % der Endpunktzahl. | D.3 |
| **Missionen** | ~~5 Stück, einmalig, keine Rotation. Nach ~10 Runden dauerhaft erledigt.~~ **Behoben 02.09.2026:** gestaffelt in sechs Stufen je Metrik, Fortschritt wird pro Metrik geführt und trägt über die Stufen. | `missions.dart` |
| **Combo-Countdown-Balken** | Zeigt eine Frist an, die im normalen Spiel nie abläuft. | D.3 |
| `square3` (3×3, 9 Zellen) | Wird mit 2,48 % erwartet, aber nur zu **1,51 %** platziert — es passt oft nicht und blockiert dann die Ablage. Kein Fehler, aber das mit Abstand „ärgerlichste" Teil. | D.8 |

Nicht tot: die Booster. Bei ~100-200 Münzen pro Runde sind Undo (50), Tausch (75)
und Bombe (150) nach 1-2 Runden bezahlbar, Revive (200) nach 1-2 Runden. Die
Preisstaffel sitzt.

---

## D.7 Level-Fortschritt

`xpForRun = score ÷ 100`, `xpForNext(level) = 100 + 50 × level`
(`leveling.dart:14`, `:21`).

| Level | XP kumuliert | Runden (Median 2.447, kompetent) | Runden (Median 218, Erstspieler) | Belohnung |
|---|---|---|---|---|
| 2 | 150 | 7 | 75 | — |
| 3 | 350 | 15 | 175 | Fade-Theme · *Gratis-Drehen endet hier* |
| 4 | 600 | 25 | 300 | — |
| 5 | 900 | 38 | 450 | Verlauf-Skin |
| 8 | 2.100 | 88 | 1.050 | Ocean-Theme |
| 12 | 4.400 | 184 | 2.200 | Glanz-Skin |
| 16 | 7.500 | 313 | 3.750 | Wood-Theme |
| 20 | 11.400 | 475 | 5.700 | Kontur-Skin |

Zwei Probleme:

1. **Für Erstspieler steht die Leiste still.** Bei 200-500 Punkten pro Runde sind
   das 2-5 XP. Der Home-Screen zeigt „Level 1 · 0/150 XP" und bewegt sich in den
   ersten 20 Runden kaum sichtbar. Genau die Spieler, die Fortschritt am
   dringendsten brauchen, bekommen ihn am langsamsten. Die XP-Formel bestraft
   Anfänger doppelt: Sie spielen schlechter *und* die Belohnung skaliert linear
   mit dem Score.
2. **Die Regeln ändern sich still.** Drehen ist bis Level 2 gratis
   (`game_controller.dart:292`), ab Level 3 kostet es Ladungen — und die Umstellung
   greift erst bei der nächsten `newGame()`. Der Spieler bekommt keine Ankündigung,
   nur irgendwann die Meldung „Keine Drehungen übrig".

*Vorschlag:* XP-Formel auf einen Sockel + Score-Anteil umstellen, z. B.
`10 + score ÷ 100`. Dann braucht Level 2 auch bei 200 Punkten nur ~12 Runden statt
75, während der Abstand für gute Spieler kaum schrumpft. Und beim Übergang auf
Level 3 einen einmaligen Hinweis zeigen: „Ab jetzt kostet Drehen eine Ladung —
räume Reihen, um sie aufzuladen."

---

## D.8 Teile-Verteilung

1,44 Mio. platzierte Teile, alle Strategien zusammen. Erwartung = Gewichtsanteil
am Katalog.

| Teil | Zellen | Gewicht | erwartet | gemessen | Δ |
|---|---|---|---|---|---|
| `square3` | 9 | 3 | 2,48 % | **1,51 %** | **−0,97** |
| `rect2x3` | 6 | 4 | 3,31 % | 2,88 % | −0,43 |
| `rect3x2` | 6 | 4 | 3,31 % | 2,90 % | −0,40 |
| `line2_v` | 2 | 6 | 4,96 % | 5,28 % | +0,32 |
| `line2_h` | 2 | 6 | 4,96 % | 5,26 % | +0,30 |
| *alle übrigen 24* | | | | | \|Δ\| < 0,25 |

Der Generator arbeitet erwartungstreu: 24 von 29 Teilen liegen innerhalb von
0,25 Prozentpunkten. Die Abweichungen sind kein Generator-Fehler, sondern die
natürliche Folge davon, dass große Teile seltener passen und länger in der Ablage
liegen bleiben.

Die Rettungsregel (`generator.dart:43`) verzerrt die Verteilung nicht messbar —
sie greift so selten, dass sie in 1,44 Mio. Zügen unter dem Rauschen bleibt.

**Kein totes Teil im Katalog.** Alle 29 Einträge werden regelmäßig platziert.
`square3` ist an der Grenze zum Ärgernis, aber das ist eine Design-Entscheidung
(das 3×3 ist im Genre das „Problemteil"), keine Fehlkonfiguration.

---

## D.9 Punkte-Kurve (Referenz)

Aus `ScoreKeeper` (`scoring.dart:43`), bei Combo 1 und ohne Fieber:

| Geräumte Linien | ca. Zellen | Linien-Mult | Punkte |
|---|---|---|---|
| 1 | 8 | 1 | ~80 |
| 2 | 15 | 2 | ~300 |
| 3 | 23 | 3 | ~690 |
| 4 | 30 | 4 | ~1.200 |
| 5 | 38 | 4 *(gedeckelt)* | ~1.520 |

Multiplikativ obendrauf: Combo `1 + (n−1) × 0,5` **ungedeckelt**, Fieber ×2.
All-Clear +300 additiv.

Die Staffelung 1 → 4 Linien ist mit dem Faktor 15 sehr steil und funktioniert:
Sie ist der Grund, warum `corner-pack` gewinnt, und damit die Quelle der Tiefe.
Der Deckel bei 4 Linien ist korrekt gesetzt. **Das einzige, was hier nicht
stimmt, ist die fehlende Obergrenze bei der Combo.**

---

## Empfohlene Änderungen, nach Wirkung pro Aufwand

| # | Änderung | Datei | Wirkung |
|---|---|---|---|
| 1 | Combo-Multiplikator bei 4,0× deckeln | `scoring.dart:123` | p95/p05 von 31,6× auf ~10×; Bestenliste wird zur Können-Rangliste |
| 2 | Sparschwein: `coinsPerLine` 1 → 3 **oder** `baseCapacity` 500 → 200 | `piggy_bank.dart:73` | Erste Auszahlung nach ~11 statt 33 Runden — im Playtest sichtbar |
| 3 | XP-Sockel: `10 + score ÷ 100` | `leveling.dart:21` | Level 2 für Erstspieler nach ~12 statt 75 Runden |
| 4 | Fieber-Abbau 0,1 → 0,05 | `scoring.dart:50` | Fieber für ~85 % statt 53 % der Runden erlebbar |
| 5 | All-Clear-Bonus 300 → 1.500 | `scoring.dart:51` | Der seltene Moment lohnt sich endlich |
| 6 | Rätsel-Sterne an geräumte-Linien-Effizienz koppeln statt an Zugzahl | `puzzle.dart:223` | 1 und 2 Sterne werden erreichbar |
| 7 | 2-3 rotierende Tagesmissionen | `missions.dart:49` | Missionen-Screen bleibt dauerhaft lebendig |
| 8 | Später Coach-Hinweis „nicht jede Reihe sofort räumen" | `coach_hints.dart` | Macht die vorhandene zweite Lernstufe sichtbar |

Punkte 1-5 sind Konstantenänderungen — jede einzeilig, alle durch die
bestehenden Unit-Tests abgedeckt und mit `scripts/audit/balance.dart` sofort
nachmessbar.

---

## Nachtrag: Was der Combo-Deckel wirklich bewirkt hat

Gemessen mit `scripts/audit/balance.dart 2000` nach der Umsetzung von
Deckel (4,0×), Fieber-Abbau (0,1 → 0,05) und All-Clear-Bonus (300 → 1.500).

| Messwert | vorher | nachher | Ziel erreicht? |
|---|---|---|---|
| Runden ohne Fieber-Ausbruch | 46,7 % | **23,9 %** | ja |
| Fieber-Ausbrüche pro Runde | 0,82 | **1,52** | ja |
| Streuung σ/ø (no-holes) | 1,07 | **0,86** | ja |
| p95/p05 Score | 31,6× | **23,4×** | teilweise |
| Können-Spanne (beste/schlechteste Heuristik) | 6,3× | **4,7×** | — |
| **Verhältnis Können : Zufall** | **1 : 5,0** | **1 : 5,0** | **nein** |

**Meine Prognose war falsch.** Ich hatte geschrieben, der Deckel würde
p95/p05 auf 8-12× drücken und damit Können gegenüber Zufall stärken. Er
drückt die Streuung, aber er skaliert Können und Glück **gleichmäßig**
herunter — das Verhältnis bleibt exakt 1:5. Der Grund: beide äußern sich
über dieselbe Größe, die Rundenlänge, und der Score wächst in beiden Fällen
superlinear damit. Ein Deckel auf einem der Multiplikatoren senkt den
Exponenten für alle Runden gleich.

Was die Streuung wirklich trägt, ist die Linien-Staffelung (1 Linie ≈ 80
Punkte, 4 Linien ≈ 1.200 — Faktor 15). Genau die ist aber die Quelle der
Tiefe: sie ist der Grund, warum `corner-pack` gewinnt. Sie zu glätten würde
das Spiel flacher machen, nicht fairer.

**Fazit:** Ein p95/p05 um 20× ist für dieses Genre weitgehend inhärent. Der
Deckel bleibt trotzdem richtig — er beendet eine unbegrenzte Rampe, macht das
Fieber für drei Viertel statt der Hälfte der Spieler erlebbar und senkt σ/ø
spürbar. Aber er ist **keine** Antwort auf „Zufall schlägt Können in der
Bestenliste". Wenn dir das wichtig ist, ist der wirksame Hebel eine andere
Bestenlisten-Metrik statt eines anderen Score-Modells: Punkte pro Zug,
oder eine Wochen-Bestenliste über den Median mehrerer Runden statt über den
Einzelbestwert. Das ist eine Produktentscheidung, keine Konstante — und
nichts, was vor dem Playtest passieren muss.

---

## Nachtrag 2: Die Bestenlisten-Metrik, nachgemessen (02.09.2026)

Werkzeug: `scripts/audit/leaderboard_metric.dart`, 200 simulierte Spieler ×
20 Runden × 5 Spielweisen, disjunkte Seed-Blöcke, jeder Block für jede
Spielweise identisch — so kürzt sich der Seed heraus.

### Zuerst: meine eigene Zahl war falsch berechnet

Das oben mehrfach zitierte Verhältnis **1 : 5,0** vergleicht zwei Größen, die
auf **unterschiedlichen Basen** entstanden sind:

- Die Glücks-Zahl (23,4×) ist p95/p05 bei **einer festen** Spielweise.
- Die Können-Zahl (4,7×, oben auch 6,3×) ist `max/min` über fünf Spielweisen
  **pro Seed**. Das ist eine Ordnungsstatistik über fünf verrauschte Werte —
  sie enthält den Seed-Zufall also selbst, statt ihn zu messen.

Auf gleicher Basis gerechnet, feste stärkste gegen feste schwächste Spielweise:

| Basis Einzelrunde | Wert |
|---|---|
| Seed-Glück p95/p05 (`no-holes`) | **24,7×** |
| Können, `corner-pack` gegen `lines-first` | **1,24×** |
| Verhältnis Können : Glück | **1 : 20** |

Auf eine einzelne Runde bezogen ist das Problem also **viermal größer**, als
oben behauptet, nicht kleiner.

### Aber die Bestenliste bewertet keine Einzelrunde

Sie führt `max(score)` über die gesamte Historie eines Spielers. Über 20 Runden
gemessen, alle vier Kandidaten auf denselben Daten:

| Metrik | Seed-Glück p95/p05 | Können best/schlecht. | Können : Glück | 20 gegen 5 Runden |
|---|---|---|---|---|
| **A max Score** (heute) | 2,9× | **1,25×** | 1 : 2,3 | **1,43×** |
| B max Punkte/Zug | 1,6× | 1,05× | 1 : 1,5 | 1,20× |
| C Median Score | 2,3× | **1,28×** | 1 : 1,8 | 0,88× |
| D Median Punkte/Zug | 1,5× | 1,12× | 1 : 1,3 | 0,98× |

Zwei Dinge daran sind neu:

**Die Aggregation erledigt den Großteil der Arbeit schon.** Aus 1 : 20 auf der
Einzelrunde wird 1 : 2,3, sobald über eine Historie gemaximiert wird. Der
Bestwert mittelt das Seed-Pech weg, weil Pech nur nach unten wirkt und der
Bestwert nur nach oben schaut.

**Punkte pro Zug verbessert das Verhältnis, indem es das Können zerstört.** Von
1,25× auf 1,05×: Zwischen der stärksten und der schwächsten Spielweise liegen
dann fünf Prozent. Das ist keine Können-Rangliste, das ist eine flache Liste.
Die Kennzahl „Können : Glück" allein ist irreführend — sie steigt auch, wenn
beide Seiten schrumpfen und die stärkere schneller.

Nur **C (Median Score)** ist auf allen drei Achsen besser als heute: mehr
Können, weniger Glück, und der Vorteil des reinen Vielspielens (1,43×)
verschwindet. Der Gewinn ist mit 1 : 2,3 → 1 : 1,8 aber klein, und er kostet
die Vergleichbarkeit jedes bestehenden Eintrags.

### Grenzen dieser Messung

Die Können-Spanne ist zwischen **fünf plausiblen Bots** gemessen, nicht
zwischen einem Anfänger und einem geübten Menschen. Die echte menschliche
Spanne ist größer, also ist das gemessene Verhältnis eine **untere Schranke**
für das Können — das reale Bild ist besser, nicht schlechter, als die Tabelle.
(`lines-first` und `keep-empty` liefern identische Werte: wer sofort räumt,
hält damit auch das Brett leer, beide Heuristiken wählen dieselben Züge. Das
ist eine Redundanz im Werkzeug, kein Messfehler — die Spanne wird davon nicht
berührt, weil sie an den Rändern entsteht.)

### Was daraus folgt

Kein Metrikwechsel. Was tatsächlich folgt, ist der Punkt aus D.1, der noch
offen war: `corner-pack` liegt bei 5.025 Durchschnittspunkten gegen 3.781 für
`lines-first` (`scripts/audit/balance.dart 800`) — **die Anleitung lehrt die um
33 % schwächere Variante**, und die stärkere ist nirgends erwähnt. Das ist
keine Balance-Frage, sondern eine Kommunikationslücke, und sie ist ohne
Eingriff in Punkte oder Ränge zu schließen: ein später Coach-Hinweis nach fünf
Runden (`CoachHints.strategyAfterGames`).

---

## Nachtrag 3: Das Combo-Fenster läuft jetzt in Zügen (02.09.2026)

Werkzeug: `scripts/audit/combo_window.dart`, 1.500 Seeds, Heuristik
`no-holes`. Die Uhr-Spalte ist **vor** der Umstellung gemessen; sie ist
heute nicht mehr reproduzierbar, weil `GameSession` keinen Zeit-Eingang mehr
hat.

### Der Befund

Die Combo verfiel nach zehn **Sekunden** — in einem Spiel, dessen
Beschreibung ausdrücklich verspricht, dass es keinen Zeitdruck gibt. Das war
keine neutrale Regel: 96,6 % aller Punkte laufen über den Combo-Multiplikator
(D.3). Dieselben Seeds, dieselbe Spielweise, nur unterschiedlich schnell
gespielt:

| Spieltempo | Score ø (Uhr, vorher) | Score ø (3 Züge, heute) |
|---|---|---|
| 1,5 s/Zug | 5.354 | 4.140 |
| 2,2 s/Zug | 4.140 | 4.140 |
| 4,0 s/Zug | 2.483 | 4.140 |
| 6,0 s/Zug | 2.077 | 4.140 |

**Faktor 2,6 allein durch Tippgeschwindigkeit**, auf einer öffentlichen
Bestenliste. Wer länger überlegt, wurde bestraft — und zwar unsichtbar, weil
der Balken zwar lief, aber niemand ihn als Punkteabzug liest.

Zur Einordnung: Das ist **größer als der gesamte Können-Unterschied** zwischen
der stärksten und der schwächsten Spielweise (1,24×, Nachtrag 2). Die Uhr
entschied über die Bestenliste doppelt so stark wie die Spielweise.

### Warum drei Züge

| Fenster | Score ø | Median | p95/p05 | Züge mit Combo | Combo max ø | rel. |
|---|---|---|---|---|---|---|
| 2 Züge | 3.490 | 2.683 | 20,3× | 54,8 % | 6,54 | 84 % |
| **3 Züge** | **4.140** | **3.124** | **23,3×** | 66,9 % | **8,51** | **100 %** |
| 4 Züge | 4.846 | 3.770 | 25,8× | 75,4 % | 11,22 | 117 % |
| 5 Züge | 5.354 | 4.162 | 28,0× | 80,1 % | 13,48 | 129 % |
| 6 Züge | 5.475 | 4.337 | 23,4× | 81,4 % | 14,08 | 132 % |

Drei Züge treffen die alte Verteilung **exakt**: Mittelwert 4.140 gegen 4.140,
Median 3.124 gegen 3.124, p95/p05 23,3× gegen 23,3×, Combo-Maximum 8,51 gegen
8,51. Die Änderung nimmt also die Tempo-Abhängigkeit heraus, **ohne** ein
verstecktes Balance-Update zu sein — genau das war die Bedingung, unter der
sie überhaupt vertretbar ist.

### Was mit geändert wurde

Die Uhr ist nicht abgeschaltet, sondern **entfernt**: `GameSession` hat keinen
`clock`-Parameter mehr. Eine Regel, die man wieder einführen kann, wird
irgendwann wieder eingeführt; ein Feld, das nicht existiert, nicht. Der
Unit-Test „nothing about the combo depends on wall-clock time" hält das fest.

Mitgezogen, weil sie sonst falsch geworden wären:

- **Anleitung** (`howToPlayComboBody`): „innerhalb von 10 Sekunden" →
  „innerhalb von drei Zügen … überlegen darfst du so lange du willst".
- **Coach-Hinweis** (`coachHintCombo`): dieselbe Korrektur.
- **HUD**: der ablaufende Zeitbalken ist durch drei Punkte ersetzt, die mit
  jedem zuglosen Zug ausgehen. Ein Zeitbalken wäre ab jetzt eine Lüge.
- **Checkpoint**: ein vor der Umstellung gespeicherter Lauf trägt
  `lastClearMillis`. Das fehlende `movesSinceClear` wird als 0 gelesen, die
  Combo bleibt also erhalten — die einzige Lesart, die niemanden für ein
  Update bestraft, das er nicht angefordert hat.

---

## Nachtrag 4: Tempo zählt wieder — gedeckelt (02.09.2026)

Nachtrag 3 hatte die Tempo-Abhängigkeit vollständig entfernt. **Das war zu
weit.** Schnell zu spielen ist ein wesentlicher Reiz des Genres; ein Spiel, in
dem Hektik und Bedächtigkeit exakt gleich viel wert sind, verliert einen
Antrieb, den es gar nicht verlieren musste. Das eigentliche Problem war nie der
Bonus, sondern **wo er ansetzte**.

### Warum es vorher entgleiste

Die Uhr fütterte den **Combo-Multiplikator**. Der wächst mit der Rundenlänge,
also multiplizierte sich ein kleiner Tempo-Vorteil pro Zug über die ganze Runde
auf: **Faktor 2,6** zwischen 1,5 s und 6 s pro Zug (Nachtrag 3). Der neue Bonus
ist bewusst andersherum gebaut — **additiv, einmal pro geräumter Linie,
gedeckelt** — und rührt den Multiplikator nicht an. Damit kann der Vorsprung
nicht mit der Rundenlänge wachsen; ein Unit-Test prüft das über 2, 10 und 40
verkettete Clears.

### Gemessen

`scripts/audit/combo_window.dart 800`, gleiche Seeds, gleiche Spielweise, nur
anderes Tempo:

| Spieltempo | Score ø | rel. zum langsamsten |
|---|---|---|
| 1,0 s/Zug | 5.322 | **128,6 %** |
| 1,5 s/Zug | 5.322 | 128,6 % |
| 2,2 s/Zug | 4.990 | 120,5 % |
| 3,0 s/Zug | 4.611 | 111,4 % |
| 4,0 s/Zug | 4.139 | 100,0 % |
| 6,0 s/Zug | 4.139 | 100,0 % |

**+28,6 % gemessen bei 30 % Deckel** — die Lücke sind die Platzierungspunkte
(3,4 % des Scores), die keinen Bonus bekommen. Vorher: +158 %.

Zwei Eigenschaften, die dabei herauskommen und wichtiger sind als die Zahl
selbst:

**Die neue Spanne liegt vollständig in der alten.** 4.139–5.322 gegen vorher
2.077–5.354. Kein bestehender Bestenlisten-Eintrag wird dadurch unerreichbar
oder trivial — die Regeländerung verschiebt niemanden aus dem Feld.

**Über 4 Sekunden gibt es keine weitere Strafe.** Wer sechs Sekunden überlegt,
verliert genauso wenig wie jemand mit vier — der Bonus ist bei null, nicht
negativ. Das ist der Unterschied zu einer Uhr, die immer weiter abzieht.

### Regelwerk

| | |
|---|---|
| Voller Bonus | bis 1,5 s zwischen zwei Zügen |
| Linear fallend | 1,5 s bis 4,0 s |
| Kein Bonus | ab 4,0 s |
| Deckel | 30 % auf die Punkte **einer** geräumten Linie |
| Combo | unberührt — zählt weiter **Züge**, nie Sekunden |

Der Bonus ist im HUD sichtbar (`⚡ +24 %`, läuft mit). Das ist keine Zierde: Die
alte Regel war **unsichtbar**, deshalb las niemand den ablaufenden Balken als
Punkteabzug, und deshalb konnte sie eine Bestenliste still entscheiden. Ein
Anreiz, den man nicht sieht, ist keiner. Die Anleitung hat dafür eine eigene
Karte (`howToPlaySpeedTitle`) — und der Satz „überlegen darfst du so lange du
willst", den Nachtrag 3 dort eingetragen hatte, ist wieder raus: Er wäre jetzt
falsch. Für die Combo stimmt er weiterhin und steht dort.

**Ein fortgesetzter Lauf erbt keinen Zeitstempel.** Der Checkpoint speichert
ihn nicht, also bekommt der erste Zug nach dem Wiedereinstieg keinen Bonus —
und keine Strafe für eine Pause, die das Schließen der App war.
