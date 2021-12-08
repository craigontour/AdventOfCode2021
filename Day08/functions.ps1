
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