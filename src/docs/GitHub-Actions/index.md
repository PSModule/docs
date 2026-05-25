# GitHub Actions

GitHub Actions is a CI/CD and workflow automation platform built into GitHub. Actions are reusable steps that compose into pipelines triggered by repository events — pushes, pull requests, issue comments, schedules, and more. PSModule's actions are composite actions written in PowerShell and published to the [GitHub Marketplace](https://github.com/marketplace?&verification=&query=publisher%3Apsmodule). See the [official GitHub Actions documentation](https://docs.github.com/en/actions).

Reusable actions are the foundation of a scalable, consistent DevOps practice on GitHub. Encapsulating common tasks — building, testing, releasing, and deploying PowerShell artifacts — into shared, versioned actions eliminates duplication and enforces best practices automatically across every repository in the organization. A single improvement to a shared action benefits all consumers immediately.

## Getting started

PSModule actions are built from the [Template-Action](https://github.com/PSModule/Template-Action) repository template, which sets up automated workflows for testing and publishing to the GitHub Marketplace. Each action is a composite action backed by PowerShell logic, following consistent input/output conventions. PR labels control versioning, and the `RepoType: Action` custom property integrates each repository with organization-wide tooling.

## What we have delivered

<!-- ACTION_LIST_START -->

<!-- ACTION_LIST_END -->
