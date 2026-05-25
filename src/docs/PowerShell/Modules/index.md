# PowerShell Modules

A PowerShell module is a distributable package of functions, cmdlets, and scripts built to be shared and reused across environments. Modules are published to and installed from the [PowerShell Gallery](https://www.powershellgallery.com/), the official repository for PowerShell packages. See the [official PowerShell modules documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules).

Modules are the primary unit of reusable automation in the PowerShell ecosystem. Packaging logic into versioned, tested, and published modules keeps pipelines maintainable and composable — any team or workflow can consume shared functions without copying code. Strong module conventions make the public API surface explicit, so breaking changes are intentional and versioned correctly through SemVer.

## Getting started

PSModule provides a standardized framework based on the [Template-PSModule](https://github.com/new?template_name=Template-PSModule&template_owner=PSModule) repository template. All modules follow a consistent directory layout, naming convention, and coding style. The [Process-PSModule](https://github.com/PSModule/Process-PSModule) reusable workflow automates building, testing, and publishing to the PowerShell Gallery. Version increments are driven by PR labels (`Major`, `Minor`, `Patch`, `Prerelease`), and the `RepoType: Module` custom property integrates each repository with organization-wide tooling.

- **[Standards](Standards.md)** — Repository layout, naming, style, parameter design, comment-based help, and SOLID applied to PowerShell modules.
- **[Test Specification](Test-Specification.md)** — How we write Pester tests: structure, hierarchy, and naming conventions.
- **[Versioning](Versioning.md)** — How changes to the public interface determine the SemVer version bump.

## What we have delivered

<!-- MODULE_LIST_START -->

<!-- MODULE_LIST_END -->
