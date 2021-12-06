# By Mark Neves

$ErrorActionPreference="Stop"
$data=@()

# Get-Content "$PSScriptRoot\test.txt" | %{$data+=$_}
$data = "3,4,3,1,2"

$fish=@{}
$numFish=0
$data.Split(',') | %{$fish[$numFish++]=[int]$_}
$fish.Values -join ','

$numDays=18 #256

$days=@{}
for ($i=0;$i -lt $numFish;$i++)
{
    for ($d=$fish[$i]+1;$d -le $numDays;$d+=7)
    {
        $days[$d]+=1
    }
}
for ($d=1;$d -le $numDays;$d++)
{
    for ($i=$d+9;$i -le $numDays;$i+=7)
    {
        $days[$i] += $days[$d]
    }
}

$total=($days.Values |  measure -sum).Sum + $numFish
$total

$days | % { $_ }
