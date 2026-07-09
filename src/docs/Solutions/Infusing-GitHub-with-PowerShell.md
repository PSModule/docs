# Infusing GitHub with PowerShell

*Infuse GitHub with PowerShell* is the [mission](https://msxorg.github.io/docs/Ways-of-Working/Goal-Setting/) of the PSModule organization. GitHub gives mainstream languages — JavaScript, Python, .NET, Go — a rich, built-in developer experience: dependency updates, security scanning, package registries, setup actions, and a first-party API client. PowerShell is a first-class automation language, but on the GitHub platform it is treated as a second-class citizen. This initiative closes that gap.

We do it two ways: by **building** the PowerShell-native tooling the ecosystem is missing, and by **advocating** for the platform to support PowerShell where only the vendor can. This page describes the collection we have built and the capabilities we still want to make PowerShell-native.

## What we have

The collection is two halves of one framework:

- A **collection of reusable PowerShell modules** — batteries the language should arguably have shipped with, plus clients for the services we automate against.
- A **set of GitHub Actions** that automate the full PowerShell module delivery lifecycle — the DevOps functionality the ecosystem is missing.

The live, auto-generated inventories are on the [PowerShell Modules](../PowerShell/Modules/index.md) and [GitHub Actions](../GitHub-Actions/index.md) pages. The sections below group that inventory into themes so the shape of the collection is easy to see.

### The module collection

| Category | What it covers | Representative modules |
| --- | --- | --- |
| Language and type helpers | The "batteries" that arguably belong in PowerShell itself | [Utilities](https://github.com/PSModule/Utilities), [Object](https://github.com/PSModule/Object), [Hashtable](https://github.com/PSModule/Hashtable), [DateTime](https://github.com/PSModule/DateTime), [Guid](https://github.com/PSModule/Guid), [PSSemVer](https://github.com/PSModule/PSSemVer), [Retry](https://github.com/PSModule/Retry), [Ast](https://github.com/PSModule/Ast) |
| Data formats and encoding | Serialization and conversion | [Json](https://github.com/PSModule/Json), [Yaml](https://github.com/PSModule/Yaml), [Toml](https://github.com/PSModule/Toml), [Hcl](https://github.com/PSModule/Hcl), [Markdown](https://github.com/PSModule/Markdown), [Base64](https://github.com/PSModule/Base64), [GZip](https://github.com/PSModule/GZip) |
| Networking | Network primitives brought to PowerShell | [Net](https://github.com/PSModule/Net), [Dns](https://github.com/PSModule/Dns), [IPv4](https://github.com/PSModule/IPv4), [IPv6](https://github.com/PSModule/IPv6), [Uri](https://github.com/PSModule/Uri), [Tls](https://github.com/PSModule/Tls), [PublicIP](https://github.com/PSModule/PublicIP) |
| Security and secrets | Credentials, tokens, and configuration | [Context](https://github.com/PSModule/Context), [Sodium](https://github.com/PSModule/Sodium), [Jwt](https://github.com/PSModule/Jwt), [PSCredential](https://github.com/PSModule/PSCredential) |
| API and SaaS clients | PowerShell wrappers over service APIs | [GitHub](https://github.com/PSModule/GitHub), [Confluence](https://github.com/PSModule/Confluence), [Discord](https://github.com/PSModule/Discord), [Bluesky](https://github.com/PSModule/Bluesky), [PowerShellGallery](https://github.com/PSModule/PowerShellGallery) |
| AI and LLM clients | Provider clients for AI services | [OpenAI](https://github.com/PSModule/OpenAI), [Anthropic](https://github.com/PSModule/Anthropic), [Gemini](https://github.com/PSModule/Gemini), [DeepSeek](https://github.com/PSModule/DeepSeek) |
| System and platform | Operating-system and environment integration | [Admin](https://github.com/PSModule/Admin), [Path](https://github.com/PSModule/Path), [Fonts](https://github.com/PSModule/Fonts), [MemoryMappedFile](https://github.com/PSModule/MemoryMappedFile) |

### The automation collection

The framework decomposes the delivery lifecycle into small, single-purpose, SHA-pinnable GitHub Actions, orchestrated by [Process-PSModule](https://github.com/PSModule/Process-PSModule). The naming grammar is deliberate: `Verb-Noun` repositories are Actions, single-`Noun` repositories are modules.

| Stage | What it does | Actions |
| --- | --- | --- |
| Prepare | Set up the runner and resolve settings | [Initialize-PSModule](https://github.com/PSModule/Initialize-PSModule), [Install-PowerShell](https://github.com/PSModule/Install-PowerShell), [Install-PSModuleHelpers](https://github.com/PSModule/Install-PSModuleHelpers), [Get-PSModuleSettings](https://github.com/PSModule/Get-PSModuleSettings) |
| Build | Compile the module and its manifest | [Build-PSModule](https://github.com/PSModule/Build-PSModule), [Resolve-PSModuleVersion](https://github.com/PSModule/Resolve-PSModuleVersion) |
| Test and lint | Static analysis, tests, coverage | [Invoke-ScriptAnalyzer](https://github.com/PSModule/Invoke-ScriptAnalyzer), [Invoke-Pester](https://github.com/PSModule/Invoke-Pester), [Test-PSModule](https://github.com/PSModule/Test-PSModule), [Get-PesterTestResults](https://github.com/PSModule/Get-PesterTestResults), [Get-PesterCodeCoverage](https://github.com/PSModule/Get-PesterCodeCoverage) |
| Document | Generate documentation | [Document-PSModule](https://github.com/PSModule/Document-PSModule) |
| Publish and release | Ship to the Gallery and cut releases | [Publish-PSModule](https://github.com/PSModule/Publish-PSModule), [Release-GHRepository](https://github.com/PSModule/Release-GHRepository) |
| Glue | Scripting and platform plumbing | [GitHub-Script](https://github.com/PSModule/GitHub-Script), [Get-IssueFormData](https://github.com/PSModule/Get-IssueFormData), [Download-CIArtifact](https://github.com/PSModule/Download-CIArtifact) |

## What we hope to do with it

The goal is **parity**: every capability GitHub gives a mainstream language should have a PowerShell-native equivalent, so that a PowerShell author on GitHub gets the same "it just works" experience as a Node or Python author. Concretely, we want:

- The **safe, smart choice to be the default choice** — pinned actions, tested releases, and SemVer versioning happen without the author thinking about them.
- Gaps that we *can* close with tooling to be closed by a PSModule module or action.
- Gaps that only the *platform* can close (Dependabot, CodeQL, the Advisory Database, trusted publishing) to be raised with GitHub, Microsoft, and the PowerShell Gallery — with a working interim built on public APIs wherever possible.

## GitHub capabilities to PowerShell-infuse

GitHub's language-aware features assume a mainstream package ecosystem. Where PowerShell is missing, these are the capabilities we most want to infuse.

### Dependency updates — Dependabot

[Dependabot](https://docs.github.com/en/code-security/dependabot) keeps dependencies current for npm, pip, NuGet, Cargo, Go modules, Maven, Composer, and [many more](https://docs.github.com/en/code-security/dependabot/ecosystems-supported-by-dependabot/supported-ecosystems-and-repositories) — but it **does not recognize PowerShell's native package management**. Although modules are distributed as NuGet packages on the PowerShell Gallery, the `nuget` ecosystem only understands .NET project files; it does not read a module manifest's `RequiredModules`, `#Requires -Module` statements, or a [PSResourceGet](https://learn.microsoft.com/en-us/powershell/module/microsoftpowershell.psresourceget/) lockfile.

We already benefit from Dependabot for the `github-actions` ecosystem (keeping SHA-pinned action references current). The gap is **PowerShell module dependencies themselves**: they are invisible to Dependabot today. The ask is a native `powershell`/`psgallery` ecosystem; the interim is a manifest-aware updater that opens the same kind of pull request.

### Linting and testing — beyond super-linter and MegaLinter

[Super-linter](https://github.com/super-linter/super-linter) and [MegaLinter](https://megalinter.io/) bundle dozens of linters — including PSScriptAnalyzer — behind one action. That is useful, but generic: PowerShell is one checkbox among many, with no opinion about how a *module* should be built or tested.

PSModule instead offers a focused, PowerShell-first pair — a custom "linter" via [Invoke-ScriptAnalyzer](https://github.com/PSModule/Invoke-ScriptAnalyzer) plus [Invoke-Pester](https://github.com/PSModule/Invoke-Pester) — with opinionated rules and a test specification tuned for modules. The infuse opportunity is to emit findings as [SARIF](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/uploading-a-sarif-file-to-github) so PowerShell analysis appears as native code-scanning alerts in the Security tab, the same place CodeQL findings land for supported languages.

### The GitHub API client — Octokit for PowerShell

GitHub ships [Octokit](https://github.com/octokit) as a first-party SDK for JavaScript, .NET, and Ruby, but not PowerShell. The [GitHub](https://github.com/PSModule/GitHub) module is the community "Octokit for PowerShell" — a REST and GraphQL client that works interactively and in automation, with authentication that spans PATs, GitHub App installations, and Actions OIDC. It is the backbone every other PSModule action builds on.

### Scripting in workflows — github-script, PowerShell flavor

[`actions/github-script`](https://github.com/actions/github-script) lets you run inline JavaScript with a pre-authenticated `github` client — but only JavaScript. [GitHub-Script](https://github.com/PSModule/GitHub-Script) is the PowerShell-flavored equivalent: run inline PowerShell in a workflow with the [GitHub](https://github.com/PSModule/GitHub) module already imported and authenticated. It turns any workflow step into first-class PowerShell automation without a bespoke script file.

## Other gaps we see

Beyond the four above, these platform capabilities are language-aware for mainstream ecosystems and still need a PowerShell story.

- **Version-selecting setup action.** GitHub maintains `setup-node`, `setup-python`, `setup-dotnet`, and friends, but there is no official `setup-powershell`. [Install-PowerShell](https://github.com/PSModule/Install-PowerShell) fills this — the opportunity is to reach the same quality and add built-in module caching.
- **Dependency graph and SBOM.** Manifests for supported ecosystems are parsed automatically into the dependency graph and SBOM export; module manifests are not. The [Dependency Submission API](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/using-the-dependency-submission-api) can submit PowerShell dependencies so they show up in the graph.
- **Security advisories.** The [GitHub Advisory Database](https://docs.github.com/en/code-security/security-advisories/working-with-global-security-advisories-from-the-github-advisory-database/about-the-github-advisory-database) covers npm, NuGet, pip, RubyGems, and more, but has no PowerShell Gallery ecosystem — so a vulnerable module version never raises a Dependabot alert. This one needs platform advocacy.
- **Static analysis.** [CodeQL](https://codeql.github.com/docs/codeql-overview/supported-languages-and-frameworks/) supports ten languages; PowerShell is not one of them. PSScriptAnalyzer is the practical substitute, surfaced through code scanning via SARIF (see above).
- **Trusted publishing.** PyPI, RubyGems, crates.io, npm, and NuGet.org now support OIDC-based trusted publishing from Actions — no long-lived secrets. The PowerShell Gallery still requires an API key, which [Publish-PSModule](https://github.com/PSModule/Publish-PSModule) uses today. OIDC trusted publishing to the Gallery is a platform ask.
- **Package registry.** [GitHub Packages](https://docs.github.com/en/packages) hosts npm, NuGet, Maven, RubyGems, and containers, but has no first-class PowerShell registry (a NuGet v3 feed works with caveats). A native PowerShell registry would let teams host private modules alongside their other packages.
- **Build provenance.** [Artifact attestations](https://docs.github.com/en/actions/security-guides/using-artifact-attestations-to-establish-provenance-for-builds) and npm provenance give consumers a verifiable supply-chain signal. Attaching attestations to published modules — and surfacing them on the Gallery — would extend that guarantee to PowerShell.
- **Dependency caching in Actions.** `setup-node` and `setup-python` cache downloaded packages out of the box; there is no equivalent for installed modules. Caching PSResourceGet installs keyed on the manifest would speed up every run.

## Parity with other language ecosystems

The table summarizes where the platform is language-aware for mainstream ecosystems, where PowerShell stands, and which PSModule piece closes the gap or what the platform still needs to provide.

| Capability | Native for mainstream languages | PowerShell today | PSModule piece or gap |
| --- | --- | --- | --- |
| Version-selecting setup action | `setup-node`, `setup-python`, `setup-dotnet` | No official `setup-powershell` | [Install-PowerShell](https://github.com/PSModule/Install-PowerShell) |
| In-workflow scripting client | `actions/github-script` (JS only) | None | [GitHub-Script](https://github.com/PSModule/GitHub-Script) |
| First-party API SDK | Octokit (JS, .NET, Ruby) | None official | [GitHub](https://github.com/PSModule/GitHub) |
| Lint and test in CI | Bundled linters, framework runners | PSScriptAnalyzer, Pester | [Invoke-ScriptAnalyzer](https://github.com/PSModule/Invoke-ScriptAnalyzer), [Invoke-Pester](https://github.com/PSModule/Invoke-Pester) |
| Static analysis / code scanning | CodeQL for 10 languages | Not supported | Gap: PSScriptAnalyzer to SARIF |
| Dependency updates | Dependabot (npm, pip, NuGet, …) | Not for `.psd1` / PSGallery | Gap: native ecosystem; interim updater |
| Dependency graph / SBOM | Manifests parsed automatically | Manifests not parsed | Gap: Dependency Submission API |
| Security advisories | GHSA for npm, NuGet, pip, … | No PowerShell ecosystem | Gap: platform advocacy |
| Publish from CI | OIDC trusted publishing | API key only | [Publish-PSModule](https://github.com/PSModule/Publish-PSModule); gap: OIDC |
| Package registry | GitHub Packages (npm, NuGet, …) | No first-class registry | Gap: PowerShell registry |
| Release automation | release-drafter, semantic-release | Label-driven | [Release-GHRepository](https://github.com/PSModule/Release-GHRepository) |

## Where to take this

The gaps split into two kinds of work, matching how we operate:

- **Build it.** Where a public API exists, we close the gap ourselves with a module or action: SARIF upload from PSScriptAnalyzer, dependency submission for module manifests, module caching for `Install-PowerShell`, and attestations on published modules.
- **Advocate for it.** Where only the vendor can deliver — a native Dependabot ecosystem, a PowerShell Gallery entry in the Advisory Database, CodeQL support, OIDC trusted publishing, and a first-class package registry — we raise it with GitHub, Microsoft, and the Gallery, and ship a working interim in the meantime.

New parity gaps and concrete bets are tracked as [initiatives](https://msxorg.github.io/docs/Ways-of-Working/Goal-Setting/) under the mission.
