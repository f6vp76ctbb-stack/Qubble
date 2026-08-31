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
| 1 | **Geräte- oder andere IDs** → Werbe-ID | ja | **ja** (Google) | Werbung | optional¹ | erstes Rewarded-Video | `lib/monetization/ads.dart:120-135`, `play-services-ads:25.3.0` |
| 2 | **App-Aktivität** → App-Interaktionen | ja | **ja** (Google) | Analyse | nein² | jeder Start | `lib/services/firebase_boot_native.dart:39, 96` |
| 3 | **App-Info und Leistung** → Absturzprotokolle, Diagnose | ja | **ja** (Google) | Diagnose | nein² | Absturz | `lib/services/firebase_boot_native.dart:68-78` |
| 4 | **Sonstige** → nutzergenerierte Inhalte (Anzeigename) | **ja** | **ja, öffentlich sichtbar** | App-Funktion | **optional** | erster Bestenlisten-Eintrag | `lib/services/leaderboard.dart:133-166` |
| 5 | **Geräte- oder andere IDs** → anonyme Auth-Kennung | **ja** | ja (Google) | App-Funktion | **optional** | erster Bestenlisten-Eintrag | `lib/services/leaderboard.dart:207-247`, `lib/services/storage.dart:46-47` |
| 6 | Kaufhistorie | nein³ | nein³ | — | — | Kauf | `lib/monetization/iap.dart` |

¹ Optional, weil der Spieler kein Video schauen muss und der UMP-Consent-Flow
vorgeschaltet ist (`lib/monetization/ads.dart:52-58`).
² Firebase Analytics und Crashlytics starten beim App-Start, ohne dass der
Spieler etwas auslöst — also **nicht** „optional" im Sinne des Formulars.
³ Der Kauf läuft vollständig über Google Play; die App erhält keine Zahlungs-
oder Kontodaten. Nichts zu deklarieren.

**Die Zeilen 4 und 5 sind die, die typischerweise vergessen werden**, weil die
App sich wie ein Offline-Spiel anfühlt. Sie sind der wahrscheinlichste
Widerspruch zwischen Formular und Realität.

## Zeilenweise Antworten auf die Formularfragen

Für jede erhobene Datenart fragt das Formular vier Dinge:

| Frage | Zeile 1 (Werbe-ID) | Zeile 2 (App-Aktivität) | Zeile 3 (Absturz) | Zeile 4 (Anzeigename) | Zeile 5 (Auth-Kennung) |
|---|---|---|---|---|---|
| Werden diese Daten **erhoben**? | ja | ja | ja | ja | ja |
| Werden diese Daten **geteilt**? | ja | ja | ja | ja | ja |
| Werden sie **vorübergehend verarbeitet**? | nein | nein | nein | nein | nein |
| Ist die Angabe für den Nutzer **optional**? | ja | nein | nein | ja | ja |

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
3. **Datenschutzerklärung gegenlesen.** `web/privacy.html` beschreibt bereits
   alle sechs Zeilen korrekt. Weichen Formular und Erklärung voneinander ab,
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
