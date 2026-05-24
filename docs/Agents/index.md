# Agents

A team mate, not a tool.

The PSModule agents are a small set of role-based collaborators that help capture, refine, plan, build, ship, and review work across the organization. They share one set of evergreen guidelines — published in [Ways of Working](../Ways-of-Working/index.md) — and operate against the same human interfaces humans already use: GitHub issues, pull requests, and READMEs.

## Why a persona, not a swarm

We treat the agentic ecosystem as **one team mate** with many abilities, rather than a swarm of disconnected bots. The single persona — informally **Cleo** — has a cohesive bank of knowledge documented here. The agents in [`PSModule/.github-private/agents/`](https://github.com/PSModule/.github-private/tree/main/agents) are the personas' abilities to act on the world, much like a person's skills.

This matters because:

- **Knowledge is shared.** A decision documented here is available to every agent that needs it.
- **Behaviour stays consistent.** The Reviewer and the Builder don't disagree on what "good" looks like — they read the same standards.
- **Human-agent cooperation is the goal.** Agents augment the team, they do not replace it.

## Shared conventions

Principles, issue format, PR format, commit conventions, review etiquette, and other shared norms live in **[Ways of Working](../Ways-of-Working/index.md)**. Both agents and humans follow those conventions.

## The lifecycle

The full workflow — phases, the loop, and how they connect — is documented in **[Ways of Working → Workflow](../Ways-of-Working/Workflow.md)**. The agents implement that workflow:

```text
   Define → Implement → Reviewer
               ↑            │
               └── (respond) ◄┘
```

| Role        | Phase                   | Purpose                                                                 |
| ----------- | ----------------------- | ----------------------------------------------------------------------- |
| Define      | Capture + Refine + Plan | Capture a desire, ground it, and produce a planned issue or sub-issues. |
| Implement   | Build + Ship + Respond  | Branch, draft PR, code, micro-commit, track progress, finalize PR.      |
| Reviewer    | Review                  | Review someone else's PR for delivery, taste, and security.             |

## What lives here

- **[Workflow](Workflow.md)** — How the roles connect, the Context Development Lifecycle, and where it meets DevOps.
- **[Git Worktrees](../Ways-of-Working/Git-Worktrees.md)** — Bare-clone + worktree layout for parallel work with agents.
- **[Standards](Standards/index.md)** — Per-language and per-platform standards referenced by the agents.

## Guiding intent

> Make it easy. Enable others to do more, faster.

Everything in this section serves that intent. If a guideline gets in the way of that, the guideline is the thing that needs to change.
