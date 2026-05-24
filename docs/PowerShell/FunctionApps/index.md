# Function Apps

PSModule Function Apps are PowerShell based Azure Functions that run serverless, event-driven code. They are built with the [PSModule framework](https://github.com/PSModule/PSModule) and follow a consistent layout, naming, and versioning convention.

## Getting started

<details>
   <summary>About</summary>

A PowerShell based Azure Function App is a serverless compute service that enables you to run event-driven code without having to manage the infrastructure. Azure Functions are ideal for processing data, integrating systems, and building simple APIs or microservices. They can be triggered by a variety of events, such as HTTP requests, timers, or messages from Azure services like Azure Storage, Event Grid, or Service Bus.
We have created a framework that automates the process of creating, testing, and deploying PowerShell based Azure Function Apps to Azure. This framework is designed to make it easy for developers to create and deploy their Azure Function Apps without having to worry about the underlying infrastructure.

</details>

<details>
   <summary>How we do it in PSModule</summary>

Projects based on the `Template-FunctionApp` repository template will automatically have the necessary workflows and configurations set up to automate the process of creating, testing, and deploying PowerShell based Azure Function Apps to Azure. This includes workflows for building, testing, and deploying the function app, as well as a configuration file for setting up the function app's metadata and dependencies.
Using custom properties we set `RepoType` to `FunctionApp`.
We use branch policies to control the flow of changes to the `main` branch, and we use labels to control the versioning of the module when a pull request is merged.

</details>

<details>
   <summary>Create a new project</summary>

1. Create a repository based on the template [Template-FunctionApp](https://github.com/PSModule/Template-FunctionApp). The module will by default use the name of the repository.
1. Create a repository or organization secret called `AZURE_CREDENTIALS`, holding the credentials for the Azure service principal.
1. Configure the settings you want for the repository including a branch policy for the `main` branch.
1. On a topic branch:
   1. develop the code you want to add to your function app.
   1. delete the parts you do not need.
   1. update the tests in the `tests` folder.
1. Create a PR. Add a label to the PR depending on what you want to do.
    - `Major` - Will create a major release (vX.0.0) when merged. If specified with "Prerelease", a major version will be created using the prerelease tag (vX.0.0-\<branchName\>).
    - `Minor` - Will create a minor release (vX.Y.0) when merged. If specified with "Prerelease", a minor version will be created using the prerelease tag (vX.Y.0-\<branchName\>).
    - `Patch` - Will create a minor release (vX.Y.Z) when merged. If specified with "Prerelease", a minor version will be created using the prerelease tag (vX.Y.Z-\<branchName\>). A patch version bump is the default if nothing is specified for the PR.
    - `Prerelease` - CI will create a prerelease of the module using the branch name as a prerelease tag in the version. This will create both a repository release and a prerelease version of the module on the PowerShell Gallery.
1. Once the PR is created, the [Process-FunctionApp](https://github.com/PSModule/Process-FunctionApp) workflow will trigger.
1. When the PR is merged, a release will be created and the function app will be deployed to Azure with a stable version based on the version bump indicator the PR was was labeled with. Prerelease tags will be cleaned up on the repository.

</details>

## Function Apps we maintain

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
