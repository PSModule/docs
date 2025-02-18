function Invoke-Function4 {
    [CmdletBinding()]
    param()
    'In: ' + $MyInvocation.InvocationName
    Get-PSCallStack
}

function Invoke-Function3 {
    [CmdletBinding()]
    param()
    'In: ' + $MyInvocation.InvocationName
    Get-PSCallStack
    Invoke-Function4
}

function Invoke-Function2 {
    [CmdletBinding()]
    param()
    'In: ' + $MyInvocation.InvocationName
    Get-PSCallStack
    Invoke-Function3
}

function Invoke-Function1 {
    [CmdletBinding()]
    param()
    "In: " + $MyInvocation.InvocationName
    Get-PSCallStack
    Invoke-Function2
}

# Test the functions
Invoke-Function1
