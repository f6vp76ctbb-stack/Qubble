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
3. **Der gemeldete Absturz ist nicht bewiesen erklärt** — die Kandidatenliste
   ließ sich seitdem aber von „begründeter Vermutung" auf drei benannte
   Codestellen einengen. Siehe den folgenden Abschnitt.

## Nachtrag: Was `StartupException.java:35` ausschließt

Die gemeldete Zeile ist nicht Beiwerk, sie trägt Information. Der Quelltext von
`androidx.startup` (AOSP, abgerufen 2026-09-01):

```java
29 public final class StartupException extends RuntimeException {
30     public StartupException(@NonNull String message) {
31         super(message);
32     }
33
34     public StartupException(@NonNull Throwable throwable) {
35         super(throwable);          // <- die gemeldete Zeile
36     }
```

Zeile 35 liegt im Konstruktor, der **eine Ursache einpackt**. Damit ist
gesichert: Der Absturzbericht hat eine `Caused by:`-Zeile, und jede
`StartupException`, die nur eine Meldung trägt, scheidet aus.

In `AppInitializer.java` gibt es genau drei Stellen, die diesen Konstruktor
verwenden:

| Stelle | Ursache | R8-relevant? |
|---|---|---|
| `AppInitializer.java:181` | `catch (Throwable)` um `component.getDeclaredConstructor().newInstance()`, den Cast auf `Initializer`, `dependencies()` und `create(mContext)` | **ja** |
| `AppInitializer.java:203` | `PackageManager.NameNotFoundException` aus `getProviderInfo(provider, GET_META_DATA)` — der **Provider selbst** fehlt im gemergten Manifest | nein |
| `AppInitializer.java:237` | `ClassNotFoundException` aus `Class.forName(key)` über den `<meta-data>`-Namen | **ja** |

**Damit ist die zweite Ursache, die dieses Dokument vorher offenließ,
widerlegt.** Ein *fehlendes* `<meta-data>` kann diese Ausnahme nicht auslösen:

```java
void discoverAndInitialize(@Nullable Bundle metadata) {
    ...
    if (metadata != null) {        // <- alles Weitere hängt daran
```

Ein fehlendes oder leeres Bundle initialisiert schlicht nichts und wirft nichts.
Der Manifest-Pfad (`:203`) betrifft den **Provider**, nicht seine Metadaten —
und weder das App-Manifest noch irgendein Plugin entfernt ihn:
`grep -rn 'tools:node="remove"' android/ ~/.pub-cache/hosted/*/*/android/`
liefert nichts.

### Die wahrscheinlichste Ursache, mit dokumentiertem Mechanismus

`:181` umschließt `component.getDeclaredConstructor().newInstance()`. Zu R8 im
Full Mode dokumentiert Google ausdrücklich:

> Unlike compatibility mode, full mode removes the no-args/default constructor
> even when the class itself is retained.
> — <https://developer.android.com/topic/performance/app-optimization/full-mode>,
> abgerufen 2026-09-01

Full Mode ist seit AGP 8.0 die Voreinstellung; `android/gradle.properties`
setzt `android.enableR8.fullMode` nicht, das Projekt baut also mit AGP 9.0.1
(`android/settings.gradle.kts:22`) im Full Mode. Ein entfernter
Standardkonstruktor an einem `Initializer` ergibt `NoSuchMethodException` →
`catch (Throwable)` → `StartupException.java:35`. Das passt vollständig auf den
gemeldeten Bericht.

Die dokumentierte Abhilfe ist genau die Form, die seit `b3bd70d` in
`android/app/proguard-rules.pro:75-77` steht — Klasse **und** parameterloser
Konstruktor:

```
-keep class * extends androidx.startup.Initializer {
    <init>();
}
```

### Eine Falle, die diese Regel fast gehabt hätte

`androidx.startup.Initializer` ist ein **Interface**
(`Initializer.java:32: public interface Initializer<T>`), die Regel schreibt
aber `extends`. Das ist kein Fehler: ProGuards Parser behandelt beide
Schlüsselwörter im selben Zweig und schreibt sie in dasselbe Feld —
`ConfigurationParser.java` prüft
`IMPLEMENTS_KEYWORD.equals(nextWord) || EXTENDS_KEYWORD.equals(nextWord)` und
belegt danach in beiden Fällen `extendsClassName`. Es gibt keine getrennte
Speicherung, die Schlüsselwörter sind austauschbar. Geprüft am Quelltext, nicht
aus dem Gedächtnis — bei einer Regel, deren einziger Zweck ein
Startabsturz ist, wäre ein stillschweigend nicht greifendes Muster der
schlechteste denkbare Fehler.

### Was das für die Bewertung heißt

Zwei der drei möglichen Ursachen sind R8-Ursachen, und beide sind von den
vorhandenen Regeln abgedeckt (`:181` durch den `<init>()`-Keep, `:237` durch
den Klassennamen-Keep). Die dritte (`:203`) ist im Quelltext ausgeschlossen,
soweit Quelltext das kann — sie könnte nur noch aus einem AAR-Manifest kommen,
das ohne Build nicht sichtbar ist.

**Der Absturz bleibt trotzdem unbewiesen erklärt.** Was fehlt, ist genau eine
Angabe: die `Caused by:`-Zeile. `NoSuchMethodException` bestätigt `:181`,
`ClassNotFoundException` bestätigt `:237`, `NameNotFoundException` widerlegt
beide Fixes und verweist auf das gemergte Manifest.

## Nachtrag 2026-09-01: Was dieser Scan übersehen hat

Crashlytics hat den Absturz geliefert, und er liegt **außerhalb dessen, was
dieses Dokument geprüft hat**:

> `Failed to create an instance of androidx.work.impl.WorkDatabase`
> — 80 Abstürze bei 14 Nutzern, dazu zwei verwandte Einträge; zusammen
> 142 Abstürze bei 23 Nutzern.

**WorkManager** kommt transitiv mit dem Google-Mobile-Ads-SDK herein (die
Changelog-Notiz von `google_mobile_ads` zu `androidx.work:work-runtime` belegt
die Abhängigkeit), wird von `androidx.startup` initialisiert, und sein
`WorkDatabase` ist eine **Room**-Datenbank.

Der vollständige Stacktrace erlaubt eine schärfere Aussage als „Reflexion
schlägt fehl":

```
java.lang.RuntimeException: Failed to create an instance of androidx.work.impl.WorkDatabase
  at androidx.room.Room.getGeneratedImplementation(Room.java:100)
  at androidx.work.impl.WorkDatabase.create(WorkDatabase.java:155)
  at androidx.work.WorkManagerInitializer.create(WorkManagerInitializer.java:39)
  at androidx.startup.AppInitializer.doInitialize(AppInitializer.java:180)
```

`Room.getGeneratedImplementation` wirft an dieser Stelle drei unterscheidbare
Meldungen:

| Ausnahme | Meldung |
|---|---|
| `ClassNotFoundException` | „cannot find implementation for …" |
| `IllegalAccessException` | „Cannot access the constructor …" |
| **`InstantiationException`** | **„Failed to create an instance of …"** |

Wir haben die dritte. **Die Klasse wurde also gefunden** — ihr Name hat die
Obfuskierung überlebt. Gefehlt hat der **parameterlose Konstruktor**. Das ist
wörtlich das, was Google für R8 Full Mode dokumentiert: „removes the
no-args/default constructor even when the class itself is retained".

Das erklärt zugleich, warum die Consumer-Regeln von WorkManager und Room nicht
gerettet haben: Sie erhalten Namen. Hier genügt ein Name nicht — die Regel muss
Member mitnehmen (`{ *; }`). Eine Keep-Regel, die nur den Klassennamen schützt,
hätte diesen Absturz **nicht** verhindert, und genau darin lag mein Denkfehler
bei der ersten Fassung dieser Regeln.

**Die Einschränkung oben hat genau das vorhergesagt** („nur Flutter-Plugin-
Quellen geprüft, nicht die transitiven AARs, die eigene Consumer-Regeln
mitbringen"). Die Annahme war, dass Room und WorkManager ihre Consumer-Regeln
mitliefern und das genügt. Unter R8 Full Mode hat es nicht genügt.

Die Initializer-Keep-Regel aus `b3bd70d` war **notwendig, aber nicht
hinreichend**: Sie schützt die Initializer-Klasse, nicht die Room-Klasse, die
deren `create()` anfasst. Ergänzt in `android/app/proguard-rules.pro`,
abgesichert in `test/release_gates_test.dart`.

### Alle drei Crashlytics-Einträge sind derselbe Fehler

Die Liste zeigte drei „neue Probleme" mit unterschiedlichen Klassen, was nach
drei Ursachen aussah. Der dritte Trace löst das auf:

```
Caused by androidx.fragment.app.g0: java.lang.RuntimeException:
    Failed to create an instance of androidx.work.impl.WorkDatabase
  at androidx.startup.StartupException.<init>(StartupException.java:35)
```

Die geworfene Klasse heißt `androidx.fragment.app.g0`, und der erste Frame
darunter ist der Konstruktor von `androidx.startup.StartupException`.
**`androidx.fragment.app.g0` *ist* die `StartupException`** — R8 Full Mode
verschiebt Klassen beim Obfuskieren über Paketgrenzen hinweg (Repackaging).
Crashlytics hat die Frames über die Mapping-Datei zurückübersetzt, den
Klassennamen in der Kopfzeile aber nicht.

**Ein obfuskierter Paketname sagt also nichts über die Herkunft der Klasse.**
`androidx.fragment.app.g0` sah nach einem Fragment-Problem aus und war keins.
Wer beim nächsten Mal aus einem obfuskierten Namen auf die Bibliothek schließt,
sucht an der falschen Stelle — der `Caused by`-Block ist die einzige
verlässliche Quelle.

Damit gehen alle **142 Abstürze bei 23 Nutzern** auf eine einzige Ursache
zurück, und die eine Keep-Regel deckt sie vollständig ab.

**Was daraus für die Methode folgt:** Ein Scan über Plugin-Quellen findet
Reflexion in den Plugins, nicht in dem, was die Plugins mitbringen. Wer das
vollständig will, braucht `./gradlew app:dependencies` gegen den echten
Abhängigkeitsbaum — in dieser Umgebung nicht ausführbar, aber im CI-Build
verfügbar.

**Nicht tun**, obwohl die Crashlytics-Zusammenfassung es vorschlägt: den
`InitializationProvider` per `tools:node="remove"` aus dem Manifest werfen.
`AppInitializer.discoverAndInitialize` holt sich den Provider über
`getProviderInfo` (Zeile 199-203) und wirft bei dessen Fehlen eine
`NameNotFoundException` — verpackt in dieselbe `StartupException`. Das tauscht
einen Absturz gegen einen anderen.

## Was als Nächstes zu tun ist

1. **Release-Build über `build-release.yaml` starten** und auf einem Gerät
   installieren. Das beantwortet gleichzeitig die offenen Punkte aus Phase 2
   (AAB-Größe, gemergtes Manifest, AD_ID).
2. Auf dem Gerät die drei Pfade prüfen, die nur R8-Schaden zeigen:
   App-Start, eine geplante Benachrichtigung **über einen Geräteneustart
   hinweg**, und ein Rewarded-Video.
3. Nach jeder Abhängigkeitsänderung `python3 tool/r8_risk_scan.py` laufen
   lassen.
4. **Die `Caused by:`-Zeile des gemeldeten Absturzes beschaffen** — sie
   entscheidet zwischen den drei Kandidaten oben und kostet nichts. In der
   Play Console steht sie unter Qualität → Absturzberichte beim jeweiligen
   Bericht; in Crashlytics direkt unter dem obersten Rahmen. Ebenfalls
   nützlich: woher der Bericht stammt (CI-Bundle, lokaler Release-Build oder
   Play Vitals) — ein Bericht aus einem Debug-Build würde R8 als Ursache
   vollständig ausschließen.

## Quellen

| Beleg | Art |
|---|---|
| `~/.pub-cache/.../flutter_local_notifications-18.0.1/android/` | Quellen geprüft, keine `*.pro`, Gson 2.8.9 in `build.gradle:48` |
| `~/.pub-cache/.../google_mobile_ads-9.0.0/android/.../AdMessageCodec.java:304-325` | Mediation-Pfad gelesen |
| `~/.pub-cache/.../google_mobile_ads-9.0.0/android/build.gradle:71,75` | `play-services-ads:25.3.0`, `lifecycle-process:2.10.0` |
| <https://developer.android.com/media/platform/supported-formats> | (nicht hier — siehe `audit/02-technik.md`) |
| Gson-Regeln ab > 2.10.1 automatisch | Websuche 2026-08-31, siehe Commit `5650e08` |
| <https://raw.githubusercontent.com/androidx/androidx/androidx-main/startup/startup-runtime/src/main/java/androidx/startup/StartupException.java> | Quelltext, abgerufen 2026-09-01 — Zeile 35 = `StartupException(Throwable)` |
| <https://raw.githubusercontent.com/androidx/androidx/androidx-main/startup/startup-runtime/src/main/java/androidx/startup/AppInitializer.java> | Quelltext, abgerufen 2026-09-01 — drei Aufrufstellen, `if (metadata != null)` |
| <https://raw.githubusercontent.com/androidx/androidx/androidx-main/startup/startup-runtime/src/main/java/androidx/startup/Initializer.java> | Quelltext, abgerufen 2026-09-01 — `Initializer` ist ein Interface |
| <https://developer.android.com/topic/performance/app-optimization/full-mode> | Primärquelle, abgerufen 2026-09-01 — Full Mode seit AGP 8.0 Standard, entfernt den Standardkonstruktor |
| <https://developer.android.com/build/releases/agp-9-0-0-release-notes> | Primärquelle, abgerufen 2026-09-01 — AGP 9.0 unterstützt nur noch `proguard-android-optimize.txt` (das Projekt verwendet sie bereits, `build.gradle.kts:78`) |
| <https://raw.githubusercontent.com/Guardsquare/proguard/master/base/src/main/java/proguard/ConfigurationParser.java> | Quelltext, abgerufen 2026-09-01 — `extends` und `implements` teilen sich einen Zweig und ein Feld |
