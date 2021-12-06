
@testing = ARGV[0] == 't'
@debug = ARGV[1] == 'd'
filename =  @testing ? 'test.txt' : 'input.txt'

puts "Testing on  : #{@testing}"
puts "Debugging on: #{@debug}"

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

coords = if @testing
           Array.new(10) { Array.new(10, 0) }
         else
           Array.new(999) { Array.new(999, 0) }
         end
dangerous = []

def print_coords(coords)
  if ARGV[0] != 't'
    puts "CAN ONLY PRINT TEST COORDS"
    exit
  end

  (0..9).each do |y|
    row = "#{y}: "
    (0..9).each do |x|
      if coords[y][x] == 0
        row += ". "
      else
        row += "#{coords[y][x]} "
      end
    end
    puts row
  end
end

def is_horiz(pt1, pt2)
  # puts "is_horiz: #{pt1}, #{pt2} -> #{pt1[1] == pt2[1]}" if @debug
  return pt1[1] == pt2[1]
end

def add_horiz(pt1, pt2, coords, dangerous)
  if pt1[0] > pt2[0]
    # puts "switch direction" if @debug
    temp = pt2
    pt2 = pt1
    pt1 = temp
  end
  puts "add horiz line: #{pt1} -> #{pt2} = #{pt2[0]-pt1[0] + 1} points" if @debug
  y = pt1[1]

  (pt1[0]..pt2[0]).each do |x|
    # puts "create coord: #{x}, #{y}, ? #{coords.include?([x, y])}" if @debug
    coords[y][x] += 1
    # puts "coords[#{x}, #{y}] = #{coords[y][x]}" if @debug
    dangerous << [x, y] if coords[y][x] > 1 && !dangerous.include?([x, y])
    # pause
  end
end

def is_vert(pt1, pt2)
  # puts "is_vert : #{pt1}, #{pt2} -> #{pt1[0] == pt2[0]}" if @debug
  return pt1[0] == pt2[0]
end

def add_vert(pt1, pt2, coords, dangerous)
  if pt1[1] > pt2[1]
    # puts "switch direction" if @debug
    temp = pt2
    pt2 = pt1
    pt1 = temp
  end
  puts "add vert line: #{pt1} -> #{pt2} = #{pt2[1]-pt1[1] + 1} points\n" if @debug
  x = pt1[0]

  (pt1[1]..pt2[1]).each do |y|
    # puts "create coord: #{x}, #{y}, ? #{coords.include?([x, y])}" if @debug
    coords[y][x] += 1
    # puts "coords[#{x}, #{y}] = #{coords[y][x]}" if @debug
    dangerous << [x, y] if coords[y][x] > 1 && !dangerous.include?([x, y])
    # pause
  end
end

def is_diag(pt1, pt2)
  puts "is diagonal: #{(pt1[0]-pt2[0]).abs == (pt1[1]-pt2[1]).abs}" if @debug
  return (pt1[0]-pt2[0]).abs == (pt1[1]-pt2[1]).abs
end

def add_diag(pt1, pt2, coords, dangerous)
  puts "add diagonal: #{pt1} -> #{pt2}" if @debug
  
  if pt1[0] > pt2[0]
    xinc = -1
  else
    xinc = 1
  end
  
  if pt1[1] > pt2[1]
    yinc = -1
  else
    yinc = 1
  end

  r = 0..((pt1[0]-pt2[0]).abs)
  (r.first..r.last).each do |i|
    puts "i: #{i}" if @debug
    x = pt1[0] + (i * xinc)
    y = pt1[1] + (i * yinc)

    puts "create coord: #{x}, #{y}, ? #{coords.include?([x, y])}" if @debug
    coords[y][x] += 1
    puts "coords[#{x}, #{y}] = #{coords[y][x]}" if @debug
    dangerous << [x, y] if coords[y][x] > 1 && !dangerous.include?([x, y])
    # pause
  end
end

data = File.readlines(filename).map(&:strip).each do |line|
  pt1 = line.split(' -> ')[0].split(',').map(&:to_i)  
  pt2 = line.split(' -> ')[1].split(',').map(&:to_i)
  # puts "line: #{pt1} -> #{pt2}" if @debug

  if is_horiz(pt1, pt2)
    add_horiz(pt1, pt2, coords, dangerous)
  elsif is_vert(pt1, pt2)
    add_vert(pt1, pt2, coords, dangerous)
  elsif is_diag(pt1, pt2)
    add_diag(pt1, pt2, coords, dangerous)
  else
    puts "skip line : #{pt1} -> #{pt2}" if @debug
  end
  pause if @debug
end

# print_coords(coords)

pp dangerous.length
# Part2 = 
