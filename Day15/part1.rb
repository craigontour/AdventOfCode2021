start = Time.now()
 
DIRECTIONS = [ [0, -1], [1, 0], [0, 1], [-1, 0] ]
 
def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  input = []
  File.readlines("#{f}.txt").map(&:strip).each do |line|
    input.push(line.chars.map(&:to_i))
  end
  # return input
  return [ [1,2,3], [4,5,6], [7,8,9] ]
end

def get_neighbours(grid, point)
  x = point[0]
  y = point[1]
  neighbours = []
  DIRECTIONS.each do |dir|
    if (x + dir[0] >= 0) && (y + dir[1] >= 0) && (x + dir[0] < grid[0].length) && (y + dir[1] < grid.length)
      neighbours << [x + dir[0], y + dir[1]]
    end
  end
  return neighbours
end

def get_path(grid, start, last, path, paths)
  path += [start]
  # puts "#{start} added to #{path}"

  if start == last
    paths.push(path)
    return
  end

  get_neighbours(grid, start).each do |neighbour|
    # puts "neighbour: #{neighbour}"
    next if path.include?(neighbour)

    # pause
  
    get_path(grid, neighbour, last, path, paths)
  end
end

last = [chitons.length-1, chitons.length-1]
paths = []
get_path(chitons, [0,0], last, [], paths)

pp paths
