# Module types

Most PSModule modules fall into one of a few archetypes. The general rules in
[PowerShell module standard](Standards.md) and [Naming](../Standard/Naming.md) always apply; this
page adds the conventions that are specific to a module's type so that modules of the same kind feel
the same to use.

Two archetypes have enough shared shape to standardize:

- **Integration (API) modules** wrap an external service's REST or GraphQL API.
- **Data modules** convert or manage a data format or in-memory structure.

A module can be both (for example, an integration module that also exposes conversion helpers).
Apply each relevant section.

## Integration (API) modules

Integration modules are the PowerShell face of an external service. `GitHub` and the
service-client modules such as `Anthropic`, `OpenAI`, `Bluesky`, and `Domeneshop` are integration
modules.

### Command naming maps to the resource, not the HTTP method

Name commands after the resource and the intent, using approved verbs. Never name a command after
the HTTP method or the endpoint path. Map REST methods to verbs:

| REST method | PowerShell verb | Example |
| ----------- | --------------- | ------- |
| `GET` | `Get-` | `Get-GitHubRepository` |
| `POST` (create) | `New-` / `Add-` | `New-GitHubRepository` |
| `PUT` / `PATCH` (update) | `Set-` / `Update-` | `Set-GitHubRepository` |
| `DELETE` | `Remove-` | `Remove-GitHubRepository` |
| Non-CRUD action | Approved verb for the intent | `Invoke-`, `Start-`, `Stop-`, `Enable-`, … |

Prefix the noun with the service's term of art (`GitHubRepository`, not `Repository`). See
[integration command naming](../Standard/Naming.md#integration-commands-and-rest-methods).

### Transport stays private

Public functions accept resolved inputs and typed objects; private helpers own the concrete
`Invoke-RestMethod` / GraphQL / HTTP calls. This is the Dependency Inversion rule from
[Standards](Standards.md#solid-applied) applied to the network boundary.

### Use Context for user and module settings

Integration modules persist state with the [`Context`](https://github.com/PSModule/Context) module
rather than inventing bespoke storage. Two kinds of state are both standard:

- **User settings and secrets** — accounts, tokens, sessions, and per-user configuration. Store these
  in a per-user context. `Context` encrypts secrets at rest (via `Sodium`), so a user can resume work
  without reconfiguring or logging in again when the service supports session refresh.
- **Module settings** — module-wide defaults, endpoints, and feature flags that are not tied to a
  single user. Store these in a module-scoped context.

Persisting both through `Context` gives every integration module the same, discoverable settings
model, and keeps secrets out of source, logs, and plain files.

## Data modules

Data modules convert between representations or manage an in-memory structure. `Hashtable` is the
reference shape; `Base64`, `Json`, `Lua`, `Hcl`, `Sodium`, and `Uri` follow the same pattern.

### The neutral object is the pivot

Every conversion goes through the neutral PowerShell object model
(`[PSCustomObject]` / `[hashtable]` / `[PSObject]`). `ConvertFrom-<Format>` parses a
format-specific representation *into* an object; `ConvertTo-<Format>` renders an object *into* the
format. Converting through the object as a common pivot means any format interoperates with any
other, instead of writing a direct converter for every pair.

Always ship **both** directions so data can round-trip between the format and the object model.

### Verb vocabulary

| Verb pattern | Purpose |
| ------------ | ------- |
| `ConvertFrom-<Format>` | Format-specific text/representation → `[PSCustomObject]` / `[hashtable]` |
| `ConvertTo-<Format>` | Object → format-specific text/representation |
| `Import-<Noun>` | Read from a file or store into objects |
| `Export-<Noun>` | Write objects to a file or store |
| `Format-<Noun>` | Produce a normalized or pretty rendering |
| `Merge-<Noun>` | Combine two structures |
| `Compare-<Noun>` | Diff two structures |
| `Test-<Noun>` | Validate a value or structure |
| `Remove-<Noun>Entry` | Remove elements by criteria |

The `Hashtable` module demonstrates the full set: `ConvertFrom-Hashtable`, `ConvertTo-Hashtable`,
`Import-Hashtable`, `Export-Hashtable`, `Format-Hashtable`, `Merge-Hashtable`, and
`Remove-HashtableEntry`. See [data conversion and I/O verbs](../Standard/Naming.md#data-conversion-and-io-verbs).

## Where this connects

- [Naming](../Standard/Naming.md) — the concrete verb rules for both types.
- [PowerShell module standard](Standards.md) — layout, private functions, and the mandatory context parameter.
- [Repository Defaults](Repository-Defaults.md) — repository files, README shape, and agent onboarding.
