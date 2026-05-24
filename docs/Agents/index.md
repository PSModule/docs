# Agents

A team mate, not a tool.

The PSModule agents are a small set of role-based collaborators that help capture, refine, plan, build, ship, and review work across the organization. They share one set of evergreen guidelines — published here — and operate against the same human interfaces humans already use: GitHub issues, pull requests, and READMEs.

## Why a persona, not a swarm

We treat the agentic ecosystem as **one team mate** with many abilities, rather than a swarm of disconnected bots. The single persona — informally **Cleo** — has a cohesive bank of knowledge documented here. The agents in [`PSModule/.github-private/agents/`](https://github.com/PSModule/.github-private/tree/main/agents) are the personas' abilities to act on the world, much like a person's skills.

This matters because:

- **Knowledge is shared.** A decision documented here is available to every agent that needs it.
- **Behaviour stays consistent.** The Reviewer and the Builder don't disagree on what "good" looks like — they read the same standards.
- **Human-agent cooperation is the goal.** Agents augment the team, they do not replace it.

## The lifecycle

```text
   Define → Implement → Reviewer
               ↑            │
               └── (respond) ◄┘
```

Each role is a focused agent. Standards are referenced, not embedded.

| Role        | Phase            | Purpose                                                                 |
| ----------- | ---------------- | ----------------------------------------------------------------------- |
| Define      | Capture + Refine + Plan | Capture a desire, ground it, and produce a planned issue or sub-issues. |
| Implement   | Build + Ship + Respond  | Branch, draft PR, code, micro-commit, track progress, finalize PR.      |
| Reviewer    | Review           | Review someone else's PR for delivery, taste, and security.             |

## What lives here

- **[Principles](Principles.md)** — Golden Circle, OKRs, DevOps, Lean, Clean Code, Evolutionary Architecture, and the other ideas underneath everything below.
- **[Workflow](Workflow.md)** — How the roles connect, the Context Development Lifecycle, and where it meets DevOps.
- **[Issue Format](Issue-Format.md)** — The three-section structure, formatting, labels, comments.
- **[Issue Hierarchy](Issue-Hierarchy.md)** — Epic / Product Backlog Item / Task and how to use GitHub issue types.
- **[PR Format](PR-Format.md)** — Title, description, change types, labels, release-note style.
- **[Commit Conventions](Commit-Conventions.md)** — How we write commit messages.
- **[Review Etiquette](Review-Etiquette.md)** — Tone, scope, and how to disagree well.
- **[README-Driven Context](Readme-Driven-Context.md)** — Why the README is the front door and the contract.
- **[Git Worktrees](Git-Worktrees.md)** — Bare-clone + worktree layout for parallel work with agents.
- **[Standards](Standards/index.md)** — Per-language and per-platform standards referenced by the agents.

## Guiding intent

> Make it easy. Enable others to do more, faster.

Everything in this section serves that intent. If a guideline gets in the way of that, the guideline is the thing that needs to change.
