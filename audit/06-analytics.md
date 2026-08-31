# 06 — Instrumentierung

Ohne Daten ist alles ab Phase 3 begründete Vermutung. Diese Phase liefert eine
umsetzbare Spezifikation gegen den vorhandenen Stack.

---

## 1. Was heute existiert

`lib/services/analytics.dart` definiert eine bewusst schmale Schnittstelle:

```dart
abstract class Analytics {
  void logEvent(String name, [Map<String, Object?> params]);
}
```

Drei Implementierungen: `NoopAnalytics` (Tests), `DebugAnalytics`
(`debugPrint`), `FirebaseAnalyticsBackend` (`firebase_boot_native.dart:81-101`,
säubert Parameter auf String/num und sendet fire-and-forget).

Ausgelöste Ereignisse, vollständige Liste
(`grep -rn "logEvent" lib/`):

| Ereignis | Parameter | Wo |
|---|---|---|
| `game_start` | `mode: endless\|daily` | `game_controller.dart:479, 489` |
| `round_complete` | mehrere | `game_controller.dart:1040` |
| `reach_round_3` | — | `game_controller.dart:1045` |
| `daily_played` | — / mehrere | `game_controller.dart:1047, 1261` |
| `rewarded_watched` | `placement` | `:518, 533, 737, 1281` |
| `purchase` | `product` | `purchase_delivery.dart:100` |
| `review_prompt` | `trigger` | `game_controller.dart:621` |
| `review_open_listing` | — | `game_controller.dart:632` |

### Fünf Lücken, jede belegt

| # | Lücke | Fundstelle | Folge |
|---|---|---|---|
| A-1 | **Auf iOS und Web läuft gar keine Analytik.** `initFirebase()` gibt dort `null` zurück, `main.dart:90` fällt auf `DebugAnalytics` zurück — Ereignisse landen in `debugPrint`. | `main.dart:90`, `firebase_config.dart:18`, `firebase_boot_stub.dart:6` | iOS wäre blind |
| A-2 | **Eine von fünf Rewarded-Platzierungen ist stumm.** Der Rätsel-Extra-Zug löst ein Video aus, ohne zu loggen. | `puzzle_screen.dart:452` | Funnel unvollständig |
| A-3 | **Kein Nenner für Rewarded.** Nur der eingelöste Reward wird geloggt, nicht das Angebot und nicht die Ablehnung. | alle vier Aufrufe | Opt-in-Rate — die Größe, die den Ad-Umsatz bestimmt — nicht bestimmbar |
| A-4 | **Kein Ad-Revenue-Tracking.** `RewardedAd.onPaidEvent` wird nicht gesetzt. | `ads.dart:120-135` | ARPDAU und eCPM nach Land unbekannt (die Lücke aus Phase 1d) |
| A-5 | **Keine Nutzereigenschaften.** `setUserProperty` wird nirgends aufgerufen. | — | Keine Kohortenbildung, keine Segmentierung |

Zusätzlich fehlt jedes Ereignis für die in Phase 3 benannten Abbruchstellen:
Es gibt kein Signal dafür, ob ein Spieler den Regelbildschirm abbricht, wie weit
er im Rätselmodus kommt oder wo eine Runde endet.

---

## 2. Ereignis-Taxonomie

Konventionen: `snake_case`, ≤ 40 Zeichen, Parameter ≤ 100 Zeichen Wert.
Firebase erfasst `first_open`, `session_start` und `app_remove` automatisch —
diese werden **nicht** neu definiert.

Neue Ereignisse sind mit **NEU** markiert.

### Onboarding und erste Runde

| Ereignis | Parameter | Auslöser | Zweck |
|---|---|---|---|
| `tutorial_begin` **NEU** | — | `HowToPlayScreen` beim ersten Start geöffnet | Nenner für den Abbruch aus L-1 |
| `tutorial_complete` **NEU** | `dismissed: bool` | Screen geschlossen | misst, ob der Regeltext gelesen oder weggetippt wird |
| `onboarding_step` **NEU** | `step: 0\|1\|2` | Coach-Stufe erreicht (`game_controller.dart:898`) | zeigt, wo die Einführung abreißt |
| `game_start` | `mode`, `is_first_game: bool` **NEU** | Rundenstart | |
| `first_placement` **NEU** | `seconds_since_open: int` | erste Platzierung überhaupt | **das zentrale FTUE-Maß** |

### Kernrunde

| Ereignis | Parameter | Auslöser |
|---|---|---|
| `round_complete` | `score`, `moves`, `lines`, `max_combo`, `duration_s`, `mode`, `end_reason` **NEU** | Rundenende |
| `reach_round_3` | — | dritte Runde |
| `revive_used` **NEU** | `coins_spent`, `score_at_death` | Revive |
| `booster_used` **NEU** | `booster: undo\|swap\|bomb`, `coins_spent` | Booster |

`end_reason` unterscheidet „kein Teil passt" von „Spieler hat abgebrochen" —
ohne das ist die Rundenlängen-Verteilung aus `BALANCE.md` nicht gegen echte
Spieler prüfbar.

### Wiederkehr

| Ereignis | Parameter | Auslöser |
|---|---|---|
| `daily_played` | `streak`, `coins_awarded` | Daily beendet |
| `streak_broken` **NEU** | `streak_lost` | Streak reißt |
| `streak_repaired` **NEU** | `method: coins\|ad` | Reparatur |
| `notification_optin` **NEU** | `accepted: bool` | Opt-in-Dialog (`app_bootstrap.dart:171`) |
| `notification_opened` **NEU** | `type: daily\|streak\|comeback` | App aus Benachrichtigung gestartet |
| `comeback_gift` **NEU** | `coins`, `days_away` | Comeback-Geschenk |

### Rätselmodus

| Ereignis | Parameter | Auslöser |
|---|---|---|
| `puzzle_start` **NEU** | `level` | Level begonnen |
| `puzzle_complete` **NEU** | `level`, `moves`, `stars` | Level gelöst |
| `puzzle_failed` **NEU** | `level`, `moves` | steckengeblieben |

`stars` mitzuloggen ist bewusst: Wenn L-2 (Phase 3) umgesetzt wird, beweisen
diese Daten, dass die Sterne danach tatsächlich variieren. Vorher werden sie
konstant 3 sein — und genau das ist der Beleg für den Befund.

### Monetarisierung

| Ereignis | Parameter | Auslöser |
|---|---|---|
| `rewarded_offered` **NEU** | `placement` | Knopf wird **angezeigt** |
| `rewarded_accepted` **NEU** | `placement` | Knopf getippt |
| `rewarded_watched` | `placement`, `earned: bool` **NEU** | Ergebnis von `showRewarded()` |
| `ad_impression` **NEU** | siehe Abschnitt 5 | `onPaidEvent` |
| `shop_opened` **NEU** | `source` | Shop geöffnet |
| `purchase` | `product`, `price_micros`, `currency` **NEU** | Auslieferung |
| `starter_offer_shown` **NEU** | — | Starter-Angebot sichtbar |

`placement` nimmt genau fünf Werte: `double`, `lucky`, `piggy`,
`streak_repair`, `puzzle_extra_move`. Der letzte ist heute nicht vorhanden
(A-2).

Die Kette `offered → accepted → watched` liefert zwei Quoten, die heute beide
unbekannt sind: die **Angebots-Annahme** und die **Abschlussrate**. Ohne sie
ist jede Aussage über die Wirksamkeit einer Platzierung geraten.

---

## 3. Funnels

### F-1 · Install bis erste monetarisierte Session

```
first_open                    (automatisch)
  → tutorial_begin            wie viele sehen den Regelbildschirm?
  → tutorial_complete         wie viele lesen ihn zu Ende?
  → game_start (is_first_game) wie viele starten überhaupt?
  → first_placement           wie viele setzen den ersten Block?   ← L-1
  → round_complete            wie viele beenden Runde 1?
  → reach_round_3             wie viele bleiben?
  → rewarded_offered          wie viele sehen ein Angebot?
  → rewarded_accepted         wie viele nehmen es an?              ← Opt-in-Rate
  → ad_impression             wie viele erzeugen Umsatz?
```

Die Stufe `first_open → first_placement` ist der Kern. Sie beantwortet die
Frage aus Phase 3, L-1 — ob der vorgeschobene Regeltext Spieler kostet — und
ist heute nicht beantwortbar.

### F-2 · Kauf

```
shop_opened → (starter_offer_shown) → purchase
```

### F-3 · Wiederkehr

```
notification_optin(accepted:true) → notification_opened → game_start
```

Misst, ob die Benachrichtigungen ihr Geld wert sind — die einzige aktive
Rückholmechanik.

---

## 4. Kohorten und Nutzereigenschaften

Firebase bildet Retention-Kohorten automatisch über `first_open`. Was fehlt,
sind die Merkmale zum Segmentieren. Vier Eigenschaften, alle über
`setUserProperty` (max. 25 pro Projekt, Wert ≤ 36 Zeichen):

| Eigenschaft | Werte | Gesetzt wann | Fragestellung |
|---|---|---|---|
| `player_tier` | `new` / `casual` / `regular` / `veteran` (nach Gesamtrunden: <5 / <25 / <100 / ≥100) | Rundenende | Wie unterscheiden sich Retention und Opt-in nach Erfahrung? |
| `has_purchased` | `true` / `false` | Auslieferung | Zahler-Kohorte |
| `notifications_on` | `true` / `false` | Opt-in und Einstellungen | Wirkung der Benachrichtigungen auf D7 |
| `leaderboard_optin` | `true` / `false` | Namensvergabe | Bringt der soziale Haken Retention? |

**Bewusst nicht gesetzt:** `setUserId`. Es gibt keine Notwendigkeit, und die
anonyme Firebase-Auth-Kennung der Bestenliste an Analytics zu übergeben, würde
zwei bisher getrennte Datenbestände verknüpfen — genau die Art Verknüpfung, die
die Datenschutzerklärung heute ausdrücklich ausschließt („Der von dir gewählte
Bestenlistenname wird nicht als Analytics-Parameter gesendet",
`web/privacy.html`). Das bleibt so.

**Ebenso wenig:** Der Anzeigename darf in keinem Ereignisparameter auftauchen.

---

## 5. Ad-Revenue-Tracking

Das ist die Lücke mit dem größten Hebel: Sie schließt die in Phase 1d
unbeantwortete Frage nach dem Rewarded-eCPM in Deutschland — nicht über einen
Benchmark, sondern über den eigenen Messwert.

Beide nötigen APIs sind im vorhandenen Stack vorhanden, verifiziert im
Pub-Cache:

```
google_mobile_ads-9.0.0/lib/src/ad_listeners.dart:36
  typedef OnPaidEventCallback =
      void Function(Ad ad, double valueMicros, PrecisionType precision,
                    String currencyCode);

firebase_analytics-12.4.5/lib/src/firebase_analytics.dart:383
  Future<void> logAdImpression({String? adPlatform, String? adSource,
      String? adFormat, String? adUnitName, double? value, String? currency, …})
```

### Schritt 1 — Schnittstelle erweitern

`lib/services/analytics.dart`:

```dart
abstract class Analytics {
  void logEvent(String name, [Map<String, Object?> params]);

  /// Ad revenue for one impression. [valueMicros] is the paid amount in
  /// micros of [currency], as reported by the ad SDK.
  void logAdImpression({
    required double valueMicros,
    required String currency,
    required String adFormat,
    String? adSource,
  });

  void setUserProperty(String name, String? value);
}
```

`NoopAnalytics` bekommt leere Rümpfe, `DebugAnalytics` je ein `debugPrint`.

### Schritt 2 — Firebase-Backend

`lib/services/firebase_boot_native.dart`:

```dart
@override
void logAdImpression({
  required double valueMicros,
  required String currency,
  required String adFormat,
  String? adSource,
}) {
  unawaited(_analytics.logAdImpression(
    adPlatform: 'AdMob',
    adSource: adSource,
    adFormat: adFormat,
    adUnitName: AdConfig.rewardedUnitId,
    // logAdImpression expects the value in the currency's own unit.
    value: valueMicros / 1000000,
    currency: currency,
  ));
}

@override
void setUserProperty(String name, String? value) {
  unawaited(_analytics.setUserProperty(name: name, value: value));
}
```

### Schritt 3 — Callback beim Laden setzen

`lib/monetization/ads.dart`, in `_loadRewarded()` innerhalb `onAdLoaded`:

```dart
onAdLoaded: (ad) {
  _rewardedLoading = false;
  _rewarded = ad;
  ad.onPaidEvent = (ad, valueMicros, precision, currencyCode) {
    _analytics?.logAdImpression(
      valueMicros: valueMicros,
      currency: currencyCode,
      adFormat: 'rewarded',
      adSource: ad.responseInfo?.mediationAdapterClassName,
    );
  };
},
```

`GoogleAdService` bekommt dafür ein optionales `Analytics` im Konstruktor;
`main.dart:81-82` reicht es durch. `FakeAdService` bleibt unverändert.

**Was das liefert:** ARPDAU, eCPM pro Land (Firebase segmentiert automatisch
nach Region), Umsatz je Platzierung über `adFormat`/`adUnitName`, und bei
späterer Mediation die Aufschlüsselung nach Netzwerk über
`mediationAdapterClassName`.

**Datenschutz-Hinweis:** `logAdImpression` überträgt keinen zusätzlichen
Identifikator. Der Werbe-ID-Bezug entsteht ohnehin schon durch die
AdMob-Einbindung — er ist in `web/privacy.html` beschrieben und gehört in die
Data-Safety-Deklaration (Phase 7).

---

## 6. Consent an Analytics durchreichen

`firebase_analytics` 12.4.5 bietet `setConsent(...)`
(`firebase_analytics.dart:147`). Heute läuft der UMP-Flow
(`ads.dart:52-90`) und Firebase Analytics **völlig unabhängig voneinander**:
Analytics startet in `main.dart:69`, bevor überhaupt ein Consent-Zustand
existiert.

Für die DSGVO-Konsistenz — und für die Data-Safety-Deklaration — sollte das
Ergebnis des UMP-Flows an Firebase weitergereicht werden:

```dart
// nach _requestConsent(), in GoogleAdService.initialize()
_analytics?.setConsent(
  adStorageConsentGranted: _canRequestAds,
  adUserDataConsentGranted: _canRequestAds,
  adPersonalizationSignalsConsentGranted: _canRequestAds,
);
```

Das ist kein rein kosmetischer Punkt: Es ist die technische Umsetzung dessen,
was die Datenschutzerklärung bereits verspricht.

**Aufwand:** 2 h.

---

## 7. Crash- und ANR-Reporting

Crashlytics ist auf Android eingebunden und die Fehler-Handler sind installiert
(`firebase_boot_native.dart:68-78`, `FlutterError.onError` +
`PlatformDispatcher.instance.onError`). Das Release-Bundle trägt das
R8-Mapping, was der CI-Job hart prüft (`build-release.yaml`).

Drei Lücken:

| # | Lücke | Fix |
|---|---|---|
| C-1 | **iOS hat kein Crashlytics** — `iosAppId` ist ein Platzhalter, `initFirebase()` gibt `null` zurück und installiert damit auch die Fehler-Handler nicht. | Firebase-iOS-App registrieren (Phase 4, M-6) |
| C-2 | **Keine Custom Keys.** Ein Absturzbericht sagt nicht, in welchem Modus, welcher Runde oder welchem Level er passierte. | `FirebaseCrashlytics.instance.setCustomKey('mode', …)` bei Rundenstart; ebenso `puzzle_level` und `player_tier` |
| C-3 | **ANRs sind über Crashlytics nicht sichtbar.** ANRs erscheinen in **Android Vitals** in der Play Console, nicht in Crashlytics. | Vitals-Schwellen kennen und beobachten; die Kaltstartkette aus Phase 2, T-8 ist der wahrscheinlichste Kandidat |

C-2 ist billig und zahlt sich beim ersten echten Absturzbericht aus.

---

## 8. Umsetzungsreihenfolge

| # | Schritt | Aufwand | Warum in dieser Reihenfolge |
|---|---|---|---|
| 1 | A-2 schließen: Rätsel-Rewarded loggen | 30 min | Einzeiler, macht den Funnel vollständig |
| 2 | `rewarded_offered` / `_accepted` (A-3) | 2 h | liefert die Opt-in-Rate — die Größe, an der der gesamte Ad-Umsatz hängt |
| 3 | Ad-Revenue via `onPaidEvent` (A-4) | 3 h | ersetzt den fehlenden DE-eCPM-Benchmark durch Messung |
| 4 | FTUE-Ereignisse (`tutorial_*`, `first_placement`) | 2 h | macht L-1 aus Phase 3 überhaupt erst entscheidbar |
| 5 | Nutzereigenschaften (A-5) | 1 h | Segmentierung für alles Weitere |
| 6 | Consent an Analytics (Abschnitt 6) | 2 h | DSGVO-Konsistenz, stützt Phase 7 |
| 7 | Rätsel- und Retention-Ereignisse | 2 h | misst die Wirkung von L-2 |
| 8 | Crashlytics Custom Keys (C-2) | 1 h | zahlt sich beim ersten Absturz aus |

**Gesamt: rund 14 Stunden.**

Schritt 1–3 sind die Voraussetzung dafür, dass irgendeine Aussage aus Phase 4
überprüfbar wird. Alles davor ist Modell, nicht Messung.

---

## 9. Was diese Spezifikation bewusst auslässt

- **Kein eigenes Backend, kein zweiter Analytics-Anbieter.** `CLAUDE.md`
  schließt ein Backend aus, und jedes zusätzliche SDK vergrößert die
  Data-Safety-Fläche — bei einem Konto mit Enforcement-Vorgeschichte das
  falsche Risiko für den Nutzen.
- **Kein `setUserId`, keine Verknüpfung mit der Bestenlisten-Identität**
  (Begründung in Abschnitt 4).
- **Keine Werbe-ID-Nutzung über das hinaus, was AdMob ohnehin tut.**
- **Kein A/B-Testing im Client.** Firebase Remote Config wäre der nächste
  Schritt, bringt aber ein weiteres SDK und eine weitere Datenkategorie. Erst
  sinnvoll, wenn es genug Nutzer für aussagekräftige Gruppen gibt — was laut
  Phase 1c nicht der nahe Fall ist.

---

## Quellen

Alle API-Aussagen wurden gegen den lokalen Pub-Cache verifiziert:

| Datei | Zweck |
|---|---|
| `~/.pub-cache/hosted/pub.dev/google_mobile_ads-9.0.0/lib/src/ad_listeners.dart:36` | `OnPaidEventCallback`-Signatur |
| `~/.pub-cache/hosted/pub.dev/google_mobile_ads-9.0.0/lib/src/ad_containers.dart:65-80` | `ResponseInfo.mediationAdapterClassName` |
| `~/.pub-cache/hosted/pub.dev/firebase_analytics-12.4.5/lib/src/firebase_analytics.dart:383` | `logAdImpression`-Signatur |
| `~/.pub-cache/hosted/pub.dev/firebase_analytics-12.4.5/lib/src/firebase_analytics.dart:147, 196, 217` | `setConsent`, `setUserId`, `setUserProperty` |

Alle Aussagen über den aktuellen Zustand tragen eine Fundstelle in diesem Repo.
