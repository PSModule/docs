function Set-DefaultParameterValue {
    [CmdletBinding()]
    param (
        [string]$Parameter = 'Default-Parameter'
    )
    Write-Verbose "Set-DefaultParameterValue: Setting Parameter to '$Parameter'"
    Start-Sleep -Seconds 1
    return $Parameter
}

function Step-One {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [int]$InputNumber,

        [string]$Parameter = (Set-DefaultParameterValue -Parameter 'Step-One-Default')
    )
    begin {
        Write-Verbose "Step-One: BEGIN block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
    process {
        Write-Verbose "Step-One: PROCESS block. InputNumber=$InputNumber, Parameter=$Parameter"
        $Output = $InputNumber * 10
        Write-Output $Output
        Start-Sleep -Seconds 1
    }
    end {
        Write-Verbose "Step-One: END block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }

    clean {
        Write-Verbose "Step-One: CLEANUP block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
}

function Step-Two {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [int]$InputNumber,

        [string]$Parameter = (Set-DefaultParameterValue -Parameter 'Step-Two-Default')
    )
    begin {
        Write-Verbose "Step-Two: BEGIN block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
    process {
        Write-Verbose "Step-Two: PROCESS block. InputNumber=$InputNumber, Parameter=$Parameter"
        $Output = $InputNumber + 5
        Write-Output $Output
        Start-Sleep -Seconds 1
    }
    end {
        Write-Verbose "Step-Two: END block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
    clean {
        Write-Verbose "Step-One: CLEANUP block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
}

function Step-Three {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [int]$InputNumber,

        [string]$Parameter = (Set-DefaultParameterValue -Parameter 'Step-Three-Default')
    )
    begin {
        Write-Verbose "Step-Three: BEGIN block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
    process {
        Write-Verbose "Step-Three: PROCESS block. InputNumber=$InputNumber, Parameter=$Parameter"
        $Output = $InputNumber - 2
        Write-Output $Output
        Start-Sleep -Seconds 1
    }
    end {
        Write-Verbose "Step-Three: END block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
    clean {
        Write-Verbose "Step-One: CLEANUP block. Parameter=$Parameter"
        Start-Sleep -Seconds 1
    }
}

$VerbosePreference = 'Continue'
1, 2, 3 | Step-One | Step-Two | Step-Three
