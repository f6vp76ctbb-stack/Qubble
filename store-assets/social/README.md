# Social media: Redaktionsplan und Bilder

## `plan.json` — was wann wo erscheint

Jeder Eintrag ist ein Post für **einen** Kanal (`youtube`, `instagram`,
`tiktok`) mit Zeit (`dueAt`, Europe/Berlin), Text, Medien und den
Plattform-Feldern, genau in der Form, die Buffers `create_post` erwartet.
TikTok wurde am 17.11. neu mit Buffer verbunden (neue Kanal-ID); Stories
kann Buffer dort nicht posten, nur Videos und Bilder. Instagram-Stories laufen
weiter.

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
Bilder auf TikTok, Story mit Link-Sticker.

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
