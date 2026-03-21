---
title: Server Tags
tags:
  - governance-engineering
  - azure
  - cmdb
  - leanix
categories:
  - concepts
status:
domain: work
---

See also: [[LeanIX Landing Zone Model and Azure Subscription Tags]]

# Context

Ista operates servers in two environments:
- **Azure** — organized in landing zones, each with an operationally responsible team ("owner")
- **On-premises** — hosted at OEDIV and 3S

**Two types of Operating Models:**

| Type | Description | Managed by | Scope |
|---|---|---|---|
| Self-managed | Operated DevOps-style by the owning squad | The squad itself | Only Azure "self-managed" partition |
| Centrally-managed | Operated by a central admin team | LOT Server Infrastructure (SI), Network Infrastructure (NI), or Database Infrastructure (DI) | On-premises + Azure "centrally-managed" partition |

Most centrally managed landing zones belong to country operations; some are application-specific. Country landing zones often host multiple applications.

**LeanIX** is used as the Enterprise Architecture Repository. It tracks business applications and IT components — but not servers.

---

# Problem

Multiple teams need to know, for each server:
- Which team is operationally responsible for it? (e.g. for immediate security fixes) 
- Which team is accountable for the servers regarding compliance and costs? 
- Which application is running on it?
- Is it a production server?

---

# What does "responsibility" for a server mean?

Servers can be associated to two different teams with different responsibilities:
- **Operationally responsible**: team responsible for the day-to-day operations, including security incident response and technical maintenance.
- **Accountable**: team accountable for the application or service, including costs and compliance.

## Case 1: Cloud servers in "Self-Managed" landing zones

- For servers in the "Self-Managed" operating model, the operationally responsible team and the accountable team must be the same. 
- It can be determined via the landing zone's team relations in LeanIX.

> Alternatively, the team could be determined via the owning team of the application(s) hosted in the landing zone. This is not recommended, because there are corner cases where the landing zone has either no applications or multiple applications with different owning teams.

**Diagram - Teams for servers in self-managed landing zones:**

![diagram](/Users/hans/.openclaw/workspace/tmp/servertag/diagram_0.png)

## Case 2: Cloud servers in the "Centrally-Managed" landing zones

- For servers in the "Centrally-Managed" operating model, the operationally responsible team is typically a central IT team (usually "Server Infrastructure LOT"), while the accountable team is a local IT team or business unit.
- Both teams can be determined via the landing zone's team relations in LeanIX.

**Diagram - Teams for servers in centrally managed landing zones:**
![diagram](/Users/hans/.openclaw/workspace/tmp/servertag/diagram_1.png)
> Alternatively, the team could be determined via the owning team of the application(s) hosted in the landing zone. This is not recommended, because there are corner cases where the landing zone has either no applications or multiple applications with different owning teams.

## Case 3: On-premises servers

- The operationally responsible team is either Server Infrastructure, Network Infrastructure, or Database Infrastructure.
- The accountable team is the local IT team or business unit owning the application hosted on the server. 

> TODO what if multiple applications with different owning teams are hosted on the same server? 

**Diagram - Teams for on-premises servers:**
![diagram](/Users/hans/.openclaw/workspace/tmp/servertag/diagram_2.png)


---


# Required Server Tags

## Systems requiring server tags

- **EDR** - SoC needs to react on security event. Needs metadata for assessing situation and contacting stakeholders.
- **Tenable** - Basis for 10GR reporting of vulnerabilities. Application owners need to see their affected servers.
- **Grafana** - TODO explain use case
- **PowerBI FinOps report** - Needs to know who leads the team accountable for a server to inform them about cloud costs.
- **10GR report** - PowerBI report for all 10 golden rules KPIs.

## Required tags specification

Server tags are going to be maintained and/or consolidated in the CMDB (IFS Assyst). From there this information can be synced to other tools which need server tags.

| CMDB Server Tag Attributes         | Allowed Values                | Used by                 | Mandatory? |
| ---------------------------------- | ----------------------------- | ----------------------- | ---------- |
| **Server/Asset name**              | Hostname                      | EDR, Tenable, Grafana   | Yes        |
| **Server Serial Number**           | Serial number                 | EDR, Tenable, Grafana   | Yes        |
| **Application**                    | LeanIX applications           | EDR, Tenable, Grafana   | No (cloud), Yes (on-prem)      |
| **IT Component**                   | LeanIX IT components          | EDR, Tenable, Grafana   | No         |
| **Operationally Responsible Team** | LeanIX team                   | EDR                     | Yes        |
| **Accountable Team**               | LeanIX team                   | Tenable                 | Yes        |
| **Server Type**                    | "prod", "nonprod"             | EDR, Tenable            | Yes        |
| **10GR group**                     | LeanIX Tribe or local IT Team | 10GR report, Tenable    | Yes        |

> Data quality improvement planned for IT components data for 2027

> Names in LeanIX can change. It is important that the CMDB updates the LeanIX data regularly or use canonical identifiers (e.g. LeanIX IDs) internally.

## Source of truth

Server tags can be either manually maintained in the CMDB or automatically filled based on data from LeanIX and Azure:

| CMDB Server Tag Attributes         | Cloud-server Source           | On-prem-server Source           | 
| ---------------------------------- | ----------------------------- | ----------------------- | 
| **Server/Asset name**              | Azure direct import           | ???   | 
| **Server Serial Number**           | Azure direct import           | ???   | 
| **Application**                    | Initially: server -> Azure subscription -> LeanIX landing zone -> LeanIX application. Manual override possible in CMDB  | Manually maintained in CMDB   |
| **IT Component**                   | Initially: server -> Azure subscription -> LeanIX landing zone -> LeanIX IT component. Manual override possible in CMDB | Manually maintained in CMDB   | 
| **Operationally Responsible Team** | server -> Azure subscription -> LeanIX landing zone -> LeanIX operationally responsible team | Manually maintained in CMDB (default = "Server Infrastructure LOT") | 
| **Accountable Team**               | server -> Azure subscription -> LeanIX landing zone -> LeanIX accountable team | application -> LeanIX owning team |
| **Server Type**                    | server -> Azure subscription -> Subscription name suffix | Manually maintained in CMDB | 
| **10GR group**                     | accountable team (-> LeanIX Tribe) | accountable team (-> LeanIX Tribe)  | 

---


# Azure Server Tag Maintenance

The process for the initial filling and the continuous update for Azure servers is the same. LeanIX data should just be imported / refreshed in regular intervals.

**Application Tag**
For each server: 
- Look up the landing zone factsheet in LeanIX with the Azure subscription ID associated to the server
- Read the relation "Hosted Applications" in LeanIX
    - If only one application: use application name
    - If multiple applications or empty: ==leave empty==

> **Open question**: Using the team name for landing zones with multiple applications is a workaround. If we can reliably fill the 10GR group tag, could just leave the application empty?

**Operationally Responsible Team Tag**
- Look up the landing zone and take the team from the relation "operationally responsible Org Structure"

**Accountable Team Tag**
- Look up the landing zone and take the team from the relation "accountable Org Structure"

**Server Type Tag (prod / nonprod)**
- Check the LeanIX factsheet if the subscription id is in the "PROD subscription ID" field or on the "NONPROD subscription ID" field and set accordingly.

**10GR group**
- Lookup the landing zone and take the "accountable Org Structure": If it's a "local IT" team, use the name. If it's another team, navigate to the parent tribe and take the tribe name.


# On-premises Servers Tag Maintenance (OEDIV, 3S)

## Initial Data Fill

**Application Tag**

- Tunde's (IT Security) existing on-prem tag evaluation is used as the starting point.
- LOT SI, DI, and NI verify correctness and plausibility.

**Operationally Responsible Team Tag**
- Value is either SI, NI, or DI. LOTs align on responsibilities between themselves.

**Accountable Team Tag**
- LOT SI pre-fills based on best knowledge; LOT SI, NI, and DI align on responsibilities between themselves.

**Server Type Tag (prod / nonprod)**
- All on-premises servers default to **nonprod**. 
- Application owners are asked to update the classification for production environments.
- Nonprod classification allows SoC to act quickly (e.g. shutdown) if needed.
- Application owners have an incentive to update the classification, because nonprod servers can be shutdown at any time. 

**10GR group**
- Accountable Tribe or Country filled by LOTs based on best knowledge.

> Note! This is a new tag! The definition has impact on the current work for the initial data fill. 

## Keeping Tag Data Up-to-Date

| Trigger | Process |
|---|---|
| New server or configuration change | LOT SI (or NI/DI) updates server tag information directly in IFS assyst |

# Ongoing Quality Monitoring

- The PowerBI report will be extended to show missing tags.
- ITAM Squad reviews tag consistency at least monthly and triggers corrective actions (approaching LOTs or App Owners as needed).

# API and Data Delivery

IFSassyst will expose the server tags defined above via API and/or file export to EDR and Tenable:

**Security concern:** A compromise of IFSassyst could lead to mass tag changes, which would cause incorrect permissions in EDR and other tools.

Proposed mitigations:
- IFS assyst is monitored by SIEM with a focus on detecting mass changes
- Data exchange via regular export/import (with a partial human review step) rather than direct live API
- IFS assyst frontend changes require ITAM Squad approval to limit human error

**Example Data Flow for 10 golden rules "Vulnerabilities" report:**
![diagram](/Users/hans/.openclaw/workspace/tmp/servertag/diagram_3.png)

---

# Access Control (RBAC)

Viewing server and tag data for all servers is restricted to:
- IT Security and SoC
- IT Infrastructure LOTs
- We enable IT Asset Management (Patrick)
- We drive Public Cloud Adoption (Janusz)
- We enable Public Cloud Solutions (Jan)

All other teams and application owners have limited, scoped access only (where technically possible).

# Next Steps

## Initial Data Fill 

| Step | Owner | Status |
|---|---|---|
| Prepare IFSassyst technically for new tags, automations, and PowerBI | ITAM Squad | in progress |
| Prepare Excel template for cloud infrastructure and share with Jan | ITAM Squad | done |
| Fill template: LeanIX Tag, Operational Responsibility, Country Tag, Server Type | Jan Harms | done |
| Review Tunde's IT Security tag evaluation, pre-fill Operational Responsibility, share with LOT SI | ITAM Squad | ? |
| Quality check data, align LOT SI/NI/DI on responsibilities and IT Component tags | LOT SI | ? |
| Upload data to IFSassyst, share PowerBI quality report, close gaps with LOTs/App Owners | ITAM Squad | ? |

## API Go-Live *(target: end of March)*

| Step | Owner |
|---|---|
| Extend API with required data fields | ITAM Squad |
| Configure Tenable API integration | Arpita + Tunde |
| Test and configure EDR API integration | Konrad + Adam |
| Cross-check tag data against existing tags in Tenable and EDR before go-live | IT Security + ITAM |

## Other

- ITAM Squad provides PowerBI report access to all involved teams once completed
- IT Security implements SIEM integration for IFSassyst
- ITAM Squad defines quality reporting and regular update process → present to group in March
