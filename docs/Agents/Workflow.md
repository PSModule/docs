# Workflow

How the agent roles connect across the **Context Development Lifecycle (CDLC)** and the **Software Development Lifecycle (SDLC)**, embedded in DevOps practice.

## The big picture

The CDLC and the SDLC run side by side. The CDLC keeps **context** evergreen — issues, decisions, READMEs, docs. The SDLC delivers **software** — code, tests, releases. Each iteration of one feeds the other.

```text
        ┌────────────────────────────────────────────────────────────┐
        │                 Context Development Lifecycle              │
        │                                                            │
        │   ideator  →  clarifier  →  planner                         │
        │      ▲                          │                           │
        │      │                          ▼                           │
        │   (capture)                  (decide)                       │
        │                                  │                          │
        └──────────────────────────────────┼──────────────────────────┘
                                           │
                                           ▼
        ┌──────────────────────────────────┼──────────────────────────┐
        │                                  │                          │
        │                  Software Development Lifecycle             │
        │                                                             │
        │            builder  →  shipper  →  reviewer                 │
        │                            ▲           │                    │
        │                            │           ▼                    │
        │                       (respond) ◄──  responder              │
        │                                                             │
        └─────────────────────────────────────────────────────────────┘
                                           │
                                           ▼
                                     Run / operate
                                  (DevOps + SRE loop)
                                           │
                                           ▼
                              Signals, errors, feedback
                                           │
                                           ▼
                                       ideator (again)
```

> A richer visual version of this diagram lives in Figma (linked from the homepage). Mermaid covers the structure; the Figma version covers the relationships between CDLC, SDLC, and operations.

## The roles in order

### 1. Capture — Ideator

A desire becomes a real, actionable item. Could be a feature request, a bug, an improvement, a triaged piece of external feedback, or a signal from production. Output: an issue with Section 1 only.

### 2. Refine — Clarifier

The desire is grounded. Assumptions surfaced. Acceptance criteria sharpened to be testable. Section 1 becomes unambiguous. No solutioning yet.

### 3. Plan — Planner

The work is decided and (often) decomposed.

- **Task** — one deliverable, one PR. Sections 2 and 3 populated.
- **Product Backlog Item (PBI)** — several Tasks. Section 2 documents decomposition; Section 3 lists children.
- **Epic** — several PBIs. Top-level co-planning artifact, often paired with an OKR.

Issue hierarchy is described in [Issue Hierarchy](Issue-Hierarchy.md).

### 4. Build — Builder

Code is written. The Task issue is the contract. Standards come from [Standards](Standards/index.md); linter rules in the repo win. Commits are small and descriptive.

### 5. Ship — Shipper

The branch becomes a draft PR with a release-note style description. Issue linked, labels applied, reviewers requested.

### 6. Review — Reviewer

Someone other than the author reads the PR with intent: does it deliver the issue, is the code in good taste, are the security best practices respected, are there undiscussed decisions hiding in the diff?

### 7. Respond — Responder

The author closes the loop. One thread at a time: read, evaluate, fix or defer, reply, resolve. CI failures handled similarly. Repeat until the loop converges.

After merge, the change runs in production. Signals — errors, logs, user feedback, alerts — feed back into the Ideator. The loop never really stops.

## Three horizons of planning

Borrowed from [Principles → Roadmapping](Principles.md#roadmapping). The planner doesn't only think about today.

|            | Now                  | Next          | Later        |
| ---------- | -------------------- | ------------- | ------------ |
| Conceptual | Vision delivered now | Vision next   | Vision later |
| Logical    | Approach now         | Approach next | Approach later |
| Detailed   | Tasks in flight      | Tasks ready   | Tasks framed |

- A Task lives in **Now / Detailed**.
- A PBI lives somewhere between **Now / Logical** and **Next / Detailed**.
- An Epic spans **Now → Next → Later** at **Conceptual / Logical** fidelity.

## Where the principles show up

| Principle                       | Most relevant phase                |
| ------------------------------- | ---------------------------------- |
| Golden Circle (Why / How / What)| Capture, Plan                      |
| OKRs                            | Plan (especially Epic-level)       |
| YAGNI / Lean                    | Plan, Build                        |
| Test-Driven Development         | Build                              |
| Clean Code                      | Build, Review                      |
| Evolutionary Architecture       | Plan, Build, Review                |
| 4-eyes                          | Review                             |
| README-Driven Context           | Build, Ship                        |
| GTD ("write it down")           | All phases                         |
| Determinism over intelligence   | Build                              |
| Dogfooding                      | Run / operate phase                |

See [Principles](Principles.md) for the full set.

## Inner and outer loops

The agent workflow is itself a series of loops at different speeds.

- **Innermost** — editor + tests + the Builder. Sub-minute.
- **Inner** — push + CI + Reviewer + Responder. Minutes to hours.
- **Outer** — issue lifecycle, decomposition refinement, planning review. Days.
- **Outermost** — strategy, OKR check-ins, vision adjustments. Weeks to quarters.

Each agent operates at its own loop. Keep work close to the loop where it is cheapest to iterate.
