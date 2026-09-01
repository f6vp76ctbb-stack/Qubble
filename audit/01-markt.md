# 01 — Markt, Wettbewerb, Benchmarks

Alle externen Angaben wurden am **2026-08-31** erhoben.

## Vorbemerkung: eine harte Einschränkung dieser Recherche

Die Ausführungsumgebung dieser Session hat eine **enge Egress-Allowlist**.
Direkte Seitenabrufe (`WebFetch`) schlagen für praktisch alle kommerziellen
Domains mit `EGRESS_BLOCKED` fehl — verifiziert unter anderem für
`play.google.com`, `support.google.com`, `www.gameanalytics.com`,
`www.appbrain.com` und als Kontrolle sogar `example.com`. Erfolgreich abrufbar
war allein `developer.android.com`.

Was funktioniert, ist die **Websuche**. Deren Ergebnisse enthalten
Trefferzeilen, URLs und Referate des Seiteninhalts, aber nicht die Seite selbst.

Konsequenz, ohne Beschönigung:

- **Kein einziges Play-Store-Listing wurde tatsächlich geöffnet.** Alles, was
  unten über Wettbewerber steht, stammt aus Suchtreffern.
- Bewertungsschnitte, Bewertungszahlen, Update-Daten, Content-Ratings,
  IAP-Preispunkte und die Volltexte der Langbeschreibungen der Wettbewerber
  sind in dieser Session **nicht belegbar** und stehen unten als „Unbekannt".
- Jede Benchmark-Zahl in 1d ist ein Suchreferat einer Primärquelle, nicht die
  Primärquelle selbst. Deshalb trägt **keine** Zahl die Konfidenz „hoch".

Das ist eine Umgebungsbeschränkung, keine Rechercheentscheidung. Die
Auftragsregel „Belegpflicht extern" wird eingehalten, indem der Belegtyp bei
jeder Aussage mitgeführt wird — nicht, indem Lücken gefüllt werden.

---

# 1b — Wettbewerbsanalyse

## Verifizierte Titel und Package-IDs

Aus Suchtreffern belegt (Ergebnis-URL + Ergebnis-Titel; der Ergebnis-Titel einer
Play-Trefferzeile entspricht dem `<title>` der Store-Seite):

| Titel-String im Store | Zeichen | Package-ID | Locale des Treffers |
|---|---:|---|---|
| `Block Blast!` | 12 | `com.block.juggle` | EN + DE belegt |
| `Blockudoku®: Block Puzzle Game` | 30 | `com.easybrain.block.puzzle.games` | EN |
| `Blockudoku - Block-Puzzle` | 25 | `com.easybrain.block.puzzle.games` | DE |
| `Woodoku - Wood Block Puzzle` | 27 | `com.tripledot.woodoku` | en_US |
| `Woodoku` | 7 | `com.tripledot.woodoku` | en_GB |
| `1010! Block Puzzle Game` | 23 | `com.gramgames.tenten` | EN |
| `Playdoku: Block Puzzle Games` | 28 | `games.burny.playdoku.block.puzzle` | EN |
| `Block Puzzle Wood Blast` | 23 | `wood.blockpuzzle.game.jewel.classic` | EN |
| `Block Blast - Top Block Puzzle` | 30 | `block.amaze.android` | EN |
| `Block Puzzle - 2026` | 19 | `com.bilkon.blockpuzzle` | EN |

Zeichenzahlen selbst gezählt. Entwickler belegt nur für
`com.tripledot.woodoku` → Tripledot Studios Limited (über die
Entwickler-URL `dev?id=7461875482624565371`).

## Was nicht belegbar war

| Merkmal | Status |
|---|---|
| Bewertungsschnitt, Anzahl Bewertungen | Unbekannt — Seite nicht abrufbar |
| Downloadzahl-Angabe im Store | Unbekannt — Seite nicht abrufbar |
| Datum des letzten Updates, Update-Frequenz | Unbekannt — Seite nicht abrufbar |
| Content-Rating | Unbekannt — Seite nicht abrufbar |
| „Enthält Werbung"/„In-App-Käufe"-Hinweise, IAP-Preisspannen | Unbekannt — Seite nicht abrufbar |
| Kurzbeschreibung, Volltext und Aufbau der Langbeschreibung | Unbekannt — Seite nicht abrufbar |
| Getrennte US-/DE-Ranglisten | Unbekannt — Chart-Seiten liegen auf `play.google.com` |

Die Kandidatenliste oben ist eine **Suchtreffer-Sammlung, keine Rangliste**.

## Zwei Korrekturen an gängigen Annahmen

- `com.easybrain.block.puzzle` ist **nicht** die Blockudoku-ID. In allen
  Treffern lautet sie `com.easybrain.block.puzzle.games`.
- `com.peoplefun.wordcross` ist **kein** Block-Puzzle, sondern
  „Wordscapes: Word puzzle game" von PeopleFun — für dieses Wettbewerbsfeld
  irrelevant.

## Was die Titelfelder verraten

Das Titelfeld ist das einzige Wettbewerbsmerkmal, das belegbar ist. Es ist
trotzdem aussagekräftig, weil bei Play der Titel indexiert wird.

**Der Marktführer verzichtet vollständig auf generische Keywords.**
`Block Blast!` sind 12 Zeichen ohne „Puzzle", ohne „Wood", ohne „Sudoku" —
etwa 18 Zeichen des Feldes bleiben ungenutzt. Das funktioniert nur, weil die
Marke selbst der Suchbegriff geworden ist. Es ist die eine Strategie, die ein
Neueinsteiger nicht kopieren kann.

**Fünf von sieben analysierbaren Titeln folgen dem Schema
`Marke + Trennzeichen + generisches Keyword`.** „Block Puzzle" kommt in sechs
von zehn belegten Titel-Strings wörtlich vor. Zwei Titel reizen die 30 Zeichen
exakt aus.

**Das Namensfeld ist mit Trittbrettfahrern gesättigt.**
`Block Blast - Top Block Puzzle` (`block.amaze.android`) enthält „Block"
zweimal und kapert den Markennamen des Marktführers. `Block Puzzle Wood Blast`
ist ein reiner Keyword-Titel ohne jede Marke, dessen Package-ID
`wood.blockpuzzle.game.jewel.classic` zusätzlich vier Keywords stapelt.

Für Qubble folgt daraus unmittelbar: Der geplante Titel
`Qubble – Block Puzzle` (`docs/STORE-LISTING.md`) konkurriert in der Suche
nicht mit Block Blast, sondern mit dieser Klasse von Klonen — und die haben
mehr Bewertungen und älteren Index. Das ist in Phase 5 zu bearbeiten.

## DE vs. US

| Titel | EN | DE | Beleg |
|---|---|---|---|
| Block Blast! | `Block Blast!` | `Block Blast!` (identisch) | DE-Trefferzeile |
| Blockudoku | `Blockudoku®: Block Puzzle Game` (30) | `Blockudoku - Block-Puzzle` (25) | DE-Trefferzeile |
| Woodoku | `Woodoku - Wood Block Puzzle` | Unbekannt | — |

Zwei Muster, beide auf dünner Basis:

1. **Der Markenkern wird nie übersetzt**, nur der generische Anhang.
2. **Der deutsche Titel ist kürzer** — „Game" fällt weg, „Block Puzzle" wird
   zum Kompositum „Block-Puzzle". Ein 1:1 übersetzter englischer Titel
   verschenkt im deutschen Feld Platz.

*Vorbehalt:* Mehrere deutschsprachige Trefferzeilen trugen `hl=en_US`-URLs.
Titel und Locale-Parameter widersprechen sich also; ohne direkten Abruf ist
nicht garantiert, dass ein Nutzer in Deutschland heute exakt diese Strings
sieht.

---

# 1c — Marktbewertung

Hier ist Klartext angebracht, weil die Zahlenlage eindeutig ist.

## Wie konzentriert die Kategorie ist

Belegt, abgerufen 2026-08-31:

- **Block Blast! ist der weltweit meistgeladene Mobile-Titel — zwei Jahre in
  Folge**, und war im Januar, Februar und März 2026 jeweils global die Nummer 1
  nach Downloads. Im April 2026 rund **23,8 Mio. Downloads in einem Monat**.
  (<https://www.streetinsider.com/Business+Wire/Block+Blast!+Ends+Q1+2026+as+the+No.+1+Most+Downloaded+Mobile+Game+Worldwide/26355494.html>,
  <https://marketingtrending.asoworld.com/en/discover/april-2026-mobile-game-rankings-block-blast-leads-downloads-honor-of-kings-tops-revenue/>)
- Spielerbasis **über 200 Mio. MAU**, rund **368 Mio. Downloads in einem Jahr**,
  geschätzt **584.000 USD Werbeumsatz pro Tag**.
  (<https://www.capermint.com/blog/develop-a-game-like-block-blast/>,
  <https://www.blog.udonis.co/statistics/block-blast>)

Der Abstand zwischen Marktführer und Rest ist damit nicht groß, sondern
kategorial. Der direkte Genre-Konkurrent von Qubble ist nicht ein starker
Mitbewerber, sondern das meistgeladene Handyspiel der Welt.

## Der Befund, der die Monetarisierungsstrategie infrage stellt

Block Blast monetarisiert **rein über Werbung**: kein Shop, keine
In-App-Käufe, keine sozialen Funktionen. Bei Downloads Platz 1, bei
IAP-Umsatz **Platz 3.264** — rund 65.000 USD in 19 Monaten.
(<https://www.capermint.com/blog/develop-a-game-like-block-blast/>)

Das ist für Qubble in zwei Richtungen unbequem:

1. Der Genre-Marktführer beweist, dass in diesem Genre **Werbung** das
   Geschäftsmodell ist und IAP praktisch nichts beiträgt. Qubbles Katalog aus
   Unterstützer-Paket, Münzpaketen und Starter-Paket (`lib/monetization/iap.dart:15-49`)
   zielt auf den Umsatzstrom, der beim erfolgreichsten Titel der Kategorie
   0,03 % ausmacht.
2. Gleichzeitig verzichtet Qubble per nicht verhandelbarer Regel auf genau das
   Format, mit dem Block Blast diese 584.000 USD/Tag erzielt. Laut Recherche
   nutzt Block Blast Interstitials zwischen Runden **plus** eine
   Rewarded-Platzierung. (<https://blog.udonis.co/statistics/block-blast>)

Qubble verzichtet also auf den funktionierenden Umsatzstrom und setzt auf den
im Genre nachweislich schwachen. Das ist eine legitime Produktentscheidung —
sie ist in `CLAUDE.md` als Wert gesetzt, nicht als Optimierung — aber sie muss
mit offenen Augen getroffen werden. Der Preis wird in Phase 4 beziffert.

## Wo realistisch Platz ist

Die Downloadverteilung ist weniger konzentriert als die Umsatzverteilung:
Die Top-10-Titel machen 4,7 % aller Installs aus, die Top 500 zusammen 43,9 % —
Downloads streuen, Umsätze nicht.
(<https://www.singular.net/blog/top-mobile-games/>)

Und der Kanal, auf den ein Solo-Entwickler ohne UA-Budget angewiesen ist,
funktioniert bei Play besser als anderswo:

> **88 % der Google-Play-Spiele-Downloads stammen aus Suche und Browse** — 8
> Prozentpunkte mehr als im App Store.
> (<https://sensortower.com/blog/google-play-download-sources>)

Das ist die einzige belastbar gute Nachricht dieser Phase: Der Store selbst ist
der Vertriebskanal, und er ist bei Android dominanter als bei Apple.

Zwei Einschränkungen aus derselben Recherche:

- Post-Install-Verhalten (Retention) ist ein **expliziter Ranking-Faktor**
  geworden; Keyword-Stuffing verliert durch die Gemini-Integration in die
  Play-Discovery an Wirkung.
  (<https://asoworld.com/en/blog/google-i-o-2026-key-developer-insights-for-apps-and-games-on-google-play/>,
  <https://appfollow.io/blog/app-store-optimization-for-games>)
- Der Discovery-Algorithmus bevorzugt Titel mit hoher Retention und guter
  Bewertung.

Daraus ergibt sich der einzige gangbare Weg: **Retention vor Reichweite.** Nicht
weil das allgemein klug klingt, sondern weil bei Play die Retention den
Suchkanal speist, der 88 % der Installs liefert — und Qubble keinen zweiten
Kanal hat.

## Wo Qubble eine Nische hat — und wo nicht

Belastbar als Differenzierung:

- **Werbefreiheit als Produktversprechen.** Der Markt ist ad-getrieben; ein
  Titel, der glaubhaft „nie eine erzwungene Werbung" sagt, hat ein Argument,
  das die Konkurrenz strukturell nicht kopieren kann, ohne ihr Geschäftsmodell
  aufzugeben. Das ist in `docs/STORE-LISTING.md` bereits prominent gesetzt.
- **Deutscher Sprachraum.** Der DE-Titel des einzigen belegten lokalisierten
  Wettbewerbers ist eine schlichte Übersetzung. Ein handgeschriebener deutscher
  Eintrag ist bereits vorhanden (`docs/STORE-LISTING.md`) und ist ein realer,
  wenn auch kleiner Vorteil.

Nicht belastbar als Differenzierung:

- **Feature-Breite.** Qubble hat Daily Challenge, Rätsel-Modus, Missionen,
  Level, Erfolge, Statistiken, 8 Themes, 8 Skins, Bestenliste, Sparschwein und
  Booster (Phase 0, `lib/game/`). Der Marktführer hat nach der belegten
  Beschreibung **keinen Shop und keine sozialen Funktionen** und ist damit die
  Nummer 1 der Welt. Feature-Breite ist in diesem Genre kein Wettbewerbsvorteil.
  Sie ist Wartungslast.

## Ehrliche Einschätzung

Ein Solo-Titel ohne UA-Budget wird in dieser Kategorie **nicht über Reichweite
gewinnen**. Die Kategorie wird von einem Titel angeführt, der mehr Downloads pro
Monat hat, als Qubble realistisch je erreichen wird, und dessen
Monetarisierungsmodell Qubble aus Prinzip ablehnt.

Was realistisch bleibt:

- ein kleiner, gut bewerteter Titel, der über Play-Suche organisch wächst,
- mit Retention als einzigem Wachstumshebel,
- und Umsatz in einer Größenordnung, die den Aufwand nicht bezahlt.

Das ist kein Grund abzubrechen — aber es ist ein Grund, die Erfolgsdefinition zu
korrigieren. Wer „Installs, Retention und Umsatz maximieren" als Ziel setzt,
sollte wissen, dass der dritte Punkt bei diesem Modell im niedrigen zwei- bis
dreistelligen Euro-Bereich pro Monat landen dürfte, solange die Nutzerbasis
klein ist. Die Ableitung dazu steht in Phase 4.

**Pivot-Szenarien**, falls Umsatz das primäre Ziel wird, in aufsteigender
Eingriffstiefe:

1. **Nichts ändern, Erwartung korrigieren.** Qubble als Portfolio-Stück und
   Referenz behandeln, nicht als Einnahmequelle. Kostet nichts.
2. **Rewarded-Platzierungen ausbauen, ohne die Regel zu brechen.** Mehr
   freiwillige Gelegenheiten, dasselbe Versprechen. Details in Phase 4.
3. **Die Monetarisierungsregel neu bewerten.** Das ist eine Eigentümer-
   entscheidung, keine Audit-Empfehlung — `CLAUDE.md` setzt sie als nicht
   verhandelbar, und dieses Audit respektiert das.

Konfidenz der Marktbewertung: **mittel-hoch**. Die Kernzahlen zu Block Blast
stammen aus mehreren unabhängigen Suchreferaten und sind konsistent; die
Feinheiten (exakte Umsatzschätzung) sind Sekundärquellen.

---

# 1d — Benchmarks Casual Puzzle

Alle Werte sind **Suchreferate**, keine geöffneten Primärseiten. Deshalb ist
die höchste vergebene Konfidenz „mittel".

## Retention

| Metrik | Wert | Abgrenzung | Erhebungsjahr | Quelle | Konfidenz |
|---|---|---|---|---|---|
| D1 | 31,85 % | Puzzle, plattformübergreifend | Daten 2024 | GameAnalytics | mittel |
| D7 | 12,18 % | Puzzle, plattformübergreifend | Daten 2024 | GameAnalytics | mittel |
| D30 | 5,35 % | Puzzle, plattformübergreifend | Daten 2024 | GameAnalytics | mittel |
| D1 Android vs. iOS | Top-25 %: 25–27 % Android vs. 31–33 % iOS | alle Genres | Daten 2024 | GameAnalytics | mittel |
| D7 Median | 3,42–3,94 % alle Genres; Top-25 %: 7–8 % | alle Genres | Daten 2024 | GameAnalytics | mittel |

**Wichtige Korrektur für Qubble:** Der Puzzle-D1 von 31,85 % ist
plattformübergreifend. Dieselbe Quelle weist für Android einen Abschlag von
etwa 5–6 Prozentpunkten aus. Für ein Android-Only-Spiel liegt die realistische
D1-Erwartung damit eher bei **27–29 %** — das ist eine Ableitung, keine belegte
Zahl, und als solche zu behandeln.

## Nutzung

| Metrik | Wert | Abgrenzung | Erhebungsjahr | Quelle | Konfidenz |
|---|---|---|---|---|---|
| Sessionlänge Median | 5–6 Min.; Top-25 % 8–9 Min. | alle Genres | 2024 | GameAnalytics via GameDev Reports | mittel |
| Tägliche Spielzeit Median | 22 Min. | alle Genres | 2024 | GameAnalytics via GameDev Reports | mittel |
| Sessions/Tag | ~4,0 Ø; Median 3,8–3,9 | alle Genres | 2024 | GameAnalytics via GameDev Reports | mittel |
| Sessions/Tag Puzzle | 4,1 (höchste Frequenz aller Genres) | Puzzle + Casual | 2025/26 | Game Growth Advisor | niedrig |
| Sessions am Install-Tag | 1,65 | alle Genres | 2025 | Adjust | niedrig |

**Definitionswarnung, die im Audit zählt:** Adjust nennt für Puzzle
Sessionlängen um 24 Minuten, GameAnalytics 5–6 Minuten Median. Das sind mit
hoher Wahrscheinlichkeit zwei verschiedene Metriken — Adjusts Wert entspricht
der Größenordnung der *täglichen Spielzeit* (22 Min.), nicht der Einzelsession.
Wer 24 Minuten als Sessionlänge in ein Ad-Modell einsetzt, überschätzt die
Impressions pro Session um Faktor 4–5. Für Qubble ist **5–6 Minuten bei ~4
Sessions/Tag** die zu verwendende Größe.

## Monetarisierung

| Metrik | Wert | Abgrenzung | Jahr | Quelle | Konfidenz |
|---|---|---|---|---|---|
| ARPDAU Median | 0,02 USD | alle Games | 2026 | Game Growth Advisor | niedrig |
| ARPDAU ad-monetarisiert | 0,05–0,15 USD; Top >0,20 USD | Casual, werbefinanziert | 2026 | Game Growth Advisor | niedrig |
| Rewarded eCPM US Android | **16,49 USD** | Games | 2026 | MAF | mittel |
| Interstitial eCPM US Android | **14,08 USD** | Games | 2026 | MAF | mittel |
| Rewarded eCPM US Android (abweichend) | 27,88 USD; CA 22,01; UK 20,45 | Games | Tenjin 2026 | Tenjin via Suche | niedrig |
| Rewarded eCPM **Deutschland** | **Unbekannt — keine abrufbare Quelle** | — | — | — | — |
| eCPM-Trend DE Q2 2026 | Rückgang 10–40 %, stärkster der geprüften Länder | Games | 2026 | bidlogic | niedrig |
| IAP-Payer-Rate | 2–5 % typisch | Games gesamt, nicht Casual-spezifisch | 2026 | AppFollow | niedrig |
| IAP ARPU D90 Casual | 1,34 USD | Casual | 2026 | AppsFlyer | mittel |
| IAP ARPPU D90 Casual | 7,26 USD | Casual | 2026 | AppsFlyer | mittel |
| Ad/IAP-Split | 59 % IAP / 41 % IAA | Hybrid-Casual „Lifestyle & Puzzle" | 2026 | Sensor Tower | mittel |
| Puzzle-Anteil am Ad-Revenue | 53 % aller Ad-Revenues; **Block-Subgenre 519 Mio. USD = 10 %** | Puzzle / Block | H1 2026 | Sensor Tower via GameDev Reports | mittel |
| Rewarded-Anteil an Impressions | 17,7 %, +53,9 % YoY | Games gesamt | 2026 | Sensor Tower via GameDev Reports | mittel |
| Ad-Frequenz Puzzle je Nutzer | 72,5 Interstitials, 23,4 Rewarded, 241,5 Banner | Puzzle | Jahr unscharf | Juego Studio | niedrig |

## Der für Qubble entscheidende Befund: Was Rewarded-only kostet

Eine Quelle, die den Umsatzbeitrag eines **reinen Rewarded-Modells gegenüber
einem interstitial-getriebenen Modell im selben Titel** beziffert, existiert
öffentlich nicht — trotz gezielter Suche. Das ist als Lücke zu benennen, nicht
zu überbrücken.

Was sich aus den vorhandenen Zahlen dennoch ableiten lässt, ist die
**Richtung** des Verlusts, und die widerspricht der verbreiteten Erzählung:

Mehrere Sekundärquellen behaupten, Rewarded liefere „3× höhere eCPMs als
Interstitials". Die einzigen konkreten Länderzahlen stützen das nicht:
US-Android Rewarded 16,49 USD gegen Interstitial 14,08 USD — **Faktor 1,17**,
nicht 3. Der „3×"-Wert wird in diesem Audit nicht verwendet.

Der Verzicht auf Interstitials kostet damit **nicht Preis, sondern Volumen**:
Im Puzzle-Genre entfallen laut der belegten Frequenzverteilung 72,5
Interstitial-Impressions auf 23,4 Rewarded-Impressions pro Nutzer. Wer die
Interstitials streicht, verliert grob drei Viertel der Ad-Impressions und
gewinnt pro verbleibender Impression rund 17 % mehr eCPM.

Das ist die ehrliche Zahl hinter der Produktentscheidung. Sie wird in Phase 4
auf Qubbles konkrete Platzierungen heruntergerechnet.

## Belastbarkeit insgesamt

Schwach bis mittel. Vier Gründe:

1. **Keine Primärquelle geöffnet.** Werte wie 31,85 / 12,18 / 5,35 zirkulieren
   mit identischer Nachkommastelle über mehrere Sekundärquellen, was auf eine
   gemeinsame Wurzel deutet — aber Median vs. Mittelwert und Plattformtrennung
   sind unverifiziert.
2. **Definitionsproblem Sessionlänge** (siehe oben), Faktor 4–5.
3. **Datenalter.** GameAnalytics-Basis ist 2024, publiziert 2025/26. Für einen
   2026-Benchmark grenzwertig, aber die aktuellste auffindbare Systematik.
4. **Genre-Unschärfe an der wichtigsten Stelle.** Der 59/41-Split gilt für
   hybrid-casual Titel *mit* Interstitials und IAP-Progression. Für ein
   Rewarded-only-Modell ist der erreichbare IAA-Anteil strukturell niedriger.
   Als Zielgröße untauglich, als Kontext brauchbar.

## Nicht belegbar

| Metrik | Status | Wie messbar |
|---|---|---|
| Rewarded-eCPM Deutschland, absolut | Unbekannt — keine abrufbare Quelle | AdMob-Reporting nach Land segmentieren, sobald DE-Traffic existiert. Der eigene Wert schlägt jeden Benchmark. |
| Retention speziell Block-Puzzle (statt Puzzle gesamt) | Unbekannt — Subgenre-Daten kostenpflichtig | Firebase-Kohorten gegen die Puzzle-Gesamtwerte spiegeln (Phase 6) |
| IAP-Konversion speziell Casual/Puzzle Android | Unbekannt — nur genreübergreifend 2–5 % | `purchase`-Events / DAU messen (Phase 6) |
| Rewarded-only vs. interstitial-getrieben, selber Titel | Unbekannt — kein Report beziffert das | Extern nicht beschaffbar. Ersatz: eigenen Rewarded-ARPDAU gegen die 0,05–0,15-USD-Spanne halten und die Differenz als Preis der Designentscheidung ausweisen. |
| Ad/IAP-Split für Rewarded-only-Titel | Unbekannt | Ad- und IAP-Revenue getrennt tracken (Phase 6) |

---

## Quellen

Alle Abrufe **2026-08-31**. Belegtyp: „Suchtreffer" = URL und Referat aus der
Websuche; „direkt" = Seite tatsächlich geöffnet.

| URL | Titel | Belegtyp |
|---|---|---|
| <https://www.streetinsider.com/Business+Wire/Block+Blast!+Ends+Q1+2026+as+the+No.+1+Most+Downloaded+Mobile+Game+Worldwide/26355494.html> | Block Blast! Ends Q1 2026 as the No. 1 Most Downloaded Mobile Game Worldwide | Suchtreffer |
| <https://marketingtrending.asoworld.com/en/discover/april-2026-mobile-game-rankings-block-blast-leads-downloads-honor-of-kings-tops-revenue/> | April 2026 Mobile Game Rankings | Suchtreffer |
| <https://www.capermint.com/blog/develop-a-game-like-block-blast/> | How to Develop a Game Like Block Blast — The $584K/Day Puzzle | Suchtreffer |
| <https://www.blog.udonis.co/statistics/block-blast> | Block Blast Revenue, Downloads & User Statistics [2026] | Suchtreffer |
| <https://www.singular.net/blog/top-mobile-games/> | Top mobile games 2026: who leads on downloads, revenue and DAU | Suchtreffer |
| <https://sensortower.com/blog/google-play-download-sources> | 88% of Google Play Game Downloads Come From Search and Browse | Suchtreffer |
| <https://www.deconstructoroffun.com/blog/2026/1/19/from-tetris-to-block-blast-why-block-puzzles-never-stop-printing> | The Post-Block Blast Playbook | Suchtreffer |
| <https://appfollow.io/blog/app-store-optimization-for-games> | App Store Optimization for Games: 2026 ASO Playbook | Suchtreffer |
| <https://asoworld.com/en/blog/google-i-o-2026-key-developer-insights-for-apps-and-games-on-google-play/> | Google I/O 2026: Key Developer Insights for Apps and Games on Google Play | Suchtreffer |
| <https://www.gameanalytics.com/reports/2026-mobile-pc-gaming-benchmarks> | 2026 Mobile & PC Gaming Benchmarks | Suchtreffer (Abruf blockiert) |
| <https://gamedevreports.substack.com/p/gameanalytics-mobile-and-pc-game> | GameAnalytics: Mobile and PC Game Benchmarks in 2026 | Suchtreffer |
| <https://gamedevreports.substack.com/p/sensor-tower-mobile-game-ad-monetization> | Sensor Tower: Mobile Game Ad Monetization in 2026 | Suchtreffer |
| <https://sensortower.com/blog/state-of-gaming-2026> | State of Gaming 2026 | Suchtreffer |
| <https://www.appsflyer.com/resources/reports/app-marketing-monetization-report/> | The State of App Monetization — 2026 Edition | Suchtreffer |
| <https://tenjin.com/blog/ad-mon-gaming-2026/> | Ad Monetization Benchmark Report 2026 | Suchtreffer |
| <https://maf.ad/en/blog/rewarded-ads-stats/> | Rewarded Ads Unpacked: Performance Insights for 2026 | Suchtreffer |
| <https://bidlogic.io/2026/07/31/q2-2026-ecpm-growth-interstitial-rewarded-video-and-banner-trends/> | Q2 2026 eCPM growth | Suchtreffer |
| <https://appfollow.io/blog/mobile-game-kpis> | Mobile Game KPIs: The 2026 Guide | Suchtreffer |
| <https://www.adjust.com/resources/ebooks/gaming-app-insights/> | The gaming app insights report: 2026 edition | Suchtreffer |
| <https://www.juegostudio.com/blog/arpdau-benchmarks-by-game-genre> | ARPDAU Benchmarks by Genre | Suchtreffer |
| <https://gamegrowthadvisor.com/blog/2026-03-17-mobile-game-kpis-benchmarks-2026/> | The 20 Mobile Game KPIs That Actually Matter in 2026 | Suchtreffer |
| <https://developer.android.com/google/play/requirements/target-sdk> | Meet Google Play's target API level requirement | **direkt** |
| <https://developer.android.com/google/play/billing/deprecation-faq> | Google Play Billing Library version deprecation | **direkt** |
