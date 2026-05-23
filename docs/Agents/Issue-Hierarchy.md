# Issue Hierarchy

Work in PSModule is tracked at three levels. The level reflects **scope and aggregation**, not priority or complexity. We use **GitHub issue types** for the segmentation — not labels — so the relationships are first-class in the platform.

## The three levels

| Level                    | Issue type   | Scope                                              | Output                                                              |
| ------------------------ | ------------ | -------------------------------------------------- | ------------------------------------------------------------------- |
| **Task**                 | `Task`       | One deliverable. One small reviewable PR.          | Working software.                                                   |
| **Product Backlog Item** | `PBI`        | A body of work composed of multiple Tasks.         | Tracking, delegation, oversight, visibility into progress.          |
| **Epic**                 | `Epic`       | Strategic chunk needing multiple PBIs.             | The co-planning artifact. Where OKRs become initiatives.            |

> The name **Product Backlog Item** is chosen for its neutral vibe — it works equally well for a feature, a fix, a refactor, or an internal capability. "Feature" implies user-visible value, which isn't always the case for the middle tier.

## When to use each level

### Task

Use Task when:

- The work has one clear deliverable.
- The expected PR is small and reviewable in a single pass (rough guideline: under ~500 lines / 15 files).
- One person (or one agent) can pick it up and finish it independently.

A Task is the **default starting point**. Promote upward only when you discover the work is too big.

### Product Backlog Item

Use PBI when:

- The work has multiple distinct deliverables, each of which would be its own PR.
- The deliverables share a goal but can be sequenced or parallelized.
- You want oversight over the body of work without prescribing the order.

A PBI's children can themselves be PBIs (nested decomposition) when the inner deliverables also break into multiple chunks. Epic → PBI → PBI → Task is legitimate when the work demands it.

### Epic

Use Epic when:

- The work spans multiple PBIs.
- It maps to a strategic objective — an OKR, an initiative, an organizational goal.
- Multiple teams or contributors should co-plan around it.

> "As a business we want to deliver this. What do we collectively need to do?"

That conversation lives on an Epic.

## Nested decomposition

Nesting is fine and expected:

```text
Epic (initiative, ties to an OKR)
├── PBI (one body of work)
│   ├── Task (one PR)
│   ├── Task
│   └── PBI (further breakdown when needed)
│       ├── Task
│       └── Task
└── PBI
    └── Task
```

The rule: **one Task = one PR-sized deliverable**. Everything above is for aggregation.

## How to express the hierarchy

Use GitHub's **sub-issue relationship** between issue types. This is a first-class GitHub feature — not just text references — and the [Planner](https://github.com/PSModule/.github-private/blob/main/agents/planner.md) agent creates these relationships when decomposing.

Text-level conventions on child issues:

- `Parent: #N` at the top of Section 1 (a courtesy duplicate of the GitHub link).
- `Blocked by: #M` when sequencing matters.
- Acceptance criteria scoped to **just this child's slice**, not the parent's whole goal.

## How the sections differ by level

| Section                  | Task                          | PBI                                                                  | Epic                                                                 |
| ------------------------ | ----------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------- |
| Section 1 (Context/Req)  | The deliverable's user story  | The grouped goal's user story                                        | The strategic outcome — vision, why, the change in the world         |
| Section 2 (Decisions)    | Implementation decisions      | Decomposition rationale + interface decisions between children       | Decomposition rationale + which PBIs and why                         |
| Section 3 (Plan)         | Checkbox task list            | Linked list of child issues (Tasks and/or sub-PBIs)                  | Linked list of child PBIs                                            |

For Epics, Section 1 should explicitly contain the **Golden Circle framing**: Why, How, What. See [Principles → Golden Circle](Principles.md#start-with-why--the-golden-circle).

## Why three levels and not more

Three is enough to:

- Cover **strategic** (Epic), **tactical** (PBI), and **operational** (Task) horizons.
- Match how teams co-plan in larger frameworks (SAFe, Nexus) without inheriting their ceremony.
- Aggregate progress meaningfully — an Epic burns down as its PBIs complete; a PBI burns down as its Tasks complete.

More levels create overhead. Fewer levels lose the ability to track progress across bodies of work.

## Promotion and demotion

A Task can be **promoted** to a PBI when it turns out to be bigger than expected. The Planner does this — Section 2 records the discovery, and the inline task list becomes child issues.

A PBI can be **demoted** to a Task when decomposition reveals only one real deliverable. Close the would-be-children, fold their content into the Task's Section 3.

Promotion / demotion always leaves a comment audit trail explaining the change.
