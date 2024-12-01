# O(n)
[array]$masterList = Get-Content -Path .\input.txt

[System.Collections.ArrayList]$leftList = @()
[System.Collections.ArrayList]$rightList = @()

foreach($line in $masterList) {
    [void]$leftList.Add($($line.Split("   "))[0])
    [void]$rightList.Add($($line.Split("   "))[1])
};

# O(n log n)
$leftList.Sort()
$rightList.Sort()

# O(n)
[int]$i = 0
[int]$totalDistanceBetweenLists = 0
foreach($lLocID in $leftList){
    $totalDistanceBetweenLists += [System.Math]::Abs($($rightList[$i]) - $lLocID)
    $i++ 
}
Write-Output "Total Distance Between lists: $totalDistanceBetweenLists"

# O(n)
$rightListHash = @{}
foreach($rLocID in $rightList){
    if($rightListHash.ContainsKey($rLocID)){
        $rightListHash[$rLocID]++
    } else {
        $rightListHash[$rLocID] = 1
    }
}

# O(n)
$totalSimScore = 0
foreach($lLocID in $leftList){
    $totalSimScore += $([int]$lLocID * $($rightListHash[[int]$lLocID]))
}
Write-Output "Simularity Score: $totalSimScore"