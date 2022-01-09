require 'yaml'

start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

class Node
  def initialize(parent, val, left, right)
    @parent = parent
    @val = val
    @left = left
    @right = right
  end
end

def addNodes(parent, arr, left, right)
  if arr[0].is_a?(Array)
    n = Node.new(arr, 0, nil, nil)
  else
    n = Node.new(arr, arr[0].to_i, nil, nil)
  end
  parent.left = n

  if arr[1].is_a?(Array)
    n = Node.new(arr, 0, nil, nil)
  else
    n = Node.new(arr, arr[1].to_i, nil, nil)
  end
  parent.right = n

  arr.each do |subarr|
    addNode(subarr)
  end
end

lines = File.readlines("#{ARGV[0]}.txt").map(&:chomp)

lines.each do |line|
  line.gsub!(/(\,)(\S)/, "\\1 \\2")
  arr = YAML::load(line).to_a

  n = Node.new(nil, 0, arr[0], arr[1])

  # mustExplode(arr) || mustSplit(arr)
  while arr.is_a?(Array) do
    arr = addNodes(n, arr, arr[0], arr[1])
    puts "arr: #{arr}"
    pause
  end
end
