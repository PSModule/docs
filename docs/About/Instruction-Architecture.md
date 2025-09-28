# GitHub Copilot File Manageme### Automation and Synchronization

All organization-tier Copilot files can be automatically synchron1. **Organization main instructions** (`instructions/organization/main.instructions.md`) - Organization-wide framework patterns
2. **Organization language instructions** (`instructions/organization/{Language}/main.instructions.md`) - Organization-wide language-specific patterns
3. **Organization context instructions** (`instructions/organization/{Language}/{context}.instructions.md`) - Organization-wide specialized patternsd from a central source to target repositories. The synchronization mechanism can be configured for different organizational contexts:

**Standard Organization Setup:**
- Source: Organization's `.github` repository
- Target: Repositories with specific custom properties (e.g., `type: module`, `framework: standard`)

**Enterprise Setup:**
- Source: Dedicated organization or repository within the enterprise
- Target: All managed repositories or those matching specific criteria

**Community Framework Setup:**
- Source: Framework organization's `.github` repository
- Target: Repositories adopting the community framework

The synchronization process applies to all Copilot configuration types:
- **Updates**: All files under `organization/` folders are managed by automation and will be overwritten during sync
- **Preserves**: All files under `repository/` folders are never modified by the sync mechanism
- **Flexibility**: Organizations can choose their synchronization criteria and automation approachcture

This specification documents a scalable GitHub Copilot file management architecture designed to provide consistent guidance, prompts, and chat modes across multiple repositories in community organizations and enterprises.

## Purpose and Context

Modern software organizations require a structured system for managing GitHub Copilot configuration files that enables AI agents to make consistent changes across multiple repositories while allowing for project-specific customization.

Due to the absence of native organization-wide configuration support in GitHub that provides a single location for common Copilot configurations, this architecture implements a scalable two-tier approach for managing:

- **Instructions**: Guidance and patterns for AI agents
- **Prompts**: Reusable prompt templates and patterns
- **Chat modes**: Specialized conversation contexts and behaviors

This architecture serves multiple organizational contexts:
- **Community Organizations**: Open source projects and community frameworks requiring consistent standards across repositories
- **Enterprises**: Large organizations needing centralized AI assistance standards across teams and projects
- **Enterprise Profiles**: Addresses the "enterprise profile" challenge by providing repository-level customization within organizational standardsEach Copilot configuration type follows a consistent two-tier management approach:

- **Organization tier**: Managed via automation from the organization level
- **Repository tier**: Managed locally within each repository

This design allows organizations to maintain consistency across all managed repositories while preserving flexibility for repository-specific requirements.

## Architecture Specification

### Design Decision: Legacy File Elimination

The file `.github/copilot-instructions.md` is not supported in this architecture. This specification replaces the simplified single-file approach with a structured system that manages all GitHub Copilot configuration files through organization-managed and repository-managed tiers.

### Automation and Synchronization

All organization-tier Copilot files are automatically synchronized from the organization's `.github` repository to all repositories that have:
- A custom property named `type`
- With the value `module`

The synchronization process applies to all Copilot configuration types:
- **Updates**: All files under `organization/` folders are managed by automation and will be overwritten during sync
- **Preserves**: All files under `repository/` folders are never modified by the sync mechanism
- **Source**: Organization files originate from the PSModule organization's `.github` repository### Folder Structure Specification

The `.github/` folder contains three Copilot configuration directories, each following the two-tier structure:

```
.github/
├── instructions/                 # AI agent guidance and patterns
│   ├── organization/            # Organization-managed instruction patterns (automated sync)
│   │   ├── main.instructions.md # Core organizational framework guidelines
│   │   └── {Language}/          # Language/technology-specific framework patterns
│   │       ├── main.instructions.md # Style guide and core instructions
│   │       └── {context}.instructions.md # Specialized context instructions
│   └── repository/              # Repository-managed instruction overrides (manual)
│       ├── main.instructions.md # Repository context and specific rules
│       └── {Language}/          # Repository-specific language customizations
│           ├── main.instructions.md # Repository language patterns
│           └── {context}.instructions.md # Repository context overrides
├── prompts/                     # Reusable prompt templates
│   ├── organization/            # Organization-managed prompts (automated sync)
│   │   └── {prompt-files}       # Standard organization prompt templates
│   └── repository/              # Repository-managed prompts (manual)
│       └── {prompt-files}       # Project-specific prompt templates
└── chatmodes/                   # Specialized conversation contexts
    ├── organization/            # Organization-managed chat modes (automated sync)
    │   └── {chatmode-files}     # Standard organization chat modes
    └── repository/              # Repository-managed chat modes (manual)
        └── {chatmode-files}     # Project-specific chat modes
```

### File Structure Specification

#### Instructions (Structured Guidance)

**Organization Files (Organization-Managed)**
- **`instructions/organization/main.instructions.md`**: Universal organizational framework guidelines and architectural principles
- **`instructions/organization/{Language}/main.instructions.md`**: Core style guide and language-specific framework instructions
- **`instructions/organization/{Language}/{context}.instructions.md`**: Specialized framework patterns for specific scenarios

**Repository Files (Repository-Managed)**
- **`instructions/repository/main.instructions.md`**: Repository-specific context, technology stack information, and project-specific rules
- **`instructions/repository/{Language}/main.instructions.md`**: Repository-specific language style and patterns that override or extend framework instructions
- **`instructions/repository/{Language}/{context}.instructions.md`**: Project-specific overrides for specialized scenarios

#### Prompts (Reusable Templates)

**Organization Files (Organization-Managed)**
- **`prompts/organization/{name}.prompt.md`**: Standard organization-wide prompt templates for common scenarios
- Organization prompts provide consistent templates for frequent development tasks

**Repository Files (Repository-Managed)**
- **`prompts/repository/{name}.prompt.md`**: Project-specific prompt templates tailored to repository requirements
- Repository prompts extend or override organization templates for specialized use cases

#### Chat Modes (Conversation Contexts)

**Organization Files (Organization-Managed)**
- **`chatmodes/organization/{name}.chatmode.md`**: Standard conversation contexts and specialized AI behaviors
- Organization chat modes provide consistent interaction patterns across repositories

**Repository Files (Repository-Managed)**
- **`chatmodes/repository/{name}.chatmode.md`**: Project-specific conversation contexts and behaviors
- Repository chat modes customize AI interactions for specific project needs

#### Context File Examples
For instructions, context-specific files may include:
- File extension patterns: `tests.instructions.md`, `classes.instructions.md`
- Folder-specific patterns: `workflows.instructions.md`, `docs.instructions.md`
- Functional patterns: `api.instructions.md`, `config.instructions.md`

### Precedence Specification

#### Instruction Precedence

Instructions are evaluated and applied in hierarchical order, with more specific instructions taking precedence:

1. **Organization main instructions** (`instructions/organization/main.instructions.md`) - Organization-wide PSModule patterns
2. **Organization language instructions** (`instructions/organization/{Language}/main.instructions.md`) - Organization-wide language-specific patterns
3. **Organization context instructions** (`instructions/organization/{Language}/{context}.instructions.md`) - Organization-wide specialized patterns
4. **Repository main instructions** (`instructions/repository/main.instructions.md`) - Project-specific context and overrides
5. **Repository language instructions** (`instructions/repository/{Language}/main.instructions.md`) - Project-specific language patterns
6. **Repository context instructions** (`instructions/repository/{Language}/{context}.instructions.md`) - Most specific project-based overrides

#### Prompt and Chat Mode Precedence

For prompts and chat modes, repository-specific files take precedence over organization files when both exist:

- **Organization prompts/chat modes**: Provide default templates and behaviors
- **Repository prompts/chat modes**: Override or extend organization defaults for project-specific needs

This precedence system ensures that repository-specific requirements can override organization-wide patterns while maintaining consistency where no overrides exist.### Migration from Legacy Implementation

Repositories transitioning from the legacy `.github/copilot-instructions.md` approach should:

1. **Remove** the `.github/copilot-instructions.md` file
2. **Create** the new folder structure under `.github/` with `instructions/`, `prompts/`, and `chatmodes/` directories
3. **Distribute** existing content appropriately:
   - Universal organizational patterns → Will be provided via organization sync to `instructions/organization/`
   - Repository-specific context → `instructions/repository/main.instructions.md`
   - Language-specific patterns → Appropriate `instructions/repository/{Language}/` folders
   - Prompt templates → `prompts/repository/` (if any existed)
   - Chat configurations → `chatmodes/repository/` (if any existed)

Note: Organization files for all Copilot configuration types will be automatically synchronized from the organization level, so manual creation is not necessary.

## Implementation Guidelines

### For AI Agents

When processing files in repositories using this architecture, AI agents should:

1. **Verify architecture compliance**: Confirm the absence of `.github/copilot-instructions.md` and presence of the three-folder Copilot structure under `.github/`
2. **Identify target file characteristics**: Note file extension, folder context, and repository segment
3. **Load configurations in precedence order**:
   - Apply instruction hierarchy from organization main through repository context
   - Use repository-specific prompts and chat modes when available, falling back to organization defaults
4. **Apply precedence rules**: Later-loaded configurations override earlier ones when conflicts exist
5. **Document patterns**: Record new patterns in appropriate files for future enhancement
6. **Validate changes**: Ensure modifications align with the architectural specification

### For Repository Contributors

Repository maintainers should understand:

- **Organization files**: These are automatically synchronized across all Copilot configuration types and should not be manually edited
- **Repository files**: These are manually maintained and contain project-specific customizations for instructions, prompts, and chat modes
- **Precedence hierarchy**: Repository files can override organization files for all configuration types
- **Pattern documentation**: New patterns should be documented promptly in the appropriate scope (organization patterns should be proposed to the organization's central repository)

## File Format Specifications

### Instructions Format
All instruction files must follow this format:

```yaml
---
applyTo: "<glob pattern targeting specific file types>"
description: "Brief, actionable description of the instruction's purpose"
---
```

Content structure: Context lead, Goal, Execution steps, Behavior rules, Output format, Error handling, Definitions

### Prompts Format
Prompt files should follow established GitHub Copilot prompt conventions with clear context and expected outcomes.

### Chat Modes Format
Chat mode files should define conversation contexts, specialized behaviors, and interaction patterns following GitHub Copilot chat mode specifications.

## Design Principles

This architecture is guided by the following principles:

- **Comprehensive Copilot management**: Unified approach to managing all GitHub Copilot configuration files (instructions, prompts, chat modes)
- **Separation of concerns**: Organization-level configurations are managed centrally while repository-specific configurations remain under local control
- **Automation-friendly**: The organization tier supports automated synchronization across all configuration types without affecting repository-managed content
- **Hierarchical precedence**: More specific configurations override general ones, enabling customization while maintaining consistency
- **Convention over configuration**: Established patterns and cross-platform compatibility are prioritized
- **Enterprise integration**: Designed for GitHub enterprise environments with proper authentication, logging, and CI/CD integration
- **Scalable governance**: Organization-wide consistency without sacrificing project-specific flexibility

## Terminology

| Term | Definition |
| --- | --- |
| **Organization instructions** | Organization-managed instruction files under `.github/instructions/organization/` that provide consistent patterns across all managed repositories |
| **Repository instructions** | Repository-managed instruction files under `.github/instructions/repository/` that contain project-specific overrides and extensions |
| **Organization prompts** | Organization-managed prompt templates under `.github/prompts/organization/` that provide standard reusable patterns |
| **Repository prompts** | Repository-managed prompt templates under `.github/prompts/repository/` that contain project-specific prompt customizations |
| **Organization chat modes** | Organization-managed conversation contexts under `.github/chatmodes/organization/` that define standard AI interaction patterns |
| **Repository chat modes** | Repository-managed conversation contexts under `.github/chatmodes/repository/` that define project-specific AI behaviors |
| **Main instructions** | The primary `main.instructions.md` file at the root of organization or repository instruction folders containing core guidelines for that scope |
| **Language instructions** | Language or technology-specific instructions contained within `{Language}/` subfolders |
| **Context instructions** | Specialized instructions for specific file types, folders, or scenarios (e.g., `tests.instructions.md`, `workflows.instructions.md`) |
| **Precedence hierarchy** | The evaluation order where more specific configuration files override more general ones across all Copilot file types |
| **Automatic synchronization** | The process by which organization files are updated from a central source to target repositories for all Copilot configuration types |
| **Managed repository** | A repository that receives automated synchronization based on organizational criteria (custom properties, naming patterns, etc.) |
