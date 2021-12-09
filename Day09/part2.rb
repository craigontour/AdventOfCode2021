
start = Time.now()

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(testing)
  if testing
    File.readlines("test.txt").map(&:strip)
  else
    File.readlines("input.txt").map(&:strip)
  end
end

input = getInput(ARGV[0] == 't')

DIRECTIONS = [ [0, -1], [1, 0], [0, 1], [-1, 0] ]

def getBasin(x, y, grid)
  sizes = ''
  sizes += grid[y][x]
  @VISITED << [y, x]

  DIRECTIONS.each do |dir|
    dx = dir[0]
    dy = dir[1]
    if (y + dy >= 0) && (x + dx >= 0) && (y + dy < grid.length) && (x + dx < grid[0].length)
      h = (grid[y + dy][x + dx]).to_i
      # puts "getBasin | x:#{x+dx}, y:#{y+dy}, h:#{h}"
      if h < 9 && !@VISITED.include?([y+dy, x+dx])
        sizes << getBasin(x + dx, y + dy, grid)
      end
    end
  end
  # puts "getBasin | sizes: #{sizes}"
  # pause
  return sizes
end

@VISITED = []
part2 = []

for y in (0..(input.length-1)) do
  for x in (0..(input[0].length-1)) do
    next if input[y][x] == '9'
    basin = ''
    # puts "main | x:#{x}, y:#{y} : #{input[y][x]}, visited: #{@VISITED.include?([y, x])}"
    if !@VISITED.include?([y, x])
      basin += getBasin(x, y, input)
      # puts "main | basin: #{basin} = #{basin.length}"
      # pause
      part2 << basin.length
    end
  end
end

puts "Part 2: #{part2.sort[-3..-1].reduce(&:*)} in #{Time.now()-start} sec."
