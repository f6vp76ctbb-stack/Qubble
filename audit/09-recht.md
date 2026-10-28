# 09 — Rechtliche Prüfung (28.10.2026)

Prüfung von App, Website (GitHub Pages), öffentlichem Repo und Store-Texten
gegen deutsches und EU-Recht. Anlass: Der Nutzer bemerkte, dass Impressum und
Datenschutzerklärung keinen Namen nannten. Keine Rechtsberatung; bei einer
Abmahnung einen Anwalt fragen.

**Nicht abrufbar:** `gesetze-im-internet.de`, `eur-lex.europa.eu`, die Live-Seiten
und `play.google.com` sperrt die Netzwerk-Richtlinie dieser Umgebung. Gesetzestexte
und Fakten sind deshalb über die Websuche belegt (Quellen unten). Die Seiten
werden aus `main` veröffentlicht; geprüft wurde der Stand von `main`. Die Play
Console sieht Claude nicht.

**Korrektur zu `audit/07-compliance.md` A-6:** Dort steht „`web/impressum.html`
erfüllt § 5 DDG". Das war falsch: Es stand nur „Thinkube" darin. Behoben am
26.10. (`37e2c62`).

## Befunde und Stand

| # | Befund | Rechtsgrundlage | Stand |
|---|---|---|---|
| 1 | Impressum ohne Vor- und Nachnamen; „Thinkube" ist nur eine Geschäftsbezeichnung | § 5 Abs. 1 Nr. 1 DDG | **behoben** 26.10. (`37e2c62`) |
| 2 | Datenschutzerklärung nennt als Verantwortlichen nur „Thinkube" | Art. 13 Abs. 1 lit. a DSGVO | **behoben** 26.10. |
| 3 | Datenschutzerklärung ohne Rechtsgrundlagen, Speicherdauer, Beschwerderecht, Drittlandübermittlung, Datenübertragbarkeit, Widerspruchshinweis | Art. 13, Art. 21 Abs. 4 DSGVO | **behoben**: `web/privacy.html` neu |
| 4 | Firebase Analytics und Crashlytics starteten bei jedem Start ohne Einwilligung | § 25 Abs. 1 TDDDG, Art. 6 Abs. 1 lit. a DSGVO | **behoben** in 1.5.3: Abfrage beim ersten Start, Schalter in den Einstellungen, beide SDKs per Manifest/Info.plist aus, bis „ja" (`lib/services/stats_consent.dart`) |
| 5 | Werbe-Einwilligung falsch an Firebase gemeldet: `setAdConsent(granted: canRequestAds)`; `canRequestAds()` ist auch nach „Nicht einwilligen" `true` | Art. 6 Abs. 1 lit. a, Art. 7 DSGVO | **behoben** in 1.5.3: Brücke entfernt, `ad_storage`/`ad_user_data`/`ad_personalization` per Manifest verweigert |
| 6 | Impressum nur mit E-Mail; der EuGH verlangt einen zweiten schnellen Kontaktweg | EuGH C-298/07 zu § 5 Abs. 1 Nr. 2 DDG | **offen**: Nutzer hat keine Telefonnummer angegeben (28.10.); ein Kontaktformular ist auf GitHub Pages nicht möglich. Restrisiko |
| 7 | Nicht beschrieben: Hosting bei GitHub, Feedback per E-Mail/GitHub (Issue öffentlich), UMP-Abfrage, Laden der Bestenliste | Art. 13 DSGVO | **behoben**; Hinweis „öffentlich" auch in der App (`feedbackGithubNote`) |
| 8 | Datenschutzerklärung nur Deutsch, App in 57 Sprachen | Art. 12 Abs. 1 DSGVO, EDPB WP260 | **behoben**: `web/privacy-en.html`; die App verlinkt Deutsch für `de`, sonst Englisch (`lib/ui/legal_links.dart`) |
| 9 | „Käufe sind … jederzeit wiederherstellbar" stimmte nur für Unterstützer-Paket und Neon | § 5 UWG | **behoben** in 1.5.3 (`shopSupporterExplainer`, alle Sprachen) |
| 10 | Shop-Preise nur in Münzen/Diamanten; zwei Währungen mit Umtausch | CPC-Grundsätze zu Spielwährungen (März 2025, nicht bindend) | **offen**, Design-Entscheidung des Nutzers |
| 11 | Etikett „Beliebt" ohne Verkaufsdaten; „Bester Preis"/„am billigsten" am teuersten Paket (de, ne und 12 weitere Sprachen) | § 5 UWG | **behoben** in 1.5.3: „Beliebt" entfernt, Etikett heißt „Bestes Verhältnis" bzw. Entsprechung |
| 12 | AdMob-SDK startete auch ohne `canRequestAds()` | Googles UMP-Beispielcode | **behoben** in 1.5.3 (`GoogleAdService._startAds`) |
| 13 | „Verantwortlich für den Inhalt: Thinkube" | § 18 Abs. 2 MStV (nur bei journalistisch-redaktionellen Inhalten; dann natürliche Person) | **behoben** 26.10. (jetzt der Name) |
| 14 | Play Games als aktiv beschrieben, in 1.5.1+ ausgeschaltet | Art. 5 Abs. 1 lit. a DSGVO | **behoben**: Abschnitt 8 „derzeit ausgeschaltet" |
| 15 | Keine Kontaktstelle nach DSA (Bestenliste = Hostingdienst) | Art. 11, 12 DSA | **behoben**: Zeile im Impressum |
| 16 | Kinder-Satz nach US-Maßstab (13) | Art. 8 DSGVO (Deutschland: 16) | **behoben** |
| 17 | Keine Lizenzseite; Nunito (OFL) verlangt Lizenztext beim Vertrieb | SIL OFL 1.1, Bedingung 2 | **behoben**: Einstellungen → Lizenzen, `assets/fonts/OFL.txt` |
| 18 | USt-IdNr. / Wirtschafts-ID | § 5 Abs. 1 Nr. 6 DDG | **noch keine** (Nutzer 28.10.); sobald vorhanden, ins Impressum |
| 19 | Händlerstatus nach DSA in der Play Console | Art. 30, 31 DSA | **unbekannt** (Nutzer 28.10.); `ANLEITUNG.md` Schritt 6 |
| 20 | Produktkatalog (Prüfung der Console-KI, 28.10.): englische Texte von `qubble_diamonds_m`/`_l` beschreiben Münzen statt Diamanten | § 5 UWG (Irreführung über wesentliche Merkmale) | **offen**: Korrektur-Prompt in `ANLEITUNG.md` Schritt 7 |
| 21 | Produktkatalog: großes Paket in Georgien (Münzen, Diamanten) und Paraguay (Diamanten) pro Stück teurer als kleinere; App und Produkttext nennen es „Bestes Verhältnis" | § 5 UWG | **offen**: Schritt 7 (Staffelprüfung je Land) |
| 22 | Produktkatalog: alle Preise 19 % über dem Plan (MwSt. aufgeschlagen) | kein Rechtsverstoß, Abweichung vom Plan | **offen**: Schritt 7; Entscheidung Nutzer 28.10.: Planpreise |

## Geprüft und in Ordnung

- Keine erzwungene Werbung; nur belohnte Videos; Einwilligungsabfrage vor der
  ersten Anzeige; Datenschutz-Optionen in den Einstellungen.
- Bestenliste: Melden, Blockieren, Regeln mit Bestätigung, Löschweg.
- Starter-Angebot: echte 48 Stunden, danach weg (`lib/game/starter_offer.dart`);
  Tagesrabatt echt (an fünf von sechs Tagen gilt der Normalpreis).
- Keine Lootboxen; Bewertungsbitte ohne Belohnung.
- Webseiten laden nichts von Dritten (keine Schriften, Skripte, Tracker).
- Link zur EU-Schlichtungsplattform entfernt (Plattform seit 20.07.2025
  abgeschaltet); der Satz nach § 36 VSBG ist zulässig.
- Store-Texte ohne Konkurrenzmarken, ohne „kein Server".
- Öffentliches Repo ohne personenbezogene Daten Dritter.
- Google LLC und GitHub, Inc. sind nach dem EU-U.S. Data Privacy Framework
  zertifiziert; das EuG hat das DPF am 03.09.2025 bestätigt (T-553/23),
  Rechtsmittel C-703/25 P anhängig.
- § 5 DDG wurde zum 19.02.2026 nur redaktionell geändert (Komma in Nr. 8).

## Quellen

| Quelle | Wofür |
|---|---|
| [IHK München, Pflichtangaben Internetimpressum](https://ihk-muenchen.de/ihk/Merkblätter-WettbewerbsR/Pflichtangaben-Internetimpressum_Stand05_2024.pdf) | Name neben Geschäftsbezeichnung |
| [buzer.de, Änderung DDG 19.02.2026](https://www.buzer.de/gesetz/16426/v337287-2026-02-19.htm) | Änderung § 5 DDG |
| [WBS, EuGH C-298/07](https://www.wbs.legal/allgemein/eugh-entschied-angabe-der-telefonnummer-im-impressum-nicht-zwingend-notwendig-8146/) | zweiter Kontaktweg |
| [IT-Recht Kanzlei, § 18 MStV](https://www.it-recht-kanzlei.de/impressum-betreiber-journalistisch-redaktionelle-angebote-medienstaatsvertrag.html) | Verantwortlicher |
| [e-recht24, Art. 13 DSGVO](https://e-recht24.de/dsgvo/12870-dsgvo-art13.html) | Pflichtangaben |
| [e-recht24, TDDDG](https://www.e-recht24.de/datenschutz/12834-tdddg.html) | § 25 TDDDG |
| [Google, UMP ConsentInformation](https://developers.google.com/ad-manager/mobile-ads-sdk/android/next-gen/reference/privacy/com/google/android/ump/ConsentInformation), [AdMob-Forum](https://groups.google.com/g/google-admob-ads-sdk/c/Dydp-cWcOIo) | `canRequestAds()` nach Ablehnung |
| [Google, UMP-Einrichtung (Android)](https://developers.google.cn/admob/android/privacy) | SDK-Start erst nach `canRequestAds()` |
| [Firebase, Analytics-Erfassung konfigurieren](https://firebase.google.com/docs/analytics/android/configure-data-collection) | `firebase_analytics_collection_enabled` |
| [FlutterFire, Crashlytics](https://firebase.flutter.dev/docs/crashlytics/usage/), [Crashlytics-Referenz](https://firebase.google.com/docs/reference/android/com/google/firebase/crashlytics/FirebaseCrashlytics?hl=de) | Opt-in, `deleteUnsentReports` |
| [Usercentrics, Consent Mode für Apps](https://usercentrics.com/docs/apps/features/google-consent-mode/) | Manifest-Schlüssel `google_analytics_default_allow_*` |
| [Reed Smith, CPC-Grundsätze](https://www.reedsmith.com/en/perspectives/2025/03/qas-on-the-eu-consumer-protection-authorities-joint-guidance-paper) | Spielwährungen |
| [DPF-Liste, GitHub](https://www.dataprivacyframework.gov/participant/6174), [Firebase Datenschutz](https://firebase.google.com/support/privacy) | Zertifizierung, Speicherdauer |
| [Heuking, EuG zum DPF](https://www.heuking.de/de/news-events/newsletter-fachbeitraege/artikel/eug-bestaetigt-wirksamkeit-des-eu-us-data-privacy-framework.html) | Gültigkeit DPF |
| [IHK Stuttgart, OS-Plattform](https://www.ihk.de/stuttgart/fuer-unternehmen/recht-und-steuern/it-recht/os-plattform-zur-streitbeilegung-wird-eingestellt-6488402) | Abschaltung |
| [lxgesetze, Art. 12 DSA](https://lxgesetze.de/dsa/12) | Kontaktstelle |
| [EDPB, WP260 rev.01](https://www.edpb.europa.eu/system/files/2023-09/wp260rev01_en.pdf) | Übersetzungen |
| [Google Analytics, Aufbewahrung](https://support.google.com/analytics/answer/7667196) | 2 oder 14 Monate |
