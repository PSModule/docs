# README-Driven Context

The README is the **evergreen context document** for every repository in the PSModule organization. It is the single source of truth for what a repository is, what it does, and how it works. Both humans and agents read the README before starting work — and update it whenever functionality changes.

## Core principles

- **The README is the front door.** Anyone — human or agent — encountering the repository for the first time should understand the purpose, scope, and current capabilities from the README without reading source code.
- **The README is evergreen.** It is a living document that always reflects the current state of the repository. When functionality is added, changed, or removed, the README is updated in the same unit of work.
- **Documentation is not optional.** A feature that is not documented in the README is effectively invisible. Updating the README is part of completing the work, not a follow-up task.
- **The README is authoritative.** If the README and the code disagree, the README is out of date and must be corrected — but it remains the intended source of truth.

## What belongs in the README

Include what is relevant. Not every repository needs every section.

| Section              | Purpose                                                                          |
| -------------------- | -------------------------------------------------------------------------------- |
| **Title**            | Repository name as the top-level heading.                                        |
| **Description**      | A concise summary (1–3 sentences) of what the repository does and who it is for. |
| **Features / Scope** | A list or prose description of the capabilities the repository provides.         |
| **Getting started**  | How to install, configure, or use the project for the first time.                |
| **Usage**            | Examples and explanations of key functionality. Code samples where applicable.   |
| **Configuration**    | Settings, environment variables, or options the user can control.                |
| **Architecture**     | High-level overview — folders, components, data flow — for complex repos.        |
| **Contributing**     | How to contribute, or a link to the organization-level contributing guide.       |
| **License**          | License type or a link to the LICENSE file.                                      |

For simple repositories (e.g., a single GitHub Action), a subset is fine — at minimum the title, description, and usage sections.

## When to update the README

The README is updated **in the same pull request** that introduces the change. Documentation is part of the work — not a separate follow-up.

### Update when

- A new feature, command, function, or capability is added.
- An existing feature changes in behavior, parameters, or output.
- A feature, command, or option is removed or deprecated.
- Installation or setup steps change.
- Configuration options change.
- The project scope or purpose evolves.
- Architecture or folder structure changes significantly.

### Do not update for

- Internal refactoring with no user-facing impact.
- Code style or formatting changes.
- CI/CD changes that do not affect usage.
- Dependency updates that do not change behavior.

## Agent workflow

When an agent works on a repository, the README sequence is:

1. **Read the README first** — before reading source code, understand the project context.
2. **Use the README as a guide** — let documented scope and architecture inform where and how to make changes.
3. **Update the README as part of implementation** — same PR, not a follow-up.
4. **Match the existing tone and structure** — heading levels, conventions, and style already present.
5. **Don't delete without reason** — if something is outdated, update it rather than removing it, unless the feature no longer exists.

## Writing guidelines

- Write for a reader who has **no prior context**.
- Use clear, direct language. Avoid jargon unless the audience is technical and the term is standard.
- Use examples liberally — a code sample is worth a paragraph.
- Focus on **what** and **how**, not implementation details. Internal design lives in code comments or architecture docs.
- Follow the organization-wide Markdown style.

## Why the README, and not this docs site

This docs site (psmodule.io/docs) is the **organization-level** evergreen context — principles, workflow, standards. The README is the **repository-level** evergreen context — what this specific repo is and does.

Both are required. The docs site explains how PSModule works. The README explains what this repository is. An agent reading the docs site knows the system; an agent reading a README knows the project.
