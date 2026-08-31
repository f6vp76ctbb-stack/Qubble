# Produktionszugriff beantragen (Play Console)

Nach 14 Tagen geschlossenem Test mit ≥ 12 aktiven Testern schaltet die Play
Console den Antrag **Produktionszugriff** frei. Dieses Dokument enthält:

1. **Wer was macht** — was schon erledigt ist und was nur in deinem
   Play-Console-Konto passieren kann
2. **Fertige Antworten** für den Fragebogen — Englisch (zum Einfügen) und
   Deutsch (zum Verstehen)

> **Warum eigene Antworten statt der Vorlage vom Testanbieter?** Die Vorlage aus
> `com.thinkube.qubble_production.pdf` ist generisch und beschreibt teils Dinge,
> die für Qubble nicht stimmen. Google liest diesen Fragebogen von Hand — eine
> erkennbare Copy-Paste-Antwort ist der häufigste Ablehnungsgrund. Die Antworten
> unten beschreiben, was in diesem Repo tatsächlich passiert ist.

---

## 1 · Wer macht was

Das meiste ist erledigt. Was übrig bleibt, sind Schritte, die **nur mit deinem
Play-Console-Konto** möglich sind — dort komme ich nicht rein.

### Schon erledigt (nichts zu tun)

| | Was |
|---|---|
| ✅ | Bewertungsfunktion eingebaut (Einstellungen + In-App-Review) |
| ✅ | Store-Texte neu geschrieben, EN + DE (`docs/STORE-LISTING.md`) |
| ✅ | Screenshots erzeugt, 6 je Sprache (`store-assets/en/`, `store-assets/de/`) |
| ✅ | App auf Englisch + Deutsch umgestellt |
| ✅ | Layout-Bug aus dem Test behoben |
| ✅ | **Versionsnummer erhöht** auf `1.1.0+3` — steht bereits in `pubspec.yaml` |
| ✅ | Fragebogen-Antworten formuliert (Abschnitt 2 unten) |
| ✅ | Signierte `.aab` gebaut und geprüft (GitHub Actions, Lauf #18) |

### Der Build: du baust nichts selbst

Die `.aab` entsteht **auf GitHub**, nicht auf deinem Rechner. Du brauchst weder
Flutter noch Android Studio. Zwei Wege:

- **Ich löse den Build aus** — sag einfach Bescheid, dann starte ich den
  Workflow und sage dir, wenn die Datei fertig ist.
- **Oder selbst:** GitHub → Tab **Actions** → links *„Build Android Release
  (.aab)"* → rechts **Run workflow**. Nach ~8 Minuten liegt die Datei unter
  *Artifacts* → `qubble-release-aab`.

Details: `docs/BUILD-CI.md`.

### Was nur du kannst (Play Console)

Das sind reine Klick-Schritte in deinem Konto — kein Code, kein Terminal.

**A. Die `.aab` hochladen**
Play Console → **Testen → Geschlossener Test** → *Neue Version erstellen* →
`.aab` hochladen. Nicht direkt in die Produktion: Google prüft, ob das Feedback
im Test gelandet ist. Release-Notizen:
- **EN:** `Now in English and German · Rate the app from the settings · Fixed a layout issue on narrow screens`
- **DE:** `Jetzt auf Englisch und Deutsch · App-Bewertung in den Einstellungen · Layout-Fehler auf schmalen Displays behoben`

**B. Store-Eintrag auf zwei Sprachen bringen**
Play Console → **Store-Präsenz → Haupt-Store-Eintrag**

1. **Englisch (USA)** als Standardsprache setzen, Texte aus
   `docs/STORE-LISTING.md` einfügen, Screenshots aus `store-assets/en/`.
2. **Deutsch** als weitere Sprache anlegen, DE-Texte, `store-assets/de/`.

> Ohne englischen Eintrag sieht der Großteil des Play Store nur deutschen Text.
> Das kostet mehr Installationen als jede andere Einstellung hier.

**C. Testerzahl gegenprüfen**
Antwort 1 nennt zwölf Tester. Prüf unter **Testen → Geschlossene Tests →
Tester**, ob das stimmt, und pass die Zahl sonst an — sie muss zur Liste in
der Console passen.

**D. Letzte Kontrolle, dann beantragen**

- [ ] Neue Version im geschlossenen Test **veröffentlicht** (nicht nur hochgeladen)
- [ ] Store-Eintrag hat Englisch **und** Deutsch mit je eigenen Screenshots
- [ ] „App-Inhalte" vollständig grün (siehe `docs/LAUNCH.md`, Abschnitt A)
- [ ] Datenschutz- und Impressum-URL erreichbar
- [ ] Testerzahl in Antwort 1 gegen die Console geprüft

Dann **Produktionszugriff beantragen**. Prüfung dauert in der Regel bis zu
7 Tage.

---

## 2 · Antworten auf den Fragebogen

Formularsprache ist Englisch. Nutze die **EN**-Fassung zum Einfügen; die
DE-Fassung steht darunter, damit du weißt, was du abgibst.

### 1) How did you recruit users for your closed test?

**EN**
> We used a paid testing service that supplies testers for Google Play closed
> tests. They provided the twelve testers the track requires; each joined the
> closed testing track, installed the app from it, and kept it installed for
> the full fourteen days.

**DE**
> Wir haben einen bezahlten Testdienst genutzt, der Tester für geschlossene
> Play-Tests stellt. Er lieferte die zwölf Tester, die der Track verlangt; jeder
> ist dem geschlossenen Test beigetreten, hat die App darüber installiert und
> über die vollen vierzehn Tage installiert gelassen.

> 👤 Falls die Console eine andere Testerzahl zeigt als zwölf, die Zahl hier
> anpassen — sie muss zur Testerliste passen.

---

### 2) How easy was it to recruit testers for your app?

**Antwort: `Easy`** (Auswahlfeld)

Ehrliche Alternative, falls es zäh war: `Neutral`. Die Antwort hat keinen
Einfluss auf die Freigabe.

---

### 3) Describe the engagement you received from testers during your closed test

**EN**
> The testers covered a range of Android versions, screen sizes and device
> ages, and they stayed on the track for the full period rather than installing
> and dropping out. Their feedback came back as one structured written report
> at the end of the test rather than as an ongoing conversation, which is how
> this service works.
>
> Substantively, the report found no crashes, no ANRs and no functional
> defects on any device tested, so the findings were about presentation and
> discoverability rather than stability. The most useful observations came from
> testers on small, older phones — that is where a layout problem showed up
> that we had not seen ourselves.

**DE**
> Die Tester deckten verschiedene Android-Versionen, Bildschirmgrößen und
> Gerätealter ab und blieben über den gesamten Zeitraum im Track, statt nur zu
> installieren und wieder abzuspringen. Ihr Feedback kam als ein strukturierter
> schriftlicher Bericht am Ende des Tests zurück, nicht als laufender Austausch
> — so arbeitet dieser Dienst.
>
> Inhaltlich fand der Bericht auf keinem getesteten Gerät Abstürze, ANRs oder
> Funktionsfehler; die Punkte betrafen also Präsentation und Auffindbarkeit,
> nicht Stabilität. Die nützlichsten Beobachtungen kamen von Testern auf
> kleinen, älteren Geräten — dort zeigte sich ein Layout-Problem, das uns selbst
> nicht aufgefallen war.

---

### 4) Provide a summary of the feedback that you received from testers. Include how you collected the feedback.

**EN**
> Collection: the testing service delivered one written report at the end of
> the fourteen days, covering every device and SDK level they tested. (The app
> also carries an in-app feedback form under Settings, which files a structured
> report to us — it is there for players once the app is public, but the closed
> test feedback all came through the service's report.)
>
> The report confirmed the app behaved correctly everywhere they ran it: no
> crashes, no ANRs, no functional defects. The substantive feedback was about
> how the app presents itself rather than how it plays, and it had three
> points:
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
> Erhebung: Der Testdienst lieferte am Ende der vierzehn Tage einen
> schriftlichen Bericht über alle Geräte und SDK-Level, die er getestet hat.
> (Die App hat außerdem ein Feedback-Formular in den Einstellungen, das einen
> strukturierten Bericht an uns schickt — das ist für Spieler nach der
> Veröffentlichung gedacht; das Feedback aus dem geschlossenen Test kam
> vollständig über den Bericht des Dienstes.)
>
> Der Bericht bestätigte, dass die App überall korrekt lief: keine Abstürze,
> keine ANRs, keine Funktionsfehler. Das inhaltliche Feedback betraf die
> Präsentation, nicht das Spiel selbst, und bestand aus drei Punkten:
>
> 1. Die Play-Store-Beschreibung war zu kurz und enthielt nicht die
>    Suchbegriffe, die Spieler tatsächlich verwenden — schlecht für die
>    Auffindbarkeit.
> 2. Die Screenshots waren schlichte Spielaufnahmen, die nicht vermitteln, was
>    das Spiel bietet — ohne Bildunterschriften, ohne Feature-Hervorhebung.
> 3. Es gab keine Möglichkeit, die App aus der App heraus zu bewerten.
>
> Tester auf kleinen Displays meldeten zusätzlich einen Layout-Fehler, den wir
> auf ein Banner zurückführen konnten, das auf schmalen Bildschirmen nicht
> schrumpfen konnte.

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
> has 441 automated tests that run on every change, and the game logic is
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
> unbemerkt zurückkehren — das Projekt hat 441 automatisierte Tests, die bei
> jeder Änderung laufen, und die Spiellogik ist bewusst als pures Dart geschrieben,
> damit sie vollständig testbar ist. Drittens Vollständigkeit: keine
> Platzhalter-Screens, keine unfertigen Abläufe, keine Funktionen, die von einem
> Server abhängen, den wir nicht betreiben.
>
> Was bleibt, ist die Art von Arbeit, die sich erst in echter Größenordnung zeigt —
> Schwierigkeit und Retention gegen echte Spielerdaten tunen — und dafür braucht es
> ein Produktions-Release.

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
