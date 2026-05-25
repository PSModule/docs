# Ways of Working

Shared conventions for how work happens across the PSModule ecosystem — for humans and agents alike.

This section documents the principles, processes, and norms that every contributor follows. Whether you're opening an issue, writing a commit message, reviewing a pull request, or planning a feature — the answer is here.

## What's covered

- **[Workflow](Workflow.md)** — How work flows from idea to delivery and back again. The phases, the loop, and how they connect.
- **[Principles](Principles.md)** — Vision, mission, OKRs, product mindset, and the foundational beliefs that drive decisions.
- **[Issue Format](Issue-Format.md)** — The three-section issue structure, formatting rules, and labels.
- **[Issue Hierarchy](Issue-Hierarchy.md)** — Epic / Product Backlog Item / Task levels and GitHub issue types.
- **[PR Format](PR-Format.md)** — Pull request title, description, change types, and labels.
- **[Commit Conventions](Commit-Conventions.md)** — How we write commit messages.
- **[Review Etiquette](Review-Etiquette.md)** — Tone, scope, severity prefixes, and how to disagree well.
- **[Git Worktrees](Git-Worktrees.md)** — Bare-clone + worktree layout for parallel, conflict-free development.
- **[README-Driven Context](Readme-Driven-Context.md)** — Why the README is the front door and the source of truth.

## Who this is for

Everyone. If you contribute to a PSModule project — by code, review, issue, or discussion — these are the norms you follow. Agents follow them too; they read these pages as context before acting.

## Core principles

> Make it **easy**, to move **fast**, in a **safe** way.

If a guideline gets in the way of that, the guideline is the thing that needs to change.
See also the [main page](../index.md).

### Easy

Simplicity is a feature. Make the right thing the easy thing — for users, contributors, and agents alike.
Prefer the obvious and limited over the powerful and confusing. Automate what is mechanical so that human attention is saved for decisions that require judgment, context, and care.

The safe and smart choice should be the default choice. Design systems, tools, and workflows so that doing the right thing requires no extra effort — while allowing a deliberate override when necessary.

### Fast

Shift left, ship early, learn fast, iterate. Work flows in small increments — draft PRs, micro-commits, quick reviews.
The faster we close the loop between intention and observation, the faster we improve and evolve what we are building.

### Safe

Every decision should be reversible. Every release should be observable. Every failure should teach.
Speed requires safety — we can only iterate fast when changes are cheap to undo, easy to monitor, and failures produce learning rather than blame.
