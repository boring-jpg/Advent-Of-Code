function Test-Safety {
    param (
        [array]$level
    )
   
    $increasing = $null
    $decreasing = $null
    for($i = 0; $i -lt $level.Length -1; $i++){

        $difference = [System.Math]::Abs($level[$i] - $level[$i+1])

        if($difference -lt 1 -or $difference -gt 3){
            return $false
        }

        if($level[$i] -lt $level[$i + 1]){
            if($decreasing){
                return $false
            }
            $increasing = $true
        }

        if($level[$i] -gt $level[$i + 1]){
            if($increasing){
                return $false
            }
            $decreasing = $true
        }
    }
    return $true
}

$allReports = Get-Content -Path ./input.txt

$safeReports = 0
$safeAfterRemoveOne = 0
foreach($report in $allReports){
    [array]$level = $report.Split(" ") | ForEach-Object { [int]$_ }
    
    if(Test-Safety $level){
        $safeReports++
    } else {
        for($i = 0; $i -lt $level.Length; $i++) {
            if ($i -eq 0) {
                $modifiedLevel = $level[1..($level.Length-1)]
            } elseif ($i -eq $level.Length - 1) {
                $modifiedLevel = $level[0..($level.Length-2)]
            } else {
                $modifiedLevel = $level[0..($i-1)] + $level[($i+1)..($level.Length-1)]
            }

            if(Test-Safety $modifiedLevel){
                $safeAfterRemoveOne++
                break
            }
        }
    }
    
}

Write-Output "Safe Reports: $safeReports"
Write-Output "Safe after removing one level: $safeAfterRemoveOne"
Write-Output "Total: $($safeReports + $safeAfterRemoveOne)"