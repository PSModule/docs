# DevOps Principles and Practices — Reference Guide

A curated synthesis of authoritative sources, frameworks, and practices.

---

## 1. Essential Reading List

### The Canon (Books)

| # | Title | Author(s) | Year | Why it matters |
| --- | ------- | ----------- | ------ | ---------------- |
| 1 | **The Phoenix Project** | Gene Kim, Kevin Behr, George Spafford | 2013 | The novel that introduced DevOps to mainstream. Source of the Three Ways. [itrevolution.com/product/the-phoenix-project](https://itrevolution.com/product/the-phoenix-project/) |
| 2 | **The Unicorn Project** | Gene Kim | 2019 | Sequel from the developer's perspective; flow state, psychological safety, Five Ideals. |
| 3 | **The DevOps Handbook** (2nd ed.) | Gene Kim, Jez Humble, Patrick Debois, John Willis | 2016/2021 | Practical companion to Phoenix Project. The reference implementation guide. |
| 4 | **Continuous Delivery** | Jez Humble, David Farley | 2010 | Foundational technical text on CI/CD and deployment pipelines. [continuousdelivery.com](https://continuousdelivery.com/) |
| 5 | **Accelerate** | Forsgren, Humble, Kim | 2018 | The science: rigorous research showing which practices actually drive performance. Origin of DORA metrics. |
| 6 | **Team Topologies** | Matthew Skelton, Manuel Pais | 2019 | The four team types and cognitive load as a design constraint. [teamtopologies.com](https://teamtopologies.com/) |
| 7 | **Lean Software Development** | Mary & Tom Poppendieck | 2003 | Lean manufacturing principles applied to software. |
| 8 | **Out of the Crisis** | W. Edwards Deming | 1982 | Foundational systems thinking; 14 Points. The intellectual root of DevOps. |
| 9 | **The Goal** | Eliyahu Goldratt | 1984 | Theory of Constraints. The novel format Kim borrowed for Phoenix Project. |

### Google SRE Books — All Free Online

All available at **[sre.google/books](https://sre.google/books/)**

- **Site Reliability Engineering** (2016) — How Google runs production. SLOs, error budgets, toil, on-call, postmortems. [sre.google/sre-book/table-of-contents](https://sre.google/sre-book/table-of-contents/)
- **The Site Reliability Workbook** (2018) — Practical implementation. [sre.google/workbook/table-of-contents](https://sre.google/workbook/table-of-contents/)
- **Building Secure & Reliable Systems** (2020) — DevSecOps and resilient design. [google.github.io/building-secure-and-reliable-systems](https://google.github.io/building-secure-and-reliable-systems/raw/toc.html)

---

## 2. Core Principles

### The Three Ways (from *The Phoenix Project*)

1. **Flow** — Optimize the whole system, not silos. Reduce batch sizes, never pass defects downstream, build quality in early. → CI/CD, trunk-based dev, feature flags, WIP limits.
2. **Feedback** — Amplify feedback loops right-to-left (ops → dev). → Observability, monitoring, SLOs, postmortems.
3. **Continual Learning** — Culture of experimentation, blameless failure, deliberate practice. → Postmortems, chaos engineering, innovation time, game days.

### Other Foundational Principles

- **"You build it, you run it"** (Werner Vogels, Amazon) — Devs own their services in production. Shared on-call.
- **Automation everywhere** — CI/CD, IaC, automated testing, security, compliance. Eliminate toil.
- **Small batch sizes & trunk-based development** — Short-lived branches (<1 day), feature flags decouple deploy from release. [trunkbaseddevelopment.com](https://trunkbaseddevelopment.com/)
- **Observability over monitoring** — Three pillars: logs, metrics, traces. Designed-in, not bolted on. [Honeycomb's Observability Manifesto](https://www.honeycomb.io/blog/observability-a-manifesto)
- **Error budgets & SLOs** — Reliability is a feature with a cost. Aligns dev velocity and ops stability.
- **Blameless postmortems** — Learning > blame. Focus on systems, not people.
- **Shift-left security (DevSecOps)** — SAST, dependency scanning, secret scanning, IaC scanning in CI.
- **Infrastructure as Code** — Version-controlled, peer-reviewed infra. Terraform, Pulumi, Kubernetes manifests + GitOps.

---

## 3. Frameworks Worth Knowing

### DORA — Four Key Metrics
The evidence-based standard for DevOps performance. Source: Forsgren/Humble/Kim research, now part of Google Cloud.

| Metric | What it measures | Elite performance |
| -------- | ------------------ | ------------------- |
| **Deployment Frequency** | How often you deploy to prod | Multiple per day / on-demand |
| **Lead Time for Changes** | Commit → production | < 1 hour |
| **Change Failure Rate** | % of deploys causing problems | 0–15% |
| **Mean Time to Restore** | Recovery from prod incidents | < 1 hour |

A fifth metric — **Reliability** — was added in recent reports.

- Latest research: [dora.dev/research](https://dora.dev/research/)
- Annual State of DevOps Report: [cloud.google.com/devops/state-of-devops](https://cloud.google.com/devops/state-of-devops)

### SPACE — Developer Productivity (Forsgren et al., 2021)
DORA measures *delivery*; SPACE measures *productivity* holistically. Five dimensions: **S**atisfaction, **P**erformance, **A**ctivity, **C**ommunication, **E**fficiency. No single metric works — need balance. [space-framework.com](https://space-framework.com/)

### CALMS — DevOps Self-Assessment (Jez Humble)
**C**ulture, **A**utomation, **L**ean, **M**easurement, **S**haring. Atlassian writeup: [atlassian.com/devops/frameworks/calms-framework](https://www.atlassian.com/devops/frameworks/calms-framework)

### Team Topologies — The Four Team Types
1. **Stream-aligned** — Owns a value stream end-to-end. The default team.
2. **Platform** — Builds the IDP that stream-aligned teams consume.
3. **Enabling** — Temporary coaches helping stream-aligned teams adopt new capabilities.
4. **Complicated-subsystem** — Deep specialists (rarely needed).

Plus three interaction modes: collaboration, X-as-a-service, facilitating. **Cognitive load** is the explicit design constraint.

---

## 4. How Good Teams Operate

### Service Ownership
One team owns a service from concept to retirement: code, deploys, on-call, SLOs, runbooks, DR, deprecation.

### On-Call Health Markers
- < 2 pages/week per engineer
- MTTR < 30 min for typical incidents
- Alerts are actionable (business-level, not "CPU > 80%")
- Runbook for every alert
- Clear escalation policy + secondary on-call
- Time off after major incidents

### Incident Response
- Incident commander coordinates; scribe documents
- Real-time war room (Slack channel + bridge)
- Status updates every 15–30 min
- Postmortem within 3–5 days, blameless, public, with tracked action items
- Reference: [SRE Book — Postmortem Culture](https://sre.google/sre-book/postmortem-culture/)

### Release Engineering
- **Canary** — 5% → 25% → 100%, with auto-rollback on metric breach
- **Blue/green** — Atomic cutover with instant rollback
- **Feature flags** — Decouple deploy from release; LaunchDarkly, Unleash, Split
- **Progressive delivery** — Combine canary + flags + experimentation

### Observability Stack (one common shape)
- Logs: ELK, Loki, Datadog, Honeycomb
- Metrics: Prometheus + Grafana, Datadog, New Relic
- Traces: Jaeger, Tempo, Honeycomb, Datadog APM
- All correlated via trace ID propagated through services

### Toil Reduction (SRE 50% rule)
SREs spend ≤ 50% on toil; the rest on engineering away the toil. [SRE Book — Eliminating Toil](https://sre.google/sre-book/eliminating-toil/)

### Platform Engineering (the modern evolution)
Internal Developer Platforms (IDPs) are how mature orgs reduce cognitive load on stream-aligned teams. Self-service deploys, golden paths, paved roads. Communities:
- [platformengineering.org](https://platformengineering.org/)
- [humanitec.com](https://humanitec.com/) — research and benchmarks
- CNCF TAG App Delivery — [github.com/cncf/tag-app-delivery](https://github.com/cncf/tag-app-delivery)

---

## 5. Where to Go Deeper

### Authoritative organizations
- **IT Revolution Press** — Gene Kim's publisher; DevOps Enterprise Summit talks (free): [itrevolution.com](https://itrevolution.com/)
- **Google SRE** — [sre.google](https://sre.google/)
- **DORA / Google Cloud** — [dora.dev](https://dora.dev/)
- **CNCF** — Cloud-native landscape and definitions: [cncf.io](https://www.cncf.io/), [landscape.cncf.io](https://landscape.cncf.io/)
- **ThoughtWorks Technology Radar** — Quarterly opinionated assessment: [thoughtworks.com/radar](https://www.thoughtworks.com/radar)

### Vendor guides (well-written even if biased)
- Atlassian DevOps Guide: [atlassian.com/devops](https://www.atlassian.com/devops)
- GitLab — *The Remote DevOps Lifecycle*: [about.gitlab.com/topics/devops](https://about.gitlab.com/topics/devops/)
- GitHub — *Well-Architected* and DevOps guides: [resources.github.com/devops](https://resources.github.com/devops/)
- AWS DevOps: [aws.amazon.com/devops](https://aws.amazon.com/devops/)
- Microsoft DevOps Resource Center: [learn.microsoft.com/en-us/devops](https://learn.microsoft.com/en-us/devops/)

### Voices to follow
- **Charity Majors** (Honeycomb) — Observability. Blog: [charity.wtf](https://charity.wtf/)
- **Liz Fong-Jones** — SRE/observability practitioner
- **Gene Kim** — DevOps movement, IT Revolution
- **Jez Humble** — CD, Accelerate co-author
- **Nicole Forsgren** — DORA/SPACE research lead
- **Kelsey Hightower** — Cloud-native pragmatism
- **Matthew Skelton & Manuel Pais** — Team Topologies
- **John Willis** — Deming, DevOps history

### Conferences worth watching (talks free on YouTube)
- DevOps Enterprise Summit (DOES)
- SREcon (USENIX)
- KubeCon + CloudNativeCon
- QCon
