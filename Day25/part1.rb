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
  puts "line: #{line}"
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

printGrid(maxx, maxy, east, south)

moves = 0
moving = true
while moving do
  puts ''

  neweast = []
  east.each do |x, y|
    if x + 1 > maxx
      newx = 0
    else
      newx = x + 1
    end
    # puts "Can #{x},#{y} move to #{newx},#{y} ?"

    if east.include?([newx, y]) || south.include?([newx, y])
      # puts "#{x},#{y} CANNOT move to #{newx},#{y}"
      neweast << [x, y]
    else
      # puts "#{x},#{y} MOVES to #{newx},#{y}"
      neweast << [newx, y]
    end
    # pause
  end
  east = neweast

  newsouth = []
  south.each do |x, y|
    if y + 1 > maxy
      newy = 0
    else
      newy = y + 1
    end
    # puts "Can #{x},#{y} move to #{x},#{newy} ?"

    if east.include?([x, newy]) || south.include?([x, newy])
      # puts "#{x},#{y} CANNOT move to #{x},#{newy}"
      newsouth << [x, y]
    else
      # puts "#{x},#{y} MOVES to #{x},#{newy}"
      newsouth << [x, newy]
    end
    # pause
  end
  south = newsouth

  printGrid(maxx, maxy, east, south)
  pause
end

# puts "Part 1: #{part1(input)} took #{Time.now() - start} secs."
