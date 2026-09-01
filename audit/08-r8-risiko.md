# 08 — R8-Risiko im Abhängigkeitsbaum

Nachtrag zum Audit, ausgelöst durch einen gemeldeten
`androidx.startup.StartupException`. Die Frage: Gibt es **weitere** Stellen, an
denen R8 etwas entfernt, das nur über Reflexion oder über einen Namen erreicht
wird?

Erhoben am 2026-09-01. Wiederholbar mit `python3 tool/r8_risk_scan.py`.

## Warum diese Klasse von Fehler besonders unangenehm ist

R8 ist für Release-Builds aktiv (`android/app/build.gradle.kts:75-77`). Es
entfernt und benennt um, was es nicht referenziert sieht. Drei Wege führen an
einer für R8 sichtbaren Referenz vorbei:

| Weg | Warum R8 es nicht sieht |
|---|---|
| **Gson** | ordnet JSON-Schlüssel auf **Feldnamen** ab; umbenannte Felder deserialisieren stumm nicht mehr |
| **androidx.startup** | benennt Initializer im `<meta-data>`-Attribut, das AGP nicht als Klassenreferenz behandelt |
| **`Class.forName`** | der Name entsteht erst zur Laufzeit |

Keiner davon bricht den Build. Sie brechen auf dem Gerät — meist nach einem
Neustart oder beim ersten Start.

## Befund

14 Pakete im Abhängigkeitsbaum liefern Android-Code. Der Scanner meldet zwei;
nach dem Lesen bleibt **eines** als echte Lücke, und beide echten Lücken sind
inzwischen geschlossen.

| Paket | Muster | Bewertung |
|---|---|---|
| `flutter_local_notifications` 18.0.1 | Gson | **echt.** Keine Consumer-Regeln, Gson 2.8.9 (eigene Regeln erst > 2.10.1), Modelle ohne `@SerializedName`. Geschlossen in `5650e08`. |
| — (transitiv über `google_mobile_ads`) | androidx.startup | **echt.** `androidx.lifecycle:lifecycle-process` registriert `ProcessLifecycleInitializer` per Manifest-Metadatum. Geschlossen in `b3bd70d`. |
| `google_mobile_ads` 9.0.0 | `Class.forName` | **kein Risiko**, siehe unten |
| `in_app_purchase_android` 0.5.1 | `newInstance` | **kein Risiko** — alle Treffer in `TranslatorTest.java` / `MethodCallHandlerTest.java`, also Testquellen, die nicht ausgeliefert werden |
| `webview_flutter_android` 4.13.0 | `getDeclaredField` | **kein Risiko** — `DisplayListenerProxy` reflektiert auf `android.hardware.display.DisplayManager`, eine Framework-Klasse; R8 fasst `android.*` nie an |
| übrige 9 Pakete | keine | — |

### `google_mobile_ads`: warum die drei Treffer nicht zählen

- `FlutterInitializationListener.java:43,45` ruft
  `Class.forName("com.google.android.gms.ads.MobileAds")` — genau die Klasse,
  die `proguard-rules.pro` bereits mit
  `-keep class com.google.android.gms.ads.** { *; }` schützt.
- `AdMessageCodec.java:309-311` instanziiert eine `FlutterMediationExtras`-
  Unterklasse aus einem von Dart übergebenen Namen. **Dieser Pfad läuft in
  Qubble nie:** Es gibt keine Mediation-Adapter im Abhängigkeitsbaum
  (`grep -iE "mediation|applovin|ironsource|unityads" pubspec.lock` → leer) und
  der Dart-Code sendet keine Mediation-Extras. Der einzige Mediation-Bezug in
  `lib/` ist ein lesender Zugriff auf `responseInfo?.mediationAdapterClassName`
  für die Umsatzmeldung (`lib/monetization/ads.dart:158`) — ein Getter, nicht
  dieser Pfad. Zudem fängt der Code `ClassNotFoundException` ab.

## Was diese Prüfung nicht abdeckt

Ehrlich zu benennen, sonst wiegt sie in falscher Sicherheit:

1. **Nur die Flutter-Plugin-Quellen**, nicht die darunterliegenden Android-AARs
   (`play-services-ads`, Firebase Android SDK, `billing`). Die bringen eigene
   Consumer-Regeln mit — deshalb ist „keine eigenen Regeln" beim Flutter-Plugin
   ein Anlass zum Nachsehen, kein Befund für sich.
2. **Kein ausgeführter Release-Build.** In dieser Umgebung gibt es kein
   Android-SDK und `dl.google.com` ist gesperrt. Die Keep-Regeln sind
   geschrieben, aber auf keinem Gerät verifiziert.
3. **Der gemeldete Absturz ist damit nicht bewiesen erklärt.** `androidx.startup`
   ist der wahrscheinlichste Kandidat und die Regel ist ergänzt, aber
   `StartupException` hat eine zweite verbreitete Ursache (ein fehlendes oder
   entferntes `<meta-data>` unter dem Provider), die diese Regel nicht behebt.
   Ohne die `Caused by:`-Zeile bleibt das eine begründete Vermutung.

## Was als Nächstes zu tun ist

1. **Release-Build über `build-release.yaml` starten** und auf einem Gerät
   installieren. Das beantwortet gleichzeitig die offenen Punkte aus Phase 2
   (AAB-Größe, gemergtes Manifest, AD_ID).
2. Auf dem Gerät die drei Pfade prüfen, die nur R8-Schaden zeigen:
   App-Start, eine geplante Benachrichtigung **über einen Geräteneustart
   hinweg**, und ein Rewarded-Video.
3. Nach jeder Abhängigkeitsänderung `python3 tool/r8_risk_scan.py` laufen
   lassen.

## Quellen

| Beleg | Art |
|---|---|
| `~/.pub-cache/.../flutter_local_notifications-18.0.1/android/` | Quellen geprüft, keine `*.pro`, Gson 2.8.9 in `build.gradle:48` |
| `~/.pub-cache/.../google_mobile_ads-9.0.0/android/.../AdMessageCodec.java:304-325` | Mediation-Pfad gelesen |
| `~/.pub-cache/.../google_mobile_ads-9.0.0/android/build.gradle:71,75` | `play-services-ads:25.3.0`, `lifecycle-process:2.10.0` |
| <https://developer.android.com/media/platform/supported-formats> | (nicht hier — siehe `audit/02-technik.md`) |
| Gson-Regeln ab > 2.10.1 automatisch | Websuche 2026-08-31, siehe Commit `5650e08` |
