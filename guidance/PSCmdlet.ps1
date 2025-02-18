function Invoke-Function4 {
    [CmdletBinding()]
    param()
    '4: ' + $MyInvocation.InvocationName
    $PSCmdlet | ConvertTo-Json
}

function Invoke-Function3 {
    [CmdletBinding()]
    param()
    '3: ' + $MyInvocation.InvocationName
    $PSCmdlet | ConvertTo-Json
    Invoke-Function4
}

function Invoke-Function2 {
    [CmdletBinding()]
    param()
    '2: ' + $MyInvocation.InvocationName
    $PSCmdlet | ConvertTo-Json
    Invoke-Function3
}

function Invoke-Function1 {
    [CmdletBinding()]
    param()
    '1: ' + $MyInvocation.InvocationName
    $PSCmdlet | ConvertTo-Json
    Invoke-Function2
}

# Test the functions
Invoke-Function1
