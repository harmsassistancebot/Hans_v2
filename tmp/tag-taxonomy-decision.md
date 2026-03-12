**Tag Taxonomy**

Tags encode dimensions orthogonal to the folder structure. The folder structure handles work/private separation; tags must not duplicate this.

Three tag dimensions are used:

**Dimension 1 — Article Type** (what kind of article is it?)
- `#type/profile` — person, company, or organization
- `#type/strategy` — investment, career, or product strategy
- `#type/analysis` — political, technological, or market analysis
- `#type/plan` — OKRs, development plans, roadmaps
- `#type/review` — book, film, product, or experience review
- `#type/reference` — how-to, glossary, reference material
- `#type/concept` — idea, design document, specification

**Dimension 2 — Topic** (what domain does it cover?)
Topics are kept at "bookshelf level" — broad enough that new tags are rarely needed, specific enough to filter meaningfully. Filtering power comes from combining type + topic, not from fine-grained topics alone. The initial set is:
- `#topic/technology`
- `#topic/finance`
- `#topic/career`
- `#topic/geopolitics`
- `#topic/people`
- `#topic/health`
- `#topic/home`
- `#topic/photography`

Topics can be split when a single tag accumulates more than ~30 articles. New topics are not created preemptively.

**Dimension 3 — Status** (how mature is the article?)
- `#status/draft` — work in progress
- `#status/stable` — complete and reliable
- `#status/archived` — outdated, no longer actively maintained

The extractor uses tag combinations to filter relevant articles per task, e.g. `#type/plan` + `#topic/career` for OKR drafting. This makes extraction independent of the folder structure.
