start = Time.now()

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

data = Array.new(10) { Array.new(10) }

def getInput(testing)
  arr = []
  if testing
    File.readlines("test.txt").map(&:strip).each do |line|
      arr << line
    end
  else
    File.readlines("input.txt").map(&:strip).map(&:to_i)
  end
end

def print_array(arr)
  (0..(arr.length-1)).each do |y|
    s = ''
    (0..(arr[y].length-1)).each do |x|
      s += arr[y][x]
    end
    puts s
  end
  puts
end

octos = getInput(ARGV[0] == 't')
puts octos,''
puts octos.length,''
puts octos[0].length,''
# exit
part1 = 0

for steps in 0..10 do
  (0..10).each do |y|
    (0..10).each do |x|
      puts "s:#{x}, y:#{y}, octo"
      octos[y][x] += 1
    end
  end
  puts octos
  pause

end




puts "Part 1: #{part1} in #{Time.now - start} secs."
