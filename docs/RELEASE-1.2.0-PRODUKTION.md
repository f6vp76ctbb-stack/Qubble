# Produktions-Release 1.2.0 — deine Schritte

Die App ist freigegeben. Was hier steht, kann nur ein Mensch erledigen.

> **Zu den Menüpfaden:** Ich sehe die Play Console nicht. In früheren Fassungen
> dieser Anleitung standen Pfade, die es so nicht gibt — ich hatte sie aus dem
> Gedächtnis geschrieben. Deshalb stehen hier nur noch **Werte und Suchbegriffe**,
> keine Klickwege. Wenn ein Formular ein Feld verlangt, das unten fehlt:
> **schick mir den Feldnamen, dann bekommst du den Wert dazu.**

---

## 1 · `qubble_neon_theme` anlegen

Zu finden über die Suche in der Console nach **„In-App-Produkte"** oder
**„In-app products"**.

### Die Werte

| Was | Wert |
|---|---|
| **Produkt-ID** | `qubble_neon_theme` |
| **Typ** | Nicht-Verbrauchsartikel / non-consumable (einmalig, dauerhaft) |
| **Preis** | 2,49 € |
| **Status** | aktiv |

> Die ID muss **exakt** so lauten. Sie ist im Code fest verdrahtet
> (`lib/monetization/iap.dart`), ein Tippfehler macht das Produkt wirkungslos —
> und man sieht nichts davon: Der Shop zeigt nur, was der Store zurückliefert,
> ein unbekanntes Produkt fällt still weg.

### Name (falls nach Sprachen getrennt abgefragt)

| Sprache | Text |
|---|---|
| Deutsch | `Neon-Theme` |
| English | `Neon theme` |

### Beschreibung

| Sprache | Text |
|---|---|
| Deutsch | `Schaltet das Neon-Theme dauerhaft frei: schwarzes Brett, leuchtend grüne und pinke Blöcke. Einmalkauf, kein Abo.` |
| English | `Unlocks the Neon theme permanently: a black board with glowing green and pink blocks. One-time purchase, no subscription.` |

Beide unter 130 Zeichen, damit sie in jedes übliche Feld passen.

### Was du dabei wissen solltest

**Neon ist auch ohne Kauf erreichbar** — für **250 Diamanten** im Spiel
(`lib/ui/theme.dart:172`). Diamanten entstehen durch Tausch: **100 Münzen = 1
Diamant** (`lib/game/economy.dart:11`), also 25.000 Münzen für das Theme. Eine
Runde bringt je nach Verlauf etwa 30 bis 260 Münzen.

Das Produkt ist damit **eine Abkürzung, kein exklusiver Inhalt.** Das ist eine
bewusste Trennung: Exklusiv ist nur, was im Unterstützer-Paket steckt (Aurora
und Kristall) — `CLAUDE.md` verbietet, exklusive Kosmetik für Münzen anzubieten,
und ein Test hält das fest.

**Nichts hängt daran.** Fehlt das Produkt, fehlt nur ein Kaufweg. Es ist kein
Grund, das Release zu verschieben.

---

## 2 · Münzpakete

**Nichts zu tun.** `qubble_coins_s/m/l` behalten. Das Audit riet zum Streichen,
weil „kein Umsatz verloren geht" — bei einer gesperrten App sagt das nichts
darüber, was sie nach der Freigabe einbringen. Drei Monate messen, dann
entscheiden.

---

## 3 · Release-Tag setzen (auf deinem Rechner)

Aus dieser Session heraus geht es nicht: Der Git-Proxy lehnt Pushes nach
`refs/tags/*` mit HTTP 403 ab. Branches gehen durch — bei 1.1.0 war es genauso.

```bash
git fetch origin
git tag -a v1.2.0 origin/main -m "Qubble 1.2.0 (versionCode 8)"
git push origin v1.2.0
```

Alternativ auf GitHub unter **Releases** ein Release aus `main` erstellen.

---

## 4 · Den AAB holen

Er wird nicht hier gebaut, sondern von GitHub Actions. Ich starte den Lauf, du
lädst nur herunter.

Der fertige Lauf heißt **„Build Android Release (.aab)"**. Unten auf der
Seite des Laufs liegen die **Artifacts**:

| Artefakt | Bedeutung |
|---|---|
| `qubble-release-aab-PRODUCTION-ads` | **echte AdMob-Einheiten** — das ist der Store-Build |
| `qubble-release-aab-TEST-ads` | Googles Testeinheiten — **nicht** in die Produktion |

Der Ad-Modus steht ab jetzt im Namen. Vorher sah man dem Bundle nicht an, womit
es gebaut wurde — ein Build mit Testeinheiten wäre in der Produktion gelandet,
ohne dass irgendetwas gewarnt hätte, bis der Umsatz ausbleibt.

Herunterladen, entpacken → `app-release.aab`.

**`mapping.txt` musst du nicht hochladen.** AGP legt die R8-Zuordnung in den AAB
selbst, deshalb bietet die Console dafür kein Feld an. Der Build prüft, dass sie
drin ist, und bricht sonst ab.

---

## 5 · Hochladen und ausrollen

- [ ] `app-release.aab` in einen neuen Produktions-Release hochladen.
      Die Console muss **versionCode 8** und **1.2.0** anzeigen. Weicht das ab,
      ist es der falsche Build.
- [ ] **Release Notes** einfügen:
      - Deutsch: `docs/release-notes/1.2.0-de.txt`
      - English: `docs/release-notes/1.2.0-en.txt`
- [ ] **Screenshots ersetzen** — je 6 Bilder aus `store-assets/de/` und
      `store-assets/en/`. Die alten zeigen ein HUD, das es nicht mehr gibt.
- [ ] **Rollout auf 20 % stellen, nicht auf 100 %.**

**Warum gestaffelt:** In 1.1.0 gab es 142 Abstürze bei 23 Nutzern durch eine
R8-Wechselwirkung. Behoben und im Build verifiziert — aber verifiziert heißt
„auf einem Runner", nicht „auf tausend Geräten". Bei 20 % siehst du ein Problem
an einem Fünftel der Nutzer und kannst anhalten. Bei 100 % ist es draußen.

---

## 6 · Danach beobachten

- [ ] **Pre-Launch-Report**: Google fährt die App auf echten Geräten. Prüfen:
      keine Abstürze beim Start, keine ANRs, die Screenshots zeigen Menü und
      Spielfeld — nicht den Fehlerschirm.
- [ ] **Android Vitals**, erste 48 Stunden. Ziel: crashfrei **> 99,5 %**.
- [ ] Firebase Crashlytics gegenprüfen — dort landen Abstürze schneller.
- [ ] Bleibt es sauber: **Rollout auf 100 %.**

**Bei Abstürzen:** Rollout **anhalten**, nicht zurückziehen — ein Halt lässt
bestehende Installationen in Ruhe. Dann den Crashlytics-Stacktrace hierher.

---

## Was du NICHT tun musst

| | |
|---|---|
| `mapping.txt` hochladen | steckt im AAB |
| Data Safety anfassen | unverändert gültig, im September gegen den Code geprüft |
| Altersfreigabe neu ausfüllen | am 02.09. eingereicht |
| Firestore-Regeln | am 03.09. veröffentlicht, gegen das Repo gediffed |
