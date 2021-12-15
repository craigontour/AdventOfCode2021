require 'ruby2d'

if ARGV[0] == 't'
  input = File.readlines("test.txt").map(&:strip)
  puts "length[0]:#{input[0].length}, length:#{input.length}"
  w = h = 500 / input.length
else
  input = File.readlines("input.txt").map(&:strip)
  w = h = 10
end


set(
  {
    :title => "AofC 2021 Part 15",
    :background => 'blue',
    :width => 500,
    :height => 500,
  }
)

# COLOURS = { 0 => 'yellow', 1 => 'lime', 2 => 'green', 3 => 'blue', 4 => 'orange', 5 => 'maroon', 6 => 'brown', 7 => 'purple', 8 => 'red', 9 => 'fuchsia' }
COLOURS = { 1=>'#eeeeee',2=>'#cccccc',3=>'#aaaaaa',4=>'#999999', 5=>'#777777', 6=>'#555555', 7=>'#333333',8=>'#222222',9=>'#111111'}
# def getNeighbours(x, y, grid)
#   neighbours = []
#   DIRECTIONS.each do |_, dir|
#     # puts "x: #{y}, y: #{y} => dir: #{dir}: #{grid[y + dir[1]][x + dir[0]]}"
#     if (y + dir[1] >= 0) && (x + dir[0] >= 0) && (y + dir[1] < grid.length) && (x + dir[0] < grid[0].length)
#       # puts "neighbour: #{grid[y + dir[1]][x + dir[0]]}"
#       neighbours << (grid[y + dir[1]][x + dir[0]]).to_i
#     end
#   end
#   return neighbours
# end

part1 = []

for y in (0..(input.length-1)) do
  for x in (0..(input[0].length-1)) do
    # puts "x:#{x*5}, y:#{y*5}, #{input[y][x]}, colour:#{COLOURS[input[y][x].to_i]}"

    Square.new(
      x: x*w,
      y: y*h,
      width: w, height: h,
      color: COLOURS[input[y][x].to_i]
    )

    # sizes = getNeighbours(x, y, input)
    # sizes << input[y][x].to_i
    # sizes.sort!
    # if input[y][x].to_i < sizes[1]
    #   # puts "low: #{input[y][x]}: #{sizes} : #{sizes[0]} ? #{sizes[0]}, risk: #{sizes[0]+ 1}"
    #   part1 << sizes[0] + 1
    # end
    # # pause
  end
end


show

exit

puts "Part 1: #{part1.sum} in #{Time.now()-start} sec."
