# GitHub Actions

PSModule provides a set of reusable GitHub Actions built with the [PSModule framework](https://github.com/PSModule/PSModule) and published to the [GitHub Marketplace](https://github.com/marketplace?&verification=&query=publisher%3Apsmodule).

## Getting started

<details>
   <summary>About</summary>

A composite action is a reusable action that is made up of one or more steps. Composite actions can be used to encapsulate common tasks or workflows that can be reused across multiple repositories. They are a great way to share code and best practices with the community, and they can help to streamline the development process by providing a consistent way to perform common tasks.
We have created a framework that automates the process of creating, testing, and publishing PowerShell based GitHub Actions to the GitHub Marketplace. This framework is designed to make it easy for developers to create and share their GitHub Actions with the community.

</details>

<details>
   <summary>How we do it in PSModule</summary>

Projects based on the `Template-Action` repository template will automatically have the necessary workflows and configurations set up to automate the process of creating, testing, and deploying PowerShell based GitHub Actions. This includes workflows for building, testing, and deploying the action, as well as a configuration file for setting up the action's metadata and dependencies.
Using custom properties we set `RepoType` to `Action`.
We use branch policies to control the flow of changes to the `main` branch, and we use labels to control the versioning of the action when a pull request is merged.

</details>

<details>
   <summary>Create a new project</summary>

1. Create a repository based on the template [Template-Action](https://github.com/PSModule/Template-Action).

</details>

## GitHub Actions on the GitHub Marketplace

<!-- ACTION_LIST_START -->

<table>
    <tr>
        <th width="10%">Name</th>
        <th width="80%">Description</th>
        <th width="10%">Version</th>
    </tr>
</table>

<!-- ACTION_LIST_END -->
