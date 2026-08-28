# Play Console — manuelle Prüfliste für 1.1.0 (versionCode 3)

Wiederveröffentlichung nach Account-Sperre. Kein inhaltlicher Policy-Verstoß
zu beheben — es geht um ein sauberes Release-Bundle. Alles hier muss ein
Mensch in der Play Console prüfen; aus dem Repo heraus ist es nicht machbar.

## A. Vor dem Upload

- [ ] **Upload-Key unverändert?** Nach einer Account-Sperre ist das der
      häufigste Stolperstein. Weicht der Fingerprint des Keystores in den
      GitHub-Secrets von dem ab, den Play erwartet, wird der Upload abgelehnt.
      Dann in der Play Console einen Upload-Key-Reset beantragen.
- [ ] **App-Eintrag existiert noch?** Prüfen, ob `com.thinkube.qubble` noch
      unter „Alle Apps" steht oder ob der Eintrag neu angelegt werden muss.
- [ ] **Rechtstexte erreichbar** (hier nicht prüfbar, github.io war gesperrt):
      - https://f6vp76ctbb-stack.github.io/Qubble/privacy.html
      - https://f6vp76ctbb-stack.github.io/Qubble/impressum.html
      Beide müssen 200 liefern; die Datenschutz-URL muss im Store-Eintrag
      hinterlegt sein.

## B. Deklarationen (müssen zum Bundle passen)

- [ ] **Data Safety**: Datenerhebung **ja**, Weitergabe an Dritte **ja**.
      Kategorien: Geräte-/andere IDs (Werbe-ID), App-Aktivität,
      App-Informationen und Leistung (Absturzprotokolle), Käufe.
      Übertragung verschlüsselt: ja. Löschanfrage: anbieten.
- [ ] **Werbe-ID-Frage**: „Ja, meine App verwendet eine Werbe-ID."
      `com.google.android.gms.permission.AD_ID` ist über den Manifest-Merger
      im Bundle (aus play-services-ads und play-services-measurement).
      Fehlende Deklaration = abgelehntes Release.
- [ ] **Enthält Werbung**: ja (Rewarded, freiwillig).
- [ ] **In-App-Käufe**: ja (Unterstützer-Paket, Münzpakete, Starter-Paket).
- [ ] **Zielgruppe / Altersfreigabe**: Fragebogen erneut durchgehen.
      Keine Kinder-Zielgruppe angeben, solange Werbe-ID genutzt wird.
- [ ] **Target-API-Level**: Play muss 36 anzeigen. Ab 31.08.2026 Pflicht.

## C. Smoke-Test (wird NICHT von mir abgedeckt)

R8/Code-Shrinking ist in diesem Release **zum ersten Mal aktiv** und wurde nie
in einem Store-Build ausgeliefert. Das ist das größte Laufzeitrisiko.

- [ ] Bundle in **Interner Test** hochladen (nicht direkt Produktion).
- [ ] **Pre-Launch-Report abwarten** (Play Console → Testen → Pre-Launch-Report).
      Google fährt die App automatisch auf echten Geräten: Kaltstart,
      Navigation, Absturz- und ANR-Erkennung, Screenshots. Das ersetzt den
      manuellen Smoke-Test weitgehend und kostet dich nichts außer Wartezeit.
- [ ] Im Report gezielt prüfen: **keine Abstürze beim Start**, Screenshots
      zeigen Hauptmenü und Spielfeld (nicht den Fehler-Screen), keine ANRs.
- [ ] `mapping.txt` aus dem Build-Run in die Play Console hochladen, sonst
      sind Crashlytics-/Play-Stacktraces unlesbar.
- [ ] Erst nach sauberem Report zu **Produktion** hochstufen.

## D. Bekannte Punkte für später (kein Blocker für 1.1.0)

- **Querformat auf Tablets**: Ab targetSdk 36 ignoriert Android 16 die
  Portrait-Sperre auf Displays ≥600dp. Auf Tablets/Foldables kommt das
  Querformat zurück, in dem laut Code die Booster-Leiste und der
  „Neue Teile"-Button wegfallen. Opt-out bis targetSdk 37 möglich über
  `PROPERTY_COMPAT_ALLOW_RESTRICTED_RESIZABILITY` im Manifest — sauberer wäre
  ein echtes Querformat-Layout.
- **Playtest-Formulierung im Fehler-Screen**: `lib/main.dart` sagt im
  Storage-Fehlerfall „bitte melde das im Playtest". Für ein öffentliches
  Release umformulieren.
- **iOS-Rewarded-Unit** ist noch `REPLACE_ME_REWARDED_IOS` (fällt auf die
  Test-Unit zurück). Nur relevant für die App-Store-Phase.
