start = Time.now()
DIRECTIONS = [ [0, -1], [1, 0], [0, 1], [-1, 0] ]

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getData(f)
  data = File.readlines("#{f}.txt").map(&:strip)

  dist = {}
  cost = {}
  data.each_with_index do |line, y|
    line.chars.each_with_index do |ch, x|
      dist["#{x},#{y}"] = Float::INFINITY
      cost["#{x},#{y}"] = data[y][x].to_i
    end
  end
  return dist, cost, data[0].length-1, data.length-1
end

def addToQueue(priority, x, y)
  k = "#{x},#{y}"
  newItem = {
    :priority => priority,
    :k => k,
    :x => x,
    :y => y,
    :nextItem => {},
    :prevItem => {}
  }

  if @queue.nil?
    @queue = newItem 
    return
  end

  i = @queue
  last = nil

  while !i.nil? do
    if i.priority >= newItem.priority
      newItem.nextItem = i

      if !i.prevItem.nil?
        newItem.prevItem = i.prevItem
        i.prevItem.nextItem = newItem
      end

      i.prevItem = newItem
      if newItem.prevItem.nil?
        @queue = newItem
      end

      return
    end
  end

  last.nextItem = newItem
  newItem.prevItem = last
end

def popQueue
  i = @queue
  puts "i     : #{i}"
  puts "queue : #{queue}"
  @queue = @queue.nextItem
  if @queue.prevItem.nil?
    @queue.prevItem = nil
  end
  return i
end

def updateNeighbours(dist, costs, visited, x, y, d, maxx, maxy)
  if x >= 0 && x <= maxx && y >= 0 && y <= maxy && !visited.include?([x,y])
    k = "#{x},#{y}"
    sum = d + costs[k]
    if sum < dist[k]
      dist[k] = sum
      addToQueue(sum, k, x, y)
    end
  end
end

dist, costs, maxx, maxy = getData(ARGV[0])

@queue = nil
addToQueue(0, 0, 0)
puts @queue
visited = []

c = 0
while true do
  i = popQueue
  x = i.x
  y = i.y

  if x == maxy && y == maxy
    puts dist["#{maxx},#{maxy}"]
    exit
  end

  d = dist["#{x},#{y}"]
  updateNeighbour(dist, costs, visited, x-1, y, d, maxx, maxy)
  updateNeighbour(dist, costs, visited, x+1, y, d, maxx, maxy)
  updateNeighbour(dist, costs, visited, x, y-1, d, maxx, maxy)
  updateNeighbour(dist, costs, visited, x, y+1, d, maxx, maxy)
  visited << [x,y]
end
