start = Time.now()
DIRECTIONS = [ [-1, 0], [1, 0], [0, -1], [0, 1] ]

def get_neighbours(nodes, x, y)
  neighbours = []
  DIRECTIONS.each do |dir|
    if (x + dir[0] >= 0) && (y + dir[1] >= 0) && (x + dir[0] < nodes.length) && (y + dir[1] < nodes.length)
      # puts "Neighbour: #{x+dir[0]}, #{y+dir[1]}, cost: #{nodes[y+dir[1]][x+dir[0]]}"
      neighbours << [x+dir[0], y+dir[1]]
    end
  end
  return neighbours
end

def getData(f)
  data = File.readlines("#{f}.txt").map(&:strip)

  graph = {}
  costs = {}
  parents = {}

  data.each_with_index do |line, y|
    line.chars.each_with_index do |ch, x|
      neighbours = get_neighbours(data, x, y)

      graph[[x,y]] = {}
      neighbours.each do |nx, ny|
        # skip if already defined as neighbour of another point else would be bi-directional graph
        next if graph[[nx,ny]]

        costs[[nx,ny]] = {}
        parents[[nx,ny]] = {}

        graph[[x,y]][[nx,ny]] = data[ny][nx].to_i
        if x == 0 && y == 0
          costs[[nx,ny]] = data[ny][nx].to_i
          parents[[nx,ny]] = [0,0]
        else
          costs[[nx,ny]] = Float::INFINITY
          parents[[nx,ny]] = {}
        end
      end
    end
  end
  return graph, costs, parents
end

def find_lowest_cost_node(costs, processed)
  lowest_cost = Float::INFINITY
  lowest_cost_node = nil

  costs.each do |node, cost|
    if cost < lowest_cost && !processed.include?(node)
      lowest_cost = cost
      lowest_cost_node = node
    end
  end

  return lowest_cost_node
end

def dijkstra(f, target)
  graph, costs, parents = getData(f)
  processed = {}

  # find node with lowest cost
  node = find_lowest_cost_node(costs, processed)
  while node != nil && node != target do
    cost = costs[node]
    neighbours = graph[node]

    neighbours.each do |n, c|
      new_cost = cost + c
      if costs[n] > new_cost
        costs[n] = new_cost
        parents[n] = node
      end
    end
    # add to processed
    processed[node] = true
    
    node = find_lowest_cost_node(costs, processed)
  end
  return costs[target]
end

if ARGV[0] == 'test'
  puts "Part 1 (test) : #{dijkstra(ARGV[0], [9,9])}"
else
  puts "Part 1 (input): #{dijkstra(ARGV[0], [99,99])}"
end
