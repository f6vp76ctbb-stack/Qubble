# In-App-Produkte — vollständige Liste zum Anlegen

**Stand 05.09.2026: Die Liste der Einmalkaufprodukte in der Console ist leer.**
Es fehlt also nicht nur das Neon-Theme, sondern **alle sieben Produkte**.
Solange sie fehlen, ist der Shop in der Produktion wirkungslos: Die App fragt
den Store nach diesen IDs, bekommt nichts zurück, und zeigt die Angebote gar
nicht erst an (`StoreIap.products` bleibt leer).

> Ich sehe die Play Console nicht und rate keine Menüpfade mehr. Hier stehen
> nur Werte. **Verlangt ein Formularfeld etwas, das hier fehlt: Feldnamen
> schicken, dann kommt der Wert.**

Alle IDs sind im Code fest verdrahtet (`lib/monetization/iap.dart`). Ein
Tippfehler macht das Produkt wirkungslos, und man sieht nichts davon — der Shop
zeigt nur, was der Store zurückliefert.

---

## Übersicht

| # | Produkt-ID | Typ | Preis |
|---|---|---|---|
| 1 | `qubble_supporter` | Nicht-Verbrauchsartikel | 4,99 € |
| 2 | `qubble_starter` | Verbrauchsartikel | 1,99 € |
| 3 | `qubble_coins_s` | Verbrauchsartikel | 0,99 € |
| 4 | `qubble_coins_m` | Verbrauchsartikel | 2,99 € |
| 5 | `qubble_coins_l` | Verbrauchsartikel | 7,99 € |
| 6 | `qubble_rename` | Verbrauchsartikel | 1,49 € |
| 7 | `qubble_neon_theme` | Nicht-Verbrauchsartikel | 2,49 € |

**Verbrauchsartikel** = mehrfach kaufbar (Münzen, Namensänderung).
**Nicht-Verbrauchsartikel** = einmalig, dauerhaft, wiederherstellbar.

Die Zuordnung stammt aus `IapProducts.isConsumable` — sie muss stimmen: Ein
dauerhafter Inhalt als Verbrauchsartikel angelegt könnte doppelt abgerechnet
werden, ein Münzpaket als Nicht-Verbrauchsartikel nur einmal.

---

## 1 · `qubble_supporter` — 4,99 € — Nicht-Verbrauchsartikel

| | |
|---|---|
| Name (DE) | `Unterstützer-Paket` |
| Name (EN) | `Supporter pack` |
| Beschreibung (DE) | `Danke-Paket: exklusives Aurora-Theme, exklusiver Kristall-Skin, 1500 Münzen und ein Abzeichen neben deinem Namen. Einmalig, bleibt dauerhaft.` |
| Beschreibung (EN) | `A thank-you pack: exclusive Aurora theme, exclusive Crystal skin, 1,500 coins and a badge next to your name. One-time, kept forever.` |

Aurora und Kristall sind **die einzigen exklusiven Inhalte** — sie sind für
Münzen nie erhältlich (`CLAUDE.md`, per Test abgesichert).

## 2 · `qubble_starter` — 1,99 € — Verbrauchsartikel

| | |
|---|---|
| Name (DE) | `Starter-Paket` |
| Name (EN) | `Starter pack` |
| Beschreibung (DE) | `1200 Münzen und das Wood-Theme. Einmaliges Angebot ab der fünften Runde, 48 Stunden gültig.` |
| Beschreibung (EN) | `1,200 coins and the Wood theme. A one-time offer from your fifth run, valid for 48 hours.` |

## 3 · `qubble_coins_s` — 0,99 € — Verbrauchsartikel

| | |
|---|---|
| Name (DE) | `500 Münzen` |
| Name (EN) | `500 coins` |
| Beschreibung (DE) | `500 Münzen für Booster, Themes und Skins.` |
| Beschreibung (EN) | `500 coins for boosters, themes and skins.` |

## 4 · `qubble_coins_m` — 2,99 € — Verbrauchsartikel

| | |
|---|---|
| Name (DE) | `2000 Münzen` |
| Name (EN) | `2,000 coins` |
| Beschreibung (DE) | `2000 Münzen für Booster, Themes und Skins.` |
| Beschreibung (EN) | `2,000 coins for boosters, themes and skins.` |

## 5 · `qubble_coins_l` — 7,99 € — Verbrauchsartikel

| | |
|---|---|
| Name (DE) | `6000 Münzen` |
| Name (EN) | `6,000 coins` |
| Beschreibung (DE) | `6000 Münzen für Booster, Themes und Skins.` |
| Beschreibung (EN) | `6,000 coins for boosters, themes and skins.` |

## 6 · `qubble_rename` — 1,49 € — Verbrauchsartikel

| | |
|---|---|
| Name (DE) | `Namensänderung` |
| Name (EN) | `Name change` |
| Beschreibung (DE) | `Ändere deinen Namen in der Bestenliste einmal. Rein kosmetisch, kein Spielvorteil.` |
| Beschreibung (EN) | `Change your leaderboard name once. Cosmetic only, no gameplay advantage.` |

## 7 · `qubble_neon_theme` — 2,49 € — Nicht-Verbrauchsartikel

| | |
|---|---|
| Name (DE) | `Neon-Theme` |
| Name (EN) | `Neon theme` |
| Beschreibung (DE) | `Schaltet das Neon-Theme dauerhaft frei: schwarzes Brett, leuchtend grüne und pinke Blöcke.` |
| Beschreibung (EN) | `Unlocks the Neon theme permanently: a black board with glowing green and pink blocks.` |

**Neon ist auch ohne Kauf erreichbar** — für 250 Diamanten im Spiel
(`lib/ui/theme.dart:172`). Es ist eine Abkürzung, kein exklusiver Inhalt.

---

## Diamanten: gibt es bewusst nicht zu kaufen

Es fehlt **kein** Diamanten-Produkt. Diamanten sind kein Kaufartikel, sondern
entstehen ausschließlich durch Tausch im Spiel: **100 Münzen = 1 Diamant**
(`lib/game/economy.dart:11`). Der Shop bietet sie nirgends zum Kauf an, und der
Code kennt keinen Auslieferungspfad dafür (`purchase_delivery.dart`).

Wer das ändern wollte, bräuchte ein neues Produkt **und** Code — beides fehlt,
und zwar konsistent. Es ist keine Lücke.

---

## Nach dem Anlegen

- Alle sieben auf **aktiv** setzen. Ein inaktives Produkt verhält sich für die
  App wie ein nicht existierendes.
- Einen **Lizenz-Tester** hinterlegen, dann kannst du ohne echte Abbuchung
  kaufen und die Auslieferung prüfen.
- Gegenprüfen im Spiel: Der Shop muss alle Angebote **mit Preis** zeigen.
  Fehlt eines, stimmt seine ID nicht.
