start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(f)
  input, folds = File.read("#{f}.txt").split("\n\n")
  input = input.split("\n")
  return input, folds
end

def getMax(input)
  maxx = maxy = 0
  input.each do |row|
    x, y = row.chomp.split(',').map(&:to_i)
    # puts "row:#{row}, x:#{x}, y:#{y}, maxx:#{maxx}, maxy:#{maxy}"
    maxx = x if x > maxx
    maxy = y if y > maxy
  end
  return maxx, maxy
end

def getDots(input)
  x, y = getMax(input)
  dots = Array.new(y+1) { Array.new(x+1, '.') }
  input.each do |row|
    x, y = row.chomp.split(',').map(&:to_i)
    # puts "x:#{x}, y:#{y}, dots:#{dots[y][x]}"
    dots[y][x] = '#'
  end
  return dots
end

def fold_horizontal(dots, n)
  folded = dots[0..n]
  
  # Copy dots up to row r
  (dots.length-1).downto(n+1) do |y|
    puts "row: #{y}"
    puts "from 0 to #{dots[0].length-1}"
    # 0..(dots[0].length-1) do |x|
    # #   puts "x:#{x}"
    # # #   if dots[y][x] == '#'
    # # #     folded[(dots.length-1)-y][x] = '#'
    # # #   end
    # # #   pause
    # end
  end
end

# def fold_vetical(dots, n)
#   puts "Fold on x"
# end

def do_fold(dots, folds, stop)
  folds.split("\n").each_with_index do |fold , i|
    axis, num = fold.chomp.split(' ')[-1].split('=')
    puts "fold along #{axis} number #{num}"

    if axis == 'y'
      fold_horizontal(dots, num.to_i)
    else
      fold_vetical(dots, num.to_i)
    end

    return dots if i+1 == stop
  end
end

input, folds = getInput(ARGV[0])
dots = getDots(input)
# pp dots

pp do_fold(dots, folds, 1).flatten.count('#')

# pp "Part1: #{part1(getInput(ARGV[0])), folds} in #{Time.now - start} secs"
