# Social media: Redaktionsplan und Bilder

## `plan.json` — was wann wo erscheint

Jeder Eintrag ist ein Post für **einen** Kanal (`youtube`, `instagram`,
`twitter` = X) mit Zeit (`dueAt`, Europe/Berlin), Text, Medien und den
Plattform-Feldern, genau in der Form, die Buffers `create_post` erwartet.
TikTok hat der Nutzer am 17.11. endgültig aus Buffer entfernt (alte
`tiktok`-Einträge bleiben als Verlauf stehen), dafür X verbunden. Facebook:
Konto vom Anbieter gesperrt, kein Kanal.

X-Posts sind die Instagram-Reels mit kürzerem Text: Play-Link statt „link in
bio", zwei Hashtags, sechs Minuten nach Instagram. X zählt jeden Link als 23
Zeichen und Emojis doppelt; mehr als 280 lehnt es ab.

**Eine geplante Aufgabe** („Qubble Buffer-Nachschub", seit 16.11.2026, läuft
in der Cloud) liest die Datei seit 20.11. einmal täglich (21:37 Berliner Zeit;
17.–20.11. stündlich) von `main` und füllt
jeden Kanal mit den nächsten fälligen Einträgen auf, bis dort 10 Posts geplant
sind (mehr erlaubt Buffer im kostenlosen Plan nicht). So ist immer alles
geplant, was passt, und der Plan reicht trotzdem beliebig weit.

- „Fehlt noch" heißt: kein Post im selben Kanal zur selben Minute. Eine
  Zeit zweimal im selben Kanal verbietet der Test.
- Die Aufgabe postet nur, was hier steht; sie erfindet und ändert nichts.
- Ist ein Kanal voll, holt der nächste Lauf den Rest.
- Medien liegen im Repo und werden über `raw.githubusercontent.com/…/main/…`
  geladen; ein Eintrag geht also erst live, wenn seine Datei auf `main` ist.

`test/social_plan_test.dart` prüft jeden Eintrag: Kanal, Zeitformat, dass
jede Mediendatei existiert, Alt-Texte, YouTube-Titel ≤ 100 Zeichen, Link in
der YouTube-Beschreibung, höchstens 5 Hashtags auf Instagram, höchstens 10
Bilder auf TikTok, X höchstens 280 Zeichen mit Play-Link, Story mit
Link-Sticker.

## Bilder

`qubbies/` und `looks/`: Karussells, je `ig/` (4:5) und `tt/` (9:16), aus
`tool/social_slides.py`.

## Clips von ChatGPT (17.11.)

`store-assets/video/qubble-find-the-move.mp4`, `-combo-chase`, `-fire-or-ice`,
`-watch-the-cat`, `-sound-on`: von ChatGPT neu geschnitten aus unseren Clips
(`qubble-neon`, `-gameplay`, `-sunset`, `-ocean`) mit Spielton und
englischen Einblendungen; Zeitlupen im Bild als Replay gekennzeichnet. Vor dem
Einplanen Bild für Bild geprüft (das „×10" in Combo-Chase steht im Spielkopf).
Texte von ChatGPT, für YouTube und Instagram übernommen.

## CTA-Reels (18.11.)

Auswertung 15.–18.11. (Buffer): ~14.000 Aufrufe, 56 Likes, 1 Kommentar,
0 Store-Besuche. Pet-Clips liefen am besten (Instagram 1.400–2.350 Aufrufe je
Reel), Bild-Posts gar nicht; am 17.11. ging alle ~45 min ein Post raus, die
Reichweite pro Reel fiel auf 21–450. Kein Video hatte einen Aufruf zum Store.

Deshalb ab 18.11.: höchstens 2 Reels pro Tag, Stories mit Link-Sticker bleiben.
`store-assets/video/qubble-cta-*.mp4` (aus `tool/social_cta_reels.py`): je
ein Pet-Clip mit Hook in den ersten 3 s, Leiste „FREE on Google Play ·
Android" und Endkarte „Play it FREE on Google Play / Link in bio". Die drei
schon geplanten ChatGPT-Clips bekommen nur die Endkarte (ihre eigenen
Einblendungen, z. B. „Replay", bleiben frei). X und YouTube verlinken mit
`referrer=utm_source%3D…%26utm_campaign%3Dcta_reels`, damit die Play Console
Besuche je Kanal zeigt. Nutzer-Schritte (Bio-Link, YouTube neu verbinden):
`ANLEITUNG.md` Schritt 13.

27./28.11.: `qubble-cta-almost-full-funki` / `-frosti`, aus
`tool/generate_reels.dart` (`clutch4`, `clutch5`): Brett 70 % bzw. 72 % voll,
ein Teil räumt 3 Reihen (Zahlen aus dem Render-Log). Die Idee „fast verloren →
gerettet" aus Buffer; „1 move from game over" stimmt für diese Bretter nicht,
deshalb steht die Füllung im Hook.

## Videotest 22.–26.11.

Fünf Clips vom Nutzer (PDF „Qubble: Recherche und 5 Videotests", 20.11.),
je einer pro Tag auf YouTube, Instagram und X, jeweils mittags (11:57 / 12:00 /
12:06; Nutzer 22.11.: „Die Videos sollen schon um 12 rausgehen“). Der Reel,
der dort geplant war (22. Firstpet, 23. Challenge), rückt auf den Abend.
Dazu 23.–26. um 12:30 derselbe Clip als Instagram-Story mit Link-Sticker
(Bio-Link steht seit 22.11.). Ausnahme 22.11.: Buffer war bis 12:00 vom
Connector getrennt (401), Firstpet war auf Instagram schon beim Senden; also
02 auf X um 12:16, auf Instagram 18:00 (Story 18:30), auf YouTube 18:30.
YouTube lehnte Firstpet um 11:57 ab („daily posting limit reached“), nachdem
am Morgen Fire-or-Ice dort nachgeholt worden war:

| Tag | Datei | Ansatz |
|---|---|---|
| So 22.11. | `qubble-where-is-the-ad.mp4` | Sketch „Wo bleibt die Werbung?" → keine Zwangswerbung |
| Mo 23.11. | `qubble-chat-send-the-game.mp4` | Chat-Sketch (als „made-up chat" gekennzeichnet) + echter Zug |
| Di 24.11. | `qubble-no-signal-no-problem.mp4` | Pendler-POV → spielbar ohne Netz |
| Mi 25.11. | `qubble-emotional-support-cat.mp4` | Kiki als „Vorgesetzte" (Qubbies nur Optik) |
| Do 26.11. | `qubble-indie-dev-pitch.mp4` | Notiz des Entwicklers |

Vor dem Einplanen Bild für Bild geprüft: Das Spielmaterial stammt aus unseren
Clips (`qubble-reel-clutch` für den Chat-Zug, `qubble-watch-the-cat`,
`qubble-ocean`). Der Zug in 01 ist regelkonform (I3 in Reihe 8, Spalten 4–6
→ drei Spalten voll). Titel „Qubble: Block Puzzle" und „by Thinkube" stimmen
mit dem Store überein (geprüft 22.11.). Aussagen nur „no forced ads", „plays
offline" fürs Spiel, Qubbies kosmetisch. Die Texte sind von uns, weil dem
Paket keine Texte beilagen.

Die Clips ersetzen die CTA-Reels der Abende 22.–26. (so wollte es der
Testplan: ersetzen statt draufpacken). Zapp, Frosti, Pyra, Prisma und Glim
laufen sieben Tage später, 29.11.–03.12. X und YouTube verlinken je Clip mit
`utm_campaign=videotest_01` … `_05`. Auswertung laut Testplan nach 24 und 72
Stunden: Aufrufe und Wiedergabedauer (Buffer/Plattform), Store-Besuche je
Kampagne und Installationen (Play Console, nur der Nutzer). Zuerst den Linkweg
prüfen, erst dann mehr Clips desselben Ansatzes.

## Auswertung 28.11.

Buffer-Kennzahlen je Post, abgerufen am 28.11. (Instagram 55 Posts seit 16.11.,
YouTube 38, X 24). Aufrufe sind keine Personen; Buffer aktualisiert einmal am
Tag.

| Clip | Länge | IG-Aufrufe | IG Ø gesehen | YouTube |
|---|---|---|---|---|
| `qubble-combo-chase` | 9,8 s | **5.704** | **7,2 s (73 %)** | 486 |
| Design-Clips mit Qubbie (`sunset`, `wood`, `forest`, `neon`, `gameplay`, …) | 24–25 s | 1.490–2.360 | 6,2–9,4 s | 1.010–1.100 bei den ersten Uploads eines Tages, sonst 2–17 |
| CTA-Reels (Endkarte) | 12–14 s | 268–1.860 | 3,1–4,8 s | 7–112 (Challenge, nachts von Hand nachgeholt: 866) |
| Videotest 04 Katze / 05 Entwickler / 02 Werbung | 15–20 s | 1.744 / 1.520 / 1.456 | 4,9 / 6,1 / 5,4 s | 991 / 161 / 49 |
| Videotest 01 Chat / 03 Offline | 15–16 s | **130 / 199** | **1,3 / 3,4 s** | 35 / – (abgelehnt) |
| Rätsel-/Vergleichs-Reels (`reel-clutch*`, `looks`, `pets`, `skins`), `almost-full` | 5,8–13,1 s | 138–183 | 1,7–3,1 s | 0–14 (`almost-full`: 113) |
| Bild-Posts / Stories | – | 0–6 / 0–16 | – | – |

Shares und Saves: auf Instagram bei jedem Post 0. X: 0–4 Impressions je Post,
also praktisch keine Reichweite. YouTube: an Tagen mit mehreren Uploads bekamen
nur die ersten 1–3 Reichweite; die Ablehnungen „daily posting limit“ vom 22.–24.11.
passen zu höchstens zwei Uploads in 24 Stunden (nicht offiziell belegt).

Was daraus folgt (nur aus diesen Zahlen):

1. **Das Spiel ab dem ersten Bild.** Alle Flops öffnen mit etwas anderem
   (Chat, Titel, stillem Brett) und werden nach 1,3–1,9 s weggewischt.
2. **Kurz, eine Frage, Auflösung am Ende, kein Abspann.** Combo-Chase (9,8 s,
   keine Endkarte) wurde zu 73 % gesehen; die CTA-Reels verloren auf der
   stummen Endkarte.
3. **Qubbie im Bild.** Die Clips mit Qubbie halten am längsten; die Katze
   war im Videotest auf Instagram und YouTube vorn.
4. **Keine Wiederholungen derselben Datei, ein YouTube-Upload am Tag.**

Markt (abgerufen 28.11.2026, Richtungsangaben, keine Benchmarks):

- YouTube hat die Shorts-Empfehlungen am 01.10.2026 auf Originalinhalte
  umgestellt; erneut hochgeladene Clips ohne Eigenleistung bekommen weniger
  Reichweite ([Music Ally, 02.10.2026](https://musically.com/2026/10/02/youtube-shorts-algorithm-will-now-prioritise-original-content/),
  [Social Media Today](https://www.socialmediatoday.com/news/youtube-updates-shorts-algorithm-to-put-more-focus-on-original-content/831976/)).
- Instagram: Mosseri nennt Wiedergabezeit, Likes pro Reichweite und Sends
  (Weiterleitungen) pro Reichweite als wichtigste Signale; 2026 kam
  Originalität dazu (Zusammenfassung:
  [Dataslayer](https://www.dataslayer.ai/blog/instagram-algorithm-2025-complete-guide-for-marketers)).
  Deshalb fordern die Texte zum Weiterschicken auf.
- Werbe-Creatives für Puzzlespiele 2026: überwiegend Video unter 30 s, der
  Einstieg in den ersten drei Sekunden entscheidet
  ([GameAnalytics](https://www.gameanalytics.com/blog/popular-mobile-game-ad-formats));
  Spannung durch Beinahe-Scheitern
  ([FoxData](https://foxdata.com/en/blogs/winning-ad-creatives-for-mobile-games-analyzing-10000-ads-to-find-what-works/),
  [SocialPeta, April 2026](https://socialpeta.com/en/blog/top-mobile-game-ad-creatives-and-advertising-trends-in-april-2026));
  Varianten, die sich nur im Hintergrund unterscheiden, nutzen sich schneller
  ab als echt verschiedene Ansätze (FoxData). Das sind bezahlte Anzeigen,
  keine organischen Posts.

## Virale Serie 29.11.–03.12.

Fünf neue Clips nach diesen Regeln, jeder mit eigenem Ansatz, alle aus
`tool/generate_reels.dart` (echte Spielszenen) und
`tool/social_viral_reels.py` (Textband oben, Spiel darunter, keine Endkarte,
Spielton + Musik bei −13 bis −15 LUFS):

| Tag | Datei | Ansatz | Länge |
|---|---|---|---|
| So 29.11. | `qubble-viral-chase.mp4` | „Can this combo hit ×13?“: Vulkan + Pyra, Combo ×3 → ×13 ohne Abbruch | 8,5 s |
| Mo 30.11. | `qubble-viral-catmeme.mp4` | „My cat every time I clear a line“: Kiki fliegt bei jedem der 12 Abräumer | 12,6 s |
| Di 01.12. | `qubble-viral-rescue.mp4` | „73 % full. Can it be saved?“: Gletscher + Frosti, 73 % → 5 % in 8 Zügen | 4,6 s |
| Mi 02.12. | `qubble-viral-soundon.mp4` | „Sound on“: Der Combo-Ton steigt (Tonhöhe bis ×11, `GameController.place`), Neon + Zapp | 8,5 s |
| Do 03.12. | `qubble-viral-allclear2.mp4` | „Can 2 pieces empty this board?“: Holz + Bit, All Clear +1.500 | 3,1 s |

- Jede Zahl im Bild (Combo, Füllstand) liest das Skript aus der
  `story.json` des Renders; ein Text kann nur sagen, was das Bild zeigt.
- Die Läufe sind ehrlich gespielt: Ein Spieler, der die Combo hält, spielt
  das Spiel des gefundenen Seeds; der Teil vor dem gezeigten Stück läuft
  ohne Kamera. „Rescue“ baut das Brett vorher ohne Abräumen auf (wie
  `clutch`), die All-Clear-Stellung ist eine gespeicherte Partie (wie
  `allclear`).
- Täglich mittags: YouTube 11:57, Instagram 12:00 + Story mit Link-Sticker
  12:30, X 12:06; Links mit `utm_campaign=viral_<name>`. Die YouTube-CTA-Reels
  dieser Tage rücken auf 04.–08.12. (ein Upload am Tag); auf Instagram und X
  bleiben sie abends.
