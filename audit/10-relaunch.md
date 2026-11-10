# 10 — Relaunch: warum wenige installieren und wenige bleiben (09./10.11.2026)

Auftrag des Nutzers: „Es sind relativ wenige Downloads und Nutzer bleiben nicht
in der App." Geprüft wurde die App so, wie ein neuer Spieler sie erlebt (jeder
Bildschirm gerendert mit `tool/review_screens.dart`), der Code dahinter, die
Messungen in `BALANCE.md` und der Store-Auftritt im Repo.

**Was hier nicht steht:** echte Zahlen. Installationen, Store-Umwandlung,
D1/D7-Bindung und Sitzungslängen sieht nur der Nutzer (Play Console, Firebase).
Jeder Befund unten ist deshalb aus dem Produkt abgeleitet, nicht aus einer
Kurve. Welche Zahlen fehlen, steht am Ende.

---

## 1 · Warum Spieler nicht bleiben

### 1.1 · Vor dem ersten Block standen zwei Dialoge und ein Menü

Ablauf eines frischen Starts bis 1.5.3, aus `lib/ui/app_bootstrap.dart`:

| Schritt | Was der Spieler sah |
|---|---|
| 1 | Startmenü, darüber sofort: „Statistiken und Absturzberichte — erlauben?" (nicht wegtippbar) |
| 2 | Googles Werbe-Formular (in EU, UK, Schweiz) — bildschirmfüllend, in einem Spiel, dessen Werbung komplett freiwillig ist |
| 3 | Menü: Bestwert 0, drei leere Guthaben, sechs Knöpfe |
| 4 | Tipp auf „Spielen" → erster Block |
| 5 | Erstes Game Over (im Median nach anderthalb Minuten): Dialog „Tritt der Bestenliste bei" mit Namensfeld und Regeltext |
| 6 | Zweiter Start: „Erinnerungen?" |

Fünf Unterbrechungen in den ersten zwei Sitzungen, drei davon vor oder direkt
nach der ersten Runde. Rechtlich nötig ist keine an dieser Stelle: Statistiken
werden ohnehin erst nach einem Ja erhoben, und eine Werbe-Einwilligung braucht
es erst vor der ersten Anzeige.

**Behoben** (`lib/game/first_session.dart`, getestet): Brett zuerst; Statistik
nach dem ersten Game Over; Name frühestens nach Runde 2 bei neuem Bestwert;
Erinnerungen nach der ersten Daily; Werbe-Formular beim ersten Tipp auf ein
Bonus-Video.

### 1.2 · Runden waren kurz, und früh vorbei

`BALANCE.md` D.2 hatte es gemessen und als passend bewertet: Median 38 Züge
(84 s), 13,4 % aller Runden vor Zug 21 zu Ende. Für einen Neuling heißt das:
ein Game Over alle anderthalb Minuten, jede achte Runde vorbei, bevor sie
begonnen hat. Der Generator würfelte dabei rein nach Gewicht; die im Plan
vorgesehene Frühphasen-Hilfe (`MASTERPLAN.md` §4) war so gebaut, dass sie
nichts bewirkte (sie bevorzugte „platzierbare" Teile — auf einem leeren Brett
sind das alle).

**Behoben** (`SpawnAssist`, `BALANCE.md` Nachtrag 6): Median 65 Züge, frühe
Abbrüche 2,3 %. Die Daily bleibt unverändert.

### 1.3 · Der meistgesehene Bildschirm ist der schwächste

Das Game Over sieht ein Spieler häufiger als jedes Menü. Stand heute
(`_GameOverOverlay`): Text ohne Karte über dem abgedunkelten Brett, die
Überschrift liegt auf der Kopfzeile, der Knopf „Nochmal spielen" läuft randlos
über die ganze Breite (abgeschnittene Rundungen), die auffälligste Farbe hat
der Video-Knopf. Kein Bestwert-Vergleich, kein Fortschritt zum nächsten Level.

**Offen**, als Nächstes.

### 1.4 · Die erste Runde zeigt alles auf einmal

Über dem leeren Brett der allerersten Runde: zwei unerklärte Balken, eine
gelbe Zeile „Neue Teile (Video)" — der erste Satz, den das Spiel zu einem
Neuling sagt, ist ein Werbe-Angebot —, darunter drei Booster mit Preisen, dann
erst die Teile. Das widerspricht dem eigenen Versprechen („keine Nerverei") und
kostet dem Brett Platz. `docs/STORE-SCREENSHOTS.md` §9 hatte die Video-Zeile
schon im August als Problem notiert.

**Offen**: Booster und Video erst ab der zweiten Runde; das Video als Booster
neben Tausch statt als Zeile über dem Brett.

### 1.5 · Was gut ist und bleibt

Sauberes Drag-and-drop mit Vorschau, Effekte und Ton, Daily mit Ziel, Serie
und Rangliste, Quests, Erfolge in Stufen, viele Designs, Rätsel mit Hinweis,
keine erzwungene Werbung, 56 Sprachen, 7.138 Tests. Der Unterbau trägt; die
Probleme lagen in den ersten zwei Minuten und in der Rundenlänge.

---

## 2 · Warum wenige installieren

### 2.1 · Der Store-Eintrag zeigt eine ältere, dunklere App

| Befund | Beleg |
|---|---|
| Die Live-Bilder stammen aus dem September: „Acht Themes" (es sind zwölf), Knöpfe „Missionen/Themes/Skins" (heißen Quests/Designs/Shop) | `store-assets/en/` auf `main` bis 09.11. |
| Die neueren Bilder vom 02.10. (acht Stück, Designs im Mittelpunkt) wurden nie hochgeladen — ihr Branch blieb ungemergt | `claude/stoic-galileo-cs0nxb` |
| Bildaufbau: kleine Überschrift links, Brett in der Mitte, das untere Drittel leer; dunkel auf dunkel | alle Motive |
| Kein Finger, kein Teil im Flug: Das Bild zeigt nicht, was man tut | Motive 1–2 |
| Symbol: neun flache Quadrate auf Dunkelblau — liest sich wie ein App-Menü, nicht wie ein Block-Puzzle | `store-assets/app-icon-512.png`, schon in `audit/05-aso.md` §6 |
| Feature-Grafik: Symbol und Schriftzug, sonst nichts | `store-assets/en/feature-graphic-1024x500.png` |
| Kein Video im Eintrag (liegt seit September bereit) | `ANLEITUNG.md` Schritt 3 |

### 2.2 · Nichts unterscheidet den Eintrag auf den ersten Blick

Titel „Qubble: Block Puzzle", Kurzbeschreibung „Offline block puzzle: drop
blocks, clear lines, beat your high score." — das trifft auf hunderte Titel zu.
Die zwei echten Unterschiede stehen erst im sechsten Bild („keine
Zwangswerbung") oder gar nicht (die vielen Designs; die Haustiere gibt es noch
nicht).

### 2.3 · 60 Store-Sprachen von Hand

Jede Änderung musste in 60 Einträgen nachgezogen werden; der Datei-Import der
Console schlug fehl. Folge: Der Eintrag blieb auf dem Stand vom 28.09. stehen.

**Geplant:** vier Sprachen von Hand (EN, DE, ES, PT-BR), der Rest per
automatischer Übersetzung; Upload per Workflow statt per Hand.

### 2.4 · Kein Zufluss außer der Suche

Kein Video, keine Kampagne (bewusst zurückgestellt), Teilen-Links erst seit
1.5.0. Bei einem neuen Titel ohne Bewertungen liefert die Suche allein wenig.
Der Plan dazu entsteht in `docs/WACHSTUM.md`.

---

## 3 · Zahlen, die nur der Nutzer hat

Für jede weitere Entscheidung zählen diese mehr als alles oben:

| Zahl | Wo | Wozu |
|---|---|---|
| Besucher des Store-Eintrags und Installationen je Woche, je Land | Play Console | Liegt es am Finden oder am Überzeugen? |
| Umwandlung Besucher → Installation | Play Console | Wirkung der neuen Bilder vorher/nachher |
| D1-, D7-, D30-Bindung | Play Console oder Firebase | Wirkung von 1.1 und 1.2 |
| Anteil „erste Runde beendet" und Runden je Sitzung | Firebase (`round_complete`, `first_placement`) | Wo genau Neulinge gehen |
| Bewertungen (Anzahl, Schnitt, Texte) | Play Console | Was Spieler selbst sagen |
| Deinstallationen in den ersten Tagen | Play Console | Fließt laut Sekundärquellen ins Ranking |
| Bonus-Videos je aktivem Spieler, Umsatz je Land | AdMob | Was ein Spieler wert ist — Voraussetzung für bezahlte Werbung |

Ohne diese Zahlen ist jede Reihenfolge eine begründete Vermutung. Sie
automatisch ins Repo zu holen, ist Teil des Wachstumsplans.
