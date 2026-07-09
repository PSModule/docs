# PowerShell standards

These standards apply to all PowerShell files across PSModule repositories. They implement the
engineering principles defined in [Principles](https://msxorg.github.io/docs/Ways-of-Working/Principles/) — specifically
*Clean Code*, *Make change easy*, *Shift Left*, and *Build for the modern engineer*.

Each standard states the practice, why it matters to us, and how to apply it.

| Topic | What it covers |
| ----- | -------------- |
| [Code Layout](Code-Layout.md) | Braces, indentation, line length, semicolons, regions |
| [Naming](Naming.md) | Functions, commands, parameters, variables, constants, paths |
| [Function Structure](Function-Structure.md) | CmdletBinding, pipeline design, script structure |
| [Documentation](Documentation.md) | Comment-based help, inline comments |
| [Readability](Readability.md) | Strings, operators, splatting, collections |
| [Control Flow](Control-Flow.md) | If/else, loops, switch |
| [Output and Errors](Output-and-Errors.md) | Streams, output suppression, error handling |
| [Performance](Performance.md) | Collections, filtering, method syntax |
| [Testing](Testing.md) | Pester structure and conventions |
| [Security](Security.md) | Credentials, input validation, ShouldProcess |
