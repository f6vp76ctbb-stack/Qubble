# Store-Listing & ASO (App Store + Play Store)

Stand 15.11.2026. Nachschlagewerk: was ein Store-Text behaupten darf, was
Google von Text und Bild verlangt und wo die Texte liegen. Was du damit tun
musst, steht in `ANLEITUNG.md`.

- **App-Name:** Qubble
- **Entwickler/Publisher:** Thinkube
- **Bundle-ID / Application-ID:** `com.thinkube.qubble`

**Die Texte selbst stehen nur an einer Stelle:**
`store-assets/listing/<Play-Code>/` (`title.txt`, `short_description.txt`,
`full_description.txt`), dieselben noch einmal in
`store-assets/store-listing.csv`. Von Hand gepflegt werden vier Einträge —
`en-US`, `de-DE`, `es-419`, `pt-BR` (Entscheidung Nutzer 09.11.2026); alle
anderen Store-Sprachen übersetzt die Play Console, für sie gibt es im Repo
keine Dateien. Bis 13.11. standen die deutsche und englische Beschreibung
zusätzlich hier im Dokument, auf 80 Zeichen umbrochen — zwei Fassungen, die
auseinanderliefen.

**Was die Tests festhalten** (`test/store_listing_test.dart`,
`test/store_claims_test.dart`): Feldlängen 30 / 80 / 4000; kein Leistungs-,
Preis- oder Rang-Wort im Titel; genau diese vier Sprachen; die genannten
Theme-Namen und die Namen der Qubbies wie in der App, höchstens fünf Themes
beim Namen; die Zahlen im Text (neun Qubbies, das erste nach Runde 3,
11 Themes, 22 Skins, 8 davon nur über Erfolge) gegen die Kataloge; keine
Aussage, die der Code widerlegt; kein fremder Spieltitel; kein harter
Zeilenumbruch im Absatz. Seit 15.11. dazu Googles eigene Vorgaben (nächster
Abschnitt): keine Versalien, Aufzählungszeichen oder Emojis in der
Beschreibung; Kurzbeschreibung als schlichter Satz; keins der Werbewörter in
Kurzbeschreibung, Bildtexten und Feature-Grafik; drei verschiedene Aussagen
in Kurzbeschreibung, erstem Screenshot und Feature-Grafik; ein Alt-Text
(≤ 140 Zeichen) je Grafik; Bildmaße ohne Transparenz.

---

## Was Google verlangt — an der Quelle gelesen (14.11.2026)

Bis 13.11. standen hier nur Suchauszüge, weil Googles Hilfe-Seiten aus der
Arbeitsumgebung nicht erreichbar waren. Seit 14.11. sind sie es; die Zitate
unten sind der Wortlaut der Seiten an diesem Tag.

| Seite | Was sie ist |
|---|---|
| [Metadata](https://support.google.com/googleplay/android-developer/answer/9898842) | **Richtlinie.** Ein Verstoß kann den Eintrag kosten. |
| [Add preview assets to showcase your app](https://support.google.com/googleplay/android-developer/answer/9866151) | Zwei Stufen. „Requirements": „failure to meet requirements may result in removal or suspension from Google Play". „Highly recommended": „Failure to comply with these guidelines will not impact your store listing page, but may result in changes to how your preview assets appear on Google Play or limit promotional opportunities" — kostet also die Plätze, an denen Google Spiele empfiehlt, nicht den Eintrag. |
| [Translate and localize your app](https://support.google.com/googleplay/android-developer/answer/9844778) | Wie Sprachen ohne eigene Texte und Bilder aussehen. |
| [Target audience and app content](https://support.google.com/googleplay/android-developer/answer/9285070) | Wann ein Eintrag als Kinder-Eintrag gilt. |

### Verbindlich

| Regel (Wortlaut) | Bei uns |
|---|---|
| Titel ≤ 30 Zeichen; in Titel, Symbol und Entwicklername keine Emojis, keine wiederholten Sonderzeichen, „Avoid ALL CAPS unless it is part of your brand name", nichts zu „store performance or ranking, price or promotional information" | ✅ Test |
| Beispiele für Verstöße in der Beschreibung: „Unattributed or Anonymous User testimonials", „Data comparison of apps or brands", „**Word blocks and vertical/horizontal word lists**" | ✅ seit 15.11.: Die Liste aller elf Theme-Namen ist raus (vier Beispiele im Satz), die Aufzählung ist Fließtext. Test |
| „Don't use special characters or all caps to manipulate search ranking" | ✅ seit 15.11.: Überschriften in normaler Schreibung, kein „▸", kein „•". Test |
| „Keep your app's description succinct and straightforward … Excessive length, detail, improper formatting, or repetition can result in a violation of this policy" | ⚠️ 2.900–3.200 von 4.000 Zeichen, neun kurze Abschnitte. Ab wann eine Beschreibung „excessive" ist, sagt Google nicht — **offen**. Kürzen wäre der sichere Schritt, wenn eine Prüfung das beanstandet |
| „Don't use repetitive keywords or deceptive claims like 'best game ever'" | ✅ Test (Behauptungen gegen den Code) |
| Screenshots: JPEG oder 24-Bit-PNG ohne Alpha, 320–3840 px, längere Seite höchstens doppelt so lang; mindestens zwei | ✅ acht je Sprache, 1080×1920. Test |
| Feature-Grafik: JPEG oder 24-Bit-PNG ohne Alpha, genau 1024×500 | ✅ Test |
| Kurzbeschreibung ≤ 80 Zeichen | ✅ Test |
| Video: Werbung im Video aus („Turn off monetization"), öffentlich oder nicht gelistet, keine Altersbeschränkung, einbettbar | 👤 beim Hochladen — `ANLEITUNG.md` Schritt 3 |
| Wirkt der Eintrag wie für Kinder („youthful animation or young characters in the graphic assets"), obwohl die App nicht für unter 13-Jährige gedacht ist, „Google Play may reject your app" | ⚠️ das eigentliche Risiko der Qubbie-Bilder — `docs/HAUSTIERE.md` §8.1. Darum bleibt das Brett in jedem Bild das Größte, und du siehst die Bilder an, bevor sie hochgehen |

### Empfohlen (entscheidet über Empfehlungs-Plätze)

| Regel (Wortlaut) | Bei uns |
|---|---|
| Für Spiele mindestens drei Screenshots 9:16 (≥ 1080×1920), die das Spiel zeigen; „Use captured footage of the app or game itself" | ✅ alles im Bild sind Aufnahmen der App |
| „Stylized screenshots … are allowed, but prioritize UI in the first three screenshots as much as possible" | ✅ seit 15.11.: Bild 3 ist der echte Qubbies-Bildschirm statt einer Montage |
| „Taglines should not take up more than 20% of the image" | ✅ seit 15.11.: höchstens 11 %; `tool/caption_screenshots.py` misst das bei jedem Lauf und bricht darüber ab. Vorher lag der Textblock allein bei rund 24 % der Bildhöhe. Wie Google die 20 % misst, steht nicht da — gemessen wird hier die Fläche der hinzugefügten Zeilen, und der Überschriften-Block muss im obersten Fünftel enden |
| Keine Wörter wie „Best", „#1", „Top", „New", „Discount", „Sale", „Million Downloads" (Feature-Grafik zusätzlich „Free"); kein „Download now", „Install now", „Play now", „Try now" — in Kurzbeschreibung, Screenshots, Feature-Grafik, Video-Text | ✅ seit 15.11.: „A **new** board every day" heißt „Every day, a different board" (ebenso de/es/pt). Test |
| „Do not include people interacting with the device (for example, fingers tapping on the device)" — Screenshots und Video | ✅ seit 15.11. ohne den aufgemalten Fingerpunkt in den Videos. Ob ein Punkt überhaupt darunter fiele, sagt Google nicht; ohne ihn stellt sich die Frage nicht |
| Kein Geräterahmen, kein Store-Abzeichen, keine fremden Marken | ✅ |
| Feature-Grafik: „avoid using pure white, black, or dark gray", „consider using more vibrant colors"; Wichtiges zur Mitte, nichts in die „cutoff zones"; „Do not use prominent branding that is similar to your app icon" | ✅ seit 15.11. violett statt dunklem Marineblau. Die „cutoff zones" zeigt Google nur als Bild, das sich hier nicht laden ließ — der Rand von 112 px ist eine vorsichtige Annahme, **keine Zahl von Google** |
| „Avoid duplication and redundancy of messaging across your short description, screenshots, feature graphics, or developer video" | ✅ seit 15.11.: drei verschiedene Sätze (vorher dreimal „Haustiere, die mitspielen"). Test |
| Kurzbeschreibung: keine Sonderzeichen, Emojis, Symbole, wiederholten Satzzeichen; „Only use periods at the end of sentences if your short description contains multiple sentences" | ✅ seit 15.11.: ein Satz, kein Punkt. Test |
| „Include alt text with each graphic asset … using 140 characters or less", ohne „photo of" / „image of" | ✅ geschrieben: `store-assets/listing/<Code>/alt_texts.txt`. Die Play-Schnittstelle hat dafür kein Feld (androidpublisher v3, Stand 26.10.2026) — eintragen musst du sie in der Console (`ANLEITUNG.md` Schritt 10) |
| Video: „within the first 10 seconds" das echte Spiel; „Aim for at least 80% of the video to be representative of the user experience"; „only the first 30 seconds autoplays"; „Do not leave black bars on either side of a portrait video"; „Properly localize the video including the UI" (Wortlaut geprüft 15.11.2026) | ✅ Store-Video `qubble-promo-<Sprache>.mp4`: 16,7 s, Spiel ab dem ersten Bild, sonst nur echte App-Bildschirme, Schlusskarte 2,6 s (≈ 16 %), je Sprache eine Fassung. Showreel 17 s ohne Text |

---

## Was in der Beschreibung stehen DARF (Realitätsabgleich)

Store-Texte müssen zur App passen, sonst droht eine Ablehnung wegen
irreführender Angaben. Der aktuelle Stand:

| Aussage | Trifft zu? |
|---|---|
| Das Spiel selbst offline spielbar, kein Konto, kein Login | ✅ ja |
| „Kein Server“ | ❌ **nein** — die Bestenliste sendet Name + Score an Firestore (`lib/services/leaderboard.dart:133`) |
| „Kein Zeitdruck“ | ⚠️ **nur halb** — keine Uhr beendet die Runde, und die Combo zählt seit 1.6.0 Züge statt Sekunden; aber schnelles Setzen bringt bis zu 30 % mehr Punkte pro Clear (`ScoreKeeper.defaultSpeedBonusMax`, `lib/game/scoring.dart`). „Keine Uhr beendet deine Runde" stimmt, „kein Zeitdruck" nicht |
| Keine Interstitials, keine Banner, keine Zwangswerbung | ✅ ja (nur Rewarded) |
| Video-Belohnungen immer freiwillig | ✅ ja |
| „Werbung dauerhaft entfernen"-Kauf | ❌ **nein** — gibt es nicht mehr |
| Unterstützer-Paket (Theme + Skin + Münzen) | ✅ ja (`qubble_supporter`) |
| Münzpakete / Starter-Paket | ✅ ja |
| 11 Themes und 22 Block-Skins, die es das ganze Jahr gibt | ✅ ja — gezählt ohne die Halloween-Designs (Kürbis-Theme, Gespenster-Skin: nur im Oktober). Aurora nur im Unterstützer-Paket, **das gehört in die Beschreibung** |
| 3 animierte Shop-Skins (Flüssig, Sprudel, Plasma) | ✅ ja — je 150 💎 (`kAnimatedSkinPrice`) |
| Reihen-Effekte (Laser, Flammen, Frost, Blitz), Explosionen, Zubehör | ✅ ja — `lib/game/clear_effect.dart`, `burst_style.dart`, `accessory.dart` |
| **Haustiere („Qubbies")**: neun; das erste nach der dritten Runde gratis (Wahl aus drei); sitzt auf dem Brett, fliegt geräumte Reihen entlang, wächst | ✅ ja, ab 1.6.0 — `lib/game/pet.dart`. **Erst in den Eintrag, wenn 1.6.0 bei allen ist** |
| „Ein Qubbie hilft beim Spielen" / „gibt Punkte" | ❌ **nein** — reine Optik, der Game-Controller kennt keine Haustiere |
| „Alle Qubbies gratis" | ❌ **nein** — alle außer dem ersten kosten Diamanten (300–1.500) |
| „Was du kaufst, macht dich nicht besser" | ❌ **nein** — Münzen sind käuflich und bezahlen Booster und Weiterspielen |
| 8 animierte Block-Skins, nicht käuflich, nur über Erfolge | ✅ ja — höchste Stufe jeder Erfolgs-Kategorie (`lib/game/achievements.dart`), nie für Münzen, Diamanten oder Geld (`BlockSkin.isPurchasable`) |
| Tägliche Challenge mit Serie, Tagesziel (bis 3 Sterne) und Serien-Truhen | ✅ ja |
| Tages-Rangliste | ❌ **nein** — wird gesammelt, ist aber ausgeblendet (`kShownLeaderboards`); nur die Punkte-Bestenliste ist zu sehen |
| Rätsel-Modus | ✅ ja |
| Rätsel-**3-Sterne-Wertung** als Leistungsabstufung | ❌ **nein** — `minMoves == Teilezahl` in 200/200 geprüften Leveln, also immer 3 Sterne (`audit/03-loop.md` L-2) |
| Quests (täglich/wöchentlich/monatlich), Level, Erfolge, Statistiken | ✅ ja — `lib/game/quests.dart` |
| Online-Bestenliste | ✅ ja (optional, Name freiwillig) — überträgt Daten, siehe oben |

---

## Titel und Kurzbeschreibung (Play: 30 / 80 Zeichen)

| Play-Code | Titel | Kurzbeschreibung |
|---|---|---|
| `en-US` | Qubble: Block Puzzle Offline | Block puzzle with a pet that hatches and grows with every line you clear |
| `de-DE` | Qubble: Block Puzzle Offline | Block Puzzle mit einem Haustier, das schlüpft und mit jeder Reihe wächst |
| `es-419` | Qubble: Puzzle de Bloques | Puzzle de bloques sin conexión, con una mascota que crece con cada fila |
| `pt-BR` | Qubble: Jogo de Blocos Offline | Jogo de blocos com um mascote que nasce e cresce a cada fileira limpa |

(Zur Übersicht; maßgeblich sind die Dateien.)

- **„Offline" im Titel:** ein Suchwort, und es stimmt — das Spiel selbst läuft
  ohne Verbindung. Kein Wort, das Leistung, Preis oder Rang behauptet.
- **Die Haustiere stehen in der Kurzbeschreibung, nicht im Titel.** Ob „Pets"
  im Titel erlaubt und klug wäre, ist nicht belegt; die Kurzbeschreibung wird
  von Play ebenfalls durchsucht.
- **In der Kurzbeschreibung kein „best", „free", „top", „new" und keine
  Aufforderung** („Play now") — Googles eigene Vorgabe, siehe oben. Ein Satz,
  ohne Punkt am Ende, ohne Sonderzeichen.
- **Sie sagt etwas anderes als das erste Bild und die Feature-Grafik:** Text
  „ein Haustier, das schlüpft und wächst", Bild 1 „Haustiere, die
  mitspielen", Grafik „Ein Haustier auf deinem Brett".
- Keine Emojis in Titel und Kurzbeschreibung.

## Aufbau der Beschreibung

1. Was anders ist: ein Qubbie spielt mit. 2. Was man tut. 3. Die Qubbies,
mit dem Preisweg (erstes gratis, die übrigen für Diamanten) und dem Satz,
dass sie nichts an Punkten oder Teilen ändern. 4. Combo-Fieber, Daily,
Rätsel. 5. Designs, als Fließtext mit vier Theme-Namen als Beispiel (alle
elf hintereinander wären eine Wortliste). 6. Ziele (Quests, Erfolge, Level,
Sparschwein, Booster, Bestenliste). 7. „Fair, ohne Nerverei" samt dem Hinweis
auf In-App-Käufe. 8. Offline.

Überschriften stehen in normaler Schreibung auf einer eigenen Zeile, ohne
Zeichen davor.

Die ersten zwei Absätze sind das, was Play vor „Mehr anzeigen" zeigt.

## iOS (für später)

Untertitel, Keywords und Werbetext für den App Store standen bis 13.11. hier;
sie waren auf dem Stand vom August („acht Themes"). Sie werden neu
geschrieben, wenn iOS ansteht (`ANLEITUNG.md`, „Später: iOS").

---

## Kategorien & Einstufung

- **Kategorie:** Spiele → Puzzle (Play) / Games → Puzzle (App Store).
- **Altersfreigabe:** voraussichtlich USK 0 / PEGI 3 / Apple 4+. Achtung: Enthält
  Werbung + In-App-Käufe → in den Fragebögen entsprechend angeben (nicht als
  „für Kinder" labeln, um COPPA/AdMob-Kinderwerbung-Themen zu vermeiden).

## Wie der Eintrag in die Console kommt

Per Workflow „Play Store (listing, release, reviews)" oder von Hand —
`ANLEITUNG.md`, Schritte 9 und 10. `tool/export_play_metadata.py` legt die
vier Einträge so ab, wie die Schnittstelle sie braucht;
`tool/play_publish.py` sendet sie.

## Die übrigen Sprachen

Die App spricht 56 Sprachen; der Store-Eintrag wird in vier von Hand
gepflegt. Bis 13.11. lagen Texte, Bilder und „Was ist neu" für 60
Play-Sprachen im Repo — jede Änderung musste sechzigmal nachgezogen werden,
und der Eintrag blieb deshalb vom 28.09. bis in den November stehen. Die
alten Dateien sind über die Git-Historie erreichbar (letzter Stand:
Commit `ad3a529`).

Was Besucher in einer Sprache sehen, die du nicht selbst gepflegt hast
([Translate and localize your app](https://support.google.com/googleplay/android-developer/answer/9844778),
gelesen 14.11.2026):

- Gibt es die Sprache im Eintrag gar nicht: „they can choose to view an
  automated translation of your app's page", mit einem Hinweis, dass die
  Übersetzung automatisch ist. Für Armenisch, Rätoromanisch, Tagalog und Zulu
  gibt es das nicht.
- Hat eine Sprache Texte, aber keine eigenen Bilder: „your app's graphic
  assets show from the default language" — bei uns Englisch.

## Screenshots, Feature-Grafik, Video

Liegen fertig in `store-assets/`; wie sie entstehen und warum sie so
aufgebaut sind: `store-assets/README.md` und `docs/STORE-SCREENSHOTS.md`.
