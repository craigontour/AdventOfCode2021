start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

east = []
maxx = 0
south = []
maxy = 0

File.readlines("#{ARGV[0]}.txt").each_with_index do |line, r|
  maxx = line.length-1
  line.chomp.chars.each_with_index do |ch, c|
    east << [c, r] if ch == '>'
    south << [c, r] if ch == 'v'
  end
  maxy = r
end

def printGrid(w, h, east, south)
  for y in 0..h
    s = ''
    for x in 0..w
      if east.include?([x, y])
        s += '>'
      elsif south.include?([x, y])
        s += 'v'
      else
        s += '.'
      end
    end
  puts s
  end
end
# printGrid(maxx, maxy, east, south)

steps = 0
while true do
  emoves = 0
  smoves = 0

  neweast = []
  east.each do |x, y|
    if x + 1 > maxx
      newx = 0
    else
      newx = x + 1
    end

    if east.include?([newx, y]) || south.include?([newx, y])
      neweast << [x, y]
    else
      neweast << [newx, y]
      emoves += 1
    end
  end
  emoves = (east - neweast).count
  east = neweast
  
  newsouth = []
  south.each do |x, y|
    if y + 1 > maxy
      newy = 0
    else
      newy = y + 1
    end

    if east.include?([x, newy]) || south.include?([x, newy])
      newsouth << [x, y]
    else
      newsouth << [x, newy]
      smoves += 1
    end
  end
  smoves = (south - newsouth).count
  south = newsouth

  steps += 1
  # printGrid(maxx, maxy, east, south)
  if emoves + smoves == 0
    puts "Part 1: #{steps}"
    return
  end
end

# puts "Part 1: #{part1(input)} took #{Time.now() - start} secs."
