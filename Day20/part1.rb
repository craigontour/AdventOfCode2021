start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def printGrid(grid)
  for j in 0...(grid.length)
    s = ''
    for i in 0...(grid[0].length)
      s += grid[j][i]
    end
  puts s
  end
end

def getData(f)
  data = File.read("#{f}.txt").split("\n\n")
  alg = data[0]

  input = []
  data[1].split("\n").each_with_index do |row, i|
    input << row.gsub('#','1').gsub('.','0')
  end

  printGrid(input)
  return alg, input
end

alg, input = getData(ARGV[0])

puts "rows = #{input.length}"
puts "cols = #{input[0].length}"

str = ''
xoffset = yoffset = 0

(0..(input.length-3)) do |r|
  (0..(input[0].length-3)) do |r|
    newinput = []

    (r-2).downto(r) do |y|
      (c-2...(row.length+2)) do |x|
        puts "do col #{x}, row: #{y}"
        if x < 0 || y < 0
          str += '0'
        else
          str += input[y][x]
        end
        puts "do col #{x}, row: #{y}, str: #{str}"
        pause

        bin = str.to_i(2)
        if bin > 0
          puts "#{y},#{x}..#{y+2},#{x+2}: #{str}"
          puts "str: #{str}\nbin: #{bin}\ncol: #{alg[bin]}"
          if alg[bin] == '#'
            input[y][x] = '1'
          else
            input[y][x] = '0'
          end
        end
      end
    end
  end
  pause
end

# printGrid(input)
# puts "Part 1: #{input.flatten.count('1')}"