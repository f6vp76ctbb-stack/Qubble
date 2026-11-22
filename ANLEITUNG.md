# Anleitung: was du noch tun musst

Stand **22.11.2026** · App **Qubble** · `com.thinkube.qubble`

**Das ist die einzige Anleitung.** Alle früheren (Launch-Fahrplan, Go-Live,
Play-Console-Prüflisten, Konten-Setup, Produkt-Anleitung) sind hier
zusammengeführt und gelöscht. Oben steht, was offen ist, in der Reihenfolge,
in der es sich lohnt. Unten steht kurz, was schon erledigt ist.

> **Zu Menüpfaden:** Ich sehe weder die Play Console noch AdMob. Deshalb stehen
> hier nur **Werte, Dateien und Suchbegriffe**, keine Klickwege. Wenn ein
> Formular ein Feld verlangt, das hier fehlt: **Schick mir einen Screenshot,
> dann bekommst du den Wert dazu.**

**Kurz: die offenen Schritte**

| # | Was | Warum jetzt | Wer |
|---|---|---|---|
| 14 | [Mehr Nutzer: Kategorie, Tags, KI-Label, Event, Play Shorts, Zahlen](#14--mehr-nutzer-kategorie-tags-ki-label-event-play-shorts-zahlen) | 20.11.: Play zeigt „10+ Downloads"; seit 09.10. hat sich kein neuer Spieler einen Namen gegeben. Qubble steht in „Casual" ohne Tags, jedes Store-Bild trägt das Label „AI" | du (15 Min.) → ich |
| 13 | [Social: Link in Bio, YouTube neu verbinden](#13--social-link-in-bio-youtube-neu-verbinden) | 18.11.: ~14.000 Aufrufe, 0 Store-Besuche. Ohne klickbaren Link führt kein Reel in den Store | du |
| 11 | [Zahlen festhalten](#11--zahlen-festhalten) | **Vor** dem neuen Store-Eintrag, sonst gibt es kein Vorher | du → ich |
| 9 | [Schlüssel für den automatischen Upload](#9--schlüssel-für-den-automatischen-upload) | Einmal einrichten; danach lädt ein Workflow Texte, Bilder und Versionen hoch | du |
| 10 | [Neuen Store-Eintrag veröffentlichen](#10--neuen-store-eintrag-veröffentlichen) | Bilder hast du am 16.11. ersetzt; Texte, Feature-Grafik und Alt-Texte, falls noch nicht drin | du / Workflow |
| 3 | [Videos](#3--videos) | 1.7.0 ist bei allen: jetzt die vier Store-Video-Links eintragen | du |
| 1 | [1.7.1 veröffentlichen](#1--171-veröffentlichen) | Nur ein Fix: Das Banner fürs leere Brett war für alle Deutsch und zeigte +300 statt 1.500. Eilt nicht | du |
| 12 | [Entscheidungen](#12--entscheidungen) | Symbol-Experiment, Haustier-Namen und -Preise, KI-Angabe für die Bilder | du |
| 5 | [AdMob: Testgerät und Einnahmen prüfen](#5--admob-testgerät-und-einnahmen-prüfen) | 16.11.: Werbung gesehen, aber keine Einnahmen in beiden Apps; eigene Live-Anzeigen zählen als ungültig | du → ich |
| 6 | [Händlerstatus (DSA): Telefonnummer eintragen](#6--händlerstatus-dsa-telefonnummer-eintragen) | Google hat gemailt: ohne Telefonnummer kein Händlerstatus. Nummer ist da, Impressum hat sie schon | du |
| 2 | [Play Games Services einrichten](#2--play-games-services-einrichten) | App ist vorbereitet; fehlen nur Erfolge, Bestenlisten und ihre IDs | du → ich trage IDs ein |
| 7 | [Produktkatalog korrigieren lassen](#7--produktkatalog-korrigieren-lassen) | Korrektur liegt als „Ausstehende Änderungen" bereit; vorher noch Kenia und Paraguay, dann anwenden | du |
| 8 | [AdMob: Block für den Rätsel-Hinweis](#8--admob-block-für-den-rätsel-hinweis) | Neuer Bonus (Hinweis per Video); mit eigenem Block siehst du ihn getrennt | du → ich trage die ID ein |
| 4 | [Steuerdaten](#4--steuerdaten) | Sobald Google Geld auszahlen soll | du |

Die Nummern sind feste Namen der Schritte (andere Dateien verweisen darauf),
nicht die Reihenfolge. Die Reihenfolge ist die der Tabelle.

---

## 14 · Mehr Nutzer: Kategorie, Tags, KI-Label, Event, Play Shorts, Zahlen

Stand 20.11.2026. Befund mit Quellen: `docs/WACHSTUM.md` §1a. Kurz: Fast
niemand findet Qubble. Die Punkte 1–3 kosten zusammen etwa eine Viertelstunde.
Die Menüpfade unten stehen so auf Googles Hilfeseiten (Nummer dahinter); was
ich nicht nachlesen konnte, steht als offen da.

1. **Kategorie und Tags.** Qubble steht in der Kategorie „Casual" und hat
   keinen einzigen Tag. Block Blast, Block Puzzle und Woodoku stehen in
   „Puzzle" und führen Tags wie „Block", „Single player", „Offline". Google
   (9859673): „Grow users > Store presence > Store settings", Abschnitt
   „App category" → Kategorie **Puzzle**; dann „Manage tags", höchstens
   **fünf**, nur solche, die ein Fremder am Eintrag sofort versteht. Aus der
   Liste „Suggested tags" passen, falls angeboten: „Block", „Offline",
   „Single player", „Casual". Welche Tags die Console für Qubble anbietet,
   sehe ich nicht. Änderungen brauchen laut Google bis zu 24 Stunden.
2. **„AI"-Label auf den Bildern.** Jedes Store-Bild zeigt im Store „AI"
   (7 auf der englischen, 9 auf der deutschen Seite). Das kommt aus der
   Selbstauskunft beim Hochladen. Google (17262077): „Declared assets will be
   AI-labeled on the Google Play Store" und „You may manually untick the
   declaration within the creation flows or in the Asset library in assets
   details." Die Bilder sind Aufnahmen der echten App
   (`tool/generate_screenshots.dart`), beschriftet von
   `tool/caption_screenshots.py`; kein Bild ist von einem Bildgenerator
   gemalt. Ob du sie als KI-Inhalt erklärst, bleibt deine Entscheidung
   (Schritt 12).
3. **Links in Bio und Kanal** (Schritt 13), falls noch nicht drin.
4. **Event-Karte „Qubbies"** (Promotional content, Typ „Major update", läuft
   fest 28 Tage, Zielgruppe „Potential users" = Leute, die Qubble nie
   installiert haben). **Nenn mir ein Startdatum**; Bilder (1920×1080 und
   quadratisch, ohne Text), Animation und Texte in en/de/es/pt baue ich dann.
   Google (12932541): höchstens 60 Tage vorher einreichen, Prüfung bis zu
   4 Tage, **mit Featuring-Antrag mindestens 14 Tage vorher** — bei
   Einreichung am 21.11. also Start frühestens 05.12. Spiele haben 4
   Featuring-Anträge pro Quartal. Ob Qubble Featuring beantragen kann, zeigt
   die Console (Featuring-Zähler auf der Seite „Promotional content"); die
   Bedingungen dafür („Premium growth tools") nennt Google nicht öffentlich.
5. **Play Shorts nachsehen.** Google (18611720) beschreibt einen
   Hochkant-Video-Feed auf Play; Upload unter „Store presence → Play Shorts".
   Ob Spiele schon teilnehmen können, sagt die Seite nicht. Ist der Punkt bei
   dir da, sag Bescheid: Ich rendere ein Video nach Googles Vorgaben
   (10–60 s, 9:16, mindestens 720p, Englisch, keine Logos von
   Social-Plattformen, Sicherheitsränder oben 15 %, unten 20 %, seitlich 10 %).
6. **Zahlen** (ein Screenshot je Seite genügt; Schritt 11 bleibt als
   Nachschlag):
   - Übersicht „Grow users": Akquisitionen der letzten 90 Tage nach
     Traffic-Quelle (Google 9859173, 16394358);
   - „Grow users > Store performance > Conversion analysis": Besucher und
     Klickrate, gefiltert nach UTM-Quelle `instagram`, `youtube`, `x`
     (Google 9859173);
   - „Grow users > Store performance > Promotional content": das
     Halloween-Event mit „Total unique users impressions" und „Total unique
     converters" (Google 12932124);
   - AdMob nur, wenn Zeit ist: Bei zehn Spielern sagt es wenig.

---

## 13 · Social: Link in Bio, YouTube neu verbinden

Stand 18.11.2026. Instagram und YouTube Shorts machen Links in Beschreibungen
**nicht klickbar**. Klickbar sind nur: Instagram-Bio, Story-Link-Sticker,
der Link auf der YouTube-Kanalseite und Links in X-Posts. Alle neuen Reels
sagen „link in bio" bzw. „link on the channel page" — das muss also stimmen.

1. **Instagram-Bio** (thinkubequbble): diesen Link eintragen bzw. den
   vorhandenen ersetzen:
   `https://play.google.com/store/apps/details?id=com.thinkube.qubble&referrer=utm_source%3Dinstagram%26utm_medium%3Dbio`
2. **YouTube-Kanal** (Qubble): denselben Link mit `utm_source%3Dyoutube`
   statt `instagram` als Kanal-Link eintragen.
3. **Buffer: YouTube neu verbinden.** Buffer meldet seit 18.11. „lost
   authorization"; bis dahin schlägt jeder YouTube-Post fehl. Der Post vom
   18.11. 10:00 (Combo ×10) ist schon fehlgeschlagen.
4. **Messen:** Die Play Console zeigt Store-Besucher nach UTM-Quelle
   (`instagram`, `youtube`, `x`) und Kampagne (`cta_reels`; für den Videotest
   22.–26.11. `videotest_01` … `videotest_05`, je Clip eine). Suchbegriff
   dort: „UTM". Nach 7 Tagen die Zahlen schicken, dann wird der Plan
   angepasst; für den Videotest ab 29.11.

---

## 1 · 1.7.1 veröffentlichen

1.7.0 (Code 19) ist seit 16.11. bei 100 %. **1.7.1 (Code 20)** ändert für
Spieler nur eins: Das Banner beim leer geräumten Brett stand fest auf Deutsch
(„BLITZBLANK!", in allen Sprachen) und zeigte den alten Bonus (+300 statt
1.500). Eilt nicht. Sobald 1.7.1 bei allen ist, kommt auch der All-Clear-Clip
auf Social Media — er zeigt schon das neue Banner.

- **Das Bundle ist gebaut:** Artefakt `qubble-release-aab-PRODUCTION-ads` aus
  **Lauf #43** (Actions → „Build Android Release (.aab)", 17.11.). Geprüft vom
  Workflow: Version 1.7.1, Code 20, targetSdk 36, echte Anzeigen, Play Games
  aus, mit dem Upload-Schlüssel signiert (nicht dem Debug-Schlüssel). Der
  Download ist ein Zip; darin liegt `app-release.aab`. Das Artefakt bleibt bis
  14.02.2027 abrufbar.
- **Hochladen:** von Hand wie bisher — oder, sobald Schritt 9 erledigt ist,
  mit dem Workflow „Play Store": Aktion `draft-release`, bei „build_run_id"
  die Nummer `43982965173` (sie steht in der Adresse von Lauf #43).
- **„Was ist neu":** `docs/release-notes/1.7.1-en.txt`, `-de.txt`, `-es.txt`,
  `-pt.txt`.
- **Datensicherheit:** 1.7.1 sendet nichts Neues.
- **Rollout:** wie bei 1.7.0 mit 20 % starten, nach einem Tag Android Vitals
  und Crashlytics ansehen, dann 100 %.

---

## 2 · Play Games Services einrichten

Projekt in der Play Console angelegt (02.10.), **Projekt-ID `108672510585`**.
**Die App ist vorbereitet** (02.10.): SDK, Anmeldung beim Start, sie meldet
Erfolge, jede Endlos-Runde und die Daily-Serie. Es fehlen nur die IDs aus der
Console. Werte aus Googles Doku ([Einrichten](https://developers.google.com/games/services/console/enabling),
[Erfolge](https://developer.android.com/games/pgs/achievements),
[Erfolge importieren](https://developer.android.com/games/pgs/integrate-achievements#import-achievements),
[Bestenlisten](https://developer.android.com/games/pgs/leaderboards),
[Qualitäts-Checkliste](https://developer.android.com/games/pgs/quality),
[Testen und veröffentlichen](https://developer.android.com/games/pgs/console/publish),
[IDs der nächsten Generation](https://developer.android.com/games/pgs/next-gen-player-ids)).
Klickwege kenne ich nicht, schick einen Screenshot, wenn etwas anders aussieht.

1. **OAuth-Zustimmungsbildschirm** (Cloud Console):
   - Nutzertyp **Extern**; App-Name `Qubble`; Support- und Kontakt-E-Mail:
     deine.
   - **Kein Logo hochladen** — laut Google löst ein Logo eine Prüfung aus.
   - Bereiche: `games`, `games_lite`, `drive.appdata` (laut Google ohne
     Prüfung).
   - Status **veröffentlichen** (Produktion); im Test-Status kommen nur
     eingetragene Testnutzer hinein.
2. **Anmeldedaten:** Typ **Android**, Paketname `com.thinkube.qubble`,
   **SHA-1 des App-Signaturschlüssels** aus der Play Console (Qubble nutzt die
   Play-App-Signatur).
3. **Eigenschaften** (Formular „Eigenschaften bearbeiten", alles auf
   Englisch):
   - Anzeigename: `Qubble` (steht schon da).
   - Beschreibung: der englische Store-Text, unverändert
     (`store-assets/listing/en-US/full_description.txt`, 2.893 von 4.000
     Zeichen).
   - Spielkategorie: **Puzzle**, wie im Store. Gibt es die Option nicht,
     schick mir die Liste.
   - **IDs der nächsten Generation: An.** Laut Google gilt das nur für
     Spieler, die sich noch nie angemeldet haben (bei Qubble: alle), und wird
     ohnehin Pflicht. Die App nutzt die ID nur intern, das passt.
   - **Recall: deaktiviert lassen.** Qubble nutzt Recall nicht, so entfallen
     die zusätzlichen Nutzungsbedingungen.
   - **Gespeicherte Spiele: Aus.** Qubble nutzt sie nicht, und laut Formular
     lässt sich das nach dem Veröffentlichen nicht mehr abschalten.
   - Spielsymbol: `store-assets/play-games/game-icon-512.png` (das App-Icon
     als 32-Bit-PNG, wie gefordert; 512 × 512, 121 KB).
   - Vorstellungsgrafik: `store-assets/en/feature-graphic-1024x500.png`
     (24-Bit-PNG, 1024 × 500, 109 KB).
   - Firebase-Projekt: nicht nötig, weglassen.
4. **17 Erfolge importieren** (Googles Import, eine Zip-Datei):
   - **Neu (02.10.): nur noch 12 Sprachen.** Der erste Import mit allen 59
     scheiterte mit „Sprache nicht unterstützt", weil Sprachen im
     Spielprojekt fehlten. Der Zip enthält jetzt nur verbreitete Sprachen,
     die auch die App hat:

     | Sprache | Code im Zip |
     |---|---|
     | Deutsch | `de-DE` |
     | Spanisch (Lateinamerika) | `es-419` |
     | Spanisch (Spanien) | `es-ES` |
     | Französisch | `fr-FR` |
     | Italienisch | `it-IT` |
     | Portugiesisch (Brasilien) | `pt-BR` |
     | Niederländisch | `nl-NL` |
     | Polnisch | `pl-PL` |
     | Türkisch | `tr-TR` |
     | Japanisch | `ja-JP` |
     | Koreanisch | `ko-KR` |
     | Chinesisch (vereinfacht) | `zh-CN` |

     Englisch ist die Standardsprache des Projekts und steckt in
     `AchievementsMetadata.csv`, nicht in der Übersetzungsdatei.
   - **Zuerst genau diese 12 Sprachen im Spielprojekt hinzufügen.** Laut
     Google geht der Import mit Übersetzungen nur für Sprachen, die das
     Spielprojekt schon hat. Google nennt den Weg „Edit properties → Manage
     translations → Manage your own translations": dort die 12 wählen, dann
     „Apply". Fehlt eine davon in der Auswahl oder heißt sie anders (z. B.
     „Spanisch" ohne Region): mir den Namen oder einen Screenshot schicken,
     ich baue den Zip dann ohne sie bzw. mit dem passenden Code neu
     (`python3 tool/play_games_import.py <codes>`).
   - Verlangt die Console danach pro Sprache eigene Pflichtfelder (Name,
     Beschreibung, Grafiken): Screenshot schicken. Store-Texte und Grafiken
     gibt es für jede dieser Sprachen schon.
   - Laut Google lassen sich Übersetzungen nach dem Import nicht mehr
     gesammelt nachladen, nur einzeln pro Erfolg. Weitere Sprachen später
     also besser vor dem Import entscheiden; die App selbst bleibt in allen
     ihren Sprachen übersetzt, das betrifft nur das Play-Games-Profil.
   - **Dann importieren:** `store-assets/play-games/qubble-achievements-import.zip`
     hochladen (Google: „Import achievements" → „Upload"), danach „Save as
     draft". Der Zip enthält die vier Teile, die die Console verlangt:
     `AchievementsMetadata.csv`, `AchievementsLocalizations.csv`,
     `AchievementsIconsMappings.csv` und die 17 Symbole als PNG.
   - Kommt wieder „Sprache nicht unterstützt": Screenshot der Sprachliste
     unter „Manage translations" schicken.
   - Inhalt: Namen und Beschreibungen sind die Texte der App, in den 12
     Sprachen oben, mit Icons. Alle Erfolge sind sichtbar. Zusammen 680 Punkte
     (Vielfache von 5, höchstens 200 pro Erfolg). Einzelheiten in
     `store-assets/play-games/import/AchievementsMetadata.csv`.
   - **8 Erfolge mit Fortschrittsbalken** (z. B. „12/25 Runden"), wie Google
     es empfiehlt: Runden, Reihen, Level, Rätsel, Teile. **9 einfache**:
     erste Runde, Punkte, Combo, Serie. Laut Google lässt sich der Typ nach
     dem Veröffentlichen nicht mehr ändern.
   - Erzeugt mit `python3 tool/play_games_import.py`. Meldet die Console
     einen Fehler: Wortlaut schicken.
5. **2 Bestenlisten anlegen:**

   | Name | Icon | Format | Reihenfolge | Obergrenze |
   |---|---|---|---|---|
   | Best score | `leaderboard_best_score.png` | Zahl, keine Nachkommastellen | Größer ist besser | 100000000 (wie die App-Bestenliste) |
   | Daily streak | `leaderboard_daily_streak.png` | Zahl, keine Nachkommastellen | Größer ist besser | 10000 |

   Laut Google lässt sich die Reihenfolge nach dem Veröffentlichen nicht mehr
   ändern. Der Manipulationsschutz ist bei neuen Bestenlisten schon an; so
   lassen.
6. **Mir schicken:** das XML hinter **„Get resources"** /
   „Ressourcen abrufen" (Android), **nachdem** Erfolge und Bestenlisten
   angelegt sind. Das XML vom 02.10. enthält nur `app_id` und `package_name`
   (schon in der App), noch keine Erfolge. Ich trage die IDs ein; ab dem
   nächsten Release meldet die App alles.
7. **Testen:** Solange das Projekt nicht veröffentlicht ist, können laut
   Google nur eingetragene Tester die Dienste nutzen. Trag deine eigene
   Google-Adresse als Tester ein.
8. **Projekt veröffentlichen**, sobald das Release mit den IDs live ist. Ich
   sage Bescheid. Laut Google ist das getrennt vom App-Release und ändert
   nichts am Store-Eintrag.
9. **Datensicherheit beim nächsten Release ergänzen:** Laut Google erhebt das
   Play-Games-SDK schon beim Start Daten (Spielername/Avatar, Analyse,
   Diagnose; Liste in `docs/DATA-SAFETY.md`). Schick mir beim Release einen
   Screenshot der Datentypen im Formular, dann sage ich dir, welche Kästchen
   dazukommen. Die Datenschutzerklärung beschreibt Play Games schon
   (Abschnitt 8, „derzeit ausgeschaltet"); beim Einschalten nehme ich den
   Zusatz heraus.

---

## 3 · Videos

- **Store-Video neu (15.11.):** `store-assets/video/qubble-promo-en.mp4`,
  `-de`, `-es`, `-pt` (je 16,7 s, hochkant, mit Ton): Combo zum Einstieg,
  zehn Looks (neun Themes) im Schnelldurchlauf, dazwischen Hauptmenü, Qubbies und ein
  Theme-Wechsel, Combo zum Schluss, 2,6 s Logo. Eine Fassung je Sprache, weil
  Menütext zu sehen ist. **Erst hochladen, wenn die nächste Version (neues
  Design, Drehen ohne Knopf) bei allen ist** — das Video zeigt sie schon.
  ✓ **Auf YouTube seit 16.11., nicht gelistet** (nur über den Link zu sehen):
  en-US `https://www.youtube.com/watch?v=A6713uvvg4g`, de-DE
  `https://www.youtube.com/watch?v=cf_lFxchW0s`, es-419
  `https://www.youtube.com/watch?v=kTnDCXfITuU`, pt-BR
  `https://www.youtube.com/watch?v=WDt0dsBvEMM`. **Jetzt eintragen**
  (1.7.0 ist seit 16.11. bei 100 %): je Sprache den Link im Store-Eintrag. Wo: laut Google-Hilfe im Abschnitt „Graphics", Feld „preview
  video" (Wortlaut der Hilfe vom 15.11.: „You can upload images and add a
  preview video in the “Graphics” section", „entering a YouTube URL in the
  "preview video" field"); wie es in deiner deutschen Console heißt, sehe ich
  nicht. Ersetzt dort das Showreel.
- **`store-assets/video/qubble-showreel.mp4`** (17 s, hochkant, mit Ton,
  ohne Text): zwölf schnelle Szenen, jede ein anderes Design, ein anderer
  Effekt, ein anderes Qubbie. ✓ **Auf YouTube seit 15.11.:**
  `https://www.youtube.com/watch?v=TMOZ2u62GnI`. Offen: diesen Link im
  Store-Eintrag als Promo-Video eintragen — **erst wenn 1.6.0 bei allen
  ist**, denn es zeigt Haustiere.
- **Titel, Beschreibung, Tags:** `store-assets/video/YOUTUBE.md` (Englisch
  und Deutsch, dazu ein kurzer Text für die Clips).
- **Was Google vom Video verlangt** (Pflicht; Wortlaut der Hilfe-Seite vom
  14.11.2026, `docs/STORE-LISTING.md`): Werbung im Video aus („Turn off
  monetization"), Sichtbarkeit **öffentlich oder nicht gelistet** (nicht
  privat), **keine Altersbeschränkung**, und es muss sich **einbetten**
  lassen. Wie die Schalter bei YouTube heißen, weiß ich nicht aus eigener
  Anschauung — im Zweifel Screenshot.
- Dasselbe und `qubble-gameplay.mp4` (25 s, eine Partie am Stück),
  `qubble-neon.mp4`, `qubble-ocean.mp4`, `qubble-sunset.mp4` als
  Shorts/Reels/TikTok posten, z. B. eins pro Woche. Seit 15.11. spielt in
  jedem ein Qubbie mit (Katze, Donnervogel, Pinguin, Drache), und der
  aufgemalte Fingerpunkt ist aus allen Videos heraus: Google will im
  Store-Video keine „fingers tapping on the device".
- **Alle Plattformen auf einmal** (TikTok, Instagram, Facebook-Seite): über
  einen Planungsdienst, der die Konten einmal verbindet und ein Video auf
  alle verteilt. Empfehlung vom 15.11.: Buffer (kostenlos laut
  Vergleichsseiten: 3 Kanäle, je 10 geplante Posts) oder Metricool (1 Marke,
  20 Posts im Monat) — Zahlen vor der Anmeldung auf der Preisseite prüfen.
  ✓ **Seit 16.11. über Buffer verbunden** (TikTok, Instagram, YouTube): Ich
  plane die Posts dort selbst; du musst nichts hochladen. Neu am 16.11.:
  fünf Social-Clips (`qubble-reel-turbo`, `-allclear`, `-clutch`, `-looks`,
  `qubble-wood.mp4`) und zwei Karussells (`store-assets/social/`). Die
  Clips sind nur für Social Media, nicht für den Store (Textzeile am Anfang,
  der All-Clear ist eine gestellte Stellung).
- **Impressum in jedem Profil**, auch im YouTube-Kanal: Ein Konto, das für
  Qubble wirbt, ist gewerblich (§ 5 DDG laut Ratgebern von e-recht24 und
  Händlerbund, kein Urteil gelesen). Link
  `https://f6vp76ctbb-stack.github.io/Qubble/impressum.html` ins
  Website-Feld oder in die Bio; bei TikTok gibt es das Website-Feld laut
  Händlerbund nur im Business-Konto.
- Brauchst du Nachschub: Sag Bescheid, ein neues Schnittvideo mit anderen
  Szenen dauert Minuten (`tool/generate_showreel.dart`).

---

## 4 · Steuerdaten

Keine Steuerberatung. Stand 26.10.:

- ✓ **Gewerbe ist angemeldet** (Oktober).
- **Fragebogen zur steuerlichen Erfassung** über Mein ELSTER abschicken, falls
  noch nicht geschehen; nicht auf Post vom Finanzamt warten. Darin die
  **Kleinunternehmerregelung (§ 19 UStG)** wählen. Danach kommt die
  Steuernummer per Brief.
- Danach Steuernummer bzw. USt-IdNr. (vom BZSt, wegen Reverse-Charge bei
  AdMob) in die Zahlungsprofile von Google eintragen, ohne sie gibt es keine
  Auszahlung.
- **Sobald du eine USt-IdNr. oder eine Wirtschafts-Identifikationsnummer
  hast:** mir schicken. Sie muss dann ins Impressum (§ 5 Abs. 1 Nr. 6 DDG);
  die Steuernummer gehört nicht hinein.
- Im Zweifel kurz Finanzamt oder Steuerberater fragen.

---

## 5 · AdMob: Testgerät und Einnahmen prüfen

**16.11.: Werbung in Qubble und im Feierabend-Rechner gesehen, aber keine
Einnahmen in AdMob.** Im Code geprüft:

- **Qubble (Android):** Belohnung erst nach einem ganz gesehenen Video;
  Release-Builds #40 und #41 mit den echten Anzeigenblöcken; App-ID
  `ca-app-pub-8596176219181991~9674890597`. Ein **volles** Sparschwein zahlt
  absichtlich ohne Video aus (Monetarisierungs-Regeln), nur das frühe Öffnen
  kostet ein Video.
- **Qubble (Web-Version):** gab jede Video-Belohnung **ohne Video** —
  behoben am 16.11. (PR #91). Dort gibt es jetzt keine Videos und keine
  Video-Belohnungen.
- **Feierabend-Rechner:** Der Store-Build bekommt die echten IDs (App
  `~3672450377`, Banner `/4877720835`, Video `/6079121863`); die
  Tester-Version startet keine Werbung.
- **app-ads.txt** ist online: `https://f6vp76ctbb-stack.github.io/app-ads.txt`
  mit `google.com, pub-8596176219181991, DIRECT, f08c47fec0942fa0` (geprüft
  16.11.).

Was Google dazu sagt (Hilfe-Seiten, gelesen 16.11.2026):

- **Eigene Anzeigen bringen nichts:** Als ungültiger Traffic gelten
  „Clicks or impressions generated by publishers clicking on their own live
  ads" ([Ungültiger Traffic](https://support.google.com/admob/answer/3342054));
  „Publishers may not click their own ads or use any means to inflate
  impressions and/or clicks artificially, including manual methods"
  ([Ungültige Zugriffe vermeiden](https://support.google.com/admob/answer/3342099)).
  **Also keine echten Anzeigen in den eigenen Apps mehr ansehen**, sondern
  das Handy als Testgerät eintragen (unten).
- **Berichte kommen verzögert:** „In most cases, your AdMob metrics (such as
  clicks and impressions) are delayed by approximately 4 hours"
  ([Daten-Aktualität](https://support.google.com/admob/answer/13291097)).
- **Neue Apps zeigen erst nach einer Prüfung voll Anzeigen:** „When you set up
  a new app in AdMob, your app must be reviewed and approved before it can
  fully serve ads"; Status „Getting ready", „Requires review" (App mit
  keinem Store verknüpft), „Needs attention" oder „Ready"; „Reviews
  typically take 2-3 days" ([App-Bereitschaft](https://support.google.com/admob/answer/10564477)).
  Neue Apps müssen seit Januar 2025 außerdem über app-ads.txt bestätigt
  werden ([App bestätigen](https://support.google.com/admob/answer/14538460)).

**Was ich von dir brauche (Screenshots, dann sage ich dir, woran es liegt):**

1. Die Übersicht aller Apps in AdMob mit dem **Status** beider Apps.
2. Für beide Apps den Bericht von gestern und heute mit **Anfragen,
   Abgleichsrate (Match rate) und Impressionen** je Anzeigenblock. Anfragen
   ohne Impressionen heißt: kein Anzeigenangebot. Gar keine Anfragen heißt:
   die IDs passen nicht zur App.

Der AdMob-Bericht vom 02.10. zeigt für den Block `Rewarded test` 20
Impressionen bei 3 Zuschauern, 4 Klicks (20 % Klickrate) und einen eCPM von
351 $. So sieht kein normaler Verkehr aus. Laut AdMob-Richtlinien darf man
eigene Live-Anzeigen nicht anklicken; viel ungültiger Traffic kann zur
Sperrung des Kontos führen
([Richtlinie](https://support.google.com/admob/answer/3342054),
[ungültige Zugriffe](https://support.google.com/admob/answer/3342099)).
Versehentliche Klicks muss man laut Google nicht melden.

- **Dein Handy als Testgerät eintragen** (laut
  [Google-Hilfe](https://support.google.com/admob/answer/9691433): Settings →
  Test devices → Add test device; Name, Plattform Android, **Werbe-ID** des
  Handys, Speichern). Danach bekommt dein Gerät Testanzeigen, auch in der
  Store-Version. Laut Google kann es bis zu einer Stunde, selten 24 Stunden
  dauern. Die Werbe-ID steht in den Android-Einstellungen; wo genau, hängt
  vom Gerät ab. Findest du sie nicht, schick mir einen Screenshot.
- Dasselbe für alle, die die App bei dir testen. Sonst: deren Videos nicht
  anklicken lassen.
- **Optional, Firebase:** Den Parameter `placement` als benutzerdefinierte
  Dimension registrieren (laut
  [Firebase-Doku](https://firebase.google.com/docs/analytics/flutter/events):
  Analytics > Events > Manage Custom Definitions > Create Custom
  Dimensions; Bereich Ereignis, Parameter `placement`). Dann zeigt Firebase
  für jeden Bonus, wie oft er angeboten, angetippt und angesehen wurde
  (`rewarded_offered`, `rewarded_accepted`, `rewarded_watched`), egal über
  welchen Anzeigenblock. Gilt ab der Registrierung.
- **`Rewarded test` umbenennen** in z. B. `Qubble – Allgemein (Ersatz)`.
  Laut Google lässt sich der Name eines Blocks ändern; die App kennt nur die
  ID. Danach prüfen, dass die ID weiter auf `4303264559` endet. Es ist **kein
  Test-Block**, sondern der echte, über den alle Videos aus 1.2.0 und die
  Ersatz-Videos laufen; die 7,03 $ sind echt.

---

## 6 · Händlerstatus (DSA): Telefonnummer eintragen

Du hast ein Gewerbe angemeldet und verdienst mit der App. Nach dem Digital
Services Act bist du damit **Händler** (Art. 3 lit. f DSA). Google muss dann
deinen Namen, deine Anschrift, Telefonnummer und E-Mail-Adresse erfassen und
EU-Nutzern anzeigen (Art. 30, 31 DSA). Google hat dir gemailt, dass ohne
Telefonnummer der Händlerstatus nicht geht.

Schon eingetragen (von mir, 10.11.), **nur im Impressum**, weil sie nur dort
Pflicht ist (zweiter Kontaktweg neben der E-Mail; dein Wunsch: nirgends sonst):

- Qubble: `web/impressum.html`. Online seit 12.11.
- Feierabend Rechner: Impressum online und in der App. Online sofort; in der
  App erst mit dem nächsten Feierabend-Update.

**Das trägst du selbst ein: die Händlerangabe in der Play Console.** Den Weg
dorthin sehe ich nicht. Nimm den Link aus Googles Mail, sonst in der Console
nach **„Händler"** bzw. **„trader"** suchen. Liegen Qubble und Feierabend
Rechner in verschiedenen Entwicklerkonten, in jedem eintragen.

Deine Angaben (die Feldnamen im Formular kenne ich nicht):

| Angabe | Wert |
|---|---|
| Name | Sam Däubler |
| Anschrift | Mähderweg 5, 88451 Dettingen, Deutschland |
| Telefon | deine Thinkube-Nummer (die im Impressum). Steht in der Console schon eine andere, ersetze sie |
| E-Mail | thinkube@outlook.de |

- Google zeigt diese Angaben EU-Nutzern öffentlich im Store an.
- Prüft Google die Nummer per SMS oder Anruf, muss das Handy mit der Nummer
  erreichbar sein.
- Verlangt das Formular ein Feld, das hier fehlt, oder steht dort „kein
  Händler": **Screenshot an mich**, bevor du etwas absendest.

---

## 7 · Produktkatalog korrigieren lassen

**Geprüft am 28.10.** (die KI im Produktkatalog, nur lesend). Gefunden:

- Alle zehn Preise um die MwSt. zu hoch (z. B. Unterstützer-Paket 5,99 €
  statt 4,99 €, Münzen S 1,19 € statt 0,99 €), in den USA ebenso. **Entscheidung
  28.10.: Planpreise.**
- Englische Texte von `qubble_diamonds_m` und `_l` beschreiben Münzen
  („2000 Coins", „6000 Coins") statt Diamanten.
- Preisstaffel verkehrt: in Georgien ist das große Münz- und Diamant-Paket pro
  Stück teurer als das mittlere, in Paraguay steigt der Preis pro Diamant mit der
  Paketgröße. Die App schreibt dort „Bestes Verhältnis" an ein Paket, das es
  nicht ist.
- Veraltete Wechselkurse (GE, MM, PY, ZZ.EUR), krumme Preise (AR, AZ, ET, UZ,
  ZZ.USD), `en-AU` fehlt bei `qubble_diamonds_m`.
- Kein Problem: Kaufoptions-IDs heißen `qubble-…` statt `standard` (die App
  nutzt sie nicht), kein Merchandising.

**Stand 28.10. abends:** Der Korrektur-Prompt unten ist gelaufen. Die KI hat
die Änderungen als **„Ausstehende Änderungen"** vorbereitet, noch nicht
übernommen. Danach: Rundung in allen Ländern sauber, Übersetzungen vollständig
(alle sieben englischen Varianten), Münz-Staffel überall richtig. **Offen:**

1. **Diamanten in Kenia und Paraguay:** dort ist das große Paket pro Diamant
   noch nicht das günstigste (KE: 100 / 400 / 1200 KES, PY: 5.000 / 20.000 /
   50.000 PYG). Diesen Text an dieselbe KI schicken, **bevor** du die Änderungen
   anwendest:

   ```
   Bitte passe in den ausstehenden Änderungen vor dem Anwenden noch Kenia (KE) und
   Paraguay (PY) an, nur die drei Diamant-Pakete. Pro Diamant muss dort streng gelten:
   qubble_diamonds_l < qubble_diamonds_m < qubble_diamonds_s.
   Nimm nur Preispunkte, die in der Landeswährung zulässig und üblich sind, und bleib so
   nah wie möglich am umgerechneten Euro-Preis (0,99 € / 2,99 € / 7,99 €).
   Alles andere bleibt unverändert. Zeig mir danach die neuen Preise der drei Pakete in
   KE und PY mit dem Preis pro Diamant und wiederhole die Staffelprüfung für Münzen und
   Diamanten in allen Ländern.
   ```

2. Dann in der Console **„Überprüfen" → „Änderungen anwenden"** (so nennt es die
   KI). Erst danach gelten die neuen Preise und Texte.
3. **Automatische Wechselkursaktualisierung nicht einschalten.** Laut KI rundet
   sie jedes Produkt einzeln und kann die Staffel wieder umdrehen. Die
   Abweichung in Kenia und Serbien bei den 0,99-€-Produkten ist harmlos: Der
   Preis liegt dort unter dem umgerechneten Betrag, weil die Preisstufen grob
   sind.
4. **Standardsprache der Produkte ist Deutsch** (laut KI an die Hauptsprache
   des Store-Eintrags gekoppelt): Wer weder Deutsch noch Englisch eingestellt
   hat, sieht die Produkttexte im Kaufdialog auf Deutsch. Abhilfe: Texte in
   allen Sprachen; die kann ich aus den App-Texten erzeugen (offen, auf Wunsch).

**Der erste Korrektur-Prompt** (erledigt, zum Nachschlagen):

```
Bitte korrigiere den Produktkatalog meiner App „Qubble" (com.thinkube.qubble).
Zeig mir vor dem Speichern eine Zusammenfassung aller Änderungen und speichere erst nach meinem OK.

NICHT ändern: Produkt-IDs, Kaufoptions-IDs, Kauftyp, Abwärtskompatibilität, Verfügbarkeit,
Steuerkategorie, Tags, Merchandising. Keine Produkte anlegen oder löschen, keine Angebote
oder Rabatte anlegen. Die automatische Wechselkursaktualisierung NICHT einschalten.

1. Preise. Das zahlt der Käufer in Deutschland, INKLUSIVE 19 % MwSt.:
   qubble_supporter 4,99 € | qubble_starter 1,99 € | qubble_coins_s 0,99 € |
   qubble_coins_m 2,99 € | qubble_coins_l 7,99 € | qubble_rename 1,49 € |
   qubble_neon_theme 2,49 € | qubble_diamonds_s 0,99 € | qubble_diamonds_m 2,99 € |
   qubble_diamonds_l 7,99 €
   a) Alle Euro-Länder: derselbe Bruttobetrag wie in Deutschland.
   b) USA: dieselben Ziffern in US-Dollar (4.99, 1.99, 0.99, 2.99, 7.99, 1.49, 2.49 USD),
      wie in den USA üblich ohne Sales Tax.
   c) Alle anderen Länder, auch ZZ.USD und ZZ.EUR: aus dem deutschen Bruttopreis zum
      aktuellen Wechselkurs neu berechnen und nach den lokalen Preismustern runden.
   d) Danach in jedem Land prüfen: Preis pro Münze qubble_coins_l < qubble_coins_m <
      qubble_coins_s und Preis pro Diamant qubble_diamonds_l < qubble_diamonds_m <
      qubble_diamonds_s. Wo das nicht gilt, das größere Paket auf den nächstniedrigeren
      üblichen Preispunkt setzen, bis es gilt. Grund: App und Produkttexte versprechen
      beim großen Paket den günstigsten Preis pro Stück.

2. Texte (Titel | Beschreibung):
   qubble_diamonds_s
     de-DE: 100 Diamanten | 100 Diamanten für Premium-Skins, -Themes und mehr.
     en-US: 100 Diamonds | 100 diamonds for premium skins, themes and more.
   qubble_diamonds_m
     de-DE: 350 Diamanten | 350 Diamanten für Premium-Skins, -Themes und mehr. Günstiger pro Diamant als das kleine Paket.
     en-US: 350 Diamonds | 350 diamonds for premium skins, themes and more. Cheaper per diamond than the small pack.
   qubble_diamonds_l
     de-DE: 1000 Diamanten | 1000 Diamanten für Premium-Skins, -Themes und mehr. Günstigster Preis pro Diamant.
     en-US: 1000 Diamonds | 1000 diamonds for premium skins, themes and more. Lowest price per diamond.
   qubble_neon_theme, nur de-DE, nur die Beschreibung:
     Schaltet das Neon-Theme dauerhaft frei: schwarzes Brett, leuchtend grüne, cyanfarbene und pinke Blöcke.
   Alle anderen Texte bleiben, wie sie sind.

3. Lege für alle zehn Produkte den en-US-Titel und die en-US-Beschreibung zusätzlich für
   jede weitere englische Sprachvariante an, die die Console anbietet (mindestens en-AU
   und en-GB).

4. Nach dem Speichern:
   - alle Zustandsprüfungen erneut ausführen und die Ergebnisse wörtlich wiedergeben;
   - die Prüfung aus 1d für jedes Land wiederholen und jede Ausnahme mit Preisen nennen;
   - den kompletten Katalog als CSV- oder JSON-Datei exportieren (alle Länder, alle Sprachen);
   - sagen, welche Sprache die Standardsprache der Produkte ist, die Käufer ohne eigene
     Übersetzung sehen;
   - erklären, wie die automatische Wechselkursaktualisierung arbeitet (wie oft, mit welcher
     Rundung, ob die Staffel aus 1d erhalten bleibt). Nur erklären, nicht einschalten.
```

Warum die neuen Diamant-Texte: „Mehr pro Euro" passt nicht für Käufer in
Franken oder Dollar, und Diamanten kaufen auch Zubehör, Explosionen und
animierte Skins („und mehr"). Neon zeigt tatsächlich drei Farben
(`lib/ui/theme.dart`), der englische Text hatte recht.

---

## 8 · AdMob: Block für den Rätsel-Hinweis

Neu in der App (kommt mit dem nächsten Release, 1.6.0): Im Rätsel gibt es
unter dem Zugzähler den Knopf **„Hinweis (Video)"**. Nach dem Video zeigt
das Brett golden umrandet, wohin das aktuelle Teil gehört. Beliebig oft pro
Rätsel, kostet keinen Stern (deine Entscheidung vom 02.10.). Ist das Brett
nicht mehr leerbar, kommt kein Video, sondern „Starte das Rätsel neu".

- **Anlegen:** neuer Anzeigenblock, Format **„Mit Prämie"**, Name
  `Qubble – Rätsel-Hinweis`. Alle übrigen Felder wie in der Tabelle
  [„Die Felder"](#anzeigenblöcke-angelegt-2809-und-0210) unten.
- **Mir die Block-ID schicken** (`ca-app-pub-8596176219181991/…`). Ich trage
  sie in `lib/monetization/ad_config.dart` ein.
- Bis dahin läuft der Hinweis über den Ersatzblock `Rewarded test`. Das
  funktioniert, AdMob zeigt ihn dann nur nicht getrennt. In Firebase heißt
  die Platzierung `puzzle_hint`.

---

## 9 · Schlüssel für den automatischen Upload

Einmalig. Danach lädt der Workflow „Play Store (listing, release, reviews)"
Texte, Bilder und Versionen hoch und holt montags die Bewertungen der Woche.

**Was am Ende da sein muss:** ein Repository-Geheimnis namens
`PLAY_SERVICE_ACCOUNT_JSON` mit dem **vollständigen Inhalt** der
JSON-Schlüsseldatei eines Google-Cloud-Dienstkontos, dem die Play Console
Zugriff auf Qubble gibt.

- **Wie man Dienstkonto und Schlüssel anlegt und in die Console einlädt,**
  beschreibt Google selbst: <https://developers.google.com/android-publisher/getting_started>.
  Ich schreibe die Klickwege nicht ab, weil ich die Console nicht sehe. Sieht
  ein Schritt bei dir anders aus als dort: Screenshot an mich.
- **Rechte:** nur für die App Qubble, nur was der Workflow braucht — den
  Store-Eintrag bearbeiten, Releases für die Produktion verwalten,
  Rezensionen lesen. **Kein Admin, keine Finanzdaten.** Wie die Häkchen
  heißen, weiß ich nicht aus eigener Anschauung; im Zweifel Screenshot.
- **Ins Repo:** GitHub → `f6vp76ctbb-stack/Qubble` → Settings → Secrets and
  variables → Actions → New repository secret (derselbe Ort wie die
  Signatur-Geheimnisse, `docs/BUILD-CI.md`). Name
  `PLAY_SERVICE_ACCOUNT_JSON`, Wert: der ganze Inhalt der Datei.
- **Die Datei selbst nie ins Repo** (es ist öffentlich) und nicht in einen
  Chat. Danach vom Rechner löschen oder in den Passwort-Manager.
- **Probe:** Workflow „Play Store" starten, Aktion `check-listing`. Wird der
  Lauf grün, funktioniert der Schlüssel. Diese Aktion ändert nichts: Google
  prüft die Änderung, und sie wird verworfen.

Ohne den Schlüssel geht alles weiter von Hand; nichts hängt daran fest.

---

## 10 · Neuen Store-Eintrag veröffentlichen

**1.7.0 ist bei 100 %, die Bilder hast du am 16.11. in allen vier Sprachen
ersetzt.** Ob Titel, Kurzbeschreibung, Beschreibung, Feature-Grafik und
Alt-Texte schon die neuen sind, weiß ich nicht — falls nicht, gilt der Rest
dieses Schritts. Die alten Bilder 5-skins, 6-daily, 7-puzzle müssen dabei
weg sein.

**Was neu ist** (alles liegt im Repo, von Tests geprüft):

| | Englisch, Deutsch, Spanisch (Lateinamerika), Portugiesisch (Brasilien) |
|---|---|
| Titel | „Qubble: Block Puzzle Offline" (es: „Qubble: Puzzle de Bloques", pt: „Qubble: Jogo de Blocos Offline") |
| Kurzbeschreibung | ein Satz: Block-Puzzle mit einem Haustier, das schlüpft und mit jeder Reihe wächst |
| Beschreibung | neu, mit Abschnitt über die Qubbies; jede Zahl kommt aus dem Code; Überschriften in normaler Schreibung, keine Aufzählungszeichen |
| 8 Screenshots | 1 Qubbie fliegt über die Reihe · 2 Reihe platzt · 3 der Qubbies-Bildschirm · 4 Designs · 5 Combo · 6 Quests & Erfolge · 7 Daily · 8 keine Zwangswerbung (neu verteilt 16.11.; die alten Bilder 5-skins, 6-daily, 7-puzzle in der Console löschen) |
| Feature-Grafik | Brett mit drei Qubbies auf Violett, „Ein Haustier auf deinem Brett." |
| Alt-Texte | je Grafik ein Satz für Screenreader: `store-assets/listing/<Code>/alt_texts.txt` |

**Am 15.11. an Googles eigenen Seiten nachgeprüft** (bis dahin kannte ich nur
Suchauszüge) und nachgebessert: Bildtexte nehmen höchstens 11 % der Fläche
ein (Google: höchstens 20 %), kein „neu" mehr in einem Bildtext, Bild 3 ist
ein echter Bildschirm, die Feature-Grafik ist nicht mehr dunkel, die
Beschreibung hat keine Versalien und keine Wortliste mehr. Was davon Pflicht
ist und was nur Empfehlung, steht mit Wortlaut in `docs/STORE-LISTING.md`.

**Sieh dir die Bilder an, bevor sie live gehen** (`store-assets/en/`,
`de/`, `es/`, `pt/`). Sie sind verspielter als die alten. Die App richtet
sich nicht an Kinder; wirkt der Eintrag trotzdem so, darf Google die App
ablehnen — Wortlaut: „If your app is not primarily designed for children
under 13 but your listing contains marketing elements that suggest otherwise
(such as youthful animation or young characters in the graphic assets),
Google Play may reject your app." Dann müssten die Bilder geändert werden
oder die Zielgruppe auf Kinder — mit den Familien-Regeln
(`docs/HAUSTIERE.md` §8.1). Ich habe das Brett in jedem Spielbild groß
gelassen und die Texte sachlich gehalten — ob es reicht, entscheidet Google,
und ob du das Risiko willst, du. **Das ist das einzige Risiko am neuen
Eintrag, das ich nicht durch einen Test ausschließen kann.**

**Mit dem Workflow** (nach Schritt 9): „Play Store" starten.

1. Aktion `check-listing` — ändert nichts, zeigt nur, ob Google die Texte
   und Bilder annimmt.
2. Aktion `publish-listing` — veröffentlicht.
   - „Spanish (Spain)" anhaken, wenn Spanien denselben spanischen Eintrag
     bekommen soll.
   - „other_images": Die übrigen Sprachen tragen noch die Bilder vom
     September („Acht Themes" …). `remove` nimmt sie dort weg; Play zeigt
     dann die englischen (Google: „If you add text translations without
     localized graphic assets, your app's graphic assets show from the
     default language"). `keep` lässt sie stehen.
   - „ai_state": siehe Schritt 12.

Der Workflow fasst **nicht** an: das App-Symbol, den Promo-Video-Link, die
Texte der übrigen Sprachen — und die **Alt-Texte**: Für sie hat Googles
Schnittstelle kein Feld.

**Alt-Texte von Hand:** Google empfiehlt zu jeder Grafik einen Alt-Text (für
Screenreader, höchstens 140 Zeichen). Sie stehen fertig in
`store-assets/listing/<Code>/alt_texts.txt`, eine Zeile je Bild. Wo die
Console das Feld zeigt, weiß ich nicht; wenn du es beim Bild nicht findest:
Screenshot an mich. Keine Pflicht — der Eintrag geht auch ohne live.

**Die übrigen Sprachen:** Dort stehen noch die Texte vom 28.09. — mit „11
Themes" und ohne Haustiere. Lass sie von der Console neu übersetzen, wie du
es vorhast. Sollen die alten Einträge stattdessen ganz weg, damit Play selbst
übersetzt: Sag es, die Schnittstelle kann das, ich baue es dann ein.

**Von Hand** geht es weiter wie bisher: Dateien in `store-assets/listing/<Code>/`
und `store-assets/<Sprache>/`, Tabelle unter „Store-Sprachen".

---

## 11 · Zahlen festhalten

Einmal **jetzt** — bevor 1.6.0 und der neue Eintrag etwas ändern — und dann
alle zwei Wochen. Ein Screenshot der jeweiligen Seite genügt; schick ihn mir.

| Zahl | Woher |
|---|---|
| Besucher des Store-Eintrags und Installationen je Tag, je Land | Play Console |
| Umwandlung Besucher → Installation | Play Console |
| Bindung an Tag 1, 7, 30 | Play Console oder Firebase |
| Deinstallationen | Play Console |
| Bewertungen: Zahl und Schnitt | Play Console |
| Abstürze, ANRs | Android Vitals |
| Ereignisse `round_complete`, `onboarding_step`, `rewarded_*` je Tag (ab 1.6.0 auch `pet_egg`, `pet_hatched`) | Firebase |
| Impressionen und Erlös je Land und Anzeigenblock | AdMob |

Ohne diese Zahlen weiß niemand, ob die Änderungen vom November wirken. Was
damit geschieht, steht in `docs/WACHSTUM.md`.

---

## 12 · Entscheidungen

Nichts davon hält 1.6.0 auf. Ein Satz von dir genügt jeweils.

| Frage | Stand | Was ich empfehle |
|---|---|---|
| **Haustiere:** Namen (Kiki, Bit, Glim, Frosti, Optik, Zapp, Funki, Prisma, Pyra) und Preise (300 / 600 / 900 / 1.500 💎) | gebaut nach dem Konzept, weil du „weiter" gesagt hast | so lassen und messen |
| **Haustiere, zweiter Teil:** Laune, Futter, Tagesgeschenk, Kaufangebote für echtes Geld, zwei neue Bonus-Videos, Event zum Start | nicht gebaut; Entscheidungen in `MASTERPLAN.md` Phase 8 | erst die Zahlen aus Schritt 11 ansehen |
| **Symbol mit Qubbie** (`store-assets/icon-variant/qubbie-app-icon-512.png`) | Kandidat, nicht ausgeliefert | als Store-Experiment gegen das heutige Symbol testen, nicht einfach tauschen: Bei einem Symbol ist das Risiko „wirkt wie Kinder-App" am größten |
| **Titel** „Qubble: Block Puzzle Offline" | steht in den Dateien | so veröffentlichen; „Offline" ist ein Suchwort und stimmt |
| **KI-Angabe für die Bilder** | Seit dem Hochladen am 16.11. zeigt Play auf **jedem** Store-Bild das Label „AI" (20.11. auf der öffentlichen Seite gesehen). Google (17262077): Die Angabe ist eine Selbstauskunft je Bild, „Regulations require that AI-generated content be labeled under certain circumstances"; erklärte Bilder werden im Store gekennzeichnet; das Häkchen lässt sich im Asset-Bereich wieder entfernen. Die Bilder sind Aufnahmen der echten App, zusammengesetzt von einem Programm; Aufbau, Texte und das Programm stammen von mir, einer KI | Das ist deine Erklärung, nicht meine. Nach meinem Verständnis ist kein Bild von einem Bildgenerator erzeugt. Ob das Label Besucher abschreckt, ist nicht belegt. Der Workflow sendet ohne deine Wahl **keine** Angabe (`unset`) |
| **Bezahlte Werbung** | zurückgestellt; seit 20.11. dringend mehr Nutzer gewünscht | Sie ist das Einzige, was sicher Installationen bringt; was eine kostet, sind nur Branchenschätzungen (`docs/WACHSTUM.md` §2), was ein Spieler einbringt, weiß niemand. Wenn du es willst: kleines Tagesbudget, eine Woche, ein Land, dann messen (`docs/WACHSTUM.md` §1a). Sonst erst Schritt 14 |

---

## Später: iOS (App Store)

Erst relevant, wenn Qubble in den App Store soll. Nötig: Apple Developer
Program, ein Mac für `flutter build ipa`, die iOS-App in AdMob und Firebase.
Offene Platzhalter im Code: `REPLACE_ME_REWARDED_IOS`
(`lib/monetization/ad_config.dart`), `REPLACE_ME_FIREBASE_IOS_APP_ID`
(`lib/services/firebase_config.dart`) und die AdMob-App-ID in
`ios/Runner/Info.plist` (steht noch auf Googles Test-ID). Die `GoogleService-Info.plist` darf
**nie** ins Repo.

---

## Erledigt: nichts zu tun

| Was | Wann |
|---|---|
| **Release 1.7.0 (Code 19, Lauf #42) bei 100 %**; Store-Bilder in en/de/es/pt ersetzt | 16.11. |
| Konten: Play Console, AdMob, Firebase | Juli |
| Firebase: Analytics, Crashlytics, anonyme Anmeldung, Firestore-Bestenliste; Regeln veröffentlicht und gegen `firebase/firestore.rules` geprüft | 22.07. / 03.09. |
| Firestore-Regeln für eindeutige Namen und Rätsel-Bestenliste veröffentlicht (Stand PR #60) | 29.09. |
| Firestore-Regeln mit Umlaut-Namen veröffentlicht, PR #61 gemergt | 30.09. |
| Firestore-Regeln mit der Tages-Bestenliste veröffentlicht (live geprüft) | 02.10. |
| Store-Beschreibung EN/DE ohne Konkurrenz-Absatz eingetragen | 02.10. |
| Zwei Anzeigenblöcke `Qubble – Gratis-Gold` und `Qubble – Gratis-Diamanten`, IDs im Code (Tabelle unten) | 02.10. |
| Entschieden: kein eigenes Release 1.4.0, alles kommt mit 1.5.0 | 02.10. |
| **Release 1.5.0 (Code 12)** hochgeladen; Halloween-Event (Promotional content) eingereicht | 02.10. |
| **1.5.0 live** | 02.10. |
| Impressum und Datenschutzerklärung mit vollem Namen (Sam Däubler, Geschäftsbezeichnung Thinkube) | 26.10. |
| Rechtliche Prüfung: Datenschutzerklärung neu (Deutsch + Englisch), Impressum mit DSA-Kontaktstelle; App-Korrekturen kommen mit 1.5.3 (`audit/09-recht.md`) | 28.10. |
| Telefonnummer im Impressum, nur dort (Qubble und Feierabend Rechner) | 10.11. |
| Entschieden: Teilen nach neuem Bestwert (gebaut); Google Ads erst, wenn messbar; Store-Experimente später; Sparschwein bleibt; Neon 150 💎; Münzpakete behalten und messen; keine Tablet-Screenshots vorerst; Play Games Services jetzt | 02.10. |
| Entschieden: Konkurrenz-Absatz raus; Web-Version ohne Priorität, also kein „App holen“-Hinweis im Web | 29.09. |
| Entschieden: Teilen-Link zeigt ab 1.5.0 auf den Play-Store-Eintrag statt auf die Web-Version | 30.09. |
| Signing-Schlüssel in den GitHub-Secrets, CI baut und signiert das Bundle (`docs/BUILD-CI.md`) | Juli |
| Datenschutzerklärung und Impressum online (`web/privacy.html`, `web/impressum.html`) | Juli |
| Geschlossener Test und Produktionszugriff | bis 17.09. |
| Alle Formulare unter App-Inhalte, Altersfreigabe (IARC) eingereicht | 02.09. / 17.09. |
| Datensicherheit; die abgegebenen Antworten mit Fundstelle im Code stehen in `docs/DATA-SAFETY.md` | September |
| `app-ads.txt` (Repo `f6vp76ctbb-stack.github.io`) und die Website im Store-Eintrag; von AdMob bestätigt | 17.09. / bestätigt bis 28.09. |
| **Release 1.2.0 (Code 9) in der Produktion, 100 %, alle Länder** | bis 28.09. |
| Marken- und Namensprüfung „Qubble"/„Thinkube" | bis 28.09. |
| **Alle zehn In-App-Produkte angelegt** (Tabelle unten) | 28.09. |
| **DSGVO-Einwilligungsmeldung in AdMob** | 28.09. |
| **Sechs Anzeigenblöcke, einer pro Bonus**, IDs im Code (Tabelle unten); wirken ab Release 1.3.0 | 28.09. |
| **Release 1.3.0 (Code 10)** in der Produktion: 56 Sprachen, Erfolgs-Belohnungen, ein Anzeigenblock pro Bonus | 28.09. |
| **Store-Eintrag in allen Sprachen** (60 Einträge von Hand; seit 13.11. werden nur noch vier gepflegt) | 28.09. |

**Nicht anfassen:** Signing-Schlüssel, Firestore-Regeln, Altersfreigabe,
Datensicherheit. Die Datensicherheit ändert sich nur, wenn sich ändert, welche
Daten die App sendet. Dann passe ich `docs/DATA-SAFETY.md` an und sage dir,
welche Zeile im Formular sich ändert.

## Store-Sprachen (seit 13.11. vier von Hand)

Von Hand gepflegt — Texte, Bilder und „Was ist neu" — werden nur noch vier
Einträge (deine Entscheidung vom 09.11.). Alle anderen übersetzt du in der
Console automatisch; für sie gibt es im Repo keine Dateien mehr.

| Sprache | Play-Code | Texte `store-assets/listing/…` | Bilder `store-assets/…` | „Was ist neu" `docs/release-notes/<version>-…` |
|---|---|---|---|---|
| Englisch (USA), Standardsprache | `en-US` | `en-US/` | `en/` | `en.txt` |
| Deutsch | `de-DE` | `de-DE/` | `de/` | `de.txt` |
| Spanisch (Lateinamerika) | `es-419` | `es-419/` | `es/` | `es.txt` |
| Portugiesisch (Brasilien) | `pt-BR` | `pt-BR/` | `pt/` | `pt.txt` |

Texte: `title.txt`, `short_description.txt`, `full_description.txt`, dazu
`alt_texts.txt` (ein Satz je Grafik, Schritt 10). Bilder:
`screenshot-1-qubbie.png` … `screenshot-8-offline.png` und
`feature-graphic-1024x500.png`. Spanisch (Spanien, `es-ES`) kann denselben
spanischen Eintrag bekommen (Workflow, Häkchen „Spanish (Spain)").

Die 56 weiteren Einträge vom 28.09. stehen noch in der Console, mit dem Text
von damals. Was damit geschieht: Schritt 10.

## Anzeigenblöcke (angelegt 28.09. und 02.10.)

Alle im Format **„Mit Prämie"**. Die IDs stehen in
`lib/monetization/ad_config.dart`; `test/monetization/ad_config_test.dart`
prüft, dass jeder Bonus seinen eigenen Block nutzt und alle zur App-ID im
Manifest gehören.

| Name in AdMob | Bonus in der App | Block-ID |
|---|---|---|
| `Qubble – Münzen verdoppeln` | Münzen verdoppeln (Rundenende) | `…/2059719876` |
| `Qubble – Tagesbelohnung verdoppeln` | Tagesbelohnung verdoppeln | `…/9586681095` |
| `Qubble – Lucky Block` | Lucky Block (neue Teile) | `…/7120474864` |
| `Qubble – Sparschwein` | Sparschwein früher öffnen | `…/7767342121` |
| `Qubble – Streak-Reparatur` | Streak reparieren | `…/1201933775` |
| `Qubble – Rätsel-Extrazug` | Rätsel: Extra-Zug | `…/5638114643` |
| `Rewarded test` (Umbenennen empfohlen, siehe Schritt 5) | **alle** Boni in 1.2.0; ab 1.3.0 Ersatz, wenn das Video eines Bonus nicht rechtzeitig geladen ist | `…/4303264559` |
| `Qubble – Gratis-Gold` | Shop: 3× täglich 500 Gold (ab 1.5.0; bis 1.5.1 je 100) | `…/3859493490` |
| `Qubble – Gratis-Diamanten` | Shop: 3× täglich 6 💎 (ab 1.5.0; bis 1.5.1 je 3) | `…/4210847288` |
| `Qubble – Rätsel-Hinweis` (**noch anlegen**, Schritt 8) | Rätsel: Hinweis, beliebig oft (ab 1.6.0) | bis dahin über `Rewarded test` |

**`Rewarded test` nicht löschen.** Ab 1.3.0 springt er ein, wenn der eigene
Block eines Bonus noch nichts geladen hat, und wer noch 1.2.0 hat, lädt alle
Bonus-Videos über ihn. Ohne ihn gäbe es dort kein einziges Bonus-Video mehr.
Der Name ist nur ein Etikett.

**Warum er im Bericht vom 02.10. fast alles hatte:** In 1.3.0 bis 1.5.0
lädt „Münzen verdoppeln" sein eigenes Video erst, wenn die Karte am
Rundenende erscheint. Wer sofort tippt, bekommt den Ersatz. Und Sparschwein
und Streak-Reparatur fragten ihr Video beim App-Start an, bevor die
Einwilligungsabfrage fertig war; diese Anfrage ging verloren, sie liefen die
ganze Sitzung über den Ersatz. Ab dem nächsten Release: „Münzen verdoppeln"
lädt beim Rundenstart, „Tagesbelohnung verdoppeln" beim Daily-Start, und
frühe Anfragen werden nach der Einwilligung nachgeholt. Den Ersatz gibt es
dann nur noch, wenn jemand in den ersten Sekunden nach dem Erscheinen eines
Angebots tippt oder das eigene Video nicht lädt — plus alle, die noch eine
ältere Version haben. Videos, die älter als 55 Minuten sind, lädt die App neu
(laut Google laufen sie nach etwa einer Stunde ab).

**Für einen neuen Block:** Format **„Mit Prämie"**.

> **Nie wählen:** „Interstitial mit Prämie", „Interstitial", „Banner",
> „App-Start" und „Erweiterte native Anzeigen". Alle fünf zeigen Werbung, ohne
> dass der Spieler darum gebeten hat. Beim „Interstitial mit Prämie" sagt das
> AdMob selbst: Im Gegensatz zu „Mit Prämie" wird es automatisch ausgeliefert,
> der Nutzer muss nicht zustimmen. Das ist in Qubble ausgeschlossen
> (`MASTERPLAN.md` §2: „AdMob — NUR Rewarded, alle freiwillig"), und die
> Store-Beschreibung verspricht in allen Sprachen „No interstitials. No
> banners." und dass Videos nur laufen, wenn der Spieler selbst tippt. Die
> App lädt nur Anzeigen mit
> Prämie, die der Spieler selbst antippt (`RewardedAd` in
> `lib/monetization/ads.dart`); ein Block in einem anderen Format bliebe
> ohnehin ungenutzt. Den Vorschlag „Strategie für Anzeigen mit Prämie
> optimieren" in AdMob ignorieren.

**Die Felder** (nach dem Formular „Mit Prämie", Stand 28.09.):

| Feld | Wert | Warum |
|---|---|---|
| Name des Anzeigenblocks | aus der Tabelle | nur für dich in AdMob, der Spieler sieht ihn nie |
| Gebote von Partnern („Ich verwende diesen Anzeigenblock für Echtzeitgebote auf einer anderen Vermittlungsplattform") | **nicht** anhaken | Qubble nutzt nur AdMob. Angehakt wäre der Block laut Formular von AdMob-Vermittlung und Google-Ads-Nachfrage ausgeschlossen, und **das lässt sich nachher nicht mehr ändern** |
| Prämienbetrag | `1` | Die App wertet nur aus, **ob** die Prämie verdient wurde, nicht Betrag oder Artikel (`onUserEarnedReward` in `lib/monetization/ads.dart`). Die Belohnung legt der Code fest |
| Prämienartikel | `Bonus` | wie oben |
| Anzeigentyp: Video | **an** | |
| Anzeigentyp: Interaktiv | **an** | mehr mögliche Anzeigen, also seltener „Gerade ist kein Video verfügbar", nachdem der Spieler getippt hat |
| Anzeigentyp: Anzeigen-Pods | **aus** (Empfehlung) | Ein Pod sind laut Googles Hilfe **zwei Videos direkt hintereinander** für eine Prämie; standardmäßig an, Abschalten kann Umsatz kosten. Die App verspricht aber „ein Bonus-Video". Ein zweites, unangekündigtes Video ist genau der Ärger, den Qubble vermeiden will. Deine Entscheidung; ich würde es ausschalten |
| Serverseitige Überprüfung | **aus** lassen | braucht einen eigenen Server, der die Prämie bestätigt. Qubble hat keinen, die Belohnung vergibt die App |
| Frequency Capping | **Deaktiviert** lassen | Wie oft ein Bonus angeboten wird, begrenzt die App selbst (z. B. Münzen verdoppeln einmal pro Runde, Streak-Reparatur höchstens alle 7 Tage). Eine Obergrenze in AdMob führt nur dazu, dass ein Spieler, der das Video **will**, keins bekommt |
| eCPM-Mindestbetrag | **Von Google optimiert** | einen Mindestbetrag von Hand festzulegen wäre geraten, solange es kaum Daten gibt |
| Methode | **Alle Preise** | „Ausführungsrate wird bei jedem Preispunkt maximiert": Der Spieler hat um das Video gebeten, ein leerer Abruf enttäuscht ihn und bringt nichts ein. „Hoher/Mittlerer Mindestbetrag" (Beta) tauscht Ausführungsrate gegen Preis; das lohnt erst bei mehr Zugriffen |

## In-App-Produkte (angelegt 28.09.)

Nachschlag für Änderungen und neue Produkte. Die IDs sind im Code fest verdrahtet (`lib/monetization/iap.dart`). Ein
Tippfehler heißt: Das Produkt existiert, die App findet es nie.

| Produkt-ID | Typ | EUR (inkl. MwSt.) | USD | Name | Beschreibung |
|---|---|---|---|---|---|
| `qubble_supporter` | Nicht-Verbrauchsartikel | 4,99 € | 4.99 $ | `Unterstützer-Paket` | `Danke-Paket: exklusives Aurora-Theme, exklusiver Kristall-Skin, 1500 Münzen und ein Abzeichen neben deinem Namen. Einmalig, bleibt dauerhaft.` |
| `qubble_starter` | Verbrauchsartikel | 1,99 € | 1.99 $ | `Starter-Paket` | `1200 Münzen und das Wood-Theme. Einmaliges Angebot ab der fünften Runde, 48 Stunden gültig.` |
| `qubble_coins_s` | Verbrauchsartikel | 0,99 € | 0.99 $ | `500 Münzen` | `500 Münzen für Booster, Themes und Skins.` |
| `qubble_coins_m` | Verbrauchsartikel | 2,99 € | 2.99 $ | `2000 Münzen` | `2000 Münzen für Booster, Themes und Skins.` |
| `qubble_coins_l` | Verbrauchsartikel | 7,99 € | 7.99 $ | `6000 Münzen` | `6000 Münzen für Booster, Themes und Skins.` |
| `qubble_rename` | Verbrauchsartikel | 1,49 € | 1.49 $ | `Namensänderung` | `Ändere deinen Namen in der Bestenliste einmal. Rein kosmetisch, kein Spielvorteil.` |
| `qubble_neon_theme` | Nicht-Verbrauchsartikel | 2,49 € | 2.49 $ | `Neon-Theme` | `Schaltet das Neon-Theme dauerhaft frei: schwarzes Brett, leuchtend grüne, cyanfarbene und pinke Blöcke.` |
| `qubble_diamonds_s` | Verbrauchsartikel | 0,99 € | 0.99 $ | `100 Diamanten` | `100 Diamanten für Premium-Skins, -Themes und mehr.` |
| `qubble_diamonds_m` | Verbrauchsartikel | 2,99 € | 2.99 $ | `350 Diamanten` | `350 Diamanten für Premium-Skins, -Themes und mehr. Günstiger pro Diamant als das kleine Paket.` |
| `qubble_diamonds_l` | Verbrauchsartikel | 7,99 € | 7.99 $ | `1000 Diamanten` | `1000 Diamanten für Premium-Skins, -Themes und mehr. Günstigster Preis pro Diamant.` |

`test/store_products_test.dart` hält diese Tabelle und den Code zusammen: Ein
Produkt, das nur auf einer Seite steht, lässt den Test fehlschlagen.

**Preise sind Bruttopreise:** Der Käufer in Deutschland zahlt genau den
EUR-Betrag, die MwSt. ist darin. Laut Katalog-Prüfung vom 28.10. lagen alle
zehn um die 19 % darüber (z. B. 5,99 € statt 4,99 €); Korrektur in Schritt 7.
Die Diamant-Pakete versprechen den günstigeren bzw. günstigsten Preis pro
Diamant, und die App schreibt „Bestes Verhältnis" an beide großen Pakete: Das
muss in **jedem** Land stimmen.

**Englisch (en-US, dazu en-AU und en-GB)** für die drei Diamant-Pakete; die
übrigen englischen Texte sind laut Prüfung in Ordnung:

| Produkt-ID | Name | Beschreibung |
|---|---|---|
| `qubble_diamonds_s` | `100 Diamonds` | `100 diamonds for premium skins, themes and more.` |
| `qubble_diamonds_m` | `350 Diamonds` | `350 diamonds for premium skins, themes and more. Cheaper per diamond than the small pack.` |
| `qubble_diamonds_l` | `1000 Diamonds` | `1000 diamonds for premium skins, themes and more. Lowest price per diamond.` |

**Die Felder des Formulars** (nach dem Formular, das du mir
geschickt hast):

| Feld | Wert |
|---|---|
| Produkt-ID | aus der Tabelle, **exakt**. Nach dem Anlegen nicht mehr änderbar |
| Name (max. 55) / Beschreibung (max. 200) | aus der Tabelle |
| Symbol | `store-assets/product-icons/<produkt-id>.png` (512×512, ohne Text, wie das Formular es verlangt) |
| Tags | leer lassen |
| Produktsteuerkategorie | **Verkäufe digitaler Apps** |
| Altersfreigabe | leer lassen |
| Beschränkungen des Zahlungsortes | keine (Voreinstellung lassen) |
| Kaufoptions-ID | angelegt ist jeweils die Produkt-ID mit Bindestrichen (z. B. `qubble-coins-s`), nicht `standard`. Egal: Die App fragt nach der Produkt-ID, nicht nach dieser. **Nicht ändern** |
| Kauftyp | **Kaufen** |
| Verfügbarkeit | **alle Regionen** |
| Preis | **Bruttopreis** aus der Tabelle (Käufer in Deutschland zahlt genau diesen Betrag, inkl. MwSt.), in allen Euro-Ländern derselbe; USA mit derselben Ziffer in USD (1,99 € → 1.99 $); alle anderen Länder aus dem Euro-Preis umgerechnet und lokal gerundet |

**Verbrauchsartikel ist keine Formsache.** Nur `qubble_supporter` und
`qubble_neon_theme` sind dauerhaft. Ein dauerhafter Inhalt als
Verbrauchsartikel könnte doppelt abgerechnet werden; ein Münzpaket als
Nicht-Verbrauchsartikel wäre nur einmal kaufbar.

**Gegenprobe:** Der Shop in der App muss alle zehn Angebote **mit Preis**
zeigen. Fehlt eines, ist es inaktiv oder seine ID stimmt nicht.

## Zum Nachschlagen (keine Anleitungen)

| Datei | Inhalt |
|---|---|
| `docs/DATA-SAFETY.md` | die Datensicherheits-Erklärung, Zeile für Zeile mit Fundstelle im Code |
| `docs/STORE-LISTING.md` | was in einer Store-Beschreibung stehen darf, und wo die Texte liegen |
| `docs/STORE-SCREENSHOTS.md`, `store-assets/README.md` | wie die Store-Bilder entstehen |
| `docs/BUILD-CI.md` | wie GitHub das Bundle baut und signiert |
| `docs/WACHSTUM.md` | der Plan Richtung Top 100: Stufen, Tore, was automatisch läuft |
| `docs/HAUSTIERE.md` | das Haustier-Konzept und was davon gebaut ist |
| `audit/10-relaunch.md` | warum wenige installierten und wenige blieben (Befunde vom November) |
| `docs/archiv/PRODUCTION-ACCESS.md` | die Antworten, die Google beim Antrag auf Produktionszugriff bekommen hat |
