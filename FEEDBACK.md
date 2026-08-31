# Feedback

Gesammeltes Nutzer-Feedback aus der App (Einstellungen → „Feedback geben").

Jeder Eintrag entsteht aus einem GitHub-Issue mit dem Label `feedback`: die
App öffnet ein vorausgefülltes Issue, die Action `.github/workflows/feedback.yaml`
hängt es hier automatisch an. Diese Datei dient als Ideen-/Aufgabensammlung —
sinnvolle Punkte werden später in konkrete Änderungen übernommen.

<!-- Neue Einträge werden unten von der Action angehängt. -->

---

## Geschlossener Play-Test — Testbericht (August 2026)

Quelle: schriftlicher Bericht des bezahlten Testdienstes nach 14 Tagen
geschlossenem Test. Er kam nicht über die Feedback-Action herein, deshalb hier
von Hand ergänzt — über das In-App-Formular ist im geschlossenen Test kein
einziger Eintrag eingegangen.

**Ergebnis:** Keine Abstürze, keine Fehler, alle Funktionen wie erwartet auf
allen getesteten Geräten und SDK-Levels.

**Verbesserungsvorschläge und Status:**

| # | Punkt | Status |
|---|---|---|
| 1 | Store-Beschreibung zu kurz, Keywords fehlen | ✅ neu geschrieben, `docs/STORE-LISTING.md` |
| 2 | Screenshots zeigen keine Features (keine Bildunterschriften) | ✅ 6 Motive je Sprache mit Text, `store-assets/` |
| 3 | Keine „App bewerten"-Möglichkeit | ✅ Einstellungen + Play In-App-Review |
| 4 | Tutorial für neue Spieler | ✅ war schon da (Coach-Hints + „So spielst du Qubble") |
| 5 | Feedback-Möglichkeit in der App | ✅ war schon da (Einstellungen → Feedback geben) |
| 6 | Regelmäßige Updates / neuer Content | ✅ ohne Update: Daily Challenge + erzeugte Rätsel |
| 7 | Community-Anbindung (Highscores teilen) | ⏳ Bestenliste vorhanden; Teilen-Button offen (Phase 7, Block 3) |

**Zusätzlich im Zuge des Feedbacks:**

- Layout-Fehler auf schmalen Displays behoben (Wochenend-Banner lief über).
- App auf **Englisch als Quellsprache** umgestellt, Deutsch als Übersetzung —
  der Hinweis zur Auffindbarkeit führte zu der Frage, wer die App überhaupt
  lesen kann.
- Hartkodierter Preis „1,99 €" im Starter-Angebot entfernt; es zeigt jetzt den
  echten Store-Preis in der Währung des Spielers.
