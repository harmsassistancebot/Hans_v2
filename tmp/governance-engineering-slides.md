---
marp: true
theme: default
paginate: true
size: 16:9
style: |
  section {
    font-family: Arial, "Arial Black", sans-serif;
    font-size: 28px;
    background: #ffffff;
    color: #0A2864;
    padding: 50px 60px;
  }
  h1 {
    color: #0A2864;
    font-size: 2em;
    border-bottom: 3px solid #0055B4;
    padding-bottom: 12px;
  }
  h2 {
    color: #0055B4;
    font-size: 1.4em;
  }
  section.title {
    display: flex;
    flex-direction: column;
    justify-content: center;
    background: #0A2864;
    color: #ffffff;
  }
  section.title h1 {
    color: #ffffff;
    border-bottom: 3px solid #0055B4;
    font-size: 2.2em;
  }
  section.title p {
    color: #80B8F8;
    font-size: 0.9em;
  }
  section.problem {
    background: #f0f4ff;
  }
  section.callout {
    background: #e8f0fc;
    border-left: 6px solid #0055B4;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.85em;
  }
  th {
    background: #0055B4;
    color: white;
    padding: 8px 12px;
    text-align: left;
  }
  td {
    padding: 7px 12px;
    border-bottom: 1px solid #dde;
  }
  tr:nth-child(even) td { background: #f0f4fb; }
  blockquote {
    border-left: 4px solid #0055B4;
    background: #e8f0fc;
    padding: 12px 20px;
    margin: 16px 0;
    font-style: italic;
    color: #333;
  }
  ul { line-height: 1.8; }
  li { margin-bottom: 4px; }
  .muted { color: #666; font-size: 0.85em; }
---

<!-- _class: title -->

# Governance Engineering

### A Vision for Automatic IT Governance

Jan Harms · ista SE · 2026

---

# Agenda

1. **Why governance fails** — the four root causes
2. **The vision** — automatic governance
3. **Four building blocks** — how to get there
4. **Today vs. tomorrow** — the path from here
5. **Open questions**

---

<!-- _class: callout -->

# The Core Idea

> **The goal of governance is not to slow things down.**
> **It is to make the right thing the easy thing.**

Organizations make thousands of technology decisions every day.

Without structure, systems **drift** — and drift creates risk, cost, and misalignment between IT and business intent.

---

# Why Traditional Governance Fails

Four predictable failure modes — always the same root causes:

1. **Siloed policies** — every discipline publishes its own rules
2. **Stale, invisible policies** — documents have no incentive to stay current
3. **Disconnected data** — the same concept lives under different names in every system
4. **Manual gatekeepers** — approval committees become bottlenecks teams route around

---

<!-- _class: problem -->

## Failure 1: Siloed Policies

Architecture · Security · Platform · Data · Finance each define rules **independently**.

- Different formats
- Different audiences
- No cross-domain ownership

**Consequence:** Overlapping, contradictory, or simply unknown rules.
Teams learn to ignore governance entirely.

---

<!-- _class: problem -->

## Failure 2: Stale & Invisible Policies

Policies that live in documents have no structural incentive to stay current.

- No versioning, no changelogs, no notifications
- Teams operate on outdated rules without knowing it

**Consequence:** Compliance measured against the wrong baseline is meaningless.

---

<!-- _class: problem -->

## Failure 3: Disconnected Data

Governance decisions rely on data from many systems:

| System | Data |
|---|---|
| CMDB | Asset inventory, ownership |
| LeanIX | Applications, architecture |
| Azure | Infrastructure metadata |
| Tenable | Security posture |
| Intune | Device compliance |

In practice: maintained manually, inconsistently, in isolation.

---

<!-- _class: problem -->

## Failure 3: A Concrete Example at ista

> KPI dashboards for the **10 golden rules of IT security** are generated from LeanIX.

**If data is stale or wrong:**
- Teams waste effort investigating non-issues
- Real issues go undetected because the data says everything is fine

The system reports compliance with a **snapshot of reality that no longer exists**.

---

<!-- _class: problem -->

## Failure 4: Manual Gatekeepers

Change advisory boards and review committees:

1. **Become bottlenecks** — overloaded, decisions delayed, teams route around
2. **Approvals expire silently** — a compliant config at approval time drifts out of compliance with no follow-up

**Consequence:** Governance is applied inconsistently.
Non-compliant configurations persist indefinitely.

---

# The Vision: Automatic Governance

Replace manual gates with **continuously evaluated, data-driven controls**:

```
📋 Policy Registry     →     🗄️ Governance Repository     →     📊 KPI Reports
(canonical, versioned)       (unified data model)              (10GR · FinOps · Risk)
        ↑                              ↓
📡 Data Sources           ⚙️ Platforms & Pipelines
LeanIX · Azure · CMDB        Azure · Kubernetes · CI/CD
Tenable · Intune · ...           (report + enforce)
```

---

# Building Block 1: Policy Registry

A **single authoritative source** for all policies across domains.

- Policies defined **as code**, versioned in a repository
- Changes surfaced to affected teams via **diffs + automated notifications**
- One team owns the canonical policy model; other disciplines contribute via process

**Result:** No more conflicting signals. Everyone operates on the same current baseline.

---

# Building Block 2: Governance Repository

A **unified data model** that resolves identities across systems.

- Canonical identifiers enforced at ingestion
  - e.g. deployment rejected if `application` tag ≠ valid LeanIX ID
- API-driven — no manual CSV exports
- One owning system per entity type:
  - Applications → LeanIX
  - Servers → Azure / CMDB
  - Teams → org structure

---

# Building Block 2: Unified Data Model

How governance data objects connect across systems:

```
Server ──── "lives in" ──────► Landing Zone
  │                                  │
  │ "has vulnerability"          "accountable"
  ▼                                  ▼
Vulnerability              Accountable Team
  │
  └─── "hosts app with endpoint" ──► Public Endpoint
```

---

# Building Block 3: Automated Controls

Two modes — **prevent** and **detect**:

| Mode | Mechanism | Example |
|---|---|---|
| **Prevent** | Platform rejects non-compliant action | Deployment blocked if application tag invalid |
| **Detect & alert** | State reported; violation flagged | Vulnerable server exposed → immediate alert |

**Additional enforcement without querying the repo:**
- Azure Policies, Kyverno for Kubernetes
- Compliant-by-design platforms (encrypted DBs, LZ ownership)
- Golden Paths — make the right thing the easiest thing

---

# Building Block 4: KPI Reporting

**Example: 10GR Vulnerabilities — today vs. with Governance Repo**

**Today (manual flow):**
```
Azure → CMDB → Tenable → 10GR Report
         ↑
    LeanIX (subscription → 10GR group)
```

**With Governance Repo (unified):**
```
Azure + LeanIX + CMDB + Tenable
         ↓
  Governance Repository
         ↓
      10GR Report  ·  FinOps  ·  Risk Dashboard
```

---

# Today vs. Tomorrow

| Today (CMDB-centric) | Vision (Governance Repository) |
|---|---|
| Tags manually maintained in IFS Assyst | Tags derived automatically from canonical sources |
| CMDB exports to Tenable and EDR | All systems pull from unified governance data |
| KPI reports via manual CSV flow | Real-time queries against live governance model |
| Human approval gates | Automated enforcement + exception handling |

The current **server tagging initiative** is a pragmatic first step.
The **Governance Repository** is the destination.

---

# Open Questions

- 🔐 **Exemptions** — who can approve, for how long, with what audit trail?
- 🏗️ **How to build** — custom platform, data mesh, or AI-assisted aggregation?
- 🔑 **Which canonical identifiers** to standardize first? (Application, LZ, Team)
- 🔄 **Dynamic org structure** — how to handle squad reshuffling / tribe changes?

---

<!-- _class: title -->

# Thank You

**Governance Engineering** — making the right thing the easy thing.

*Questions?*

---

<!-- _class: callout -->

# Appendix: Key Data Sources to Integrate

| Source | Data |
|---|---|
| **LeanIX** | Applications, Landing Zones, team accountability |
| **Azure Resource Manager** | Infrastructure, subscriptions, resource metadata |
| **CMDB (IFS Assyst)** | Asset inventory, server ownership (transitional) |
| **Tenable** | Vulnerability posture per asset |
| **Intune / Jamf** | Device compliance, installed software |
| **SAP / Workday** | Cost centers, team allocations |
| **Confluence** | Team topology, responsibilities |
