start = Time.now()

DIRECTIONS = [ [-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1] ]

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(testing)
  if testing
    File.readlines("test.txt").map { |line| line.chomp.chars.map(&:to_i) }
  else
    File.readlines("input.txt").map { |line| line.chomp.chars.map(&:to_i) }
  end
end

def addOne(octos)
  (0...(octos.length)).each do |y|
    (0...(octos[0].length)).each do |x|
      # puts "octo: #{octos[y][x]} => #{octos[y][x] += 1}"
      octos[y][x] += 1
    end
  end
  return octos
end

def findNeighbours(x, y, grid)
  neighbours = []
  DIRECTIONS.each do |dir|
    if (y + dir[1] >= 0) && (x + dir[0] >= 0) && (y + dir[1] < grid.length) && (x + dir[0] < grid[0].length)
      neighbours << [x + dir[0], y + dir[1]]
    end
  end
  return neighbours
end

def isFlashes(octos)
  octos.flatten.sort.inject(0) { |k, v| v > 9 }
end

def flash(x, y, octos)
  findNeighbours(x, y, octos).each do |neighbour|
    octos[neighbour[0]][neighbour[1]] += 1
  end
end

def solve(part)
  octos = getInput(ARGV[0] == 't')
  h = octos.length
  w = octos[0].length
  solution = 0
  limit = if part == 1
            100
          else
            300
          end

  for step in 0...limit do
    flashed = []

    octos = addOne(octos)

    while isFlashes(octos) do
      (0...h).each do |x|
        (0...w).each do |y|
          if octos[x][y] > 9 && !flashed.include?([x, y])
            flash(x, y, octos)
            flashed << [x, y]
          end
        end
      end

      flashed.each do |xy|
        octos[xy[0]][xy[1]] = 0
      end
    end

    if part == 1
      solution += octos.flatten.count(0)
    elsif octos.flatten.count(0) == 100
      pp "Step: #{step}"
      pp octos
      return step + 1
    end
  end
  return solution
end

puts "Part 1: #{solve(1)} in #{Time.now - start} secs."
puts "Part 2: #{solve(2)} in #{Time.now - start} secs."
