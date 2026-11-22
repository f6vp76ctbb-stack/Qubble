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
(Bio-Link steht seit 22.11.):

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
