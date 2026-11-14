# Store-Listing & ASO (App Store + Play Store)

Stand 13.11.2026. Nachschlagewerk: was ein Store-Text behaupten darf und wo
die Texte liegen. Was du damit tun musst, steht in `ANLEITUNG.md`.

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
Preis- oder Rang-Wort im Titel; genau diese vier Sprachen; die Theme-Namen
und die Namen der Qubbies wie in der App; die Zahlen im Text (neun Qubbies,
das erste nach Runde 3, 11 Themes, 22 Skins, 8 davon nur über Erfolge) gegen
die Kataloge; keine Aussage, die der Code widerlegt; kein fremder Spieltitel;
kein harter Zeilenumbruch im Absatz.

---

## Was in der Beschreibung stehen DARF (Realitätsabgleich)

Store-Texte müssen zur App passen, sonst droht eine Ablehnung wegen
irreführender Angaben. Der aktuelle Stand:

| Aussage | Trifft zu? |
|---|---|
| Das Spiel selbst offline spielbar, kein Konto, kein Login | ✅ ja |
| „Kein Server“ | ❌ **nein** — die Bestenliste sendet Name + Score an Firestore (`lib/services/leaderboard.dart:133`) |
| „Kein Zeitdruck“ | ⚠️ **nur halb** — die Runde hat keinen Timer, aber die Combo läuft nach 10 s ab (`lib/game/scoring.dart:50`) |
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
| `en-US` | Qubble: Block Puzzle Offline | Block puzzle with pets that play along. Clear lines and hatch your own Qubbie. |
| `de-DE` | Qubble: Block Puzzle Offline | Block Puzzle mit Haustieren, die mitspielen: Reihen räumen, Qubbies ausbrüten. |
| `es-419` | Qubble: Puzzle de Bloques | Puzzle de bloques con mascotas que juegan contigo. Limpia filas, cría tu Qubbie. |
| `pt-BR` | Qubble: Jogo de Blocos Offline | Jogo de blocos com mascotes que jogam junto. Limpe fileiras e crie seu Qubbie. |

(Zur Übersicht; maßgeblich sind die Dateien.)

- **„Offline" im Titel:** ein Suchwort, und es stimmt — das Spiel selbst läuft
  ohne Verbindung. Kein Wort, das Leistung, Preis oder Rang behauptet.
- **Die Haustiere stehen in der Kurzbeschreibung, nicht im Titel.** Ob „Pets"
  im Titel erlaubt und klug wäre, ist nicht belegt; die Kurzbeschreibung wird
  von Play ebenfalls durchsucht.
- **Auch in der Kurzbeschreibung kein „best", „free", „top":** Branchenberichte
  (2021) nennen Verwarnungen dafür; darum heißt es „hatch your own Qubbie" und
  nicht „beat your best".
- Keine Emojis in Titel und Kurzbeschreibung.

## Aufbau der Beschreibung

1. Was anders ist: ein Qubbie spielt mit. 2. Was man tut. 3. Die Qubbies,
mit dem Preisweg (erstes gratis, die übrigen für Diamanten) und dem Satz,
dass sie nichts an Punkten oder Teilen ändern. 4. Combo-Fieber, Daily,
Rätsel. 5. Designs, mit allen Theme-Namen. 6. Ziele (Quests, Erfolge, Level,
Sparschwein, Booster, Bestenliste). 7. „Fair, ohne Nerverei" samt dem Hinweis
auf In-App-Käufe. 8. Offline.

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

Ohne eigene Bilder zeigt Play in einer Sprache die Bilder der
Standardsprache Englisch (Suchauszug der Hilfe-Seite, 23.09.; nicht in der
Console gegengeprüft).

## Screenshots, Feature-Grafik, Video

Liegen fertig in `store-assets/`; wie sie entstehen und warum sie so
aufgebaut sind: `store-assets/README.md` und `docs/STORE-SCREENSHOTS.md`.
