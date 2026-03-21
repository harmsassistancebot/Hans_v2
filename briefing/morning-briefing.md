# Morning Briefing - frubnosis

## Auftrag
Erstelle ein kompaktes, strategisch ausgerichtetes Morning Briefing auf Deutsch. Fokus auf globale Trends, Risiken und strategische Entwicklungen — kein Kleinkram der Tagespolitik.

Wichtig: **Kein Deep Reading, keine Volltext-Zusammenfassungen, kein summarize-CLI.** Arbeite primär mit Feed-Titeln, kurzen Beschreibungen/Teasern und offensichtlichen Metadaten aus RSS oder per `web_fetch` gezogenen Übersichtsseiten. Das Briefing soll **rate-limit-sparsam** sein.

## Nutzer-Profil
- **Name:** frubnosis
- **Standort:** Bochum (Rottstr. 20) / Arbeit: Essen (ista SE)
- **Interessen:** KI, Technologie, Klimawandel, Geopolitik, globale Trends
- **Ziel:** Systematisches Monitoring von finanziellen, politischen, beruflichen Risiken

## Budget-Regeln / Effizienz
- **Nur Feed-Sichtung / Übersichtsseiten**, kein Lesen kompletter Artikel
- **Maximal 1 Eintrag pro Hauptkategorie**: Tech & KI, Geopolitik & News, Wirtschaft & Märkte
- **Insgesamt maximal 3 Hauptmeldungen** aus diesen drei Kategorien zusammen
- **Apple & Fujifilm** nur aufnehmen, wenn wirklich relevante Produkt-/Release-/Gerüchte-News sichtbar sind; sonst Kategorie weglassen
- **Strategische Analyse** nur dann aufnehmen, wenn schon aus Feed-Titel/Teaser klar ein hoher Mehrwert erkennbar ist; sonst weglassen
- Bei mehreren ähnlichen Meldungen: die strategisch wichtigste wählen, nicht die lauteste
- Lieber **knapp und sauber priorisiert** als vollständig
- Auch der Ideen-Teil unten soll **kurz** bleiben: nur sichtbare, konkrete Anschlussmöglichkeiten nennen

## Wetter
Quelle: **Open-Meteo API** (kein API-Key nötig, sehr schnell)

Bochum (51.4818°N, 7.2162°E):
`web_fetch("https://api.open-meteo.com/v1/forecast?latitude=51.4818&longitude=7.2162&hourly=temperature_2m,precipitation_probability,weathercode&daily=temperature_2m_max&timezone=Europe/Berlin&forecast_days=1")`

Essen (51.4556°N, 7.0116°E):
`web_fetch("https://api.open-meteo.com/v1/forecast?latitude=51.4556&longitude=7.0116&hourly=temperature_2m,precipitation_probability&daily=temperature_2m_max&timezone=Europe/Berlin&forecast_days=1")`

Aus den stündlichen Daten extrahieren:
- **08:00 Uhr Temperatur** (Index 8 im hourly-Array)
- **Tageshöchsttemperatur** (daily.temperature_2m_max[0])
- **Niederschlagswahrscheinlichkeit:**
  - Morgens: Wert bei 08:00 (Index 8)
  - Mittags: Wert bei 12:00 (Index 12)
  - Abends: Wert bei 18:00 (Index 18)

Weathercode-Mapping (wichtigste):
0=Klar, 1-3=Leicht bewölkt/bewölkt, 45/48=Nebel, 51-67=Regen, 71-77=Schnee, 80-82=Schauer, 95=Gewitter

## Ideen vom Vortag
Zusätzlich zum Nachrichten-Teil: prüfe **alle Notes der Kategorie `ideas` vom vorangegangenen Kalendertag** im Obsidian-Vault.

Ziel:
- kurz sichtbar machen, welche frischen Ideen von gestern existieren
- pro Idee 1 knappen Vorschlag machen, **wie du konkret unterstützen kannst**

Regeln:
- nur Ideen vom **vorangegangenen Tag**, nicht ältere Backlog-Ideen
- priorisiere nach **Umsetzbarkeit**: bevorzuge Ideen, bei denen die nächsten Schritte für dich als Assistant klar, konkret und direkt durchführbar sind
- pro Idee **1 kurze Unterstützungsoption**
- keine langen Analysen, kein Ausschmücken
- wenn es keine neuen Ideen von gestern gibt: Bereich weglassen
- wenn es sehr viele Ideen gibt: auf **maximal 3** priorisierte Ideen begrenzen
- Unterstützungsangebote sollen konkret sein, z. B.:
  - Struktur skizzieren
  - Recherchefragen ableiten
  - nächsten Arbeitsschritt formulieren
  - Entwurf / Gliederung / Checkliste erstellen
  - Risiken oder offene Fragen sichtbar machen

## Quellen

### Tech & KI
- https://feeds.arstechnica.com/arstechnica/index — Ars Technica RSS
- https://thenewstack.io/feed/ — The New Stack RSS
- https://www.heise.de/rss/heise-atom.xml — Heise Newsticker

### News & Geopolitik
- https://www.tagesschau.de/xml/rss2/ — Tagesschau RSS
- https://rss.cnn.com/rss/edition.rss — CNN RSS

### Wirtschaft & ETFs
- https://www.justetf.com/de/news/ — justETF News (web_fetch)
- https://feeds.reuters.com/reuters/businessNews — Reuters Business

### Apple & Fujifilm Neuheiten
- https://www.apple.com/newsroom/rss-feed.rss — Apple Newsroom (offizielle Ankündigungen)
- https://feeds.macrumors.com/MacRumors-All — MacRumors (Gerüchte + Releases)
- https://www.fujirumors.com/feed/ — FujiRumors (Fujifilm-spezifisch, sehr aktuell)
- https://fujifilm-x.com/en-us/news/ — Fujifilm X Newsroom (web_fetch, offizielle Releases)

Nur anzeigen wenn es tatsächlich Neuigkeiten gibt (neue Produkte, Ankündigungen, relevante Gerüchte). Wenn nichts Neues: Kategorie weglassen.

### Strategische Analyse
- https://www.project-syndicate.org/rss — Project Syndicate
- https://www.carbonbrief.org/feed/ — Carbon Brief (Klima)

Nur nutzen, wenn bereits aus Titel/Teaser ersichtlich ist, dass ein klarer strategischer Mehrwert besteht. Keine Volltext-Lektüre.

## Deduplizierung (Anti-Repeat)

Vor dem Briefing: lies `workspace/briefing/seen-stories.json`.
Diese Datei enthält URLs und Titel von Stories, die in den letzten 7 Tagen bereits gemeldet wurden.

Regeln:
- **Schließe jede Story aus**, deren URL **oder** Titel (Fuzzy-Match: >70% ähnlich) bereits in `seen` vorkommt.
- Nach dem Senden: aktualisiere `seen-stories.json` — füge alle verwendeten Stories als Objekte hinzu:
  ```json
  { "date": "YYYY-MM-DD", "url": "...", "title": "..." }
  ```
- Einträge älter als **7 Tage** beim Schreiben entfernen (rolling window).
- Wenn nach Deduplizierung keine Story für eine Kategorie übrig bleibt: Kategorie weglassen oder nächstbeste nicht-gesehene Story wählen.

## Arbeitsweise für Meldungen
Für jede gewählte Meldung:
- Nutze **Headline + Quelle + Link**
- Ergänze **genau einen knappen Einordnungssatz** auf Basis von Titel/Teaser/Feed-Kontext
- **Keine erfundenen Details**, keine Volltextbehauptungen
- Wenn der Feed-Teaser zu dünn ist: lieber neutral bleiben statt spekulieren

## Ausgabe-Format (Discord-optimiert, KEIN Markdown-Table)

```
☀️ **Morning Briefing** — [DATUM], [WOCHENTAG]

🌤️ **Wetter Bochum / Essen**
• 08:00 Uhr: [Temp]°C | Höchst: [Max]°C | [Wetterlage]
• 🌧️ Niederschlag: morgens [X]% · mittags [X]% · abends [X]%

💡 **Ideen von gestern** *(nur wenn vorhanden)*
• **[Idee]**
  Ich kann dich dabei unterstützen, indem ich [konkreter nächster Schritt].
• **[Idee]**
  Ich kann dich dabei unterstützen, indem ich [konkreter nächster Schritt].

🤖 **Tech & KI**
• **[Headline]** — [Quelle] <[Artikel-URL]>
  [1 kurzer Einordnungssatz auf Basis von Feed-Titel/Teaser]

🌍 **Geopolitik & News**
• **[Headline]** — [Quelle] <[Artikel-URL]>
  [1 kurzer Einordnungssatz auf Basis von Feed-Titel/Teaser]

💹 **Wirtschaft & Märkte**
• **[Headline]** — [Quelle] <[Artikel-URL]>
  [1 kurzer Einordnungssatz auf Basis von Feed-Titel/Teaser]

📷 **Apple & Fujifilm** *(nur wenn Neuigkeiten vorhanden)*
• [Produkt/Ankündigung] — [Quelle] <[Artikel-URL]>

🔴 **Risk Radar**
• [1-3 kurze Punkte mit strategischer Einschätzung aus den ausgewählten Meldungen]

📌 **Strategischer Ausblick**
[2 kurze Sätze: Was ist gerade wirklich wichtig?]
```

## Archivierung
Nach dem Senden das Briefing als Datei speichern:
- Pfad: `workspace/briefing/YYYY/YYYY-MM-DD.md` (z.B. `workspace/briefing/2026/2026-03-06.md`)
- Inhalt: identisch mit dem gesendeten Briefing (plain text, kein Discord-Markup nötig)
- Verzeichnis ggf. anlegen falls noch nicht vorhanden

## Hinweise
- Keine Paywall-Inhalte forcieren — wenn nicht zugänglich, überspringen
- Links zu Artikeln in `<>` einwickeln (Discord embed-suppression)
- Kein "Guten Morgen, hier ist dein Briefing..." — direkt starten
- Prägnant halten, Zielgröße eher **300-450 Wörter** statt lang
- Wenn die Nachrichtenlage dünn ist, lieber kürzer sein
- **Keine Deep-Read-Calls und kein summarize-CLI verwenden**
