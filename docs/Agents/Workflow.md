# Workflow

How the agent roles connect across the **Context Development Lifecycle (CDLC)** and the **Software Development Lifecycle (SDLC)**, embedded in DevOps practice.

## The big picture

The CDLC and the SDLC run side by side. The CDLC keeps **context** evergreen — issues, decisions, READMEs, docs. The SDLC delivers **software** — code, tests, releases. Each iteration of one feeds the other.

```text
        ┌───────────────────────────────────────────────────────┐
        │           Context Development Lifecycle               │
        │                                                       │
        │                     Define                            │
        │          (capture → refine → plan)                    │
        │                       │                               │
        │        ┌──────────────┼──────────────┐                │
        │        ▼              ▼              ▼                │
        │   simple task    sub-issues     checklist             │
        │                                                       │
        └───────────────────────┼───────────────────────────────┘
                                │
                                ▼
        ┌───────────────────────┼───────────────────────────────┐
        │                       │                               │
        │           Software Development Lifecycle              │
        │                                                       │
        │                  Implement                            │
        │    (branch → draft PR → build → finalize)             │
        │                       │                               │
        │                       ▼                               │
        │                   Reviewer                            │
        │                       │                               │
        │              fixes needed? → Implement (respond)      │
        │                                                       │
        └───────────────────────────────────────────────────────┘
                                │
                                ▼
                          Run / operate
                       (DevOps + SRE loop)
                                │
                                ▼
                   Signals, errors, feedback
                                │
                                ▼
                          Define (again)
```

## The agents

### Define

Combines **capture**, **refine**, and **plan** into a single flow. Takes any input — a desire, a bug, a signal — and produces a planned, actionable issue.

**Output is one of:**

- A single Task with Sections 1–3 (context, decisions, checklist).
- A decomposed PBI or Epic with structured sub-issues, each scoped to one PR.

See [Issue Format](../Ways-of-Working/Issue-Format.md) and [Issue Hierarchy](../Ways-of-Working/Issue-Hierarchy.md) for the structure.

### Implement

Takes a planned issue and delivers a merge-ready pull request. Owns the full loop:

1. **Orient** — read the issue, README, contribution guide, and standards.
2. **Branch and draft PR** — create a [worktree](Git-Worktrees.md) for the issue, push early so CI attaches and progress is visible. Assign to the user. Link to the issue.
3. **Build** — micro-commits, one logical change each. Update the issue as each task completes (not in bulk).
4. **Respond** — process reviewer feedback and CI failures. One thread at a time.
5. **Finalize** — update PR title, labels, and description as a user-facing release note.

See [Git Worktrees](Git-Worktrees.md), [PR Format](../Ways-of-Working/PR-Format.md), [Commit Conventions](../Ways-of-Working/Commit-Conventions.md), and [Standards](Standards/index.md).

### Reviewer

Reviews someone else's PR. Checks delivery against the linked issue, good taste, security, and undiscussed decisions.

See [Review Etiquette](../Ways-of-Working/Review-Etiquette.md).

## Three horizons of planning

Borrowed from [Principles → Roadmapping](../Ways-of-Working/Principles.md#roadmapping). The planner doesn't only think about today.

|            | Now                  | Next          | Later          |
| ---------- | -------------------- | ------------- | -------------- |
| Conceptual | Vision delivered now | Vision next   | Vision later   |
| Logical    | Approach now         | Approach next | Approach later |
| Detailed   | Tasks in flight      | Tasks ready   | Tasks framed   |

- A Task lives in **Now / Detailed**.
- A PBI lives somewhere between **Now / Logical** and **Next / Detailed**.
- An Epic spans **Now → Next → Later** at **Conceptual / Logical** fidelity.

## Where the principles show up

| Principle                       | Most relevant agent                |
| ------------------------------- | ---------------------------------- |
| Golden Circle (Why / How / What)| Define                             |
| OKRs                            | Define (especially Epic-level)     |
| YAGNI / Lean                    | Define, Implement                  |
| Test-Driven Development         | Implement                          |
| Clean Code                      | Implement, Reviewer                |
| Evolutionary Architecture       | Define, Implement, Reviewer        |
| 4-eyes                          | Reviewer                           |
| README-Driven Context           | Implement                          |
| GTD ("write it down")           | All agents                         |
| Determinism over intelligence   | Implement                          |
| Make change easy first          | Implement                          |
| Git Worktrees (parallel work)   | Implement                          |
| Dogfooding                      | Run / operate phase                |

See [Principles](../Ways-of-Working/Principles.md) for the full set.

## Inner and outer loops

The agent workflow is itself a series of loops at different speeds.

- **Innermost** — editor + tests + Implement (build). Sub-minute.
- **Inner** — push + CI + Reviewer + Implement (respond). Minutes to hours.
- **Outer** — issue lifecycle, decomposition, Define. Days.
- **Outermost** — strategy, OKR check-ins, vision adjustments. Weeks to quarters.

Each agent operates at its own loop. Keep work close to the loop where it is cheapest to iterate.
