# PowerShell-based Function Apps

Azure Function Apps are a serverless compute service that runs event-driven code without requiring dedicated infrastructure. PSModule function apps are written in PowerShell and deployed to Azure, responding to events such as HTTP requests, timers, or Azure service messages. See the [Azure Functions documentation](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview).

Serverless PowerShell functions extend automation into cloud-native, event-driven scenarios that traditional scripts and pipelines cannot cover alone. They enable lightweight, always-on integrations — such as GitHub App webhooks, scheduled maintenance tasks, and API bridges — to run reliably without managing servers or paying for idle compute.

## Getting started

PSModule function apps are built from the [Template-FunctionApp](https://github.com/PSModule/Template-FunctionApp) repository template, which wires up the [Process-FunctionApp](https://github.com/PSModule/Process-FunctionApp) reusable workflow for automated build, test, and Azure deployment. The `AZURE_CREDENTIALS` secret provides the service principal for deployment, and PR labels control versioning the same way they do for modules. The `RepoType: FunctionApp` custom property integrates each repository with organization-wide tooling.

## What we have delivered

<!-- FUNCTIONAPP_LIST_START -->

<!-- FUNCTIONAPP_LIST_END -->
