start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(testfile)
  File.readlines("#{testfile}.txt").map(&:strip)
end

def twoLowers(path, np)
  lowers = []
  path.each do |node|
    if node != 'start' && node != 'end' && node[0] >= 'a' && node[0] <= 'z'
      lowers << node
    end
  end
  if lowers.empty?
    return false
  else
    return lowers.group_by(&:itself).transform_values(&:count).values.include?(2)
  end
end

def get_paths(graph, start, path, paths)
  path += [start]
  
  if start == 'end'
    paths.push(path)
    return
  end

  graph[start].each do |np|
    # puts "np: #{np}, path: #{path}"
    if !np.scan(/[a-z]/).empty?
      next if twoLowers(path, np) && path.include?(np)
    end
    # pause
    get_paths(graph, np, path, paths)
  end
end

def part2(graph)
  paths = []
  get_paths(graph, 'start', [], paths)
  # pp paths
  return paths
end

graph = Hash.new { |h, k| h[k] = [] }
getInput(ARGV[0]).each do |line|
  l, r = line.chomp.split('-')
  graph[l] << r unless r == 'start' || l == 'end'
  graph[r] << l unless l == 'start' || r == 'end'
end

# pp graph, ''

pp "Part2: #{part2(graph).size} in #{Time.now - start} secs"
