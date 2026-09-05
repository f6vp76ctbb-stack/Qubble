# Produktions-Release 1.2.0 — deine Schritte

Die App ist freigegeben. Was hier steht, kann nur ein Mensch in der Play
Console bzw. auf deinem Rechner tun. Alles Übrige ist erledigt.

**Reihenfolge:** 1 → 2 → 3 → 4. Schritt 3 ist der Punkt ohne Rückwärtsgang.

---

## 1 · Vor dem Upload (5 Minuten)

### 1.1 `qubble_neon_theme` anlegen

**Monetarisierung → Produkte → In-App-Produkte → Produkt erstellen**

| Feld | Wert |
|---|---|
| Produkt-ID | `qubble_neon_theme` (exakt, Tippfehler = Produkt funktioniert nie) |
| Typ | **Nicht-Verbrauchsartikel** |
| Name | Neon-Theme |
| Preis | 2,49 € (Vorschlag) |
| Status | **Aktiv** |

Warum: Der Code kennt das Produkt und liefert es aus
(`purchase_delivery.dart:90`), die Console kannte es nie. Bis dahin fragt die
App nach etwas, das der Store nicht hat — der Shop lässt es still weg.

**Ohne diesen Schritt ist nichts kaputt**, es fehlt nur ein verkäufliches
Produkt. Kein Grund, das Release aufzuhalten.

### 1.2 Münzpakete: Entscheidung

`qubble_coins_s/m/l` behalten oder streichen? **Meine Empfehlung: behalten.**
Das Audit riet zum Streichen mit der Begründung „es geht kein Umsatz verloren,
weil heute keiner entsteht" — bei einer gesperrten App ist das zirkulär. Was
sie nach der Freigabe einbringen, weiß niemand. Drei Monate messen, dann
entscheiden. **Nichts zu tun.**

### 1.3 Release-Tag setzen (auf deinem Rechner)

Aus dieser Session heraus geht es nicht — der Git-Proxy lehnt Pushes nach
`refs/tags/*` mit HTTP 403 ab (Branches gehen durch, bei 1.1.0 war es genauso).

```bash
git fetch origin
git tag -a v1.2.0 origin/main -m "Qubble 1.2.0 (versionCode 8)"
git push origin v1.2.0
```

Oder in der GitHub-Weboberfläche unter **Releases → Draft a new release**.

---

## 2 · Den AAB holen

Der Build läuft in GitHub Actions; ich starte ihn. Du lädst nur herunter.

1. **Actions → Build release bundle →** der Lauf für `main`.
2. Unter **Artifacts** liegt **`qubble-release-aab-PRODUCTION-ads`**.

> **Am Namen erkennst du den Ad-Modus.** Heißt das Artefakt
> `…-TEST-ads`, wurde mit Googles Testeinheiten gebaut — das darf **nicht**
> in die Produktion. Dann sag mir Bescheid, ich starte neu.

3. Entpacken → `app-release.aab`.

`mapping.txt` musst du **nicht** hochladen: AGP legt die R8-Zuordnung in den
AAB selbst, deshalb zeigt die Console dafür kein Feld. Der Build prüft, dass
sie drin ist, und bricht sonst ab.

---

## 3 · Hochladen und ausrollen

**Produktion → Neuen Release erstellen**

- [ ] `app-release.aab` hochladen. Die Console muss **versionCode 8** und
      **Versionsname 1.2.0** anzeigen. Weicht das ab, ist es der falsche Build.
- [ ] **Release Notes** einfügen — Text aus:
      - `docs/release-notes/1.2.0-de.txt`
      - `docs/release-notes/1.2.0-en.txt`
      Beide liegen unter Plays 500-Zeichen-Grenze (per Test abgesichert).
- [ ] **Screenshots ersetzen** — je 6 Bilder aus `store-assets/de/` und
      `store-assets/en/`. Die alten zeigen ein HUD, das es nicht mehr gibt
      (Tempo-Anzeige, neue Booster-Leiste). Store-Bilder müssen die App
      abbilden — Metadaten-Genauigkeit war einer der Audit-Befunde.
- [ ] **Rollout-Prozentsatz: mit 20 % starten**, nicht 100 %.

**Warum gestaffelt:** In 1.1.0 gab es 142 Abstürze bei 23 Nutzern durch eine
R8-Wechselwirkung. Die Ursache ist behoben und im Build verifiziert, aber
verifiziert heißt hier „auf einem Runner", nicht „auf tausend Geräten". Bei
20 % siehst du ein Problem an ~einem Fünftel der Nutzer und kannst den Rollout
anhalten. Bei 100 % ist es draußen.

---

## 4 · Danach beobachten

- [ ] **Pre-Launch-Report** (Testen → Pre-Launch-Report). Google fährt die App
      auf echten Geräten. Gezielt prüfen: keine Abstürze beim Start, keine
      ANRs, die Screenshots zeigen Menü und Spielfeld — nicht den Fehlerschirm.
- [ ] **Android Vitals**, erste 48 Stunden. Zielwert crashfrei **> 99,5 %**.
- [ ] Bleibt es sauber: **Rollout auf 100 % erhöhen.**
- [ ] Firebase → Crashlytics gegenprüfen; dort landen Abstürze schneller als
      in Vitals.

**Wenn Abstürze auftreten:** Rollout sofort anhalten (nicht zurückziehen — ein
Halt lässt bestehende Installationen in Ruhe), Crashlytics-Stacktrace hierher,
dann sehen wir weiter.

---

## Was du NICHT tun musst

- `mapping.txt` hochladen — steckt im AAB (siehe 2).
- Data Safety anfassen — unverändert gültig, im September Zeile für Zeile
  gegen den Code geprüft.
- Altersfreigabe neu ausfüllen — am 02.09. eingereicht.
- Firestore-Regeln — am 03.09. veröffentlicht, gegen das Repo gediffed.
