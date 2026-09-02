# AUDIT — Qubble, Executive Summary

Stand 2026-08-31 · Commit `e07354f` · Vollaudit in `audit/`, Maßnahmen in `BACKLOG.md`

Vorgänger-Audit (Playtest, 26.08.2026): `audit/AUDIT-playtest-2026-08-26.md`.

---

## Die fünf wichtigsten Befunde

### 1. Die Bestenliste macht Qubble zu einer UGC-App — ohne die dafür nötige Moderation

Der Spieler wählt einen Anzeigenamen, dieser geht an Cloud Firestore und wird
**allen anderen Spielern öffentlich angezeigt** (`lib/services/leaderboard.dart:133-166`,
Firestore-Regel `allow read: if true`). Damit greift Googles Policy für
nutzergenerierte Inhalte: In-App-Meldefunktion, Blockfunktion,
Nutzungsbedingungen, zeitnahes Handeln.

Vorhanden ist eine client-seitige Wortliste (`lib/game/name_filter.dart`).
Nicht vorhanden: Meldefunktion, Blockfunktion, Nutzungsbedingungen — und
`allow delete: if false` verhindert sogar, dass der Betreiber einen gemeldeten
Eintrag über den normalen Client entfernt. Ein Wortfilter ist keine Moderation
im Sinne der Policy; die verlangt das Meldesystem zusätzlich.

Google erwartet nach einem Enforcement-Vorfall ausdrücklich die Eigenprüfung
des gesamten Kontos, nicht nur die Behebung des gerügten Punktes. Ein
öffentliches Namensfeld ohne Meldeweg ist die Art offene Flanke, die eine
Neuprüfung findet. → `audit/07-compliance.md` B-1

### 2. Die Store-Beschreibung bestreitet die Datenübertragung, die das Data-Safety-Formular deklarieren muss

Das Listing sagt „Kein Internet nötig, kein Konto, **kein Server**". Die App
sendet Anzeigename und Punktestand an Firestore und legt dafür eine anonyme
Firebase-Auth-Identität an. Zwei weitere Aussagen halten dem Abgleich ebenfalls
nicht stand: das Drei-Sterne-Versprechen im Rätselmodus (siehe Befund 4) und
„kein Zeitdruck" bei einem sichtbaren 10-Sekunden-Combo-Countdown, an dem
96,6 % aller Punkte hängen.

Der erste Widerspruch ist der gefährlichste, weil er denselben Sachverhalt
betrifft, den Google beim Data-Safety-Abgleich prüft — laut der Recherche der
häufigste Enforcement-Auslöser. Die gehostete Datenschutzerklärung
(`web/privacy.html`) beschreibt den Datenfluss **korrekt**; der Fehler steckt
allein im Marketing-Text. Bereinigte Fassungen liegen in `audit/copy/`.
→ `audit/07-compliance.md` B-2, `audit/05-aso.md`

### 3. Der Rätselmodus ist ab Level 9 konstant, und seine Sterne sind Dekoration

Eigene Messung über den Generator: Level-Block 20–40 braucht im Schnitt 7,75
Züge, Level-Block **480–500 genau 8,00**. Level 500 ist so schwer wie Level 20.
Ursache im Code: `bandCount` sättigt bei Level 9, `holesPerBand` bei Level 5,
`maxPieces` deckelt den Rest (`lib/game/puzzle.dart:314-316`).

Und in **200 von 200** geprüften Leveln gilt `minMoves == Teilezahl` — das
Brett leert sich per Konstruktion erst, wenn jedes Teil liegt. Also ist `moves`
beim Sieg immer exakt `minMoves`, und `PuzzleRules.stars` gibt **immer 3**
zurück. Ein und zwei Sterne sind unerreichbar; die Sternanzeige auf drei
Bildschirmen bewertet nichts.

Das trifft ausgerechnet den einzigen Inhalt mit echtem Fortschritt statt
Zufall — strukturell der beste Grund, an Tag 7 wiederzukommen.
→ `audit/03-loop.md` L-2

### 4. Drei Nebenbildschirme laufen schon bei Werkseinstellung über, und einer ist gar nicht übersetzt

Eine Messsonde über acht Screens × vier Textskalen × zwei Sprachen zeigt bei
**Textskala 1.0** auf 360×640: `AchievementsScreen` 177 px Überlauf,
`ThemesScreen` 22 px (EN) bzw. **122 px (DE)**, `StatsScreen` sieben Überläufe.
Ab Skala 1.3 — der ersten Stufe über der Werkseinstellung — ist auch der
Startbildschirm betroffen; bei 1.5 fehlen dem Erfolge-Screen 387 px.
Nichts in `lib/` fasst `textScaler` an.

Keiner der drei Screens kommt in einem Layout-Test vor. Dazu zeigt
`AchievementsScreen` auch in der englischen Fassung `const Text('Erfolge')`.
Der l10n-Test kann das strukturell nicht finden — alle vier seiner Prüfungen
laufen in der Richtung `arb → Code`. → `audit/02-technik.md` T-1, T-2, T-3

### 5. Das Geschäftsmodell setzt auf den Umsatzstrom, der im Genre nachweislich nicht trägt

Block Blast ist zwei Jahre in Folge der weltweit meistgeladene Mobile-Titel,
rund 23,8 Mio. Downloads allein im April 2026, über 200 Mio. MAU,
geschätzt 584 000 USD Werbeumsatz **pro Tag** — ohne Shop, ohne
In-App-Käufe, ohne soziale Funktionen. Bei IAP-Umsatz steht derselbe Titel auf
**Platz 3 264**.

Qubble verzichtet per nicht verhandelbarer Regel auf Interstitials und baut
stattdessen einen IAP-Katalog. Der oft zitierte Ausgleich („Rewarded bringt 3×
höhere eCPMs") hält nicht: Die einzigen konkreten Länderzahlen ergeben Faktor
**1,17** (16,49 gegen 14,08 USD, US-Android). Der Verzicht kostet nicht Preis,
sondern Menge — im Puzzle-Genre stehen 72,5 Interstitial-Impressions gegen 23,4
Rewarded pro Nutzer.

Dazu ein hausgemachtes Problem: Bei 3 Münzen je Linie und ~15 Linien je Runde
entspricht das 0,99-€-Münzpaket etwa **15 Minuten Spielzeit** — die drei
Münzpakete sind strukturell unverkäuflich. Das Unterstützer-Paket funktioniert,
weil es Kosmetik verkauft, die Münzen nicht kaufen können. Das ist das Modell,
das sich auszubauen lohnt. → `audit/01-markt.md`, `audit/04-monetarisierung.md`

---

## Ehrliche Einschätzung der Erfolgsaussichten

**Die Wiederzulassung ist erreichbar.** Konfidenz **mittel-hoch**. Beide
technischen Fristen, die heute — am 31.08.2026 — greifen, sind erfüllt:
targetSdk 36 und Play Billing 8.0.0, beides verifiziert statt angenommen. Die
Ads-Policy kann Qubble strukturell nicht verletzen, weil es kein anderes Format
einbindet. Der Admin-Riegel ist tatsächlich doppelt verriegelt, die
Datenschutzerklärung ist vollständig und genau, das Release-Artefakt wird im CI
gegen sechs Kriterien geprüft. Das Fundament ist besser als bei den meisten
Solo-Projekten. Die drei offenen Compliance-Punkte kosten zusammen unter
zwölf Stunden.

**Der kommerzielle Erfolg ist es nicht.** Konfidenz **hoch**, und das ist der
unbequeme Teil. Die Kategorie wird von einem Titel angeführt, der mehr
Downloads in einem Monat hat, als Qubble je erreichen wird, und dessen
Geschäftsmodell Qubble aus Prinzip ablehnt. Ohne UA-Budget bleibt der
Play-Suchkanal — der immerhin 88 % der Spiele-Downloads liefert und bei Android
dominanter ist als bei Apple. Realistisch ist ein kleiner, gut bewerteter
Titel mit organischem Wachstum und einem Monatsumsatz im niedrigen zwei- bis
dreistelligen Euro-Bereich.

Das ist kein Grund abzubrechen, sondern die Erfolgsdefinition zu korrigieren:
Qubble ist als Produkt verteidigbar und als Umsatzprojekt nicht tragfähig. Wer
das akzeptiert, hat ein sauber gebautes Spiel — 441 grüne Tests, 94,6 %
Abdeckung auf der Spiellogik, eine Balance-Analyse, die ihre eigene
Fehlprognose dokumentiert. Wer es nicht akzeptiert, muss die
Monetarisierungsregel neu bewerten, und das ist eine Eigentümerentscheidung.

**Eine Einschränkung, die dieses Audit trägt:** Die Ausführungsumgebung hat
eine enge Egress-Allowlist. `play.google.com`, `support.google.com` und
praktisch alle Analysedienste waren nicht direkt abrufbar; kein einziges
Wettbewerber-Listing konnte geöffnet werden. Policy-Texte und Benchmarks
stammen deshalb aus Suchreferaten, nicht aus Primärseiten. Jede solche Aussage
ist in den Phasendateien als solche markiert. Auch der Release-AAB ließ sich
hier nicht bauen — kein Android SDK, Download blockiert. Was das kostet und wie
es zu schließen ist, steht in `audit/02-technik.md`.

---

## Die drei Maßnahmen mit dem größten Hebel

### 1. Zwei Stunden Papierarbeit vor allem anderen

Store-Beschreibung ersetzen (15 min, Copy liegt fertig), CI-Release-Build
starten (10 min), Data-Safety-Deklaration korrigieren (1 h), IARC-Fragebogen auf
„Nutzerinteraktion: ja" (30 min).

Das ist der billigste Hebel des ganzen Audits. Es adressiert das größte
Zulassungsrisiko, kostet keinen Code, und der CI-Lauf beantwortet nebenbei vier
Fragen, die dieses Audit offenlassen musste — darunter, ob die Werbe-ID über
das Manifest-Merging hereinkommt und damit deklariert werden muss.

### 2. Die Bestenliste moderierbar machen (8 h)

Meldefunktion im Bestenlisten-Screen, ein Satz Nutzungsregel beim
Namensdialog, und ein „Bestenlisten-Eintrag löschen" in den Einstellungen mit
der passenden Firestore-Regel. Ohne Backend genügt für die Meldung ein
`mailto:`-Aufruf über den bereits eingebundenen `url_launcher`.

Das schließt den einzigen Punkt, an dem die App eine Policy-Anforderung
schlicht nicht erfüllt — und beseitigt zugleich den Umstand, dass „Fortschritt
löschen" heute die anonyme Identität und den öffentlichen Eintrag stehen lässt.

### 3. Messen, bevor weiter optimiert wird (7 h)

`rewarded_offered` und `_accepted` einführen, das stumme fünfte Rewarded
instrumentieren, Ad-Revenue über `onPaidEvent` erfassen, `first_placement`
loggen.

Heute wird nur der **eingelöste** Reward geloggt — der Nenner fehlt, also ist
die Opt-in-Rate unbekannt, und die bestimmt den gesamten Ad-Umsatz. `onPaidEvent`
liefert dazu den eigenen eCPM nach Land und ersetzt damit genau den Benchmark,
den die Recherche nicht auftreiben konnte. Und ohne `first_placement` bleibt
unentscheidbar, ob der Regeltext vor der ersten Runde tatsächlich Spieler
kostet.

Alles nach diesen drei Punkten ist Optimierung auf Basis von Daten statt auf
Basis von Annahmen — dieses Audit eingeschlossen.

---

## Umsetzungsstand, 2026-09-01

Der Text oben ist der Audit-Stand vom 31.08.2026 und bleibt unverändert — auch
die 441 Tests und die Befunde, von denen inzwischen mehrere behoben sind. Was
seitdem passiert ist, steht mit Commit in `BACKLOG.md`; hier nur die Bilanz:

| Block | Stand |
|---|---|
| **P0** (10) | 7 umgesetzt — alles, was im Code liegt. Offen sind **drei Console-Aktionen**, die nur der Kontoinhaber ausführen kann: CI-Release-Build (#2), IARC-Fragebogen auf „ja" (#4), Data-Safety-Formular korrigieren (#5, Vorlage in `docs/DATA-SAFETY.md`). |
| **P1** (12) | vollständig umgesetzt |
| **P2** (12) | 8 umgesetzt, 4 bewusst offen (#29, #31, #32, #34) — Begründung je Punkt in `BACKLOG.md` |

Testzahl 441 → **673**, `flutter analyze` ohne Befund.

Alle fünf Befunde oben sind adressiert, soweit sie im Code liegen: die
UGC-Moderation ist gebaut (Melden, Blocken, Löschweg, Nutzungsbedingungen), die
unbelegbaren Behauptungen sind aus den Verkaufstexten entfernt, der Rätselmodus
hat eine Schwierigkeitsrampe und ehrliche Sterne, die drei überlaufenden
Bildschirme sind repariert und gegen Rückfall getestet. Befund 5 ist keine
Code-Frage und bleibt offen — es ist eine Eigentümerentscheidung.

**Nachträglich aufgenommen, nicht Teil des ursprünglichen Audits:** ein
gemeldeter `androidx.startup.StartupException` deutet auf einen
R8-Startabsturz. Keep-Regeln sind ergänzt (`b3bd70d`, `5650e08`), und alle 14
Android-Plugins wurden systematisch auf dieselbe Klasse von Fehlern geprüft
(`audit/08-r8-risiko.md`, Werkzeug `tool/r8_risk_scan.py`).

**Am 02.09. geklärt und behoben.** Der vollständige Stacktrace nannte die
Ursache: R8 Full Mode behielt den Namen von `androidx.work.impl.WorkDatabase_Impl`,
entfernte aber dessen parameterlosen Konstruktor — genau den, den Room über
Reflexion aufruft. Alle drei Crashlytics-Einträge (142 Abstürze, 23 Nutzer)
gehen darauf zurück; der dritte sah nur anders aus, weil R8 die
`StartupException` beim Obfuskieren in ein fremdes Paket verschoben hatte.
Keep-Regel ergänzt, und der Release-Build **belegt** sie inzwischen selbst:
Er liest die von R8 erzeugte `seeds.txt` und scheitert, wenn der Konstruktor
fehlt.
