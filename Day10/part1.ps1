
$lines = get-content 'test.txt'

$i = 0
foreach ($line in $lines)
{
  while (($line | select-string "()" -SimpleMatch) || ($line | select-string "[]" -SimpleMatch) || ($line | select-string "{}" -SimpleMatch)|| ($line | select-string "<>" -SimpleMatch))
  {
    $line = $line.replace("()",'').replace("[]",'').replace("{}",'').replace("<>",'')
    "subbed:`r`n$line"
  }

}
