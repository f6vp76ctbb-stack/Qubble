# Qubble — Block Puzzle (Flutter, iOS + Android)

Qubble ist ein Block-Puzzle im Stil von Block Blast! / Woodoku: Blockformen
auf ein 8×8-Raster ziehen, volle Reihen und Spalten abräumen, Highscores jagen.
Eine Codebase (Flutter) für iOS, Android und Web. Monetarisierung über
**freiwillige** Rewarded Ads und In-App-Käufe — keine Interstitials, keine
Banner. **Komplett offline** — kein Backend, kein Server.

App-Sprachen: **Englisch** (Quellsprache) und **Deutsch** (Übersetzung); die App
folgt der Gerätesprache und fällt auf Englisch zurück.

Produkt- und Phasenplan mit aktuellen Checkboxen: siehe **`MASTERPLAN.md`**.
Entwicklungs-Konventionen: **`CLAUDE.md`**.

## Features

**Gameplay**
- 8×8-Board, Drag & Drop mit Platzierungs-Vorschau, seed-barer Fair-Generator
- Scoring mit Combos und Fieber-Meter, All-Clear-Bonus
- Endlos-Modus + tägliche Challenge (seed-basiert, für alle gleich)
- **Rätsel-Modus**: seed-generierte, per Bitboard-Solver validierte Level mit
  3-Sterne-Wertung (unendlicher Content ohne Content-Kosten)

**Retention**
- Daily-Streak mit Streak-Schutz (1 verpasster Tag heilbar)
- Missionen, Spieler-Level (XP), Statistik-Screen
- Lokale Benachrichtigungen (offline): Daily-Reminder, Streak-Warnung, Comeback
- In-Game-Booster: Undo, Teil-Tausch, Board-Bombe

**Sprachen**
- Englisch + Deutsch, umschaltbar in den Einstellungen (oder Gerätesprache)
- Quelltexte in `lib/l10n/app_en.arb`, Übersetzung in `app_de.arb`

**Game Feel**
- Partikel beim Clearen, Score-Popups, Screen-Shake, All-Clear-Feier
- Haptik, selbst erzeugte Sound-Effekte, Combo-Sound-Eskalation
- 8 Themes und 8 Block-Skins, per Münzen/Diamanten freischaltbar

**Monetarisierung**
- Rewarded Ads als einziges Ad-Format und immer freiwillig (Lucky Block, Münzen
  verdoppeln, Extra-Zug, Streak-Reparatur), UMP/DSGVO-Consent
- IAP: Unterstützer-Paket, Münzpakete, Starter-Paket; Revive kostet Münzen
- Wochenend-Event (doppelte Münzen), Münz-Ökonomie mit Boostern/Kosmetik

## Architektur

Spiellogik strikt von der UI getrennt und vollständig unit-getestet:

```
lib/
  game/           # Pure Dart, KEINE Flutter-Imports (board, piece, generator,
                  # scoring, session, daily, streak, missions, leveling, stats,
                  # puzzle+solver, piggy_bank, starter_offer, weekend_event,
                  # block_skin)
  ui/             # Screens, Widgets, Riverpod-Controller
  monetization/   # ads (nur Rewarded), iap, ad_config, purchase_delivery
  services/       # storage, audio, haptics, notifications, analytics
  l10n/           # app_en.arb (Quelle) + app_de.arb (Übersetzung)
test/             # spiegelt lib/ — 316 Tests
```

State: Riverpod. Persistenz: `shared_preferences` (lokal). Ads:
`google_mobile_ads`. IAP: `in_app_purchase`. Benachrichtigungen:
`flutter_local_notifications`.

## Entwickeln & Testen

Flutter (stable) vorausgesetzt. In frischen Cloud-Umgebungen: `scripts/setup.sh`.

```bash
flutter pub get
flutter analyze     # muss sauber sein
flutter test        # 316 Tests, müssen grün sein
flutter run         # Emulator/Gerät
flutter run -d chrome   # Web (lokales Testen, siehe docs/LOCAL-TESTING.md)
```

## Weiterführende Docs

| Datei | Inhalt |
|---|---|
| `MASTERPLAN.md` | Produkt-/Phasenplan, Spiel-Spezifikation (Anhang A–C) |
| `docs/LOCAL-TESTING.md` | Lokal auf PC + iPhone testen (Web-Version) |
| `docs/SETUP-ACCOUNTS.md` | Store-/AdMob-/Firebase-Konten (die 👤-Schritte) |
| `docs/RELEASE.md` | Build & Signing (Play-Store-first) |
| `docs/STORE-LISTING.md` | ASO-Texte (EN + DE), Realitätsabgleich |
| `docs/PRODUCTION-ACCESS.md` | Play-Produktionszugriff: Checkliste + Fragebogen-Antworten |
| `web/privacy.html`, `web/impressum.html` | Rechtstexte — die **gehostete** Fassung, in der App verlinkt |
| `docs/NOTIFICATIONS.md` | Benachrichtigungen: Setup + Geräte-Verifikation |

## Status

Phasen 0–3 (spielbarer MVP, Game Feel, Monetarisierung) und Phase 6 (Tiefe &
Profit) sind **code-seitig abgeschlossen**; Debug-Builds laufen mit AdMob-Test-
IDs. Offen sind die menschlichen Schritte (👤): Entwickler-Konten, echte
AdMob-/IAP-IDs, Firebase-Config, Store-Upload — dokumentiert in `docs/`.

Assets: App-Icon und Sound-Effekte sind selbst erstellt (CC0-äquivalent), siehe
`assets/CREDITS.md`.
