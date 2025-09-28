# PSModule Instruction Architecture

This document describes the Copilot instruction system used across PSModule repositories to provide consistent guidance to AI coding agents.

## Overview

The PSModule ecosystem uses a structured instruction system that guides AI agents in making consistent changes across multiple repositories while allowing for project-specific customization.

## Architecture

### Two-Tier Hierarchy

The instruction system follows a two-tier hierarchy:

```
.github/instructions/
├── framework/                    # Generic, reusable patterns (automation-managed)
│   ├── main.instructions.md     # Universal cross-language guidelines
│   └── {Language}/              # Language-specific framework patterns
│       ├── main.instructions.md
│       ├── tests.instructions.md
│       └── classes.instructions.md
└── repo/                        # Project-specific patterns (manually curated)
    ├── main.instructions.md     # Repository context and rules
    └── {Language}/              # Project-specific language patterns
        └── main.instructions.md
```

### Content Hierarchy and Precedence

Instructions are applied in precedence order, with more specific rules taking precedence:

1. **Framework instructions** provide foundation and universal patterns
2. **Repository instructions** override and extend framework instructions
3. **Language-specific instructions** inherit from their main instruction files
4. **Repository language instructions** take precedence over framework language instructions

## Usage

### For AI Agents

When editing files, agents should:

1. Locate the file you intend to edit and note its extension and repository segment (code, docs, workflows, etc.)
2. Load all matching framework instructions under `/.github/instructions/framework/`, then load the corresponding repository overrides under `/.github/instructions/repo/`
3. Respect the precedence order: framework → framework language → repository → repository language, applying the most specific rule last
4. If gaps appear, record them as enhancements and avoid unverified assumptions
5. After completing work, confirm that updates continue to fit the documented architecture and that any new patterns are captured in the appropriate instruction file

### For Contributors

- Always consult both framework and repo instructions before editing
- Follow the `applyTo` glob when determining relevancy; do not assume coverage
- Document new patterns promptly so they can be promoted to framework guidance when reusable

## File Format

All instruction files must follow this format:

```yaml
---
applyTo: "<glob pattern targeting specific file types>"
description: "Brief, actionable description of the instruction's purpose"
---
```

Content structure: Context lead, Goal, Execution steps, Behavior rules, Output format, Error handling, Definitions

## Key Principles

- Honor convention over configuration, context awareness, pipeline friendliness, and cross-platform compatibility
- Maintain strong typing, clear documentation, robust authentication abstractions, and enterprise GitHub support throughout the ecosystem
- Expect tight coupling with GitHub Actions, PSModule authentication helpers, structured logging (`LogGroup`), and cross-repo dependencies
- Validate changes against both local tooling and CI automation

## Definitions

| Term | Description |
| --- | --- |
| **Framework instructions** | Canonical, reusable rules under `/.github/instructions/framework/` that apply across PSModule repositories |
| **Repository instructions** | Overrides located under `/.github/instructions/repo/` describing project-specific expectations |
| **Precedence order** | Evaluation order where the most specific applicable instruction file governs the final decision |
