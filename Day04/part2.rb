filename =  ARGV[0] == 't' ? 'test.txt' : 'input.txt'
input = File.readlines(filename).map(&:strip)

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def print_boxes(boxes)
  boxes.each do | box|
    box.each do |line|
     pp line.map(&:to_s)
    end
    puts
  end
end

# line 0 is numbers
balls = []
balls = input[0].split(',').map(&:to_i)

# line 3-7, 9-13, 15-19, etc,.
x = 2
boxes = []
while x < input.length do
  box = []
  for y in (x...(x+5)) do
    # puts "line(#{y}): #{input[y]}"
    box << input[y].split(' ').map(&:to_i)
  end
  
  boxes << box
  x += 6
end

def sum_column(arr, col)
  sum = 0
  for y in 0...(arr.length) do
    # puts "arr[#{y}][#{col}]: #{arr[y][col]}"
    sum += arr[y][col]
  end
  return sum
end

def ball_found(box, ball)
  puts "find ball: #{ball}"
  for y in 0..4
    if box[y].include?(ball)
      i = box[y].index(ball)
      box[y][i] = -1
      if box[y].sum == -5 || sum_column(box, i) == -5
        # puts "Found ball: #{ball} at line #{box[y]}, sum: #{box[y].sum}"
        return box, true
      else
        return box, false
      end
    end
  end
end

winning_boxes = []
for b in (0...(boxes.length))
  winning_boxes << b
end

winners = []

balls.each do |ball|
  boxes.each_with_index do |box, i|
    puts "box: #{i}"
    box, house = ball_found(box, ball)
    if house
      total = 0
      boxes[i].flatten.each do |n|
        total += n if n > 0
      end
      winners << [total, ball]
      winning_boxes.delete(i)
      if winning_boxes.length == 0
        puts winners
        puts winning_boxes
        puts "Part2 #{ARGV[0] == 't' ? '(test)' : '(actual)'}: #{winners[-1][0] * winners[-1][1]}"
        exit
      end
    end
  end
  print_boxes(boxes)
  # pause
end
