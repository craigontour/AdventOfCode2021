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

def ball_found(box, ball, i)
  for y in 0..4
    if box[y].include?(ball)
      box[y][box[y].index(ball)] = -1
      if box[y].sum == -5
        # puts "Found ball: #{ball} in box #{i} at line #{box[y]}, sum: #{box[y].sum}"
        return box, true
      else
        return box, false
      end
    end
  end
end

winners = []

balls.each do |ball|
  # puts "ball: #{ball}"
  boxes.each_with_index do |box, i|
    box, house = ball_found(box, ball, i)
    if house
      total = 0
      boxes[i].flatten.each do |n|
        total += n if n > 0
      end
      winners << [total, ball]
    end
  end
  # print_boxes(boxes)
end

puts "Part1 #{ARGV[0] == 't' ? '(test)' : ''}: #{winners[0][0] * winners[0][1]}"
