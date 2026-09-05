# Produktions-Release 1.2.0 — deine Schritte

Die App ist freigegeben. Was hier steht, kann nur ein Mensch erledigen.

> **Zu den Menüpfaden:** Ich sehe die Play Console nicht. In früheren Fassungen
> dieser Anleitung standen Pfade, die es so nicht gibt — ich hatte sie aus dem
> Gedächtnis geschrieben. Deshalb stehen hier nur noch **Werte und Suchbegriffe**,
> keine Klickwege. Wenn ein Formular ein Feld verlangt, das unten fehlt:
> **schick mir den Feldnamen, dann bekommst du den Wert dazu.**

---

## 1 · Alle In-App-Produkte anlegen

**Die Liste der Einmalkaufprodukte ist leer — es fehlen alle zehn Produkte,
nicht nur das Neon-Theme.** Solange sie fehlen, ist der Shop in der Produktion
wirkungslos: Die App fragt den Store nach diesen IDs, bekommt nichts zurück und
zeigt die Angebote gar nicht erst an.

Vollständige Liste mit Typ, Preis, Namen und Beschreibungen in DE und EN:
**`docs/PLAY-PRODUKTE.md`** — zehn Einträge, zum Abtippen aufbereitet.

Kurzfassung:

| Produkt-ID | Typ | Preis |
|---|---|---|
| `qubble_supporter` | Nicht-Verbrauchsartikel | 4,99 € |
| `qubble_starter` | Verbrauchsartikel | 1,99 € |
| `qubble_coins_s` | Verbrauchsartikel | 0,99 € |
| `qubble_coins_m` | Verbrauchsartikel | 2,99 € |
| `qubble_coins_l` | Verbrauchsartikel | 7,99 € |
| `qubble_rename` | Verbrauchsartikel | 1,49 € |
| `qubble_neon_theme` | Nicht-Verbrauchsartikel | 2,49 € |
| `qubble_diamonds_s` | Verbrauchsartikel | 0,99 € |
| `qubble_diamonds_m` | Verbrauchsartikel | 2,99 € |
| `qubble_diamonds_l` | Verbrauchsartikel | 7,99 € |

**Diamant-Pakete sind dazugekommen** (`qubble_diamonds_s/m/l`). Sie standen
seit Juli als „geplant" im `MASTERPLAN.md`, waren aber nie gebaut — eine
frühere Fassung dieses Dokuments hat das fälschlich als Absicht ausgelegt. Der
Gold-Tausch bleibt daneben bestehen (100 Gold = 1 Diamant, bewusst langsam).

**Blockiert das Release?** Nein. Ohne Produkte funktioniert das Spiel
vollständig, nur der Shop bleibt leer. Du kannst also hochladen und die
Produkte danach nachziehen — sie brauchen kein neues Bundle.

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
