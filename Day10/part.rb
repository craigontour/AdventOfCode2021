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

part1 = 0
part2 = []

input.each_with_index do |line, i|
  line = removeChunks(line)
  syntaxerror = 0
  
  if line.include?(')') || line.include?(']') || line.include?('}') || line.include?('>')   
    line.chars.each do |char|
      case char
      when ')'
        syntaxerror += 3
        break
      when ']'
        syntaxerror += 57
        break
      when '}'
        syntaxerror += 1197
        break
      when '>'
        syntaxerror += 25137
        break
      end
    end
    part1 += syntaxerror
  else
    # puts "incomplete: #{line} => #{line.reverse}"
    line.reverse.chars.each do |char|
      case char
      when '('
        # puts "#{char} = #{syntaxerror} * 5 + 1 = #{syntaxerror * 5 + 1}"
        syntaxerror = (syntaxerror * 5) + 1
      when '['
        # puts "#{char} = #{syntaxerror} * 5 + 2 = #{syntaxerror * 5 + 2}"
        syntaxerror = (syntaxerror * 5) + 2
      when '{'
        # puts "#{char} = #{syntaxerror} * 5 + 3 = #{syntaxerror * 5 + 3}"
        syntaxerror = (syntaxerror * 5) + 3
      when '<'
        # puts "#{char} = #{syntaxerror} * 5 + 4 = #{syntaxerror * 5 + 4}"
        syntaxerror = (syntaxerror * 5) + 4
      end
      # puts "syntaxerror: #{syntaxerror}"
      # pause
    end
    part2 << syntaxerror
  end
  # pause
end

puts "Part 1: #{part1} in #{Time.now()-start} sec."
puts "Part 2: #{part2.sort[part2.length/2]} in #{Time.now()-start} sec."
