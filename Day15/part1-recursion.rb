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

def get_path(grid, point, last, path, paths, risk)
  puts "#{point} added to #{path['points']} with risk: #{path['risk']}"
  # pause

  return true if point == last
  return false if point == []

  path['points'] += [point]
  path['risk'] += grid[point[0]][point[1]] if point != [0,0]

  # puts "path: #{path['points']}, risk: #{path['risk']}"
  # risk = path['risk'] if path['risk'] < risk
  # paths.push(path)

  get_neighbours(grid, point).each do |neighbour|
    next if path['points'].include?(neighbour)
  
    get_path(grid, neighbour, last, path, paths, risk)
  end
end

chitons = getInput(ARGV[0])
last = [chitons.length-1, chitons.length-1]
path = { 'points' => [], 'risk' => 0 }
paths = []
risk = 0

get_path(chitons, [0,0], last, path, paths, risk)

pp paths
pp risk
