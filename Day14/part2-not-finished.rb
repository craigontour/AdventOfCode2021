start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

PAIRS = {}

def getInput(f)
  template, rest = File.read("#{f}.txt").split("\n\n")
  
  rest = rest.split("\n").each do |line|
    pair = line.split(' -> ')
    PAIRS[pair[0]] = pair[1]
  end

  return template
end

# for each pair create 2 pairs
# 'NNCB'.chars.each_cons(2) do |pair|
# 