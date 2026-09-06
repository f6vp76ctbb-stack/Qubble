# In-App-Produkte anlegen — Feld für Feld

**Stand 06.09.2026: Die Liste der Einmalkaufprodukte ist leer.** Es fehlen
**alle zehn** Produkte. Solange sie fehlen, ist der Shop in der Produktion
wirkungslos: Die App fragt den Store nach diesen IDs, bekommt nichts zurück und
zeigt gar keine Angebote an.

Diese Anleitung folgt dem Formular, das du mir geschickt hast. Frühere
Fassungen enthielten Menüpfade, die ich mir aus dem Gedächtnis zusammengesetzt
hatte — die sind raus. **Taucht ein Feld auf, das hier fehlt: schick mir den
Feldnamen.**

---

## Was das Formular fragt — und was rein muss

### Schritt 1 · Produktdetails

| Feld | Was rein muss |
|---|---|
| **Produkt-ID \*** | die ID aus der Tabelle unten, **exakt**. Nicht änderbar und nicht wiederverwendbar, nach dem Anlegen |
| **Tags** | **leer lassen.** Optional, hat für uns keine Funktion |
| **Name \*** (max. 55) | aus der Tabelle. Das sieht der Nutzer im Einkaufswagen |
| **Beschreibung \*** (max. 200) | aus der Tabelle |
| **Symbol** | PNG aus `store-assets/product-icons/<produkt-id>.png` — ich habe für jedes Produkt eins erzeugt: 512×512, 32-Bit-RGBA, 1:1, ohne Text und ohne Branding, wie das Formular es verlangt |
| **Produktsteuerkategorie** | **Verkäufe digitaler Apps** (steht dort meist schon) |
| **Altersfreigabe** | **leer lassen.** Kein Produkt hat andere Inhalte als die App |
| **Beschränkungen des Zahlungsortes** | **Kein Land / keine Region beschränkt** (Voreinstellung lassen) |

### Schritt 2 · Verfügbarkeit und Preisgestaltung

| Feld | Was rein muss |
|---|---|
| **Kaufoptions-ID \*** (max. 63) | `standard` — bei **allen zehn** gleich. Der Nutzer sieht sie nie; sie muss nur pro Produkt eindeutig sein, und jedes Produkt hat genau eine |
| **Kauftyp \*** | **Kaufen** |
| **Tags** | leer lassen |
| **Verfügbarkeit** | **Alle Regionen** — nicht Land für Land durchgehen. Die App ist überall verfügbar, also die Produkte auch |
| **Preis** | ⚠️ **offen — siehe unten** |

> ### ⚠️ Was ich noch von dir brauche: das Preisfeld
>
> In dem Formularausschnitt, den du geschickt hast, kommt **kein Preisfeld
> vor** — nur die Länderliste mit Mehrwertsteuersätzen und „Verfügbar".
> Ich weiß deshalb nicht, wo der Preis eingetragen wird: ein Basispreis für
> alle Regionen, oder je Land.
>
> **Schick mir den Abschnitt, in dem der Preis abgefragt wird**, dann trage ich
> die Werte hier ein. Bis dahin steht in der Tabelle unten die Preisabsicht
> (0,99 / 1,49 / 1,99 / 2,49 / 2,99 / 4,99 / 7,99 €) — wo genau sie hingehört,
> rate ich nicht.

> **Zur Kaufoptions-ID:** Das ist das neue Play-Modell (ein Produkt kann mehrere
> Kaufoptionen haben). Die App fragt nach der **Produkt-ID**, nicht nach der
> Kaufoptions-ID — deshalb ist `standard` als Konvention unkritisch. **Prüfen
> statt glauben:** Nach dem Anlegen die App öffnen; im Shop muss jedes Angebot
> **mit Preis** erscheinen. Fehlt eines, stimmt seine Produkt-ID nicht.

---

## Die zehn Produkte

### 1 · `qubble_supporter` — 4,99 € — Nicht-Verbrauchsartikel

| | |
|---|---|
| Name | `Unterstützer-Paket` |
| Beschreibung | `Danke-Paket: exklusives Aurora-Theme, exklusiver Kristall-Skin, 1500 Münzen und ein Abzeichen neben deinem Namen. Einmalig, bleibt dauerhaft.` |
| Symbol | `store-assets/product-icons/qubble_supporter.png` |

### 2 · `qubble_starter` — 1,99 € — Verbrauchsartikel

| | |
|---|---|
| Name | `Starter-Paket` |
| Beschreibung | `1200 Münzen und das Wood-Theme. Einmaliges Angebot ab der fünften Runde, 48 Stunden gültig.` |
| Symbol | `store-assets/product-icons/qubble_starter.png` |

### 3 · `qubble_coins_s` — 0,99 € — Verbrauchsartikel

| | |
|---|---|
| Name | `500 Münzen` |
| Beschreibung | `500 Münzen für Booster, Themes und Skins.` |
| Symbol | `store-assets/product-icons/qubble_coins_s.png` |

### 4 · `qubble_coins_m` — 2,99 € — Verbrauchsartikel

| | |
|---|---|
| Name | `2000 Münzen` |
| Beschreibung | `2000 Münzen für Booster, Themes und Skins.` |
| Symbol | `store-assets/product-icons/qubble_coins_m.png` |

### 5 · `qubble_coins_l` — 7,99 € — Verbrauchsartikel

| | |
|---|---|
| Name | `6000 Münzen` |
| Beschreibung | `6000 Münzen für Booster, Themes und Skins.` |
| Symbol | `store-assets/product-icons/qubble_coins_l.png` |

### 6 · `qubble_rename` — 1,49 € — Verbrauchsartikel

| | |
|---|---|
| Name | `Namensänderung` |
| Beschreibung | `Ändere deinen Namen in der Bestenliste einmal. Rein kosmetisch, kein Spielvorteil.` |
| Symbol | `store-assets/product-icons/qubble_rename.png` |

### 7 · `qubble_neon_theme` — 2,49 € — Nicht-Verbrauchsartikel

| | |
|---|---|
| Name | `Neon-Theme` |
| Beschreibung | `Schaltet das Neon-Theme dauerhaft frei: schwarzes Brett, leuchtend grüne und pinke Blöcke.` |
| Symbol | `store-assets/product-icons/qubble_neon_theme.png` |

### 8 · `qubble_diamonds_s` — 0,99 € — Verbrauchsartikel

| | |
|---|---|
| Name | `100 Diamanten` |
| Beschreibung | `100 Diamanten für Premium-Skins und -Themes.` |
| Symbol | `store-assets/product-icons/qubble_diamonds_s.png` |

### 9 · `qubble_diamonds_m` — 2,99 € — Verbrauchsartikel

| | |
|---|---|
| Name | `350 Diamanten` |
| Beschreibung | `350 Diamanten für Premium-Skins und -Themes. Mehr pro Euro als das kleine Paket.` |
| Symbol | `store-assets/product-icons/qubble_diamonds_m.png` |

### 10 · `qubble_diamonds_l` — 7,99 € — Verbrauchsartikel

| | |
|---|---|
| Name | `1000 Diamanten` |
| Beschreibung | `1000 Diamanten für Premium-Skins und -Themes. Bestes Verhältnis.` |
| Symbol | `store-assets/product-icons/qubble_diamonds_l.png` |

---

## Verbrauchsartikel oder nicht — das ist keine Formsache

Die Zuordnung stammt aus `IapProducts.isConsumable` (`lib/monetization/iap.dart`)
und ein Test hält sie fest. Falsch gesetzt heißt:

- **Dauerhafter Inhalt als Verbrauchsartikel** → kann mehrfach abgerechnet
  werden, obwohl der Spieler ihn schon besitzt.
- **Münz- oder Diamantpaket als Nicht-Verbrauchsartikel** → nur einmal kaufbar,
  danach nie wieder.

Nicht-Verbrauchsartikel sind genau zwei: `qubble_supporter` und
`qubble_neon_theme`. Alle anderen acht sind Verbrauchsartikel.

---

## Nach dem Anlegen

1. Alle zehn auf **aktiv** setzen. Ein inaktives Produkt ist für die App ein
   nicht existierendes.
2. Einen **Lizenz-Tester** hinterlegen — kauft ohne echte Abbuchung.
3. **Im Spiel gegenprüfen:** Der Shop muss alle zehn Angebote **mit Preis**
   zeigen. Fehlt eines, stimmt seine Produkt-ID nicht.

---

## Die Symbole

Erzeugt von `tool/product_icons.py` aus der Palette des Spiels
(`lib/ui/theme.dart`), damit Store und App zusammenpassen. Menge wird durch
Wiederholung gezeigt — eine, zwei, drei Münzen —, nie durch eine Ziffer, weil
das Formular Text im Symbol ausdrücklich verbietet.

Neu erzeugen: `python3 tool/product_icons.py`. Das Skript bricht ab, wenn ein
Motiv den Rand berührt; drei Münzen bei einem Radius, der für eine gewählt war,
liefen an beiden Seiten heraus.
