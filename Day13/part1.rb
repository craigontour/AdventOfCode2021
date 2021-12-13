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
  bounds = [ [0, 0], [@w, row-1]]
  # puts "horizontal fold at #{row}"
  # puts "bounds are #{bounds[0][0]},#{bounds[0][1]}-#{bounds[1][0]},#{bounds[1][1]}"

  newMap = Set.new

  dots.each do |coord|
    # puts "inBounds: #{coord} within: #{bounds[0]}-#{bounds[1]} = #{inBounds(coord, bounds)}"
    if inBounds(coord, bounds)
      newMap << coord
    else
      newCoord = [coord[0], row - (coord[1] - row)]
      # puts "coord #{coord} has new coord at #{newCoord}"
      newMap << newCoord
    end
    # pause
  end

  return newMap
end

def fold_vertical(dots, col)
  bounds = [ [0, 0], [col - 1, @h]]
  # puts "vertical fold at #{col}"
  # puts "bounds are #{bounds[0][0]},#{bounds[0][1]}-#{bounds[1][0]},#{bounds[1][1]}"

  newMap = Set.new

  dots.each do |coord|
    # puts "inBounds: #{coord} within: #{bounds[0]}-#{bounds[1]} = #{inBounds(coord, bounds)}"
    if inBounds(coord, bounds)
      newMap << coord
    else
      newCoord = [col - (coord[0] - col), coord[1]]
      # puts "coord #{coord} has new coord at #{newCoord}"
      newMap << newCoord
    end
    # pause
  end

  return newMap
end

dots, folds = getInput(ARGV[0])

folds.split("\n").each_with_index do |fold , i|
  axis, num = fold.chomp.split(' ')[-1].split('=')
  # puts "fold along #{axis} number #{num}"

  if axis == 'y'
    puts fold_horizontal(dots, num.to_i).length
  else
    puts fold_vertical(dots, num.to_i).length
  end

  exit if i == 0
end
