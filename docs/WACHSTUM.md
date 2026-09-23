# Wachstum: mehr Downloads — Ideen, Stand, offene Fragen

Stand 23.09.2026 · Branch `claude/app-download-strategies-qi5eme`

Auftrag: „Ideen für die App, sodass wir die Downloads stärken — und umsetzen."
Grundregel dabei: **Policy-Compliance vor allem anderen** (HANDOVER §0 — ein
zweiter Vorfall beendet das Projekt). Jede Idee unten ist daran gemessen.

---

## 1. Wovon Downloads bei Qubble abhängen (belegt, nicht geschätzt)

| Befund | Beleg | Folge |
|---|---|---|
| **88 %** der Play-Spiele-Downloads kommen aus Suche und Browse | Sensor Tower, Suchreferat in `audit/01-markt.md` | Der Store selbst ist der Kanal. Ohne UA-Budget zählt, **in wie vielen Suchen** Qubble auftaucht und **wie viele** dann installieren. |
| Ein Store-Eintrag rankt nur für Suchen **in seiner Sprache** | Google-Play-Console-Seiten zu Übersetzung/Store-Eintrag, Suchreferat (Primärseite hier gesperrt) | Bis heute: nur EN + DE. Alle anderen Märkte sahen den englischen Text. |
| Bindung und Bewertungen fließen ins Ranking | `audit/01-markt.md`, Suchreferat Google I/O 2026 | Bewertungsvolumen und Retention sind Wachstumshebel, nicht nur „Qualität". |
| Weitere Store-Sprachen waren **bewusst zurückgestellt** — weil die App nur EN/DE sprach | `BACKLOG.md`, „Bewusst nicht tun" | Hebel lag bereit, blockiert von genau einer Sache: der App-Übersetzung. |

Daraus die Reihenfolge: **(1) Reichweite in der Suche** (Sprachen),
**(2) Umwandlung auf der Store-Seite** (lokalisierte Bilder),
**(3) Bewertungen**, **(4) Weiterempfehlung**.

---

## 2. Umgesetzt in diesem Branch

| # | Was | Warum es Downloads bringt | Commit |
|---|---|---|---|
| 1 | **App in 9 neuen Sprachen**: Spanisch, Portugiesisch (BR), Französisch, Italienisch, Türkisch, Indonesisch, dann Vietnamesisch, Polnisch, Niederländisch — 347 Texte je Sprache, ICU-Plurale (Polnisch mit one/few/many), Sprachwahl in den Einstellungen | Entsperrt die Store-Einträge in diesen Sprachen (siehe 2) — vorher hätte ein spanischer Eintrag eine englische App versprochen | `3b87a6f` |
| 2 | **Store-Texte** (Titel, Kurz-, Vollbeschreibung) für es-419/es-ES, pt-BR, fr-FR, it-IT, tr-TR, id, nl-NL, pl-PL, vi | Qubble taucht in Suchen in diesen Sprachen auf; Aussage für Aussage wie der englische Text | `2c12aca` |
| 3 | **Screenshots + Feature-Grafik** in allen 9 Sprachen, aus der App in der Sprache gerendert | Die Bilder tragen den Großteil der Installationsentscheidung — jetzt mit Text, den der Spieler lesen kann | `ba17f0d` |
| 4 | **Bewertungskarte nach neuem Bestwert** — war geplant (MASTERPLAN 7b) und Google so mitgeteilt (`docs/PRODUCTION-ACCESS.md`), aber nie angeschlossen; die Karte kam nur nach 3-Sterne-Rätseln | Mehr Bewertungen → bessere Umwandlung und Ranking. Und die Aussage an Google stimmt jetzt | `e7f3fd7` |
| 5 | **Link-Vorschau** für den geteilten Daily-Link (Open Graph + 1200×630-Bild) | Ein geteiltes Ergebnis kam als nackte URL an; jetzt mit Bild und Text in WhatsApp & Co. | `3fa8606` |
| 6 | **Deutsche Skin-Namen in der englischen App** behoben („Verlauf", „Kristall", „Level 4: Verlauf-Skin") | Sichtbarer Übersetzungsfehler → Bewertungen | `635744f` |
| 7 | **5 Screens liefen auf 360-px-Handys über** (Game-Over, Skins, Daily, Rätsel-Level, Feedback) — teils schon auf Englisch | Kaputt wirkende Screens → Bewertungen | `9ede775` |
| 8 | **Gameplay-Video** aus der echten App (echte Drag-Gesten, echte Sounds), sprachneutral | Promo-Video im Store und Clips für Shorts/TikTok (MASTERPLAN Phase 5) | siehe Git-Log |
| 9 | **Punktzahl brach im Spiel um**, sobald das Combo-Abzeichen erschien („4,1/74", „SCOR/E") — auf 360-dp-Handys, auch auf Englisch | Sichtbarer Darstellungsfehler mitten im Spiel | `64e00ef` |
| 10 | **Japanisch, Koreanisch, Thai, Chinesisch und Arabisch** (dritte Welle; Chinesisch vereinfacht und traditionell, Arabisch von rechts nach links mit grammatisch korrekten Zahlformen): App, Store-Texte `ja-JP`/`ko-KR`/`th`/`zh-CN`/`zh-TW`/`zh-HK`/`ar`, Screenshots und Feature-Grafik. Nur Android/iOS — Nunito hat keine CJK-/Thai-Zeichen, der Web-Build lässt sie weg statt Schriften von Google nachzuladen. Taiwan/Hongkong-Handys bekommen automatisch die traditionelle Schrift | Zwei große Play-Märkte, in denen ein englischer Eintrag kaum gefunden wird; die Bilder zeigen die App so, wie das Handy sie zeichnet (Noto Sans CJK) | siehe Git-Log |
| 11 | **Geteilter Daily-Link öffnet direkt das Daily** (`…/Qubble/?daily`): wer ein geteiltes Ergebnis anklickt, landet auf demselben Brett statt auf der Startseite. Schon gespielt → Startseite mit Countdown; ein laufendes Daily wird beim Neuladen fortgesetzt | Ein Klick weniger zwischen Neugier und erstem Zug — genau an der Stelle, an der der Teilen-Loop neue Spieler bringt. Im Web-Build in Chromium geprüft | siehe Git-Log |
| 12 | **Web-Build fragte nach Erinnerungen, die nie kommen**: beim 2. Besuch „Erinnerungen?" — ein „Ja" bewirkte nichts; der Schalter in den Einstellungen riet zu „Systemeinstellungen" | Ein leeres Versprechen an genau die Spieler, die zurückkommen | siehe Git-Log |

**Absicherung, damit das so bleibt:** Jede Sprache läuft durch alle
Layout-Tests (jeder Screen, Game-Over, HUD, mehrere Schriftgrößen); ein neuer
Test liest die Zeichentabelle der Schrift Nunito und schlägt fehl, sobald ein
Text ein Zeichen enthält, das der Web-Build von Google nachladen müsste; die
Store-Texte werden auf Feldlängen, verbotene Titelwörter und gleiche
Theme-Namen wie in der App geprüft. Der Web-Build wurde in headless Chromium
auf Spanisch, Türkisch und Französisch gestartet: richtige Sprache, **null**
externe Anfragen.

Tests: 828 → **1947**, `flutter analyze` ohne Befund.

---

## 3. Was du tun musst, damit es wirkt

Nichts davon kann ich aus der Umgebung heraus. **Menüpfade schreibe ich
bewusst nicht** (CLAUDE.md) — wenn eine Stelle in der Console unklar ist,
schick mir einen Screenshot, dann sage ich dir, was wohin gehört.

1. **Neuen Build hochladen.** Die Übersetzungen stecken im App-Code; erst ein
   neuer Build bringt sie auf die Geräte. Versionsnummer: siehe Frage 4 unten.
2. **Im Store-Eintrag die Sprachen hinzufügen** und je Sprache eintragen:
   - Texte aus `store-assets/listing/<code>/` (drei Dateien, direkt kopierbar)
   - Feature-Grafik und 6 Screenshots aus `store-assets/<sprache>/`
   - Spanisch **zweimal** anlegen (Lateinamerika und Spanien), gleiche Texte
     und Bilder — Play behandelt die beiden als getrennte Sprachen.
   - Details und Sprachcodes: `docs/STORE-LISTING.md`, Abschnitt „Weitere
     Sprachen".
3. **Einmal den Live-Eintrag auf dem Handy ansehen** (EN/DE): Die Texte in
   `docs/STORE-LISTING.md` sind für den Editor auf 80 Zeichen umbrochen. Falls
   sie so eingefügt wurden, zeigt Play halbe Zeilen.

---

## 4. Offene Fragen an dich

Ich habe dazu **nichts** umgesetzt, weil die Antwort bei dir liegt.

1. **Ist der Play-Eintrag öffentlich erreichbar** (Produktion oder offener
   Test, von jedem Gerät aus installierbar)? Wenn ja, zwei schnelle Hebel:
   - Der Teilen-Text verweist heute auf die Web-Version. Mit öffentlichem
     Eintrag könnte er auf **Play** zeigen (eine Installation statt eines
     Browser-Spiels).
   - Die Web-Version könnte Android-Besuchern „App bei Google Play holen"
     anbieten (Manifest-Feld `related_applications`; Chrome kann dann die
     native App statt der PWA vorschlagen — laut Chrome-/MDN-Doku per
     Suchreferat, Primärseiten hier gesperrt).
2. **Konkurrenz-Absatz in EN/DE entfernen?** („Du magst Woodoku, Block
   Blast …"). Ob das unter „irreführende Verweise" der Metadaten-Richtlinie
   fällt, konnte ich nicht belegen. In den neuen Sprachen habe ich ihn
   weggelassen. **Empfehlung: auch in EN/DE raus** — bei der Vorgeschichte ist
   das die billigere Seite des Risikos.
3. **Teilen-Knopf auch nach einem neuen Bestwert?** MASTERPLAN (Block 3) legt
   das Teilen bewusst nur aufs Daily („nur dort ist ein Ergebnis
   vergleichbar"). Ein „Neuer Rekord"-Teilen wäre Angeberei statt Vergleich —
   ein häufiger Wachstumsmechanismus, aber eine Abweichung vom Plan. Deine
   Entscheidung.
4. **Versionsnummer** für das Release mit den Sprachen (z. B. 1.3.0)? Die
   „Was ist neu"-Texte in allen Sprachen liegen schon bereit als
   `docs/release-notes/next-<sprache>.txt` (je unter 500 Zeichen, eine Zeile
   pro Punkt). Sobald du die Nummer nennst, benenne ich sie um und hebe
   `pubspec.yaml` an.

---

## 5. Weitere Ideen, priorisiert

Sortiert nach erwartetem Effekt je Aufwand. **„braucht Daten"** heißt: erst
messen, dann entscheiden (Firebase-Ereignisse existieren, siehe
`audit/06-analytics.md`).

| # | Idee | Effekt | Aufwand | Wer | Anmerkung |
|---|---|---|---|---|---|
| A | ~~Zweite Sprachwelle: Vietnamesisch, Polnisch, Niederländisch~~ und ~~Japanisch, Koreanisch, Thai, Chinesisch, Arabisch~~ **erledigt** (App, Store-Texte, Bilder) | hoch | mittel | ich | Kyrillisch (Russisch) ebenfalls von Nunito abgedeckt — aber Play-Abrechnung und AdMob in Russland: vor einer Entscheidung belegen, nicht annehmen |
| B | ~~Gameplay-Video~~ **gerendert**: `store-assets/video/qubble-gameplay.mp4` (25 s, hochkant, mit Spiel-Sounds). **Du:** auf YouTube hochladen und im Store-Eintrag als Promo-Video verlinken; als Short/Reel/TikTok posten | mittel–hoch | — | du | Beim Rendern fiel ein HUD-Fehler auf (Punktzahl brach mit Combo-Abzeichen zeichenweise um) — behoben, `64e00ef` |
| C | **Store-Listing-Experiment: Icon** (Variante liegt in `store-assets/icon-variant/`) | mittel | klein | du | `audit/05-aso.md` §8 — Icon zuerst, weil es auf jeder Oberfläche sichtbar ist |
| D | **Titel-Test** „Qubble: Block Puzzle" gegen „… Block Puzzle Game" / „… Offline" | mittel | klein | du | Varianten in `audit/05-aso.md` §2 |
| E | Teilen-Link → Play / „App holen" im Web | mittel | klein | ich | hängt an Frage 1 |
| F | ~~**Web-Link öffnet direkt das Daily**~~ **erledigt** (siehe §2 Nr. 11) | mittel | mittel | ich | verstärkt den bestehenden Teilen-Loop |
| G | **Play Games Services** (Erfolge/Bestenliste im Play-Games-Profil) | klein–mittel | groß | beide | MASTERPLAN C.9, 👤-gebunden |
| H | Streak-Meilenstein als dritter Bewertungs-Moment (`ReviewTrigger.streakMilestone` existiert, ist aber nicht im Plan) | klein | klein | ich | erst Opt-in-Rate der Bewertungskarte ansehen — braucht Daten |

**Bewusst nicht vorgeschlagen:** Belohnung für Bewertungen oder
Einladungen (Anreize für Bewertungen sind bei Play untersagt; ein
Einladungs-System bräuchte zudem einen Server), Werbung im Web-Build,
Interstitials jeglicher Art (`CLAUDE.md`, nicht verhandelbar), bezahlte
Nutzerakquise vor messbarem LTV (MASTERPLAN Phase 5).

---

## Quellen

Primärseiten von Google/Chrome/MDN sind aus dieser Umgebung gesperrt; die
Angaben stammen aus Suchreferaten und sind so gekennzeichnet.

- [88 % of Google Play Game Downloads Come From Search and Browse](https://sensortower.com/blog/google-play-download-sources) — über `audit/01-markt.md`
- [Translation services | Google Play Console](https://play.google.com/console/about/translationservices/) — Suchreferat
- [Main store listing | Google Play Console](https://play.google.com/console/about/storelistings/) — Suchreferat
- [Metadata – Play Console Help](https://support.google.com/googleplay/android-developer/answer/9898842) — Suchreferat
- [Google Play's Metadata Policy Changes](https://www.apptweak.com/en/aso-blog/how-to-prepare-for-new-google-metadata-policy-changes) — Suchreferat
- [Native App Install Prompt | Chrome for Developers](https://developer.chrome.com/blog/app-install-banners-native) — Suchreferat
- [related_applications | MDN](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Manifest/Reference/related_applications) — Suchreferat
