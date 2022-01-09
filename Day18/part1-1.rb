start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def updateLeft(i, line)
  # add n to the next number to the left
  i.downto(0).each do |j|
    if line[j] != '[' && line[j] != ']' && line[j] != ','
      line[j] = (line[j].to_i + line[i+1].to_i).to_s
      return line
    end
  end
  return line
end

def updateRight(i, line)
  # add n to the next number to the right
  puts "updateRight: #{line[i..-1]}"
  n = ''
  j = i + 1
  pp line[i..-1].match(/\d+,/).captures[0]
  while line[j] != '[' && line[j] != ']' && line[j] != ','
    puts "updateRight: line[#{j}]: #{line[j]}"
    n += line[j]
    j += 1
  end
  pause
  # if n != ''
  #   .to_i + line[i].to_i).to_s
  #   return line[j..(j+n.length)], n)
  # else
  #   return line
  # end
end

def explode(i, line)
  updateLeft(i - 1, line)
  puts "- updated left  : #{line}"
  pause

  updateRight(i, line)
  puts "- updated right : #{line}"
  pause

  return line[0..i-1] + '0' + line[i+5..-1]
end

def splitNumber(i, line)
  # assumes only 2 digit number
  puts "Split line: #{line} at #{i}: #{line[i]+line[i+1]}"

  a, b = (line[i] + line[i+1]).to_i.divmod(2)
  return "[#{a},#{a+b}]"
end

lines = File.readlines("#{ARGV[0]}.txt").map(&:chomp)

lines.each_with_index do |line, i|
  puts "do line: #{line}"

  stack = []
  i = 0
  
  while i < line.length - 1 do
    stack << line[i]

    if stack.count('[') == 5 && line[i+3] == ']'
      stack.pop
      puts "explode: i:#{i}, #{line[i-1..i+4]}"
      line = explode(i, line)
      puts "becomes: #{line}"
      i += 4 # skip to next
    else
      puts "i:#{i}, line[#{i}]:#{line[i]}"
      i += 1
    end
  end
  puts '---------------------------------------------'

  pause

  # puts "done line: #{line}"
end
