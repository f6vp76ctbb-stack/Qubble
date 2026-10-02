# Anleitung: was du noch tun musst

Stand **02.10.2026** · App **Qubble** · `com.thinkube.qubble`

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
| 1 | [1.5.1 hochladen](#1--151-hochladen-werbe-fix) | Werbe-Fix: getrennte Auswertung pro Bonus, keine abgelaufenen Videos | du |
| 2 | [Play Games Services einrichten](#2--play-games-services-einrichten) | App ist vorbereitet; fehlen nur Erfolge, Bestenlisten und ihre IDs | du → ich trage IDs ein |
| 3 | [Gameplay-Video](#3--gameplay-video) | Promo-Video im Store, Clips für Shorts | du |
| 4 | [Steuerdaten](#4--steuerdaten) | Sobald Google Geld auszahlen soll | du |
| 5 | [AdMob: dein Handy als Testgerät](#5--admob-dein-handy-als-testgerät) | Der Bericht vom 02.10. sieht nach eigenen Klicks aus; das kann das Konto kosten | du |

---

## 1 · 1.5.1 hochladen (Werbe-Fix)

1.5.0 (Code 12) ist live, das Halloween-Event eingereicht. 1.5.1 (Code 13)
ist der Fix hinterher:

- Jeder Bonus nutzt seinen eigenen Anzeigenblock, sodass AdMob
  „Münzen verdoppeln", „Sparschwein" usw. getrennt zeigt.
- Abgelaufene Videos werden ersetzt; sonst kam nach langer Pause „kein
  Video".
- Neuer Bestwert lässt sich teilen.
- Neon kostet 150 💎.

Play Games ist darin **ausgeschaltet** (`play_games.xml`), deshalb bleibt die
Datensicherheit unverändert.

- **AAB:** Artefakt `qubble-release-aab-PRODUCTION-ads` aus dem Lauf, den ich
  dir nenne. Nur die Datei mit `PRODUCTION-ads` im Namen hochladen.
- **„Was ist neu":** Die Texte für alle Sprachen schicke ich dir als Datei
  (`<de-DE>…</de-DE>`-Blöcke zum Einfügen). Russisch hat keine App-Übersetzung
  und bekommt die englischen Notizen; meldet die Console `ru-RU` als
  unbekannt, den Block löschen.
- **Rollout:** mit 20 % starten. Nach einem Tag Android Vitals und
  Crashlytics ansehen, dann **100 %**. Bei Abstürzen anhalten (nicht
  zurückziehen) und mir den Stacktrace schicken.
- **Halloween:** „Was ist neu" nennt das Event; nach dem 31.10. nehme ich die
  Zeile für das nächste Release heraus.

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
   - **Zuerst die Sprachen hinzufügen.** Laut Google geht der Import mit
     Übersetzungen nur für Sprachen, die das Spielprojekt schon hat. Danach
     lassen sich Übersetzungen nicht mehr gesammelt nachladen, nur noch
     einzeln. Google nennt den Weg „Edit properties → Manage translations →
     Manage your own translations": dort mehrere Sprachen auf einmal wählen,
     dann „Apply". Diese 59 Codes, also alle Store-Sprachen außer en-US:

     `de-DE es-419 es-ES pt-BR pt-PT fr-FR it-IT tr-TR id vi pl-PL nl-NL uk
     ms ro cs-CZ hu-HU sv-SE af bs mk-MK sq kk ne-NP mr-IN bn-BD pa ml-IN
     kn-IN gu te-IN ta-IN sr sl lv et lt az-AZ uz sw ca ur fil iw-IL hr bg
     fi-FI no-NO da-DK el-GR sk ja-JP ko-KR th zh-CN zh-TW zh-HK ar hi-IN`

     Verlangt die Console danach pro Sprache eigene Pflichtfelder (Name,
     Beschreibung, Grafiken): Screenshot schicken. Store-Texte und Grafiken
     gibt es für jede dieser Sprachen schon.
   - **Dann importieren:** `store-assets/play-games/qubble-achievements-import.zip`
     hochladen (Google: „Import achievements" → „Upload"), danach „Save as
     draft".
   - Inhalt: Namen und Beschreibungen sind die Texte der App, in allen 59
     Sprachen, mit Icons. Alle Erfolge sind sichtbar. Zusammen 680 Punkte
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
   dazukommen. Die Datenschutzerklärung ist schon ergänzt.

---

## 3 · Gameplay-Video

- `store-assets/video/qubble-gameplay.mp4` (25 s, hochkant, mit Ton) auf
  YouTube hochladen und den Link im Store-Eintrag als Promo-Video eintragen.
- Dasselbe und `qubble-neon.mp4`, `qubble-ocean.mp4`, `qubble-sunset.mp4` als
  Shorts/Reels/TikTok posten, z. B. eins pro Woche.

---

## 4 · Steuerdaten

Keine Steuerberatung, nur der Stand aus Juli:

- Gewerbe anmelden, **sobald real Geld ausgezahlt werden soll** (Gewerbeamt,
  auch rückwirkend möglich). Im Fragebogen vom Finanzamt die
  **Kleinunternehmerregelung (§ 19 UStG)** wählen.
- Danach Steuernummer bzw. USt-IdNr. (vom BZSt, wegen Reverse-Charge bei
  AdMob) in die Zahlungsprofile von Google eintragen, ohne sie gibt es keine
  Auszahlung.
- Im Zweifel kurz Finanzamt oder Steuerberater fragen.

---

## 5 · AdMob: dein Handy als Testgerät

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
| **Store-Eintrag in allen Sprachen** (Tabelle unten) | 28.09. |

**Nicht anfassen:** Signing-Schlüssel, Firestore-Regeln, Altersfreigabe,
Datensicherheit. Die Datensicherheit ändert sich nur, wenn sich ändert, welche
Daten die App sendet. Dann passe ich `docs/DATA-SAFETY.md` an und sage dir,
welche Zeile im Formular sich ändert.

## Store-Sprachen (angelegt 28.09.)

Welche Dateien zu welcher Play-Sprache gehören, z. B. für neue Screenshots
oder „Was ist neu“. Texte: `title.txt`, `short_description.txt`,
`full_description.txt`; Bilder: `screenshot-1-clear.png` …
`screenshot-6-offline.png` und `feature-graphic-1024x500.png`. Englisch und
Deutsch liegen in `listing/en-US/` bzw. `de-DE/` und `store-assets/en/` bzw.
`de/`.

| Sprache | Play-Code | Texte `store-assets/listing/…` | Bilder `store-assets/…` | „Was ist neu" `docs/release-notes/<version>-…` |
|---|---|---|---|---|
| Afrikaans | `af` | `af/` | `af/` | `af.txt` |
| Albanisch | `sq` | `sq/` | `sq/` | `sq.txt` |
| Arabisch | `ar` | `ar/` | `ar/` | `ar.txt` |
| Aserbaidschanisch | `az-AZ` | `az-AZ/` | `az/` | `az.txt` |
| Bengalisch | `bn-BD` | `bn-BD/` | `bn/` | `bn.txt` |
| Bosnisch | `bs` | `bs/` | `bs/` | `bs.txt` |
| Bulgarisch | `bg` | `bg/` | `bg/` | `bg.txt` |
| Chinesisch traditionell (Hongkong) | `zh-HK` | `zh-TW/` | `zh_Hant/` | `zh_Hant.txt` |
| Chinesisch traditionell (Taiwan) | `zh-TW` | `zh-TW/` | `zh_Hant/` | `zh_Hant.txt` |
| Chinesisch vereinfacht | `zh-CN` | `zh-CN/` | `zh/` | `zh.txt` |
| Dänisch | `da-DK` | `da-DK/` | `da/` | `da.txt` |
| Estnisch | `et` | `et/` | `et/` | `et.txt` |
| Filipino | `fil` | `fil/` | `fil/` | `fil.txt` |
| Finnisch | `fi-FI` | `fi-FI/` | `fi/` | `fi.txt` |
| Französisch | `fr-FR` | `fr-FR/` | `fr/` | `fr.txt` |
| Griechisch | `el-GR` | `el-GR/` | `el/` | `el.txt` |
| Gujarati | `gu` | `gu/` | `gu/` | `gu.txt` |
| Hebräisch | `iw-IL` | `iw-IL/` | `he/` | `he.txt` |
| Hindi | `hi-IN` | `hi-IN/` | `hi/` | `hi.txt` |
| Indonesisch | `id` | `id/` | `id/` | `id.txt` |
| Italienisch | `it-IT` | `it-IT/` | `it/` | `it.txt` |
| Japanisch | `ja-JP` | `ja-JP/` | `ja/` | `ja.txt` |
| Kannada | `kn-IN` | `kn-IN/` | `kn/` | `kn.txt` |
| Kasachisch | `kk` | `kk/` | `kk/` | `kk.txt` |
| Katalanisch | `ca` | `ca/` | `ca/` | `ca.txt` |
| Koreanisch | `ko-KR` | `ko-KR/` | `ko/` | `ko.txt` |
| Kroatisch | `hr` | `hr/` | `hr/` | `hr.txt` |
| Lettisch | `lv` | `lv/` | `lv/` | `lv.txt` |
| Litauisch | `lt` | `lt/` | `lt/` | `lt.txt` |
| Malaiisch | `ms` | `ms/` | `ms/` | `ms.txt` |
| Malayalam | `ml-IN` | `ml-IN/` | `ml/` | `ml.txt` |
| Marathi | `mr-IN` | `mr-IN/` | `mr/` | `mr.txt` |
| Mazedonisch | `mk-MK` | `mk-MK/` | `mk/` | `mk.txt` |
| Nepali | `ne-NP` | `ne-NP/` | `ne/` | `ne.txt` |
| Niederländisch | `nl-NL` | `nl-NL/` | `nl/` | `nl.txt` |
| Norwegisch | `no-NO` | `no-NO/` | `nb/` | `nb.txt` |
| Polnisch | `pl-PL` | `pl-PL/` | `pl/` | `pl.txt` |
| Portugiesisch (Brasilien) | `pt-BR` | `pt-BR/` | `pt/` | `pt.txt` |
| Portugiesisch (Portugal) | `pt-PT` | `pt-PT/` | `pt/` | `pt.txt` |
| Punjabi | `pa` | `pa/` | `pa/` | `pa.txt` |
| Rumänisch | `ro` | `ro/` | `ro/` | `ro.txt` |
| Schwedisch | `sv-SE` | `sv-SE/` | `sv/` | `sv.txt` |
| Serbisch | `sr` | `sr/` | `sr/` | `sr.txt` |
| Slowakisch | `sk` | `sk/` | `sk/` | `sk.txt` |
| Slowenisch | `sl` | `sl/` | `sl/` | `sl.txt` |
| Spanisch (Lateinamerika) | `es-419` | `es-419/` | `es/` | `es.txt` |
| Spanisch (Spanien) | `es-ES` | `es-419/` | `es/` | `es.txt` |
| Swahili | `sw` | `sw/` | `sw/` | `sw.txt` |
| Tamil | `ta-IN` | `ta-IN/` | `ta/` | `ta.txt` |
| Telugu | `te-IN` | `te-IN/` | `te/` | `te.txt` |
| Thai | `th` | `th/` | `th/` | `th.txt` |
| Tschechisch | `cs-CZ` | `cs-CZ/` | `cs/` | `cs.txt` |
| Türkisch | `tr-TR` | `tr-TR/` | `tr/` | `tr.txt` |
| Ukrainisch | `uk` | `uk/` | `uk/` | `uk.txt` |
| Ungarisch | `hu-HU` | `hu-HU/` | `hu/` | `hu.txt` |
| Urdu | `ur` | `ur/` | `ur/` | `ur.txt` |
| Usbekisch | `uz` | `uz/` | `uz/` | `uz.txt` |
| Vietnamesisch | `vi` | `vi/` | `vi/` | `vi.txt` |

Spanisch und Chinesisch traditionell gibt es bei Play je zweimal (es-419/es-ES,
zh-TW/zh-HK); beide bekommen dieselben Dateien. Portugiesisch (Portugal) hat
eigene Texte, aber die Bilder und „Was ist neu" von Brasilien.

**Dateiimport in der Console:** schlug am 28.09. ohne Fehlermeldung fehl; das
erwartete Format ist nicht beschrieben. Kann die Console die Texte
exportieren, schick mir den Export, dann baue ich `store-assets/store-listing.csv`
genau so nach.

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
| `Qubble – Gratis-Gold` | Shop: 3× täglich 100 Gold (ab 1.5.0) | `…/3859493490` |
| `Qubble – Gratis-Diamanten` | Shop: 3× täglich 3 💎 (ab 1.5.0) | `…/4210847288` |

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

| Produkt-ID | Typ | EUR | USD | Name | Beschreibung |
|---|---|---|---|---|---|
| `qubble_supporter` | Nicht-Verbrauchsartikel | 4,99 € | 4.99 $ | `Unterstützer-Paket` | `Danke-Paket: exklusives Aurora-Theme, exklusiver Kristall-Skin, 1500 Münzen und ein Abzeichen neben deinem Namen. Einmalig, bleibt dauerhaft.` |
| `qubble_starter` | Verbrauchsartikel | 1,99 € | 1.99 $ | `Starter-Paket` | `1200 Münzen und das Wood-Theme. Einmaliges Angebot ab der fünften Runde, 48 Stunden gültig.` |
| `qubble_coins_s` | Verbrauchsartikel | 0,99 € | 0.99 $ | `500 Münzen` | `500 Münzen für Booster, Themes und Skins.` |
| `qubble_coins_m` | Verbrauchsartikel | 2,99 € | 2.99 $ | `2000 Münzen` | `2000 Münzen für Booster, Themes und Skins.` |
| `qubble_coins_l` | Verbrauchsartikel | 7,99 € | 7.99 $ | `6000 Münzen` | `6000 Münzen für Booster, Themes und Skins.` |
| `qubble_rename` | Verbrauchsartikel | 1,49 € | 1.49 $ | `Namensänderung` | `Ändere deinen Namen in der Bestenliste einmal. Rein kosmetisch, kein Spielvorteil.` |
| `qubble_neon_theme` | Nicht-Verbrauchsartikel | 2,49 € | 2.49 $ | `Neon-Theme` | `Schaltet das Neon-Theme dauerhaft frei: schwarzes Brett, leuchtend grüne und pinke Blöcke.` |
| `qubble_diamonds_s` | Verbrauchsartikel | 0,99 € | 0.99 $ | `100 Diamanten` | `100 Diamanten für Premium-Skins und -Themes.` |
| `qubble_diamonds_m` | Verbrauchsartikel | 2,99 € | 2.99 $ | `350 Diamanten` | `350 Diamanten für Premium-Skins und -Themes. Mehr pro Euro als das kleine Paket.` |
| `qubble_diamonds_l` | Verbrauchsartikel | 7,99 € | 7.99 $ | `1000 Diamanten` | `1000 Diamanten für Premium-Skins und -Themes. Bestes Verhältnis.` |

`test/store_products_test.dart` hält diese Tabelle und den Code zusammen: Ein
Produkt, das nur auf einer Seite steht, lässt den Test fehlschlagen.

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
| Kaufoptions-ID | `standard`, bei allen zehn gleich. Die App fragt nach der Produkt-ID, nicht nach dieser |
| Kauftyp | **Kaufen** |
| Verfügbarkeit | **alle Regionen** |
| Preis | über den Sammel-Dialog „Set prices": alle Länder, ein EUR-Betrag. Danach optional die Dollar-Märkte mit derselben Ziffer in USD (1,99 € → 1.99 $, kein Wechselkurs) |

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
| `docs/STORE-LISTING.md` | Store-Texte EN/DE und was in einer Beschreibung stehen darf |
| `docs/STORE-SCREENSHOTS.md`, `store-assets/README.md` | wie die Store-Bilder entstehen |
| `docs/BUILD-CI.md` | wie GitHub das Bundle baut und signiert |
| `docs/WACHSTUM.md` | was für mehr Downloads gemacht wurde, und weitere Ideen |
| `docs/archiv/PRODUCTION-ACCESS.md` | die Antworten, die Google beim Antrag auf Produktionszugriff bekommen hat |
