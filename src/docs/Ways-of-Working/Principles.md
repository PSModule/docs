# Principles

The ideas underneath how we work — with each other and with our agents. These are evergreen. The agent definitions and the rest of the Agents docs reference them.

## Start with Why — the Golden Circle

From Simon Sinek's [Start With Why](https://simonsinek.com/books/start-with-why/). Every piece of work — at every level — should be groundable in three concentric questions:

- **Why** — what change in the world are we trying to make? Vision.
- **How** — what approach do we take to make that change happen? Mission.
- **What** — what concrete thing are we delivering right now? OKRs → initiatives → tasks.

When an issue is being written, the **Why** belongs in the Context part of Section 1. The **How** belongs in Section 2 (Technical Decisions). The **What** belongs in Section 3 (Implementation Plan).

## Vision, mission, OKRs

### Vision

> Make it easy. Enable others to do more, faster.

### Mission

PSModule's mission is to **infuse GitHub with PowerShell**, and to **bring more to the PowerShell ecosystem** by using the GitHub platform to its fullest extent.

### OKRs

We aim for OKRs — not KPIs. From [Measure What Matters](https://www.whatmatters.com/) by John Doerr. The difference matters:

- **Objectives** are qualitative, aspirational, and from outside in. They describe a state of the world we want to see.
- **Key Results** are measurements that tell us the Objective is being met. They drive incentive in the right direction without prescribing the path.

A good OKR is one that anyone — contributor, user, or agent — can read and immediately have ideas about how to contribute.

## Product / service mindset

We are building something for people who should **want** to use it. Without users, we are nothing. Every decision is filtered through: does this make the product more wanted, or less?

## Build for all developers

We target all platforms and all shells. Our code, scripts, workflows, and documentation must work regardless of whether the developer is on Windows, macOS, or Linux. Line endings, path separators, shell assumptions — none of these should silently break someone's experience. Repository configuration (`.gitattributes`, CI matrices, test environments) must reflect this.

## Build for the modern engineer

We build for engineers using the latest tools and platforms. We do not support deprecated or end-of-life software. Concretely: we target **PowerShell** (cross-platform, actively developed) — not Windows PowerShell (legacy, frozen at 5.1). The same applies across the stack: latest stable releases, current LTS versions, modern APIs. If a tool has a successor, use the successor.

## Dogfooding

Be the first customer of every service we build. But avoid full self-dependency on a service before it is proven — explore and use it in non-critical contexts first, then promote it as confidence grows.

## Agentic development

### Human–agent coexistence

The workflow is designed for humans and agents working side by side. Agents join a good human way of working — they do not replace it or require a parallel system. The operating model is **human-first, agent-augmented**.

Agents are trained to read documentation. That is their natural skill. By keeping standards, conventions, and principles in documentation format we serve both audiences with a single artifact — no separate "agent manual" required.

Agent context is delivered through three layers, in priority order:

1. **Documentation** — the primary source. Published docs at <https://psmodule.io/docs/>, READMEs, and issue bodies are written for humans and naturally consumable by agents.
2. **Central agent configuration** — organization-wide agent files in `.github-private`. Thin orchestrators built mostly from references to the docs. They define roles, boundaries, and procedural steps — not standards or conventions.
3. **Local repository files** — `.github/` instruction files and repo-level overrides for what is unique to a single repository.

### Persona, not swarm

Treat the agent ecosystem as one team mate. Many specialized roles, one cohesive bank of knowledge, one consistent voice. See [the Agents index](../Agents/index.md#why-a-persona-not-a-swarm).

### Augmentation, not replacement

Agents amplify the team. They make us faster, more consistent, and free us from work that is mechanical. **Human in the loop** remains the default for decisions that matter.

### Self-improving agents

Agents need feedback and a way to process it. Every agent definition should evolve as we learn. Capture lessons in the agent definitions and in this docs section — don't let them live only in someone's head.

### Determinism is cheaper than intelligence

LLM tokens are not the right tool for work that has a deterministic answer. Use agents to **build** the deterministic tool — a script, a library, a converter — and then run the tool. Don't burn tokens on work a function call can do.

### Integration and sensoring

- **Integration** — the agent's ability to act on a platform as if it were human. GitHub, the editor, the terminal.
- **Sensoring** — the agent's ability to notice that it is needed. Webhooks, scheduled checks, signals from the platform.

### Context-first development

An echo of platform engineering's "a product starts with a README." Every change flows through context before it touches code:

```text
Intention of change → Update documentation → Update README → Update tests → Update code
```

Code echoes the docs, not the other way around. The README and the docs are the **specification**. Tests validate the interface we want to see. If a change isn't reflected in context first, the code has no contract to implement against — and agents have nothing to read.

This means:

- A new feature starts as a documented intent (issue, README update, or docs change) before any code is written.
- Tests are written or updated to assert the interface the documentation describes — before the implementation exists.
- A refactor updates the relevant documentation **first**, then the tests, then the code follows to match.
- If the docs and the code disagree, the docs are wrong — fix the docs, fix the tests, then fix the code to match.

This is what makes agentic development work at scale. Agents read context. If the context is stale or missing, the agent builds the wrong thing. Keeping context ahead of code is how we stay in control.

See [README-Driven Context](Readme-Driven-Context.md).

## Getting Things Done

From David Allen's [GTD](https://gettingthingsdone.com/). If something is only in your head:

- Nobody else can work with you on it.
- You cannot reflect on it.
- It can escape you and be lost.

**Write it down.** Issues, decisions, plans, READMEs. Writing is how knowledge becomes shared and how agents can help.

## Everything as Code

Everything — workflows, configuration, infrastructure, processes, agent definitions, even the docs you are reading — lives in source control. This is the bedrock of human-agent interaction. An agent can read code, change code, propose code. It cannot read what's only in someone's memory.

## Documentation lives close to the thing it documents

- Comment-based help lives next to the function.
- README lives at the root of the repo.
- Workflow guidance lives in the org-level docs (this site).
- Decisions live in the issue that produced them.

Distance between a thing and its documentation is the rate at which they drift apart.

## SOLID — in plain language

- **Single Responsibility.** One thing does one thing.
- **Open / Closed.** Extend by adding, not by modifying what already works.
- **Liskov Substitution.** If something derives from a base, it should be safely usable wherever the base is expected.
- **Interface Segregation.** Don't make consumers depend on things they don't use.
- **Dependency Inversion.** Depend on abstractions, not concretions.

## Coupling and cohesion

**Coupling** — two elements are coupled *with respect to a particular change* if changing one implies changing the other. Not merely "A calls B", but "changing A forces a change to B". Coupling is always relative to a specific kind of change, and it can be invisible until a change reveals it.

The cost of software is roughly the cost of change. Changes follow a power-law distribution: most are cheap; a few cascade into very expensive ones. Coupling is what conducts that cascade — change A, must change B, must change C. Reducing coupling flattens the tail of expensive changes and extends how long a codebase can keep absorbing new requirements.

**Cohesion** — an element is cohesive to the degree that all its sub-elements are coupled to each other: change one, change all. Grouping things that must change together into their own element reduces the scope of coupling you have to reason about. You can always find opportunities to improve cohesion locally, even when global decoupling feels intractable.

## DRY — with judgment

Don't Repeat Yourself, but **don't extract too early**. Wait until the same non-trivial logic appears in three or more places, or until the duplication is clearly load-bearing. Premature abstraction is more expensive than duplication.

## 1-2-Automate

If you've done a thing twice, the third time it should be automated. Sometimes you already know — go straight to automation. Extreme automation is often the right starting point.

## 4-eyes (or N-eyes) principle

Every change benefits from a second perspective. With AI in the loop, that can be:

- A human reviewing your work.
- You bouncing ideas off an agent.
- Multiple agents reviewing each other's output against the same standards.

The goal is the same: catch what one perspective misses.

## Local testing for quick iterations

Make it easy to build, test, and run locally. The inner loop is where most engineering time is spent — every second saved there compounds.

Inner / outer loops to be aware of:

- **Innermost** — write code, save, see result. Sub-second.
- **Inner** — run tests, see result. Seconds to a minute.
- **Outer** — push, CI, review, merge. Minutes to hours.
- **Outermost** — release, deploy, user feedback. Days to weeks.

Push work as far inward as it can go.

## Shift Left

Move quality gates as early as possible in the development cycle. The later a problem is caught, the more expensive it is to fix — a failing test in the editor is free; a bug in production is not. Design solutions so that validation happens at the earliest possible moment, not as an afterthought.

### Testable locally

A developer (or agent) must be able to run the full test suite locally, without requiring cloud resources, special access, or environment secrets that can't be mocked. If you can't test it on your machine, you can't reason about it in your editor.

This is a design constraint, not an optional addition. A solution that is untestable locally has a hidden cost that compounds with every change. When building new workflows, modules, or automation, ask early: *can someone run this locally?*

### Pre-commit hooks

Validation that runs automatically on `git commit` — before the change enters history and before a PR is opened. Pre-commit hooks close the gap between "I can test it locally if I choose to" and "it is always checked before it leaves my machine."

Typical gates: linting, formatting, static analysis, secret scanning, and fast unit tests. Keep them fast enough to not interrupt flow — if a hook takes more than a few seconds, it will be bypassed.

### Validatable in PRs

Every pull request must trigger automated checks that verify correctness before a human review begins. Tests, linting, module analysis, or any other relevant gate must run in CI on each PR.

A solution without PR validation shifts the cost of catching regressions onto reviewers — and reviewers miss things. Automation catches what humans don't, consistently and at no extra cost per PR.

## Roadmapping

We plan in a 3×3 matrix:

|              | Now          | Next           | Later          |
| ------------ | ------------ | -------------- | -------------- |
| Conceptual   | Vision today | Vision next    | Vision later   |
| Logical      | Approach now | Approach next  | Approach later |
| Detailed     | Tasks now    | Tasks next     | Tasks later    |

- **Now / Next / Later** are time horizons without firm dates.
- **Conceptual / Logical / Detailed** are levels of fidelity.

The detail increases as work moves from Later toward Now.

## Test-Driven Development

Define the tests when you define the behavior. Update them when behavior changes. Tests are the executable specification.

## DevOps and SRE

> You build it, you run it.

Everything is continuous — development, integration, delivery, operation. The same team owns the system across the loop. Build the systems, the practices, and the teams that internalize this.

## Context as a product

The work of keeping context **right, evergreen, and declarative** runs alongside software delivery:

- **Software delivery** produces code, tests, and releases using source control, CI/CD, and DevOps practices.
- **Context maintenance** produces issues, decisions, READMEs, agent definitions, and documentation — and treats them as products that must be kept current.

Both run continuously. Each iteration of software delivery produces context that needs maintenance; each iteration of context maintenance unblocks the next round of software work.

See [Workflow](Workflow.md) for how these connect in practice.

## Lean Software Development

Start very thin. Get the team's ideas flowing. Enable more people to contribute. Don't build for tomorrow's requirements (**YAGNI**).

The iteration phases — and we move through them quickly, sometimes in parallel:

1. **Spike / Experiment** — can this thing even be built?
2. **Proof of Concept** — does the experiment survive contact with reality?
3. **MVP** — first version we can run in production. Start collecting real feedback.
4. **Improvements** — stabilize, add functionality, harden.

The best feedback is the feedback from people who have seen the thing.

## Clean Code

Write code that is understandable. Code is read more often than it is written. Names, structure, and intent come before cleverness.

## Evolutionary design / architecture

Don't decide what you don't yet know. Experiment, iterate, treat design as a product — not a fixed contract. Architecture earns its right to be permanent by surviving change.

## Make change easy, then make the easy change

When a change is hard, resist the temptation to force it. First, restructure the system so the change becomes easy — as a separate, focused step. Then make the change itself. This separates two concerns:

- **Prepare** — refactor, rename, extract, reorganise. No behaviour change.
- **Change** — add, remove, or alter behaviour. No structural churn.

Applied recursively: if the preparation step is also hard, first make that easy. Work like a zipper — each structural step unlocks the next, until the actual behaviour change is trivial.

Keeping the two steps separate also lets you apply different levels of rigour. Structural changes are reversible — an extracted helper can be inlined again, a rename can be undone. Behaviour changes are often not — output sent, a form filed, a side effect triggered cannot be recalled. Irreversible decisions deserve more care. Separating the two gives you room to apply that care where it actually matters.

## Ways of working

One size does not fit all. The way we work follows the principles above, including the principle of evolving how we work.

- **Start lean** with processes and ceremonies. Get to know each other and the work first.
- **Scrum + Kanban hybrid** — dynamic cycles, no firm sprint end dates. A cycle is over when an Epic is delivered. Estimation is approximate; Epics themselves are kept lean.
- **Limit Work in Progress.** Roughly three concurrent items per person is the typical ceiling for sustained focus.
- **Extreme Programming** — pair programming (human + human, or human + agent) as a vehicle for learning, decision-making, review, and validation.

## Why these principles matter

These are the assumptions every agent decision rests on. When an agent's behaviour is unclear or contested, the answer comes from here. When something here turns out to be wrong, update this page — not just one agent.
