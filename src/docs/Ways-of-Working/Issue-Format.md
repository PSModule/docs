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

| Section                   | Owner                 | Present in                                                    |
| ------------------------- | --------------------- | ------------------------------------------------------------- |
| 1 — Context and Request   | Ideator → Clarifier   | Every issue at every level (Task, PBI, Epic)                  |
| 2 — Technical Decisions   | Planner               | Task always; PBI / Epic for decomposition rationale           |
| 3 — Implementation Plan   | Planner               | Task always (task list); PBI / Epic (links to children)       |

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

| Type           | Framing                                                                              |
| -------------- | ------------------------------------------------------------------------------------ |
| Feature        | **Desired capability:** The desired capability from the user's point of view.        |
| Bug / Fix      | **What happens:** / **What is expected:** Observed vs. expected behavior.            |
| Change request | **Current experience:** / **Desired experience:** The shift from the user's lens.    |
| Maintenance    | **User impact:** How internal work improves reliability, speed, or correctness.      |
| Documentation  | **What is confusing or missing:** The gap from a user trying to accomplish a task.   |

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

Element definitions:

- **Reproduction steps** — a [minimal reproducible example](https://en.wikipedia.org/wiki/Minimal_reproducible_example): exact steps, inputs, and commands that trigger the problem. Anyone can reproduce the failure without guessing.
- **Environment / version** — module version, PowerShell version (`$PSVersionTable`), and operating system. Other relevant runtime details (host application, execution context) included as applicable. Omitted only when clearly version-independent.
- **Regression indicator** — whether this previously worked, and in which version. If unknown, stated explicitly.
- **Known workarounds** — any mitigation available today, even if ugly or incomplete.

This section contains:

- Context: user story or scenario, background, what the user is trying to accomplish
- Request: the specific problem, gap, or desired change — as the user experiences it
- Current vs. desired experience
- Impact of not addressing this (data loss, confusion, blocked workflows)
- Acceptance criteria — what "done" looks like from the user's perspective
- Applicable work-type-specific elements from the table above
- Links to related issues, PRs, or external references — every external resource is a clickable hyperlink

This section **does not contain** file paths, function internals, API endpoints, or implementation patterns. Those belong in Section 2. The section is understandable by someone who has never read the source code.

**Example (Bug / Fix):**

```markdown
`Get-GitHubRepository` is used in automation to sync all repositories for an account.
The script relies on getting the full list so it can detect new or removed repositories.

## Request

When `Get-GitHubRepository` is called on an account with more than 30 repositories, only 30 results are returned.
There is no indication that results are incomplete, so it appears as though the full list has been retrieved.
The silent truncation causes scripts to miss repositories, which can go unnoticed for weeks.

### Reproduction steps

1. Create or use an account with more than 30 repositories
2. Run `Get-GitHubRepository`
3. Count the returned objects — only 30 are returned regardless of total count

### What is expected

The command should return **all** repositories by default. If there is a way to limit results,
it should be opt-in — not the default.

### Environment

- **Module version:** 0.14.0
- **PowerShell:** 7.4.6 (Linux, Ubuntu 22.04)

### Regression

This appears to have been the behavior since the initial release. Not a regression.

### Workaround

Calling the GitHub REST API directly with manual pagination returns all results.

### Acceptance criteria

- All repositories are returned by default, regardless of how many exist
- Results can be limited with a parameter when only a subset is needed
- No silent data loss — if something limits results, it should be explicit
```

**Example (Feature):**

```markdown
Automation scripts that publish module releases to multiple registries currently call `Publish-PSResource`
in a loop for each target. There is no built-in way to publish to several registries in a single invocation.

## Request

### Desired capability

A `-Repository` parameter on `Publish-Module` that accepts an array of registry names, publishing
the module to each in sequence. If any single publish fails, the error should be reported per-registry
without aborting the remaining targets.

### Acceptance criteria

- `-Repository` accepts one or more registry names
- Each target is attempted independently — a failure on one does not block the others
- Output clearly indicates success or failure per registry
```

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

**Example:**

```markdown
---

## Technical decisions

**Function placement:** New private function goes in `src/functions/private/Utilities/` following the existing
`Invoke-GitHubRestMethod` pattern. Public function stays in `src/functions/public/Repository/`.

**Pagination approach:** Use link-header-based pagination (`rel="next"`) rather than page-number incrementing.
The GitHub REST API uses link headers consistently, and this avoids hardcoding page size assumptions.

**Parameter naming:** Use `-First` (consistent with PowerShell convention and `Select-Object -First`) rather than
`-Limit` or `-MaxResults`.

**Breaking changes:** None. Default behavior changes from returning one page to returning all pages, but since the
previous behavior was undocumented and returning incomplete data, this is treated as a bugfix rather than a breaking change.

**Test approach:** Unit tests with mocked API responses. One test per scenario: single-page, multi-page, and `-First` limiting.
```

## Section 3 — Implementation Plan

The task-level roadmap. Implementers track progress here; reviewers use it to understand scope.

Structure:

- Every discrete piece of work is a checkbox: `- [ ]`.
- Tasks are grouped under subheadings when work spans multiple areas (files, components, tests).
- Each task is specific and actionable — file paths, function names, modules.
- All tasks start unchecked. Checking happens during implementation.
- Tasks are ordered logically — dependencies first, tests last.

For PBIs and Epics, Section 3 is **a list of links to child issues**, not inline tasks. See [Issue Hierarchy](Issue-Hierarchy.md).

**Example:**

```markdown
---

## Implementation plan

### Core changes

- [ ] Add `Invoke-GitHubRestMethodPaged` private function in `src/functions/private/Utilities/`
- [ ] Update `Get-GitHubRepository` to call paged variant in `src/functions/public/Repository/`
- [ ] Add `-First` parameter with `[int]` type and validation

### Tests

- [ ] Add unit test for single-page response
- [ ] Add unit test for multi-page response
- [ ] Add unit test for `-First` parameter limiting results

### Documentation

- [ ] Update function help with new parameter documentation
- [ ] Add example showing pagination usage
```

## Comments

Every description update is accompanied by a comment. Comments preserve the change history so reasoning is not lost when the description is overwritten.

A comment contains:

- A brief summary line.
- Bullet points detailing what was added, changed, or removed.
- Any gaps or open questions that need input.

**Example:**

```markdown
Structured the issue description into the standard three-section format.

- Rewrote the context and request to separate user-facing behavior from technical details
- Added technical decisions section based on codebase research
- Created implementation plan with 6 tasks covering core changes, tests, and documentation
- Open question: should `-First` default to unlimited or require explicit opt-in? Marked as open in technical decisions.
```

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

## Complete example

A fully structured bug fix issue:

**Title:** `Fix silent truncation of results in Get-GitHubRepository`

**Labels:** `Patch`, `Bug`

**Body:**

```markdown
`Get-GitHubRepository` is used in automation to sync all repositories for an account.
The script relies on getting the full list so it can detect new or removed repositories.

## Request

When `Get-GitHubRepository` is called on an account with more than 30 repositories, only
30 results are returned. There is no indication that results are incomplete, so it appears
as though the full list has been retrieved. The silent truncation causes scripts to miss
repositories, which can go unnoticed for weeks.

### Reproduction steps

1. Create or use an account with more than 30 repositories
2. Run `Get-GitHubRepository`
3. Count the returned objects — only 30 are returned regardless of total count

### What is expected

The command should return **all** repositories by default. If there is a way to limit
results, it should be opt-in — not the default.

### Environment

- **Module version:** 0.14.0
- **PowerShell:** 7.4.6 (Linux, Ubuntu 22.04)

### Regression

This appears to have been the behavior since the initial release. Not a regression.

### Workaround

Calling the GitHub REST API directly with manual pagination returns all results.

### Acceptance criteria

- All repositories are returned by default, regardless of how many exist
- Results can be limited with a parameter when only a subset is needed
- No silent data loss — if something limits results, it should be explicit

---

## Technical decisions

**Function placement:** New private function goes in `src/functions/private/Utilities/` following
the existing `Invoke-GitHubRestMethod` pattern. Public function stays in
`src/functions/public/Repository/`.

**Pagination approach:** Use link-header-based pagination (`rel="next"`) rather than page-number
incrementing. The GitHub REST API uses link headers consistently, and this avoids hardcoding page
size assumptions.

**Parameter naming:** Use `-First` (consistent with PowerShell convention and `Select-Object -First`)
rather than `-Limit` or `-MaxResults`.

**Breaking changes:** None. Default behavior changes from returning one page to returning all pages,
but since the previous behavior was undocumented and returning incomplete data, this is treated as a
bug fix rather than a breaking change.

**Test approach:** Unit tests with mocked API responses. One test per scenario: single-page,
multi-page, and `-First` limiting.

---

## Implementation plan

### Core changes

- [ ] Add `Invoke-GitHubRestMethodPaged` private function in `src/functions/private/Utilities/`
- [ ] Update `Get-GitHubRepository` to call paged variant in `src/functions/public/Repository/`
- [ ] Add `-First` parameter with `[int]` type and validation

### Tests

- [ ] Add unit test for single-page response
- [ ] Add unit test for multi-page response
- [ ] Add unit test for `-First` parameter limiting results

### Documentation

- [ ] Update function help with new parameter documentation
- [ ] Add example showing pagination usage
```

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
