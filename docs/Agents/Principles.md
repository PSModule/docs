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

## Dogfooding

Be the first customer of every service we build. But avoid full self-dependency on a service before it is proven — explore and use it in non-critical contexts first, then promote it as confidence grows.

## Agentic development

### Persona, not swarm

Treat the agent ecosystem as one team mate. Many specialized roles, one cohesive bank of knowledge, one consistent voice. See [the Agents index](index.md#why-a-persona-not-a-swarm).

### Augmentation, not replacement

Agents amplify the team. They make us faster, more consistent, and free us from work that is mechanical. **Human in the loop** remains the default for decisions that matter.

### Self-improving agents

Agents need feedback and a way to process it. Every agent definition should evolve as we learn. Capture lessons in the agent definitions and in this docs section — don't let them live only in someone's head.

### Determinism is cheaper than intelligence

LLM tokens are not the right tool for work that has a deterministic answer. Use agents to **build** the deterministic tool — a script, a library, a converter — and then run the tool. Don't burn tokens on work a function call can do.

### Integration and sensoring

- **Integration** — the agent's ability to act on a platform as if it were human. GitHub, the editor, the terminal.
- **Sensoring** — the agent's ability to notice that it is needed. Webhooks, scheduled checks, signals from the platform.

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

## Roadmapping

We plan in a 3×3 matrix:

|              | Now           | Next         | Later        |
| ------------ | ------------- | ------------ | ------------ |
| Conceptual   | Vision today  | Vision next  | Vision later |
| Logical      | Approach now  | Approach next| Approach later |
| Detailed     | Tasks now     | Tasks next   | Tasks later  |

- **Now / Next / Later** are time horizons without firm dates.
- **Conceptual / Logical / Detailed** are levels of fidelity.

The detail increases as work moves from Later toward Now.

## Test-Driven Development

Define the tests when you define the behavior. Update them when behavior changes. Tests are the executable specification.

## DevOps and SRE

> You build it, you run it.

Everything is continuous — development, integration, delivery, operation. The same team owns the system across the loop. Build the systems, the practices, and the teams that internalize this.

## Context Development Lifecycle

The work of keeping context **right, evergreen, and declarative**. The CDLC sits beside the SDLC:

- **SDLC** delivers software using source code management, CI/CD, and DevOps practices.
- **CDLC** delivers context — issues, decisions, READMEs, agent definitions, this docs site — and treats them as products that must be kept current.

Both lifecycles run continuously. Each iteration of the SDLC produces context that needs CDLC maintenance; each iteration of the CDLC unblocks SDLC work.

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

## Ways of working

One size does not fit all. The way we work follows the principles above, including the principle of evolving how we work.

- **Start lean** with processes and ceremonies. Get to know each other and the work first.
- **Scrum + Kanban hybrid** — dynamic cycles, no firm sprint end dates. A cycle is over when an Epic is delivered. Estimation is approximate; Epics themselves are kept lean.
- **Limit Work in Progress.** Roughly three concurrent items per person is the typical ceiling for sustained focus.
- **Extreme Programming** — pair programming (human + human, or human + agent) as a vehicle for learning, decision-making, review, and validation.

## Why these principles matter

These are the assumptions every agent decision rests on. When an agent's behaviour is unclear or contested, the answer comes from here. When something here turns out to be wrong, update this page — not just one agent.
