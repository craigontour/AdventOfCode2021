require 'ruby2d'

start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getData(f)
  data = File.read("#{f}.txt").split("\n\n")
  alg = data[0]

  input = {}
  data[1].split("\n").each_with_index do |row, r|
    row.chars.each_with_index do |ch, c|
      if row[c] == '#'
        input[ [c, r] ] = '1'
      else
        input[ [c, r] ] = '0'
      end
    end
  end

  return alg, input
end

def printGrid(input)
  min = input.keys.min_by { |x, y| [x, y] }
  max = input.keys.max_by { |x, y| [x, y] }

  for y in min[1]...max[1]
    s = ''
    for x in min[0]..max[0]
      if input[[x,y]] == '1'
        s += '#'
      else
        s += ' '
      end
    end
  puts s
  end
end

def getNine(input, x, y)
  str = ''
  (y-1..y+1).each do |yy|
    (x-1..x+1).each do |xx|
      if input[[xx,yy]]
        str += input[[xx,yy]]
      else
        str += '0'
      end
    end
  end
  return str.to_i(2)
end

def main(alg, input, t)
  newinput = {}

  t.times do |i|
    min = input.keys.min_by { |x, y| [x, y] }
    max = input.keys.max_by { |x, y| [x, y] }

    ((min[1]-1)..(max[1])+1).each do |y|
      ((min[0]-1)..(max[0])+1).each do |x|
        if alg[getNine(input, x, y)] == '#'
          newinput[[x-1, y-1]] = '1'
        else
          newinput[[x-1, y-1]] = '0'
        end
      end
    end
    input = newinput
  end
  
  return input
end

alg, input = getData(ARGV[0])

# pp main(alg, input, 2).values.count('1')
input = main(alg, input, 50)
pp input.values.count('1')

#### Ruby2D

min = input.keys.min_by { |x, y| [x, y] }
max = input.keys.max_by { |x, y| [x, y] }
puts "min: #{min[0]},#{min[1]}"
puts max

set(
  {
    :title => "AofC 2021 Day 20",
    :background => 'black',
    :width => 800,
    :height => 800,
  }
)

boxw = 800 / (min[0].abs + max[0].abs)
boxh = 800 / (min[1].abs + max[1].abs)
puts "boxw: #{boxw}\nbowh: #{boxh}"

for y in min[1]...(min[1] + 1) #max[1]
  for x in min[0]..max[0]
    if input[[x,y]] == '1'
      colour = 'white'
    else
      colour = 'gray'
    end
    # puts "sq: x: #{(x+(min[0].abs))*boxw}, y: #{(y+(min[1].abs))*boxh}"
    Square.new(
      x: (x+(min[0].abs))*boxw,
      y: (y+(min[1].abs))*boxh,
      width: boxw, height: boxh,
      color: colour
    )
    # pause
  end

end

show