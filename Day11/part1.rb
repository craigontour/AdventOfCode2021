start = Time.now()

DIRECTIONS = [ [-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1] ]

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(testing)
  if testing
    File.readlines("test.txt").map { |line| line.chomp.chars.map(&:to_i) }
  else
    File.read("input.txt")
  end
end

def addOne(octos)
  (0...H).each do |y|
    (0...W).each do |x|
      # puts "octo: #{octos[y][x]} => #{octos[y][x] += 1}"
      octos[y][x] += 1
    end
  end
  return octos
end

def getNeighbours(x, y, grid)
  neighbours = []
  DIRECTIONS.each do |dir|
    # puts "dir: #{dir}"
    # puts "x: #{y}, y: #{y} => dir: #{dir}: #{grid[y + dir[1]][x + dir[0]]}"
    if (y + dir[1] >= 0) && (x + dir[0] >= 0) && (y + dir[1] < H) && (x + dir[0] < W)
      # puts "#{x}, #{y} neighbour is: #{y + dir[1]},#{x + dir[0]}, val: #{grid[y + dir[1]][x + dir[0]]}"
      neighbours << [y + dir[1] , x + dir[0]]
      # pause
    end
  end
  return neighbours
end

def flash(x, y, octos, flashed)
  puts "flash at #{x}, #{y}"
  neighbours = getNeighbours(x, y, octos)
  neighbours.each do |neighbour|
    octos[neighbour[1]][neighbour[0]] += 1
    
    if octos[neighbour[1]][neighbour[0]] > 9 && !flashed.include?([neighbour[1], neighbour[0]])
      flashed << [y, x]
      flash(neighbour[0], neighbour[1], octos, flashed)
    end
  end
end

octos = getInput(ARGV[0] == 't')
H = octos.length
W = octos[0].length
part1 = 0

pp octos, '----'

for step in 0..10 do
  flashed = []

  octos = addOne(octos)
  pp octos, '----'
  puts "Any flashing? = #{octos.flatten.include?(9)}"
  pause

  (0...H).each do |y|
    (0...W).each do |x|
      if octos[y][x] > 9
        flash(x, y, octos, flashed)
        pause
      end
    end
  end

  puts "After step #{step+1}:\n"
  pp octos

  pause
end

puts "Part 1: #{part1} in #{Time.now - start} secs."
