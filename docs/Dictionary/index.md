# Dictionary

Welcome to the PSModule Dictionary - a comprehensive glossary of terms, concepts, and technologies used throughout our projects and documentation.

## Quick Reference

Common terms you might encounter:
- [API](#api) - Application Programming Interface
- [Azure](#azure) - Microsoft's cloud platform
- [CI/CD](#cicd) - Continuous Integration/Continuous Deployment
- [Cmdlet](#cmdlet) - PowerShell command
- [Git](#git) - Version control system
- [GitHub](#github) - Code hosting platform
- [LTS](#lts) - Long-Term Servicing
- [MkDocs](#mkdocs) - Documentation generator
- [Module](#module) - PowerShell package
- [Pipeline](#pipeline) - Automated process chain
- [PowerShell](#powershell) - Task automation framework
- [Repository](#repository) - Code storage location
- [Workflow](#workflow) - Automated process series

## Overview

This dictionary serves as a reference for developers, contributors, and users to understand the terminology and concepts used in PSModule projects. Each entry includes clear definitions, usage examples, and related links where applicable.

---

## A

### API
Application Programming Interface (API) - A set of protocols, routines, and tools for building software applications. APIs specify how software components should interact and are used when programming graphical user interface (GUI) components.

**Example**: The [GitHub](#github) API allows developers to interact with GitHub repositories, issues, and pull requests programmatically.

### Azure
Microsoft's cloud computing platform that provides a wide range of cloud services, including compute, analytics, storage, and networking.

**Related**: [Azure Functions](#azure-functions), [Azure DevOps](#azure-devops)

### Azure DevOps
A set of development tools and services from Microsoft for software development teams, including version control, build automation, and project management.

### Azure Functions
A serverless compute service that lets you run event-triggered code without having to explicitly provision or manage infrastructure.

---

## B

### Branch
In version control systems like [Git](#git), a branch is a parallel version of a [repository](#repository) that diverges from the main working project.

**Example**: Feature branches are used to develop new features in isolation before merging back to the main branch.

### Build Pipeline
An automated process that compiles, tests, and packages source code into deployable artifacts.

---

## C

### CI/CD
Continuous Integration/Continuous Deployment (CI/CD) - A software development practice where developers regularly merge their code changes into a central repository, after which automated builds and tests are run.

### Cmdlet
A lightweight [PowerShell](#powershell) command that follows the verb-noun naming convention and is designed to perform a specific function.

**Example**: `Get-Process`, `Set-Location`, `New-Item`

### Container
A lightweight, standalone, executable package that includes everything needed to run an application: code, runtime, system tools, libraries, and settings.

---

## D

### DevOps
A set of practices that combines software development (Dev) and IT operations (Ops) to shorten the systems development life cycle and provide continuous delivery.

### Docker
A platform for developing, shipping, and running applications using containerization technology.

---

## G

### Git
A distributed version control system for tracking changes in source code during software development.

### GitHub
A web-based platform for version control and collaboration that lets you and others work together on projects from anywhere.

### GitHub Actions
[GitHub's](#github) built-in [CI/CD](#cicd) platform that allows you to automate your build, test, and deployment [pipeline](#pipeline).

**Example**: Automatically running tests when a [pull request](#pull-request) is created.

---

## L

### LTS
Long-Term Servicing (LTS).
For more info visit: [PowerShell Support Lifecycle](https://learn.microsoft.com/en-us/powershell/scripting/install/powershell-support-lifecycle?view=powershell-7.5)

---

## M

### Markdown
A lightweight markup language with plain text formatting syntax, designed to be converted to HTML and many other formats.

### MkDocs
A fast, simple static site generator that's geared towards building project documentation using [Markdown](#markdown) files.

### Module
In [PowerShell](#powershell), a package that contains PowerShell members, such as [cmdlets](#cmdlet), providers, functions, workflows, variables, and aliases.

---

## P

### Pipeline
A series of automated processes that allow developers and [DevOps](#devops) professionals to reliably and efficiently compile, build, and deploy their code.

### PowerShell
A task automation and configuration management framework from Microsoft, consisting of a command-line shell and the associated scripting language.

### Pull Request
Pull Request (PR) - A method of submitting contributions to a software project where changes are proposed and reviewed before being merged into the main codebase.

---

## R

### Repository
Repository (Repo) - A storage location for software packages, often used in version control systems to store project files and their revision history.

### REST API
An architectural style for designing web services that uses HTTP requests to GET, PUT, POST, and DELETE data.

---

## S

### Semantic Versioning
Semantic Versioning (SemVer) - A versioning scheme that uses a three-part version number: MAJOR.MINOR.PATCH, where each part is incremented based on the type of changes made.

**Example**: Version 1.2.3 where 1 is major, 2 is minor, and 3 is patch.

### Static Site Generator
A tool that generates a full static HTML website based on raw data and a set of templates.

---

## T

### Template
A pre-designed format or structure that can be used as a starting point for creating new files, projects, or configurations.

### Testing
The process of evaluating and verifying that a software application or system meets specified requirements and functions correctly.

---

## V

### Version Control
A system that records changes to a file or set of files over time so that you can recall specific versions later.

### Virtual Environment
An isolated environment that allows you to install packages and dependencies without affecting the global system installation.

---

## W

### Workflow
A series of automated steps or processes that execute in response to specific events or triggers.

**Example**: A [GitHub Actions](#github-actions) workflow that runs tests every time code is pushed to a [repository](#repository).

---

## Y

### YAML
YAML Ain't Markup Language (YAML) - A human-readable data serialization standard commonly used for configuration files and data exchange.

**Example**: [GitHub Actions](#github-actions) workflows are defined using [YAML](#yaml) files.

---

!!! info "Contributing to the Dictionary"
    Found a term that should be added or need to update an existing definition? Please [create an issue](https://github.com/PSModule/docs/issues) or submit a pull request with your suggestions.

!!! tip "Search Functionality"
    Use the search feature in the top navigation to quickly find specific terms and their definitions across the entire documentation site.
