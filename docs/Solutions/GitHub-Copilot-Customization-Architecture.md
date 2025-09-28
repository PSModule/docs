# GitHub Copilot Customization Architecture

This specification documents a scalable GitHub Copilot customization architecture designed to provide consistent guidance, prompts, and chat modes
across multiple repositories in community organizations and enterprises.The architecture addresses the challenge of managing GitHub Copilot
configurations at scale by implementing a multi-tier approach that balances centralized governance with project-specific flexibility. This system
enables organizations to:

- Maintain consistent AI assistance patterns across all repositories
- Implement enterprise-wide compliance and governance requirements
- Adopt community frameworks while preserving organizational customizations
- Allow repository-level overrides for project-specific needs
- Automate synchronization of shared configurations while protecting local customizations

The architecture replaces GitHub Copilot's single-file approach with a structured three-tier system that manages instructions, prompts, and chat modes
through a hierarchical precedence model.

## Purpose and Context

Modern software organizations require a structured system for managing GitHub Copilot configuration files that enables AI agents to make consistent
changes across multiple repositories while allowing for project-specific customization.

Due to the absence of native organization-wide configuration support in GitHub that provides a single location for common Copilot configurations, this
architecture implements a scalable multi-tier approach for managing:

- **Instructions**: Guidance and patterns for AI agents
- **Prompts**: Reusable prompt templates and patterns
- **Chat modes**: Specialized conversation contexts and behaviors

This architecture serves multiple organizational contexts:
- **Enterprises**: Large organizations needing centralized AI assistance standards across teams and projects
- **Enterprise Adoption**: Enterprises adopting community frameworks while maintaining their own customizations
- **Multi-Division Enterprises**: Large organizations with division-specific requirements within enterprise standards
- **Community Organizations**: Open source projects and community frameworks requiring consistent standards across repositories

## Architecture Specification

### Three-Tier Management System

Each Copilot configuration type follows a flexible three-tier management approach:

- **Enterprise tier**: Enterprise-specific customizations and governance (highest precedence layer)
- **Organization tier**: Community or framework-level patterns (middle layer)
- **Repository tier**: Project-specific overrides (base layer)

This design allows organizations to:
- Enforce enterprise-wide governance and compliance requirements
- Adopt community standards and frameworks as a foundation
- Allow repository-level customization within enterprise and organizational constraints

### Design Decision: Legacy File Elimination

The file `.github/copilot-instructions.md` is not supported in this architecture. This specification replaces the simplified single-file approach with
 a structured system that manages all GitHub Copilot configuration files through multi-tier management.

### Automation and Synchronization

The multi-tier Copilot files can be automatically synchronized from different sources:

**Enterprise Tier Synchronization:**
- Source: Enterprise's central configuration repository
- Target: Enterprise repositories (optional, based on enterprise policy)
- Content: Enterprise-specific customizations, compliance requirements, security patterns

**Organization Tier Synchronization:**
- Source: Community framework or organization's base repository
- Target: All repositories adopting the framework
- Content: Universal patterns and base standards

**Repository Tier Management:**
- Source: Local repository maintenance
- Target: Current repository only
- Content: Project-specific overrides and customizations

The synchronization process applies to all Copilot configuration types:
- **Updates**: Files under `organization/` and `enterprise/` folders are managed by automation
- **Preserves**: All files under `repository/` folders are never modified by sync mechanisms
- **Flexibility**: Organizations can choose which tiers to implement and their synchronization criteria

### Folder Structure Specification

The `.github/` folder contains three Copilot configuration directories, each supporting the three-tier structure:

```
.github/
├── instructions/                         # AI agent guidance and patterns
│   ├── enterprise/                       # Enterprise-managed customizations (automated sync, optional)
│   │   ├── main.instructions.md          # Enterprise-wide guidelines and compliance
│   │   └── {Language}/                   # Enterprise language-specific patterns
│   │       ├── main.instructions.md      # Enterprise style guides (e.g., C# enterprise standards)
│   │       └── {context}.instructions.md # Enterprise context requirements
│   ├── organization/                     # Community/framework-managed patterns (automated sync)
│   │   ├── main.instructions.md          # Core framework guidelines
│   │   └── {Language}/                   # Language-specific framework patterns
│   │       ├── main.instructions.md      # Style guide and core instructions
│   │       └── {context}.instructions.md # Specialized context instructions
│   └── repository/                       # Repository-managed overrides (manual)
│       ├── main.instructions.md          # Repository context and specific rules
│       └── {Language}/                   # Repository-specific language customizations
│           ├── main.instructions.md      # Repository language patterns
│           └── {context}.instructions.md # Repository context overrides
├── prompts/                              # Reusable prompt templates
│   ├── enterprise/                       # Enterprise-specific prompts (automated sync, optional)
│   │   └── {prompt-files}                # Enterprise-customized prompt templates
│   ├── organization/                     # Community/framework prompts (automated sync)
│   │   └── {prompt-files}                # Standard framework prompt templates
│   └── repository/                       # Repository-specific prompts (manual)
│       └── {prompt-files}                # Project-specific prompt templates
└── chatmodes/                            # Specialized conversation contexts
    ├── enterprise/                       # Enterprise-specific chat modes (automated sync, optional)
    │   └── {chatmode-files}              # Enterprise-customized chat modes
    ├── organization/                     # Community/framework chat modes (automated sync)
    │   └── {chatmode-files}              # Standard framework chat modes
    └── repository/                       # Repository-specific chat modes (manual)
        └── {chatmode-files}              # Project-specific chat modes
```

### File Structure Specification

#### File Structure Specification

| Configuration Type | Tier | File Path | Management | Description |
|-------------------|------|-----------|------------|-------------|
| **Instructions** | Enterprise | `instructions/enterprise/main.instructions.md` | Enterprise-Managed, Optional | Enterprise-wide guidelines, compliance requirements, and governance |
| **Instructions** | Enterprise | `instructions/enterprise/{Language}/main.instructions.md` | Enterprise-Managed, Optional | Enterprise-specific language standards (e.g., "C# Enterprise coding standards") |
| **Instructions** | Enterprise | `instructions/enterprise/{Language}/{context}.instructions.md` | Enterprise-Managed, Optional | Enterprise-specific patterns for compliance, security, or organizational needs |
| **Instructions** | Organization | `instructions/organization/main.instructions.md` | Community/Framework-Managed | Universal framework guidelines and architectural principles |
| **Instructions** | Organization | `instructions/organization/{Language}/main.instructions.md` | Community/Framework-Managed | Community standard style guides and language-specific patterns |
| **Instructions** | Organization | `instructions/organization/{Language}/{context}.instructions.md` | Community/Framework-Managed | Framework-specific patterns for specialized scenarios |
| **Instructions** | Repository | `instructions/repository/main.instructions.md` | Repository-Managed | Repository-specific context, technology stack, and project rules |
| **Instructions** | Repository | `instructions/repository/{Language}/main.instructions.md` | Repository-Managed | Project-specific language overrides and patterns |
| **Instructions** | Repository | `instructions/repository/{Language}/{context}.instructions.md` | Repository-Managed | Most specific project-based overrides |
| **Prompts** | Enterprise | `prompts/enterprise/{name}.prompt.md` | Enterprise-Managed, Optional | Enterprise-customized prompt templates incorporating company standards |
| **Prompts** | Organization | `prompts/organization/{name}.prompt.md` | Community/Framework-Managed | Standard community prompt templates for common development scenarios |
| **Prompts** | Repository | `prompts/repository/{name}.prompt.md` | Repository-Managed | Project-specific prompt templates tailored to repository requirements |
| **Chat Modes** | Enterprise | `chatmodes/enterprise/{name}.chatmode.md` | Enterprise-Managed, Optional | Enterprise-specific conversation contexts incorporating company culture and standards |
| **Chat Modes** | Organization | `chatmodes/organization/{name}.chatmode.md` | Community/Framework-Managed | Standard conversation contexts and AI behaviors from the community |
| **Chat Modes** | Repository | `chatmodes/repository/{name}.chatmode.md` | Repository-Managed | Project-specific conversation contexts and behaviors |

#### Context File Examples
For instructions, context-specific files may include:
- File extension patterns: `tests.instructions.md`, `classes.instructions.md`
- Folder-specific patterns: `workflows.instructions.md`, `docs.instructions.md`
- Functional patterns: `api.instructions.md`, `config.instructions.md`, `compliance.instructions.md`

### Precedence Specification

#### Instruction Precedence (Nine-Level Hierarchy)

Instructions are evaluated and applied in hierarchical order, with more specific instructions taking precedence:

1. **Enterprise main instructions** (`instructions/enterprise/main.instructions.md`) - Enterprise-wide governance and compliance
2. **Enterprise language instructions** (`instructions/enterprise/{Language}/main.instructions.md`) - Enterprise language standards
3. **Enterprise context instructions** (`instructions/enterprise/{Language}/{context}.instructions.md`) - Enterprise specialized requirements
4. **Organization main instructions** (`instructions/organization/main.instructions.md`) - Community/framework base patterns
5. **Organization language instructions** (`instructions/organization/{Language}/main.instructions.md`) - Community language-specific patterns
6. **Organization context instructions** (`instructions/organization/{Language}/{context}.instructions.md`) - Community specialized patterns
7. **Repository main instructions** (`instructions/repository/main.instructions.md`) - Project-specific context and overrides
8. **Repository language instructions** (`instructions/repository/{Language}/main.instructions.md`) - Project-specific language patterns
9. **Repository context instructions** (`instructions/repository/{Language}/{context}.instructions.md`) - Project-specific customizations

#### Prompt and Chat Mode Precedence

For prompts and chat modes, the precedence follows the three-tier approach:

- **Enterprise prompts/chat modes**: Provide enterprise-wide governance and mandatory templates (highest precedence)
- **Organization prompts/chat modes**: Provide community standard templates and behaviors (middle precedence)
- **Repository prompts/chat modes**: Provide project-specific customizations (lowest precedence)

When multiple tiers have the same prompt/chat mode, the enterprise tier takes highest precedence, followed by organization tier, then repository tier.

#### Implementation Flexibility

Organizations can choose to implement:
- **Two-tier**: Organization + Repository (skip enterprise tier)
- **Three-tier**: Organization + Enterprise + Repository (full implementation)
- **Enterprise-only**: Enterprise + Repository (for enterprises with internal frameworks)

### Migration from Legacy Implementation

Repositories transitioning from legacy approaches should:

1. **Remove** legacy files (`.github/copilot-instructions.md`)
2. **Create** the new folder structure under `.github/` with `instructions/`, `prompts/`, and `chatmodes/` directories
3. **Distribute** existing content appropriately:
   - Enterprise-specific customizations → `enterprise/` folders (if using enterprise tier)
   - Community framework patterns → Will be provided via organization tier sync
   - Repository-specific context → `repository/main.instructions.md`
   - Language-specific patterns → Appropriate tier `{Language}/` folders
   - Templates and configurations → Appropriate `prompts/` and `chatmodes/` folders

Note: Organization and enterprise files will be automatically synchronized when implemented, so manual creation is typically not necessary.

## Implementation Guidelines

### For AI Agents

When processing files in repositories using this architecture, AI agents should:

1. **Verify architecture compliance**: Confirm absence of legacy files and presence of the multi-tier structure
2. **Identify target file characteristics**: Note file extension, folder context, repository segment, and applicable tiers
3. **Load configurations in precedence order**:
   - Apply the nine-level instruction hierarchy when all tiers are present
   - Use highest precedence prompts and chat modes from available tiers
   - Fall back gracefully when tiers are not implemented
4. **Apply precedence rules**: Later-loaded configurations override earlier ones when conflicts exist
5. **Document patterns**: Record new patterns in the appropriate tier for future enhancement
6. **Validate changes**: Ensure modifications align with the architectural specification and precedence rules

### For Repository Contributors

Repository maintainers should understand:

- **Enterprise files**: Enterprise-managed, automatically synchronized (when implemented), should not be manually edited
- **Organization files**: Community/framework-managed, automatically synchronized, should not be manually edited
- **Repository files**: Manually maintained, contain project-specific customizations for all configuration types
- **Precedence hierarchy**: Enterprise files take highest precedence, followed by organization, then repository files for all configuration types
- **Pattern documentation**: New patterns should be documented in the appropriate tier scope

### For Enterprise Administrators

Enterprise administrators implementing the enterprise tier should:

- **Tier strategy**: Decide whether to implement full three-tier or selective approaches
- **Synchronization setup**: Configure enterprise tier synchronization from enterprise configuration repository
- **Governance policies**: Define what customizations belong in enterprise vs. repository tiers
- **Compliance integration**: Use enterprise tier for compliance, security, and governance requirements
- **Migration planning**: Plan rollout across enterprise repositories with appropriate change management

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
Prompt files should follow established GitHub Copilot prompt conventions with clear context and expected outcomes, including tier identification for
provenance tracking.

### Chat Modes Format
Chat mode files should define conversation contexts, specialized behaviors, and interaction patterns following GitHub Copilot chat mode
specifications, with tier identification for configuration management.

## Design Principles

This architecture is guided by the following principles:

- **Comprehensive Copilot management**: Unified approach to managing all GitHub Copilot configuration files across multiple organizational tiers
- **Flexible tier adoption**: Organizations can implement the tiers that match their governance and complexity needs
- **Separation of concerns**: Each tier manages configurations appropriate to its scope and authority
- **Automation-friendly**: All managed tiers support automated synchronization without affecting repository-controlled content
- **Hierarchical precedence**: Higher precedence tiers (Enterprise) override lower precedence tiers (Organization, Repository), enabling enterprise
  governance while maintaining organizational standards and repository flexibility
- **Enterprise compliance**: Enterprise tier specifically addresses compliance, governance, and enterprise-specific requirements
- **Convention over configuration**: Established patterns and cross-platform compatibility are prioritized across all tiers
- **Scalable governance**: Multi-tier approach enables appropriate governance at each organizational level

## Use Cases

### Community Framework Adoption
- **Enterprise tier**: Not used
- **Organization tier**: Framework maintainers provide base standards
- **Repository tier**: Projects customize for specific needs

### Enterprise with Custom Standards
- **Enterprise tier**: Company-specific standards, compliance requirements
- **Organization tier**: Industry or community best practices
- **Repository tier**: Project-specific customizations

### Large Enterprise with Divisions
- **Enterprise tier**: Corporate-wide governance and compliance
- **Organization tier**: Industry standards
- **Repository tier**: Team and project-specific needs

### Internal Enterprise Framework
- **Enterprise tier**: Internal enterprise framework and standards
- **Organization tier**: Not used
- **Repository tier**: Project-specific customizations
