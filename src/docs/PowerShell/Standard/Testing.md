# Testing

**Practice:** Pester tests for every function. Files named `*.Tests.ps1`. Structure: `Describe` → `Context` → `It`. Use `BeforeAll`/`AfterAll` for setup.

**Why:** Tests are the executable specification (*TDD*). They catch regressions before production (*Shift Left*) and give contributors confidence to refactor. Consistent naming lets CI, pre-commit hooks, and editors discover tests automatically (*Testable locally*, *Validatable in PRs*).

**How:**

```powershell
# Good
Describe 'Get-UserAccount' {
    Context 'When user exists' {
        It 'Should return user object' {
            $result = Get-UserAccount -UserId '123'
            $result | Should -Not -BeNullOrEmpty
            $result.UserId | Should -Be '123'
        }
    }

    Context 'When user does not exist' {
        It 'Should throw' {
            { Get-UserAccount -UserId '999' } | Should -Throw
        }
    }
}
```
