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
| 1 | **App in 36 neuen Sprachen**: Spanisch, Portugiesisch (BR), Französisch, Italienisch, Türkisch, Indonesisch, dann Vietnamesisch, Polnisch, Niederländisch, Ukrainisch, Malaiisch, Rumänisch, Tschechisch, Ungarisch, Schwedisch, Slowakisch, Dänisch, Norwegisch, Finnisch, Bulgarisch, Kroatisch, Filipino, Katalanisch, Swahili, Usbekisch, Aserbaidschanisch, Litauisch, Estnisch, Lettisch, Slowenisch, Serbisch, Kasachisch, Albanisch, Mazedonisch, Bosnisch, Afrikaans — 347 Texte je Sprache, ICU-Plurale (Polnisch/Tschechisch/Slowakisch mit one/few/many), Sprachwahl in den Einstellungen | Entsperrt die Store-Einträge in diesen Sprachen (siehe 2) — vorher hätte ein spanischer Eintrag eine englische App versprochen | `3b87a6f` |
| 2 | **Store-Texte** (Titel, Kurz-, Vollbeschreibung) für es-419/es-ES, pt-BR, fr-FR, it-IT, tr-TR, id, nl-NL, pl-PL, vi | Qubble taucht in Suchen in diesen Sprachen auf; Aussage für Aussage wie der englische Text | `2c12aca` |
| 3 | **Screenshots + Feature-Grafik** in allen 9 Sprachen, aus der App in der Sprache gerendert | Die Bilder tragen den Großteil der Installationsentscheidung — jetzt mit Text, den der Spieler lesen kann | `ba17f0d` |
| 4 | **Bewertungskarte nach neuem Bestwert** — war geplant (MASTERPLAN 7b) und Google so mitgeteilt (`docs/archiv/PRODUCTION-ACCESS.md`), aber nie angeschlossen; die Karte kam nur nach 3-Sterne-Rätseln | Mehr Bewertungen → bessere Umwandlung und Ranking. Und die Aussage an Google stimmt jetzt | `e7f3fd7` |
| 5 | **Link-Vorschau** für den geteilten Daily-Link (Open Graph + 1200×630-Bild) | Ein geteiltes Ergebnis kam als nackte URL an; jetzt mit Bild und Text in WhatsApp & Co. | `3fa8606` |
| 6 | **Deutsche Skin-Namen in der englischen App** behoben („Verlauf", „Kristall", „Level 4: Verlauf-Skin") | Sichtbarer Übersetzungsfehler → Bewertungen | `635744f` |
| 7 | **5 Screens liefen auf 360-px-Handys über** (Game-Over, Skins, Daily, Rätsel-Level, Feedback) — teils schon auf Englisch | Kaputt wirkende Screens → Bewertungen | `9ede775` |
| 8 | **Gameplay-Video** aus der echten App (echte Drag-Gesten, echte Sounds), sprachneutral | Promo-Video im Store und Clips für Shorts/TikTok (MASTERPLAN Phase 5) | siehe Git-Log |
| 9 | **Punktzahl brach im Spiel um**, sobald das Combo-Abzeichen erschien („4,1/74", „SCOR/E") — auf 360-dp-Handys, auch auf Englisch | Sichtbarer Darstellungsfehler mitten im Spiel | `64e00ef` |
| 10 | **Japanisch, Koreanisch, Thai, Chinesisch, Arabisch, Hebräisch, Urdu, Hindi, Marathi, Nepali, Bengalisch, Gujarati, Kannada, Malayalam, Punjabi, Tamil, Telugu und Griechisch** (dritte Welle; Chinesisch vereinfacht und traditionell, Arabisch von rechts nach links mit grammatisch korrekten Zahlformen): App, Store-Texte `ja-JP`/`ko-KR`/`th`/`zh-CN`/`zh-TW`/`zh-HK`/`ar`/`ur`/`hi-IN`/`ta-IN`/`te-IN`/`gu`/`kn-IN`/`ml-IN`/`pa`/`bn-BD`/`mr-IN`/`ne-NP`, Screenshots und Feature-Grafik. Nur Android/iOS — Nunito hat keine CJK-/Thai-Zeichen, der Web-Build lässt sie weg statt Schriften von Google nachzuladen. Taiwan/Hongkong-Handys bekommen automatisch die traditionelle Schrift | Zwei große Play-Märkte, in denen ein englischer Eintrag kaum gefunden wird; die Bilder zeigen die App so, wie das Handy sie zeichnet (Noto Sans CJK) | siehe Git-Log |
| 11 | **Geteilter Daily-Link öffnet direkt das Daily** (`…/Qubble/?daily`): wer ein geteiltes Ergebnis anklickt, landet auf demselben Brett statt auf der Startseite. Schon gespielt → Startseite mit Countdown; ein laufendes Daily wird beim Neuladen fortgesetzt | Ein Klick weniger zwischen Neugier und erstem Zug — genau an der Stelle, an der der Teilen-Loop neue Spieler bringt. Im Web-Build in Chromium geprüft | siehe Git-Log |
| 12 | **Web-Build fragte nach Erinnerungen, die nie kommen**: beim 2. Besuch „Erinnerungen?" — ein „Ja" bewirkte nichts; der Schalter in den Einstellungen riet zu „Systemeinstellungen" | Ein leeres Versprechen an genau die Spieler, die zurückkommen | siehe Git-Log |
| 13 | **Daily-Karte schnitt ihren Status ab** — mit laufender Serie auf 360-dp-Handys schon auf Englisch („6-day streak · Open t…"); der Countdown aus MASTERPLAN D.3.3 verlor seine Uhrzeit. Auch Store-Screenshot 6 zeigte das. Jetzt rutscht der Status in eine eigene Zeile | Die Startseite ist das Erste, was ein neuer Spieler sieht — und Screenshot 6 das Letzte, was er vor der Installation sieht | `9f2d6c6` |
| 14 | **Titel-Prüfung auf verbotene Wörter griff nicht** bei Wörtern, die mit einem Sonderzeichen beginnen oder enden („ücretsiz", „miễn phí", „nejlepší") — `\b` kennt nur ASCII. Jetzt Unicode-fest, mit eigenem Test | Ein „kostenlos" im Titel verstößt gegen die Metadaten-Richtlinie; die Prüfung soll das in jeder Sprache finden | siehe Git-Log |
| 15 | **Abgeschnittene Texte bei größerer Systemschrift** (ab 1,3×, mit echter Nunito gemessen): Statistik-Beschriftungen, XP und nächste Belohnung auf der Startseite, Wochenend-Hinweis, zwei Titel („Comment jouer à Q…"); im Daily schnitt das Spiel „TÄGLICHE CHALLENGE" schon bei normaler Schrift in acht Sprachen ab. Dazu zwei echte Layout-Fehler bei 2×: Sprach- und Vibrationsmenü ließen ihrem Titel keine Breite (ListTile wirft), „Gold eintauschen" lief 36 px über. Die Menüs zeichneten zudem in der Systemschrift statt Nunito. Neuer Test prüft jeden Menü-Bildschirm, das Spiel und Game-Over in allen Web-Sprachen bei 1×/1,3×/2× mit echter Schrift; der alte Überlauf-Test verschluckte alle Fehler außer „overflowed" | Wer die Systemschrift größer stellt, sah Texte mit „…" und in den Einstellungen kaputtes Layout — ein Grund für schlechte Bewertungen | siehe Git-Log |

**Absicherung, damit das so bleibt:** Jede Sprache läuft durch alle
Layout-Tests (jeder Screen, Game-Over, HUD, mehrere Schriftgrößen); ein neuer
Test liest die Zeichentabelle der Schrift Nunito und schlägt fehl, sobald ein
Text ein Zeichen enthält, das der Web-Build von Google nachladen müsste; die
Store-Texte werden auf Feldlängen, verbotene Titelwörter und gleiche
Theme-Namen wie in der App geprüft. Der Web-Build wurde in headless Chromium
auf Spanisch, Türkisch und Französisch gestartet: richtige Sprache, **null**
externe Anfragen.

Tests: 828 → **6552**, `flutter analyze` ohne Befund.

---

## 3. Was du tun musst, damit es wirkt

Steht seit 28.09. in **`ANLEITUNG.md`** (Release 1.3.0, Store-Eintrag in den
neuen Sprachen, Video). Hier stand vorher eine eigene Liste; zwei
Anleitungen nebeneinander waren eine zu viel.

## 4. Offene Fragen an dich

Die noch offenen stehen in **`ANLEITUNG.md`** unter „Entscheidungen". Beantwortet (28.09.):

- **Ist der Play-Eintrag öffentlich?** Ja: 1.2.0 ist in der Produktion, alle
  Länder, 100 %. Damit sind „Teilen-Link auf Play" und „App holen" im Web
  entscheidbar (dort unter „Entscheidungen").
- **Konkurrenz-Absatz** (29.09.): aus EN/DE gestrichen; ein Test hält
  fremde Spieltitel aus allen Store-Texten heraus.
- **Web-Version** (29.09.): keine Priorität — kein „App holen“-Hinweis.
- **Versionsnummer:** `1.3.0+10` (Code 9 ist durch 1.2.0 verbraucht). Die
  „Was ist neu"-Texte heißen jetzt `docs/release-notes/1.3.0-<sprache>.txt`.

---

## 5. Weitere Ideen, priorisiert

Sortiert nach erwartetem Effekt je Aufwand. **„braucht Daten"** heißt: erst
messen, dann entscheiden (Firebase-Ereignisse existieren, siehe
`audit/06-analytics.md`).

| # | Idee | Effekt | Aufwand | Wer | Anmerkung |
|---|---|---|---|---|---|
| A | ~~Zweite Sprachwelle: Vietnamesisch, Polnisch, Niederländisch~~ und ~~Japanisch, Koreanisch, Thai, Chinesisch, Arabisch, Hindi, Ukrainisch~~ **erledigt** (App, Store-Texte, Bilder) | hoch | mittel | ich | Kyrillisch (Russisch) ebenfalls von Nunito abgedeckt — aber Play-Abrechnung und AdMob in Russland: vor einer Entscheidung belegen, nicht annehmen |
| B | ~~Gameplay-Video~~ **gerendert**: `store-assets/video/qubble-gameplay.mp4` (25 s, hochkant, mit Spiel-Sounds), dazu drei weitere Clips (`qubble-neon/-ocean/-sunset.mp4`, je eine andere Partie) für regelmäßige Posts. **Du:** das erste auf YouTube hochladen und im Store-Eintrag als Promo-Video verlinken; alle als Short/Reel/TikTok posten, z. B. einen pro Woche | mittel–hoch | — | du | Beim Rendern fiel ein HUD-Fehler auf (Punktzahl brach mit Combo-Abzeichen zeichenweise um) — behoben, `64e00ef` |
| C | **Store-Listing-Experiment: Icon** (Variante liegt in `store-assets/icon-variant/`) | mittel | klein | du | `audit/05-aso.md` §8 — Icon zuerst, weil es auf jeder Oberfläche sichtbar ist |
| D | **Titel-Test** „Qubble: Block Puzzle" gegen „… Block Puzzle Game" / „… Offline" | mittel | klein | du | Varianten in `audit/05-aso.md` §2 |
| E | Teilen-Link → Play / ~~„App holen" im Web~~ | mittel | klein | ich | „App holen“ im Web: **nein** — die Web-Version hat keine Priorität (Entscheidung Nutzer 29.09.) |
| F | ~~**Web-Link öffnet direkt das Daily**~~ **erledigt** (siehe §2 Nr. 11) | mittel | mittel | ich | verstärkt den bestehenden Teilen-Loop |
| G | **Play Games Services** (Erfolge/Bestenliste im Play-Games-Profil) | klein–mittel | groß | beide | MASTERPLAN C.9, 👤-gebunden |
| H | Streak-Meilenstein als dritter Bewertungs-Moment (`ReviewTrigger.streakMilestone` existiert, ist aber nicht im Plan) | klein | klein | ich | erst Opt-in-Rate der Bewertungskarte ansehen — braucht Daten |
| I | **Tablet-Screenshots** (7" und 10") — Qubble läuft auf Tablets (`test/widget/large_screen_test.dart`), der Eintrag hat aber nur Telefonbilder. fastlane kennt die Ordner `sevenInchScreenshots/` und `tenInchScreenshots/` (aus dem supply-Quelltext). **Offen:** Googles Anforderungen (Maße, Mindestanzahl) — die Hilfeseite ist von hier gesperrt, Sekundärquellen widersprechen sich (10": 1600×2560 oder 1800×2560). **Du:** die Vorgaben aus der Console nennen, dann rendere ich EN/DE (für alle Sprachen wären es geschätzt ~290 MB im Repo) | unklar | mittel | beide | Nicht auf Verdacht gebaut |

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
