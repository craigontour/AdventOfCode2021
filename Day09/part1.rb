start = Time.now()

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def print_array(arr)
  (0..(arr.length)).each do |y|
    s = ''
    (0..(arr[y].length)).each do |x|
      s += arr[y][x]
    end
    puts s
  end
  puts
end

if ARGV[0] == 't'
  f = 'test'
  h = 5
  w = 10
else
  f = 'input'
  h = w = 100
end

DIRECTIONS = {"n" => [0, -1], "e" => [1, 0], "s" => [0, 1], "w" => [-1, 0] }

input = File.readlines("#{f}.txt").map(&:strip)

# puts input.length
# puts input[0].length
# for y in (0...(input.length)) do
#   for x in (0...(input[0].length)) do
#     pp "x:#{x},y:#{y}"
#   end
# end

# exit

def getNeighbours(x, y, grid)
  neighbours = []
  DIRECTIONS.each do |_, dir|
    # puts "x: #{y}, y: #{y} => dir: #{dir}: #{grid[y + dir[1]][x + dir[0]]}"
    if (y + dir[1] >= 0) && (x + dir[0] >= 0) && (y + dir[1] < grid.length) && (x + dir[0] < grid[0].length)
      # puts "neighbour: #{grid[y + dir[1]][x + dir[0]]}"
      neighbours << (grid[y + dir[1]][x + dir[0]]).to_i
    end
  end
  return neighbours
end

part1 = []

for y in (0..(input.length-1)) do
  for x in (0..(input[0].length-1)) do
    sizes = getNeighbours(x, y, input)
    sizes << input[y][x].to_i
    sizes.sort!
    if input[y][x].to_i < sizes[1]
      # puts "low: #{input[y][x]}: #{sizes} : #{sizes[0]} ? #{sizes[0]}, risk: #{sizes[0]+ 1}"
      part1 << sizes[0] + 1
    end
    # pause
  end
end

puts "Part 1: #{part1.sum} in #{Time.now()-start} sec."
