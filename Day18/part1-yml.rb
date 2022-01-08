require 'yaml'

start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def Node(arr)
  def initialize(parent)
    @parent = parent
  end
end

lines = File.readlines("#{ARGV[0]}.txt").map(&:chomp)

lines.each do |line|
  line.gsub!(/(\,)(\S)/, "\\1 \\2")
  arr = YAML::load(line).to_a

  sf = Node.new(arr, nil, nil, nil)
  while arr.length > 1 do
    f = Node.new(arr[0], sf, '[', arr[1])
  end
  pause
end
