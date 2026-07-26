# Module Bootstrap

A brand-new module often needs several interdependent functions before it is usable at all — for example a TOML module needs `ConvertFrom-Toml`, `ConvertTo-Toml`, `Import-Toml`, and `Export-Toml` together before any of them is meaningful on its own. A single feature PR cannot carry that much scope and still be small and focused, so bootstrap uses one integration branch instead.

## Pattern

1. Cut one long-lived branch from the default branch for the initial release, named for the outcome, e.g. `build-toml-module`.
2. Open one pull request per function (or small group of related functions) targeting that branch instead of `main`. These PRs can land in parallel — there is no strict order between them, unlike a [stacked pull request](https://msxorg.github.io/docs/Ways-of-Working/Branching-and-Merging/#stacked-pull-requests).
3. Once the foundational set of functions is coherent and complete, open the pull request that merges the integration branch into `main`. This becomes the module's first real release.
4. Smaller follow-up features (one more function, a formatter, an alias) can keep targeting the integration branch before it lands, the same way they targeted it during bootstrap.

```mermaid
gitGraph
    commit id: "main"
    branch build-toml-module
    checkout build-toml-module
    commit id: "ConvertFrom-Toml"
    commit id: "ConvertTo-Toml"
    commit id: "Import-Toml / Export-Toml"
    checkout main
    merge build-toml-module id: "first release"
```

## Example

[PSModule/Toml](https://github.com/PSModule/Toml) bootstrapped this way:

| PR | Targets | Contents |
| --- | --- | --- |
| [#15](https://github.com/PSModule/Toml/pull/15) | `main` | `build-toml-module` branch, the foundational `ConvertFrom-Toml`, `ConvertTo-Toml`, `Import-Toml`, `Export-Toml` release |
| [#20](https://github.com/PSModule/Toml/pull/20) | `build-toml-module` | `Format-Toml`, a follow-up feature added before the integration branch merged |

## When to use this

- The module has no usable release yet, and no single function is meaningful without the others.
- Use this only for the initial bootstrap. Once `main` has a first release, ongoing feature work targets `main` directly with ordinary topic branches, or a [stacked pull request](https://msxorg.github.io/docs/Ways-of-Working/Branching-and-Merging/#stacked-pull-requests) when changes genuinely depend on each other.

For the general branching and merge model, see [MSX Branching and Merging](https://msxorg.github.io/docs/Ways-of-Working/Branching-and-Merging/).
