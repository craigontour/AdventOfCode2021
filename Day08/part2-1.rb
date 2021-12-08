f = ARGV[0] == 't' ? 'test' : 'input'

def pause
  puts "pause..."
  exit if STDIN.gets.chomp == 'x'
end

def b2d(bin_str)
  return bin_str.to_i(2)
end

def s2b(signal)
  binStr = ''
  (97..103).each do |ch|
    letter = ch.chr
    if signal.include?(letter)
      # puts "signal includes   :#{ch}"
      binStr += '1'
    else
      # puts "signal not include: #{ch.chr}"
      binStr += '0'
    end
  end
  return binStr
end

digits = {
  'abcefg' => '0',
  'cf' => '1',
  'acdeg' => '2',
  'acdfg' => '3',
  'bcdf' => '4',
  'abdfg' => '5',
  'abdefg' => '6',
  'acf' => '7',
  'abcdefg' => '8',
  'abcdfg' => '9'
}

'abcdefg'.chars.permutation do |config|
  pp config

  digits.each do |segment, digit|
    puts "segment: #{segment} = #{digit}"
  end
  
  exit
end

exit

'abcdefg'.chars.permutation do |config|
  pp config

  'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab'.split(' ').each do |signal|
    puts "signal: #{signal.chars.sort}"
  end

end

exit

digits.each do |digit, values|
  puts "digit: #{digit}, segments: #{values[:segment]}, binary: #{values[:binary]}, decimal: #{values[:decimal]}"
end

outputs = []

File.readlines("#{f}.txt").each do |line|
  r = line.chomp.split(' | ')[1]
  
  output = ''

  r.split(' ').each do |digit|
    if digit.length == 2
      output += '1'
    elsif digit.length == 3
      output += '7'
    elsif digit.length == 4
      output += '4'
    elsif digit.length == 7
      output += '8'
    else
      output += "#{digits[digit.chars.sort.join('')]}"
    end
    puts "#{digit} => #{output}"
  end
  puts "r: #{r}, output: #{output}"
  pause
end
