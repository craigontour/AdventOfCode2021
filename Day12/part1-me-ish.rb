start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(testfile)
  File.readlines("#{testfile}.txt").map(&:strip)
end

def get_paths(graph, start, path, paths, loop)
  path += [start]

  if start == 'end'
    paths.push(path)
    return
  end

  graph[start].each do |np|
    next if path.include?(np) && !np.scan(/[a-z]/).empty?

    get_paths(graph, np, path, paths, loop)
  end
end

def part1(graph)
  loop = 0
  paths = []
  get_paths(graph, 'start', [], paths, loop)
  return paths
end

graph = Hash.new { |h, k| h[k] = [] }

getInput(ARGV[0]).each do |line|
  l, r = line.chomp.split('-')
  graph[l] << r unless r == 'start' || l == 'end'
  graph[r] << l unless l == 'start' || r == 'end'
end

# pp graph, ''

pp "Part1: #{part1(graph).size} in #{Time.now - start} secs"
