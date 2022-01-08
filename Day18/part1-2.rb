start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def Node
  def initialize(parent)
    @parent = parent
  end

  attr_accessor :left, :right, :val, :parent
end

def Calc(str)
end

lines = File.readlines("#{ARGV[0]}.txt").map(&:chomp)

lines.each do |line|

  sf = Node.new(arr, nil, nil, nil)
  while arr.length > 1 do
    f = Node.new(arr[0], sf, '[', arr[1])
  end
  pause
end
