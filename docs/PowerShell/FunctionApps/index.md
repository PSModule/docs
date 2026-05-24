# PowerShell-based Function Apps

## What it is

Azure Function Apps are a serverless compute service that runs event-driven code without requiring dedicated infrastructure. PSModule function apps are written in PowerShell and deployed to Azure, responding to events such as HTTP requests, timers, or Azure service messages. See the [Azure Functions documentation](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview).

## Why we care

Serverless PowerShell functions extend automation into cloud-native, event-driven scenarios that traditional scripts and pipelines cannot cover alone. They enable lightweight, always-on integrations — such as GitHub App webhooks, scheduled maintenance tasks, and API bridges — to run reliably without managing servers or paying for idle compute.

## How we do it

PSModule function apps are built from the [Template-FunctionApp](https://github.com/PSModule/Template-FunctionApp) repository template, which wires up the [Process-FunctionApp](https://github.com/PSModule/Process-FunctionApp) reusable workflow for automated build, test, and Azure deployment. The `AZURE_CREDENTIALS` secret provides the service principal for deployment, and PR labels control versioning the same way they do for modules. The `RepoType: FunctionApp` custom property integrates each repository with organization-wide tooling.

## What we have delivered

<!-- FUNCTIONAPP_LIST_START -->

<table>
    <tr>
        <th width="10%">Name</th>
        <th width="80%">Description</th>
        <th width="10%">Version</th>
    </tr>
    <tr>
        <td><a href="https://github.com/PSModule/GitHubApp/">GitHubApp</a></td>
        <td>
            A GitHub app running on Azure Function App
            <br>
            <a href="https://github.com/PSModule/GitHubApp/issues"><img src="https://img.shields.io/github/issues-raw/PSModule/GitHubApp?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIElzc3VlczwvdGl0bGU+PHBhdGggZD0iTTggOS41YTEuNSAxLjUgMCAxIDAgMC0zIDEuNSAxLjUgMCAwIDAgMCAzWiIgZmlsbD0iIzg0OEQ5NyIvPjxwYXRoIGQ9Ik04IDBhOCA4IDAgMSAxIDAgMTZBOCA4IDAgMCAxIDggMFpNMS41IDhhNi41IDYuNSAwIDEgMCAxMyAwIDYuNSA2LjUgMCAwIDAtMTMgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4=" alt="GitHub Issues"></a>
            <a href="https://github.com/PSModule/GitHubApp/pulls"><img src="https://img.shields.io/github/issues-pr-raw/PSModule/GitHubApp?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFB1bGwgUmVxdWVzdHM8L3RpdGxlPjxwYXRoIGQ9Ik0xLjUgMy4yNWEyLjI1IDIuMjUgMCAxIDEgMyAyLjEyMnY1LjI1NmEyLjI1MSAyLjI1MSAwIDEgMS0xLjUgMFY1LjM3MkEyLjI1IDIuMjUgMCAwIDEgMS41IDMuMjVabTUuNjc3LS4xNzdMOS41NzMuNjc3QS4yNS4yNSAwIDAgMSAxMCAuODU0VjIuNWgxQTIuNSAyLjUgMCAwIDEgMTMuNSA1djUuNjI4YTIuMjUxIDIuMjUxIDAgMSAxLTEuNSAwVjVhMSAxIDAgMCAwLTEtMWgtMXYxLjY0NmEuMjUuMjUgMCAwIDEtLjQyNy4xNzdMNy4xNzcgMy40MjdhLjI1LjI1IDAgMCAxIDAtLjM1NFpNMy43NSAyLjVhLjc1Ljc1IDAgMSAwIDAgMS41Ljc1Ljc1IDAgMCAwIDAtMS41Wm0wIDkuNWEuNzUuNzUgMCAxIDAgMCAxLjUuNzUuNzUgMCAwIDAgMC0xLjVabTguMjUuNzVhLjc1Ljc1IDAgMSAwIDEuNSAwIC43NS43NSAwIDAgMC0xLjUgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4NCg==" alt="GitHub Pull Requests"></a>
            <a href="https://github.com/PSModule/GitHubApp/stargazers"><img src="https://img.shields.io/github/stars/PSModule/GitHubApp?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFN0YXJzPC90aXRsZT48cGF0aCBkPSJNOCAuMjVhLjc1Ljc1IDAgMCAxIC42NzMuNDE4bDEuODgyIDMuODE1IDQuMjEuNjEyYS43NS43NSAwIDAgMSAuNDE2IDEuMjc5bC0zLjA0NiAyLjk3LjcxOSA0LjE5MmEuNzUxLjc1MSAwIDAgMS0xLjA4OC43OTFMOCAxMi4zNDdsLTMuNzY2IDEuOThhLjc1Ljc1IDAgMCAxLTEuMDg4LS43OWwuNzItNC4xOTRMLjgxOCA2LjM3NGEuNzUuNzUgMCAwIDEgLjQxNi0xLjI4bDQuMjEtLjYxMUw3LjMyNy42NjhBLjc1Ljc1IDAgMCAxIDggLjI1Wm0wIDIuNDQ1TDYuNjE1IDUuNWEuNzUuNzUgMCAwIDEtLjU2NC40MWwtMy4wOTcuNDUgMi4yNCAyLjE4NGEuNzUuNzUgMCAwIDEgLjIxNi42NjRsLS41MjggMy4wODQgMi43NjktMS40NTZhLjc1Ljc1IDAgMCAxIC42OTggMGwyLjc3IDEuNDU2LS41My0zLjA4NGEuNzUuNzUgMCAwIDEgLjIxNi0uNjY0bDIuMjQtMi4xODMtMy4wOTYtLjQ1YS43NS43NSAwIDAgMS0uNTY0LS40MUw4IDIuNjk0WiIgZmlsbD0iIzg0OEQ5NyIvPjwvc3ZnPg==" alt="GitHub Stars"></a>
            <a href="https://github.com/PSModule/GitHubApp/watchers"><img src="https://img.shields.io/github/watchers/PSModule/GitHubApp?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIFRhZ3M8L3RpdGxlPjxwYXRoIGQ9Ik04IDJjMS45ODEgMCAzLjY3MS45OTIgNC45MzMgMi4wNzggMS4yNyAxLjA5MSAyLjE4NyAyLjM0NSAyLjYzNyAzLjAyM2ExLjYyIDEuNjIgMCAwIDEgMCAxLjc5OGMtLjQ1LjY3OC0xLjM2NyAxLjkzMi0yLjYzNyAzLjAyM0MxMS42NyAxMy4wMDggOS45ODEgMTQgOCAxNGMtMS45ODEgMC0zLjY3MS0uOTkyLTQuOTMzLTIuMDc4QzEuNzk3IDEwLjgzLjg4IDkuNTc2LjQzIDguODk4YTEuNjIgMS42MiAwIDAgMSAwLTEuNzk4Yy40NS0uNjc3IDEuMzY3LTEuOTMxIDIuNjM3LTMuMDIyQzQuMzMgMi45OTIgNi4wMTkgMiA4IDJaTTEuNjc5IDcuOTMyYS4xMi4xMiAwIDAgMCAwIC4xMzZjLjQxMS42MjIgMS4yNDEgMS43NSAyLjM2NiAyLjcxN0M1LjE3NiAxMS43NTggNi41MjcgMTIuNSA4IDEyLjVjMS40NzMgMCAyLjgyNS0uNzQyIDMuOTU1LTEuNzE1IDEuMTI0LS45NjcgMS45NTQtMi4wOTYgMi4zNjYtMi43MTdhLjEyLjEyIDAgMCAwIDAtLjEzNmMtLjQxMi0uNjIxLTEuMjQyLTEuNzUtMi4zNjYtMi43MTdDMTAuODI0IDQuMjQyIDkuNDczIDMuNSA4IDMuNWMtMS40NzMgMC0yLjgyNS43NDItMy45NTUgMS43MTUtMS4xMjQuOTY3LTEuOTU0IDIuMDk2LTIuMzY2IDIuNzE3Wk04IDEwYTIgMiAwIDEgMS0uMDAxLTMuOTk5QTIgMiAwIDAgMSA4IDEwWiIgZmlsbD0iIzg0OEQ5NyIvPjwvc3ZnPg==" alt="GitHub Watchers"></a>
            <a href="https://github.com/PSModule/GitHubApp/forks"><img src="https://img.shields.io/github/forks/PSModule/GitHubApp?style=flat-square&label=&labelColor=rgba(0%2C%200%2C%200%2C%200)&color=rgba(0%2C%200%2C%200%2C%200)&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAxNiAxNiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViIEZvcmtzPC90aXRsZT48cGF0aCBkPSJNNSA1LjM3MnYuODc4YzAgLjQxNC4zMzYuNzUuNzUuNzVoNC41YS43NS43NSAwIDAgMCAuNzUtLjc1di0uODc4YTIuMjUgMi4yNSAwIDEgMSAxLjUgMHYuODc4YTIuMjUgMi4yNSAwIDAgMS0yLjI1IDIuMjVoLTEuNXYyLjEyOGEyLjI1MSAyLjI1MSAwIDEgMS0xLjUgMFY4LjVoLTEuNUEyLjI1IDIuMjUgMCAwIDEgMy41IDYuMjV2LS44NzhhMi4yNSAyLjI1IDAgMSAxIDEuNSAwWk01IDMuMjVhLjc1Ljc1IDAgMSAwLTEuNSAwIC43NS43NSAwIDAgMCAxLjUgMFptNi43NS43NWEuNzUuNzUgMCAxIDAgMC0xLjUuNzUuNzUgMCAwIDAgMCAxLjVabS0zIDguNzVhLjc1Ljc1IDAgMSAwLTEuNSAwIC43NS43NSAwIDAgMCAxLjUgMFoiIGZpbGw9IiM4NDhEOTciLz48L3N2Zz4=" alt="GitHub Forks"></a>
        </td>
        <td>
            <a href="https://github.com/PSModule/GitHubApp/releases/latest"><img src="https://img.shields.io/github/v/release/PSModule/GitHubApp?style=flat-square&logo=github&logoColor=a0a0a0&label=&labelColor=505050&color=blue" alt="GitHub release (with filter)"></a>
        </td>
    </tr>
</table>

<!-- FUNCTIONAPP_LIST_END -->
