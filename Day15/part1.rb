start = Time.now()
DIRECTIONS = [ [1, 0], [0, 1] ]

@debug = ARGV[1]

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

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
        # next if graph[[nx,ny]]

        puts "- #{x},#{y} has neighbour : #{nx},#{ny} with cost #{data[ny][nx]}" if @debug == '1'
        
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
    pause if @debug == '1'
  end
  return graph, costs, parents
end

def printCosts(costs, processed)
  costs.each do |node, cost|
    if cost < Float::INFINITY && !processed.include?(node)
      puts "[COSTS] node: #{node}, cost: #{cost}" if @debug == '0'
    elsif processed.include?(node)
      puts "[Processed] node: #{node}, cost: #{cost}" if @debug == '0'
    end
  end
  pause if @debug == '0'
end

def find_lowest_cost_node(its, costs, processed)
  lowest_cost = Float::INFINITY
  lowest_cost_node = nil

  costs.each do |node, cost|
    if cost < lowest_cost && !processed.include?(node)
      lowest_cost = cost
      lowest_cost_node = node
      puts "#{its} lowest_cost_node: #{node} = #{cost}" if @debug == '0'
    end
  end

  return lowest_cost_node
end

def dijkstra(f, target)
  graph, costs, parents = getData(f)
  processed = []
  
  puts '--------------------' if @debug == '2'
  puts "graph   :\n#{graph}",'' if @debug == '2'
  puts "costs   :\n#{costs}",'' if @debug == '2'
  puts "parents :\n#{parents}",'' if @debug == '2'
  puts '--------------------' if @debug == '2'

  # find node with lowest cost
  its = 0
  node = find_lowest_cost_node(its, costs, processed)
  while node != nil && node != target do
    puts "lowest_code_node: #{node}"
  
    cost = costs[node]
    neighbours = graph[node]
    puts "#{node} has neighbours:\n#{neighbours}" if @debug == '1'

    neighbours.each do |n, c|
      new_cost = cost + c
      if costs[n] > new_cost
        puts "costs[#{n}] = #{new_cost}" if @debug == '1'
        costs[n] = new_cost
        parents[n] = node
      end
    end
    # add to processed
    processed << node
    
    its += 1
    printCosts(costs, processed)
    node = find_lowest_cost_node(its, costs, processed)
    printCosts(costs, processed)
  end

  # pp graph
  # # puts "costs: #{costs.length}"
  # pp parents

  return costs[target]
end

if ARGV[0] == 'test'
  puts "Part 1 (test) : #{dijkstra(ARGV[0], [9,9])}"
else
  puts "Part 1 (input): #{dijkstra(ARGV[0], [99,99])}"
end
