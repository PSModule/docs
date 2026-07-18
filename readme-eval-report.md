# README rollout — evaluation against the new standard (2026-07-12)

> Snapshot of the **current head** of each of the 55 open landing-page PRs versus the
> standard as revised in PR #61 (`Repository-Defaults.md` + `Module-Types.md` + version policy).
> All 55 PRs are **OPEN** and every head README was re-fetched and confirmed current.
> Nothing has been applied — this is a conformance snapshot. Detailed per-repo fix actions
> live in `readme-rollout-review.md`.

## Summary

| Verdict | Count | Meaning |
| --- | --- | --- |
| PASS | 0 | Fully conforms to the new standard. |
| MINOR | 20 | Genuine placeholder, correct shape; only a boilerplate `## Contributing` to remove. |
| NEEDS CHANGES | 34 | Implemented module missing `## Usage` and/or other fixes. |
| SKIP | 1 | Inherited/unmaintained (AzureDevOps). |

**Headline: 0/55 conform yet** — expected, since the PRs pre-date the standard and have not been applied.

### Violation tallies

- **Missing `## Usage` showcase:** 34 (every implemented module).
- **Has `## Contributing` (remove; ship `CONTRIBUTING.md`):** 55 (all 55).
- **Has `## Capabilities`:** 0 — good, none; `## Usage` just needs adding, no rename on the PRs.
- **Uses `Install-Module` (-> `Install-PSResource`):** 5 — Admin, AzureDevOps, DynamicParams, ElvUI, PSSemVer.
- **Ships `<CommandName>` placeholder:** 17 — Ast, AzureDevOps, base64, Dns, Fonts, Json, Jwt, Lua, Markdown, MemoryMappedFile, Net, Object, PowerShellGallery, PublicIP, Retry, Uri, Utilities.
- **Unfilled `{{ NAME }}`/`{{ DESCRIPTION }}`:** 0 — good, all filled.
- **Wrongly marked placeholder (real commands):** Hcl, Toml.
- **Needs over-deleted content RESTORED:** 23 (see review log for specifics).

## NEEDS CHANGES (34)

| Repo | PR | Class | Findings |
| --- | --- | --- | --- |
| Admin | #41 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); uses Install-Module (-> Install-PSResource); no Install-PSResource; RESTORE over-deleted unique content (see review log) |
| Ast | #43 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| Base64 | #23 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| CasingStyle | #20 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| Context | #120 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| Dns | #20 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| DynamicParams | #35 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); uses Install-Module (-> Install-PSResource); RESTORE over-deleted unique content (see review log) |
| ElvUI | #8 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); uses Install-Module (-> Install-PSResource); RESTORE over-deleted unique content (see review log) |
| Fonts | #63 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| GoogleFonts | #238 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| Guid | #16 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| Hashtable | #30 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| Hcl | #7 | IMPLEMENTED (misclassified placeholder) | wrongly marked placeholder -> make a landing page; missing ## Usage; has ## Contributing (remove; ship CONTRIBUTING.md) |
| Json | #22 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| Jwt | #32 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| Lua | #13 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| Markdown | #28 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| MemoryMappedFile | #14 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| Net | #16 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| Object | #15 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| Path | #38 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| PowerShellGallery | #31 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| PSCredential | #21 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| PSCustomObject | #18 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| PSSemVer | #44 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); uses Install-Module (-> Install-PSResource); RESTORE over-deleted unique content (see review log) |
| PublicIP | #33 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| Retry | #19 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| Sodium | #66 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| TimeSpan | #24 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| Tls | #16 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); RESTORE over-deleted unique content (see review log) |
| Toml | #10 | IMPLEMENTED (misclassified placeholder) | wrongly marked placeholder -> make a landing page; missing ## Usage; has ## Contributing (remove; ship CONTRIBUTING.md) |
| Uri | #17 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command); RESTORE over-deleted unique content (see review log) |
| Utilities | #103 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md); ships <CommandName> placeholder (-> real command) |
| WoW | #34 | IMPLEMENTED | missing ## Usage showcase; has ## Contributing (remove; ship CONTRIBUTING.md) |

## MINOR — placeholders (only drop `## Contributing`) (20)

| Repo | PR | Class | Findings |
| --- | --- | --- | --- |
| Anthropic | #12 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Bluesky | #15 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Claude | #11 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Context7 | #13 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| CurseForge | #36 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| DateTime | #15 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| DeepSeek | #15 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Discord | #13 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Domeneshop | #12 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Gemini | #11 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| GraphQL | #21 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| GZip | #17 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| IPv4 | #24 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| IPv6 | #13 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| LinkedIn | #18 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| OpenAI | #22 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| PowerShellDataFile | #18 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Telemetry | #18 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Twitch | #14 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |
| Yaml | #34 | PLACEHOLDER (scaffold-only) | has ## Contributing (remove; not in placeholder shape) |

## SKIP (1)

| Repo | PR | Class | Findings |
| --- | --- | --- | --- |
| AzureDevOps | #2 | SKIP | — |

## Notes

- **Good news:** no PR uses `## Capabilities` and none have unfilled `{{ }}` tokens, so the
  per-PR work is *adding* `## Usage` + restoring content, not undoing a bad rename.
- **`CONTRIBUTING.md` / agent files (`AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`)**
  are a **Distributor** rollout (mandatory file sets), not part of these 55 README PRs — the PRs
  only need the `## Contributing` *section* removed from the README.
- **Hcl #7 and Toml #10** are marked as placeholders but export real commands — convert to landing pages.
- **AzureDevOps #2** and **jira-archive** are skipped (inherited/unmaintained).
- Detailed restore/Usage proposals per repo: see `readme-rollout-review.md`.

