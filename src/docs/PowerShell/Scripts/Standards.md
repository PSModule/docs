# Script Standards

Standards for writing standalone PowerShell scripts in the PSModule ecosystem.

> This page is a stub. Standards will be documented here as conventions stabilise.

## General principles

- Scripts follow the same naming, style, and parameter conventions as module functions. See [Module Standards](../Modules/Standards.md) as the baseline.
- Scripts that grow beyond a single responsibility should be promoted to module functions.
- All scripts must run on PowerShell (cross-platform) — not Windows PowerShell 5.1.
