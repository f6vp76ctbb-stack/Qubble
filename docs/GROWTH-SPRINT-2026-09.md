# Growth-Sprint: 1.000 Installationen bis So, 27.09.2026

Stand: **21.09.2026** · App `com.thinkube.qubble` · Ziel: **≥ 1.000 Installationen
laut Play Console** bis Sonntag, 27.09.2026, 23:59 Uhr.
Ausgangslage: seit dem 17./18.09. in Produktion, praktisch 0 Impressionen und
0 Installationen.

> **Was dieses Dokument nicht tut.** Es schreibt keine Play-Console- oder
> Google-Ads-Menüpfade aus dem Gedächtnis (`CLAUDE.md`, Abschnitt „nichts
> erfinden"). Wo ein Klickweg nötig wäre, stehen hier **Werte, Antworten und
> Suchbegriffe**. Fehlt dir ein Feld: Feldnamen oder Screenshot schicken.

## Was in dieser Session verifiziert werden konnte — und was nicht

| Quelle | Status |
|---|---|
| Zeichenlimits Google Ads (5 Headlines à 30, 5 Descriptions à 90) | ✅ belegt, [Google Ads Help](https://support.google.com/google-ads/answer/6357595?hl=en) |
| Alle Texte in diesem Dokument gegen ihre Limits | ✅ **programmatisch gezählt**, 0 Überläufe |
| UTM-/Referrer-Format für Play | ✅ belegt, [Play Console Help](https://support.google.com/googleplay/android-developer/answer/6263332?hl=en) |
| CPI-Spannen, Lernphase, Anzeigenprüfung | ✅ belegt, Quellen am Dateiende |
| **Live-Store-Eintrag** | ❌ `play.google.com` ist egress-gesperrt |
| **Subreddit-Regeln** | ❌ `reddit.com` ist egress-gesperrt — **vor jedem Post selbst prüfen**, siehe D3 |
| **Budget, Zeit/Tag, freigeschaltete Länder, eigene Reichweite** | ❌ nicht beantwortet — Plan ist deshalb budget-parametrisiert |

## Abweichung vom MASTERPLAN — bewusst, und deine Entscheidung

`MASTERPLAN.md`, Phase 5 legt fest:

> - [ ] Erst wenn LTV > CPI messbar: kleine Paid-UA-Tests

Dieser Sprint tut genau das Gegenteil: Er schaltet bezahlte UA, **bevor** ein
LTV messbar ist — es gibt schlicht noch keine Nutzer, an denen man ihn messen
könnte. Der Plan hat damit recht, und der Auftrag „1.000 Installationen bis
Sonntag" ist ohne diesen Bruch rechnerisch nicht erfüllbar (Schritt 1,
Abschnitt B).

Das ist keine Empfehlung, den Plan zu ändern, sondern die Feststellung, dass
hier zwei Ziele kollidieren. Die Wahl liegt bei dir:

| | Ziel | Konsequenz |
|---|---|---|
| **Sprint** | 1.000 bis Sonntag | Budget wird ohne LTV-Kenntnis ausgegeben. Der CPI ist danach bekannt, der LTV immer noch nicht |
| **MASTERPLAN** | erst messen, dann kaufen | Ziel bis Sonntag entfällt. Dafür kostet die erste UA-Ausgabe später nicht blind |

Ein Mittelweg, der beides teilweise bedient, steckt bereits im Plan: die 15 %
Budgetanteil auf Länder-Set B (DACH, D2 Abschnitt 3). Die liefern kaum
Volumen, aber einen echten DACH-CPI — die eine Hälfte der Gleichung, die der
MASTERPLAN verlangt.

---

---

# C) Tagesplan bis Sonntag

**Annahme, die du kippen kannst:** ~2 h/Tag, Mo etwas mehr. Steht dir weniger
zur Verfügung, streiche in dieser Reihenfolge: Kurzvideos → itch/Verzeichnisse →
zweite Reddit-Welle. **Die Google-Ads-Kampagne wird nie gestrichen** — ohne sie
ist das Ziel rechnerisch nicht erreichbar (Schritt 1, Abschnitt B).

Tagesziele sind kumulativ gerechnet und berücksichtigen die Lernphase der
App-Kampagne (2–7 Tage, [Quelle](https://support.google.com/google-ads/answer/13020501?hl=en)),
die Montag und Dienstag noch drückt.

| Tag | Uhrzeit (CEST) | Aufgabe | Zeit | Ziel-Installs kumulativ |
|---|---|---|---|---|
| **Mo 21.09.** | 09:00 | Prüfliste A1–A12 aus Schritt 1 abarbeiten | 30 min | — |
| | 09:30 | Google-Ads-Konto + Zahlungsmethode + Play-Verknüpfung (D2, Abschnitt 1) | 45 min | — |
| | 10:15 | Kampagne anlegen, Assets einfügen, **noch nicht starten** | 45 min | — |
| | 11:00 | UTM-Links anlegen (E), in Notizen speichern | 10 min | — |
| | 11:10 | Netzwerk-Nachricht rausschicken (D5) | 15 min | — |
| | ab 14:00 | **Rohmaterial aufnehmen**: 10 min Gameplay, Hochkant, ohne Schnitt. Basis für alle 7 Clips **und** die Video-Assets der Kampagne | 45 min | **15** |
| | 18:00 | Kampagne **starten** (Anzeigenprüfung läuft über Nacht) | 5 min | |
| **Di 22.09.** | 08:00 | Prüfen: Anzeigen „Zulässig"? Sonst Ablehnungsgrund lesen und beheben | 15 min | |
| | 12:00 | **Reddit-Post 1** → r/AndroidGaming (D3) | 30 min | |
| | 12:30–14:00 | Auf Kommentare antworten (das entscheidet über die Reichweite) | 45 min | |
| | 19:00 | Clips 1+2 schneiden und posten (D4) | 60 min | **75** |
| **Mi 23.09.** | 08:00 | **KONTROLLPUNKT 1** — Entscheidungsregeln unten | 20 min | |
| | 12:00 | **Reddit-Post 2** → r/playmygame (D3) | 25 min | |
| | 19:00 | Clips 3+4 | 45 min | **190** |
| **Do 24.09.** | 08:00 | Kampagnen-Check, Land/Creative nach Regel unten anpassen | 15 min | |
| | 12:00 | **Reddit-Post 3** → r/AndroidApps oder r/IndieDev (D3) | 25 min | |
| | 19:00 | Clips 5+6 | 45 min | **340** |
| **Fr 25.09.** | 08:00 | **KONTROLLPUNKT 2 — Plan B** | 30 min | |
| | 12:00 | itch.io / IndieDB / Verzeichnisse eintragen | 40 min | |
| | 19:00 | Clip 7 + bester Clip erneut, anderer Hook | 40 min | **510** |
| **Sa 26.09.** | 10:00 | Kampagnen-Check, Budget nach Regel unten | 15 min | |
| | 11:00 | Zweitverwertung: bester Clip auf Reels + Shorts | 30 min | |
| | 18:00 | Kommentare beantworten, überall | 30 min | **740** |
| **So 27.09.** | 10:00 | Letzter Budget-Push, falls Regel erfüllt | 15 min | |
| | 11:00 | Nachfass-Kommentar in den Reddit-Threads (Update, kein Repost) | 20 min | |
| | 22:00 | Zahlen sichern: Screenshot Play Console + Google Ads | 15 min | **1.000** |

**Posting-Fenster, als Schätzung markiert.** Ich konnte keine aktuellen
Traffic-Daten für die genannten Subreddits abrufen. Die Fenster oben
(12:00–13:00 CEST = 06:00–07:00 ET) zielen auf den US-Vormittag, der bei
englischsprachigen Android-Subs die größte Überlappung mit EU-Nachmittag
bietet. **Das ist eine Schätzung, kein Messwert.** Verlässlicher: in jedem Sub
eine Woche zurückscrollen und schauen, wann die Top-Posts gepostet wurden.

## Kontrollpunkt Mittwoch, 08:00 — Entscheidungsregeln

Gemessen wird **Google Ads** (Installationen, CPI), nicht Play Console — deren
Akquisitionsbericht hinkt mehrere Tage hinterher (siehe E).

| Befund Mi 08:00 | Entscheidung |
|---|---|
| Anzeigen noch „In Prüfung" | Nichts überstürzen. Ist es **Mi Mittag** noch so, Google-Ads-Support kontaktieren; parallel Reddit + Clips hochziehen, sie sind dann der einzige Kanal |
| CPI ≤ 60 % vom Zielwert, Ausgaben < 60 % des Tagesbudgets | Kampagne findet günstige Nutzer, gibt aber nicht aus → **Tagesbudget × 1,5**, tCPI unverändert |
| CPI ≤ Zielwert, Budget wird voll ausgegeben | **Tagesbudget × 2.** Das ist der gute Fall |
| CPI 100–150 % vom Zielwert | tCPI **unverändert lassen**, 24 h warten. Änderungen an tCPI werfen die Kampagne in die Lernphase zurück |
| CPI > 150 % vom Zielwert | Teuerste Länder aus dem Targeting nehmen — **nicht** den tCPI senken |
| Installationen = 0 trotz „Zulässig" und Ausgaben | Kampagne kauft Klicks, die nicht installieren → Store-Eintrag ist die Bremse. Prüfliste A1–A5 **erneut**, insbesondere Länderverfügbarkeit |
| Reddit-Post 1 entfernt | Ursache im Modmail erfragen, **nicht** erneut posten. Sub aus dem Plan streichen, Do-Slot mit einem anderen füllen |

## Kontrollpunkt Freitag, 08:00 — Plan B

Soll-Stand Fr 08:00: **340 Installationen**.

| Ist-Stand | Plan B |
|---|---|
| ≥ 340 | Kurs halten. Sa/So nur Budget nach Regel oben erhöhen |
| 200–339 | **Bezahltes Budget von Sa+So vorziehen** und Fr/Sa ausgeben. Lieber 2 Tage mit doppeltem Budget als 4 mit halbem — die Lernphase ist dann durch |
| 80–199 | Organik trägt nicht. Restbudget **vollständig** in die Kampagne, günstigstes Land isoliert. Kurzvideos einstellen, die Zeit in Kommentar-Arbeit in den laufenden Reddit-Threads stecken |
| < 80 | **Ziel ist bis Sonntag nicht mehr erreichbar.** Dann keine Panik-Maßnahmen: Jede Abkürzung, die jetzt noch 900 Installationen bringen würde, fällt unter „gekaufte oder incentivierte Installs" und kostet dich das Konto. Sprint neu terminieren, Budget auf 14 Tage strecken |

**Die Regel, die über allen steht:** Kein Kontrollpunkt darf zu einer Maßnahme
aus der Ausschlussliste führen. Ein verfehltes Wochenziel ist reparabel, ein
zweiter Enforcement-Fall nicht.

---

# D) Assets

## D1 · Store-Eintrag

### Vorab: diese Woche so wenig wie möglich am Listing ändern

Jede Änderung am Store-Eintrag geht bei Play durch eine Prüfung — 2026
typischerweise **1–7 Tage**, und der mit Abstand häufigste Ablehnungsgrund ist
**Metadaten, die nicht zur App passen**
([Aerious 2026](https://aerious.uk/blog/google-play-review-time-in-2026-real-timelines-and-how-to-avoid-delays)).
Bei einem Konto mit Enforcement-Vorgeschichte in der Woche, in der der Traffic
ankommt, ist das ein schlechtes Tauschgeschäft.

**Empfehlung, klar:**

| Änderung | diese Woche? | Begründung |
|---|---|---|
| **Screenshots aktualisieren** (`docs/PLAY-CONSOLE-1.2.0.md`, B3 — noch offen) | **Ja, heute** | Die hochgeladenen Bilder zeigen ein HUD, das es nicht mehr gibt. Das ist die einzige Änderung, die das Policy-Risiko **senkt** statt es zu erhöhen. Dateien liegen fertig in `store-assets/de/` und `store-assets/en/` |
| Kurzbeschreibung tauschen | **Nein** | Ein Feld, aber dieselbe Prüfung. Der Gewinn ist kleiner als das Risiko, mitten im Sprint „In Prüfung" zu stehen |
| Vollbeschreibung tauschen | **Nein** | dto., und die aktuelle Fassung ist gegen den Code geprüft (`audit/05-aso.md`, Abschnitt 1) |
| Titel ändern | **Nein** | Titeländerungen kosten zusätzlich die bisherige Suchhistorie |

Die Texte unten sind für **nach dem Sprint** fertig — oder für sofort, wenn du
das Risiko bewusst nimmst. Sie sind nicht Voraussetzung für die 1.000.

### Kurzbeschreibungen (Play, max. 80 Zeichen) — alle Längen gezählt

Unterschied zu den Varianten in `audit/05-aso.md` §3: die dortigen sind auf
**Play-Suche** optimiert (Keyword zuerst). Diese hier sind auf den Traffic
**dieser Woche** optimiert — Besucher aus Reddit, TikTok und Anzeigen wissen
schon, dass es ein Block Puzzle ist. Sie brauchen den Grund, **dieses** zu
nehmen.

**Deutsch**

| Var. | Text | Zeichen |
|---|---|---:|
| **S1** | `Block Puzzle offline: Reihen räumen, Highscore knacken, null Zwangswerbung.` | 75 |
| **S2** | `Blockpuzzle ohne Nerverei: keine Banner, keine Interstitials, offline spielbar.` | 79 |
| **S3** | `Reihe voll, Reihe weg. Offline, ohne Anmeldung, ohne erzwungene Werbung.` | 72 |

**Englisch**

| Var. | Text | Zeichen |
|---|---|---:|
| **S1** | `Offline block puzzle: clear lines, beat your score, zero forced ads.` | 68 |
| **S2** | `Block puzzle without the nagging: no banners, no interstitials, plays offline.` | 78 |
| **S3** | `Fill a line, watch it go. Offline, no sign-up, not one forced ad.` | 65 |

**Empfehlung: S2.** Sie führt mit dem einzigen belegbaren Unterschied zu den
Marktführern und wiederholt nicht, was der Titel schon sagt.

### Vollbeschreibung

**Nicht neu schreiben.** Die einsatzfertigen Fassungen liegen in
`audit/copy/long-de.txt` (3.075 Zeichen) und `audit/copy/long-en.txt`
(2.812 Zeichen). Beide sind gegen den Code geprüft; drei frühere Aussagen
(„kein Server", „drei Sterne", „kein Zeitdruck") wurden entfernt, weil sie der
Prüfung nicht standhielten. Eine Neufassung würde genau dieses Risiko
wiedereinführen.

**Die einzige Stelle, an der sich der Traffic dieser Woche unterscheidet, ist
der erste Absatz** — bei Play sind nur ~3 Zeilen sichtbar, bevor „Mehr ansehen"
kommt. Wer aus einem Reddit-Thread kommt, braucht dort nicht das Genre erklärt,
sondern die Bestätigung, dass das Versprechen stimmt:

**DE — Alternativ-Einstieg (ersetzt nur Absatz 1):**

```
Keine Interstitials. Keine Banner. Kein „schau ein Video, um weiterzuspielen".
Qubble ist das Block Puzzle, das dich nie unterbricht – offline spielbar, ohne
Anmeldung, ohne Konto. Blöcke setzen, Reihen räumen, Highscore knacken.
```

**EN — alternative opener (replaces paragraph 1 only):**

```
No interstitials. No banners. No "watch a video to keep playing". Qubble is the
block puzzle that never interrupts you — plays offline, no sign-up, no account.
Drop blocks, clear lines, beat your high score.
```

Beide Absätze sind inhaltlich durch `audit/05-aso.md` gedeckt: Die App hat
nachweislich nur Rewarded Ads (`lib/monetization/ads.dart`), das Spiel selbst
läuft offline, und Weiterspielen kostet Münzen, nie ein Video.

### Screenshot-Captions

Die sechs Captions existieren bereits, sind aus den echten Screens gerendert
und sitzen richtig (`store-assets/README.md`, Abschnitt „Die sechs Motive").
Sie werden **nicht** ersetzt — das wäre Arbeit ohne Gegenwert.

Eine Änderung lohnt sich, und nur eine: **Screenshot 6** trägt heute
„Keine Zwangswerbung." / „No forced ads. Ever." Für Traffic, der aus einer
Anzeige mit genau dieser Aussage kommt, ist das eine Wiederholung. Stärker
wäre dort der zweite belegbare Unterschied:

| # | heute | Alternative DE | Alternative EN |
|---|---|---|---|
| 6 | Keine Zwangswerbung. | `Weiterspielen kostet Münzen, nie ein Video.` | `Continue with coins you earned. Never an ad.` |

Neu erzeugen mit `python3 tool/caption_screenshots.py` nach Änderung von
`CAPTIONS` in derselben Datei. **Gilt die Empfehlung oben: diese Woche nicht.**

---

## D2 · Google-Ads-App-Kampagne

### 1 · Voraussetzungen (Montag, vor allem anderen)

Reihenfolge ist bindend — Schritt 4 geht nicht ohne 3, und 3 nicht ohne 2.

| # | Was | Wert / Antwort | Dauer |
|---|---|---|---|
| 1 | Google-Ads-Konto auf **denselben Google-Account** wie die Play Console | — | 10 min |
| 2 | **Zahlungsmethode** hinterlegen, Abrechnungsland = dein Land | — | 10 min |
| 3 | **Play Console ↔ Google Ads verknüpfen**: In der Play Console eine Verknüpfung zur Google-Ads-Kundennummer einladen, im Google-Ads-Konto annehmen. Suchbegriff in beiden Oberflächen: `Verknüpfte Konten` / `Linked accounts` | Kundennummer: 10-stellig, steht oben rechts in Google Ads | 15 min |
| 4 | **Conversion: App-Installation (Google Play)** aktivieren | Für Android-Installationen braucht es **kein SDK und keinen Code** — die Verknüpfung aus 3 liefert die Installations-Conversion ([Quelle](https://support.google.com/google-ads/answer/6255257?hl=en)) | 5 min |
| 5 | **Advertiser-Verifizierung** starten, falls angefordert | Ausweisdokument bereithalten. Frist 30 Tage, Anzeigen laufen in der Regel währenddessen ([Quelle](https://support.google.com/adspolicy/answer/9703665?hl=en)) | 10 min |

> **Wenn Schritt 3 scheitert:** Ohne Verknüpfung kann die Kampagne keine
> Installationen zählen und optimiert ins Blaue. Dann **nicht** starten,
> sondern erst die Verknüpfung klären. Eine Kampagne ohne Conversion-Signal
> verbrennt in 6 Tagen das ganze Budget und lernt nichts.

### 2 · Kampagnen-Einstellungen — Werte, nicht Klickwege

| Feld | Wert | Warum |
|---|---|---|
| Kampagnentyp | **App** | |
| Unterziel | **App-Installationen** | |
| App | `com.thinkube.qubble`, Android | |
| Gebotsstrategie | **Conversions maximieren** — **kein** Ziel-CPI setzen | Bei null Conversion-Historie drosselt ein zu niedriger Ziel-CPI die Auslieferung, und die Lernphase wird in 6 Tagen nie fertig. Praktiker-Empfehlung 2026: erst „Conversions maximieren", Ziel-CPI erst ab ~30 Conversions/Woche ([Quelle](https://support.google.com/google-ads/answer/12073727?hl=en)) |
| Tagesbudget | **Gesamtbudget ÷ 6** (Di–So) | Tabelle unten |
| Zielgruppe | **Alle Nutzer** (nicht „Nutzer, die wahrscheinlich …") | Maximales Volumen, das ist diese Woche das Ziel |
| Sprachen | **Englisch + Deutsch** | Die App spricht nur diese beiden (`lib/l10n/`). Andere Sprachen zu targetieren erzeugt Installationen, die die App nicht bedienen kann |
| Länder | siehe Länder-Sets unten — **nur aus den Ländern wählen, die in Prüfliste A3 tatsächlich freigeschaltet sind** | |
| Anzeigenrotation / Placements | Standard lassen | App-Kampagnen sind absichtlich kaum steuerbar; jeder Ausschluss verkleinert nur den Suchraum |

**Budget → erwartete Installationen** (CPI-Schätzung 0,25 € für Set A,
1,55 € für Set B; Herleitung in Schritt 1, Abschnitt B):

| Gesamtbudget | Tagesbudget (÷6) | Set A (Volumen) | Set B (DACH) |
|---:|---:|---:|---:|
| 150 € | 25 € | ~600 | ~95 |
| 250 € | 42 € | ~1.000 | ~160 |
| 400 € | 67 € | ~1.600 | ~260 |
| 600 € | 100 € | ~2.400 | ~390 |

### 3 · Länder-Sets

| Set | Länder | CPI-Schätzung | Warum genau diese |
|---|---|---:|---|
| **A — Volumen** | Indien, Pakistan, Philippinen, Bangladesch, Nigeria, Kenia | 0,10–0,40 € | Casual-Android in Indien ab $0,08, APAC Ø $0,27 ([FoxData 2026](https://foxdata.com/en/blogs/2026-mobile-game-user-acquisition-cost-benchmarks-how-much-should-you-spend/)). **Alle sechs sind englischsprachige Märkte** — das ist der Punkt: Der Store-Eintrag und die App sind Englisch, also passt das Produkt zum Land |
| **B — DACH** | Deutschland, Österreich, Schweiz | 1,20–2,20 € | DACH Ø $1,70 ([FoxData 2026](https://foxdata.com/en/blogs/2026-mobile-game-user-acquisition-cost-benchmarks-how-much-should-you-spend/)). Deutscher Store-Eintrag und deutsche App liegen vor |
| ~~C — Mitte~~ | ~~Brasilien, Indonesien, Vietnam, Türkei~~ | 0,14–0,50 € | **Bewusst gestrichen.** Günstig, aber weder App noch Store-Eintrag sprechen diese Sprachen. Das erzeugt Installationen, die am ersten Tag wieder deinstallieren — und seit 2026 fließt Post-Install-Verhalten ins Play-Ranking ein (`audit/05-aso.md`, Abschnitt 5). Für 1.000 in einer Woche nicht nötig |

**Empfehlung: Set A und Set B als zwei getrennte Kampagnen**, Budget ~85 % auf
A, ~15 % auf B. Getrennt, weil ein gemeinsames Budget sonst binnen Stunden
vollständig nach A abfließt und du nie erfährst, was DACH kostet. Die 15 % auf
B sind kein Volumenkanal, sondern dein Messwert für danach.

### 4 · Anzeigen-Assets — fertig, Zeichenzahl geprüft

Limits: **max. 5 Headlines à 30 Zeichen, max. 5 Descriptions à 90 Zeichen**
([Google Ads Help](https://support.google.com/google-ads/answer/6357595?hl=en)).
Alle Texte unten wurden programmatisch gezählt, **0 Überläufe**.

**Headlines Englisch (Set A)**

| Text | Zeichen |
|---|---:|
| `Block Puzzle, Fully Offline` | 27 |
| `No Forced Ads. Not One.` | 23 |
| `Fill a Line. Watch It Go.` | 25 |
| `Three Blocks, an 8x8 Grid` | 25 |
| `Beat Your High Score` | 20 |

*Reserve zum Tauschen:* `Never Watch an Ad to Play` (25), `A New Challenge Daily` (21), `Relaxing Block Puzzle` (21)

**Descriptions Englisch (Set A)**

| Text | Zeichen |
|---|---:|
| `Drop blocks, clear lines, beat your high score. Plays offline, with no forced ads.` | 82 |
| `No interstitials, no banners. Videos only ever run when you tap them yourself.` | 78 |
| `Daily challenge, puzzle mode, eight themes. Runs completely without internet.` | 77 |
| `Three blocks, one 8x8 grid. Easy to learn, hard to master.` | 58 |
| `No account, no sign-up. Your progress stays on your device.` | 59 |

**Headlines Deutsch (Set B)**

| Text | Zeichen |
|---|---:|
| `Block Puzzle, ganz offline` | 26 |
| `Ohne Zwangswerbung spielen` | 26 |
| `Reihe voll. Reihe weg.` | 22 |
| `Drei Blöcke, 8x8-Raster` | 23 |
| `Dein Highscore wartet` | 21 |

*Reserve zum Tauschen:* `Kein Video zum Weiterspielen` (28), `Täglich neue Challenge` (22), `Entspanntes Block Puzzle` (24)

**Descriptions Deutsch (Set B)**

| Text | Zeichen |
|---|---:|
| `Blöcke setzen, Reihen räumen, Highscore knacken. Offline und ohne Zwangswerbung.` | 80 |
| `Keine Interstitials, keine Banner. Videos nur, wenn du sie selbst antippst.` | 75 |
| `Tägliche Challenge, Rätsel-Modus, acht Themes. Läuft komplett ohne Internet.` | 76 |
| `Drei Blöcke, ein 8x8-Raster. Leicht zu lernen, schwer zu meistern.` | 66 |
| `Kein Konto, keine Anmeldung. Dein Fortschritt bleibt auf dem Gerät.` | 67 |

> **Policy-Grenze in Anzeigentexten:** Kein einziger Wettbewerbertitel
> (Woodoku, Block Blast, Blockudoku, 1010!) darf in Headline oder Description
> stehen. Im Fließtext der Play-Vollbeschreibung ist die Nennung üblich und
> bleibt dort — in einer Anzeige wäre sie Markennutzung. Ebenso keine
> Superlative („bestes", „Nr. 1"), die nicht belegbar sind.

### 5 · Bild- und Video-Assets — liegen im Repo bereit

```bash
python3 tool/ad_creatives.py     # -> store-assets/ads/<locale>/
```

Erzeugt **24 Dateien**: 4 Motive (`clear`, `combo`, `noads`, `daily`) × 3
Formate × 2 Sprachen. Die Formate sind die drei, die App-Kampagnen erwarten —
**1200×1200, 1200×628, 1200×1500**
([Google Ads Help](https://support.google.com/google-ads/answer/17091671?hl=en)) —
und alle drei müssen existieren, sonst spielt die Kampagne an den Platzierungen
der fehlenden Form gar nicht aus.

Die Spielfeld-Pixel stammen aus den fertigen Store-Screenshots, die ihrerseits
aus der echten App gerendert sind. **Nichts daran ist nachgemalt** — eine
Anzeige, die eine Oberfläche zeigt, die die App nicht hat, ist derselbe
Misrepresentation-Fall wie ein falscher Store-Screenshot.

Hochladen: für Set A die Dateien aus `store-assets/ads/en/`, für Set B die aus
`store-assets/ads/de/`.

**Video:** App-Kampagnen nehmen Videos nur **von YouTube**, Länge 10–60 s,
Hochformat 9:16 und Querformat 16:9 ([Quelle](https://support.google.com/google-ads/answer/17091671?hl=en)).
Lädst du keines hoch, baut Google selbst eines aus deinen Bildern — das
funktioniert, ist aber regelmäßig das schwächste Asset der Kampagne. **Nimm
stattdessen den besten der Clips aus D4**, lade ihn als *nicht gelistet* bei
YouTube hoch und hänge die URL in die Kampagne. Das ist Montagabend-Arbeit von
15 Minuten und der größte einzelne Hebel auf den CPI.

### 6 · Stopp- und Skalierungs-Kriterien

Die Tagesregeln stehen in Abschnitt C (Kontrollpunkte Mi/Fr). Zusätzlich gilt
durchgehend:

| Auslöser | Handlung |
|---|---|
| Anzeigen „Abgelehnt" | Grund lesen, Text tauschen, **nicht** identisch neu einreichen |
| CPI in Set B > 3,00 € nach 48 h | Set B pausieren, Budget nach A |
| Ein Bildformat liefert 0 Impressionen | Datei prüfen (Maße exakt? < 5 MB?), neu hochladen |
| Asset-Bewertungen („Gering"/„Gut"/„Optimal") | **In dieser Woche ignorieren.** Sie brauchen deutlich mehr Conversions, als 6 Tage liefern — danach zu optimieren wäre Rauschen |
| Tagesbudget läuft mittags leer | Gutes Zeichen. Budget erhöhen statt Gebote senken |
| Installationen brechen nach einer Änderung ein | Lernphase. **24 h nichts anfassen.** Jede zweite Änderung innerhalb der Lernphase verlängert sie |

**Die teuerste Fehlbedienung in dieser Woche** ist tägliches Nachjustieren. Die
Lernphase dauert 2–7 Tage ([Quelle](https://support.google.com/google-ads/answer/13020501?hl=en)),
du hast 6. Wer täglich am Gebot dreht, verlässt sie nie.

---

## D3 · Community-Posts

> **Ungeprüft — vor jedem Post 60 Sekunden investieren.** `reddit.com` ist in
> der Session, in der dieses Dokument entstand, egress-gesperrt. Die Regeln der
> vier Subs konnten **nicht** live gelesen werden. Die Texte unten sind
> geschrieben, um gegen die üblichen Selbstpromotions-Regeln nicht zu
> verstoßen — sie sind **kein Beleg**, dass sie es nicht tun.

**Pre-Flight, für jeden Sub einzeln, vor dem Posten:**

1. `reddit.com/r/<sub>/about/rules` öffnen und lesen.
2. Prüfen, ob es einen **angepinnten Wochen-Thread** für Selbstpromotion gibt —
   dann gehört der Beitrag dorthin, nicht als eigener Post.
3. Prüfen, ob **Mindest-Karma oder Kontoalter** verlangt wird.
4. Prüfen, welches **Flair** Pflicht ist (oft `[DEV]`, `Self-Promo`, `Android`).
5. Im Sub nach „block puzzle" suchen: Wie liefen vergleichbare Posts? Wurden
   sie entfernt?

**Regel für alle vier:** Keine Bitte um Installation, keine Bitte um
Bewertungen, kein „bitte unterstützt mich". Du zeigst etwas und stellst eine
Frage. Nach dem Posten die ersten zwei Stunden auf **jeden** Kommentar
antworten — das entscheidet über die Reichweite mehr als der Text.

### Post 1 — r/AndroidGaming · Di 22.09., 12:00 CEST

**Titel:**
`[DEV] I built a block puzzle where you never have to watch an ad to keep playing`

**Text:**

```
I've been playing block puzzles for years and the thing that finally made me
build my own was the ad wall. You lose, and instead of the board you get a
30-second video. Sometimes twice.

So Qubble has no interstitials and no banners. Anywhere. Continuing after a
game over costs coins you earned by playing, never a video. The only ads in
the game are rewarded ones you tap yourself — double your coins, open the
piggy bank early — and they always pay what they say.

Other things that came out of the same idea:
- The game itself runs fully offline. Only the leaderboard needs a connection,
  and that one is optional and needs no account.
- Daily challenge: the same pieces in the same order for everyone worldwide.
- Puzzle mode: every level is verified solvable by a solver before you see it,
  so you can never get handed an impossible board.

It's free, Android only for now. Link in the comments so this doesn't read as
a drop-and-run.

Honest question for this sub, because I genuinely don't know: is "no forced
ads" something you'd actually switch games for, or has everyone just made
peace with the ad wall by now?
```

**Erster eigener Kommentar** (direkt nach dem Post): der UTM-Link aus
Abschnitt E, Variante `reddit`.

### Post 2 — r/playmygame · Mi 23.09., 12:00 CEST

**Titel:**
`[Android][Free] Qubble – block puzzle with a solver-verified puzzle mode`

**Text:**

```
What it is: an 8x8 block puzzle. Three pieces at a time, fill rows and columns,
they clear. Standard genre, so here is what's actually different:

1. Puzzle mode. Levels are generated and then run through a solver before they
   ship, so every board you get is provably clearable. No "this one was just
   impossible" runs.
2. No forced ads. No interstitials, no banners, and continuing after a game
   over costs in-game coins, not a video.
3. Combo windows count moves, not seconds. I had it on a timer first and
   measured that slow players lost up to 61% of their score to nothing but
   tapping speed. Moves fixed it.

Free, Android, plays offline, no account.

What I'd like feedback on specifically: the first 60 seconds. There's a short
in-run coach for the first placement and I can't tell any more whether it
helps or gets in the way. If you bounce off early, I'd love to know at which
screen.
```

### Post 3 — r/AndroidApps · Do 24.09., 12:00 CEST

> **Wichtig:** Viele App-Subs erlauben Entwickler-Posts nur im Wochen-Thread.
> Wenn Pre-Flight Schritt 2 einen findet, gehört der Text **dorthin**, gekürzt
> auf die ersten zwei Absätze.

**Titel:**
`Qubble – a block puzzle with no interstitials, no banners, and no ad wall on game over`

**Text:**

```
Free Android block puzzle I've been building. The one design rule the whole
thing is built around: the game never interrupts you to show a video.

- No interstitials, no banners, anywhere in the app.
- Game over -> you continue with coins you earned, never by watching an ad.
- Rewarded videos exist, but only where you tap them yourself, and they always
  pay out what was promised.
- Plays fully offline. No account, no sign-up, no email.
- The optional leaderboard is the only thing that talks to a server, and it
  only ever sends a display name you pick and a score. You can delete your
  entry from inside the app.

Eight themes, a daily challenge with streaks, and a puzzle mode where every
level is verified solvable before it ships.

Happy to answer anything about how it's built or how it pays for itself.
```

### Post 4 — r/IndieDev · Fr 25.09. (oder Do), 12:00 CEST

Hier zählt der **Entwickler**-Blickwinkel, nicht das Produkt. Das ist der
einzige der vier Posts, bei dem die interessanteste Geschichte eine Messung ist.

**Titel:**
`I timed my combo window in seconds. It cost slow players 61% of their score, and I only found out by measuring.`

**Text:**

```
Block puzzle, 8x8, combo multiplier when you clear lines in quick succession.
The window was 10 seconds, because that felt right.

Then I simulated 1,500 seeded runs at different tap speeds. A player at 1.5
seconds per move and a player at 6 seconds per move were separated by a factor
of 2.6 in final score — on identical boards, with identical decisions. The
combo window wasn't rewarding good play. It was rewarding fast thumbs, and it
was quietly punishing exactly the players who like this genre because it
doesn't rush them.

Fix was one line of intent and a lot of re-tuning: the window now counts moves,
not seconds. Speed still earns something — there's a separate bonus, capped at
+30% and added to a cleared line rather than multiplied into the combo — but it
can't decide a run any more.

The part I want to pass on: "it feels right" and "it is right" diverge most for
the players who are least like you. I'd have shipped the timer version without
blinking. The measurement was a couple of hours.

Game's on Play if anyone wants to see the result, link in the comments.
```

### Discord / Fachgruppen (ohne festen Termin)

Für Indie-Dev- und Android-Discords, in denen du **schon aktiv** bist. Bist du
in keinem aktiv: **überspringen**. Ein Erstbeitrag, der eine Werbung ist, kostet
dort mehr als er bringt.

```
Hab die letzten Monate an einem Block Puzzle gebaut und es gerade auf Play
gestellt. Die eine Regel, um die herum alles andere entstanden ist: das Spiel
unterbricht dich nie für ein Video. Keine Interstitials, keine Banner, und
Weiterspielen nach dem Aus kostet Münzen statt Werbung.

Läuft komplett offline, kein Konto nötig. Falls jemand Lust hat
draufzuschauen — mich interessiert vor allem, ob die erste Minute trägt.
```

---

## D4 · Sieben Kurzvideo-Skripte (TikTok / Reels / Shorts)

**Alle sieben werden aus einer einzigen Aufnahme geschnitten.** Montagnachmittag
10 Minuten Gameplay hochkant mitschneiden (Android-Bildschirmaufnahme reicht,
kein Kamerabild), dabei bewusst einmal jedes der folgenden Ereignisse
provozieren: eine volle Reihe, eine Dreier-Combo, ein Game Over, die tägliche
Challenge öffnen, ein Rätsel-Level lösen, durch die Themes wischen.

**Format für alle:** 9:16, 1080×1920, 12–22 s, Ton an (der Clear-Sound trägt
die Hälfte der Wirkung). Kein Logo am Anfang — die ersten zwei Sekunden gehören
dem Spielfeld.

**Hashtag-Grenze:** Keine Wettbewerbermarken als Hashtag (`#woodoku`,
`#blockblast`, `#blockudoku`). Das fällt unter „fremde Markennamen" und ist
ausgeschlossen, auch wenn es dort üblich ist.

---

### Clip 1 — „Der Moment, in dem normalerweise die Werbung kommt"

| Zeit | Bild | Text-Overlay |
|---|---|---|
| 0,0–2,0 s | Board fast voll, ein Teil passt noch, Finger zögert. **GAME OVER blendet auf** | `Jetzt kommt normalerweise das Video.` |
| 2,0–5,0 s | Weiterspielen-Dialog: Kosten in **Münzen**, kein Video-Button | `Kommt aber nicht.` |
| 5,0–9,0 s | Tippen, Board wird frei, Spiel läuft weiter | `Weiterspielen kostet Münzen. Die hast du dir verdient.` |
| 9,0–13,0 s | Weiterspielen, eine Reihe löst sich auf | `Keine Interstitials. Keine Banner. Nirgends.` |

**Caption:** Das Einzige, was ich an Block Puzzles nicht mehr ertragen habe, war die Werbewand nach dem Game Over. Also gibt es hier keine.
**Hashtags:** `#blockpuzzle #puzzlegame #mobilegame #indiegame #androidgames #gamedev`

---

### Clip 2 — Combo-Kette, ohne Worte

| Zeit | Bild | Text-Overlay |
|---|---|---|
| 0,0–1,5 s | Direkt in die Aktion: ein Teil rastet ein, erste Reihe löst sich auf, `+393` fliegt hoch | — |
| 1,5–4,0 s | Zweites Teil, zwei Linien gleichzeitig, Multiplikator springt | `x2` |
| 4,0–7,0 s | Drittes Teil, Board glüht, Fieber-Meter füllt sich | `x4` |
| 7,0–11,0 s | Großer Clear, Punktzahl läuft hoch, Neon-Theme | `Eine Kette. Vier Züge.` |

**Caption:** Ton an. Der Clear-Sound ist der halbe Spaß.
**Hashtags:** `#satisfying #blockpuzzle #puzzlegame #asmr #mobilegame #androidgames`

---

### Clip 3 — Die Messung (Entwickler-Perspektive)

| Zeit | Bild | Text-Overlay |
|---|---|---|
| 0,0–2,0 s | Board, Combo-Zähler sichtbar | `Mein Combo-Fenster lief 10 Sekunden ab.` |
| 2,0–5,0 s | Zwei Spielszenen nebeneinander, schnell / langsam gespielt | `Also habe ich 1.500 Runden simuliert.` |
| 5,0–9,0 s | Zahl groß im Bild | `Schnelle Daumen: 2,6× mehr Punkte. Bei identischen Zügen.` |
| 9,0–14,0 s | Spielszene, Combo-Anzeige zählt jetzt Züge | `Jetzt zählt das Fenster Züge statt Sekunden.` |
| 14,0–17,0 s | Ruhiger Zug, Combo hält | `Das Spiel belohnt Denken. Nicht Tippgeschwindigkeit.` |

**Caption:** „Fühlt sich richtig an" und „ist richtig" liegen am weitesten auseinander bei den Spielern, die am wenigsten wie du spielen.
**Hashtags:** `#gamedev #indiedev #gamedesign #mobilegame #blockpuzzle #devlog`

---

### Clip 4 — Tägliche Challenge

| Zeit | Bild | Text-Overlay |
|---|---|---|
| 0,0–2,0 s | Startbildschirm, Finger tippt auf die Daily-Kachel, Streak-Zähler sichtbar | `Alle bekommen heute dasselbe Board.` |
| 2,0–6,0 s | Board öffnet sich, erste Teile | `Gleiche Teile. Gleiche Reihenfolge. Weltweit.` |
| 6,0–11,0 s | Zwei, drei Züge, ein Clear | `Ein Versuch. Ein Ergebnis.` |
| 11,0–15,0 s | Streak-Zähler springt hoch | `Tag 7.` |

**Caption:** Jeden Tag ein Board, für alle dasselbe. Kein Glück, keine Ausrede.
**Hashtags:** `#dailychallenge #blockpuzzle #puzzlegame #mobilegame #androidgames`

---

### Clip 5 — „Jedes Level ist lösbar"

| Zeit | Bild | Text-Overlay |
|---|---|---|
| 0,0–2,0 s | Rätsel-Board, halb geräumt, sieht aussichtslos aus | `Sieht unmöglich aus, oder?` |
| 2,0–5,0 s | Ein Zug, zwei Reihen fallen | `Ist es nicht.` |
| 5,0–10,0 s | Weitere Züge, Board leert sich | `Jedes Level wird vorher von einem Solver geprüft.` |
| 10,0–14,0 s | Letztes Teil, Board leer, Erfolgsanimation | `Du kriegst nie ein unlösbares Board.` |

**Caption:** Im Rätsel-Modus ist jedes Level nachweislich lösbar — geprüft, bevor du es siehst.
**Hashtags:** `#puzzlegame #brainteaser #blockpuzzle #mobilegame #logicgame`

---

### Clip 6 — Die Rettung

| Zeit | Bild | Text-Overlay |
|---|---|---|
| 0,0–2,0 s | Board fast voll, nur noch wenige Lücken, drei Teile in der Ablage | `Drei Teile. Ein Ausweg.` |
| 2,0–4,0 s | Kamera bleibt, kurze Pause — der Zuschauer sucht mit | — |
| 4,0–8,0 s | Erstes Teil rastet ein, es wird enger | `Falsch gesetzt = vorbei.` |
| 8,0–13,0 s | Zweites Teil, zwei Reihen räumen gleichzeitig ab, Board atmet auf | `Geschafft.` |
| 13,0–16,0 s | Standbild auf dem freien Board | `Hättest du es gesehen?` |

**Caption:** Pausier bei Sekunde 3 und sag mir, wo du das erste Teil gesetzt hättest.
**Hashtags:** `#blockpuzzle #puzzlegame #braingames #mobilegame #canyousolveit`

---

### Clip 7 — Acht Themes

| Zeit | Bild | Text-Overlay |
|---|---|---|
| 0,0–1,5 s | Board in Classic, ein Clear läuft | `Acht Themes.` |
| 1,5–8,0 s | Schneller Schnitt durch Neon → Ocean → Wood → Sunset → Forest, in jedem ein kurzer Clear | *Theme-Name klein unten* |
| 8,0–12,0 s | Aurora zuletzt, langsamer | `Aurora gibt's nur im Unterstützer-Paket.` |
| 12,0–15,0 s | Zurück auf das Lieblings-Theme | `Welches?` |

**Caption:** Acht Themes, acht Block-Skins. Welches würdest du spielen?
**Hashtags:** `#blockpuzzle #mobilegame #gameart #puzzlegame #androidgames`

---

**Posting-Reihenfolge nach erwarteter Wirkung:** 2 → 1 → 6 → 5 → 4 → 7 → 3.
Clip 2 und 6 tragen am weitesten, weil sie ohne Kontext funktionieren. Clip 3
bringt die wenigsten Installationen, aber die besten Kommentare — und er ist
der einzige, der auch auf r/IndieDev zweitverwertbar ist.

**Wenn ein Clip nach 24 h über 5.000 Aufrufe hat:** gleicher Clip, neuer Hook,
neu hochladen. Das ist der einzige Skalierungshebel, den organische Kurzvideos
in dieser Woche hergeben.

---

## D5 · Nachricht an das persönliche Netzwerk

Ohne Bitte um Bewertungen, ohne Bitte um Installation, ohne Aufforderung zu
einer koordinierten Aktion — alle drei stehen auf deiner Ausschlussliste und
sind bei einem Konto mit Vorgeschichte das schlechteste Risiko-Nutzen-Verhältnis
der ganzen Woche.

**Für WhatsApp / Signal / Telegram, einzeln verschickt, nicht als Broadcast:**

```
Kurze Sache: Das Block-Puzzle, an dem ich die letzten Monate gebastelt habe,
ist seit ein paar Tagen im Play Store. Heißt Qubble.

Die eine Regel, um die herum alles andere entstanden ist: Das Spiel
unterbricht dich nie für ein Werbevideo. Keine Interstitials, keine Banner,
und auch Weiterspielen nach dem Aus kostet Münzen statt Werbung. Läuft
komplett offline, ohne Konto.

<LINK>

Falls du reinschaust: Mich interessiert ehrlich nur eins — ob die erste Minute
trägt oder ob du vorher aussteigst. Schreib mir gern, was dir auffällt.
```

`<LINK>` = UTM-Variante `network` aus Abschnitt E.

**Was bewusst nicht drinsteht und auch nicht ergänzt wird:**

| Nicht schreiben | Warum |
|---|---|
| „Lass gern 5 Sterne da" | Koordinierte Bewertungsaktion im Bekanntenkreis — ausgeschlossen |
| „Bitte installier es kurz" | Incentivierte/erbetene Installation ohne echtes Interesse |
| „Leite es an alle weiter" | Erzeugt genau das Muster (viele Installationen aus einem Gerätecluster in kurzer Zeit), das dein Konto schon einmal auffällig gemacht hat |
| Ein Gruppenchat mit 40 Leuten | dto., plus es liest sich als Spam |

**Obergrenze, die ich empfehle: 20–30 Einzelnachrichten über die ganze Woche
verteilt**, nicht alle an einem Abend. Der Beitrag zum Ziel ist klein (~20
Installationen); der Sinn ist, dass die ersten Nutzer Menschen sind, die dir
sagen, wo sie aussteigen.

---

# E) Tracking

## UTM-Links pro Kanal

Play liest Kampagnenparameter aus dem **`referrer`**-Parameter der Store-URL;
der Inhalt muss URL-kodiert und ≤ 512 Zeichen sein
([Play Console Help](https://support.google.com/googleplay/android-developer/answer/6263332?hl=en)).
Die Links unten sind fertig kodiert, Kampagne `sprint_0921`, längster Link
149 Zeichen.

| Kanal | Link |
|---|---|
| **Reddit** | `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Dreddit%26utm_medium%3Dpost%26utm_campaign%3Dsprint_0921` |
| **TikTok** | `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Dtiktok%26utm_medium%3Dsocial%26utm_campaign%3Dsprint_0921` |
| **Instagram** | `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Dinstagram%26utm_medium%3Dsocial%26utm_campaign%3Dsprint_0921` |
| **YouTube Shorts** | `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Dyoutube%26utm_medium%3Dsocial%26utm_campaign%3Dsprint_0921` |
| **Discord** | `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Ddiscord%26utm_medium%3Dcommunity%26utm_campaign%3Dsprint_0921` |
| **Netzwerk** | `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Dnetwork%26utm_medium%3Dreferral%26utm_campaign%3Dsprint_0921` |
| **Verzeichnisse** | `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Ditch%26utm_medium%3Dreferral%26utm_campaign%3Dsprint_0921` |

Neu erzeugen (anderer Kanal, andere Kampagne):

```python
from urllib.parse import quote
base = "https://play.google.com/store/apps/details?id=com.thinkube.qubble"
ref  = quote("utm_source=NEU&utm_medium=NEU&utm_campaign=sprint_0921", safe="")
print(f"{base}&referrer={ref}")
```

**Für Google Ads wird kein UTM-Link gebaut.** Die App-Kampagne misst ihre
Installationen selbst über die Play-Verknüpfung; ein zusätzlicher Referrer
würde die Attribution nur doppeln.

## Die tägliche 5-Minuten-Routine

**Der wichtige Vorbehalt zuerst:** Der Play-Akquisitionsbericht — also genau
die Aufschlüsselung nach UTM — läuft der Realität **mehrere Tage** hinterher;
Analyse-Anbieter warten rund 6 Tage, bis sie ihn für stabil halten
([AppTweak](https://developers.apptweak.com/reference/google-play-console)).
**In dieser Woche triffst du damit keine Entscheidungen.** Der UTM-Bericht ist
die Nachbereitung am Montag danach. Die tägliche Steuerung läuft über Google
Ads, das nahezu in Echtzeit meldet.

| # | Wo | Was ablesen | Zeit |
|---|---|---|---|
| 1 | Google Ads, Kampagnenübersicht | **Installationen gestern**, **Kosten gestern**, **Kosten/Conversion** | 60 s |
| 2 | Google Ads, Anzeigen-Status | Alles „Zulässig"? Eine einzelne Ablehnung stoppt still eine ganze Platzierung | 30 s |
| 3 | Play Console, Statistik → Installationen | Gesamtzahl gestern. **Weicht sie stark von 1 ab, ist der Rest organisch** — das ist die Zahl, die zählt | 60 s |
| 4 | Play Console, Bewertungen | Neue 1-Sterne-Bewertung? Sofort lesen — bei frischem Traffic ist die erste schlechte Bewertung meist ein echter Bug | 60 s |
| 5 | Play Console, Android Vitals | Absturzrate. Der R8-Absturz aus 1.1.0 (142 Abstürze, 23 Nutzer) ist behoben, aber erst echter Traffic beweist das | 60 s |
| 6 | Reddit-Threads / Clip-Kommentare | Unbeantwortete Kommentare → beantworten | 60 s |

**Eintragen in `docs/growth-sprint-tracking.csv`** — liegt mit Datumszeilen,
Tageszielen und den Aufgaben des Tages bereits im Repo, du füllst nur die
Zahlenspalten. Jeden Tag dieselben sechs: Installationen (Play), Installationen
(Ads), Kosten, CPI, Absturzrate, Notiz.

Ohne diese Tabelle weißt du am Montag danach nicht, welcher Kanal funktioniert
hat — der UTM-Bericht ist dann noch nicht vollständig, und die Google-Ads-Zahlen
von gestern sind bis dahin die einzigen belastbaren.

---

# F) Die drei größten Risiken

### Risiko 1 — Die Vorlaufzeiten fressen die Woche auf

Anzeigenprüfung bis zu 1 Werktag (bei manueller Prüfung 3–7), Lernphase der
App-Kampagne 2–7 Tage. Du hast **6 Ausspieltage**. Im schlechten Fall spielt die
Kampagne erst Donnerstag stabil aus — dann bleiben vier Tage für 1.000
Installationen. Das ist mit Abstand das wahrscheinlichste Scheiter-Szenario,
und es hat nichts mit Budget zu tun.

**Gegenmaßnahme:**
1. Kampagne **heute Abend** starten, nicht morgen früh. Die Prüfung läuft dann
   über Nacht statt über den Dienstagvormittag.
2. **Conversions maximieren statt Ziel-CPI.** Ein Ziel-CPI drosselt die
   Auslieferung genau in den Tagen, in denen du sie brauchst.
3. **Nach dem Start 48 Stunden nichts ändern.** Jede Gebots- oder
   Budgetänderung wirft die Kampagne in die Lernphase zurück. Die
   Kontrollpunkte Mi/Fr sind bewusst so gelegt, dass nur dann angefasst wird.
4. Freitag-Regel aus Abschnitt C: Bei Rückstand das Wochenendbudget vorziehen —
   zwei Tage mit doppeltem Budget schlagen vier mit halbem, weil die Lernphase
   dann durch ist.

### Risiko 2 — Bezahlter Traffic läuft gegen einen blockierten Store-Eintrag

Wenn die App in einem Zielland nicht verfügbar ist, der Rollout gedrosselt oder
das Release noch in Prüfung, kauft die Kampagne Klicks, die niemand einlösen
kann. Das Geld ist weg, und es sieht in Google Ads aus wie ein CPI-Problem,
obwohl es ein Verfügbarkeitsproblem ist. `docs/GO-LIVE-PRODUKTION.md:195`
empfiehlt ausdrücklich **20 % Rollout** — falls du dem gefolgt bist und es ein
Update war, ist dieses Risiko bereits eingetreten.

**Gegenmaßnahme:**
1. **Harte Regel: Prüfliste A5 muss bestanden sein, bevor ein Cent ausgegeben
   wird.** Fremdes Gerät, fremdes Konto, Zielland, Button „Installieren"
   sichtbar. Kein „sieht bei mir gut aus".
2. A5 für **jedes** Land aus dem gewählten Set stichprobenartig — mindestens
   für das Land mit dem größten Budgetanteil.
3. Mittwoch-Regel aus Abschnitt C: Ausgaben ohne Installationen sind **kein**
   CPI-Problem, sondern ein Signal, A1–A5 erneut zu prüfen.

### Risiko 3 — Ein zweiter Enforcement-Fall

Das ist das einzige Risiko in dieser Liste, das das Projekt beendet statt nur
das Wochenziel. Zwei Wege führen dorthin:

- **Freitagabend-Panik.** Bei 150 statt 340 Installationen wird jede
  Abkürzung plötzlich diskutabel: eine Gruppe im Bekanntenkreis, ein
  „Install-Tausch", ein günstiger Anbieter, der 1.000 Installationen für 40 €
  verspricht. Google filtert genau das und hat 2026 ein eigenes
  Erkennungssystem dafür im Einsatz
  ([Play Console Help](https://support.google.com/googleplay/android-developer/answer/9898684?hl=en)).
- **Invalid Traffic auf der AdMob-Seite.** Ein Schwall neuer Tier-3-Nutzer, die
  Rewarded-Videos anfordern, ist ein ungewöhnliches Muster für ein Konto ohne
  Historie. Das Risiko ist gering, aber es existiert.

**Gegenmaßnahme:**
1. **Der Freitag-Kontrollpunkt hat eine Abbruchstufe, und sie ist verbindlich:**
   unter 80 Installationen wird das Ziel verschoben, nicht die Methode
   gewechselt. Diese Zeile ist der eigentliche Schutz — sie nimmt die
   Entscheidung aus dem Moment heraus, in dem sie schlecht getroffen würde.
2. **Nur first-party-attribuierte Kanäle.** Google Ads, organische Posts,
   eigene Videos. Kein Drittanbieter-Netzwerk, keine Austauschgruppe, kein
   Dienst, der Installationen verkauft — unabhängig davon, wie er sich nennt.
3. **Netzwerk-Nachrichten gestreut und einzeln** (D5), nie als Broadcast an
   einen großen Gruppenchat.
4. **AdMob-Testeinheiten bleiben aus dem Produktionsbuild draußen**, und
   umgekehrt: kein interner Test mit Produktionseinheiten
   (`lib/monetization/ad_config.dart`, Kopfkommentar).

---

## Was dieser Plan bewusst nicht behauptet

**Die 1.000 sind eine Zahl, kein Geschäft.** Mit Länder-Set A kaufst du
Installationen von Nutzern, deren erwartete D1-Retention bei einem unbekannten
EN-only-Casual-Puzzle niedrig ist und deren Rewarded-eCPM einen Bruchteil von
DACH beträgt. Als Zwischenziel für Install-Velocity und Ranking ist das
vertretbar. Als Umsatzkanal ist es das nicht — und seit Post-Install-Verhalten
ins Play-Ranking einfließt (`audit/05-aso.md`, Abschnitt 5), kann eine Woche
mit schlechter Retention den Ranking-Effekt sogar auffressen, den die
Install-Velocity gebracht hat.

Wenn das Ziel „1.000 Installationen" ein Stellvertreter für „das Spiel kommt
bei jemandem an" ist, wäre **Set B mit kleinerem Budget** die ehrlichere Wahl —
200 Installationen in DACH sagen dir mehr über das Spiel als 1.000 aus Set A.
Diese Entscheidung ist deine, nicht meine; der Plan liefert beides.

---

## Quellen

Alle am 21.09.2026 abgerufen, per Suchindex — `support.google.com`,
`play.google.com` und `reddit.com` sind in dieser Umgebung egress-gesperrt und
konnten nicht direkt gelesen werden.

- [Play Console: User Ratings, Reviews, and Installs](https://support.google.com/googleplay/android-developer/answer/9898684?hl=en)
- [Play Console: Staged rollouts](https://support.google.com/googleplay/android-developer/answer/6346149?hl=en)
- [Play Console: App Indexing on Google Search](https://support.google.com/googleplay/android-developer/answer/6041489?hl=en)
- [Play Console: Measure acquisition and retention (UTM/referrer)](https://support.google.com/googleplay/android-developer/answer/6263332?hl=en)
- [Google Ads: About the ad review process](https://support.google.com/google-ads/answer/1722120?hl=en)
- [Google Ads: Duration of the learning period](https://support.google.com/google-ads/answer/13020501?hl=en)
- [Google Ads: About assets and ads in App campaigns](https://support.google.com/google-ads/answer/6357595?hl=en)
- [Google Ads: App campaigns specs and format requirements](https://support.google.com/google-ads/answer/17091671?hl=en)
- [Google Ads: Choose a bid strategy for your App campaign](https://support.google.com/google-ads/answer/12073727?hl=en)
- [Google Ads: Measure app conversions with Google Play](https://support.google.com/google-ads/answer/6255257?hl=en)
- [Ads Policy: Advertiser verification](https://support.google.com/adspolicy/answer/9703665?hl=en)
- [FoxData: 2026 Mobile Game UA Cost Benchmarks](https://foxdata.com/en/blogs/2026-mobile-game-user-acquisition-cost-benchmarks-how-much-should-you-spend/)
- [Playio: Mobile Game CPI Benchmarks 2026](https://blog.playio.co/mobile-game-cpi-benchmarks-2026)
- [vmobify: App Store CRO — CVR Benchmarks 2026](https://vmobify.com/blog/app-store-conversion-rate-optimization)
- [Aerious: Google Play Review Time in 2026](https://aerious.uk/blog/google-play-review-time-in-2026-real-timelines-and-how-to-avoid-delays)
- [AppTweak: Google Play Console data delay](https://developers.apptweak.com/reference/google-play-console)

## Offene Pflichtangaben

Bis diese beantwortet sind, bleiben Budgetzeilen und Tagesziele Parameter statt
Zahlen:

1. Werbebudget bis Sonntag in € (hart blockierend)
2. Zeit pro Tag in Stunden (hart blockierend)
3. Release-Status + Rollout-Prozentsatz (Prüfliste A1/A2)
4. Freigeschaltete Länder (A3), Anzahl unterstützter Geräte (A4)
5. Angelegte Store-Sprachen — nur DE + EN?
6. Google-Ads-Konto: vorhanden, verifiziert, Zahlungsmethode, Play verknüpft?
7. Eigene Reichweite: Reddit-Kontoalter und -Karma, aktive Subs, Social-Accounts
8. Screenshot-Aufnahme möglich? (Voraussetzung für D4 und das Kampagnen-Video)
