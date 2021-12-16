start = Time.now()
 
DIRECTIONS = [ [0, -1], [1, 0], [0, 1], [-1, 0] ]
 
def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  nodes = {}
  last = []

  File.readlines("#{f}.txt").map(&:strip).each_with_index do |line, row|
    # input.push(line.chars.map(&:to_i))

    line.chars.each_with_index do |ch, col|
      # puts "#{row},#{col} : #{ch.to_i} "
      nodes[[col, row]] = ch.to_i
      last = [col, row]
    end
  end

  # return input
  return {
    [0,0] => 1, [1,0]=>2, [2,0]=>3,
    [0,1] => 4, [1,1]=>5, [2,1]=>6,
    [0,2] => 7, [1,2]=>8, [2,2]=>9
  }, last
end

def get_neighbours(nodes, point)
  x = point[0]
  y = point[1]
  neighbours = {}
  DIRECTIONS.each do |dir|
    if (x + dir[0] >= 0) && (y + dir[1] >= 0) && (x + dir[0] < nodes.length) && (y + dir[1] < nodes.length)
      # puts "Add point at #{x+dir[0]}, #{y+dir[1]} to #{neighbours}"
      neighbours[[x+dir[0], y+dir[1]]] = nodes[[x+dir[0], y+dir[1]]]
    end
  end
  return neighbours
end

nodes, target = getInput(ARGV[0])
pp nodes.length
# pp target

def djikstra(nodes, start, target)
  puts "start: #{start}"
  parent = []
  paths = []

  neighbours = get_neighbours(nodes, start)
  puts "neighbours: #{neighbours}"
  neighbours.each do |k, v|
    puts "neighbour at #{k}: #{v}"
  end
  pp neighbours.min_by{ |k,v| v }
  pp neighbours

end

djikstra(nodes, [0,0], target)
