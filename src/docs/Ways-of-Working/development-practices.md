# Development Practices

How we work on this team. Short, opinionated, and meant to be argued with — if a practice stops serving us, we change it in a retro.

---

## 1. How we think

**Deliver value, not output.** Shipping code is not the goal. Changing outcomes for customers is.

- **Customer first.** Every story answers: who is this for, and what changes for them?
- **Small batches.** Smaller changes are safer, faster to review, and faster to learn from. If a story takes more than a few days, split it.
- **Optimize the whole.** A local win that slows the next team down is a loss. Think in flow, not silos.
- **Build quality in.** We do not "add testing later" or "harden it in hardening sprint." Quality is a property of how we work, not a phase.
- **Decide reversibly.** Prefer decisions that are cheap to undo. For one-way doors, slow down and write it down.

---

## 2. How we plan

**Flow over utilization.** A busy team is not the same as a productive team.

- **One backlog, ranked.** The top is always the next most valuable thing. No parallel priority lists.
- **Thin vertical slices.** Each story delivers end-to-end value — UI through to data. No "backend-only" stories that wait weeks for a frontend.
- **Limit WIP.** Finish before you start. Work-in-progress is inventory; inventory is risk.
- **Definition of Ready / Done are contracts.** Ready = small enough, clear enough, testable. Done = merged, deployed, observable, documented.
- **Estimate to align, not to commit.** Sizing is a conversation tool. If we need a date, we forecast from throughput, not from gut feel.
- **Retro every two weeks, minimum.** One concrete change per retro, owned by a person, checked next retro.

---

## 3. How we build

**Simple, tested, readable — in that order of argument-winning power.**

- **TDD where it pays.** Red-green-refactor for logic with branching, edge cases, or money. Not dogma for trivial glue.
- **Pair or review, always.** No code reaches `main` without a second pair of eyes. Pairing counts as review.
- **Trunk-based.** Short-lived branches, merged daily. Feature flags over long-lived branches.
- **SOLID, applied with judgement.** Especially: single responsibility, and depend on abstractions at module boundaries. Don't invent interfaces you have one implementation of.
- **DRY the knowledge, not the code.** Two things that look the same but change for different reasons are not duplication. Premature deduplication is worse than repetition.
- **YAGNI.** Build for the requirement in front of you. Extensibility you don't need is complexity you pay for.
- **Clean Code basics.** Names reveal intent. Functions do one thing. Comments explain why, not what. Delete dead code.
- **Refactor continuously.** Leave the code better than you found it. Refactoring is part of the story, not a separate ticket.

---

## 4. How we ship

**You build it, you run it.** The team that writes the code owns it in production.

- **Everything in version control.** Code, infra, pipelines, dashboards, runbooks.
- **CI on every commit.** Build, lint, test, security scan. Red build blocks everyone — we fix it first.
- **CD by default.** `main` is always deployable. Deploys are boring, frequent, and automated.
- **Feature flags for risk.** Decouple deploy from release. Roll forward, not back.
- **Observability is a feature.** Logs, metrics, traces, and a dashboard ship with the service. If you can't see it, you don't own it.
- **Alert on symptoms, not causes.** Page on customer impact. Everything else is a ticket.
- **Secure by default.** Least privilege, secrets in a vault, dependencies patched, threats modelled for new surfaces.
- **Runbooks for the top 5 alerts.** Written by the team, tested in game days.

---

## 5. How we improve

**Learning is the work.** The service will outlive any single feature we build.

- **Blameless postmortems.** For every incident that hurt a customer or woke someone up. Output: actions with owners, not blame.
- **Measure what matters.** Lead time, deploy frequency, change fail rate, MTTR (the DORA four). Plus whatever customer metric this service moves.
- **Kill your darlings.** Deprecate and delete code, features, dashboards, and meetings that stopped paying rent.
- **Share the learning.** Demos, brown bags, ADRs. If only one person knows how it works, that's a bug.

---

## Principles we borrow from

- **Agile Manifesto, Scrum, Kanban, XP** — iteration, flow, TDD, pairing, collective ownership.
- **Lean Product Development** — small batches, flow, limit WIP, build quality in, defer commitment.
- **DevOps / DevOps Dojo** — you build it you run it, automation, measurement, blameless culture.
- **SOLID, DRY, YAGNI, Clean Code** — keep the inside of the code honest.
- **DORA** — measure delivery performance.

---

## How this document works

This is version 0. We review it every quarter and after any incident that exposes a gap. Propose changes in a PR; we decide in a retro.
