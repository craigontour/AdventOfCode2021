
$content = Get-Content 'test.txt'
# $content

$parts = $content

$parts = $content.Split("`n")

$balls = $parts[0]
$parts.Remove(0)
$balls

foreach ($part in $parts) {
  if ($part.length -eq 0) { continue }

  $part.length
}
