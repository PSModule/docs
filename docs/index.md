---
hide:
  - navigation
---

# A GitHub & PowerShell development framework

We empower PowerShell-savvy developers to effortlessly transform their ideas into impactful solutions.
Our approach centers around a development framework that allows developers to focus on delivering value through their code.
By leveraging the GitHub platform and PowerShell, we aim to automate the repetitive tasks, enabling developers — whether as consumers or contributors
 — to concentrate on coding without distractions.

## Supported Platforms

This development framework is built to serve the needs of modern developers and environments. We prioritize supporting the latest Long-Term Servicing
([LTS](Dictionary/index.md#lts){data-preview}) version of PowerShell to ensure that we can leverage the most recent features and capabilities, keeping our framework aligned with the demands
of today’s development landscape. We assume most of the users of this framework work on modern platforms and have access to the latest versions of
PowerShell or seek to use it to develop solutions intended to run on modern systems, like GitHub Actions, Azure Functions on a developer machine.

### The Trade-Off: Not Supporting Windows PowerShell

We’ve made a deliberate choice not to actively persure to support the older Windows PowerShell (5.1) version, as it limits our ability to use the
newest PowerShell features. Where its low effort to support Windows PowerShell, we will do so, but we will not actively develop modules for it.
While we recognize that some users may still rely on Windows PowerShell 5.1, they can run tools developed in this framework by installing
PowerShell 7 alongside it or on remote systems. This decision ensures that this framework can focus on delivering new features for modern development
without being constrained by legacy technology, which would otherwise require significant effort to develop and maintain, even if it is available in
the newer versions of PowerShell.

## Products and projects we focus on

Our framework is dedicated to advancing the tools and processes that empower modern development and operations teams, with a specific focus on GitHub
as our primary toolstack. We concentrate on the following key areas:

- [PowerShell Modules](PowerShell/Modules/index.md)
- [Function Apps](PowerShell/FunctionApps/index.md)
- [GitHub Actions](GitHubActions/index.md)
