$corruptedMemory = Get-Content -Path ./input.txt -Raw

$regex = 'mul\((-?\d+),\s*(-?\d+)\)'

$found = [regex]::Matches($corruptedMemory, $regex)

$total = 0
foreach($match in $found){
    $x = [int]$match.Groups[1].Value
    $y = [int]$match.Groups[2].Value

    $total += $x * $y
}
Write-Output "Part one total: $total"

## Part 2 ##

$regex = "mul\((-?\d+),\s*(-?\d+)\)|do\(\)|don\'t\(\)"

$found = [regex]::Matches($corruptedMemory, $regex)

$total = 0
$enabled = $true
foreach($match in $found){
    if($match.Value -match 'mul\((-?\d+),\s*(-?\d+)\)'){
        if($enabled){
            $x = [int]$match.Groups[1].Value
            $y = [int]$match.Groups[2].Value

            $total += $x * $y
        }
    }

    elseif($match.Value -eq "don't()"){
        $enabled = $false
    }
    elseif ($match.Value -eq 'do()') {
        $enabled = $true
    }
    
}
Write-Output "Part two total: $total"




