[array]$masterList = Get-Content -Path .\input.txt

$leftList = [System.Collections.ArrayList]@()
$rightList = [System.Collections.ArrayList]@()

foreach($line in $masterList) {
    [array]$split = $line.Split("   ")

    $leftList += $split[0]
    $rightList += $split[1]
};

[System.Collections.ArrayList]$leftList = $leftList | Sort-Object
[System.Collections.ArrayList]$rightList = $rightList | Sort-Object

$totalDistanceList = [System.Collections.ArrayList]@()
[int]$i = 0
foreach($lLocID in $leftList){

    [int]$rLocID = $rightList[$i]
    [int]$totalDistance = 0

    if($rLocID -gt $lLocID){
        $totalDistance = $RLocID - [int]$lLocID
        
    } else {
        $totalDistance = [int]$lLocID - $rLocID
    };
    
    $totalDistanceList += $totalDistance
    $i++
};

[int]$totalDistanceBetweenLists = $($totalDistanceList | Measure-Object -Sum).Sum
Write-Output "Total Distance Between lists: $totalDistanceBetweenLists"

### Part two ###

$simulatityScores = [System.Collections.ArrayList]@()
foreach($lLocID in $leftList){

    [int]$timesAppeared = 0

    foreach($rLocID in $rightList){
        if($lLocID -eq $rLocID){
            $timesAppeared++
        };
    };
    
    if(-not($timesAppeared -eq 0)){
        $simscore = [int]$lLocID * $timesAppeared
        $simulatityScores += $simscore
    };
;}

$totalSimScore = $($simulatityScores | Measure-Object -Sum).Sum

Write-Output "Simularity Score: $totalSimScore"

