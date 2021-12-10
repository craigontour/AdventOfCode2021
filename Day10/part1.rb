start = Time.now()

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def getInput(testing)
  if testing
    File.readlines("test.txt").map(&:strip)
  else
    File.readlines("input.txt").map(&:strip)
  end
end

input = getInput(ARGV[0] == 't')

CHUNKS = [ '\(\)', '\[\]', '\{\}', '\<\>' ]

def removeChunks(line)
  # puts "#{line} include:#{line.include?("()") || line.include?("[]") || line.include?("{}") || line.include?("<>")}"

  while line.include?("()") || line.include?("[]") || line.include?("{}") || line.include?("<>")
    # puts "() [] {} <> : #{line}"
    line = line.gsub(/\(\)/, '').gsub(/\[\]/, '').gsub(/\{\}/, '').gsub(/\<\>/, '')
    # puts "after : #{line}",'------------------'
    # pause
  end
  
  return line
end

input.each_with_index do |line, i|
  line = removeChunks(line)
  puts "#{i}: #{line}"
end

# part1 = 0


# puts "Part 1: #{part1} in #{Time.now()-start} sec."
