
def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

f = ARGV[0] == 't' ? 'test' : 'input'

count = 0

File.readlines("#{f}.txt").each do |line|
  output = line.chomp.split(' | ')[1]
  output.split(' ').each do |digit|
    # puts "digit: #{digit}, length: #{digit.length}"
    count += 1 if digit.length != 5 && digit.length != 6
  end
end

pp count