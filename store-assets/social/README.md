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
in der Cloud) liest die Datei seit 17.11. jede Stunde von `main` und füllt
jeden Kanal mit den nächsten fälligen Einträgen auf, bis dort 10 Posts geplant
sind (mehr erlaubt Buffer im kostenlosen Plan nicht). So ist immer alles
geplant, was passt, und der Plan reicht trotzdem beliebig weit.

- „Fehlt noch" heißt: kein Post im selben Kanal zur selben Minute. Eine
  Zeit zweimal im selben Kanal verbietet der Test.
- Die Aufgabe postet nur, was hier steht; sie erfindet und ändert nichts.
- Ist ein Kanal voll, holt die nächste Stunde den Rest.
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
