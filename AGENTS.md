# Agents

This repository holds the source for the [PSModule](https://psmodule.io) documentation, published at [psmodule.io/docs](https://psmodule.io/docs). Everything an agent needs to work here is documentation — read it the same way a new contributor would.

## Start here

1. Read this file, then the [README](README.md) for what this repository is and how it builds.
2. Read the [PSModule documentation](https://psmodule.io/docs) for the framework's why, how, and what — its standards, conventions, and style guides. The source for those pages lives under `src/docs/` in this repository.
3. Read the [MSX documentation](https://msxorg.github.io/docs) for the organization-level principles and ways of working that sit above any single repository.

## Working in this repository

- Documentation pages live under `src/docs/`; the published site navigation is defined in `src/zensical.toml`. Add a new page to both.
- The PowerShell standards and style guides under `src/docs/` are the source of truth for content changes — follow the page you are changing.
- Keep each page the single source of truth: link to the canonical page instead of restating its content elsewhere.

## The rule

This file points; it never defines. Standards and process live in the documentation and are referenced by their canonical location — never copied here.
