Analyze this codebase and generate, update and cleanup Copilot instruction files that guide AI coding agents.

This prompt defines a structured workflow with specific tasks that can be planned and executed systematically to maintain a comprehensive instruction system for AI coding agents.

## Execution Tasks

The following tasks should be executed in order, with each task depending on the successful completion of previous tasks:

### T001: Discovery and Analysis
**Dependencies**: None
**Goal**: Analyze existing instruction structure and identify content sources
**Actions**:
1. Read all existing files matching pattern: `**/{.github/copilot-instructions.md,.github/instructions/**,AGENT.md,AGENTS.md,CLAUDE.md,.cursorrules,.windsurfrules,.clinerules,.cursor/rules/**,.windsurf/rules/**,.clinerules/**,README.md}`
2. Catalog current `.github/instructions/` directory structure and content
3. Identify all programming languages/technologies used in the codebase
4. Analyze codebase patterns and conventions to extract implicit guidance
5. Create content inventory and categorization plan

### T002: Content Categorization and Planning
**Dependencies**: T001
**Goal**: Plan content migration and organization strategy
**Actions**:
1. Categorize existing content as framework (generic) vs repo-specific (project)
2. Identify content gaps for discovered languages/technologies
3. Plan file structure for `.github/instructions/framework/` and `.github/instructions/repo/`
4. Create mapping strategy for migrating `.github/copilot-instructions.md` content
5. Validate no critical content will be lost during migration

### T003: Framework Instructions Creation/Update
**Dependencies**: T002
**Goal**: Create or update generic, reusable instruction files
**Actions**:
1. Create/update `.github/instructions/framework/main.instructions.md` with universal patterns
2. For each detected language/technology, create/update main instruction files:
   - `.github/instructions/framework/{Language}/main.instructions.md`
3. Create specialized instruction files for each language:
   - Tests: `.github/instructions/framework/{Language}/tests.instructions.md`
   - Classes/Components: `.github/instructions/framework/{Language}/classes.instructions.md`
   - Other patterns as identified (workflows, actions, docs, etc.)
4. Ensure all files follow required YAML frontmatter and content model
5. Extract generic patterns from existing repo-specific instructions

### T004: Repository-Specific Instructions Creation/Update
**Dependencies**: T002
**Goal**: Create or update project-specific instruction files
**Actions**:
1. Create/update `.github/instructions/repo/main.instructions.md` with project context
2. For each language/technology, create/update repo-specific instruction files:
   - `.github/instructions/repo/{Language}/main.instructions.md`
3. Create specialized repo instruction files as needed
4. Preserve all project-specific patterns and conventions
5. Include architecture, workflows, and integration-specific guidance

### T005: Content Migration from Legacy Files
**Dependencies**: T003, T004
**Goal**: Migrate content from `.github/copilot-instructions.md` and other legacy sources
**Actions**:
1. Systematically extract content from `.github/copilot-instructions.md`
2. Categorize each piece of content (framework vs repo-specific)
3. Migrate content to appropriate instruction files without duplication
4. Ensure no valuable guidance is lost during migration

### T006: Structure Validation and Quality Check
**Dependencies**: T005
**Goal**: Validate instruction system completeness and accuracy
**Actions**:
1. Verify all instruction files have proper YAML frontmatter with `applyTo` and `description`
2. Validate `applyTo` patterns correctly target intended file types
3. Check for content completeness across all discovered languages/technologies
4. Ensure consistent terminology and patterns across instruction files
5. Validate framework vs repo categorization is correct

### T007: Legacy File Cleanup
**Dependencies**: T006
**Goal**: Clean up legacy instruction files after successful migration
**Actions**:
1. Verify all content has been successfully migrated from legacy files
2. Delete any files in `.github/instructions/` (outside framework/repo) after confirming their content has been migrated to appropriate framework/repo subfolders
3. Remove `.github/copilot-instructions.md` ONLY after verifying complete migration
4. Clean up any other legacy instruction files found

### T008: Final Validation and User Feedback
**Dependencies**: T007
**Goal**: Complete final system validation and provide user feedback
**Actions**:
1. Perform final validation that all tasks completed successfully
2. Verify no content was lost during migration process
3. Confirm instruction system completeness and accuracy
4. Provide summary of work completed
5. Ask user for feedback on instruction system quality and completeness

## Goals and Constraints

### Primary Goals
1. Maintain path-scoped instruction files under `.github/instructions/`
2. Separate framework-level generic guidance from repo-specific guidance:
   - `.github/instructions/framework/...` = generic, reusable, automation-managed
   - `.github/instructions/repo/...` = project-specific, manually curated
   - Other files or folders in the `.github/instructions/` directory MUST be treated as potential candidates for either framework or repo-specific instructions, resulting in its content being migrated to the appropriate subfolder and then deleted
3. Evaluate and extract content from `.github/instructions/repo/...` to create or update the corresponding framework instructions
4. Move any existing content from `.github/copilot-instructions.md` into the appropriate path-scoped files

### Task Execution Constraints
- Tasks MUST be executed in the specified order due to dependencies
- Each task MUST be completed successfully before proceeding to the next
- If any task fails, abort the process and report the specific failure
- No content MUST be lost during migration or cleanup processes
- All changes MUST be validated before proceeding to cleanup tasks

### Content Preservation Rules
- **No content loss**: All valuable guidance from existing instruction files must be preserved
- **Proper categorization**: Generic patterns go to framework, project-specific patterns stay in repo
- **Content deduplication**: Avoid duplicating the same guidance across multiple files
- **Consistency validation**: Ensure consistent terminology and patterns across all instruction files
- **Completeness check**: Verify all languages/technologies found in codebase have appropriate instruction coverage

## Expected Output Structure

The execution of tasks T003-T004 will create/update the following file structure:

### Framework Instructions (automation-managed)
Created/updated by **T003: Framework Instructions Creation/Update**

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
  (repeat for all detected languages/technologies)

- Section-specific examples:
  `.github/instructions/framework/PowerShell/tests.instructions.md`
  ```yaml
  ---
  applyTo: "**/*.Tests.ps1,**/tests/**/*.ps1"
  description: Generic PowerShell test guidance
  ---
  ```
  (repeat for all components/types discovered)

### Repository Instructions (project-specific)
Created/updated by **T004: Repository-Specific Instructions Creation/Update**

- Root repo-specific: `.github/instructions/repo/main.instructions.md`
  ```yaml
  ---
  applyTo: "**/*"
  description: Repo-specific rules for this project
  ---
  ```
- Per language/technology (project conventions):
  `.github/instructions/repo/PowerShell/main.instructions.md`
  ```yaml
  ---
  applyTo: "**/*.{ps1,psm1,psd1}"
  description: Repo-specific PowerShell conventions
  ---
  ```
  Section-specific as needed, same pattern as framework instructions

### Automation Sync Rules
- Files under `.github/instructions/framework/` MAY be updated automatically by sync tooling, sources from a central pattern repository
- Files under `.github/instructions/repo/` MUST NOT be overwritten by automation, is meant to be manually curated within the repo

### Legacy File Migration and Cleanup
Handled by **T005: Content Migration from Legacy Files** and **T007: Legacy File Cleanup**

Migration process for `.github/copilot-instructions.md`:
1. Read and analyze existing content thoroughly (T005)
2. Extract valuable patterns, conventions, and project-specific knowledge (T005)
3. Merge content into appropriate instruction files based on applicability (T005):
   - Generic patterns → framework instructions
   - Project-specific patterns → repo instructions
   - Language-specific guidance → appropriate language folders
4. Preserve all valuable content; do not lose important guidance (T005)
5. Remove `.github/copilot-instructions.md` ONLY after verifying all content has been properly migrated (T007)

Cleanup process for loose instruction files (T007):
1. Verify all content from loose instruction files has been migrated to framework/repo structure
2. Delete loose files after confirming successful content migration
3. Do not move files - delete them after migration is confirmed complete

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

## Content preservation and validation rules

- **No content loss**: All valuable guidance from existing instruction files must be preserved
- **Proper categorization**: Generic patterns go to framework, project-specific patterns stay in repo
- **Content deduplication**: Avoid duplicating the same guidance across multiple files
- **Consistency validation**: Ensure consistent terminology and patterns across all instruction files
- **Completeness check**: Verify all languages/technologies found in codebase have appropriate instruction coverage
- **Migration verification**: Before removing `.github/copilot-instructions.md`, confirm all its content has been properly distributed

## Error handling and safety

- If `.github/copilot-instructions.md` contains critical content that cannot be categorized, do NOT remove the file
- If migration would result in content loss, abort the cleanup and report the issue
- Maintain backup references to original content during migration process
- Validate that all `applyTo` patterns correctly target intended file types

## Validation checklist (apply before responding)

- Verify all mandated sections for the prompt type.
- Ensure no unresolved placeholders remain (except intentional TODOs).
- Check line length and newline compliance.
- Confirm deterministic ordering of enumerations.
- **Migration validation**:
  - Confirm all content from `.github/copilot-instructions.md` has been properly migrated
  - Verify no valuable guidance was lost during content extraction
  - Ensure proper framework vs repo categorization
  - Validate all `applyTo` patterns target correct file types
  - Check that migration maintains content accuracy and completeness

## Commit guidance (when files are modified)

- Suggested commit: `chore(prompts): <concise change summary>`
- Constitution updates: `docs: amend constitution to vX.Y.Z (<summary>)`

## Task Deliverables

Upon successful completion of all tasks, the following deliverables will be produced:

### From T003-T004: Instruction System
1. Framework instructions under `.github/instructions/framework/` (automation-managed)
2. Repo instructions under `.github/instructions/repo/` (manual, project-specific)

### From T005-T007: Migration and Cleanup
3. Content migration from `.github/copilot-instructions.md` completed
4. Cleanup: `.github/copilot-instructions.md` file removed after successful migration
5. Cleanup: Any loose instruction files deleted after content migrated to appropriate framework/repo subfolders

### From T008: Final Validation
6. Final validation of system completeness and accuracy
7. User feedback on instruction system quality

## Task Success Criteria

Each task has specific success criteria that must be met before proceeding:

- **T001**: Complete inventory of existing content and technology discovery
- **T002**: Clear categorization plan with no ambiguous content
- **T003**: All framework instruction files created with proper structure and content
- **T004**: All repo-specific instruction files created with project context
- **T005**: All legacy content successfully migrated without loss
- **T006**: All validation checks pass with no structural or content issues
- **T007**: Legacy files cleaned up only after confirmed migration
- **T008**: Final validation completed and user feedback provided

## Task Execution Guidance

### Planning Phase
Before executing tasks, create a detailed execution plan:
1. Review all task dependencies and ensure proper sequencing
2. Estimate scope and complexity for each task based on discovered content
3. Identify potential risks or blockers for each task
4. Plan rollback strategy if any task fails

### Execution Phase
Execute tasks in the specified order:
1. Complete each task fully before moving to the next
2. Validate task success criteria before proceeding
3. Document progress and any issues encountered
4. If a task fails, stop execution and report the specific failure

### Validation Phase
After each task completion:
1. Verify task deliverables meet specified criteria
2. Check that no content has been lost or corrupted
3. Validate file structure and format requirements
4. Confirm dependencies for next task are satisfied

## Final Step: Task Completion and User Feedback

### Task Completion Verification
1. **All tasks completed successfully**: Confirm T001-T008 have been executed and their success criteria met
2. **Migration verification**: Confirm all content has been successfully migrated from `.github/copilot-instructions.md`
3. **Cleanup verification**: Verify legacy files have been removed (if migration was successful)
4. **Content integrity**: Validate that no valuable guidance was lost during the process
5. **System completeness**: Ensure instruction system covers all discovered technologies and patterns

### User Feedback and Next Steps
1. **Report completion**: Provide brief summary of work completed
2. **Identify gaps**: Ask the user which unclear or incomplete areas need refinement
3. **Propose improvements**: Suggest specific follow-ups for any remaining content gaps
4. **Categorization review**: Offer to adjust categorization if framework vs repo separation needs refinement

### Success Indicators
- ✅ All 8 tasks completed successfully
- ✅ No content loss during migration
- ✅ Proper framework vs repo categorization
- ✅ Complete technology coverage
- ✅ Legacy files cleaned up appropriately
