function Find-Word {
    param(
        [int]$row,
        [int]$col,
        [string]$targetWord,
        [array]$direction
    ) 
    $wordLength = $targetWord.Length
    $dRow, $dCol = $direction

    for ($i = 0; $i -lt $wordLength; $i++) {
        $newRow = $row + ($i * $dRow)
        $newCol = $col + ($i * $dCol)

        if ($newRow -lt 0 -or $newRow -ge $rows -or $newCol -lt 0 -or $newCol -ge $cols) {
            return $false
        }
        if ($wordSearch[$newRow][$newCol] -ne $targetWord[$i]) {
            return $false
        }
    }
    return $true
}

function Search-Grid {
    param (
        [array]$grid,
        [string]$target,
        [string]$targetReverse,
        [array]$directions,
        [string]$part
    )

    [int]$rows = $grid.Length
    [int]$cols = $grid[0].Length
    

    $totalFound = 0
    for ($row = 0; $row -lt $rows; $row++) {
        for ($col = 0; $col -lt $cols; $col++) {
            if($part -eq "1"){
                if ($wordSearch[$row][$col] -eq $targetWord[0]) {
                    foreach ($direction in $directions) {
                        if (Find-Word -row $row -col $col -targetWord $targetWord -direction $direction) {
                            $totalFound++
                        }
                        if (Find-Word -row $row -col $col -targetWord $reversedWord -direction $direction) {
                            $totalFound++
                        }
                    }
                }
            }    
        }
    }
    return $totalFound
}

[array]$wordSearch = @()
Get-Content -Path '.\input.txt' | ForEach-Object {
    $wordSearch += ,$($_ -split "")
}
[array]$directions = @(
        (-1, 0),   # Up
        (1, 0),    # Down
        (0, -1),   # Left
        (0, 1),    # Right
        (-1, -1),  # Up-Left
        (-1, 1),   # Up-Right
        (1, -1),   # Down-Left
        (1, 1)     # Down-Right
)

$totalFoundP1 = Search-Grid -grid $wordSearch -target "XMAS" -targetReverse "SAMX" -directions $directions -part '1'
Write-Host "Part one: $totalFoundP1!"

## Part 2##
# [
#     [iiiiiiiiiiiiii],
#     [iiiiiiiiiiiiiii],
#     [iiiiiiiiiiiiiii],
#     [iiiiiiiiiiiii],
#     [iiiiiiiiiiiiii]
# ]
    