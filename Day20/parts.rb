start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def getData(f)
  data = File.read("#{f}.txt").split("\n\n")
  alg = []
  data[0].chars.each_with_index do |ch, i|
    alg[i] = ch == '#' ? 1 : 0
  end

  input = {}
  data[1].split("\n").each_with_index do |row, r|
    row.chars.each_with_index do |ch, c|
      input[[c, r]] = 1 if row[c] == '#'
    end
  end

  return alg, input
end

def printGrid(input)
  min = input.keys.min_by { |x, y| [x, y] }
  max = input.keys.max_by { |x, y| [x, y] }
  puts "min: #{min}, max: #{max}"
  
  for y in min[1]...max[1]
    s = ''
    for x in min[0]..max[0]
      if input[[x, y]] == 1
        s += '#'
      else
        s += ' '
      end
    end
  puts s
  end
  pause
end

def getNine(input, x, y)
  str = ''
  (y-1..y+1).each do |yy|
    (x-1..x+1).each do |xx|
      if input[[xx,yy]] == 1
        str += '1'
      else
        str += '0'
      end
    end
  end
  return str.to_i(2)
end

def main(alg, input, t)
  t.times do |i|
    newinput = {}

    min = input.keys.min_by { |x, y| [x, y] }
    max = input.keys.max_by { |x, y| [x, y] }
    # puts "min: #{min[0]}..#{min[1]}"
    # puts "max: #{max[0]}..#{max[1]}"

    ((min[1]-1)..(max[1]+1)).each do |y|
      ((min[0]-1)..(max[0]+1)).each do |x|
        newinput[[x, y]] = alg[getNine(input, x, y)]
      end
    end

    input = newinput.clone

    # printGrid(input)
  end
  
  return input
end

alg, input = getData(ARGV[0])

part1 = main(alg, input, 2)
puts "Part 1: #{part1.values.count(1)}"

part2 = main(alg, input, 50)
puts "Part 2: #{part2.values.count(1)} (which is not correct!)"
printGrid(part2)