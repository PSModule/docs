# Issue Format

Every issue in the PSModule organization follows the same structure. The format makes issues:

- **Readable** by anyone — human or agent — without prior context.
- **Actionable** by an implementer without back-and-forth.
- **Traceable** because decisions and changes are recorded.

## Properties of every issue

- **Every change has an issue.** Features, fixes, refactors, documentation, maintenance — all tracked as issues before work begins.
- **The description is the single source of truth.** It reflects the current state of the work at all times. Decisions, scope changes, and approach changes are written directly into the description.
- **Comments record change history only.** Each description update is accompanied by a comment summarizing what changed and why.
- **Tone is impersonal.** No first-person ("I", "my") or second-person ("you", "your") language. Neutral references like "the user", "the developer", or passive constructions.
- **External references are hyperlinks.** Every mention of an API, RFC, library, doc, or tool is a clickable `[text](url)` link. No bare URLs.
- **No duplicates.** Existing issues are searched before creating or restructuring. Duplicates are consolidated or cross-linked.

## Title

A clear, imperative-mood statement of the work. Not a question, not a symptom.

- Scope or area when it aids disambiguation: `Build-PSModule: Add retry logic to publish step`.
- No type prefixes (`[Bug]`, `[Feature]`) — labels handle categorization.

### Well-formed

- `Add pagination support to Get-GitHubRepository`
- `Fix null reference when Context is not resolved`
- `Update installation guide with prerequisites`

### Malformed

- `Bug in module`
- `Please fix`
- `WIP`

## The three sections

The description has three sections separated by horizontal rules (`---`), ordered from behavioural to architectural to tactical. The user need is understood before the technical discussion.

| Section | Owner          | Present in                                            |
| ------- | -------------- | ----------------------------------------------------- |
| 1 — Context and Request | Ideator → Clarifier   | Every issue at every level (Task, PBI, Epic) |
| 2 — Technical Decisions | Planner               | Task always; PBI / Epic for decomposition rationale |
| 3 — Implementation Plan | Planner               | Task always (task list); PBI / Epic (links to children) |

## Section 1 — Context and Request

Describes the **user experience** — what someone wants, what isn't working, or what is missing. Written from the user's perspective, not the implementer's.

Two parts:

- **Context** — who the user is, what they're trying to accomplish, the situation.
- **Request** — the problem or need, as the user experiences it.

Answers:

- What does the user want to do?
- What is the user experiencing today (for bugs / gaps)?
- What should the experience look like instead?
- Why does it matter?

Framing by work type:

| Type           | Framing                                                                |
| -------------- | ---------------------------------------------------------------------- |
| Feature        | Desired capability from the user's point of view.                      |
| Bug / Fix      | What happens vs. What is expected.                                     |
| Change request | Current experience vs. Desired experience.                             |
| Maintenance    | User impact — how internal work improves reliability, speed, etc.      |
| Documentation  | What is confusing or missing — the gap a user runs into.               |

Elements per work type:

| Element                  | Feature | Bug / Fix | Change request | Maintenance | Documentation |
| ------------------------ | :-----: | :-------: | :------------: | :---------: | :-----------: |
| Acceptance criteria      |    ✓    |     ✓     |       ✓        |      ✓      |       ✓       |
| Reproduction steps       |         |     ✓     |                |             |               |
| Environment / version    |         |     ✓     |                |             |               |
| Regression indicator     |         |     ✓     |                |             |               |
| Known workarounds        |         |     ✓     |       ○        |             |               |
| Error messages / logs    |         |     ✓     |                |      ○      |               |
| Screenshots / visuals    |    ○    |     ✓     |       ○        |             |       ○       |

✓ = present when applicable, ○ = optional

This section **does not contain** file paths, function internals, API endpoints, or implementation patterns. Those belong in Section 2.

## Section 2 — Technical Decisions

The technical choices that shape the plan. Sits between the user-facing request and the tactical plan.

Why this section exists:

- Different technical choices lead to fundamentally different plans — deciding upfront avoids rework.
- Conscious, documented choices replace implicit assumptions buried in code.
- Reviewers see the **reasoning** behind the plan, not just the plan itself.

Structure:

- Each decision is a bolded label or heading, followed by the chosen approach and a brief rationale.
- Alternatives considered are included when they help explain the choice.
- Open decisions are marked with `Open:` and resolved before the implementation plan is written.
- When a decision changes later, this section is updated and a comment documents the change.

Typical decision areas:

- Where new code lives (paths, modules).
- Patterns or conventions followed (e.g., "follow the existing pattern in `Get-GitHubRelease`").
- Naming choices.
- Whether to extend or create new.
- Dependencies on other functions, modules, or APIs.
- Error handling strategy.
- Breaking changes and backward compatibility.
- Test strategy (unit, integration, mocks).

## Section 3 — Implementation Plan

The task-level roadmap. Implementers track progress here; reviewers use it to understand scope.

Structure:

- Every discrete piece of work is a checkbox: `- [ ]`.
- Tasks are grouped under subheadings when work spans multiple areas (files, components, tests).
- Each task is specific and actionable — file paths, function names, modules.
- All tasks start unchecked. Checking happens during implementation.
- Tasks are ordered logically — dependencies first, tests last.

For PBIs and Epics, Section 3 is **a list of links to child issues**, not inline tasks. See [Issue Hierarchy](Issue-Hierarchy.md).

## Comments

Every description update is accompanied by a comment. Comments preserve the change history so reasoning is not lost when the description is overwritten.

A comment contains:

- A brief summary line.
- Bullet points detailing what was added, changed, or removed.
- Any gaps or open questions that need input.

## Formatting

Issues use [GitHub Flavored Markdown](https://github.github.com/gfm/) with the full feature set:

- `- [ ]` / `- [x]` task lists.
- Tables for comparisons, label definitions, decision matrices.
- Fenced code blocks with language identifiers.
- `>` blockquotes for callouts.
- `> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]` alerts.
- `<details><summary>…</summary>…</details>` collapsible sections.
- `#123`, `@user`, and commit SHA autolinks.
- Backtick-wrapped inline code for identifiers.
- `---` horizontal rules between sections.
- `[text](url)` links for all external references.
- **No hard line breaks within a paragraph.** GitHub renders mid-paragraph newlines as spaces, which creates inconsistent visual spacing.

## Labels

Labels categorize. The category is never encoded in the title.

| Label       | Use for                                              |
| ----------- | ---------------------------------------------------- |
| `Major`     | Breaking changes                                     |
| `Minor`     | New features or enhancements                         |
| `Patch`     | Small fixes or improvements                          |
| `NoRelease` | Documentation, maintenance, CI/CD — no version bump  |
| `Bug`       | Bug reports                                          |
| `Feature`   | Feature requests                                     |
| `Question`  | Questions or discussion                              |

Issue **types** (Epic / PBI / Task) are GitHub-native and separate from labels — see [Issue Hierarchy](Issue-Hierarchy.md).
