# Workflow

How the agent roles map to the [Ways of Working workflow](../Ways-of-Working/Workflow.md). Each phase is owned by a specific agent.

## The lifecycle

```text
   Define → Implement → Reviewer
               ↑            │
               └── (respond) ◄┘
```

Each role is a focused agent. The shared workflow and conventions are documented in [Ways of Working](../Ways-of-Working/index.md) — agents read those pages as context before acting.

## The agents

### Define

Covers the **Capture**, **Refine**, and **Plan** phases. Takes any input — a desire, a bug, a signal — and produces a planned, actionable issue.

**Output is one of:**

- A single Task with Sections 1–3 (context, decisions, checklist).
- A decomposed PBI or Epic with structured sub-issues, each scoped to one PR.

See [Issue Format](../Ways-of-Working/Issue-Format.md) and [Issue Hierarchy](../Ways-of-Working/Issue-Hierarchy.md) for the structure.

### Implement

Covers the **Build** and **Ship** phases. Takes a planned issue and delivers a merge-ready pull request. Owns the full loop:

1. **Orient** — read the issue, README, contribution guide, and standards.
2. **Branch and draft PR** — create a [worktree](../Ways-of-Working/Git-Worktrees.md) for the issue, push early so CI attaches and progress is visible. Assign to the user. Link to the issue.
3. **Build** — micro-commits, one logical change each. Update the issue as each task completes (not in bulk).
4. **Respond** — process reviewer feedback and CI failures. One thread at a time.
5. **Finalize** — update PR title, labels, and description as a user-facing release note.

See [Git Worktrees](../Ways-of-Working/Git-Worktrees.md), [PR Format](../Ways-of-Working/PR-Format.md), [Commit Conventions](../Ways-of-Working/Commit-Conventions.md), and [Standards](Standards/index.md).

### Reviewer

Covers the **Review** phase. Reviews someone else's PR. Checks delivery against the linked issue, good taste, security, and undiscussed decisions.

See [Review Etiquette](../Ways-of-Working/Review-Etiquette.md).

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
