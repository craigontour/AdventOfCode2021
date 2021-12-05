
filename =  ARGV[0] == 't' ? 'test.txt' : 'input.txt'

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

# Globals
points = []
dangerous = []

# Check points are increasing direction
def sort_direction(pt1, pt2)
  # puts "sort_direction, before: #{pt1}, #{pt2}"
  if pt1[0] > pt2[0] || pt1[1] > pt2[1]
    temp = pt1
    pt1 = pt2
    pt2 = temp
  end
  # puts "sort_direction, after: #{pt1}, #{pt2}"
  return pt1, pt2
end

def not_diagonal(pt1, pt2)
  # puts "not_diagonal: #{pt1}, #{pt2} : #{pt1[0] == pt2[0]} || #{pt1[1] == pt2[1]}"
  return pt1[0] == pt2[0] || pt1[1] == pt2[1]
end

def create_points(pt1, pt2, points, dangerous)
  # puts "create points: #{pt1} -> #{pt2}"

  (pt1[0]..pt2[0]).each do |x|
    (pt1[1]..pt2[1]).each do |y|
      # puts "create point: #{x}, #{y}, ? #{points.include?([x, y])}"
      if points.include?([x, y]) && !dangerous.include?([x, y])
        dangerous << [x, y]
      end
      points << [x, y]
    end
  end
end

data = File.readlines(filename).map(&:strip).each do |line|
  puts "line: #{line}"
  sx, sy = line.split(' -> ')[0].split(',').map(&:to_i)  
  ex, ey = line.split(' -> ')[1].split(',').map(&:to_i)
  # puts "start: #{sx}, #{sy}"
  # puts "end  : #{ex}, #{ey}"
  pt1, pt2 = sort_direction([sx, sy], [ex, ey])

  if not_diagonal(pt1, pt2)
    create_points(pt1, pt2, points, dangerous)
  else
    # puts "diagnonal line : #{pt1} -> #{pt2}"
  end
  # pause
end

# pp points.sort
pp dangerous.length
