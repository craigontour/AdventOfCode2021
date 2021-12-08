
def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

f = ARGV[0] == 't' ? 'test' : 'input'

digits = {
  '0' => 'abcefg', #6
  '1' => 'cf', #2
  '2' => 'acdeg', #5
  '3' => 'acdfg', #5
  '4' => 'bcdf', #4
  '5' => 'abdfg', #5
  '6' => 'abdefg', #6
  '7' => 'acf', #3
  '8' => 'abcdefg', #7
  '9' => 'abcdfg' #6
}
digits = {
  'abcefg' => '0',
  'cf' => '1',
  'acdeg' => '2',
  'acdfg' => '3',
  'bcdf' => '4',
  'abdfg' => '5',
  'abdefg' => '6',
  'acf' => '7',
  'abcdefg' => '8',
  'abcdfg' => '9'
}

count = 0

File.readlines("#{f}.txt").each do |line|
  output = line.chomp.split(' | ')[1]
  output.split(' ').each do |digit|
    # puts "digit: #{digit}, length: #{digit.length}"
    count += 1 if digit.length != 5 && digit.length != 6
  end
end

pp count