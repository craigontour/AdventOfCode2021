$start = Get-Date

Function Get-StringPermutation {
  <#
      .SYNOPSIS
          Retrieves the permutations of a given string. Works only with a single word.

      .DESCRIPTION
          Retrieves the permutations of a given string Works only with a single word.
     
      .PARAMETER String           
          Single string used to give permutations on
     
      .NOTES
          Name: Get-StringPermutation
          Author: Boe Prox
          DateCreated:21 Feb 2013
          DateModifed:21 Feb 2013

      .EXAMPLE
          Get-StringPermutation -String "hat"
          Permutation                                                                          
          -----------                                                                          
          hat                                                                                  
          hta                                                                                  
          ath                                                                                  
          aht                                                                                  
          tha                                                                                  
          tah        

          Description
          -----------
          Shows all possible permutations for the string 'hat'.

      .EXAMPLE
          Get-StringPermutation -String "help" | Format-Wide -Column 4            
          help                  hepl                  hlpe                 hlep                
          hpel                  hple                  elph                 elhp                
          ephl                  eplh                  ehlp                 ehpl                
          lphe                  lpeh                  lhep                 lhpe                
          leph                  lehp                  phel                 phle                
          pelh                  pehl                  plhe                 pleh        

          Description
          -----------
          Shows all possible permutations for the string 'hat'.

  #>
  [cmdletbinding()]
  Param(
      [parameter(ValueFromPipeline=$True)]
      [string]$String = 'the'
  )
  Begin {
      #region Internal Functions
      Function New-Anagram { 
          Param([int]$NewSize)              
          If ($NewSize -eq 1) {
              return
          }
          For ($i=0;$i -lt $NewSize; $i++) { 
              New-Anagram  -NewSize ($NewSize - 1)
              If ($NewSize -eq 2) {
                  New-Object PSObject -Property @{
                      Permutation = $stringBuilder.ToString()                  
                  }
              }
              Move-Left -NewSize $NewSize
          }
      }
      Function Move-Left {
          Param([int]$NewSize)        
          $z = 0
          $position = ($Size - $NewSize)
          [char]$temp = $stringBuilder[$position]           
          For ($z=($position+1);$z -lt $Size; $z++) {
              $stringBuilder[($z-1)] = $stringBuilder[$z]               
          }
          $stringBuilder[($z-1)] = $temp
      }
      #endregion Internal Functions
  }
  Process {
      $size = $String.length
      $stringBuilder = New-Object System.Text.StringBuilder -ArgumentList $String
      New-Anagram -NewSize $Size
  }
  End {}
}

$data = Get-Content "test.txt" | ForEach-Object { $_.split('\n') }

$part1 = 0
foreach ($line in $data) {
  $part1 += ($line.split(' | ')[1].split(' ') | ? { ($_.length -ne 5) -and ($_.length -ne 6) }).count
}
Write-host "Part 1: $part1"

$template = @{
  abcefg = 0
  cf = 1
  acdeg = 2
  acdfg = 3
  bcdf = 4
  abdfg = 5
  abdefg = 6
  acf = 7
  abcdefg = 8
  abcdfg = 9
}

function findDigit {
  param([string]$segment, [string]$config)
  Write-host "Segment: $segment"
  $str = ""
  for ($i=0; $i -lt $segment.length; $i++) {
    Write-Host "char: $($segment[$i])"
  }

}

findDigit("afc" | sort)

exit

$part2 = 0
foreach ($line in $data) {
  $lr = $line.split(' | ')

  $perms = Get-StringPermutation("abcdefg")

  foreach ($perm in $perms) {
    $nextPerm = $false

    $segments = $lr[0].split(' ')
    foreach ($segment in $segments) {
      if (findDigit($segment, $perm) == $null) {
        $nextPerm = $true
        break
      }
    }

    if ($nextPerm) { continue }

    $digits = ''

    $segments = $lr[1].split(' ')
    foreach ($segment in $segments) {
      $digits += '1' #findDigit($segment, $perm)
    }
    $part2 += [int32]($digits -join(''))
  }

}

$elapsed = $(Get-Date) - $start
$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsed.Ticks)

Write-host "Part 2: $part2 in $totalTime"
