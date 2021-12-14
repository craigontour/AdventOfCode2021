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

def update(template)
  poly = ''
  (0...(template.length-1)).each do |i|
    pair = "#{template[i]}#{template[i+1]}"
    replaced = "#{template[i]}#{PAIRS[pair]}#{template[i+1]}"
    if i == 0
      poly += replaced
    else
      poly += replaced[1..2]
    end
    # puts "#{pair}->#{replaced}"
    # pause
  end
  return poly
end

def part1(template, n)
  n.times do
    newtemplate = update(template)
    # puts newtemplate.length
    template = newtemplate
    # pause
  end
  counts = template.chars.sort.map { |c| [template.count(c), c] }.sort.uniq!
  return (counts[-1][0] - counts[0][0])
end

template, pairs = getInput(ARGV[0])

pp "Part1: #{part1(template, 10)} in #{Time.now - start} secs"
pp "Part2: #{part1(template, 40)} in #{Time.now - start} secs"
