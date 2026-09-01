# 01a — Compliance-Anforderungen, live geprüft

Alle Angaben in diesem Abschnitt wurden am **2026-08-31** abgerufen. Wo eine
Google-Primärquelle erreichbar war, ist sie zitiert; `support.google.com` und
`play.google.com` sind aus dieser Umgebung durch den Egress-Proxy gesperrt
(`{"error_type":"EGRESS_BLOCKED"}`), deshalb stammen einige Angaben aus der
Websuche über den Text der Play-Console-Hilfe. Wo das der Fall ist, steht es
dabei — diese Punkte sind vor Umsetzung in der Console gegenzuprüfen.

## Zusammenfassung: Status je Anforderung

| Anforderung | Frist / Stand | Qubble | Beleg |
|---|---|---|---|
| Target API Level | ab **31.08.2026** API 36 für neue Apps und Updates | **erfüllt** (targetSdk 36) | developer.android.com + `FlutterExtension.kt:34` |
| Play Billing Library | ab **31.08.2026** Version 8+ | **erfüllt** (8.0.0) | developer.android.com + Pub-Cache |
| Ads-Policy (Better Ads) | Interstitials reglementiert, Rewarded ausgenommen | **erfüllt, sogar strukturell** | Better-Ads-Policy + `lib/monetization/ads.dart` |
| AD_ID-Permission | Pflicht ab targetSdk 33 bei Werbe-ID-Nutzung | **unklar** — im Hauptmanifest nicht deklariert, kommt vermutlich per Merge | siehe unten |
| Data Safety | muss exakt zum realen Datenfluss passen | **Risiko** — Deklaration unbekannt, Datenfluss breiter als „offline" | siehe unten |
| Privacy Policy | Pflicht, URL in der Console | **erfüllt** | `web/privacy.html` |
| Account-Löschung | Pflicht, wenn Nutzer Konten anlegen können | **unklar/Risiko** | anonyme Firebase-Identität |
| UGC-Moderation | Melde- und Blockfunktion, Nutzungsbedingungen | **nicht erfüllt** | Bestenliste ohne Meldefunktion |
| Content Rating (IARC) | Pflicht, muss UGC/Interaktion abbilden | **unklar** — Fragebogen-Antworten unbekannt | — |
| Closed Testing | 12 Tester, 14 Tage, für neue Privatkonten | vermutlich erfüllt (Test durchgeführt) | — |
| Appeal-Frist | 180 Tage ab Termination | laufend | — |

---

## 1. Target API Level — erfüllt

Primärquelle, abgerufen 2026-08-31:

> **Starting August 31, 2026:** New apps and app updates must target Android 16
> (API level 36) or higher.
> […] If you need more time to update your app, you'll be able to request an
> extension to **November 1, 2026**.

— <https://developer.android.com/google/play/requirements/target-sdk>

Der Stichtag ist **heute**. Qubble targetiert 36
(`android/app/build.gradle.kts:47` → `FlutterExtension.kt:34`), und der
CI-Job prüft das am gebauten Artefakt hart nach
(`.github/workflows/build-release.yaml`, `check targetSdkVersion … "36"`).

Damit ist der Punkt erfüllt, und zwar ohne Verlängerungsantrag. Das ist relevant
für den Wiedereinreichungs-Zeitplan: Wäre die App auf 35 stehen geblieben, wäre
ab heute jedes Update blockiert gewesen.

Konfidenz: **hoch** — Primärquelle plus verifizierte Build-Assertion.

## 2. Play Billing Library — erfüllt

Primärquelle, abgerufen 2026-08-31:

> **By August 31, 2026**, all new apps and updates to existing apps must use
> **Billing Library version 8 or later**.

Deprecation-Tabelle derselben Seite: Version 7 → Frist 31.08.2026,
Verlängerung bis 01.11.2026.

— <https://developer.android.com/google/play/billing/deprecation-faq>

Qubble nutzt `in_app_purchase` 3.3.0; die Android-Implementierung
`in_app_purchase_android` 0.5.1 bindet:

```
/root/.pub-cache/hosted/pub.dev/in_app_purchase_android-0.5.1/android/build.gradle.kts:76
    implementation("com.android.billingclient:billing:8.0.0")
```

Auch das ist der Stichtag **heute** und ebenfalls erfüllt. Der Punkt ist wichtig
genug für eine Regressionssicherung: Ein `flutter pub upgrade`, das
`in_app_purchase_android` versehentlich nach unten löst, würde die App
unveröffentlichbar machen, ohne dass ein Test anschlägt.

Konfidenz: **hoch**.

## 3. Ads-Policy — erfüllt, und zwar als Struktur, nicht als Zufall

Googles „Better Ads Experiences"-Policy verbietet u. a. Interstitials, die
unerwartet erscheinen, die während des Gameplays auftauchen, oder die sich nach
15 Sekunden nicht schließen lassen. Rewarded Ads sind ausdrücklich ausgenommen:

> Since users have explicitly opted in to rewarded ad experience, these ads are
> allowed as long as they follow all Developer Program Policies. These changes
> don't affect opt-in ads like rewarded video ads since users voluntarily engage
> with these ads and they aren't considered disruptive.

— Play-Console-Hilfe „Understanding Google Play's Better Ads Experiences
policy", Text über Websuche abgerufen 2026-08-31,
<https://support.google.com/googleplay/android-developer/answer/12271244>
(Seite selbst egress-gesperrt)

Qubble hat nur Rewarded. Verifiziert:
`grep -rn "InterstitialAd\|BannerAd\|AppOpenAd" lib/` → keine Treffer.
`lib/monetization/ads.dart:1-8` dokumentiert die Regel, `lib/main.dart:81-82`
setzt sie durch (Web bekommt `FakeAdService`).

Das ist der einzige Bereich, in dem Qubble strukturell **unter** dem
Policy-Risiko der Kategorie liegt. Der Preis dafür steht in Phase 4.

Konfidenz: **hoch** für die Policy-Aussage, **hoch** für die Code-Aussage.

## 4. AD_ID-Permission — unklar, muss am gemergten Manifest geprüft werden

> Apps with target API level set to 33 (Android 13) or later must declare the
> normal permission `com.google.android.gms.permission.AD_ID` in the
> AndroidManifest.xml in order to use this API. […] Some SDKs, such as the
> Google Mobile Ads SDK (play-services-ads) may already declare this permission
> in the SDK's library manifest.

— Play-Console-Hilfe „Advertising ID", Text über Websuche abgerufen 2026-08-31,
<https://support.google.com/googleplay/android-developer/answer/6048248>
(egress-gesperrt)

Befund: `android/app/src/main/AndroidManifest.xml` deklariert die Permission
**nicht** (Zeilen 2-5 enthalten nur INTERNET, POST_NOTIFICATIONS,
RECEIVE_BOOT_COMPLETED). Qubble bindet aber `play-services-ads:25.3.0`
(verifiziert in
`~/.pub-cache/hosted/pub.dev/google_mobile_ads-9.0.0/android/build.gradle:71`),
das die Permission laut Google selbst mitbringt.

Konsequenz ist nicht der Build, sondern die Deklaration: Wenn AD_ID im
gemergten Manifest steht — und danach sieht es aus — dann **nutzt die App die
Werbe-ID**, und das muss im Data-Safety-Formular stehen. Genau dieser
Widerspruch (SDK sammelt, Formular sagt nein) ist der in Abschnitt 5 zitierte
häufigste Enforcement-Grund.

Verifizierbar ohne Rätselraten: Der bestehende CI-Job gibt die gemergten
Permissions bereits aus (`build-release.yaml`, Schritt „Verify the bundle",
`q /manifest/uses-permission/@android:name`). Ein Lauf von
„Build Android Release" beantwortet die Frage abschließend.

Konfidenz: **mittel** (Policy hoch, konkrete Merge-Wirkung unverifiziert).

## 5. Data Safety — das größte Enforcement-Risiko

> Google cross-references Data Safety Section declarations against what the APK
> actually does, including embedded SDKs, and inaccurate declarations — even
> accidental ones — can result in app removal and account warning strikes.

> Third-party SDK data collection counts as yours […] Data is "shared" whenever
> it's transferred to a third party — including the SDK provider if they use the
> data for their own purposes.

— Recherche über Websuche 2026-08-31 zur Play-Console-Hilfe
<https://support.google.com/googleplay/android-developer/answer/10787469>
(egress-gesperrt); sekundär bestätigt durch
<https://www.applander.io/blog/google-play-data-safety-form-complete-guide>
und <https://www.nasrtech.dev/blog/google-play-data-safety-explained/>

Der tatsächliche Datenfluss von Qubble (aus Phase 0, alle Fundstellen dort):

| Datenart | Empfänger | Auslöser | Fundstelle |
|---|---|---|---|
| Werbe-ID, Geräte-/Nutzungsdaten | Google AdMob | erstes Rewarded-Video | `ads.dart:120-135` |
| App-Instanz-ID, Ereignisse, Geräteinfo | Firebase Analytics | jeder Start (nativ) | `firebase_boot_native.dart:39` |
| Crash-Stacktraces, Geräteinfo | Crashlytics | Absturz (nativ) | `firebase_boot_native.dart:68-78` |
| **Anzeigename + Punktestand** | Cloud Firestore, **öffentlich lesbar** | Bestenlisten-Eintrag | `leaderboard.dart:133-166` |
| **anonyme Auth-Kennung (uid, refreshToken)** | Firebase Auth, lokal gespeichert | erster Submit | `leaderboard.dart:192-209`, `storage.dart:46-47` |
| Kaufvorgänge | Google Play Billing | Kauf | `iap.dart:240-255` |

Die gehostete Datenschutzerklärung (`web/privacy.html`) beschreibt das
**korrekt und vollständig**, inklusive Bestenliste und anonymer Kennung. Das ist
gut und ungewöhnlich sorgfältig.

Das Risiko liegt nicht im Text, sondern in der Console-Deklaration, die ich
nicht sehen kann. Zwei konkrete Fallen:

1. Die Marketing-Erzählung der App ist „komplett offline, kein Server"
   (`docs/STORE-LISTING.md`, Vollbeschreibung DE: „Kein Internet nötig, kein
   Konto, kein Server"). Wer das Formular in dieser Denkweise ausfüllt, klickt
   „keine Daten erhoben" an — und das wäre nachweislich falsch.
2. Die veralteten Vorlagen `docs/PRIVACY-POLICY.md` behaupten wörtlich „Diese
   Daten verlassen das Gerät nicht" und kennen die Bestenliste nicht. Wenn diese
   Fassung je irgendwo eingereicht oder verlinkt wurde, steht sie im Widerspruch
   zur App.

Konfidenz: **hoch**, dass der Datenfluss so ist (Code belegt).
**Unbekannt**, was deklariert ist — Console-Frage, siehe Fragenblock.

## 6. Datenschutzerklärung — erfüllt

Pflicht ist eine gültige, erreichbare Privacy-Policy-URL in der Console.
`web/privacy.html` ist ausgefüllt (Verantwortlich: Thinkube, Mähderweg 5,
88451 Dettingen, thinkube@outlook.de; Stand 23.07.2026), deckt AdMob, Firebase
Analytics/Crashlytics, Bestenliste, IAP und Kinder ab und wird in der App unter
Einstellungen verlinkt (`lib/ui/screens/settings_screen.dart:39`).

Ein Mangel: Die Erklärung ist deutschsprachig mit englischer Kurzfassung am
Ende, während die App und das Store-Listing zweisprachig sind. Für einen
US-Listing-Eintrag ist das dünn.

Zweiter Mangel: `docs/PRIVACY-POLICY.md` und `docs/IMPRESSUM.md` sind
widersprüchliche, ungefüllte Altfassungen im selben Repo. Sie sind nirgends
verlinkt, aber sie sind eine Fehlerquelle für jeden, der später das Formular
ausfüllt.

## 7. Account-Löschung — unklares Risiko

> If users can create accounts in your app, you must provide a way for them to
> request account deletion, with options readily available to users within and
> outside your app.

— Play-Console-Hilfe „Understanding Google Play's app account deletion
requirements", über Websuche abgerufen 2026-08-31,
<https://support.google.com/googleplay/android-developer/answer/13327111>
(egress-gesperrt)

Qubble legt beim ersten Bestenlisten-Submit still ein anonymes
Firebase-Auth-Konto an (`leaderboard.dart:192-209`). Für den Spieler ist das
kein sichtbares Konto — es gibt keinen Login, keine E-Mail. Ob Google das als
„account creation" wertet, ist aus der Policy nicht eindeutig ableitbar.

Was dagegen eindeutig ist: Der Eintrag ist **öffentlich lesbar**
(`firebase/firestore.rules`: `allow read: if true`) und der Spieler kann ihn
nicht selbst entfernen (`allow delete: if false`). Die Datenschutzerklärung
verweist für Löschungen auf eine E-Mail-Adresse. Das ist DSGVO-seitig
vertretbar, aber es ist genau die Art halb erfüllter Anforderung, die bei einem
Konto mit Vorgeschichte teuer wird.

Konfidenz der Einordnung: **mittel**.

## 8. UGC-Moderation — nicht erfüllt

Das ist der schwerwiegendste Neubefund dieser Phase.

> Apps that contain or feature UGC must implement robust, effective, and ongoing
> UGC moderation that requires users accept the app's terms of use and/or user
> policy before creating or uploading UGC […] Apps must provide an in-app system
> for reporting and blocking objectionable UGC and users, and take action
> against UGC or users where appropriate. […] readily accessible from within the
> app.

— Play-Console-Hilfe „User Generated Content", über Websuche abgerufen
2026-08-31, <https://support.google.com/googleplay/android-developer/answer/9876937>
(egress-gesperrt)

Qubble hat UGC: Der Spieler wählt einen Anzeigenamen, dieser wird an Firestore
gesendet und **allen anderen Spielern öffentlich angezeigt**
(`lib/services/leaderboard.dart:133-166`, `lib/ui/screens/leaderboard_screen.dart`).

Was vorhanden ist:
- Client-seitige Wortliste mit Normalisierung gegen Leetspeak und Dehnung
  (`lib/game/name_filter.dart`, 2-14 Zeichen, `[A-Za-z0-9 _-]`)
- Server-seitige Regex- und Längenprüfung (`firebase/firestore.rules`)

Was **fehlt**, verifiziert per Suche über `leaderboard_screen.dart`,
`home_screen.dart` und `lib/l10n/app_en.arb`:
- **keine** Meldefunktion für einen anstößigen Namen (Suche nach
  `report|melde|block|flag|abuse` → einziger Treffer ist
  `Icons.flag_outlined` in `home_screen.dart:560`, und das ist der
  Missionen-Button, nicht eine Meldefunktion)
- **keine** Blockfunktion
- **keine** Nutzungsbedingungen, die der Spieler vor der Namensvergabe
  akzeptiert
- **kein** Weg, einen gemeldeten Eintrag zu entfernen — die Firestore-Regeln
  verbieten Löschen kategorisch (`allow delete: if false`), auch dem Betreiber
  über den normalen Client

Ein Wortfilter ist keine Moderation im Sinne der Policy; die Policy verlangt
ausdrücklich zusätzlich ein In-App-Meldesystem. Und der Filter ist umgehbar:
Er kennt nur `[a-z]` nach Normalisierung, also passieren Namen, die aus
erlaubten Zeichen etwas Beleidigendes bilden, das nicht auf der Liste steht.

Konfidenz: **hoch**. Policy-Text und Code-Befund sind beide belegt.

## 9. Content Rating (IARC)

> Content raters, such as the International Age Rating Coalition (IARC), will
> consider whether apps collect and share location or personal information,
> **enable user interaction, share user-generated content**, or offer in-app
> digital purchases.

— Play-Console-Hilfe „Content rating requirements", über Websuche abgerufen
2026-08-31, <https://support.google.com/googleplay/android-developer/answer/9859655>
(egress-gesperrt)

`docs/STORE-LISTING.md` plant „voraussichtlich USK 0 / PEGI 3 / Apple 4+". Die
Frage, die im Fragebogen zwingend richtig beantwortet werden muss, ist die nach
Nutzerinteraktion und geteilten Inhalten — und die ist wegen der Bestenliste
**ja**, nicht nein. Eine falsche Antwort hier ist eine Fehldeklaration
gegenüber IARC.

Konfidenz: **hoch** für die Anforderung. Was tatsächlich angegeben wurde, ist
eine Console-Frage.

## 10. Testanforderung für neue Privatkonten

> Developers with personal accounts created after November 13, 2023, must run a
> closed test for their app with a minimum of **12 testers** who have been
> opted in continuously for at least **14 days**.

Ursprünglich 20 Tester, im Dezember 2024 auf 12 gesenkt. Organisationskonten mit
D-U-N-S-Nummer sind ausgenommen.

— Recherche über Websuche 2026-08-31 zu
<https://support.google.com/googleplay/android-developer/answer/14151465>
(egress-gesperrt), sekundär
<https://ontest.app/blog/google-play-12-testers-14-days-requirement-explained>

Der geschlossene Test wurde laut Auftragsbeschreibung durchgeführt. Ob die
12/14-Bedingung formal erfüllt und der Produktionszugang beantragt ist, ist eine
Console-Frage. `docs/PRODUCTION-ACCESS.md` existiert im Repo und deutet darauf
hin, dass der Antrag vorbereitet wurde.

## 11. Enforcement und Appeal

> For accounts terminated on or after January 28, 2026, you must submit the
> appeal within **180 days** of the termination date.

> Repeated or serious violations […] will result in termination of individual or
> **related** Google Play Developer accounts. […] developers are responsible for
> addressing any policy issue and conducting **extra due diligence to ensure
> that the remainder of their app or account is fully policy compliant**.
> Failure to address policy violations in your account and all of your apps may
> result in additional enforcement actions.

— Recherche über Websuche 2026-08-31 zu
<https://support.google.com/googleplay/android-developer/answer/9899234>
(egress-gesperrt), sekundär
<https://www.ibtimes.sg/google-play-extends-ban-appeal-window-180-days-developers-countdown-starts-termination-date-91283>

Zum Bot-Verdacht bei neuen Konten fand sich als konkretes Signal:

> Rapid-fire app uploads — submitting five apps in a single afternoon — is a
> bot-pattern flag regardless of what the apps contain.

— <https://gologin.com/blog/google-play-account-banned/>, abgerufen 2026-08-31.
Sekundärquelle, kein Google-Dokument. Konfidenz: **niedrig**. Als Erklärung für
den konkreten Fall taugt das nur, wenn tatsächlich mehrere Uploads kurz
hintereinander stattfanden.

Der operativ wichtigste Satz ist der aus der Enforcement-Seite: Google erwartet
nach einem Vorfall nicht nur die Behebung des gerügten Punktes, sondern eine
Eigenprüfung des Rests. Genau das ist der Grund, warum die UGC-Lücke (Abschnitt
8) und die Data-Safety-Konsistenz (Abschnitt 5) vor der Wiedereinreichung
geschlossen gehören — auch wenn die ursprüngliche Sperre nichts damit zu tun
hatte.

---

## Was ich nicht prüfen konnte

| Punkt | Grund |
|---|---|
| Wortlaut der Play-Policy-Seiten im Original | `support.google.com` und `play.google.com` sind egress-gesperrt; Inhalte nur über Websuchtreffer |
| Gemergtes AndroidManifest (AD_ID, weitere Plugin-Permissions) | kein Android-SDK in dieser Umgebung; CI-Job liefert es |
| Aktuelle Data-Safety-Deklaration | Console-Zugriff fehlt |
| IARC-Fragebogen-Antworten | Console-Zugriff fehlt |
| Wortlaut der Enforcement-/Appeal-Mail | nicht vorgelegt |
| Ob der geschlossene Test 12/14 formal erfüllt | Console-Zugriff fehlt |

---

## Quellen

| URL | Titel | Abrufdatum | Art |
|---|---|---|---|
| <https://developer.android.com/google/play/requirements/target-sdk> | Meet Google Play's target API level requirement | 2026-08-31 | Primär, direkt abgerufen |
| <https://developer.android.com/google/play/billing/deprecation-faq> | Google Play Billing Library version deprecation | 2026-08-31 | Primär, direkt abgerufen |
| <https://developer.android.com/training/articles/user-data-ids> | Best practices for unique identifiers | 2026-08-31 | Primär, direkt abgerufen |
| <https://support.google.com/googleplay/android-developer/answer/12271244> | Understanding Google Play's Better Ads Experiences policy | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://support.google.com/googleplay/android-developer/answer/10787469> | Provide information for Google Play's Data safety section | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://support.google.com/googleplay/android-developer/answer/9876937> | User Generated Content | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://support.google.com/googleplay/android-developer/answer/13327111> | App account deletion requirements | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://support.google.com/googleplay/android-developer/answer/9859655> | Content rating requirements | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://support.google.com/googleplay/android-developer/answer/14151465> | App testing requirements for new personal developer accounts | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://support.google.com/googleplay/android-developer/answer/9899234> | Enforcement Process | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://support.google.com/googleplay/android-developer/answer/6048248> | Advertising ID | 2026-08-31 | über Websuche, Seite gesperrt |
| <https://ontest.app/blog/google-play-12-testers-14-days-requirement-explained> | 12 Testers, 14 Days Requirement Explained | 2026-08-31 | Sekundär |
| <https://www.ibtimes.sg/google-play-extends-ban-appeal-window-180-days-developers-countdown-starts-termination-date-91283> | Google Play Extends Ban Appeal Window To 180 Days | 2026-08-31 | Sekundär |
| <https://gologin.com/blog/google-play-account-banned/> | Google Play Account suspended or Banned? | 2026-08-31 | Sekundär, Konfidenz niedrig |
| <https://www.applander.io/blog/google-play-data-safety-form-complete-guide> | Google Play Data Safety Form: Complete Walkthrough 2026 | 2026-08-31 | Sekundär |
| <https://www.apptweak.com/en/aso-blog/how-to-prepare-for-new-google-metadata-policy-changes> | Google Play's Metadata Policy Changes | 2026-08-31 | Sekundär |
