# PowerShell Function Test Specification

## Overview

This document defines the structure and guidelines for writing Pester tests for PowerShell functions. The goal is to ensure consistency and comprehensive test coverage while maintaining clarity.

## Pester version

Lock the test framework to a **major version** so a new Pester major cannot be adopted silently and break every suite at once. Declare it as the first line of each `*.Tests.ps1` file:

```powershell
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '6.0.0'; MaximumVersion = '6.*' }
```

- `ModuleVersion` + `MaximumVersion` accept any Pester `6.x`, so routine minor and patch updates flow in without a change here — only a new major requires a deliberate, reviewed bump.
- The `MaximumVersion = '6.*'` wildcard locks to the major without a sentinel version; PowerShell enforces the range at discovery time.
- The [Invoke-Pester](https://github.com/PSModule/Invoke-Pester) action installs a matching `6.x`, so the requirement and the installed version stay aligned.
- Pinning module identity with a `GUID` is a separate, stricter supply-chain control — omit it for the default major-lock; add it only when identity assurance is required.

## Test Structure

Each function is tested within a structured Pester `Describe` block that follows this hierarchy:

### 1. Module-Level `Describe`

- The outermost `Describe` block corresponds to the module.
- The module name is derived from the prefix of the function name's noun part.

### 2. Function-Level `Describe`

- Each function within the module gets its own `Describe` block.
- Named using the full function name.

### 3. Use Case `Context`

- Each use case is grouped within a `Context` block.
- The context name starts with the function name followed by a descriptive test case identifier.
  - Example: `Get-Uri - simple usage`
  - Example: `Get-Uri - Pipeline usage`
  - Example: `Get-Uri - ParameterSet: Detailed`

### 4. Functional `It` Statements

- Each `It` block tests a specific aspect of the function's behavior.
- The name follows the format: `FunctionName - <expected behavior>`
  - Example: `Get-Uri - gets the URI object when provided a string`
  - Example: `Get-Uri - returns $null when input is empty`
  - Example: `Get-Uri - throws error on invalid input`

### 5. Test Guidelines

- **No Mocks**: We do not use mocks in tests.
- **Real Inputs**: Tests should use actual inputs and expected outputs.
- **Comprehensive Coverage**: All function functionality, including edge cases, must be tested.

## Example Test Structure

```pwsh
Describe 'Uri' {
    Describe 'Get-Uri' {
        Context 'Get-Uri - simple usage' {
            It 'Get-Uri - gets the URI object when provided a string' {
                $result = Get-Uri -InputString 'https://example.com'
                $result | Should -BeOfType [System.Uri]
            }
        }

        Context 'Get-Uri - Pipeline usage' {
            It 'Get-Uri - processes input from the pipeline' {
                $result = 'https://example.com' | Get-Uri
                $result | Should -BeOfType [System.Uri]
            }
        }
    }
}
```

This ensures our tests are structured, maintainable, and adhere to best practices.
