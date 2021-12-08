f = ARGV[0] == 't' ? 'test' : 'input'

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

@master = {
  'abcefg'=>'0', 'cf'=>'1', 'acdeg'=>'2', 'acdfg'=>'3', 'bcdf'=>'4', 'abdfg'=>'5', 'abdefg'=>'6', 'acf'=>'7', 'abcdefg'=>'8', 'abcdfg'=>'9'
}

def findDigit(segment, config)
  puts "segment: #{segment}, config: #{config}"

  str = ''
  segment.chars.sort.each do |ch|
    el = config.chars.find_index(ch)
    if 'abcdefg'[el].nil?
      return nil
    else
      str += 'abcdefg'[el]
    end
    # puts "ch: #{ch}, el: #{el}, str: #{str}"
  end
  
  puts "segment: #{segment}, digit: #{@master[str.chars.sort.join('')]}"
  
  return @master[str.chars.sort.join('')]
end

input = File.readlines("#{f}.txt").map(&:strip)
# input = ['acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf']

'abcdefg'.chars.permutation do |config|
# config = 'deafgbc'
  outputs = []
  nextPerm = false

  input.each do |line|
    l, r = line.chomp.split(' | ')
    # puts "l: #{l} r: #{r}"

    digits = 0
    output = ''

    l.split(' ').each do |segment|
      digit = findDigit(segment, config)
      if digit.nil?
        nextPerm = true
      else
        digits += digit.to_i
      end
      # pause
    end

    if digits == 45
      r.split(' ').each do |segment|
        output += findDigit(segment, config)
      end
    else
      puts "next permuation"
    end
    
    puts "r: #{r} = #{output}",  ' '
  end
end
