start = Time.now()
 
DIRECTIONS = [ [0, -1], [1, 0], [0, 1], [-1, 0] ]

class Graph
  Vertex = Struct.new(:name, :neighbours, :dist, :prev)
 
  def initialize(graph)
    @vertices = Hash.new { |h,k| h[k]=Vertex.new(k,[],Float::INFINITY) }
    @edges = {}
    graph.each do |(v1, v2, dist)|
      @vertices[v1].neighbours << v2
      @vertices[v2].neighbours << v1
      @edges[[v1, v2]] = @edges[[v2, v1]] = dist
    end
    @dijkstra_source = nil
  end

  def dijkstra(source)
    return if @dijkstra_source == source
    q = @vertices.values
    q.each do |v|
      v.dist = Float::INFINITY
      v.prev = nil
    end
    @vertices[source].dist = 0
    until q.empty?
      u = q.min_by {|vertex| vertex.dist}
      break if u.dist == Float::INFINITY
      q.delete(u)
      u.neighbours.each do |v|
        vv = @vertices[v]
        if q.include?(vv)
          alt = u.dist + @edges[[u.name, v]]
          if alt < vv.dist
            vv.dist = alt
            vv.prev = u.name
          end
        end
      end
    end
    @dijkstra_source = source
  end

  def shortest_path(source, target)
    dijkstra(source)
    path = []
    u = target
    while u
      path.unshift(u)
      u = @vertices[u].prev
    end
    return path, @vertices[target].dist
  end
end

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def get_neighbours(nodes, x, y)
  neighbours = []
  DIRECTIONS.each do |dir|
    if (x + dir[0] >= 0) && (y + dir[1] >= 0) && (x + dir[0] < nodes.length) && (y + dir[1] < nodes.length)
      # puts "Neighbour: #{x+dir[0]}, #{y+dir[1]}, cost: #{nodes[y+dir[1]][x+dir[0]]}"
      neighbours << { point: [ x+dir[0], y+dir[1] ], cost: nodes[y+dir[1]][x+dir[0]] }
    end
  end
  return neighbours
end

def getData(f)
  data = File.readlines("#{f}.txt").map(&:strip)
  pp data

  height = data.length
  width = data[0].length

  vertices = []
  data.each_with_index do |line, y|
    line.chars.each_with_index do |ch, x|
      get_neighbours(data, x, y).each do |neighbour|
        vertices << [[x,y], neighbour[:point], neighbour[:cost].to_i]
      end
    end
  end
  return vertices
end

g = Graph.new(getData(ARGV[0]))
# pp g

start, stop = [0,0], [9,9]
path, dist = g.shortest_path(start, stop)
puts "shortest path from #{start} to #{stop} has cost #{dist}:"
pp path #.join(" -> ")