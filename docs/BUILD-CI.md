# App bauen ohne Computer (GitHub-Auto-Build)

Baut die signierte Play-Store-Datei (`.aab`) direkt auf GitHub — du brauchst
**keinen** Rechner mit Flutter, nur einen Browser. Workflow:
`.github/workflows/build-release.yaml`.

## Einmalig: 4 Signatur-Geheimnisse (+ 1 optionales) hinterlegen

GitHub → dein Repo `f6vp76ctbb-stack/Qubble` → **Settings** →
**Secrets and variables** → **Actions** → **New repository secret**. Lege
diese an (Name exakt so):

| Secret-Name | Wert |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | der lange base64-Text aus der Datei `qubble-upload.jks.b64` (alles markieren + einfügen) |
| `ANDROID_KEYSTORE_PASSWORD` | das Store-Passwort (bekommst du von Claude) |
| `ANDROID_KEY_PASSWORD` | das Key-Passwort (bekommst du von Claude) |
| `ANDROID_KEY_ALIAS` | `upload` |
| `GOOGLE_SERVICES_JSON` *(optional)* | kompletter Inhalt deiner `google-services.json` (für Firebase im Release) |

> **Wichtig:** Bewahre die Schlüssel-Datei (`qubble-upload.jks`) und die beiden
> Passwörter sicher auf (z. B. Passwort-Manager). Mit dieser Datei werden alle
> App-Updates signiert. Falls sie verloren geht: Bei **Play App Signing**
> (unten) kann Google den Upload-Schlüssel zurücksetzen — also kein Weltuntergang,
> aber Backup ist besser.

## Bauen (jedes Mal, wenn du eine neue Datei brauchst)

1. GitHub → Tab **Actions** → links **„Build Android Release (.aab)"**
2. Rechts **„Run workflow"** → **„Run workflow"** (grüner Knopf)
3. ~5–10 Minuten warten, bis der Lauf grün ist
4. Den Lauf öffnen → unten unter **„Artifacts"** → **`qubble-release-aab`**
   herunterladen → darin liegt `app-release.aab`

5. Optional **`qubble-r8-mapping`** herunterladen → darin liegt `mapping.txt`.
   **Nicht für den Upload nötig** (siehe unten), aber praktisch als Archiv,
   falls du einen Stacktrace mal von Hand entschlüsseln willst.

## Diese Datei in die Play Console

- Play Console → deine App → **Test** (z. B. Geschlossener Test) oder
  **Produktion** → **Neue Version erstellen** → `.aab` hochladen.
- **Die Mapping-Datei musst du nicht hochladen.** Bei einem App Bundle bettet
  der Android-Build sie in die `.aab` ein, und die Play Console liest sie von
  dort — deshalb findest du dort auch kein Upload-Feld dafür. Das Feld
  „Offenlegungsdateien" gibt es nur beim APK-Upload. Der Build prüft die
  Einbettung inzwischen selbst und schlägt fehl, wenn sie fehlt.
- Beim ersten Upload fragt Google nach **Play App Signing** → **aktivieren**
  (empfohlen). Google verwaltet dann den finalen Signaturschlüssel; unser
  Keystore ist nur der Upload-Schlüssel.
- **Versionscode: Jede hochgeladene `.aab` braucht eine neue Nummer.** Der Teil
  nach dem `+` in `pubspec.yaml` muss steigen — und zwar auch dann, wenn der
  vorige Build nur *hochgeladen*, aber nie veröffentlicht wurde: Google merkt
  sich jede Nummer, die es je gesehen hat. Kommt beim Upload „Versionscode X
  wurde bereits verwendet", ist genau das passiert. Sag Bescheid, dann zähle
  ich hoch (drei Stellen: `pubspec.yaml`, `lib/app_info.dart` und der Test, der
  beide aneinander bindet).

## Wenn der Build fehlschlägt

Öffne den roten Lauf → das Log zeigt den Fehler. Häufig:
- Ein Secret fehlt/vertippt → oben erscheint „ANDROID_KEYSTORE_BASE64 secret
  is not set".
- Schick Claude die letzten Zeilen des Logs, dann fixt er es.
