# Data-Safety-Deklaration — Qubble

**Diese Datei ist die Vorlage zum Abtippen in die Play Console**
(App-Inhalte → Datensicherheit). Sie ist aus dem Code abgeleitet, nicht aus der
Marketing-Beschreibung — und das ist der Punkt: Die Store-Beschreibung sagt
„offline", die App überträgt trotzdem Daten.

Google gleicht die Deklaration gegen das ab, was das Bundle tatsächlich tut,
**einschließlich der eingebetteten SDKs**. Eine falsche Angabe — auch eine
versehentliche — führt zu App-Entfernung und Konto-Verwarnung. Für ein Konto mit
Enforcement-Vorgeschichte ist das der wichtigste einzelne Punkt vor der
Wiedereinreichung.

> **Kurzfassung: „Es werden keine Daten erhoben" ist FALSCH.** Wer das
> ankreuzt, deklariert nachweislich unzutreffend.

Stand: 2026-08-31, Commit-Stand siehe `git log`. Bei jeder Änderung an
Abhängigkeiten oder an der Bestenliste **erneut prüfen**.

---

## Was die App tatsächlich überträgt

Jede Zeile mit Fundstelle. Gilt für den **nativen Android-Build**; Abweichungen
für Web stehen unten.

| # | Datenart (Play-Kategorie) | Erhoben | Geteilt | Zweck | Pflicht? | Auslöser | Fundstelle |
|---|---|---|---|---|---|---|---|
| 1 | **Geräte- oder andere IDs** → Werbe-ID | ja | **ja** (AdMob) | Werbung | **ja**¹ | jeder Start | `lib/monetization/ads.dart:60-66`, `lib/ui/app_bootstrap.dart:100` |
| 2 | **App-Aktivität** → App-Interaktionen | ja | nein² | Analyse | ja¹ | jeder Start | `lib/services/firebase_boot_native.dart:39, 96` |
| 3 | **App-Info und Leistung** → Absturzprotokolle, Diagnose | ja | nein² | Diagnose | ja¹ | Absturz | `lib/services/firebase_boot_native.dart:68-78` |
| 4 | **Nutzergenerierte Inhalte** + **Name** → Bestenlisten-Anzeigename | **ja** | **ja, öffentlich sichtbar**³ | App-Funktion | **optional** | erster Bestenlisten-Eintrag | `lib/services/leaderboard.dart:133-166` |
| 5 | **Personenbezogene Daten** → Nutzer-ID (anonyme Auth-Kennung) | **ja** | nein² | App-Funktion | **optional** | erster Bestenlisten-Eintrag | `lib/services/leaderboard.dart:207-247`, `lib/services/storage.dart:46-47` |
| 6 | **Finanzdaten** → Kaufhistorie | **ja**⁴ | nein² | App-Funktion, Analyse | optional | Kauf | `lib/monetization/purchase_delivery.dart:100` |
| 7 | **Standort** → ungefährer Standort | ja⁵ | **ja** (AdMob) | Werbung | ja¹ | jeder Start | `play-services-ads`, IP-basiert |

¹ **Nicht optional.** `app_bootstrap.dart:100` initialisiert den Ads-SDK bei
jedem Start, und Firebase startet noch davor — beides ohne Zutun des Spielers.
Dass ein Rewarded-Video freiwillig ist, ändert daran nichts: Die Erhebung
beginnt vor der ersten Videoentscheidung. (Diese Datei behauptete bis
2026-09-01 das Gegenteil.)

² **Nicht „geteilt" im Sinne des Formulars.** Google unterscheidet
Weitergabe an Dritte von Verarbeitung durch einen *Dienstanbieter*, der
ausschließlich im Auftrag des Entwicklers verarbeitet — Letzteres ist keine
Weitergabe. Firebase Analytics, Crashlytics, Auth und Firestore fallen darunter.
AdMob dagegen **nicht**: Es baut Werbeprofile über viele Kunden hinweg und ist
deshalb in Zeile 1 und 7 als geteilt geführt. Beleg:
<https://support.google.com/googleplay/answer/11416267>, abgerufen 2026-09-01.

³ Zeile 4 ist unabhängig von Fußnote 2 geteilt, und zwar im deutlichsten Sinn:
Der Anzeigename ist **für alle anderen Spieler öffentlich lesbar**. Das ist
keine Auftragsverarbeitung.

⁴ **Korrektur.** Diese Zeile stand bis 2026-09-01 auf „nicht erhoben, nichts zu
deklarieren". Das war falsch: `purchase_delivery.dart:100` meldet jeden
erfolgreichen Kauf als Analytics-Ereignis mit Produkt-ID, und
`game_controller.dart:675` setzt zusätzlich die Nutzereigenschaft
`has_purchased`. Die Zahlungsabwicklung läuft zwar vollständig über Google Play
— die App sieht keine Zahlungsdaten —, aber *dass* gekauft wurde, erhebt sie
selbst.

⁵ AdMob leitet aus der IP einen groben Standort ab. Nicht aus dem Code
belegbar, aber Bestandteil des SDK-Verhaltens; im Zweifel deklarieren.

**Die Zeilen 4 und 5 sind die, die typischerweise vergessen werden**, weil die
App sich wie ein Offline-Spiel anfühlt. Sie sind der wahrscheinlichste
Widerspruch zwischen Formular und Realität.

## Der Export ist die Kontrolle, nicht diese Datei

Die Play Console kann die Data-Safety-Antworten als CSV **exportieren und
importieren** (Richtlinien → App-Inhalte → Datensicherheit). Damit ist der
Ist-Zustand prüfbar, statt aus dem Gedächtnis rekonstruiert zu werden — und
genau so wurde am 2026-09-01 festgestellt, dass vier Zeilen dieser Datei falsch
waren und das Formular recht hatte. **Bei jeder künftigen Prüfung zuerst
exportieren.** Dasselbe gilt für den Store-Eintrag
(`store-assets/store-listing.csv`).

Stand des geprüften Exports: alle sieben Zeilen oben sind im Formular
vorhanden, nichts ist unterdeklariert. Eine Unstimmigkeit bleibt bestehen:
Absturzprotokolle sind als *nicht* geteilt geführt, Leistungsdiagnose als
geteilt — beide kommen aus Crashlytics und sollten gleich beantwortet sein.
Das ist eine Über-, keine Unterdeklaration und damit kein Verstoß; ein
laufendes, akzeptiertes Formular deswegen anzufassen wäre das größere Risiko.

## Sicherheitspraktiken

| Frage | Antwort | Begründung |
|---|---|---|
| Werden Daten bei der Übertragung verschlüsselt? | **ja** | Alle Aufrufe gehen über HTTPS (`Uri.https` in `lib/services/leaderboard.dart`); AdMob und Firebase ebenso. |
| Können Nutzer die Löschung ihrer Daten beantragen? | **ja** | In der App: Einstellungen → „Bestenlisten-Eintrag löschen". Außerhalb: thinkube@outlook.de, in `web/privacy.html` genannt. |
| Wurde die App unabhängig auf Sicherheit geprüft? | nein | — |

Für die Frage nach der **Löschung** ist die URL der Datenschutzerklärung
anzugeben: <https://f6vp76ctbb-stack.github.io/Qubble/privacy.html>

## Abweichungen im Web-/PWA-Build

Nur relevant, falls die Web-Fassung je separat deklariert wird. Der
Play-Eintrag betrifft sie nicht.

| Datenart | Web |
|---|---|
| Werbe-ID | **nein** — `FakeAdService` (`lib/main.dart:82`) |
| App-Aktivität, Absturzprotokolle | **nein** — Firebase-Stub (`lib/services/firebase_boot_stub.dart:6`) |
| Anzeigename, Auth-Kennung | **ja** — die Bestenliste läuft über plain REST und funktioniert auch im Web |
| Käufe | **nein** — `LockedIap` (`lib/main.dart:87`) |

## Gegenprobe vor dem Absenden

1. **Gemergtes Manifest ansehen.** Der Workflow „Build Android Release"
   (`.github/workflows/build-release.yaml`) gibt im Schritt „Verify the bundle"
   alle gemergten Permissions aus. Steht dort
   `com.google.android.gms.permission.AD_ID`, ist Zeile 1 zwingend zu
   deklarieren. (Erwartung: ja, `play-services-ads` bringt sie mit.)
2. **Beschreibung gegenlesen.** Die Store-Beschreibung darf nicht bestreiten,
   was hier deklariert wird. Die bereinigte Fassung in `docs/STORE-LISTING.md`
   ist darauf abgestimmt — die ältere Formulierung „kein Server" war es nicht.
3. **Datenschutzerklärung gegenlesen.** `web/privacy.html` deckt alle sieben
   Zeilen ab (ungefährer Standort und das Kauf-Ereignis wurden am 2026-09-01
   ergänzt — sie waren deklariert, aber nicht beschrieben). Weichen Formular und Erklärung voneinander ab,
   ist eines von beiden falsch.

## Wenn sich etwas ändert

Diese Deklaration ist an folgende Stellen gekoppelt. Ändert sich eine davon,
gehört das Formular überprüft:

- `lib/services/leaderboard.dart` — was an Firestore geht
- `lib/monetization/ads.dart`, `lib/monetization/ad_config.dart` — Werbeformate
- `lib/services/firebase_boot_native.dart` — Analytics und Crashlytics
- `pubspec.yaml` — **jedes neue SDK kann eine neue Datenkategorie mitbringen**

---

Quellen zur Anforderung mit Abrufdatum: `audit/01a-compliance-recherche.md`,
Abschnitt 5. Vollständige Bewertung: `audit/07-compliance.md`, Abschnitt C-1.
