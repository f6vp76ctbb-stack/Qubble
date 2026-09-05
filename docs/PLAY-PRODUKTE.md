# In-App-Produkte — vollständige Liste zum Anlegen

**Stand 05.09.2026: Die Liste der Einmalkaufprodukte in der Console ist leer.**
Es fehlt also nicht nur das Neon-Theme, sondern **alle zehn Produkte**.
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
| 8 | `qubble_diamonds_s` | Verbrauchsartikel | 0,99 € |
| 9 | `qubble_diamonds_m` | Verbrauchsartikel | 2,99 € |
| 10 | `qubble_diamonds_l` | Verbrauchsartikel | 7,99 € |

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

## 8-10 · Diamant-Pakete — `qubble_diamonds_s/m/l`

**Korrektur.** Eine frühere Fassung dieses Dokuments behauptete, Diamanten
seien bewusst nicht käuflich. Das war falsch: `MASTERPLAN.md` führt
Diamant-Pakete seit Juli als geplant („später auch per Diamant-Kauf
(Echtgeld)", Z. 79). Ich hatte aus drei Code-Stellen auf Absicht geschlossen,
statt den Plan zu lesen. Die Pakete sind am 05.09. gebaut.

| Produkt-ID | Typ | Preis | Menge |
|---|---|---|---|
| `qubble_diamonds_s` | Verbrauchsartikel | 0,99 € | 100 💎 |
| `qubble_diamonds_m` | Verbrauchsartikel | 2,99 € | 350 💎 |
| `qubble_diamonds_l` | Verbrauchsartikel | 7,99 € | 1000 💎 |

| Sprache | Name | Beschreibung |
|---|---|---|
| DE (S) | `100 Diamanten` | `100 Diamanten für Premium-Skins und -Themes.` |
| EN (S) | `100 diamonds` | `100 diamonds for premium skins and themes.` |
| DE (M) | `350 Diamanten` | `350 Diamanten für Premium-Skins und -Themes. Mehr pro Euro als das kleine Paket.` |
| EN (M) | `350 diamonds` | `350 diamonds for premium skins and themes. Better value than the small pack.` |
| DE (L) | `1000 Diamanten` | `1000 Diamanten für Premium-Skins und -Themes. Bestes Verhältnis.` |
| EN (L) | `1,000 diamonds` | `1,000 diamonds for premium skins and themes. Best value.` |

**Warum diese Mengen:** nicht am Gold-Tausch orientiert — der ist mit 100 Gold
je Diamant bewusst eine Grind-Senke, kein Kurs. Der vorhandene Anker ist
`qubble_neon_theme`: 2,49 € für einen Gegenstand, der im Spiel 250 💎 kostet,
also rund 100 💎 pro Euro.

**Der Gold-Tausch bleibt** (100 Gold = 1 💎, `economy.dart:11`), wie im Plan
vorgesehen: verdienbar, aber langsam. Der teuerste Diamant-Skin (Glow, 50 💎)
kostet damit 5.000 Gold.

---

## Nach dem Anlegen

- Alle zehn auf **aktiv** setzen. Ein inaktives Produkt verhält sich für die
  App wie ein nicht existierendes.
- Einen **Lizenz-Tester** hinterlegen, dann kannst du ohne echte Abbuchung
  kaufen und die Auslieferung prüfen.
- Gegenprüfen im Spiel: Der Shop muss alle Angebote **mit Preis** zeigen.
  Fehlt eines, stimmt seine ID nicht.
