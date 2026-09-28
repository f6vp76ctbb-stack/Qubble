# Anleitung: was du noch tun musst

Stand **28.09.2026** · App **Qubble** · `com.thinkube.qubble`

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
| 1 | [Sechs Anzeigenblöcke anlegen](#1--sechs-anzeigenblöcke-einer-pro-bonus) | Einnahmen je Bonus sichtbar machen | du → IDs an mich |
| 2 | [Release 1.3.0 hochladen](#2--release-130-hochladen) | 56 Sprachen und Erfolgs-Belohnungen kommen erst so aufs Handy | du |
| 3 | [Store-Eintrag in 54 weiteren Sprachen](#3--store-eintrag-in-54-weiteren-sprachen) | Wirkt erst, wenn 1.3.0 live ist | du |
| 4 | [Gameplay-Video](#4--gameplay-video) | Promo-Video im Store, Clips für Shorts | du |
| 5 | [Steuerdaten](#5--steuerdaten) | Sobald Google Geld auszahlen soll | du |
| 6 | [Entscheidungen](#6--entscheidungen-die-bei-dir-liegen) | Kein Zeitdruck | du → ich setze um |

---

## 1 · Sechs Anzeigenblöcke, einer pro Bonus

Bisher laufen alle Bonus-Videos über **einen** Block. Mit einem eigenen Block
je Bonus zeigt AdMob, welcher Bonus wie viel einbringt. Der Code dafür ist
fertig (PR #58). Solange ein Block fehlt, nutzt dieser Bonus weiter den alten.
Es bricht also nichts, wenn du sie nacheinander anlegst.

**Sechs Blöcke anlegen**, einen je Bonus. Beim Anlegen fragt AdMob zuerst
nach dem Format: **„Mit Prämie" wählen.** Das ist das Format, bei dem der
Spieler aktiv zustimmt, und das einzige, das Qubble verwendet.

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

| Bonus in der App | Name des Anzeigenblocks | Eintrag im Code |
|---|---|---|
| Münzen verdoppeln (Rundenende) | `Qubble – Münzen verdoppeln` | `AdPlacement.doubleCoins` |
| Tagesbelohnung verdoppeln | `Qubble – Tagesbelohnung verdoppeln` | `AdPlacement.dailyDouble` |
| Lucky Block (neue Teile) | `Qubble – Lucky Block` | `AdPlacement.luckyBlock` |
| Sparschwein früher öffnen | `Qubble – Sparschwein` | `AdPlacement.piggy` |
| Streak reparieren | `Qubble – Streak-Reparatur` | `AdPlacement.streakRepair` |
| Rätsel: Extra-Zug | `Qubble – Rätsel-Extrazug` | `AdPlacement.puzzleExtraMove` |

**Die Felder** (nach dem Formular „Mit Prämie", das du mir am 28.09.
geschickt hast):

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

**Dann:** mir die sechs IDs schicken (Form `ca-app-pub-…/…`, je mit Bonus).
Ich trage sie in `lib/monetization/ad_config.dart` ein. Die IDs sind nicht
geheim, sie stehen in jeder ausgelieferten App. Am besten **vor** Schritt 2,
dann sind sie gleich im Release 1.3.0; sonst braucht es dafür ein weiteres
Release.

---

## 2 · Release 1.3.0 hochladen

Inhalt: 56 Sprachen, animierte Skins als Erfolgs-Belohnung, ein Anzeigenblock
pro Bonus, Layout-Korrekturen. Version im Repo: **`1.3.0+10`** (Code 9 ist
durch 1.2.0 verbraucht).

1. **PR #58 mergen**, oder mir sagen, dann merge ich.
2. **Bundle bauen:** Workflow **„Build Android Release (.aab)"** auf `main`
   starten, **`test_ads` auf AUS** (der Schalter steht standardmäßig auf AN =
   Googles Testwerbung, kein Umsatz). Das Artefakt heißt dann
   **`qubble-release-aab-PRODUCTION-ads`**, darin `app-release.aab`. Ein
   Artefakt `…-TEST-ads` gehört nie in die Produktion.
3. **Hochladen in die Produktion.** Die Console muss **1.3.0** und
   **Versionscode 10** anzeigen. Weicht das ab, ist es das falsche Artefakt.
   `mapping.txt` musst du nicht hochladen, sie steckt im Bundle.
4. **„Was ist neu":** Englisch aus `docs/release-notes/1.3.0-en.txt`,
   Deutsch aus `1.3.0-de.txt`. Bietet die Console weitere Sprachen an, die
   passende Datei aus der Tabelle in Schritt 3. Alle unter 500 Zeichen, per
   Test geprüft.
5. **Rollout gestaffelt: erst 20 %.** 1.1.0 hatte 142 Abstürze bei 23 Nutzern
   (R8-Problem, behoben). Bei 20 % kannst du anhalten, bevor alle es haben.
6. **Nach 1–2 Tagen prüfen:** Pre-Launch-Bericht (keine Abstürze beim Start,
   keine ANRs), Android Vitals (Ziel crashfrei > 99,5 %), Firebase
   Crashlytics. Sauber → **100 %**. Bei Abstürzen: Rollout **anhalten** (nicht
   zurückziehen) und mir den Crashlytics-Stacktrace schicken.

---

## 3 · Store-Eintrag in 54 weiteren Sprachen

**Erst wenn 1.3.0 live ist.** Vorher verspräche der Eintrag eine Sprache, die
die App noch nicht spricht.

**Englisch und Deutsch zuerst aktualisieren:** Beide Vollbeschreibungen
nennen jetzt auch die 8 animierten Skins. Neu einfügen aus
`store-assets/listing/en-US/full_description.txt` und `de-DE/`. Nur diese
Dateien verwenden, nicht die Fassungen in `docs/STORE-LISTING.md`, die sind
für den Editor umbrochen.

**Je Sprache** die Sprache aus der Liste der Console **auswählen** (nicht den
Code tippen, die Codes sind nicht in der Console nachgesehen) und eintragen:

- Titel, Kurz- und Vollbeschreibung: `title.txt`, `short_description.txt`,
  `full_description.txt` aus dem Textordner
- 6 Screenshots (`screenshot-1-clear.png` … `screenshot-6-offline.png`) und
  die Feature-Grafik `feature-graphic-1024x500.png` aus dem Bildordner

Ohne eigene Bilder zeigt Play in dieser Sprache die englischen.

**Dateiimport:** `store-assets/store-listing.csv` enthält alle Texte, aber der
Import in der Console schlägt ohne Fehlermeldung fehl (28.09.). Das Format, das
die Console erwartet, ist nicht öffentlich beschrieben. **Wenn die Console die
vorhandenen Texte exportieren kann: einmal exportieren und mir die Datei
schicken.** Dann baue ich alle Sprachen genau in diesem Format nach. So hat es
beim Datensicherheits-Formular funktioniert.

**Alternative ohne Handarbeit:** `python3 tool/export_play_metadata.py` legt
alles im Ordneraufbau von fastlane `supply` ab, das über die Play-API
hochlädt. Dafür braucht es einen Service-Account-Schlüssel; die Einrichtung
beschreibt fastlane selbst (docs.fastlane.tools, „supply"). Der Schlüssel darf
**nie** ins Repo.

| Sprache | Play-Code | Texte `store-assets/listing/…` | Bilder `store-assets/…` | „Was ist neu" `docs/release-notes/1.3.0-…` |
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
zh-TW/zh-HK). Beide bekommen dieselben Dateien. Portugiesisch (Portugal) hat
eigene Texte, aber die Bilder und „Was ist neu" von Brasilien, weil die App
brasilianisches Portugiesisch spricht.

---

## 4 · Gameplay-Video

- `store-assets/video/qubble-gameplay.mp4` (25 s, hochkant, mit Ton) auf
  YouTube hochladen und den Link im Store-Eintrag als Promo-Video eintragen.
- Dasselbe und `qubble-neon.mp4`, `qubble-ocean.mp4`, `qubble-sunset.mp4` als
  Shorts/Reels/TikTok posten, z. B. eins pro Woche.

---

## 5 · Steuerdaten

Keine Steuerberatung, nur der Stand aus Juli:

- Gewerbe anmelden, **sobald real Geld ausgezahlt werden soll** (Gewerbeamt,
  auch rückwirkend möglich). Im Fragebogen vom Finanzamt die
  **Kleinunternehmerregelung (§ 19 UStG)** wählen.
- Danach Steuernummer bzw. USt-IdNr. (vom BZSt, wegen Reverse-Charge bei
  AdMob) in die Zahlungsprofile von Google eintragen, ohne sie gibt es keine
  Auszahlung.
- Im Zweifel kurz Finanzamt oder Steuerberater fragen.

---

## 6 · Entscheidungen, die bei dir liegen

Ich setze nichts davon um, bevor du entschieden hast.

| Frage | Meine Empfehlung |
|---|---|
| **Konkurrenz-Absatz** („Du magst Woodoku, Block Blast …") aus der EN/DE-Beschreibung streichen? In den 54 neuen Sprachen ist er nicht drin | **Ja, streichen.** Ob fremde Spieltitel als „irreführende Verweise" gelten, konnte ich nicht belegen; bei der Sperr-Vorgeschichte ist Streichen die billigere Seite des Risikos |
| **Teilen-Link auf Play statt Web?** Der Eintrag ist jetzt öffentlich; der Teilen-Text zeigt heute auf die Web-Version | Ja: Eine Installation ist mehr wert als eine Browser-Runde |
| **„App holen"-Hinweis in der Web-Version** für Android-Besucher | Ja, klein und ohne Risiko |
| **Teilen auch nach neuem Bestwert?** Der Plan legt Teilen bewusst nur aufs Daily | Deine Entscheidung. Es ist ein häufiger Wachstumshebel, weicht aber vom Plan ab |
| **Google-Ads-Kampagne** | `MASTERPLAN.md`: erst, wenn messbar ist, dass ein Spieler mehr einbringt, als eine Installation kostet. Wenn du trotzdem starten willst: Budget nennen und mir einen Screenshot des Anzeigen-Formulars schicken, dann liefere ich Texte und Bilder |
| **Play Games Services** (Erfolge/Bestenliste im Play-Games-Profil) | Später. Braucht Einträge in der Console und eine neue Abhängigkeit |
| **Tablet-Screenshots** | Nur, wenn du mir die Vorgaben der Console nennst (Maße, Anzahl). Die Quellen, die ich finde, widersprechen sich |
| **Store-Experimente** (Icon-Variante in `store-assets/icon-variant/`, Titel-Varianten in `audit/05-aso.md`) | Wenn genug Besucher da sind: zuerst das Icon |

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

**Nicht anfassen:** Signing-Schlüssel, Firestore-Regeln, Altersfreigabe,
Datensicherheit. Die Datensicherheit ändert sich nur, wenn sich ändert, welche
Daten die App sendet. Dann passe ich `docs/DATA-SAFETY.md` an und sage dir,
welche Zeile im Formular sich ändert.

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
