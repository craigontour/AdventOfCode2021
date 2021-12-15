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
  end
  return poly
end

def part2(template, n)
  puts template
  n.times do |t|
    newtemplate = update(template)
    template = newtemplate
    puts "#{t+1}: #{template} | #{template.length} | #{template.chars.sort.chunk { |c| c }.map { |c, ch| [ch.size, c] }}"

    # counts = template.chars.sort.map { |c| [template.count(c), c] } #.sort.uniq!
    # total = counts.map { |k,v| k.sum }
    # counts.map { |k,v| "#{v}: #{k/total}"}
    # pp counts
  end
  counts = template.chars.sort.map { |c| [template.count(c), c] }.sort.uniq!
  return (counts[-1][0] - counts[0][0])
end

# def part2(template, n)
#   l = template.length
#   (1..n).each do |i|
#     l = l + (l-1)
#     puts "i:#{i} #{l}"
#   end
#   return l
# end

template, pairs = getInput(ARGV[0])

pp "Part2: #{part2(template, 10)} in #{Time.now - start} secs"
