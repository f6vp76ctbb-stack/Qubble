# YouTube-Texte

Titel und Beschreibungen für die Videos in diesem Ordner. Das Showreel ist
das Promo-Video des Store-Eintrags; Google Play nimmt es nur als YouTube-Link.
Was Google von dem Video verlangt (Monetarisierung aus, öffentlich oder nicht
gelistet, keine Altersbeschränkung, einbettbar): `ANLEITUNG.md` Schritt 3.

Jede Aussage hier muss zur App passen wie der Store-Eintrag:
`test/store_claims_test.dart` liest diese Datei mit. Erst veröffentlichen,
wenn 1.6.0 bei 100 % ist — die Videos zeigen Qubbies.

Tags ohne fremde Spieltitel, wie im Store-Eintrag (Entscheidung Nutzer
29.09.2026, `test/store_claims_test.dart`).

## Showreel (`qubble-showreel.mp4`)

**Hochgeladen am 15.11.2026** (als Short): `https://www.youtube.com/watch?v=TMOZ2u62GnI`
— dieselbe Video-ID wie der Shorts-Link `youtube.com/shorts/TMOZ2u62GnI`. In
der Play Console die `watch?v=`-Adresse eintragen, ohne `?feature=share`.

### Englisch

Titel:

    Qubble – Block Puzzle with Pets That Play Along

Beschreibung:

    Qubble is a block puzzle where a pet plays along. Drag blocks onto the 8×8 board, fill a row or column and watch it go – and your Qubbie flies along the line you clear, some with fire, others with frost or lightning.

    Every scene in this video is recorded in the game itself: different themes, block skins, row effects and Qubbies.

    • 9 Qubbies – choose your first one after your third run, at no cost. It hatches while you play and grows with every line you clear.
    • 11 themes and 22 block skins
    • Daily Challenge and Puzzle mode
    • Plays offline, no sign-up
    • No forced ads: videos only play when you tap them

    Qubble on Google Play: https://play.google.com/store/apps/details?id=com.thinkube.qubble

### Deutsch

Titel:

    Qubble – Block Puzzle mit Haustieren, die mitspielen

Beschreibung:

    Qubble ist ein Block-Puzzle, bei dem ein Haustier mitspielt. Zieh Blöcke auf das 8×8-Brett, füll eine Reihe oder Spalte und sieh zu, wie sie verschwindet – und dein Qubbie fliegt die Reihe entlang, manche mit Feuer, andere mit Frost oder Blitz.

    Jede Szene in diesem Video ist im Spiel selbst aufgenommen: verschiedene Themes, Block-Skins, Reihen-Effekte und Qubbies.

    • 9 Qubbies – dein erstes wählst du nach deiner dritten Runde, und es kostet nichts. Es schlüpft beim Spielen und wächst mit jeder Reihe, die du räumst.
    • 11 Themes und 22 Block-Skins
    • Tägliche Challenge und Rätsel-Modus
    • Spielt offline, ohne Anmeldung
    • Keine Zwangswerbung: Videos laufen nur, wenn du sie antippst

    Qubble bei Google Play: https://play.google.com/store/apps/details?id=com.thinkube.qubble

### Tags

    block puzzle, puzzle game, offline game, qubble, pet game

## Kurze Clips (`qubble-gameplay`, `-neon`, `-ocean`, `-sunset`)

Für Shorts, Reels, TikTok.

    Qubble – a block puzzle where your pet plays along

    Every move recorded in the game. Plays offline, no forced ads. #blockpuzzle #puzzlegame #qubble
    Qubble on Google Play: https://play.google.com/store/apps/details?id=com.thinkube.qubble

## Warum die Aussagen stimmen

- „flies along the line you clear": ein Qubbie fliegt pro Zug eine Reihe
  entlang (`PetFlightLine.first`, `lib/ui/widgets/pet_overlay.dart`) — nicht
  „every line".
- „after your third run, at no cost": `PetRules.firstEggAfterRuns = 3`, das
  erste Ei ist die Gratis-Wahl aus drei (`kStarterPetIds`).
- „grows with every line you clear": Erfahrung je geräumter Reihe
  (`PetState.addLines`).
- „11 themes and 22 block skins": was es das ganze Jahr gibt, ohne die
  Halloween-Designs — dieselben Zahlen wie im Store-Eintrag.
- „Every scene … recorded in the game itself": `tool/generate_showreel.dart`
  rendert den echten Spielbildschirm mit echten Drag-Gesten und den Sounds,
  die das Spiel anfordert.
- „Plays offline": das Spiel selbst; nur die freiwillige Bestenliste braucht
  eine Verbindung.
- „No forced ads": nur freiwillige Belohnungsvideos.
