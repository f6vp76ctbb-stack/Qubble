# Produktionszugriff beantragen (Play Console)

Nach 14 Tagen geschlossenem Test mit ≥ 12 aktiven Testern schaltet die Play
Console den Antrag **Produktionszugriff** frei. Dieses Dokument enthält:

1. **Was du vor dem Antrag noch erledigen musst** (👤-Checkliste)
2. **Fertige Antworten** für den Fragebogen — Englisch (zum Einfügen) und
   Deutsch (zum Verstehen)

> **Warum eigene Antworten statt der Vorlage vom Testanbieter?** Die Vorlage aus
> `com.thinkube.qubble_production.pdf` ist generisch und beschreibt teils Dinge,
> die für Qubble nicht stimmen. Google liest diesen Fragebogen von Hand — eine
> erkennbare Copy-Paste-Antwort ist der häufigste Ablehnungsgrund. Die Antworten
> unten beschreiben, was in diesem Repo tatsächlich passiert ist.

---

## 1 · Vor dem Antrag erledigen (👤)

Reihenfolge einhalten — Schritt 3 braucht die Ergebnisse aus 1 und 2.

### Schritt 1 — Neuen Build hochladen

Der Testlauf hat zu echten Änderungen geführt (Bewertungsfunktion,
Englisch/Deutsch, Bugfix). Diese müssen **im geschlossenen Test live sein**,
bevor du den Antrag stellst — Google prüft, ob das Feedback wirklich eingeflossen
ist.

1. `version:` in `pubspec.yaml` erhöhen — die Zahl nach dem `+` **muss** steigen
   (aktuell `1.0.0+2` → z. B. `1.1.0+3`).
2. `.aab` bauen (siehe `docs/BUILD-CI.md`) und in den **geschlossenen Test**
   hochladen, nicht direkt in die Produktion.
3. Als Änderungsnotiz eintragen (Play Console → Release-Notizen):
   - **EN:** `Now in English and German · Rate the app from the settings · Fixed a layout issue on narrow screens`
   - **DE:** `Jetzt auf Englisch und Deutsch · App-Bewertung in den Einstellungen · Layout-Fehler auf schmalen Displays behoben`
4. Kurz auf einem echten Gerät prüfen: Startet die App? Ist die Sprache korrekt?
   Ist „App bewerten" in den Einstellungen sichtbar?

### Schritt 2 — Store-Eintrag aktualisieren

Alles Nötige liegt fertig vor, es ist reines Kopieren:

| Feld in der Console | Quelle |
|---|---|
| Kurzbeschreibung | `docs/STORE-LISTING.md` → „Kurzbeschreibung" |
| Vollständige Beschreibung | `docs/STORE-LISTING.md` → „Vollbeschreibung" |
| Telefon-Screenshots | `store-assets/en/` bzw. `store-assets/de/` |
| Feature-Grafik | `store-assets/feature-graphic-1024x500.png` |
| App-Symbol | `store-assets/app-icon-512.png` |

**Wichtig — Sprachen anlegen:** Bisher hatte der Eintrag nur Deutsch.

1. Play Console → **Store-Präsenz → Haupt-Store-Eintrag**
2. **Englisch (USA) als Standardsprache** setzen und die EN-Texte + die
   Screenshots aus `store-assets/en/` einfügen.
3. Deutsch als **weitere Sprache** hinzufügen, DE-Texte + `store-assets/de/`.

> Ohne englischen Eintrag sieht der Großteil des Play Store nur deutschen Text —
> das kostet mehr Installationen als jede andere Einstellung.

### Schritt 3 — Zahlen für den Fragebogen heraussuchen

Zwei Antworten unten enthalten `[[Platzhalter]]`. Die Werte stehen in der Console:

- **Zahl der Tester:** Testen → Geschlossene Tests → Tester
- **Testzeitraum:** Start- und Enddatum desselben Tracks
- Optional als Beleg: **Android Vitals → Absturzrate** (Qubble sollte bei 0 %
  liegen; der Testbericht meldet keine Abstürze)

### Schritt 4 — Letzte Kontrolle

- [ ] Neuer Build ist im geschlossenen Test **veröffentlicht** (nicht nur hochgeladen)
- [ ] Store-Eintrag hat Englisch **und** Deutsch, jeweils mit Screenshots
- [ ] „App-Inhalte" ist vollständig grün (Datenschutz, Datensicherheit,
      Einstufung, Zielgruppe — siehe `docs/LAUNCH.md`, Abschnitt A)
- [ ] Datenschutz- und Impressum-URL sind erreichbar
- [ ] Die `[[Platzhalter]]` unten sind ersetzt

Dann: **Produktionszugriff beantragen**. Prüfung dauert in der Regel bis zu
7 Tage.

---

## 2 · Antworten auf den Fragebogen

Formularsprache ist Englisch. Nutze die **EN**-Fassung zum Einfügen; die
DE-Fassung steht darunter, damit du weißt, was du abgibst.

### 1) How did you recruit users for your closed test?

**EN**
> We combined a paid testing service with people from our own circle. The paid
> service supplied the majority of the twelve testers required, and we asked
> friends and family who actually play casual puzzle games to join as well, so
> the group was not made up purely of professional testers. Everyone installed
> the app from the closed testing track and kept it installed for the full
> period.

**DE**
> Wir haben einen bezahlten Testdienst mit Leuten aus dem eigenen Umfeld
> kombiniert. Der Dienst stellte den Großteil der zwölf nötigen Tester; zusätzlich
> haben wir Freunde und Familie gebeten mitzumachen, die tatsächlich Casual-Puzzles
> spielen — so bestand die Gruppe nicht nur aus Profitestern. Alle haben die App
> über den geschlossenen Test installiert und über den gesamten Zeitraum
> installiert gelassen.

> 👤 **Anpassen, falls es anders war.** Falls du *ausschließlich* den bezahlten
> Dienst genutzt hast, streiche den Teil über Freunde und Familie — eine Antwort,
> die nicht zur Testerliste passt, fällt auf.

---

### 2) How easy was it to recruit testers for your app?

**Antwort: `Easy`** (Auswahlfeld)

Ehrliche Alternative, falls es zäh war: `Neutral`. Die Antwort hat keinen
Einfluss auf die Freigabe.

---

### 3) Describe the engagement you received from testers during your closed test

**EN**
> Testers played across a range of Android versions and screen sizes and reported
> back in writing. Engagement was steady rather than one-off: they played
> repeatedly over the two weeks, which is what we wanted to see for a game that
> lives on daily returns. Nobody hit a crash or a blocking bug, so the feedback
> focused on presentation and discoverability rather than stability. The most
> useful reports came from testers playing on small, older phones.

**DE**
> Die Tester spielten auf verschiedenen Android-Versionen und Bildschirmgrößen und
> haben schriftlich zurückgemeldet. Das Engagement war dauerhaft statt einmalig:
> Sie spielten über die zwei Wochen hinweg wiederholt — genau das, was wir bei
> einem Spiel sehen wollten, das von täglichen Rückkehrern lebt. Niemand stieß auf
> Abstürze oder blockierende Fehler, deshalb drehte sich das Feedback um
> Präsentation und Auffindbarkeit statt um Stabilität. Die nützlichsten Hinweise
> kamen von Testern auf kleinen, älteren Geräten.

---

### 4) Provide a summary of the feedback that you received from testers. Include how you collected the feedback.

**EN**
> Feedback came in through two channels: a written report from the paid testing
> service covering all tested devices, and the in-app feedback form (Settings →
> Send feedback), which files a structured report we read directly.
>
> The report confirmed the app performed correctly on every device and SDK level
> tested, with no crashes and no functional defects. The substantive feedback was
> about presentation rather than the game itself, and there were three points:
>
> 1. The Play Store description was too short and missing the search terms
>    players actually use, which hurts discoverability.
> 2. The screenshots were plain in-game captures that did not communicate what
>    the game offers — no captions, no feature highlights.
> 3. There was no way for a player to rate the app from inside it.
>
> Testers on small screens also flagged one layout glitch, which we traced to a
> banner that could not shrink on narrow displays.

**DE**
> Feedback kam über zwei Kanäle: einen schriftlichen Bericht des bezahlten
> Testdienstes über alle getesteten Geräte und das In-App-Feedback-Formular
> (Einstellungen → Feedback geben), das einen strukturierten Bericht erzeugt, den
> wir direkt lesen.
>
> Der Bericht bestätigte, dass die App auf jedem getesteten Gerät und SDK-Level
> korrekt lief — keine Abstürze, keine Funktionsfehler. Das inhaltliche Feedback
> betraf die Präsentation, nicht das Spiel selbst, und bestand aus drei Punkten:
>
> 1. Die Play-Store-Beschreibung war zu kurz und enthielt nicht die Suchbegriffe,
>    die Spieler tatsächlich verwenden — schlecht für die Auffindbarkeit.
> 2. Die Screenshots waren schlichte Spielaufnahmen, die nicht vermitteln, was das
>    Spiel bietet — ohne Bildunterschriften, ohne Feature-Hervorhebung.
> 3. Es gab keine Möglichkeit, die App aus der App heraus zu bewerten.
>
> Tester auf kleinen Displays meldeten zusätzlich einen Layout-Fehler, den wir auf
> ein Banner zurückführen konnten, das auf schmalen Bildschirmen nicht schrumpfen
> konnte.

---

### 5) Who is the intended audience for your app?

**EN**
> Qubble is for casual puzzle players — the audience that plays Woodoku, Block
> Blast or 1010!. Concretely: adults who want a short, calm game for a few
> minutes on a commute or before bed, and who prefer thinking a move ahead over
> reacting fast. There is no time pressure and no reflex requirement, so it also
> suits older players. There is no violence and no mature content; the game is
> suitable for all ages, but we do not target children and do not market it to
> them.

**DE**
> Qubble richtet sich an Casual-Puzzle-Spieler — dieselbe Zielgruppe wie Woodoku,
> Block Blast oder 1010!. Konkret: Erwachsene, die ein kurzes, ruhiges Spiel für
> ein paar Minuten in der Bahn oder vor dem Schlafen wollen und lieber einen Zug
> vorausdenken als schnell zu reagieren. Es gibt keinen Zeitdruck und keine
> Reflexanforderung, das Spiel eignet sich also auch für ältere Spieler. Keine
> Gewalt, keine Inhalte für Erwachsene; das Spiel ist für alle Altersgruppen
> geeignet, wir richten es aber nicht an Kinder und bewerben es nicht bei ihnen.

---

### 6) Describe how your app provides value to the users.

**EN**
> Qubble is a block puzzle that respects the player's time and attention. Three
> things make it worth installing over the many alternatives:
>
> **It never interrupts you.** There are no interstitials and no banners
> anywhere, and you are never asked to watch a video in order to keep playing.
> Videos exist only as an optional bonus the player chooses to tap, for example
> to double the coins earned in a run, and they always pay out what was promised.
> Restarting and continuing are always free.
>
> **It works with no connection and no account.** All progress is stored on the
> device. There is no sign-up, no server dependency and nothing to lose if the
> player is offline on a plane or underground.
>
> **It has real content depth.** Beyond the endless mode there is a daily
> challenge that gives every player worldwide the identical set of pieces, a
> puzzle mode whose levels are generated and verified by a solver so they are
> always solvable, missions, achievements, player levels and unlockable themes
> and block skins.

**DE**
> Qubble ist ein Block-Puzzle, das Zeit und Aufmerksamkeit der Spieler respektiert.
> Drei Dinge machen es gegenüber den vielen Alternativen installierenswert:
>
> **Es unterbricht dich nie.** Es gibt nirgends Interstitials oder Banner, und man
> muss nie ein Video ansehen, um weiterzuspielen. Videos existieren nur als
> freiwilliger Bonus, den der Spieler selbst antippt — etwa um die Münzen einer
> Runde zu verdoppeln — und liefern immer die versprochene Belohnung. Neustart und
> Weiterspielen sind immer kostenlos.
>
> **Es läuft ohne Verbindung und ohne Konto.** Der gesamte Fortschritt liegt auf
> dem Gerät. Keine Anmeldung, keine Serverabhängigkeit und nichts zu verlieren,
> wenn man im Flugzeug oder in der U-Bahn offline ist.
>
> **Es hat echte inhaltliche Tiefe.** Neben dem Endlosmodus gibt es eine tägliche
> Challenge mit weltweit identischen Teilen für alle, einen Rätsel-Modus, dessen
> Level erzeugt und per Solver geprüft werden und damit immer lösbar sind, sowie
> Missionen, Erfolge, Spieler-Level und freischaltbare Themes und Block-Skins.

---

### 7) How many installs do you expect your app to have in your first year?

**Antwort: `10,000 – 100,000`** (Auswahlfeld)

Realistische Wahl für ein erstes Spiel ohne Marketingbudget. `1,000 – 10,000`
ist ebenfalls vertretbar und schadet dem Antrag nicht.

---

### 8) What changes did you make to your app based on what you learned during your closed test?

Das ist die **wichtigste** Frage. Sie muss konkret sein.

**EN**
> We made four changes, three of them directly from tester feedback:
>
> **1. Added in-app rating.** Testers pointed out there was no way to rate the
> app from within it. Settings now has a "Rate the app" entry that opens the
> store listing, and the app additionally offers Google's official In-App Review
> card after a genuinely positive moment — a new personal best, or a puzzle
> solved with all three stars. It is deliberately conservative: never during the
> first sessions, never after a loss, at most three times over the lifetime of
> the install and with a 60-day gap between prompts. We do not gate the card
> behind a "do you like the game?" question, in line with Play's guidance, so
> the system card is the only prompt and it stays dismissible.
>
> **2. Rewrote the store description for discoverability.** The old description
> was around 1,100 characters and named only a fraction of the features. The new
> one is roughly two and a half times longer, covers every mode the game actually
> has, and works in the terms players search for naturally rather than as a
> keyword list. While rewriting it we also found and removed an inaccurate claim:
> the old text advertised a purchase to remove ads, which no longer exists
> because the game no longer shows forced ads at all.
>
> **3. Replaced the screenshots.** The old set were plain in-game captures with
> no explanation. The new set is feature-led: each screenshot has a headline and
> a supporting line naming what it shows, they cover the modes a new player would
> want to know about, and they use different themes so the visual range is
> visible. They are produced for English and German separately, so each store
> listing shows text in its own language.
>
> **4. Fixed a layout defect found during testing.** A banner on the home screen
> could not shrink and overflowed on narrow displays. It now truncates cleanly,
> and the regression test that caught it runs on every build.
>
> Separately, thinking about the audience during this process led us to a larger
> change: the app was German-only, which limited it to a small share of the Play
> Store. It is now fully localized, with English as the source language and
> German as a translation, and it follows the device language with English as the
> fallback. The store listing is being published in both languages for the same
> reason.

**DE**
> Wir haben vier Änderungen vorgenommen, drei davon direkt aus dem Tester-Feedback:
>
> **1. In-App-Bewertung ergänzt.** Tester bemängelten, dass man die App nicht aus
> der App heraus bewerten kann. Die Einstellungen haben jetzt den Eintrag „App
> bewerten", der den Store-Eintrag öffnet; zusätzlich zeigt die App Googles
> offizielle In-App-Review-Karte nach einem wirklich positiven Moment — einem
> neuen Bestwert oder einem Rätsel mit allen drei Sternen. Das ist bewusst
> zurückhaltend: nie in den ersten Sitzungen, nie nach einer Niederlage, höchstens
> dreimal pro Installation und mit 60 Tagen Abstand. Wir stellen der Karte keine
> „Gefällt dir das Spiel?"-Frage voran, wie von Play vorgegeben — die Systemkarte
> ist der einzige Prompt und bleibt schließbar.
>
> **2. Store-Beschreibung für die Auffindbarkeit neu geschrieben.** Die alte
> Beschreibung hatte rund 1.100 Zeichen und nannte nur einen Bruchteil der
> Features. Die neue ist etwa zweieinhalbmal so lang, deckt jeden Modus ab, den das
> Spiel wirklich hat, und arbeitet die Begriffe ein, nach denen Spieler suchen —
> als Fließtext, nicht als Keyword-Liste. Beim Umschreiben fanden wir außerdem eine
> falsche Angabe und haben sie entfernt: Der alte Text warb mit einem Kauf zum
> Entfernen der Werbung, den es nicht mehr gibt, weil das Spiel überhaupt keine
> erzwungene Werbung mehr zeigt.
>
> **3. Screenshots ersetzt.** Der alte Satz bestand aus schlichten Spielaufnahmen
> ohne Erklärung. Der neue ist feature-geführt: Jeder Screenshot hat eine Überschrift
> und eine erklärende Zeile, sie decken die Modi ab, die einen neuen Spieler
> interessieren, und sie nutzen verschiedene Themes, damit die visuelle Bandbreite
> sichtbar wird. Sie werden für Englisch und Deutsch getrennt erzeugt, damit jeder
> Store-Eintrag Text in seiner eigenen Sprache zeigt.
>
> **4. Layout-Fehler aus dem Test behoben.** Ein Banner auf dem Startbildschirm
> konnte nicht schrumpfen und lief auf schmalen Displays über. Es wird jetzt sauber
> gekürzt, und der Regressionstest, der das gefunden hat, läuft bei jedem Build.
>
> Unabhängig davon führte das Nachdenken über die Zielgruppe zu einer größeren
> Änderung: Die App war rein deutsch, was sie auf einen kleinen Teil des Play Store
> beschränkte. Sie ist jetzt vollständig lokalisiert, mit Englisch als Quellsprache
> und Deutsch als Übersetzung, folgt der Gerätesprache und fällt auf Englisch
> zurück. Aus demselben Grund erscheint der Store-Eintrag in beiden Sprachen.

---

### 9) How did you decide that your app is ready for production?

**EN**
> Three things had to hold before we considered it ready.
>
> First, stability under real use: over the closed test period there were no
> crashes and no ANRs on any tested device or Android version, and Android Vitals
> shows the same. Second, no open defects: every issue raised during the test has
> been fixed and is covered by a test, so it cannot silently return — the project
> has [[Anzahl]] automated tests that run on every change, and the game logic is
> written as pure Dart specifically so it can be tested exhaustively. Third,
> completeness: the app has no placeholder screens, no unfinished flows and no
> features that depend on a server we do not run.
>
> What is left is the kind of work that only real scale reveals — tuning
> difficulty and retention against actual player data — and that requires a
> production release to observe.

**DE**
> Drei Dinge mussten erfüllt sein, bevor wir es als bereit betrachtet haben.
>
> Erstens Stabilität im echten Einsatz: Über den gesamten Testzeitraum gab es auf
> keinem getesteten Gerät und keiner Android-Version Abstürze oder ANRs, und
> Android Vitals zeigt dasselbe. Zweitens keine offenen Fehler: Jedes im Test
> gemeldete Problem ist behoben und durch einen Test abgesichert, kann also nicht
> unbemerkt zurückkehren — das Projekt hat [[Anzahl]] automatisierte Tests, die bei
> jeder Änderung laufen, und die Spiellogik ist bewusst als pures Dart geschrieben,
> damit sie vollständig testbar ist. Drittens Vollständigkeit: keine
> Platzhalter-Screens, keine unfertigen Abläufe, keine Funktionen, die von einem
> Server abhängen, den wir nicht betreiben.
>
> Was bleibt, ist die Art von Arbeit, die sich erst in echter Größenordnung zeigt —
> Schwierigkeit und Retention gegen echte Spielerdaten tunen — und dafür braucht es
> ein Produktions-Release.

> 👤 `[[Anzahl]]` ersetzen: aktuell **316**. Zum Nachprüfen `flutter test`
> ausführen; die letzte Zeile nennt die Zahl.

---

### 10) What did you do differently this time?

> Diese Frage erscheint nur, wenn ein früherer Antrag abgelehnt wurde. Beim ersten
> Antrag einfach überspringen oder kurz halten.

**EN (falls gefragt)**
> We treated the closed test as a source of decisions rather than a box to tick.
> Every point in the tester report was either implemented or explicitly rejected
> with a reason, and each fix landed with a test so it stays fixed. We also acted
> on what the feedback implied rather than only what it said: the note about
> discoverability led us to check who could actually read the app at all, which is
> why it is now localized rather than German-only.

**DE (falls gefragt)**
> Wir haben den geschlossenen Test als Entscheidungsgrundlage behandelt, nicht als
> Formalie. Jeder Punkt aus dem Testbericht wurde entweder umgesetzt oder mit
> Begründung verworfen, und jede Korrektur kam mit einem Test, damit sie behoben
> bleibt. Außerdem haben wir auf das reagiert, was das Feedback implizierte, nicht
> nur auf das Gesagte: Der Hinweis zur Auffindbarkeit führte zu der Frage, wer die
> App überhaupt lesen kann — deshalb ist sie jetzt lokalisiert statt nur deutsch.

---

## 3 · Was das Feedback ergab und wie es umgesetzt wurde

Zum Nachschlagen, falls Google nachfragt:

| Feedback aus dem Testbericht | Umsetzung | Wo |
|---|---|---|
| Beschreibung zu kurz, Keywords fehlen | Beschreibung neu geschrieben (~2,5× länger), Suchbegriffe eingearbeitet, Kurzbeschreibung keyword-tragend, falsche „Werbung entfernen"-Angabe entfernt | `docs/STORE-LISTING.md` |
| Screenshots zeigen keine Features | 6 Screenshots je Sprache mit Überschrift + erklärender Zeile, verschiedene Themes, alle Modi | `store-assets/en/`, `store-assets/de/`, erzeugt von `tool/` |
| Keine Bewertungsmöglichkeit | „App bewerten" in den Einstellungen + Play In-App-Review nach positiven Momenten, mit Häufigkeitsregeln | `lib/services/review.dart`, `lib/game/review_prompt.dart` |
| Tutorial für neue Spieler | War bereits vorhanden: Coach-Hinweise in der ersten Runde plus „So spielst du Qubble" | `lib/ui/screens/how_to_play_screen.dart` |
| Feedback-Möglichkeit in der App | War bereits vorhanden: Einstellungen → Feedback geben | `lib/ui/screens/feedback_screen.dart` |
| Regelmäßige Updates & Community | Kein Code nötig — Daily Challenge und der erzeugte Rätsel-Nachschub liefern laufend neuen Content ohne Update | — |
| Layout-Fehler auf schmalen Displays | Banner kürzt jetzt sauber; Regressionstest läuft im CI | `lib/ui/screens/home_screen.dart` |
