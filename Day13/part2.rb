require 'set'

start = Time.now()
@w = @h = 0

def getInput(f)
  input, folds = File.read("#{f}.txt").split("\n\n")
  input = input.split("\n")

  dots = Set.new

  input.each do |row|
    x, y = row.chomp.split(',').map(&:to_i)
    @w = x if x > @w
    @h = y if y > @h
    dots << [x, y]
  end

  # pp dots, ''

  return dots, folds
end

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def inBounds(coord, bounds)
  x = coord[0]
  y = coord[1]
  tl = bounds[0]
  br = bounds[1]
  return x >= tl[0] && y >= tl[1] && x <= br[0] && y <= br[1]
end

def fold_horizontal(dots, row)
  puts "horizontal fold at #{row}"

  bounds = [ [0, 0], [@w, row-1]]
  newMap = Set.new

  dots.each do |coord|
    if inBounds(coord, bounds)
      newMap << coord
    else
      newCoord = [coord[0], row - (coord[1] - row)]
      newMap << newCoord
    end
  end

  return newMap
end

def fold_vertical(dots, col)
  puts "vertical fold at #{col}"

  bounds = [ [0, 0], [col - 1, @h]]
  newMap = Set.new

  dots.each do |coord|
    if inBounds(coord, bounds)
      newMap << coord
    else
      newCoord = [col - (coord[0] - col), coord[1]]
      newMap << newCoord
    end
  end

  return newMap
end

def printDots(dots)
  arr = dots.to_a #.sort
  maxx = arr.max_by { |x, y| x }[0]
  maxy = arr.max_by { |x, y| y }[0]
  grid = Array.new(maxy) { Array.new(maxx, ' ') }

  dots.each do |x, y|
    grid[y][x] = '#'
  end

  for j in 0...maxy
    s = ''
    for i in 0...maxx
      s += grid[j][i]
    end
  puts s
  end
end

dots, folds = getInput(ARGV[0])

folds.split("\n").each_with_index do |fold , i|
  axis, num = fold.chomp.split(' ')[-1].split('=')
  puts "axis:#{axis}, num:#{num}"

  if axis == 'y'
    dots = fold_horizontal(dots, num.to_i)
  else
    dots = fold_vertical(dots, num.to_i)
  end

  pause
end

pp dots
pause
printDots(dots)
