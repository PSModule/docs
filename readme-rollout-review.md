# README standardization — review log (proposal, nothing applied)

> Status: **DRAFT for your review.** No repository or PR has been modified. Edit the
> "Action" lines where you disagree, then tell me to apply. When applying I will push
> commits to each PR's head branch (not merge).
>
> Scope reviewed: the **55 open** "📖 [Docs]: README pages now use the standard module
> landing-page format" PRs. Excluded: `GitHub#638` and `NerdFonts#85` (already redone
> correctly — used as reference), and `Template-PSModule#24` (the template itself — see Part 1).
>
> Source of truth for the standard: `PSModule/docs` → `src/docs/PowerShell/Modules/Repository-Defaults.md`
> as revised by the **open PR #61** ("Preserve unique content in the README default").

---

## Part 1 — Standard review (standard vs. template)

**UPDATE (round 2): the standard has been revised on the PR #61 branch** to absorb your
directives. Changes committed to `docs/readme-content-standard`:

- **Section renamed `Capabilities` → `Usage`.** The mandatory showcase is now `## Usage`
  (`## Examples` allowed); `## Capabilities` is explicitly disallowed and added to README
  validation. `Repository-Defaults.md`, and the per-repo actions below, use `Usage`.
- **Each repo stands on its own feet.** New sentence: a repo carries its own governance files
  and must not depend on the org `.github` fallback (GitHub only shows it in the web UI; agents
  and tooling do not read it). The README carries no `## Contributing` section; the repo ships a
  self-contained `CONTRIBUTING.md`.
- **Agent onboarding files** are now required and documented: `AGENTS.md` (cross-tool),
  `CLAUDE.md` (`@AGENTS.md` import), `.github/copilot-instructions.md` — all pointing to
  `PSModule/docs` (module why/how/what) and `MSXOrg/docs` (org principles). Added to both
  required-files tables and the Distributor mandatory-file list.
- **Placeholder guard** added: a module that exports any real command is not a placeholder
  (fixes the Hcl/Toml misclassification).
- **Upstream attribution / acknowledgements** kept (already in PR #61) — reaffirmed.
- **Modern PowerShell only** (`PowerShell/index.md`): minimum PowerShell 7.6, tracking current
  and LTS releases; Windows PowerShell 5.1 no longer accommodated.
- **New page `Modules/Module-Types.md`** + naming rules in `Standard/Naming.md`:
  - *Integration (API) modules* — command names map to the resource/intent, REST method → verb
    (`GET`→`Get-`, `POST`→`New-`/`Add-`, `PUT`/`PATCH`→`Set-`/`Update-`, `DELETE`→`Remove-`);
    transport stays private; **use `Context` for both user settings/secrets and module settings**.
  - *Data modules* — `ConvertTo-`/`ConvertFrom-` pivot through `[PSCustomObject]`/`[hashtable]`,
    plus `Format-`/`Import-`/`Export-`/`Merge-`/`Compare-`/`Test-`/`Remove-…Entry`; ship both
    directions. **`Hashtable` is the reference shape.**

Template (`Template-PSModule#24`) still needs the `Capabilities`→`Usage` rename, the
`Get-Help -Name CommandName` → `<Command>` fix, and the agent files — folded into apply.
The standard explicitly exempts the template from the "no `<Command>` placeholder" rule.

**MSXOrg/docs alignment (flagged, not changed).**
`MSXOrg/docs` → `Ways-of-Working/Repository-Standard.md` "README defaults" is already
consistent with the landing-page model. But `Ways-of-Working/Readme-Driven-Context.md` still
lists the heavier section set (Features / Usage / Configuration / Architecture / Contributing /
License). That is org-level guidance for *all* repo types, so it is not wrong, but it reads as
encouraging sections the module standard trims. Recommendation: add a one-line pointer that
PowerShell modules follow the tighter `PSModule/docs` module default. Say the word for a
separate MSXOrg PR.

---

## Universal fixes (apply to every implemented-module PR unless noted)

- **U1 — Add a `## Usage` showcase.** None of the 55 PRs include one. Every implemented module
  needs 1–3 real examples using its actual commands (proposed per repo below). Use the heading
  `## Usage` (not `Capabilities`). Not applicable to the 20 genuine placeholders.
- **U2 — Fix the copy/paste-hostile help line.** Replace `Get-Help <CommandName> -Examples` /
  `'CommandName'` with a real exported command. Affected: **Ast, Base64, Dns,
  Fonts, Json, Jwt, Lua, Markdown, MemoryMappedFile, Net, Object, PowerShellGallery, PublicIP,
  Retry, Uri, Utilities**. (AzureDevOps skipped — see below.)
- **U3 — `Install-Module` → `Install-PSResource`.** Standard mandates PSResourceGet. Affected:
  **ElvUI, PSSemVer**. (AzureDevOps skipped.)
- **U4 — No `## Contributing` section in the README.** Remove the boilerplate `## Contributing`
  the rollout added; instead ensure the repo ships a self-contained `CONTRIBUTING.md` (U6).
- **U5 — Add agent onboarding files.** Each repo needs `AGENTS.md`, `CLAUDE.md` (`@AGENTS.md`
  import), and `.github/copilot-instructions.md` pointing to `PSModule/docs` + `MSXOrg/docs`.
  Best delivered as managed files via Distributor (see issue) rather than 55 hand edits, but the
  standard now requires them.
- **U6 — Ensure `CONTRIBUTING.md` (and the other governance files) exist in each repo** so the
  repo stands on its own — do not rely on the org `.github` fallback. Also a Distributor rollout.

> Scope note: **U5/U6 are repo-file rollouts, not README edits** — they belong to Distributor
> (mandatory file sets), tracked as a follow-up issue, not to the 55 README PRs. The README PRs
> themselves only need U1–U4 plus the per-repo restores below.

---

## Part 2 — Per-repo review

Legend: **RESTORE** = unique content the PR dropped that should come back (kept on the landing
page or relocated to a published home); **CAPABILITIES** = the real commands to feature in the
`## Usage` showcase (U1); **FIX** = standard violations; **DESC** = GitHub description note (flag
only — I will not change descriptions).

### Category A — Genuine placeholders — PR is essentially correct (20)

Main README was raw template; module contains only scaffold stubs (e.g. `Get-PSModuleTest`).
The PR's `## Status` placeholder shape is **correct**. Action for all: **keep as-is**; optional
U4 (drop boilerplate `## Contributing`); DESC is aspirational (describes intended purpose, not
current state) — flagged below, no change.

| Repo | PR | Scaffold cmd | DESC note |
| --- | --- | --- | --- |
| Anthropic | #12 | Get-PSModuleTest | aspirational ("interacting with Anthropic APIs") |
| Bluesky | #15 | Get-PSModuleTest | aspirational; casing "BlueSky" vs repo "Bluesky" |
| Claude | #11 | Test-PSModuleTest | aspirational |
| Context7 | #13 | Get-PSModuleTest | aspirational |
| CurseForge | #36 | *-PSModuleTest (+SomethingElse group) | aspirational |
| DateTime | #15 | Get-PSModuleTest | says "work with DateTime objects" but module is a stub |
| DeepSeek | #15 | Get-PSModuleTest | aspirational |
| Discord | #13 | Get-PSModuleTest | aspirational |
| Domeneshop | #12 | Get-PSModuleTest | aspirational |
| Gemini | #11 | Set-PSModuleTest | aspirational |
| GraphQL | #21 | Get-PSModule | aspirational; grammar "a GraphQL APIs" |
| GZip | #17 | Get-PSModuleTest | says "handles GZip archives" but module is a stub |
| IPv4 | #24 | Test-PSModuleTemplate | says "managing IPv4 data" but module is a stub |
| IPv6 | #13 | Get-PSModuleTest | says "manage IPv6 networking" but module is a stub |
| LinkedIn | #18 | Get-PSModuleTest | aspirational |
| OpenAI | #22 | Test-PSModuleTemplate | aspirational |
| PowerShellDataFile | #18 | Set-PSModuleTest | **WEAK: "for base functions..." — vague/placeholder text** |
| Telemetry | #18 | Get-PSModuleTest | says "managing and registering telemetry" but module is a stub |
| Twitch | #14 | Get-PSModuleTest | aspirational |
| Yaml | #34 | Get-PSModuleTest | says "working with Yaml" but module is a stub (note: a `feature/convert-yaml-functions` branch is building it out) |

### Category B — Misclassified placeholders — change to a landing page (2)

The PR marked these `## Status` (placeholder), but they export **real** commands and (for Hcl)
previously had real usage docs. They must become implemented landing pages.

- **Hcl #7** — cmds `ConvertFrom-Hcl`, `ConvertTo-Hcl`. Old README had real examples (parse
  Terraform locals, parse `.tfvars`, convert object→HCL).
  - **Action:** replace the placeholder notice with the implemented shape.
  - **RESTORE / CAPABILITIES:** showcase parsing a Terraform `locals` block and `ConvertTo-Hcl`.
  - DESC ok ("for working with HCL language").
- **Toml #10** — cmd `ConvertFrom-Toml` (real; note: no `ConvertTo-Toml` yet).
  - **Action:** replace placeholder with landing page; CAPABILITIES: `ConvertFrom-Toml` example.
    If a `ConvertTo-Toml` is planned, the "in-progress" wording is acceptable, but there is a
    working command today, so prefer the implemented shape.
  - DESC ok.

### Category C — Landing pages that over-deleted unique content — restore (23)

Real, human-written content was removed. For each: add a `## Usage` showcase (U1) and restore the
unique bits. Worked examples that only duplicate `Get-Help` may be trimmed, but conceptual/reference
content, prerequisites, auth/setup, operational notes, and attribution must stay.

- **Context #120** (−291) — **highest impact.** Removed the entire conceptual model: "What is a
  `Context`?", "Grouping Contexts into Vaults", directory-structure diagram, the encrypt/store
  walkthrough, and the "Implementation Guide for Module Developers".
  - **RESTORE:** the conceptual overview (What is a Context / Vaults / directory structure) and
    the libsodium/`Sodium` dependency note **on the landing page**. **RELOCATE** the long
    "Implementation Guide" to a published home (`src/functions/public/<Group>/<Group>.md` or
    comment-based help) — do not drop it.
  - **CAPABILITIES:** `Set-Context` / `Get-Context` minimal round-trip.
  - FIX: install line dropped `-TrustRepository`/`-Repository PSGallery` — keep standard form.
- **Markdown #28** (−317) — removed `## Usage` incl. a full document-generation example.
  - RESTORE as **CAPABILITIES:** `Set-MarkdownSection` / `Set-MarkdownTable` /
    `Set-MarkdownCodeBlock` mini example. FIX U2.
- **DynamicParams #35** (−142) — removed Usage (function / DSL / pipeline styles) + `## Links`.
  - CAPABILITIES: `New-DynamicParam`, `New-DynamicParamDictionary`. RESTORE `## Links` if unique.
- **TimeSpan #24** (−113) — removed 5 formatting examples, **`## Supported Time Units`** (unique
  reference), and `## Acknowledgements`.
  - RESTORE: "Supported Time Units" reference + attribution. CAPABILITIES: `Format-TimeSpan`.
- **Sodium #66** (−99) — removed Prerequisites, 4 examples, and **`## Acknowledgements`
  (libsodium upstream attribution)**.
  - RESTORE: libsodium attribution (required) + prerequisites. CAPABILITIES: `New-SodiumKeyPair`,
    `ConvertTo-SodiumSealedBox`/`ConvertFrom-SodiumSealedBox`.
- **Hashtable #30** (−99) — removed Usage (4 examples).
  - CAPABILITIES: `ConvertTo-HashTable`, `Merge-Hashtable`, `Format-Hashtable`.
- **CasingStyle #20** (−96) — removed Usage (3 examples).
  - CAPABILITIES: `ConvertTo-CasingStyle`, `Get-CasingStyle`, `Split-CasingStyle`.
- **Uri #17** (−93) — removed Usage (parse/construct query strings, build URIs); also retitled
  `# URI`→`# Uri`.
  - CAPABILITIES: `New-Uri`, `Get-Uri`, `ConvertTo-UriQueryString`/`ConvertFrom-UriQueryString`.
    FIX U2.
- **PSCredential #21** (−88) — removed Usage (3 examples) + **`## Disclaimer`** (security note —
  important for a credentials module).
  - RESTORE: the Disclaimer/security note. CAPABILITIES: `New-PSCredential`, `Save-PSCredential`,
    `Restore-PSCredential`.
- **Lua #13** (−87) — removed 6 real examples; also regressed real command names in the help
  block to `<CommandName>`.
  - CAPABILITIES: `ConvertTo-Lua` (hashtable→Lua), `ConvertFrom-Lua` (string→object). FIX U2.
- **PSSemVer #44** (−77) — removed Usage (create/compare/increment) + `## Links`.
  - CAPABILITIES: `New-PSSemVer`, `ConvertTo-PSSemVer`. RESTORE `## Links` if unique. **FIX U3
    (uses Install-Module).**
- **PSCustomObject #18** (−73) — removed Usage (compare objects).
  - CAPABILITIES: `Compare-PSCustomObject`.
- **Path #38** (−72) — removed Usage (get/add/remove/repair PATH).
  - CAPABILITIES: `Get-EnvironmentPath`, `Add-EnvironmentPath`, `Repair-EnvironmentPath`.
- **Tls #16** (−72) — removed Usage (4 examples).
  - CAPABILITIES: `Get-TLSConfig`, `Set-TLSConfig`. DESC: says "A module…" not "A PowerShell
    module…" (minor).
- **Fonts #63** (−69) — removed **`## Supported platforms`** (cross-platform notes — unique) +
  Usage.
  - RESTORE: Supported platforms. CAPABILITIES: `Get-Font`, `Install-Font`, `Uninstall-Font`.
    FIX U2.
- **Base64 #23** (−68) — removed `## Module Features` + Prerequisites + Usage.
  - CAPABILITIES: `ConvertTo-Base64`, `ConvertFrom-Base64`, `Test-Base64` (fold "Module
    Features" into the description/showcase). FIX U2.
- **Jwt #32** (−51) — removed `## Commands` (OK — duplicates generated help), Usage, and
  `## Acknowledgements`.
  - RESTORE: check the Acknowledgements for third-party attribution; keep if real. CAPABILITIES:
    `New-Jwt`, `Test-Jwt`, `Get-JwtPayload`. FIX U2.
- **Guid #16** (−50) — removed Usage (test/find GUID).
  - CAPABILITIES: `Test-Guid`, `Search-GUID`.
- **ElvUI #8** (−50) — removed **Prerequisites (PS version, WoW install targeting)** + Usage
  (update/reinstall/target flavor).
  - RESTORE: prerequisites. CAPABILITIES: `Update-ElvUI`, `Install-ElvUI`. **FIX U3 (uses
    Install-Module).**
- **GoogleFonts #238** (−49) — removed Usage (install one/all) + `## Links`.
  - CAPABILITIES: `Install-GoogleFont`, `Get-GoogleFont`. RESTORE `## Links` if unique.
- **Ast #43** (−37) — removed Usage + `## Tools`.
  - RESTORE: check `## Tools` for unique content. CAPABILITIES: `Get-AstFunction`,
    `Get-AstCommand`. FIX U2.
- **PublicIP #33** (−33) — removed Usage (public IP/ISP, MyIP API).
  - CAPABILITIES: `Get-PublicIP`. FIX U2.
- **Admin #41** (−28) — removed Usage (test elevated) + `## Acknowledgements`.
  - CAPABILITIES: `Test-Admin`. RESTORE: check Acknowledgements for real attribution. DESC:
    "working with the admin role" (minor grammar).

### Category D — Scaffold README → landing page; implemented, nothing real lost — add Usage (6)

Main README was raw template (only scaffold boilerplate removed), but the module **is**
implemented. No restore needed; just add a real `## Usage` showcase and fix U2.

- **Json #22** — CAPABILITIES: `Import-Json`, `Export-Json`, `Format-Json`. FIX U2.
- **MemoryMappedFile #14** — CAPABILITIES: `New-MemoryMappedFile`, `Set-MemoryMappedFileContent`,
  `Read-MemoryMappedFileContent`. FIX U2.
- **Dns #20** — CAPABILITIES: `Resolve-DnsHost`. FIX U2. DESC "for managing DNS" is broad for a
  single resolver command (minor).
- **Net #16** — CAPABILITIES: `Get-NetIPConfiguration`. FIX U2. DESC broad vs single command
  (minor).
- **Object #15** — CAPABILITIES: `Remove-Member`. FIX U2. DESC broad vs single command (minor).
- **Retry #19** — CAPABILITIES: `Invoke-Retry`. FIX U2.

### Category E — Stub README expanded to landing page — additive, add Usage (3)

These went from a 1–2 line stub to a proper landing page (an improvement). Just add a `## Usage`
showcase.

- **WoW #34** (was `# Demo`) — CAPABILITIES: `Get-WoWCharacter`, `Get-WoWAddon`,
  `Set-BNetAPIRegion`. (15 commands total.)
- **Utilities #103** (was `# Utils`) — CAPABILITIES: pick 2–3 flagship, e.g. `ConvertTo-Boolean`,
  `Invoke-PruneModule`, `Set-ModuleManifest`. FIX U2. (25 commands.)
- **PowerShellGallery #31** (was 2-line stub) — CAPABILITIES: `Get-PSGalleryAPI`,
  `Show-PowerShellGalleryItem`. FIX U2.

### Category F — Skipped (2)

- **AzureDevOps #2** — **SKIP (per your call).** Inherited/adopted external module
  (upstream `mehmetseckin/azuredevops-powershell`), default branch `master`, non-standard layout
  (no `src/functions/public/`). You will align it later. No action; removed from U2/U3 lists above.
- **jira-archive** — not part of the rollout (no README PR) and inherited/unmaintained. SKIP.

---

## Part 2b — Module-type conformance (round 2 against `Module-Types.md`)

The new module-type standard is largely **descriptive of existing good practice** — most data
modules already match the `Hashtable` shape, so re-review surfaced no README changes, only a few
code-level follow-ups (tracked as issues, not part of the README PRs):

- **Data modules already conforming** (`ConvertTo`/`ConvertFrom` + `Format`/`Import`/`Export`):
  Hashtable (reference), Base64, Lua, Hcl, Sodium, Uri, CasingStyle, TimeSpan (`Format-TimeSpan`),
  PSSemVer (`ConvertTo-PSSemVer`). `Json` intentionally omits `ConvertFrom/To-Json` (PowerShell
  built-ins cover it) and adds `Import`/`Export`/`Format-Json` — acceptable.
- **Gaps (→ issue, code change, out of README scope):** `Toml` ships only `ConvertFrom-Toml` (no
  `ConvertTo-Toml`) — the standard says ship both directions; `Hashtable` has `ConvertTo-HashTable`
  with inconsistent noun casing vs the other `Hashtable` commands.
- **Integration (API) modules:** the API-client placeholders (Anthropic, OpenAI, Bluesky, …) are
  unimplemented, so nothing to check now; when built they must follow REST→verb naming and use
  `Context` for user + module settings. `Context` itself is the storage reference.

## Convergence

Round 2 (all 55 re-reviewed against the updated standard) produced **no further standard
additions** beyond those in Part 1 — the remaining findings are per-repo actions (already listed)
and three code/infra follow-ups filed as issues. The standard is considered **converged** for this
pass; re-open the loop if applying the changes surfaces a new gap.

---

## Part 3 — Description flags (for your decision — I will NOT change any description)

None are missing. Flagged as "not in line with intent":

- **PowerShellDataFile** — "A PowerShell module for base functions..." — vague placeholder text;
  rewrite to describe the actual intent.
- **Aspirational vs. reality** — these describe working functionality but the module is currently
  a scaffold placeholder: DateTime, GZip, IPv4, IPv6, Telemetry, Yaml (and the API-client
  placeholders Anthropic, Bluesky, Claude, Context7, CurseForge, DeepSeek, Discord, Domeneshop,
  Gemini, GraphQL, LinkedIn, OpenAI, Twitch). Acceptable if you intend them as "purpose" text;
  flagging so you're aware they overstate current state.
- **Minor wording only:** Tls ("A module…" — not "A PowerShell module…"), Uri ("powershell"
  lowercase), Bluesky ("BlueSky" casing), GraphQL ("a GraphQL APIs"), Net/Object/Dns
  (description broader than the single implemented command).

---

## Apply checklist (when you say go)

1. For each README PR: push a commit to its head branch implementing the Action lines above.
2. Every implemented module gets a `## Usage` section (U1) + a real help command (U2). Do not use
   the `## Capabilities` heading.
3. Fix `Install-Module`→`Install-PSResource` on ElvUI, PSSemVer (U3).
4. Restore the flagged unique content (Category B/C) on the landing page or a published home,
   keeping attributions/acknowledgements.
5. Remove any `## Contributing` section the rollout added (U4). Leave the 20 genuine placeholders'
   bodies as-is.
6. Handle Hcl/Toml as implemented modules (landing page + `## Usage`).
7. **Skip AzureDevOps and jira-archive** (inherited; you will align later).
8. Do **not** touch any GitHub repo description.
9. Rollout of the new repo files — `CONTRIBUTING.md` (self-contained), `AGENTS.md`, `CLAUDE.md`,
   `.github/copilot-instructions.md` (U5/U6) — is a **Distributor** job (mandatory file sets),
   tracked as a separate issue; it is not part of the 55 README PR commits.
10. Sync `Template-PSModule#24`: `Capabilities`→`Usage`, `Get-Help -Name CommandName`→`<Command>`,
    and add the agent files.
