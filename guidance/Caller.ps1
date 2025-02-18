function Invoke-Function4 {
    [CmdletBinding()]
    param()
    'In: ' + $MyInvocation.InvocationName
    $caller = (Get-PSCallStack)[1].Command
    'Caller: ' + $caller
}

function Invoke-Function3 {
    [CmdletBinding()]
    param()
    'In: ' + $MyInvocation.InvocationName
    $caller = (Get-PSCallStack)[1].Command
    'Caller: ' + $caller
    Invoke-Function4
}

function Invoke-Function2 {
    [CmdletBinding()]
    param()
    'In: ' + $MyInvocation.InvocationName
    $caller = (Get-PSCallStack)[1].Command
    'Caller: ' + $caller
    Invoke-Function3
}

function Invoke-Function1 {
    [CmdletBinding()]
    param()
    'In: ' + $MyInvocation.InvocationName
    Get-PSCallStack
    $caller = (Get-PSCallStack)[1].Command
    'Caller: ' + $caller
    Invoke-Function2
}

# Test the functions
Invoke-Function1
