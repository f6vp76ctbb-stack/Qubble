# Play Console — manuelle Prüfliste für 1.2.0 (versionCode 8)

> **Freigabe erteilt (03.09.).** Die Schritt-für-Schritt-Anleitung für das
> Produktions-Release steht in **`docs/RELEASE-1.2.0-PRODUKTION.md`** — diese
> Datei bleibt als Begründungs-Nachschlagewerk daneben stehen.

Alles hier muss ein Mensch in der Play Console bzw. Firebase erledigen; aus
dem Repo heraus geht es nicht. Die Liste für 1.1.0 steht in
`docs/PLAY-CONSOLE-1.1.0.md` und bleibt gültig, wo hier nichts anderes steht.

**Reihenfolge:** A vor B vor C. A1 ist am 03.09. erledigt; damit kann keiner
der übrigen Punkte eine bereits ausgelieferte Funktion mehr betreffen — sie
hängen alle am nächsten Release.

---

## A. Vor dem Upload

- [x] **A1 — Firestore-Regeln veröffentlicht** (03.09., vom Kontoinhaber
      bestätigt und gegen `firebase/firestore.rules` gediffed: byte-identisch,
      `allow delete: if isOwner(uid)` ist live). Der Löschweg wirkt damit
      serverseitig. **Achtung bei künftigen Änderungen:** `rules_version = '2'`
      steht seit der ersten Fassung in der Datei und unterscheidet nichts —
      die veröffentlichte Version erkennt man an der `allow delete`-Zeile.
      Ursprünglicher Text:
      **A1 — Firestore-Regeln veröffentlichen.** `firebase/firestore.rules`
      wurde am 31.08. geändert (`296c2ed`, `allow delete: if isOwner(uid)`).
      **Die Datei im Repo ist nicht die Regel auf dem Server.** Ohne diesen
      Schritt lehnt Firestore jedes Löschen ab und der Löschweg für den
      eigenen Bestenlisten-Eintrag funktioniert nicht — genau der Punkt, den
      Google bei nutzergenerierten Inhalten sehen will (Befund B-3).
      Firebase Console → Firestore Database → Regeln → Inhalt der Datei
      einfügen → **Veröffentlichen**.

- [ ] **A2 — `qubble_neon_theme` anlegen.** Non-Consumable, Vorschlag 2,49 €.
      Der Code kennt das Produkt seit jeher (`IapProducts.neonTheme`,
      Auslieferung in `purchase_delivery.dart:90`), die Console nicht — die
      App fragt also nach einem Produkt, das der Store nicht kennt, und der
      Shop lässt es still weg. `test/store_products_test.dart` hält Code und
      `docs/LAUNCH.md` ab jetzt zusammen.

- [ ] **A3 — Entscheidung: Münzpakete behalten oder streichen?**
      `qubble_coins_s/m/l`. Das Audit empfahl streichen mit der Begründung
      „es geht kein Umsatz verloren, weil heute keiner entsteht". Bei einer
      gesperrten App ist das zirkulär — es sagt nichts darüber, was sie nach
      der Wiederzulassung einbringen. **Empfehlung: behalten**, nach der
      Wiederzulassung drei Monate messen, dann entscheiden. Kein Blocker.

## B. Build und Upload

- [ ] **B1 — CI-Build starten:** Actions → `build-release.yaml` →
      **`test_ads` auf OFF**. Das ist der einzige Schalter, der echte
      AdMob-Einheiten aktiviert; für jeden internen Test bleibt er AN, sonst
      wertet AdMob den Traffic als ungültig.
      Version kommt aus `pubspec.yaml` und steht auf **1.2.0+8**.

- [ ] **B2 — `mapping.txt`** aus dem Build-Run in die Play Console laden,
      sonst sind Crashlytics- und Play-Stacktraces unlesbar.

- [ ] **B3 — Store-Eintrag aktualisieren:**
      - Screenshots neu hochladen (`store-assets/de/`, `store-assets/en/`) —
        sie sind am 03.09. neu erzeugt, weil das Spiel-HUD sich geändert hat
        (Tempo-Anzeige, Booster-Leiste). Alte Bilder zeigen eine App, die es
        nicht mehr gibt; Metadaten-Genauigkeit war Befund B-2.
      - Release Notes aus `docs/release-notes/1.2.0-de.txt` und
        `1.2.0-en.txt` (beide unter Plays 500-Zeichen-Grenze, per Test
        abgesichert).

## C. Nach dem Upload

- [ ] **C1 — Pre-Launch-Report abwarten** und gezielt prüfen: keine Abstürze
      beim Start, keine ANRs, Screenshots zeigen Menü und Spielfeld.
- [ ] **C2 — Android Vitals** in den ersten Tagen beobachten. Der
      R8-Absturz aus 1.1.0 (142 Abstürze, 23 Nutzer) ist behoben und in
      Build #26 verifiziert; die Bestätigung liefert erst echter Traffic.

---

## D. Was sich seit 1.1.0 inhaltlich geändert hat

Für den Fall, dass die Prüfung nachfragt, warum sich Spielverhalten geändert
hat:

| Änderung | Warum |
|---|---|
| Combo zählt **Züge statt Sekunden** | Die Uhr kostete langsame Spieler bis zu 61 % ihrer Punkte (Faktor 2,6 zwischen 1,5 s und 6 s pro Zug, 1.500 Seeds). `BALANCE.md` Nachtrag 3 |
| **Tempo-Bonus, gedeckelt auf 30 %** | Tempo soll zählen, aber nicht entscheiden. Additiv auf eine geräumte Linie, nie im Multiplikator — gemessen +28,6 %. `BALANCE.md` Nachtrag 4 |
| **Keine Emoji** mehr in App-Texten | Der Web-Build holte dafür `NotoColorEmoji` von `fonts.gstatic.com` nach — eine Anfrage, die `web/privacy.html` nicht nennt, und offline ein leeres Kästchen. Befund C-4 |
| Booster bleiben bei großer Schrift | Das Kompakt-Layout entfernte sie ganz — ausgerechnet für Nutzer, die größere Schrift brauchen |

## E. Offen, aber kein Blocker

- **iOS**: `REPLACE_ME_REWARDED_IOS` und `REPLACE_ME_FIREBASE_IOS_APP_ID`.
  Ohne sie liefe iOS ohne Werbeumsatz und ohne Crash-Reporting. Erst relevant
  für die App-Store-Phase.
- **Play Games Services** (Achievements/Bestenlisten): braucht Console-Einträge
  und eine neue Abhängigkeit. Nach der Wiederzulassung neu bewerten.
- **Querformat auf Tablets** ab targetSdk 36 — siehe 1.1.0-Liste, Punkt D.
