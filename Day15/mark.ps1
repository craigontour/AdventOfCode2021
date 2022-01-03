param([string]$file)

$ErrorActionPreference="Stop"
$data = @()

Get-Content "$PSScriptRoot\$file.txt" | % { $data += $_ }
$maxx = $data[0].length -1
$maxy = $data.length - 1

$global:front = $null

function AddToQueue($priority,$x,$y)
{
    $newitem=[PSCustomObject]@{
        priority = $priority
        x = $x
        y = $y
        next = $null
    }

    if ($null -eq $global:front) {
        $global:front = $newitem
        return
    }

    $i = $global:front # pointer
    $last = $null
    
    while ($null -ne $i)
    {
        # 
        if ($i.priority -ge $newitem.priority)
        {
            $newitem.next = $i
            if ($null -ne $last)
            {
                $last.next = $newitem
            }
            if ($global:front -eq $i)
            {
                $global:front = $newitem
            }
            return
        }

        $last = $i
        $i = $i.next
    }

    $last.next = $newitem
}

function PopQueue
{
    $first = $global:front
    $global:front = $global:front.next
    return $first
}

function UpdateAdjacent($dist,$x,$y,$d,$maxx,$maxy)
{
    if ($x -ge 0 -and $x -le $maxx -and $y -ge 0 -and $y -le $maxy)
    {
        $k = "$x,$y"
        $v = $dist[$k]
        $sum = $d + $weight[$k]
        if ($sum -lt $v)
        {
            $dist[$k] = $sum
            AddToQueue $sum $x $y
        }
    }
}

$dist = @{}
$weight = @{}
0..$maxy | %{
    $y = $_
    0..$maxx | %{
        $x = $_
        $k = "$x,$y"
        $dist[$k]=[int]::MaxValue
        $weight[$k]=[int]"$($data[$y][$x])"
    }
}

$dist["0,0"] = 0
AddToQueue 0 0 0

while (1)
{
    $i = PopQueue
    $x = $i.x
    $y = $i.y

    if ($x -eq $maxx -and $y -eq $maxy) { break }

    $d = $dist["$x,$y"]
    UpdateAdjacent $dist ($x-1) $y $d $maxx $maxy
    UpdateAdjacent $dist ($x+1) $y $d $maxx $maxy
    UpdateAdjacent $dist $x ($y-1) $d $maxx $maxy
    UpdateAdjacent $dist $x ($y+1) $d $maxx $maxy
}

"Result:"
$dist["$maxx,$maxy"]