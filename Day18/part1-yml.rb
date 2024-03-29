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

def createNodes(arr, parent)
  while arr.is_a?(Array) do
    p.left = Node(arr, 0, arr[0], arr[1])

    #   puts "arr: #{arr}"
    #   pause
  end
end

lines = File.readlines("#{ARGV[0]}.txt").map(&:chomp)

lines.each do |line|
  line.gsub!(/(\,)(\S)/, "\\1 \\2")
  arr = YAML::load(line).to_a

  n = Node.new(nil, 0, arr[0], arr[1])
  pp n

  # mustExplode(arr) || mustSplit(arr)

end
