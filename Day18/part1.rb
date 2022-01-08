start = Time.now()

def pause(m = "pause")
  puts "#{m}..."
  exit if STDIN.gets.chomp == 'x'
end

def updateLeft(i, line)
  # add n to the next number to the left
  i.downto(0).each do |j|
    if line[j] != '[' && line[j] != ']' && line[j] != ','
      puts "-- update left  : #{line[i+1].to_i} to #{line[j]} = #{line[j].to_i + line[i+1].to_i}"
      line[j] = (line[j].to_i + line[i+1].to_i).to_s
    end
  end
  return line
end

def updateRight(i, line)
  # add n to the next number to the right
  (i+4..(line.length-1)).each do |j|
    if line[j] != '[' && line[j] != ']' && line[j] != ','
      puts "-- update right: #{line[i+3].to_i} to #{line[j]} = #{line[j].to_i + line[i+3].to_i}"
      line[j] = (line[j].to_i + line[i+3].to_i).to_s
    end
  end
  puts "- becomes         : #{line[0..i-1] + '0' + line[i+5..-1]}"

  return line 
end

def explode(i, line)
  updateLeft(i, line)
  puts "- updated left    : #{line}"
  updateRight(i, line)
  puts "- updated right   : #{line}"

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

lines.each do |line|
  puts "do line: #{line}"

  i = 0
  while i < line.length do
    if line[0..i].count('[') - line[0..i].count(']') > 4
      puts "explode at i :#{i}, #{line[i..i+4]} in #{line}"
      line = explode(i, line)
      puts "after explode   : #{line}"
    else
      if (line[i] + line[i+1]).to_i > 9
        puts "split at i :#{i}, for #{line[i] + line[i+1]}"
        
        splitNum = splitNumber(i-1, line)
        puts "after split : num: #{splitNum} => #{line.sub(line[i] + line[i+1], splitNum)}"
      end
    end
    i += 1
  end
  pause

  puts "done line: #{line}"
end
