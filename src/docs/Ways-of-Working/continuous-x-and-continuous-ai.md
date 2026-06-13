# Continuous X Practices, Continuous AI, and the Microsoft DevOps Dojo

## 1. The "Continuous X" Practices

### Microsoft DevOps Dojo's eight pillars (White Belt)

The cleanest authoritative taxonomy. From [DevOps Dojo White Belt Foundation](https://learn.microsoft.com/en-us/training/paths/devops-dojo-white-belt-foundation/):

| # | Practice | What it covers |
|---|----------|----------------|
| 1 | Continuous Planning | Lean product, hypothesis-driven dev, backlog management, OKRs |
| 2 | Continuous Integration | Trunk-based dev, automated build & test on every commit |
| 3 | Continuous Delivery | Every commit potentially releasable; automated pipeline to prod |
| 4 | Continuous Quality | Test pyramid, shift-left testing, code review, static analysis |
| 5 | Continuous Security | Shift-left security, SAST/DAST/SCA, secrets, supply chain |
| 6 | Continuous Operations | SRE, observability, SLOs, incident response, on-call |
| 7 | Continuous Collaboration | ChatOps, docs-as-code, transparent comms, shared ownership |
| 8 | Continuous Improvement | Kaizen, retros, blameless postmortems, value-stream mapping |

### Full inventory with provenance

| Practice | Origin / canonical source |
|----------|--------------------------|
| **Continuous Integration** | Coined in Grady Booch's 1991 method; popularised by XP and [Martin Fowler's 2006 article](https://martinfowler.com/articles/continuousIntegration.html). |
| **Continuous Delivery** | Jez Humble & David Farley, [*Continuous Delivery*](https://continuousdelivery.com/), 2010. |
| **Continuous Deployment** | Every passing build deploys to prod with no human gate (vs. CD which only makes it *deployable*). |
| **Continuous Testing** | Test throughout the pipeline plus in production (synthetic, canary analysis). |
| **Continuous Verification** | Netflix's term for chaos-engineering-style continuous resilience validation. Rosenthal & Jones, [*Chaos Engineering*](https://www.oreilly.com/library/view/chaos-engineering/9781492043850/), O'Reilly. |
| **Continuous Monitoring → Continuous Observability** | Shift from dashboards of knowns to ad-hoc querying of unknowns. [Honeycomb's Observability Manifesto](https://www.honeycomb.io/blog/observability-a-manifesto). |
| **Continuous Feedback** | Right-to-left flow from prod → dev. DevOps Second Way (*Phoenix Project*). |
| **Continuous Improvement** | Toyota *kaizen*; Deming PDCA cycle. |
| **Continuous Learning** | DevOps Third Way (Kim, *Phoenix Project*). |
| **Continuous Security / DevSecOps** | OWASP; [DoD Enterprise DevSecOps Reference Design](https://dodcio.defense.gov/Portals/0/Documents/DoD%20Enterprise%20DevSecOps%20Reference%20Design%20v1.0_Public%20Release.pdf). |
| **Continuous Compliance** | Compliance-as-code: Chef InSpec, OPA, AWS Config. |
| **Continuous Configuration Automation (CCA)** | Gartner term covering Ansible/Puppet/Chef/Salt. |
| **Continuous Inspection** | SonarSource's term for always-on code-quality scanning. [docs.sonarsource.com](https://docs.sonarsource.com/). |
| **Continuous Profiling** | Always-on production profiling. Pyroscope/Grafana, Polar Signals, Google-Wide Profiling paper (2010). |
| **Continuous Documentation / docs-as-code** | Write the Docs community; treat docs like code. |
| **Continuous Experimentation** | A/B testing, hypothesis-driven dev. Kohavi et al., [*Trustworthy Online Controlled Experiments*](https://experimentguide.com/), 2020. |
| **Continuous Discovery** | Teresa Torres, [*Continuous Discovery Habits*](https://www.producttalk.org/continuous-discovery-habits/), 2021. |
| **Continuous Architecture** | Erder & Pureur, *Continuous Architecture in Practice*, 2021. |
| **Continuous Refactoring** | XP practice; Fowler's [*Refactoring*](https://martinfowler.com/books/refactoring.html). |
| **Continuous Reliability** | Vendor-popularised (Catchpoint, Gremlin); convergence of SRE + chaos + observability. |
| **Continuous Code Review** | Modern PR workflows + always-on reviewers. |
| **Continuous Training (CT)** in MLOps | Google's [MLOps Levels 1–2](https://cloud.google.com/architecture/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning) — automatic retraining on fresh data. |

---

## 2. Continuous AI

**Canonical source:** [GitHub Next — Continuous AI](https://githubnext.com/projects/continuous-ai/), published June 2025 by Eddie Aftandilian, Peli de Halleux, Russell Horton, Don Syme.

### Definition (verbatim)
> "All uses of automated AI to support software collaboration on any platform."

Positioned explicitly as the AI-era counterpart to CI/CD: *"Just as CI/CD transformed software development by automating integration and deployment, Continuous AI covers the ways in which AI can be used to automate and enhance collaboration workflows."*

GitHub explicitly does **not** claim ownership of the term — it's a label for the industry, not a product.

### Seven characteristics (GitHub Next's taxonomy)
Continuous AI tasks are: **automatable, repetitive, collaborative, integrated, auditable, event-triggered**, and have **many variants**.

### GitHub Next's example workflows
- **Continuous Documentation** — docs in sync with code automatically
- **Continuous Code Improvement** — comments, tests, small refactors
- **Continuous Triage** — label/summarise/respond to issues in natural language
- **Continuous Summarization** — rolling summaries of project activity
- **Continuous Fault Analysis** — auto-explain failed CI runs
- **Continuous Quality** — LLM-driven quality analysis
- **Continuous Team Motivation** — PRs into poetry/zines/podcasts (the social layer)
- **Continuous Accessibility** — auto-check & improve a11y

### Continuous AI vs. its cousins

| Term | What it is |
|------|-----------|
| **Continuous AI** | AI participating *in* the SDLC continuously (review, docs, triage, fault analysis). The AI is the actor. |
| **MLOps** | CI/CD/CT *for* ML models — training, evaluation, deployment, monitoring. The model is the product. |
| **LLMOps** | MLOps specialised for LLM apps: prompt versioning, evals, retrieval, guardrails, cost/latency monitoring. |
| **AIOps** | AI/ML applied to IT operations — anomaly detection, alert correlation, RCA. Gartner term, ~2017. |

### How Continuous AI augments each Continuous X practice

| Traditional practice | Continuous-AI augmentation | Example tools (2025) |
|---------------------|---------------------------|----------------------|
| Continuous Integration | AI summarises broken builds; suggests fixes | GitHub Copilot Workspace, Sweep |
| Continuous Delivery | Agents drive multi-step deploys; AI-authored release notes | GitHub Copilot agents, Devin |
| Continuous Testing | Test generation, flaky-test detection, auto-repair | Diffblue, Qodo (CodiumAI), Meta TestGen-LLM |
| Continuous Quality | LLM PR review beyond linters | CodeRabbit, Greptile, Graphite Diamond, Copilot review |
| Continuous Security | LLM-aware SAST, auto-remediation PRs | Snyk DeepCode, Semgrep Assistant, Copilot Autofix |
| Continuous Operations | "AI SRE" — autonomous triage, RCA, runbook execution | Resolve.ai, Cleric, PagerDuty AIOps, Rootly AI |
| Continuous Documentation | Docs stay in sync with code | Mintlify, GitHub Next *Continuous Documentation* |
| Continuous Code Review | Always-on AI reviewer | CodeRabbit, Greptile, Copilot review |
| Continuous Refactoring | Background agents propose refactors | Cursor background agents, Sourcegraph Cody, Grit.io |
| Continuous Triage | Issue labelling, dedup, summarisation | GitHub Models + Actions recipes, Linear AI |
| Continuous Improvement | Auto-postmortems, retro summaries | incident.io, Rootly, Jeli (Atlassian) |
| Continuous Discovery | LLM synthesis of user research | Dovetail AI, Maze AI |
| Continuous Training (MLOps) | Pre-existed; now intersects with eval-driven LLM dev | Vertex AI, Databricks, Weights & Biases |

### What structurally changes

- **Evals are the new tests.** For AI features, regression suites are eval suites — graded by LLM judges or humans. Eval drift = test failure.
- **Pipelines gain non-deterministic actors.** Every Continuous AI step needs auditability: which agent, which model version, which prompt, which tools, what did it touch.
- **Cost and runaway risk.** Traditional CI steps have bounded cost; agentic steps can recurse. Need budgets, timeouts, concurrency caps.
- **Prompt injection becomes a CI/CD threat.** Untrusted issue text, PR descriptions, error messages, third-party docs become attack surfaces when an agent reads them.
- **Governance.** Expect "AI-generated change" to need provenance equivalent to a signed commit. SOC2/ISO27001/regulators catching up.

### Tooling stack referenced by GitHub Next
- [GitHub Actions](https://github.com/features/actions)
- [GitHub Models](https://github.com/features/models)
- [GenAIScript (Microsoft)](https://microsoft.github.io/genaiscript/)
- [Datasette `llm`](https://llm.datasette.io/)
- [GitHub Agentic Workflows](https://githubnext.com/projects/agentic-workflows/) — sister project at GitHub Next
- [The Agentics](https://github.com/githubnext/agentics/) — example workflows

---

## 3. Microsoft DevOps Dojo — Status

**Status:** alive but dormant. White Belt remains a real Microsoft Learn path; higher belts are blog posts; GitHub org quiet since late 2022.

### History
Started ~2018–2019 inside Microsoft (catalysed by a 2019 conversation with German CIOs); grew into a cross-org community spanning Services, Customer Success, Digital Advisory, and product groups. Public face was largely **April Edwards** (Senior Cloud Advocate). Authoritative intro: [*Intro of DevOps Dojo*](https://devblogs.microsoft.com/devops/intro-of-devops-dojo/) on Azure DevOps Blog (July 2022).

### Belt curriculum
- **White Belt** — standardised DevOps fundamentals — *only one with a formal Microsoft Learn path*
- **Orange Belt** — scaled DevOps (enterprise/program/portfolio) — blog only
- **Green Belts** — domain lenses (e.g. UX/Accessibility) — blog only
- **Black Belt** — data-driven, intelligent DevOps for executives — never published

Four pillars: Culture & Mindset, Lean Product, Architecture, Technology.

### Where the content lives today

**Microsoft Learn — White Belt (six modules):**
- [DevOps Dojo White Belt Foundation](https://learn.microsoft.com/en-us/training/paths/devops-dojo-white-belt-foundation/)

**Azure DevOps Blog (the deeper belts):**
- [Intro of DevOps Dojo](https://devblogs.microsoft.com/devops/intro-of-devops-dojo/)
- [People & Teams (Orange)](https://devblogs.microsoft.com/devops/devops-dojo-people-teams/)
- [UX/Accessibility (Green)](https://devblogs.microsoft.com/devops/devops-dojo-ux-accessibility/)
- [Culture and Mindset](https://devblogs.microsoft.com/devops/devops-dojo-culture-and-mindset/)
- [Experiential Learning](https://devblogs.microsoft.com/devops/devops-dojo-experiential-learning/)
- [Lean Product Part 1 / Part 2](https://devblogs.microsoft.com/devops/devops-dojo-lean-product-part-1/)

**DevOps Lab video series:** [learn.microsoft.com/shows/devops-lab](https://learn.microsoft.com/en-us/shows/devops-lab/)

**GitHub:** [github.com/microsoftdevopsdojo](https://github.com/microsoftdevopsdojo) — sparse, last meaningful activity Oct 2022.

### What to use today
1. **Dojo White Belt** on Learn — for the Continuous X scaffolding
2. **[Evolve your DevOps practices](https://learn.microsoft.com/en-us/training/paths/evolve-your-devops-practices/)** — practical follow-on
3. **[ISE Engineering Fundamentals Playbook](https://microsoft.github.io/code-with-engineering-playbook/)** — Microsoft's public, actively-maintained engineering playbook. The de facto modern equivalent.
4. **[AZ-400 Enterprise DevOps](https://learn.microsoft.com/en-us/credentials/certifications/devops-engineer/)** — certification track

The ISE Playbook is the more living artifact — updated regularly, public PRs welcome, covers similar ground without the belt theatre.
