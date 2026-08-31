# 04 — Monetarisierung

## Vorbemerkung

`CLAUDE.md` setzt die Monetarisierungsregeln als **nicht verhandelbar**: keine
Interstitials, keine Banner, Rewarded nur freiwillig, Revive kostet Münzen und
nie Werbung, das Sparschwein ist kein Kaufprodukt. Dieses Audit respektiert das.
Alle Empfehlungen unten bleiben innerhalb dieser Regeln.

Was das Audit trotzdem leistet: den **Preis** dieser Entscheidung beziffern,
damit sie mit offenen Augen weitergetragen wird — und innerhalb der Regeln alles
holen, was zu holen ist.

---

## 1. Ist-Zustand aus dem Code

### Werbung

Ein einziges Format: Rewarded Video. Verifiziert:
`grep -rn "InterstitialAd\|BannerAd\|AppOpenAd" lib/` → **keine Treffer**.

Fünf Platzierungen:

| # | Platzierung | Auslöser | Belohnung | Begrenzung | Analytics | Fundstelle |
|---|---|---|---|---|---|---|
| 1 | Münzen verdoppeln | Rundenende | Rundenmünzen ×2 | **1× pro Runde** | `placement: double` | `game_controller.dart:510-524` |
| 2 | Lucky Block | im Spiel | neue Teile-Ablage | **keine** | `placement: lucky` | `game_controller.dart:526-539` |
| 3 | Sparschwein früher öffnen | Sparschwein < voll | Auszahlung | implizit (Bank leer) | `placement: piggy` | `game_controller.dart:733-739` |
| 4 | Streak-Reparatur | Streak gebrochen | Streak gerettet | 1× pro Tag | `placement: streak_repair` | `game_controller.dart:1277-1285` |
| 5 | Rätsel: Extra-Zug | Rätsel unlösbar | ein zusätzlicher Zug | `canExtraMove` | **fehlt** | `puzzle_screen.dart:452` |

Consent: UMP läuft vor dem ersten Ad-Request (`ads.dart:52-90`), ein
Fehlschlag führt nie zu einem Request (`:69-71`), und die Datenschutz-Optionen
sind in den Einstellungen erneut aufrufbar (`ads.dart:93-115`). Das ist sauber.

### In-App-Käufe

| Produkt-ID | Typ | Inhalt | Preis (Platzhalter) |
|---|---|---|---|
| `qubble_supporter` | non-consumable | Aurora-Theme + Crystal-Skin + **1 500 Münzen** + Herz-Abzeichen | 4,99 € |
| `qubble_coins_s` | consumable | 500 Münzen | 0,99 € |
| `qubble_coins_m` | consumable | 2 000 Münzen | 2,99 € |
| `qubble_coins_l` | consumable | 6 000 Münzen | 7,99 € |
| `qubble_starter` | consumable | 1 200 Münzen + Wood-Theme, nach 5 Runden, 48-h-Fenster | — |
| `qubble_rename` | consumable | eine Namensänderung | — |
| `qubble_neon_theme` | consumable | Neon-Theme | — |

Die Preise stammen aus `FakeIap` (`iap.dart:107-132`) — das sind
**Entwicklungs-Platzhalter**, nicht die Store-Preise. `StoreIap` liest die
echten lokalisierten Preise aus dem Store (`iap.dart:205-214`). Die letzten
beiden Produkte stehen im Katalog, aber **nicht** in `docs/STORE-LISTING.md`.

Auslieferung (`purchase_delivery.dart:74-101`): idempotent, serialisiert über
eine Queue, Eigentum wird **vor** der additiven Belohnung persistiert, damit ein
wiederholtes Stream-Event die 1 500 Münzen nicht erneut gewährt. Kosmetik wird
bei jedem Restore neu gesetzt, damit eine unvollständige Installation sich
repariert. Das ist gut gebaut.

### Die Münz-Ökonomie

| Einnahme | Betrag | Fundstelle |
|---|---|---|
| pro geräumter Linie | **3** | `game_controller.dart:258` |
| All Clear | 25 | `game_controller.dart:261` |
| Daily Challenge | 50 + 10/Streak-Tag, gedeckelt bei +100 | `streak.dart:27-31` |
| Comeback nach 72 h | 100 | `notification_planner.dart:66` |
| Rätsellevel gelöst | 10, +25 jedes 10. | `puzzle.dart:285` |
| Wochenende | Münzen ×2 | `weekend_event.dart:11` |
| Sparschwein | 2/Linie, Kapazität 200 | `piggy_bank.dart:20-21` |
| Startguthaben | 100 | `storage.dart:68` |

| Ausgabe | Kosten |
|---|---|
| Rückgängig | 50 |
| Teile-Tausch | 75 |
| Board-Bombe | 150 |
| **Revive** | **200** |

**Die Rechnung.** `BALANCE.md` misst ~15 geräumte Linien pro Runde bei einer
Median-Rundendauer von 84 s. Also:

```
Münzen pro Runde     ≈ 15 Linien × 3          =  45
Münzen pro Session   ≈ 3 Runden × 45 + Daily  ≈ 285   (mit Daily 50-150)
Revive               = 200                     ≈ 4,4 Runden Spielertrag
```

Ein täglicher Spieler verdient also grob **285 Münzen am Tag**. Und hier liegt
das strukturelle Problem des IAP-Katalogs:

```
qubble_coins_s = 500 Münzen ≈ 11 Runden ≈ 15 Minuten Spielzeit
```

**Für 0,99 € kauft der Spieler eine Viertelstunde Münzen-Grinden ab.** Das
verkauft sich nicht — nicht weil der Preis falsch ist, sondern weil die
Währung im Spiel zu schnell fließt, als dass sie knapp genug wäre, um Geld
wert zu sein.

Das ist keine Kritik an der Großzügigkeit — die ist richtig und passt zum
Produktversprechen. Es heißt nur: **die drei Münzpakete sind strukturell
unverkäuflich** und sollten nicht als Umsatzquelle eingeplant werden.

Das Unterstützer-Paket funktioniert dagegen, und zwar aus dem entgegengesetzten
Grund: Es verkauft Aurora-Theme und Crystal-Skin — Dinge, die **für Münzen
nicht erhältlich** sind (`CLAUDE.md`: „Exklusive Kosmetik (`supporterOnly`) ist
nie für Münzen erhältlich"). Knappheit, die nicht durch Spielzeit auflösbar
ist, ist das Einzige, wofür in diesem Genre gezahlt wird.

---

## 2. Was die Regel kostet — die belegte Zahl

Aus Phase 1d, alles am 2026-08-31 recherchiert:

| Kennwert | Wert | Quelle |
|---|---|---|
| Rewarded eCPM US Android | 16,49 USD | MAF 2026 |
| Interstitial eCPM US Android | 14,08 USD | MAF 2026 |
| **Verhältnis** | **1,17×** | daraus |
| Ad-Impressions je Nutzer, Puzzle-Genre | 72,5 Interstitial / **23,4 Rewarded** | Juego Studio |
| ARPDAU, werbefinanziertes Casual | 0,05–0,15 USD | Game Growth Advisor 2026 |
| Rewarded eCPM Deutschland | **Unbekannt — keine abrufbare Quelle** | — |

**Der oft zitierte „3× höhere eCPM von Rewarded" ist falsch.** Die einzigen
konkreten Länderzahlen ergeben Faktor 1,17. Dieses Audit verwendet ihn nicht.

Daraus folgt die eigentliche Rechnung:

> Der Verzicht auf Interstitials kostet **nicht Preis, sondern Menge**.
> Im Puzzle-Genre stehen 72,5 Interstitial-Impressions gegen 23,4 Rewarded.
> Wer die Interstitials streicht, verzichtet grob auf **drei Viertel des
> Anzeigenvolumens** und gewinnt auf dem Rest rund 17 % eCPM.

Grob überschlagen liegt Qubbles erreichbarer Ad-ARPDAU damit im Bereich von
**25–30 % dessen, was ein vergleichbarer Titel mit Interstitials erzielt** —
also eher am unteren Rand oder unter der 0,05-USD-Spanne, nicht darin.

**Die Gegenprobe aus dem Markt** (Phase 1c): Block Blast erzielt mit
Interstitials **plus** Rewarded rund 584 000 USD Werbeumsatz pro Tag und steht
bei IAP-Umsatz auf **Platz 3 264**. In diesem Genre ist Werbung das
Geschäftsmodell und IAP praktisch nichts. Qubble verzichtet auf den Löwenanteil
des funktionierenden Stroms und baut auf den, der beim Marktführer 0,03 %
ausmacht.

**Was das konkret heißt.** Bei kleiner Nutzerbasis — dem realistischen Szenario
für einen Solo-Titel ohne UA-Budget — landet der Monatsumsatz im niedrigen
zwei- bis dreistelligen Euro-Bereich. Das ist keine Schätzung mit Anspruch auf
Genauigkeit; die Eingangsgröße, die alles entscheidet (die Opt-in-Rate auf die
Rewarded-Knöpfe), ist **unbekannt und heute nicht messbar**. Sie wird in Phase 6
messbar gemacht.

Diese Zahl ist kein Argument, die Regel zu kippen. Sie ist ein Argument, die
**Erfolgsdefinition** anzupassen: Qubble ist als Umsatzprojekt nicht tragfähig
und als Produkt trotzdem verteidigbar.

---

## 3. Policy-Lage: der eine Bereich, in dem Qubble besser dasteht als die Kategorie

Aus Phase 1a, Google „Better Ads Experiences", abgerufen 2026-08-31:

> Since users have explicitly opted in to rewarded ad experience, these ads are
> allowed as long as they follow all Developer Program Policies. […] These
> changes don't affect opt-in ads like rewarded video ads.

Verboten sind dagegen: Interstitials, die unerwartet erscheinen, die während
des Gameplays auftauchen, oder die sich nach 15 Sekunden nicht schließen lassen.

**Qubble kann diese Policy strukturell nicht verletzen**, weil es das Format
nicht einbindet. Für ein Konto mit Enforcement-Vorgeschichte ist das eine
erhebliche Risikoreduktion — und es ist der einzige Punkt, an dem die
Monetarisierungsregel dem Projekt handfest hilft.

### Risikobewertung je Platzierung

| Platzierung | Ad-Policy-Risiko | Fehlklick-Risiko | Begründung |
|---|---|---|---|
| Münzen verdoppeln (Rundenende) | **keins** | gering | eigener Knopf, Rundenende, kein Zeitdruck |
| Sparschwein früher öffnen | **keins** | gering | bewusster Griff ins Menü |
| Streak-Reparatur | **keins** | gering | seltener, klar benannter Dialog |
| Rätsel: Extra-Zug | **keins** | gering | Fail-Screen, klar beschriftet |
| **Lucky Block** | keins | **mittel** | liegt im Spielbildschirm neben den Interaktionsflächen des laufenden Spiels |

**Der einzige zu prüfende Punkt ist Lucky Block.** Nicht weil er die Policy
verletzt — tut er nicht — sondern weil er der einzige Rewarded-Knopf **im
laufenden Spiel** ist, also in derselben Fläche, in der der Spieler zieht und
tippt. Ein versehentlicher Treffer startet ein Video. Google zählt so etwas
nicht als Policy-Verstoß, aber AdMob zählt es potenziell als **Invalid
Traffic**, und Nutzer schreiben darüber Bewertungen.

**Empfehlung:** Bestätigungsdialog vor dem Video („Neue Teile für ein
Bonus-Video?" / Abbrechen), oder den Knopf aus der Zieh-Fläche herausnehmen.
Aufwand: 1 h.

---

## 4. Zielarchitektur

Alles Folgende bleibt innerhalb der Regeln aus `CLAUDE.md`.

### M-1 · Die fehlende Instrumentierung schließen · **P0 für alles Weitere**

`puzzle_screen.dart:452` löst ein Rewarded-Video aus, **ohne** ein
`rewardedWatched`-Ereignis zu senden. Vier von fünf Platzierungen sind im
Funnel sichtbar, eine nicht.

Solange das so ist, ist jede Aussage über die Wirksamkeit der Platzierungen
geraten. Das ist der billigste Punkt der ganzen Phase und die Voraussetzung
für alle anderen.

**Fix:** `_analytics.logEvent(AnalyticsEvent.rewardedWatched, {'placement':
'puzzle_extra_move'})` ergänzen — sinnvollerweise im Controller, nicht im
Screen, damit die Platzierung nicht an der UI hängt.
**Aufwand:** 30 min.

### M-2 · Angebot und Ablehnung getrennt messen · **P1**

Heute wird nur der **eingelöste** Reward geloggt. Was fehlt, ist der Nenner:
Wie oft wurde der Knopf überhaupt gesehen, wie oft getippt, wie oft ist das
Video durchgelaufen?

Ohne diese drei Zahlen ist die Opt-in-Rate — die Größe, die den gesamten
Ad-Umsatz bestimmt (Abschnitt 2) — nicht bestimmbar.

**Fix:** drei Ereignisse je Platzierung: `rewarded_offered`,
`rewarded_accepted`, `rewarded_completed`. Spezifikation in Phase 6.
**Aufwand:** 2 h.

### M-3 · Lucky Block absichern und deckeln · **P1**

Zwei Probleme in einer Platzierung:

1. **Fehlklick-Risiko** (siehe oben) → Bestätigungsdialog.
2. **Keine Begrenzung.** `luckyBlock()` (`game_controller.dart:526-539`) prüft
   nur `_isDaily`. Ein Spieler kann in einer Runde beliebig oft die Ablage neu
   würfeln. In Verbindung mit dem Befund aus Phase 3 (Glück schlägt Können
   5 : 1 in der Bestenliste) ist das ein Fairness-Leck: Wer bereit ist, Videos
   zu schauen, kauft sich Bestenlisten-Plätze mit Zeit.

Die Begrenzung durch die Videolänge (~30 s) ist real, aber sie ist kein Design.

**Fix:** 3 Lucky Blocks pro Runde. Das ist großzügig genug, um nie im Weg zu
stehen, und schließt das Fairness-Leck.
**Aufwand:** 1 h inkl. Test.

### M-4 · Die Münzpakete auf ein verkäufliches Modell umstellen · **P2**

Aus Abschnitt 1: 500 Münzen entsprechen ~15 Minuten Spielzeit. Zwei Wege, und
sie schließen sich aus:

**Weg A — Pakete ehrlich streichen.** `qubble_coins_s/m/l` aus dem Shop
nehmen, den Katalog auf Unterstützer-Paket + Starter-Paket + Kosmetik
reduzieren. Der Shop wird kürzer und ehrlicher, es geht praktisch kein Umsatz
verloren (weil heute keiner entsteht), und die Pflege eines Katalogs mit toten
Produkten entfällt.

**Weg B — Kosmetik statt Münzen verkaufen.** Die belegte Marktlogik ist, dass
in diesem Genre nur unerreichbare Knappheit bezahlt wird. Das Unterstützer-Paket
beweist es bereits im eigenen Katalog. Statt Münzpaketen also einzelne
Themes/Skins als `supporterOnly`-Kosmetik anbieten — `qubble_neon_theme`
existiert bereits im Code (`iap.dart:27`), taucht aber im Store-Listing nicht
auf.

**Empfehlung: Weg B**, weil er den vorhandenen, funktionierenden Mechanismus
ausbaut, statt einen toten zu pflegen. Weg A als Rückfall, wenn keine Zeit für
neue Kosmetik da ist.

**Preisgerüst.** Der einzige belegbare Anker ist AppsFlyer 2026: **ARPPU D90
Casual = 7,26 USD** — was ein zahlender Casual-Spieler in 90 Tagen insgesamt
ausgibt. Ein Katalog, dessen Einstieg darüber liegt, verkauft nichts. Daraus:

| Produkt | DE | US | Begründung |
|---|---|---|---|
| Starter-Paket | 1,99 € | 1,99 $ | Impulskauf-Schwelle, 48-h-Fenster |
| Einzel-Theme/Skin | 1,99 € | 1,99 $ | unter dem ARPPU-Anker |
| Unterstützer-Paket | 4,99 € | 4,99 $ | wie bisher; deckt allein schon zwei Drittel des 90-Tage-ARPPU |

Konfidenz: **niedrig**. Ein Anker ist kein Preistest. Play Console erlaubt
Preisexperimente — das ist der richtige Weg, nicht meine Tabelle.

### M-5 · Zwei zusätzliche Rewarded-Gelegenheiten, regelkonform · **P2**

Die Regel verbietet erzwungene Werbung, nicht zusätzliche freiwillige
Gelegenheiten. Zwei Stellen im Loop bieten sich an, beide belegt aus Phase 3:

**(a) Am Game-Over-Bildschirm.** Aus Phase 3: Der Game-Over-Screen ist der
meistgesehene Bildschirm des Spiels (Median-Runde 84 s, 3–4 Runden je Session).
Dort steht heute genau ein Rewarded-Angebot (Münzen verdoppeln). Ein zweites,
das die Regel nicht berührt: **„Ergebnis der Runde in der Bestenliste
absichern"** oder ein Bonus auf die Tagesmission. Wichtig: Der Revive bleibt
münzpflichtig — das ist in `CLAUDE.md` festgeschrieben und bleibt so.

**(b) Beim Daily-Ergebnis.** Die Daily-Belohnung (50–150 Münzen) ist der
stärkste Wiederkehrgrund. Ein freiwilliges „Tagesbelohnung verdoppeln" ist die
direkte Entsprechung zum bereits existierenden Rundenende-Angebot und liegt an
der Stelle mit der höchsten Motivation.

**Erwartete Wirkung:** mehr Rewarded-Impressions je DAU, ohne eine einzige
erzwungene Anzeige. **Messbar über** die Ereignisse aus M-2.
**Aufwand:** je 2 h.

### M-6 · iOS-Ad-Unit und Firebase-App fehlen · **P2** (blockiert die iOS-Phase)

- `ad_config.dart:30`: `_prodRewardedIos = 'REPLACE_ME_REWARDED_IOS'`
- `firebase_config.dart:18`: `iosAppId = 'REPLACE_ME_FIREBASE_IOS_APP_ID'`

Beide fallen kontrolliert zurück (Test-Unit bzw. kein Firebase), es stürzt also
nichts ab. Die Folge ist trotzdem hart: **Auf iOS liefe die App ohne
Werbeumsatz und ohne Crash-Reporting.** Vor einer iOS-Einreichung sind beide
zu füllen. Für die aktuelle Android-Wiederzulassung ist das kein Blocker.

---

## 5. Kurzliste

| # | Maßnahme | Schwere | Aufwand |
|---|---|---|---|
| M-1 | Rätsel-Rewarded instrumentieren | P0 | 30 min |
| M-2 | offered / accepted / completed je Platzierung | P1 | 2 h |
| M-3 | Lucky Block: Bestätigung + Deckel von 3 | P1 | 1 h |
| M-4 | Münzpakete → Kosmetik (Weg B) | P2 | 4 h + Store-Pflege |
| M-5 | zwei zusätzliche freiwillige Platzierungen | P2 | 4 h |
| M-6 | iOS-Ad-Unit + Firebase-App | P2 | extern |

---

## Quellen

| URL | Titel | Abrufdatum | Belegtyp |
|---|---|---|---|
| <https://support.google.com/googleplay/android-developer/answer/12271244> | Understanding Google Play's Better Ads Experiences policy | 2026-08-31 | Suchtreffer (Seite egress-gesperrt) |
| <https://maf.ad/en/blog/rewarded-ads-stats/> | Rewarded Ads Unpacked: Performance Insights for 2026 | 2026-08-31 | Suchtreffer |
| <https://www.juegostudio.com/blog/arpdau-benchmarks-by-game-genre> | ARPDAU Benchmarks by Genre | 2026-08-31 | Suchtreffer |
| <https://gamegrowthadvisor.com/blog/2026-03-17-mobile-game-kpis-benchmarks-2026/> | The 20 Mobile Game KPIs That Actually Matter in 2026 | 2026-08-31 | Suchtreffer |
| <https://www.appsflyer.com/resources/reports/app-marketing-monetization-report/> | The State of App Monetization — 2026 Edition | 2026-08-31 | Suchtreffer |
| <https://www.capermint.com/blog/develop-a-game-like-block-blast/> | How to Develop a Game Like Block Blast | 2026-08-31 | Suchtreffer |

Alle Code- und Ökonomieaussagen stützen sich auf Fundstellen in diesem Repo und
auf die Simulationsdaten in `BALANCE.md`.
