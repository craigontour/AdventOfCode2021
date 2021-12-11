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
      neighbours << [x + dir[0], y + dir[1]]
    end
  end
  return neighbours
end

def flash(x, y, octos, flashed)
  puts "flash at #{x}, #{y}"
  neighbours = getNeighbours(x, y, octos)
  neighbours.each do |neighbour|
    if !flashed.include?([neighbour[0]],[neighbour[1]])
      octos[neighbour[0]][neighbour[1]] += 1
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

  (0...H).each do |x|
    (0...W).each do |y|
      if octos[x][y] > 9
        flash(x, y, octos, flashed)
        flashed << [x, y]
      end
    end
  end

  flashed.each do |octo|
    octos[octo[0]][octo[1]] = 0
  end

  puts "After step #{step+1}:\n"
  pp octos

  pause
end

puts "Part 1: #{part1} in #{Time.now - start} secs."
