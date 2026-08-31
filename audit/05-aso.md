# 05 — Store-Listing und ASO

Fertige Copy, keine Beschreibung von Copy. Die beiden Vollbeschreibungen liegen
einsatzfertig in `audit/copy/long-de.txt` (3 075 Zeichen) und
`audit/copy/long-en.txt` (2 812 Zeichen); alle Längen sind programmatisch
geprüft.

Die aktuellen Live-Texte der Store-Seite konnte ich nicht abrufen —
`play.google.com` ist egress-gesperrt (Phase 1), und die App ist ohnehin
gesperrt. Grundlage ist deshalb `docs/STORE-LISTING.md`, der Stand, den das
Repo als eingereicht dokumentiert.

---

## 1. Drei Aussagen müssen raus, bevor irgendetwas optimiert wird

Google verlangt, dass Metadaten die Funktionalität **präzise** abbilden
(Phase 1a). Bei einem Konto mit Enforcement-Vorgeschichte ist das kein
Feinschliff, sondern P0. Drei Aussagen im aktuellen Text halten der Prüfung
gegen den Code nicht stand:

| Aktuelle Aussage | Warum sie nicht haltbar ist | Beleg |
|---|---|---|
| „Kein Internet nötig, kein Konto, **kein Server**" | Die Bestenliste sendet Anzeigename und Punktestand an Cloud Firestore und legt dafür eine anonyme Firebase-Auth-Identität an. | `lib/services/leaderboard.dart:133-210` |
| „Wer es in der **Mindestzahl an Zügen** schafft, holt **drei Sterne**" | Beschreibt eine Bewertung, die nicht bewertet: In 200 von 200 geprüften Leveln gilt `minMoves == Teilezahl`, also ist `moves` beim Sieg immer exakt `minMoves` → **immer 3 Sterne**. 1 und 2 Sterne sind unerreichbar. | Phase 3, L-2, eigene Messung |
| „**Kein Zeitdruck**, kein Timer" | Die Runde hat keinen Timer — das stimmt. Aber der Combo-Multiplikator läuft nach 10 Sekunden ab, die UI zeigt den Countdown, und 96,6 % aller Punkte hängen an Clears mit diesem Multiplikator. | `lib/game/scoring.dart:50`, `game_screen.dart:704`, `BALANCE.md` D.3 |

Die erste ist die gefährlichste: Sie widerspricht direkt dem, was die App
tatsächlich an Daten überträgt — also genau der Konsistenz, die Google beim
Data-Safety-Abgleich prüft.

Zwei weitere Kleinigkeiten habe ich mitkorrigiert: „Handverlesen wirkende"
Level (die Level sind erzeugt, „wirkende" rettet das nur knapp) und die
Auflistung von acht Themes ohne den Hinweis, dass Aurora dem Unterstützer-Paket
vorbehalten ist.

**In der neuen Fassung sind alle fünf bereinigt** — ohne dass der Text an
Verkaufskraft verliert. Der Verzicht auf erzwungene Werbung wird sogar stärker
herausgestellt, weil er der einzige belegbare Wettbewerbsvorteil ist.

---

## 2. Titel (max. 30 Zeichen), je drei Varianten

**Grundlage aus Phase 1b:** „Block Puzzle" kommt in sechs von zehn belegten
Wettbewerber-Titeln wörtlich vor. Zwei Titel reizen die 30 Zeichen exakt aus.
Nur der Marktführer verzichtet vollständig auf generische Keywords — eine
Strategie, die eine etablierte Markennachfrage voraussetzt und deshalb für
Qubble nicht kopierbar ist.

### Deutsch

| Var. | Titel | Zeichen | Hypothese |
|---|---|---:|---|
| **A** | `Qubble: Block Puzzle` | 20 | Basis (entspricht dem heutigen Stand) |
| **B** | `Qubble – Block Puzzle Spiel` | 27 | „Spiel" fängt die Suchanfrage „block puzzle spiel" ab, die im DE-Store verbreitet ist |
| **C** | `Qubble Block Puzzle: Offline` | 28 | „Offline" ist Qubbles belegbarer Unterschied und zugleich ein eigenständiger Suchbegriff |

### Englisch

| Var. | Titel | Zeichen | Hypothese |
|---|---|---:|---|
| **A** | `Qubble: Block Puzzle` | 20 | Basis |
| **B** | `Qubble: Block Puzzle Game` | 25 | exakt das Muster von Blockudoku (30) und 1010! (23) |
| **C** | `Qubble Block Puzzle Offline` | 27 | Differenzierung statt Kategorie-Wettbewerb |

**Empfehlung:** Zuerst **B gegen A** testen (reine Keyword-Breite), danach den
Sieger gegen **C** (Differenzierung). Begründung in Abschnitt 8.

**Wichtig zur deutschen Fassung:** Aus Phase 1b — der Markenkern wird nie
übersetzt, nur der generische Anhang, und der deutsche Titel fällt kürzer aus
(Blockudoku: 30 Zeichen EN gegen 25 DE). Eine 1:1-Übersetzung des englischen
Titels verschenkt deshalb Platz. Die Varianten oben sind entsprechend getrennt
geschrieben, nicht übersetzt.

---

## 3. Kurzbeschreibung (max. 80 Zeichen), je drei Varianten

Die Kurzbeschreibung ist bei Play **indexiert** — hier gehören Keywords hinein,
kein Slogan.

### Deutsch

| Var. | Text | Zeichen |
|---|---|---:|
| **A** | `Blöcke setzen, Reihen räumen, Highscore knacken. Offline, ohne Zwangswerbung.` | 77 |
| **B** | `Block Puzzle offline: Blöcke ziehen, Linien räumen, Bestenliste erklimmen.` | 74 |
| **C** | `Entspanntes Block Puzzle: keine Zwangswerbung, kein Timer, jederzeit offline.` | 77 |

### Englisch

| Var. | Text | Zeichen |
|---|---|---:|
| **A** | `Drop blocks, clear lines, beat your high score. Offline, no forced ads.` | 71 |
| **B** | `Offline block puzzle: drag blocks, clear lines, climb the leaderboard.` | 70 |
| **C** | `Relaxing block puzzle. No forced ads, no interruptions, plays offline.` | 70 |

Variante B stellt in beiden Sprachen das Kategorie-Keyword an den Anfang,
Variante C führt mit dem Nutzenversprechen. A ist die aktuelle Linie.

---

## 4. Vollbeschreibung

**Deutsch:** `audit/copy/long-de.txt` — 3 075 / 4 000 Zeichen
**Englisch:** `audit/copy/long-en.txt` — 2 812 / 4 000 Zeichen

Beide sind einsatzfertig zum Kopieren. Struktur unverändert gegenüber dem
bisherigen Text (er war gut aufgebaut), inhaltlich bereinigt um die fünf
Punkte aus Abschnitt 1.

Die wesentlichen inhaltlichen Änderungen:

| Stelle | vorher | nachher |
|---|---|---|
| Offline-Absatz | „kein Server" | „Das Spiel selbst läuft komplett offline […] Nur die optionale Bestenliste braucht eine Verbindung." |
| Intro | „ohne Zwangswerbung" | „ohne eine einzige erzwungene Werbung" — konkreter, gleiches Keyword |
| Combo-Absatz | reine Eskalation | ergänzt um „wer in Ruhe knobelt, spielt trotzdem jede Runde zu Ende" — löst den Widerspruch aus Phase 3, L-4 |
| Rätsel-Absatz | „drei Sterne für die Mindestzahl an Zügen" | Sternversprechen gestrichen, stattdessen die Positionierung als ruhiger Gegenpol |
| Themes | „8 Themes: … und Aurora" | Aurora-Einschränkung direkt dahinter |
| Fairness-Absatz | — | ergänzt: Weiterspielen kostet Münzen, nie ein Video (macht die `CLAUDE.md`-Regel zum Verkaufsargument) |
| Bestenliste | „Name freiwillig" | „kein Konto und keine E-Mail" — greift die häufigste Sorge auf |

Absichtlich **nicht** geändert: der Vergleichsabsatz „Du magst Woodoku, Block
Blast, Blockudoku oder 1010!?". Das Nennen von Wettbewerbertiteln ist bei Play
im Fließtext üblich und hier keyword-relevant; kritisch würde es erst im
**Titel** (siehe Phase 1b: `Block Blast - Top Block Puzzle` als Beispiel für
Markenkaperung — genau das darf Qubble nicht tun).

---

## 5. Keyword-Mapping mit Begründung aus 1b

| Keyword | Wo platziert | Begründung aus der Wettbewerbsanalyse |
|---|---|---|
| `Block Puzzle` | Titel, Kurzbeschreibung, erster Absatz | Kommt in 6 von 10 belegten Wettbewerber-Titeln wörtlich vor. Das Kategorie-Kopfwort; ohne es findet einen niemand. |
| `offline` | Titel-Variante C, alle Kurzbeschreibungen, eigener Absatz | Belegbarer Unterschied. Kein einziger der geprüften Wettbewerber-Titel führt ihn — geringer Wettbewerb um den Begriff. |
| `Blöcke` / `blocks` | Kurzbeschreibung, Fließtext | Deutsche Nutzer suchen beides; der Store indexiert die Kurzbeschreibung. |
| `Woodoku`, `Blockudoku`, `Block Blast`, `1010!` | nur Fließtext, ein Absatz | Alle vier sind als reale Titel belegt. Im Fließtext üblich und relevant; im Titel wäre es Markenkaperung. |
| `Highscore` / `high score` | Kurzbeschreibung, Fließtext | Ergänzt die Bestenliste als Suchintention. |
| `Bestenliste` / `leaderboard` | Kurzbeschreibung B, eigener Absatz | Neu gegenüber dem alten Text; die Funktion existiert und war unterbelichtet. |
| `entspannt` / `relaxing` | Kurzbeschreibung C, Intro | Die Positionierung, die den Verzicht auf Zwangswerbung stützt. |
| `Sudoku`, `1010`, `blast` (iOS-Keywordfeld) | nur iOS | Für Play irrelevant — Play hat kein Keywordfeld. |

**Was ich weggelassen habe und warum.** Keyword-Stuffing ist explizit
untersagt (Phase 1a), und laut der Recherche zur Play-Discovery 2026 verliert es
durch die Gemini-Integration ohnehin an Wirkung, während Post-Install-Verhalten
zum expliziten Ranking-Faktor wird
(<https://asoworld.com/en/blog/google-i-o-2026-key-developer-insights-for-apps-and-games-on-google-play/>,
abgerufen 2026-08-31). Für ein Konto mit Vorgeschichte ist ein sauberer Text
mehr wert als drei zusätzliche Suchbegriffe.

**Die unbequeme Konsequenz:** Da 88 % der Play-Spiele-Downloads aus Suche und
Browse kommen und Retention inzwischen in das Ranking einfließt (beides Phase
1c), ist der wirksamste ASO-Hebel für Qubble **nicht** dieser Text, sondern
L-1 bis L-3 aus Phase 3. Die Copy hier ist notwendig und billig — aber sie ist
nicht der Hebel.

---

## 6. Screenshots und Icon

### Icon-Kritik

Das aktuelle Icon (`store-assets/app-icon-512.png`): ein 3×3-Raster
abgerundeter Quadrate in Violett/Weiß/Pink/Türkis auf dunklem Marineblau.

Handwerklich sauber. Drei Probleme im Wettbewerbsumfeld:

1. **Es zeigt kein Block-Puzzle, es zeigt ein Raster.** Es fehlt die
   definierende Silhouette des Genres — eine mehrzellige Blockform. Ein 3×3-Feld
   gleichmäßiger Kacheln liest sich näher an einem Sudoku- oder, schlimmer, an
   einem generischen „Apps"-Menü-Glyph als an diesem Genre.
2. **Das Raster stimmt nicht.** 3×3 im Icon, 8×8 im Spiel.
3. **Der dunkle Hintergrund verliert im Suchergebnis.** Die Kategorie ist
   durchgehend hell und gesättigt; ein marineblaues Icon fällt in einer Reihe
   von Suchtreffern zurück statt auf.

*Vorbehalt:* Ich konnte die Wettbewerber-Icons in dieser Session **nicht
abrufen** (Phase 1b). Die Aussage über die Helligkeit der Kategorie ist damit
nicht belegt und als Hypothese zu behandeln — sie ist aber genau die Art
Annahme, die ein Play-Store-Listing-Experiment in zwei Wochen beantwortet.

**Vorschlag zum Testen:** dieselbe Farbwelt, aber ein **L- oder T-förmiges
Blockteil**, das teilweise in ein Raster einrastet, auf hellerem Grund. Das
zeigt die Mechanik statt des Spielfelds.

### Screenshot-Kritik

`store-assets/en/screenshot-1-clear.png` gesehen: große, lesbare Überschrift,
klare Bildunterschrift, echtes Spielbrett mit Partikeleffekt und Punkte-Popup.
Der Aufbau ist gut.

Ein Problem, und es betrifft ausgerechnet den wichtigsten Screenshot: **Der
Partikeleffekt verdeckt genau das, was die Überschrift verspricht.** Die
Überschrift sagt „Fill a line. Watch it blow." — im Bild ist aber keine
geräumte Linie erkennbar, weil die türkisen Partikel großflächig über dem Brett
liegen und auch die „+303" teilweise überdecken. Zweitens fehlt **die Ablage
mit den drei Teilen**; ohne sie sieht ein Betrachter nicht, wie man spielt.

### Screenshot-Konzept

| # | Bildinhalt | Caption DE | Caption EN |
|---|---|---|---|
| 1 | Brett mit **einer vollen Reihe im Moment des Auflösens**, Partikel deutlich reduziert, **Ablage mit drei Teilen sichtbar** | „Reihe voll. Reihe weg." | „Fill a line. Watch it go." |
| 2 | Combo-Multiplikator sichtbar, mehrere Linien gleichzeitig | „Mehrere Linien = Punkte-Explosion" | „Chain clears, multiply your score" |
| 3 | Startbildschirm mit Daily-Kachel und Streak-Zähler | „Jeden Tag dieselbe Aufgabe – weltweit" | „One daily challenge, same for everyone" |
| 4 | Rätsel-Modus, Brett halb geräumt | „Rätsel-Modus: räum das Brett komplett" | „Puzzle mode: clear the whole board" |
| 5 | Theme-Auswahl, vier Themes nebeneinander | „8 Themes, 8 Block-Skins" | „8 themes, 8 block skins" |
| 6 | Flugmodus-Symbol über dem Spielbrett | „Kein Netz? Läuft trotzdem." | „No signal? Still works." |

Reihenfolge begründet: Screenshot 1 und 2 tragen die Konversion (die Mechanik
und ihr Höhepunkt), 3 und 4 zeigen Wiederspielgründe, 5 und 6 sind
Differenzierung. Das entspricht der bestehenden Abfolge in `store-assets/` —
die ist bereits richtig sortiert und braucht nur die Korrektur an Bild 1.

### Video-Konzept

Die ersten drei Sekunden, ausformuliert:

- **0,0–0,8 s:** Direkt auf dem Brett, kein Logo, kein Vorspann. Ein Finger
  zieht ein L-Teil in die vorletzte Lücke einer fast vollen Reihe.
- **0,8–1,4 s:** Das Teil rastet ein, die Reihe füllt sich sichtbar von links.
- **1,4–2,2 s:** Die Reihe löst sich auf, Punkte fliegen hoch, der
  Combo-Zähler springt auf ×2.
- **2,2–3,0 s:** Kamera bleibt auf dem Brett, eine zweite Reihe fällt, das
  Fieber-Meter füllt sich. Erst **danach** darf ein Logo kommen.

Regel dahinter: In drei Sekunden muss die Frage „Was mache ich hier?"
beantwortet sein. Ein Logo am Anfang verbraucht die halbe Zeit dafür, dass der
Betrachter den Namen liest, den er im Listing ohnehin schon gesehen hat.

---

## 7. Was die App vor dem Listing noch braucht

Zwei Punkte aus früheren Phasen blockieren Aussagen im Text:

- **Der Rätsel-Modus liefert immer 3 Sterne** (Phase 3, L-2). Solange das so
  ist, darf kein Sternversprechen im Listing stehen — es steht deshalb auch
  nicht mehr drin. Wird L-2 umgesetzt, kann der Absatz wieder wachsen.
- **`AchievementsScreen` zeigt Deutsch in der englischen Fassung** (Phase 2,
  T-3). Ein englisches Listing, hinter dem eine teilweise deutsche App steckt,
  ist genau die Art Diskrepanz, die in Bewertungen und im Zweifel in einer
  Metadaten-Beanstandung landet.

---

## 8. A/B-Testplan (Play Store Listing Experiments)

Reihenfolge nach erwartetem Effekt pro Aufwand. **Immer nur ein Element
gleichzeitig**, sonst ist das Ergebnis nicht zuzuordnen.

| # | Test | Variante A | Variante B | Erfolgskriterium | Mindestlaufzeit |
|---|---|---|---|---|---|
| 1 | **Icon** | aktuell (3×3-Raster, dunkel) | Blockteil rastet ein, heller | Store-Listing-Conversion-Rate | 14 Tage oder bis das Konfidenzintervall der Console nicht mehr die Null einschließt |
| 2 | **Screenshot 1** | aktuell (Partikel verdecken) | sichtbare Reihe + Ablage | Conversion-Rate | 14 Tage |
| 3 | **Titel** | `Qubble: Block Puzzle` | `Qubble: Block Puzzle Game` / `Qubble – Block Puzzle Spiel` | **Store-Listing-Aufrufe** (nicht Conversion — der Titel wirkt auf die Auffindbarkeit) | 21 Tage |
| 4 | **Kurzbeschreibung** | Variante A | Variante B (Keyword vorn) | Conversion-Rate | 14 Tage |
| 5 | **Titel-Sieger vs. C** | Sieger aus 3 | `Qubble Block Puzzle Offline` | Aufrufe + Conversion | 21 Tage |

Warum Icon zuerst: Es ist das einzige Element, das in **jeder** Oberfläche
sichtbar ist — Suchergebnis, Kategorie-Browse, „Ähnliche Apps". Ein Titeltest
davor misst die Wirkung des Titels durch ein Icon hindurch, das die Klicks
begrenzt.

**Eine ehrliche Einschränkung:** Play-Store-Listing-Experimente brauchen
Traffic, um Signifikanz zu erreichen. Bei den Installationszahlen, die für einen
Solo-Titel ohne UA-Budget realistisch sind (Phase 1c), kann ein Test Wochen
laufen, ohne ein verwertbares Ergebnis zu liefern. Die Tests sind trotzdem
richtig — aber wer nach 14 Tagen kein Signal sieht, sollte die Variante nach
Augenmaß wählen und weitergehen, statt auf Signifikanz zu warten, die nie
kommt.

---

## Quellen

| URL | Titel | Abrufdatum | Belegtyp |
|---|---|---|---|
| <https://sensortower.com/blog/google-play-download-sources> | 88% of Google Play Game Downloads Come From Search and Browse | 2026-08-31 | Suchtreffer |
| <https://asoworld.com/en/blog/google-i-o-2026-key-developer-insights-for-apps-and-games-on-google-play/> | Google I/O 2026: Key Developer Insights for Apps and Games on Google Play | 2026-08-31 | Suchtreffer |
| <https://appfollow.io/blog/app-store-optimization-for-games> | App Store Optimization for Games: 2026 ASO Playbook | 2026-08-31 | Suchtreffer |
| <https://www.apptweak.com/en/aso-blog/how-to-prepare-for-new-google-metadata-policy-changes> | Google Play's Metadata Policy Changes | 2026-08-31 | Suchtreffer |

Titel-Strings und Package-IDs der Wettbewerber sind in `audit/01-markt.md`
belegt. Alle Aussagen über die App selbst tragen eine Fundstelle in diesem Repo.
