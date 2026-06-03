# Goal-Setting Framework

PSModule uses a lightweight OKR-based framework to connect strategic direction to day-to-day work. The hierarchy runs from the organisation's reason to exist down to individual deliverables tracked in GitHub issues.

## Layers

| Layer           | Lives in                                                                | Purpose                                                         |
| --------------- | ----------------------------------------------------------------------- | --------------------------------------------------------------- |
| **Mission**     | [`PSModule/.github` #68](https://github.com/PSModule/.github/issues/68) | The org's reason to exist — *infuse GitHub with PowerShell*     |
| **OKR**         | Sub-issues of the Mission                                               | Qualitative objectives + measurable key results                 |
| **Initiative**  | Sub-issues of an OKR                                                    | A concrete bet to move a Key Result — becomes an Epic in a repo |

## Why OKRs and not KPIs

- **Objectives** are qualitative, aspirational, and outside-in. They describe a state of the world we want to see.
- **Key Results** are measurements that confirm the Objective is being met. They drive incentive in the right direction without prescribing the path.

A good OKR is one that anyone — contributor, user, or agent — can read and immediately have ideas about how to contribute. See [Principles](Principles.md) for the full rationale.

## Current OKRs

Tracked as sub-issues of the [Mission issue](https://github.com/PSModule/.github/issues/68):

- [Every module author ships with confidence](https://github.com/PSModule/.github/issues/69)
- [The framework handles complexity so authors don't have to](https://github.com/PSModule/.github/issues/70)
- [PSModule modules are the best-maintained on the Gallery](https://github.com/PSModule/.github/issues/71)

## From strategy to delivery

Initiatives are the bridge between strategy and execution. An Initiative is a sub-issue of an OKR and maps directly to an **Epic** in the relevant repository. From there it decomposes into PBIs and Tasks through the [Issue Hierarchy](Issue-Hierarchy.md).

```text
Mission (org-level, evergreen)
└── OKR (qualitative objective + key results)
    └── Initiative (concrete bet to move a KR)
        └── Epic (in a repository) → PBIs → Tasks
```
