start = Time.now()

f = ARGV[0] == 't' ? 'test' : 'input'

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

@master = {
  'abcefg'=>'0', 'cf'=>'1', 'acdeg'=>'2', 'acdfg'=>'3', 'bcdf'=>'4', 'abdfg'=>'5', 'abdefg'=>'6', 'acf'=>'7', 'abcdefg'=>'8', 'abcdfg'=>'9'
}

def findDigit(segment, config)
  str = ''
  segment.chars.sort.each do |ch|
    el = config.find_index(ch)
    str += 'abcdefg'[el]
  end
  # puts "segment: #{segment}, config: #{config.join('')}, str: #{str}, digit: #{@master[str.chars.sort.join('')]}"
  
  return @master[str.chars.sort.join('')]
end

input = File.readlines("#{f}.txt").map(&:strip)
# input = ['acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf']

total = 0

input.each do |line|
  l, r = line.chomp.split(' | ')
  
  'abcdefg'.chars.permutation do |config|
    # config = 'deafgbc'.chars
    nextPerm = false

    l.split(' ').each do |segment|
      if findDigit(segment, config).nil?
        nextPerm = true
        break
      end
    end
  
    next if nextPerm

    digits = []
    r.split(' ').each do |segment|
      digits << findDigit(segment, config).to_i
    end
    total += digits.join('').to_i

    # outputs += digits.join('').to_i if !digits.nil?
  end
end

puts "part 2: #{total} in #{Time.now() - start} sec"
