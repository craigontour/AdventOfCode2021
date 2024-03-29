start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getData(f)
  data = File.readlines("#{f}.txt").map(&:strip)
  maxx = data[0].length
  maxy = data.length

  dist = {}
  weight = {}

  for y in 0...(maxy * 5)
    for x in 0...(maxx * 5)
      
      dist["#{x},#{y}"] = Float::INFINITY
      
      w = data[y % maxy][x % maxx].to_i + (x / maxx) + (y / maxy)
      
      if w > 9
        weight["#{x},#{y}"] = (w % 10) + 1
        # puts "#{x},#{y} = #{x % maxx}, #{y % maxy} : #{w % 10 + 1}"
      else
        weight["#{x},#{y}"] = w
        # puts "#{x},#{y} = #{x % maxx}, #{y % maxy} : #{w}"
      end
    end
  end

  return dist, weight, (maxx * 5) - 1, (maxy * 5) - 1
end

dist, weight, maxx, maxy = getData(ARGV[0])
# pp weight
# pause

def addToQueue(priority, x, y)
  newNode = {
    :priority => priority,
    :x => x,
    :y => y,
    :nextNode => nil
  }

  # If linked list is empty return new node item
  if @frontNode.nil?
    @frontNode = newNode
    return
  end

  i = @frontNode
  last = nil

  # frontNode references the lowest priority node in linked list, i.e. the one on the front
  while !i.nil? do
    if i[:priority] >= newNode[:priority]
      newNode[:nextNode] = i
      if !last.nil?
        last[:nextNode] = newNode
      end
      if @frontNode == i
        @frontNode = newNode
      end
      return
    end
    
    last = i
    i = i[:nextNode]
  end

  last[:nextNode] = newNode
end

def popQueue
  first = @frontNode
  @frontNode = @frontNode[:nextNode]
  return first
end

def updateNeighbour(dist, costs, x, y, d, maxx, maxy)
  if x >= 0 && x <= maxx && y >= 0 && y <= maxy
    # puts "updateNeighbour: x:#{x}, y: #{y}"
    k = "#{x},#{y}"
    v = dist[k]
    sum = d + costs[k]
    if sum < v
      dist[k] = sum
      addToQueue(sum, x, y)
    end
  end
end

# M A I N  L O O P

dist["0,0"] = 0
frontNode = addToQueue(0, 0, 0)

while true do
  # Process the node with lowest priority (pop)
  current = popQueue
  x = current[:x]
  y = current[:y]

  if x == maxy && y == maxy
    puts "Part2: #{dist["#{maxx},#{maxy}"]} in #{Time.now - start} secs"
    exit
  end

  d = dist["#{x},#{y}"]

  updateNeighbour(dist, weight, x-1, y, d, maxx, maxy)
  updateNeighbour(dist, weight, x+1, y, d, maxx, maxy)
  updateNeighbour(dist, weight, x, y-1, d, maxx, maxy)
  updateNeighbour(dist, weight, x, y+1, d, maxx, maxy)
end
