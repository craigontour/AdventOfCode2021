# From Safari Books - Grokking Algorithms
# Chp 7. Dijkstra's Algorithm

graph = {}
graph['s'] = {}
graph['s']['a'] = 5
graph['s']['b'] = 2
graph['a'] = {}
graph['a']['c'] = 4
graph['a']['d'] = 2
graph['b'] = {}
graph['b']['a'] = 8
graph['b']['d'] = 7
graph['c'] = {}
graph['c']['d'] = 6
graph['c']['f'] = 3
graph['d'] = {}
graph['d']['f'] = 1
graph['f'] = {}
puts "graph:\n#{graph}",''

# We only know costs of start point to begin with
costs = {}
costs['a'] = 5
costs['b'] = 2
costs['c'] = Float::INFINITY
costs['d'] = Float::INFINITY
costs['f'] = Float::INFINITY
puts "costs:\n#{costs}",''

parents = {}
parents['a'] = 's'
parents['b'] = 's'
parents['c'] = {}
parents['d'] = {}
parents['f'] = {}
puts "parents:\n#{parents}",''

processed = []

puts '--------------------'

def find_lowest_cost_node(costs, processed)
  lowest_cost = Float::INFINITY
  lowest_cost_node = nil
  costs.each do |node, cost|
    if cost < lowest_cost && !processed.include?(node)
      puts "find_lowest_cost_node: #{cost} is lowest cost so far!"
      lowest_cost = cost
      lowest_cost_node = node
    end
  end
  return lowest_cost_node
end

# find node with lowest cost
node = find_lowest_cost_node(costs, processed)

while node != nil do # [9,9] do
  cost = costs[node]
  puts "while_node_not_nil: lowest cost node is '#{node}' with cost #{cost}"

  neighbours = graph[node]
  puts "while_node_not_nil: node #{node}'s neighbours are #{neighbours}"

  neighbours.each do |n, c|
    new_cost = cost + c
    puts "while_node_not_nil: neighbour: '#{n}' has cost #{new_cost}"
    if costs[n] > new_cost
      # update costs for neighbours
      puts "costs[#{n}] = #{new_cost}"
      costs[n] = new_cost
      # if neighbours costs updated, update parents too
      parents[n] = node
    end
  end
  # add to processed
  processed << node

  puts "graph     :\n#{graph}",''
  puts "costs     :\n#{costs}",''
  puts "parents   :\n#{parents}",''
  puts "processed :\n#{processed}",''

  node = find_lowest_cost_node(costs, processed)
end

puts '--------------------'
pp graph
pp costs
pp parents

puts '--------------------'
puts "cheapest path is #{costs['f']}"