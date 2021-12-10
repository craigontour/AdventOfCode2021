
$lines = get-content 'test.txt'

$i = 0
foreach ($line in $lines)
{
  "$i before: $line"

  while ($line -match "()" || $line -match "[]" || $line -match "{}" || $line -match "<>")
  {
    "subbing:`r`n$($line.replace("()",'@@').replace('[]','@@').replace('{}','@@').replace("<>",'@@'))"

    $line = $line.replace("()",'').replace("[]",'').replace("{}",'').replace("<>",'')
    "subbed:`r`n$line"
    pause
  }
  
  "$i after : $line`r`n"
  $i += 1
}
