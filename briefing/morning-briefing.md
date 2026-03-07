# Morning Briefing - frubnosis

## Auftrag
Erstelle ein kompaktes, strategisch ausgerichtetes Morning Briefing auf Deutsch. Fokus auf globale Trends, Risiken und strategische Entwicklungen — kein Kleinkram der Tagespolitik.

## Nutzer-Profil
- **Name:** frubnosis
- **Standort:** Bochum (Rottstr. 20) / Arbeit: Essen (ista SE)
- **Interessen:** KI, Technologie, Klimawandel, Geopolitik, globale Trends
- **Ziel:** Systematisches Monitoring von finanziellen, politischen, beruflichen Risiken

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

## Artikel-Zusammenfassung
Für die 1-2 wichtigsten Artikel pro Kategorie: nutze das `summarize`-CLI-Tool um den Artikel tatsächlich zu lesen und zu komprimieren:
```bash
summarize "https://artikel-url.com" --length short
```
Falls summarize fehlschlägt (Paywall, Timeout): auf Headline/Teaser zurückfallen.

## Quellen (je 2-3 Top-Stories)

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

### Strategische Analyse (1-2 Highlights)
- https://www.project-syndicate.org/rss — Project Syndicate
- https://www.carbonbrief.org/feed/ — Carbon Brief (Klima)

## Ausgabe-Format (Discord-optimiert, KEIN Markdown-Table)

```
☀️ **Morning Briefing** — [DATUM], [WOCHENTAG]

🌤️ **Wetter Bochum / Essen**
• 08:00 Uhr: [Temp]°C | Höchst: [Max]°C | [Wetterlage]
• 🌧️ Niederschlag: morgens [X]% · mittags [X]% · abends [X]%

🤖 **Tech & KI**
• **[Headline]** — [Quelle] <[Artikel-URL]>
  [1-2 Sätze Zusammenfassung via summarize]
• [Headline] — [Quelle] <[Artikel-URL]>

🌍 **Geopolitik & News**
• **[Headline]** — [Quelle] <[Artikel-URL]>
  [1-2 Sätze Zusammenfassung via summarize]
• [Headline] — [Quelle] <[Artikel-URL]>

💹 **Wirtschaft & Märkte**
• **[Headline]** — [Quelle] <[Artikel-URL]>
  [1-2 Sätze Zusammenfassung via summarize]
• [Headline] — [Quelle] <[Artikel-URL]>

📷 **Apple & Fujifilm** *(nur wenn Neuigkeiten vorhanden)*
• [Produkt/Ankündigung] — [Quelle] <[Artikel-URL]>

🔴 **Risk Radar** (Klimawandel, geopolitische Eskalation, Tech-Disruption)
• [1-3 relevante Entwicklungen mit strategischer Einschätzung]

📌 **Strategischer Ausblick**
[2-3 Sätze: Was sind die wichtigsten Entwicklungen der nächsten Tage/Wochen?]
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
- Prägnant halten, max. ~400 Wörter
