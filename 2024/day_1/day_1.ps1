# O(n)
[array]$masterList = Get-Content -Path .\input.txt

[System.Collections.ArrayList]$leftList = @()
[System.Collections.ArrayList]$rightList = @()

foreach($line in $masterList) {
    [void]$leftList.Add($($line.Split("   "))[0])
    [void]$rightList.Add($($line.Split("   "))[1])
};

# O(n log n) .net arrayList uses quicksort
$leftList.Sort()
$rightList.Sort()

# O(n)
[int]$i = 0
[System.Collections.ArrayList]$totalDistanceList = @()
foreach($lLocID in $leftList){

    [int]$totalDistance = [System.Math]::Abs([int]$($rightList[$i]) - [int]$lLocID)
    [void]$totalDistanceList.Add($totalDistance) 
    $i++ 
}

[int]$totalDistanceBetweenLists = $($totalDistanceList | Measure-Object -Sum).Sum
Write-Output "Total Distance Between lists: $totalDistanceBetweenLists"

## Part One overall O(n log n)

### Part two ###

# O(n)
$simulatityScores = [System.Collections.ArrayList]@()
$rightListHash = @{}
foreach($rLocID in $rightList){
    if($rightListHash.ContainsKey($rLocID)){
        $rightListHash[$rLocID]++
    } else {
        $rightListHash[$rLocID] = 1
    }
}

foreach($lLocID in $leftList){

    $simScore = [int]$lLocID * $($rightListHash[[int]$lLocID])
    [void]$simulatityScores.Add($simScore)
}

$totalSimScore = $($simulatityScores | Measure-Object -Sum).Sum
Write-Output "Simularity Score: $totalSimScore"

## Part 2 overall O(n)

