Analyze this codebase and generate or update Copilot instruction files that guide AI coding agents.

## Goals

1. Generate path-scoped instruction files under `.github/instructions/`.
1. Separate framework-level generic guidance from repo-specific guidance:
   - `.github/instructions/framework/...` = generic, reusable, automation-managed
   - `.github/instructions/repo/...` = project-specific, manually curated
1. Evaluate and extract content from `.github/instructions/repo/...` to create or update the corresponding framework instructions.
1. Move any existing content from `.github/copilot-instructions.md` into the appropriate path-scoped files.

## Source of existing guidance if exists

Read from:
`**/{.github/copilot-instructions.md,.github/instructions/**,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,README.md}`

## File structure to create/update

1. Path-scoped split into framework vs repo:
   - `.github/instructions/framework/...` = generic reusable instructions
   - `.github/instructions/repo/...` = repo-specific instructions
   - Both MAY contain the same language/tech folders but MUST be kept separate
1. Framework instructions (automation-owned)
   - Root generic: `.github/instructions/framework/main.instructions.md`
     ```yaml
     ---
     applyTo: "**/*"
     description: Generic guidance for all files across repos
     ---
     ```
   - Per language/technology (main + sections):
     `.github/instructions/framework/PowerShell/main.instructions.md`
     ```yaml
     ---
     applyTo: "**/*.{ps1,psm1,psd1}"
     description: Generic PowerShell guidance
     ---
     ```
     `.github/instructions/framework/csharp/main.instructions.md`
     ```yaml
     ---
     applyTo: "**/*.{cs,csproj,sln}"
     description: Generic C# guidance
     ---
     ```
     (repeat for all detected languages/technologies, i.e. Terraform, TypeScript/JavaScript, YAML/GitHub Actions, Markdown, JSON, etc.)
   - Section-specific examples:
     `.github/instructions/framework/PowerShell/tests.instructions.md`
     ```yaml
     ---
     applyTo: "**/*.Tests.ps1,**/tests/**/*.ps1"
     description: Generic PowerShell test guidance
     ---
     ```
     (repeat for all components/types of language files, i.e. classes, functions, private functions, formats, etc. for PowerShell; main + tests for
     TypeScript/JavaScript; main + workflows + actions for YAML; main + docs + changelog for Markdown; etc.)
1. Repo instructions (project-specific)
   - Root repo-specific: `.github/instructions/repo/main.instructions.md`
     ```yaml
     ---
     applyTo: "**/*"
     description: Repo-specific rules for this project
     ---
     ```
   - Per language/technology (project conventions, not generic)
     `.github/instructions/repo/PowerShell/main.instructions.md`
     ```yaml
     ---
     applyTo: "**/*.{ps1,psm1,psd1}"
     description: Repo-specific PowerShell conventions
     ---
     ```
     Section-specific as needed, same pattern as for framework instructions.

1) Automation sync rules
   - Files under `.github/instructions/framework/` MAY be updated automatically by sync tooling, sources from a central pattern repository.
   - Files under `.github/instructions/repo/` MUST NOT be overwritten by automation, is meant to be manually curated within the repo.

1) Root copilot-instructions.md file.
   - Path: `.github/copilot-instructions.md`
   - Merge content into any of the other files that apply: preserve valuable content, refresh outdated specifics.
   - Finally remove this file when content is verified to be migrated to other files.

## Content model for every instruction file

1) YAML front matter (required)
   ```yaml
   ---
   applyTo: <glob(s) only for path-scoped files; omit in the global file>
   description: <succinct purpose in one sentence>
   ---
   ```
2) Optional one-line context lead; do not restate description verbatim.
3) Sections (sentence-case headings, no numbering inside the heading text):
   - Goal (if distinct from description)
   - Execution steps (ordered list)
   - Behavior rules / Constraints
   - Output format (if a specific result shape is required)
   - Error handling (only if non-trivial)
   - Definitions / Glossary (optional)
4) Use fenced code blocks only for literal commands/templates; avoid huge blocks unless needed.

## Discovery focus (repo-specific only)

- Architecture: components, boundaries, data flows, and rationale.
- Critical workflows: build, test, debug, release. Include exact commands and entry points.
- Conventions and patterns: naming, logging, error handling, DI, layout, testing styles.
- Integrations: APIs, events, queues, IaC, cross-component calls.
- Language-/tech-specific idioms in this repo with concrete examples and file paths.

## User input handling (reusable rule)

- User input may be provided as command arguments; MUST consider it if non-empty.
- Refer to raw user input placeholder exactly as `$ARGUMENTS`.
- If input can be empty and flow changes, specify explicit fallback or abort behavior.

## Script invocation pattern

- Specify exact relative path from repo root.
- Put mandatory flags first, optional flags second.
- Use "Run once" / "MUST only run once" for one-time scripts.
- Clarify required JSON fields expected from script output.
- Use CAPITALIZED derived variable names (e.g., FEATURE_DIR, SPEC_FILE) for parsed values.

## Parsing and modeling guidance

- For multi-document sets (spec.md, plan.md, tasks.md), define presence rules and derivations.
- Provide deterministic key generation (e.g., slugified phrases).
- Include explicit mapping constructs: Requirements Inventory and Task Coverage Mapping.
- Define deterministic heuristics for inference (dup detection, keyword match) to ensure stable IDs.

## Detection and analysis patterns

- Categories with purpose, triggers, output fields (e.g., Duplication, Ambiguity, Coverage, Constitution Alignment).
- Provide a severity heuristic list and cap results (e.g., max 50 rows); specify overflow handling.

## Output specification for assistant responses

- Define required sections via Markdown headings (## or ###) for consumer tooling.
- For tables: fixed column order and headers; stable IDs (prefix category initial + counter: A1, A2).
- Include a summary metrics block when analytical.
- End with an explicit next-action question when user approval is required.

## Clarification workflow (clarify-style prompts)

- Ask at most 5 questions, one at a time; never reveal the queue.
- Provide an answer format hint line (e.g., "Format: Short answer (<=5 words)").
- Support early termination tokens: "stop", "done", "proceed".
- Persist accepted answers only after validating brevity and relevance.

## Task, plan, and spec generation

- Enforce prerequisites (spec before plan, plan before tasks) unless user overrides.
- NEVER fabricate missing clarifications; prompt the user instead.
- Number tasks deterministically as T001, T002 (zero-padded to 3 digits).
- Mark tasks with [P] only when no shared file path overlap.
- Separate phases: Setup, Tests, Core, Integration, Polish, with explicit gates.

## Constitution handling

- Treat `.specify/memory/constitution.md` as authoritative and immutable during analysis.
- Flag conflicts as CRITICAL; do not reinterpret principles.
- On updates, apply semver (MAJOR/MINOR/PATCH) and output an HTML comment Sync Impact Report.

## Error and abort rules

- If a required file is missing, abort with a clear message and the next command to run (e.g., "/tasks" or "/specify").
- Do NOT partially modify artifacts when prerequisites fail.
- Do not auto-create design artifacts outside their dedicated workflows.

## Determinism and idempotence

- Lists, IDs, and metrics MUST be stable across runs with unchanged inputs.
- Avoid non-deterministic ordering; sort alphabetically or by original appearance index.

## Prohibited behaviors

- No silent edits unless the prompt explicitly authorizes writing.
- No hallucinated sections; report absence explicitly.
- Do not exceed question or task limits.

## Quality and clarity

- Prefer explicit over implicit dependencies (e.g., "T005 depends on T002").
- Use a consistent canonical term set and flag drift.
- Replace vague nouns with domain terms.

## Accessibility and formatting

- Keep tables ≤120 characters wide when feasible; wrap cells minimally.
- End responses with a single newline; avoid trailing spaces in table rows.

## Extension and future-proofing

- New prompt types SHOULD reuse the same section taxonomy when possible.
- Add new severity levels only with rationale and backward compatibility notes.
- Mark temporary placeholders with `TODO(<TOKEN>): reason`.

## Validation checklist (apply before responding)

- Verify all mandated sections for the prompt type.
- Ensure no unresolved placeholders remain (except intentional TODOs).
- Check line length and newline compliance.
- Confirm deterministic ordering of enumerations.

## Commit guidance (when files are modified)

- Suggested commit: `chore(prompts): <concise change summary>`
- Constitution updates: `docs: amend constitution to vX.Y.Z (<summary>)`

## Deliverables

1) Updated `.github/copilot-instructions.md` (merged).
2) Framework instructions under `.github/instructions/framework/` (automation-managed).
3) Repo instructions under `.github/instructions/repo/` (manual, project-specific).
4) Short report listing each created/updated file, its `applyTo`, and whether it belongs to framework or repo.

## Final step

Ask the user which unclear or incomplete areas need refinement and propose specific follow-ups.
