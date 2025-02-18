$ranGen = New-Object System.Random
$RepeatCount = 10000

'Basic for-loop = {0}ms' -f (Measure-Command -Expression {
        for ($i = 0; $i -lt $RepeatCount; $i++) {
            $Null = $ranGen.Next()
        }
    }).TotalMilliseconds

'Wrapped in a function = {0}ms' -f (Measure-Command -Expression {
        function Get-RandNum_Core {
            param ($ranGen)
            $ranGen.Next()
        }

        for ($i = 0; $i -lt $RepeatCount; $i++) {
            $Null = Get-RandNum_Core $ranGen
        }
    }).TotalMilliseconds

'For-loop in a function = {0}ms' -f (Measure-Command -Expression {
        function Get-RandNum_All {
            param ($ranGen)
            for ($i = 0; $i -lt $RepeatCount; $i++) {
                $Null = $ranGen.Next()
            }
        }

        Get-RandNum_All $ranGen
    }).TotalMilliseconds
