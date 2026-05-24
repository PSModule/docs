# PowerShell Scripts

A PowerShell script is a standalone `.ps1` file that executes a sequence of commands to accomplish a task. Unlike modules, scripts are not packaged for distribution — they run directly in a shell, pipeline, or CI/CD runner. See the [official PowerShell scripting documentation](https://learn.microsoft.com/en-us/powershell/scripting/overview).

Scripts are the fastest path from intent to automation. In GitHub Actions and DevOps pipelines, scripts orchestrate deployment steps, invoke APIs, transform data, and bridge gaps between purpose-built tools. Consistent, well-structured scripts are easier to review, test, and debug — reducing the risk of pipeline failures and onboarding friction for new contributors.

## Getting started

PSModule scripts follow a set of conventions covering naming, parameter design, error handling, and output format. These standards ensure scripts behave predictably in both pipeline and interactive contexts.

- **[Standards](Standards.md)** — How we write, name, and structure PowerShell scripts.

## What we have delivered

> No standalone script repositories are maintained yet. Scripts are typically co-located with the module or workflow that uses them.
