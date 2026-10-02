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
| 1 | [Release 1.5.0 hochladen](#1--release-150-hochladen) | Ein Bundle für alles seit 1.3.0; Halloween läuft nur im Oktober | du |
| 2 | [Halloween-Event im Play Store](#2--halloween-event-im-play-store) | Event-Karte im Store, solange Oktober ist | du |
| 3 | [Gameplay-Video](#3--gameplay-video) | Promo-Video im Store, Clips für Shorts | du |
| 4 | [Steuerdaten](#4--steuerdaten) | Sobald Google Geld auszahlen soll | du |
| 5 | [Entscheidungen](#5--entscheidungen-die-bei-dir-liegen) | Kein Zeitdruck | du → ich setze um |

---

## 1 · Release 1.5.0 hochladen

Entschieden 02.10.: **ein** Bundle statt zwei. 1.4.0 wird nicht hochgeladen;
1.5.0 enthält alles aus 1.4.0 mit. Version im Repo: **`1.5.0+12`**
(Versionscode 11 bleibt ungenutzt, das ist erlaubt).

Inhalt seit 1.3.0: Namensfrage nach der ersten Runde, eindeutige Namen (auch
mit Umlauten), neuer Shop mit Angebot des Tages, Designs-Bildschirm, neue
Designs und animierte Skins, Quests, Rätsel-Bestenliste, Daily mit Tagesziel
(1–3 Sterne), Serien-Truhen und Tages-Bestenliste, Gratis-Bonus im Shop
(3× täglich Gold, 3× täglich Diamanten per Video), Zubehör für Blöcke,
Explosionen, Halloween-Event im Oktober (Kürbis-Theme, Gespenster-Skin).

1. **Bundle:** Workflow **„Build Android Release (.aab)"**, Lauf vom 02.10.
   auf `main` nach PR #62, `test_ads` aus (ich starte und prüfe ihn und nenne
   dir die Nummer). Artefakt **`qubble-release-aab-PRODUCTION-ads`**, darin
   `app-release.aab`. Ein Artefakt `…-TEST-ads` gehört nie in die
   Produktion; den Build #32 (1.4.0) nicht mehr hochladen.
2. **Hochladen in die Produktion.** Die Console muss **1.5.0** und
   **Versionscode 12** anzeigen.
3. **„Was ist neu":** die fertige Datei `Was-ist-neu-1.5.0.txt` aus dem Chat
   ganz in das Feld einfügen (alle Sprachen in `<code>…</code>`-Blöcken).
   Quelle: `docs/release-notes/1.5.0-<code>.txt`, gefüllt mit
   `tool/play_release_notes.py`. Russisch (ru-RU) bekommt Englisch, die App
   kann kein Russisch.
4. **Rollout zuerst 20 %**, nach 1–2 Tagen Pre-Launch-Bericht, Android
   Vitals und Crashlytics ansehen, dann **100 %**. Bei Abstürzen anhalten
   (nicht zurückziehen) und mir den Stacktrace schicken. Das Halloween-Event
   (Schritt 2) sollte erst starten, wenn 1.5.0 bei 100 % ist; sonst führt
   die Event-Karte zu einer App ohne Halloween.

> **Halloween:** „Was ist neu" nennt das Event. Geht 1.5.0 erst nach dem
> 31.10. raus, sag Bescheid — dann nehme ich die Zeile vorher heraus.

---

## 2 · Halloween-Event im Play Store

Google Play nennt das **„Promotional content"** (früher „LiveOps"): eine
Event-Karte im Store. Ich sehe die Console nicht; was hier steht, ist aus
Googles Hilfe (Suchergebnisse) und Fachartikeln, Klickwege kenne ich nicht.
Fehlt ein Feld oder sieht es anders aus: Screenshot schicken.

- **Wer darf:** laut Google für **alle Spiele** verfügbar; Qubble ist ein
  Spiel.
- **Typ:** **Event** (zeitlich begrenzt). Höchstdauer laut Quellen
  **4 Wochen**, also nicht der ganze Oktober.
- **Zeitplan:** Google prüft bis zu **4 Tage**, deshalb mindestens 4 Tage
  vor dem Start einreichen. Vorschlag: **Start 07.10., Ende 31.10.**
  (24 Tage). Bis zum Start muss 1.5.0 bei 100 % sein (Schritt 1).
- **Name** (nur in der Console sichtbar): `Halloween 2026`.
- **Tagline** (max. 80 Zeichen) und **Beschreibung** (max. 500, Google
  empfiehlt mindestens 100): fertig in
  **`store-assets/event-halloween/TEXTE.md`**, für alle 60 Store-Sprachen
  außer Russisch. Englisch:
  - Tagline: `Pumpkin theme and ghost skin — only in October.`
  - Beschreibung: siehe Datei, Abschnitt `en-US`.
- **Übersetzungen:** laut Google-Hilfe über „Manage translations" >
  „Manage your own translations". Jede Sprache in ihrer eigenen Sprache
  eintragen; Text in der falschen Sprache ist laut Google ein häufiger
  Ablehnungsgrund.
- **Bilder** in `store-assets/event-halloween/`, ohne Text (Google: kein
  Logo, kein Slogan, kein Event-Name im Bild):
  - quer `halloween-1920x1080` (16:9)
  - quadratisch `halloween-1080x1080` (1:1)
  - je als `.png` und `.jpg`. Die Quellen widersprechen sich beim Format
    (PNG 32-bit laut Google-Hilfe, „JPG oder 24-bit PNG" laut Fachartikel);
    nimm, was die Console annimmt.
- **Animation** (statt des Bilds, laut Google oft mehr Klicks):
  **`store-assets/event-halloween/halloween-animation.json`** (Lottie,
  106 KB, 4 s, 60 fps, 16:9, nahtlose Schleife, kein Text). Googles
  Vorgaben dafür: Lottie-JSON, höchstens 200 KB, 60 fps, höchstens 6 s,
  16:9, kein Text, keine runden Ecken. Erzeugt von
  `tool/generate_event_lottie.py`, geprüft mit dem Lottie-Player im
  Browser.
- **Video:** optional (YouTube, quer). Ein Halloween-Video gibt es noch
  nicht; sag Bescheid, wenn du eins willst.
- **Link/Deep Link:** weiß ich nicht, ob das Formular einen verlangt. Qubble
  hat keinen Deep Link in den Shop. Falls nötig: Screenshot schicken.

Die Bilder erzeugt `tool/generate_event_images.dart` aus den Malfunktionen
der App (Kürbis-Theme, Gespenster-Skin).

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

## 5 · Entscheidungen, die bei dir liegen

Ich setze nichts davon um, bevor du entschieden hast.

| Frage | Meine Empfehlung |
|---|---|
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
| Firestore-Regeln für eindeutige Namen und Rätsel-Bestenliste veröffentlicht (Stand PR #60) | 29.09. |
| Firestore-Regeln mit Umlaut-Namen veröffentlicht, PR #61 gemergt | 30.09. |
| Firestore-Regeln mit der Tages-Bestenliste veröffentlicht (live geprüft) | 02.10. |
| Store-Beschreibung EN/DE ohne Konkurrenz-Absatz eingetragen | 02.10. |
| Zwei Anzeigenblöcke `Qubble – Gratis-Gold` und `Qubble – Gratis-Diamanten`, IDs im Code (Tabelle unten) | 02.10. |
| Entschieden: kein eigenes Release 1.4.0, alles kommt mit 1.5.0 | 02.10. |
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
| `Rewarded test` | **alle** Boni in 1.2.0; ab 1.3.0 Ersatz, wenn das Video eines Bonus nicht rechtzeitig geladen ist | `…/4303264559` |
| `Qubble – Gratis-Gold` | Shop: 3× täglich 100 Gold (ab 1.5.0) | `…/3859493490` |
| `Qubble – Gratis-Diamanten` | Shop: 3× täglich 3 💎 (ab 1.5.0) | `…/4210847288` |

**`Rewarded test` nicht löschen.** Ab 1.3.0 springt er ein, wenn der eigene
Block eines Bonus noch nichts geladen hat, und wer noch 1.2.0 hat, lädt alle
Bonus-Videos über ihn. Ohne ihn gäbe es dort kein einziges Bonus-Video mehr.
Der Name ist nur ein Etikett.

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
