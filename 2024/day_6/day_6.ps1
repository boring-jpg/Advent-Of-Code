# Directions: up (0), right (1), down (2), left (3)
$directions = @(
    (-1, 0), # up
    (0, 1),  # right
    (1, 0),  # down
    (0, -1)  # left
)

function Track-Guard-Path {
    param(
        [string[]]$map
    )

    $startRow, $startCol = -1, -1
    for ($row = 0; $row -lt $map.Length; $row++) {
        for ($col = 0; $col -lt $map[$row].Length; $col++) {
            if ($map[$row][$col] -eq '^') {
                $startRow = $row
                $startCol = $col
                break
            }
        }
        if ($startRow -ne -1) { break }
    }

    $row, $col = $startRow, $startCol
    $direction = 0
    $visitedPositions = @{}  

    $visitedPositions["$row,$col"] = $true

    while ($true) {
        $nextRow = $row + $directions[$direction][0]
        $nextCol = $col + $directions[$direction][1]

        if ($nextRow -lt 0 -or $nextRow -ge $map.Length -or $nextCol -lt 0 -or $nextCol -ge $map[$nextRow].Length) {
            break  
        }

        if ($map[$nextRow][$nextCol] -eq '#') {
            $direction = ($direction + 1) % 4 
        } else {
            $row, $col = $nextRow, $nextCol
            $visitedPositions["$row,$col"] = $true
        }
    }

    return $visitedPositions.Count
}

$mapInput = Get-Content -Path ".\input.txt"

$result = Track-Guard-Path -map $mapInput
Write-Output $result 
